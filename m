Return-Path: <netdev+bounces-230688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473EFBED7F4
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 20:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02282620482
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E245262FD7;
	Sat, 18 Oct 2025 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9Mk7xJ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F953146D45
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760813267; cv=none; b=lqsvdLVCVtFfaOTKfSCZnvRfL/0mqgoCbqYW9hjgSM2pn7jATm6jQEuhsS4sXfXp4s5VyPSziAI/aAJT0N6+iIsftMZ4FF17fspwcvDeFb2czgARxRVTTYPGCLtCnczMzN6mRSrEVeL0CIv/aeViB/vjzZtCpDgQIAXg3V3r2gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760813267; c=relaxed/simple;
	bh=lYDtjA8Iwl8MNUrxgkqDynjG7ARlp0AhhJyUsZivEn4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=G27cp4zeQkMQAK66bF8X2nW7jj3pGoH+QUoxj0y5ZthrLTc3H/+0Sjtz231RrSP3OT5fJXVzdFIOonubPZyaSL6DWybdY/r6t479rBT5AXpNCMsP8CNZ049S9oHdpGehSZOFJj9G22qRz/CDH2EM0XoWJS7AAGvdDabM+YtuJ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9Mk7xJ3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4283be7df63so381225f8f.1
        for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760813263; x=1761418063; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0kl3Mx2HvT/QoI67STS3Sg7DwvWfAvzZyZD001INcdE=;
        b=W9Mk7xJ3/6QSPOJ97jH2bO6M7rxPPnbGdKMMrgx6EBl7E+DyJPTZpLGQpclDHWOKcO
         UPVu9IFEdRVGTPsrOpOwwMmcTBoNO48ywjv0LFUN2yO2+cyt3bQDfW5/vGPmtcNrasds
         yiN2dnWbuyIcxsh6Jhftmn1QCYhrEgdDaD/5jjK3I9peNRhTWY7zqhdZo9iGGUIfumyW
         YFS273AH9d+HP5g79/06YhMOA4qKJolZWG+wToGkPJncoyN5eZgKPseXmXSUQHPN3BFl
         4vnoWOxrue2+b6JBwiA4r93731BWMttTfJTllnYUHF84VXEp7SBgPuG7ouA5RbkNmw7R
         M8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760813263; x=1761418063;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0kl3Mx2HvT/QoI67STS3Sg7DwvWfAvzZyZD001INcdE=;
        b=cSos3A/Yx5t3GsnpWqCT+/YM3s1ZyzOdHMGKSgXCUYgEJgX+4uCTqlDxpskx55Uwtj
         S6mR53LRNf1mS9gDBGOJdWZ8LC4cakS0gNDzEIensSbbYuHJ3en+bATRPtfBNNcuGqy9
         YaHmHhEWTs7ANlU/2NiuAkRNFVMCHdBEd+GtsysJEUW+B+wYa7EM1uJtDtSt4399nZCw
         T12zGDNX/iLY3OA5ITAnDuky15WB6SDds+YGCiRpuh6mefRq1O8Q8//sxwYUfy+ONe5A
         Ff842GLIfhxhM03FYv3fzJ6SfUfksPtaaMqFXhVvTIQ8boJkuCxZMI4E+YG/Le0VYs+H
         nigQ==
X-Gm-Message-State: AOJu0YytocfC01vxM24+JYOWq02/f82916OwS/r0bgJfxoN2ITv7nqKK
	ZzwqDxhpRtV7g+LuIbT9S23FqykGJ/IZIcSdyRtRpCHgMoeeeJ0gVARD
X-Gm-Gg: ASbGncslw6tfAUsSXSM1ErcckzRrJBpR/LGPpheqTihc5exX9mI+jzjieL4MPrXScZd
	QcONcWenpmPhmDhVBrF49N4piAM0eAfwEmf1bI2HsnukrJb9dYL3KqVUQQDA/4WmqRsty48Xr1k
	l3L3O7SvdlVRd9wTmtBPs6R5TUcSBty+C9foroF6RdMbTvyec5jGIiz2cLIxPM6zCVbgPlVeuK4
	wxVFXwNDaz10qJAcWFUcmz8NdQBc/l/Q+w9CSHJTmCjLEvSFf6M5dRFX/qR+Y9buy40CBgVLQhu
	xqDxUao6ujp+a1dJYYdHdXy6EYm/wG9k6q2C6ZOfiy+k12TRZdq8QmQf6xoD+chvnJHyoRLlWuD
	Tk+v/KqBPYkEThS/xScG/lrqV1krJ5WBvO0MfpDijkuTYxLbO1U3GcVlj5B8mwp7ySGRJBsBHSB
	kdR7ZyrTY2iXAy9qHHO39lOepa52MNurwRrkAzNh+i+OGOzK4Df3QDdeIvqpZy5sbvoZgK0pPyH
	I038kO0ZMsChzuY8XjnwnNLeJQyjzfei4A+e2nKJb7GbrMI
X-Google-Smtp-Source: AGHT+IEbAa/zOXLabrZ+qh6MAEL5ItK4Yz5rziepaw1JNz6ok3iwkgjKZoHptDm8DDaa0bcutQjnVw==
X-Received: by 2002:a05:6000:22c6:b0:3ff:d5c5:6b0d with SMTP id ffacd0b85a97d-42704d497eemr4599806f8f.4.1760813263349;
        Sat, 18 Oct 2025 11:47:43 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f04:d100:f060:eb:b826:a912? (p200300ea8f04d100f06000ebb826a912.dip0.t-ipconnect.de. [2003:ea:8f04:d100:f060:eb:b826:a912])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4710ed57cedsm76762975e9.2.2025.10.18.11.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 11:47:42 -0700 (PDT)
Message-ID: <20ca4962-9588-40b8-b021-fb349a92e9e5@gmail.com>
Date: Sat, 18 Oct 2025 20:48:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] net: stmmac: mdio: use phy_find_first to simplify
 stmmac_mdio_register
To: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Simplify the code by using phy_find_first().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- remove variable addr and use phydev->mdio.addr
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 53 ++++++++-----------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index f408737f6..76a87e42e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -584,7 +584,8 @@ int stmmac_mdio_register(struct net_device *ndev)
 	struct device *dev = ndev->dev.parent;
 	struct fwnode_handle *fixed_node;
 	struct fwnode_handle *fwnode;
-	int addr, found, max_addr;
+	struct phy_device *phydev;
+	int max_addr;
 
 	if (!mdio_bus_data)
 		return 0;
@@ -668,41 +669,31 @@ int stmmac_mdio_register(struct net_device *ndev)
 	if (priv->plat->phy_node || mdio_node)
 		goto bus_register_done;
 
-	found = 0;
-	for (addr = 0; addr < max_addr; addr++) {
-		struct phy_device *phydev = mdiobus_get_phy(new_bus, addr);
-
-		if (!phydev)
-			continue;
-
-		/*
-		 * If an IRQ was provided to be assigned after
-		 * the bus probe, do it here.
-		 */
-		if (!mdio_bus_data->irqs &&
-		    (mdio_bus_data->probed_phy_irq > 0)) {
-			new_bus->irq[addr] = mdio_bus_data->probed_phy_irq;
-			phydev->irq = mdio_bus_data->probed_phy_irq;
-		}
-
-		/*
-		 * If we're going to bind the MAC to this PHY bus,
-		 * and no PHY number was provided to the MAC,
-		 * use the one probed here.
-		 */
-		if (priv->plat->phy_addr == -1)
-			priv->plat->phy_addr = addr;
-
-		phy_attached_info(phydev);
-		found = 1;
-	}
-
-	if (!found && !mdio_node) {
+	phydev = phy_find_first(new_bus);
+	if (!phydev || phydev->mdio.addr > max_addr) {
 		dev_warn(dev, "No PHY found\n");
 		err = -ENODEV;
 		goto no_phy_found;
 	}
 
+	/*
+	 * If an IRQ was provided to be assigned after
+	 * the bus probe, do it here.
+	 */
+	if (!mdio_bus_data->irqs && mdio_bus_data->probed_phy_irq > 0) {
+		new_bus->irq[phydev->mdio.addr] = mdio_bus_data->probed_phy_irq;
+		phydev->irq = mdio_bus_data->probed_phy_irq;
+	}
+
+	/*
+	 * If we're going to bind the MAC to this PHY bus, and no PHY number
+	 * was provided to the MAC, use the one probed here.
+	 */
+	if (priv->plat->phy_addr == -1)
+		priv->plat->phy_addr = phydev->mdio.addr;
+
+	phy_attached_info(phydev);
+
 bus_register_done:
 	priv->mii = new_bus;
 
-- 
2.51.1.dirty



