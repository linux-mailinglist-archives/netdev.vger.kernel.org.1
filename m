Return-Path: <netdev+bounces-108241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C885891E791
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFC81C21AF5
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8005C172BA8;
	Mon,  1 Jul 2024 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL+Sm+WA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8E171E7C;
	Mon,  1 Jul 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858580; cv=none; b=n8kKYlE7mccT1/JQ1mqPVs2T2HfrK+PWH4exHI9X4D2EMMEq2F8sVwIKZ1fqFOQvi9nB1Ad+2xjf8DOq+P5o8D0ZwdHJRGYmddV/Wb3kYXw77YphfwaswUIvsP5JgQwxGlT85GkzYJLMLudo/t+79ahotNWdBXu0Wrkzr3gQB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858580; c=relaxed/simple;
	bh=IP/5AJ+Vufn+/ZKWx1tKfG43F+wE2LV255krT/dD65g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMHna4nUUkaNqS+bRVQeHEOD6LdGIHBZEkFX1z64/ehBuOHTPOoTJfS6GAewXlYBzAO8nyr+eK9/W/dMD6ceFPBkq9Hplu8oxyMf68lqT1Vkt0rPhGz+s9hdK0oKSwCfYDRbf3dAwHBHL1KpoGqOqPP7pw62HGgQCPyMGcOckVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL+Sm+WA; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e8037f8a5so2963346e87.1;
        Mon, 01 Jul 2024 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719858577; x=1720463377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hm2aYC8yWwZ1MpEgLfzSQGrNN+4dM8SxGRjO92ATLvs=;
        b=lL+Sm+WAmkVPnF75u866f9NhhN+F7GZWiw2VvrydMsdQysLx6gLor5XQ/br28L6zRY
         pSXM4J2Zf8C3eodccFIR3n0fyATbZ39zTce1rDgIo1Ze0wtQanLc4Ocrm3JcesZuz+Ac
         s1owoohkZq8RGyUI7WTHAxUfDB3B0iaALAfmI/kgj2L0SKkAqsBW0ExA3kSw9LNLB58L
         rVoTsU3+S6T9sv/46KDro+XAgdW26I39VAOu3wuM/DwHsh+LecJhFANRcum03yBrQ1gc
         4BjFqyGaVPGUSJ2oLKZ27IT+47amT3g+byOei07OPS6TaZO0GEYwzyi5P0WMBRU1qU7+
         9lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858577; x=1720463377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hm2aYC8yWwZ1MpEgLfzSQGrNN+4dM8SxGRjO92ATLvs=;
        b=WzHbDAZTVrab/N8xhJcXW7NyLeW+xJGed/zZpOywBG1QRQexTeV0pF1Sjkqpoco08c
         GvegvNeVNfq8fq3XZbeZRC+IK1WKO1GSxRu0aOqlHa9UBVc/xw3+eCl4Uspt2PI4sAhc
         U+rQvGFy+XTkAtxC8OwqvLaFAnh+3bdV3QHY93bfGQbhDbkoFLi6xC/fgRGL4V7z3fmF
         u+0Kc1KPzk8wgyXr6GB6xZmm7aoMSGXUmMXnlktx6eOkk5KwbFZbf5ExfZ/PLyg+io+W
         /G7yUlgZo3oD+z686uI9w2THcBwjgyuVmBAnmI7FIpylBhJhaEjkzluqHmNY7RdhC2jk
         w8LA==
X-Forwarded-Encrypted: i=1; AJvYcCVb+LbVP9pJQpS0hSmW9P4fsG+qcowfqaxF81OQqvJ7VJ0SCHfsuh5s4vc37Z6J99+gn1KVnICfdBfU2gO4Nf+pHbXfL0NATqgokbBIwukwbXN2JzRB2yiA26xzdaLrM4pc+uuGvCrnMwGNDk31XVEzJurPKwi6ldTtudVratlBUA==
X-Gm-Message-State: AOJu0YxNAReqWgHz0456fviYS3ADMGd9p0OyEiujF06Q9twOFnL8xbC4
	sxwq4qw5F7awBVzq83VSGzWJqG/rtNppx/pOnz2ETLWKgrqBYIfF
X-Google-Smtp-Source: AGHT+IEt5gIUeS1X520wxU/94QsvXwHNTg2JU+U1rzcs6/smAEiwqIqEcxkoEO/CYSKcAoR1W4rKbQ==
X-Received: by 2002:a05:6512:ad4:b0:52c:5254:b625 with SMTP id 2adb3069b0e04-52e8270a66dmr5353997e87.52.1719858576708;
        Mon, 01 Jul 2024 11:29:36 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2ea09sm1514069e87.193.2024.07.01.11.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:29:36 -0700 (PDT)
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
Subject: [PATCH net-next v4 08/10] net: pcs: xpcs: Add fwnode-based descriptor creation method
Date: Mon,  1 Jul 2024 21:28:39 +0300
Message-ID: <20240701182900.13402-9-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701182900.13402-1-fancer.lancer@gmail.com>
References: <20240701182900.13402-1-fancer.lancer@gmail.com>
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
index f4425a7c74d5..82463f9d50c8 100644
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


