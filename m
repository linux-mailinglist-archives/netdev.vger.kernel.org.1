Return-Path: <netdev+bounces-116684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF73294B5BB
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFE31C2125A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A7F7F484;
	Thu,  8 Aug 2024 04:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqeT5Wvm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73B11C83;
	Thu,  8 Aug 2024 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723089869; cv=none; b=pSNES5ZbUB+6s0Wmo/SVFbTiCyvXcYd1Bi5h2G0IZ94LHOe/y65BUkLFclZ2Lj/qgefZrD/aFKp5OKK96EteAI+eELpg8fRCav5RFiOOhO3+/zxWxg4d9x2vKrm4bCY7dP4H6HRwsP+JzYRrFD+RaCEw7wmMv/D2+dfVe9Kcpjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723089869; c=relaxed/simple;
	bh=HxsNmQeveDje+k7GJ5p0ExaAXkD5Uz24koDvUfEl56g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J3zHaCGIy/gFtrgjCqZucn3FlAdpe7q75ldu1d+WDq+ps5n0FA5XMpkQsJV7r243UNdCHsXMn5dk+YYJiLDadzm1+DFCHMfOF70bJsUTSyoSS2vjaUbAXmM4Cq4xNutItyMf9ZTQ0M10f5XAMtU3UwlDyH1uo96+XTC0oryaT4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqeT5Wvm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d1c655141so472865b3a.1;
        Wed, 07 Aug 2024 21:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723089867; x=1723694667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qB4AbGWugMyClxVBVAdAWXyEbSp0MuqOJuxSTPl9cMA=;
        b=eqeT5WvmY+7F00UbbT00nxrL3GWHU+fgTxXIcmnKb9tcCnOiyv8ceayYseKVAznQ8A
         O3qPFFfZO5RQh1zNLIKj7QoTW8bfcDJBXzL+ybvvu21oHY8aSfrbqKy/Zz2fFE/IOTS3
         NTsjl2kdRgZVlRGfxCcxoQKJjvNUHP1ps3ldXXDih1/f5YRxKLFgIQfNrK8YvUJyZLuF
         VkmHfXyCm7H7woBbuILhzZmrJyAJ3ZGFbqi04AGYxMuN6EuYhsM18x7qGM1SKWZjsi3D
         bCJsk1UDMNR/2yQB1MXqRAFWGPkuM1kZzgkQEjv2y6q3m5FVfCz1fsnITEgEd5vX64FA
         vNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723089867; x=1723694667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qB4AbGWugMyClxVBVAdAWXyEbSp0MuqOJuxSTPl9cMA=;
        b=gUNnggHkjfX38jqTm6nDyYFIajaBM95+kSzx0ef5pNe+PDmZpeY+0JYWwxDXGs8eUR
         GSBvjLU4uR52CtojdLAlxeCneK+Cg86IuE8SI7E/LqJ8m9cj8p8NwmCz6xDaUExTt57i
         ecZNVSsBbWDVM2Tob9sC8r6xb9XqCaEzXivXBL2yBJD/xaunnVlYoiF+U21ssn3GV20P
         iawFO7Zw6bxnNbyGUxFkFXG0m0ZmgkCZ+mILF/AvJf64R4EZ1Q2mLNuCQL8CdiPiRbYg
         2NLQfH3ZUFpX6LFwxxg8hnynsXdYs0o1Uu7GbcpXHVEj6dVkANp/f4jaieOfgOKOLaeF
         JlHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXiw3xv4EI+39jcWGxvoGGwoflKv3iVe76eN7KxgwgJTz15TQiI0Q9jDqNDUHQG0YNmE88gPdHMFHwJ9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YykqDs+KaD/g+aeP5cYAAg5LW68dJ8JacjOoWO35PxFlCo5Fndo
	g0Wfx8UpuJSLdKw2TiwzqNhtqb1q2GSPLci3EwD+YgZLqeXyfyDgzzFn4uCQ
X-Google-Smtp-Source: AGHT+IE9Ln7CAAMnFGaiJTlhxb+rKtE1cwgbtM0VGmLbzx+hc9LQk2kprlXX3MVoq/8wRBaDLvW5HA==
X-Received: by 2002:a05:6a00:2d16:b0:706:6c38:31f3 with SMTP id d2e1a72fcca58-710cad6d366mr975637b3a.8.1723089867385;
        Wed, 07 Aug 2024 21:04:27 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb20d602sm274767b3a.5.2024.08.07.21.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 21:04:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: u.kleine-koenig@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: moxart_ether: use devm in probe
Date: Wed,  7 Aug 2024 21:03:54 -0700
Message-ID: <20240808040425.5833-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_etherdev and kmalloc_array are called first and destroyed last.
Safe to use devm to remove frees.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/moxa/moxart_ether.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index 96dc69e7141f..06c632c90494 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -81,9 +81,6 @@ static void moxart_mac_free_memory(struct net_device *ndev)
 		dma_free_coherent(&priv->pdev->dev,
 				  RX_REG_DESC_SIZE * RX_DESC_NUM,
 				  priv->rx_desc_base, priv->rx_base);
-
-	kfree(priv->tx_buf_base);
-	kfree(priv->rx_buf_base);
 }
 
 static void moxart_mac_reset(struct net_device *ndev)
@@ -461,15 +458,14 @@ static int moxart_mac_probe(struct platform_device *pdev)
 	unsigned int irq;
 	int ret;
 
-	ndev = alloc_etherdev(sizeof(struct moxart_mac_priv_t));
+	ndev = devm_alloc_etherdev(p_dev, sizeof(struct moxart_mac_priv_t));
 	if (!ndev)
 		return -ENOMEM;
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (irq <= 0) {
 		netdev_err(ndev, "irq_of_parse_and_map failed\n");
-		ret = -EINVAL;
-		goto irq_map_fail;
+		return -EINVAL;
 	}
 
 	priv = netdev_priv(ndev);
@@ -511,15 +507,15 @@ static int moxart_mac_probe(struct platform_device *pdev)
 		goto init_fail;
 	}
 
-	priv->tx_buf_base = kmalloc_array(priv->tx_buf_size, TX_DESC_NUM,
-					  GFP_KERNEL);
+	priv->tx_buf_base = devm_kmalloc_array(p_dev, priv->tx_buf_size,
+					       TX_DESC_NUM, GFP_KERNEL);
 	if (!priv->tx_buf_base) {
 		ret = -ENOMEM;
 		goto init_fail;
 	}
 
-	priv->rx_buf_base = kmalloc_array(priv->rx_buf_size, RX_DESC_NUM,
-					  GFP_KERNEL);
+	priv->rx_buf_base = devm_kmalloc_array(p_dev, priv->rx_buf_size,
+					       RX_DESC_NUM, GFP_KERNEL);
 	if (!priv->rx_buf_base) {
 		ret = -ENOMEM;
 		goto init_fail;
@@ -553,8 +549,6 @@ static int moxart_mac_probe(struct platform_device *pdev)
 init_fail:
 	netdev_err(ndev, "init failed\n");
 	moxart_mac_free_memory(ndev);
-irq_map_fail:
-	free_netdev(ndev);
 	return ret;
 }
 
@@ -565,7 +559,6 @@ static void moxart_remove(struct platform_device *pdev)
 	unregister_netdev(ndev);
 	devm_free_irq(&pdev->dev, ndev->irq, ndev);
 	moxart_mac_free_memory(ndev);
-	free_netdev(ndev);
 }
 
 static const struct of_device_id moxart_mac_match[] = {
-- 
2.45.2


