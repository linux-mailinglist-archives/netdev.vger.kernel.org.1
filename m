Return-Path: <netdev+bounces-238290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B332DC56FF7
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96C19350098
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953AC33D6CC;
	Thu, 13 Nov 2025 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Utr/Ycqt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA2F33CEA9
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030798; cv=none; b=rgXBGI1eJ1Nk+o2E6JNlLR0W1P3aUeUM2oMKxw/uu525N9GBcKvvTxDtVY3BSdP2zZrchEF36db+0YwveWSkN8yvIxGsrV3srtHGGh/7DU+tbjyY0hn/ekaOdw1KzOtnIUReJz9EfGKrbG+5KO+ndOKKI8BWP7QFPj+1J6DKq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030798; c=relaxed/simple;
	bh=+rhDk982EzCFvYQv00Owr92/Hx0avc4Ng/M3aSKvhV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qbe0txSdou0OUO1ge1rJKqNsFP5lSi2OP/l0u00zz8f91GAiv7RUGMyvK9aezyUjT8h2BcgAUGx1sul+Xs6BLoC0ViOsrehiygea9y8F/FAS5/tnPILB8qXPTf7RWrnTC/KvBPfhItCvBFQgIu5UMoP1aMBYNt5zbSADtTN+Fik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Utr/Ycqt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b387483bbso547859f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030795; x=1763635595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6L17PdjIQ0I4W/txT3ofY9NSqCulyqTttOKU1s6mNs=;
        b=Utr/YcqtenT3XiYCrgGN4FO2tov+BlzyOpMT3fPmlAcmcTgKQbG4RTx+iIMCdFGSr8
         +ynJXPxGKWFEgqNDUj+SUHLKWdO+SuhLyIMRxzbr1KxUrUnVOfaVontXoJgu7UwI4a97
         85rrZNwIDeUOpu5kLcPQ7WyBGVLs1qDdJzsxO5FzViqU2omHiQyF/pdA4YRpthke9nKR
         OqrgM52BHLbsBMHntgnsaLH71YS9qOArIghobjlT+S19hgdb424d1cj3Ch6AWrJk2rY3
         0xx9KdVOEre7Wg1ZVwePXSHNIlA35iZ3b+1RtTPi/vxRdleVlAPaQc2DPk4K4nKSQwKH
         Ea6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030795; x=1763635595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6L17PdjIQ0I4W/txT3ofY9NSqCulyqTttOKU1s6mNs=;
        b=RfCG/V73A3/CaHk/JP8g1t6xvfFfWQd0f5awovK64ekAw5mmr+3I4kirSR9/hhDMbL
         4ibC+j2hVtScgwZYQb7mMzbmQ943mlzY6HGWDBkbbqOSBEvSkVzusfLudvdwyP0fes5d
         GibS13kVEm31Oxjnaaz1r1mTm5of+kzUEKft5IszDYzl9fYsc02ug4uzyStjx+wcTZu9
         QBntMeJcIfo07A34fdAHcWhPY1kwTiCQlupRuFQyNg+MBjSM678IBXhMx6nQEAnujQR0
         9q82kvHl2pHj2/fMUvsaKqHBMUAbCD8nDCJjilOCqx2K8gvEnApRLqu+p1fy5bO3lJ72
         5SOg==
X-Forwarded-Encrypted: i=1; AJvYcCUXNbU8QlxTzUf0QLX+AAjY2zrhhc6Rx2zB8AvCpsyhcBvFXlU37MA1blFCCcmhmcW7r6a1akw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1Wb67Hf6mObksgt0k7KQq8pgftpDQDRL0+fJNBAj/izwL00h
	XNZuqBlp+qjZm1l6+N5NqxyUvV8gYtV2sKzD+jHWhTEXkZQwx+aLMV6H
X-Gm-Gg: ASbGncstwPNb0E/USsLT4968DNkSSAF8sugDUVNAnvwCHfYSlMRDfetl/xsbcWJuo69
	nY5rHQH1OQuPltasI+MXQ4bs8xYe4XNhaktGSmZO40gvyoXO5KmB+h/BIDTogcrXKRMod55I/oe
	K/zLaBPULZicGZE+SftCkNFuTViYeSALEZLs1ZoK7tlthp2UN3Fj0YzQpOF49Z/1qqlwnKMwlcG
	/n5qbuncNyADF7O+18P64HDTsLz5IMRi01IGJpLK+3pX88NQHflFzNxtWYAFpaBiAlN+pThPmGu
	Xfvr0SJb6gyoS1LFhhJ0wo0lXc/5vLowB6tREtPqg9sijPfYde+6AAHcOh1s6aYx18+D8X6LsA5
	wQSjzuqJSRzhHQvEvOP2lxPnbDsenzUboZeYxue0nZSIamiGkzCR/jbCxlzg=
X-Google-Smtp-Source: AGHT+IEig4C1NTiH+dl6TVyWD3Z+E5tDcp+tu/v4WJtJG26QDirlwhDV+zuNkvKKfKGdeToMKxichQ==
X-Received: by 2002:a05:6000:2087:b0:429:ca7f:8d70 with SMTP id ffacd0b85a97d-42b4bb91a52mr6264315f8f.15.1763030794955;
        Thu, 13 Nov 2025 02:46:34 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:6794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b12asm3135210f8f.10.2025.11.13.02.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:46:33 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org,
	David Wei <dw@davidwei.uk>
Subject: [PATCH 07/10] io_uring/zcrx: move io_zcrx_scrub() and dependencies up
Date: Thu, 13 Nov 2025 10:46:15 +0000
Message-ID: <f8a6aed311288b3dfd486988261d102e5420a700.1763029704.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1763029704.git.asml.silence@gmail.com>
References: <cover.1763029704.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wei <dw@davidwei.uk>

In preparation for adding zcrx ifq exporting and importing, move
io_zcrx_scrub() and its dependencies up the file to be closer to
io_close_queue().

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 84 ++++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 2335f140ff19..e60c5c00a611 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -544,6 +544,48 @@ static void io_put_zcrx_ifq(struct io_zcrx_ifq *ifq)
 		io_zcrx_ifq_free(ifq);
 }
 
+static void io_zcrx_return_niov_freelist(struct net_iov *niov)
+{
+	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
+
+	spin_lock_bh(&area->freelist_lock);
+	area->freelist[area->free_count++] = net_iov_idx(niov);
+	spin_unlock_bh(&area->freelist_lock);
+}
+
+static void io_zcrx_return_niov(struct net_iov *niov)
+{
+	netmem_ref netmem = net_iov_to_netmem(niov);
+
+	if (!niov->desc.pp) {
+		/* copy fallback allocated niovs */
+		io_zcrx_return_niov_freelist(niov);
+		return;
+	}
+	page_pool_put_unrefed_netmem(niov->desc.pp, netmem, -1, false);
+}
+
+static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
+{
+	struct io_zcrx_area *area = ifq->area;
+	int i;
+
+	if (!area)
+		return;
+
+	/* Reclaim back all buffers given to the user space. */
+	for (i = 0; i < area->nia.num_niovs; i++) {
+		struct net_iov *niov = &area->nia.niovs[i];
+		int nr;
+
+		if (!atomic_read(io_get_user_counter(niov)))
+			continue;
+		nr = atomic_xchg(io_get_user_counter(niov), 0);
+		if (nr && !page_pool_unref_netmem(net_iov_to_netmem(niov), nr))
+			io_zcrx_return_niov(niov);
+	}
+}
+
 struct io_mapped_region *io_zcrx_get_region(struct io_ring_ctx *ctx,
 					    unsigned int id)
 {
@@ -684,48 +726,6 @@ static struct net_iov *__io_zcrx_get_free_niov(struct io_zcrx_area *area)
 	return &area->nia.niovs[niov_idx];
 }
 
-static void io_zcrx_return_niov_freelist(struct net_iov *niov)
-{
-	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
-
-	spin_lock_bh(&area->freelist_lock);
-	area->freelist[area->free_count++] = net_iov_idx(niov);
-	spin_unlock_bh(&area->freelist_lock);
-}
-
-static void io_zcrx_return_niov(struct net_iov *niov)
-{
-	netmem_ref netmem = net_iov_to_netmem(niov);
-
-	if (!niov->desc.pp) {
-		/* copy fallback allocated niovs */
-		io_zcrx_return_niov_freelist(niov);
-		return;
-	}
-	page_pool_put_unrefed_netmem(niov->desc.pp, netmem, -1, false);
-}
-
-static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
-{
-	struct io_zcrx_area *area = ifq->area;
-	int i;
-
-	if (!area)
-		return;
-
-	/* Reclaim back all buffers given to the user space. */
-	for (i = 0; i < area->nia.num_niovs; i++) {
-		struct net_iov *niov = &area->nia.niovs[i];
-		int nr;
-
-		if (!atomic_read(io_get_user_counter(niov)))
-			continue;
-		nr = atomic_xchg(io_get_user_counter(niov), 0);
-		if (nr && !page_pool_unref_netmem(net_iov_to_netmem(niov), nr))
-			io_zcrx_return_niov(niov);
-	}
-}
-
 void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 {
 	struct io_zcrx_ifq *ifq;
-- 
2.49.0


