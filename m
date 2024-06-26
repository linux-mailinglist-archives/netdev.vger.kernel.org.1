Return-Path: <netdev+bounces-107026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2556918A30
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66ADB1F257FE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1325190043;
	Wed, 26 Jun 2024 17:35:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7A13B5BB;
	Wed, 26 Jun 2024 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423316; cv=none; b=Sx2Zww0NzfLByjbhd9BThoGLkteXKtxkvU24CFSYFaJt4uYHHPDzKkRbF754I3hleVW9z3/xEFLBEtcl0pSz9Yw36poXmGBeM9bYV7CybLOti4kzVfDmLu8p4OZxQKHXY4e8QwxUqKTfLlhYlDM5sB0t2sSjd/aCSja+Ki4ysUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423316; c=relaxed/simple;
	bh=fph8E5X9oA2wmkoFT3JrWcqdJYi4bxA4WkIVzc5FymI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXb7qEQhMP5cA7XLtciccHAFnGXactlq75Ojdhev5hCCv1f+uJ1dLPcPH6pt551cyXEwFOGd6eZCtx7UNCN1KX8wggdM6DDf2hR5v4Kz4DPJIrpoToXih6ERuAXfjOfgjXiIOt8H8e4gr9/1VbALz5NZWvp1KacPw7Qz99w7OBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6fe61793e2so308499066b.0;
        Wed, 26 Jun 2024 10:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719423313; x=1720028113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ow1/zkrwYlXL87F3Jhh935fE1AcOFBtgfTMUkpcve0g=;
        b=uIOAceReHIxezGn3hOcpK80/kC21/VfYk7/0uvwOwb6q5vVMJ893qFJvUdnpUrOaN5
         VHTFtxutiC/z12fLexHSUXf+zQAYJ4U4SFi1DmoL1MPgeAhqYsVxXlKn/G3S6jcz4y1R
         OmPCSJwaJMXKYG5QQ8POTR4eB5PbOwvheUfrQGo68XGWlX7z06guJchqDxJud3rZdaAg
         5zKzU0BQ7/4drC5ouOHOADNrERN+6X0ubxclb3nKeyNjsPQwugWC82PMrJVDZtOis/xx
         dBh0TlxdkHErP/hwQ6/+SDqrdQb07+k85/PPq0J2M0l64IzGa/KbKizdn4wGQyGCGKnO
         3vew==
X-Forwarded-Encrypted: i=1; AJvYcCXJxRKqvBEL5g+AHMN+lh7MtfeOxfETm06MzTNwtHFUl8NvzJ0Fi+Xx13wAiYGO+aw1dAYlGJsUmU6w1KBP5wrdeQPBXws4lSII9/38iay0gBTddtyQbzXkymFVAR3weFjAWbe9
X-Gm-Message-State: AOJu0Yx4bAVLnvVtOb92la/PbzAA/YJqNSL/MVMymxDNsH7W9+sXQg5d
	UgUs/J0EkaIgxU9bGBwKqNs5lDa6maPBOujlNJ+ORj4qX9p8q1In
X-Google-Smtp-Source: AGHT+IGd5w8E3YSQlN+Wteim20OJPCRnGzSrcDQQ4ewgWBwEl7pRbve5ElLzoCZ3gjCNKsuDtUIfug==
X-Received: by 2002:a50:99dd:0:b0:57c:5874:4f5c with SMTP id 4fb4d7f45d1cf-57d4bdcad82mr10024152a12.32.1719423313055;
        Wed, 26 Jun 2024 10:35:13 -0700 (PDT)
Received: from localhost (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30bd5f1asm7471524a12.37.2024.06.26.10.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:35:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] net: thunderx: Unembed netdev structure
Date: Wed, 26 Jun 2024 10:35:02 -0700
Message-ID: <20240626173503.87636-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embedding net_device into structures prohibits the usage of flexible
arrays in the net_device structure. For more details, see the discussion
at [1].

Un-embed the net_devices from struct lmac by converting them
into pointers, and allocating them dynamically. Use the leverage
alloc_netdev() to allocate the net_device object at
bgx_lmac_enable().

The free of the device occurs at bgx_lmac_disable().

 Do not free_netdevice() if bgx_lmac_enable() fails after lmac->netdev
is allocated, since bgx_lmac_disable() is called if bgx_lmac_enable()
fails, and lmac->netdev will be freed there (similarly to lmac->dmacs).

Link: https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:

v2:
	* Fixed a wrong dereference in netdev_priv (Jakub)

 .../net/ethernet/cavium/thunder/thunder_bgx.c | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index a317feb8decb..a40c266c37f2 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -54,7 +54,7 @@ struct lmac {
 	bool			link_up;
 	int			lmacid; /* ID within BGX */
 	int			lmacid_bd; /* ID on board */
-	struct net_device       netdev;
+	struct net_device       *netdev;
 	struct phy_device       *phydev;
 	unsigned int            last_duplex;
 	unsigned int            last_link;
@@ -590,10 +590,12 @@ static void bgx_sgmii_change_link_state(struct lmac *lmac)
 
 static void bgx_lmac_handler(struct net_device *netdev)
 {
-	struct lmac *lmac = container_of(netdev, struct lmac, netdev);
 	struct phy_device *phydev;
+	struct lmac *lmac, **priv;
 	int link_changed = 0;
 
+	priv = netdev_priv(netdev);
+	lmac = *priv;
 	phydev = lmac->phydev;
 
 	if (!phydev->link && lmac->last_link)
@@ -1052,12 +1054,18 @@ static int phy_interface_mode(u8 lmac_type)
 
 static int bgx_lmac_enable(struct bgx *bgx, u8 lmacid)
 {
-	struct lmac *lmac;
+	struct lmac *lmac, **priv;
 	u64 cfg;
 
 	lmac = &bgx->lmac[lmacid];
 	lmac->bgx = bgx;
 
+	lmac->netdev = alloc_netdev_dummy(sizeof(struct lmac *));
+	if (!lmac->netdev)
+		return -ENOMEM;
+	priv = netdev_priv(lmac->netdev);
+	*priv = lmac;
+
 	if ((lmac->lmac_type == BGX_MODE_SGMII) ||
 	    (lmac->lmac_type == BGX_MODE_QSGMII) ||
 	    (lmac->lmac_type == BGX_MODE_RGMII)) {
@@ -1116,7 +1124,7 @@ static int bgx_lmac_enable(struct bgx *bgx, u8 lmacid)
 		}
 		lmac->phydev->dev_flags = 0;
 
-		if (phy_connect_direct(&lmac->netdev, lmac->phydev,
+		if (phy_connect_direct(lmac->netdev, lmac->phydev,
 				       bgx_lmac_handler,
 				       phy_interface_mode(lmac->lmac_type)))
 			return -ENODEV;
@@ -1183,6 +1191,7 @@ static void bgx_lmac_disable(struct bgx *bgx, u8 lmacid)
 	    (lmac->lmac_type != BGX_MODE_10G_KR) && lmac->phydev)
 		phy_disconnect(lmac->phydev);
 
+	free_netdev(lmac->netdev);
 	lmac->phydev = NULL;
 }
 
@@ -1414,7 +1423,7 @@ static acpi_status bgx_acpi_register_phy(acpi_handle handle,
 
 	acpi_get_mac_address(dev, adev, bgx->lmac[bgx->acpi_lmac_idx].mac);
 
-	SET_NETDEV_DEV(&bgx->lmac[bgx->acpi_lmac_idx].netdev, dev);
+	SET_NETDEV_DEV(bgx->lmac[bgx->acpi_lmac_idx].netdev, dev);
 
 	bgx->lmac[bgx->acpi_lmac_idx].lmacid = bgx->acpi_lmac_idx;
 	bgx->acpi_lmac_idx++; /* move to next LMAC */
@@ -1483,7 +1492,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 
 		of_get_mac_address(node, bgx->lmac[lmac].mac);
 
-		SET_NETDEV_DEV(&bgx->lmac[lmac].netdev, &bgx->pdev->dev);
+		SET_NETDEV_DEV(bgx->lmac[lmac].netdev, &bgx->pdev->dev);
 		bgx->lmac[lmac].lmacid = lmac;
 
 		phy_np = of_parse_phandle(node, "phy-handle", 0);
-- 
2.43.0


