Return-Path: <netdev+bounces-124701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F36296A7A4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AF51C23DA7
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B61D9D6F;
	Tue,  3 Sep 2024 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG75m5py"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A41D88C6;
	Tue,  3 Sep 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392602; cv=none; b=XLxYqrlsswGsYdXm0lvvt8E2NO2As5+usVDET/WjfwjCRq42O6aPBf4BTDqinilL8gc4AJhOzNN3OlcfY4Ym2BpxzAXgUJVQ5db6/OaJU9M9fjTFPo3rBmoKL1u8jWamrbihto8/Q/akzvexpB9jFnwA19CQLSxcGEa4r+cw4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392602; c=relaxed/simple;
	bh=ykrgyKRFg1uLEC6ckT+l4Kd9SWyDpuZZ1qKLLmrC7QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMauzFVKcwsssfHxzuwHxBkhQLBZJaAZHnLzEL1797f8r6AAI6xOgkdH0C79Mj0ler9qKd9BnG4rz5ZdmzySDwHOfilH2Rz+WDHl3jkSSG0DUvFf3nn/jkBj6enhZ4r9/HAu77hDfqwm2SGguSjl9HsMmtiNPwwf+38HbqC5hv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG75m5py; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20551e2f1f8so28139285ad.2;
        Tue, 03 Sep 2024 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725392600; x=1725997400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpNBuVDP6cW9RiD+NgwPMfYMJOKSgp1YQ143TP+6/kg=;
        b=jG75m5pymFHamBtpmRUaC3ZAZDioJ1iXWauh4UM1rk0iC0+sIZkbbbao3kctPJj+8y
         UoDecxnErtqCFOdifV3duFYhbhMgDq3xiN61sp5cm9AC5hmtwPe1QIkLYVejaz+CVg4C
         Ql2Ksw6qLzSo+cgXxrb8FJZ6UTQisBBhAHYBt6ukV3MX0U9lYaHeYiiHpKVI7gxZ1hHG
         00ZRjmwOXeFF2+qI6i818UmpvMgn1iZMAqynSFGALVexAfL6g0gDlAqWd6T2OFC9Q3ki
         a67dc8pFySVIXxakt5j4lG6e/9YhLWmgzeiK3GAZZDGEfmRAARkfVmyltvBcYZcgUUg0
         rC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392600; x=1725997400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpNBuVDP6cW9RiD+NgwPMfYMJOKSgp1YQ143TP+6/kg=;
        b=kQavOWRB9K3/9gGeeiH1EwXxMLxGL5H+/A0iMQkbXuxE4zntzgvPK/6vesr3a3a7hO
         9o4PDi+CnrvP6+iRVqptW24wtNemvz1mAvcaA4daDymViby5KKUX4QbSEPfaRFdH5RRR
         qRZHkmjoBAyGCQphv+1TcIiWYz7OhVxzoBuXr9TyeQP2EDTEY0f059eZYMqaLRBgd9Aa
         jroAlt4kDiTAC3n7AY5yChktmsZ/0eR6v9ewpmjAiyoD0M8pPH/SrhpgHGiJVYT4YPAc
         4l2hbebe6IrWJu5EKUBVIwC97LB5jC8OqRpIFR40FAmVEcnPnZlgCqYDTCOBLG0SjF0t
         wZiw==
X-Forwarded-Encrypted: i=1; AJvYcCUvvVDtx7POvVzZYg/etPrPRDZb+KR91YbGtbdky2dKGcn8XqTVisPxfmpDhTilWeF0oUgmVZumrE5mKRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwjwaExtITbNU0JszEedwk3iYdvR6yXJ2+JEoYasjG9mbo/rSX
	s6hhul0RDVL5FBUzpSZbbDfI6X2Enb0nZre7Bd7UlcrY7a0dT3ZvpysOIYS8
X-Google-Smtp-Source: AGHT+IGxV6x7rXltNpJ482CNvHOEKrCD50BnCOMhXHgav/1+6JXZCS3QTDYhV0i1knBziRkxYXqVwQ==
X-Received: by 2002:a17:902:ea05:b0:201:f0c2:9c7 with SMTP id d9443c01a7336-2058417ac35mr91548645ad.11.1725392600368;
        Tue, 03 Sep 2024 12:43:20 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea52a8asm1979505ad.182.2024.09.03.12.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:43:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv2 net-next 4/8] net: ibm: emac: remove mii_bus with devm
Date: Tue,  3 Sep 2024 12:42:40 -0700
Message-ID: <20240903194312.12718-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903194312.12718-1-rosenp@gmail.com>
References: <20240903194312.12718-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to devm management of mii_bus allows to remove
mdiobus_unregister calls and thus avoids needing a mii_bus global struct
member.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 32 +++++++++++-----------------
 drivers/net/ethernet/ibm/emac/core.h |  1 -
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 459f893a0a56..4cf8af9052bf 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2580,6 +2580,7 @@ static const struct mii_phy_ops emac_dt_mdio_phy_ops = {
 
 static int emac_dt_mdio_probe(struct emac_instance *dev)
 {
+	struct mii_bus *bus;
 	struct device_node *mii_np;
 	int res;
 
@@ -2594,23 +2595,23 @@ static int emac_dt_mdio_probe(struct emac_instance *dev)
 		goto put_node;
 	}
 
-	dev->mii_bus = devm_mdiobus_alloc(&dev->ofdev->dev);
-	if (!dev->mii_bus) {
+	bus = devm_mdiobus_alloc(&dev->ofdev->dev);
+	if (!bus) {
 		res = -ENOMEM;
 		goto put_node;
 	}
 
-	dev->mii_bus->priv = dev->ndev;
-	dev->mii_bus->parent = dev->ndev->dev.parent;
-	dev->mii_bus->name = "emac_mdio";
-	dev->mii_bus->read = &emac_mii_bus_read;
-	dev->mii_bus->write = &emac_mii_bus_write;
-	dev->mii_bus->reset = &emac_mii_bus_reset;
-	snprintf(dev->mii_bus->id, MII_BUS_ID_SIZE, "%s", dev->ofdev->name);
-	res = of_mdiobus_register(dev->mii_bus, mii_np);
+	bus->priv = dev->ndev;
+	bus->parent = dev->ndev->dev.parent;
+	bus->name = "emac_mdio";
+	bus->read = &emac_mii_bus_read;
+	bus->write = &emac_mii_bus_write;
+	bus->reset = &emac_mii_bus_reset;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev->ofdev->name);
+	res = devm_of_mdiobus_register(&dev->ofdev->dev, bus, mii_np);
 	if (res) {
 		dev_err(&dev->ofdev->dev, "cannot register MDIO bus %s (%d)",
-			dev->mii_bus->name, res);
+			bus->name, res);
 	}
 
  put_node:
@@ -2656,8 +2657,6 @@ static int emac_dt_phy_probe(struct emac_instance *dev)
 		res = emac_dt_mdio_probe(dev);
 		if (!res) {
 			res = emac_dt_phy_connect(dev, phy_handle);
-			if (res)
-				mdiobus_unregister(dev->mii_bus);
 		}
 	}
 
@@ -2697,10 +2696,8 @@ static int emac_init_phy(struct emac_instance *dev)
 
 			res = of_phy_register_fixed_link(np);
 			dev->phy_dev = of_phy_find_device(np);
-			if (res || !dev->phy_dev) {
-				mdiobus_unregister(dev->mii_bus);
+			if (res || !dev->phy_dev)
 				return res ? res : -EINVAL;
-			}
 			emac_adjust_link(dev->ndev);
 			put_device(&dev->phy_dev->mdio.dev);
 		}
@@ -3262,9 +3259,6 @@ static void emac_remove(struct platform_device *ofdev)
 	if (dev->phy_dev)
 		phy_disconnect(dev->phy_dev);
 
-	if (dev->mii_bus)
-		mdiobus_unregister(dev->mii_bus);
-
 	busy_phy_map &= ~(1 << dev->phy.address);
 	DBG(dev, "busy_phy_map now %#x" NL, busy_phy_map);
 
diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/ibm/emac/core.h
index 295516b07662..f4bd4cd8ac4a 100644
--- a/drivers/net/ethernet/ibm/emac/core.h
+++ b/drivers/net/ethernet/ibm/emac/core.h
@@ -189,7 +189,6 @@ struct emac_instance {
 	struct mutex			mdio_lock;
 
 	/* Device-tree based phy configuration */
-	struct mii_bus			*mii_bus;
 	struct phy_device		*phy_dev;
 
 	/* ZMII infos if any */
-- 
2.46.0


