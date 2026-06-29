Return-Path: <netdev+bounces-302493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 57mBCHslQmrb0wkAu9opvQ
	(envelope-from <netdev+bounces-302493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:57:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B146D73C9
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:57:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=KPDR0ijP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302493-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302493-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FCA7312F0C3
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8253C108B;
	Mon, 29 Jun 2026 07:38:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C42282F3A;
	Mon, 29 Jun 2026 07:38:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718687; cv=none; b=eRqE386eB+/lIh+Vz4lzdb8HLZ1wVYvJi+cupI/Oy6oJsKSz7I9RWNnFK8Awbd56bJgFk0XQGs2AKRibj966c5ApztkDRX7WX62z7bobksirxChkGXHfvSgHxLb6U6n1LoIoXzjgsPLGKV8u8id7eJyG59Mh4tLxj0QzpgAub8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718687; c=relaxed/simple;
	bh=fs7+nDC7SC8xjdJQxWufUp11DkNcQ5AILn/OVlDlrys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLjTzkpUfLfbga9jCmDFJfxBFiIycKXtakmwMQSnoHIsaineS0exdrbtT9qbnSUXI4GyK7+xXMfyG9RkCt+3JSiErBL/YP37RyNMjfa0bG8LK8xCLqlKEmmDtJ6v/F4KCsmFH8WSMuqkRtpXECMaoiiiEb/8hS+pzXSB4aWY6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KPDR0ijP; arc=none smtp.client-ip=113.46.200.222
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wmpM2YfvOvRA/sSyMGpSaDY6nWb+juPpoAxwFlpeObE=;
	b=KPDR0ijPY8M1svfbiJ7K8bR5pNM2LtzuchqM3Pvjq0dsp+FGAccmaUsI3YVGpf06E9L9EmBce
	yIvUe/NXfWVunk3A8OqsP2Az2AQmNRgxaKuf1VEIXd738jFf2sKZ7yI6EV8dKZ0sOZn0gJ1E71j
	GXIQGuwSRndFtrhMd0JvnB8=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gpdDx0bntzLlXX;
	Mon, 29 Jun 2026 15:28:49 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 72E66402AB;
	Mon, 29 Jun 2026 15:37:57 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 29 Jun 2026 15:37:56 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri
 Daskalakis <dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v10 1/5] hinic3: Add ethtool queue ops
Date: Mon, 29 Jun 2026 15:37:42 +0800
Message-ID: <3414df08001307c6d96c17ffc0921206c62f85a1.1782718232.git.wudi234@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1782718232.git.wudi234@huawei.com>
References: <cover.1782718232.git.wudi234@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-302493-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[huawei.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gongfan1@huawei.com,m:wudi234@huawei.com,m:tengpeisen@huawei.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:ioana.ciornei@nxp.com,m:mohsin.bashr@gmail.com,m:dimitri.daskalakis1@gmail.com,m:hramamurthy@google.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:luosifu@huawei.com,m:guoxin09@huawei.com,m:zhoushuai28@huawei.com,m:wulike1@huawei.com,m:shijing34@huawei.com,m:zhengjiezhen@h-partners.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,m:dimitridaskalakis1@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70B146D73C9

  Implement following ethtool callback function:
.get_ringparam
.set_ringparam

  These callbacks allow users to utilize ethtool for detailed
queue depth configuration and monitoring.

  Change port_state_mutex to state_lock as a unified mutex lock
in hinic3_nic_dev.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   |  91 +++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  11 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  13 ++-
 .../huawei/hinic3/hinic3_netdev_ops.c         | 110 ++++++++++++++++--
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  11 +-
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    |   4 +-
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |   8 +-
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |   2 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |   7 +-
 9 files changed, 236 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index 90fc16288de9..e6dff46a0d00 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/ethtool.h>
 
 #include "hinic3_lld.h"
@@ -409,6 +410,94 @@ hinic3_get_link_ksettings(struct net_device *netdev,
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
+	ring->tx_pending = nic_dev->q_params.sq_depth;
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
+				       "Queue depth underflow[%d]: tx[%d], rx[%d]",
+				       HINIC3_MIN_QUEUE_DEPTH,
+				       ring->tx_pending, ring->rx_pending);
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
+	new_sq_depth = rounddown_pow_of_two(ring->tx_pending);
+	new_rq_depth = rounddown_pow_of_two(ring->rx_pending);
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
+	if (!netif_running(netdev)) {
+		hinic3_update_qp_depth(netdev, new_sq_depth, new_rq_depth);
+	} else {
+		q_params = nic_dev->q_params;
+		q_params.sq_depth = new_sq_depth;
+		q_params.rq_depth = new_rq_depth;
+
+		err = hinic3_change_channel_settings(netdev, &q_params);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops hinic3_ethtool_ops = {
 	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
 					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
@@ -417,6 +506,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_msglevel                   = hinic3_get_msglevel,
 	.set_msglevel                   = hinic3_set_msglevel,
 	.get_link                       = ethtool_op_get_link,
+	.get_ringparam                  = hinic3_get_ringparam,
+	.set_ringparam                  = hinic3_set_ringparam,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index e7d6c2033b45..5479c235e3de 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -135,10 +135,13 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	struct hinic3_interrupt_info info = {};
-	int err;
+	int err = 0;
+
+	if (!mutex_trylock(&nic_dev->state_lock))
+		goto out;
 
 	if (q_id >= nic_dev->q_params.num_qps)
-		return 0;
+		goto err_unlock;
 
 	info.interrupt_coalesc_set = 1;
 	info.coalesc_timer_cfg = coalesc_timer_cfg;
@@ -156,6 +159,10 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
 		nic_dev->rxqs[q_id].last_pending_limit = pending_limit;
 	}
 
+err_unlock:
+	mutex_unlock(&nic_dev->state_lock);
+
+out:
 	return err;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 0a888fe4c975..bb2b000f86e8 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -178,7 +178,7 @@ static int hinic3_sw_init(struct net_device *netdev)
 	u8 mac_addr[ETH_ALEN];
 	int err;
 
-	mutex_init(&nic_dev->port_state_mutex);
+	mutex_init(&nic_dev->state_lock);
 
 	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
 	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
@@ -315,21 +315,28 @@ static void hinic3_link_status_change(struct net_device *netdev,
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 
+	if (!mutex_trylock(&nic_dev->state_lock))
+		return;
+
 	if (link_status_up) {
 		if (netif_carrier_ok(netdev))
-			return;
+			goto err_unlock;
 
 		nic_dev->link_status_up = true;
 		netif_carrier_on(netdev);
 		netdev_dbg(netdev, "Link is up\n");
 	} else {
 		if (!netif_carrier_ok(netdev))
-			return;
+			goto err_unlock;
 
 		nic_dev->link_status_up = false;
 		netif_carrier_off(netdev);
 		netdev_dbg(netdev, "Link is down\n");
 	}
+
+err_unlock:
+	mutex_unlock(&nic_dev->state_lock);
+	return;
 }
 
 static void hinic3_port_module_event_handler(struct net_device *netdev,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index da73811641a9..2d527b0ecbbe 100644
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
@@ -299,12 +300,25 @@ static int hinic3_open_channel(struct net_device *netdev)
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
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
 	err = hinic3_qps_irq_init(netdev);
 	if (err) {
 		netdev_err(netdev, "Failed to init txrxq irq\n");
@@ -321,6 +335,7 @@ static int hinic3_open_channel(struct net_device *netdev)
 
 err_uninit_qps_irq:
 	hinic3_qps_irq_uninit(netdev);
+
 err_free_qp_ctxts:
 	hinic3_free_qp_ctxts(nic_dev);
 
@@ -341,9 +356,9 @@ static int hinic3_maybe_set_port_state(struct net_device *netdev, bool enable)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	int err;
 
-	mutex_lock(&nic_dev->port_state_mutex);
+	mutex_lock(&nic_dev->state_lock);
 	err = hinic3_set_port_enable(nic_dev->hwdev, enable);
-	mutex_unlock(&nic_dev->port_state_mutex);
+	mutex_unlock(&nic_dev->state_lock);
 
 	return err;
 }
@@ -428,6 +443,78 @@ static void hinic3_vport_down(struct net_device *netdev)
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
+	mutex_lock(&nic_dev->state_lock);
+	hinic3_config_num_qps(netdev, trxq_params);
+
+	err = hinic3_alloc_channel_resources(netdev, &new_qp_params,
+					     trxq_params);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc channel resources\n");
+		mutex_unlock(&nic_dev->state_lock);
+		return err;
+	}
+
+	hinic3_vport_down(netdev);
+	hinic3_close_channel(netdev);
+	clear_bit(HINIC3_INTF_UP, &nic_dev->flags);
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
+	set_bit(HINIC3_INTF_UP, &nic_dev->flags);
+
+	hinic3_free_channel_resources(netdev, &cur_qp_params, &cur_trxq_params);
+
+	mutex_unlock(&nic_dev->state_lock);
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
+err_uninit_qps:
+	hinic3_get_cur_qps(nic_dev, &new_qp_params);
+	hinic3_config_num_qps(netdev, &cur_trxq_params);
+	hinic3_init_qps(nic_dev, &cur_qp_params);
+	hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params);
+	mutex_unlock(&nic_dev->state_lock);
+
+	return err;
+}
+
 static int hinic3_open(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -458,6 +545,10 @@ static int hinic3_open(struct net_device *netdev)
 
 	hinic3_init_qps(nic_dev, &qp_params);
 
+	err = hinic3_prepare_channel(netdev, &nic_dev->q_params);
+	if (err)
+		goto err_uninit_qps;
+
 	err = hinic3_open_channel(netdev);
 	if (err)
 		goto err_uninit_qps;
@@ -473,7 +564,7 @@ static int hinic3_open(struct net_device *netdev)
 err_close_channel:
 	hinic3_close_channel(netdev);
 err_uninit_qps:
-	hinic3_uninit_qps(nic_dev, &qp_params);
+	hinic3_get_cur_qps(nic_dev, &qp_params);
 	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
 err_destroy_num_qps:
 	hinic3_destroy_num_qps(netdev);
@@ -493,10 +584,15 @@ static int hinic3_close(struct net_device *netdev)
 		return 0;
 	}
 
+	mutex_lock(&nic_dev->state_lock);
 	hinic3_vport_down(netdev);
 	hinic3_close_channel(netdev);
-	hinic3_uninit_qps(nic_dev, &qp_params);
-	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
+	hinic3_get_cur_qps(nic_dev, &qp_params);
+	hinic3_free_channel_resources(netdev, &qp_params,
+				      &nic_dev->q_params);
+	hinic3_free_nicio_res(nic_dev);
+	hinic3_destroy_num_qps(netdev);
+	mutex_unlock(&nic_dev->state_lock);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 9502293ff710..ccef82d57fdd 100644
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
@@ -127,8 +130,8 @@ struct hinic3_nic_dev {
 	struct workqueue_struct         *workq;
 	struct delayed_work             periodic_work;
 	struct work_struct              rx_mode_work;
-	/* lock for enable/disable port */
-	struct mutex                    port_state_mutex;
+	/* Protects Interface state */
+	struct mutex                    state_lock;
 
 	struct list_head                uc_filter_list;
 	struct list_head                mc_filter_list;
@@ -143,6 +146,10 @@ struct hinic3_nic_dev {
 
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
index 309ab5901379..389b1c2158be 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -541,7 +541,7 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
 		rq_associate_cqes(rxq);
 
 		pkts = hinic3_rx_fill_buffers(rxq);
-		if (!pkts) {
+		if (pkts < rxq->q_mask) {
 			netdev_err(netdev, "Failed to fill Rx buffer\n");
 			return -ENOMEM;
 		}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 9306bf0020ca..53c065194136 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -261,8 +261,7 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
 		    ((struct udphdr *)skb_transport_header(skb))->dest !=
 		    VXLAN_OFFLOAD_PORT_LE) {
 			/* Unsupported tunnel packet, disable csum offload */
-			skb_checksum_help(skb);
-			return 0;
+			return skb_checksum_help(skb);
 		}
 	}
 
@@ -412,6 +411,10 @@ static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
 		offload |= HINIC3_TX_OFFLOAD_TSO;
 	} else {
 		tso_cs_en = hinic3_tx_csum(txq, task, skb);
+		if (tso_cs_en < 0) {
+			offload = HINIC3_TX_OFFLOAD_INVALID;
+			return offload;
+		}
 		if (tso_cs_en)
 			offload |= HINIC3_TX_OFFLOAD_CSUM;
 	}
-- 
2.43.0


