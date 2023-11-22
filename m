Return-Path: <netdev+bounces-50126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBF37F4AA1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EA6281442
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01CC4CDF6;
	Wed, 22 Nov 2023 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+O+6It9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9D4CDF0
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 15:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5360C433C7;
	Wed, 22 Nov 2023 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700667293;
	bh=uUlJZrpgLO/ZLKjSdD9KYtjRaWtZ+6uPYlonXPr+/Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+O+6It9gc5fK6QuRS8Mcv6nNpjIlKAfPACMN0D+smFj872ap9f3T4BWfbZ06FLym
	 eweeUQ7PX2nHAu7HyZPwChwjYI00KYhr2i6jfL8z13wgGN6cB0zbEzo2C+iJfFyLN8
	 p0B4MA+twj3QxNA2mrJECa0u8L9tzRsWGuyl74IP2vbotA/LO8ADW4/88jv44tWEuQ
	 2BtgnaetquHNu2gCdUAbwDGyZXxTlEwelR3bDfnbTfosdR7IUPGqDPu33vin2hzHph
	 8IT/TRLEE18oZLopYuVxCm1DIFgIo4ePaIhe3tuujheRRCMdSyc4khGVUORGD8ds5X
	 DFlXRDCPMEQWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	justinstitt@google.com,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 4/9] netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test
Date: Wed, 22 Nov 2023 10:34:28 -0500
Message-ID: <20231122153440.852807-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153440.852807-1-sashal@kernel.org>
References: <20231122153440.852807-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.63
Content-Transfer-Encoding: 8bit

From: Jozsef Kadlecsik <kadlec@netfilter.org>

[ Upstream commit 28628fa952fefc7f2072ce6e8016968cc452b1ba ]

Linkui Xiao reported that there's a race condition when ipset swap and destroy is
called, which can lead to crash in add/del/test element operations. Swap then
destroy are usual operations to replace a set with another one in a production
system. The issue can in some cases be reproduced with the script:

ipset create hash_ip1 hash:net family inet hashsize 1024 maxelem 1048576
ipset add hash_ip1 172.20.0.0/16
ipset add hash_ip1 192.168.0.0/16
iptables -A INPUT -m set --match-set hash_ip1 src -j ACCEPT
while [ 1 ]
do
	# ... Ongoing traffic...
        ipset create hash_ip2 hash:net family inet hashsize 1024 maxelem 1048576
        ipset add hash_ip2 172.20.0.0/16
        ipset swap hash_ip1 hash_ip2
        ipset destroy hash_ip2
        sleep 0.05
done

In the race case the possible order of the operations are

	CPU0			CPU1
	ip_set_test
				ipset swap hash_ip1 hash_ip2
				ipset destroy hash_ip2
	hash_net_kadt

Swap replaces hash_ip1 with hash_ip2 and then destroy removes hash_ip2 which
is the original hash_ip1. ip_set_test was called on hash_ip1 and because destroy
removed it, hash_net_kadt crashes.

The fix is to force ip_set_swap() to wait for all readers to finish accessing the
old set pointers by calling synchronize_rcu().

The first version of the patch was written by Linkui Xiao <xiaolinkui@kylinos.cn>.

v2: synchronize_rcu() is moved into ip_set_swap() in order not to burden
    ip_set_destroy() unnecessarily when all sets are destroyed.
v3: Florian Westphal pointed out that all netfilter hooks run with rcu_read_lock() held
    and em_ipset.c wraps the entire ip_set_test() in rcu read lock/unlock pair.
    So there's no need to extend the rcu read locked area in ipset itself.

Closes: https://lore.kernel.org/all/69e7963b-e7f8-3ad0-210-7b86eebf7f78@netfilter.org/
Reported by: Linkui Xiao <xiaolinkui@kylinos.cn>
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 20eede37d5228..d47dfdcb899b0 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -61,6 +61,8 @@ MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_IPSET);
 	ip_set_dereference((inst)->ip_set_list)[id]
 #define ip_set_ref_netlink(inst,id)	\
 	rcu_dereference_raw((inst)->ip_set_list)[id]
+#define ip_set_dereference_nfnl(p)	\
+	rcu_dereference_check(p, lockdep_nfnl_is_held(NFNL_SUBSYS_IPSET))
 
 /* The set types are implemented in modules and registered set types
  * can be found in ip_set_type_list. Adding/deleting types is
@@ -708,15 +710,10 @@ __ip_set_put_netlink(struct ip_set *set)
 static struct ip_set *
 ip_set_rcu_get(struct net *net, ip_set_id_t index)
 {
-	struct ip_set *set;
 	struct ip_set_net *inst = ip_set_pernet(net);
 
-	rcu_read_lock();
-	/* ip_set_list itself needs to be protected */
-	set = rcu_dereference(inst->ip_set_list)[index];
-	rcu_read_unlock();
-
-	return set;
+	/* ip_set_list and the set pointer need to be protected */
+	return ip_set_dereference_nfnl(inst->ip_set_list)[index];
 }
 
 static inline void
@@ -1399,6 +1396,9 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
 	ip_set(inst, to_id) = from;
 	write_unlock_bh(&ip_set_ref_lock);
 
+	/* Make sure all readers of the old set pointers are completed. */
+	synchronize_rcu();
+
 	return 0;
 }
 
-- 
2.42.0


