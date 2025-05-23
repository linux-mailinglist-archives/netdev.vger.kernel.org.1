Return-Path: <netdev+bounces-193155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5CCAC2AF4
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 22:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EBBA45BC4
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6C520DD4E;
	Fri, 23 May 2025 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EpnKM1kG"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B81F03FF
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748032478; cv=none; b=cA0nUA/TCimNhPSMPu/c1kaauDITJOSJnDioJuh89cQegGPNpmZNolpo3ntSpIyJbebLGqkzqAUySlpBXtcj7flF0a+bfTLy+t6IZA+M5zBfMPqCBjNX0VM/a5HdUHl+MDBSWJcD4ZRIOfhmcmiklMpJttFbynEEf+VROcZIeGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748032478; c=relaxed/simple;
	bh=SqYTrDvGIKtKV1jaqoXsL8oeVBq3vvm0eznr+7yISOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZnhdzHX0rH0VO/ajtYKDUoDMgwagU8HK2uOc08YIfHLU9/QaX7/4CCpWTr/+gpmzW+TUSLmDMGW1AUXNi3h74UyOFqhyovFoDrQt3nrZeAybndUVVM4cuOKvHEIBZh4IWNbdjgFy7yCSK8RXlnxJxMDut+1SQualK1lf0j4fY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EpnKM1kG; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748032473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkGvjNiTNu2tspXEqAyZfxG912QtKaDd0tfYAUC6KYg=;
	b=EpnKM1kG8cKyvbihuZFPLcObrCoo3GylFnSpTfOxM57LzXSf3nFzHkeaUeLIdzWd5A0Y5Q
	7UD48Ts+jl/RLkDAtt0d4l+CYp7jtO6E7KeQo/l1Go29b0Hf8KdmpP1KguWqK/lGecz4Ns
	+Uk1oEDrobdg/tiJlb9ZRqszyOvv7W4=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Lei Wei <quic_leiwei@quicinc.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [net-next PATCH v5 03/10] net: pcs: Add subsystem
Date: Fri, 23 May 2025 16:33:32 -0400
Message-Id: <20250523203339.1993685-4-sean.anderson@linux.dev>
In-Reply-To: <20250523203339.1993685-1-sean.anderson@linux.dev>
References: <20250523203339.1993685-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This adds support for getting PCS devices from the device tree. PCS
drivers must first register with phylink_register_pcs. After that, MAC
drivers may look up their PCS using phylink_get_pcs.

We wrap registered PCSs in another PCS. This wrapper PCS is refcounted
and can outlive the wrapped PCS (such as if the wrapped PCS's driver is
unbound). The wrapper forwards all PCS callbacks to the wrapped PCS,
first checking to make sure the wrapped PCS still exists. This design
was inspired by Bartosz Golaszewski's talk at LPC [1].

One downside of this approach is that if a PCS provider gets rebound,
the consumer must put the old PCS and re-get it. Typically this means
rebinding the consumer as well. I don't consider this a major downside:

- There is no guarantee that the PCS provider will support the same
  PHY interfaces as before. At the moment there is no way to handle this
  other than rebinding the consumer.
- Unbinding a PCS can generally happen in three ways:
  - The entire MAC and PCS is on a removable bus and everything is
    getting unbound because the whole thing is being removed. In this
    case we do not need to worry about the PCS coming back without the
    MAC having been unbound.
  - The PCS is on an FPGA that is being reconfigured but the MAC is not.
    This is a legitimate (if uncommon) use case. However, given that
    such arrangements were not possible at all before this series I
    think this is an acceptible limitation (at least initially).
  - The user has manually rebound the PCS (directly or indirectly)
    through sysfs. In this case I think it is fine to require them to
    manually rebind the MACs as well.

pcs_get_by_fwnode_compat is a bit hairy, but it's necessary for
compatibility with existing drivers, which often attach to (devicetree)
nodes directly. We use the devicetree changeset system instead of
adding a (secondary) software node because mdio_bus_match calls
of_driver_match_device to match devices, and that function only works on
devicetree nodes.

[1] https://lpc.events/event/17/contributions/1627/

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v4)

Changes in v4:
- Adjust variable ordering in pcs_find_fwnode
- Annotate pcs_wrapper.wrapped with __rcu
- Fix PCS lookup functions missing ERR_PTR casts
- Fix documentation for devm_pcs_register_full
- Fix incorrect condition in pcs_post_config
- Fix linking when PCS && !OF_DYNAMIC
- Fix linking when PCS && OF_DYNAMIC && PHYLIB=m
- Reduce line lengths to under 80 characters
- Remove unused dev parameter to pcs_put
- Use a spinlock instead of a mutex to protect pcs_wrappers

Changes in v3:
- Remove support for #pcs-cells. Upon further investigation, the
  requested functionality can be accomplished by specifying the PCS's
  fwnode manually.

Changes in v2:
- Add fallbacks for pcs_get* and pcs_put
- Add support for #pcs-cells
- Remove outdated comment
- Remove unused variable

 Documentation/networking/index.rst |   1 +
 Documentation/networking/kapi.rst  |   4 +
 Documentation/networking/pcs.rst   | 102 +++++
 MAINTAINERS                        |   2 +
 drivers/net/pcs/Kconfig            |  13 +
 drivers/net/pcs/Makefile           |   2 +
 drivers/net/pcs/core.c             | 686 +++++++++++++++++++++++++++++
 include/linux/pcs.h                | 205 +++++++++
 8 files changed, 1015 insertions(+)
 create mode 100644 Documentation/networking/pcs.rst
 create mode 100644 drivers/net/pcs/core.c
 create mode 100644 include/linux/pcs.h

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index ac90b82f3ce9..ff0e5968850b 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -30,6 +30,7 @@ Contents:
    page_pool
    phy
    sfp-phylink
+   pcs
    alias
    bridge
    snmp_counter
diff --git a/Documentation/networking/kapi.rst b/Documentation/networking/kapi.rst
index 98682b9a13ee..7a48178649de 100644
--- a/Documentation/networking/kapi.rst
+++ b/Documentation/networking/kapi.rst
@@ -146,6 +146,10 @@ PHYLINK
 
 .. kernel-doc:: include/linux/phylink.h
    :internal:
+   :no-identifiers: phylink_pcs phylink_pcs_ops pcs_validate pcs_inband_caps
+      pcs_enable pcs_disable pcs_pre_config pcs_post_config pcs_get_state
+      pcs_config pcs_an_restart pcs_link_up pcs_disable_eee pcs_enable_eee
+      pcs_pre_init
 
 .. kernel-doc:: drivers/net/phy/phylink.c
 
diff --git a/Documentation/networking/pcs.rst b/Documentation/networking/pcs.rst
new file mode 100644
index 000000000000..4b41ba884160
--- /dev/null
+++ b/Documentation/networking/pcs.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+PCS Subsystem
+=============
+
+The PCS (Physical Coding Sublayer) subsystem handles the registration and lookup
+of PCS devices. These devices contain the upper sublayers of the Ethernet
+physical layer, generally handling framing, scrambling, and encoding tasks. PCS
+devices may also include PMA (Physical Medium Attachment) components. PCS
+devices transfer data between the Link-layer MAC device, and the rest of the
+physical layer, typically via a serdes. The output of the serdes may be
+connected more-or-less directly to the medium when using fiber-optic or
+backplane connections (1000BASE-SX, 1000BASE-KX, etc). It may also communicate
+with a separate PHY (such as over SGMII) which handles the connection to the
+medium (such as 1000BASE-T).
+
+Looking up PCS Devices
+----------------------
+
+There are generally two ways to look up a PCS device. If the PCS device is
+internal to a larger device (such as a MAC or switch), and it does not share an
+implementation with an existing PCS, then it does not need to be registered with
+the PCS subsystem. Instead, you can populate a :c:type:`phylink_pcs`
+in your probe function. Otherwise, you must look up the PCS.
+
+If your device has a :c:type:`fwnode_handle`, you can add a PCS using the
+``pcs-handle`` property::
+
+    ethernet-controller {
+        // ...
+        pcs-handle = <&pcs>;
+        pcs-handle-names = "internal";
+    };
+
+Then, during your probe function, you can get the PCS using :c:func:`pcs_get`::
+
+    mac->pcs = pcs_get(dev, "internal");
+    if (IS_ERR(mac->pcs)) {
+        err = PTR_ERR(mac->pcs);
+        return dev_err_probe(dev, "Could not get PCS\n");
+    }
+
+If your device doesn't have a :c:type:`fwnode_handle`, you can get the PCS
+based on the providing device using :c:func:`pcs_get_by_dev`. Typically, you
+will create the device and bind your PCS driver to it before calling this
+function. This allows reuse of an existing PCS driver.
+
+Once you are done using the PCS, you must call :c:func:`pcs_put`.
+
+Using PCS Devices
+-----------------
+
+To select the PCS from a MAC driver, implement the ``mac_select_pcs`` callback
+of :c:type:`phylink_mac_ops`. In this example, the PCS is selected for SGMII
+and 1000BASE-X, and deselected for other interfaces::
+
+    static struct phylink_pcs *mac_select_pcs(struct phylink_config *config,
+                                              phy_interface_t iface)
+    {
+        struct mac *mac = config_to_mac(config);
+
+        switch (iface) {
+        case PHY_INTERFACE_MODE_SGMII:
+        case PHY_INTERFACE_MODE_1000BASEX:
+            return mac->pcs;
+        default:
+            return NULL;
+        }
+    }
+
+To do the same from a DSA driver, implement the ``phylink_mac_select_pcs``
+callback of :c:type:`dsa_switch_ops`.
+
+Writing PCS Drivers
+-------------------
+
+To write a PCS driver, first implement :c:type:`phylink_pcs_ops`. Then,
+register your PCS in your probe function using :c:func:`pcs_register`. If you
+need to provide multiple PCSs for the same device, then you can pass specific
+firmware nodes using :c:macro:`pcs_register_full`.
+
+You must call :c:func:`pcs_unregister` from your remove function. You can avoid
+this step by registering with :c:func:`devm_pcs_unregister`.
+
+API Reference
+-------------
+
+.. kernel-doc:: include/linux/phylink.h
+   :identifiers: phylink_pcs phylink_pcs_ops pcs_validate pcs_inband_caps
+      pcs_enable pcs_disable pcs_pre_config pcs_post_config pcs_get_state
+      pcs_config pcs_an_restart pcs_link_up pcs_disable_eee pcs_enable_eee
+      pcs_pre_init
+
+.. kernel-doc:: include/linux/pcs.h
+   :internal:
+
+.. kernel-doc:: drivers/net/pcs/core.c
+   :export:
+
+.. kernel-doc:: drivers/net/pcs/core.c
+   :internal:
diff --git a/MAINTAINERS b/MAINTAINERS
index 4e31726aa8d0..f098406db6ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8789,6 +8789,7 @@ F:	Documentation/ABI/testing/sysfs-class-net-phydev
 F:	Documentation/devicetree/bindings/net/ethernet-phy.yaml
 F:	Documentation/devicetree/bindings/net/mdio*
 F:	Documentation/devicetree/bindings/net/qca,ar803x.yaml
+F:	Documentation/networking/pcs.rst
 F:	Documentation/networking/phy.rst
 F:	drivers/net/mdio/
 F:	drivers/net/mdio/acpi_mdio.c
@@ -8802,6 +8803,7 @@ F:	include/linux/linkmode.h
 F:	include/linux/mdio/*.h
 F:	include/linux/mii.h
 F:	include/linux/of_net.h
+F:	include/linux/pcs.h
 F:	include/linux/phy.h
 F:	include/linux/phy_fixed.h
 F:	include/linux/phy_link_topology.h
diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index f6aa437473de..6d19625b696d 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -5,6 +5,19 @@
 
 menu "PCS device drivers"
 
+config PCS
+	bool "PCS subsystem"
+	select PHYLIB if OF_DYNAMIC
+	help
+	  This provides common helper functions for registering and looking up
+	  Physical Coding Sublayer (PCS) devices. PCS devices translate between
+	  different interface types. In some use cases, they may either
+	  translate between different types of Medium-Independent Interfaces
+	  (MIIs), such as translating GMII to SGMII. This allows using a fast
+	  serial interface to talk to the phy which translates the MII to the
+	  Medium-Dependent Interface. Alternatively, they may translate a MII
+	  directly to an MDI, such as translating GMII to 1000Base-X.
+
 config PCS_XPCS
 	tristate "Synopsys DesignWare Ethernet XPCS"
 	select PHYLINK
diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
index 4f7920618b90..35e3324fc26e 100644
--- a/drivers/net/pcs/Makefile
+++ b/drivers/net/pcs/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Linux PCS drivers
 
+obj-$(CONFIG_PCS)		+= core.o
+
 pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-plat.o \
 				   pcs-xpcs-nxp.o pcs-xpcs-wx.o
 
diff --git a/drivers/net/pcs/core.c b/drivers/net/pcs/core.c
new file mode 100644
index 000000000000..133df15483f0
--- /dev/null
+++ b/drivers/net/pcs/core.c
@@ -0,0 +1,686 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-25 Sean Anderson <sean.anderson@seco.com>
+ */
+
+#define pr_fmt(fmt) "pcs-core: " fmt
+
+#include <linux/fwnode.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/pcs.h>
+#include <linux/phylink.h>
+#include <linux/property.h>
+#include <linux/rcupdate.h>
+#include <linux/spinlock.h>
+
+static LIST_HEAD(pcs_wrappers);
+/* Protects PCS (un)registration i.e. pcs_wrappers */
+static DEFINE_SPINLOCK(pcs_lock);
+/* Protects pcs_wrapper.pcs from being unregistered while we are operating on
+ * it. One SRCU is shared by all PCSs, so drivers may wait on other drivers'
+ * PCSs. If this becomes a problem the SRCU can be made per-PCS.
+ */
+DEFINE_STATIC_SRCU(pcs_srcu);
+
+/**
+ * struct pcs_wrapper - Wrapper for a registered PCS
+ * @pcs: the wrapping PCS
+ * @refcnt: refcount for the wrapper
+ * @list: list head for pcs_wrappers
+ * @dev: the device associated with this PCS
+ * @fwnode: this PCS's firmware node; typically @dev.fwnode
+ * @wrapped: the backing PCS
+ */
+struct pcs_wrapper {
+	struct phylink_pcs pcs;
+	refcount_t refcnt;
+	struct list_head list;
+	struct device *dev;
+	struct fwnode_handle *fwnode;
+	struct phylink_pcs __rcu *wrapped;
+};
+
+static const struct phylink_pcs_ops pcs_ops;
+
+static struct pcs_wrapper *pcs_to_wrapper(struct phylink_pcs *pcs)
+{
+	WARN_ON(pcs->ops != &pcs_ops);
+	return container_of(pcs, struct pcs_wrapper, pcs);
+}
+
+static int pcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
+			const struct phylink_link_state *state)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int ret, idx;
+
+	if (!wrapper)
+		return 0;
+
+	idx = srcu_read_lock(&pcs_srcu);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
+	if (wrapped) {
+		if (wrapped->ops->pcs_validate)
+			ret = wrapped->ops->pcs_validate(wrapped, supported,
+							 state);
+		else
+			ret = 0;
+	} else {
+		ret = -ENODEV;
+	}
+
+	srcu_read_unlock(&pcs_srcu, idx);
+	return ret;
+}
+
+static unsigned int pcs_inband_caps(struct phylink_pcs *pcs,
+				    phy_interface_t interface)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int ret, idx;
+
+	idx = srcu_read_lock(&pcs_srcu);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
+	if (wrapped && wrapped->ops->pcs_inband_caps)
+		ret = wrapped->ops->pcs_inband_caps(wrapped, interface);
+	else
+		ret = 0;
+
+	srcu_read_unlock(&pcs_srcu, idx);
+	return ret;
+}
+
+static int pcs_enable(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int ret, idx;
+
+	if (!wrapper)
+		return 0;
+
+	idx = srcu_read_lock(&pcs_srcu);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
+	if (wrapped) {
+		if (wrapped->ops->pcs_enable)
+			ret = wrapped->ops->pcs_enable(wrapped);
+		else
+			ret = 0;
+	} else {
+		ret = -ENODEV;
+	}
+
+	srcu_read_unlock(&pcs_srcu, idx);
+	return ret;
+}
+
+static void pcs_disable(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&pcs_srcu);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
+	if (wrapped && wrapped->ops->pcs_disable)
+		wrapped->ops->pcs_disable(wrapped);
+
+	srcu_read_unlock(&pcs_srcu, idx);
+}
+
+static void pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
+			  struct phylink_link_state *state)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&pcs_srcu);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
+	if (wrapped)
+		wrapped->ops->pcs_get_state(wrapped, neg_mode, state);
+	else
+		state->link = 0;
+
+	srcu_read_unlock(&pcs_srcu, idx);
+}
+
+static void pcs_pre_config(struct phylink_pcs *pcs,
+			   phy_interface_t interface)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&pcs_srcu);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
+	if (wrapped && wrapped->ops->pcs_pre_config)
+		wrapped->ops->pcs_pre_config(wrapped, interface);
+
+	srcu_read_unlock(&pcs_srcu, idx);
+}
+
+static int pcs_post_config(struct phylink_pcs *pcs,
+			   phy_interface_t interface)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int ret, idx;
+
+	idx = srcu_read_lock(&pcs_srcu);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
+	if (wrapped && wrapped->ops->pcs_post_config)
+		ret = wrapped->ops->pcs_post_config(wrapped, interface);
+	else
+		ret = 0;
+
+	srcu_read_unlock(&pcs_srcu, idx);
+	return ret;
+}
+
+static int pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+		      phy_interface_t interface,
+		      const unsigned long *advertising,
+		      bool permit_pause_to_mac)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int ret, idx;
+
+	idx = srcu_read_lock(&pcs_srcu);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
+	if (wrapped)
+		ret = wrapped->ops->pcs_config(wrapped, neg_mode, interface,
+					       advertising, permit_pause_to_mac);
+	else
+		ret = -ENODEV;
+
+	srcu_read_unlock(&pcs_srcu, idx);
+	return ret;
+}
+
+static void pcs_an_restart(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&pcs_srcu);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
+	if (wrapped)
+		wrapped->ops->pcs_an_restart(wrapped);
+
+	srcu_read_unlock(&pcs_srcu, idx);
+}
+
+static void pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
+			phy_interface_t interface, int speed, int duplex)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&pcs_srcu);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
+	if (wrapped && wrapped->ops->pcs_link_up)
+		wrapped->ops->pcs_link_up(wrapped, neg_mode, interface, speed,
+					  duplex);
+
+	srcu_read_unlock(&pcs_srcu, idx);
+}
+
+static void pcs_disable_eee(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&pcs_srcu);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
+	if (wrapped && wrapped->ops->pcs_disable_eee)
+		wrapped->ops->pcs_disable_eee(wrapped);
+
+	srcu_read_unlock(&pcs_srcu, idx);
+}
+
+static void pcs_enable_eee(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&pcs_srcu);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
+	if (wrapped && wrapped->ops->pcs_enable_eee)
+		wrapped->ops->pcs_enable_eee(wrapped);
+
+	srcu_read_unlock(&pcs_srcu, idx);
+}
+
+static int pcs_pre_init(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int ret, idx;
+
+	idx = srcu_read_lock(&pcs_srcu);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
+	if (wrapped) {
+		wrapped->rxc_always_on = pcs->rxc_always_on;
+		if (wrapped->ops->pcs_pre_init)
+			ret = wrapped->ops->pcs_pre_init(wrapped);
+		else
+			ret = 0;
+	} else {
+		ret = -ENODEV;
+	}
+
+	srcu_read_unlock(&pcs_srcu, idx);
+	return ret;
+}
+
+static const struct phylink_pcs_ops pcs_ops = {
+	.pcs_validate = pcs_validate,
+	.pcs_inband_caps = pcs_inband_caps,
+	.pcs_enable = pcs_enable,
+	.pcs_disable = pcs_disable,
+	.pcs_pre_config = pcs_pre_config,
+	.pcs_post_config = pcs_post_config,
+	.pcs_get_state = pcs_get_state,
+	.pcs_config = pcs_config,
+	.pcs_an_restart = pcs_an_restart,
+	.pcs_link_up = pcs_link_up,
+	.pcs_disable_eee = pcs_disable_eee,
+	.pcs_enable_eee = pcs_enable_eee,
+	.pcs_pre_init = pcs_pre_init,
+};
+
+static void pcs_change_callback(void *priv, bool up)
+{
+	struct pcs_wrapper *wrapper = priv;
+
+	phylink_pcs_change(&wrapper->pcs, up);
+}
+
+/**
+ * pcs_register_full() - register a new PCS
+ * @dev: The device requesting the PCS
+ * @fwnode: The PCS's firmware node; typically @dev.fwnode
+ * @pcs: The PCS to register
+ *
+ * Registers a new PCS which can be attached to a phylink.
+ *
+ * Return: 0 on success, or -errno on error
+ */
+int pcs_register_full(struct device *dev, struct fwnode_handle *fwnode,
+		      struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper;
+
+	if (!dev || !pcs->ops)
+		return -EINVAL;
+
+	if (!pcs->ops->pcs_an_restart || !pcs->ops->pcs_config ||
+	    !pcs->ops->pcs_get_state)
+		return -EINVAL;
+
+	wrapper = kzalloc(sizeof(*wrapper), GFP_KERNEL);
+	if (!wrapper)
+		return -ENOMEM;
+
+	refcount_set(&wrapper->refcnt, 1);
+	INIT_LIST_HEAD(&wrapper->list);
+	wrapper->dev = get_device(dev);
+	wrapper->fwnode = fwnode_handle_get(fwnode);
+	RCU_INIT_POINTER(wrapper->wrapped, pcs);
+
+	wrapper->pcs.ops = &pcs_ops;
+	wrapper->pcs.poll = pcs->poll;
+	bitmap_copy(wrapper->pcs.supported_interfaces,
+		    pcs->supported_interfaces, PHY_INTERFACE_MODE_MAX);
+
+	pcs->link_change = pcs_change_callback;
+	pcs->link_change_priv = wrapper;
+
+	spin_lock(&pcs_lock);
+	list_add(&wrapper->list, &pcs_wrappers);
+	spin_unlock(&pcs_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcs_register_full);
+
+/**
+ * pcs_unregister() - unregister a PCS
+ * @pcs: a PCS previously registered with pcs_register()
+ */
+void pcs_unregister(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper;
+
+	spin_lock(&pcs_lock);
+	list_for_each_entry(wrapper, &pcs_wrappers, list) {
+		if (rcu_access_pointer(wrapper->wrapped) == pcs)
+			goto found;
+	}
+
+	spin_unlock(&pcs_lock);
+	WARN(1, "trying to unregister an already-unregistered PCS\n");
+	return;
+
+found:
+	list_del(&wrapper->list);
+	spin_unlock(&pcs_lock);
+
+	put_device(wrapper->dev);
+	fwnode_handle_put(wrapper->fwnode);
+	rcu_replace_pointer(wrapper->wrapped, NULL, true);
+	synchronize_srcu(&pcs_srcu);
+
+	if (!wrapper->pcs.poll)
+		phylink_pcs_change(&wrapper->pcs, false);
+	if (refcount_dec_and_test(&wrapper->refcnt))
+		kfree(wrapper);
+}
+EXPORT_SYMBOL_GPL(pcs_unregister);
+
+static void devm_pcs_unregister(void *pcs)
+{
+	pcs_unregister(pcs);
+}
+
+/**
+ * devm_pcs_register_full - resource managed pcs_register()
+ * @dev: device that is registering this PCS
+ * @fwnode: The PCS's firmware node; typically @dev.fwnode
+ * @pcs: the PCS to register
+ *
+ * Managed pcs_register(). For PCSs registered by this function,
+ * pcs_unregister() is automatically called on driver detach. See
+ * pcs_register() for more information.
+ *
+ * Return: 0 on success, or -errno on failure
+ */
+int devm_pcs_register_full(struct device *dev, struct fwnode_handle *fwnode,
+			   struct phylink_pcs *pcs)
+{
+	int ret;
+
+	ret = pcs_register_full(dev, fwnode, pcs);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_pcs_unregister, pcs);
+}
+EXPORT_SYMBOL_GPL(devm_pcs_register_full);
+
+/**
+ * _pcs_get_tail() - Look up and request a PCS
+ * @dev: The device requesting the PCS
+ * @fwnode: The PCS's fwnode
+ * @pcs_dev: The PCS's device
+ *
+ * Search PCSs registered with pcs_register() for one with a matching
+ * fwnode or device. Either @fwnode or @pcs_dev may be %NULL if matching
+ * against a fwnode or device is not desired (respectively).
+ *
+ * Once a PCS is found, perform common operations necessary when getting a PCS
+ * (increment reference counts, etc).
+ *
+ * You should probably call one of the pcs_get* functions instead of this one.
+ *
+ * Return: A PCS, or an error pointer on failure. If both @fwnode and @pcs_dev
+ *         are %NULL, returns %NULL to allow easier chaining.
+ */
+struct phylink_pcs *_pcs_get_tail(struct device *dev,
+				  const struct fwnode_handle *fwnode,
+				  const struct device *pcs_dev)
+{
+	struct pcs_wrapper *wrapper;
+
+	if (!fwnode && !pcs_dev)
+		return NULL;
+
+	pr_debug("looking for %pfwf or %s %s...\n", fwnode,
+		 pcs_dev ? dev_driver_string(pcs_dev) : "(null)",
+		 pcs_dev ? dev_name(pcs_dev) : "(null)");
+
+	spin_lock(&pcs_lock);
+	list_for_each_entry(wrapper, &pcs_wrappers, list) {
+		if (pcs_dev && wrapper->dev == pcs_dev)
+			goto found;
+		if (fwnode && wrapper->fwnode == fwnode)
+			goto found;
+	}
+	spin_unlock(&pcs_lock);
+	pr_debug("...not found\n");
+	return ERR_PTR(-EPROBE_DEFER);
+
+found:
+	refcount_inc(&wrapper->refcnt);
+	spin_unlock(&pcs_lock);
+	pr_debug("...found\n");
+	return &wrapper->pcs;
+}
+EXPORT_SYMBOL_GPL(_pcs_get_tail);
+
+/**
+ * pcs_find_fwnode() - Find a PCS's fwnode
+ * @mac_node: The fwnode referencing the PCS
+ * @id: The name of the PCS to get. May be %NULL to get the first PCS.
+ * @fallback: An optional fallback property to use if pcs-handle is absent
+ * @optional: Whether the PCS is optional
+ *
+ * Find a PCS's fwnode, as referenced by @mac_node. This fwnode can later be
+ * used with _pcs_get_tail() to get the actual PCS. ``pcs-handle-names`` is
+ * used to match @id, then the fwnode is found using ``pcs-handle``.
+ *
+ * This function is internal to the PCS subsystem from a consumer
+ * point-of-view. However, it may be used to implement fallbacks for legacy
+ * behavior in PCS providers.
+ *
+ * Return: %NULL if @optional is set and the PCS cannot be found. Otherwise,
+ *         returns a PCS if found or an error pointer on failure.
+ */
+struct fwnode_handle *pcs_find_fwnode(const struct fwnode_handle *mac_node,
+				      const char *id, const char *fallback,
+				      bool optional)
+{
+	struct fwnode_handle *pcs_fwnode;
+	int index;
+
+	if (!mac_node)
+		return optional ? NULL : ERR_PTR(-ENODEV);
+
+	if (id)
+		index = fwnode_property_match_string(mac_node,
+						     "pcs-handle-names", id);
+	else
+		index = 0;
+
+	if (index < 0) {
+		if (optional && (index == -EINVAL || index == -ENODATA))
+			return NULL;
+		return ERR_PTR(index);
+	}
+
+	/* First try pcs-handle, and if that doesn't work try the fallback */
+	pcs_fwnode = fwnode_find_reference(mac_node, "pcs-handle", index);
+	if (PTR_ERR(pcs_fwnode) == -ENOENT && fallback)
+		pcs_fwnode = fwnode_find_reference(mac_node, fallback, index);
+	if (optional && !id && PTR_ERR(pcs_fwnode) == -ENOENT)
+		return NULL;
+	return pcs_fwnode;
+}
+EXPORT_SYMBOL_GPL(pcs_find_fwnode);
+
+/**
+ * _pcs_get() - Get a PCS from a fwnode property
+ * @dev: The device to get a PCS for
+ * @fwnode: The fwnode to find the PCS with
+ * @id: The name of the PCS to get. May be %NULL to get the first PCS.
+ * @fallback: An optional fallback property to use if pcs-handle is absent
+ * @optional: Whether the PCS is optional
+ *
+ * Find a PCS referenced by @fwnode and return a reference to it. Every call
+ * to _pcs_get_by_fwnode() must be balanced with one to pcs_put().
+ *
+ * Return: a PCS if found, %NULL if not, or an error pointer on failure
+ */
+struct phylink_pcs *_pcs_get(struct device *dev, struct fwnode_handle *fwnode,
+			     const char *id, const char *fallback,
+			     bool optional)
+{
+	struct fwnode_handle *pcs_fwnode;
+	struct phylink_pcs *pcs;
+
+	pcs_fwnode = pcs_find_fwnode(fwnode, id, fallback, optional);
+	if (IS_ERR(pcs_fwnode))
+		return ERR_CAST(pcs_fwnode);
+
+	pcs = _pcs_get_tail(dev, pcs_fwnode, NULL);
+	fwnode_handle_put(pcs_fwnode);
+	return pcs;
+}
+EXPORT_SYMBOL_GPL(_pcs_get);
+
+#ifdef CONFIG_OF_DYNAMIC
+static void of_changeset_cleanup(void *data)
+{
+	struct of_changeset *ocs = data;
+
+	if (WARN(of_changeset_revert(ocs),
+		 "could not revert changeset; leaking memory\n"))
+		return;
+
+	of_changeset_destroy(ocs);
+	kfree(ocs);
+}
+
+/**
+ * pcs_get_by_fwnode_compat() - Get a PCS with a compatibility fallback
+ * @dev: The device requesting the PCS
+ * @fwnode: The &struct fwnode_handle of the PCS itself
+ * @fixup: Callback to fix up @fwnode for compatibility
+ * @data: Passed to @fixup
+ *
+ * This function looks up a PCS and retries on failure after fixing up @fwnode.
+ * It is intended to assist in backwards-compatible behavior for drivers that
+ * used to create a PCS directly from a &struct device_node. This function
+ * should NOT be used in new drivers.
+ *
+ * @fixup modifies a devicetree changeset to create any properties necessary to
+ * bind the PCS's &struct device_node. At the very least, it should use
+ * of_changeset_add_prop_string() to add a compatible property.
+ *
+ * Note that unlike pcs_get_by_fwnode, @fwnode is the &struct fwnode_handle of
+ * the PCS itself, and not that of the requesting device. @fwnode could be
+ * looked up with pcs_find_fwnode() or determined by some other means for
+ * compatibility.
+ *
+ * Return: A PCS on success or an error pointer on failure
+ */
+struct phylink_pcs *
+pcs_get_by_fwnode_compat(struct device *dev, struct fwnode_handle *fwnode,
+			 int (*fixup)(struct of_changeset *ocs,
+				      struct device_node *np, void *data),
+			 void *data)
+{
+	struct mdio_device *mdiodev;
+	struct of_changeset *ocs;
+	struct phylink_pcs *pcs;
+	struct device_node *np;
+	struct device *pcsdev;
+	int err;
+
+	/* First attempt */
+	pcs = _pcs_get_tail(dev, fwnode, NULL);
+	if (PTR_ERR(pcs) != -EPROBE_DEFER)
+		return pcs;
+
+	/* No luck? Maybe there's no compatible... */
+	np = to_of_node(fwnode);
+	if (!np || of_property_present(np, "compatible"))
+		return pcs;
+
+	/* OK, let's try fixing things up */
+	pr_warn("%pOF is missing a compatible\n", np);
+	ocs = kmalloc(sizeof(*ocs), GFP_KERNEL);
+	if (!ocs)
+		return ERR_PTR(-ENOMEM);
+
+	of_changeset_init(ocs);
+	err = fixup(ocs, np, data);
+	if (err)
+		goto err_ocs;
+
+	err = of_changeset_apply(ocs);
+	if (err)
+		goto err_ocs;
+
+	err = devm_add_action_or_reset(dev, of_changeset_cleanup, ocs);
+	if (err)
+		return ERR_PTR(err);
+
+	mdiodev = fwnode_mdio_find_device(fwnode);
+	if (mdiodev) {
+		/* Clear that pesky PHY flag so we can match PCS drivers */
+		device_lock(&mdiodev->dev);
+		mdiodev->flags &= ~MDIO_DEVICE_FLAG_PHY;
+		device_unlock(&mdiodev->dev);
+		pcsdev = &mdiodev->dev;
+	} else {
+		pcsdev = get_device(fwnode->dev);
+		if (!pcsdev)
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	err = device_reprobe(pcsdev);
+	put_device(pcsdev);
+	if (err)
+		return ERR_PTR(err);
+
+	return _pcs_get_tail(dev, fwnode, NULL);
+
+err_ocs:
+	of_changeset_destroy(ocs);
+	kfree(ocs);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(pcs_get_by_fwnode_compat);
+#endif
+
+/**
+ * pcs_put() - Release a previously-acquired PCS
+ * @pcs: The PCS to put
+ *
+ * This frees resources associated with the PCS which were acquired when it was
+ * gotten.
+ */
+void pcs_put(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper;
+
+	if (!pcs)
+		return;
+
+	wrapper = pcs_to_wrapper(pcs);
+	if (refcount_dec_and_test(&wrapper->refcnt))
+		kfree(wrapper);
+}
+EXPORT_SYMBOL_GPL(pcs_put);
diff --git a/include/linux/pcs.h b/include/linux/pcs.h
new file mode 100644
index 000000000000..6f04a3d22669
--- /dev/null
+++ b/include/linux/pcs.h
@@ -0,0 +1,205 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Sean Anderson <sean.anderson@seco.com>
+ */
+
+#ifndef _PCS_H
+#define _PCS_H
+
+#include <linux/property.h>
+
+struct device_node;
+struct of_changeset;
+struct phylink_pcs;
+
+int pcs_register_full(struct device *dev, struct fwnode_handle *fwnode,
+		      struct phylink_pcs *pcs);
+void pcs_unregister(struct phylink_pcs *pcs);
+int devm_pcs_register_full(struct device *dev, struct fwnode_handle *fwnode,
+			   struct phylink_pcs *pcs);
+
+/**
+ * pcs_register() - register a new PCS
+ * @dev: The device requesting the PCS
+ * @pcs: The PCS to register
+ *
+ * Registers a new PCS which can be attached to a phylink.
+ *
+ * Return: 0 on success, or -errno on error
+ */
+static inline int pcs_register(struct device *dev, struct phylink_pcs *pcs)
+{
+	return pcs_register_full(dev, dev_fwnode(dev), pcs);
+}
+
+/**
+ * devm_pcs_register - resource managed pcs_register()
+ * @dev: device that is registering this PCS
+ * @pcs: the PCS to register
+ *
+ * Managed pcs_register(). For PCSs registered by this function,
+ * pcs_unregister() is automatically called on driver detach. See
+ * pcs_register() for more information.
+ *
+ * Return: 0 on success, or -errno on failure
+ */
+static inline int devm_pcs_register(struct device *dev, struct phylink_pcs *pcs)
+{
+	return devm_pcs_register_full(dev, dev_fwnode(dev), pcs);
+}
+
+struct fwnode_handle *pcs_find_fwnode(const struct fwnode_handle *mac_node,
+				      const char *id, const char *fallback,
+				      bool optional);
+
+#ifdef CONFIG_PCS
+struct phylink_pcs *_pcs_get_tail(struct device *dev,
+				  const struct fwnode_handle *fwnode,
+				  const struct device *pcs_dev);
+struct phylink_pcs *_pcs_get(struct device *dev, struct fwnode_handle *fwnode,
+			     const char *id, const char *fallback,
+			     bool optional);
+void pcs_put(struct phylink_pcs *handle);
+
+/**
+ * pcs_get() - Get a PCS based on a fwnode
+ * @dev: The device requesting the PCS
+ * @id: The name of the PCS
+ *
+ * Find and get a PCS, as referenced by @dev's &struct fwnode_handle. See
+ * pcs_find_fwnode() for details. Each call to this function must be balanced
+ * with one to pcs_put().
+ *
+ * Return: A PCS on success or an error pointer on failure
+ */
+static inline struct phylink_pcs *pcs_get(struct device *dev, const char *id)
+{
+	return _pcs_get(dev, dev_fwnode(dev), id, NULL, false);
+}
+
+/**
+ * pcs_get_optional() - Optionally get a PCS based on a fwnode
+ * @dev: The device requesting the PCS
+ * @id: The name of the PCS
+ *
+ * Optionally find and get a PCS, as referenced by @dev's &struct
+ * fwnode_handle. See pcs_find_fwnode() for details. Each call to this function
+ * must be balanced with one to pcs_put().
+ *
+ * Return: A PCS on success, %NULL if none was found, or an error pointer on
+ * *       failure
+ */
+static inline struct phylink_pcs *pcs_get_optional(struct device *dev,
+						   const char *id)
+{
+	return _pcs_get(dev, dev_fwnode(dev), id, NULL, true);
+}
+
+/**
+ * pcs_get_by_fwnode() - Get a PCS based on a fwnode
+ * @dev: The device requesting the PCS
+ * @fwnode: The &struct fwnode_handle referencing the PCS
+ * @id: The name of the PCS
+ *
+ * Find and get a PCS, as referenced by @fwnode. See pcs_find_fwnode() for
+ * details. Each call to this function must be balanced with one to pcs_put().
+ *
+ * Return: A PCS on success or an error pointer on failure
+ */
+static inline struct phylink_pcs
+*pcs_get_by_fwnode(struct device *dev, struct fwnode_handle *fwnode,
+		   const char *id)
+{
+	return _pcs_get(dev, fwnode, id, NULL, false);
+}
+
+/**
+ * pcs_get_by_fwnode_optional() - Optionally get a PCS based on a fwnode
+ * @dev: The device requesting the PCS
+ * @fwnode: The &struct fwnode_handle referencing the PCS
+ * @id: The name of the PCS
+ *
+ * Optionally find and get a PCS, as referenced by @fwnode. See
+ * pcs_find_fwnode() for details. Each call to this function must be balanced
+ * with one to pcs_put().
+ *
+ * Return: A PCS on success, %NULL if none was found, or an error pointer on
+ * *       failure
+ */
+static inline struct phylink_pcs
+*pcs_get_by_fwnode_optional(struct device *dev, struct fwnode_handle *fwnode,
+			    const char *id)
+{
+	return _pcs_get(dev, fwnode, id, NULL, true);
+}
+
+/**
+ * pcs_get_by_dev() - Get a PCS from its providing device
+ * @dev: The device requesting the PCS
+ * @pcs_dev: The device providing the PCS
+ *
+ * Get the first PCS registered by @pcs_dev. Each call to this function must be
+ * balanced with one to pcs_put().
+ *
+ * Return: A PCS on success or an error pointer on failure
+ */
+static inline struct phylink_pcs *pcs_get_by_dev(struct device *dev,
+						 const struct device *pcs_dev)
+{
+	return _pcs_get_tail(dev, NULL, pcs_dev);
+}
+#else /* CONFIG_PCS */
+static inline void pcs_put(struct phylink_pcs *handle)
+{
+}
+
+static inline struct phylink_pcs *pcs_get(struct device *dev, const char *id)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct phylink_pcs *pcs_get_optional(struct device *dev,
+						   const char *id)
+{
+	return NULL;
+}
+
+static inline struct phylink_pcs
+*pcs_get_by_fwnode(struct device *dev, struct fwnode_handle *fwnode,
+		   const char *id)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct phylink_pcs
+*pcs_get_by_fwnode_optional(struct device *dev, struct fwnode_handle *fwnode,
+			    const char *id)
+{
+	return NULL;
+}
+
+static inline struct phylink_pcs *pcs_get_by_dev(struct device *dev,
+						 const struct device *pcs_dev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif
+
+#ifdef CONFIG_OF_DYNAMIC
+struct phylink_pcs *
+pcs_get_by_fwnode_compat(struct device *dev, struct fwnode_handle *fwnode,
+			 int (*fixup)(struct of_changeset *ocs, struct device_node *np,
+				      void *data),
+			 void *data);
+#else
+static inline struct phylink_pcs *
+pcs_get_by_fwnode_compat(struct device *dev, struct fwnode_handle *fwnode,
+			 int (*fixup)(struct of_changeset *ocs, struct device_node *np,
+				      void *data),
+			 void *data)
+{
+	return _pcs_get_tail(dev, fwnode, NULL);
+}
+#endif
+
+#endif /* PCS_H */
-- 
2.35.1.1320.gc452695387.dirty


