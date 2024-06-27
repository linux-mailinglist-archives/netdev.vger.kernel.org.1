Return-Path: <netdev+bounces-107095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5823C919BF6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58DB1F21ABA
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 00:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AB2249EB;
	Thu, 27 Jun 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9dd10ER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03B2139B5;
	Thu, 27 Jun 2024 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719448940; cv=none; b=XQXkPbR5qVK9VKJ4Z0EbhNAO0HH8rSB0RhYV4atRSrdZqZYBUCQxEkbgGORj0xN8FFCG+rDzZ+BhARPxvwUuRvk3nufs5jn5CGotsqEWTkVp01RQH9W3K1/KgRRx52Tar4SW/RteODg6hulHATZ6qtWrXELHwqE17CQ3jUEdKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719448940; c=relaxed/simple;
	bh=M0U/WpQ9anDx+P6LnmY92tN825PYOEhUfi6QJstY/pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOJaWUdj9/1Pydm6fSdjswuYYjl8oUGMpOV5y7fuKxGE1djFE3bj8JOVe9hpaqZ5hDWZ02Ld8RiQqHcsstxvohk6qDGWNsKm0axs3En3u/7LjvzDgGPARO39tUUyVh52W9sfDzVOKrF2LeF0RGvkWQqS2GLajYwDJXtlddUGb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9dd10ER; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e72224c395so84817471fa.3;
        Wed, 26 Jun 2024 17:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719448936; x=1720053736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meRcVrx/K8/sJerdBBTH157b52QfYejAtE/mSM/skqM=;
        b=Q9dd10ER29JAI+XqkDZao/2sXrqP317jrNKZCOI+8R59mLf6zLCPpirIpnN6IP1Vqm
         kktJXyV9Ed++XU5ydqF62nzsc+9oBXbMlZgUxd6z1Q3vXazl7xWRfnuovQMfRCMqGIG7
         dK+l2oRUb3faHr4bKDlE/COAyVGyHyRjnGNc9AVnPnc3pKJiybaCWSrbYzrPGW9H4dfX
         gU9edz/CzxBHmDgqpyU67AtQDHX88ofaeby+UOX/Xm7vA8biDYtS8bWoIV2P+2KBLT+T
         u/Tf8TDhHMTgfUIobRzdmUYq/h3EJf0nViMGDEDRVAOLZCluY0WuCUebkNII63yvxy3m
         Pu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719448936; x=1720053736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meRcVrx/K8/sJerdBBTH157b52QfYejAtE/mSM/skqM=;
        b=Jjd7t+r5bagFqGuOLwjIytVqyXr4w10hqvgqln8GzrMWCtKyv9jmdjzYbs2s9UmBvz
         Y7zGB7XQyrcK0Zvf+LakTt3T9ietHCnz4VM142g2b6sewd4l+plsWGLIU+DLLgGnadTm
         tPXr6WWn6LFmHobOXerwIVDnaDgcNgY0Bt75H93wFEg8a1bLvrpTDu5orueM1z7v2H7k
         whcEKlJ8js2TxkckwStwST/qzBW7+XiDHk+/4PSRHqHHf1/+yjDcfZ9b5n0mQ+VOjqPo
         cyqz8ufz5jHDglC7nohK/Q2pAHCmBpaaOdthT9TPhBjthEkAznE3yIADVFOGUnfeXBpk
         THNw==
X-Forwarded-Encrypted: i=1; AJvYcCXRVpXyK17APG6RMf6VVFAcjtaoTgbDUdE86GKj8Av3+nYH0lbjyiPVjhtEykeEKK0akoZbgaWm/birIQNJgdjJikwj7GEM1u7usXTTrojlHyb+jD3OyekULdcZAFwaVwO8Y1LlbtHvUrguj4GurSeqKQMaHbJQSwtj/LL+3gf5Yg==
X-Gm-Message-State: AOJu0Yz7kuRR1KNKpNJ6PLMWZylCBRu5SDPOjU3Le75uEGjmdZWYUbvc
	MXUDW5KSvTWStA/LWiQAKp2PzTYz+T27lbsTUddU4/Rw9G/U2sXv
X-Google-Smtp-Source: AGHT+IGn7wSsgabnJX4LHqU2k9E0zw7bvYkA0kaErRgC3cSC1Sz3JRD4SdluOe4K7TmTCVGfdo85Yw==
X-Received: by 2002:a05:651c:154e:b0:2ee:4ab4:f752 with SMTP id 38308e7fff4ca-2ee4ab4f7damr990181fa.49.1719448936422;
        Wed, 26 Jun 2024 17:42:16 -0700 (PDT)
Received: from localhost ([89.113.147.248])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a34f68csm491251fa.29.2024.06.26.17.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 17:42:15 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 08/10] net: pcs: xpcs: Add fwnode-based descriptor creation method
Date: Thu, 27 Jun 2024 03:41:28 +0300
Message-ID: <20240627004142.8106-9-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627004142.8106-1-fancer.lancer@gmail.com>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's now possible to have the DW XPCS device defined as a standard
platform device for instance in the platform DT-file. Although that
functionality is useless unless there is a way to have the device found by
the client drivers (STMMAC/DW *MAC, NXP SJA1105 Eth Switch, etc). Provide
such ability by means of the xpcs_create_fwnode() method. It needs to be
called with the device DW XPCS fwnode instance passed. That node will be
then used to find the MDIO-device instance in order to create the DW XPCS
descriptor.

Note the method semantics and name is similar to what has been recently
introduced in the Lynx PCS driver.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Use the function name and semantics similar to the Lynx PCS driver.
- Add kdoc describing the DW XPCS create functions.

Changelog v3:
- Add the "@interface" argument kdoc to the xpcs_create_mdiodev()
  function. (@Simon)
- Fix the "@fwnode" argument name in the xpcs_create_fwnode() method kdoc.
  (@Simon)
- Move the return value descriptions to the "Return:" section of the
  xpcs_create_mdiodev() and xpcs_create_fwnode() kdoc. (@Simon)
---
 drivers/net/pcs/pcs-xpcs.c   | 50 ++++++++++++++++++++++++++++++++++++
 include/linux/pcs/pcs-xpcs.h |  3 +++
 2 files changed, 53 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 8f7e3af64fcc..94f2f95ef425 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -10,7 +10,9 @@
 #include <linux/delay.h>
 #include <linux/pcs/pcs-xpcs.h>
 #include <linux/mdio.h>
+#include <linux/phy.h>
 #include <linux/phylink.h>
+#include <linux/property.h>
 
 #include "pcs-xpcs.h"
 
@@ -1505,6 +1507,16 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 	return ERR_PTR(ret);
 }
 
+/**
+ * xpcs_create_mdiodev() - create a DW xPCS instance with the MDIO @addr
+ * @bus: pointer to the MDIO-bus descriptor for the device to be looked at
+ * @addr: device MDIO-bus ID
+ * @interface: requested PHY interface
+ *
+ * Return: a pointer to the DW XPCS handle if successful, otherwise -ENODEV if
+ * the PCS device couldn't be found on the bus and other negative errno related
+ * to the data allocation and MDIO-bus communications.
+ */
 struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 				    phy_interface_t interface)
 {
@@ -1529,6 +1541,44 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 }
 EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
 
+/**
+ * xpcs_create_fwnode() - Create a DW xPCS instance from @fwnode
+ * @fwnode: fwnode handle poining to the DW XPCS device
+ * @interface: requested PHY interface
+ *
+ * Return: a pointer to the DW XPCS handle if successful, otherwise -ENODEV if
+ * the fwnode device is unavailable or the PCS device couldn't be found on the
+ * bus, -EPROBE_DEFER if the respective MDIO-device instance couldn't be found,
+ * other negative errno related to the data allocations and MDIO-bus
+ * communications.
+ */
+struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode,
+				   phy_interface_t interface)
+{
+	struct mdio_device *mdiodev;
+	struct dw_xpcs *xpcs;
+
+	if (!fwnode_device_is_available(fwnode))
+		return ERR_PTR(-ENODEV);
+
+	mdiodev = fwnode_mdio_find_device(fwnode);
+	if (!mdiodev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	xpcs = xpcs_create(mdiodev, interface);
+
+	/* xpcs_create() has taken a refcount on the mdiodev if it was
+	 * successful. If xpcs_create() fails, this will free the mdio
+	 * device here. In any case, we don't need to hold our reference
+	 * anymore, and putting it here will allow mdio_device_put() in
+	 * xpcs_destroy() to automatically free the mdio device.
+	 */
+	mdio_device_put(mdiodev);
+
+	return xpcs;
+}
+EXPORT_SYMBOL_GPL(xpcs_create_fwnode);
+
 void xpcs_destroy(struct dw_xpcs *xpcs)
 {
 	if (!xpcs)
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 813be644647f..b4a4eb6c8866 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -8,6 +8,7 @@
 #define __LINUX_PCS_XPCS_H
 
 #include <linux/clk.h>
+#include <linux/fwnode.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
@@ -72,6 +73,8 @@ int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
 		    int enable);
 struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 				    phy_interface_t interface);
+struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode,
+				   phy_interface_t interface);
 void xpcs_destroy(struct dw_xpcs *xpcs);
 
 #endif /* __LINUX_PCS_XPCS_H */
-- 
2.43.0


