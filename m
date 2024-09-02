Return-Path: <netdev+bounces-124293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FDD968D33
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A90F1C20C27
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0983DAC0D;
	Mon,  2 Sep 2024 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2SK5XvD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0D3DABE8;
	Mon,  2 Sep 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300943; cv=none; b=cNwdA25eDtnAZske4aFaLiEJqLDPpL+NrHFdzv+2oF02maXJ1+7d7SjsJGLosJCEmbM54OIiSpCacgBrJdndC65ltobMTIjs4F4FMUkO8gvdCCc60Mj9VPglHOb0Eg87bhGoFKEh1e/eHbd/o880SdfmdBe2MzUnFf3wOwNZ/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300943; c=relaxed/simple;
	bh=sAzTeWjaMXA+mcojDxjAl+KB46Q8YZoFqsYu3ebkais=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNZ2zCnIyCfNItbHRVwSTEE8oKooN406eBKKBe8Z14LsIAS1SzwQWXxxh6eTcFdjEC+hO7SMZtrO+g9Qr5iOlVNpe74nImyr9o73miwPLII8cHZvxseIzMQcxSAgevaJEetpA9xGLGalb+mnONs6nDYRdFgdcaKaGfwIlasda/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2SK5XvD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-714186ce2f2so3653301b3a.0;
        Mon, 02 Sep 2024 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725300941; x=1725905741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0P2T6oCbry27gpab3OBQR4pOyHpWlTZxFjava/v4V4=;
        b=a2SK5XvDLmUL4LP5KE3kig3OP1jnlfBtM4HbMuqO9gaHev7uQ3WeUhLHP/gRsUlVLG
         WOgaJruaW+uUiJE/sIr19oTc9GtunHjYaiViBvrdR0e7xSvfpW6Dqwf/f9w3VrcqGryH
         1RSxiQY2CvZ6+w3OgrI2tprkbGfDufm9vU0fjx+lLAlyvoD+Crl+VsWTM+B8uTTnFgv1
         mBI82/t841TEjVBRbwsunYYrG14Fa1oFz4ArCdNfDAhYkmLTgDw4OKqJ9YlI72LhGe5T
         9f7b08muTZvCKr/JjSRhYYwf7KJhYWRlLyn/5RRvLuWjm4CQ/eKIir3xGRDwOgB+LE+7
         cViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725300941; x=1725905741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0P2T6oCbry27gpab3OBQR4pOyHpWlTZxFjava/v4V4=;
        b=FgSZAm2lTiVGguj38Bh5gmXRhdVOzgH/mO2iaFgeoTUc1nzOQNnYSGbx8YVsNLuCk9
         decT1xKsZTuaGknOJMWblddVsFybh3rI6Go1QFIH3UxZFvAW6UmSQi0S2uE+2bMIH7d8
         go9U0SuBxx8ZFWeORyz2VCe11vcW5D5SrexjSyyu9KKrvUkGhKeuLP2srGNUm9lXSZN5
         xCzo0FJm6+NAvdzInDsZjtGfwYEsWq8tL1ZUvoXh3bIg8qwO/i9LLeFV77Illx7/vcVQ
         TJMZZvWYLM2qJNZR8XT+NIiWgUgAF8kUxqogYA9txXe3eiXnoq5gn5IHt9bfqmSvXoU6
         MuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgzQOGbgyjOKxLLGgfhEvCSZ+uVCJ81MAadPU31t1fGqtF8u8a4nk0cp8rc65oH9XxNybvwnEGrLf8Um8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKe/9h2AtLvNaseUtjdGIkwnxdQZwPKUMBp84srtE0ShCAo/o8
	BN3V92PrxbtBGdOKNnifAe37HFp+n4y1jOz5fC4FS8m+tVczWMQXuTueEE3u
X-Google-Smtp-Source: AGHT+IEyFvkXw1jzLm4G63s1mqUkqbb8n9RJCxzbJDrEAsuxQUOtX7cAtZKe10z154S+t4jdqfm23w==
X-Received: by 2002:a05:6a21:39b:b0:1cc:ef31:da6d with SMTP id adf61e73a8af0-1ccef31dc1emr11120950637.52.1725300941404;
        Mon, 02 Sep 2024 11:15:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d7804sm7109167b3a.154.2024.09.02.11.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:15:41 -0700 (PDT)
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
Subject: [PATCH 6/6] net: ibm: emac: use netdev's phydev directly
Date: Mon,  2 Sep 2024 11:15:15 -0700
Message-ID: <20240902181530.6852-7-rosenp@gmail.com>
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

Avoids having to use own struct member.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 47 +++++++++++++---------------
 drivers/net/ethernet/ibm/emac/core.h |  3 --
 2 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index fa871d7f93a9..78cc57c8cd19 100644
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


