Return-Path: <netdev+bounces-296531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iygwF/y3JmoObwIAu9opvQ
	(envelope-from <netdev+bounces-296531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:39:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 536D7656426
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:39:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=XadjxGaR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296531-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296531-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E45303016FBE
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE0437F8D9;
	Mon,  8 Jun 2026 12:36:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920134D3B9;
	Mon,  8 Jun 2026 12:36:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922208; cv=none; b=qd/i5j3XQHejzuS76Dpgasmjs4ZkNuuYWSnZ5zqHaEbINm2xdFbFO6MCoWZWleU2NTYC2B3n7Z7pLMJ1XZRMNLFqUjUGYVJfrDY14lNp4yl92Krs1QnJdFs8AndA5AzbQgMCMnYU93FYSuBNqyb26y4LH/vSWtR5o/CDgnyk05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922208; c=relaxed/simple;
	bh=+Hsr9p52H03RE6aukDnwSmzYJvb+6BrWr756J4k1E+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqGXeGrse3yajU8mJ7n65PZaQOlNNnHqw/jLPxmJHpVEyou/gwlGXh+TyySj5jfbZ8mB3oEav6fLvvk59t0iRPW+FS+VzxUAWEVam94yNHMGjsb88E9+mOxUaa9dzqyO+UKHnWAqRS1wxaLjQMzDXLkUKk+pqKaWwmCrBWdFhMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XadjxGaR; arc=none smtp.client-ip=113.46.200.221
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Zq63XOUipQghGsYCI0fqHwpcZZfYJCh4co4wz7SH7do=;
	b=XadjxGaRmq9JxtKa6bTzEjgGR4qoCS9cgtdpTJpdb5p44eqaQbEuwpgQHdtRnPQOmi+HmRi+m
	xiVqI+y2fYk+4khPqKKAGuyZ/iFedpLP2k3X1RaQVyX7JyBVzaiH+hCayz1/ub4PnE56peWF2g2
	w8rNGNQpv00NsMW19+Fo9NA=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gYrtn2PMVzRhQx;
	Mon,  8 Jun 2026 20:28:49 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 10DA640537;
	Mon,  8 Jun 2026 20:36:42 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 8 Jun 2026 20:36:40 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Mohsin Bashir <mohsin.bashr@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v08 1/5] hinic3: Add ethtool queue ops
Date: Mon, 8 Jun 2026 20:36:30 +0800
Message-ID: <4ad179dd9082df5e738219e05d90ddb2dcdad8f0.1780907605.git.wudi234@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1780907605.git.wudi234@huawei.com>
References: <cover.1780907605.git.wudi234@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-296531-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gongfan1@huawei.com,m:wudi234@huawei.com,m:tengpeisen@huawei.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:ioana.ciornei@nxp.com,m:mohsin.bashr@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:luosifu@huawei.com,m:guoxin09@huawei.com,m:zhoushuai28@huawei.com,m:wulike1@huawei.com,m:shijing34@huawei.com,m:zhengjiezhen@h-partners.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[huawei.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,nxp.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,huawei.com:mid,huawei.com:dkim,huawei.com:from_mime,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 536D7656426

  Implement following ethtool callback function:
.get_ringparam
.set_ringparam

  These callbacks allow users to utilize ethtool for detailed
queue depth configuration and monitoring.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 100 +++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |   5 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   6 +
 .../huawei/hinic3/hinic3_netdev_ops.c         | 104 ++++++++++++++++--
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   9 ++
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    |   4 +-
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |   8 +-
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |   2 +-
 8 files changed, 224 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index 90fc16288de9..c72db9da7701 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/ethtool.h>
 
 #include "hinic3_lld.h"
@@ -409,6 +410,103 @@ hinic3_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
+static void hinic3_get_ringparam(struct net_device *netdev,
+				 struct ethtool_ringparam *ring,
+				 struct kernel_ethtool_ringparam *kernel_ring,
+				 struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	ring->rx_max_pending = HINIC3_MAX_RX_QUEUE_DEPTH;
+	ring->tx_max_pending = HINIC3_MAX_TX_QUEUE_DEPTH;
+	ring->rx_pending = nic_dev->q_params.rq_depth;
+	ring->rx_pending = nic_dev->q_params.sq_depth;
+}
+
+static void hinic3_update_qp_depth(struct net_device *netdev,
+				   u32 sq_depth, u32 rq_depth)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 i;
+
+	nic_dev->q_params.sq_depth = sq_depth;
+	nic_dev->q_params.rq_depth = rq_depth;
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		nic_dev->txqs[i].q_depth = sq_depth;
+		nic_dev->txqs[i].q_mask = sq_depth - 1;
+		nic_dev->rxqs[i].q_depth = rq_depth;
+		nic_dev->rxqs[i].q_mask = rq_depth - 1;
+	}
+}
+
+static int hinic3_check_ringparam_valid(struct net_device *netdev,
+					const struct ethtool_ringparam *ring,
+					struct netlink_ext_ack *extack)
+{
+	if (ring->tx_pending < HINIC3_MIN_QUEUE_DEPTH ||
+	    ring->rx_pending < HINIC3_MIN_QUEUE_DEPTH) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Queue depth out of range tx[%d-%d] rx[%d-%d]",
+				       HINIC3_MIN_QUEUE_DEPTH,
+				       HINIC3_MAX_TX_QUEUE_DEPTH,
+				       HINIC3_MIN_QUEUE_DEPTH,
+				       HINIC3_MAX_RX_QUEUE_DEPTH);
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_set_ringparam(struct net_device *netdev,
+				struct ethtool_ringparam *ring,
+				struct kernel_ethtool_ringparam *kernel_ring,
+				struct netlink_ext_ack *extack)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_txrxq_params q_params = {};
+	u32 new_sq_depth, new_rq_depth;
+	int err;
+
+	err = hinic3_check_ringparam_valid(netdev, ring, extack);
+	if (err)
+		return err;
+
+	new_sq_depth = 1U << ilog2(ring->tx_pending);
+	new_rq_depth = 1U << ilog2(ring->rx_pending);
+	if (new_sq_depth == nic_dev->q_params.sq_depth &&
+	    new_rq_depth == nic_dev->q_params.rq_depth)
+		return 0;
+
+	if (new_sq_depth != ring->tx_pending ||
+	    new_rq_depth != ring->rx_pending)
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Requested Tx/Rx ring depth %u/%u trimmed to %u/%u",
+				       ring->tx_pending, ring->rx_pending,
+				       new_sq_depth, new_rq_depth);
+
+	netdev_info(netdev, "Change Tx/Rx ring depth from %u/%u to %u/%u\n",
+		    nic_dev->q_params.sq_depth, nic_dev->q_params.rq_depth,
+		    new_sq_depth, new_rq_depth);
+
+	if (!netif_running(netdev)) {
+		hinic3_update_qp_depth(netdev, new_sq_depth, new_rq_depth);
+	} else {
+		q_params = nic_dev->q_params;
+		q_params.sq_depth = new_sq_depth;
+		q_params.rq_depth = new_rq_depth;
+
+		err = hinic3_change_channel_settings(netdev, &q_params);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Failed to change channel settings");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops hinic3_ethtool_ops = {
 	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
 					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
@@ -417,6 +515,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_msglevel                   = hinic3_get_msglevel,
 	.set_msglevel                   = hinic3_set_msglevel,
 	.get_link                       = ethtool_op_get_link,
+	.get_ringparam                  = hinic3_get_ringparam,
+	.set_ringparam                  = hinic3_set_ringparam,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index e7d6c2033b45..bc4d879f9be4 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -137,7 +137,8 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
 	struct hinic3_interrupt_info info = {};
 	int err;
 
-	if (q_id >= nic_dev->q_params.num_qps)
+	if (q_id >= nic_dev->q_params.num_qps ||
+	    !mutex_trylock(&nic_dev->change_res_mutex))
 		return 0;
 
 	info.interrupt_coalesc_set = 1;
@@ -156,6 +157,8 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
 		nic_dev->rxqs[q_id].last_pending_limit = pending_limit;
 	}
 
+	mutex_unlock(&nic_dev->change_res_mutex);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 0a888fe4c975..c87624a5e5dc 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -179,6 +179,7 @@ static int hinic3_sw_init(struct net_device *netdev)
 	int err;
 
 	mutex_init(&nic_dev->port_state_mutex);
+	mutex_init(&nic_dev->change_res_mutex);
 
 	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
 	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
@@ -315,6 +316,9 @@ static void hinic3_link_status_change(struct net_device *netdev,
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 
+	if (!mutex_trylock(&nic_dev->change_res_mutex))
+		return;
+
 	if (link_status_up) {
 		if (netif_carrier_ok(netdev))
 			return;
@@ -330,6 +334,8 @@ static void hinic3_link_status_change(struct net_device *netdev,
 		netif_carrier_off(netdev);
 		netdev_dbg(netdev, "Link is down\n");
 	}
+
+	mutex_unlock(&nic_dev->change_res_mutex);
 }
 
 static void hinic3_port_module_event_handler(struct net_device *netdev,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index da73811641a9..047214cfc753 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -288,7 +288,8 @@ static void hinic3_free_channel_resources(struct net_device *netdev,
 	hinic3_free_qps(nic_dev, qp_params);
 }
 
-static int hinic3_open_channel(struct net_device *netdev)
+static int hinic3_prepare_channel(struct net_device *netdev,
+				  struct hinic3_dyna_txrxq_params *qp_params)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	int err;
@@ -299,16 +300,28 @@ static int hinic3_open_channel(struct net_device *netdev)
 		return err;
 	}
 
-	err = hinic3_configure_txrxqs(netdev, &nic_dev->q_params);
+	err = hinic3_configure_txrxqs(netdev, qp_params);
 	if (err) {
 		netdev_err(netdev, "Failed to configure txrxqs\n");
 		goto err_free_qp_ctxts;
 	}
 
+	return 0;
+
+err_free_qp_ctxts:
+	hinic3_free_qp_ctxts(nic_dev);
+
+	return err;
+}
+
+static int hinic3_open_channel(struct net_device *netdev)
+{
+	int err;
+
 	err = hinic3_qps_irq_init(netdev);
 	if (err) {
 		netdev_err(netdev, "Failed to init txrxq irq\n");
-		goto err_free_qp_ctxts;
+		return err;
 	}
 
 	err = hinic3_configure(netdev);
@@ -321,8 +334,6 @@ static int hinic3_open_channel(struct net_device *netdev)
 
 err_uninit_qps_irq:
 	hinic3_qps_irq_uninit(netdev);
-err_free_qp_ctxts:
-	hinic3_free_qp_ctxts(nic_dev);
 
 	return err;
 }
@@ -428,6 +439,74 @@ static void hinic3_vport_down(struct net_device *netdev)
 	}
 }
 
+int
+hinic3_change_channel_settings(struct net_device *netdev,
+			       struct hinic3_dyna_txrxq_params *trxq_params)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_txrxq_params cur_trxq_params = {};
+	struct hinic3_dyna_qp_params new_qp_params = {};
+	struct hinic3_dyna_qp_params cur_qp_params = {};
+	int err;
+
+	cur_trxq_params = nic_dev->q_params;
+
+	hinic3_config_num_qps(netdev, trxq_params);
+
+	err = hinic3_alloc_channel_resources(netdev, &new_qp_params,
+					     trxq_params);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc channel resources\n");
+		return err;
+	}
+
+	mutex_lock(&nic_dev->change_res_mutex);
+	hinic3_vport_down(netdev);
+	hinic3_close_channel(netdev);
+	hinic3_get_cur_qps(nic_dev, &cur_qp_params);
+
+	hinic3_init_qps(nic_dev, &new_qp_params);
+
+	err = hinic3_prepare_channel(netdev, trxq_params);
+	if (err)
+		goto err_uninit_qps;
+
+	if (nic_dev->num_qp_irq > trxq_params->num_qps)
+		hinic3_qp_irq_change(netdev, trxq_params->num_qps);
+
+	nic_dev->q_params = *trxq_params;
+
+	err = hinic3_open_channel(netdev);
+	if (err)
+		goto err_qp_irq_reset;
+
+	err = hinic3_vport_up(netdev);
+	if (err)
+		goto err_close_channel;
+
+	hinic3_free_channel_resources(netdev, &cur_qp_params, &cur_trxq_params);
+
+	mutex_unlock(&nic_dev->change_res_mutex);
+
+	return 0;
+
+err_close_channel:
+	hinic3_close_channel(netdev);
+err_qp_irq_reset:
+	nic_dev->q_params = cur_trxq_params;
+
+	if (trxq_params->num_qps > cur_trxq_params.num_qps)
+		hinic3_qp_irq_change(netdev, cur_trxq_params.num_qps);
+	hinic3_free_qp_ctxts(nic_dev);
+err_uninit_qps:
+	hinic3_get_cur_qps(nic_dev, &new_qp_params);
+	hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params);
+	hinic3_free_channel_resources(netdev, &cur_qp_params, &cur_trxq_params);
+	mutex_unlock(&nic_dev->change_res_mutex);
+
+	return err;
+}
+
 static int hinic3_open(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -458,6 +537,10 @@ static int hinic3_open(struct net_device *netdev)
 
 	hinic3_init_qps(nic_dev, &qp_params);
 
+	err = hinic3_prepare_channel(netdev, &nic_dev->q_params);
+	if (err)
+		goto err_uninit_qps;
+
 	err = hinic3_open_channel(netdev);
 	if (err)
 		goto err_uninit_qps;
@@ -473,7 +556,7 @@ static int hinic3_open(struct net_device *netdev)
 err_close_channel:
 	hinic3_close_channel(netdev);
 err_uninit_qps:
-	hinic3_uninit_qps(nic_dev, &qp_params);
+	hinic3_get_cur_qps(nic_dev, &qp_params);
 	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
 err_destroy_num_qps:
 	hinic3_destroy_num_qps(netdev);
@@ -493,10 +576,15 @@ static int hinic3_close(struct net_device *netdev)
 		return 0;
 	}
 
+	mutex_lock(&nic_dev->change_res_mutex);
 	hinic3_vport_down(netdev);
 	hinic3_close_channel(netdev);
-	hinic3_uninit_qps(nic_dev, &qp_params);
-	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
+	hinic3_get_cur_qps(nic_dev, &qp_params);
+	hinic3_free_channel_resources(netdev, &qp_params,
+				      &nic_dev->q_params);
+	hinic3_free_nicio_res(nic_dev);
+	hinic3_destroy_num_qps(netdev);
+	mutex_unlock(&nic_dev->change_res_mutex);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 9502293ff710..005b2c01a988 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -10,6 +10,9 @@
 #include "hinic3_hw_cfg.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_mgmt_interface.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_tx.h"
+#include "hinic3_rx.h"
 
 #define HINIC3_VLAN_BITMAP_BYTE_SIZE(nic_dev)  (sizeof(*(nic_dev)->vlan_bitmap))
 #define HINIC3_VLAN_BITMAP_SIZE(nic_dev)  \
@@ -129,6 +132,8 @@ struct hinic3_nic_dev {
 	struct work_struct              rx_mode_work;
 	/* lock for enable/disable port */
 	struct mutex                    port_state_mutex;
+	/* mutex to serialize channel/resource changes */
+	struct mutex                    change_res_mutex;
 
 	struct list_head                uc_filter_list;
 	struct list_head                mc_filter_list;
@@ -143,6 +148,10 @@ struct hinic3_nic_dev {
 
 void hinic3_set_netdev_ops(struct net_device *netdev);
 int hinic3_set_hw_features(struct net_device *netdev);
+int
+hinic3_change_channel_settings(struct net_device *netdev,
+			       struct hinic3_dyna_txrxq_params *trxq_params);
+
 int hinic3_qps_irq_init(struct net_device *netdev);
 void hinic3_qps_irq_uninit(struct net_device *netdev);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
index 87e736adba02..0e7a0ccfba98 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
@@ -484,8 +484,8 @@ void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
 	}
 }
 
-void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
-		       struct hinic3_dyna_qp_params *qp_params)
+void hinic3_get_cur_qps(struct hinic3_nic_dev *nic_dev,
+			struct hinic3_dyna_qp_params *qp_params)
 {
 	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
index 12eefabcf1db..571b34d63950 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
@@ -14,6 +14,10 @@ struct hinic3_nic_dev;
 #define HINIC3_RQ_WQEBB_SHIFT      3
 #define HINIC3_SQ_WQEBB_SIZE       BIT(HINIC3_SQ_WQEBB_SHIFT)
 
+#define HINIC3_MAX_TX_QUEUE_DEPTH  65536
+#define HINIC3_MAX_RX_QUEUE_DEPTH  16384
+#define HINIC3_MIN_QUEUE_DEPTH     128
+
 /* ******************** RQ_CTRL ******************** */
 enum hinic3_rq_wqe_type {
 	HINIC3_NORMAL_RQ_WQE = 1,
@@ -136,8 +140,8 @@ void hinic3_free_qps(struct hinic3_nic_dev *nic_dev,
 		     struct hinic3_dyna_qp_params *qp_params);
 void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
 		     struct hinic3_dyna_qp_params *qp_params);
-void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
-		       struct hinic3_dyna_qp_params *qp_params);
+void hinic3_get_cur_qps(struct hinic3_nic_dev *nic_dev,
+			struct hinic3_dyna_qp_params *qp_params);
 
 int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev);
 void hinic3_free_qp_ctxts(struct hinic3_nic_dev *nic_dev);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index 309ab5901379..b5b601469517 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -541,7 +541,7 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
 		rq_associate_cqes(rxq);
 
 		pkts = hinic3_rx_fill_buffers(rxq);
-		if (!pkts) {
+		if (pkts < rxq->q_depth - 1) {
 			netdev_err(netdev, "Failed to fill Rx buffer\n");
 			return -ENOMEM;
 		}
-- 
2.43.0


