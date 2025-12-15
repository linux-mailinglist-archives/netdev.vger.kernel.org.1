Return-Path: <netdev+bounces-244799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF90CBEDFE
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D98303010A9A
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A02D9EF9;
	Mon, 15 Dec 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="2eHprBKu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C123288C08
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815370; cv=none; b=bKN0nfBX/RqXfPJfKTLjTTfUqEEqVqq2CDIkRcWrOyM3gohPoEEcj8LIcbm7aalSjtihcUN5ysl7ZIw38JGcNwM7LQM9hZw963jaLv53oS4eNFfaCCi1GUCquWKC50D4DaKND6QPTb1Wi97hpcj07zBblDxB0Dg6d2dzl8cyxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815370; c=relaxed/simple;
	bh=KqaiSjmSa4Qr68QYN2e5Gl5vUs2VpbqyDoMaDL7ACiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LDCoIKJGul8VSO2aiq18vqsQYfq/UwmNRKO6LfruzjaXl+wA1L0tocW3tdv4txaBvUpAfFlR/92guF4F4eAVVuMwxSuKL0VBlaFrLUpBMRMjWBQSBeRUVKaz1xlHvi9KLiogtZk4LYFL83t7W3s2mPpRLF/BwoHH+tQyM0XiBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=2eHprBKu; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88a367a1db0so18097306d6.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 08:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765815366; x=1766420166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WDw4KYVfuxcVTOOw8ahoBimkFT6ZVWon7a9hFOlhyDE=;
        b=2eHprBKuh2dXYnNAViNWxbExy5vL3iE9ocO4DQ85FKxNT0FmpqyQkzLFWeKrbhogJd
         aicwGrlVNEEvAcH4MkCmvDn5e1BlNBTJkB7KH4eDR2/tFTyTnCLXzetKbPSocmEGxKlH
         n9UM4l7J+PYZRFitaGNof3alBuNo2EiKMhE7/T6KNZusYMgN40AuNoSmTtflznL37QRo
         3X6TCCnb4nRmAcO4JgwCRGcLTuTNBYlUKpi3N69gJaILiq1jMhgmphWrWfHccwxmZZSJ
         9jhc6WKez6cjOTzpBpOW8gLKX0ORmO2Xu6zh2K3p4aBcPDWQz/lXDAdl6UdnFJ125QvZ
         gO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815366; x=1766420166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDw4KYVfuxcVTOOw8ahoBimkFT6ZVWon7a9hFOlhyDE=;
        b=v83E0g5IHaqusU/anhQYFDkc+A5bDSb+ZBv3iU1yYita0p8p29Kju4aIMOX4DFMCF1
         58+qZx/8C7uMuYCopq2equsuy8aI/kwiEWlORpjFqufAwZhBhT3mEkbZJlTXlOKxTjgP
         8eYyhpvNZKzhWLRb0wTdQ/ghbZNZ2EVsmf8HuQceQ8y3kdaNxp/oaJs4GWdhDcNqxJv7
         ssoi84Jx5b8FHKgdH2tbZVbnJRgDahHe2NuQoaO0Yv7OszWKgTL4z39vYNm6yH0X/ll6
         Mq1uHpydFxYgR2rZ81W99hS7Vngr5Lh8h57Jz5jSzd0m/Yr1Yc0EPl2roPNxGUzQ86Pc
         /1uw==
X-Gm-Message-State: AOJu0YzW01EeKBpGJa6Kvo9xpDjyAjcKMaIq0L0PQCK361lZW4y5SbkM
	nZF07rol4zA/+jqD8jxZ1aQuru+GUMMCxtbQ/09HoXW104R0sYVcOOaObPYR5ufoZS7kkt9TYZ9
	vX3U=
X-Gm-Gg: AY/fxX4KSq5pu0jvlawSaYrvCGQrGGSy/avGGwttWC4pTk8tbdjYsYpFzoa6QJOqjy2
	T/lwto63sX1SBgYgP1d6uySB/Ys+ijb/BRh5AcemwafSkPcSUoB/fyRoo++3E63MwJK8WMHtGG0
	q4+duk+grT3YyAVxzPps/AdOH/nSTbMHyoNELsl00egMH3DiSNsNJqYfmwmwISlUtZWdIQYbfRR
	gEoYul7/Jos0eyArUCIkKlZEFJcRUDpQnTSDPYQ4PfvUn5tp5oG4OAiAjXuOZd8H0vw3SJaE6lp
	1pepppujpn6diIV7QMaKCR0TIxxdIFhNyrsANltJwn/XjLTbLXRUP68kzePDU2zFhKlq/k9sqMA
	mVLvl8ThOYJXhJ5p5VAnV0j2vHN3TRzNULs2HQPPyZc4g0c36fC7ZkMmkS9Jlx1+IbMqEzI0IRd
	OJUASfYF5vgJs=
X-Google-Smtp-Source: AGHT+IHd8VdwmNEn8YCNPiNUaYXMKLq+1t/sA/AKu0VgkUxQ7HtO1garqWIcdLRdwEPi6/JmWKYYfQ==
X-Received: by 2002:ad4:5dc2:0:b0:88a:4289:77c9 with SMTP id 6a1803df08f44-88a428978afmr4450906d6.10.1765815365576;
        Mon, 15 Dec 2025 08:16:05 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b59838sm54627886d6.13.2025.12.15.08.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:16:04 -0800 (PST)
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
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH RFC net v3 1/1] net: sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
Date: Mon, 15 Dec 2025 11:15:50 -0500
Message-Id: <20251215161550.188784-1-jhs@mojatatu.com>
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

Changes in V2:
Fix compile issues found by Intel bot. Thank you bot!
The bot created the issue by unselecting ifb.
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512140745.hsk9Cf0J-lkp@intel.com/

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
 drivers/net/ifb.c              |  2 +-
 include/linux/skbuff.h         | 24 ++----------------------
 include/net/sch_generic.h      | 27 +++++++++++++++++++++++++++
 net/netfilter/nft_fwd_netdev.c |  1 +
 net/sched/act_mirred.c         |  4 +++-
 5 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index d3dc0914450a..137a20e4bf8c 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -124,7 +124,7 @@ static void ifb_ri_tasklet(struct tasklet_struct *t)
 		rcu_read_unlock();
 		skb->skb_iif = txp->dev->ifindex;
 
-		if (!skb->from_ingress) {
+		if (!qdisc_skb_cb(skb)->from_ingress) {
 			dev_queue_xmit(skb);
 		} else {
 			skb_pull_rcsum(skb, skb->mac_len);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d..7f18b0c28728 100644
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
@@ -1000,6 +1001,7 @@ struct sk_buff {
 	/* Indicates the inner headers are valid in the skbuff. */
 	__u8			encapsulation:1;
 	__u8			encap_hdr_csum:1;
+	__u8			ttl:2;
 	__u8			csum_valid:1;
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	__u8			ndisc_nodetype:2;
@@ -1016,9 +1018,6 @@ struct sk_buff {
 	__u8			offload_l3_fwd_mark:1;
 #endif
 	__u8			redirected:1;
-#ifdef CONFIG_NET_REDIRECT
-	__u8			from_ingress:1;
-#endif
 #ifdef CONFIG_NETFILTER_SKIP_EGRESS
 	__u8			nf_skip_egress:1;
 #endif
@@ -5352,30 +5351,11 @@ static inline bool skb_is_redirected(const struct sk_buff *skb)
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
index c3a7268b567e..b34a1ba258c1 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -459,6 +459,14 @@ struct qdisc_skb_cb {
 	u8			post_ct:1;
 	u8			post_ct_snat:1;
 	u8			post_ct_dnat:1;
+#ifdef CONFIG_NET_REDIRECT
+	/* XXX: For RFC,  we should review and/or fix CONFIG_NET_REDIRECT
+	 * dependency or totally get rid of the NET_REDIRECT Kconfig (which
+	 * would work assuming qdisc_skb_cb is omni present; need to check
+	 * on netfilter dependency; everything else depends on mirred.
+	 */
+	u8			from_ingress:1;
+#endif
 };
 
 typedef void tcf_chain_head_change_t(struct tcf_proto *tp_head, void *priv);
@@ -1140,6 +1148,25 @@ static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb,
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
index 91c96cc625bd..4a945ea00197 100644
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
@@ -434,7 +436,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 #else
 	xmit = this_cpu_ptr(&softnet_data.xmit);
 #endif
-	if (unlikely(xmit->sched_mirred_nest >= MIRRED_NEST_LIMIT)) {
+	if (skb->ttl >= MIRRED_NEST_LIMIT - 1) {
 		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
 				     netdev_name(skb->dev));
 		return TC_ACT_SHOT;
-- 
2.34.1


