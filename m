Return-Path: <netdev+bounces-248907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE623D10F85
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 08:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2D1F304B952
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F365336ECE;
	Mon, 12 Jan 2026 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qU1fpsC8"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63CC30DD22;
	Mon, 12 Jan 2026 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204188; cv=none; b=MDSo8eAs8gabwxiNo54gGWKXyb417f/ao5Qi1FUh+PIc5vSmIQchKqaXJbTD3j6FfztxiYysYtdyNVS2Bb2OH4YiN/bf6VtGMKXklzMhg1hFQ2LyX5iltS7czspJLsLxFNvZfC1OAQliw9Xhm4xxXBosmJLcD0CMsYJ2gIldZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204188; c=relaxed/simple;
	bh=qmyB7N6I0xeiPujp8TaTDmTfRROiTahcPelzRdpx0Mc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dI2KJCsVmJfnFnG1pmqO0Xvq40AfUQzvjsdMxeBpM2hswt/u2JN44WL4KSlZOhd6CUPyj6oxzVKm+m1ftherNOnS8/hliAIgJjMFhPJ5lnvKtFGOowN1F2RNQJFmy0lvxFedwci2iT3KgUiHVknuIPaAE0N0zxx+bYQlAxU7HmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qU1fpsC8; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lkkbEw8LDu9WgfulVf1h0ApMz+3GYhxe1OQFoYYVI4w=;
	b=qU1fpsC8C2S46V9gu4u0ADQBY9f1DTW+sQW8xw0EPeCtk8dI3IEZUZn2jRkeh5uCiLXZch3gI
	jmR2sGuxQgRVe5QzULM92rNkUD/zOygurV8tEqxEP+g74+s+XdJWITiYakOcwQZjFsLPnofiGEj
	CrVKpyBu5JMU2mwUoTczf7g=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dqPb01Vj3z12LfR;
	Mon, 12 Jan 2026 15:46:36 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D9A340569;
	Mon, 12 Jan 2026 15:49:37 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemk500008.china.huawei.com
 (7.202.194.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 12 Jan
 2026 15:49:36 +0800
From: Chen Zhen <chenzhen126@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<huyizhen2@huawei.com>, <gaoxingwang1@huawei.com>
Subject: [PATCH v3 net 1/2] net: vlan: set header_ops to match hard_header_len when hw offload is toggled
Date: Mon, 12 Jan 2026 15:59:38 +0800
Message-ID: <20260112075939.2509397-2-chenzhen126@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260112075939.2509397-1-chenzhen126@huawei.com>
References: <20260112075939.2509397-1-chenzhen126@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500008.china.huawei.com (7.202.194.93)

When tx-vlan-hw-insert is toggled to on, vlan device hard_header_len
will be reduced to dev->hard_header_len since commit 029f5fc31cdb
("8021q: set hard_header_len when VLAN offload features are toggled"),
but the header_ops remains unchanged, ndisc skb will be allocated
with this len and filled in vlan hdr in vlan_dev_hard_header(), but
with reorder_hdr off, the skb room is not enough so it triggers
skb_panic() as below:

skbuff: skb_under_panic: text:ffffffffa0535126 len:90 put:14
 head:ffff916c04232ec0 data:ffff916c04232ebe tail:0x58 end:0x180 dev:veth0.10
------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:197!
 <TASK>
  skb_push+0x39/0x40 net/core/skbuff.c:207
  eth_header+0x26/0xb0 net/ethernet/eth.c:90
  vlan_dev_hard_header+0x58/0x130 net/8021q/vlan_dev.c:85 [8021q]
  neigh_connected_output+0xae/0x100 net/core/neighbour.c:1589
  ip6_finish_output2+0x2cc/0x650 net/ipv6/ip6_output.c:213
  ip6_finish_output+0x27/0xd0 net/ipv6/ip6_output.c:246
  ndisc_send_skb+0x1d0/0x370 net/ipv6/ndisc.c:516
  ndisc_send_ns+0x5a/0xb0 net/ipv6/ndisc.c:672
  addrconf_dad_work+0x2b5/0x380 net/ipv6/addrconf.c:4258
  process_one_work+0x17f/0x320 kernel/workqueue.c:2743

Fix this by also setting header_ops of vlan dev when offload feature
is toggled.

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


