Return-Path: <netdev+bounces-15652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE77E748EE8
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 22:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3881C20C2D
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A608915AF8;
	Wed,  5 Jul 2023 20:24:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B766168D1
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 20:24:48 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35084173F
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688588687; x=1720124687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fVL8wn6x12HrkV3VkKsHhRcnh6/uKJ/a6NotRo8qTr4=;
  b=mt3lyjAb61IbMAnG6UgOkHX0/RF9dCLBnK6y5OQ0yvBVbxtebuEB0/2m
   2aj7CY6eXcaoqm1rjJzeIQwxezKRky4wo1oNF+wNSuz+xhuQltylGSAXq
   OJ/bWsDdmiMbjKNKEJJtxfkrapAaqPIPqh0NSYUzy4jwf8xzAhhe1VzCm
   TpOhp+PdCAs0dAsvKadpfUJmk/Ys33R6+erCJfBWOioar2PL+DexIytLU
   nUui2aM8OPg+tT/JRRioSVpsxmj6SfWwRZm6K79hsAQCHjCqeQ8dJeKJu
   Uy06Yt9Okhf1/slMtDVy50s8wUu3+/MNFs9mcKjyhO9QulnQ/TwAx5Sfr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362303247"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="362303247"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 13:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="809380442"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="809380442"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jul 2023 13:24:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tan Tee Min <tee.min.tan@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 5/6] igc: Include the length/type field and VLAN tag in queueMaxSDU
Date: Wed,  5 Jul 2023 13:19:04 -0700
Message-Id: <20230705201905.49570-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230705201905.49570-1-anthony.l.nguyen@intel.com>
References: <20230705201905.49570-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tan Tee Min <tee.min.tan@linux.intel.com>

IEEE 802.1Q does not have clear definitions of what constitutes an
SDU (Service Data Unit), but IEEE Std 802.3 clause 3.1.2 does define
the MAC service primitives and clause 3.2.7 does define the MAC Client
Data for Q-tagged frames.

It shows that the mac_service_data_unit (MSDU) does NOT contain the
preamble, destination and source address, or FCS. The MSDU does contain
the length/type field, MAC client data, VLAN tag and any padding
data (prior to the FCS).

Thus, the maximum 802.3 frame size that is allowed to be transmitted
should be QueueMaxSDU (MSDU) + 16 (6 byte SA + 6 byte DA + 4 byte FCS).

Fixes: 92a0dcb8427d ("igc: offload queue max SDU from tc-taprio")
Signed-off-by: Tan Tee Min <tee.min.tan@linux.intel.com>
Reviewed-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e5bfc4000658..281a0e35b9d1 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1575,16 +1575,9 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	if (adapter->qbv_transition || tx_ring->oper_gate_closed)
 		goto out_drop;
 
-	if (tx_ring->max_sdu > 0) {
-		u32 max_sdu = 0;
-
-		max_sdu = tx_ring->max_sdu +
-			  (skb_vlan_tagged(first->skb) ? VLAN_HLEN : 0);
-
-		if (first->bytecount > max_sdu) {
-			adapter->stats.txdrop++;
-			goto out_drop;
-		}
+	if (tx_ring->max_sdu > 0 && first->bytecount > tx_ring->max_sdu) {
+		adapter->stats.txdrop++;
+		goto out_drop;
 	}
 
 	if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
@@ -6231,7 +6224,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 		struct net_device *dev = adapter->netdev;
 
 		if (qopt->max_sdu[i])
-			ring->max_sdu = qopt->max_sdu[i] + dev->hard_header_len;
+			ring->max_sdu = qopt->max_sdu[i] + dev->hard_header_len - ETH_TLEN;
 		else
 			ring->max_sdu = 0;
 	}
-- 
2.38.1


