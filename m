Return-Path: <netdev+bounces-125684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF77C96E3D1
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693B01F2894A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD021B1D58;
	Thu,  5 Sep 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKI/uJKX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF771AE033;
	Thu,  5 Sep 2024 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567320; cv=none; b=blSDvMLj0BUUzi9zuROjmH0CwNCql2nQ2Pscdn1ZRScTPa0yB3G2CVRkNX8pPnt6OeMZf5aQysb4LCJwOzWMRP3eEZYfJE/VVmnWCF+z+jNiOQPjAIjCHBucenvDo5LnBZtbwN+jnkbQUpS9G9aXQYjyHSS1WwQed7rN4VGlvh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567320; c=relaxed/simple;
	bh=bY55F9Yt7ywbbfK3BGmP1sX8m6TqOLVevoO2SJWEKWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyH9+NJ6UQx92dk2QVWc7lGj26xOe/G4EAWWl3yh+3+fXA32gVXCxeTS07ICtjSEg1Wk5ucQON63NiI5I1U0EufaFNj56JpiRemDQZLYoqc95mBDqmh23QHCHYKFLD8R1KyVUqpiUvPOzy/LZs9whobe0HoYhnzge9Do5e4qR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKI/uJKX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc47abc040so12413745ad.0;
        Thu, 05 Sep 2024 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725567318; x=1726172118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rULex6OkOrcFUaHqW8L17Ue37gBcZpzVH/KOfFKPcI=;
        b=BKI/uJKXgNW7Ud/Lf8OgEvgNJCgbz973wLZ6T7AmEf4X8Hlt6dpzBZYbdAfxQpljUq
         YOlt2HvqOMRlWWb+7CdaDH3uiwZOfyaq3s3KPpBKz5pnLk+JxQmobi/mbLmgjcfmABNa
         cuVDCiSz1cbVwOEzEQ9KhvN4SXMIK4U03plbWfx7DuJTQgRwDvx7AGwreVCSesVPnVBE
         w62K7kVfKgIuUhWyRBW00OvzMxcJau6Cg3aFREhq3CVZhYt7EjtLzzNTDIt4X9h0lCaU
         n9uB3o05jHwM0mHpSPPdVshwyeBroKvwisT+vJxX8926NWHduFOyzChJt9UElJSmJenD
         flqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567318; x=1726172118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rULex6OkOrcFUaHqW8L17Ue37gBcZpzVH/KOfFKPcI=;
        b=fX3GAZSzbhNsTVpn+WXfSGNfG8jXP0DrkBaniQZimLT+Aod7aqJ3cmyVxi+euXJnrs
         AqPaBkAEA7OCiEsALVeiNOp3a+OIvUYWbuxakkxnGnnSkqX7VVBzzsHOuoNnLVCVxjyo
         iT2X6pYl2kSWcOFx0hIOY7UpMFpnupL+AXjrpEFvg/tFuawcfOwjniMuWEKYE6HlHh1G
         LNJsKdXa79d2gC+2gZZtcYKttWSlgi3g8QAMCF8MDNhb7NUgX7yuRVyUxUaCxy4CU/z5
         MYOJQ5ErXwYZCzUU8ILd3zEmsRPPIMTcHrrDGoW4oIXJ9Nb2GGLj8+elJqleMdZYPbBm
         Q/aw==
X-Forwarded-Encrypted: i=1; AJvYcCWiVZCxTwQ9OhDtAP7VyIldRviVgEe2xQlB5e73tFLf33HyXZXCUcdfkZ85UWfPYA+qCNv+vt7QIEX+NcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZvvJVN8VTpDo8sCT0q+67pqPTjTm+JU0ABfmV1m7ZNCForLeV
	VMUe8k6tpXOCJ4Xe1U6B4WsTT7wLFtHeqYCg5J5jv5fURAtBX6gljN5xvR4a
X-Google-Smtp-Source: AGHT+IGjMVbQ4BUa/m/GDRSWNm7+l5K5JMeQLdUNRfHyp3LXx7BgRiHkwexlX03ByRd0CoxYpU5dXg==
X-Received: by 2002:a17:902:ea05:b0:206:bdbb:116e with SMTP id d9443c01a7336-206bdbb1e8bmr56870415ad.65.1725567318294;
        Thu, 05 Sep 2024 13:15:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea68565sm32327075ad.294.2024.09.05.13.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 13:15:17 -0700 (PDT)
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
Subject: [PATCHv3 net-next 6/9] net: ibm: emac: use netdev's phydev directly
Date: Thu,  5 Sep 2024 13:15:03 -0700
Message-ID: <20240905201506.12679-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905201506.12679-1-rosenp@gmail.com>
References: <20240905201506.12679-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoids having to use own struct member.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 47 +++++++++++++---------------
 drivers/net/ethernet/ibm/emac/core.h |  3 --
 2 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index e2abda947a51..cda368701ae4 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2459,7 +2459,7 @@ static int emac_read_uint_prop(struct device_node *np, const char *name,
 static void emac_adjust_link(struct net_device *ndev)
 {
 	struct emac_instance *dev = netdev_priv(ndev);
-	struct phy_device *phy = dev->phy_dev;
+	struct phy_device *phy = ndev->phydev;
 
 	dev->phy.autoneg = phy->autoneg;
 	dev->phy.speed = phy->speed;
@@ -2510,22 +2510,20 @@ static int emac_mdio_phy_start_aneg(struct mii_phy *phy,
 static int emac_mdio_setup_aneg(struct mii_phy *phy, u32 advertise)
 {
 	struct net_device *ndev = phy->dev;
-	struct emac_instance *dev = netdev_priv(ndev);
 
 	phy->autoneg = AUTONEG_ENABLE;
 	phy->advertising = advertise;
-	return emac_mdio_phy_start_aneg(phy, dev->phy_dev);
+	return emac_mdio_phy_start_aneg(phy, ndev->phydev);
 }
 
 static int emac_mdio_setup_forced(struct mii_phy *phy, int speed, int fd)
 {
 	struct net_device *ndev = phy->dev;
-	struct emac_instance *dev = netdev_priv(ndev);
 
 	phy->autoneg = AUTONEG_DISABLE;
 	phy->speed = speed;
 	phy->duplex = fd;
-	return emac_mdio_phy_start_aneg(phy, dev->phy_dev);
+	return emac_mdio_phy_start_aneg(phy, ndev->phydev);
 }
 
 static int emac_mdio_poll_link(struct mii_phy *phy)
@@ -2534,20 +2532,19 @@ static int emac_mdio_poll_link(struct mii_phy *phy)
 	struct emac_instance *dev = netdev_priv(ndev);
 	int res;
 
-	res = phy_read_status(dev->phy_dev);
+	res = phy_read_status(ndev->phydev);
 	if (res) {
 		dev_err(&dev->ofdev->dev, "link update failed (%d).", res);
 		return ethtool_op_get_link(ndev);
 	}
 
-	return dev->phy_dev->link;
+	return ndev->phydev->link;
 }
 
 static int emac_mdio_read_link(struct mii_phy *phy)
 {
 	struct net_device *ndev = phy->dev;
-	struct emac_instance *dev = netdev_priv(ndev);
-	struct phy_device *phy_dev = dev->phy_dev;
+	struct phy_device *phy_dev = ndev->phydev;
 	int res;
 
 	res = phy_read_status(phy_dev);
@@ -2564,10 +2561,9 @@ static int emac_mdio_read_link(struct mii_phy *phy)
 static int emac_mdio_init_phy(struct mii_phy *phy)
 {
 	struct net_device *ndev = phy->dev;
-	struct emac_instance *dev = netdev_priv(ndev);
 
-	phy_start(dev->phy_dev);
-	return phy_init_hw(dev->phy_dev);
+	phy_start(ndev->phydev);
+	return phy_init_hw(ndev->phydev);
 }
 
 static const struct mii_phy_ops emac_dt_mdio_phy_ops = {
@@ -2622,26 +2618,28 @@ static int emac_dt_mdio_probe(struct emac_instance *dev)
 static int emac_dt_phy_connect(struct emac_instance *dev,
 			       struct device_node *phy_handle)
 {
+	struct phy_device *phy_dev;
+
 	dev->phy.def = devm_kzalloc(&dev->ofdev->dev, sizeof(*dev->phy.def),
 				    GFP_KERNEL);
 	if (!dev->phy.def)
 		return -ENOMEM;
 
-	dev->phy_dev = of_phy_connect(dev->ndev, phy_handle, &emac_adjust_link,
+	phy_dev = of_phy_connect(dev->ndev, phy_handle, &emac_adjust_link,
 				      0, dev->phy_mode);
-	if (!dev->phy_dev) {
+	if (!phy_dev) {
 		dev_err(&dev->ofdev->dev, "failed to connect to PHY.\n");
 		return -ENODEV;
 	}
 
-	dev->phy.def->phy_id = dev->phy_dev->drv->phy_id;
-	dev->phy.def->phy_id_mask = dev->phy_dev->drv->phy_id_mask;
-	dev->phy.def->name = dev->phy_dev->drv->name;
+	dev->phy.def->phy_id = phy_dev->drv->phy_id;
+	dev->phy.def->phy_id_mask = phy_dev->drv->phy_id_mask;
+	dev->phy.def->name = phy_dev->drv->name;
 	dev->phy.def->ops = &emac_dt_mdio_phy_ops;
 	ethtool_convert_link_mode_to_legacy_u32(&dev->phy.features,
-						dev->phy_dev->supported);
-	dev->phy.address = dev->phy_dev->mdio.addr;
-	dev->phy.mode = dev->phy_dev->interface;
+						phy_dev->supported);
+	dev->phy.address = phy_dev->mdio.addr;
+	dev->phy.mode = phy_dev->interface;
 	return 0;
 }
 
@@ -2695,11 +2693,11 @@ static int emac_init_phy(struct emac_instance *dev)
 				return res;
 
 			res = of_phy_register_fixed_link(np);
-			dev->phy_dev = of_phy_find_device(np);
-			if (res || !dev->phy_dev)
+			ndev->phydev = of_phy_find_device(np);
+			if (res || !ndev->phydev)
 				return res ? res : -EINVAL;
 			emac_adjust_link(dev->ndev);
-			put_device(&dev->phy_dev->mdio.dev);
+			put_device(&ndev->phydev->mdio.dev);
 		}
 		return 0;
 	}
@@ -3254,9 +3252,6 @@ static void emac_remove(struct platform_device *ofdev)
 	if (emac_has_feature(dev, EMAC_FTR_HAS_ZMII))
 		zmii_detach(dev->zmii_dev, dev->zmii_port);
 
-	if (dev->phy_dev)
-		phy_disconnect(dev->phy_dev);
-
 	busy_phy_map &= ~(1 << dev->phy.address);
 	DBG(dev, "busy_phy_map now %#x" NL, busy_phy_map);
 
diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/ibm/emac/core.h
index f4bd4cd8ac4a..b820a4f6e8c7 100644
--- a/drivers/net/ethernet/ibm/emac/core.h
+++ b/drivers/net/ethernet/ibm/emac/core.h
@@ -188,9 +188,6 @@ struct emac_instance {
 	struct emac_instance		*mdio_instance;
 	struct mutex			mdio_lock;
 
-	/* Device-tree based phy configuration */
-	struct phy_device		*phy_dev;
-
 	/* ZMII infos if any */
 	u32				zmii_ph;
 	u32				zmii_port;
-- 
2.46.0


