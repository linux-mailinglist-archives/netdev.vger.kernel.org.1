Return-Path: <netdev+bounces-152816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5432C9F5D5E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05D116F767
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E84713D638;
	Wed, 18 Dec 2024 03:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="bV1Mn1sX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D0884D29
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492179; cv=none; b=siyTebJat2gn4jNwuRMmaA30VIzOAVzKWDlDnYFjrthQNSFiP3ihSmXlYyXPYzuzZFtQGRrZYKnjjbCib3Qe12f26hRZyTZTgCL1j0H1/jV+tBUAALCna3tmZewhpjgAKrvWbHdJnnk82jtHYpSeEvqwdnAx8EEVPCvMdognWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492179; c=relaxed/simple;
	bh=BLG9JmyHYUQllcG9Tz2SoPt8OKpBZ8RF5ui8Gg1Qwf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4YMVTgOk7z3pwWdbO8HHPAjk2jLKXZ0Zh9HlgVfugS98nFU4r3ytWvIv8Subyh5HwXkrSjBYxSvDQkVR1bhzlkXUA2xjQmEeNEgE9jfB42x08SIb7BdGuDjT82uE+sI8R9NpNLKdKmjm7UO+60UpVIFuUgZCDYvLJRNkoLMfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=bV1Mn1sX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725ecc42d43so5106350b3a.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 19:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734492177; x=1735096977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HN0kCWzUQSvGKZZ0wt0adgUCnTeQn7XySDNlpXpwm74=;
        b=bV1Mn1sXBVKw0rlZxnyV1Sh0rxAVbK84pA7emI2kWTxLcbmc4Kb/xa0BBjb+IqB/OB
         kSxo1IiT5tlEcjU7QPp1kw7BuJHeWD1yPPp5Eu8CB5UKahIozLSpXkE1XCrAs0DRzdZB
         u9I0V8MlrEqGRPMDLi23jzTQhd2MlULFd3t265tV/cpSwcuv9/eah0L/EzUqBfgU2DlP
         T2/q0QvihTCo1BVUB+072OPMtXpYNEyBZmF0X2puu/E9eW283Lger64jC7Kw35h0jnru
         Sof08OMLSUtPAkPFwHnVVlqyhQxVKb8Yo8lUls5xPv7n+Ky58Y+c3v8SwGDR4iufD9AB
         sekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734492177; x=1735096977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HN0kCWzUQSvGKZZ0wt0adgUCnTeQn7XySDNlpXpwm74=;
        b=TJE5QHQ6CoJc7f8YvvYrEmz1srGjT/SNjgM4UE/FstslfGGuimySpj+CWN5tks4TsE
         Zyo3TQe+dS6J8ry6QRno1kU59wIxdRkoXHdOgxxOCp+BF2uyD3ABCqf96E79GtUnJRUZ
         so5TWnAWgiIcayn3EoIvz+ajCZA7TeXurZMLTDyJ8b0hFMYyK9szPlQTp3zpIYDM52/J
         5UEOgW16a261BkKqNCLZW/tUGmvYKN9tKVnMkwpckTdJLVkXiud7l1g3A1VYnPx04Xxh
         W1Njp1sk7ujzoXrKmuFDpc95vxEm9Afa7kTPSxg6VfhLJ6m8pinq/tpLT+gFqmNIt9zw
         +xbA==
X-Forwarded-Encrypted: i=1; AJvYcCU2yYHFU6pZMwN/O1/Hm+987/HRZ24gGT3BL1pqYOukaPbtE1p1gmJMGu8ec6ImZB4/Vy3wgAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxteCKYxj8EO5wiLDWiIQReABcxs40iNLYOCnKog1x3pf4vINVP
	t7EDAdIhfDOP+6CdToVjHl03B/4sn4F00Zqw5jTN0T6ccuGNBQZckNXmcWJGRvs=
X-Gm-Gg: ASbGncvAh8kKrZ++BCK9eYVKVZhIpKhK0HvntNFZ9X+4RByZiXYe5AB8WRm8qvUp3Qa
	x2gyDUGcoQrqxHlOFM/u/MH+NE7LPk42A6ahKFbWUY2eCGRIoT9BbDtgplV6p9UhIR7FmaNy//e
	/FqBo3v4TWAgDRCwFZXG6cwtwQgPD3gSUwOJKfocKB2FIhRX0dT2i85G0ESkQakEQcc3J1x5SYj
	WX6n4SAeffuAtzHH7/iL90seDya3ITlJ4znV0+ZFy9jz8wQXQqAJJXkpPoHPsJeJSN6BK/6wWei
	hLhxRe5rcax0DRzIuyGjcO22WZ8X/+w0Vvkx/RIwnlY=
X-Google-Smtp-Source: AGHT+IGj44DIDlKeijIuBeM7eDvAm2kP+pj3y9KVOVTeMYdtT6MUF1+/V8hVUTf688XOwS1GIqcHgw==
X-Received: by 2002:a05:6a00:398a:b0:725:e499:5b88 with SMTP id d2e1a72fcca58-72a8d2c9b7emr1995093b3a.25.1734492177106;
        Tue, 17 Dec 2024 19:22:57 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bb4037sm7453908b3a.168.2024.12.17.19.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:22:56 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com
Cc: krzk@kernel.org,
	dan.carpenter@linaro.org,
	netdev@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2 2/2] net: stmmac: remove the unnecessary argument of stmmac_remove_config_dt()
Date: Wed, 18 Dec 2024 12:22:30 +0900
Message-Id: <20241218032230.117453-3-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218032230.117453-1-joe@pf.is.s.u-tokyo.ac.jp>
References: <20241218032230.117453-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first argument of stmmac_remove_config_dt() is not used, so drop it.

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 669d8eb07044..aadacb1d5939 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -407,13 +407,11 @@ static int stmmac_of_get_mac_mode(struct device_node *np)
 
 /**
  * stmmac_remove_config_dt - undo the effects of stmmac_probe_config_dt()
- * @pdev: platform_device structure
  * @plat: driver data platform structure
  *
  * Release resources claimed by stmmac_probe_config_dt().
  */
-static void stmmac_remove_config_dt(struct platform_device *pdev,
-				    struct plat_stmmacenet_data *plat)
+static void stmmac_remove_config_dt(struct plat_stmmacenet_data *plat)
 {
 	clk_disable_unprepare(plat->stmmac_clk);
 	clk_disable_unprepare(plat->pclk);
@@ -582,7 +580,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*dma_cfg),
 			       GFP_KERNEL);
 	if (!dma_cfg) {
-		stmmac_remove_config_dt(pdev, plat);
+		stmmac_remove_config_dt(plat);
 		return ERR_PTR(-ENOMEM);
 	}
 	plat->dma_cfg = dma_cfg;
@@ -611,7 +609,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 
 	rc = stmmac_mtl_setup(pdev, plat);
 	if (rc) {
-		stmmac_remove_config_dt(pdev, plat);
+		stmmac_remove_config_dt(plat);
 		return ERR_PTR(rc);
 	}
 
@@ -628,7 +626,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 
 	plat->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
 	if (IS_ERR(plat->pclk)) {
-		stmmac_remove_config_dt(pdev, plat);
+		stmmac_remove_config_dt(plat);
 		return ERR_CAST(plat->pclk);
 	}
 	clk_prepare_enable(plat->pclk);
@@ -647,14 +645,14 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	plat->stmmac_rst = devm_reset_control_get_optional(&pdev->dev,
 							   STMMAC_RESOURCE_NAME);
 	if (IS_ERR(plat->stmmac_rst)) {
-		stmmac_remove_config_dt(pdev, plat);
+		stmmac_remove_config_dt(plat);
 		return ERR_CAST(plat->stmmac_rst);
 	}
 
 	plat->stmmac_ahb_rst = devm_reset_control_get_optional_shared(
 							&pdev->dev, "ahb");
 	if (IS_ERR(plat->stmmac_ahb_rst)) {
-		stmmac_remove_config_dt(pdev, plat);
+		stmmac_remove_config_dt(plat);
 		return ERR_CAST(plat->stmmac_ahb_rst);
 	}
 
@@ -663,10 +661,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 
 static void devm_stmmac_remove_config_dt(void *data)
 {
-	struct plat_stmmacenet_data *plat = data;
-
-	/* Platform data argument is unused */
-	stmmac_remove_config_dt(NULL, plat);
+	stmmac_remove_config_dt(data);
 }
 
 /**
-- 
2.34.1


