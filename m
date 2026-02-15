Return-Path: <netdev+bounces-258811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Z7RVH/ZWkmmjtAEAu9opvQ
	(envelope-from <netdev+bounces-258811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 00:29:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9CA14013D
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 00:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C805230039A4
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 23:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B0B2D7DC6;
	Sun, 15 Feb 2026 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFudlKws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1A23C503
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 23:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198191; cv=none; b=EJOu2faXsTgVnVa67rKJA6w0aiDVKIOhC6ROKnb2rDa4dUj41XPPtu/NlQeqPotw3ZNPRcECZjFOkVaY3zdorMSN0cvYgG4hZ2H6Rv6Py1MDzp9tuKpPokWI3JXeU8jUvTBThwaZcuG1xQwghvXib049dDD5VhKGN8dPUmcKITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198191; c=relaxed/simple;
	bh=i3UDGp7KLBf04ttQhlWkE6uwpc1xbbanHk4UuNzhxHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHFVoh1iYX7hU4kZRN7ii9YpGaWXokoYBCmB79spgkJJXFHF2WXxmF54DvoTfZJHGLlp9QWLFU+Fh4horPjnZd5B8nwcxkUuJ6FqSMvGP1l4/fRMjVN84HvtE/cOQE893LUOHfQo2JVkMwvOFPariy5IiqukPkVQNUg6bZtHeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFudlKws; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so25726505e9.2
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 15:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771198188; x=1771802988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1g7mVgGvWTK8/EIC7VR9y/94JjU5VubItvDLMki6i5A=;
        b=NFudlKwsOfaCd552NIQjvhRB98fIuYhnJkmThdvq21VzVpE2Eh66rpHtW+wicnoPwz
         2o8gHdpAqVTlenmWnZ7afHdflpcMC3HFNI1UpqxEU1OW1fyDR44P58gwcHi6RS8JKGTr
         UiS49sSaR11atc9nD00CFmwqhUFfuvKGLXZ6SLPx0DDaiUPNV2PL/A9A9XDVNKb/1I+g
         ESn4+A1UyFKpTIgv5BaBQ/sw8PMmvNoK425q9VMDlYwrQVGYdaSbB/0brY4mJSmXCut3
         j69qcmJlU5TdGAokmXe6Bz6jKzLwLzlZFqroUYFolg0ipkNzOa3pKOzrqTISM+GYMDrX
         7lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771198188; x=1771802988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1g7mVgGvWTK8/EIC7VR9y/94JjU5VubItvDLMki6i5A=;
        b=BnZeIdngi22Tnoo/nkOE5y3RXiPI2r46kR4x0Dk+W1M+BvEj4k5SNLlJp5RT8T9Zri
         zMyDLyVpa9kzN9a06x9UiD2m+vQ4SjFBifU1E7FdnnIgFzHTNb/FJ8UdY28/PsouCoG7
         mj1FeROZ5AsYf/EkkJNDzAm5NEsHwHgK3T6S/Y32M+jmGmzIZDh/BclgnlFKKpKz0Q60
         xnED8jZIcxLeUTb6GcyLBIbhgqqvg1LxKKu/423aM+ha8le3emOwCx6lq4OX8RSyX77P
         eSkXHlUuSErqdoANhw8UCgIhAnqmJMV4Q060rqyF10sqoBceYxcfWHWDroz5BiFQ6VXQ
         oZDg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0QWzePRZmc4nv9qOHZiQQwIskWmwGK6i2+FbP/YVU+oM8PjUtcB8iN4/dKQYY/qBBx/LB8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz96x2J07WvlHkzNErO/cQcmj2KfEqJaw5Lz3NVUyRbhiK3qhiW
	Wj2ppi5Ven3ZwI4WJ5Q1gTy10LoXFPLbrv+/cfKQSLYl4XOAezd7z4lF
X-Gm-Gg: AZuq6aK4auabMJTddLaJIafZEJf2hDTclefVEIFODRnKvgsh08m/LBQTz55CZ6y0UM3
	3Hu8BvT/F7Tx9kfMp0OlRxEhF91GM0iKnkuGXrFYw/9yQYlgX1rs2P/RQIU/9O/7r8/wSO3ksPH
	tr6M+acad7OVgbJJ1Nsrp7ylZakb2U9cX2cArr7dR+cWbVXTagcjZW5egHwu6gl5p0VFggzCDOE
	zlWHNWuwEm5tO8oqnY7GmUpzudLSpyDf7Nc8+InELYGIFmnylrw3x8CBTPNT+AUQbae3NRH3tWF
	AiQ1KabECeGWqdThZhvnxK/+JNlco5kX+H0wbsMin0toN5tSp3RscZprn4cvOlzbvBq6G0yH9gt
	r47BlQMDy9FT+vV8+iK1fChg10+iIAUbEfJvqBBxBNfx4ygq7tDzVq9yIcITKBCZuIs414Td2qG
	cciF4SV71pDFdTVRYhMZ6pgcKZi5ud/gqBwbs+bvMdfjSVZVccWNahJpJB8U+XiAYkZhWzuda4Z
	nn1TYjlxt/PeQVb4w3YSTZWtXyRSWxIVA06x1Ac
X-Received: by 2002:a05:600c:83c6:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-48373a15fa3mr143130425e9.8.1771198187814;
        Sun, 15 Feb 2026 15:29:47 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a44d2asm70403195e9.30.2026.02.15.15.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 15:29:47 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] io_uring/zcrx: declare some constants for query
Date: Sun, 15 Feb 2026 23:29:39 +0000
Message-ID: <b68ff77af39422191154413f262717a08dfc9e04.1771197486.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258811-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D9CA14013D
X-Rspamd-Action: no action

Add constants for zcrx features and supported registration flags that
can be reused by the query code. I was going to add another registration
flag, and this patch helps to avoid duplication and keeps changes
specific to zcrx files.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

Depends on the patch that added zcrx features

 io_uring/query.c | 4 ++--
 io_uring/zcrx.c  | 4 +++-
 io_uring/zcrx.h  | 3 +++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/io_uring/query.c b/io_uring/query.c
index 63cc30c9803d..c1704d088374 100644
--- a/io_uring/query.c
+++ b/io_uring/query.c
@@ -34,12 +34,12 @@ static ssize_t io_query_zcrx(union io_query_data *data)
 {
 	struct io_uring_query_zcrx *e = &data->zcrx;
 
-	e->register_flags = ZCRX_REG_IMPORT;
+	e->register_flags = ZCRX_SUPPORTED_REG_FLAGS;
 	e->area_flags = IORING_ZCRX_AREA_DMABUF;
 	e->nr_ctrl_opcodes = __ZCRX_CTRL_LAST;
 	e->rq_hdr_size = sizeof(struct io_uring);
 	e->rq_hdr_alignment = L1_CACHE_BYTES;
-	e->features = ZCRX_FEATURE_RX_PAGE_SIZE;
+	e->features = ZCRX_FEATURES;
 	e->__resv2 = 0;
 	return sizeof(*e);
 }
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 28150c6578e3..60e12eb5d4f3 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -774,11 +774,13 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		return -EFAULT;
 	if (!mem_is_zero(&reg.__resv, sizeof(reg.__resv)) || reg.zcrx_id)
 		return -EINVAL;
+	if (reg.flags & ~ZCRX_SUPPORTED_REG_FLAGS)
+		return -EINVAL;
 	if (reg.flags & ZCRX_REG_IMPORT)
 		return import_zcrx(ctx, arg, &reg);
 	if (copy_from_user(&rd, u64_to_user_ptr(reg.region_ptr), sizeof(rd)))
 		return -EFAULT;
-	if (reg.if_rxq == -1 || !reg.rq_entries || reg.flags)
+	if (reg.if_rxq == -1 || !reg.rq_entries)
 		return -EINVAL;
 	if (reg.rq_entries > IO_RQ_MAX_ENTRIES) {
 		if (!(ctx->flags & IORING_SETUP_CLAMP))
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 32ab95b2cb81..0ddcf0ee8861 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -8,6 +8,9 @@
 #include <net/page_pool/types.h>
 #include <net/net_trackers.h>
 
+#define ZCRX_SUPPORTED_REG_FLAGS	(ZCRX_REG_IMPORT)
+#define ZCRX_FEATURES			(ZCRX_FEATURE_RX_PAGE_SIZE)
+
 struct io_zcrx_mem {
 	unsigned long			size;
 	bool				is_dmabuf;
-- 
2.52.0


