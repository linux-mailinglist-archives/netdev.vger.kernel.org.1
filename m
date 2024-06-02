Return-Path: <netdev+bounces-99995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB118D765A
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300E41F21F4B
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D2E7602B;
	Sun,  2 Jun 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km1mhUbK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28946757E8;
	Sun,  2 Jun 2024 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717339022; cv=none; b=ls4BpU8iW2bKSr5qXVX6PiW1m/jI9MXUJQwjBXjLM3Dr28lVbshI4alCrQr/bpGLOeBj/a5xcmeLbIesY6vv1RfKm/eUsv6teBZJcfvJwmHGSOIgNZV8zew+ZVNIsHmzpVuOb7C3JUdj2o44ZnIKwnVkoFx7Y955gKFnSb1HBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717339022; c=relaxed/simple;
	bh=b+hmzCrEDZFrYbYiNIshirXH/vP+OZ7MY1T5RLbh4Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A33+6ZeSRxypK6ucxCMdzxSH5t9Rca9z9QVBnU9XJLEi/XoRJPXnhWA2W6A3ZvAGzn1nGXe5py2Sgd5yWbt4b7+f4zyOHv/IVvWGFt7PFzt9tpgiHBHOXOGoH9Q5lbOTvXqwSGphJq17AR7UhTSUEC1L3JtECMgiBi1RrRlJkzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km1mhUbK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e724bc466fso40218871fa.3;
        Sun, 02 Jun 2024 07:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717339019; x=1717943819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4aGTiAPBTBiXTU5Af6ILBXeRCSgwACWrEB026RZEFk=;
        b=Km1mhUbKhjO0LAFzWr+nc/LLg+vARc0TdxAwPtu17kR+X/sdgCY39bjK8xNaQYpQJp
         SL2pHK2vHbgIJXmgCZ6c8kR6RkYzl60LnjI3W1cgME+4nwYD7N9TVaPTJ2/kVdc4dz6S
         zPIoZa4QIwLyX+Vtagw1bllogRLQM2O30o52Mit8FIkSFr22wLczBKurkmQLZw5mjGa/
         W2mwW6j0ekD5s9xBz57npXSxTvX2vuX8txLCL14fP14FtIM5NX2vSAMnuQUuinCFQ8FB
         QD7xysoc/LjCw9SlzHpDPjYheGyv+tWtNTWeYlaWiqYspzWQ930iu45pvrqC+yuv6TIn
         c02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717339019; x=1717943819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4aGTiAPBTBiXTU5Af6ILBXeRCSgwACWrEB026RZEFk=;
        b=EVK1ZuCUAbs++F6SNWx7GgCiSd6m1a6MVay9XKhktAXvcaWAVDIADwH+zNACa1TNPu
         xBu/AlAjA0dRpesaq8k4tkW1aqQXmgrVn6eMoM0j+pSIdmLgH341Hc1GifKH8JbQR0FA
         5eElqg/tJMxA3zh24c2evFpKwB9Eh9rgM6VN6X9nC0ZcfPHL1qsVLFj817QTr7V/8kc6
         pnzZzRR2xuDiY9C3C80b1gzIDw1Pm1nt/ZH6El60eSkw3M3mfYh2lsbMaiEP38Wa4qmi
         /aVIGJi7f1GxdtKZR1OFM7DrqPRTY7hU2Gi+sfslLLi1VF6IK+Z86U4tMQ32H4I9YJpV
         u6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0lNX6tOODgPqqBrrisL9110SnXkCAyvBnzzljEy1dIUl2emVNgQb6pfq/V8IK8/BcxpualzmqEaS+h4gy86m0FQW1Af5vwaCSSi91aNkHA6tUkf1uj3/P2swYezAOsv+9m+aRGy04a5htPMqhMnV8kb2eOCj69d318pbzMN9Xg==
X-Gm-Message-State: AOJu0Yx1551qQ9XS7kXyw4RLeUENi7UAjY7wV9UiltzInB2HOQxEXU2P
	rLtLHu3PaIbavx4w/gO+G5YCN+bzZgXc8MwX82EIF40gzQ81VEPz
X-Google-Smtp-Source: AGHT+IF+oobCAxds4AhiGxi+LGxB+KYDlBE57HkX5WVkoQfOlVO4ykFSLc4rqzw0TKa2a6kiImbqSA==
X-Received: by 2002:ac2:4354:0:b0:52b:404:914f with SMTP id 2adb3069b0e04-52b8958aed8mr4401137e87.34.1717339019150;
        Sun, 02 Jun 2024 07:36:59 -0700 (PDT)
Received: from localhost ([178.178.142.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b93500e57sm420576e87.46.2024.06.02.07.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 07:36:58 -0700 (PDT)
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
Subject: [PATCH net-next v2 08/10] net: pcs: xpcs: Add fwnode-based descriptor creation method
Date: Sun,  2 Jun 2024 17:36:22 +0300
Message-ID: <20240602143636.5839-9-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240602143636.5839-1-fancer.lancer@gmail.com>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
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
---
 drivers/net/pcs/pcs-xpcs.c   | 50 ++++++++++++++++++++++++++++++++++++
 include/linux/pcs/pcs-xpcs.h |  3 +++
 2 files changed, 53 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 8f7e3af64fcc..d45fa6514884 100644
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
+ * @requested PHY interface
+ *
+ * If successful, returns a pointer to the DW XPCS handle. Otherwise returns
+ * -ENODEV if device couldn't be found on the bus, other negative errno related
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
+ * @node: fwnode handle poining to the DW XPCS device
+ * @interface: requested PHY interface
+ *
+ * If successful, returns a pointer to the DW XPCS handle. Otherwise returns
+ * -ENODEV if the fwnode is marked unavailable or device couldn't be found on
+ * the bus, -EPROBE_DEFER if the respective MDIO-device instance couldn't be
+ * found, other negative errno related to the data allocations and MDIO-bus
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


