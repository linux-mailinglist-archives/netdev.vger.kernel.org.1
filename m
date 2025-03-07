Return-Path: <netdev+bounces-173061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26961A5708C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A88418988CF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B0B241687;
	Fri,  7 Mar 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcjZMgv0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0844241698
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372212; cv=none; b=BUh+QNwS8+M8vJKZf3PDXdzD7XApMViNtC7qLmFoELMcuydf62EtcUzwyVXK0Eio/Zbb3QsEF2BHY5oWBNlCIuvfnptFhWnK+6JD9gZIY697TTEnHFgYibgSW0tK92jLsr08Pq4wsW0s1Mj3QCFXfkq/T/WsZtUaJp6jfHnUKSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372212; c=relaxed/simple;
	bh=AFV7QwA+AGvBv0LmBHSeIyCTeCuGIiEDV77dHcoqa3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTUlAMdlslM1/obCC4j+dG+CwJQfw1HWuCMMbU+fJCHOlV3Xhc8Wyn/BXQiYSLPG0qdlvyIZXIcjFepuh/3WTGgQxFxPV/u8tmen8FLOal6E1raTF+TQgrn5KzkDAmH/3Gz2bgBc/t9haGg3dCuXwfLSN8HeCEYO1/xSzlfD1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcjZMgv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07522C4CED1;
	Fri,  7 Mar 2025 18:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741372211;
	bh=AFV7QwA+AGvBv0LmBHSeIyCTeCuGIiEDV77dHcoqa3w=;
	h=From:To:Cc:Subject:Date:From;
	b=UcjZMgv0IHOQgaDCxHED2segyoCR87yIdn8KREiS5/yg8TL2zobB6Ssm6S+nF0KTT
	 SRELujcVLmgTEp3fRQBEkCzDNfPeEzIEP35NDrJuphUzNGMKneI1L8T5cvZIXXPLqa
	 30eJEQMrCqeMckrc3Yty4XJuJ5Q1gjzPAAWtogSEhpLTxrXb37OGfiDNaXt2RzBOKQ
	 GNHxmsHn8lEO8tKJ+KPawcjLFYRm2FztefS1+eUJFHc8kcIorB+LArT4Ao5bb4+BQ3
	 7QtgD6GLnml+PyQ/J8wdgPgad8QSAx7EDWH/ZumYWdM3NL48DKANvUuGR45YbVLCZv
	 dskQn5EvrcFlQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: move misc netdev_lock flavors to a separate header
Date: Fri,  7 Mar 2025 10:30:06 -0800
Message-ID: <20250307183006.2312761-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the more esoteric helpers for netdev instance lock to
a dedicated header. This avoids growing netdevice.h to infinity
and makes rebuilding the kernel much faster (after touching
the header with the helpers).

The main netdev_lock() / netdev_unlock() functions are used
in static inlines in netdevice.h and will probably be used
most commonly, so keep them in netdevice.h.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h                     | 81 +----------------
 include/net/netdev_lock.h                     | 89 +++++++++++++++++++
 net/core/dev.h                                |  1 +
 drivers/net/bonding/bond_main.c               |  1 +
 drivers/net/dummy.c                           |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c |  1 +
 drivers/net/geneve.c                          |  1 +
 drivers/net/hyperv/netvsc_drv.c               |  1 +
 drivers/net/ipvlan/ipvlan_main.c              |  1 +
 drivers/net/loopback.c                        |  1 +
 drivers/net/macsec.c                          |  1 +
 drivers/net/macvlan.c                         |  1 +
 drivers/net/netdevsim/netdev.c                |  1 +
 drivers/net/ppp/ppp_generic.c                 |  1 +
 drivers/net/team/team_core.c                  |  1 +
 drivers/net/veth.c                            |  1 +
 drivers/net/vrf.c                             |  1 +
 drivers/net/vxlan/vxlan_core.c                |  1 +
 kernel/bpf/offload.c                          |  1 +
 net/8021q/vlan_dev.c                          |  1 +
 net/bluetooth/6lowpan.c                       |  1 +
 net/bridge/br_device.c                        |  2 +
 net/core/dev.c                                |  1 +
 net/core/dev_api.c                            |  2 +
 net/core/dev_ioctl.c                          |  1 +
 net/core/net-sysfs.c                          |  1 +
 net/core/rtnetlink.c                          |  1 +
 net/dsa/conduit.c                             |  1 +
 net/ethtool/cabletest.c                       |  1 +
 net/ethtool/cmis_fw_update.c                  |  1 +
 net/ethtool/features.c                        |  2 +
 net/ethtool/ioctl.c                           |  1 +
 net/ethtool/module.c                          |  1 +
 net/ethtool/netlink.c                         |  1 +
 net/ethtool/phy.c                             |  1 +
 net/ethtool/rss.c                             |  2 +
 net/ethtool/tsinfo.c                          |  1 +
 net/ieee802154/6lowpan/core.c                 |  1 +
 net/ipv4/ip_tunnel.c                          |  1 +
 net/ipv6/ip6_gre.c                            |  1 +
 net/ipv6/ip6_tunnel.c                         |  1 +
 net/ipv6/ip6_vti.c                            |  1 +
 net/ipv6/sit.c                                |  1 +
 net/l2tp/l2tp_eth.c                           |  1 +
 net/sched/sch_api.c                           |  1 +
 net/xdp/xsk.c                                 |  1 +
 net/xdp/xsk_buff_pool.c                       |  1 +
 50 files changed, 142 insertions(+), 80 deletions(-)
 create mode 100644 include/net/netdev_lock.h

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d206c9592b60..9a297757df7e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2630,40 +2630,6 @@ static inline void netdev_for_each_tx_queue(struct net_device *dev,
 		f(dev, &dev->_tx[i], arg);
 }
 
-static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
-				     const struct lockdep_map *b)
-{
-	/* Only lower devices currently grab the instance lock, so no
-	 * real ordering issues can occur. In the near future, only
-	 * hardware devices will grab instance lock which also does not
-	 * involve any ordering. Suppress lockdep ordering warnings
-	 * until (if) we start grabbing instance lock on pure SW
-	 * devices (bond/team/veth/etc).
-	 */
-	if (a == b)
-		return 0;
-	return -1;
-}
-
-#define netdev_lockdep_set_classes(dev)				\
-{								\
-	static struct lock_class_key qdisc_tx_busylock_key;	\
-	static struct lock_class_key qdisc_xmit_lock_key;	\
-	static struct lock_class_key dev_addr_list_lock_key;	\
-	static struct lock_class_key dev_instance_lock_key;	\
-	unsigned int i;						\
-								\
-	(dev)->qdisc_tx_busylock = &qdisc_tx_busylock_key;	\
-	lockdep_set_class(&(dev)->addr_list_lock,		\
-			  &dev_addr_list_lock_key);		\
-	lockdep_set_class(&(dev)->lock,				\
-			  &dev_instance_lock_key);		\
-	lock_set_cmp_fn(&dev->lock, netdev_lock_cmp_fn, NULL);	\
-	for (i = 0; i < (dev)->num_tx_queues; i++)		\
-		lockdep_set_class(&(dev)->_tx[i]._xmit_lock,	\
-				  &qdisc_xmit_lock_key);	\
-}
-
 u16 netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev);
 struct netdev_queue *netdev_core_pick_tx(struct net_device *dev,
@@ -2765,56 +2731,11 @@ static inline void netdev_lock(struct net_device *dev)
 	mutex_lock(&dev->lock);
 }
 
-static inline bool netdev_trylock(struct net_device *dev)
-{
-	return mutex_trylock(&dev->lock);
-}
-
 static inline void netdev_unlock(struct net_device *dev)
 {
 	mutex_unlock(&dev->lock);
 }
-
-static inline void netdev_assert_locked(struct net_device *dev)
-{
-	lockdep_assert_held(&dev->lock);
-}
-
-static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
-{
-	if (dev->reg_state == NETREG_REGISTERED ||
-	    dev->reg_state == NETREG_UNREGISTERING)
-		netdev_assert_locked(dev);
-}
-
-static inline bool netdev_need_ops_lock(struct net_device *dev)
-{
-	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
-
-#if IS_ENABLED(CONFIG_NET_SHAPER)
-	ret |= !!dev->netdev_ops->net_shaper_ops;
-#endif
-
-	return ret;
-}
-
-static inline void netdev_lock_ops(struct net_device *dev)
-{
-	if (netdev_need_ops_lock(dev))
-		netdev_lock(dev);
-}
-
-static inline void netdev_unlock_ops(struct net_device *dev)
-{
-	if (netdev_need_ops_lock(dev))
-		netdev_unlock(dev);
-}
-
-static inline void netdev_ops_assert_locked(struct net_device *dev)
-{
-	if (netdev_need_ops_lock(dev))
-		lockdep_assert_held(&dev->lock);
-}
+/* Additional netdev_lock()-related helpers are in net/netdev_lock.h */
 
 void netif_napi_set_irq_locked(struct napi_struct *napi, int irq);
 
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
new file mode 100644
index 000000000000..99631fbd7f54
--- /dev/null
+++ b/include/net/netdev_lock.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _NET_NETDEV_LOCK_H
+#define _NET_NETDEV_LOCK_H
+
+#include <linux/lockdep.h>
+#include <linux/netdevice.h>
+
+static inline bool netdev_trylock(struct net_device *dev)
+{
+	return mutex_trylock(&dev->lock);
+}
+
+static inline void netdev_assert_locked(struct net_device *dev)
+{
+	lockdep_assert_held(&dev->lock);
+}
+
+static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
+{
+	if (dev->reg_state == NETREG_REGISTERED ||
+	    dev->reg_state == NETREG_UNREGISTERING)
+		netdev_assert_locked(dev);
+}
+
+static inline bool netdev_need_ops_lock(struct net_device *dev)
+{
+	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
+
+#if IS_ENABLED(CONFIG_NET_SHAPER)
+	ret |= !!dev->netdev_ops->net_shaper_ops;
+#endif
+
+	return ret;
+}
+
+static inline void netdev_lock_ops(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		netdev_lock(dev);
+}
+
+static inline void netdev_unlock_ops(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		netdev_unlock(dev);
+}
+
+static inline void netdev_ops_assert_locked(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		lockdep_assert_held(&dev->lock);
+}
+
+static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
+				     const struct lockdep_map *b)
+{
+	/* Only lower devices currently grab the instance lock, so no
+	 * real ordering issues can occur. In the near future, only
+	 * hardware devices will grab instance lock which also does not
+	 * involve any ordering. Suppress lockdep ordering warnings
+	 * until (if) we start grabbing instance lock on pure SW
+	 * devices (bond/team/veth/etc).
+	 */
+	if (a == b)
+		return 0;
+	return -1;
+}
+
+#define netdev_lockdep_set_classes(dev)				\
+{								\
+	static struct lock_class_key qdisc_tx_busylock_key;	\
+	static struct lock_class_key qdisc_xmit_lock_key;	\
+	static struct lock_class_key dev_addr_list_lock_key;	\
+	static struct lock_class_key dev_instance_lock_key;	\
+	unsigned int i;						\
+								\
+	(dev)->qdisc_tx_busylock = &qdisc_tx_busylock_key;	\
+	lockdep_set_class(&(dev)->addr_list_lock,		\
+			  &dev_addr_list_lock_key);		\
+	lockdep_set_class(&(dev)->lock,				\
+			  &dev_instance_lock_key);		\
+	lock_set_cmp_fn(&dev->lock, netdev_lock_cmp_fn, NULL);	\
+	for (i = 0; i < (dev)->num_tx_queues; i++)		\
+		lockdep_set_class(&(dev)->_tx[i]._xmit_lock,	\
+				  &qdisc_xmit_lock_key);	\
+}
+
+#endif
diff --git a/net/core/dev.h b/net/core/dev.h
index b50ca645c086..0ddd3631acb0 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/rwsem.h>
 #include <linux/netdevice.h>
+#include <net/netdev_lock.h>
 
 struct net;
 struct netlink_ext_ack;
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index cf0b02720dd8..6c95f478ab80 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -90,6 +90,7 @@
 #include <net/tls.h>
 #endif
 #include <net/ip6_route.h>
+#include <net/netdev_lock.h>
 #include <net/xdp.h>
 
 #include "bonding_priv.h"
diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index 005d79975f3b..a4938c6a5ebb 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -38,6 +38,7 @@
 #include <linux/moduleparam.h>
 #include <linux/rtnetlink.h>
 #include <linux/net_tstamp.h>
+#include <net/netdev_lock.h>
 #include <net/rtnetlink.h>
 #include <linux/u64_stats_sync.h>
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1a1e6da77777..b09171110ec4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -54,6 +54,7 @@
 #include <net/pkt_cls.h>
 #include <net/page_pool/helpers.h>
 #include <linux/align.h>
+#include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 #include <linux/pci-tph.h>
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 0caf6e9bccb8..cf2b3ad75c9b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -15,6 +15,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/filter.h>
+#include <net/netdev_lock.h>
 #include <net/page_pool/helpers.h>
 #include "bnxt_hsi.h"
 #include "bnxt.h"
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 032e1a58af6f..6d7ba4d67a19 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include <linux/net/intel/libie/rx.h>
+#include <net/netdev_lock.h>
 
 #include "iavf.h"
 #include "iavf_ptp.h"
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 0411a1897f57..2d826077d38c 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -13,6 +13,7 @@
 
 #include <net/checksum.h>
 #include <net/ip6_checksum.h>
+#include <net/netdev_lock.h>
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
 
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 2c65f867fd31..66e38ce9cd1d 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -18,6 +18,7 @@
 #include <net/rtnetlink.h>
 #include <net/geneve.h>
 #include <net/gro.h>
+#include <net/netdev_lock.h>
 #include <net/protocol.h>
 
 #define GENEVE_NETDEV_VER	"0.6"
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 9c6501bf27bd..c51b318b8a72 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -29,6 +29,7 @@
 #include <linux/bpf.h>
 
 #include <net/arp.h>
+#include <net/netdev_lock.h>
 #include <net/route.h>
 #include <net/sock.h>
 #include <net/pkt_sched.h>
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index b56144ca2fde..0ed2fd833a5d 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -3,6 +3,7 @@
  */
 
 #include <linux/ethtool.h>
+#include <net/netdev_lock.h>
 
 #include "ipvlan.h"
 
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 201fddcd3b1e..1fb6ce6843ad 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -54,6 +54,7 @@
 #include <linux/percpu.h>
 #include <linux/net_tstamp.h>
 #include <net/net_namespace.h>
+#include <net/netdev_lock.h>
 #include <linux/u64_stats_sync.h>
 
 /* blackhole_netdev - a device used for dsts that are marked expired!
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 4de5d63fd577..3d315e30ee47 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -19,6 +19,7 @@
 #include <net/gro_cells.h>
 #include <net/macsec.h>
 #include <net/dst_metadata.h>
+#include <net/netdev_lock.h>
 #include <linux/phy.h>
 #include <linux/byteorder/generic.h>
 #include <linux/if_arp.h>
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 4e9d54be887c..d0dfa6bca6cc 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -28,6 +28,7 @@
 #include <linux/if_macvlan.h>
 #include <linux/hash.h>
 #include <linux/workqueue.h>
+#include <net/netdev_lock.h>
 #include <net/rtnetlink.h>
 #include <net/xfrm.h>
 #include <linux/netpoll.h>
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 54d03b0628d2..d71fd2907cc8 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -25,6 +25,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/netlink.h>
 #include <net/net_shaper.h>
+#include <net/netdev_lock.h>
 #include <net/pkt_cls.h>
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index ca77661688c0..53463767cc43 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -45,6 +45,7 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/unaligned.h>
+#include <net/netdev_lock.h>
 #include <net/slhc_vj.h>
 #include <linux/atomic.h>
 #include <linux/refcount.h>
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index fb917560d0a2..d8fc0c79745d 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -23,6 +23,7 @@
 #include <linux/rtnetlink.h>
 #include <net/rtnetlink.h>
 #include <net/genetlink.h>
+#include <net/netdev_lock.h>
 #include <net/netlink.h>
 #include <net/sch_generic.h>
 #include <linux/if_team.h>
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 05f5eeef539f..7bb53961c0ea 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -17,6 +17,7 @@
 
 #include <net/rtnetlink.h>
 #include <net/dst.h>
+#include <net/netdev_lock.h>
 #include <net/xfrm.h>
 #include <net/xdp.h>
 #include <linux/veth.h>
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 36cf6191335e..7168b33adadb 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -34,6 +34,7 @@
 #include <net/addrconf.h>
 #include <net/l3mdev.h>
 #include <net/fib_rules.h>
+#include <net/netdev_lock.h>
 #include <net/sch_generic.h>
 #include <net/netns/generic.h>
 #include <net/netfilter/nf_conntrack.h>
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 227d7f5a302a..8c49e903cb3a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -25,6 +25,7 @@
 #include <net/inet_ecn.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/netdev_lock.h>
 #include <net/tun_proto.h>
 #include <net/vxlan.h>
 #include <net/nexthop.h>
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index a10153c3be2d..ba2f40a0fbe2 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -25,6 +25,7 @@
 #include <linux/rhashtable.h>
 #include <linux/rtnetlink.h>
 #include <linux/rwsem.h>
+#include <net/netdev_lock.h>
 #include <net/xdp.h>
 
 /* Protects offdevs, members of bpf_offload_netdev and offload members
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index ee3283400716..770a4dcf7f63 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -27,6 +27,7 @@
 #include <linux/phy.h>
 #include <net/arp.h>
 #include <net/macsec.h>
+#include <net/netdev_lock.h>
 
 #include "vlan.h"
 #include "vlanproc.h"
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 50cfec8ccac4..1298c8685bad 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -13,6 +13,7 @@
 #include <net/ipv6.h>
 #include <net/ip6_route.h>
 #include <net/addrconf.h>
+#include <net/netdev_lock.h>
 #include <net/pkt_sched.h>
 
 #include <net/bluetooth/bluetooth.h>
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 9d8c72ed01ab..a818fdc22da9 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -16,6 +16,8 @@
 #include <linux/netfilter_bridge.h>
 
 #include <linux/uaccess.h>
+#include <net/netdev_lock.h>
+
 #include "br_private.h"
 
 #define COMMON_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA | \
diff --git a/net/core/dev.c b/net/core/dev.c
index a0f75a1d1f5a..1cb134ff7327 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -156,6 +156,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
+#include <net/netdev_lock.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 655a95fb7baa..1f0e24849bc6 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+
 #include <linux/netdevice.h>
+#include <net/netdev_lock.h>
 
 #include "dev.h"
 
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 296e52d1395d..5471cf4fc984 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -10,6 +10,7 @@
 #include <linux/wireless.h>
 #include <linux/if_bridge.h>
 #include <net/dsa_stubs.h>
+#include <net/netdev_lock.h>
 #include <net/wext.h>
 
 #include "dev.h"
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 02d1d40b47ae..529a0f721268 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/cpu.h>
+#include <net/netdev_lock.h>
 #include <net/netdev_rx_queue.h>
 #include <net/rps.h>
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 88a352b02bce..90597bf84e3d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -53,6 +53,7 @@
 #include <net/fib_rules.h>
 #include <net/rtnetlink.h>
 #include <net/net_namespace.h>
+#include <net/netdev_lock.h>
 #include <net/devlink.h>
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/addrconf.h>
diff --git a/net/dsa/conduit.c b/net/dsa/conduit.c
index f21bb2551bed..4ae255cfb23f 100644
--- a/net/dsa/conduit.c
+++ b/net/dsa/conduit.c
@@ -10,6 +10,7 @@
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <net/dsa.h>
+#include <net/netdev_lock.h>
 
 #include "conduit.h"
 #include "dsa.h"
diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index ddcba073321f..0364b8fb577b 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -2,6 +2,7 @@
 
 #include <linux/phy.h>
 #include <linux/ethtool_netlink.h>
+#include <net/netdev_lock.h>
 #include "netlink.h"
 #include "common.h"
 
diff --git a/net/ethtool/cmis_fw_update.c b/net/ethtool/cmis_fw_update.c
index 946830af3e7c..df5f344209c4 100644
--- a/net/ethtool/cmis_fw_update.c
+++ b/net/ethtool/cmis_fw_update.c
@@ -2,6 +2,7 @@
 
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
+#include <net/netdev_lock.h>
 
 #include "common.h"
 #include "module_fw.h"
diff --git a/net/ethtool/features.c b/net/ethtool/features.c
index ccffd64d5a87..f2217983be2b 100644
--- a/net/ethtool/features.c
+++ b/net/ethtool/features.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <net/netdev_lock.h>
+
 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 496a2774100c..221639407c72 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -31,6 +31,7 @@
 #include <net/ipv6.h>
 #include <net/xdp_sock_drv.h>
 #include <net/flow_offload.h>
+#include <net/netdev_lock.h>
 #include <linux/ethtool_netlink.h>
 #include "common.h"
 
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index d3d2e135e45e..4d4e0a82579a 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -4,6 +4,7 @@
 #include <linux/firmware.h>
 #include <linux/sfp.h>
 #include <net/devlink.h>
+#include <net/netdev_lock.h>
 
 #include "netlink.h"
 #include "common.h"
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 239b5252ed2a..78797862c1a7 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
 #include <net/sock.h>
 #include <linux/ethtool_netlink.h>
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index 1a6b725d1f14..1f590e8d75ed 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -9,6 +9,7 @@
 #include <linux/phy.h>
 #include <linux/phy_link_topology.h>
 #include <linux/sfp.h>
+#include <net/netdev_lock.h>
 
 struct phy_req_info {
 	struct ethnl_req_info		base;
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index ec41d1d7eefe..6d9b1769896b 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <net/netdev_lock.h>
+
 #include "netlink.h"
 #include "common.h"
 
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 73b6a89b8731..32204cca24da 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -4,6 +4,7 @@
 #include <linux/phy.h>
 #include <linux/phy_link_topology.h>
 #include <linux/ptp_clock_kernel.h>
+#include <net/netdev_lock.h>
 
 #include "netlink.h"
 #include "common.h"
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 9a9da74b0a4f..018929563c6b 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -50,6 +50,7 @@
 #include <linux/if_arp.h>
 
 #include <net/ipv6.h>
+#include <net/netdev_lock.h>
 
 #include "6lowpan_i.h"
 
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 4b06dc7e04f2..1024f961ec9a 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -40,6 +40,7 @@
 #include <net/xfrm.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/netdev_lock.h>
 #include <net/rtnetlink.h>
 #include <net/udp.h>
 #include <net/dst_metadata.h>
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index c6ebb6a6d390..957ca98fa70f 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -43,6 +43,7 @@
 #include <net/xfrm.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/netdev_lock.h>
 #include <net/rtnetlink.h>
 
 #include <net/ipv6.h>
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 170a6ac30889..a04dd1bb4b19 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -52,6 +52,7 @@
 #include <net/inet_ecn.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/netdev_lock.h>
 #include <net/dst_metadata.h>
 #include <net/inet_dscp.h>
 
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 83c055996fbb..09ec4b0ad7dc 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -45,6 +45,7 @@
 #include <net/xfrm.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/netdev_lock.h>
 #include <linux/etherdevice.h>
 
 #define IP6_VTI_HASH_SIZE_SHIFT  5
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 6f04703fe638..9a0f32acb750 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -51,6 +51,7 @@
 #include <net/dsfield.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/netdev_lock.h>
 #include <net/inet_dscp.h>
 
 /*
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index e83691073496..cf0b66f4fb29 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -25,6 +25,7 @@
 #include <net/xfrm.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/netdev_lock.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/udp.h>
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index f5101c2ffc66..abace7665cfe 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/hashtable.h>
 
+#include <net/netdev_lock.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
 #include <net/netlink.h>
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f864e5d70b40..e5d104ce7b82 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -25,6 +25,7 @@
 #include <linux/vmalloc.h>
 #include <net/xdp_sock_drv.h>
 #include <net/busy_poll.h>
+#include <net/netdev_lock.h>
 #include <net/netdev_rx_queue.h>
 #include <net/xdp.h>
 
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 0e6ca568fdee..14716ad3d7bc 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/netdevice.h>
+#include <net/netdev_lock.h>
 #include <net/xsk_buff_pool.h>
 #include <net/xdp_sock.h>
 #include <net/xdp_sock_drv.h>
-- 
2.48.1


