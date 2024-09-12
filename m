Return-Path: <netdev+bounces-127646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5E6975F30
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1381C229DE
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D10178CDF;
	Thu, 12 Sep 2024 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEZmJcWP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CCE126BE3;
	Thu, 12 Sep 2024 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109357; cv=none; b=mvLJk+bNQH4WJFBDTh7/7CmzjRlzt0BLshe3tLlknSXXAQR4qHE7Rc6JkvK1vqm96TwzLD5Yr5K+Nu9eWCPOw3/AjJ92+KekKCJwoa9BntSTuM6eOjERh1o9hogWDTezqv4sPiY21oNyyHMU2VGhyGneF7N1vPZQpLwJTa31GRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109357; c=relaxed/simple;
	bh=49c02I6ZOrgFmFq7qJyVmZB1W60G9Zv7OfWrs3I0gI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3NtlpPpxuBPLzHplkz/3PPOHI6lxwMQjZQFS3x1xGJMSaoR0AGdKXwX7PRiHKz/dl0WtVsL2TtIbgxZsyUFs1wCYpSLYT7Nn22DKslZxtZeQGYoyxXBrjPGQEUSYFAymcDWl9+BU2RQkMDF3tlU7IpSQ8JsBHGx0xc28juP8RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEZmJcWP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so400084a91.1;
        Wed, 11 Sep 2024 19:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109355; x=1726714155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIQk+mM3AiQJnx01Ed1veGArYkm9ITnlxL8jOGEyZtU=;
        b=VEZmJcWPVFRqNttkGA5Qb0dXsKlPM4PDsuwecOlmpYQ5Kf41HHdrIlKzKLp9Tn+tVA
         E+Ui1iF2zknph+jpj65Wr1H3Ifm07fFu//mLOQTGZM9YOZcGrYUgRaRcZV4zA37uJ6i4
         p4UQKSqnXi3qyCgwtHKh0r/WeTbVnBnX8UfoG1zgdWacEj75Aq6oNc3KEbEF6DuzPtoJ
         N+YJ6vVWAe3BhVBcF79Fj6LVvWIjlouVyB8HSw742pDe3E5Q7F31jpJz/Ca2ZJNqUpkd
         JhFGJftnYHzrEVeWwCqmTel7aaaxoYeAtKGmC0miBjx3pBYGuvKd3bPjV9unGylFGXFM
         Ozbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109355; x=1726714155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIQk+mM3AiQJnx01Ed1veGArYkm9ITnlxL8jOGEyZtU=;
        b=dnyC5yQ1/SVPXWqAFibHnSmQYRx/+FcSZI1CPY7EZkF7Det5nj/rhjWsuVbEWSNpMX
         q4hGyX8jvmBofDv8gR8fj1DfbtP4HlpXRYytxIQzQGyJm+sb0Xajkrnwq8sKDSWrvm/h
         hUgZknHbQBUdlz6BOGrwsXdKwn5GrUfkL4fVUNlAiw8EUzYbHR0UvHmECx903nRShD1u
         El8QuDmiKWJfISCjUOgsMqyaN9fE1zPtEKtbfY5V5dkrhvWQ4+3UhHG5SA6ju+n980GF
         qGex9OtUmR3GuBO6E2uL9s6u5Z4Cy0ywjOM76l6pF5Ys/orecH+bVY1i54nhoksAlxKO
         OQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUon7dZ603eMwl+Xs9i56YLgDV8GY+RUl7ZXVsiZ/MfK0iZKH6jzK9E2BovbLVffVuTPErYbrB5mDEhZtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm3D7QfPA/TkBES8fOocjpoKvOePpH4ut0TJc3oDqcK+5zRQV9
	BGjwRg56zSN50VRnLIJYz3ZTZA6coQIvagUsOPhVJOBBflp3KLDzgklzUWmM
X-Google-Smtp-Source: AGHT+IFaklKQQrUb/vUWZ4fbgLtNDkiQQs+GXsQPdSCY0aIWGDijON3E4Snxyu1H+Gz2S8IlsS76Ww==
X-Received: by 2002:a17:90a:6887:b0:2d8:905e:d25b with SMTP id 98e67ed59e1d1-2db9ff90633mr1620743a91.9.1726109355088;
        Wed, 11 Sep 2024 19:49:15 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe4897sm11457868a91.7.2024.09.11.19.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:49:14 -0700 (PDT)
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
Subject: [PATCHv5 net-next 6/9] net: ibm: emac: use netdev's phydev directly
Date: Wed, 11 Sep 2024 19:49:00 -0700
Message-ID: <20240912024903.6201-7-rosenp@gmail.com>
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

Avoids having to use own struct member.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 49 +++++++++++++---------------
 drivers/net/ethernet/ibm/emac/core.h |  3 --
 2 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 65e78f9a5038..f79481b6da30 100644
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
-				      0, dev->phy_mode);
-	if (!dev->phy_dev) {
+	phy_dev = of_phy_connect(dev->ndev, phy_handle, &emac_adjust_link, 0,
+				 dev->phy_mode);
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
@@ -3257,9 +3255,6 @@ static void emac_remove(struct platform_device *ofdev)
 	if (emac_has_feature(dev, EMAC_FTR_HAS_ZMII))
 		zmii_detach(dev->zmii_dev, dev->zmii_port);
 
-	if (dev->phy_dev)
-		phy_disconnect(dev->phy_dev);
-
 	busy_phy_map &= ~(1 << dev->phy.address);
 	DBG(dev, "busy_phy_map now %#x" NL, busy_phy_map);
 
diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/ibm/emac/core.h
index 5a9d4b56d7cf..89fa1683ec3c 100644
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


