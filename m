Return-Path: <netdev+bounces-223590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BD4B599F2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C646F7A2155
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8321A34A315;
	Tue, 16 Sep 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuW94JQ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0597346A0D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032834; cv=none; b=eyPOysfngrTVh4kUBifO3sGYCAjhJbgAZRIfwxCHqrX/jOlmkKHocxwJDaGZy/PZB0sSiK6zRToCG6RViDU/G2+aSRMozeXr87A2NU46W6eypvvlogoxJs1FwBK+EIhAimwgtATSyCJGxjsapcU9Vao36iGldR11MODGsa5Tfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032834; c=relaxed/simple;
	bh=OQFjokGn3WaqjsssPWzJqKKp55as+qTWDAvWlatEDD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfJe3Fxky/R4zWlJ++Ekky8FK9QR8DI1kZ0crdoYW0M3Z0P3St7nfTz1T6VDjqb2p2O6WjYDflzgPN55+u25ykiLfStU9Nlci39EZumTlNYPpJFOaF2ULSm6HxMJEfdGX3zGFayuaBmB100NcO6wW3fljyZp96jDBbmWmLCtE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuW94JQ7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3eb0a50a60aso1651798f8f.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032831; x=1758637631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRfVer2fUIipwB8cmncBOeklcNg3ZFTmdULVyysrYj4=;
        b=LuW94JQ7Z/1OSzHGgLNFQ5iqRxLSBXOhlvCHzP7NdsmMs0h79obBOJd3gmxbWaUB0W
         Y357wqKtne+MYVlIrk/4H7fDiCL9RZlvrVI0puPjla9AHEnALMcCvexzWyw+HGnUGD/G
         7eFthl9On/k3RRRqT0M3bGUBxh+5pcodN3S2svYXANc0l0ciYiSIo7BmMbn/XfZhLYpZ
         elahkmiF6wHlqndTEpcKKWPHw6j6AExf5kfrYHnUnR+7eEI4dPYR2gs9py6J/AneCXuR
         S9XM6R8ddC+n224VgIw11DMQQLAfF366wHwiyFJLRzmP5fyLhYj5IRP+teZVR4lyzC9e
         1juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032831; x=1758637631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRfVer2fUIipwB8cmncBOeklcNg3ZFTmdULVyysrYj4=;
        b=HRXBQlvwtC2HYFwp2wi5l1i1QJaRU8egCZtlpvzZgKX0MLAGo4SHgC5kxlfNXGkhco
         8V9q2ninAjZsRE1fqPPrrHTsqmwglC3cFKsaGXzxsTxsW6TMgznbHFDFnAD/irU9asSd
         N+5zV3/taGBCK1gC+mArjr50XpLlmUq4L5kttIeimUOnOAvywbthRLojKL7ikrMLPWLP
         Zn+0xuK2HA2LtFaQO2Ux7g5fpK5Do9ztEFPINLEUOl+p8LR6W6Au2zQ1bknnaERVCnbA
         g4FGdJjQtZUC608F6jZ8ZuilES4qVXlHgS+L4gLTx4/XQ77yoE4CI8Ywt+wUG6MR/qkf
         8afA==
X-Forwarded-Encrypted: i=1; AJvYcCWFHxju+Z+4qwmvBoMDnq1X5ZmqwKd5NpXMDT6AD4WANPkwQWkMFa+KRfaP+kScLtegsaNI1jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSFq9vatekWaEnXLwEa7B80l6LRprRebKUzgCkq5U+fPprZlWW
	LZneGDtjtQa16X61E+4yLmpnaMXHB9nZe3NJC03NCrRJ+pr0hFYK14X8
X-Gm-Gg: ASbGncsc7DjthA/qKmPqC9+Oy/okaoj5LNAFFRngsDu6+Or3FruOlNiFLkRv01kcyVa
	L63tYAHtKQr2tqUDVrjgBXNbuWs7CwS0Wxkmw4CNyh2AhZVSqhb0ah91j7ENgREkjA20rNoQNnw
	mbt9GIbayzkqg6a7h2OmQ3g9NmkccRdnxO0Y0uH/gSuLg+fQp+gUZLT7seSXuTYccBwziCkJ7YR
	RbBJRYL4rEg+MLJGLnuhw2RyTdpObet2BIKLyxphDWwfI6RjSvVCJ/rJ9Sp+og7f6Qwc38Kd2tN
	IM9y+T9zG0YccuMIpsS06SomgMrHo6zbUIRp3PMgyD2tU2NjggOrY+unKg7NznIIC8S21gInSoZ
	ElhTKsQ==
X-Google-Smtp-Source: AGHT+IFpQpBBI/RRzhcEhne0rIeMs7c/SdD4OgqtFmdHjtuN5szPMtq2zOIAyu5qHXyF6id2lG/33w==
X-Received: by 2002:a05:6000:18a6:b0:3e7:486b:45cb with SMTP id ffacd0b85a97d-3e765594133mr13697709f8f.3.1758032830890;
        Tue, 16 Sep 2025 07:27:10 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:27:09 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 18/20] io_uring/zcrx: introduce io_parse_rqe()
Date: Tue, 16 Sep 2025 15:28:01 +0100
Message-ID: <6f8483923c688e19cfbccc9ee795b2d1b0086d51.1758030357.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758030357.git.asml.silence@gmail.com>
References: <cover.1758030357.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper for verifying a rqe and extracting a niov out of it. It'll
be reused in following patches.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index a805f744c774..81d4aa75a69f 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -750,6 +750,28 @@ static struct io_uring_zcrx_rqe *io_zcrx_get_rqe(struct io_zcrx_ifq *ifq,
 	return &ifq->rqes[idx];
 }
 
+static inline bool io_parse_rqe(struct io_uring_zcrx_rqe *rqe,
+				struct io_zcrx_ifq *ifq,
+				struct net_iov **ret_niov)
+{
+	unsigned niov_idx, area_idx;
+	struct io_zcrx_area *area;
+
+	area_idx = rqe->off >> IORING_ZCRX_AREA_SHIFT;
+	niov_idx = (rqe->off & ~IORING_ZCRX_AREA_MASK) >> ifq->niov_shift;
+
+	if (unlikely(rqe->__pad || area_idx))
+		return false;
+	area = ifq->area;
+
+	if (unlikely(niov_idx >= area->nia.num_niovs))
+		return false;
+	niov_idx = array_index_nospec(niov_idx, area->nia.num_niovs);
+
+	*ret_niov = &area->nia.niovs[niov_idx];
+	return true;
+}
+
 static void io_zcrx_ring_refill(struct page_pool *pp,
 				struct io_zcrx_ifq *ifq)
 {
@@ -765,23 +787,11 @@ static void io_zcrx_ring_refill(struct page_pool *pp,
 
 	do {
 		struct io_uring_zcrx_rqe *rqe = io_zcrx_get_rqe(ifq, mask);
-		struct io_zcrx_area *area;
 		struct net_iov *niov;
-		unsigned niov_idx, area_idx;
 		netmem_ref netmem;
 
-		area_idx = rqe->off >> IORING_ZCRX_AREA_SHIFT;
-		niov_idx = (rqe->off & ~IORING_ZCRX_AREA_MASK) >> ifq->niov_shift;
-
-		if (unlikely(rqe->__pad || area_idx))
+		if (!io_parse_rqe(rqe, ifq, &niov))
 			continue;
-		area = ifq->area;
-
-		if (unlikely(niov_idx >= area->nia.num_niovs))
-			continue;
-		niov_idx = array_index_nospec(niov_idx, area->nia.num_niovs);
-
-		niov = &area->nia.niovs[niov_idx];
 		if (!io_zcrx_put_niov_uref(niov))
 			continue;
 
-- 
2.49.0


