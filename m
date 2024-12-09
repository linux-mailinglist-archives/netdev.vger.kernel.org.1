Return-Path: <netdev+bounces-150050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5599E8BE2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2828E280FB1
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7799921504E;
	Mon,  9 Dec 2024 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="eiRXMKFy"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-31.ptr.blmpb.com (va-1-31.ptr.blmpb.com [209.127.230.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01FB214A65
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728307; cv=none; b=gqS9tsmnjDMcF/TIH89Jt9mM3wwtixw1kTGvwmBP/79H6Su7GwPJK3HKBVpWmab6LzRRSlehdenl2AwpnhPzmXeMAT8rVqgEn3HdOwLMr3hnDAbfAVW6MZl6gBHvKwnjPVbRzM0AG+Qw/P+YIuNCWaNHK9fy8omb+uCt/JPmt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728307; c=relaxed/simple;
	bh=t8B06qIPvAkDPE3YD7tqqJ9RjuiSYraiZoUcqb+WBNU=;
	h=Subject:Date:Mime-Version:To:Cc:Message-Id:Content-Type:From; b=YJPYWGL3V5hiRUoacgulg6gSkPLlAd4da6F7LFstn42o1ag9kIXY4BR7dQ2qVTN7/dJLGrmUvB94K3vnl9ALkTckvUERkWjx9GzZ+h7JoGAnBhOgCl5jcEIJjmFxEeBOsU8OLsPQmbV8yyu269dVJhy8YVJSWpNtEO9mSVHVdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=eiRXMKFy; arc=none smtp.client-ip=209.127.230.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728293; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ElHZvTtyJrgdo7GJ9wAgcGEevFDgFieFOA74zOPWEeI=;
 b=eiRXMKFykd3latE1JdIFCCY08WmxadI7prqXrMZFmqaA6i/IdyLbG75cvtD4BQiuf7/unO
 QlBmY32+yKyFFyWQ1VU3YR9G1gg93VULlJzz2s9SUb+bIgqNPlJrtlkZzJqy542HPa/5gs
 slXAyIvYuO/SwlyGaS7ak8g0sYZdLHX55PdaJGHskG+l+J/VPPlzREFdRXkmlCDTgKoBGV
 M2pNe0/WbVPyzlLx9j4LvHU/DbzCwmr3gAJ/o8WpAwNLdPEkJ0qAKU9+lTTXgurYg7mWma
 93G7O4uM2nCUPKuPjChxtshQcS0VzV3zv2hiYYumxtvIDL7hg3Bnzza1949pYQ==
Subject: [PATCH 16/16] net-next/yunsilicon: Add change mtu
Date: Mon,  9 Dec 2024 15:11:01 +0800
X-Mailer: git-send-email 2.25.1
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
Message-Id: <20241209071101.3392590-17-tianx@yunsilicon.com>
X-Original-From: Tian Xin <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
From: "Tian Xin" <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267569823+b2692f+vger.kernel.org+tianx@yunsilicon.com>

From: Xin Tian <tianx@yunsilicon.com>

Add ndo_change_mtu

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 235 ++++++++++++++++--
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |   2 +
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |   2 +-
 3 files changed, 213 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
index 1861b10a8..f749dca2f 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -1665,12 +1665,222 @@ static int xsc_eth_set_mac(struct net_device *netdev, void *addr)
 	return 0;
 }
 
+static void xsc_eth_rss_params_change(struct xsc_adapter *adapter, u32 change, void *modify)
+{
+	struct xsc_core_device *xdev = adapter->xdev;
+	struct xsc_rss_params *rss = &adapter->rss_param;
+	struct xsc_eth_params *params = &adapter->nic_param;
+	struct xsc_cmd_modify_nic_hca_mbox_in *in =
+		(struct xsc_cmd_modify_nic_hca_mbox_in *)modify;
+	u32 hash_field = 0;
+	int key_len;
+	u8 rss_caps_mask = 0;
+
+	if (xsc_get_user_mode(xdev))
+		return;
+
+	if (change & BIT(XSC_RSS_RXQ_DROP)) {
+		in->rss.rqn_base = cpu_to_be16(adapter->channels.rqn_base -
+				xdev->caps.raweth_rss_qp_id_base);
+		in->rss.rqn_num = 0;
+		rss_caps_mask |= BIT(XSC_RSS_RXQ_DROP);
+		goto rss_caps;
+	}
+
+	if (change & BIT(XSC_RSS_RXQ_UPDATE)) {
+		in->rss.rqn_base = cpu_to_be16(adapter->channels.rqn_base -
+				xdev->caps.raweth_rss_qp_id_base);
+		in->rss.rqn_num = cpu_to_be16(params->num_channels);
+		rss_caps_mask |= BIT(XSC_RSS_RXQ_UPDATE);
+	}
+
+	if (change & BIT(XSC_RSS_HASH_KEY_UPDATE)) {
+		key_len = min(sizeof(in->rss.hash_key), sizeof(rss->toeplitz_hash_key));
+		memcpy(&in->rss.hash_key, rss->toeplitz_hash_key, key_len);
+		rss_caps_mask |= BIT(XSC_RSS_HASH_KEY_UPDATE);
+	}
+
+	if (change & BIT(XSC_RSS_HASH_TEMP_UPDATE)) {
+		hash_field = rss->rx_hash_fields[XSC_TT_IPV4_TCP] |
+				rss->rx_hash_fields[XSC_TT_IPV6_TCP];
+		in->rss.hash_tmpl = cpu_to_be32(hash_field);
+		rss_caps_mask |= BIT(XSC_RSS_HASH_TEMP_UPDATE);
+	}
+
+	if (change & BIT(XSC_RSS_HASH_FUNC_UPDATE)) {
+		in->rss.hfunc = xsc_hash_func_type(rss->hfunc);
+		rss_caps_mask |= BIT(XSC_RSS_HASH_FUNC_UPDATE);
+	}
+
+rss_caps:
+	if (rss_caps_mask) {
+		in->rss.caps_mask = rss_caps_mask;
+		in->rss.rss_en = 1;
+		in->nic.caps_mask = cpu_to_be16(BIT(XSC_TBM_CAP_RSS));
+		in->nic.caps = in->nic.caps_mask;
+	}
+}
+
+static int xsc_eth_modify_nic_hca(struct xsc_adapter *adapter, u32 flags)
+{
+	struct xsc_core_device *xdev = adapter->xdev;
+	struct xsc_cmd_modify_nic_hca_mbox_in in = {};
+	struct xsc_cmd_modify_nic_hca_mbox_out out = {};
+	int err = 0;
+
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_MODIFY_NIC_HCA);
+
+	xsc_eth_rss_params_change(adapter, flags, &in);
+	if (in.rss.caps_mask) {
+		err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+		if (err || out.hdr.status) {
+			xsc_core_err(xdev, "failed!! err=%d, status=%u\n",
+				     err, out.hdr.status);
+			return -ENOEXEC;
+		}
+	}
+
+	return 0;
+}
+
+static int xsc_safe_switch_channels(struct xsc_adapter *adapter,
+				    xsc_eth_fp_preactivate preactivate)
+{
+	struct net_device *netdev = adapter->netdev;
+	int carrier_ok;
+	int ret = 0;
+
+	adapter->status = XSCALE_ETH_DRIVER_CLOSE;
+
+	carrier_ok = netif_carrier_ok(netdev);
+	netif_carrier_off(netdev);
+	ret = xsc_eth_modify_nic_hca(adapter, BIT(XSC_RSS_RXQ_DROP));
+	if (ret)
+		goto close_channels;
+
+	xsc_eth_deactivate_priv_channels(adapter);
+	xsc_eth_close_channels(adapter);
+
+	if (preactivate) {
+		ret = preactivate(adapter);
+		if (ret)
+			goto out;
+	}
+
+	ret = xsc_eth_open_channels(adapter);
+	if (ret)
+		goto close_channels;
+
+	xsc_eth_activate_priv_channels(adapter);
+	ret = xsc_eth_modify_nic_hca(adapter, BIT(XSC_RSS_RXQ_UPDATE));
+	if (ret)
+		goto close_channels;
+
+	adapter->status = XSCALE_ETH_DRIVER_OK;
+
+	goto out;
+
+close_channels:
+	xsc_eth_deactivate_priv_channels(adapter);
+	xsc_eth_close_channels(adapter);
+
+out:
+	if (carrier_ok)
+		netif_carrier_on(netdev);
+	xsc_core_dbg(adapter->xdev, "channels=%d, mtu=%d, err=%d\n",
+		     adapter->nic_param.num_channels,
+		     adapter->nic_param.mtu, ret);
+	return ret;
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
+static int xsc_eth_nic_mtu_changed(struct xsc_adapter *priv)
+{
+	u32 new_mtu = priv->nic_param.mtu;
+	int ret;
+
+	ret = xsc_eth_set_hw_mtu(priv->xdev, XSC_SW2HW_MTU(new_mtu),
+				 XSC_SW2HW_RX_PKT_LEN(new_mtu));
+
+	return ret;
+}
+
+static int xsc_eth_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	struct xsc_adapter *adapter = netdev_priv(netdev);
+	int old_mtu = netdev->mtu;
+	int ret = 0;
+	int max_buf_len = 0;
+
+	if (new_mtu > netdev->max_mtu || new_mtu < netdev->min_mtu) {
+		netdev_err(netdev, "%s: Bad MTU (%d), valid range is: [%d..%d]\n",
+			   __func__, new_mtu, netdev->min_mtu, netdev->max_mtu);
+		return -EINVAL;
+	}
+
+	if (!xsc_rx_is_linear_skb(new_mtu)) {
+		max_buf_len = adapter->xdev->caps.recv_ds_num * PAGE_SIZE;
+		if (new_mtu > max_buf_len) {
+			netdev_err(netdev, "Bad MTU (%d), max buf len is %d\n",
+				   new_mtu, max_buf_len);
+			return -EINVAL;
+		}
+	}
+	mutex_lock(&adapter->status_lock);
+	adapter->nic_param.mtu = new_mtu;
+	if (adapter->status != XSCALE_ETH_DRIVER_OK) {
+		ret = xsc_eth_nic_mtu_changed(adapter);
+		if (ret)
+			adapter->nic_param.mtu = old_mtu;
+		else
+			netdev->mtu = adapter->nic_param.mtu;
+		goto out;
+	}
+
+	ret = xsc_safe_switch_channels(adapter, xsc_eth_nic_mtu_changed);
+	if (ret)
+		goto out;
+
+	netdev->mtu = adapter->nic_param.mtu;
+
+out:
+	mutex_unlock(&adapter->status_lock);
+	xsc_core_info(adapter->xdev, "mtu change from %d to %d, new_mtu=%d, err=%d\n",
+		      old_mtu, netdev->mtu, new_mtu, ret);
+	return ret;
+}
+
 static const struct net_device_ops xsc_netdev_ops = {
 	.ndo_open		= xsc_eth_open,
 	.ndo_stop		= xsc_eth_close,
 	.ndo_start_xmit		= xsc_eth_xmit_start,
 	.ndo_get_stats64	= xsc_eth_get_stats,
 	.ndo_set_mac_address	= xsc_eth_set_mac,
+	.ndo_change_mtu		= xsc_eth_change_mtu,
 };
 
 static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
@@ -1724,31 +1934,6 @@ static void xsc_eth_nic_cleanup(struct xsc_adapter *adapter)
 	kfree(adapter->txq2sq);
 }
 
-static int xsc_eth_set_hw_mtu(struct xsc_core_device *dev, u16 mtu, u16 rx_buf_sz)
-{
-	struct xsc_set_mtu_mbox_in in;
-	struct xsc_set_mtu_mbox_out out;
-	int ret;
-
-	memset(&in, 0, sizeof(struct xsc_set_mtu_mbox_in));
-	memset(&out, 0, sizeof(struct xsc_set_mtu_mbox_out));
-
-	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_SET_MTU);
-	in.mtu = cpu_to_be16(mtu);
-	in.rx_buf_sz_min = cpu_to_be16(rx_buf_sz);
-	in.mac_port = dev->mac_port;
-
-	ret = xsc_cmd_exec(dev, &in, sizeof(struct xsc_set_mtu_mbox_in), &out,
-			   sizeof(struct xsc_set_mtu_mbox_out));
-	if (ret || out.hdr.status) {
-		xsc_core_err(dev, "failed to set hw_mtu=%u rx_buf_sz=%u, err=%d, status=%d\n",
-			     mtu, rx_buf_sz, ret, out.hdr.status);
-		ret = -ENOEXEC;
-	}
-
-	return ret;
-}
-
 static int xsc_eth_get_mac(struct xsc_core_device *dev, char *mac)
 {
 	struct xsc_query_eth_mac_mbox_out *out;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
index 96c1954ef..9b261f116 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
@@ -53,4 +53,6 @@ struct xsc_adapter {
 	struct xsc_stats *stats;
 };
 
+typedef int (*xsc_eth_fp_preactivate)(struct xsc_adapter *priv);
+
 #endif /* XSC_ETH_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
index 2a6740896..b24a686f1 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
- * Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * Copyright (C) 2021-2024, Shanghai Yunsilicon Technology Co., Ltd.
  * Copyright (c) 2015-2016, Mellanox Technologies. All rights reserved.
  *
  * This software is available to you under a choice of one of two
-- 
2.43.0

