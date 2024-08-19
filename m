Return-Path: <netdev+bounces-119828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554C895728C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 19:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9D41F23889
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE05B188CAF;
	Mon, 19 Aug 2024 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="mSSIx/59"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C4176AB9
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090286; cv=none; b=sL/CI9GeEd73nydWOPalt5UKQtadiIb7RA44lJP6NJZgZCP+kTPRKX23DLDN6kOmaKuOJDKp/3wMRs0wX0PT2g5stlzGciDRNXWJ4OHo7t6nwp+xklrZb0LSz94KnmPkGsHO349ZB8krG2F37tgTjco6m/8ezmniy+GPCcm6Kp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090286; c=relaxed/simple;
	bh=I74Nsd/hv/7Z1KBPIywZQhxoLRuZY2jSJNhcyK2ch8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLqz12t/nJS89AbfObeQOTMdoh7wr+qw207Lct52+Uqm8MtgoeOnVy1oQD+OJzGd3IKW4LKKZVHpl1DXLmq1xoxfkOosFT8blK/di0rp22nTJ+0nMD8szoKVdyKGivwIIeydnWbKg20yuBRZib32kIxVKt1pUSInPqTBuRMR8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=mSSIx/59; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3d58d6e08so3082330a91.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1724090283; x=1724695083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fj/JRnUiS2ccvYLpltbwZnQSUIfTnOEAJgrq5esozr0=;
        b=mSSIx/598POFlBCVGOMvkDcO4hFH/qqTIQZ9RBqX+vygWbn+HPVV0oDhcYz34zFWeQ
         pY7FvkRY8dBY8mbRIqBiszOZerQbc92S/aIJRDBzzlsfPNLpa4HFwoVf+n03mIL1pwOs
         2/lp9g/eZNlS09/H+gy+xxs+acwd+l7L3e/wfnuj9t6JludxO9s8I6HpSS+lVX8Z4UEo
         8QT3LbYX00SaP5zcBSUV2neoGDzZxK6nbtnILDMsgwt4A9u52w/huxF9RfeZV+UFdTTq
         2DQDCrvoW+Hpm/Zuy3HNV8bvZizHjgHa9l04hNADXVlYRnu9iaqIe4mMdYlto0/2Njgz
         3JCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724090283; x=1724695083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fj/JRnUiS2ccvYLpltbwZnQSUIfTnOEAJgrq5esozr0=;
        b=TkTlW8021fdAO2hzXG6zKl6ha9FGisiEi59gNk/KC6Oho+nR2pszYbb8/I0jVuEl+Q
         1Ww3zaZiH2Ms1Iqqw6YTtZJtIvFE9PrksKpevqjIgqfo71bS548qkP0kdmFaVuue+UZt
         yYrSsb0KmcA8mBUWZTT4im5R8vJv1DAqmdkBn/QRMNOMxkbnChwhrnly2tTsXg9WfmhL
         R6JkYcO703JgKWSHIvQUcJ9ja3hGemLVakLy7lIK6coenkhYufTRjWKxWXSzlwSsbvA+
         S4MDPkHxS1yUO4D/uV5DbpOdB1iK40N9qVR+ysGN0vO6h4Jo8shQbL/nB3EY+9dYTKn1
         0cJA==
X-Gm-Message-State: AOJu0YyZLMzM81+83I1fobWNpPNXiL8TPawzTbNA6dngGzvNr0zo4ueu
	AObq34ut4s3CpBMrSJLTGeA3rKzvRPxLg4hvYO4MsWWHkQGmBE89fyznDPxABK9+9wmVVRYl0q4
	q+x8=
X-Google-Smtp-Source: AGHT+IFgWVEx6cbuYxIpkjpE7FNl342NnFixb6XDIp1xkcfwI2POSDxplq/p6uHN0KhZi8o+IkJkOg==
X-Received: by 2002:a17:90a:db86:b0:2ca:5ec8:576c with SMTP id 98e67ed59e1d1-2d3dfda7e42mr12432690a91.5.1724090283352;
        Mon, 19 Aug 2024 10:58:03 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3c0b87dc8sm9635504a91.38.2024.08.19.10.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:58:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Budimir Markovic <markovicbudimir@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sheng Lan <lansheng@huawei.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] netem: fix return value if duplicate enqueue fails
Date: Mon, 19 Aug 2024 10:56:45 -0700
Message-ID: <20240819175753.5151-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a bug in netem_enqueue() introduced by
commit 5845f706388a ("net: netem: fix skb length BUG_ON in __skb_to_sgvec")
that can lead to a use-after-free.

This commit made netem_enqueue() always return NET_XMIT_SUCCESS
when a packet is duplicated, which can cause the parent qdisc's q.qlen to be
mistakenly incremented. When this happens qlen_notify() may be skipped on the
parent during destruction, leaving a dangling pointer for some classful qdiscs
like DRR.

There are two ways for the bug happen:

- If the duplicated packet is dropped by rootq->enqueue() and then the original
  packet is also dropped.
- If rootq->enqueue() sends the duplicated packet to a different qdisc and the
  original packet is dropped.

In both cases NET_XMIT_SUCCESS is returned even though no packets are enqueued
at the netem qdisc.

The fix is to defer the enqueue of the duplicate packet until after the
original packet has been guaranteed to return NET_XMIT_SUCCESS.

Fixes: 5845f706388a ("net: netem: fix skb length BUG_ON in __skb_to_sgvec")
Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 47 ++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index edc72962ae63..0f8d581438c3 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -446,12 +446,10 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct netem_sched_data *q = qdisc_priv(sch);
 	/* We don't fill cb now as skb_unshare() may invalidate it */
 	struct netem_skb_cb *cb;
-	struct sk_buff *skb2;
+	struct sk_buff *skb2 = NULL;
 	struct sk_buff *segs = NULL;
 	unsigned int prev_len = qdisc_pkt_len(skb);
 	int count = 1;
-	int rc = NET_XMIT_SUCCESS;
-	int rc_drop = NET_XMIT_DROP;
 
 	/* Do not fool qdisc_drop_all() */
 	skb->prev = NULL;
@@ -480,19 +478,11 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		skb_orphan_partial(skb);
 
 	/*
-	 * If we need to duplicate packet, then re-insert at top of the
-	 * qdisc tree, since parent queuer expects that only one
-	 * skb will be queued.
+	 * If we need to duplicate packet, then clone it before
+	 * original is modified.
 	 */
-	if (count > 1 && (skb2 = skb_clone(skb, GFP_ATOMIC)) != NULL) {
-		struct Qdisc *rootq = qdisc_root_bh(sch);
-		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
-
-		q->duplicate = 0;
-		rootq->enqueue(skb2, rootq, to_free);
-		q->duplicate = dupsave;
-		rc_drop = NET_XMIT_SUCCESS;
-	}
+	if (count > 1)
+		skb2 = skb_clone(skb, GFP_ATOMIC);
 
 	/*
 	 * Randomized packet corruption.
@@ -504,7 +494,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (skb_is_gso(skb)) {
 			skb = netem_segment(skb, sch, to_free);
 			if (!skb)
-				return rc_drop;
+				goto finish_segs;
+
 			segs = skb->next;
 			skb_mark_not_on_list(skb);
 			qdisc_skb_cb(skb)->pkt_len = skb->len;
@@ -530,7 +521,24 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
-		return rc_drop;
+		if (skb2)
+			__qdisc_drop(skb2, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	/*
+	 * If doing duplication then re-insert at top of the
+	 * qdisc tree, since parent queuer expects that only one
+	 * skb will be queued.
+	 */
+	if (skb2) {
+		struct Qdisc *rootq = qdisc_root_bh(sch);
+		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
+
+		q->duplicate = 0;
+		rootq->enqueue(skb2, rootq, to_free);
+		q->duplicate = dupsave;
+		skb2 = NULL;
 	}
 
 	qdisc_qstats_backlog_inc(sch, skb);
@@ -601,9 +609,12 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 finish_segs:
+	if (skb2)
+		__qdisc_drop(skb2, to_free);
+
 	if (segs) {
 		unsigned int len, last_len;
-		int nb;
+		int rc, nb;
 
 		len = skb ? skb->len : 0;
 		nb = skb ? 1 : 0;
-- 
2.43.0


