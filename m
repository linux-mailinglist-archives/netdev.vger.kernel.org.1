Return-Path: <netdev+bounces-126268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E033970465
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 00:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7D01C210EE
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 22:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439AA16C68B;
	Sat,  7 Sep 2024 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTZK6vjr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DE716BE13;
	Sat,  7 Sep 2024 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725747718; cv=none; b=UZSsX0luK7osbxp3BoXcq0p0VPWu/Dw6MtWNxncSopaQaPv7RkFotdhSC4o4yDfppbQV3EIkFfWK6XFeeM2EuCXvby6sS9QOayvfr2Kb0AhvLx2n40X4VceE+Kn1HSy7xebfFshK8mB9Uc1wHy5TW4ubAcIER2huzojFi90pOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725747718; c=relaxed/simple;
	bh=DiDDJP6Pm2z/OTNn+uGgEtWoySH0EoDuDh525D4cvBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nM1j1SS5aa3qFp69rXflfG3uhaBolGiGmrna6k2tePDIHFpnr/the8EblIjNBtPm+fRafw7B9WOnkbHsuN5PdlPpDam/HW2vVaODjbgiaNjcQwSiCxhCb5DJ4zJZWCUuaL/1Z/1pjUXZR41irZ1cxfGHBZn485K4tRox4mJo5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTZK6vjr; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so2412354a12.1;
        Sat, 07 Sep 2024 15:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725747715; x=1726352515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRCIdYnIa2p6nZZlzYLZy1O5bnyhZ6eDPBWIoa9hH9Q=;
        b=cTZK6vjrRX5LsMHyGcVTZh6NVIbwkGfdrXdOMZHZ+mhp0IezjLyiIXjB1RTaIedGVd
         cdaK3C9+xU+h4Q09Kj5KRo5kcfw9vvaZadjsADN5rLPXBzZ4Fdix4KQZTyXkQKs0njcn
         anXDy67u91rrOj7THNyfAoAXApes5h+I+tPB9oC2h8qPUOtRK5q4ZWdfnSX3flLQkxxZ
         vxqu+NDCvEODRCLee7SWyp3kP5Kb91a6UXWL3h3uZnmOnoUVUsek1TjZmVZGfoYSz9NM
         8HnwLPAd0yU/MyEdJ11UBYl1T4NnOrRUjHqiOF0sodQ+ZgYKG0p42gWI05HedXba7/PM
         HTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725747715; x=1726352515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRCIdYnIa2p6nZZlzYLZy1O5bnyhZ6eDPBWIoa9hH9Q=;
        b=p6yE02ivT9Q5+sE7DxLwIRaoUXH3MQlUKQUbn1vwQGR0ThY2ixyEdJemRV6dj2vd0Q
         HRfALO+uuLGxvwa50B6w/t7hSfF/JYhUlZ8nLCu5Xm3rPIL+RgKkQkYedqzelyY8ZCGA
         eGdgs8ZgYc6FjKsiE4Po3Rr5h3/zv8Nd52XLvEtQEjSee6zQ5XK9ca717SQE7hKycgKN
         svsvob6AnTLGvirNssSEAAeztyGSrEP4VwFr46F/huozAdXDnhYWGhe3dMegpz6KyfgA
         MPxc8g0uS6BOS5kOwSl5KC6eWfT2ziKk8esoPIjhcGBbexBOtRFz5ErkkTgOBfyVDN3R
         yOfg==
X-Forwarded-Encrypted: i=1; AJvYcCXruDYfteE/76BoTE9lV+XMTxdU45fFR0ug1js8x1wmit9msp+0XsC8aiM8HVk5OnvycHMjhs91Gxc/VGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhd72vDu4wK1McbLstcqJF5+ZLFr8mWscnuigJRuXEmfWsVXdh
	lf4kOSn8xqYtL+eNctlMm3Bbj1mFpOGIMdSb8r58djmW5y9K6DSHAWFkkl0+
X-Google-Smtp-Source: AGHT+IEfgT5cKoq7ClzOLcbQtZuxZ77W+Kug8efojSR9Qj7spDtRbec4EsEo4WTB+T7+O5BVzaeyqw==
X-Received: by 2002:a05:6a21:385:b0:1ce:e975:7017 with SMTP id adf61e73a8af0-1cf1c10851dmr9153251637.16.1725747715413;
        Sat, 07 Sep 2024 15:21:55 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d860a4d202sm1077198a12.85.2024.09.07.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 15:21:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next 4/4] net: ibm: emac: mal: use devm and dev_err
Date: Sat,  7 Sep 2024 15:21:47 -0700
Message-ID: <20240907222147.21723-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907222147.21723-1-rosenp@gmail.com>
References: <20240907222147.21723-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the driver by removing manual frees and using dev_err instead
of printk. pdev->dev has the of_node name in it. eg.

MAL v2 /plb/mcmal, 1 TX channels, 1 RX channels

vs

mcmal plb:mcmal: MAL version 2, 1 TX channels, 1 RX channels

Close enough

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 144 ++++++++++++----------------
 1 file changed, 61 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index d92dd9c83031..ceee51781c1e 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -513,7 +513,7 @@ void *mal_dump_regs(struct mal_instance *mal, void *buf)
 	return regs + 1;
 }
 
-static int mal_probe(struct platform_device *ofdev)
+static int mal_probe(struct platform_device *pdev)
 {
 	struct mal_instance *mal;
 	int err = 0, i, bd_size;
@@ -524,79 +524,71 @@ static int mal_probe(struct platform_device *ofdev)
 	unsigned long irqflags;
 	irq_handler_t hdlr_serr, hdlr_txde, hdlr_rxde;
 
-	mal = kzalloc(sizeof(struct mal_instance), GFP_KERNEL);
+	mal = devm_kzalloc(&pdev->dev, sizeof(struct mal_instance), GFP_KERNEL);
 	if (!mal)
 		return -ENOMEM;
 
 	mal->index = index;
-	mal->ofdev = ofdev;
-	mal->version = of_device_is_compatible(ofdev->dev.of_node, "ibm,mcmal2") ? 2 : 1;
+	mal->ofdev = pdev;
+	if (of_device_is_compatible(pdev->dev.of_node, "ibm,mcmal2"))
+		mal->version = 2;
+	else
+		mal->version = 1;
 
 	MAL_DBG(mal, "probe" NL);
 
-	prop = of_get_property(ofdev->dev.of_node, "num-tx-chans", NULL);
-	if (prop == NULL) {
-		printk(KERN_ERR
-		       "mal%d: can't find MAL num-tx-chans property!\n",
-		       index);
-		err = -ENODEV;
-		goto fail;
+	prop = of_get_property(pdev->dev.of_node, "num-tx-chans", NULL);
+	if (!prop) {
+		dev_err(&pdev->dev,
+			"mal%d: can't find MAL num-tx-chans property", index);
+		return -ENODEV;
 	}
 	mal->num_tx_chans = prop[0];
 
-	prop = of_get_property(ofdev->dev.of_node, "num-rx-chans", NULL);
-	if (prop == NULL) {
-		printk(KERN_ERR
-		       "mal%d: can't find MAL num-rx-chans property!\n",
-		       index);
-		err = -ENODEV;
-		goto fail;
+	prop = of_get_property(pdev->dev.of_node, "num-rx-chans", NULL);
+	if (!prop) {
+		dev_err(&pdev->dev,
+			"mal%d: can't find MAL num-rx-chans property", index);
+		return -ENODEV;
 	}
 	mal->num_rx_chans = prop[0];
 
-	dcr_base = dcr_resource_start(ofdev->dev.of_node, 0);
+	dcr_base = dcr_resource_start(pdev->dev.of_node, 0);
 	if (dcr_base == 0) {
-		printk(KERN_ERR
-		       "mal%d: can't find DCR resource!\n", index);
-		err = -ENODEV;
-		goto fail;
+		dev_err(&pdev->dev, "mal%d: can't find DCR resource", index);
+		return -ENODEV;
 	}
-	mal->dcr_host = dcr_map(ofdev->dev.of_node, dcr_base, 0x100);
+	mal->dcr_host = dcr_map(pdev->dev.of_node, dcr_base, 0x100);
 	if (!DCR_MAP_OK(mal->dcr_host)) {
-		printk(KERN_ERR
-		       "mal%d: failed to map DCRs !\n", index);
-		err = -ENODEV;
-		goto fail;
+		dev_err(&pdev->dev, "mal%d: failed to map DCRs", index);
+		return -ENODEV;
 	}
 
-	if (of_device_is_compatible(ofdev->dev.of_node, "ibm,mcmal-405ez")) {
+	if (of_device_is_compatible(pdev->dev.of_node, "ibm,mcmal-405ez")) {
 #if defined(CONFIG_IBM_EMAC_MAL_CLR_ICINTSTAT) && \
 		defined(CONFIG_IBM_EMAC_MAL_COMMON_ERR)
 		mal->features |= (MAL_FTR_CLEAR_ICINTSTAT |
 				MAL_FTR_COMMON_ERR_INT);
 #else
-		printk(KERN_ERR "%pOF: Support for 405EZ not enabled!\n",
-				ofdev->dev.of_node);
-		err = -ENODEV;
-		goto fail;
+		dev_err(&pdev->dev, "support for 405EZ not enabled");
+		return -ENODEV;
 #endif
 	}
 
-	mal->txeob_irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
-	mal->rxeob_irq = irq_of_parse_and_map(ofdev->dev.of_node, 1);
-	mal->serr_irq = irq_of_parse_and_map(ofdev->dev.of_node, 2);
+	mal->txeob_irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	mal->rxeob_irq = irq_of_parse_and_map(pdev->dev.of_node, 1);
+	mal->serr_irq = irq_of_parse_and_map(pdev->dev.of_node, 2);
 
 	if (mal_has_feature(mal, MAL_FTR_COMMON_ERR_INT)) {
 		mal->txde_irq = mal->rxde_irq = mal->serr_irq;
 	} else {
-		mal->txde_irq = irq_of_parse_and_map(ofdev->dev.of_node, 3);
-		mal->rxde_irq = irq_of_parse_and_map(ofdev->dev.of_node, 4);
+		mal->txde_irq = irq_of_parse_and_map(pdev->dev.of_node, 3);
+		mal->rxde_irq = irq_of_parse_and_map(pdev->dev.of_node, 4);
 	}
 
 	if (!mal->txeob_irq || !mal->rxeob_irq || !mal->serr_irq ||
 	    !mal->txde_irq  || !mal->rxde_irq) {
-		printk(KERN_ERR
-		       "mal%d: failed to map interrupts !\n", index);
+		dev_err(&pdev->dev, "mal%d: failed to map interrupts", index);
 		err = -ENODEV;
 		goto fail_unmap;
 	}
@@ -624,7 +616,7 @@ static int mal_probe(struct platform_device *ofdev)
 	/* Current Axon is not happy with priority being non-0, it can
 	 * deadlock, fix it up here
 	 */
-	if (of_device_is_compatible(ofdev->dev.of_node, "ibm,mcmal-axon"))
+	if (of_device_is_compatible(pdev->dev.of_node, "ibm,mcmal-axon"))
 		cfg &= ~(MAL2_CFG_RPP_10 | MAL2_CFG_WPP_10);
 
 	/* Apply configuration */
@@ -637,7 +629,7 @@ static int mal_probe(struct platform_device *ofdev)
 	bd_size = sizeof(struct mal_descriptor) *
 		(NUM_TX_BUFF * mal->num_tx_chans +
 		 NUM_RX_BUFF * mal->num_rx_chans);
-	mal->bd_virt = dma_alloc_coherent(&ofdev->dev, bd_size, &mal->bd_dma,
+	mal->bd_virt = dma_alloc_coherent(&pdev->dev, bd_size, &mal->bd_dma,
 					  GFP_KERNEL);
 	if (mal->bd_virt == NULL) {
 		err = -ENOMEM;
@@ -664,21 +656,26 @@ static int mal_probe(struct platform_device *ofdev)
 		hdlr_rxde = mal_rxde;
 	}
 
-	err = request_irq(mal->serr_irq, hdlr_serr, irqflags, "MAL SERR", mal);
+	err = devm_request_irq(&pdev->dev, mal->serr_irq, hdlr_serr, irqflags,
+			       "MAL SERR", mal);
 	if (err)
 		goto fail2;
-	err = request_irq(mal->txde_irq, hdlr_txde, irqflags, "MAL TX DE", mal);
+	err = devm_request_irq(&pdev->dev, mal->txde_irq, hdlr_txde, irqflags,
+			       "MAL TX DE", mal);
 	if (err)
-		goto fail3;
-	err = request_irq(mal->txeob_irq, mal_txeob, 0, "MAL TX EOB", mal);
+		goto fail2;
+	err = devm_request_irq(&pdev->dev, mal->txeob_irq, mal_txeob, 0,
+			       "MAL TX EOB", mal);
 	if (err)
-		goto fail4;
-	err = request_irq(mal->rxde_irq, hdlr_rxde, irqflags, "MAL RX DE", mal);
+		goto fail2;
+	err = devm_request_irq(&pdev->dev, mal->rxde_irq, hdlr_rxde, irqflags,
+			       "MAL RX DE", mal);
 	if (err)
-		goto fail5;
-	err = request_irq(mal->rxeob_irq, mal_rxeob, 0, "MAL RX EOB", mal);
+		goto fail2;
+	err = devm_request_irq(&pdev->dev, mal->rxeob_irq, mal_rxeob, 0,
+			       "MAL RX EOB", mal);
 	if (err)
-		goto fail6;
+		goto fail2;
 
 	/* Enable all MAL SERR interrupt sources */
 	set_mal_dcrn(mal, MAL_IER, MAL_IER_EVENTS);
@@ -686,40 +683,28 @@ static int mal_probe(struct platform_device *ofdev)
 	/* Enable EOB interrupt */
 	mal_enable_eob_irq(mal);
 
-	printk(KERN_INFO
-	       "MAL v%d %pOF, %d TX channels, %d RX channels\n",
-	       mal->version, ofdev->dev.of_node,
-	       mal->num_tx_chans, mal->num_rx_chans);
+	dev_err(&pdev->dev, "MAL version %d, %d TX channels, %d RX channels",
+		mal->version, mal->num_tx_chans, mal->num_rx_chans);
 
 	/* Advertise this instance to the rest of the world */
 	wmb();
-	platform_set_drvdata(ofdev, mal);
+	platform_set_drvdata(pdev, mal);
 
 	return 0;
 
- fail6:
-	free_irq(mal->rxde_irq, mal);
- fail5:
-	free_irq(mal->txeob_irq, mal);
- fail4:
-	free_irq(mal->txde_irq, mal);
- fail3:
-	free_irq(mal->serr_irq, mal);
- fail2:
-	dma_free_coherent(&ofdev->dev, bd_size, mal->bd_virt, mal->bd_dma);
- fail_dummy:
+fail2:
+	dma_free_coherent(&pdev->dev, bd_size, mal->bd_virt, mal->bd_dma);
+fail_dummy:
 	free_netdev(mal->dummy_dev);
- fail_unmap:
+fail_unmap:
 	dcr_unmap(mal->dcr_host, 0x100);
- fail:
-	kfree(mal);
 
 	return err;
 }
 
-static void mal_remove(struct platform_device *ofdev)
+static void mal_remove(struct platform_device *pdev)
 {
-	struct mal_instance *mal = platform_get_drvdata(ofdev);
+	struct mal_instance *mal = platform_get_drvdata(pdev);
 
 	MAL_DBG(mal, "remove" NL);
 
@@ -732,22 +717,15 @@ static void mal_remove(struct platform_device *ofdev)
 		       "mal%d: commac list is not empty on remove!\n",
 		       mal->index);
 
-	free_irq(mal->serr_irq, mal);
-	free_irq(mal->txde_irq, mal);
-	free_irq(mal->txeob_irq, mal);
-	free_irq(mal->rxde_irq, mal);
-	free_irq(mal->rxeob_irq, mal);
-
 	mal_reset(mal);
 
 	free_netdev(mal->dummy_dev);
 
-	dma_free_coherent(&ofdev->dev,
+	dma_free_coherent(&pdev->dev,
 			  sizeof(struct mal_descriptor) *
-			  (NUM_TX_BUFF * mal->num_tx_chans +
-			   NUM_RX_BUFF * mal->num_rx_chans), mal->bd_virt,
-			  mal->bd_dma);
-	kfree(mal);
+				  (NUM_TX_BUFF * mal->num_tx_chans +
+				   NUM_RX_BUFF * mal->num_rx_chans),
+			  mal->bd_virt, mal->bd_dma);
 }
 
 static const struct of_device_id mal_platform_match[] =
-- 
2.46.0


