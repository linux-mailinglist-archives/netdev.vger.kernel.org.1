Return-Path: <netdev+bounces-293160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cASxJX+6GWqVyggAu9opvQ
	(envelope-from <netdev+bounces-293160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:10:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEF360552E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C628632AC091
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4623ED5A1;
	Fri, 29 May 2026 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VDjiv1hg"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B08C3EA968
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068166; cv=none; b=als74hDLyYMyg9BFw1Xt6Oa9N6Rn2wj1Dt5THPOGVZP4EpW9EEHPso7f4bAofu1TAKJwA63h8RTi/9CD9DL8mCz9kSHhQi/nZ2+YXq/BrhATvgz7akIMV03KXSo3Gac2W9Sy1jJo/z1o90zbvnNYPeI4vaFFyv+LXEPBlFvfGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068166; c=relaxed/simple;
	bh=Ldhi3TS47EpmmZk63arnUtLu75lqarGTXvizDQseIYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNOUEb2oqxDZJv2u13fSzutpkGCqEHB1sYqBJPCXgdHJk4C8gRLfn80FQp60MWv/XX9aJp7dGP3jydNHVjymqUgZhijT5qZNq+jVKPKPPatEgRWQtypxVHIeikcOAHDcUvRU4XonQ6CtpLvO+46zq4v6bXgpmgH9cs36Y2fLRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VDjiv1hg; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780068163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zOnYofdmc4+1eIjLJiI33DnZebvI/fZOqTY841UQVGE=;
	b=VDjiv1hgkwmBGhon8EUVls3/ns5IVAUk+8taob0g/OiMK52t82v7EiPA8Pz4E5/aHXR0xx
	woQQjqsOyyHnc8xPbVb5fvkEMNf/3tleQ89ljFxcne9HAb2kJipDYjGorIINTjTrZLjgm7
	LYnlNmTIWWZ4K5Bs9rfc1WhT0MEgfeA=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+819eb928d120d2bdad0e@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] ipv6: anycast: insert aca into global hash under idev->lock
Date: Fri, 29 May 2026 23:22:18 +0800
Message-ID: <20260529152219.235475-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-293160-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,819eb928d120d2bdad0e];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,linux.dev:email,linux.dev:mid,linux.dev:dkim,appspotmail.com:email]
X-Rspamd-Queue-Id: EFEF360552E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot reported a splat [1]: a slab-use-after-free in
ipv6_chk_acast_addr(), which walks the global inet6_acaddr_lst[] hash
under RCU and dereferences a struct ifacaddr6 that has already been
freed while still linked in the hash, so a later reader walks into a
dangling node.

In __ipv6_dev_ac_inc() the aca is allocated with refcount 1, then
aca_get() bumps it to 2 to keep it alive across the unlocked region.
It is published to idev->ac_list under idev->lock, but
ipv6_add_acaddr_hash() runs after write_unlock_bh(). A concurrent
teardown (ipv6_ac_destroy_dev() from addrconf_ifdown(), under RTNL)
can slip into that window:

  CPU0 __ipv6_dev_ac_inc           CPU1 ipv6_ac_destroy_dev (RTNL)
  ------------------------------   ------------------------------------
  aca_alloc()              refcnt 1
  aca_get()               refcnt 2
  write_lock_bh(idev->lock)
    add aca to ac_list
  write_unlock_bh(idev->lock)
                                   write_lock_bh(idev->lock)
                                     pull aca off ac_list
                                   write_unlock_bh(idev->lock)
                                   ipv6_del_acaddr_hash(aca)
                                     hlist_del_init_rcu() is a no-op,
                                     aca is not in the hash yet
                                   aca_put()           refcnt 2->1
  ipv6_add_acaddr_hash(aca)
    aca now inserted into the hash
  aca_put()                refcnt 1->0
    call_rcu(aca_free_rcu) -> kfree(aca)

The hash removal becomes a no-op because the insertion has not
happened yet, so once CPU0 inserts and drops the last reference, the
aca is freed while still linked in inet6_acaddr_lst[], and readers
dereference freed memory after the slab slot is reused.

This window opened once RTNL stopped serializing the join path against
device teardown. Move ipv6_add_acaddr_hash() inside the idev->lock
section so the ac_list and hash insertions are atomic with respect to
teardown: a racing remover now either misses the aca entirely or finds
it in both lists.

acaddr_hash_lock is now nested under idev->lock, which is acquired in
softirq context, so switch all acaddr_hash_lock sites to spin_lock_bh()
to avoid the irq lock inversion reported in [2].

[1] https://syzkaller.appspot.com/bug?extid=a01df04303c131efbf3a
[2] https://lore.kernel.org/netdev/6a194ef7.ba3b1513.1890b4.0000.GAE@google.com/

Reported-by: syzbot+819eb928d120d2bdad0e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a191f87.ce022c6e.138e56.0003.GAE@google.com/T/
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Fixes: eb1ac9ff6c4a ("ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/anycast.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 67a42e01dfc3..be6dac8a8566 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -243,16 +243,16 @@ static void ipv6_add_acaddr_hash(struct net *net, struct ifacaddr6 *aca)
 {
 	unsigned int hash = inet6_acaddr_hash(net, &aca->aca_addr);
 
-	spin_lock(&acaddr_hash_lock);
+	spin_lock_bh(&acaddr_hash_lock);
 	hlist_add_head_rcu(&aca->aca_addr_lst, &inet6_acaddr_lst[hash]);
-	spin_unlock(&acaddr_hash_lock);
+	spin_unlock_bh(&acaddr_hash_lock);
 }
 
 static void ipv6_del_acaddr_hash(struct ifacaddr6 *aca)
 {
-	spin_lock(&acaddr_hash_lock);
+	spin_lock_bh(&acaddr_hash_lock);
 	hlist_del_init_rcu(&aca->aca_addr_lst);
-	spin_unlock(&acaddr_hash_lock);
+	spin_unlock_bh(&acaddr_hash_lock);
 }
 
 static void aca_get(struct ifacaddr6 *aca)
@@ -371,10 +371,10 @@ int __ipv6_dev_ac_inc(struct inet6_dev *idev, const struct in6_addr *addr)
 	aca->aca_next = idev->ac_list;
 	rcu_assign_pointer(idev->ac_list, aca);
 
-	write_unlock_bh(&idev->lock);
-
 	ipv6_add_acaddr_hash(net, aca);
 
+	write_unlock_bh(&idev->lock);
+
 	ip6_ins_rt(net, f6i);
 
 	addrconf_join_solict(idev->dev, &aca->aca_addr);
@@ -649,8 +649,8 @@ void ipv6_anycast_cleanup(void)
 {
 	int i;
 
-	spin_lock(&acaddr_hash_lock);
+	spin_lock_bh(&acaddr_hash_lock);
 	for (i = 0; i < IN6_ADDR_HSIZE; i++)
 		WARN_ON(!hlist_empty(&inet6_acaddr_lst[i]));
-	spin_unlock(&acaddr_hash_lock);
+	spin_unlock_bh(&acaddr_hash_lock);
 }
-- 
2.43.0


