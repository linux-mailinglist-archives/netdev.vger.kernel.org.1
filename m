Return-Path: <netdev+bounces-77287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AA987125E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 02:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF74B21E66
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 01:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88417BCA;
	Tue,  5 Mar 2024 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUADzLnd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12D717BBD
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602534; cv=none; b=TQdb/B3gqaOcT4vRaG3+D+rI8zmUBaewVitulaPgmGewDvRle8icSmWLq3bolp3YGV1V9r+6bSVVnZQd7DE89AjxWMbZ6fPiWv0dhssnDdFEfLK0PwOdXj1TO8rT66t0lsifbjMZh8btLvtfT8BVeiabfHkHRREQCRkuC0uzuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602534; c=relaxed/simple;
	bh=aVAJJSo3LKQdSiPing/b4kPBmqZLusqntvSOejEKnmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SkeMUpWnIaExwHIQ9mo9kYPMAxAJCbh0y4zMhfmISa/bX3kVD4BiZPDLJ7tIw4zrSCbAF4WOD9FKM29/Ex0WVwGQsurXzZCapUl7XvUn+uI72skUgLhMDckPHspnFzlncB0XfBX1iTcI5m6o7YOdyO8Wi+/lDXhoJ8L3PJ6cQbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUADzLnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF6CC433F1;
	Tue,  5 Mar 2024 01:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709602534;
	bh=aVAJJSo3LKQdSiPing/b4kPBmqZLusqntvSOejEKnmc=;
	h=From:To:Cc:Subject:Date:From;
	b=BUADzLndr5YgUBkTv6Id64cz/wmn234NODu2Bs5rKKKXOgqyNVu5RCAd5MnKd55Ho
	 MfVVmtb9JCkyCCLhbcB9DCxZmfzAsh5mfkpHOkVpe45IyQYvuw04Zz7NDl2iqVwy9x
	 F9R0n3dDrJ/J9JhH0vzMxqlGLLQ4h+ifwbOXd2o1NquD7Ta6QQeTQhdmHbmXOcrJlu
	 H6xujPfEpWvuyPT7oSsCeKLCVbFP7Gsa067UHLQhipfYr+QsR7KcJNT1uKOBYYetVl
	 MR0HU978b8RqBH3Qk1XQhJwR0ETvtgaTnXo1KkR8E/wlH8/s9UsIZ0X0zIEKStR7ti
	 BiUYXNkhnl1FQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us
Subject: [PATCH net v2] dpll: move all dpll<>netdev helpers to dpll code
Date: Mon,  4 Mar 2024 17:35:32 -0800
Message-ID: <20240305013532.694866-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Older versions of GCC really want to know the full definition
of the type involved in rcu_assign_pointer().

struct dpll_pin is defined in a local header, net/core can't
reach it. Move all the netdev <> dpll code into dpll, where
the type is known. Otherwise we'd need multiple function calls
to jump between the compilation units.

This is the same problem the commit under fixes was trying to address,
but with rcu_assign_pointer() not rcu_dereference().

Some of the exports are not needed, networking core can't
be a module, we only need exports for the helpers used by
drivers.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/35a869c8-52e8-177-1d4d-e57578b99b6@linux-m68k.org/
Fixes: 640f41ed33b5 ("dpll: fix build failure due to rcu_dereference_check() on unknown type")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - covering the extra cases discovered by Geert
 - re-target the whole thing at net, doing temporary fixes in net
   and refactoring in net-next feels wrong
v1: https://lore.kernel.org/all/20240301001607.2925706-1-kuba@kernel.org/

CC: vadim.fedorenko@linux.dev
CC: arkadiusz.kubalewski@intel.com
CC: jiri@resnulli.us
---
 Documentation/driver-api/dpll.rst             |  2 +-
 drivers/dpll/dpll_core.c                      | 25 +++++++++---
 drivers/dpll/dpll_netlink.c                   | 38 ++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_dpll.c     |  4 +-
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  4 +-
 include/linux/dpll.h                          | 26 ++++++-------
 include/linux/netdevice.h                     |  4 --
 net/core/dev.c                                | 22 -----------
 net/core/rtnetlink.c                          |  4 +-
 9 files changed, 64 insertions(+), 65 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index e3d593841aa7..ea8d16600e16 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -545,7 +545,7 @@ In such scenario, dpll device input signal shall be also configurable
 to drive dpll with signal recovered from the PHY netdevice.
 This is done by exposing a pin to the netdevice - attaching pin to the
 netdevice itself with
-``netdev_dpll_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin)``.
+``dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin)``.
 Exposed pin id handle ``DPLL_A_PIN_ID`` is then identifiable by the user
 as it is attached to rtnetlink respond to get ``RTM_NEWLINK`` command in
 nested attribute ``IFLA_DPLL_PIN``.
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 241db366b2c7..7f686d179fc9 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -42,11 +42,6 @@ struct dpll_pin_registration {
 	void *priv;
 };
 
-struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
-{
-	return rcu_dereference_rtnl(dev->dpll_pin);
-}
-
 struct dpll_device *dpll_device_get_by_id(int id)
 {
 	if (xa_get_mark(&dpll_device_xa, id, DPLL_REGISTERED))
@@ -513,6 +508,26 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	return ERR_PTR(ret);
 }
 
+static void dpll_netdev_pin_assign(struct net_device *dev, struct dpll_pin *dpll_pin)
+{
+	rtnl_lock();
+	rcu_assign_pointer(dev->dpll_pin, dpll_pin);
+	rtnl_unlock();
+}
+
+void dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin)
+{
+	WARN_ON(!dpll_pin);
+	dpll_netdev_pin_assign(dev, dpll_pin);
+}
+EXPORT_SYMBOL(dpll_netdev_pin_set);
+
+void dpll_netdev_pin_clear(struct net_device *dev)
+{
+	dpll_netdev_pin_assign(dev, NULL);
+}
+EXPORT_SYMBOL(dpll_netdev_pin_clear);
+
 /**
  * dpll_pin_get - find existing or create new dpll pin
  * @clock_id: clock_id of creator
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 4ca9ad16cd95..8746828ce819 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -8,6 +8,7 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/netdevice.h>
 #include <net/genetlink.h>
 #include "dpll_core.h"
 #include "dpll_netlink.h"
@@ -47,18 +48,6 @@ dpll_msg_add_dev_parent_handle(struct sk_buff *msg, u32 id)
 	return 0;
 }
 
-/**
- * dpll_msg_pin_handle_size - get size of pin handle attribute for given pin
- * @pin: pin pointer
- *
- * Return: byte size of pin handle attribute for given pin.
- */
-size_t dpll_msg_pin_handle_size(struct dpll_pin *pin)
-{
-	return pin ? nla_total_size(4) : 0; /* DPLL_A_PIN_ID */
-}
-EXPORT_SYMBOL_GPL(dpll_msg_pin_handle_size);
-
 /**
  * dpll_msg_add_pin_handle - attach pin handle attribute to a given message
  * @msg: pointer to sk_buff message to attach a pin handle
@@ -68,7 +57,7 @@ EXPORT_SYMBOL_GPL(dpll_msg_pin_handle_size);
  * * 0 - success
  * * -EMSGSIZE - no space in message to attach pin handle
  */
-int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
+static int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
 {
 	if (!pin)
 		return 0;
@@ -76,7 +65,28 @@ int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
 		return -EMSGSIZE;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dpll_msg_add_pin_handle);
+
+static struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
+{
+	return rcu_dereference_rtnl(dev->dpll_pin);
+}
+
+/**
+ * dpll_netdev_pin_handle_size - get size of pin handle attribute of a netdev
+ * @dev: netdev from which to get the pin
+ *
+ * Return: byte size of pin handle attribute, or 0 if @dev has no pin.
+ */
+size_t dpll_netdev_pin_handle_size(const struct net_device *dev)
+{
+	return netdev_dpll_pin(dev) ? nla_total_size(4) : 0; /* DPLL_A_PIN_ID */
+}
+
+int dpll_netdev_add_pin_handle(struct sk_buff *msg,
+			       const struct net_device *dev)
+{
+	return dpll_msg_add_pin_handle(msg, netdev_dpll_pin(dev));
+}
 
 static int
 dpll_msg_add_mode(struct sk_buff *msg, struct dpll_device *dpll,
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index adfa1f2a80a6..c59e972dbaae 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1597,7 +1597,7 @@ static void ice_dpll_deinit_rclk_pin(struct ice_pf *pf)
 	}
 	if (WARN_ON_ONCE(!vsi || !vsi->netdev))
 		return;
-	netdev_dpll_pin_clear(vsi->netdev);
+	dpll_netdev_pin_clear(vsi->netdev);
 	dpll_pin_put(rclk->pin);
 }
 
@@ -1641,7 +1641,7 @@ ice_dpll_init_rclk_pins(struct ice_pf *pf, struct ice_dpll_pin *pin,
 	}
 	if (WARN_ON((!vsi || !vsi->netdev)))
 		return -EINVAL;
-	netdev_dpll_pin_set(vsi->netdev, pf->dplls.rclk.pin);
+	dpll_netdev_pin_set(vsi->netdev, pf->dplls.rclk.pin);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 928bf24d4b12..d74a5aaf4268 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -261,7 +261,7 @@ static void mlx5_dpll_netdev_dpll_pin_set(struct mlx5_dpll *mdpll,
 {
 	if (mdpll->tracking_netdev)
 		return;
-	netdev_dpll_pin_set(netdev, mdpll->dpll_pin);
+	dpll_netdev_pin_set(netdev, mdpll->dpll_pin);
 	mdpll->tracking_netdev = netdev;
 }
 
@@ -269,7 +269,7 @@ static void mlx5_dpll_netdev_dpll_pin_clear(struct mlx5_dpll *mdpll)
 {
 	if (!mdpll->tracking_netdev)
 		return;
-	netdev_dpll_pin_clear(mdpll->tracking_netdev);
+	dpll_netdev_pin_clear(mdpll->tracking_netdev);
 	mdpll->tracking_netdev = NULL;
 }
 
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index c60591308ae8..e37344f6a231 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -122,15 +122,24 @@ struct dpll_pin_properties {
 };
 
 #if IS_ENABLED(CONFIG_DPLL)
-size_t dpll_msg_pin_handle_size(struct dpll_pin *pin);
-int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin);
+void dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin);
+void dpll_netdev_pin_clear(struct net_device *dev);
+
+size_t dpll_netdev_pin_handle_size(const struct net_device *dev);
+int dpll_netdev_add_pin_handle(struct sk_buff *msg,
+			       const struct net_device *dev);
 #else
-static inline size_t dpll_msg_pin_handle_size(struct dpll_pin *pin)
+static inline void
+dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin) { }
+static inline void dpll_netdev_pin_clear(struct net_device *dev) { }
+
+static inline size_t dpll_netdev_pin_handle_size(const struct net_device *dev)
 {
 	return 0;
 }
 
-static inline int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
+static inline int
+dpll_netdev_add_pin_handle(struct sk_buff *msg, const struct net_device *dev)
 {
 	return 0;
 }
@@ -169,13 +178,4 @@ int dpll_device_change_ntf(struct dpll_device *dpll);
 
 int dpll_pin_change_ntf(struct dpll_pin *pin);
 
-#if !IS_ENABLED(CONFIG_DPLL)
-static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
-{
-	return NULL;
-}
-#else
-struct dpll_pin *netdev_dpll_pin(const struct net_device *dev);
-#endif
-
 #endif
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 735a9386fcf8..78a09af89e39 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -79,8 +79,6 @@ struct xdp_buff;
 struct xdp_frame;
 struct xdp_metadata_ops;
 struct xdp_md;
-/* DPLL specific */
-struct dpll_pin;
 
 typedef u32 xdp_features_t;
 
@@ -4042,8 +4040,6 @@ int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
 int dev_get_port_parent_id(struct net_device *dev,
 			   struct netdev_phys_item_id *ppid, bool recurse);
 bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);
-void netdev_dpll_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin);
-void netdev_dpll_pin_clear(struct net_device *dev);
 
 struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again);
 struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
diff --git a/net/core/dev.c b/net/core/dev.c
index 0230391c78f7..76e6438f4858 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9074,28 +9074,6 @@ bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b)
 }
 EXPORT_SYMBOL(netdev_port_same_parent_id);
 
-static void netdev_dpll_pin_assign(struct net_device *dev, struct dpll_pin *dpll_pin)
-{
-#if IS_ENABLED(CONFIG_DPLL)
-	rtnl_lock();
-	rcu_assign_pointer(dev->dpll_pin, dpll_pin);
-	rtnl_unlock();
-#endif
-}
-
-void netdev_dpll_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin)
-{
-	WARN_ON(!dpll_pin);
-	netdev_dpll_pin_assign(dev, dpll_pin);
-}
-EXPORT_SYMBOL(netdev_dpll_pin_set);
-
-void netdev_dpll_pin_clear(struct net_device *dev)
-{
-	netdev_dpll_pin_assign(dev, NULL);
-}
-EXPORT_SYMBOL(netdev_dpll_pin_clear);
-
 /**
  *	dev_change_proto_down - set carrier according to proto_down.
  *
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ae86f751efc3..bd50e9fe3234 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1057,7 +1057,7 @@ static size_t rtnl_dpll_pin_size(const struct net_device *dev)
 {
 	size_t size = nla_total_size(0); /* nest IFLA_DPLL_PIN */
 
-	size += dpll_msg_pin_handle_size(netdev_dpll_pin(dev));
+	size += dpll_netdev_pin_handle_size(dev);
 
 	return size;
 }
@@ -1792,7 +1792,7 @@ static int rtnl_fill_dpll_pin(struct sk_buff *skb,
 	if (!dpll_pin_nest)
 		return -EMSGSIZE;
 
-	ret = dpll_msg_add_pin_handle(skb, netdev_dpll_pin(dev));
+	ret = dpll_netdev_add_pin_handle(skb, dev);
 	if (ret < 0)
 		goto nest_cancel;
 
-- 
2.44.0


