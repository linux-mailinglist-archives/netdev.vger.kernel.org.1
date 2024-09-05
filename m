Return-Path: <netdev+bounces-125669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6AF96E378
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CAB1F2734A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3E5199E9D;
	Thu,  5 Sep 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqvUs6+2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D263D18E772;
	Thu,  5 Sep 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565784; cv=none; b=UZCCfE6STyg0zLNuUQGjYzSOiNdcDGu39h3rGPgbgIy+MImSr5SygPLjSdtvpBgCmTGPGXU16431UCe5EYhwD0olyypKkZdK+HgkBKhXlHhP9XciCkAI403jn9lm6LJuPyBqs/c16xRibSL/39jACNLyPVaZxdlej2v+5J/x8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565784; c=relaxed/simple;
	bh=hAk9pXqkbo2o+5MhqRTmqI9f/rGaqlCpmFo3+Ai3ipQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UK5L2bpyJ5FX74309g9Sepyg4IFCTaw5qxmKyXlKr2wYfCaPoZwkwP1c6/VgsF4EDKEx6kQiLAeJqoiu94rEjJ15OcO4wAM3X0Wh1e6X5IRVFs4pC4jjyFVb5dzzOTaTMtkju5VwyIOVRZ8Ej0RI8sgG1Q3FNImdA2DVLB2nAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqvUs6+2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71767ef16b3so800883b3a.0;
        Thu, 05 Sep 2024 12:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725565782; x=1726170582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUmhuELtVNs0Uu50P1tyTkvo5EER/vEBydF2CtAxSf4=;
        b=HqvUs6+24zJl65ciacOBoob9dVu425kwnZVSY7Gd3kyzAS2Etp235ikCGhr0TVwuLD
         zOSLIzWyf4QS4BLk8IDS+oaQEzboNHBABa2q8jELiKTziM21yEUwhOlN3MT82kVIp/go
         1DAFbS1eI9JJD60pDr3dBeUeXYBlwAvFjEQy7IBSr/v1F3KOpVJADP24DI9mgpvmhBU5
         2n4wI8ltsBaqvafTguvuHkIeqNpBIsPYc6SuAVyP4ybpHDMDEuuf8F9lCjpg0UFeaJ4T
         Nyhqs28r46oMgibY1Ai+f/LPnWP1QH5t0M4wjvYkHFz56RuBojjPWhiX1ufFAW2Kpq1j
         OBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725565782; x=1726170582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUmhuELtVNs0Uu50P1tyTkvo5EER/vEBydF2CtAxSf4=;
        b=htNLLYLsyaW5XS68mfJKfJj8Z8vdeJvpbBSi9iokXUB7RIoV4l2yazpONO8B993sBQ
         gi8EKJyhtlE1fpESi4I3OjDUDzENPFlSIfayGWOxGqnEUi4ZoB6r0mGBXcvkQJcRjSvC
         QqFjN+XhZp6kdhQImz3FHizWAclD9QRp8+CmpQDJd473J99NRFPGQH/EjKXFeDN4R+YB
         QcjZG7M12jaHvkx3c3X+vkC05kbZWpKMa38ueM7/uoxH2QVuoD0eE+XEvxxIk9cOFRI9
         gFeSVVIRAiDjiAdbfqeXruYoSUfqMMMPtEW8krJ2ohlS2tPxv5Q26llq9uxo1mQ4i72K
         WtuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8xfdExe1T4iI2PfA6Boz4cvzJYTr3NCBTl30K+sHJpuisR3ZAlkYjisIYLmWxXT+0f3uGW/zWpQFOTRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJoNnCBcaceZ4OqC8arNmDk93PMBGizRZJHkVJu79ZJBUydOkd
	cx4+uK0TP0yFD+ZR4dP199X0L584+vzJXogN3txx4S70MAN5cH+haP0vE0ip
X-Google-Smtp-Source: AGHT+IGU9F9j0MLcMSEyQw55on9GjRQS3pue9/pZJ9yl4bX73p7jFnMkyVCLZ0R3hVuYIJe1C65Sag==
X-Received: by 2002:a05:6a00:1896:b0:706:284f:6a68 with SMTP id d2e1a72fcca58-718d5f0d28dmr288555b3a.23.1725565781839;
        Thu, 05 Sep 2024 12:49:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71791e54585sm1248410b3a.182.2024.09.05.12.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 12:49:41 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCHv2 net-next 1/7] net: ag71xx: add COMPILE_TEST to test compilation
Date: Thu,  5 Sep 2024 12:49:32 -0700
Message-ID: <20240905194938.8453-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905194938.8453-1-rosenp@gmail.com>
References: <20240905194938.8453-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While this driver is meant for MIPS only, it can be compiled on x86 just
fine. Remove pointless parentheses while at it.

Enables CI building of this driver.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/atheros/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/Kconfig b/drivers/net/ethernet/atheros/Kconfig
index 482c58c4c584..bec5cdf8d1da 100644
--- a/drivers/net/ethernet/atheros/Kconfig
+++ b/drivers/net/ethernet/atheros/Kconfig
@@ -6,7 +6,7 @@
 config NET_VENDOR_ATHEROS
 	bool "Atheros devices"
 	default y
-	depends on (PCI || ATH79)
+	depends on PCI || ATH79 || COMPILE_TEST
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -19,7 +19,7 @@ if NET_VENDOR_ATHEROS
 
 config AG71XX
 	tristate "Atheros AR7XXX/AR9XXX built-in ethernet mac support"
-	depends on ATH79
+	depends on ATH79 || COMPILE_TEST
 	select PHYLINK
 	imply NET_SELFTESTS
 	help
-- 
2.46.0


