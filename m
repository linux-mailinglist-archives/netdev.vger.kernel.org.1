Return-Path: <netdev+bounces-179095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11764A7A928
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 20:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E643B8961
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 18:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ABE253B6C;
	Thu,  3 Apr 2025 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rax/4iVX"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7A25335D
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704375; cv=none; b=iYfgcny0VFk8mVXtf3XnubF3yftZ/CjLmAi4yY4mj3utn0qNZSeviFYvT3I3lCLRBIN90TQiq5dUbUhuNn3FYFT2iBe5W4O8x5qNbKfDG3/ZTi3dKtMyFWSGXiAdZ+GlkdYq6V5eH8qMGoBwXOErQWIGkEiWPYFYtjOuoZsTaHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704375; c=relaxed/simple;
	bh=UwK6F7Z6P5+SofjQVQeIUXE6qb5DKJKzasCJgVBo9xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGEiLNOBkRM+dOCBYlCWvuOuM4rSR0nyecyEuFVMPrQmPLVPpxQjXnX9loB3mbPyEizJ1yDihisPNI08ySQ0JTaywIqAel7fAUTVnMlE5+Qc9XmlEL3Db7GW3jtSGh3Qk0YmbsOgCvaqQKQ7T/Z8VVNI4hX9J2uOopo8wPcimyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rax/4iVX; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743704370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VmOzHRCKK//tjTGoGqSzoFrHc6VkoHv6ThwTrKjhWgI=;
	b=rax/4iVX8XJJ/sd8WW5o61+yP3tlhc79o29mNLmx2dUp7beTpSWz9qSCJMTKgZh5N8dCGg
	QILwVFeQt1ncv0e1yABSjEvTkz/W/aHWhAp5OfvYP3XZgP7oGjQq/7DvCYJlbq53hq5EC0
	/E6ExMdBAocxU8aqPc3oRzAjKelJLBk=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	upstream@airoha.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [RFC net-next PATCH 03/13] net: pcs: Add subsystem
Date: Thu,  3 Apr 2025 14:18:57 -0400
Message-Id: <20250403181907.1947517-4-sean.anderson@linux.dev>
In-Reply-To: <20250403181907.1947517-1-sean.anderson@linux.dev>
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
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
was inspired by Bartosz Golaszewsk's talk at LPC [1].

pcs_get_by_fwnode_compat is a bit hairy, but it's necessary for
compatibility with existing drivers, which often attach to (devicetree)
nodes directly. We use the devicetree changeset system instead of
adding a (secondary) software node because mdio_bus_match calls
of_driver_match_device to match devices, and that function only works on
devicetree nodes.

[1] https://lpc.events/event/17/contributions/1627/

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 Documentation/networking/index.rst |   1 +
 Documentation/networking/kapi.rst  |   4 +
 Documentation/networking/pcs.rst   |  99 ++++
 MAINTAINERS                        |   2 +
 drivers/net/pcs/Kconfig            |  12 +
 drivers/net/pcs/Makefile           |   2 +
 drivers/net/pcs/core.c             | 701 +++++++++++++++++++++++++++++
 include/linux/pcs.h                | 122 +++++
 8 files changed, 943 insertions(+)
 create mode 100644 Documentation/networking/pcs.rst
 create mode 100644 drivers/net/pcs/core.c
 create mode 100644 include/linux/pcs.h

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 058193ed2eeb..96a2cf71057d 100644
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
index 000000000000..3677527e5e2b
--- /dev/null
+++ b/Documentation/networking/pcs.rst
@@ -0,0 +1,99 @@
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
+register your PCS in your probe function using :c:func:`pcs_register`. You must
+call :c:func:`pcs_unregister` from your remove function. You can avoid this step
+by registering with :c:func:`devm_pcs_unregister`.
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
index 1cd25139cc58..9d3b3788a005 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8644,6 +8644,7 @@ F:	Documentation/ABI/testing/sysfs-class-net-phydev
 F:	Documentation/devicetree/bindings/net/ethernet-phy.yaml
 F:	Documentation/devicetree/bindings/net/mdio*
 F:	Documentation/devicetree/bindings/net/qca,ar803x.yaml
+F:	Documentation/networking/pcs.rst
 F:	Documentation/networking/phy.rst
 F:	drivers/net/mdio/
 F:	drivers/net/mdio/acpi_mdio.c
@@ -8657,6 +8658,7 @@ F:	include/linux/linkmode.h
 F:	include/linux/mdio/*.h
 F:	include/linux/mii.h
 F:	include/linux/of_net.h
+F:	include/linux/pcs.h
 F:	include/linux/phy.h
 F:	include/linux/phy_fixed.h
 F:	include/linux/phy_link_topology.h
diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index f6aa437473de..b764770063cc 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -5,6 +5,18 @@
 
 menu "PCS device drivers"
 
+config PCS
+	bool "PCS subsystem"
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
index 000000000000..de3f9e418cf2
--- /dev/null
+++ b/drivers/net/pcs/core.c
@@ -0,0 +1,701 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022, 2025 Sean Anderson <sean.anderson@seco.com>
+ */
+
+#define pr_fmt(fmt) "pcs-core: " fmt
+
+#include <linux/fwnode.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/pcs.h>
+#include <linux/phylink.h>
+#include <linux/property.h>
+#include <linux/rcupdate.h>
+
+static LIST_HEAD(pcs_wrappers);
+static DEFINE_MUTEX(pcs_mutex);
+
+/**
+ * struct pcs_wrapper - Wrapper for a registered PCS
+ * @pcs: the wrapping PCS
+ * @ssp: SRCU protecting @wrapped
+ * @refcnt: refcount for the wrapper
+ * @list: list head for pcs_wrappers
+ * @dev: the device associated with this PCS
+ * @wrapped: the backing PCS
+ */
+struct pcs_wrapper {
+	struct phylink_pcs pcs;
+	struct srcu_struct ssp;
+	refcount_t refcnt;
+	struct list_head list;
+	struct device *dev;
+	struct phylink_pcs *wrapped;
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
+	idx = srcu_read_lock(&wrapper->ssp);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &wrapper->ssp);
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
+	srcu_read_unlock(&wrapper->ssp, idx);
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
+	idx = srcu_read_lock(&wrapper->ssp);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &wrapper->ssp);
+	if (wrapped && wrapped->ops->pcs_inband_caps)
+		ret = wrapped->ops->pcs_inband_caps(wrapped, interface);
+	else
+		ret = 0;
+
+	srcu_read_unlock(&wrapper->ssp, idx);
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
+	idx = srcu_read_lock(&wrapper->ssp);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &wrapper->ssp);
+	if (wrapped) {
+		if (wrapped->ops->pcs_enable)
+			ret = wrapped->ops->pcs_enable(wrapped);
+		else
+			ret = 0;
+	} else {
+		ret = -ENODEV;
+	}
+
+	srcu_read_unlock(&wrapper->ssp, idx);
+	return ret;
+}
+
+static void pcs_disable(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&wrapper->ssp);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &wrapper->ssp);
+	if (wrapped && wrapped->ops->pcs_disable)
+		wrapped->ops->pcs_disable(wrapped);
+
+	srcu_read_unlock(&wrapper->ssp, idx);
+}
+
+static void pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
+			  struct phylink_link_state *state)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&wrapper->ssp);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &wrapper->ssp);
+	if (wrapped)
+		wrapped->ops->pcs_get_state(wrapped, neg_mode, state);
+	else
+		state->link = 0;
+
+	srcu_read_unlock(&wrapper->ssp, idx);
+}
+
+static void pcs_pre_config(struct phylink_pcs *pcs,
+			   phy_interface_t interface)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&wrapper->ssp);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &wrapper->ssp);
+	if (wrapped && wrapped->ops->pcs_pre_config)
+		wrapped->ops->pcs_pre_config(wrapped, interface);
+
+	srcu_read_unlock(&wrapper->ssp, idx);
+}
+
+static int pcs_post_config(struct phylink_pcs *pcs,
+			   phy_interface_t interface)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int ret, idx;
+
+	idx = srcu_read_lock(&wrapper->ssp);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &wrapper->ssp);
+	if (pcs && wrapped->ops->pcs_post_config)
+		ret = wrapped->ops->pcs_post_config(wrapped, interface);
+	else
+		ret = 0;
+
+	srcu_read_unlock(&wrapper->ssp, idx);
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
+	idx = srcu_read_lock(&wrapper->ssp);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &wrapper->ssp);
+	if (wrapped)
+		ret = wrapped->ops->pcs_config(wrapped, neg_mode, interface,
+					   advertising, permit_pause_to_mac);
+	else
+		ret = -ENODEV;
+
+	srcu_read_unlock(&wrapper->ssp, idx);
+	return ret;
+}
+
+static void pcs_an_restart(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&wrapper->ssp);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &wrapper->ssp);
+	if (wrapped)
+		wrapped->ops->pcs_an_restart(wrapped);
+
+	srcu_read_unlock(&wrapper->ssp, idx);
+}
+
+static void pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
+			phy_interface_t interface, int speed, int duplex)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&wrapper->ssp);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &wrapper->ssp);
+	if (wrapped && wrapped->ops->pcs_link_up)
+		wrapped->ops->pcs_link_up(wrapped, neg_mode, interface, speed,
+					  duplex);
+
+	srcu_read_unlock(&wrapper->ssp, idx);
+}
+
+static void pcs_disable_eee(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&wrapper->ssp);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &wrapper->ssp);
+	if (wrapped && wrapped->ops->pcs_disable_eee)
+		wrapped->ops->pcs_disable_eee(wrapped);
+
+	srcu_read_unlock(&wrapper->ssp, idx);
+}
+
+static void pcs_enable_eee(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int idx;
+
+	idx = srcu_read_lock(&wrapper->ssp);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &wrapper->ssp);
+	if (wrapped && wrapped->ops->pcs_enable_eee)
+		wrapped->ops->pcs_enable_eee(wrapped);
+
+	srcu_read_unlock(&wrapper->ssp, idx);
+}
+
+static int pcs_pre_init(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
+	struct phylink_pcs *wrapped;
+	int ret, idx;
+
+	idx = srcu_read_lock(&wrapper->ssp);
+
+	wrapped = srcu_dereference(wrapper->wrapped, &wrapper->ssp);
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
+	srcu_read_unlock(&wrapper->ssp, idx);
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
+ * pcs_register() - register a new PCS
+ * @dev: The device requesting the PCS
+ * @pcs: The PCS to register
+ *
+ * Registers a new PCS which can be attached to a phylink.
+ *
+ * Return: 0 on success, or -errno on error
+ */
+int pcs_register(struct device *dev, struct phylink_pcs *pcs)
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
+	init_srcu_struct(&wrapper->ssp);
+	refcount_set(&wrapper->refcnt, 1);
+	INIT_LIST_HEAD(&wrapper->list);
+	wrapper->dev = dev;
+	RCU_INIT_POINTER(wrapper->wrapped, pcs);
+
+	wrapper->pcs.ops = &pcs_ops;
+	wrapper->pcs.poll = pcs->poll;
+	bitmap_copy(wrapper->pcs.supported_interfaces, pcs->supported_interfaces,
+		    PHY_INTERFACE_MODE_MAX);
+
+	pcs->link_change = pcs_change_callback;
+	pcs->link_change_priv = wrapper;
+
+	mutex_lock(&pcs_mutex);
+	list_add(&wrapper->list, &pcs_wrappers);
+	mutex_unlock(&pcs_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcs_register);
+
+static void pcs_destroy(struct pcs_wrapper *wrapper)
+{
+	cleanup_srcu_struct(&wrapper->ssp);
+	kfree(wrapper);
+}
+
+/**
+ * pcs_unregister() - unregister a PCS
+ * @pcs: a PCS previously registered with pcs_register()
+ */
+void pcs_unregister(struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper;
+	struct phylink_pcs *wrapped;
+
+	mutex_lock(&pcs_mutex);
+	list_for_each_entry(wrapper, &pcs_wrappers, list) {
+		if (wrapper->wrapped == pcs)
+			goto found;
+	}
+
+	mutex_unlock(&pcs_mutex);
+	WARN(1, "trying to unregister an already-unregistered PCS\n");
+	return;
+
+found:
+	list_del(&wrapper->list);
+	wrapped = rcu_replace_pointer(wrapper->wrapped, NULL, true);
+	mutex_unlock(&pcs_mutex);
+	synchronize_srcu(&wrapper->ssp);
+
+	if (!wrapper->pcs.poll)
+		phylink_pcs_change(&wrapper->pcs, false);
+	if (refcount_dec_and_test(&wrapper->refcnt))
+		pcs_destroy(wrapper);
+}
+EXPORT_SYMBOL_GPL(pcs_unregister);
+
+static void devm_pcs_release(struct device *dev, void *res)
+{
+	pcs_unregister(*(struct phylink_pcs **)res);
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
+int devm_pcs_register(struct device *dev, struct phylink_pcs *pcs)
+{
+	struct phylink_pcs **pcsp;
+	int ret;
+
+	pcsp = devres_alloc(devm_pcs_release, sizeof(*pcsp),
+			    GFP_KERNEL);
+	if (!pcsp)
+		return -ENOMEM;
+
+	ret = pcs_register(dev, pcs);
+	if (ret) {
+		devres_free(pcsp);
+		return ret;
+	}
+
+	*pcsp = pcs;
+	devres_add(dev, pcsp);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_pcs_register);
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
+ * Return: A PCS, or an error pointer on failure. If both @fwnode and @pcs_dev are
+ * *       %NULL, returns %NULL to allow easier chaining.
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
+	/* We need to hold this until we get to device_link_add. Otherwise,
+	 * someone could unbind the PCS driver.
+	 */
+	mutex_lock(&pcs_mutex);
+	list_for_each_entry(wrapper, &pcs_wrappers, list) {
+		if (pcs_dev && wrapper->dev == pcs_dev)
+			goto found;
+		if (fwnode && wrapper->dev && wrapper->dev->fwnode == fwnode)
+			goto found;
+	}
+	mutex_unlock(&pcs_mutex);
+	pr_debug("...not found\n");
+	return ERR_PTR(-EPROBE_DEFER);
+
+found:
+	pr_debug("...found\n");
+
+	refcount_inc(&wrapper->refcnt);
+	get_device(wrapper->dev);
+
+	mutex_unlock(&pcs_mutex);
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
+ * *       returns a PCS if found or an error pointer on failure.
+ */
+struct fwnode_handle *pcs_find_fwnode(const struct fwnode_handle *mac_node,
+				      const char *id, const char *fallback,
+				      bool optional)
+{
+	int index;
+	struct fwnode_handle *pcs_fwnode;
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
+ * Find a PCS referenced by @mac_node and return a reference to it. Every call
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
+static __maybe_unused void of_changeset_cleanup(void *data)
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
+#ifdef CONFIG_OF_DYNAMIC
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
+#else
+	return _pcs_get_tail(dev, fwnode, NULL);
+#endif
+}
+EXPORT_SYMBOL_GPL(pcs_get_by_fwnode_compat);
+
+/**
+ * pcs_put() - Release a previously-acquired PCS
+ * @dev: The device used to acquire the PCS
+ * @pcs: The PCS to put
+ *
+ * This frees resources associated with the PCS which were acquired when it was
+ * gotten.
+ */
+void pcs_put(struct device *dev, struct phylink_pcs *pcs)
+{
+	struct pcs_wrapper *wrapper;
+
+	if (!pcs)
+		return;
+
+	wrapper = pcs_to_wrapper(pcs);
+	put_device(wrapper->dev);
+	if (refcount_dec_and_test(&wrapper->refcnt))
+		pcs_destroy(wrapper);
+}
+EXPORT_SYMBOL_GPL(pcs_put);
diff --git a/include/linux/pcs.h b/include/linux/pcs.h
new file mode 100644
index 000000000000..53fbff3af9e8
--- /dev/null
+++ b/include/linux/pcs.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Sean Anderson <sean.anderson@seco.com>
+ */
+
+#ifndef _PCS_H
+#define _PCS_H
+
+struct device_node;
+struct of_changeset;
+struct phylink_pcs;
+
+int pcs_register(struct device *dev, struct phylink_pcs *pcs);
+void pcs_unregister(struct phylink_pcs *pcs);
+int devm_pcs_register(struct device *dev, struct phylink_pcs *pcs);
+struct phylink_pcs *_pcs_get_tail(struct device *dev,
+				  const struct fwnode_handle *fwnode,
+				  const struct device *pcs_dev);
+struct phylink_pcs *_pcs_get(struct device *dev, struct fwnode_handle *fwnode,
+			     const char *id, const char *fallback,
+			     bool optional);
+void pcs_put(struct device *dev, struct phylink_pcs *handle);
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
+
+struct fwnode_handle *pcs_find_fwnode(const struct fwnode_handle *mac_node,
+				      const char *id, const char *fallback,
+				      bool optional);
+
+struct phylink_pcs *
+pcs_get_by_fwnode_compat(struct device *dev, struct fwnode_handle *fwnode,
+			 int (*fixup)(struct of_changeset *ocs, struct device_node *np,
+				      void *data),
+			 void *data);
+
+#endif /* PCS_H */
-- 
2.35.1.1320.gc452695387.dirty


