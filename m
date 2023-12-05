Return-Path: <netdev+bounces-53877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD61805074
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E0C1C20E75
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4137A4F216;
	Tue,  5 Dec 2023 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbS1n4X6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC91AB;
	Tue,  5 Dec 2023 02:36:26 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50c0478f970so640402e87.3;
        Tue, 05 Dec 2023 02:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772584; x=1702377384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hpm9CJMW8yeGqWkPdTKA3BPaZ3J6DVLqALQqXWpKSU=;
        b=dbS1n4X6wa9Gu0ZqNqO6wBhEBGe0fj/H4s3kdDEAP6hHpOx0tfbCuCvzVB/uggJgHE
         /3HMsP1ec02Zgu999WizLIZ3Cf0Gd+gpuO5GXgc3SzMsVQSy/LFj6NRC616hOID8OofO
         /sH01iy6AqDTZ6vKpyjyiF3U71YKNYSlz3rg90ArM940phtZPvtffjj1DWvarkAcusDx
         rYezKBCenQKktkGw8ZluEUV8GbMu/CPpjJuWvWozOsUjD/1+sKVNjY4PHpKGpbmeWEmH
         Btcf2ixDuWzYK8TnsMRj+hdZjO7xE0gA0dZk6Eci1+/Nzs9diST9nPL3JLdpUQTLhUFD
         nxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772584; x=1702377384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hpm9CJMW8yeGqWkPdTKA3BPaZ3J6DVLqALQqXWpKSU=;
        b=kuEeh4JjU/Qbx1R6YbmqPJRZ5KBegxywzBV5uRYbihuRtbNl7vkLw3IwdZUdsiXOxZ
         xidr6pJoFVh0zQNlCw3HOo06zH5x1cuXXLXTDHY97GHFfXX/3jCA9ROmdWEVV0K/Dp9x
         eaVQ1wr8Duan2mtmUt8Qn4/cxEsjGBL5OilHDRqWntDAK11YJ+WkzdTlXNMdyPYAXU6A
         q+MUEhpVE+/xX+P6aknIBAm3fXNooyHXet/5XjGMvtE6sF/E9FcGscGlczFdHekGCAhh
         b67jXXgOJA76VN43+Vu+GnpQzn5bWpb7feo/WLdLe/uQDLras9E3uwftaX51edsfMsQz
         mDaw==
X-Gm-Message-State: AOJu0Yw47xKD98HqZm/cHMt3gSsHzC9cZL8Q+FhDejlBJpPhK2d9KP02
	kMf+UabEg/f2dACa7MNwGsQ=
X-Google-Smtp-Source: AGHT+IHUCyh6fTgOz+IpheRuxzuTVvMVIazUtogkrsNd/ECy8uXTfUSwsV4TsLItWinwQ4JF0eHc9g==
X-Received: by 2002:a05:6512:3e16:b0:50b:f39d:5204 with SMTP id i22-20020a0565123e1600b0050bf39d5204mr2173050lfv.44.1701772584488;
        Tue, 05 Dec 2023 02:36:24 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d5-20020a0565123d0500b0050bfbc471b0sm442106lfv.18.2023.12.05.02.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:24 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 12/16] net: pcs: xpcs: Add xpcs_create_bynode() method
Date: Tue,  5 Dec 2023 13:35:33 +0300
Message-ID: <20231205103559.9605-13-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205103559.9605-1-fancer.lancer@gmail.com>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's now possible to have the DW XPCS device defined as a standard
platform device for instance in the platform DT-file. Although it's
pointless unless there is a way to have the device found by the client
drivers (STMMAC/DW *MAC, NXP SJA1105 Eth Switch, etc). Provide such
ability by means of the xpcs_create_bynode() method. It needs to be
supplied with the device fwnode which is equipped with the "pcs-handle"
property pointing to the DW XPCS fw-node (in this regards it looks similar
to the phylink interface). That node will be then used to find the
MDIO-device instance in order to create the DW XPCS descriptor.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c   | 26 ++++++++++++++++++++++++++
 include/linux/pcs/pcs-xpcs.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e376e255f1d3..c3336895a124 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -9,9 +9,11 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/fwnode.h>
 #include <linux/mdio.h>
 #include <linux/module.h>
 #include <linux/pcs/pcs-xpcs.h>
+#include <linux/phy.h>
 #include <linux/phylink.h>
 #include <linux/property.h>
 
@@ -1511,6 +1513,30 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 	return ERR_PTR(ret);
 }
 
+struct dw_xpcs *xpcs_create_bynode(const struct fwnode_handle *fwnode,
+				   phy_interface_t interface)
+{
+	struct fwnode_handle *pcs_node;
+	struct mdio_device *mdiodev;
+	struct dw_xpcs *xpcs;
+
+	pcs_node = fwnode_find_reference(fwnode, "pcs-handle", 0);
+	if (IS_ERR(pcs_node))
+		return ERR_CAST(pcs_node);
+
+	mdiodev = fwnode_mdio_find_device(pcs_node);
+	fwnode_handle_put(pcs_node);
+	if (!mdiodev)
+		return ERR_PTR(-ENODEV);
+
+	xpcs = xpcs_create(mdiodev, interface);
+	if (IS_ERR(xpcs))
+		mdio_device_put(mdiodev);
+
+	return xpcs;
+}
+EXPORT_SYMBOL_GPL(xpcs_create_bynode);
+
 struct dw_xpcs *xpcs_create_byaddr(struct mii_bus *bus, int addr,
 				   phy_interface_t interface)
 {
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index b11bbb5e820a..2981dcdf65d4 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -8,6 +8,7 @@
 #define __LINUX_PCS_XPCS_H
 
 #include <linux/clk.h>
+#include <linux/fwnode.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
@@ -73,6 +74,8 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces);
 int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
 		    int enable);
+struct dw_xpcs *xpcs_create_bynode(const struct fwnode_handle *fwnode,
+				   phy_interface_t interface);
 struct dw_xpcs *xpcs_create_byaddr(struct mii_bus *bus, int addr,
 				   phy_interface_t interface);
 void xpcs_destroy(struct dw_xpcs *xpcs);
-- 
2.42.1


