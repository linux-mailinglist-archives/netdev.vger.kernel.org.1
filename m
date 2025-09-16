Return-Path: <netdev+bounces-223581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA153B599DD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 650AF7A5471
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F8333EB1B;
	Tue, 16 Sep 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhPxRdXS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D246E335BBC
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032821; cv=none; b=mviwAqQo8SenbLaGctfwU84KKJWTZovpWTYTyOkYEGI61VF8bAZISNSFYjPdhRFQyesxClvbuyXl/ggE7U/1SLlkiQWzi6yYXqnSVwTXqpu/V5Swcxo2fJ6bcCOljmeDAYV2snW92vmdbBTYXjIh0EgY/StnQ3Atszgy30ex3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032821; c=relaxed/simple;
	bh=dhaO5bXGCF040t/G3p3c2L63kxB5T2zkggK5T1YtcXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAlZtQlj6Hd3FRhF1uXjFKEm4tFyiM2Wf2762T5L70DbKttu3nj0hXBujIukoPj8Nc1pe6n4q+Px/XH1e9gPYDqstiD8MTYG+swJq+Xb+51aiUAAkdHNQ2Ye+heQ8D1okoA5mTE3GnCB7+kYfYB9kyk09dixS4rcM+FR4KtZt9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhPxRdXS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so3843419f8f.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032818; x=1758637618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+K+wCvWPeBe4fiwMbzC5U3R6MJ4/gSsqNozWBVE1aVs=;
        b=MhPxRdXSE5UcxTsFmrE/R1Zk3wjxw7IyBwp58U4rfANNYrtnF9sGgj/OftzJcIQIMu
         HMNZOL+ClS1NTb3Tn1BClz8kPjBW9PBIzcK0nqkO+38j1l0BV70I4RRkDCQcht4b7nyS
         VqKFVRfDI7IFFRS1lo9kfnVGXwimq74Sg36z2zOLixVXYtJXVi2rvJ55T8iRfGKqcp7A
         9a1cSOKmSnifZjZwP4bluVW7LwhHV+yyXt7raqHNj1na8ms77OM5uhRaziXra0hd7yMM
         HmS31Qag4/oE8Gq9kTf9zGPo76A+4y2Q1Oed9YHqqzLvmZy54YrBHhbl1vqCCvHaZV1H
         dPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032818; x=1758637618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+K+wCvWPeBe4fiwMbzC5U3R6MJ4/gSsqNozWBVE1aVs=;
        b=GemWjSina/NS6h6jQi01Sse8x64kSERbD1iuDfxxFAaMIWC+iiTHSYA9c9J4BNbMw8
         /HaBADwM2i/74x1YlOhGyQq5Tq/GN2oOWF5EX/9T7S6B0raUDAPpAtyJYV8hDy7I7sAl
         Q0NUkUGE87cyClsZpl2ImxHtCn/MTv3kfKOUwYiLqqBTygoGQrqGs00FKaG5oOH4K/Ct
         SM101tSMHInIAdcTLBdof/yS/o6fVbuAsBzRAmHAGczICJxJEuet1HK5fxwq3ucMhRJ4
         QzbAOPLnQiAMlL+L5cGpHxczyKfNyfZbmOZtoLu8r16Px5srv1V7gQw+ljfk7ZFERi0l
         NGAw==
X-Forwarded-Encrypted: i=1; AJvYcCXM+Ak4ZuzfO3hxYn2vSN68gvy30xKl27pvMr4kwyXEDUh+nvimjZ6NmzW4g3tkus0sn5V4Y9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvZ0XtsWSwlUcWy5lJsqJI21xMgEOFrqVWK91hz/cGH4OhjsM
	/+d9bo1daLgOCdt1ou8m65v8LMGJoXcaZiMHWaX5nCWlZpoXeJLbyWod
X-Gm-Gg: ASbGncsCW7e+eNtHHwj8OImeBpyISG0rT/HCTS0ZhcvVPxH2GSdheZ0NtuEdZDx/HQH
	irffGYCUF1A8dCT7TE89jVsk68qyoKmAlVrqZtIaMXxpHcAKp/UZ9ruQ3/e318BSUgskCt+Y9AT
	hpl9P2/HNvZFVBT8FVw6IsV+nhDnX0yX56biIxATVaI5j0Rj1fYezQqMs5BDWyv2n4A8h4arMgv
	gZGYBBp/u5wm5XWrx3scR+Qx5HhDK8NRn9KIREp+QXJhQ/Vg4zFzMI64ZChuRddTxsUse7MK1k8
	RJcut5UkJ9tedIiqT6djAFxkYlZ29co0HPvwKJv3OIslDP6V0a88IIb4TZ14H9Z/9mo+BEzWkEN
	vX32TvQ==
X-Google-Smtp-Source: AGHT+IFvdUTfW+spY+N4yUPMvLFoNvaMtFtAW2x7UFoT7U2jhK6RZD1Ssm1dUNWTqdRTP5GlFApyPg==
X-Received: by 2002:a05:6000:24c7:b0:3e7:5ece:cffa with SMTP id ffacd0b85a97d-3e765a140fbmr9949464f8f.30.1758032818100;
        Tue, 16 Sep 2025 07:26:58 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:26:57 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 09/20] io_uring/zcrx: deduplicate area mapping
Date: Tue, 16 Sep 2025 15:27:52 +0100
Message-ID: <fdbd46d50edf16e0fd4695c4e10f8784a82d2a7d.1758030357.git.asml.silence@gmail.com>
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

With a common type for storing dma addresses and io_populate_area_dma(),
type-specific area mapping helpers are trivial, so open code them and
deduplicate the call to io_populate_area_dma().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 16bf036c7b24..bba92774c801 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -157,14 +157,6 @@ static int io_import_dmabuf(struct io_zcrx_ifq *ifq,
 	return ret;
 }
 
-static int io_zcrx_map_area_dmabuf(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
-{
-	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
-		return -EINVAL;
-	return io_populate_area_dma(ifq, area, area->mem.sgt,
-				    area->mem.dmabuf_offset);
-}
-
 static unsigned long io_count_account_pages(struct page **pages, unsigned nr_pages)
 {
 	struct folio *last_folio = NULL;
@@ -275,30 +267,29 @@ static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
 	}
 }
 
-static unsigned io_zcrx_map_area_umem(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
-{
-	int ret;
-
-	ret = dma_map_sgtable(ifq->dev, &area->mem.page_sg_table,
-				DMA_FROM_DEVICE, IO_DMA_ATTR);
-	if (ret < 0)
-		return ret;
-	return io_populate_area_dma(ifq, area, &area->mem.page_sg_table, 0);
-}
-
 static int io_zcrx_map_area(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
 {
+	unsigned long offset;
+	struct sg_table *sgt;
 	int ret;
 
 	guard(mutex)(&ifq->dma_lock);
 	if (area->is_mapped)
 		return 0;
 
-	if (area->mem.is_dmabuf)
-		ret = io_zcrx_map_area_dmabuf(ifq, area);
-	else
-		ret = io_zcrx_map_area_umem(ifq, area);
+	if (!area->mem.is_dmabuf) {
+		ret = dma_map_sgtable(ifq->dev, &area->mem.page_sg_table,
+				      DMA_FROM_DEVICE, IO_DMA_ATTR);
+		if (ret < 0)
+			return ret;
+		sgt = &area->mem.page_sg_table;
+		offset = 0;
+	} else {
+		sgt = area->mem.sgt;
+		offset = area->mem.dmabuf_offset;
+	}
 
+	ret = io_populate_area_dma(ifq, area, sgt, offset);
 	if (ret == 0)
 		area->is_mapped = true;
 	return ret;
-- 
2.49.0


