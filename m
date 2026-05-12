Return-Path: <netdev+bounces-287064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJMjNT4BA2rdzQEAu9opvQ
	(envelope-from <netdev+bounces-287064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:30:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D40951E92D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BAF33075354
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A46F349CDC;
	Tue, 12 May 2026 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOd91ZfH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA8349CC5
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581530; cv=none; b=eSwvAdy7mEPmWSe/FpFuBtryxnqvvhXSF8/0YhvhVv7SS9JAyML57VDmxCJph8oG53iyT0U3x3tAL48EUAacUVKXAOfPNnXs00sMulCi0hqR0lNeoA27ShJSLKH67bnHpFy/lgW2OH5MxchzU9kOUMT5Qu9MNoRk/x8EDz7UAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581530; c=relaxed/simple;
	bh=MVvZtomfTexV5ncnjedGVPdgok9JWHiWLqTZdg1w6Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNLdRpSENyGL/8Dc7YGsWLptybFPlCU7t8PC36k6H3sHj5cq9g37gnSIJQvRkk71aJ9dI9EHDBDJd/atVtn2o5cQTab/R+UtFgDa596AArR5BZyn80q+xP/SeL9nvnTrLOynGFaPiCMhJBSrIBKmE1N6dsnFk4frPp8S3O/ecu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOd91ZfH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso45635515e9.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778581527; x=1779186327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B6WVDSvzkov4nVWGmDCtwnrdal1/p/x4+gM4REImlY=;
        b=pOd91ZfHnWxY49nrm6w1OrJEHWhwkBBiSWV4vumfyGyTCyTYZz7525MHfnD8/AUIb+
         6caBV1400zjJVbGwJKo8eygJpeGOWSywin0qBApBSeqtD6auRE4w+scXI6IeTjD+wl3K
         FCVVKFtJHGiBh2JRWzRlOCaMAdPmyGEl52JflRcI1d/qrm3T5OoUdQ5Zw/by3US+7M/D
         CrsUCqpnmr4DvTuqQDlu59cgKClsTIvkFoCanUrDiLCd1qCAB1YJchJEzlQfbey1jdcZ
         DN/hZGHg3zgBa2pZSn9k9AF/Bj4ghkaxRmIWoB8m1k1OoOJg1hjQQhrWDDJip5eNkiqG
         Xbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581527; x=1779186327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+B6WVDSvzkov4nVWGmDCtwnrdal1/p/x4+gM4REImlY=;
        b=j9nzuFXve+4UHuzLgLOSCmnAvp9mtyZMX7uZUVXKfo8/Ck8XnNiAkcOl69eymJf3lN
         zQ7tzRNJ+Pa7dtL37jkBsWh7ObBmWjy6Kb9zqQudlqKk8yOswrlAPZr1wCUO4unQlnL3
         Gt6LqeU0ZF9+f6aVNEI9aGhNh6nw+5HR2x3DCjgmbe7gboW0ojy4ZPZR/N6kusRhQZlg
         7Z+ALhZZ0BFZRwsrP2NiRUrLQbNCWn4pCNTYbX2k5+Uw95xS++viBs34kNLwG/H867aW
         VcrW1NmA6X0s1ldLDi8ygRm5Bj75yontXLPauskx2mQ5rKdVlznSG1gprL+dw75mP6Go
         3gSw==
X-Forwarded-Encrypted: i=1; AFNElJ8DXhEIDNE8yQXr7QnUYyW6Rwu+67aox5/XtP3VZrWcptpzUXabCOdspTGhYNSRZVbKzitzefk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz66s3oLD9pVu78HCMhzxkzOe2mHMhZYhsddBLGhuwG9E13c6Qm
	AcYthtWYaxsqsX7ktwhr2kZOLrGJjgOhf8wecpUsmmCCoSXZbYy4DPcrxxiV7Q==
X-Gm-Gg: Acq92OFIw+FxWR4QuLBBXBcAhm3i+CJELGIdqhV+BUvSVYKL56SKFiQf8ft62M4hU8k
	QNxerWKFf77zZI9lTw4638D/v2Vi6So9PS5G9YTAO2FFvLS+4qgTEVxt0oDBdcj64kpH69J56YA
	xEd8DMx316dcBGcuSMTEBFL3eg+wXSQ2b+82i2ys/FCugMHsTntTU7g+GRJuIqzkazpxlKyvZzW
	V9xVjD717G5G1/d74mOjHRDAPC3eXw+rqbxz9gydBfgFIGVo59RVwVWEXjM7c3crJEUimLgw+VA
	YNEZr1AHP0SwryhxDAqg3Lpflg5wl6x4P8F2V5Q16hvsYLSAuUJpMd36z1KPmpWnfwRPPQey2SY
	0TpnPO+o9myJUv205jZ2WtTl41Nkbj57bE593iMnJt04UABWo7oSBAVu77a4vQWqELUAKI458+f
	gGYhvkWCYnNSkrQzFFzhYGfZItZNcmOXpZ5c57/14Odba2zMWgv+gYpMJqH3mPKxzp3Tky9QWIe
	G5w2LpVcg==
X-Received: by 2002:a05:600c:3510:b0:48a:53ea:1408 with SMTP id 5b1f17b1804b1-48e8fe50a02mr31244805e9.8.1778581527111;
        Tue, 12 May 2026 03:25:27 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:8c90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e9052c9fesm74352255e9.1.2026.05.12.03.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:25:26 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [RFC 2/6] io_uring/zcrx: move freelist lock to struct zcrx
Date: Tue, 12 May 2026 11:25:02 +0100
Message-ID: <9f3931933b6470c14548e480f0a7ee92b0671483.1778581283.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778581283.git.asml.silence@gmail.com>
References: <cover.1778581283.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D40951E92D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-287064-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

freelist_lock, which protects slow path allocations, is currently stored
in struct io_zcrx_area. Once we add support for multiple queues, we'll
need a lock in the zcrx ctx, move it there.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 14 +++++++-------
 io_uring/zcrx.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 3478040f2197..563bef1e724b 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -511,7 +511,6 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	/* we're only supporting one area per ifq for now */
 	area->area_id = 0;
 	area_reg->rq_area_token = (u64)area->area_id << IORING_ZCRX_AREA_SHIFT;
-	spin_lock_init(&area->freelist_lock);
 
 	ret = io_zcrx_append_area(ifq, area);
 	if (!ret)
@@ -532,6 +531,7 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 
 	ifq->if_rxq = -1;
 	spin_lock_init(&ifq->rq.lock);
+	spin_lock_init(&ifq->alloc_lock);
 	mutex_init(&ifq->pp_lock);
 	refcount_set(&ifq->refs, 1);
 	refcount_set(&ifq->user_refs, 1);
@@ -603,8 +603,9 @@ static void io_put_zcrx_ifq(struct io_zcrx_ifq *ifq)
 static void io_zcrx_return_niov_freelist(struct net_iov *niov)
 {
 	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
+	struct io_zcrx_ifq *ifq = area->ifq;
 
-	guard(spinlock_bh)(&area->freelist_lock);
+	guard(spinlock_bh)(&ifq->alloc_lock);
 	if (WARN_ON_ONCE(area->free_count >= area->nia.num_niovs))
 		return;
 	area->freelist[area->free_count++] = net_iov_idx(niov);
@@ -614,7 +615,7 @@ static struct net_iov *zcrx_get_free_niov(struct io_zcrx_area *area)
 {
 	unsigned niov_idx;
 
-	lockdep_assert_held(&area->freelist_lock);
+	lockdep_assert_held(&area->ifq->alloc_lock);
 
 	if (unlikely(!area->free_count))
 		return NULL;
@@ -1082,7 +1083,7 @@ static unsigned io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *if
 	struct io_zcrx_area *area = ifq->area;
 	unsigned allocated = 0;
 
-	guard(spinlock_bh)(&area->freelist_lock);
+	guard(spinlock_bh)(&ifq->alloc_lock);
 
 	for (allocated = 0; allocated < to_alloc; allocated++) {
 		struct net_iov *niov = zcrx_get_free_niov(area);
@@ -1317,14 +1318,13 @@ static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
 
 static struct net_iov *io_alloc_fallback_niov(struct io_zcrx_ifq *ifq)
 {
-	struct io_zcrx_area *area = ifq->area;
 	struct net_iov *niov = NULL;
 
 	if (!ifq->kern_readable)
 		return NULL;
 
-	scoped_guard(spinlock_bh, &area->freelist_lock)
-		niov = zcrx_get_free_niov(area);
+	scoped_guard(spinlock_bh, &ifq->alloc_lock)
+		niov = zcrx_get_free_niov(ifq->area);
 
 	if (niov)
 		page_pool_fragment_netmem(net_iov_to_netmem(niov), 1);
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 75e0a4e6ef6e..687ca7c9f45b 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -34,7 +34,6 @@ struct io_zcrx_area {
 	u16			area_id;
 
 	/* freelist */
-	spinlock_t		freelist_lock ____cacheline_aligned_in_smp;
 	u32			free_count;
 	u32			*freelist;
 
@@ -57,6 +56,7 @@ struct io_zcrx_ifq {
 	bool				kern_readable;
 
 	struct zcrx_rq			rq ____cacheline_aligned_in_smp;
+	spinlock_t			alloc_lock ____cacheline_aligned_in_smp;
 
 	u32				if_rxq;
 	struct device			*dev;
-- 
2.53.0


