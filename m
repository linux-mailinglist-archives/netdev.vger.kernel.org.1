Return-Path: <netdev+bounces-57658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C314813B9B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 21:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066951F21610
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B521110;
	Thu, 14 Dec 2023 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GVxs58Yr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4096D1AF
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d069b1d127so52486815ad.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 12:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702586150; x=1703190950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGkCjqBrZueI7OLLPxcfcXU1Q2LF7+DyN4ePbi7d7l8=;
        b=GVxs58YrJPsTAxFFOhNVI0JoT0hvNFKE8XfNexwcUulvqSGaso+g2nCLE3I6NTrSPL
         sDyHtGeTvKvl7pRrSMsM3wzsOGOgvzYHeuBANhNR7rs2y7FiAWJ8ImGKEvOq4sljt/JY
         cKTNgq+JBq35JCvpfWaYy4Q1W3FZw5KKKXWQVvv8xk+Rqqv4uUx38e6UVgOcFQFKhUlD
         59g9aJSI0vdTFH9fMMLYOoMpgV/JGzozHN8QCEoGWHfP4FKkRr7LZLJCOwUIuQa0p1eP
         F0kN7XHMZ0fnCrk0sM+zTlGtAWKr40xDvFQ/wmxWLxUD/UJmevt1YvS3B1311MRbsWrJ
         UcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586150; x=1703190950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGkCjqBrZueI7OLLPxcfcXU1Q2LF7+DyN4ePbi7d7l8=;
        b=tYwEpttdFYUWFFW4od1KDufk5BP15zDkQS5+v6xCCMTjKiLxdpeH2cz708X4QgZ5mS
         kT7W4JaCEK3lRrAHjPayRwRatp1H4YzUnNn4ZlUPaFQXnOgQ/6ybP8apatK80QbGbA+4
         wEfXbhvkNI8xgRICf0AdW6wWoE9kn87lw9qeWa0b38fkg8JYJlBU3AQlFi0i2dWMQIXo
         qqv6QmlmbrX3Fp00lnWzSSSxuHkapSV7DiLsGEmuYnZGTDh3rXS1W2J4wTa/16gapLEW
         zkS1bBQi/jI6L6oZRm+CoQmGJBYQqOCeEmsN5WHZWnvBDOulfiAgmEPvyY8ShdpsKC6E
         L0Xw==
X-Gm-Message-State: AOJu0Ywcja5CZwu1T0nxtK3S6vbrnqbRjux83Ani/AyMLg7lcwccc6Kt
	3AKMExVn81pKvVSaeXOZaaefQg==
X-Google-Smtp-Source: AGHT+IH6f+SIQXvYbESuKRctASJ8e/oxBqou3YVMV71MpBCER42ClW+jYs51AgQCc8w5NbZrNxKu0Q==
X-Received: by 2002:a17:902:b708:b0:1d0:76c2:e352 with SMTP id d8-20020a170902b70800b001d076c2e352mr5601109pls.94.1702586149863;
        Thu, 14 Dec 2023 12:35:49 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001b9e9edbf43sm12842871plk.171.2023.12.14.12.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:35:49 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	horms@kernel.org
Cc: dcaratti@redhat.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v4 2/3] net: sched: Make tc-related drop reason more flexible for remaining qdiscs
Date: Thu, 14 Dec 2023 17:35:31 -0300
Message-ID: <20231214203532.3594232-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214203532.3594232-1-victor@mojatatu.com>
References: <20231214203532.3594232-1-victor@mojatatu.com>
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
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/net/pkt_cls.h     | 16 ----------------
 include/net/pkt_sched.h   | 19 -------------------
 include/net/sch_generic.h | 31 +++++++++++++++++++++++++++++++
 net/core/dev.c            |  7 +++++--
 4 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 761e4500cca0..f308e8268651 100644
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
-tcf_get_drop_reason(const struct sk_buff *skb)
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
index 9b559aa5c079..1e200d9a066d 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -275,25 +275,6 @@ static inline void skb_txtime_consumed(struct sk_buff *skb)
 	skb->tstamp = ktime_set(0, 0);
 }
 
-struct tc_skb_cb {
-	struct qdisc_skb_cb qdisc_cb;
-	u32 drop_reason;
-
-	u16 zone; /* Only valid if post_ct = true */
-	u16 mru;
-	u8 post_ct:1;
-	u8 post_ct_snat:1;
-	u8 post_ct_dnat:1;
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
index c499b56bb215..1d70c2c1572f 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1036,6 +1036,37 @@ static inline struct sk_buff *qdisc_dequeue_head(struct Qdisc *sch)
 	return skb;
 }
 
+struct tc_skb_cb {
+	struct qdisc_skb_cb qdisc_cb;
+	u32 drop_reason;
+
+	u16 zone; /* Only valid if post_ct = true */
+	u16 mru;
+	u8 post_ct:1;
+	u8 post_ct_snat:1;
+	u8 post_ct_dnat:1;
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
+tcf_get_drop_reason(const struct sk_buff *skb)
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
 /* Instead of calling kfree_skb() while root qdisc lock is held,
  * queue the skb for future freeing at end of __dev_xmit_skb()
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 16af89a733e4..b87504078320 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3753,6 +3753,8 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 
 	qdisc_calculate_pkt_len(skb, q);
 
+	tcf_set_drop_reason(skb, SKB_DROP_REASON_QDISC_DROP);
+
 	if (q->flags & TCQ_F_NOLOCK) {
 		if (q->flags & TCQ_F_CAN_BYPASS && nolock_qdisc_is_empty(q) &&
 		    qdisc_run_begin(q)) {
@@ -3782,7 +3784,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 no_lock_out:
 		if (unlikely(to_free))
 			kfree_skb_list_reason(to_free,
-					      SKB_DROP_REASON_QDISC_DROP);
+					      tcf_get_drop_reason(to_free));
 		return rc;
 	}
 
@@ -3837,7 +3839,8 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	}
 	spin_unlock(root_lock);
 	if (unlikely(to_free))
-		kfree_skb_list_reason(to_free, SKB_DROP_REASON_QDISC_DROP);
+		kfree_skb_list_reason(to_free,
+				      tcf_get_drop_reason(to_free));
 	if (unlikely(contended))
 		spin_unlock(&q->busylock);
 	return rc;
-- 
2.25.1


