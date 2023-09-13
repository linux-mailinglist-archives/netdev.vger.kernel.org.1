Return-Path: <netdev+bounces-33677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8507279F353
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 22:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF911F21357
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 20:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D275C22F1C;
	Wed, 13 Sep 2023 20:50:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4E27708
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 20:50:35 +0000 (UTC)
Received: from out-217.mta0.migadu.com (out-217.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029051998
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 13:50:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694638233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPV86mHmnR/HeLIS36rhZeS4Hy2B5Mo3iHIK8MvWTQM=;
	b=fxmRgOn33rgbSQY6LeuR4b6YlT4p1SBU3rwFSziE6iM87SA0myuADrvKl8ZVe1bp/1dZOh
	2HG3Dp+EOpf/XAaJ8akSqTzG+m2H7yp3abKarAqnh7wlU+iwVYEK247zMkE4C7R6+vwdC6
	q3a2IgwLQ13BPQHEu9K5HePvR2KSpX4=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@nvidia.com>,
	Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	poros@redhat.com,
	mschmidt@redhat.com,
	netdev@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next v8 5/9] netdev: expose DPLL pin handle for netdevice
Date: Wed, 13 Sep 2023 21:49:39 +0100
Message-Id: <20230913204943.1051233-6-vadim.fedorenko@linux.dev>
In-Reply-To: <20230913204943.1051233-1-vadim.fedorenko@linux.dev>
References: <20230913204943.1051233-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiri Pirko <jiri@nvidia.com>

In case netdevice represents a SyncE port, the user needs to understand
the connection between netdevice and associated DPLL pin. There might me
multiple netdevices pointing to the same pin, in case of VF/SF
implementation.

Add a IFLA Netlink attribute to nest the DPLL pin handle, similar to
how it is implemented for devlink port. Add a struct dpll_pin pointer
to netdev and protect access to it by RTNL. Expose netdev_dpll_pin_set()
and netdev_dpll_pin_clear() helpers to the drivers so they can set/clear
the DPLL pin relationship to netdev.

Note that during the lifetime of struct dpll_pin the pin handle does not
change. Therefore it is save to access it lockless. It is drivers
responsibility to call netdev_dpll_pin_clear() before dpll_pin_put().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
v5->v6:
- remove dpll.h from netdevice.h
- style fixes
v2->v5:
- rebase on top of net-next
v1->v2:
- fix checkpatch errors

 drivers/dpll/dpll_netlink.c  | 16 ++++++++++++++--
 include/linux/dpll.h         | 15 +++++++++++++++
 include/linux/netdevice.h    | 21 +++++++++++++++++++++
 include/uapi/linux/if_link.h |  2 +-
 net/core/dev.c               | 22 ++++++++++++++++++++++
 net/core/rtnetlink.c         | 36 ++++++++++++++++++++++++++++++++++++
 6 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 9464a6865977..764437a0661b 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -47,6 +47,18 @@ dpll_msg_add_dev_parent_handle(struct sk_buff *msg, u32 id)
 	return 0;
 }
 
+/**
+ * dpll_msg_pin_handle_size - get size of pin handle attribute for given pin
+ * @pin: pin pointer
+ *
+ * Return: byte size of pin handle attribute for given pin.
+ */
+size_t dpll_msg_pin_handle_size(struct dpll_pin *pin)
+{
+	return pin ? nla_total_size(4) : 0; /* DPLL_A_PIN_ID */
+}
+EXPORT_SYMBOL_GPL(dpll_msg_pin_handle_size);
+
 /**
  * dpll_msg_add_pin_handle - attach pin handle attribute to a given message
  * @msg: pointer to sk_buff message to attach a pin handle
@@ -56,8 +68,7 @@ dpll_msg_add_dev_parent_handle(struct sk_buff *msg, u32 id)
  * * 0 - success
  * * -EMSGSIZE - no space in message to attach pin handle
  */
-static int
-dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
+int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
 {
 	if (!pin)
 		return 0;
@@ -65,6 +76,7 @@ dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
 		return -EMSGSIZE;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dpll_msg_add_pin_handle);
 
 static int
 dpll_msg_add_mode(struct sk_buff *msg, struct dpll_device *dpll,
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 2202310c10cd..bbc480cd2932 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -101,6 +101,21 @@ struct dpll_pin_properties {
 	struct dpll_pin_frequency *freq_supported;
 };
 
+#if IS_ENABLED(CONFIG_DPLL)
+size_t dpll_msg_pin_handle_size(struct dpll_pin *pin);
+int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin);
+#else
+static inline size_t dpll_msg_pin_handle_size(struct dpll_pin *pin)
+{
+	return 0;
+}
+
+static inline int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
+{
+	return 0;
+}
+#endif
+
 struct dpll_device *
 dpll_device_get(u64 clock_id, u32 dev_driver_id, struct module *module);
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0896aaa91dd7..db3d8429d50d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -79,6 +79,8 @@ struct xdp_buff;
 struct xdp_frame;
 struct xdp_metadata_ops;
 struct xdp_md;
+/* DPLL specific */
+struct dpll_pin;
 
 typedef u32 xdp_features_t;
 
@@ -2049,6 +2051,9 @@ enum netdev_ml_priv_type {
  *			SET_NETDEV_DEVLINK_PORT macro. This pointer is static
  *			during the time netdevice is registered.
  *
+ *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
+ *		   where the clock is recovered.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2405,6 +2410,10 @@ struct net_device {
 	struct rtnl_hw_stats64	*offload_xstats_l3;
 
 	struct devlink_port	*devlink_port;
+
+#if IS_ENABLED(CONFIG_DPLL)
+	struct dpll_pin		*dpll_pin;
+#endif
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
@@ -3940,6 +3949,18 @@ int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
 int dev_get_port_parent_id(struct net_device *dev,
 			   struct netdev_phys_item_id *ppid, bool recurse);
 bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);
+void netdev_dpll_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin);
+void netdev_dpll_pin_clear(struct net_device *dev);
+
+static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
+{
+#if IS_ENABLED(CONFIG_DPLL)
+	return dev->dpll_pin;
+#else
+	return NULL;
+#endif
+}
+
 struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again);
 struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 				    struct netdev_queue *txq, int *ret);
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index ce3117df9cec..fac351a93aed 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -376,7 +376,7 @@ enum {
 
 	IFLA_GSO_IPV4_MAX_SIZE,
 	IFLA_GRO_IPV4_MAX_SIZE,
-
+	IFLA_DPLL_PIN,
 	__IFLA_MAX
 };
 
diff --git a/net/core/dev.c b/net/core/dev.c
index ccff2b6ef958..cc03a5758d2d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9023,6 +9023,28 @@ bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b)
 }
 EXPORT_SYMBOL(netdev_port_same_parent_id);
 
+static void netdev_dpll_pin_assign(struct net_device *dev, struct dpll_pin *dpll_pin)
+{
+#if IS_ENABLED(CONFIG_DPLL)
+	rtnl_lock();
+	dev->dpll_pin = dpll_pin;
+	rtnl_unlock();
+#endif
+}
+
+void netdev_dpll_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin)
+{
+	WARN_ON(!dpll_pin);
+	netdev_dpll_pin_assign(dev, dpll_pin);
+}
+EXPORT_SYMBOL(netdev_dpll_pin_set);
+
+void netdev_dpll_pin_clear(struct net_device *dev)
+{
+	netdev_dpll_pin_assign(dev, NULL);
+}
+EXPORT_SYMBOL(netdev_dpll_pin_clear);
+
 /**
  *	dev_change_proto_down - set carrier according to proto_down.
  *
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 4a2ec33bfb51..7452a6d190c5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -57,6 +57,7 @@
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/addrconf.h>
 #endif
+#include <linux/dpll.h>
 
 #include "dev.h"
 
@@ -1055,6 +1056,15 @@ static size_t rtnl_devlink_port_size(const struct net_device *dev)
 	return size;
 }
 
+static size_t rtnl_dpll_pin_size(const struct net_device *dev)
+{
+	size_t size = nla_total_size(0); /* nest IFLA_DPLL_PIN */
+
+	size += dpll_msg_pin_handle_size(netdev_dpll_pin(dev));
+
+	return size;
+}
+
 static noinline size_t if_nlmsg_size(const struct net_device *dev,
 				     u32 ext_filter_mask)
 {
@@ -1111,6 +1121,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + rtnl_prop_list_size(dev)
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_PERM_ADDRESS */
 	       + rtnl_devlink_port_size(dev)
+	       + rtnl_dpll_pin_size(dev)
 	       + 0;
 }
 
@@ -1774,6 +1785,28 @@ static int rtnl_fill_devlink_port(struct sk_buff *skb,
 	return ret;
 }
 
+static int rtnl_fill_dpll_pin(struct sk_buff *skb,
+			      const struct net_device *dev)
+{
+	struct nlattr *dpll_pin_nest;
+	int ret;
+
+	dpll_pin_nest = nla_nest_start(skb, IFLA_DPLL_PIN);
+	if (!dpll_pin_nest)
+		return -EMSGSIZE;
+
+	ret = dpll_msg_add_pin_handle(skb, netdev_dpll_pin(dev));
+	if (ret < 0)
+		goto nest_cancel;
+
+	nla_nest_end(skb, dpll_pin_nest);
+	return 0;
+
+nest_cancel:
+	nla_nest_cancel(skb, dpll_pin_nest);
+	return ret;
+}
+
 static int rtnl_fill_ifinfo(struct sk_buff *skb,
 			    struct net_device *dev, struct net *src_net,
 			    int type, u32 pid, u32 seq, u32 change,
@@ -1916,6 +1949,9 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	if (rtnl_fill_devlink_port(skb, dev))
 		goto nla_put_failure;
 
+	if (rtnl_fill_dpll_pin(skb, dev))
+		goto nla_put_failure;
+
 	nlmsg_end(skb, nlh);
 	return 0;
 
-- 
2.27.0


