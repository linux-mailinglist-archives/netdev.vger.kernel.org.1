Return-Path: <netdev+bounces-289429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJLVEIlODGpIeQUAu9opvQ
	(envelope-from <netdev+bounces-289429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:50:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C257E06F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0307430D7378
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597244ADD87;
	Tue, 19 May 2026 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwpP3gNq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9C49552D
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191097; cv=none; b=D8D0K0x7zERkXTQGr6PHoAHlxJ+MMBSw7hDCzu6EufUt0XRgWI9sF+pi6ISlsTsEqmHDfxPrHwy/ShUGTrxvLtR6caaT2wJvrj72SRa7AzPZHAafKdjhkOHdZsYWbMFIKDS4gXGUkSOblkSrz3cHXga6/T2JdWMt2F1Z31MZ6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191097; c=relaxed/simple;
	bh=JwIlwqb1EAG3IEbLEIWlu5V+R/juG4sXNHVX8+zi3R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsS38WtLj28dGRaStHsIKfqaOve4m8JdWTOsgr3p2QZrfRNrUWIVZLaJ0UF6LEYS0BVJCtlaz2i7G+bJx2t/1y6h6tZOPd6qOJpQ8LujFVrLnFotRiByfQ6a+aTUfqy/2/1E4D7L5Q8Gj9KD7MMiV4eqyyIB+CUe60Ueyk0aACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwpP3gNq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so40935635e9.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779191091; x=1779795891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=od+5CwlkM9INOxHkGcHjhrH2reIsnDlmIScrN09w4LM=;
        b=JwpP3gNqhteY5AVzpckRHVJDPIIk0XuglkGYyIfm3A1TyWkvCvKw1rAPbDybLZXxfN
         ZD0/Js76rZfYzuVSGhTgEgwvTOxQYs+OWIFhibY23J2o11GZTmu0gn1ETEa1lTm063Ur
         s0OkPCCm5ibfeEs3xhP9PRSaU2VPcceyBfvYq3NEdzoxRuZc9HJJQosThNWuDAsSBhFN
         Na9q3FRo8DEhgEkjDDPCBQDSLCugHxezZKeXquO90vIB35xR3KB0ctGOPflp9WIg3INd
         ZcPqeABPE6KuvHL3gE3Z9A+HY0d98MqFSkv417Flpm0jUe8X3YTPfKjUE9J3ckU6kt3R
         PAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191091; x=1779795891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=od+5CwlkM9INOxHkGcHjhrH2reIsnDlmIScrN09w4LM=;
        b=KO0EPU/WtPpdoc7EXvr8WRyno74M6LCSZgdTDl8R7LBITzrraMK2sMI+reR8Bc+/eL
         xv9YPnbZaPqEaeIhYg7UT+Chvq6vOt3Q+Sc03PFgIgybbeYUFQvMhW3D8JSyEXJnJx27
         jEFDX3ZXk25Jhv3gLINC96Jx855k7G67xze6h77Jz3csxleApsP22MPYXccsoG30WpgL
         6l/4YZvq/DWSm9riDSHUZLFjQkjZy8JRwG5lCWiZlrHhWUSL30EaQCqO/yqyqxE9mRBM
         dZvOdvZaZRSwDhoW8w5QZKWZY8H5IT3y11pI3n5COeSEOhwCLVJqy2JhVVlBvUO87bTd
         MLIg==
X-Forwarded-Encrypted: i=1; AFNElJ/MSiRlcDTLBWwv0aFJv2Ce8mqY96mdIJ+chrA/pPwA+i7rn24gr0AmqJYzezBHFyt04OdLkog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOTv4AjqBDwlBRSA/ksYYzZLZlMGdK954HG5tiKfkAyVGHIH7P
	1n9ZzqRCvFR66wLbNQiSGI/d331pjBWZKO/LLW2c9zhdVDR9Eu5if4KS
X-Gm-Gg: Acq92OERUSzyWz9HaygQV8fjVDBCQidq7OP0BLGgq3f40kxS1H4RpRKKr2sDdHB8CmP
	u4UmdsZrgzZ8FyhOk9rS6UweZNuTG8Mat9DhSSQoVlHe63xI/FQ/bH55cEDlQBGvjU7/VUJY/4I
	vSC6wOGIEnUzcJDLiu6zg05wgOUQomYkyN5dOxV1ujsTuUUIKt8OKi/OiUDehpSxeTaAC0swQF0
	nkNHDE3BUqoSEhU0ryrfhmANOV9WmJaeo5LeW1rhYKzWpGXAHST98ApNN8r1DTqAWmNTES6q4Da
	fm1jMsEUp/T4YsP95prH/fPim9IHP/E9Ix9mi30l7/9gG2/PKLo8WwM3CTrAwJWmwb/PJUTDyVu
	dgdz/t4zZcQnBRrSd6l134QkuP/0Ln2c4+VOFr6L/aXpu4FO0YLfJZScP75Ig+iXMIMQ495C9gv
	A55OozjhgFZzLWGXYHHUvxv199nnJx3uZPPL5Tb0FJyJuYYX+H/f43aAZ2VzLhq4q+s8FnEUequ
	BqkI6kgBi9MunZ7gTvqf6glVFpOiA==
X-Received: by 2002:a05:600c:34ca:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-48fe60ee4c7mr307116515e9.14.1779191090630;
        Tue, 19 May 2026 04:44:50 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694f2csm323392445e9.4.2026.05.19.04.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:44:50 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH 8/8] io_uring/zcrx: add shared-memory notification statistics
Date: Tue, 19 May 2026 12:44:34 +0100
Message-ID: <f6af5a21015efea4b733b9d77aba22c637788fe4.1779189667.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779189667.git.asml.silence@gmail.com>
References: <cover.1779189667.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289429-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E23C257E06F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Clément Léger <cleger@meta.com>

Add support for an optional stats struct embedded in the refill queue
region, allowing userspace to monitor copy-fallback in real-time.

Userspace queries the stats struct size and alignment via
IO_URING_QUERY_ZCRX_NOTIF (notif_stats_size / notif_stats_alignment),
then provides a stats_offset in zcrx_notification_desc pointing to a
location within the refill queue region.

The kernel updates the stats counters in-place on every copy-fallback
event.

Signed-off-by: Clément Léger <cleger@meta.com>
[pavel: rename io_uring_zcrx_notif_stats]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/uapi/linux/io_uring/query.h | 12 +++++++
 include/uapi/linux/io_uring/zcrx.h  | 15 ++++++--
 io_uring/query.c                    | 16 +++++++++
 io_uring/zcrx.c                     | 54 +++++++++++++++++++++++++++--
 io_uring/zcrx.h                     |  1 +
 5 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/io_uring/query.h b/include/uapi/linux/io_uring/query.h
index 95500759cc13..1a68eca7c6b4 100644
--- a/include/uapi/linux/io_uring/query.h
+++ b/include/uapi/linux/io_uring/query.h
@@ -23,6 +23,7 @@ enum {
 	IO_URING_QUERY_OPCODES			= 0,
 	IO_URING_QUERY_ZCRX			= 1,
 	IO_URING_QUERY_SCQ			= 2,
+	IO_URING_QUERY_ZCRX_NOTIF		= 3,
 
 	__IO_URING_QUERY_MAX,
 };
@@ -62,6 +63,17 @@ struct io_uring_query_zcrx {
 	__u64 __resv2;
 };
 
+struct io_uring_query_zcrx_notif {
+	/* Bitmask of supported ZCRX_NOTIF_* flags */
+	__u32 notif_flags;
+	/* Size of io_uring_zcrx_notif_stats */
+	__u32 notif_stats_size;
+	/* Required alignment for the stats struct within the region (ie stats_offset) */
+	__u32 notif_stats_off_alignment;
+	__u32 __resv1;
+	__u64 __resv2[4];
+};
+
 struct io_uring_query_scq {
 	/* The SQ/CQ rings header size */
 	__u64 hdr_size;
diff --git a/include/uapi/linux/io_uring/zcrx.h b/include/uapi/linux/io_uring/zcrx.h
index 3f7b72b09878..15c05c45ce36 100644
--- a/include/uapi/linux/io_uring/zcrx.h
+++ b/include/uapi/linux/io_uring/zcrx.h
@@ -75,11 +75,22 @@ enum zcrx_notification_type {
 	__ZCRX_NOTIF_TYPE_LAST,
 };
 
+enum zcrx_notification_desc_flags {
+	/* If set, stats_offset holds a valid offset to a notif_stats struct */
+	ZCRX_NOTIF_DESC_FLAG_STATS = 1 << 0,
+};
+
+struct zcrx_notif_stats {
+	__u64	copy_count;	/* cumulative copy-fallback CQEs */
+	__u64	copy_bytes;	/* cumulative bytes copied */
+};
+
 struct zcrx_notification_desc {
 	__u64	user_data;
 	__u32	type_mask;
-	__u32	__resv1;
-	__u64	__resv2[10];
+	__u32	flags; /* see enum zcrx_notification_desc_flags */
+	__u64	stats_offset; /* offset from the beginning of refill ring region for stats */
+	__u64	__resv2[9];
 };
 
 /*
diff --git a/io_uring/query.c b/io_uring/query.c
index c1704d088374..d529d94aa8f4 100644
--- a/io_uring/query.c
+++ b/io_uring/query.c
@@ -9,6 +9,7 @@
 union io_query_data {
 	struct io_uring_query_opcode opcodes;
 	struct io_uring_query_zcrx zcrx;
+	struct io_uring_query_zcrx_notif zcrx_notif;
 	struct io_uring_query_scq scq;
 };
 
@@ -44,6 +45,18 @@ static ssize_t io_query_zcrx(union io_query_data *data)
 	return sizeof(*e);
 }
 
+static ssize_t io_query_zcrx_notif(union io_query_data *data)
+{
+	struct io_uring_query_zcrx_notif *e = &data->zcrx_notif;
+
+	e->notif_flags = ZCRX_NOTIF_TYPE_MASK;
+	e->notif_stats_size = sizeof(struct zcrx_notif_stats);
+	e->notif_stats_off_alignment = __alignof__(struct zcrx_notif_stats);
+	e->__resv1 = 0;
+	memset(&e->__resv2, 0, sizeof(e->__resv2));
+	return sizeof(*e);
+}
+
 static ssize_t io_query_scq(union io_query_data *data)
 {
 	struct io_uring_query_scq *e = &data->scq;
@@ -83,6 +96,9 @@ static int io_handle_query_entry(union io_query_data *data, void __user *uhdr,
 	case IO_URING_QUERY_ZCRX:
 		ret = io_query_zcrx(data);
 		break;
+	case IO_URING_QUERY_ZCRX_NOTIF:
+		ret = io_query_zcrx_notif(data);
+		break;
 	case IO_URING_QUERY_SCQ:
 		ret = io_query_scq(data);
 		break;
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 1e7c305da0d0..6d078beaf0ca 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -415,6 +415,7 @@ static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 	io_free_region(ifq->user, &ifq->rq_region);
 	ifq->rq.ring = IO_URING_PTR_POISON;
 	ifq->rq.rqes = IO_URING_PTR_POISON;
+	ifq->notif_stats = IO_URING_PTR_POISON;
 }
 
 static void io_zcrx_free_area(struct io_zcrx_ifq *ifq,
@@ -854,6 +855,33 @@ static int zcrx_register_netdev(struct io_zcrx_ifq *ifq,
 	return ret;
 }
 
+static int zcrx_validate_notif_stats(struct io_zcrx_ifq *ifq,
+				     const struct io_uring_zcrx_ifq_reg *reg,
+				     const struct zcrx_notification_desc *notif)
+{
+	size_t stats_off = notif->stats_offset;
+	size_t used, end;
+
+	used = reg->offsets.rqes +
+	       sizeof(struct io_uring_zcrx_rqe) * reg->rq_entries;
+
+	if (!IS_ALIGNED(stats_off, __alignof__(struct zcrx_notif_stats)))
+		return -EINVAL;
+	if (stats_off < used)
+		return -ERANGE;
+	if (check_add_overflow(stats_off,
+			       sizeof(struct zcrx_notif_stats),
+			       &end))
+		return -ERANGE;
+	if (end > io_region_size(&ifq->rq_region))
+		return -ERANGE;
+
+	ifq->notif_stats = io_region_get_ptr(&ifq->rq_region) + stats_off;
+	memset(ifq->notif_stats, 0, sizeof(*ifq->notif_stats));
+
+	return 0;
+}
+
 int io_register_zcrx(struct io_ring_ctx *ctx,
 		     struct io_uring_zcrx_ifq_reg __user *arg)
 {
@@ -907,7 +935,13 @@ int io_register_zcrx(struct io_ring_ctx *ctx,
 		return -EFAULT;
 	if (notif.type_mask & ~ZCRX_NOTIF_TYPE_MASK)
 		return -EINVAL;
-	if (notif.__resv1 || !mem_is_zero(&notif.__resv2, sizeof(notif.__resv2)))
+	if (notif.flags & ~ZCRX_NOTIF_DESC_FLAG_STATS)
+		return -EINVAL;
+	if (!(notif.flags & ZCRX_NOTIF_DESC_FLAG_STATS)) {
+		if (notif.stats_offset)
+			return -EINVAL;
+	}
+	if (!mem_is_zero(&notif.__resv2, sizeof(notif.__resv2)))
 		return -EINVAL;
 
 	ifq = io_zcrx_ifq_alloc(ctx);
@@ -938,6 +972,12 @@ int io_register_zcrx(struct io_ring_ctx *ctx,
 	if (ret)
 		goto err;
 
+	if (notif.flags & ZCRX_NOTIF_DESC_FLAG_STATS) {
+		ret = zcrx_validate_notif_stats(ifq, &reg, &notif);
+		if (ret)
+			goto err;
+	}
+
 	ifq->kern_readable = !(area.flags & IORING_ZCRX_AREA_DMABUF);
 
 	if (!(reg.flags & ZCRX_REG_NODEV)) {
@@ -1153,6 +1193,11 @@ static void zcrx_notif_tw(struct io_tw_req tw_req, io_tw_token_t tw)
 	kmem_cache_free(req_cachep, req);
 }
 
+static void zcrx_stat_add(__u64 *p, s64 v)
+{
+	WRITE_ONCE(*p, READ_ONCE(*p) + v);
+}
+
 static void zcrx_send_notif(struct io_zcrx_ifq *ifq, unsigned type)
 {
 	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN | __GFP_ZERO;
@@ -1536,8 +1581,13 @@ static int io_zcrx_copy_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 	int ret;
 
 	ret = io_zcrx_copy_chunk(req, ifq, page, off + skb_frag_off(frag), len);
-	if (ret > 0)
+	if (ret > 0) {
+		if (ifq->notif_stats) {
+			zcrx_stat_add(&ifq->notif_stats->copy_count, 1);
+			zcrx_stat_add(&ifq->notif_stats->copy_bytes, ret);
+		}
 		zcrx_send_notif(ifq, ZCRX_NOTIF_COPY);
+	}
 
 	return ret;
 }
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 54d91b580eaf..fa00900e479e 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -80,6 +80,7 @@ struct io_zcrx_ifq {
 	u32				allowed_notif_mask;
 	u32				fired_notifs;
 	u64				notif_data;
+	struct zcrx_notif_stats		*notif_stats;
 };
 
 #if defined(CONFIG_IO_URING_ZCRX)
-- 
2.54.0


