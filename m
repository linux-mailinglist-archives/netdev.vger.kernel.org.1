Return-Path: <netdev+bounces-28246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E003577EB81
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D85F1C20311
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD3E1AA7D;
	Wed, 16 Aug 2023 21:14:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704FF1AA76
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:14:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F962128
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692220443; x=1723756443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rfjAe+SMHEPkIiJXwuyI+Fbekrv+t16DKdVGK+AMXw=;
  b=jQt3tDQ84oEb08Xg/meXcESTFfor6125Zp6lPXrD1htRecOKpX+Fr+6x
   dlHns3VMwsblFfxrMvwkfBYSn8XGKQBssI4lqt6pfCsY7/F9btF0Sz/tU
   fvId1Iuu0VudtO0ZCk3fEM9fv0ridT8fQ+h3WsTNg03zH/RWD+itVxFAB
   ytkpO0iIhe9Cf0zR1PYAGLPyyyszU3w7yiFVSSUFmlqtTeVFPJF/1kgr8
   0/3Zz1dVucZJjJPncgJcx1jmztJ62GwQ/txXiKIHjWDF4hhFaWVIwztou
   0kp3sWuQzygpfgMhl1hId9fGFBp3PhPAHDQDBpbjotil+3hv+DFvUmQv7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352223502"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="352223502"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 14:13:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763765540"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="763765540"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2023 14:13:56 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	andriy.shevchenko@linux.intel.com,
	larysa.zaremba@intel.com,
	keescook@chromium.org,
	gustavoars@kernel.org,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 3/3] virtchnl: fix fake 1-elem arrays for structures allocated as `nents`
Date: Wed, 16 Aug 2023 14:06:57 -0700
Message-Id: <20230816210657.1326772-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816210657.1326772-1-anthony.l.nguyen@intel.com>
References: <20230816210657.1326772-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Finally, fix 3 structures which are allocated technically correctly,
i.e. the calculated size equals to the one that struct_size() would
return, except for sizeof(). For &virtchnl_vlan_filter_list_v2, use
the same approach when there are no enough space as taken previously
for &virtchnl_vlan_filter_list, i.e. let the maximum size be calculated
automatically instead of trying to guestimate it using maths.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  7 ++--
 drivers/net/ethernet/intel/iavf/iavf_client.c |  4 +-
 drivers/net/ethernet/intel/iavf/iavf_client.h |  2 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 25 +++++-------
 include/linux/avf/virtchnl.h                  | 39 ++++++++++++-------
 5 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index a6983c2d7c30..8ea1a238dcef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -506,6 +506,7 @@ i40e_config_rdma_qvlist(struct i40e_vf *vf,
 	struct virtchnl_rdma_qv_info *qv_info;
 	u32 v_idx, i, reg_idx, reg;
 	u32 next_q_idx, next_q_type;
+	size_t size;
 	u32 msix_vf;
 	int ret = 0;
 
@@ -521,9 +522,9 @@ i40e_config_rdma_qvlist(struct i40e_vf *vf,
 	}
 
 	kfree(vf->qvlist_info);
-	vf->qvlist_info = kzalloc(struct_size(vf->qvlist_info, qv_info,
-					      qvlist_info->num_vectors - 1),
-				  GFP_KERNEL);
+	size = virtchnl_struct_size(vf->qvlist_info, qv_info,
+				    qvlist_info->num_vectors);
+	vf->qvlist_info = kzalloc(size, GFP_KERNEL);
 	if (!vf->qvlist_info) {
 		ret = -ENOMEM;
 		goto err_out;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_client.c b/drivers/net/ethernet/intel/iavf/iavf_client.c
index 93c903c02c64..e6051b6355aa 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_client.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_client.c
@@ -469,8 +469,8 @@ static int iavf_client_setup_qvlist(struct iavf_info *ldev,
 	}
 
 	v_qvlist_info = (struct virtchnl_rdma_qvlist_info *)qvlist_info;
-	msg_size = struct_size(v_qvlist_info, qv_info,
-			       v_qvlist_info->num_vectors - 1);
+	msg_size = virtchnl_struct_size(v_qvlist_info, qv_info,
+					v_qvlist_info->num_vectors);
 
 	adapter->client_pending |= BIT(VIRTCHNL_OP_CONFIG_RDMA_IRQ_MAP);
 	err = iavf_aq_send_msg_to_pf(&adapter->hw,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_client.h b/drivers/net/ethernet/intel/iavf/iavf_client.h
index c5d51d7dc7cc..500269bc0f5b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_client.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_client.h
@@ -53,7 +53,7 @@ struct iavf_qv_info {
 
 struct iavf_qvlist_info {
 	u32 num_vectors;
-	struct iavf_qv_info qv_info[1];
+	struct iavf_qv_info qv_info[];
 };
 
 #define IAVF_CLIENT_MSIX_ALL 0xFFFFFFFF
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 4fdac698eb38..f9727e9c3d63 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -727,15 +727,12 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 			more = true;
 		}
 
-		len = sizeof(*vvfl_v2) + ((count - 1) *
-					  sizeof(struct virtchnl_vlan_filter));
+		len = virtchnl_struct_size(vvfl_v2, filters, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
 			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
-			count = (IAVF_MAX_AQ_BUF_SIZE - sizeof(*vvfl_v2)) /
-				sizeof(struct virtchnl_vlan_filter);
-			len = sizeof(*vvfl_v2) +
-				((count - 1) *
-				 sizeof(struct virtchnl_vlan_filter));
+			while (len > IAVF_MAX_AQ_BUF_SIZE)
+				len = virtchnl_struct_size(vvfl_v2, filters,
+							   --count);
 			more = true;
 		}
 
@@ -879,16 +876,12 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		adapter->current_op = VIRTCHNL_OP_DEL_VLAN_V2;
 
-		len = sizeof(*vvfl_v2) +
-			((count - 1) * sizeof(struct virtchnl_vlan_filter));
+		len = virtchnl_struct_size(vvfl_v2, filters, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
 			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
-			count = (IAVF_MAX_AQ_BUF_SIZE -
-				 sizeof(*vvfl_v2)) /
-				sizeof(struct virtchnl_vlan_filter);
-			len = sizeof(*vvfl_v2) +
-				((count - 1) *
-				 sizeof(struct virtchnl_vlan_filter));
+			while (len > IAVF_MAX_AQ_BUF_SIZE)
+				len = virtchnl_struct_size(vvfl_v2, filters,
+							   --count);
 			more = true;
 		}
 
@@ -1492,7 +1485,7 @@ void iavf_enable_channels(struct iavf_adapter *adapter)
 		return;
 	}
 
-	len = struct_size(vti, list, adapter->num_tc - 1);
+	len = virtchnl_struct_size(vti, list, adapter->num_tc);
 	vti = kzalloc(len, GFP_KERNEL);
 	if (!vti)
 		return;
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index c1a20b533fc0..d0807ad43f93 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -716,10 +716,11 @@ struct virtchnl_vlan_filter_list_v2 {
 	u16 vport_id;
 	u16 num_elements;
 	u8 pad[4];
-	struct virtchnl_vlan_filter filters[1];
+	struct virtchnl_vlan_filter filters[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_vlan_filter_list_v2);
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_vlan_filter_list_v2);
+#define virtchnl_vlan_filter_list_v2_LEGACY_SIZEOF	40
 
 /* VIRTCHNL_OP_ENABLE_VLAN_STRIPPING_V2
  * VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2
@@ -918,10 +919,11 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_channel_info);
 struct virtchnl_tc_info {
 	u32	num_tc;
 	u32	pad;
-	struct	virtchnl_channel_info list[1];
+	struct virtchnl_channel_info list[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_tc_info);
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_tc_info);
+#define virtchnl_tc_info_LEGACY_SIZEOF	24
 
 /* VIRTCHNL_ADD_CLOUD_FILTER
  * VIRTCHNL_DEL_CLOUD_FILTER
@@ -1059,10 +1061,11 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_rdma_qv_info);
 
 struct virtchnl_rdma_qvlist_info {
 	u32 num_vectors;
-	struct virtchnl_rdma_qv_info qv_info[1];
+	struct virtchnl_rdma_qv_info qv_info[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rdma_qvlist_info);
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_rdma_qvlist_info);
+#define virtchnl_rdma_qvlist_info_LEGACY_SIZEOF	16
 
 /* VF reset states - these are written into the RSTAT register:
  * VFGEN_RSTAT on the VF
@@ -1377,6 +1380,9 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_fdir_del);
 #define __vss_byone(p, member, count, old)				      \
 	(struct_size(p, member, count) + (old - 1 - struct_size(p, member, 0)))
 
+#define __vss_byelem(p, member, count, old)				      \
+	(struct_size(p, member, count - 1) + (old - struct_size(p, member, 0)))
+
 #define __vss_full(p, member, count, old)				      \
 	(struct_size(p, member, count) + (old - struct_size(p, member, 0)))
 
@@ -1390,6 +1396,9 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_fdir_del);
 		 __vss(virtchnl_irq_map_info, __vss_full, p, m, c),	      \
 		 __vss(virtchnl_ether_addr_list, __vss_full, p, m, c),	      \
 		 __vss(virtchnl_vlan_filter_list, __vss_full, p, m, c),	      \
+		 __vss(virtchnl_vlan_filter_list_v2, __vss_byelem, p, m, c),  \
+		 __vss(virtchnl_tc_info, __vss_byelem, p, m, c),	      \
+		 __vss(virtchnl_rdma_qvlist_info, __vss_byelem, p, m, c),     \
 		 __vss(virtchnl_rss_key, __vss_byone, p, m, c),		      \
 		 __vss(virtchnl_rss_lut, __vss_byone, p, m, c))
 
@@ -1495,13 +1504,13 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_RELEASE_RDMA_IRQ_MAP:
 		break;
 	case VIRTCHNL_OP_CONFIG_RDMA_IRQ_MAP:
-		valid_len = sizeof(struct virtchnl_rdma_qvlist_info);
+		valid_len = virtchnl_rdma_qvlist_info_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_rdma_qvlist_info *qv =
 				(struct virtchnl_rdma_qvlist_info *)msg;
 
-			valid_len += ((qv->num_vectors - 1) *
-				sizeof(struct virtchnl_rdma_qv_info));
+			valid_len = virtchnl_struct_size(qv, qv_info,
+							 qv->num_vectors);
 		}
 		break;
 	case VIRTCHNL_OP_CONFIG_RSS_KEY:
@@ -1534,12 +1543,12 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		valid_len = sizeof(struct virtchnl_vf_res_request);
 		break;
 	case VIRTCHNL_OP_ENABLE_CHANNELS:
-		valid_len = sizeof(struct virtchnl_tc_info);
+		valid_len = virtchnl_tc_info_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_tc_info *vti =
 				(struct virtchnl_tc_info *)msg;
-			valid_len += (vti->num_tc - 1) *
-				     sizeof(struct virtchnl_channel_info);
+			valid_len = virtchnl_struct_size(vti, list,
+							 vti->num_tc);
 			if (vti->num_tc == 0)
 				err_msg_format = true;
 		}
@@ -1566,13 +1575,13 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		break;
 	case VIRTCHNL_OP_ADD_VLAN_V2:
 	case VIRTCHNL_OP_DEL_VLAN_V2:
-		valid_len = sizeof(struct virtchnl_vlan_filter_list_v2);
+		valid_len = virtchnl_vlan_filter_list_v2_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_vlan_filter_list_v2 *vfl =
 			    (struct virtchnl_vlan_filter_list_v2 *)msg;
 
-			valid_len += (vfl->num_elements - 1) *
-				sizeof(struct virtchnl_vlan_filter);
+			valid_len = virtchnl_struct_size(vfl, filters,
+							 vfl->num_elements);
 
 			if (vfl->num_elements == 0) {
 				err_msg_format = true;
-- 
2.38.1


