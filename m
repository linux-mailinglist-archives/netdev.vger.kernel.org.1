Return-Path: <netdev+bounces-127644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E51975F2C
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A661F23F4C
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB0153BD9;
	Thu, 12 Sep 2024 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjJpuDX1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C265143748;
	Thu, 12 Sep 2024 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109354; cv=none; b=Lx+uddp/BJOGDfA6+7UnXWd0rN8T0sgNRQ2fEN3fW1ab/+IHxj6YegNbxwl+yW7coImlD67AQdzsvEOVnCAm8tGEqUICUrinuJ9oL+6Jm0jPdWdj4XT3okDUHxBHAUfJfzW53TjAzHiqt+/0T0039uYqxEGUI5rmQjv806r6gI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109354; c=relaxed/simple;
	bh=/HRFUxqMU8Q5Rbr1ovrH+JLmllMAbcmsBJ2p3nIaJk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0foyw6u3EbEqWViOd0PiHbQXljbE397fmFSDO3X9IisWx2R+Zhu8XawIzIJ9LWrI9EsXcptwvEXEI5LUWzsbDFM9dUVRldX1gh7LEvE4T9f0NuMqq8w28jlizD2vTr272NUyqVIriCk5VNQ3qjhpXN/1efxRmKWqX2L18Evfac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjJpuDX1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d88690837eso368366a91.2;
        Wed, 11 Sep 2024 19:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109352; x=1726714152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARlP6/Q8jF5xtzZpR1qmLezgEPxQWF7QTJCTo4RZeQI=;
        b=GjJpuDX1djTZbdh8eqZjvmW47nw39WLQ8HIZcZdYBDM3puJ43elZgELCO+c0Po+PDZ
         jaZmH/8m0l8dOj609Xu6w69x5pC2P9qoCsT46972wgKw0Ti4ZosYORMio3AaEom3+ZKU
         0twj5jY1NE2B2CHQAF74i0MxiEfWITLH4nCC4V7HdSBRMIBFNEPWFGe/tKkDUOEZ9OIs
         tkF7thiuBVljEgvBOWV04mKe3aSNWO8YQctS6NI4UmB6544/RbVUVbHdfxad/LlWK+Yd
         BNwWuBDdNvtxrvta7l1Rq72b366nRQ+sflQ414Hg2MqsPNwFae6wGjo36Jp75K8Y0WRY
         VWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109352; x=1726714152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARlP6/Q8jF5xtzZpR1qmLezgEPxQWF7QTJCTo4RZeQI=;
        b=gmTQQKvT12JTo0qI1Tyrko+TLwid4rin1QeiVrDOH+MRyQQ4KOobdH0G/Rt6giKVMP
         Tc/MLkp7A0O87XjIYczKYPP8rl1QkVUywmzxZxedPocolYqdsTtdEjl15TEHjkfvCLTM
         4GcoTSOFXqs/PxmDoPiqs0q1ydZ8+PVHYSsZk+id7mUtCYK52MZdLntrXsbHB8lplLvM
         F1NkSEvh8crsNkJhGJNcjwDg5I7+uTWZ1wJgN+5RGCLK29fv0xq013QMwahrNpQhrTE3
         gztSChzszoi93wR0hEoSDD1b7krPBKmEyxLLy6wg0R/psfpMMTTgXWYuXt0efnoV52SD
         pS1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiHl8xTQSXcS2knSCYUWRb+hm80SQA5hb+AnCR492L0pqpJGrMu08VD2ndqqBp0WRskY3qzeTkro7hvGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEL7W6ShSJKgqHBnKHcr9haObdhaeXUjwJ3U8mBtf6A/U4PkR
	0yPlVLX6SWLLREbBUeOwsLDOIvlMzZCadTb1O5GIC793DThpY/WJz8HHBK+8
X-Google-Smtp-Source: AGHT+IFH6gsCNBEagDsTIs61Iw8ezk3cMUGHP7KQ7Swfn167P84G4NFUM+TtsMWikw720i40Beqzvg==
X-Received: by 2002:a17:90a:ba94:b0:2cf:f3e9:d5c9 with SMTP id 98e67ed59e1d1-2db9ffdc386mr1306294a91.21.1726109351964;
        Wed, 11 Sep 2024 19:49:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe4897sm11457868a91.7.2024.09.11.19.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:49:11 -0700 (PDT)
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
Subject: [PATCHv5 net-next 4/9] net: ibm: emac: remove mii_bus with devm
Date: Wed, 11 Sep 2024 19:48:58 -0700
Message-ID: <20240912024903.6201-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912024903.6201-1-rosenp@gmail.com>
References: <20240912024903.6201-1-rosenp@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 32 +++++++++++-----------------
 drivers/net/ethernet/ibm/emac/core.h |  1 -
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index ad361202e805..9596eca20317 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2581,6 +2581,7 @@ static const struct mii_phy_ops emac_dt_mdio_phy_ops = {
 static int emac_dt_mdio_probe(struct emac_instance *dev)
 {
 	struct device_node *mii_np;
+	struct mii_bus *bus;
 	int res;
 
 	mii_np = of_get_child_by_name(dev->ofdev->dev.of_node, "mdio");
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
@@ -3265,9 +3262,6 @@ static void emac_remove(struct platform_device *ofdev)
 	if (dev->phy_dev)
 		phy_disconnect(dev->phy_dev);
 
-	if (dev->mii_bus)
-		mdiobus_unregister(dev->mii_bus);
-
 	busy_phy_map &= ~(1 << dev->phy.address);
 	DBG(dev, "busy_phy_map now %#x" NL, busy_phy_map);
 
diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/ibm/emac/core.h
index d8664bd65e1f..5a9d4b56d7cf 100644
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


