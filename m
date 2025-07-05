Return-Path: <netdev+bounces-204351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE50AFA200
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 23:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58CA1BC519F
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 21:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296CE238C36;
	Sat,  5 Jul 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="J8zJZb5S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560231A8F84
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751750516; cv=none; b=Z/2DlsQxYdLscFaOOl0x3ALT5F+7us8li1s+HDQ4HE7pm0OK+1TGMnPxh/LyLAOOjO9kb38J7UN4vyv6/0HN8qEkvtZR6Xr9TNJuDAe8HYlAMfyrW0GRSKVxaAAvvVH7dBlgSkdqqB/A/DfQdTCEsqPPtEz3z+BWXzq/rwJ3iqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751750516; c=relaxed/simple;
	bh=8o/c15nPIY82+gv7yhpCChqOkAhkA++Y2hQIHnc6g0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oqk0zlk0v9EOl1juDzG74aGEXIatMn7aGCyNG0alaiWWd+IjQrMXEJMQn6KsdHBkkroBsiiNgVrrfgRQYeovCGE08nD6TlKzY6ulR85N2NrpJfypK1ielXs1V3e6qHfE2Q54U+LlC6gWkObZ19/5htegX7qxL7NBqXYksSGvch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=J8zJZb5S; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7490acf57b9so1410091b3a.2
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1751750513; x=1752355313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR0C4H0HXHHSS1yijg+WjzbiwmNnRZlwtPTBCJyoIwQ=;
        b=J8zJZb5So1S067Cqk4DBhA68fAX6xrThtH3tZPBhfcz5OLdlSA/Mq+rcsphykgglln
         34ThqJpXTvpzNZS7P+ZKrzu1nKmVuEr4hxEujQH2fneA21a0I4ENLm18G4dkuj1vqi18
         nDFTwCxkC07GhLbNHcFfR/3kjByPkiNQ9CuSamgmyrFsxvxja77+oGMUaz930Kgojn3o
         ZTFLxwhnXGbkHOfMsHpmFkwVkhoiwt5y3SUeOiotvQDYMKNH81GOZ00BLRZRsyZ0MpYc
         fXY7mGu7CAvqodmNyFkid7jniCjMLQwctoybRwzENEuqnrzTUkbizLVCK7f1qiebgal+
         aINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751750513; x=1752355313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR0C4H0HXHHSS1yijg+WjzbiwmNnRZlwtPTBCJyoIwQ=;
        b=hefYQYjCsEPB++64h8DS29SWAjeoRnq1XVlIZsSq8+5LMKVPDNnKJBJW922YL+f5EB
         6RfRnz5LTQJMXpeTqKbPgVsosnGVVJZFDSXr4XIsfHi7dUYeH7qn5mFEC9V2xeRacl8K
         RumW/u0LpSL/XaJXoI+iPW6OfTchwFvQfz0WrXWPx5l3s3WcE0eBg8Nx+ffQd+79WQhA
         nx6ZsuHtF1irJnWeRGMfV4aDQSnS4DL5Inr+w9bibM7W/52+OymdmSeKzsRlhvCaS9Nj
         Vyn9zpZkHmlM+H+0B9o2Jzrih70YjzL6Qc6XSFBhG/whs29eGxJNoEgD17yliN95gUK2
         cGig==
X-Gm-Message-State: AOJu0YxQbXeSdZRgUMXNaugMFilAJlBayXq3GF6bJ/M1srjuxDX1+sHE
	P6927w0Gb/Vx2lLKmRXzy+NXSugFAfMsc112lyIh9xuAdOjIPE6JPh+oYvtE/AuSug==
X-Gm-Gg: ASbGncsuICyoPzzd19PkHDCOJT9rgWT3ky+9zLIfiW/kMXqJrioZv/fTkafM2ZXywE5
	8wxenWB8c+F0fggt6qLofbsra3jF+QGS0Ze+Jg/UQtPA9TDJQBZJ3Qt5czSjY4ZjN3jHajVgM7u
	uTAXiqWxe+pNbAVdGV/Rr8xXjBSEB7dde6x6Ecj/xNsHup1XiO7IZ/YcKFzBpwwR26fsqLC1AzF
	e2YUamaUkUypGJW81SmsHsBTJbJdCbSY9ln6oR0hXrVWCf3ex0h1vmWzZRFdtkwiqyvydCpem2X
	Jo9GUxKFpa6NQYByDOaNBDTQZmeA/H0yXptTE0ax62Nh4fvuLluioyUOPS13IrcOpbRrCQx4Due
	w9aurmSX4NfCw
X-Google-Smtp-Source: AGHT+IF/zOLWqm+m+485KYevTmbWLE05jVe4GYybA40/sn76s7HsLPoJQNmD/oBJ1OD1v9iYek1klg==
X-Received: by 2002:a05:6a20:d492:b0:220:33e9:15da with SMTP id adf61e73a8af0-225b754f754mr14990894637.2.1751750513549;
        Sat, 05 Jul 2025 14:21:53 -0700 (PDT)
Received: from xps.tailc0aff1.ts.net (129-219-8-64.nat.asu.edu. [129.219.8.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38f060165csm4839089a12.10.2025.07.05.14.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 14:21:53 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: xiyou.wangcong@gmail.com
Cc: netdev@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	security@kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v3] net/sched: sch_qfq: Fix null-deref in agg_dequeue
Date: Sat,  5 Jul 2025 14:21:43 -0700
Message-ID: <20250705212143.3982664-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aGdceCwEZ/cwzKq9@pop-os.localdomain>
References: <aGdceCwEZ/cwzKq9@pop-os.localdomain>
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

1. Changed qdisc_warn_nonwc(include/net/pkt_sched.h) into a static
inline function.

2. Moved qdisc_peek_len from net/sched/sch_hfsc.c to
include/net/pkt_sched.h so that sch_qfq can reuse it.

3. Applied qdisc_peek_len in agg_dequeue to avoid crashing.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v3: 
- Move qdisc_warn_nonwc and qdisc_peek_len to pkt_sched.h

v2:
- Use real name in signed-off-by

v1:
- Move qdisc_warn_nonwc to include/net/sch_generic.h
- Move qdisc_peek_len from net/sched/sch_hfsc.c to include/net/sch_generic.h
- Replace  cl->qdisc->ops->peek() with qdisc_peek_len() in sch_qfq.c

 include/net/pkt_sched.h | 25 ++++++++++++++++++++++++-
 net/sched/sch_api.c     | 10 ----------
 net/sched/sch_hfsc.c    | 16 ----------------
 net/sched/sch_qfq.c     |  2 +-
 4 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 15960564e0c3..4d72d24b1f33 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -112,7 +112,6 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 					struct netlink_ext_ack *extack);
 void qdisc_put_rtab(struct qdisc_rate_table *tab);
 void qdisc_put_stab(struct qdisc_size_table *tab);
-void qdisc_warn_nonwc(const char *txt, struct Qdisc *qdisc);
 bool sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
 		     struct net_device *dev, struct netdev_queue *txq,
 		     spinlock_t *root_lock, bool validate);
@@ -306,4 +305,28 @@ static inline bool tc_qdisc_stats_dump(struct Qdisc *sch,
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
 #endif
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


