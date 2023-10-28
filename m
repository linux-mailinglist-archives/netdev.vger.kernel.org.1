Return-Path: <netdev+bounces-45026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 051AE7DA952
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 22:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1406D1C20940
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 20:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977A78F5D;
	Sat, 28 Oct 2023 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPUocww3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207728F9
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 20:48:43 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00847B8
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 13:48:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507e85ebf50so4473334e87.1
        for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698526120; x=1699130920; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YVLQjXVLKZfGCSGch/qGFr8re6qYrJR23uX27QZ5BbI=;
        b=UPUocww3P8hragmlvqHKHM1kAfZDoyiO12bcrM282lqvAjJov/aUmHudFhiTttvMB0
         6oBEb4/7cPiqNmFUdoh8q7LnRvlegqtpp6v/BQtFDjPWIoeC4QMLUtxbEIG6lt3E14B4
         h2TIHyVfHwFk8UHVfa0JNksr7BfbFUhqfKeLoedN5ZTODwamQ4jrzaOCmcOJt/Sivwh+
         RmotqlevDs+a6Ytts+m9+JnaI/PtTWRFO4O0+3jIwu2aGBKREA2UtyJl2m5iVEsdvewK
         CuEha96BlWH4NbcSkF6FVDDEflawgp+oVb2yPsXMAl8VEI5Ko7kCZgwwQkRHH55lf4tR
         G1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698526120; x=1699130920;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVLQjXVLKZfGCSGch/qGFr8re6qYrJR23uX27QZ5BbI=;
        b=c1RGObbwuKlvUPV9wu3l8L2sfmXXFugvqC1j3KmPN2Vqdt3TXa5A+zIFhPnkexKpIE
         ceqooXDeog7fphN0TQulOK0amCFPfudn7iaH4+xuTFJsEYAt4KD8oNvyuhyT4iVn5R2K
         Q3fJ23cYikvT18vFSXdJ9vgY61C9Qe/X3BH6OYE/ClG7k/+kPgQEpA2Bs2/zb8ny1ZZz
         72c6MiZ4XUPgKlqvj/OZdIFpJ7Aqph2JpSGFj/xwuy76dIm+bJ3VoAyZl69ssxjWcquU
         audBgB2kQfTb8fuEFJ16zNgHq1MLiYyVO/hf/PWFMt5dbQQJOU3nWb7zkn3gacdrnYwo
         26Ew==
X-Gm-Message-State: AOJu0YyZrlx0hyv6QaJsK4qf8wQvZUdLcjII4LHuBdV1vBKr8mcGr7Sg
	Sh4MYJYNEbM2DavstFMklAzvyw==
X-Google-Smtp-Source: AGHT+IEbWdI89KrKJ0QcwjzCF/uBDgK1n6sTTVv+58ModTMzwrwhkH4H6gODqlwhlitRT3Pkz1fpzA==
X-Received: by 2002:a05:6512:324a:b0:4fa:5e76:7ad4 with SMTP id c10-20020a056512324a00b004fa5e767ad4mr3946367lfr.10.1698526120201;
        Sat, 28 Oct 2023 13:48:40 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n4-20020ac24904000000b0050300e013f3sm770940lfi.254.2023.10.28.13.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 13:48:39 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 28 Oct 2023 22:48:35 +0200
Subject: [PATCH net-next] net: xscale: Drop unused PHY number
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231028-ixp4xx-eth-id-v1-1-57be486d7f0f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKJzPWUC/x2MSQqAMAwAv1JyNmCr4PIV8aA1ai61tEUC4t8NH
 odh5oFMiSnDaB5IdHPmKyjYyoA/l3AQ8qYMrnaNrV2PLLEVQSqnGuw2tw67Cut70CYm2ln+3wS
 BCgaSAvP7fp1i1YtpAAAA
To: Krzysztof Halasa <khalasa@piap.pl>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Howard Harte <hharte@magicandroidapps.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

For some cargoculted reason on incomplete cleanup, we have a
PHY number which refers to nothing and gives confusing messages
about PHY 0 on all ports.

Print the name of the actual PHY device instead.

Reported-by: Howard Harte <hharte@magicandroidapps.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 3b0c5f177447..711f2727fa33 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -154,7 +154,6 @@ typedef void buffer_t;
 
 /* Information about built-in Ethernet MAC interfaces */
 struct eth_plat_info {
-	u8 phy;		/* MII PHY ID, 0 - 31 */
 	u8 rxq;		/* configurable, currently 0 - 31 only */
 	u8 txreadyq;
 	u8 hwaddr[ETH_ALEN];
@@ -1520,7 +1519,7 @@ static int ixp4xx_eth_probe(struct platform_device *pdev)
 	if ((err = register_netdev(ndev)))
 		goto err_phy_dis;
 
-	netdev_info(ndev, "%s: MII PHY %i on %s\n", ndev->name, plat->phy,
+	netdev_info(ndev, "%s: MII PHY %s on %s\n", ndev->name, phydev_name(phydev),
 		    npe_name(port->npe));
 
 	return 0;

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20231028-ixp4xx-eth-id-7d2b9f1021c8

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


