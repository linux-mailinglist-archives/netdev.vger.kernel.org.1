Return-Path: <netdev+bounces-203149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F83AAF0990
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1E7189DD46
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB017B4EC;
	Wed,  2 Jul 2025 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="hUm1L0xp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4087184
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 04:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751428967; cv=none; b=UhaAo24TtfrHs/yGmUOMjaief3vOF8gb9K+qykFSl4bKALaAjTzl8W+rslWra4umDnngS3DkMq6jz2rTtcZrEoxvzKTfSSwrVb06TIrnlJtMy+qxobw8SWpLPJkLWZrsIgiS99VcCDKhcFwdQkeHyUIzOdHbblJz6jkk/L8+udE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751428967; c=relaxed/simple;
	bh=xQYF6reLsCoeUvgugdO7OZAzQjGHiVoMMRNtkdSm0+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eY0VRTmi3e5LZIBJAYWHXKbBnwtL8zb4zBXZ74pWOwAktmeG+uFU743AqdF52I3UHs8a1WxVuFXsFvGSgbbg1v6tTh5nRc2API3dbHM9FpW9dH98tqJF4rVw/bJoV4ZFGCujDGUFdG/+NpJUdByr6iwGojk+m68AZWBo1Pmh1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=hUm1L0xp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234bfe37cccso77090085ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 21:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1751428965; x=1752033765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu7QW7Mt+rZRYyJB6sfb5OsLtmdb/o2H4lhHBG4p5Es=;
        b=hUm1L0xpZ9+UNNDBOLcM8QvDzRVB/eceZtzmm4rQedDuEy8gIxP5lWnKuXhbXQqn7P
         J8yLeuApY4LczcqT2arSeztSxnaCOs0myz9JpUOnM5+YkkMUN5+M+x6uocisj50+xfTM
         gUdLRKDdpH7JStQkWacLtrTA78dzTeqbDAX1rgkbA79Gtx9caG9Jk9yXqZXyL+bjjDGV
         9HsXn2T4aln++KPl3Dd9GFwn7BmQcs4AmMjBeXMCAqZRa0U/HHtZYSLAMYSYupb2FAnr
         v0f94M4fX/Aa0vnb+DqOZnR3mVR65JOIU4uhn/G5sTSgclc4Vtr8GSFiSgWREOLjVcsx
         Drjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751428965; x=1752033765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zu7QW7Mt+rZRYyJB6sfb5OsLtmdb/o2H4lhHBG4p5Es=;
        b=bjfnWBZNxLnlrdvz0CTNLytMnXyXPYYUbjImSZzsA/lmlEjkabTj9ilu+UHMGbuLTB
         +JgvMOwOi5d63NxbZ0ckOHxrcuift8CnN5EuQ0fquqnM7j/8iPRdcBUkZgvB56ZF8EIm
         4PR/ySvJ1diMnBu/F9k6sAZ/xLVzu4l/fDN9GcFpzn2ou5c5wwiDTKZH/c9loRrls1P1
         FZdYbSokc0HdZSlQpyiOzviUECbIENk66X6m4j/uyscdDzTs5uvfj5CBme1FRGXJvQWw
         By0+oR1c7aF2ghAMhCNcGXf5YhSDK4HyW/zyfWh3sjLQ2FyRpMB6CbTJSVbAZDHc1iRI
         +m2A==
X-Gm-Message-State: AOJu0YxfFlx6zgQ0zI5ebvmaCSA6iKuP2q4+lUqyeJKMHASmpFlEwjuQ
	C6tB0MPWAj0oovVSrkO1UR2/1/jYWsoTL0Er0NWDrhEogvHg/sFFqF/JiWsZ1f09Hg==
X-Gm-Gg: ASbGnct1PLDADfjlUdQoLIcmztPq80xbSTq0Mj+PSDC7943LdTHEDJX7o+mUtUj8PUJ
	1QeUJRfuK0jaQF69aCJdt83dXdou6w+MsD8d+IDtyHL2GlsKiEq1GCwQReSEkvUVpNh05KXK7St
	DdnVrkdQcaXORefSFxDLmwhDRTSoUEwdQRkWTN7PPG74COjSetRwtiJQJgcKh5Di2M6qC2+Z1lC
	1aS9Hke7+atfFCu0+tKSG9xP3e/olH44/SFyU8sGKgzzPBRemE3QD6hfwGtal/4QDcDj2M5f6jr
	7IE2WWt7oTOaMjUmk7Jz01cjmZXlUtcz0VbGaltIYR5A6a1/h9jh6H73f+qY2pJO6lg/44M5aqH
	hUtBJsZfp6VUCQg==
X-Google-Smtp-Source: AGHT+IEiD/2VMo7fr8rnw5DvZ3AYOy/5NVv8oa/vbEZjERwMziqNUP7huNXLPD9WF7NvllqPMCGC7w==
X-Received: by 2002:a17:903:28f:b0:224:1eab:97b2 with SMTP id d9443c01a7336-23c6e642b86mr23981085ad.53.1751428965198;
        Tue, 01 Jul 2025 21:02:45 -0700 (PDT)
Received: from xps.dhcp.asu.edu (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bb29sm124964955ad.137.2025.07.01.21.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 21:02:44 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: xiyou.wangcong@gmail.com
Cc: netdev@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	security@kernel.org,
	n132 <xmei5@asu.edu>
Subject: [PATCH] net/sched: sch_qfq: Fix null-deref in agg_dequeue
Date: Tue,  1 Jul 2025 21:02:28 -0700
Message-ID: <20250702040228.8002-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAM_iQpWkQd_1BdP+4cA2uQ5HP2wrb5dh8ZUgGWY7v3enLq_7Fg@mail.gmail.com>
References: <CAM_iQpWkQd_1BdP+4cA2uQ5HP2wrb5dh8ZUgGWY7v3enLq_7Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: n132 <xmei5@asu.edu>

To prevent a potential crash in agg_dequeue (net/sched/sch_qfq.c)
when cl->qdisc->ops->peek(cl->qdisc) returns NULL, we check the return
value before using it, similar to the existing approach in sch_hfsc.c.

To avoid code duplication, the following changes are made:

1. Moved qdisc_warn_nonwc to include/net/sch_generic.h and removed
its EXPORT_SYMBOL declaration, since all users include the header.

2. Moved qdisc_peek_len from net/sched/sch_hfsc.c to
include/net/sch_generic.h so that sch_qfq can reuse it.

3. Applied qdisc_peek_len in agg_dequeue to avoid crashing.

Signed-off-by: n132 <xmei5@asu.edu>
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


