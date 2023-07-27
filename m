Return-Path: <netdev+bounces-21870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF327651D4
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502171C215BF
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24893168A5;
	Thu, 27 Jul 2023 10:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FAF168A0
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:58:28 +0000 (UTC)
Received: from mint-fitpc2.localdomain (unknown [81.168.73.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C76BC271F
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 03:58:25 -0700 (PDT)
Received: from palantir17.mph.net (palantir17 [192.168.0.4])
	by mint-fitpc2.localdomain (Postfix) with ESMTP id EA11E321AC9;
	Thu, 27 Jul 2023 11:40:54 +0100 (BST)
Received: from localhost ([::1] helo=palantir17.mph.net)
	by palantir17.mph.net with esmtp (Exim 4.95)
	(envelope-from <habetsm.xilinx@gmail.com>)
	id 1qOyQQ-0002Xd-C2;
	Thu, 27 Jul 2023 11:40:54 +0100
Subject: [PATCH net-next 03/11] sfc: Remove support for siena high priority
 queue
From: Martin Habets <habetsm.xilinx@gmail.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com
Date: Thu, 27 Jul 2023 11:40:54 +0100
Message-ID: <169045445398.9625.14203742535724682000.stgit@palantir17.mph.net>
In-Reply-To: <169045436482.9625.4994454326362709391.stgit@palantir17.mph.net>
References: <169045436482.9625.4994454326362709391.stgit@palantir17.mph.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_GMAIL_RCVD,FREEMAIL_FROM,KHOP_HELO_FCRDNS,MAY_BE_FORGED,
	NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This also removes TC support code, since that was never supported for EF10.
TC support for EF100 is not handled from efx.c.

Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx.c        |    1 -
 drivers/net/ethernet/sfc/efx.h        |    2 -
 drivers/net/ethernet/sfc/net_driver.h |    4 +--
 drivers/net/ethernet/sfc/tx.c         |   45 +--------------------------------
 4 files changed, 2 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index d670a319b379..19f4b4d0b851 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -605,7 +605,6 @@ static const struct net_device_ops efx_netdev_ops = {
 #endif
 	.ndo_get_phys_port_id   = efx_get_phys_port_id,
 	.ndo_get_phys_port_name	= efx_get_phys_port_name,
-	.ndo_setup_tc		= efx_setup_tc,
 #ifdef CONFIG_RFS_ACCEL
 	.ndo_rx_flow_steer	= efx_filter_rfs,
 #endif
diff --git a/drivers/net/ethernet/sfc/efx.h b/drivers/net/ethernet/sfc/efx.h
index 4239c7ece123..48d3623735ba 100644
--- a/drivers/net/ethernet/sfc/efx.h
+++ b/drivers/net/ethernet/sfc/efx.h
@@ -30,8 +30,6 @@ static inline netdev_tx_t efx_enqueue_skb(struct efx_tx_queue *tx_queue, struct
 			       tx_queue, skb);
 }
 void efx_xmit_done_single(struct efx_tx_queue *tx_queue);
-int efx_setup_tc(struct net_device *net_dev, enum tc_setup_type type,
-		 void *type_data);
 extern unsigned int efx_piobuf_size;
 
 /* RX */
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index b64a68a51050..25013caaeefb 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -67,9 +67,7 @@
 #define EFX_MAX_CORE_TX_QUEUES	(EFX_MAX_TX_TC * EFX_MAX_CHANNELS)
 #define EFX_TXQ_TYPE_OUTER_CSUM	1	/* Outer checksum offload */
 #define EFX_TXQ_TYPE_INNER_CSUM	2	/* Inner checksum offload */
-#define EFX_TXQ_TYPE_HIGHPRI	4	/* High-priority (for TC) */
-#define EFX_TXQ_TYPES		8
-/* HIGHPRI is Siena-only, and INNER_CSUM is EF10, so no need for both */
+#define EFX_TXQ_TYPES		4
 #define EFX_MAX_TXQ_PER_CHANNEL	4
 #define EFX_MAX_TX_QUEUES	(EFX_MAX_TXQ_PER_CHANNEL * EFX_MAX_CHANNELS)
 
diff --git a/drivers/net/ethernet/sfc/tx.c b/drivers/net/ethernet/sfc/tx.c
index 4ed4082836a9..fe2d476028e7 100644
--- a/drivers/net/ethernet/sfc/tx.c
+++ b/drivers/net/ethernet/sfc/tx.c
@@ -517,13 +517,8 @@ netdev_tx_t efx_hard_start_xmit(struct sk_buff *skb,
 	unsigned index, type;
 
 	EFX_WARN_ON_PARANOID(!netif_device_present(net_dev));
-
 	index = skb_get_queue_mapping(skb);
 	type = efx_tx_csum_type_skb(skb);
-	if (index >= efx->n_tx_channels) {
-		index -= efx->n_tx_channels;
-		type |= EFX_TXQ_TYPE_HIGHPRI;
-	}
 
 	/* PTP "event" packet */
 	if (unlikely(efx_xmit_with_hwtstamp(skb)) &&
@@ -603,43 +598,5 @@ void efx_init_tx_queue_core_txq(struct efx_tx_queue *tx_queue)
 	/* Must be inverse of queue lookup in efx_hard_start_xmit() */
 	tx_queue->core_txq =
 		netdev_get_tx_queue(efx->net_dev,
-				    tx_queue->channel->channel +
-				    ((tx_queue->type & EFX_TXQ_TYPE_HIGHPRI) ?
-				     efx->n_tx_channels : 0));
-}
-
-int efx_setup_tc(struct net_device *net_dev, enum tc_setup_type type,
-		 void *type_data)
-{
-	struct efx_nic *efx = efx_netdev_priv(net_dev);
-	struct tc_mqprio_qopt *mqprio = type_data;
-	unsigned tc, num_tc;
-
-	if (type != TC_SETUP_QDISC_MQPRIO)
-		return -EOPNOTSUPP;
-
-	/* Only Siena supported highpri queues */
-	if (efx_nic_rev(efx) > EFX_REV_SIENA_A0)
-		return -EOPNOTSUPP;
-
-	num_tc = mqprio->num_tc;
-
-	if (num_tc > EFX_MAX_TX_TC)
-		return -EINVAL;
-
-	mqprio->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
-
-	if (num_tc == net_dev->num_tc)
-		return 0;
-
-	for (tc = 0; tc < num_tc; tc++) {
-		net_dev->tc_to_txq[tc].offset = tc * efx->n_tx_channels;
-		net_dev->tc_to_txq[tc].count = efx->n_tx_channels;
-	}
-
-	net_dev->num_tc = num_tc;
-
-	return netif_set_real_num_tx_queues(net_dev,
-					    max_t(int, num_tc, 1) *
-					    efx->n_tx_channels);
+				    tx_queue->channel->channel);
 }



