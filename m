Return-Path: <netdev+bounces-53136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A47801739
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46541C20950
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C133F8C9;
	Fri,  1 Dec 2023 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="2MpDfXiY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A9890
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 15:00:27 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d817ccaa6dso704713a34.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 15:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701471626; x=1702076426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Jmec2Z07jEPbTj86DW3gNscxYM5F8ER7eOO93Xmo4w=;
        b=2MpDfXiYDAoVDXwAAfWTY7iczQQHrqka2hcxbL7r6QbEtmYMaWqHvs3vQK1OCkx87k
         1Hidk/5df741904f1Y7+Noymns6mcmBDpsa33XjDrfQJrvV63Y1+Zgm+2E8sfkE6136+
         zJ2A1kYIxwBClSjztKuyl7AYj/OysAGaWrGV2QRqUsrY9tQqoA12ru6s4pONj0wvCnK5
         /+/BrK67JdfqQCpGKFcsax2lRiG0xibH0g9cmmN2tV2XqZMP8YMm9pOWlnYRko3fug4C
         cnwxfWi2D1z1Y3qAHMbALzzvMpLG7GzO0s9fvSDCWaUIG77jUdd+CvDstC3MxPYS+o8x
         HkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701471626; x=1702076426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Jmec2Z07jEPbTj86DW3gNscxYM5F8ER7eOO93Xmo4w=;
        b=LO7FqpDCS0G2pS27DYqPDeg5cKqKF5QB4ubwf+aIrhtH2mYQZpnukcSMru931Xs65U
         o8Ep9A0u/rEAQdlZ/0SnAoxdIUgRqpxR6gKYmCCUXOwO2lR5nPyZHdT2wvjizy+Wfq+6
         quCKjS8t+zGpfCeMbQCmgDaoiKUtgIC49ib7noQY3pOpqHc7lLsb9wujLiSdK2has6XS
         wTsZSvMhv842I8lsOfhr1L8ucUMsZjIngHCsd369YUabS5jj8DIHKVwMPlyLTHf+PK4g
         Y+T1P091LIk5cll2qFSHlMyJrmaWb2McnBblORlXROQ14D48RUJhtK42TBDFSvcL2+RR
         o2cw==
X-Gm-Message-State: AOJu0YwvakSBg3bWvCxAQ4NuzigSYY+W9PpFftJJJc1c/TM8U9dptd0b
	6N6WsFHiyeKdCWadtxPozF55yzwgnhyKXBnSnFg=
X-Google-Smtp-Source: AGHT+IF+kPmcOyMR1DMoCY5pyfvXT1bZkqH77gx0zz7pqiJFdUeAxXFrXeZHTrYg+UJhTTSnHYOLZQ==
X-Received: by 2002:a9d:5e12:0:b0:6d8:a8:b59c with SMTP id d18-20020a9d5e12000000b006d800a8b59cmr314515oti.27.1701471626245;
        Fri, 01 Dec 2023 15:00:26 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:638:b3b3:3480:1b98:451d])
        by smtp.gmail.com with ESMTPSA id y62-20020a62ce41000000b006be0fb89ac3sm3632124pfg.30.2023.12.01.15.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 15:00:25 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net
Cc: dcaratti@redhat.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v2 2/3] net: sched: Make tc-related drop reason more flexible for remaining qdiscs
Date: Fri,  1 Dec 2023 20:00:10 -0300
Message-ID: <20231201230011.2925305-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231201230011.2925305-1-victor@mojatatu.com>
References: <20231201230011.2925305-1-victor@mojatatu.com>
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
 include/net/pkt_cls.h     | 16 ----------------
 include/net/pkt_sched.h   | 19 -------------------
 include/net/sch_generic.h | 31 +++++++++++++++++++++++++++++++
 net/core/dev.c            |  7 +++++--
 4 files changed, 36 insertions(+), 37 deletions(-)

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
index c499b56bb215..07ca001e94e0 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1036,6 +1036,37 @@ static inline struct sk_buff *qdisc_dequeue_head(struct Qdisc *sch)
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
 /* Instead of calling kfree_skb() while root qdisc lock is held,
  * queue the skb for future freeing at end of __dev_xmit_skb()
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 323496ca0dc3..861c54241a53 100644
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


