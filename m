Return-Path: <netdev+bounces-259003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIBBARJKlGn0BwIAu9opvQ
	(envelope-from <netdev+bounces-259003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:59:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D6714B148
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D294303323C
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29BB32C94A;
	Tue, 17 Feb 2026 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqggczfk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DEF32BF32
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771325944; cv=none; b=ScfX69YzPL5oouGYBZijqHGW66mip+rZtIPmJv0pupNH0md0pIWiGkuWIQnQAPhQMMZ7+y77MEF+XfPpCif9h6V7Tmjwv9LT9m2WypCiHEXbaIga4fMbP8Goj9+zwVyC37zZae+E6KW5U26hCnDjE7dC4weXcY3cXebvOqNim/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771325944; c=relaxed/simple;
	bh=vKrjZiwP7d/2tsuWlOGmo5etWthFEDBquJaxbzRI8IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1dS7De0Uh7dBNSdLOVZfMgsRnK/y9IT052RvtjZVgc8IDv+wy3R5zCSeRYFqDNtyOA5SM4zAIuszFUoZvnv9sCdyoTK1LP6D7SWYzUMXnE98RIUqVXpqoNx8t02q+cYDGmQk+jkaq+NiFbMytQwNnsr5MS10vSFha5SXgWmWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqggczfk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4834826e555so41115715e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 02:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771325942; x=1771930742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHpJTLX1FI9TF8Lz9wpjsap/XYPEHymSqSKaFnhhx70=;
        b=nqggczfkySilVmb0iP+U5e5qf/TQNz2fOG+A61h3t9mDOXZsWb2w7BFQEL91G5IIV2
         W0wuzaIaJ+ibOKSd9eNBRVt/ipp/r3Efq8X1uroK1zPEHllpwc8Rpm7omMnJg1alNHqu
         +zegbNzVYzkfkQbT8t6hGWe2ky/rE3jwRCQB/NrdKSzGANEVB+vwHC2cdgCEJq9hIOn3
         g9wzxJI5rCMRToRTuro/hq7etZAR4BN36t/fnIn8AaGeA8qljLkI+W0PUZvC9IYehaVC
         d8USuCiFN87DjmCsHlPYLYgFPM+OCXa6+Vik9bN8pfRpff/8ZYLS9YqYQ+y3jXG07bD/
         H5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771325942; x=1771930742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UHpJTLX1FI9TF8Lz9wpjsap/XYPEHymSqSKaFnhhx70=;
        b=p1mCGSMgzOHYVUfvhor6RPampyCU2NAAvjnmBvQnrNDKLZowuJo8B40/w+7usy0USN
         4r1iRQFswI4HNoNAiyfiREhOiStT2jryl6AXU9fimqLc1UsZ1R7cneJ8SYjP5jSN5stt
         8QQ9Yt0S5mQTI/SHcMUJ4ZjZJAQGmgQIeZvcOr9QVsjDW2UlZXPm4PBZI3mUvhSTMpce
         N6RcNGY4MHwS3/uzTLFjC+FrF+35VxKx+0adSsYw3Hc8FTNi7Eoekn0Y7T2JW+1VicBP
         u3M2T0d45jX4yWW5uTKCFNn8FEWYRrEka9ejE7YqsECFevl6//nbrKGvd25YgrBV7xUT
         iXRA==
X-Forwarded-Encrypted: i=1; AJvYcCXGUlVKvcyiFJ5T4liu5QOLTDw+faweaz/bHi1MIgu7z0kshomHeBoFMzmcKxud53XP6Lop+Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX8MZERzl3Td8WbqJ8QqcVwstpB5Yq6mXyCUz+VHPhpkSCctOW
	pE5sPaSmCII2EhExGlWj9cZ3B0dwVC5Z8MJ5lyyEQK6nWEphR6CdaRfk2gS2fA==
X-Gm-Gg: AZuq6aIHA98PNGblo0vEjuLa0QFzWWjysm8ns4UyopO0fbnMiU0TTrPaiwZsSFocGO/
	fxIOZO9oUWjQ8FMJrMNFTX1SYnIVL1GaYMkpFmoqY9mtzyKvTRfufnqOakI7WJpUdZxLADlF+DN
	osszfVqrF3SwSMceQ0meK6Ej9r3XmD3yaWms98o5JYlnCgSM0o0wDOAGcDiQgQKhJ1ZQFZREqEW
	3swSyzTwhvqMCZg4DWeLAL5sDHj9aWCoXi1kakuiBUPwIhw8OqllQZpWvKAZZLF3tanTeMBpaKa
	tv+91dgGon21Vitk7JSoSYhMZlPu0ZGaKvKcVVO+2VSQWuYnYeeWLnit9rjd3G/ZIvLhpGGm1FW
	8k4OvxikE+BqDXbPeccuqlYrs/xprNNi7YTQeENbhH85/Q40Kv0L0PyYqG/quD/R4kyhgrzJQnR
	v/Jtmhw/bKu7ORGIiMVQlX62Sw9jSc9hZ7eP7y5enGXeGoZGy3n0RF+cgYtCbQ2FsHVrDwxhQUK
	Hhxq52DmYOxoT7I/Ay3h3wabIOVCw==
X-Received: by 2002:a05:600c:1c19:b0:483:5310:dc67 with SMTP id 5b1f17b1804b1-48379be817cmr203753345e9.20.1771325941861;
        Tue, 17 Feb 2026 02:59:01 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a78c89sm327759395e9.5.2026.02.17.02.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 02:59:01 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH review-only 2/4] io_uring/zcrx: always dma map in advance
Date: Tue, 17 Feb 2026 10:58:53 +0000
Message-ID: <0afb4dfc31f93e5754110d3bafa0f11b6eab8b92.1771325198.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771325198.git.asml.silence@gmail.com>
References: <cover.1771325198.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259003-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B8D6714B148
X-Rspamd-Action: no action

zcrx was originally establisihing dma mappings at a late stage when it
was being bound to a page pool. Dma-buf couldn't work this way, so it's
initialised during area creation.

It's messy having them do it at different spots, just move everything to
the area creation time.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 117d578224f5..290db098cfe7 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -194,6 +194,7 @@ static int io_import_umem(struct io_zcrx_ifq *ifq,
 {
 	struct page **pages;
 	int nr_pages, ret;
+	bool mapped = false;
 
 	if (area_reg->dmabuf_fd)
 		return -EINVAL;
@@ -210,6 +211,12 @@ static int io_import_umem(struct io_zcrx_ifq *ifq,
 	if (ret)
 		goto out_err;
 
+	ret = dma_map_sgtable(ifq->dev, &mem->page_sg_table,
+			      DMA_FROM_DEVICE, IO_DMA_ATTR);
+	if (ret < 0)
+		goto out_err;
+	mapped = true;
+
 	mem->account_pages = io_count_account_pages(pages, nr_pages);
 	ret = io_account_mem(ifq->user, ifq->mm_account, mem->account_pages);
 	if (ret < 0) {
@@ -223,6 +230,9 @@ static int io_import_umem(struct io_zcrx_ifq *ifq,
 	mem->size = area_reg->len;
 	return ret;
 out_err:
+	if (mapped)
+		dma_unmap_sgtable(ifq->dev, &mem->page_sg_table,
+				  DMA_FROM_DEVICE, IO_DMA_ATTR);
 	sg_free_table(&mem->page_sg_table);
 	unpin_user_pages(pages, nr_pages);
 	kvfree(pages);
@@ -288,30 +298,6 @@ static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
 	}
 }
 
-static int io_zcrx_map_area(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
-{
-	int ret;
-
-	guard(mutex)(&ifq->pp_lock);
-	if (area->is_mapped)
-		return 0;
-
-	if (!area->mem.is_dmabuf) {
-		ret = dma_map_sgtable(ifq->dev, &area->mem.page_sg_table,
-				      DMA_FROM_DEVICE, IO_DMA_ATTR);
-		if (ret < 0)
-			return ret;
-	}
-
-	ret = io_populate_area_dma(ifq, area);
-	if (ret && !area->mem.is_dmabuf)
-		dma_unmap_sgtable(ifq->dev, &area->mem.page_sg_table,
-				  DMA_FROM_DEVICE, IO_DMA_ATTR);
-	if (ret == 0)
-		area->is_mapped = true;
-	return ret;
-}
-
 static void io_zcrx_sync_for_device(struct page_pool *pool,
 				    struct net_iov *niov)
 {
@@ -460,6 +446,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	ret = io_import_area(ifq, &area->mem, area_reg);
 	if (ret)
 		goto err;
+	area->is_mapped = true;
 
 	if (buf_size_shift > io_area_max_shift(&area->mem)) {
 		ret = -ERANGE;
@@ -495,6 +482,10 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 		niov->type = NET_IOV_IOURING;
 	}
 
+	ret = io_populate_area_dma(ifq, area);
+	if (ret)
+		goto err;
+
 	area->free_count = nr_iovs;
 	/* we're only supporting one area per ifq for now */
 	area->area_id = 0;
@@ -1036,7 +1027,6 @@ static bool io_pp_zc_release_netmem(struct page_pool *pp, netmem_ref netmem)
 static int io_pp_zc_init(struct page_pool *pp)
 {
 	struct io_zcrx_ifq *ifq = io_pp_to_ifq(pp);
-	int ret;
 
 	if (WARN_ON_ONCE(!ifq))
 		return -EINVAL;
@@ -1049,10 +1039,6 @@ static int io_pp_zc_init(struct page_pool *pp)
 	if (pp->p.dma_dir != DMA_FROM_DEVICE)
 		return -EOPNOTSUPP;
 
-	ret = io_zcrx_map_area(ifq, ifq->area);
-	if (ret)
-		return ret;
-
 	refcount_inc(&ifq->refs);
 	return 0;
 }
-- 
2.52.0


