Return-Path: <netdev+bounces-33653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF0579F0D5
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 20:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFE31C20356
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 18:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7B3200D3;
	Wed, 13 Sep 2023 18:04:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1123200D2
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 18:04:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163A119AE
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694628265; x=1726164265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sr8qQa64VFu9g5TTyOwEKai0ffV+/veG3Y5mIeIWKaA=;
  b=fa4R+y3zgGKvjUNlIdQYIjLjFD6nKoaivm9duTAHe6AjOwN9Y+DlEKhv
   9Jitlp3wCo6vs7DdZe3sXRBGnXovMjjNUMwMWFrICHLuegh/+4fq+TdCH
   MbOxjdYH0XOWb/FrnSxs143SNWCJtrXbFjCM4SdihOrriYREt3Yv796Ek
   ZzqXnlOdKoWwZCUABFPw+BdfJm/92iI2C9EkdsZ0Ha0EtRT4vhrjO0AHR
   tkt3V8kkJOBwaNGhdxQ0JsSAJTEaSbOwYiO8xbnXFap9TjmVhUOj1+NeM
   EOX4Xen48A9KtvrD7vizCP0Ty1nP88Wvka9W7RCNdGjhjz118vT9bB3yT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378658442"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378658442"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747417161"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="747417161"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2023 11:03:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	anthony.l.nguyen@intel.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next 1/4] virtchnl: Add CRC stripping capability
Date: Wed, 13 Sep 2023 11:03:31 -0700
Message-Id: <20230913180334.2116162-2-anthony.l.nguyen@intel.com>
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

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

Some VFs may want to disable CRC stripping on incoming packets so create
an offload for that. The VF already sends information about configuring
its RX queues so use that structure to indicate that the CRC stripping
should be enabled or not.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/linux/avf/virtchnl.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index d0807ad43f93..dd71d3009771 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -240,6 +240,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_vsi_resource);
 #define VIRTCHNL_VF_OFFLOAD_REQ_QUEUES		BIT(6)
 /* used to negotiate communicating link speeds in Mbps */
 #define VIRTCHNL_VF_CAP_ADV_LINK_SPEED		BIT(7)
+#define  VIRTCHNL_VF_OFFLOAD_CRC		BIT(10)
 #define VIRTCHNL_VF_OFFLOAD_VLAN_V2		BIT(15)
 #define VIRTCHNL_VF_OFFLOAD_VLAN		BIT(16)
 #define VIRTCHNL_VF_OFFLOAD_RX_POLLING		BIT(17)
@@ -295,7 +296,13 @@ VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_txq_info);
 /* VIRTCHNL_OP_CONFIG_RX_QUEUE
  * VF sends this message to set up parameters for one RX queue.
  * External data buffer contains one instance of virtchnl_rxq_info.
- * PF configures requested queue and returns a status code.
+ * PF configures requested queue and returns a status code. The
+ * crc_disable flag disables CRC stripping on the VF. Setting
+ * the crc_disable flag to 1 will disable CRC stripping for each
+ * queue in the VF where the flag is set. The VIRTCHNL_VF_OFFLOAD_CRC
+ * offload must have been set prior to sending this info or the PF
+ * will ignore the request. This flag should be set the same for
+ * all of the queues for a VF.
  */
 
 /* Rx queue config info */
@@ -307,7 +314,7 @@ struct virtchnl_rxq_info {
 	u16 splithdr_enabled; /* deprecated with AVF 1.0 */
 	u32 databuffer_size;
 	u32 max_pkt_size;
-	u8 pad0;
+	u8 crc_disable;
 	u8 rxdid;
 	u8 pad1[2];
 	u64 dma_ring_addr;
-- 
2.38.1


