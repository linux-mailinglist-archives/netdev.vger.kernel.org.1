Return-Path: <netdev+bounces-72057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B30856606
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 15:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0E9B231BE
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F0C131E36;
	Thu, 15 Feb 2024 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/slDuff"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA461131E20
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007628; cv=none; b=BHfUI8M7pAYmWfd3zyUWtEi08qiCgPzZHEBdC1Iu5MdCXbiaOV86h1nMTbxHJvEdM2M77kO0BtK1bHALihLqCdTlQ5E2TA76+nX6oYrHl7oMYEbe4OijWkoXbmCEEoJ4ucdptjdOdWCV2eIMYMZaRUz6MDSVYxLP3aKfUrI8dgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007628; c=relaxed/simple;
	bh=EZ/YcTaJ+h/n7Pb6OrnN8h6zHmcVy1TYjNgZcW1mNl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSvf1RGiZfaixcbqRChXU/Sm6H/SL9eE1P4kB1VQVbB5YZWtRKguzGvWDl5+Koc1i/v71YFkr7KG0cvE+2QkHnb1PTkAcw4D/EpTamgG8m9ApfKvNH4AgJ9ljBIrBShkmYdN1lFU0eFVRl2qZ2HAUrzaZWs1cCy5B5j+rFAFjnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/slDuff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7B4C433F1;
	Thu, 15 Feb 2024 14:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708007628;
	bh=EZ/YcTaJ+h/n7Pb6OrnN8h6zHmcVy1TYjNgZcW1mNl0=;
	h=From:To:Cc:Subject:Date:From;
	b=G/slDuffDUf75JrLvuLrfo2o9qrGS5Meia+dD+OWNFvKOUlX5rcHMxUrt+YbLuZZO
	 0CwN1X34FazsVyLPdgZAPzhEDqvt0Q657m7Bh2n1ceia0gg8x+oo/gA79lmFQTj6/N
	 9iNLKcJrdqtRuUw7Hp6RrfbGYWVao7Qb3dWxg3ZNABTM8P3FQC7Co6UaK1Ac8PDT4l
	 QFKtfhrh4UIFxmWnb0dxyLgIa0KoOXOdTl8J0zg8aep13LykgQReoRXNAnUCF8Oq4K
	 DkaoB6ZZod8yaIrSSdEFous1CwDlAzCN3hd2L1087NeaJaF7JYqdZLEMzOGCqI4HWy
	 gwkY/SHvFlIMw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shmulik.ladkani@gmail.com
Subject: [PATCH net v3 1/2] net/sched: act_mirred: use the backlog for mirred ingress
Date: Thu, 15 Feb 2024 06:33:45 -0800
Message-ID: <20240215143346.1715054-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test Davide added in commit ca22da2fbd69 ("act_mirred: use the backlog
for nested calls to mirred ingress") hangs our testing VMs every 10 or so
runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
lockdep.

The problem as previously described by Davide (see Link) is that
if we reverse flow of traffic with the redirect (egress -> ingress)
we may reach the same socket which generated the packet. And we may
still be holding its socket lock. The common solution to such deadlocks
is to put the packet in the Rx backlog, rather than run the Rx path
inline. Do that for all egress -> ingress reversals, not just once
we started to nest mirred calls.

In the past there was a concern that the backlog indirection will
lead to loss of error reporting / less accurate stats. But the current
workaround does not seem to address the issue.

Fixes: 53592b364001 ("net/sched: act_mirred: Implement ingress actions")
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Suggested-by: Davide Caratti <dcaratti@redhat.com>
Link: https://lore.kernel.org/netdev/33dc43f587ec1388ba456b4915c75f02a8aae226.1663945716.git.dcaratti@redhat.com/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
CC: shmulik.ladkani@gmail.com
---
 net/sched/act_mirred.c                             | 14 +++++---------
 .../testing/selftests/net/forwarding/tc_actions.sh |  3 ---
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 0a1a9e40f237..291d47c9eb69 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -232,18 +232,14 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 	return err;
 }
 
-static bool is_mirred_nested(void)
-{
-	return unlikely(__this_cpu_read(mirred_nest_level) > 1);
-}
-
-static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
+static int
+tcf_mirred_forward(bool at_ingress, bool want_ingress, struct sk_buff *skb)
 {
 	int err;
 
 	if (!want_ingress)
 		err = tcf_dev_queue_xmit(skb, dev_queue_xmit);
-	else if (is_mirred_nested())
+	else if (!at_ingress)
 		err = netif_rx(skb);
 	else
 		err = netif_receive_skb(skb);
@@ -319,9 +315,9 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 
 		skb_set_redirected(skb_to_send, skb_to_send->tc_at_ingress);
 
-		err = tcf_mirred_forward(want_ingress, skb_to_send);
+		err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
 	} else {
-		err = tcf_mirred_forward(want_ingress, skb_to_send);
+		err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
 	}
 
 	if (err) {
diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index b0f5e55d2d0b..589629636502 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -235,9 +235,6 @@ mirred_egress_to_ingress_tcp_test()
 	check_err $? "didn't mirred redirect ICMP"
 	tc_check_packets "dev $h1 ingress" 102 10
 	check_err $? "didn't drop mirred ICMP"
-	local overlimits=$(tc_rule_stats_get ${h1} 101 egress .overlimits)
-	test ${overlimits} = 10
-	check_err $? "wrong overlimits, expected 10 got ${overlimits}"
 
 	tc filter del dev $h1 egress protocol ip pref 100 handle 100 flower
 	tc filter del dev $h1 egress protocol ip pref 101 handle 101 flower
-- 
2.43.0


