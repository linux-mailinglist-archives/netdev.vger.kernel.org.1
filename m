Return-Path: <netdev+bounces-203238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE15AF0E07
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B2C37A73A7
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437DF23956E;
	Wed,  2 Jul 2025 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="oW/BZRC/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF523816C
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445009; cv=none; b=ojpcnZ8uq7L1GgLb2q/D6MhxVYsbVeGWMpgCdFk0gDwRExSv/8Cem1XVUefElhQF426H5yik3ldTyDKy9ZgUlPOuecihe/yW705S95oWFQn68UwfRUbrSsJR4zU8UviB2zFbuI2dfGK9ugZgF9Na+qC2E4Gd7uhnCLqIxq2+UlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445009; c=relaxed/simple;
	bh=8bb0nq0AIaLs2F3ZkWbLEgmEJURtKRQG8iHMG2lnqno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/cARuIGoYZ44dMEXYtnHuC9Lco5/JTP5k/VoVey2kLOoiM7G1wRDm8Fh+voKcyZ+b1nTg1XzD8VjunhXMrDjne3oEXIN/b+hq473LRq0gLgS9pd1OVwW/oe+x88ZgsWU1XT7rYxPWQQOAgJi+LMShyU0TdQO0Y6dR9YZbTrJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=oW/BZRC/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747c2cc3419so6183424b3a.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1751445007; x=1752049807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUpE6DOpz680h4MelNVO8U/j5aSVNsfr9vve44Z2hGk=;
        b=oW/BZRC/EJ3AanPMmbPeoS7+9RP8IRRZR0R+/QAkJtSalyPsPdd09fYoGbwOkxrdlv
         NbR8C3z1V5a8SN59kUCqCcrIZLG8q2q5m8epw4jvZklgMr5h6P7Y/K6RaW+HTt1v0IKV
         /ZWyPMkjskqI+GBsKcnaHYRa4uTR2UDtdv6DIXDUtbPxggxO93xdwLmBCH6Uw8XBhTbg
         KdhegDc0oXoi+sffXbWy8wDABGwd4Uc7QzbLu0TIPf1A8VS2gWi8hLfzY1S7TXwdkEQN
         uKRCy1gihkWPQr7vH1rxs09CSDM1o/BhoR2AuTXVCzuWSpCnyJDDnjnoOvboe0uHPD1d
         qjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751445007; x=1752049807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUpE6DOpz680h4MelNVO8U/j5aSVNsfr9vve44Z2hGk=;
        b=gIs9QrJOFWDoqF7tKcVMpptT/0+f/wQJLZ26qBakb74z3TMmc+n7PUikCryMGzW0WC
         FCcxtdzL5p3wHxqv+CgxPq59USlERkTOnMmaq/bzjf0H+aUhGbjkUnnPQ3wrc/b5fKh5
         3Dk7EhxoWOSOCNe49N5W930/Euy6jOzT7Z2oqnUnxM2FsDuK5vrYz6uXBp/hPuvRDWGq
         +bYjUThBj5S+2uU6ulbg9MJqR2JEDPOJGuy2qdTKxj5AZQ18tcbbxVUi+oAkabhUsDu9
         +rYkcbE5yhmoiJhGa8Sy3liKqzS0IF/miqZonTH2xxynono+tTXhJfqfbx/7nn5qynHa
         Vt6w==
X-Gm-Message-State: AOJu0YyjvyhtZhgXdPrHurBr2kiSUngEwv5uiuFPKfl0TpzIu0JGB3V5
	JI1rrUN7jVFo+82wrSKXkCH8+6hpho3/swNsD8Ov1DDirFk69tRwA7qivy/LgU3GzQ==
X-Gm-Gg: ASbGncuoXBr7sQ6kOma2wT0HnOomD9vC2eghDM5SQFjj7U6ZBBf+3iLz7QBTEGdu3iW
	ZFSBBcZ7JTpjsdAqJrX+jdL4tQ6wGjdgOfWoOx7gWjBqftVQ202y0HvN6hhyQZfUGdUAQ/BKJwG
	SviNIDJg5Kb1pJI0dblI5CiP8rnJrLuzkByrLsZySwS9IkFjUL1EvVcAz/sdI6qYl2jvwOM8dwb
	mPvfyTNwVsJWetGpYQNq4GkI30kqbh857IyTpErVGFheU+9WtVJ7+l/Nx3QxFHvzdLCE3GPMTeg
	G4l1CKPiXLt6XafW/7GAOx+X9yrdTOaj2go7AGGPcnLh4GNs7sN5MKaf0nkEHGYPs9Lpz29hEZH
	SsQgrnuP1FCrEhA==
X-Google-Smtp-Source: AGHT+IHV3YpmKLnOXFrKayicou9S3pto2l4O+AKJehVWzQbRg2YXgvtqMBBXNI/juOx/c8/0VnLa1w==
X-Received: by 2002:a05:6a20:4304:b0:1ee:e20f:f14e with SMTP id adf61e73a8af0-222d7f30909mr3570914637.38.1751445006721;
        Wed, 02 Jul 2025 01:30:06 -0700 (PDT)
Received: from xps.dhcp.asu.edu (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541d233sm14434945b3a.61.2025.07.02.01.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:30:05 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	security@kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v2] net/sched: sch_qfq: Fix null-deref in agg_dequeue
Date: Wed,  2 Jul 2025 01:30:01 -0700
Message-ID: <20250702083001.10803-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025070255-overdress-relight-21bf@gregkh>
References: <2025070255-overdress-relight-21bf@gregkh>
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
v2:
- Use real name in signed-off-by
v1:
- Move qdisc_warn_nonwc to include/net/sch_generic.h
- Move qdisc_peek_len from net/sched/sch_hfsc.c to include/net/sch_generic.h
- Replace  cl->qdisc->ops->peek() with qdisc_peek_len() in sch_qfq.c

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


