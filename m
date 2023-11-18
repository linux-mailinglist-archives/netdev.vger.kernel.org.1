Return-Path: <netdev+bounces-48958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 838B07F02EC
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 21:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A571F226E4
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 20:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81F111AE;
	Sat, 18 Nov 2023 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="WRrFqO8d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D656BC5
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 12:38:26 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ce618b7919so10701075ad.0
        for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 12:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700339906; x=1700944706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6MNyhW0nhTU4iWeHDPoxoiHHuLw7r3Gkh93O/dqOtk=;
        b=WRrFqO8dqEmZcKeLSRWUYwtu5+KlybG7mF8OQ2VDS6e8bLe3ruc5UDM1tNGpPVbjGd
         T9lwH7IfgbvlKNTlDsr1vr4jvSPbbis5VDmB59KR/4lWuNOlhO4UThuOcR3YiJdSaPwA
         WF+1rsha0uQ4LrGH3C6oFsJuHRA/T6zv4WVxnaWVCmFMWr+CSq5i+c/W4jmag/Ju1nwL
         AOw+6iAiG2zziFPnlFH02wJUMA8BDpG3b1bZnnMSxLJ9rvu/uGxU2pPqCTbjSlG2SRPr
         trrzGnqc6QYaWYSD7IfxhYEMHKGM0ewXZO1QxFAX6oS+mwRTdNAu8sINuts3p5NQX4r2
         FPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700339906; x=1700944706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6MNyhW0nhTU4iWeHDPoxoiHHuLw7r3Gkh93O/dqOtk=;
        b=wGOFytRWMRrDbMFVsSuLWmhyWnf9mjriML6y8JZPE6/erp2ROuk4YqofUq4geFebYD
         VrMNsGdvJRImr75RIYK4lo1PHazkv2V9FSUxK4CdHMwiKoRCP4ue5kpX4g0Zwq0Up6Y1
         ZrIJYMynILsho72EdIoGe6Mq5fiUssrpqIpFSKDj3aM+esRxan9GnGKB4tLdILq7n7Ui
         KUGQ1KkAOn9sNZXLFUKYfrqYyhTDEzk7E0G2GWNagVlNPkRaw0kBubTUClmgcBb3j38N
         b/N7dyGhRHuOAB+SMeKhc7s05qkL8Idil5J4sh1OVyKPdCuFpYoXpNYCi65sKkTSVM1c
         AaTg==
X-Gm-Message-State: AOJu0YzaHr6RN6eyRC30bdraKbhUTrWr0VUTL9nO7ZbJpdHP4DUeoIYb
	yh0krcIoSXNhjiBGVrjA/N1QphbBEc4hYeJZj50qcw==
X-Google-Smtp-Source: AGHT+IGLQ+ZUBRbil6TQux1M1kA/L9LGDnFKOQjGMnZhEorh+7g+PwJaZtE3wm/W3XuDvISPAnLIUg==
X-Received: by 2002:a17:903:4d:b0:1ce:5fa5:9056 with SMTP id l13-20020a170903004d00b001ce5fa59056mr6122347pla.3.1700339906243;
        Sat, 18 Nov 2023 12:38:26 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c3:b02d:77:2195:4deb:3614])
        by smtp.gmail.com with ESMTPSA id g31-20020a63565f000000b005891f3af36asm3403875pgm.87.2023.11.18.12.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 12:38:25 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net
Cc: netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH RFC net-next 2/3] net: sched: Make tc-related drop reason more flexible for remaining qdiscs
Date: Sat, 18 Nov 2023 17:37:53 -0300
Message-ID: <20231118203754.2270159-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231118203754.2270159-1-victor@mojatatu.com>
References: <20231118203754.2270159-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Incrementing on Daniel's patch[1], make tc-related drop reason more
flexible for remaining qdiscs - that is, all qdiscs aside from clsact.
In essence, the drop reason will be set by cls_api and act_api in case
any error occurred in the data path. With that, we can give the user more
detailed information so that they can distinguish between a policy drop
or an error drop.

[1] https://lore.kernel.org/all/20231009092655.22025-1-daniel@iogearbox.net

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/pkt_cls.h     | 16 --------------
 include/net/pkt_sched.h   | 19 -----------------
 include/net/sch_generic.h | 45 +++++++++++++++++++++++++++++++++++++++
 net/core/dev.c            |  7 ++++--
 4 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 7bd7ea511100..f308e8268651 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -154,22 +154,6 @@ __cls_set_class(unsigned long *clp, unsigned long cl)
 	return xchg(clp, cl);
 }
 
-struct tc_skb_cb;
-
-static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb);
-
-static inline enum skb_drop_reason
-tc_skb_cb_drop_reason(const struct sk_buff *skb)
-{
-	return tc_skb_cb(skb)->drop_reason;
-}
-
-static inline void tcf_set_drop_reason(const struct sk_buff *skb,
-				       enum skb_drop_reason reason)
-{
-	tc_skb_cb(skb)->drop_reason = reason;
-}
-
 static inline void
 __tcf_bind_filter(struct Qdisc *q, struct tcf_result *r, unsigned long base)
 {
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index f09bfa1efed0..1e200d9a066d 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -275,25 +275,6 @@ static inline void skb_txtime_consumed(struct sk_buff *skb)
 	skb->tstamp = ktime_set(0, 0);
 }
 
-struct tc_skb_cb {
-	struct qdisc_skb_cb qdisc_cb;
-	u32 drop_reason;
-
-	u16 mru;
-	u8 post_ct:1;
-	u8 post_ct_snat:1;
-	u8 post_ct_dnat:1;
-	u16 zone; /* Only valid if post_ct = true */
-};
-
-static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb)
-{
-	struct tc_skb_cb *cb = (struct tc_skb_cb *)skb->cb;
-
-	BUILD_BUG_ON(sizeof(*cb) > sizeof_field(struct sk_buff, cb));
-	return cb;
-}
-
 static inline bool tc_qdisc_stats_dump(struct Qdisc *sch,
 				       unsigned long cl,
 				       struct qdisc_walker *arg)
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c499b56bb215..00251a526bf4 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1036,11 +1036,54 @@ static inline struct sk_buff *qdisc_dequeue_head(struct Qdisc *sch)
 	return skb;
 }
 
+struct tc_skb_cb {
+	struct qdisc_skb_cb qdisc_cb;
+	u32 drop_reason;
+
+	u16 mru;
+	u8 post_ct:1;
+	u8 post_ct_snat:1;
+	u8 post_ct_dnat:1;
+	u16 zone; /* Only valid if post_ct = true */
+};
+
+static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb)
+{
+	struct tc_skb_cb *cb = (struct tc_skb_cb *)skb->cb;
+
+	BUILD_BUG_ON(sizeof(*cb) > sizeof_field(struct sk_buff, cb));
+	return cb;
+}
+
+static inline enum skb_drop_reason
+tc_skb_cb_drop_reason(const struct sk_buff *skb)
+{
+	return tc_skb_cb(skb)->drop_reason;
+}
+
+static inline void tcf_set_drop_reason(const struct sk_buff *skb,
+				       enum skb_drop_reason reason)
+{
+	tc_skb_cb(skb)->drop_reason = reason;
+}
+
+static inline void tcf_init_drop_reason(const struct sk_buff *skb,
+					const enum skb_drop_reason reason)
+{
+	const u32 orig_drop_reason = tc_skb_cb_drop_reason(skb);
+
+	/* If not set previously, initialise with reason */
+	if (likely(orig_drop_reason == SKB_NOT_DROPPED_YET))
+		tcf_set_drop_reason(skb, reason);
+}
+
 /* Instead of calling kfree_skb() while root qdisc lock is held,
  * queue the skb for future freeing at end of __dev_xmit_skb()
  */
 static inline void __qdisc_drop(struct sk_buff *skb, struct sk_buff **to_free)
 {
+	tcf_init_drop_reason(skb, SKB_DROP_REASON_QDISC_DROP);
+
 	skb->next = *to_free;
 	*to_free = skb;
 }
@@ -1048,6 +1091,8 @@ static inline void __qdisc_drop(struct sk_buff *skb, struct sk_buff **to_free)
 static inline void __qdisc_drop_all(struct sk_buff *skb,
 				    struct sk_buff **to_free)
 {
+	tcf_init_drop_reason(skb, SKB_DROP_REASON_QDISC_DROP);
+
 	if (skb->prev)
 		skb->prev->next = *to_free;
 	else
diff --git a/net/core/dev.c b/net/core/dev.c
index eb39e9f80428..c47959754ab0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3754,6 +3754,8 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 
 	qdisc_calculate_pkt_len(skb, q);
 
+	tcf_set_drop_reason(skb, SKB_DROP_REASON_QDISC_DROP);
+
 	if (q->flags & TCQ_F_NOLOCK) {
 		if (q->flags & TCQ_F_CAN_BYPASS && nolock_qdisc_is_empty(q) &&
 		    qdisc_run_begin(q)) {
@@ -3783,7 +3785,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 no_lock_out:
 		if (unlikely(to_free))
 			kfree_skb_list_reason(to_free,
-					      SKB_DROP_REASON_QDISC_DROP);
+					      tc_skb_cb_drop_reason(to_free));
 		return rc;
 	}
 
@@ -3838,7 +3840,8 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	}
 	spin_unlock(root_lock);
 	if (unlikely(to_free))
-		kfree_skb_list_reason(to_free, SKB_DROP_REASON_QDISC_DROP);
+		kfree_skb_list_reason(to_free,
+				      tc_skb_cb_drop_reason(to_free));
 	if (unlikely(contended))
 		spin_unlock(&q->busylock);
 	return rc;
-- 
2.25.1


