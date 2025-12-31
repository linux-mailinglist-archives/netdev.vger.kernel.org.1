Return-Path: <netdev+bounces-246400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22576CEB341
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 04:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7A16300E797
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 03:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02E62E4263;
	Wed, 31 Dec 2025 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wpFHrjKO"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09171DF27F;
	Wed, 31 Dec 2025 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767152643; cv=none; b=LdYwDgAzs+ocQJwvBadvn+1XFSNPqCQazT0hIcdt/DrEb5SQSsiADTX4MCb73AZ31gNZY2ufqw4nVsvmoHlQ4I5sVoE/FLcqo68THHiliNeBOIkud6afbKnnWTZRgHnpR6I/XRzXi33xSnufrTn8XFbYzTTznreXZseKaqU6L5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767152643; c=relaxed/simple;
	bh=SRhvHenXPlYX/SKh/bBvEoxLFhDnQDe2TouBglOqZfs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=naP3CsEafkZGI0/bxtTPnOSz2RL/gQEiWcad8OShTbCqOzQT7zf1FGuwz0lVq3kRER9L9fypaNGcoudGop3OF8UqI9f0t4yuRmiAM4ZO0eroTaynWlrQJnWyd54/zZs5H2wZJnM+Eh3ymfLuwxua7n50CXBtYZLuq1wTfInPIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wpFHrjKO; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MzgrMvQDWZkLvC8U6+ga/s9XsxBhURpjlisbFbw7l70=;
	b=wpFHrjKO29Ta+Xx62RWJl9gUvsINAF/RylDXkOxUfPOQh1zFGu6Daegw4lWnAUIPW3rG4SIMg
	XxsfSrVklEjrnF2x1iPLB94ZckeTqyQikMVA92ypZ/lewNwdR7vi+lNf1mGeFZaf+G0cXPQRx28
	+HoY82w71AXvTcKiUyoj9iM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dgwhq299SznTXY;
	Wed, 31 Dec 2025 11:40:43 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id BC001402AB;
	Wed, 31 Dec 2025 11:43:51 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemk500008.china.huawei.com
 (7.202.194.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 11:43:51 +0800
From: Chen Zhen <chenzhen126@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<huyizhen2@huawei.com>, <gaoxingwang1@huawei.com>
Subject: [PATCH net] net: vlan: set header_ops to match hard_header_len when hw offload is toggled
Date: Wed, 31 Dec 2025 11:54:19 +0800
Message-ID: <20251231035419.23422-1-chenzhen126@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500008.china.huawei.com (7.202.194.93)

We found a skb_panic in vlan_dev_hard_header():

skbuff: skb_under_panic: text:ffffffff95b33e66 len:90 put:14 head:ffff915ac1967440 data:ffff915ac196743e tail:0x58 end:0x180 dev:br0.10
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:197!
Call Trace:
 <TASK>
 skb_push+0x39/0x40
 eth_header+0x26/0xb0
 vlan_dev_hard_header+0x58/0x130 [8021q]
 neigh_connected_output+0xae/0x100
 ip6_finish_output2+0x2cc/0x650
 ? nf_hook_slow+0x41/0xc0
 ip6_finish_output+0x27/0xd0
 ndisc_send_skb+0x1d0/0x370
 ? __pfx_dst_output+0x10/0x10
 ndisc_send_ns+0x5a/0xb0
 addrconf_dad_work+0x2b5/0x380
 process_one_work+0x17f/0x320
 worker_thread+0x26d/0x2f0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xcc/0x100
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x30/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

This bug can be easily reproduced by these steps:

 ip link add veth0 type veth peer name veth1
 ip link set veth0 up
 ip link set veth1 up
 ethtool -K veth0 tx-vlan-hw-insert off
 # vlandev.header_ops = vlan_header_ops, hard_header_len = 18(hard_header_len + VLAN_HLEN)
 ip link add link veth0 name veth0.10 type vlan id 10 reorder_hdr off
 ip addr add 192.168.10.1/24 dev veth0.10
 ip link set veth0.10 up
 # vlandev.hard_header_len = 14(hard_header_len)
 ethtool -K veth0 tx-vlan-hw-insert on
 # Panic!

The reason is that when NETIF_F_HW_VLAN_CTAG_TX is off, vlandev.hard_header_len will be set to
dev->hard_header_len since commit 029f5fc31cdb ("8021q: set hard_header_len when VLAN offload features
are toggled"), but the header_ops remains unchanged. Then neigh_connected_output() will call
vlan_dev_hard_header() and panic in skb_push() because reorder_hdr is off.

Fix this by also setting header_ops of vlan dev when offload feature is toggled.

Fixes: 029f5fc31cdb ("8021q: set hard_header_len when VLAN offload features are toggled")
Signed-off-by: Chen Zhen <chenzhen126@huawei.com>
---
 net/8021q/vlan.c     |  5 +----
 net/8021q/vlan.h     |  3 +++
 net/8021q/vlan_dev.c | 22 ++++++++++++++--------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 2b74ed56eb16..84b3a3f67996 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -323,10 +323,7 @@ static void vlan_transfer_features(struct net_device *dev,
 
 	netif_inherit_tso_max(vlandev, dev);
 
-	if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
-		vlandev->hard_header_len = dev->hard_header_len;
-	else
-		vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
+	vlan_dev_set_header_attributes(dev, vlandev, vlan->vlan_proto);
 
 #if IS_ENABLED(CONFIG_FCOE)
 	vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index c7ffe591d593..1d837814e061 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -143,6 +143,9 @@ int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack);
 void unregister_vlan_dev(struct net_device *dev, struct list_head *head);
 bool vlan_dev_inherit_address(struct net_device *dev,
 			      struct net_device *real_dev);
+void vlan_dev_set_header_attributes(struct net_device *dev,
+				    struct net_device *vlan_dev,
+				    __be16 proto);
 
 static inline u32 vlan_get_ingress_priority(struct net_device *dev,
 					    u16 vlan_tci)
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index fbf296137b09..1fe171748711 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -519,6 +519,19 @@ static const struct device_type vlan_type = {
 
 static const struct net_device_ops vlan_netdev_ops;
 
+void vlan_dev_set_header_attributes(struct net_device *dev,
+				    struct net_device *vlan_dev,
+				    __be16 proto)
+{
+	if (vlan_hw_offload_capable(dev->features, proto)) {
+		vlan_dev->header_ops      = &vlan_passthru_header_ops;
+		vlan_dev->hard_header_len = dev->hard_header_len;
+	} else {
+		vlan_dev->header_ops      = &vlan_header_ops;
+		vlan_dev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
+	}
+}
+
 static int vlan_dev_init(struct net_device *dev)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
@@ -572,14 +585,7 @@ static int vlan_dev_init(struct net_device *dev)
 #endif
 
 	dev->needed_headroom = real_dev->needed_headroom;
-	if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) {
-		dev->header_ops      = &vlan_passthru_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len;
-	} else {
-		dev->header_ops      = &vlan_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
-	}
-
+	vlan_dev_set_header_attributes(real_dev, dev, vlan->vlan_proto);
 	dev->netdev_ops = &vlan_netdev_ops;
 
 	SET_NETDEV_DEVTYPE(dev, &vlan_type);
-- 
2.33.0


