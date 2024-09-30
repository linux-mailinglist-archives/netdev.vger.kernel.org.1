Return-Path: <netdev+bounces-130598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8146A98AE3F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40131C22340
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA91A304D;
	Mon, 30 Sep 2024 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC6seBt+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D81A2C19;
	Mon, 30 Sep 2024 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727884; cv=none; b=Do5oftOoDYRsvdJBkmO9ODN0eQua5WQ7QYa9y7EFZdf/cRm/LdnpNO5Dn8I0kTpsHczM7qMW8Sov0J6rQ0pxL+ISqPvVs2Zc7wMPv/oXwrKPQGJXt48wavW5YNduVbpeMdqHTBS2eXIjZ2kzyn37IfRpxUmOXfTT0OM1BQnugNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727884; c=relaxed/simple;
	bh=UbY7X3xoQwvPKIgeSXpN8TiC94FgYetqZR1cwmZYOHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udvRNpt7b7+wcsJGsVjXjQXx/OGeim+NPpdeK6NqkjVPhBg2Vg74uNL9zUF29aofgiC6krxErdiwYxP2SheebJH9aVUX2piJi29TYms/+rOlS8xfYEesOUXOTNtkgmRPKn1EWee3C74H2KbJUDB5PnUIAVmyie/fCDEkLLU2WFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gC6seBt+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6afa8baeaso4077337a12.3;
        Mon, 30 Sep 2024 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727882; x=1728332682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsLesHqpeFTSe8JaIvfnYTIedQG/JoNHMh7rsELIkDM=;
        b=gC6seBt+6w+yEJJrv2VFmzBkdEIs6Dc4YndtUsOacS/lrqr0dQOC2QUfF+W0EgxGAe
         BtuXYl2h3ZTBExB94KyYdQzKsvjXMKANDO+/L1HoUZ3YX+bY17jmrWFf8FyLKeuxWPWN
         OPFLr8oCRYB++6Exg7/UMuNoUEN5BVFQBhHlogk1W1CLh0+ccD/tFMazS2TlkR7+UNDP
         Cqri1T+J+xOI0LPS32KjMhblb8tbxwrG9R1QWd4pEPqTccPoh/ALYU1x5yHfXKmNXbFX
         6+HIVaVPU8mEZ1Bk/x0W/JuRqiUvUN6TOyvuW9tOWQNIH/0bOyCDVwVCB2guys2lhy1X
         r4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727882; x=1728332682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsLesHqpeFTSe8JaIvfnYTIedQG/JoNHMh7rsELIkDM=;
        b=BjnaAQEgGYKL/zUwdH+qVtY51u4H8WgmCiyp2ldfpoxktj4ZWAsy2QuT4aqwHZOVTv
         9LelsCQwmmOr/rzmr7j0VNY763M7ksSLuNnR69kNdsrk07s9TJkiY31gbHxiuhmEv/xM
         ZW2xNGCCB5NZg6LOlU9QXXGh6b4sA6NMujLCA+Ku+hN+YUahaMdoPkQY2bvND6xnCeVe
         CwjeUbilr11yDNVIk16nQ8DYOaShxmtSetx/79Jcqdl8crDkb6hZ138rAieoRdW7085V
         XRo8wzkS9WZasP75NNvbEht2bsLudJ5Ze7jI89lao6L9EaKnxmB2CFJMC6cssPeClAge
         P+0A==
X-Forwarded-Encrypted: i=1; AJvYcCXF6dM48Y9Sp40YHXu19ixqDupBKJZi65nVyy+8OAoMlHG4doEP/ldPToM29MAWx8yjfOOEQ7TBWCNCfN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzourxHEHrfEdEJmXIWqf2dx+SiWq7PUIvEesYzDaDrxtlUFswF
	brwmiEbsV1cpImzfdv3MLi8/ZdhAK6tFegCVzb1jiyWEDAr0XU/7awPqB6A8
X-Google-Smtp-Source: AGHT+IFU+lltBr7u/6B+O0I+uSlsS396fumfGPvOaQ44allSOv0DiD0W1fNMYLpxn4P/QzsdSZtRiw==
X-Received: by 2002:a05:6a21:30cc:b0:1d2:e458:4061 with SMTP id adf61e73a8af0-1d4fa67bfc8mr16540738637.15.1727727881688;
        Mon, 30 Sep 2024 13:24:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265160a5sm6670623b3a.103.2024.09.30.13.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:24:41 -0700 (PDT)
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
Subject: [PATCH net-next 4/9] net: lantiq_etop: use devm for mdiobus
Date: Mon, 30 Sep 2024 13:24:29 -0700
Message-ID: <20240930202434.296960-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930202434.296960-1-rosenp@gmail.com>
References: <20240930202434.296960-1-rosenp@gmail.com>
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


