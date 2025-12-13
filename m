Return-Path: <netdev+bounces-244585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CFECBA8B1
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 13:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1110A30136C9
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F82D19F464;
	Sat, 13 Dec 2025 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DtkqMJet"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16172602
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765628218; cv=none; b=q31M+FudWngKUNZtpOYd1LtAFYU1P6TVpCk/8ayr5God1X3SzaTeYDPMQGx8Uo170wYFWpABIuRGCm52IXHbfNHdsTyEcz4PQkO03qkrrUw8g05Lx+3uLokvCNQxqMgHNiiW2H6jjle6cLu3qyW0v07wuyrmFb6UU1DUCpL0zjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765628218; c=relaxed/simple;
	bh=oPzJYCSEmOomkH0py8Fl5KkIHnbQ9TJ3DyLsLr4SPrY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RmBPKsF91khrvhPJTH5oRwALifar2GRq09pYZOqoGIvI96eIbU47Hr22XfCgCsjYXH76qWZQo2gncb8aTzBS0ACEtGy+OL0tZ6ZaRo/8wLxeJB8XG1peqBzXc/M3onnFT/akHX81gKtqBiA9uJPV2Rl5CrzP/rzXaB5E2XwcB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=DtkqMJet; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2d7c38352so213405185a.0
        for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 04:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765628215; x=1766233015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qV4QS6czt4N7BvIj5WADk7dY5ypNmbjBfRYX0QBI7RI=;
        b=DtkqMJetdIA2sEuV5t7xl5G+gRJFysqgQSGzt2Vd3rbXK/ZQS5c1r2B3iarqLboKDZ
         W2grNo6es+U2bqMUIM9A3YaFM86brXpFvcVwEefmWrgsqhYV/cW0LxBRSKCc1zmpeS7u
         dPM5d1nVXrXb91q8/K9GR99H/rptwAmM9h5bZGZWj0C4MkpJ9/p6famAIvO8pI9Yie4h
         Qa2hRB7YGp6HqI5FUiuTXKkciE1nk3nS1+OD/N5VAwf7nJFb6oolbvh3iDmlBovuwtpX
         2PvwIB4W7ts+5my3jNui4w2BjRPw87wcJBvZaSZuss0K4vYFkln59dgN1AEp/w9jVqVK
         p6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765628215; x=1766233015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV4QS6czt4N7BvIj5WADk7dY5ypNmbjBfRYX0QBI7RI=;
        b=jSQ0IFtlTSabMphVdufh4HZD8lwliC+molSboEojiQx6MgrXMjp69KVXNLp0C/SpXW
         QBnbmbfh59WepTfc/tXw+mIjd5BPAVdXiHNcyvRdus+TNXNGDgIC8GfubV+14wtfDJqF
         GgnxINjGYeB4HR3ezMmFLEdDERLQm1Mmq0EqzR9kzVdDld+42GeiTUQ0ZTnGGLrjPsML
         oQ8lzNJNnMe8baX/yyELmwpkOLbKJ++2pg9gisMZ5YzuxPJvGcKPnpGVUdTXzwcMhB7u
         AJQa4Wbt4ZVVdC8wIuIphkc+f7BvoCRGl/WcqjgDEQsSMLEJYyfCZPCRixQk7mQTCio+
         dKIA==
X-Gm-Message-State: AOJu0Yzy7UWHFlWPpkfF/YcXAQR3gDDSIfUqJOCh3NNuEJWCw0dhv4Fh
	7aFUgdQrrdfGt2Gma6r1TSyImdZjtWvfsEv6Tlc0D0FMSukzg7Rl7XKv9qfTzxvYtw==
X-Gm-Gg: AY/fxX71d4TDQ7Xc38kwfkjp2Xy2Yf1ybm2ZTl6tsa/RMiSF0FrijB1Mk7LO4Q1tDw4
	kQ5otiP2gRcIsSjKagI3QgGVv93no8OR5jNsD8wrZMq1Af6mR7dvbv+2OQc8BY8yswNH/nFdDIP
	9I+2LVq70qM7YIq3DPx8/qz4Ih0IOrbwrwfAe2QZD6Ror30g+rLqcPJdidYA48+NXm6r2DgqiJ+
	EL4I3fQSuAzC4GxOlqkb0vZ6OeTOnlfMOL7Pn5VdPx194sBtYcBakLO1Ia8UgaddgcvvV9E1vCh
	YJx4zwcLbL3cVr9kjjlXpro5VUQYRv8QkOkTx+VSA0H1u/lTNxxpPI9WezqeOQg+WS5+7dNvgv9
	82f6g7Ei9MIan8eYyy3LGKWRpzW9jFKMwe66VSjW9+reDLCRINaU3vtos3omqS35hcRNsD/md7a
	chWkUFuwy6ibQ=
X-Google-Smtp-Source: AGHT+IHFb+dJTx+k2gpvVw/ruzyrxsaelQ2Pcp2/SW+M+1NTUES9eN3583MWn+GVsWSygA/Zxx2SwQ==
X-Received: by 2002:a05:620a:2910:b0:8b2:e3c1:24b7 with SMTP id af79cd13be357-8bad440bfdbmr1301121685a.29.1765628215016;
        Sat, 13 Dec 2025 04:16:55 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a860ffebsm12883206d6.57.2025.12.13.04.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 04:16:53 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	dcaratti@redhat.com,
	lariel@nvidia.com,
	daniel@iogearbox.net,
	pablo@netfilter.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH RFC net 1/1] net: sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
Date: Sat, 13 Dec 2025 07:16:36 -0500
Message-Id: <20251213121636.132568-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in V1:
1) Fix compile issues found by Intel bot. Thank you bot
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512121401.3NRi0dUf-lkp@intel.com/
2) Fix other issues found by patchwork
 - https://patchwork.kernel.org/project/netdevbpf/patch/20251210172554.1071864-1-jhs@mojatatu.com/
3) The AI reviewer claimed there was an issue but the link was a 404
 - https://netdev-ai.bots.linux.dev/ai-review.html?id=23b3f0a5-ca6c-4cd2-962e-34cbf46f9d24

This patch could be broken down into multiple patches(at least two), but
posted as one because it is an RFC.

When mirred redirects from egress to ingress  the loop state is lost.
This is because the current loop detection mechanism depends on the device
being rememebred on the sched_mirred_dev array; however, that array is
cleared when we go from egress->ingress because the packet ends up in the
backlog and when we restart from the backlog the loop is amplified, on and
on...

A simple test case:

tc qdisc add dev ethx clsact
tc qdisc add dev ethy clsact
tc filter add dev ethx ingress protocol ip \
   prio 10 matchall action mirred egress redirect dev ethy
tc filter add dev ethy egress protocol ip \
   prio 10 matchall action mirred ingress redirect dev ethx

ping such that packets arrive on ethx. Puff and sweat while the cpu
consumption goes up. Or just delete those two qdiscs from above
on ethx and ethy.

For this to work we need to _remember the loop state in the skb_.
We reclaim the bit "skb->from_ingress" to the qdisc_skb_cb since its use
is constrained for ifb. We then use an extra bit that was available on
the skb for a total of 2 "skb->ttl" bits.
Mirred increments the ttl whenever it sees the same skb. We then
catch it when it exceeds MIRRED_NEST_LIMIT iterations of the loop.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 drivers/net/ifb.c              |  3 +--
 include/linux/skbuff.h         | 26 ++++----------------------
 include/net/sch_generic.h      | 20 ++++++++++++++++++++
 net/netfilter/nft_fwd_netdev.c |  1 +
 net/sched/act_mirred.c         |  5 ++++-
 5 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index d3dc0914450a..4783d479d1d6 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -123,8 +123,7 @@ static void ifb_ri_tasklet(struct tasklet_struct *t)
 		}
 		rcu_read_unlock();
 		skb->skb_iif = txp->dev->ifindex;
-
-		if (!skb->from_ingress) {
+		if (!qdisc_skb_cb(skb)->from_ingress) {
 			dev_queue_xmit(skb);
 		} else {
 			skb_pull_rcsum(skb, skb->mac_len);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d..a6df99714a44 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -840,6 +840,7 @@ enum skb_tstamp_type {
  *	@no_fcs:  Request NIC to treat last 4 bytes as Ethernet FCS
  *	@encapsulation: indicates the inner headers in the skbuff are valid
  *	@encap_hdr_csum: software checksum is needed
+ *	@ttl: time to live count when a packet loops.
  *	@csum_valid: checksum is already valid
  *	@csum_not_inet: use CRC32c to resolve CHECKSUM_PARTIAL
  *	@csum_complete_sw: checksum was completed by software
@@ -1000,6 +1001,9 @@ struct sk_buff {
 	/* Indicates the inner headers are valid in the skbuff. */
 	__u8			encapsulation:1;
 	__u8			encap_hdr_csum:1;
+#ifdef CONFIG_NET_REDIRECT
+	__u8			ttl:2;
+#endif
 	__u8			csum_valid:1;
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	__u8			ndisc_nodetype:2;
@@ -1016,9 +1020,6 @@ struct sk_buff {
 	__u8			offload_l3_fwd_mark:1;
 #endif
 	__u8			redirected:1;
-#ifdef CONFIG_NET_REDIRECT
-	__u8			from_ingress:1;
-#endif
 #ifdef CONFIG_NETFILTER_SKIP_EGRESS
 	__u8			nf_skip_egress:1;
 #endif
@@ -5352,30 +5353,11 @@ static inline bool skb_is_redirected(const struct sk_buff *skb)
 	return skb->redirected;
 }
 
-static inline void skb_set_redirected(struct sk_buff *skb, bool from_ingress)
-{
-	skb->redirected = 1;
-#ifdef CONFIG_NET_REDIRECT
-	skb->from_ingress = from_ingress;
-	if (skb->from_ingress)
-		skb_clear_tstamp(skb);
-#endif
-}
-
 static inline void skb_reset_redirect(struct sk_buff *skb)
 {
 	skb->redirected = 0;
 }
 
-static inline void skb_set_redirected_noclear(struct sk_buff *skb,
-					      bool from_ingress)
-{
-	skb->redirected = 1;
-#ifdef CONFIG_NET_REDIRECT
-	skb->from_ingress = from_ingress;
-#endif
-}
-
 static inline bool skb_csum_is_sctp(struct sk_buff *skb)
 {
 #if IS_ENABLED(CONFIG_IP_SCTP)
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c3a7268b567e..ee494310165f 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -459,6 +459,7 @@ struct qdisc_skb_cb {
 	u8			post_ct:1;
 	u8			post_ct_snat:1;
 	u8			post_ct_dnat:1;
+	u8			from_ingress:1;
 };
 
 typedef void tcf_chain_head_change_t(struct tcf_proto *tp_head, void *priv);
@@ -1140,6 +1141,25 @@ static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb,
 	q->to_free = skb;
 }
 
+static inline void skb_set_redirected(struct sk_buff *skb, bool from_ingress)
+{
+	skb->redirected = 1;
+#ifdef CONFIG_NET_REDIRECT
+	qdisc_skb_cb(skb)->from_ingress = from_ingress;
+	if (qdisc_skb_cb(skb)->from_ingress)
+		skb_clear_tstamp(skb);
+#endif
+}
+
+static inline void skb_set_redirected_noclear(struct sk_buff *skb,
+					      bool from_ingress)
+{
+	skb->redirected = 1;
+#ifdef CONFIG_NET_REDIRECT
+	qdisc_skb_cb(skb)->from_ingress = from_ingress;
+#endif
+}
+
 /* Instead of calling kfree_skb() while root qdisc lock is held,
  * queue the skb for future freeing at end of __dev_xmit_skb()
  */
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 152a9fb4d23a..d62c856ef96a 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -16,6 +16,7 @@
 #include <net/netfilter/nf_dup_netdev.h>
 #include <net/neighbour.h>
 #include <net/ip.h>
+#include <net/sch_generic.h>
 
 struct nft_fwd_netdev {
 	u8	sreg_dev;
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 91c96cc625bd..fec5a5763fcb 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -318,8 +318,10 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 
 		skb_set_redirected(skb_to_send, skb_to_send->tc_at_ingress);
 
+		skb_to_send->ttl++;
 		err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
 	} else {
+		skb_to_send->ttl++;
 		err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
 	}
 	if (err)
@@ -434,7 +436,8 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 #else
 	xmit = this_cpu_ptr(&softnet_data.xmit);
 #endif
-	if (unlikely(xmit->sched_mirred_nest >= MIRRED_NEST_LIMIT)) {
+
+	if (skb->ttl >= MIRRED_NEST_LIMIT - 1) {
 		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
 				     netdev_name(skb->dev));
 		return TC_ACT_SHOT;
-- 
2.34.1


