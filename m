Return-Path: <netdev+bounces-238285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65793C56FF4
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 741F44E43EA
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ADE33BBCC;
	Thu, 13 Nov 2025 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM+Py9TZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49424337BAC
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030791; cv=none; b=QolzBvqTWgGluF6PfLT+vlC4zGpxV++wMj5DRk4hZEu/ie2E7TbFA3aVp8rAbVqQOeOdWHwl24qIffXCDscXNR82qNgsbaU+c+3xLrBzCKJsH5MmBrbeYx9nD6iqQqmAirYkA1f3wnCMFQcJ9Mghxkrt1SjYPVqWGvwwl1bvaSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030791; c=relaxed/simple;
	bh=X39KDvAwy/CrKEtq5OmIpNZxcBKw/URvO24fiCsTcb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp1qvffJKElZbPVcb6+WTuflBQf2CYnnvYWF19xE/15xVWBntWZ71SxU9y32lYwhEAwynHUPptL5hN6W6qM9B6qiBr6kmV/adRBxXF7VImnUVDjjklQ6qtiKjNrhM2mvxR8jL05A/a7s0kN2fDP/S5VTxjzi/haddAyhztnep4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TM+Py9TZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so428781f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030787; x=1763635587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSZJowsGSgNVlodrBamdaFT1Q8MzsnuAhDUFTnHqXhQ=;
        b=TM+Py9TZMi21XkqwHxRpR3pmjQq0Wd9J0bERx/TKRLbk6D5yzuqC7bv7bDoS1qt0oU
         du0EzEpM0V1ZgGU2lJYepMZtFGYkX7xV9uRZY7gEO6dFXRYpEQBLijbONrhJwl1ObmYy
         BYu0J/+kDavekQF4OMu+9HIUnMQU67MsC7grZncW45km/YnifC1pv6sgA0qutlaUv3/i
         9BBc9XZwmr1Zu2FN4LTd7KBmKe5czOyjFjNGLMzYQ/VROiSXxNjIQbPHSg4o18iuU6r4
         9s7z6GmEDp3GhnyAojYnlnbJrT9ZpQ3lNRYsjlPirk6IqZyR1b9xWxO7VWFfdKsDLNS+
         vMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030787; x=1763635587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HSZJowsGSgNVlodrBamdaFT1Q8MzsnuAhDUFTnHqXhQ=;
        b=oY4wNGHgJaxWSyN4hX1d1wSF/hDk5BRxbCCaCKxDjPCs1AAgWourRwOP/z4saAoXOZ
         /uMh9wtmSjPk/Zri0ERipWDMSSYY2TlZA/kOjuQm/LZh/i16kzTeIwCmkeRTJutjF/yh
         3YdcRI4bD97MYjDTqH1OT2atfVt+7n41nEljlftineO0Zsf2sGPUjj0h9PKNXkPHEFdH
         znuD8+HqP6qHhrZXxJudG12grQGEgT1TpDr3vHh1pcziz1HIZmJEWHVdB3LU4r80DbMj
         FpEg2Z7fFO5UhZzFV0AWNTS+QtwjMxOrQd518UZM0aM471pk+WgqV1ho6wqCiFH40Tvh
         KbOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXarjbuPa9thXqVx1UE/F864mmu6iVMRaZZw7ikBRzx9M5JJhk1YC2KDgKtawnmrPm96C9mShw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuV0IDr6Z+3GE8QjiG7zVwus8Re+WGMV2sdDOPQMj8Ve3dS79J
	ssHwBBvYAUtzxf5UQhAgaFXJLPB4Ey5S6l9cZ4YvdwujAISTRX+xL5qo
X-Gm-Gg: ASbGnctbLplGbBrazsL8+pDd3106lb6V85jXPB2sZRP2RBoAUraRXRReBOdPj8GpT2j
	aR1NWT37NWcv/d3X3KTjTzlItIeOlqxQXhbxulQW6KJ4b8XtXAzOJF0vdd+3m+4qgffZzskA9bj
	OVwci6OlxI/cp14ROD7JEHFGAFWp+q2WRE41u7IBgv6U+S8jRNg7pG5oqN6x2mFa2Q37WtXYhHP
	DJT7KDlIpNTbSxY5jwks+VriNYLwrFrAljc7mXeqakDJyimFVYfnvcqBoFK0ztaT9oSoswdbfmQ
	gEHBMkQiYkotT17iClZwBnnplCVfTQimamUqSUjjAw/eFQ47e86hG9T4h8KVK7EGZirSj0xNyCr
	UZYGAKGJcO6j0PLDRiJAJiLWL6UD7SeCRSNPg5ed8a1tNRDSW3anPD9OeVG4=
X-Google-Smtp-Source: AGHT+IH6buxWpu6XO/rSqD1Gk+kcSbXBWVnCikm3r91Dz9tCMzmbS6mC7q6gPH4+gvRXo5+V3D5LiA==
X-Received: by 2002:a05:6000:24c7:b0:42b:4223:e62a with SMTP id ffacd0b85a97d-42b4bb7d329mr5845939f8f.23.1763030787479;
        Thu, 13 Nov 2025 02:46:27 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:6794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b12asm3135210f8f.10.2025.11.13.02.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:46:26 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH 02/10] io_uring/zcrx: use folio_nr_pages() instead of shift operation
Date: Thu, 13 Nov 2025 10:46:10 +0000
Message-ID: <083a8ca834fa7c5a0eedf355c684148b289b5135.1763029704.git.asml.silence@gmail.com>
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

From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>

folio_nr_pages() is a faster helper function to get the number of pages when
NR_PAGES_IN_LARGE_FOLIO is enabled.

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 635ee4eb5d8d..149bf9d5b983 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -170,7 +170,7 @@ static unsigned long io_count_account_pages(struct page **pages, unsigned nr_pag
 		if (folio == last_folio)
 			continue;
 		last_folio = folio;
-		res += 1UL << folio_order(folio);
+		res += folio_nr_pages(folio);
 	}
 	return res;
 }
-- 
2.49.0


