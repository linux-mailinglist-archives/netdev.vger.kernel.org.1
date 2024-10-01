Return-Path: <netdev+bounces-130996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636BB98C596
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959901C21349
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BE71CEAAB;
	Tue,  1 Oct 2024 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhqZfTe/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8231CDA3F;
	Tue,  1 Oct 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808376; cv=none; b=lPYbreZphiO64VL3XiInlpO609ndL6ZZFrb+YthiA8uD6n7tR/TtmqnnTODfY7+7oWsVeTPU6895UBMyA1A+bXioGyYNWtekfHGj7N32XSlUTlubFpSv0JjoGlh1gXyh2egfV1N/S7g4PnUOWbd5xAUkc7BYN5oXVCSNs5Tv/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808376; c=relaxed/simple;
	bh=RV8dk0EnCulbVbPhN8hMIAvbnxDjyjvcVSxawAEPebE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCd7ne1o5UeqInK1ZWSoXNApbcnpm4n8Y4qYqXjlGXpxadqkx3tgQYqRutnlyVVOue6f76TN3DEXjko8gygFCoOC2UeJL2/aosgSF6j3TKfnsZ9Y6ouzEZir59LiQWNhldvLMkmX1k71zTbJiaN7z0No7Q4ICo7DK/lmdhITc0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhqZfTe/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ba9f3824fso11406385ad.0;
        Tue, 01 Oct 2024 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808374; x=1728413174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF8fdTeeyPCDuzbPxMkFvzHsTUX68pxONz2CuYTvJXQ=;
        b=ZhqZfTe/eVIP002zkEh5HMukSV2bXI/cIkBHHnF8EYoO7uz+Hni4st2l3RlsyN+xX6
         vid5ej5tbgayFiPJb8ZM+WGi4fa37FEYATEOXM9rAit36+R93n+a6pMkVK5E7/lcZUOV
         uf/n16GnP7shy0FDq/+9pDnPLK0XjKrLv64ruiCVKICoTJnoSCYNy+exGGn3HD8tL/YT
         CMj8zn7+cgOjnkghjcCptpPs1yZbjfgbHykc65NO96FYy1FxWC5lD+7co73dzYLWELJJ
         Hd8sRrLouBMxfdrj4byGaRWPbDSfMtaGpIGmdbtQPqG33UCXYoX66Dj8Enyjte3f0ekU
         35fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808374; x=1728413174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF8fdTeeyPCDuzbPxMkFvzHsTUX68pxONz2CuYTvJXQ=;
        b=E/Wt9R9GR1UsF2ZJqhfKuQWdYTJ4m2phKjgWlMb3ypgHGtX+ZvOKPKuh9ucvxoibpI
         RaUGjnulTz/cVSeYXQ6aUTqZEjxZI9kNwM4fUCpNKxX85iyOBmnmqjdlt3542OAwsoEO
         m5xjeG0PcCHG/vSTT0OojJ8frPZItrYrnHYDaG2Uzpgo+ZOPDKL3K+gwUnqAurOkDMGi
         2r8JZ43QdWYfFRA4H7seqnDn4EURjpbYC13oMHiPXVlf4QEXa1CvNaEa2Vkymb/DdVd2
         SPD9B/KPISSJ5/LVYTs1q65SZGBD7/knDuH0XVARTevWe9naW9uscL6tLW3vKz5Rvu5q
         iYrw==
X-Forwarded-Encrypted: i=1; AJvYcCV0vzDHhBZnqfCvHV1Zp5vGqkxtzovt4F6FiNTobtvNlazrB2ioEG4QR4tgOjB7zD5W+rnyVo5xECu/eLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo/Q3QsSG3k4WGylX5uk6wKhRNR23ug+Hg0tfaRltXXIIlohV0
	4a/qIYTslV26xCaS8yjg7Pj6ahptAVn58EmY/2wR6c8aRcGYOT3EqHa5EP+V
X-Google-Smtp-Source: AGHT+IEcpDHQdgDEQUV/i2PiQjQtI2wjoEzXOp6LH/gPonhPbP5/zGR7EzDdrI4RxPpnLt5+Rjj4BQ==
X-Received: by 2002:a17:903:2301:b0:20b:78de:c62c with SMTP id d9443c01a7336-20bc5a4eb00mr7751185ad.39.1727808374533;
        Tue, 01 Oct 2024 11:46:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357absm72278965ad.190.2024.10.01.11.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:46:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCHv2 net-next 04/10] net: lantiq_etop: use devm for mdiobus
Date: Tue,  1 Oct 2024 11:46:01 -0700
Message-ID: <20241001184607.193461-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001184607.193461-1-rosenp@gmail.com>
References: <20241001184607.193461-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows removing ltq_etop_mdio_cleanup. Kept the phy_disconnect in the
remove function just in case.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/lantiq_etop.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 988f204fd89c..d1fcbfd3e255 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -391,7 +391,7 @@ ltq_etop_mdio_init(struct net_device *dev)
 	struct ltq_etop_priv *priv = netdev_priv(dev);
 	int err;
 
-	priv->mii_bus = mdiobus_alloc();
+	priv->mii_bus = devm_mdiobus_alloc(&dev->dev);
 	if (!priv->mii_bus) {
 		netdev_err(dev, "failed to allocate mii bus\n");
 		err = -ENOMEM;
@@ -404,35 +404,21 @@ ltq_etop_mdio_init(struct net_device *dev)
 	priv->mii_bus->name = "ltq_mii";
 	snprintf(priv->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
 		 priv->pdev->name, priv->pdev->id);
-	if (mdiobus_register(priv->mii_bus)) {
+	if (devm_mdiobus_register(&dev->dev, priv->mii_bus)) {
 		err = -ENXIO;
-		goto err_out_free_mdiobus;
+		goto err_out;
 	}
 
 	if (ltq_etop_mdio_probe(dev)) {
 		err = -ENXIO;
-		goto err_out_unregister_bus;
+		goto err_out;
 	}
 	return 0;
 
-err_out_unregister_bus:
-	mdiobus_unregister(priv->mii_bus);
-err_out_free_mdiobus:
-	mdiobus_free(priv->mii_bus);
 err_out:
 	return err;
 }
 
-static void
-ltq_etop_mdio_cleanup(struct net_device *dev)
-{
-	struct ltq_etop_priv *priv = netdev_priv(dev);
-
-	phy_disconnect(dev->phydev);
-	mdiobus_unregister(priv->mii_bus);
-	mdiobus_free(priv->mii_bus);
-}
-
 static int
 ltq_etop_open(struct net_device *dev)
 {
@@ -725,7 +711,7 @@ static void ltq_etop_remove(struct platform_device *pdev)
 	if (dev) {
 		netif_tx_stop_all_queues(dev);
 		ltq_etop_hw_exit(dev);
-		ltq_etop_mdio_cleanup(dev);
+		phy_disconnect(dev->phydev);
 	}
 }
 
-- 
2.46.2


