Return-Path: <netdev+bounces-48561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C137EED32
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 392EAB209B8
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 08:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9483D302;
	Fri, 17 Nov 2023 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJVyOO8B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C65A8
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 00:10:08 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2e08526b9so349197b6e.0
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 00:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700208607; x=1700813407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j05EofG28rFbGboqZoP5R96M/5boTODVV1yGcFQG4wc=;
        b=mJVyOO8BtHnPfIpFqxpT0bIejS+A2tmjfjVCjJYE4KAPY3k349xvijqxcesUkDv+kO
         5rJ9fDTWIaqcObIm2KMkWkX9FrtNM5Kza9hWvK8CPvp4Wv88BBqVt989p9nUGXQmtCPa
         sZ2kDaFXvsVAe0MOmYsXHQwr5ejrcMcC+w7O9eMEA9eGmjwxRoCmlz5/YjJ2sHIMaghx
         k3g0whVxbvVpidItzAd3NtrpDj/QKuhJqpao5SNUOl7PizpFTaksqQEwQcS9lCI/DyMV
         WeGHMW7ebeTwEbHnwwUsB+ACiUstfvA59LhM7gfxuZ4NtE4Jvy6PkvWGxd9FSm4TFcK7
         czYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700208607; x=1700813407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j05EofG28rFbGboqZoP5R96M/5boTODVV1yGcFQG4wc=;
        b=Gq4mKaebSX7UAz8OwZjVx59GgtTPRl+HorYYphFvaaCeziFWnsUrViUlT5bsMcW43K
         svV36kGlriJhanPqMWdiaD17XnRme0fFsdqy5F4Z7Vq62Hfa3hgT6/GPNHg1FMaU756U
         bDcgTaOu+epSxivjAOijWKaC1joTUCjIA5myeAWIfjJx97UEsSDPjQAaQKFlC6UQ/4E+
         ejNmRMHRYz0A9KlaJNmR1qNBYFzmAtUa3PfpEMcRM7bXemeBJR/EnLKn6UucIWN9sLQf
         +BgP3FAnp7mc+gVlVGsOLVhE0f18jBPbtVFHV1vZtwSv8xUWVgI0NlE8C4lwQVAM9PMZ
         3igA==
X-Gm-Message-State: AOJu0Yyclkn7g7yNsTVglC6m2u3AJinkwbHYqk9QWrscJAvEkA9rk74K
	jEPhFLCoMTIoT1k9DbeDpfoSsw==
X-Google-Smtp-Source: AGHT+IHJPwPa+W+qlve0ksmPI2HbMgpB1Udyl4DkhXHf7j52pThb0yAsW1NixCCz68Z7g7sLFQuonw==
X-Received: by 2002:a05:6808:1719:b0:3b6:db1b:67b7 with SMTP id bc25-20020a056808171900b003b6db1b67b7mr13677032oib.4.1700208607310;
        Fri, 17 Nov 2023 00:10:07 -0800 (PST)
Received: from fedora.. ([240d:1a:3a7:a400:9a57:aa11:487a:b54f])
        by smtp.gmail.com with ESMTPSA id y5-20020a655a05000000b005b3a91e8a94sm765500pgs.76.2023.11.17.00.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 00:10:06 -0800 (PST)
From: Ryosuke Saito <ryosuke.saito@linaro.org>
To: jaswinder.singh@linaro.org,
	ilias.apalodimas@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	masahisa.kojima@linaro.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: netsec: replace cpu_relax() with timeout handling for register checks
Date: Fri, 17 Nov 2023 17:10:02 +0900
Message-ID: <20231117081002.60107-1-ryosuke.saito@linaro.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpu_relax() loops have the potential to hang if the specified
register bits are not met on condition. The patch replaces it with
usleep_range() and netsec_wait_while_busy() which includes timeout
logic.

Additionally, if the error condition is met during interrupting DMA
transfer, there's no recovery mechanism available. In that case, any
frames being sent or received will be discarded, which leads to
potential frame loss as indicated in the comments.

Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
---
 drivers/net/ethernet/socionext/netsec.c | 35 ++++++++++++++++---------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 0dcd6a568b06..6f9127d30a9a 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1410,21 +1410,28 @@ static int netsec_reset_hardware(struct netsec_priv *priv,
 		netsec_write(priv, NETSEC_REG_DMA_MH_CTRL,
 			     NETSEC_DMA_CTRL_REG_STOP);
 
-		while (netsec_read(priv, NETSEC_REG_DMA_HM_CTRL) &
-		       NETSEC_DMA_CTRL_REG_STOP)
-			cpu_relax();
-
-		while (netsec_read(priv, NETSEC_REG_DMA_MH_CTRL) &
-		       NETSEC_DMA_CTRL_REG_STOP)
-			cpu_relax();
+		if (netsec_wait_while_busy(priv, NETSEC_REG_DMA_HM_CTRL,
+					   NETSEC_DMA_CTRL_REG_STOP) ||
+		    netsec_wait_while_busy(priv, NETSEC_REG_DMA_MH_CTRL,
+					   NETSEC_DMA_CTRL_REG_STOP)) {
+			dev_warn(priv->dev,
+				 "%s: DMA transfer cannot be stopped.\n",
+				 __func__);
+			/* There is no recovery mechanism in place if this
+			 * error occurs. Frames may be lost.
+			 */
+		}
 	}
 
 	netsec_write(priv, NETSEC_REG_SOFT_RST, NETSEC_SOFT_RST_REG_RESET);
 	netsec_write(priv, NETSEC_REG_SOFT_RST, NETSEC_SOFT_RST_REG_RUN);
 	netsec_write(priv, NETSEC_REG_COM_INIT, NETSEC_COM_INIT_REG_ALL);
 
-	while (netsec_read(priv, NETSEC_REG_COM_INIT) != 0)
-		cpu_relax();
+	if (netsec_wait_while_busy(priv, NETSEC_REG_COM_INIT, 1)) {
+		dev_err(priv->dev,
+			"%s: failed to reset NETSEC.\n", __func__);
+		return -ETIMEDOUT;
+	}
 
 	/* set desc_start addr */
 	netsec_write(priv, NETSEC_REG_NRM_RX_DESC_START_UP,
@@ -1476,9 +1483,13 @@ static int netsec_reset_hardware(struct netsec_priv *priv,
 	netsec_write(priv, NETSEC_REG_DMA_MH_CTRL, MH_CTRL__MODE_TRANS);
 	netsec_write(priv, NETSEC_REG_PKT_CTRL, value);
 
-	while ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
-		NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0)
-		cpu_relax();
+	usleep_range(100000, 120000);
+
+	if ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
+			 NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0) {
+		dev_warn(priv->dev,
+			 "%s: trans comp timeout.\n", __func__);
+	}
 
 	/* clear any pending EMPTY/ERR irq status */
 	netsec_write(priv, NETSEC_REG_NRM_TX_STATUS, ~0);
-- 
2.34.1


