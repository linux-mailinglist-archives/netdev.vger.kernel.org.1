Return-Path: <netdev+bounces-244278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1877CB39E5
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 18:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7B23302532F
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 17:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A1730FF3B;
	Wed, 10 Dec 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="SaQGVVW5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6027B358
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765387573; cv=none; b=czc8gVie43IRAEa7QeLF7LBwE/98T14gQ5xBxJ3dCn8L8BL7e93fEWnUgGaS40MWfHsfvTj6YJ3jlN4Y9o4AbepwP7dMz/qHXBpLyxS6e9QPwBDl4C6YaVnILcOOGoHjxshVVCZAw6lKjqv8r96tilvlQsn369blLQOoXIDEx2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765387573; c=relaxed/simple;
	bh=Dj30wna/cGqsfd3+heWOiHPayNwVRle0QLdeRSXFnzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ldTBcVGEPjP4mWatfmSo+Y4xbaa2qpQAuvyFuTr7SxI6NtTMTMtHcnfTTdx2onjh1r0p4x08qW3ZsY0B+EhOPrZk4qb1FMH7RJseYwtKRFDD+HNVg0p/HK1ITeQ4d01RgKFVjc9kLZLjYCLXhOsuiRXz0o88sISVnFkYKsK91YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=SaQGVVW5; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ee0ce50b95so10725961cf.0
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 09:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765387570; x=1765992370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qortwmnraNcyPicOXQjsuNN3yW2jvMMJW5TuFjMLtNI=;
        b=SaQGVVW5H9MJiOhckeq3jq9yOcSCO4z7zQRHcx2H6GymCknXjQxMMVAXO2jutIApqu
         HLZOT7wZkcEnQj0Vrpon4anTmbkrEe63QYG+rPdbNehZh/GbqcRGyGRK3UuKwDI+61PT
         ipYSxIsC6cMjbx5rLNGpjqoAeydkuoMXbcudNqlir5K9A6LmQjydiXQHm+mq/pTI8Xoi
         AUtqmhuNB15nGhpMeQ/YGPXfoCC8EtUCSEMZ/vBXWyE22IQe1G548YmsxXpcdX+XX5od
         0B1vYcECLBMWFBA5XYOgAJd7/XDK8VJDJ9/RKX0OLkv9X5n7d+ed2T6ahCsSxN5QBWpN
         JTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765387570; x=1765992370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qortwmnraNcyPicOXQjsuNN3yW2jvMMJW5TuFjMLtNI=;
        b=R5jQALxbPe86kTr6eu2kM4M0t9Ou7q9F6SZWi8ekCHW8hZvu9bIjW22KSO/UVgIUWn
         E3RUrRFdQubtTbkdCHK8Qc6N+1rFGzzsS6BL/kFC5NI951Bj9vXswfUaOfjwkjKUBz+G
         5/em8P0J/cGdEUypQZbuP1GfFmHHdki00aTZFwTQPZ/sfTd3xW1tpOYhpfDgy/x1xPBc
         JrYrSpf0pFBhP+IjXmRPcfdgcbxBNnqYuj2xEv4DfCW3jnWnnUrrVrTN4VXuXTD9b+j+
         9V3Ql8/PXLTrJcyHlgzNCjCDVrggxkI4llm7i4qZr1oizWNOeF56wtH/6fzwJsNMWbn/
         LbAA==
X-Gm-Message-State: AOJu0Yzav7CdALi6JE4aaCqHbSFz0gfRPN6P53kjoAK9D7HT/HVHpz7z
	ZB6xVS5aSLWhd8rrygqboqr14GK9Wxm40ZwYS6cbL+xJdgDMZ3EU/Orug4EPiRUrdQ==
X-Gm-Gg: ASbGncv62NobpPiUortN7rK4WHNnYea72eU91tt7F3pU/wWm+zC345vRIqHdenXwy2G
	i5RO5ZEjwMlR18wMMIWh86KimEsTtmmk1ZKlqn1guG2pIo4AUPTVvdonyJ+Xl2fYBGwqE0B102H
	ObwoT5vsxmdjdJIEaTM1xp07iZk6eCL+V4dOzHPu9llC3yIIDNfxNN9d9b3cAotyNcMpwyDSpw0
	5En27N37RZGtMF3OnNUKW6TttMu82cqC1L2ZUOkuUZBYcXKpRPjInpPIuJ8WF2WiVRgp2ImAgsp
	8dt2teT3ky2cUg/tAb/85cJZR+2QavxQgela/w2IGuSH3LSAF8/2oiZzGehBW57VfWNGrrPRG7m
	uWTAh+MXBxT/5UilDxJmu0Js9bPv3ljwQdWOpPl8LV5ILl5eCoKjBQjOulGzdGBLYfaj+ywgW21
	Uu7MwxZlY1k5U=
X-Google-Smtp-Source: AGHT+IEfmJdTs08Vw/2Nih+F5s961qD08RnAR4C/StEltfsBnJo+V1h490IBWqaGN+3yH/G4zhU/vg==
X-Received: by 2002:a05:622a:11c9:b0:4f1:af84:f1f8 with SMTP id d75a77b69052e-4f1bbcace0emr3068021cf.12.1765387570007;
        Wed, 10 Dec 2025 09:26:10 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f027d24734sm118829591cf.23.2025.12.10.09.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 09:26:09 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	dcaratti@redhat.com,
	lariel@nvidia.com,
	daniel@iogearbox.net,
	pablo@netfilter.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH RFC net 1/1] net: sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
Date: Wed, 10 Dec 2025 12:25:54 -0500
Message-Id: <20251210172554.1071864-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/net/ifb.c         |  3 +--
 include/linux/skbuff.h    | 35 +++--------------------------------
 include/net/sch_generic.h | 30 ++++++++++++++++++++++++++++++
 net/sched/act_mirred.c    |  5 ++++-
 4 files changed, 38 insertions(+), 35 deletions(-)

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
index 86737076101d..2e76d84eddf8 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1000,6 +1000,9 @@ struct sk_buff {
 	/* Indicates the inner headers are valid in the skbuff. */
 	__u8			encapsulation:1;
 	__u8			encap_hdr_csum:1;
+#ifdef CONFIG_NET_REDIRECT
+	__u8			ttl:2;
+#endif
 	__u8			csum_valid:1;
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	__u8			ndisc_nodetype:2;
@@ -1016,9 +1019,6 @@ struct sk_buff {
 	__u8			offload_l3_fwd_mark:1;
 #endif
 	__u8			redirected:1;
-#ifdef CONFIG_NET_REDIRECT
-	__u8			from_ingress:1;
-#endif
 #ifdef CONFIG_NETFILTER_SKIP_EGRESS
 	__u8			nf_skip_egress:1;
 #endif
@@ -5347,35 +5347,6 @@ static inline __wsum lco_csum(struct sk_buff *skb)
 	return csum_partial(l4_hdr, csum_start - l4_hdr, partial);
 }
 
-static inline bool skb_is_redirected(const struct sk_buff *skb)
-{
-	return skb->redirected;
-}
-
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
-static inline void skb_reset_redirect(struct sk_buff *skb)
-{
-	skb->redirected = 0;
-}
-
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
index c3a7268b567e..7580ccb65ba5 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -459,6 +459,7 @@ struct qdisc_skb_cb {
 	u8			post_ct:1;
 	u8			post_ct_snat:1;
 	u8			post_ct_dnat:1;
+	u8			from_ingress:1;
 };
 
 typedef void tcf_chain_head_change_t(struct tcf_proto *tp_head, void *priv);
@@ -1140,6 +1141,35 @@ static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb,
 	q->to_free = skb;
 }
 
+static inline bool skb_is_redirected(const struct sk_buff *skb)
+{
+	return skb->redirected;
+}
+
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
+static inline void skb_reset_redirect(struct sk_buff *skb)
+{
+	skb->redirected = 0;
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


