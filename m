Return-Path: <netdev+bounces-124291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9CB968D2E
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFF61F22E8B
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2950521C182;
	Mon,  2 Sep 2024 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds1lhAkZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A43BB22;
	Mon,  2 Sep 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300941; cv=none; b=p1Jd/CWk1s/pUvbR+2a4SzntQZAID7lKluLCm0y6IpKC/b0LrDmPqBn8O9w3LwdakjSFq+72VasiD9wD8pMhA7BQGY8Rtg6kG2+lBPbHb74MpfJqYTSEL9t6PihuZs8befBkhttNLYxOQJw/mTeyfblcTIF5ZjyCbodywdH7ng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300941; c=relaxed/simple;
	bh=PnIAzZu+MDJAm+gsXxmqEewg/2XRFhRoTemtVw7cehs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqtlZX4j9sjD2YRjk7bvNl1b81uWWSUC8zjxLu+izXZKPzS41nnbHiTjVxW3v5tzz7+SOl+eQnXSngNu3s50Tu6HZI3FbuI069eGJziUT121GCReA7GFPqKl8OMCLjjPu76cA5/JnYUvubCQ9ksJqEU7pfjQpVAXki7m9AhuSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ds1lhAkZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-714114be925so3627092b3a.2;
        Mon, 02 Sep 2024 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725300939; x=1725905739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPRjyz9vFHJOAVQ7s5yA4b/J4xdj+tyqzGLlTB6HBC4=;
        b=Ds1lhAkZXxG1vmenfKCQkn7bxCeshX6QmxC+XtdfFBYug9Ok0BsH8lv6Ht6cKLJWTL
         WWrUqpmlx590qKTtb63DPwB6mT+EMfODifVp1nn1VL7klZVIc2c/bA/AwH8yEABV5Q5I
         +h1v/TSBscHjRkboj2F5TaxUADo8DBWmzECZZVHpvS/cR4iU/LVmp8DY8or7vRWSozSp
         z0tHHc+YTayvYCUdmzSnE5o51+0C9KKBTeeNV8vxelNVPZiyxx1vJ0MMqEhrHOeXcRh2
         /3N/eYu/m1CPo+aBsPMret4zGGhgMpB0WCnpoDuhxi7vSE9Zf5PInwpEs9/uPgazKeew
         YJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725300939; x=1725905739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPRjyz9vFHJOAVQ7s5yA4b/J4xdj+tyqzGLlTB6HBC4=;
        b=m7I/kq0OcFyBpNn9MWJXwXpF0Yp3FVxu+ACd6D2JPEZ/joEzvctKRAYLA0E+hsJeJZ
         G3EcGLx+VTwGdGoih301GDtvYTWpV4H/uhvEz5GHFcINHp/YsQdbT9O/tXTU3CDeEJk2
         Tuc9ts9UWcjdHfGbetSwsqYqebMd6bP2taCQxzW6W+xvRWhvdLhAa8nX2w8tw0KODeM+
         1i6RX60PKKen9le174BPOZHdlbFl8gmJmtmRAlnhW3+tFpYrbrCHSqQ25reOFIKwZjiv
         GxBqtl9jgHZQx+RB5Dxb6wnVa/THzi2gCWwpnO2TbZY//OwzAihyXHPFqRCYVHsmdQu2
         Ub+g==
X-Forwarded-Encrypted: i=1; AJvYcCVwB1TOGhFjOPnKY+3c9dF40qW6CxR33e/aEkYC7DYutI9TqMLT78qBbZuJoV2PG6nvGeJnfc8lcmYQVqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtyeuJqjZlSRWOPqQjQEdVnwBo/beqQue9PXPyipelnar2fOit
	zHZ6N3Cu5tmze8PRbJCeI5V+PpweoN6LG/Qgwb65nmWbRVezQA4PeBmCWDJf
X-Google-Smtp-Source: AGHT+IFRyta+qrOOcrQJawpaE+2/q3ar1Gq7rDtNbSKm5oPpPROSOUTrKKLjX8ZNm/0Z79DTClHElw==
X-Received: by 2002:a05:6a20:b418:b0:1c6:a562:997f with SMTP id adf61e73a8af0-1cecf757f5cmr9374776637.42.1725300938513;
        Mon, 02 Sep 2024 11:15:38 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d7804sm7109167b3a.154.2024.09.02.11.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:15:38 -0700 (PDT)
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
Subject: [PATCH 4/6] net: ibm: emac: remove mii_bus with devm
Date: Mon,  2 Sep 2024 11:15:13 -0700
Message-ID: <20240902181530.6852-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902181530.6852-1-rosenp@gmail.com>
References: <20240902181530.6852-1-rosenp@gmail.com>
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
index 1a4c9fd87663..af26a30bb5de 100644
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


