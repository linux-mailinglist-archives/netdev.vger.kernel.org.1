Return-Path: <netdev+bounces-54088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954EB805FC4
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD6E281FA8
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9F86A02B;
	Tue,  5 Dec 2023 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="w3qIrQFw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69801188
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 12:50:43 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ce7632b032so837668b3a.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 12:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701809443; x=1702414243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70IKko6nuFG0YgO0yVZiuVVQeJMW/VMd50S6MbDFdyg=;
        b=w3qIrQFwuFrYD4coUIut6CoYluTiyZP+g3b/VfOw/OdyAJn2g2s4kVEZeo2lZl7S7R
         0JX2TBs7N0lTD9cytQ9CR43p1U8UZUzqaqCRnA4EtVB6cJcu6jNRHytQDWLIx190eIJ4
         KL9OuxAYYnZdEdgPTdhSvZxC5GFecib0Gea6nyAHQQFhLXxG8AOkqnLY/7cFkLuxPPnl
         tW6L0GezyTaquvxQYeS8sx1QQlz0/wz0z2/2P6dzSfnx8QNpcGNtrqFpis7nFke0bUIB
         pGR/nPZTv2FWKy9aOU7AtFpHHn91Wo0Uimn11+yg1txJM/Xnh5cLN04vLdcz3IK/fGtZ
         JQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701809443; x=1702414243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70IKko6nuFG0YgO0yVZiuVVQeJMW/VMd50S6MbDFdyg=;
        b=EfKjBm6vv+cxET3Utt8gr//ZaB589uhf2cmwWgHCNiZlRwLWr2yEcZ4UKUKtvSycRv
         1HnJ69NNJUNkJ7n8RHTDZzgW9Ufg9jDZof98SeahwznMnqeZTIRDTuP/ypsRhHHl8B9H
         baeP53rCpFHY7rALg/+OCRviKuMBYe0YSk+W8ARvhX9qebC588YJlr/eLdh0ps7nooKF
         L9HLM1r9W/oNGSp3wBkhew6WqX159RySCu89Jiu7wxdQ0kDdbzCq9VpW9+WWIHDnW7Jg
         XSiEqfzSkOKBBc9zIIg6TGxobeCL92xm0Bcg7PdzCFrC5Yl/RW8uZvpVQtWPT1yvxuRI
         YKGQ==
X-Gm-Message-State: AOJu0YxZJXahNsSTXfcIVPaL6EkCiZdYIT+H1Np4/JczC+crWtZED07q
	70DRdepslRJdlW++Pl8FPs5KeQ==
X-Google-Smtp-Source: AGHT+IHHjtlgBjedyc+QwH8lP9oEOYWKk17ZrffcySxIG5b3rTBYVFnfQQOAk1lW7wjw0Ee77SKCiw==
X-Received: by 2002:a05:6a20:1444:b0:18f:97c:5b77 with SMTP id a4-20020a056a20144400b0018f097c5b77mr3895540pzi.69.1701809442833;
        Tue, 05 Dec 2023 12:50:42 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:638:b3b3:3480:1b98:451d])
        by smtp.gmail.com with ESMTPSA id iw13-20020a170903044d00b001bf52834696sm8772788plb.207.2023.12.05.12.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 12:50:42 -0800 (PST)
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
Subject: [PATCH net-next v3 2/3] net: sched: Make tc-related drop reason more flexible for remaining qdiscs
Date: Tue,  5 Dec 2023 17:50:29 -0300
Message-ID: <20231205205030.3119672-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205205030.3119672-1-victor@mojatatu.com>
References: <20231205205030.3119672-1-victor@mojatatu.com>
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
index 4b84b72ebae8..f38c928a34aa 100644
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


