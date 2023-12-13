Return-Path: <netdev+bounces-56703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA8B8108D9
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 04:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499341F219BF
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 03:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CA69471;
	Wed, 13 Dec 2023 03:55:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2119BC
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 19:55:15 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SqhT5553Mz1wnj5;
	Wed, 13 Dec 2023 11:55:05 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 78ECA1A0190;
	Wed, 13 Dec 2023 11:55:12 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Dec
 2023 11:55:11 +0800
From: Liu Jian <liujian56@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <vladimir.oltean@nxp.com>,
	<andrew@lunn.ch>, <d-tatianin@yandex-team.ru>, <justin.chen@broadcom.com>,
	<rkannoth@marvell.com>, <idosch@nvidia.com>, <jdamato@fastly.com>,
	<netdev@vger.kernel.org>
CC: <liujian56@huawei.com>
Subject: [PATCH net v2] net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()
Date: Wed, 13 Dec 2023 12:06:41 +0800
Message-ID: <20231213040641.2653812-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)

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

To fix this problem, we should add VLAN_FILTER feature checks in
vlan_vids_add_by_dev() and vlan_vids_del_by_dev() to prevent incorrect
addition or deletion of vlan_vid information.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
v1->v2: Modify patch title and commit message.
	Remove superfluous operations in ethtool/features.c and ioctl.c
 net/8021q/vlan_core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

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
 
-- 
2.34.1


