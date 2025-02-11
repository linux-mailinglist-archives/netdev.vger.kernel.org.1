Return-Path: <netdev+bounces-164967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8AFA2FED6
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D943A341F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF4B26461D;
	Tue, 11 Feb 2025 00:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyUbyw+l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13DF1361;
	Tue, 11 Feb 2025 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232564; cv=none; b=lUeN08mDWAvNNPnTT4vqDY7TitriNXSz05TPSGtyc6g907czj/BMpMygykPd1u3g1tbgLZCiFwKG+9rtwH5rnSVtz2+0hJU0S+op626QD1mtb9GWYWG13h64lft5dZqelkxw8WWm7G1V05L7p8GVuDAuv3si+KaYPKmc4z1c8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232564; c=relaxed/simple;
	bh=01uiTrRRxKutdrpyTfLES+sUzCNND8v4qkEDza+0xVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JXawYtviyWMtupCpvVdrNXuWj9RyW9Z48nflFqP1semNQlpVwptAuJKcfrtQybJGvjFk6dpzFEKo+fYX9QyfPccdzLQbTuhXC0tzMOTUuvzq/JNEuqTUatVpgsNMnhSeAzdh0Ywag5YNUyW31ZO6TbG9+mcMgJZK5lZCmjgEZ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyUbyw+l; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c05cce598dso33064585a.3;
        Mon, 10 Feb 2025 16:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739232561; x=1739837361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ah4k5+xQ1fRNUu+6C0S6nP1nA7x+T5drbERSfhVVRE=;
        b=DyUbyw+llULRR/gNW25wUNQcCiJsgDvNGPfbMGDyh7KRrLzCDrojJYPulljVI7ynQg
         mZRYOP5bUJYH/RuXgGdZtgQhFNAVENsY4PgHPiCqP0Ns0eju4LTKYSiC4rJrNP6tI+7B
         CDIIYdeI49RnAu4KnytGElwqMCraivxGssRXrPe4TTeYWNFiHmOccThNnLaMeIm0Nm2X
         VOKsi8YZyqIDIrwcHjPXQqJGE1v14jNavWiC2nnf5CNELOR+1GJZER1srMrU0Xe12UFE
         l4lIjy7GL7a0jENZoNmjSxz7I5HKVxk+8pSL/JjIHlw8Ct7xSmnZTl1rpAzsp0KV2Zi/
         8fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739232561; x=1739837361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Ah4k5+xQ1fRNUu+6C0S6nP1nA7x+T5drbERSfhVVRE=;
        b=lAOMqGN3BW3W11egb7opNrhRv6EGKc5jGxgCw700D+GwvVxGoQ9CvSWa6VmLDiaT8p
         kiHfIw0gjEWSBkcFwD15/Iq0iHAkoQDRJQi/POd2DGDofdakeg0OEMo18MDGDGaOTM3a
         gSfwrvWrhaZgnbPX8je/eR1qLFO24ufAq0UO7FvClKModiIgCENeNbuHr5a7OdJW2Q+U
         Nvkbn6ETzIbpkwYg4V2JPWMKZaYYBM4mRKJaAaiHCJocsSAUfpVSBTRiz3akaUBpx2oU
         2GVUNIAa2Drnz0WGh9SHFgn9zG9ZnEGOd8yZ00zAQJRLt5OEYtpWJekTfkKV4wY4Xrcm
         kQvA==
X-Forwarded-Encrypted: i=1; AJvYcCUBqCMZ6WD+S6kOTAuoFYjIXy0VblKAZcURC2/NoK0dxTXE6yESsDKRiRVRtFJGrVKVdhAJYVhY@vger.kernel.org, AJvYcCVqBqKMvmSq9yPFJYaTXU+rYs7tj7HzabQlBcmgm8MA7tgieomDNi6e+OmZJaDSs0O9KLDrUN0PKjk=@vger.kernel.org, AJvYcCVrv+yMU29QWLVSSpRe488j7z9+r6Rmd6N7Gal02fqNyGIfTdYr6q/PToeaa6hZZ83inwdnGMj09T6aPzDR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8IA8JTPMr4Q1uFyI0fS9AacoEZdV7QV3g3Km1sOsykQ/NHFFb
	9ThlLArkGj/U8cEs1NWgXWNARuVI6qwKJNxChC8FZM8XcowF0/U=
X-Gm-Gg: ASbGncsnXUzZToqlqeoC715swCdh/FjjyPTJkDfYoJlMzCJVc2nf7IVKxa43fADO/Or
	qW9oeMb2DQwrnr1wI8zUDLxmTlEzYLZu74kEcAKggbObwuXJhvoYjjM1ggBmY1fM+BHF99Az/IY
	sHcbNSiyUIW+8GcUjp4BngJYnp4akPtAEC9c3kLjU5ATiW8vKtu9ume9AXDvFDa6WxwM87jgzTm
	u0wR7JEsFH6rJOZajm8c2gjV64O4NmaevL8cnjZzyEUh8wDIPt5U+LWyapigSRVlETR9ABD2mvv
	6F2CyR+wjErb
X-Google-Smtp-Source: AGHT+IEBNymajCc+NwMXIImuo+y111CUAjewA7syDuazHuJdvT8SyYtv2TQjZ/rPxap9qo/cAU2erw==
X-Received: by 2002:a05:620a:4150:b0:7b6:dc5c:de5 with SMTP id af79cd13be357-7c069ce9f4emr42655285a.1.1739232561394;
        Mon, 10 Feb 2025 16:09:21 -0800 (PST)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0603216c4sm173032885a.97.2025.02.10.16.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:09:20 -0800 (PST)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	dave.stevenson@raspberrypi.com,
	popcornmix@gmail.com,
	mripard@kernel.org,
	u.kleine-koenig@baylibre.com,
	nathan@kernel.org,
	linux-clk@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	zzjas98@gmail.com,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] clk: bcm: rpi: Fix potential NULL pointer dereference
Date: Mon, 10 Feb 2025 18:09:17 -0600
Message-Id: <20250211000917.1739835-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `init.name` could be NULL. Add missing check in the
raspberrypi_clk_register().
This is similar to commit 3027e7b15b02
("ice: Fix some null pointer dereference issues in ice_ptp.c").
Besides, bcm2835_register_pll_divider() under the same directory also
has a very similar check.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 0e1fe3759530..720acc10f8aa 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -286,6 +286,8 @@ static struct clk_hw *raspberrypi_clk_register(struct raspberrypi_clk *rpi,
 	init.name = devm_kasprintf(rpi->dev, GFP_KERNEL,
 				   "fw-clk-%s",
 				   rpi_firmware_clk_names[id]);
+	if (!init.name)
+		return ERR_PTR(-ENOMEM);
 	init.ops = &raspberrypi_firmware_clk_ops;
 	init.flags = CLK_GET_RATE_NOCACHE;
 
-- 
2.34.1


