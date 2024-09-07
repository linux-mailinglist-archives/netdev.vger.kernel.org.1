Return-Path: <netdev+bounces-126248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEF69703A9
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 20:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57B82837D8
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 18:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978C916B72B;
	Sat,  7 Sep 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inPcbIic"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9BC16B396;
	Sat,  7 Sep 2024 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734742; cv=none; b=pguXusov1tPwCtcGmB5qL7NxcQjgQIBku0qzaAMtUxXBMrzeZBRUSvVRWOlXZAgW+cFe2t0KNQ1EUiB7dOWDkEGZTfVouZWbDN4xRG38QTgRFcgzD9KArUGvNoJLyKdgwv86WD2p5qGcXCGuPrILXp3zy9HsnU4RDMqTJHtb/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734742; c=relaxed/simple;
	bh=H8SN0p6mNaKXZJ+XbcZbSggjtY2meUxNNeSWEiCPrP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mY/NtHmVKhsDOt3cYQj9nJQw9x5OoD+u5OXf4TLe9M2eAcAW+cX8+U6HMAY9cpcVYF/NVk06LDP5aOb7v3Jb9S35/WVFJvpGJfvAtDbOqkvd3ta/NHR5lBqGBim4idLka2r0aY6JLQAS31Whi2HHdNQ5cR+KXiV4t2KgRjrtlc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inPcbIic; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718e56d7469so399655b3a.0;
        Sat, 07 Sep 2024 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725734740; x=1726339540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqrZ86leH6CKDA18mB55EYOs04WJksmldMF1y9Gg60g=;
        b=inPcbIicyhFoZbc80QfRE6WlrNm2z1CEIGo5aFlrzO+bzPKLC/048Od5tqIEOvB9CH
         a4Q4ZsPn7du0rcNjFwdQmEORnTyGk3wX1xkMkZWXOZqXJYrXLIrtcYxWH1RD815qmEmK
         GDbSXqc4h+NCdn5s/IqyLxQe6kvXqzDpLXeE1z6cUssbFXokKqRgdoHuLsX3vBOY1i+5
         OeGKBtIoMJCwv0nUjt5usPXpl6+3FTiZEdrIQdQjo+hdj7VGRmLlLWQlsK1bWZ9aGgjI
         4bgYEuwlxEqKqZBP27XDIsBg7LioUaNh/qqgUeOhyHBjRv8hZHinSd+rZ8QjHH1cAOYz
         O55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734740; x=1726339540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqrZ86leH6CKDA18mB55EYOs04WJksmldMF1y9Gg60g=;
        b=QQNhsgv1bvhOdi01/lGXqmsVmRfZV4p7vnhjcMKEUaTnMvAid4H0NWUPdoyxXGuary
         jRAoEA4l8gwtQpTMcihIIJrlskCQEJ7j2xQBh2jVUPchDonUwvdylALqKQ3WBmLO/YtC
         GGMHfzo1gC9klrRuK4NRLG3cdfQVeIqBakCF9tAPJxYUp2em6ghdkKF54G4ycYVd7WhS
         LI1QC9GUwfYPmNL7RDGcnZr6RfV92pNL+W0UdoPCFM9C+IC12dVqjiTTLstTzl7OUobv
         4puonqkbZrnBagjK5lPz2nNs3petP0uQbMbe3qwRbPLepre86hQ6qbJnzQ7SvB6VVzYA
         BdeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeTmYudThFgl9aP8NWi1Yawj8eaUMb0BoCEceP6y81UkUJzkTnS57iIAkteIzaTanDYky2rH5ohKyz+z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1fBcK+8x84IT7XT338+bBd4umUbCX5a8Hzhu/cAtpJ2/JmjKI
	NurapcPYOsy3+qHeB1dRn7Q5EevkSW8AHw6rzOJUW1djO84XPQhZODsRYLRW
X-Google-Smtp-Source: AGHT+IH9aCoYxDsb38F3dT4qPJqTUllT+fIbcC1PFGzwE9jDJZckUt8LtRgyo3TwmbdxAj8xN2bpLQ==
X-Received: by 2002:a05:6a00:9444:b0:713:e3f9:b58e with SMTP id d2e1a72fcca58-718d5eefb46mr6451711b3a.17.1725734740040;
        Sat, 07 Sep 2024 11:45:40 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ab18bfsm1111239a12.88.2024.09.07.11.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:45:39 -0700 (PDT)
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
Subject: [PATCHv4 net-next 5/8] net: ibm: emac: use netdev's phydev directly
Date: Sat,  7 Sep 2024 11:45:25 -0700
Message-ID: <20240907184528.8399-6-rosenp@gmail.com>
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

Avoids having to use own struct member.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 49 +++++++++++++---------------
 drivers/net/ethernet/ibm/emac/core.h |  3 --
 2 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 71809450b3f3..3096e4e6b5e5 100644
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


