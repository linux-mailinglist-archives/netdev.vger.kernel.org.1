Return-Path: <netdev+bounces-150051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4D9E8BE9
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B7116268F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D80214A92;
	Mon,  9 Dec 2024 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="UNlF7iwv"
X-Original-To: netdev@vger.kernel.org
Received: from lf-1-33.ptr.blmpb.com (lf-1-33.ptr.blmpb.com [103.149.242.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEDD1C1F3B
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728356; cv=none; b=OXWEkaA11rwYaO8JAcOXlX4oum4wbgrBngFVBnpmFMj6FwI/3fSvOjJoJWDy2kWKrvsy8mSxLP5F9pV9meNk4ol5aX+6Z9BK6+EC2jQznI+bRJhTzgHc/aEQ3anrMX6sJ9OwXWLLTw/mNJzR8LFKzGb8MgpqXKMk4mYsRmJG/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728356; c=relaxed/simple;
	bh=hCKfUZMXEwrU+RIPlGBOhtIJgb9fz5y1F1h7XaplDu8=;
	h=Cc:To:Subject:Date:Message-Id:Mime-Version:Content-Type:From; b=AydUzFLXNlYYrUhCCDPv4DVW7zIiJca6vykaEqskwc1raJqv8TnIfYSs+4u0ttN2P+1MfDq/I8hTO+S1Z79+uUM8rDWdxjT/jdq4//27l/UxAmfP+4BV57DJLDldrVVKxoNhoqcDHkZ/iXOX9q/oCVPZmd9MTOJIEEuoF15OkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=UNlF7iwv; arc=none smtp.client-ip=103.149.242.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728279; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=sC3jUbXDML9qiiCbXtjwKioBp6i4I5GMyGQrdmAhigQ=;
 b=UNlF7iwvjgVzSks/5QVeAurWV1dbyTzJROymwXj9iwy2VtKni2rHp37Dibae+psGlaxS7+
 GJ1DrYclX+pb6K7zz2F8IPfVidXoOA+3M8dsF1uQdDtOq6htR56xMbm/2zSCm8dd59ZTq3
 VVmXSEUDiMSl8SiMNq31QFIDa0eR+WNuTv6l/LbQIe9dGfPYIuC0SW7f92sv6soxIGrNpa
 v+xVY1f6jodVhwXjOYwK9srf7t+JCW5RR/o7jf/ycqf+UHWbXiYivtEJ2GeJ/UGwNi/Gwq
 BlTSCcbUJP2408UnyZWR+gq/j/s0yoXkHrHkutTB/Akr1FrOYkcezSYUkokaZQ==
Content-Transfer-Encoding: 7bit
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
X-Original-From: Tian Xin <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267569815+37b291+vger.kernel.org+tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Subject: [PATCH 09/16] net-next/yunsilicon: Init net device
Date: Mon,  9 Dec 2024 15:10:54 +0800
Message-Id: <20241209071101.3392590-10-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:17 +0800
Content-Type: text/plain; charset=UTF-8
From: "Tian Xin" <tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1

From: Xin Tian <tianx@yunsilicon.com>

Initialize network device:
1. initialize hardware
2. configure network parameters

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   1 +
 .../yunsilicon/xsc/common/xsc_device.h        |  42 +++
 .../ethernet/yunsilicon/xsc/common/xsc_pp.h   |  38 ++
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 332 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |  36 +-
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  41 +++
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  48 +++
 7 files changed, 534 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_pp.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 5d2b28e2e..c4286df0d 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/if_vlan.h>
 #include "common/xsc_cmdq.h"
 
 extern uint xsc_debug_mask;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
new file mode 100644
index 000000000..1238cf7a6
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_DEVICE_H
+#define XSC_DEVICE_H
+
+enum xsc_traffic_types {
+	XSC_TT_IPV4,
+	XSC_TT_IPV4_TCP,
+	XSC_TT_IPV4_UDP,
+	XSC_TT_IPV6,
+	XSC_TT_IPV6_TCP,
+	XSC_TT_IPV6_UDP,
+	XSC_TT_IPV4_IPSEC_AH,
+	XSC_TT_IPV6_IPSEC_AH,
+	XSC_TT_IPV4_IPSEC_ESP,
+	XSC_TT_IPV6_IPSEC_ESP,
+	XSC_TT_ANY,
+	XSC_NUM_TT,
+};
+
+#define XSC_NUM_INDIR_TIRS XSC_NUM_TT
+
+enum {
+	XSC_L3_PROT_TYPE_IPV4	= 1 << 0,
+	XSC_L3_PROT_TYPE_IPV6	= 1 << 1,
+};
+
+enum {
+	XSC_L4_PROT_TYPE_TCP	= 1 << 0,
+	XSC_L4_PROT_TYPE_UDP	= 1 << 1,
+};
+
+struct xsc_tirc_config {
+	u8 l3_prot_type;
+	u8 l4_prot_type;
+	u32 rx_hash_fields;
+};
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_pp.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_pp.h
new file mode 100644
index 000000000..4ea86c3a2
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_pp.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_PP_H
+#define XSC_PP_H
+
+enum {
+	XSC_HASH_FIELD_SEL_SRC_IP	= 1 << 0,
+	XSC_HASH_FIELD_SEL_PROTO	= 1 << 1,
+	XSC_HASH_FIELD_SEL_DST_IP	= 1 << 2,
+	XSC_HASH_FIELD_SEL_SPORT	= 1 << 3,
+	XSC_HASH_FIELD_SEL_DPORT	= 1 << 4,
+	XSC_HASH_FIELD_SEL_SRC_IPV6	= 1 << 5,
+	XSC_HASH_FIELD_SEL_DST_IPV6	= 1 << 6,
+	XSC_HASH_FIELD_SEL_SPORT_V6	= 1 << 7,
+	XSC_HASH_FIELD_SEL_DPORT_V6	= 1 << 8,
+};
+
+#define XSC_HASH_IP		(XSC_HASH_FIELD_SEL_SRC_IP	|\
+				XSC_HASH_FIELD_SEL_DST_IP	|\
+				XSC_HASH_FIELD_SEL_PROTO)
+#define XSC_HASH_IP_PORTS	(XSC_HASH_FIELD_SEL_SRC_IP	|\
+				XSC_HASH_FIELD_SEL_DST_IP	|\
+				XSC_HASH_FIELD_SEL_SPORT	|\
+				XSC_HASH_FIELD_SEL_DPORT	|\
+				XSC_HASH_FIELD_SEL_PROTO)
+#define XSC_HASH_IP6		(XSC_HASH_FIELD_SEL_SRC_IPV6	|\
+				XSC_HASH_FIELD_SEL_DST_IPV6	|\
+				XSC_HASH_FIELD_SEL_PROTO)
+#define XSC_HASH_IP6_PORTS	(XSC_HASH_FIELD_SEL_SRC_IPV6	|\
+				XSC_HASH_FIELD_SEL_DST_IPV6	|\
+				XSC_HASH_FIELD_SEL_SPORT_V6	|\
+				XSC_HASH_FIELD_SEL_DPORT_V6	|\
+				XSC_HASH_FIELD_SEL_PROTO)
+
+#endif /* XSC_PP_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
index 243ec7ced..76bf62519 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -6,22 +6,334 @@
 #include <linux/reboot.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include "common/xsc_core.h"
+#include "common/xsc_driver.h"
+#include "common/xsc_device.h"
+#include "common/xsc_pp.h"
 #include "xsc_eth_common.h"
 #include "xsc_eth.h"
 
+static const struct xsc_tirc_config tirc_default_config[XSC_NUM_INDIR_TIRS] = {
+	[XSC_TT_IPV4] = {
+				.l3_prot_type = XSC_L3_PROT_TYPE_IPV4,
+				.l4_prot_type = 0,
+				.rx_hash_fields = XSC_HASH_IP,
+	},
+	[XSC_TT_IPV4_TCP] = {
+				.l3_prot_type = XSC_L3_PROT_TYPE_IPV4,
+				.l4_prot_type = XSC_L4_PROT_TYPE_TCP,
+				.rx_hash_fields = XSC_HASH_IP_PORTS,
+	},
+	[XSC_TT_IPV4_UDP] = {
+				.l3_prot_type = XSC_L3_PROT_TYPE_IPV4,
+				.l4_prot_type = XSC_L4_PROT_TYPE_UDP,
+				.rx_hash_fields = XSC_HASH_IP_PORTS,
+	},
+	[XSC_TT_IPV6] = {
+				.l3_prot_type = XSC_L3_PROT_TYPE_IPV6,
+				.l4_prot_type = 0,
+				.rx_hash_fields = XSC_HASH_IP6,
+	},
+	[XSC_TT_IPV6_TCP] = {
+				.l3_prot_type = XSC_L3_PROT_TYPE_IPV6,
+				.l4_prot_type = XSC_L4_PROT_TYPE_TCP,
+				.rx_hash_fields = XSC_HASH_IP6_PORTS,
+	},
+	[XSC_TT_IPV6_UDP] = {
+				.l3_prot_type = XSC_L3_PROT_TYPE_IPV6,
+				.l4_prot_type = XSC_L4_PROT_TYPE_UDP,
+				.rx_hash_fields = XSC_HASH_IP6_PORTS,
+	},
+};
+
+static int xsc_eth_close(struct net_device *netdev)
+{
+	return 0;
+}
+
 static int xsc_get_max_num_channels(struct xsc_core_device *xdev)
 {
 	return min_t(int, xdev->dev_res->eq_table.num_comp_vectors,
 		     XSC_ETH_MAX_NUM_CHANNELS);
 }
 
+static void xsc_build_default_indir_rqt(u32 *indirection_rqt, int len,
+				 int num_channels)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		indirection_rqt[i] = i % num_channels;
+}
+
+static void xsc_build_rss_params(struct xsc_rss_params *rss_params, u16 num_channels)
+{
+	enum xsc_traffic_types tt;
+
+	rss_params->hfunc = ETH_RSS_HASH_TOP;
+	netdev_rss_key_fill(rss_params->toeplitz_hash_key,
+			    sizeof(rss_params->toeplitz_hash_key));
+
+	xsc_build_default_indir_rqt(rss_params->indirection_rqt,
+				    XSC_INDIR_RQT_SIZE, num_channels);
+
+	for (tt = 0; tt < XSC_NUM_INDIR_TIRS; tt++) {
+		rss_params->rx_hash_fields[tt] =
+			tirc_default_config[tt].rx_hash_fields;
+	}
+	rss_params->rss_hash_tmpl = XSC_HASH_IP_PORTS | XSC_HASH_IP6_PORTS;
+}
+
+static void xsc_eth_build_nic_params(struct xsc_adapter *adapter, u32 ch_num, u32 tc_num)
+{
+	struct xsc_core_device *xdev = adapter->xdev;
+	struct xsc_eth_params *params = &adapter->nic_param;
+
+	params->mtu = SW_DEFAULT_MTU;
+	params->num_tc = tc_num;
+
+	params->comp_vectors = xdev->dev_res->eq_table.num_comp_vectors;
+	params->max_num_ch = ch_num;
+	params->num_channels = ch_num;
+
+	params->rq_max_size = BIT(xdev->caps.log_max_qp_depth);
+	params->sq_max_size = BIT(xdev->caps.log_max_qp_depth);
+	xsc_build_rss_params(&adapter->rss_param, adapter->nic_param.num_channels);
+
+	xsc_core_info(xdev, "mtu=%d, num_ch=%d(max=%d), num_tc=%d\n",
+		      params->mtu, params->num_channels,
+		      params->max_num_ch, params->num_tc);
+}
+
+static int xsc_eth_netdev_init(struct xsc_adapter *adapter)
+{
+	unsigned int node, tc, nch;
+
+	tc = adapter->nic_param.num_tc;
+	nch = adapter->nic_param.max_num_ch;
+	node = dev_to_node(adapter->dev);
+	adapter->txq2sq = kcalloc_node(nch * tc,
+				       sizeof(*adapter->txq2sq), GFP_KERNEL, node);
+	if (!adapter->txq2sq)
+		goto err_out;
+
+	adapter->workq = create_singlethread_workqueue("xsc_eth");
+	if (!adapter->workq)
+		goto err_free_priv;
+
+	netif_carrier_off(adapter->netdev);
+
+	return 0;
+
+err_free_priv:
+	kfree(adapter->txq2sq);
+err_out:
+	return -ENOMEM;
+}
+
+static const struct net_device_ops xsc_netdev_ops = {
+	// TBD
+};
+
+static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	/* Set up network device as normal. */
+	netdev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
+	netdev->netdev_ops = &xsc_netdev_ops;
+
+	netdev->min_mtu = SW_MIN_MTU;
+	netdev->max_mtu = SW_MAX_MTU;
+	/*mtu - macheaderlen - ipheaderlen should be aligned in 8B*/
+	netdev->mtu = SW_DEFAULT_MTU;
+
+	netdev->vlan_features |= NETIF_F_SG;
+	netdev->vlan_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;//NETIF_F_HW_CSUM;
+	netdev->vlan_features |= NETIF_F_GRO;
+	netdev->vlan_features |= NETIF_F_TSO;//NETIF_F_TSO_ECN
+	netdev->vlan_features |= NETIF_F_TSO6;
+
+	netdev->vlan_features |= NETIF_F_RXCSUM;
+	netdev->vlan_features |= NETIF_F_RXHASH;
+	netdev->vlan_features |= NETIF_F_GSO_PARTIAL;
+
+	netdev->hw_features = netdev->vlan_features;
+
+	netdev->features |= netdev->hw_features;
+	netdev->features |= NETIF_F_HIGHDMA;
+}
+
+static int xsc_eth_nic_init(struct xsc_adapter *adapter,
+			    void *rep_priv, u32 ch_num, u32 tc_num)
+{
+	int err = -1;
+
+	xsc_eth_build_nic_params(adapter, ch_num, tc_num);
+
+	err = xsc_eth_netdev_init(adapter);
+	if (err)
+		return err;
+
+	xsc_eth_build_nic_netdev(adapter);
+
+	return 0;
+}
+
+static void xsc_eth_nic_cleanup(struct xsc_adapter *adapter)
+{
+	destroy_workqueue(adapter->workq);
+	kfree(adapter->txq2sq);
+}
+
+static int xsc_eth_set_hw_mtu(struct xsc_core_device *dev, u16 mtu, u16 rx_buf_sz)
+{
+	struct xsc_set_mtu_mbox_in in;
+	struct xsc_set_mtu_mbox_out out;
+	int ret;
+
+	memset(&in, 0, sizeof(struct xsc_set_mtu_mbox_in));
+	memset(&out, 0, sizeof(struct xsc_set_mtu_mbox_out));
+
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_SET_MTU);
+	in.mtu = cpu_to_be16(mtu);
+	in.rx_buf_sz_min = cpu_to_be16(rx_buf_sz);
+	in.mac_port = dev->mac_port;
+
+	ret = xsc_cmd_exec(dev, &in, sizeof(struct xsc_set_mtu_mbox_in), &out,
+			   sizeof(struct xsc_set_mtu_mbox_out));
+	if (ret || out.hdr.status) {
+		xsc_core_err(dev, "failed to set hw_mtu=%u rx_buf_sz=%u, err=%d, status=%d\n",
+			     mtu, rx_buf_sz, ret, out.hdr.status);
+		ret = -ENOEXEC;
+	}
+
+	return ret;
+}
+
+static int xsc_eth_get_mac(struct xsc_core_device *dev, char *mac)
+{
+	struct xsc_query_eth_mac_mbox_out *out;
+	struct xsc_query_eth_mac_mbox_in in;
+	int err;
+
+	out = kzalloc(sizeof(*out), GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	memset(&in, 0, sizeof(in));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_QUERY_ETH_MAC);
+
+	err = xsc_cmd_exec(dev, &in, sizeof(in), out, sizeof(*out));
+	if (err || out->hdr.status) {
+		xsc_core_warn(dev, "get mac failed! err=%d, out.status=%u\n", err, out->hdr.status);
+		err = -ENOEXEC;
+		goto exit;
+	}
+
+	memcpy(mac, out->mac, 6);
+	xsc_core_dbg(dev, "get mac %02x:%02x:%02x:%02x:%02x:%02x\n",
+		     mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+
+exit:
+	kfree(out);
+
+	return err;
+}
+
+static void xsc_eth_l2_addr_init(struct xsc_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	char mac[6] = {0};
+	int ret = 0;
+
+	ret = xsc_eth_get_mac(adapter->xdev, mac);
+	if (ret) {
+		xsc_core_warn(adapter->xdev, "get mac failed %d, generate random mac...", ret);
+		eth_random_addr(mac);
+	}
+	dev_addr_mod(netdev, 0, mac, 6);
+
+	if (!is_valid_ether_addr(netdev->perm_addr))
+		memcpy(netdev->perm_addr, netdev->dev_addr, netdev->addr_len);
+}
+
+static int xsc_eth_nic_enable(struct xsc_adapter *adapter)
+{
+	struct xsc_core_device *xdev = adapter->xdev;
+
+	xsc_eth_l2_addr_init(adapter);
+
+	xsc_eth_set_hw_mtu(xdev, XSC_SW2HW_MTU(adapter->nic_param.mtu),
+			   XSC_SW2HW_RX_PKT_LEN(adapter->nic_param.mtu));
+
+	rtnl_lock();
+	netif_device_attach(adapter->netdev);
+	rtnl_unlock();
+
+	return 0;
+}
+
+static void xsc_eth_nic_disable(struct xsc_adapter *adapter)
+{
+	rtnl_lock();
+	if (netif_running(adapter->netdev))
+		xsc_eth_close(adapter->netdev);
+	netif_device_detach(adapter->netdev);
+	rtnl_unlock();
+}
+
+static int xsc_attach_netdev(struct xsc_adapter *adapter)
+{
+	int err = -1;
+
+	err = xsc_eth_nic_enable(adapter);
+	if (err)
+		return err;
+
+	xsc_core_info(adapter->xdev, "%s ok\n", __func__);
+	return 0;
+}
+
+static void xsc_detach_netdev(struct xsc_adapter *adapter)
+{
+	xsc_eth_nic_disable(adapter);
+
+	flush_workqueue(adapter->workq);
+	adapter->status = XSCALE_ETH_DRIVER_DETACH;
+}
+
+static int xsc_eth_attach(struct xsc_core_device *xdev, struct xsc_adapter *adapter)
+{
+	int err = -1;
+
+	if (netif_device_present(adapter->netdev))
+		return 0;
+
+	err = xsc_attach_netdev(adapter);
+	if (err)
+		return err;
+
+	xsc_core_info(adapter->xdev, "%s ok\n", __func__);
+	return 0;
+}
+
+static void xsc_eth_detach(struct xsc_core_device *xdev, struct xsc_adapter *adapter)
+{
+	if (!netif_device_present(adapter->netdev))
+		return;
+
+	xsc_detach_netdev(adapter);
+}
+
 static void *xsc_eth_add(struct xsc_core_device *xdev)
 {
 	int err = -1;
 	int num_chl, num_tc;
 	struct net_device *netdev;
 	struct xsc_adapter *adapter = NULL;
+	void *rep_priv = NULL;
 
 	num_chl = xsc_get_max_num_channels(xdev);
 	num_tc = xdev->caps.max_tc;
@@ -42,6 +354,19 @@ static void *xsc_eth_add(struct xsc_core_device *xdev)
 	adapter->xdev = (void *)xdev;
 	xdev->eth_priv = adapter;
 
+	err = xsc_eth_nic_init(adapter, rep_priv, num_chl, num_tc);
+	if (err) {
+		xsc_core_warn(xdev, "xsc_nic_init failed, num_ch=%d, num_tc=%d, err=%d\n",
+			      num_chl, num_tc, err);
+		goto err_free_netdev;
+	}
+
+	err = xsc_eth_attach(xdev, adapter);
+	if (err) {
+		xsc_core_warn(xdev, "xsc_eth_attach failed, err=%d\n", err);
+		goto err_cleanup_netdev;
+	}
+
 	err = register_netdev(netdev);
 	if (err) {
 		xsc_core_warn(xdev, "register_netdev failed, err=%d\n", err);
@@ -53,6 +378,10 @@ static void *xsc_eth_add(struct xsc_core_device *xdev)
 	return adapter;
 
 err_reg_netdev:
+	xsc_eth_detach(xdev, adapter);
+err_cleanup_netdev:
+	xsc_eth_nic_cleanup(adapter);
+err_free_netdev:
 	free_netdev(netdev);
 
 	return NULL;
@@ -133,3 +462,6 @@ static __exit void xsc_net_driver_exit(void)
 
 module_init(xsc_net_driver_init);
 module_exit(xsc_net_driver_exit);
+
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
index ba8e52d7f..f9bfaa27a 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
@@ -6,11 +6,39 @@
 #ifndef XSC_ETH_H
 #define XSC_ETH_H
 
+#include "common/xsc_device.h"
+#include "xsc_eth_common.h"
+
+enum {
+	XSCALE_ETH_DRIVER_INIT,
+	XSCALE_ETH_DRIVER_OK,
+	XSCALE_ETH_DRIVER_CLOSE,
+	XSCALE_ETH_DRIVER_DETACH,
+};
+
+struct xsc_rss_params {
+	u32	indirection_rqt[XSC_INDIR_RQT_SIZE];
+	u32	rx_hash_fields[XSC_NUM_INDIR_TIRS];
+	u8	toeplitz_hash_key[52];
+	u8	hfunc;
+	u32	rss_hash_tmpl;
+};
+
 struct xsc_adapter {
-	struct net_device *netdev;
-	struct pci_dev *pdev;
-	struct device *dev;
-	struct xsc_core_device *xdev;
+	struct net_device	*netdev;
+	struct pci_dev		*pdev;
+	struct device		*dev;
+	struct xsc_core_device	*xdev;
+
+	struct xsc_eth_params	nic_param;
+	struct xsc_rss_params	rss_param;
+
+	struct workqueue_struct		*workq;
+
+	struct xsc_sq		**txq2sq;
+
+	u32	status;
+	struct mutex	status_lock; // protect status
 };
 
 #endif /* XSC_ETH_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
index 8cc416783..63fb1fcf9 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -6,10 +6,51 @@
 #ifndef XSC_ETH_COMMON_H
 #define XSC_ETH_COMMON_H
 
+#define SW_MIN_MTU		64
+#define SW_DEFAULT_MTU		1500
+#define SW_MAX_MTU		9600
+
+#define XSC_ETH_HW_MTU_SEND	9800		/*need to obtain from hardware*/
+#define XSC_ETH_HW_MTU_RECV	9800		/*need to obtain from hardware*/
+#define XSC_SW2HW_MTU(mtu)	((mtu) + 14 + 4)
+#define XSC_SW2HW_FRAG_SIZE(mtu)	((mtu) + 14 + 8 + 4 + XSC_PPH_HEAD_LEN)
+#define XSC_SW2HW_RX_PKT_LEN(mtu)	((mtu) + 14 + 256)
+
 #define XSC_LOG_INDIR_RQT_SIZE		0x8
 
 #define XSC_INDIR_RQT_SIZE			BIT(XSC_LOG_INDIR_RQT_SIZE)
 #define XSC_ETH_MIN_NUM_CHANNELS	2
 #define XSC_ETH_MAX_NUM_CHANNELS	XSC_INDIR_RQT_SIZE
 
+struct xsc_eth_params {
+	u16	num_channels;
+	u16	max_num_ch;
+	u8	num_tc;
+	u32	mtu;
+	u32	hard_mtu;
+	u32	comp_vectors;
+	u32	sq_size;
+	u32	sq_max_size;
+	u8	rq_wq_type;
+	u32	rq_size;
+	u32	rq_max_size;
+	u32	rq_frags_size;
+
+	u16	num_rl_txqs;
+	u8	rx_cqe_compress_def;
+	u8	tunneled_offload_en;
+	u8	lro_en;
+	u8	tx_min_inline_mode;
+	u8	vlan_strip_disable;
+	u8	scatter_fcs_en;
+	u8	rx_dim_enabled;
+	u8	tx_dim_enabled;
+	u32	rx_dim_usecs_low;
+	u32	rx_dim_frames_low;
+	u32	tx_dim_usecs_low;
+	u32	tx_dim_frames_low;
+	u32	lro_timeout;
+	u32	pflags;
+};
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
new file mode 100644
index 000000000..b2c848995
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_QUEUE_H
+#define XSC_QUEUE_H
+
+#include "common/xsc_core.h"
+
+struct xsc_sq {
+	struct xsc_core_qp		cqp;
+	/* dirtied @completion */
+	u16                        cc;
+	u32                        dma_fifo_cc;
+
+	/* dirtied @xmit */
+	u16                        pc ____cacheline_aligned_in_smp;
+	u32                        dma_fifo_pc;
+
+	struct xsc_cq            cq;
+
+	/* read only */
+	struct xsc_wq_cyc         wq;
+	u32                        dma_fifo_mask;
+	struct xsc_sq_stats     *stats;
+	struct {
+		struct xsc_sq_dma         *dma_fifo;
+		struct xsc_tx_wqe_info    *wqe_info;
+	} db;
+	void __iomem              *uar_map;
+	struct netdev_queue       *txq;
+	u32                        sqn;
+	u16                        stop_room;
+
+	__be32                     mkey_be;
+	unsigned long              state;
+	unsigned int               hw_mtu;
+
+	/* control path */
+	struct xsc_wq_ctrl        wq_ctrl;
+	struct xsc_channel         *channel;
+	int                        ch_ix;
+	int                        txq_ix;
+	struct work_struct         recover_work;
+} ____cacheline_aligned_in_smp;
+
+#endif /* XSC_QUEUE_H */
-- 
2.43.0

