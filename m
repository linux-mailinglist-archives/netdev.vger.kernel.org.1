Return-Path: <netdev+bounces-124703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B5D96A7A8
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F26281471
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F8C1D5891;
	Tue,  3 Sep 2024 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzkYdbB9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1551D9D8C;
	Tue,  3 Sep 2024 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392605; cv=none; b=tigJHrW2HVG6lCoNmefzFUG/PheHAlcI82FeZGgGpDsDpvq4CcMfBIoYQSDy8NGtyMgBNX8Lqky+EfrJABucrvQONx9pV7ebaiswlay00PRIIiZfrRgGyDt6AVaffhNI+rFOKR5iUSGV4ZGtu7gGNkQuhkCcNVSm0X1knUp/euw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392605; c=relaxed/simple;
	bh=mX3kGLJighXuGvdOPieHdrb0awbzzcng29W+gPcAoz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0+T3KVL2eJwQfteylZXBVnG9ZqBHWKbfD68s8rUNIiXNOaEOH0CVdIMtahOCejpbJrygAw42Yper23N4YabpMRvUMqRNzUHf9rqmi2ZXI0TQPduV8yU4p38kZeH9i/Kut0+OzKUsVbxpn8uFtK8S0Z/Jz4DF1ccu5bEHrQUlGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzkYdbB9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so592175a12.2;
        Tue, 03 Sep 2024 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725392603; x=1725997403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81sQTGyUrTjqH1KfW7Mrw33abUjSwj5schWd4BTRCqE=;
        b=lzkYdbB9BkTtiYTxMhkfxiMlnEHar4G2++K+mzd3F/FXSTLH4tE0M7i/JlQZonjEV7
         8VtimPYDqwrBmA1EXl7N1UAutTRGkX74SXWRTuxhDaKWmbmKzJTX9ExGD7VFwILWu/G1
         jT7DSz/sZ3gcnjoSmDE2powcQ52keqPENnVUQ68YSAlRmnRrxmoinzcRMEveQ78498ME
         DTrfh3oc1QGZMnO2f5pYVvq5IWGs8PtgHCWN/S8ECvqR3KWcYTnfd6/PRkEnEi+wsF7U
         vIg08MQ7X79Xt2qhibnSCyd6nRgMZ+XaBRhVEzT2mboFzPvQXZnecYg2huhTYEZ6t15K
         BYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392603; x=1725997403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81sQTGyUrTjqH1KfW7Mrw33abUjSwj5schWd4BTRCqE=;
        b=E9PlbSlG9PjGsiDwzF4Ji+ducTSKwRqs4295rGgB0qRlQYaeK5EuVNKZqaPslRENKf
         QkGZE6TO5szuOryzhrDeX3W1EWRXWcrs73JFmwcbCto86Y+vTpksh/hEJ/7k9ivQC8Ff
         ZhMhnmEOxOp4jKW96Y/iKGdUxdNdYxs5bNgqTUun90NbWj93wN0c1gAX475uCdmqwx+c
         fBntGlNfdKg0iyWqA/uZP8kSgvsiQ2SYeKS8/S52k4gAzlw+biu4HChrRoRGZx9oS0xJ
         qqCh7J0/IZlF0uT+a2hY74x0f+CrZChnuYInzwSkzJx64p++SUTd/AUVgmd1drJkaE4m
         k4Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVfKoLi6UruIAY4+1lTPyfmTuPpTspKKq801CzEuiLM5oSAKHHQfOw08BHSqayXjLFhYxCgMH2UC/+DSig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx217FhNRm+759FI7kmT+JrJIlcfelPPNHU8jbxmyceaHZz8OV6
	VaIUXthSjhtz5OLV+NtzXYkmccQ4Ot3r4LzqrsxNmVWWqGjJ6P1OT8HgmwnB
X-Google-Smtp-Source: AGHT+IGotFQpf5tNC3er0L31QQ5wJhj+55Q+ETcOBFhwKNK+JxKKpj6//TLEtDtYthACoxkaWXJrkg==
X-Received: by 2002:a17:903:32d0:b0:205:36dc:c3d9 with SMTP id d9443c01a7336-20536dcc7femr162505265ad.33.1725392602917;
        Tue, 03 Sep 2024 12:43:22 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea52a8asm1979505ad.182.2024.09.03.12.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:43:22 -0700 (PDT)
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
Subject: [PATCHv2 net-next 6/8] net: ibm: emac: use netdev's phydev directly
Date: Tue,  3 Sep 2024 12:42:42 -0700
Message-ID: <20240903194312.12718-7-rosenp@gmail.com>
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

Avoids having to use own struct member.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 47 +++++++++++++---------------
 drivers/net/ethernet/ibm/emac/core.h |  3 --
 2 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 45984e420488..121db9611cd9 100644
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
+	struct phy_device *phy_dev = dev->ndev->phydev;
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


