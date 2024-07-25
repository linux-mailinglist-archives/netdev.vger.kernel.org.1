Return-Path: <netdev+bounces-112994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DA393C24A
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14BC1F21846
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4387C44C97;
	Thu, 25 Jul 2024 12:45:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB631219EB;
	Thu, 25 Jul 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911522; cv=none; b=lO8Zxi+xnDa6TuBQw8wMo3LnkmJVsu1rZoAtihDF6YoeNBLMSO5FTKBuomO+ONqBmCvecKfVTDNaB9JeoFuEowAQgxiXTFOiKLFb6tAg1Uucgm1CY/oFp1E8a2kXO9RdM/myr2QM8SB6VQNcJL8SOlaVaG59/zTiLpNumd0tU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911522; c=relaxed/simple;
	bh=Kno7oXfRynZA04n185N0SSwq7t3bgmw59672KoymYrc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q6IODlmL0O7s0YIQqAxScTqjO3ExBAFDzgRWxRw2JW3jnlf2t6bwIPd5JLXhJ7IG/s08KsVgFcvkSsOHTkGFTas4OTU0H06a6d1j9oXQd6rCJWsmXg3aRCx6wjxcTMBAPU19i9AilSFYVYLRb4BTKc13997zYxBxFS/1Xyc9+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sWxq9-000000002Yy-3gXn;
	Thu, 25 Jul 2024 12:45:02 +0000
Date: Thu, 25 Jul 2024 13:44:49 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Sam Shih <Sam.Shih@mediatek.com>,
	Weijie Gao <Weijie.Gao@mediatek.com>,
	Steven Liu <steven.liu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH RFC net-next] net: pcs: add helper module for standalone
 drivers
Message-ID: <ba4e359584a6b3bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Implement helper module for standalone PCS drivers which allows
standaline PCS drivers to register and users to get instances of
'struct phylink_pcs' using device tree nodes.

At this point only a single instance for each device tree node is
supported, once we got devices providing more than one PCS we can
extend it and introduce an xlate function as well as '#pcs-cells',
similar to how this is done by the PHY framework.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
This is meant to provide the infrastructure suggested by
Russell King in an earlier review. It just took me a long while to
find the time to implement this.
Users are going to be the standalone PCS drivers for 8/10 LynxI as
well as 64/66 USXGMII PCS found on MediaTek MT7988 SoC.
See also https://patchwork.kernel.org/comment/25636726/

The full tree where this is being used can be found at

https://github.com/dangowrt/linux/commits/mt7988-for-next/

 drivers/net/pcs/Kconfig            |  4 ++
 drivers/net/pcs/Makefile           |  1 +
 drivers/net/pcs/pcs-standalone.c   | 95 +++++++++++++++++++++++++++++
 include/linux/pcs/pcs-standalone.h | 25 ++++++++
 4 files changed, 129 insertions(+)
 create mode 100644 drivers/net/pcs/pcs-standalone.c
 create mode 100644 include/linux/pcs/pcs-standalone.h

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index f6aa437473de..2b02b9351fa4 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -5,6 +5,10 @@
 
 menu "PCS device drivers"
 
+config PCS_STANDALONE
+	tristate
+	select PHYLINK
+
 config PCS_XPCS
 	tristate "Synopsys DesignWare Ethernet XPCS"
 	select PHYLINK
diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
index 4f7920618b90..0cb0057f2b8e 100644
--- a/drivers/net/pcs/Makefile
+++ b/drivers/net/pcs/Makefile
@@ -4,6 +4,7 @@
 pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-plat.o \
 				   pcs-xpcs-nxp.o pcs-xpcs-wx.o
 
+obj-$(CONFIG_PCS_STANDALONE)	+= pcs-standalone.o
 obj-$(CONFIG_PCS_XPCS)		+= pcs_xpcs.o
 obj-$(CONFIG_PCS_LYNX)		+= pcs-lynx.o
 obj-$(CONFIG_PCS_MTK_LYNXI)	+= pcs-mtk-lynxi.o
diff --git a/drivers/net/pcs/pcs-standalone.c b/drivers/net/pcs/pcs-standalone.c
new file mode 100644
index 000000000000..1569793328a1
--- /dev/null
+++ b/drivers/net/pcs/pcs-standalone.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Helpers for standalone PCS drivers
+ *
+ * Copyright (C) 2024 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <linux/pcs/pcs-standalone.h>
+#include <linux/phylink.h>
+
+static LIST_HEAD(pcs_list);
+static DEFINE_MUTEX(pcs_mutex);
+
+struct pcs_standalone {
+	struct device *dev;
+	struct phylink_pcs *pcs;
+	struct list_head list;
+};
+
+static void devm_pcs_provider_release(struct device *dev, void *res)
+{
+	struct pcs_standalone *pcssa = (struct pcs_standalone *)res;
+
+	mutex_lock(&pcs_mutex);
+	list_del(&pcssa->list);
+	mutex_unlock(&pcs_mutex);
+}
+
+int devm_pcs_register(struct device *dev, struct phylink_pcs *pcs)
+{
+	struct pcs_standalone *pcssa;
+
+	pcssa = devres_alloc(devm_pcs_provider_release, sizeof(*pcssa),
+			     GFP_KERNEL);
+	if (!pcssa)
+		return -ENOMEM;
+
+	devres_add(dev, pcssa);
+	pcssa->pcs = pcs;
+	pcssa->dev = dev;
+
+	mutex_lock(&pcs_mutex);
+	list_add_tail(&pcssa->list, &pcs_list);
+	mutex_unlock(&pcs_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_pcs_register);
+
+static struct pcs_standalone *of_pcs_locate(const struct device_node *_np, u32 index)
+{
+	struct device_node *np;
+	struct pcs_standalone *iter, *pcssa = NULL;
+
+	if (!_np)
+		return NULL;
+
+	np = of_parse_phandle(_np, "pcs-handle", index);
+	if (!np)
+		return NULL;
+
+	mutex_lock(&pcs_mutex);
+	list_for_each_entry(iter, &pcs_list, list) {
+		if (iter->dev->of_node != np)
+			continue;
+
+		pcssa = iter;
+		break;
+	}
+	mutex_unlock(&pcs_mutex);
+
+	of_node_put(np);
+
+	return pcssa ?: ERR_PTR(-ENODEV);
+}
+
+struct phylink_pcs *devm_of_pcs_get(struct device *dev,
+				    const struct device_node *np,
+				    unsigned int index)
+{
+	struct pcs_standalone *pcssa;
+
+	pcssa = of_pcs_locate(np ?: dev->of_node, index);
+	if (IS_ERR_OR_NULL(pcssa))
+		return ERR_PTR(PTR_ERR(pcssa));
+
+	device_link_add(dev, pcssa->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+
+	return pcssa->pcs;
+}
+EXPORT_SYMBOL_GPL(devm_of_pcs_get);
+
+MODULE_DESCRIPTION("Helper for standalone PCS drivers");
+MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pcs/pcs-standalone.h b/include/linux/pcs/pcs-standalone.h
new file mode 100644
index 000000000000..ad7819f4a2eb
--- /dev/null
+++ b/include/linux/pcs/pcs-standalone.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_PCS_STANDALONE_H
+#define __LINUX_PCS_STANDALONE_H
+
+#include <linux/device.h>
+#include <linux/phylink.h>
+#include <linux/phy/phy.h>
+#include <linux/of.h>
+
+#if IS_ENABLED(CONFIG_PCS_STANDALONE)
+int devm_pcs_register(struct device *dev, struct phylink_pcs *pcs);
+struct phylink_pcs *devm_of_pcs_get(struct device *dev,
+				    const struct device_node *np, unsigned int index);
+#else
+static inline int devm_pcs_register(struct device *dev, struct phylink_pcs *pcs);
+	return -EOPNOTSUPP;
+}
+static inline struct phylink_pcs *devm_of_pcs_get(struct device *dev,
+						  const struct device_node *np,
+						  unsigned int index)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif /* CONFIG_PCS_STANDALONE */
+#endif /* __LINUX_PCS_STANDALONE_H */
-- 
2.45.2


