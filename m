Return-Path: <netdev+bounces-162193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377A3A260FD
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C517A0573
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 17:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F77720B7FB;
	Mon,  3 Feb 2025 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="FAH1Wn6x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698420AF96
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602596; cv=none; b=AN7YGQvOlxzY+kMFA8zH7oGe5E5QkLR9ZPQgVFsnU5XZD+vjST6EdX6yD3NsOBslyyPtvwZoqYTAaT7cuo4n3u4oSIOnu3RR+JyQp9rHnj+nNAPdnfxciYaWZ1oHy3M2aDy9JKNoCVOi8vnyUCLWsv4sIqrgrVldhpdFnGSSouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602596; c=relaxed/simple;
	bh=SXFqC3GVQkD/2PTYtutR27FxaGFkclss2JtUVCOlaeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dk0L3YswyogstaMObhGKSCvDgWIZpamwcBWC88rWSr/c4FZdXsrhFSCn70kqZUGYASk5slSaVeYw6wAGmHm/63aDP+2CDsw53KclNx2XEJCBsm9kL4w+zoifoWGy5MesVZaJdgHXaqy07BbuKfk8c8X7k4lfj0rxmb3Zwi65hvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=FAH1Wn6x; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab6f636d821so691908666b.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 09:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1738602591; x=1739207391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eksEQebHQVa7hAdVv6wfTibFsvEsjwpBHgMoKU8/cxg=;
        b=FAH1Wn6xu9xvEzXRDXzDgiFv8tIQKwBcgeFS6fmKluD/fa9DJluquB9Q85Q3soYuUP
         7H6OUp/aveIfnNjI6so31lJIqCIcoAQ09H0JEmAgceLr6PVDcLvwxK47vNVoOuheFwd1
         JN7WVTRf03CcpGlI8VLwlvJX5wqswWVIMEAe0icbsXY0dkwKVcZMpbwQqH4EgRrsZ/q7
         ea94JNIF0xfkibwHWaGVmOSfziR21CmKNoH1V50soNFbNuhffsBHROAVJzfgIPNaukSG
         oElVh4DJlegDDI0UvY1QD+rdKQvAUaEZM+euWtbh0TxWwaemlqIqGAYD3TbrcR+2IdTh
         TUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738602591; x=1739207391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eksEQebHQVa7hAdVv6wfTibFsvEsjwpBHgMoKU8/cxg=;
        b=Q0/d3wh2DAJC7TNYcuJd2VcA4wF4sFU6KqUS/z/lXmZDIwuCcKttyDwzyNTimUhUfX
         QCDJVNnVmkcs/WluFHOMSnzpFbkwgrmFyFhKshfXkVJRq6shv8tbetjvV3PTKAU96i19
         u/OW6gkpMZyLv5PfeN4r09jhopEgbpraDbZps+T9sNCVdOF+yKb5apnC138IwK7yU7Ra
         Oq7tdTVo2wHSHtqGUd6Aqbjv1AMOOEV/8+jVVd3UhmBUC3egfBD/7hMVrSFJgSo35bwj
         7o6aO7xKE1ONnV8f6EcC0MmtJxII4WblK6BA4G8R5HzW0brNZJM3E5qNKS38vfT9Inzr
         aD7A==
X-Gm-Message-State: AOJu0Ywy+tnmZVfp24xVYTnoDhKgFMEPWr/DpVi7ujuwbTvusqKjc9/+
	u2KztVJCQ4qFIHp/eqBIOxDBc7BRG1Kk3b+2IcJXzZKEW2rPr2Kaul6WplO9z5E=
X-Gm-Gg: ASbGnctFNYwDu77k6rmO5hXTMKCm9IXQCL0hyV5B0qDn7itV8VoSyDnzePsGWKjiG3d
	JzlVCIrcdfRtbWrcE+RepqhadfHXUH1DgsV5QbVGqD993g76OJpGaDi3016AGam6TQDu2oGoFRY
	eyydXUYr1g6rbG3VEVuqgrWKTZXk0gaerrC4PZY0m39hAf8QMcLgi0aTNpSmIHIf4Oz7EYrc18d
	+tid/JPAxIgOnJbcW/zZDlzhzKRz6QQhPq+v/3COlDb9W6ExKZMrhlGFztq4dntFTpCsZteh65O
	a2ZKdDdHNu8wpTA=
X-Google-Smtp-Source: AGHT+IHm3lvdOVBK08x71NIQ4g8uOHa3z7Flg3SfLzj55T4B2PjV/ugNB/4jIcX7xqSKo29Zb5cA/g==
X-Received: by 2002:a17:907:d30c:b0:ab6:eec5:a7cd with SMTP id a640c23a62f3a-ab6eec5aa1fmr1902610666b.32.1738602591169;
        Mon, 03 Feb 2025 09:09:51 -0800 (PST)
Received: from cobook.home ([2a02:810a:b8b:f900::9891])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47f2071sm778794066b.85.2025.02.03.09.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:09:50 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next] net: renesas: rswitch: cleanup max_speed setting
Date: Mon,  3 Feb 2025 18:09:41 +0100
Message-Id: <20250203170941.2491964-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was observed on spider board that with upstream kernel, PHY
auto-negotiation takes almost 1 second longer than with renesas BSP
kernel. This was tracked down to upstream kernel allowing more PHY modes
than renesas BSP kernel.

To avoid that effect when possible, always set max_speed to not more
than phy_interface allows.

While at this, also ensure that etha->speed always gets a supported
value, even if max_speed in device tree is set to something else.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 48 ++++++++++++++------------
 drivers/net/ethernet/renesas/rswitch.h |  1 +
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 84d09a8973b7..4b4e174e3abb 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1308,37 +1308,41 @@ static struct device_node *rswitch_get_port_node(struct rswitch_device *rdev)
 
 static int rswitch_etha_get_params(struct rswitch_device *rdev)
 {
-	u32 max_speed;
+	struct rswitch_etha *etha = rdev->etha;
 	int err;
 
 	if (!rdev->np_port)
 		return 0;	/* ignored */
 
-	err = of_get_phy_mode(rdev->np_port, &rdev->etha->phy_interface);
+	err = of_get_phy_mode(rdev->np_port, &etha->phy_interface);
 	if (err)
 		return err;
 
-	err = of_property_read_u32(rdev->np_port, "max-speed", &max_speed);
-	if (!err) {
-		rdev->etha->speed = max_speed;
-		return 0;
-	}
-
-	/* if no "max-speed" property, let's use default speed */
-	switch (rdev->etha->phy_interface) {
-	case PHY_INTERFACE_MODE_MII:
-		rdev->etha->speed = SPEED_100;
-		break;
+	switch (etha->phy_interface) {
 	case PHY_INTERFACE_MODE_SGMII:
-		rdev->etha->speed = SPEED_1000;
+		etha->max_speed = SPEED_1000;
 		break;
 	case PHY_INTERFACE_MODE_USXGMII:
-		rdev->etha->speed = SPEED_2500;
+	case PHY_INTERFACE_MODE_5GBASER:
+		etha->max_speed = SPEED_2500;
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	/* Allow max_speed override */
+	of_property_read_u32(rdev->np_port, "max-speed", &etha->max_speed);
+
+	/* Set etha->speed to one of values expected by the driver */
+	if (etha->max_speed < SPEED_100)
+		return -EINVAL;
+	else if (etha->max_speed < SPEED_1000)
+		etha->speed = SPEED_100;
+	else if (etha->max_speed < SPEED_2500)
+		etha->speed = SPEED_1000;
+	else
+		etha->speed = SPEED_2500;
+
 	return 0;
 }
 
@@ -1412,6 +1416,13 @@ static void rswitch_adjust_link(struct net_device *ndev)
 static void rswitch_phy_remove_link_mode(struct rswitch_device *rdev,
 					 struct phy_device *phydev)
 {
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
+
+	phy_set_max_speed(phydev, rdev->etha->max_speed);
+
 	if (!rdev->priv->etha_no_runtime_change)
 		return;
 
@@ -1431,8 +1442,6 @@ static void rswitch_phy_remove_link_mode(struct rswitch_device *rdev,
 	default:
 		break;
 	}
-
-	phy_set_max_speed(phydev, rdev->etha->speed);
 }
 
 static int rswitch_phy_device_init(struct rswitch_device *rdev)
@@ -1462,11 +1471,6 @@ static int rswitch_phy_device_init(struct rswitch_device *rdev)
 	if (!phydev)
 		goto out;
 
-	phy_set_max_speed(phydev, SPEED_2500);
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
 	rswitch_phy_remove_link_mode(rdev, phydev);
 
 	phy_attached_info(phydev);
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index 532192cbca4b..09f5d5e1933e 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -920,6 +920,7 @@ struct rswitch_etha {
 	bool external_phy;
 	struct mii_bus *mii;
 	phy_interface_t phy_interface;
+	u32 max_speed;
 	u32 psmcs;
 	u8 mac_addr[MAX_ADDR_LEN];
 	int link;
-- 
2.39.5


