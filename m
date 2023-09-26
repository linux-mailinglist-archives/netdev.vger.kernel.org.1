Return-Path: <netdev+bounces-36322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B740B7AF2BD
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 20:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9B9301C20805
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8144450D3;
	Tue, 26 Sep 2023 18:25:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72B42BFA
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 18:25:29 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988CBF3
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 11:25:26 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QHW2fd031623;
	Tue, 26 Sep 2023 18:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=VZmzQSqEGRwwVdJ/5L4OV0wj3a48KVlktgPtd+IGygA=;
 b=fdpXLGSmgWOvzeP9lN8ISgbx5KNlCGSZE93Fbrthgvrpr7heBx/dXX/kbknmpDIQoLSL
 k9w+L48beXh95gzpi3bmbMnKYlBgivF43CjXJXPJU5CuJRdS4l86Nl8o9BZt2rSoh660
 JvZYpezBn981fsUHjhSa4/zwPOOsRnxu5AezrtPcvIiOXHiKszhs0ZCKVh8PR2Z7ldX5
 6gPAJUO96ssI0at4/cW59888FUUW2m1CVX1DggoXpzTvyxRKybO+GRpHiQNiKhrlbptn
 rU/pYdNltv1ldd10y4+5rWYNfnzPQbwXf6fk4kXU+tR+x2sEuOvCxS6D8Zw1Tzr8xrAS Xw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbexgjvkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Sep 2023 18:25:12 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38QILZO1002902;
	Tue, 26 Sep 2023 18:24:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3t9s3kufqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Sep 2023 18:24:57 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QILTth002840;
	Tue, 26 Sep 2023 18:24:57 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 38QIOuWD008484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Sep 2023 18:24:57 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id 476BD635; Tue, 26 Sep 2023 11:24:56 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
        lkp@intel.com
Cc: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
        Sean Tranchetti <quic_stranche@quicinc.com>
Subject: [PATCH net-next v2] net: qualcomm: rmnet: Add side band flow control support
Date: Tue, 26 Sep 2023 11:24:07 -0700
Message-Id: <20230926182407.964671-1-quic_subashab@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lPeNANG10DgMuhdWBXtcJrg_uGHX0ynX
X-Proofpoint-GUID: lPeNANG10DgMuhdWBXtcJrg_uGHX0ynX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 clxscore=1011 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260160
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Individual rmnet devices map to specific network types such as internet,
multimedia messaging services, IP multimedia subsystem etc. Each of
these network types may support varying quality of service for different
bearers or traffic types.

The physical device interconnect to radio hardware may support a
higher data rate than what is actually supported by the radio network.
Any packets transmitted to the radio hardware which exceed the radio
network data rate limit maybe dropped. This patch tries to minimize the
loss of packets by adding support for bearer level flow control within a
rmnet device by ensuring that the packets transmitted do not exceed the
limit allowed by the radio network.

In order to support multiple bearers, rmnet must be created as a
multiqueue TX netdevice. Radio hardware communicates the supported
bearer information for a given network via side band signalling.
Consider the following mapping -

IPv4 UDP port 1234 - Mark 0x1001 - Queue 1
IPv6 TCP port 2345 - Mark 0x2001 - Queue 2

iptables can be used to install filters which mark packets matching these
specific traffic patterns and the RMNET_QUEUE_MAPPING_ADD operation can
then be to install the mapping of the mark to the specific txqueue.

If the traffic limit is exceeded for a particular bearer, radio hardware
would notify that the bearer cannot accept more packets and the
corresponding txqueue traffic can be stopped using RMNET_QUEUE_DISABLE.

Conversely, if radio hardware can send more traffic for a particular
bearer, RMNET_QUEUE_ENABLE can be used to allow traffic on that
particular txqueue. RMNET_QUEUE_MAPPING_REMOVE can be used to remove the
mark to queue mapping in case the radio network doesn't support that
particular bearer any longer.

Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
---
v1 -> v2
 Fix incorrect xarray API usage in rmnet_update_queue_map() and remove some
 unneccessary checks in rmnet_vnd_select_queue() as mentioned by Vadim.
 Fix UAPI types as reported by kernel test robot.

 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 96 ++++++++++++++++++-
 .../ethernet/qualcomm/rmnet/rmnet_config.h    |  2 +
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 21 ++++
 include/uapi/linux/if_link.h                  | 16 ++++
 4 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 39d24e07f306..822fb29f47eb 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2013-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  *
  * RMNET configuration engine
  */
@@ -19,6 +20,7 @@
 static const struct nla_policy rmnet_policy[IFLA_RMNET_MAX + 1] = {
 	[IFLA_RMNET_MUX_ID]	= { .type = NLA_U16 },
 	[IFLA_RMNET_FLAGS]	= { .len = sizeof(struct ifla_rmnet_flags) },
+	[IFLA_RMNET_QUEUE]	= { .len = sizeof(struct rmnet_queue_mapping) },
 };
 
 static int rmnet_is_real_dev_registered(const struct net_device *real_dev)
@@ -88,6 +90,66 @@ static int rmnet_register_real_device(struct net_device *real_dev,
 	return 0;
 }
 
+static int rmnet_update_queue_map(struct net_device *dev, u8 operation,
+				  u8 txqueue, u32 mark,
+				  struct netlink_ext_ack *extack)
+{
+	struct rmnet_priv *priv = netdev_priv(dev);
+	struct netdev_queue *q;
+	void *p;
+	u8 txq;
+
+	if (unlikely(txqueue >= dev->num_tx_queues)) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid txqueue");
+		return -EINVAL;
+	}
+
+	switch (operation) {
+	case RMNET_QUEUE_MAPPING_ADD:
+		p = xa_store(&priv->queue_map, mark, xa_mk_value(txqueue),
+			     GFP_ATOMIC);
+		if (xa_is_err(p)) {
+			NL_SET_ERR_MSG_MOD(extack, "unable to add mapping");
+			return -EINVAL;
+		}
+		break;
+	case RMNET_QUEUE_MAPPING_REMOVE:
+		p = xa_erase(&priv->queue_map, mark);
+		if (xa_is_err(p)) {
+			NL_SET_ERR_MSG_MOD(extack, "unable to remove mapping");
+			return -EINVAL;
+		}
+		break;
+	case RMNET_QUEUE_ENABLE:
+	case RMNET_QUEUE_DISABLE:
+		p = xa_load(&priv->queue_map, mark);
+		if (p && xa_is_value(p)) {
+			txq = xa_to_value(p);
+
+			q = netdev_get_tx_queue(dev, txq);
+			if (unlikely(!q)) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "unsupported queue mapping");
+				return -EINVAL;
+			}
+
+			if (operation == RMNET_QUEUE_ENABLE)
+				netif_tx_wake_queue(q);
+			else
+				netif_tx_stop_queue(q);
+		} else {
+			NL_SET_ERR_MSG_MOD(extack, "invalid queue mapping");
+			return -EINVAL;
+		}
+		break;
+	default:
+		NL_SET_ERR_MSG_MOD(extack, "unsupported operation");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void rmnet_unregister_bridge(struct rmnet_port *port)
 {
 	struct net_device *bridge_dev, *real_dev, *rmnet_dev;
@@ -175,8 +237,24 @@ static int rmnet_newlink(struct net *src_net, struct net_device *dev,
 	netdev_dbg(dev, "data format [0x%08X]\n", data_format);
 	port->data_format = data_format;
 
+	if (data[IFLA_RMNET_QUEUE]) {
+		struct rmnet_queue_mapping *queue_map;
+
+		queue_map = nla_data(data[IFLA_RMNET_QUEUE]);
+		if (rmnet_update_queue_map(dev, queue_map->operation,
+					   queue_map->txqueue, queue_map->mark,
+					   extack))
+			goto err3;
+
+		netdev_dbg(dev, "op %02x txq %02x mark %08x\n",
+			   queue_map->operation, queue_map->txqueue,
+			   queue_map->mark);
+	}
+
 	return 0;
 
+err3:
+	hlist_del_init_rcu(&ep->hlnode);
 err2:
 	unregister_netdevice(dev);
 	rmnet_vnd_dellink(mux_id, port, ep);
@@ -352,6 +430,20 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 		}
 	}
 
+	if (data[IFLA_RMNET_QUEUE]) {
+		struct rmnet_queue_mapping *queue_map;
+
+		queue_map = nla_data(data[IFLA_RMNET_QUEUE]);
+		if (rmnet_update_queue_map(dev, queue_map->operation,
+					   queue_map->txqueue, queue_map->mark,
+					   extack))
+			return -EINVAL;
+
+		netdev_dbg(dev, "op %02x txq %02x mark %08x\n",
+			   queue_map->operation, queue_map->txqueue,
+			   queue_map->mark);
+	}
+
 	return 0;
 }
 
@@ -361,7 +453,9 @@ static size_t rmnet_get_size(const struct net_device *dev)
 		/* IFLA_RMNET_MUX_ID */
 		nla_total_size(2) +
 		/* IFLA_RMNET_FLAGS */
-		nla_total_size(sizeof(struct ifla_rmnet_flags));
+		nla_total_size(sizeof(struct ifla_rmnet_flags)) +
+		/* IFLA_RMNET_QUEUE */
+		nla_total_size(sizeof(struct rmnet_queue_mapping));
 }
 
 static int rmnet_fill_info(struct sk_buff *skb, const struct net_device *dev)
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
index ed112d51ac5a..ae8300fc5ed7 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright (c) 2013-2014, 2016-2018, 2021 The Linux Foundation.
  * All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  *
  * RMNET Data configuration engine
  */
@@ -87,6 +88,7 @@ struct rmnet_priv {
 	struct rmnet_pcpu_stats __percpu *pcpu_stats;
 	struct gro_cells gro_cells;
 	struct rmnet_priv_stats stats;
+	struct xarray queue_map;
 };
 
 struct rmnet_port *rmnet_get_port_rcu(struct net_device *real_dev);
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 046b5f7d8e7c..cd82613f56f0 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2013-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  *
  * RMNET Data virtual network driver
  */
@@ -158,6 +159,23 @@ static void rmnet_get_stats64(struct net_device *dev,
 	s->tx_dropped = total_stats.tx_drops;
 }
 
+static u16 rmnet_vnd_select_queue(struct net_device *dev,
+				  struct sk_buff *skb,
+				  struct net_device *sb_dev)
+{
+	struct rmnet_priv *priv = netdev_priv(dev);
+	void *p = xa_load(&priv->queue_map, skb->mark);
+	u8 txq;
+
+	if (!p || !xa_is_value(p))
+		return 0;
+
+	txq = xa_to_value(p);
+
+	netdev_dbg(dev, "mark %08x -> txq %02x\n", skb->mark, txq);
+	return txq;
+}
+
 static const struct net_device_ops rmnet_vnd_ops = {
 	.ndo_start_xmit = rmnet_vnd_start_xmit,
 	.ndo_change_mtu = rmnet_vnd_change_mtu,
@@ -167,6 +185,7 @@ static const struct net_device_ops rmnet_vnd_ops = {
 	.ndo_init       = rmnet_vnd_init,
 	.ndo_uninit     = rmnet_vnd_uninit,
 	.ndo_get_stats64 = rmnet_get_stats64,
+	.ndo_select_queue = rmnet_vnd_select_queue,
 };
 
 static const char rmnet_gstrings_stats[][ETH_GSTRING_LEN] = {
@@ -334,6 +353,8 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
 
 		priv->mux_id = id;
 
+		xa_init(&priv->queue_map);
+
 		netdev_dbg(rmnet_dev, "rmnet dev created\n");
 	}
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index fac351a93aed..452867d5246a 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1368,6 +1368,7 @@ enum {
 	IFLA_RMNET_UNSPEC,
 	IFLA_RMNET_MUX_ID,
 	IFLA_RMNET_FLAGS,
+	IFLA_RMNET_QUEUE,
 	__IFLA_RMNET_MAX,
 };
 
@@ -1378,6 +1379,21 @@ struct ifla_rmnet_flags {
 	__u32	mask;
 };
 
+enum {
+	RMNET_QUEUE_OPERATION_UNSPEC,
+	RMNET_QUEUE_MAPPING_ADD,	/* Add new queue <-> mark mapping */
+	RMNET_QUEUE_MAPPING_REMOVE,	/* Remove queue <-> mark mapping */
+	RMNET_QUEUE_ENABLE,		/* Allow traffic on an existing queue */
+	RMNET_QUEUE_DISABLE,		/* Stop traffic on an existing queue */
+};
+
+struct rmnet_queue_mapping {
+	__u8	operation;
+	__u8	txqueue;
+	__u16	padding;
+	__u32	mark;
+};
+
 /* MCTP section */
 
 enum {
-- 
2.34.1


