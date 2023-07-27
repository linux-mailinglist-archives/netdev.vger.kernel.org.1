Return-Path: <netdev+bounces-21863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3622C7651C3
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B11282268
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8F713AE9;
	Thu, 27 Jul 2023 10:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8F4107BC
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:58:24 +0000 (UTC)
X-Greylist: delayed 1015 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 03:58:23 PDT
Received: from mint-fitpc2.localdomain (unknown [81.168.73.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 203611FED
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 03:58:22 -0700 (PDT)
Received: from palantir17.mph.net (palantir17 [192.168.0.4])
	by mint-fitpc2.localdomain (Postfix) with ESMTP id 1FFB2321ACE;
	Thu, 27 Jul 2023 11:41:16 +0100 (BST)
Received: from localhost ([::1] helo=palantir17.mph.net)
	by palantir17.mph.net with esmtp (Exim 4.95)
	(envelope-from <habetsm.xilinx@gmail.com>)
	id 1qOyQl-0002YH-TV;
	Thu, 27 Jul 2023 11:41:15 +0100
Subject: [PATCH net-next 07/11] sfc: Filter cleanups for Falcon and Siena
From: Martin Habets <habetsm.xilinx@gmail.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com
Date: Thu, 27 Jul 2023 11:41:15 +0100
Message-ID: <169045447582.9625.7375273361417055918.stgit@palantir17.mph.net>
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

unicast_filter and multicast_hash are no longer needed.

Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/mcdi_port_common.c |    5 -----
 drivers/net/ethernet/sfc/net_driver.h       |   18 ------------------
 2 files changed, 23 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mcdi_port_common.c b/drivers/net/ethernet/sfc/mcdi_port_common.c
index 0ab14f3d01d4..76ea26722ca4 100644
--- a/drivers/net/ethernet/sfc/mcdi_port_common.c
+++ b/drivers/net/ethernet/sfc/mcdi_port_common.c
@@ -1106,11 +1106,6 @@ int efx_mcdi_set_mac(struct efx_nic *efx)
 
 	MCDI_SET_DWORD(cmdbytes, SET_MAC_IN_MTU, efx_calc_mac_mtu(efx));
 	MCDI_SET_DWORD(cmdbytes, SET_MAC_IN_DRAIN, 0);
-
-	/* Set simple MAC filter for Siena */
-	MCDI_POPULATE_DWORD_1(cmdbytes, SET_MAC_IN_REJECT,
-			      SET_MAC_IN_REJECT_UNCST, efx->unicast_filter);
-
 	MCDI_POPULATE_DWORD_1(cmdbytes, SET_MAC_IN_FLAGS,
 			      SET_MAC_IN_FLAG_INCLUDE_FCS,
 			      !!(efx->net_dev->features & NETIF_F_RXFCS));
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 474ee577bf0f..6654fbb8f4c0 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -752,18 +752,6 @@ struct efx_hw_stat_desc {
 	u16 offset;
 };
 
-/* Number of bits used in a multicast filter hash address */
-#define EFX_MCAST_HASH_BITS 8
-
-/* Number of (single-bit) entries in a multicast filter hash */
-#define EFX_MCAST_HASH_ENTRIES (1 << EFX_MCAST_HASH_BITS)
-
-/* An Efx multicast filter hash */
-union efx_multicast_hash {
-	u8 byte[EFX_MCAST_HASH_ENTRIES / 8];
-	efx_oword_t oword[EFX_MCAST_HASH_ENTRIES / sizeof(efx_oword_t) / 8];
-};
-
 struct vfdi_status;
 
 /* The reserved RSS context value */
@@ -955,10 +943,6 @@ struct efx_mae;
  *	see &enum ethtool_fec_config_bits.
  * @link_state: Current state of the link
  * @n_link_state_changes: Number of times the link has changed state
- * @unicast_filter: Flag for Falcon-arch simple unicast filter.
- *	Protected by @mac_lock.
- * @multicast_hash: Multicast hash table for Falcon-arch.
- *	Protected by @mac_lock.
  * @wanted_fc: Wanted flow control flags
  * @fc_disable: When non-zero flow control is disabled. Typically used to
  *	ensure that network back pressure doesn't delay dma queue flushes.
@@ -1137,8 +1121,6 @@ struct efx_nic {
 	struct efx_link_state link_state;
 	unsigned int n_link_state_changes;
 
-	bool unicast_filter;
-	union efx_multicast_hash multicast_hash;
 	u8 wanted_fc;
 	unsigned fc_disable;
 



