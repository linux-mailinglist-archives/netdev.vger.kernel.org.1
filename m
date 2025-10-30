Return-Path: <netdev+bounces-234513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4628CC22724
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 22:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9FEC4E58AF
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 21:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAA031A05E;
	Thu, 30 Oct 2025 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y00uQ3SN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACEB314B7A
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860549; cv=none; b=Rexrne4zdBYC12uVy5SlHboAX9O0dzqlZNyNoDupaKaqC41RFDI5h3rwWVCrBzgVcVWWskRC53MFbmXTfsmh3Z49dHlYtdL8RTGDr4kKL8uE4ohTb+ic/dPrlj+FStpqIfifQ7sMAWut7JTINTQEL5urnuSpGHejPdHdXDXioVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860549; c=relaxed/simple;
	bh=TvNDWVdmpvbEbvmft7H46461xn5+3cCucjLuAiYQSuY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GOmAmmQ7Xpiuldr0H2FAXwr2MkDYK4JXDorAkEJ+QEO9weRbReYMOZA82BtldDW8u+HHpcK/ozGwIcKGylFcst6IqrB9Fyud6ckcLn6FwTKwapXtSd7lcoIXQ04Xf4qEKEaGdOKLqkAZFV4mxXM79hldiprpWvwvDGS5MqAfqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y00uQ3SN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b6d70df0851so323146266b.1
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761860546; x=1762465346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vjUgQuKKSNZeUncCHSxC9aLRNOsmNXtDbAw5szG7GiA=;
        b=Y00uQ3SNMk4jOExM9mDdUX0wNumhzLiI8hGf6+KvOXNSiZHa4BH8n/QNPMEOfAxsoK
         8BqLA6Tfq7Jg3VqYvevLAGeYUvSQVtP1UkCOUoIo12qziJUrfE9ZWKqfdBKjrrs+N09T
         T7oRXEN/5VjObxSz9on+B5pIatciGMnbzInDCVfNKmOvLbU04WGD0PjbqH+Mq+7dAGgo
         XY4i+npw3xBOzQKDb7WxPrbzZqy6ZEewIo6b75MGQGUI/L2aJlRGSgK1VCuCKgRgfKrv
         gRlEvS4j6waPC6CWRAMFfSLiAytHwPLFf1ptYBdvqGEETKIhH9TVoLG6W8A0JrKiYtak
         R+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860546; x=1762465346;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjUgQuKKSNZeUncCHSxC9aLRNOsmNXtDbAw5szG7GiA=;
        b=C5oLArWu/THFIudk795mvYpP09KvuNQ4VxhoMJ4GU3lZ/GQYs0OBPk/8xmsi9mYxZr
         3ZdhRoB1I0TB4wMimAGHh0uMMAzEpoFeFQiNY6k0UhkBr6pamAjXbnqFmoUphJkqApvh
         iTRWml5IdgZX01qpKajzFCyzITf5YJ+9bycqhzGxRhLvL9xWtk2YCBYzDfVb9QMvJTOT
         BGMBQWgdro7h31JRNWVK8yTX5W613ll+APo6JZz7QDgBzJznbnQk71CtQvVEp93Xi0dY
         OFgCuhUw9835y6fy92cwngoxw5CFtC3d+FvBXszNsf+wm65OcbZPGkJoqaaPDzOTWL+k
         +ncA==
X-Forwarded-Encrypted: i=1; AJvYcCUIqiMFrvsbk3UUB2iqxcWD1zB7x76lYxUP20MWIP1fl3hvn69Oo991kYYX9hPlTNIevQ0rp4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwoOP1ijyX2zseSeuSAuPArAswaKIuPiZXZ+Nv05D6r3a3YPmx
	8L6CXfZt7RuSvMNv3a6vLsqjirT/Uii5Xv/QG3ArMOgM1QupSniqsXoo
X-Gm-Gg: ASbGncuZU7/FQR8/6iVh+zwKFfZSlw/vJtJ5rU8z1O9O9UPEJgKOCeMuMyW/7VwK3ve
	cUQnCQ/yvk1fn1U5LFCWCFBY3B+XLVvsbiFwpFxD3gsY7xvg0fgHRuT2chkJs1yTTq+p4XNnTpd
	82iG+iNvNZ4kmKA2jdaQuprXvfgd4xwHVHYngm9m5eHwXPp2J+67qd6WgFZJp6gsonDOWmgObxX
	YuIWBAKmsmEAt8Zu2BP9LcDdw2lvAjBf8xz56Cwk93hFcu6p4HLL/WJQR6yPdBn1gKwvFpFjhoI
	oZjndvv/slCRRJUF2O1NO5eT4TlIsZuu9MEJ/4TbBZUfDSIY/Qy02CBdgIvsjjxwAZLGoUV9OJ+
	WbTLR5SDx4gdoK/99L8agpY8hfNowhFS3Ws/kFokIcVWGLmpR/p43wYM4/dvCAeqScHmnCFKDOP
	WbFg6dfweOifmz7hBxPMyJpvz7QaXnLmXz6A7LBKuT9/ZeeLAUhzK9aere5dkqLQzJMM745b+x1
	UBjd9RjbJ+V9ETuBFbkecuui0C8Myuopz/ZULOowl4=
X-Google-Smtp-Source: AGHT+IERJM08TZ8bXx+ck0uj2d1X7qOQAV88F/tMs34SYSvoPqnMtrIfOQ8jsjc5sU98I59xCP9tTA==
X-Received: by 2002:a17:906:9fc4:b0:b6d:a7ad:2fda with SMTP id a640c23a62f3a-b70700b5861mr123536666b.12.1761860546056;
        Thu, 30 Oct 2025 14:42:26 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f48:be00:f474:dcfc:be2f:4938? (p200300ea8f48be00f474dcfcbe2f4938.dip0.t-ipconnect.de. [2003:ea:8f48:be00:f474:dcfc:be2f:4938])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308cc6sm1866709666b.12.2025.10.30.14.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 14:42:25 -0700 (PDT)
Message-ID: <adf4dc5c-5fa3-4ae6-a75c-a73954dede73@gmail.com>
Date: Thu, 30 Oct 2025 22:42:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/6] net: fec: register a fixed phy using
 fixed_phy_register_100fd if needed
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Greg Ungerer <gerg@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Hauke Mehrtens
 <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Chan <michael.chan@broadcom.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <0285fcb0-0fb5-4f6f-823c-7b6e85e28ba3@gmail.com>
Content-Language: en-US
In-Reply-To: <0285fcb0-0fb5-4f6f-823c-7b6e85e28ba3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In case of coldfire/5272 a fixed phy is used, which so far is created
by platform code, using fixed_phy_add(). This function has a number of
problems, therefore create a potentially needed fixed phy here, using
fixed_phy_register_100fd.

Note 1: This includes a small functional change, as coldfire/5272
created a fixed phy in half-duplex mode. Likely this was by mistake,
because the fec MAC is 100FD-capable, and connection is to a switch.

Note 2: Usage of phy_find_next() makes use of the fact that dev_id can
only be 0 or 1.

Due to lack of hardware, this is compile-tested only.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/freescale/Kconfig    |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 52 +++++++++++------------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index bbef47c34..e2a591cf9 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -28,6 +28,7 @@ config FEC
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select CRC32
 	select PHYLIB
+	select FIXED_PHY if M5272
 	select PAGE_POOL
 	imply PAGE_POOL_STATS
 	imply NET_SELFTESTS
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c60ed8bac..0b71e4c15 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -52,6 +52,7 @@
 #include <linux/of_net.h>
 #include <linux/phy.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/phy_fixed.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/prefetch.h>
@@ -2476,11 +2477,8 @@ static int fec_enet_parse_rgmii_delay(struct fec_enet_private *fep,
 static int fec_enet_mii_probe(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct phy_device *phy_dev = NULL;
-	char mdio_bus_id[MII_BUS_ID_SIZE];
-	char phy_name[MII_BUS_ID_SIZE + 3];
-	int phy_id;
-	int dev_id = fep->dev_id;
+	struct phy_device *phy_dev;
+	int ret;
 
 	if (fep->phy_node) {
 		phy_dev = of_phy_connect(ndev, fep->phy_node,
@@ -2492,30 +2490,28 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 		}
 	} else {
 		/* check for attached phy */
-		for (phy_id = 0; (phy_id < PHY_MAX_ADDR); phy_id++) {
-			if (!mdiobus_is_registered_device(fep->mii_bus, phy_id))
-				continue;
-			if (dev_id--)
-				continue;
-			strscpy(mdio_bus_id, fep->mii_bus->id, MII_BUS_ID_SIZE);
-			break;
-		}
+		phy_dev = phy_find_first(fep->mii_bus);
+		if (fep->dev_id && phy_dev)
+			phy_dev = phy_find_next(fep->mii_bus, phy_dev);
 
-		if (phy_id >= PHY_MAX_ADDR) {
+		if (!phy_dev) {
 			netdev_info(ndev, "no PHY, assuming direct connection to switch\n");
-			strscpy(mdio_bus_id, "fixed-0", MII_BUS_ID_SIZE);
-			phy_id = 0;
+			phy_dev = fixed_phy_register_100fd();
+			if (IS_ERR(phy_dev)) {
+				netdev_err(ndev, "could not register fixed PHY\n");
+				return PTR_ERR(phy_dev);
+			}
 		}
 
-		snprintf(phy_name, sizeof(phy_name),
-			 PHY_ID_FMT, mdio_bus_id, phy_id);
-		phy_dev = phy_connect(ndev, phy_name, &fec_enet_adjust_link,
-				      fep->phy_interface);
-	}
+		ret = phy_connect_direct(ndev, phy_dev, &fec_enet_adjust_link,
+					 fep->phy_interface);
+		if (ret) {
+			if (phy_is_pseudo_fixed_link(phy_dev))
+				fixed_phy_unregister(phy_dev);
+			netdev_err(ndev, "could not attach to PHY\n");
+			return ret;
+		}
 
-	if (IS_ERR(phy_dev)) {
-		netdev_err(ndev, "could not attach to PHY\n");
-		return PTR_ERR(phy_dev);
 	}
 
 	/* mask with MAC supported features */
@@ -3622,8 +3618,9 @@ static int
 fec_enet_close(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct phy_device *phy_dev = ndev->phydev;
 
-	phy_stop(ndev->phydev);
+	phy_stop(phy_dev);
 
 	if (netif_device_present(ndev)) {
 		napi_disable(&fep->napi);
@@ -3631,7 +3628,10 @@ fec_enet_close(struct net_device *ndev)
 		fec_stop(ndev);
 	}
 
-	phy_disconnect(ndev->phydev);
+	phy_disconnect(phy_dev);
+
+	if (!fep->phy_node && phy_is_pseudo_fixed_link(phy_dev))
+		fixed_phy_unregister(phy_dev);
 
 	if (fep->quirks & FEC_QUIRK_ERR006687)
 		imx6q_cpuidle_fec_irqs_unused();
-- 
2.51.1



