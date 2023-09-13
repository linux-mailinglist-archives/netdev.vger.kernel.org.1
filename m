Return-Path: <netdev+bounces-33654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6594379F0DA
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 20:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209AA28060F
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 18:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2CB200DE;
	Wed, 13 Sep 2023 18:04:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB3B200D2
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 18:04:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F0919BB
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694628266; x=1726164266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QyYLIif5LNoMNg4j2gxbRukKDXmGrWFYxEqdO7nWWb4=;
  b=N+Zso0OGvqR+1RPPCd9epoFGKMehg+/6hAbLwa6wrhdqDaC9gzI69VP0
   VB3H7KAYKaHaKYgdnO9VEeZL2JkW6SWNSEbgrw+uNMiO2T/53HHnlAVNn
   bMxq9j2Eeca8W/c+yxqdPnrvlV8Wm+1kgVAFAwwmXjGMOJj9xvb9w6Ayd
   ew258450lw+CrqxK9bYrVaMYVS8PpLRdVgOM7L7t9lYjQ4Cfe3HfwvO0O
   UgfTOOWWOostsS/qYo/mTXbRoQjbObc3WxqapkKN9WhVLpN4ndV9up/b4
   E0eZSKd2/9gDwUQu73vmx4iCanbKWrt3VprCcw5w89A7AiaADmkoZpP17
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378658454"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378658454"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:03:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747417165"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="747417165"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2023 11:03:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Haiyue Wang <haiyue.wang@intel.com>,
	anthony.l.nguyen@intel.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 2/4] ice: Support FCS/CRC strip disable for VF
Date: Wed, 13 Sep 2023 11:03:32 -0700
Message-Id: <20230913180334.2116162-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913180334.2116162-1-anthony.l.nguyen@intel.com>
References: <20230913180334.2116162-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haiyue Wang <haiyue.wang@intel.com>

To support CRC strip enable/disable functionality, VF needs the explicit
request VIRTCHNL_VF_OFFLOAD_CRC offload. Then according to crc_disable
flag of Rx queue configuration information to set up the queue context.

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index b03426ac932b..c0c3e524c523 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -486,6 +486,9 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_REQ_QUEUES)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_REQ_QUEUES;
 
+	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_CRC)
+		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_CRC;
+
 	if (vf->driver_caps & VIRTCHNL_VF_CAP_ADV_LINK_SPEED)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_CAP_ADV_LINK_SPEED;
 
@@ -1666,6 +1669,18 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 			vsi->rx_rings[i]->dma = qpi->rxq.dma_ring_addr;
 			vsi->rx_rings[i]->count = qpi->rxq.ring_len;
 
+			if (qpi->rxq.crc_disable &&
+			    !(vf->driver_caps & VIRTCHNL_VF_OFFLOAD_CRC)) {
+				goto error_param;
+			}
+
+			if (qpi->rxq.crc_disable)
+				vsi->rx_rings[q_idx]->flags |=
+					ICE_RX_FLAGS_CRC_STRIP_DIS;
+			else
+				vsi->rx_rings[q_idx]->flags &=
+					~ICE_RX_FLAGS_CRC_STRIP_DIS;
+
 			if (qpi->rxq.databuffer_size != 0 &&
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
 			     qpi->rxq.databuffer_size < 1024))
-- 
2.38.1


