Return-Path: <netdev+bounces-55535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC29780B367
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557E81F210E6
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 09:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BA6D519;
	Sat,  9 Dec 2023 09:17:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2CA10E6
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 01:17:46 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SnMq80HGGzsRxB;
	Sat,  9 Dec 2023 17:17:40 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 9 Dec
 2023 17:17:41 +0800
From: Liu Jian <liujian56@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <vladimir.oltean@nxp.com>,
	<andrew@lunn.ch>, <d-tatianin@yandex-team.ru>, <justin.chen@broadcom.com>,
	<rkannoth@marvell.com>, <idosch@nvidia.com>, <jdamato@fastly.com>,
	<netdev@vger.kernel.org>
CC: <liujian56@huawei.com>
Subject: [PATCH next] net: update the vlan filter info synchronously when modifying the features of netdev
Date: Sat, 9 Dec 2023 17:29:21 +0800
Message-ID: <20231209092921.1454609-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected

I got the bleow warning trace:

WARNING: CPU: 4 PID: 4056 at net/core/dev.c:11066 unregister_netdevice_many_notify
CPU: 4 PID: 4056 Comm: ip Not tainted 6.7.0-rc4+ #15
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
RIP: 0010:unregister_netdevice_many_notify+0x9a4/0x9b0
Call Trace:
 rtnl_dellink
 rtnetlink_rcv_msg
 netlink_rcv_skb
 netlink_unicast
 netlink_sendmsg
 __sock_sendmsg
 ____sys_sendmsg
 ___sys_sendmsg
 __sys_sendmsg
 do_syscall_64
 entry_SYSCALL_64_after_hwframe

It can be repoduced via:

    ip netns add ns1
    ip netns exec ns1 ip link add bond0 type bond mode 0
    ip netns exec ns1 ip link add bond_slave_1 type veth peer veth2
    ip netns exec ns1 ip link set bond_slave_1 master bond0
[1] ip netns exec ns1 ethtool -K bond0 rx-vlan-filter off
[2] ip netns exec ns1 ip link add link bond_slave_1 name bond_slave_1.0 type vlan id 0
[3] ip netns exec ns1 ip link add link bond0 name bond0.0 type vlan id 0
[4] ip netns exec ns1 ip link set bond_slave_1 nomaster
[5] ip netns exec ns1 ip link del veth2
    ip netns del ns1

This is all caused by command [1] turning off the rx-vlan-filter function
of bond0. The reason is the same as commit 01f4fd270870 ("bonding: Fix
incorrect deletion of ETH_P_8021AD protocol vid from slaves"). Commands
[2] [3] add the same vid to slave and master respectively, causing
command [4] to empty slave->vlan_info. The following command [5] triggers
this problem.

To fix the problem, we could update the vlan filter information
synchronously when modifying the features of netdev.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 net/8021q/vlan_core.c  | 21 ++++++++++++++++++++-
 net/ethtool/features.c | 19 ++++++++++++++++++-
 net/ethtool/ioctl.c    | 18 +++++++++++++++++-
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 0beb44f2fe1f..e94b509386bb 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -407,6 +407,12 @@ int vlan_vids_add_by_dev(struct net_device *dev,
 		return 0;
 
 	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
+		if (!(by_dev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+		    vid_info->proto == htons(ETH_P_8021Q))
+			continue;
+		if (!(by_dev->features & NETIF_F_HW_VLAN_STAG_FILTER) &&
+		    vid_info->proto == htons(ETH_P_8021AD))
+			continue;
 		err = vlan_vid_add(dev, vid_info->proto, vid_info->vid);
 		if (err)
 			goto unwind;
@@ -417,6 +423,12 @@ int vlan_vids_add_by_dev(struct net_device *dev,
 	list_for_each_entry_continue_reverse(vid_info,
 					     &vlan_info->vid_list,
 					     list) {
+		if (!(by_dev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+		    vid_info->proto == htons(ETH_P_8021Q))
+			continue;
+		if (!(by_dev->features & NETIF_F_HW_VLAN_STAG_FILTER) &&
+		    vid_info->proto == htons(ETH_P_8021AD))
+			continue;
 		vlan_vid_del(dev, vid_info->proto, vid_info->vid);
 	}
 
@@ -436,8 +448,15 @@ void vlan_vids_del_by_dev(struct net_device *dev,
 	if (!vlan_info)
 		return;
 
-	list_for_each_entry(vid_info, &vlan_info->vid_list, list)
+	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
+		if (!(by_dev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+		    vid_info->proto == htons(ETH_P_8021Q))
+			continue;
+		if (!(by_dev->features & NETIF_F_HW_VLAN_STAG_FILTER) &&
+		    vid_info->proto == htons(ETH_P_8021AD))
+			continue;
 		vlan_vid_del(dev, vid_info->proto, vid_info->vid);
+	}
 }
 EXPORT_SYMBOL(vlan_vids_del_by_dev);
 
diff --git a/net/ethtool/features.c b/net/ethtool/features.c
index a79af8c25a07..dee6d17c5b50 100644
--- a/net/ethtool/features.c
+++ b/net/ethtool/features.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/if_vlan.h>
 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"
@@ -278,8 +279,24 @@ int ethnl_set_features(struct sk_buff *skb, struct genl_info *info)
 					  wanted_diff_mask, new_active,
 					  active_diff_mask, compact);
 	}
-	if (mod)
+	if (mod) {
+		bitmap_xor(active_diff_mask, old_active, new_active,
+			   NETDEV_FEATURE_COUNT);
+		if (test_bit(NETIF_F_HW_VLAN_CTAG_FILTER_BIT, active_diff_mask)) {
+			if (test_bit(NETIF_F_HW_VLAN_CTAG_FILTER_BIT, new_active))
+				vlan_get_rx_ctag_filter_info(dev);
+			else
+				vlan_drop_rx_ctag_filter_info(dev);
+		}
+		if (test_bit(NETIF_F_HW_VLAN_STAG_FILTER_BIT, active_diff_mask)) {
+			if (test_bit(NETIF_F_HW_VLAN_STAG_FILTER_BIT, new_active))
+				vlan_get_rx_stag_filter_info(dev);
+			else
+				vlan_drop_rx_stag_filter_info(dev);
+		}
+
 		netdev_features_change(dev);
+	}
 
 out_rtnl:
 	rtnl_unlock();
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b0ce4f81c01..df7f65ca10b2 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3055,8 +3055,24 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 	if (dev->ethtool_ops->complete)
 		dev->ethtool_ops->complete(dev);
 
-	if (old_features != dev->features)
+	if (old_features != dev->features) {
+		netdev_features_t diff = old_features ^ dev->features;
+
+		if (diff & NETIF_F_HW_VLAN_CTAG_FILTER) {
+			if (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+				vlan_get_rx_ctag_filter_info(dev);
+			else
+				vlan_drop_rx_ctag_filter_info(dev);
+		}
+		if (diff & NETIF_F_HW_VLAN_STAG_FILTER) {
+			if (dev->features & NETIF_F_HW_VLAN_STAG_FILTER)
+				vlan_get_rx_stag_filter_info(dev);
+			else
+				vlan_drop_rx_stag_filter_info(dev);
+		}
+
 		netdev_features_change(dev);
+	}
 out:
 	if (dev->dev.parent)
 		pm_runtime_put(dev->dev.parent);
-- 
2.34.1


