Return-Path: <netdev+bounces-175955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4DAA680FF
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAD2189946C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A98213E78;
	Tue, 18 Mar 2025 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4SCSaaJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DCF20AF92;
	Tue, 18 Mar 2025 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342375; cv=none; b=IZ5q4CwsiIqKn7x0s524Xk4YVG4meCLmzgoO2JfNMPTm+UNV/T82HX4wvxahqZgmopfovXaTOELikYpQ+lP0EDwXShxL94UlCjmZOiCmCiBOS/0RDiyM9ckA6Xv+qyregHzyB6JsuEV8Wekt1q3woS+gQfaSsY2q0HoSDBDvdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342375; c=relaxed/simple;
	bh=uGv9kKkksTyRK/VdBvtNjHQwtAZv5aeTEsFHP2RhExs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gj4rkmJTV2yYHgoetOZE1LSk33DUNzNP7quc15OsLlHPRt4+jPSSx60MuuvvCvMzAckbC7oupmwj7RVUSEzeO9CAzG6y3kRMWUodcG/tlceGe8Xws+NszJnns65/HMiNDvlmMUQCyeYcPcgu7C2qE4AQ9oJXyqqlbcgrEsNGxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4SCSaaJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39133f709f5so3866567f8f.0;
        Tue, 18 Mar 2025 16:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742342370; x=1742947170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmJzo91J/S06r3dhO0o9t/r3EqA/+DpXvZ8HsyWjWoc=;
        b=Q4SCSaaJjlCzX6gjvDHdD2hG8zcE0VRVQuwznHWfD83rHvA4EVUdLqf/g492HxfC5w
         qoxvEkG9OddsjQFlv6pWaAdem336agE+mL6sOheRCT6VFDMicfpVAD2bflGCrhw6ki1s
         RG7+gJJIdiqsaY9RbyzIoKOkPkT4m79xjWvu4aOLxoNaJXSt+cDdaNEh2mddsdpoNWI7
         iBTzA+gGbbP2ZVdVQGH4qzUT50LVxWPPAK/W7l5vTfOPhD1K7XDXfohMU5vv+cRAiVM4
         Z1aQuR9HmBQA/LxbF72RD+/2e3zBhtsE51/KtblatmtCMvUxu99aQUJMcJwAG3FTucco
         etZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742342370; x=1742947170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmJzo91J/S06r3dhO0o9t/r3EqA/+DpXvZ8HsyWjWoc=;
        b=RDC3fK5qgBQvDfhySqAB/JcRmPWsBgozZhl+X/bm11yu5adE4OFug9J+FhC08IoPE+
         PXpHzpCxCwcv9B7dr7BnTUVtMcrZ2ZAbDYOz8tk7GWJbcqwa8noOHvu+HT1HsLco5FMK
         oIpslm5m99G8NcvcukrdSnA2FKRCKk4BPgTLnC/ld1JDUJn43qp9Kt2MZ4f/gxn/LXUp
         okwDUHMA27OjkOL9rzj91s12HB8nhebUw5A+DJW9o2k0jfBvpsLQYzV4JS7vLeQ0r6gl
         VSK3/N53oNa/87wEIWJip0fR49bwaNaU/RQxZS10Smp8o9FoQjcZg1gNbZ2l1DCvcGxo
         ycxA==
X-Forwarded-Encrypted: i=1; AJvYcCW4ouZWxNZ0vparx7xAMiCEdwwDIjxjUgF9FUC+kFKDqgkMMHKtYLsW9U6P14lxIV+LM2fdnMSBMGek@vger.kernel.org, AJvYcCWNNnZ78RAKmNk0MkOp0zZC3++mwKy5ha+A6xmF/sGDNU3gFw9DSHQ2D5FwL6yY8QII3lgYkxVvviRCXCYF@vger.kernel.org, AJvYcCXpTsB/7eWbWRxnAut4CIC+CGhtZg6gHCSITsaMkBg83snaC1w8fawn+20kNXjEEI/sATMt2yhF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ifgwvKGn+epGonUbTBRLaNf95L6tgCc/uVBV5FE8B9ritHVC
	sQz9ZerxTPq0S8d+1axwiDtSroO7V6DSrFuJxjIcjwBwbzBq/qMQ
X-Gm-Gg: ASbGnctHjTgDdLIlzATjNWOW6FpSXKZ3p8c1lL+/lkYeCvK6GxFAMV2kU4ycnO8uYuh
	6yL3u86S2TGpfcPhhCT9L+TxZxdPSXgqRQsjQyafWpSzECbJEnjNEF2w6a6WqzwTF/WYcs/1BQy
	4ha0wQnGsoyG/NQoyAgJ2LY30AM5MqBsvIuBKCik+ddisyBHYBWmBJYd5w0GaUxYL+u1+O0iaJY
	GlHUPWB0UcqMJaGGwRalLzeNSr7eYJOa6ZRI760iJmYGRLQcmG459LSLx2hXVOGGYyEDUGwsA+i
	a0MErVPJAEpUOt0AArh0ar7NDmKf/L/0hkQgDxehQtWtbi5FTdqBLR5BOsKe3hALR+JLiijQPAn
	0qNXxSEYy2yxWZA==
X-Google-Smtp-Source: AGHT+IHQUyw4iUyOZRyykS1zVBb5nhFrSi3ZazEJqzoWmYmOcyFWzt+novsud1diDKzY2f1JpPJyZg==
X-Received: by 2002:a5d:6489:0:b0:391:253b:4046 with SMTP id ffacd0b85a97d-399739c11d7mr619099f8f.16.1742342370328;
        Tue, 18 Mar 2025 16:59:30 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395c83b748bsm19713268f8f.39.2025.03.18.16.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:59:30 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH 2/6] net: pcs: Implement OF support for PCS driver
Date: Wed, 19 Mar 2025 00:58:38 +0100
Message-ID: <20250318235850.6411-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318235850.6411-1-ansuelsmth@gmail.com>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the foundation of OF support for PCS driver.

To support this, implement a simple Provider API where a PCS driver can
expose multiple PCS with an xlate .get function.

PCS driver will have to call of_pcs_add_provider() and pass the device
node pointer and a xlate function to return the correct PCS for the
requested interface and the passed #pcs-cells.

This will register the PCS in a global list of providers so that
consumer can access it.

Consumer will then use of_pcs_get() to get the actual PCS by passing the
device_node pointer, the index for #pcs-cells and the requested
interface.

For simple implementation where #pcs-cells is 0 and the PCS driver
expose a single PCS, the xlate function of_pcs_simple_get() is
provided. In such case the passed interface is ignored and is expected
that the PCS supports any interface mode supported by the MAC.

For advanced implementation a custom xlate function is required. Such
function should return an error if the PCS is not supported for the
requested interface type.

This is needed for the correct function of of_phylink_mac_select_pcs()
later described.

PCS driver on removal should first call phylink_pcs_release() on every
PCS the driver provides and then correctly delete as a provider with
the usage of of_pcs_del_provider().

A generic function for .mac_select_pcs is provided for any MAC driver
that will declare PCS in DT, of_phylink_mac_select_pcs().
This function will parse "pcs-handle" property and will try every PCS
declared in DT until one that supports the requested interface type is
found. This works by leveraging the return value of the xlate function
returned by of_pcs_get() and checking if it's an ERROR or NULL, in such
case the next PCS in the phandle array is tested.

Some additional helper are provided for xlate functions,
pcs_supports_interface() as a simple function to check if the requested
interface is supported by the PCS and phylink_pcs_release() to release a
PCS from a phylink instance.

Co-developed-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/pcs/Kconfig          |   7 ++
 drivers/net/pcs/Makefile         |   1 +
 drivers/net/pcs/pcs.c            | 185 +++++++++++++++++++++++++++++++
 drivers/net/phy/phylink.c        |  21 ++++
 include/linux/pcs/pcs-provider.h |  46 ++++++++
 include/linux/pcs/pcs.h          |  62 +++++++++++
 include/linux/phylink.h          |   2 +
 7 files changed, 324 insertions(+)
 create mode 100644 drivers/net/pcs/pcs.c
 create mode 100644 include/linux/pcs/pcs-provider.h
 create mode 100644 include/linux/pcs/pcs.h

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index f6aa437473de..8c3b720de6fd 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -5,6 +5,13 @@
 
 menu "PCS device drivers"
 
+config OF_PCS
+	tristate
+	depends on OF
+	depends on PHYLINK
+	help
+		OpenFirmware PCS accessors
+
 config PCS_XPCS
 	tristate "Synopsys DesignWare Ethernet XPCS"
 	select PHYLINK
diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
index 4f7920618b90..29881f0f981f 100644
--- a/drivers/net/pcs/Makefile
+++ b/drivers/net/pcs/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Linux PCS drivers
 
+obj-$(CONFIG_OF_PCS)		+= pcs.o
 pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-plat.o \
 				   pcs-xpcs-nxp.o pcs-xpcs-wx.o
 
diff --git a/drivers/net/pcs/pcs.c b/drivers/net/pcs/pcs.c
new file mode 100644
index 000000000000..af04a76ef825
--- /dev/null
+++ b/drivers/net/pcs/pcs.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/phylink.h>
+#include <linux/pcs/pcs.h>
+#include <linux/pcs/pcs-provider.h>
+
+struct of_pcs_provider {
+	struct list_head link;
+
+	struct device_node *node;
+	struct phylink_pcs *(*get)(struct of_phandle_args *pcsspec,
+				   void *data,
+				   phy_interface_t interface);
+
+	void *data;
+};
+
+static LIST_HEAD(of_pcs_providers);
+static DEFINE_MUTEX(of_pcs_mutex);
+
+struct phylink_pcs *of_pcs_simple_get(struct of_phandle_args *pcsspec, void *data,
+				      phy_interface_t interface)
+{
+	struct phylink_pcs *pcs = data;
+
+	if (!pcs_supports_interface(pcs, interface))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return data;
+}
+EXPORT_SYMBOL_GPL(of_pcs_simple_get);
+
+int of_pcs_add_provider(struct device_node *np,
+			struct phylink_pcs *(*get)(struct of_phandle_args *pcsspec,
+						   void *data,
+						   phy_interface_t interface),
+			void *data)
+{
+	struct of_pcs_provider *pp;
+
+	if (!np)
+		return 0;
+
+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
+
+	pp->node = of_node_get(np);
+	pp->data = data;
+	pp->get = get;
+
+	mutex_lock(&of_pcs_mutex);
+	list_add(&pp->link, &of_pcs_providers);
+	mutex_unlock(&of_pcs_mutex);
+	pr_debug("Added pcs provider from %pOF\n", np);
+
+	fwnode_dev_initialized(&np->fwnode, true);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_pcs_add_provider);
+
+void of_pcs_del_provider(struct device_node *np)
+{
+	struct of_pcs_provider *pp;
+
+	if (!np)
+		return;
+
+	mutex_lock(&of_pcs_mutex);
+	list_for_each_entry(pp, &of_pcs_providers, link) {
+		if (pp->node == np) {
+			list_del(&pp->link);
+			fwnode_dev_initialized(&np->fwnode, false);
+			of_node_put(pp->node);
+			kfree(pp);
+			break;
+		}
+	}
+	mutex_unlock(&of_pcs_mutex);
+}
+EXPORT_SYMBOL_GPL(of_pcs_del_provider);
+
+static int of_parse_pcsspec(const struct device_node *np, int index,
+			    const char *name, struct of_phandle_args *out_args)
+{
+	int ret = -ENOENT;
+
+	if (!np)
+		return -ENOENT;
+
+	if (name)
+		index = of_property_match_string(np, "pcs-names", name);
+
+	ret = of_parse_phandle_with_args(np, "pcs-handle", "#pcs-cells",
+					 index, out_args);
+	if (ret || (name && index < 0))
+		return ret;
+
+	return 0;
+}
+
+static struct phylink_pcs *
+of_pcs_get_from_pcsspec(struct of_phandle_args *pcsspec,
+			phy_interface_t interface)
+{
+	struct of_pcs_provider *provider;
+	struct phylink_pcs *pcs = ERR_PTR(-EPROBE_DEFER);
+
+	if (!pcsspec)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&of_pcs_mutex);
+	list_for_each_entry(provider, &of_pcs_providers, link) {
+		if (provider->node == pcsspec->np) {
+			pcs = provider->get(pcsspec, provider->data,
+					    interface);
+			if (!IS_ERR(pcs))
+				break;
+		}
+	}
+	mutex_unlock(&of_pcs_mutex);
+
+	return pcs;
+}
+
+static struct phylink_pcs *__of_pcs_get(struct device_node *np, int index,
+					const char *con_id,
+					phy_interface_t interface)
+{
+	struct of_phandle_args pcsspec;
+	struct phylink_pcs *pcs;
+	int ret;
+
+	ret = of_parse_pcsspec(np, index, con_id, &pcsspec);
+	if (ret)
+		return ERR_PTR(ret);
+
+	pcs = of_pcs_get_from_pcsspec(&pcsspec, interface);
+	of_node_put(pcsspec.np);
+
+	return pcs;
+}
+
+struct phylink_pcs *of_pcs_get(struct device_node *np, int index,
+			       phy_interface_t interface)
+{
+	return __of_pcs_get(np, index, NULL, interface);
+}
+EXPORT_SYMBOL_GPL(of_pcs_get);
+
+struct phylink_pcs *of_phylink_mac_select_pcs(struct phylink_config *config,
+					      phy_interface_t interface)
+{
+	int i, count;
+	struct device *dev = config->dev;
+	struct device_node *np = dev->of_node;
+	struct phylink_pcs *pcs = ERR_PTR(-ENODEV);
+
+	/* To enable using_mac_select_pcs on phylink_create */
+	if (interface == PHY_INTERFACE_MODE_NA)
+		return NULL;
+
+	/* Reject configuring PCS with Internal mode */
+	if (interface == PHY_INTERFACE_MODE_INTERNAL)
+		return ERR_PTR(-EINVAL);
+
+	if (!of_property_present(np, "pcs-handle"))
+		return pcs;
+
+	count = of_count_phandle_with_args(np, "pcs-handle", "#pcs-cells");
+	if (count < 0)
+		return ERR_PTR(count);
+
+	for (i = 0; i < count; i++) {
+		pcs = of_pcs_get(np, i, interface);
+		if (!IS_ERR_OR_NULL(pcs))
+			return pcs;
+	}
+
+	return pcs;
+}
+EXPORT_SYMBOL_GPL(of_phylink_mac_select_pcs);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index eef1712ec22c..7f71547e89fe 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1130,6 +1130,27 @@ int phylink_pcs_pre_init(struct phylink *pl, struct phylink_pcs *pcs)
 }
 EXPORT_SYMBOL_GPL(phylink_pcs_pre_init);
 
+/**
+ * phylink_pcs_release() - release a PCS
+ * @pl: a pointer to &struct phylink_pcs
+ *
+ * PCS provider can use this to release a PCS from a phylink
+ * instance by stopping the attached netdev. This is only done
+ * if the PCS is actually attached to a phylink, otherwise is
+ * ignored.
+ */
+void phylink_pcs_release(struct phylink_pcs *pcs)
+{
+	struct phylink *pl = pcs->phylink;
+
+	if (pl) {
+		rtnl_lock();
+		dev_close(pl->netdev);
+		rtnl_unlock();
+	}
+}
+EXPORT_SYMBOL_GPL(phylink_pcs_release);
+
 static void phylink_mac_config(struct phylink *pl,
 			       const struct phylink_link_state *state)
 {
diff --git a/include/linux/pcs/pcs-provider.h b/include/linux/pcs/pcs-provider.h
new file mode 100644
index 000000000000..0172d0286f07
--- /dev/null
+++ b/include/linux/pcs/pcs-provider.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __LINUX_PCS_PROVIDER_H
+#define __LINUX_PCS_PROVIDER_H
+
+#include <linux/phy.h>
+
+/**
+ * of_pcs_simple_get - Simple xlate function to retrieve PCS
+ * @pcsspec: Phandle arguments
+ * @data: Context data (assumed assigned to the single PCS)
+ * @interface: requested PHY interface type for PCS
+ *
+ * Returns the PCS (pointed by data) or an -EOPNOTSUPP pointer
+ * if the PCS doesn't support the requested interface.
+ */
+struct phylink_pcs *of_pcs_simple_get(struct of_phandle_args *pcsspec, void *data,
+				      phy_interface_t interface);
+
+/**
+ * of_pcs_add_provider - Registers a new PCS provider
+ * @np: Device node
+ * @get: xlate function to retrieve the PCS
+ * @data: Context data
+ *
+ * Register and add a new PCS to the global providers list
+ * for the device node. A function to get the PCS from
+ * device node with the use of phandle args.
+ * To the get function is also passed the interface type
+ * requested for the PHY. PCS driver will use the passed
+ * interface to understand if the PCS can support it or not.
+ *
+ * Returns 0 on success or -ENOMEM on allocation failure.
+ */
+int of_pcs_add_provider(struct device_node *np,
+			struct phylink_pcs *(*get)(struct of_phandle_args *pcsspec,
+						   void *data,
+						   phy_interface_t interface),
+			void *data);
+
+/**
+ * of_pcs_del_provider - Removes a PCS provider
+ * @np: Device node
+ */
+void of_pcs_del_provider(struct device_node *np);
+
+#endif /* __LINUX_PCS_PROVIDER_H */
diff --git a/include/linux/pcs/pcs.h b/include/linux/pcs/pcs.h
new file mode 100644
index 000000000000..b681bf05ac08
--- /dev/null
+++ b/include/linux/pcs/pcs.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __LINUX_PCS_H
+#define __LINUX_PCS_H
+
+#include <linux/phy.h>
+#include <linux/phylink.h>
+
+static inline bool pcs_supports_interface(struct phylink_pcs *pcs,
+					  phy_interface_t interface)
+{
+	return test_bit(interface, pcs->supported_interfaces);
+}
+
+#ifdef CONFIG_OF_PCS
+/**
+ * of_pcs_get - Retrieves a PCS from a device node
+ * @np: Device node
+ * @index: Index of PCS handle in Device Node
+ * @interface: requested PHY interface type for PCS
+ *
+ * Get a PCS for the requested PHY interface type from the
+ * device node at index.
+ *
+ * Returns a pointer to the phylink_pcs or a negative
+ * error pointer. Can return -EPROBE_DEFER if the PCS is not
+ * present in global providers list (either due to driver
+ * still needs to be probed or it failed to probe/removed)
+ */
+struct phylink_pcs *of_pcs_get(struct device_node *np, int index,
+			       phy_interface_t interface);
+
+/**
+ * of_phylink_mac_select_pcs - Generic MAC select pcs for OF PCS provider
+ * @config: phylink config pointer
+ * @interface: requested PHY interface type for PCS
+ *
+ * Generic helper function to get a PCS from a "pcs-handle" OF property
+ * defined in device tree. Each phandle defined in "pcs-handle" will be
+ * tested until a PCS that supports the requested PHY interface is found.
+ *
+ * Returns a pointer to the selected PCS or an error pointer.
+ * Return NULL for PHY_INTERFACE_MODE_NA and a -EINVAL error pointer
+ * for PHY_INTERFACE_MODE_INTERNAL. It can also return -EPROBE_DEFER,
+ * refer to of_pcs_get for details about it.
+ */
+struct phylink_pcs *of_phylink_mac_select_pcs(struct phylink_config *config,
+					      phy_interface_t interface);
+#else
+static inline struct phylink_pcs *of_pcs_get(struct device_node *np, int index,
+					     phy_interface_t interface)
+{
+	return PTR_ERR(-ENOENT);
+}
+
+static inline struct phylink_pcs *of_phylink_mac_select_pcs(struct phylink_config *config,
+							    phy_interface_t interface)
+{
+	return PTR_ERR(-EOPNOTSUPP);
+}
+#endif
+
+#endif /* __LINUX_PCS_H */
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index c187267a15b6..80367d4fbad9 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -695,6 +695,8 @@ void phylink_pcs_change(struct phylink_pcs *, bool up);
 
 int phylink_pcs_pre_init(struct phylink *pl, struct phylink_pcs *pcs);
 
+void phylink_pcs_release(struct phylink_pcs *pcs);
+
 void phylink_start(struct phylink *);
 void phylink_stop(struct phylink *);
 
-- 
2.48.1


