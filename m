Return-Path: <netdev+bounces-223578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA94B59A2D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA45525CAF
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8513375CD;
	Tue, 16 Sep 2025 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE7qIOYi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57B5334386
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032817; cv=none; b=sNOz45br9fuA5YJcx0+MThlTfurf4eWkM615GxWLAisIhMqYM5HCfSAA39maDeplFdByNR+bEyy0qoEdhkXLpklpPvAo5oDwaRlF+zaGhbJRe4eARwAJRPuXrh9si/WGgPuAYALALcBCw+f/TI6W0Oe7u3zcqf6lzRq/R+FzMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032817; c=relaxed/simple;
	bh=kZs+DHWaawva+MXn9WHKPm2Vy0w5G8FxKpsyd+A3M0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkCvHOJqSUsJp/IilHa6Tn7ERaTJ8XR633ExaieTo1I+Q+2GTzlmDrmI0z+x79HVokJdq8a35NypLTxLVLjQGIDCeqJrk2HJHpR9py6vnG8VhFlk57bDQu63zJe6vEnv7Gql3Ey+JYSR0/du9n50BEv5Qbl1ayvraxzzQ+mYqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE7qIOYi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dec026c78so56056535e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032814; x=1758637614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuj4BWzPC5531S2LDg+xtZ940ulE2g5Y/85FDPfd8xE=;
        b=PE7qIOYiY5du4ByxOR0BT7TNc5mx2yEopxodxNi9Bhu6Yb/XWr9JsVeE13zaWOICFM
         sEmQUx815reCug7faGSVaaUBdrBwWw5likjhcTA3fyX2OhU9FD+5GJ6y6nfL3fCAwiTy
         gOulBvlignYqjGXIL9RaCiKgECkUMxYOFVCqldl5d8cNMLsIeZbGP6uNuzW/O51AqMFw
         mVocL7nb6QfnUXjz9rxDLhRaqZZf1tocDTsIo50HS4L+N94a0usr4wdPs0TSHWJmNr2z
         JwKFwQ+0LxLyf+DDrvpsE8YCkb7qGhXN5XnZWTeh2U1/NLsiVyPOVYQaNnnupM6ao5Vz
         gLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032814; x=1758637614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuj4BWzPC5531S2LDg+xtZ940ulE2g5Y/85FDPfd8xE=;
        b=oPgh5O1Isk8xQOAx0TEG847KvRnbO13ain8soXOR8ZaIObzI0CPCLRnEZ6zSqESUyU
         +GTve71/qU43HKlR0GGPVLs0HKLOmkhcH8D2RDFQp5ir3tmYziFcLaJKcUKtJCb71DYM
         CZQqcQXoIAHjLodZsuZ4yV6OaVnNPgIVoJsuKCcB7ntNo/lv3xGL55bKyyVLj7UntsAJ
         BiyXfH6y1nas9MlctjZIJSpWZk5k4WcMoaJUv1l1d4RVQaruNZhB0LYuROib9DNOeFGl
         uFhUtMCl0jqbBrXdqvTPhOhlguo+WIR5n+0Cu+R+9vyfZ9C9cwCzI+M43eXUlzep5bsI
         HibA==
X-Forwarded-Encrypted: i=1; AJvYcCVfXVLWq1Dsqvl0lRL8jJ729RZJxvzoBr8i7NVbVm0/8Z6ehs0CvQknPDu3xQyeKA3wwZRaGww=@vger.kernel.org
X-Gm-Message-State: AOJu0YziEIseIaCluP/sj9IyQJ7nM8F3MriKlHRt7mItrHEXHRiHoHSK
	EhNzBhsk0WW6FNbEC6+/DKp4kuDztjULZvGD3exPordBF+PKkMzdIk59
X-Gm-Gg: ASbGncs4s4t1BbHrg9ya92OIT64iB1Dqn8O5zrWqsVjvP9c5t/UuUeE9CG8de8vsExT
	fpQTYO/i8/EJA+bpQINukgOpMJXXFc1hFV2Jh8W94d4V3eM8/XIQrvPn+eMd3+gYZqaRncQtI7f
	uMXsXjpJjWaH7NYZVQ8OyvRxeWUpm7r5KI3dcRQHnDxbioaQIG+RfJNlwnqoL1N7qCSsrPMTJMm
	nJbgtn6s7SUX64xV5ta8qqn51gjjsfB6iRiResuklVHIfUOvnZ9NJu/e7GYgIaGF6m5iGkqt8jw
	8p7QDGZCiH9Vyld/7VuXAZ7XqHS4vH46s5kRkB7/++R+zk6i4+WYm13Cyn5H9Z8UZnr8rOWANv+
	PgtoG+Q==
X-Google-Smtp-Source: AGHT+IGUsH8IIT0VhmUWDtKJn5YdMX11CTBPM32mGFKsWymIVbBGd0bXVkyHF0dAxJirgbThVk2GjQ==
X-Received: by 2002:a05:6000:4013:b0:3ec:6259:5095 with SMTP id ffacd0b85a97d-3ec6259530dmr2969121f8f.12.1758032813885;
        Tue, 16 Sep 2025 07:26:53 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:26:52 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 06/20] io_uring/zcrx: move area reg checks into io_import_area
Date: Tue, 16 Sep 2025 15:27:49 +0100
Message-ID: <4eecbb60c6fb177f1d3a9027b85082678d999b0f.1758030357.git.asml.silence@gmail.com>
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

io_import_area() is responsible for importing memory and parsing
io_uring_zcrx_area_reg, so move all area reg structure checks into the
function.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index c64b8c7ddedf..ef8d60b92646 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -26,6 +26,8 @@
 #include "zcrx.h"
 #include "rsrc.h"
 
+#define IO_ZCRX_AREA_SUPPORTED_FLAGS	(IORING_ZCRX_AREA_DMABUF)
+
 #define IO_DMA_ATTR (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
 
 static inline struct io_zcrx_ifq *io_pp_to_ifq(struct page_pool *pp)
@@ -231,6 +233,13 @@ static int io_import_area(struct io_zcrx_ifq *ifq,
 {
 	int ret;
 
+	if (area_reg->flags & ~IO_ZCRX_AREA_SUPPORTED_FLAGS)
+		return -EINVAL;
+	if (area_reg->rq_area_token)
+		return -EINVAL;
+	if (area_reg->__resv2[0] || area_reg->__resv2[1])
+		return -EINVAL;
+
 	ret = io_validate_user_buf_range(area_reg->addr, area_reg->len);
 	if (ret)
 		return ret;
@@ -395,8 +404,6 @@ static void io_zcrx_free_area(struct io_zcrx_area *area)
 	kfree(area);
 }
 
-#define IO_ZCRX_AREA_SUPPORTED_FLAGS	(IORING_ZCRX_AREA_DMABUF)
-
 static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
 				struct io_zcrx_area *area)
 {
@@ -413,13 +420,6 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	unsigned nr_iovs;
 	int i, ret;
 
-	if (area_reg->flags & ~IO_ZCRX_AREA_SUPPORTED_FLAGS)
-		return -EINVAL;
-	if (area_reg->rq_area_token)
-		return -EINVAL;
-	if (area_reg->__resv2[0] || area_reg->__resv2[1])
-		return -EINVAL;
-
 	ret = -ENOMEM;
 	area = kzalloc(sizeof(*area), GFP_KERNEL);
 	if (!area)
-- 
2.49.0


