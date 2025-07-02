Return-Path: <netdev+bounces-203213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE770AF0C5A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572ED442086
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE4C223DCD;
	Wed,  2 Jul 2025 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="dDhi9dkv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C00232C85
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440705; cv=none; b=mmwA9TmpvaW6m+E5MYJJGLMJ+1CZ7dv5EQH8KrjsXklZw0g/5ezvKNf78Plbl8bpQU+EQImxNRDycDeYuhdfMiF9r0zevY1BuHEKJJaBtDaOOSopSfgFogfpVBOou6mSlZDPqUpqi9y7WRXUf+UOXI7PtCM1gLAjL77q2hpi65k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440705; c=relaxed/simple;
	bh=JxKrKEmLuA06NTeYWvo0wUyOPesaHES8pzAXeO2ZKPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peSj8d9lthWra3DMnK6jJ44d0lotRPg2ucTUUOixKpwnslz2ghDKbd+GCtTtKGlIFv3CCXjj+hsIjl0D7QvgwNYEDXN2U4XD8b82FjVSvGbOk5HC13CH0l0CNQREc2lA1eyzzMqv9V9gRwoqXWL0D0U4D/OPRsPPSCGlsaCO870=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=dDhi9dkv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234b440afa7so65835565ad.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1751440703; x=1752045503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy7H0ZYdtRQl4Da1EmIyCQoTQO+pkft5mRGtpqqpozY=;
        b=dDhi9dkvCRuOV/+Cgb2OFu/ksVDib65S22idI6z4ObwmKaxr2zEGpmdR/Uqa+v2STY
         zR6VqPqUbNFqdpiAMQW12IDQSiSTmYX0zBj6Im8zux5sU0gjOpK9w3sk9O8wfU2OuKk0
         FgLDJnTyGEBjHk7B02bst1k5TgMi57J+hV1L6ycGCsKse83zpGSfZqFkRWzfzQAw+1q9
         BmeFrGSsx56qhJ4PnZ1AVALWA7wZbQ0vBunnOW4j6sE8Sqox6efUPIZG9woP9OBD3ajB
         9pxnMd3m8Q2kJDKq0kkIrvIzyVtkmVSOxZfPLo+uXwnUfeUl/D++SvVDLGn4uo725ldm
         lwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751440703; x=1752045503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iy7H0ZYdtRQl4Da1EmIyCQoTQO+pkft5mRGtpqqpozY=;
        b=KuuiEMkKhY1Gtnli+2TOrhSjB4KRTaM5EgRR/s7kXKvxB1fa/W0ijWQOLBFvQNhdFp
         SQ1LAlAJrC9NuY+ugYHJr5t6aHbDetq5P51mru3a05rQ1MtYWKbt8QSVnD1BGd68A3EF
         zpnMm6ACBTsVoH//8QlMohQssyO6DKZD158QwATg3eKV7pJKr0KEXR+AgZhnHkoyXn+W
         gQBG24Qhf7lFN/69Bidn3gKBzFt9mtK/xbKQNrPyYAJtkj1lw4a6qkheeml2pAUVqYLI
         HVwT/RYsv0Bab/aGSSqQUDhtcki/FmaSUb5cqaaN73iQ0Wyj2vgNKgD+UVh8BkicdH4I
         1anQ==
X-Gm-Message-State: AOJu0Yx2gjvqkKYN2Y6tLBZpjcryV+kb8/fHbtlqt1KJ+OLUuSjDrb8m
	augPWE5eHyk5birD0maafqyAIwZbvEfCxWt2/OnHEdayLPp3m1kGND4awt7pHHIiZQ==
X-Gm-Gg: ASbGncuHPKvOofvZwPep63PQ5k/Z4Q7zN1ScPQvvq+V/elCIuDa50sv23R3yGwzTnQn
	XHinlWguhFXnThALdEc0klwo0ufgoW4Gv+P0mw+5h9LkcpAt9/Kf1aqYOlGR+I3v/xvabm5udnP
	Qz0Pd4dVOam8X25hFfKCBGMW7NXjc7H1VFdmAhuLUSQTu0xuZzsAPZK/TLh9EIvNUFVswNVgC9h
	JwZRGMt025+rD9OMFheqe9FgsRaTrbuh9jU2Jy5LPj+xWIeVVTtS+m9gJ+mv4TijGtDkpV08iie
	CunWnWheb2EQRASr/7/7p+/ka18JR/cXGWJFscwxqIP6wMnIomZa0T0oO1egf54dNYsHbLYfjmN
	J0qiyeKSqy47AYw==
X-Google-Smtp-Source: AGHT+IE5DDFwnOS+TS6nh6JDekWlDH5rRkElgvGq44BHTX8yC75m31ZsyttD3EQg+A7nEynyZrTyHA==
X-Received: by 2002:a17:902:ea0e:b0:236:363e:55d with SMTP id d9443c01a7336-23c6e591826mr29083665ad.28.1751440702829;
        Wed, 02 Jul 2025 00:18:22 -0700 (PDT)
Received: from xps.dhcp.asu.edu (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f0babsm129995935ad.58.2025.07.02.00.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:18:22 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	security@kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] net/sched: sch_qfq: Fix null-deref in agg_dequeue
Date: Wed,  2 Jul 2025 00:18:18 -0700
Message-ID: <20250702071818.10161-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025070231-unrented-sulfate-8b6f@gregkh>
References: <2025070231-unrented-sulfate-8b6f@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent a potential crash in agg_dequeue (net/sched/sch_qfq.c)
when cl->qdisc->ops->peek(cl->qdisc) returns NULL, we check the return
value before using it, similar to the existing approach in sch_hfsc.c.

To avoid code duplication, the following changes are made:

1. Moved qdisc_warn_nonwc to include/net/sch_generic.h and removed
its EXPORT_SYMBOL declaration, since all users include the header.

2. Moved qdisc_peek_len from net/sched/sch_hfsc.c to
include/net/sch_generic.h so that sch_qfq can reuse it.

3. Applied qdisc_peek_len in agg_dequeue to avoid crashing.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 include/net/sch_generic.h | 24 ++++++++++++++++++++++++
 net/sched/sch_api.c       | 10 ----------
 net/sched/sch_hfsc.c      | 16 ----------------
 net/sched/sch_qfq.c       |  2 +-
 4 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 3287988a6a98..d090aaa59ef2 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -814,11 +814,35 @@ static inline bool qdisc_tx_is_noop(const struct net_device *dev)
 	return true;
 }
 
+static inline void qdisc_warn_nonwc(const char *txt, struct Qdisc *qdisc)
+{
+	if (!(qdisc->flags & TCQ_F_WARN_NONWC)) {
+		pr_warn("%s: %s qdisc %X: is non-work-conserving?\n",
+			txt, qdisc->ops->id, qdisc->handle >> 16);
+		qdisc->flags |= TCQ_F_WARN_NONWC;
+	}
+}
+
 static inline unsigned int qdisc_pkt_len(const struct sk_buff *skb)
 {
 	return qdisc_skb_cb(skb)->pkt_len;
 }
 
+static inline unsigned int qdisc_peek_len(struct Qdisc *sch)
+{
+	struct sk_buff *skb;
+	unsigned int len;
+
+	skb = sch->ops->peek(sch);
+	if (unlikely(skb == NULL)) {
+		qdisc_warn_nonwc("qdisc_peek_len", sch);
+		return 0;
+	}
+	len = qdisc_pkt_len(skb);
+
+	return len;
+}
+
 /* additional qdisc xmit flags (NET_XMIT_MASK in linux/netdevice.h) */
 enum net_xmit_qdisc_t {
 	__NET_XMIT_STOLEN = 0x00010000,
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index df89790c459a..6518fdc63dc2 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -594,16 +594,6 @@ void __qdisc_calculate_pkt_len(struct sk_buff *skb,
 	qdisc_skb_cb(skb)->pkt_len = pkt_len;
 }
 
-void qdisc_warn_nonwc(const char *txt, struct Qdisc *qdisc)
-{
-	if (!(qdisc->flags & TCQ_F_WARN_NONWC)) {
-		pr_warn("%s: %s qdisc %X: is non-work-conserving?\n",
-			txt, qdisc->ops->id, qdisc->handle >> 16);
-		qdisc->flags |= TCQ_F_WARN_NONWC;
-	}
-}
-EXPORT_SYMBOL(qdisc_warn_nonwc);
-
 static enum hrtimer_restart qdisc_watchdog(struct hrtimer *timer)
 {
 	struct qdisc_watchdog *wd = container_of(timer, struct qdisc_watchdog,
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index afcb83d469ff..751b1e2c35b3 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -835,22 +835,6 @@ update_vf(struct hfsc_class *cl, unsigned int len, u64 cur_time)
 	}
 }
 
-static unsigned int
-qdisc_peek_len(struct Qdisc *sch)
-{
-	struct sk_buff *skb;
-	unsigned int len;
-
-	skb = sch->ops->peek(sch);
-	if (unlikely(skb == NULL)) {
-		qdisc_warn_nonwc("qdisc_peek_len", sch);
-		return 0;
-	}
-	len = qdisc_pkt_len(skb);
-
-	return len;
-}
-
 static void
 hfsc_adjust_levels(struct hfsc_class *cl)
 {
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 5e557b960bde..e0cefa21ce21 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -992,7 +992,7 @@ static struct sk_buff *agg_dequeue(struct qfq_aggregate *agg,
 
 	if (cl->qdisc->q.qlen == 0) /* no more packets, remove from list */
 		list_del_init(&cl->alist);
-	else if (cl->deficit < qdisc_pkt_len(cl->qdisc->ops->peek(cl->qdisc))) {
+	else if (cl->deficit < qdisc_peek_len(cl->qdisc)) {
 		cl->deficit += agg->lmax;
 		list_move_tail(&cl->alist, &agg->active);
 	}
-- 
2.43.0


