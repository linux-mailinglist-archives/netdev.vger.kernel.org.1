Return-Path: <netdev+bounces-126246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22099703A5
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 20:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350AE28383E
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4639C1684A1;
	Sat,  7 Sep 2024 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sypccghm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5FC166F36;
	Sat,  7 Sep 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734738; cv=none; b=kzYRdeepR0rWZozVQD2GIMkj/YNQ5fpITKRWlvtueJTQCj2DkAoczG2gzSIMT0H13KHilGBRvtOUtzXjGV4x64YPMOtLJx40QwsIkAKgV1HpBFMlcAm+xm1MA4dqoVCAIhaZX708F6+4gLOBNfz4rd1vRggxlTD/VWqnV4IwT8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734738; c=relaxed/simple;
	bh=J4i+pjvGEr9w8cX9+k5ZAXVoDvumeDRQwkT79rNhoqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMq2yXp6wT+g8xY2X8WRCCwwyzBzzos28oY9fVHgT3+0ehL3i0DYxhxzTmrIS6zgSEUexFARD6vp/xZqrhoD7lnLx0RGcoA1UuAIerHtImTy0Azn+ryPsKmZxbWtPgZJbKbfcp9Sif8KdHwJKy+IFqRynC94ZxNKu1CMVxqxQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sypccghm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-717911ef035so2410841b3a.3;
        Sat, 07 Sep 2024 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725734736; x=1726339536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkXxmfOMUnZVegO/6gjb+zCqyFgjDsLsBXpnAHvj2v4=;
        b=Sypccghm39ZH1kLyz6PseI69CRhBbBnA5i6A/m2wBO5cYVcK/OTjK0BRcsbQEpnh0s
         6B0h5nZWNPYqLa/xuJtzS/8Djq/cLuPIl17Su6IaAUeVzRkap9X4WlYApMIEAzg8t5Rc
         LCGwAZqb+8uxCkTc3l0QmFpST9ADL8ilDOTRaUnABlysXYcgHEy6xMe2DovUbQy5QOSa
         IV17uEgyjEkVFUOjFbEuoTfuRJaOfUqRhcCuG6xs080h5yp1DhBKNYiKgQ3jiU6h6pBv
         Bd6cWWsW/DUIa70srkHr3jPzpqHfxlNUS4ehca/vbdh/zqIr+Z7IFRGjB1jIG5fqjo7h
         /61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734736; x=1726339536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkXxmfOMUnZVegO/6gjb+zCqyFgjDsLsBXpnAHvj2v4=;
        b=hd8wnwFP4AtdeBvvPztAV2GemlUOlJsVUhSDf2OEdzQnIG2yRCSqa1V3aCuiixaSGt
         cq3skd4nvOJjG1OKcTPTjvuvBSUNh/bl9YdFV/pYUQUy7I8hsAS+VjBIFTk0jyxrCQ+w
         kqLphDb9sk1oPxWiGJYdEs1FyizXFIkBnZBfvos3cj9KtZIRfv3ICvS00SlKAOdsamKx
         dfCqu4qI4icWgjvI/Nx2Ut6Hx7+DkikZB0GjnxWQhTuz5PzIQJaCf+sJG8QLqJHi9oBR
         cpyuHnSBcZc63sPyTn4ti0iv0W/Ef6Aap1Stiv+rujIk5dhRB6ZQmfunGATDnOWQBXPO
         DKGg==
X-Forwarded-Encrypted: i=1; AJvYcCVCpIXZGrR2omrYO0P+Ab8KBKbTbloqZqWydehyKjjzB/ZDmGSEpTcSHfrG4sg1SPUs40sBEAv+8W+yi1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiDF7pfio4liKWMMLloLoKtV96ZzuNWNLx8IjoAhVzd8bYqler
	exLBa/uJ7Ma6en0oU+bD6G2K2qN2/4A+1cTRHycXkM0hXJcEhRK0XieolKgu
X-Google-Smtp-Source: AGHT+IGhbBNFIKylt6fouwp7Q6G6AOkMz2VO1qsgeFpFg3caBTu7MZ9J8Ebhhcaq7kpARbaQ5ZDdZA==
X-Received: by 2002:a05:6a00:1746:b0:70e:8e3a:10ee with SMTP id d2e1a72fcca58-718d5ee0415mr7089536b3a.21.1725734735946;
        Sat, 07 Sep 2024 11:45:35 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ab18bfsm1111239a12.88.2024.09.07.11.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:45:35 -0700 (PDT)
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
Subject: [PATCHv4 net-next 3/8] net: ibm: emac: remove mii_bus with devm
Date: Sat,  7 Sep 2024 11:45:23 -0700
Message-ID: <20240907184528.8399-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907184528.8399-1-rosenp@gmail.com>
References: <20240907184528.8399-1-rosenp@gmail.com>
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
index e06fcd920f9f..837715b52397 100644
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


