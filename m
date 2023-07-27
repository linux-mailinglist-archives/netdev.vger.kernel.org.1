Return-Path: <netdev+bounces-21864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7117651C7
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC396282245
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8594B154B3;
	Thu, 27 Jul 2023 10:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17B154A9
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:58:25 +0000 (UTC)
Received: from mint-fitpc2.localdomain (unknown [81.168.73.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A0EC2719
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 03:58:22 -0700 (PDT)
Received: from palantir17.mph.net (palantir17 [192.168.0.4])
	by mint-fitpc2.localdomain (Postfix) with ESMTP id D05A9321ACC;
	Thu, 27 Jul 2023 11:41:10 +0100 (BST)
Received: from localhost ([::1] helo=palantir17.mph.net)
	by palantir17.mph.net with esmtp (Exim 4.95)
	(envelope-from <habetsm.xilinx@gmail.com>)
	id 1qOyQg-0002Y7-Hu;
	Thu, 27 Jul 2023 11:41:10 +0100
Subject: [PATCH net-next 06/11] sfc: Remove some NIC type indirections that
 are no longer needed
From: Martin Habets <habetsm.xilinx@gmail.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com
Date: Thu, 27 Jul 2023 11:41:10 +0100
Message-ID: <169045447045.9625.16700954187003104115.stgit@palantir17.mph.net>
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

The special handling for SRIOV reset and FLR is not needed on EF10.

Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef10.c       |    2 --
 drivers/net/ethernet/sfc/ef10_sriov.h |    2 --
 drivers/net/ethernet/sfc/efx_common.c |    2 --
 drivers/net/ethernet/sfc/mcdi.c       |    5 -----
 drivers/net/ethernet/sfc/net_driver.h |    8 --------
 5 files changed, 19 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 8c019f382a7f..fca0cf338510 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -4267,8 +4267,6 @@ const struct efx_nic_type efx_hunt_a0_nic_type = {
 	.sriov_init = efx_ef10_sriov_init,
 	.sriov_fini = efx_ef10_sriov_fini,
 	.sriov_wanted = efx_ef10_sriov_wanted,
-	.sriov_reset = efx_ef10_sriov_reset,
-	.sriov_flr = efx_ef10_sriov_flr,
 	.sriov_set_vf_mac = efx_ef10_sriov_set_vf_mac,
 	.sriov_set_vf_vlan = efx_ef10_sriov_set_vf_vlan,
 	.sriov_set_vf_spoofchk = efx_ef10_sriov_set_vf_spoofchk,
diff --git a/drivers/net/ethernet/sfc/ef10_sriov.h b/drivers/net/ethernet/sfc/ef10_sriov.h
index 3c703ca878b0..be419c9c5dec 100644
--- a/drivers/net/ethernet/sfc/ef10_sriov.h
+++ b/drivers/net/ethernet/sfc/ef10_sriov.h
@@ -35,9 +35,7 @@ static inline bool efx_ef10_sriov_wanted(struct efx_nic *efx)
 
 int efx_ef10_sriov_configure(struct efx_nic *efx, int num_vfs);
 int efx_ef10_sriov_init(struct efx_nic *efx);
-static inline void efx_ef10_sriov_reset(struct efx_nic *efx) {}
 void efx_ef10_sriov_fini(struct efx_nic *efx);
-static inline void efx_ef10_sriov_flr(struct efx_nic *efx, unsigned vf_i) {}
 
 int efx_ef10_sriov_set_vf_mac(struct efx_nic *efx, int vf, const u8 *mac);
 
diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
index 361687de308d..c8d8f1e9a21a 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -785,8 +785,6 @@ int efx_reset_up(struct efx_nic *efx, enum reset_type method, bool ok)
 	mutex_unlock(&efx->rss_lock);
 	efx->type->filter_table_restore(efx);
 	up_write(&efx->filter_sem);
-	if (efx->type->sriov_reset)
-		efx->type->sriov_reset(efx);
 
 	mutex_unlock(&efx->mac_lock);
 
diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
index f7ffaa14fda4..d23da9627338 100644
--- a/drivers/net/ethernet/sfc/mcdi.c
+++ b/drivers/net/ethernet/sfc/mcdi.c
@@ -1352,11 +1352,6 @@ void efx_mcdi_process_event(struct efx_channel *channel,
 	case MCDI_EVENT_CODE_MAC_STATS_DMA:
 		/* MAC stats are gather lazily.  We can ignore this. */
 		break;
-	case MCDI_EVENT_CODE_FLR:
-		if (efx->type->sriov_flr)
-			efx->type->sriov_flr(efx,
-					     MCDI_EVENT_FIELD(*event, FLR_VF));
-		break;
 	case MCDI_EVENT_CODE_PTP_FAULT:
 	case MCDI_EVENT_CODE_PTP_PPS:
 		efx_ptp_event(efx, event);
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 25013caaeefb..474ee577bf0f 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1261,10 +1261,6 @@ struct efx_udp_tunnel {
  * @remove_port: Free resources allocated by probe_port()
  * @handle_global_event: Handle a "global" event (may be %NULL)
  * @fini_dmaq: Flush and finalise DMA queues (RX and TX queues)
- * @prepare_flush: Prepare the hardware for flushing the DMA queues
- *	(for Falcon architecture)
- * @finish_flush: Clean up after flushing the DMA queues (for Falcon
- *	architecture)
  * @prepare_flr: Prepare for an FLR
  * @finish_flr: Clean up after an FLR
  * @describe_stats: Describe statistics for ethtool
@@ -1411,8 +1407,6 @@ struct efx_nic_type {
 	void (*remove_port)(struct efx_nic *efx);
 	bool (*handle_global_event)(struct efx_channel *channel, efx_qword_t *);
 	int (*fini_dmaq)(struct efx_nic *efx);
-	void (*prepare_flush)(struct efx_nic *efx);
-	void (*finish_flush)(struct efx_nic *efx);
 	void (*prepare_flr)(struct efx_nic *efx);
 	void (*finish_flr)(struct efx_nic *efx);
 	size_t (*describe_stats)(struct efx_nic *efx, u8 *names);
@@ -1528,8 +1522,6 @@ struct efx_nic_type {
 	int (*sriov_init)(struct efx_nic *efx);
 	void (*sriov_fini)(struct efx_nic *efx);
 	bool (*sriov_wanted)(struct efx_nic *efx);
-	void (*sriov_reset)(struct efx_nic *efx);
-	void (*sriov_flr)(struct efx_nic *efx, unsigned vf_i);
 	int (*sriov_set_vf_mac)(struct efx_nic *efx, int vf_i, const u8 *mac);
 	int (*sriov_set_vf_vlan)(struct efx_nic *efx, int vf_i, u16 vlan,
 				 u8 qos);



