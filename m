Return-Path: <netdev+bounces-152481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939709F413B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 04:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187EA188927C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8312BCF5;
	Tue, 17 Dec 2024 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="CLds1278"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DB93FD4
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734406373; cv=none; b=o/23aYnsM98ZQ7q2G7ePc6X5BHaALyvnJKZ6bpZy15+rmhMWePwS0hRQ+DsON7kpauslvfHxpS69l6TbDBXahpiCUttRb3AKnjvUKWTSQtyF7/WH5P8NM+v3t8AdxtHIY1vS7VvTiudL3XbKULT7G0RagHmZ1WsbvGPi+Hgvqko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734406373; c=relaxed/simple;
	bh=SNtoa0pDAOzUprFo9FlL6xr6DBu2/gDMCWq5EAxdEZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VxjlD7bv0MdzP2CakJKDuSKnlJvR0FGrl7bu00i7NnYSrBY5fa5+tTuebkwUMeiXBm8RDcMlZAjcGy8w+yhRvLhOXwxKKE0qXRPqmaEwGX6HhvWSaxlZ3B/rLkqz+h1akKlHu3Uzb8KKtMQ83JIVONZuYte3YUWRzJPZvL178xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=CLds1278; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so3582835a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 19:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734406370; x=1735011170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=myVN/9GCj+EmMAD6BspesgmygYT45vKeG7/Zqor3VFE=;
        b=CLds12783o5nnPlN4vwVVsLpVnmqhWpDjdit5qiGXPeNhL5Zc/vV4PorzfCbsuqG2h
         srv+4stWHonBTn0r9Vyw/6pi3D0+FBlNT0KusZB1XLSSp8hWhTCCC1dyfD9Wi6yPUi/K
         Qs7KDxYDbREOg4uBfqVfIyLzwkuqCH2qqC1WSrPI8sm5oH89ouBDDpEU6I7FvX3NBmbg
         JY0qdoKqg6k74jn937MEuQgu6iICv1XKT0abfbXDMU5yhbhD8+5aQozKgfpNiixqU47G
         GaDHkgYuYyrMj/L4ZPMcepoe0gp263vIuUDRo/pMEkWyVr7gJeqReW6lpf9FDppO7LYS
         ivXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734406370; x=1735011170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myVN/9GCj+EmMAD6BspesgmygYT45vKeG7/Zqor3VFE=;
        b=W8GyLZfBnRtoS8StmHevroEOIM3olOgCuxtQ0XnLiNcTk2blp6+0Ud1eUjt228gbDn
         KFh1tgZC2eOTE6p4KLc5KtsLV9C88u6VPhfzcecNRZ1odjmLsDhJryUKxWG7pAaYbFMB
         aykBuvxXBqPUIbhMNfZ72SpmwWU+UJf46M+oeFBRtsrAsTXpuo3Ci5mfma96DytO8snN
         uE+jQU4zXR3zr+4l4YSlwrbgv12OEFieyuROKbWU3aC0TSitEMLClFV/i2DvAb1COFRO
         tL7cWzedb9BZhgN3mzCc3FCDe+5bgCqJzCpEAo6/WLELHR/Z1MfXFKavnlA3PYKycSFV
         9GcQ==
X-Gm-Message-State: AOJu0Yyr8oO7Z/OUVkTyCfdGk1T3RiGoTgAshyi3qhRLZucurEWkH5oB
	tXhGKSVdeUwtPudyDtFsLPcl4P/V4Ra5PBA/vvX0nNtNoR9bkQ50zOfFRnL6bNc=
X-Gm-Gg: ASbGncsmEoGljTTmf0Xv94ndBzBkNLCqae6sb2xRj66d7vqYlyopYgVk72DijEDX7vE
	yjHJL8s0qrYiT42MTfLQcvF8o1wCOYunYN5W4fzGvcN4QE0k1UHhrKYTb2ZlG/w+xSJyAD0v1sc
	JzuN8YDEICBkJv/q4NqrZnKth4jHlbn+G4WKLBTEj4YHon4Sxf9vbRMxUemdBZIciGKgZNZ2GzB
	Mn1O/w+X3FBKuXMv8hPnc6z7EP9vIyk9h6phvhJyE1+JZYwcknZcuQY/lnBpJazRLV4QUGyXmyx
	axB2ejNXqVgeELonB1qh9zm6h7hzm8CObiFmJZgUkgU=
X-Google-Smtp-Source: AGHT+IFs58B+k6lMPpaCdheVW5S9Rl7Kana0ZhmZ7Jxy01AyEzIQdJxut+BvfMUFwi1BT+GAf0OMGA==
X-Received: by 2002:a17:90b:1fc3:b0:2ee:b0f1:ba17 with SMTP id 98e67ed59e1d1-2f2903a2ddemr21300287a91.37.1734406370115;
        Mon, 16 Dec 2024 19:32:50 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2434a17sm6210837a91.37.2024.12.16.19.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 19:32:49 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] net: stmmac: call stmmac_remove_config_dt() in error paths in stmmac_probe_config_dt()
Date: Tue, 17 Dec 2024 12:32:43 +0900
Message-Id: <20241217033243.3144184-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of stmmac_probe_config_dt() does not release the
OF node reference obtained by of_parse_phandle() when stmmac_dt_phy()
fails, thus call stmmac_remove_config_dt(). The error_hw_init and
error_pclk_get labels can be removed as just calling
stmmac_remove_config_dt() suffices. Also, remove the first argument of
stmmac_remove_config_dt() as it is not used.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: 4838a5405028 ("net: stmmac: Fix wrapper drivers not detecting PHY")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 37 +++++++------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3ac32444e492..4f1a9f7aae6e 100644
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
@@ -436,7 +434,6 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_dma_cfg *dma_cfg;
 	int phy_mode;
-	void *ret;
 	int rc;
 
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
@@ -490,8 +487,10 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
 
 	rc = stmmac_mdio_setup(plat, np, &pdev->dev);
-	if (rc)
+	if (rc) {
+		stmmac_remove_config_dt(plat);
 		return ERR_PTR(rc);
+	}
 
 	of_property_read_u32(np, "tx-fifo-depth", &plat->tx_fifo_size);
 
@@ -581,7 +580,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*dma_cfg),
 			       GFP_KERNEL);
 	if (!dma_cfg) {
-		stmmac_remove_config_dt(pdev, plat);
+		stmmac_remove_config_dt(plat);
 		return ERR_PTR(-ENOMEM);
 	}
 	plat->dma_cfg = dma_cfg;
@@ -610,7 +609,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 
 	rc = stmmac_mtl_setup(pdev, plat);
 	if (rc) {
-		stmmac_remove_config_dt(pdev, plat);
+		stmmac_remove_config_dt(plat);
 		return ERR_PTR(rc);
 	}
 
@@ -627,8 +626,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 
 	plat->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
 	if (IS_ERR(plat->pclk)) {
-		ret = plat->pclk;
-		goto error_pclk_get;
+		stmmac_remove_config_dt(plat);
+		return ERR_CAST(plat->pclk);
 	}
 	clk_prepare_enable(plat->pclk);
 
@@ -646,33 +645,23 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	plat->stmmac_rst = devm_reset_control_get_optional(&pdev->dev,
 							   STMMAC_RESOURCE_NAME);
 	if (IS_ERR(plat->stmmac_rst)) {
-		ret = plat->stmmac_rst;
-		goto error_hw_init;
+		stmmac_remove_config_dt(plat);
+		return ERR_CAST(plat->stmmac_rst);
 	}
 
 	plat->stmmac_ahb_rst = devm_reset_control_get_optional_shared(
 							&pdev->dev, "ahb");
 	if (IS_ERR(plat->stmmac_ahb_rst)) {
-		ret = plat->stmmac_ahb_rst;
-		goto error_hw_init;
+		stmmac_remove_config_dt(plat);
+		return ERR_CAST(plat->stmmac_ahb_rst);
 	}
 
 	return plat;
-
-error_hw_init:
-	clk_disable_unprepare(plat->pclk);
-error_pclk_get:
-	clk_disable_unprepare(plat->stmmac_clk);
-
-	return ret;
 }
 
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


