Return-Path: <netdev+bounces-223587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EB0B599F0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594FF7A632C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F704345743;
	Tue, 16 Sep 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4veuE/W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B18341AA1
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032830; cv=none; b=gxWGB93GuHdBzZZZFbho3ggLfnnkTDcz06ZW04pWp7Tp5uKVOaBT1zNwOiXBBj/xYjAzQWNOT/nwbpqOs3f5n+XSYV0Z05ZPwPykSE5O3ArmHeBWkqpIVZe6/RD4vOGdh59AikpY9R90GoMd8+P1MtA1tEtLQh9DFbB6DRjJcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032830; c=relaxed/simple;
	bh=zFUgVjN8gCChVqCbuCN5B7SJ8Ml3TiaNoAwuIDJZdrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZ/X1JavsQxTBi3iTTHauxPWLYwa4u551sSSwg8Bw6AG7jY+k7EHo7PaCTt+Ag/3v0bN/wSHI/kX77oWyLRvk15HaVDA+JJiJk/bDBinYHjlXWTWJzP38wt/Rbi/iRjvj1vorW0Y+sDNrDnAecqQS9ndByvRhNfI+t+2Yk9gWf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4veuE/W; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3eb0a50a4c3so1521711f8f.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032827; x=1758637627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLh6FB29DjH0Q7hYhSSk+TA0DlD3EiiBje8bEhVpW+g=;
        b=I4veuE/WWtW/EjFCM7zVdlQ46pg8aKUtcxZ19Dq8sjQP7AAvZv+6+wnZl2oSBgHkmA
         TmSrEubcjX/ozUinA5Us7xA5n1lqqMkZBClgITXYPCyw5NzWd94ApP9cMoUfGtgujWlM
         hCe2oSxZ7h4X11YDNBv9/5dHsZoXM2zNhyHjng8BYfqNEpVYT4gz/4xRwoFVfT39W0Xv
         fTeb0eJB2LphdPcQu5+XMWe4/3pSPw268f/9I7wgbgiuduP8Vo3jw9yOrB2Y2LPs3SEX
         xv/Di4O5Tc6qi6wntqKE3xd5Q30L0mzfQBo9YqNrS1WMdaSMF40zEBjfIKLMIlXJILsD
         A8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032827; x=1758637627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLh6FB29DjH0Q7hYhSSk+TA0DlD3EiiBje8bEhVpW+g=;
        b=TUq+O3GA0SWnwhHwTqmiAwsZ62+Aq+rqBfqsF4QiCGEdIWjiKUzTw8fWjBBkF3TVNy
         /0P7IWnXcPl/HXmcSjOcFg9f0g35JCxDLcn+Wq024NHLGJcuiI9dptL32nj7/ZINjXYk
         Cd1cwMMspNkmFNGjLZZOb8Z+d4qvVo8W4DdESo58v88st3VFBtKX5e3hno9fQXzWrpvp
         CUfuTQiaXB7WSOGgslpfJB2OZUX2pMvnH/onJTsH5lS2/Vbo3ByYTPjVNemrDHBoLGtH
         fE1yqV3Vn0FTZEW9A3lfQDzAu99QwACnWnkQQd2sIztbks/nppNEBohIfcDjfodlCXOm
         JL7g==
X-Forwarded-Encrypted: i=1; AJvYcCWblCXhlJjyyGe4uQhJWQbK1hw08X3JlLoInIWHwt0lc18pnFiUcAF6EQQtqIQW10Z/jJweuws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0s/8rljn5zuqZX7PsS/8ZpBK6a8pNxGQIXVV96dNmM9+hW0n
	kP+mTEmjWVspiISHmHbLm5FFIz1SAtCcEp+4A8g88/z2nHp2EpReDnyr
X-Gm-Gg: ASbGncvG9xTD1iDlc/Io5EQLoaiC1h4sw+xe2dCrO1H5RxMCiphJRB6cuA8i3IOXESb
	HXY02X707avJTVb7E1O8g1Dhsmydv8jeHzxbFAR7XbQrUi7ZDOALRcSpEms1+a5ZNdaY1Jz00HW
	RzqCw53OUDOj3Jnsam3Selhppf/BKxQaPqJsJa3H7luoT6pebVH6yUvbZnWm1HdsZFgvqAd0ynd
	Q+ihW1Sh3vpSGFxxf6aL3XyURWMineDSUM1AoAFiOx7L+QWGarxzsZUozAeRvwWVFOz0O4yDS88
	yloOqwO9JTrd9p60NMln71PGDT5+WRyoMkN4OCk16R2PBAp0nUkXQ3nd6M5ziycACbNkbDJsKpI
	aH3NwGQ==
X-Google-Smtp-Source: AGHT+IFPvUoQ7F1e2ZU/ZnmyJIgsytT0235SXNnKobzQJA0XHzL/acl+bRHUvh8S+ul9ec6PvZnaVA==
X-Received: by 2002:a5d:5d07:0:b0:3ec:1b42:1f8b with SMTP id ffacd0b85a97d-3ec1b42221dmr4363579f8f.40.1758032826685;
        Tue, 16 Sep 2025 07:27:06 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:27:05 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 15/20] io_uring/zcrx: reduce netmem scope in refill
Date: Tue, 16 Sep 2025 15:27:58 +0100
Message-ID: <14ccfe8a94e04b9829ed802ea6f474ba5f638e7c.1758030357.git.asml.silence@gmail.com>
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

Reduce the scope of a local var netmem in io_zcrx_ring_refill.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 6a5b6f32edc3..5f99fc7b43ee 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -755,7 +755,6 @@ static void io_zcrx_ring_refill(struct page_pool *pp,
 {
 	unsigned int mask = ifq->rq_entries - 1;
 	unsigned int entries;
-	netmem_ref netmem;
 
 	spin_lock_bh(&ifq->rq_lock);
 
@@ -771,6 +770,7 @@ static void io_zcrx_ring_refill(struct page_pool *pp,
 		struct io_zcrx_area *area;
 		struct net_iov *niov;
 		unsigned niov_idx, area_idx;
+		netmem_ref netmem;
 
 		area_idx = rqe->off >> IORING_ZCRX_AREA_SHIFT;
 		niov_idx = (rqe->off & ~IORING_ZCRX_AREA_MASK) >> ifq->niov_shift;
-- 
2.49.0


