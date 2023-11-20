Return-Path: <netdev+bounces-49400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C90C7F1E65
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D294A1F261EF
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D26315A1;
	Mon, 20 Nov 2023 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJvfITdu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF91D2;
	Mon, 20 Nov 2023 12:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700513829; x=1732049829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pNiQdQCtBPWZHa6DncJqBEjOa18ri1ObobyNYXIQJqw=;
  b=VJvfITdu0bYzb+9izeKYoxzzEsAQ27BU3PT6mvRKtTcRhZG6oQcyqDMH
   XIumCyuJsbCrQGTYhqeSb3gucSkFJlXKx/SFAdKebFbBtSnomzOz82ZR4
   4qKJZn0DEmbMjuuNYFv0Hr8KsRNzTZbmRkD7UmXl+Mnckt1u37qluuij7
   YTiJinA0Dgi4mG00T7bHeeLgynUOLrpXtmxG/fQ2YxTo3MC95S/bTz/OX
   vcDW/Dj1ybFfLDVwujiq4S3Fl1f1CW9MJOdEC0U2Pb7aDFq7f/gMF/w0t
   zqJSoyDQNgXTOVpPCc6qroSfH+FpS6CuP+pW9Gl+AuOqZkuzFR6K/LRBX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="391484400"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="391484400"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:57:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="857106291"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="857106291"
Received: from cchircul-mobl2.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.249.46.122])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:57:02 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	corbet@lwn.net,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	andrew@lunn.ch,
	horms@kernel.org,
	mkubecek@suse.cz,
	willemdebruijn.kernel@gmail.com,
	gal@nvidia.com,
	alexander.duyck@gmail.com,
	linux-doc@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: [PATCH net-next v6 7/7] iavf: enable symmetric-xor RSS for Toeplitz hash function
Date: Mon, 20 Nov 2023 13:56:14 -0700
Message-Id: <20231120205614.46350-8-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120205614.46350-1-ahmed.zaki@intel.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the user to set the symmetric Toeplitz hash function via:

    # ethtool -X eth0 hfunc toeplitz symmetric-xor

The driver will reject any new RSS configuration if a field other than
(IP src/dst and L4 src/dst ports) is requested for hashing.

The symmetric RSS will not be supported on PFs not advertising the ADV RSS
Offload flag (ADV_RSS_SUPPORT()), for example the E700 series (i40e).

Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  5 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.c    |  8 ++-
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |  3 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 43 ++++++++++++++--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  4 ++
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 41 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 50 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |  1 +
 .../intel/ice/ice_virtchnl_allowlist.c        |  1 +
 include/linux/avf/virtchnl.h                  | 19 +++++++
 10 files changed, 166 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index e7ab89dc883a..f83fbcc72075 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -312,7 +312,8 @@ struct iavf_adapter {
 #define IAVF_FLAG_AQ_SET_HENA			BIT_ULL(12)
 #define IAVF_FLAG_AQ_SET_RSS_KEY		BIT_ULL(13)
 #define IAVF_FLAG_AQ_SET_RSS_LUT		BIT_ULL(14)
-#define IAVF_FLAG_AQ_CONFIGURE_PROMISC_MODE	BIT_ULL(15)
+#define IAVF_FLAG_AQ_SET_RSS_HFUNC		BIT_ULL(15)
+#define IAVF_FLAG_AQ_CONFIGURE_PROMISC_MODE	BIT_ULL(16)
 #define IAVF_FLAG_AQ_ENABLE_VLAN_STRIPPING	BIT_ULL(19)
 #define IAVF_FLAG_AQ_DISABLE_VLAN_STRIPPING	BIT_ULL(20)
 #define IAVF_FLAG_AQ_ENABLE_CHANNELS		BIT_ULL(21)
@@ -414,6 +415,7 @@ struct iavf_adapter {
 	struct iavf_vsi vsi;
 	u32 aq_wait_count;
 	/* RSS stuff */
+	enum virtchnl_rss_algorithm hfunc;
 	u64 hena;
 	u16 rss_key_size;
 	u16 rss_lut_size;
@@ -539,6 +541,7 @@ void iavf_get_hena(struct iavf_adapter *adapter);
 void iavf_set_hena(struct iavf_adapter *adapter);
 void iavf_set_rss_key(struct iavf_adapter *adapter);
 void iavf_set_rss_lut(struct iavf_adapter *adapter);
+void iavf_set_rss_hfunc(struct iavf_adapter *adapter);
 void iavf_enable_vlan_stripping(struct iavf_adapter *adapter);
 void iavf_disable_vlan_stripping(struct iavf_adapter *adapter);
 void iavf_virtchnl_completion(struct iavf_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
index 6edbf134b73f..a9e1da35e248 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
@@ -95,17 +95,21 @@ iavf_fill_adv_rss_sctp_hdr(struct virtchnl_proto_hdr *hdr, u64 hash_flds)
  * @rss_cfg: the virtchnl message to be filled with RSS configuration setting
  * @packet_hdrs: the RSS configuration protocol header types
  * @hash_flds: the RSS configuration protocol hash fields
+ * @symm: if true, symmetric hash is required
  *
  * Returns 0 if the RSS configuration virtchnl message is filled successfully
  */
 int
 iavf_fill_adv_rss_cfg_msg(struct virtchnl_rss_cfg *rss_cfg,
-			  u32 packet_hdrs, u64 hash_flds)
+			  u32 packet_hdrs, u64 hash_flds, bool symm)
 {
 	struct virtchnl_proto_hdrs *proto_hdrs = &rss_cfg->proto_hdrs;
 	struct virtchnl_proto_hdr *hdr;
 
-	rss_cfg->rss_algorithm = VIRTCHNL_RSS_ALG_TOEPLITZ_ASYMMETRIC;
+	if (symm)
+		rss_cfg->rss_algorithm = VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC;
+	else
+		rss_cfg->rss_algorithm = VIRTCHNL_RSS_ALG_TOEPLITZ_ASYMMETRIC;
 
 	proto_hdrs->tunnel_level = 0;	/* always outer layer */
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h
index 4d3be11af7aa..e31eb2afebea 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h
@@ -80,13 +80,14 @@ struct iavf_adv_rss {
 
 	u32 packet_hdrs;
 	u64 hash_flds;
+	bool symm;
 
 	struct virtchnl_rss_cfg cfg_msg;
 };
 
 int
 iavf_fill_adv_rss_cfg_msg(struct virtchnl_rss_cfg *rss_cfg,
-			  u32 packet_hdrs, u64 hash_flds);
+			  u32 packet_hdrs, u64 hash_flds, bool symm);
 struct iavf_adv_rss *
 iavf_find_adv_rss_cfg_by_hdrs(struct iavf_adapter *adapter, u32 packet_hdrs);
 void
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 2f3cd504f249..9fa85b444697 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1540,14 +1540,26 @@ static u32 iavf_adv_rss_parse_hdrs(struct ethtool_rxnfc *cmd)
 /**
  * iavf_adv_rss_parse_hash_flds - parses hash fields from RSS hash input
  * @cmd: ethtool rxnfc command
+ * @symm: true if Symmetric Topelitz is set
  *
  * This function parses the rxnfc command and returns intended hash fields for
  * RSS configuration
  */
-static u64 iavf_adv_rss_parse_hash_flds(struct ethtool_rxnfc *cmd)
+static u64 iavf_adv_rss_parse_hash_flds(struct ethtool_rxnfc *cmd, bool symm)
 {
 	u64 hfld = IAVF_ADV_RSS_HASH_INVALID;
 
+	/* Sanity check: if a symmetric hash is requested, then:
+	 * 1 - no other fields besides IP src/dst and/or L4 src/dst
+	 * 2 - If src is set, dst must also be set
+	 */
+	if (symm &&
+	    ((cmd->data & ~(RXH_IP_SRC | RXH_IP_DST |
+			    RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
+	     (!!(cmd->data & RXH_IP_SRC) ^ !!(cmd->data & RXH_IP_DST)) ||
+	     (!!(cmd->data & RXH_L4_B_0_1) ^ !!(cmd->data & RXH_L4_B_2_3))))
+		return hfld;
+
 	if (cmd->data & RXH_IP_SRC || cmd->data & RXH_IP_DST) {
 		switch (cmd->flow_type) {
 		case TCP_V4_FLOW:
@@ -1616,17 +1628,20 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
 	struct iavf_adv_rss *rss_old, *rss_new;
 	bool rss_new_add = false;
 	int count = 50, err = 0;
+	bool symm = false;
 	u64 hash_flds;
 	u32 hdrs;
 
 	if (!ADV_RSS_SUPPORT(adapter))
 		return -EOPNOTSUPP;
 
+	symm = !!(adapter->hfunc == VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC);
+
 	hdrs = iavf_adv_rss_parse_hdrs(cmd);
 	if (hdrs == IAVF_ADV_RSS_FLOW_SEG_HDR_NONE)
 		return -EINVAL;
 
-	hash_flds = iavf_adv_rss_parse_hash_flds(cmd);
+	hash_flds = iavf_adv_rss_parse_hash_flds(cmd, symm);
 	if (hash_flds == IAVF_ADV_RSS_HASH_INVALID)
 		return -EINVAL;
 
@@ -1634,7 +1649,8 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
 	if (!rss_new)
 		return -ENOMEM;
 
-	if (iavf_fill_adv_rss_cfg_msg(&rss_new->cfg_msg, hdrs, hash_flds)) {
+	if (iavf_fill_adv_rss_cfg_msg(&rss_new->cfg_msg, hdrs, hash_flds,
+				      symm)) {
 		kfree(rss_new);
 		return -EINVAL;
 	}
@@ -1653,9 +1669,11 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
 	if (rss_old) {
 		if (rss_old->state != IAVF_ADV_RSS_ACTIVE) {
 			err = -EBUSY;
-		} else if (rss_old->hash_flds != hash_flds) {
+		} else if (rss_old->hash_flds != hash_flds ||
+			   rss_old->symm != symm) {
 			rss_old->state = IAVF_ADV_RSS_ADD_REQUEST;
 			rss_old->hash_flds = hash_flds;
+			rss_old->symm = symm;
 			memcpy(&rss_old->cfg_msg, &rss_new->cfg_msg,
 			       sizeof(rss_new->cfg_msg));
 			adapter->aq_required |= IAVF_FLAG_AQ_ADD_ADV_RSS_CFG;
@@ -1667,6 +1685,7 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
 		rss_new->state = IAVF_ADV_RSS_ADD_REQUEST;
 		rss_new->packet_hdrs = hdrs;
 		rss_new->hash_flds = hash_flds;
+		rss_new->symm = symm;
 		list_add_tail(&rss_new->list, &adapter->adv_rss_list_head);
 		adapter->aq_required |= IAVF_FLAG_AQ_ADD_ADV_RSS_CFG;
 	}
@@ -1919,8 +1938,12 @@ static int iavf_get_rxfh(struct net_device *netdev, struct ethtool_rxfh *rxfh,
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u16 i;
 
-	if (rxfh)
+	if (rxfh) {
 		rxfh->hfunc = ETH_RSS_HASH_TOP;
+		if (adapter->hfunc == VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC)
+			rxfh->data |= RXH_HFUNC_SYM_XOR;
+	}
+
 	if (key)
 		memcpy(key, adapter->rss_key, adapter->rss_key_size);
 
@@ -1953,6 +1976,16 @@ static int iavf_set_rxfh(struct net_device *netdev, struct ethtool_rxfh *rxfh,
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
+	if (rxfh->data & RXH_HFUNC_SYM_XOR) {
+		if (!ADV_RSS_SUPPORT(adapter))
+			return -EOPNOTSUPP;
+		adapter->hfunc = VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC;
+		adapter->aq_required |= IAVF_FLAG_AQ_SET_RSS_HFUNC;
+	} else if (adapter->hfunc == VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC) {
+		adapter->hfunc = VIRTCHNL_RSS_ALG_TOEPLITZ_ASYMMETRIC;
+		adapter->aq_required |= IAVF_FLAG_AQ_SET_RSS_HFUNC;
+	}
+
 	if (!key && !indir)
 		return 0;
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index c862ebcd2e39..d96b7a190233 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2169,6 +2169,10 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 		iavf_set_rss_lut(adapter);
 		return 0;
 	}
+	if (adapter->aq_required & IAVF_FLAG_AQ_SET_RSS_HFUNC) {
+		iavf_set_rss_hfunc(adapter);
+		return 0;
+	}
 
 	if (adapter->aq_required & IAVF_FLAG_AQ_CONFIGURE_PROMISC_MODE) {
 		iavf_set_promiscuous(adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 64c4443dbef9..64a351e70a56 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1141,6 +1141,34 @@ void iavf_set_rss_lut(struct iavf_adapter *adapter)
 	kfree(vrl);
 }
 
+/**
+ * iavf_set_rss_hfunc
+ * @adapter: adapter structure
+ *
+ * Request the PF to set our RSS Hash function
+ **/
+void iavf_set_rss_hfunc(struct iavf_adapter *adapter)
+{
+	struct virtchnl_rss_hfunc *vrh;
+	int len = sizeof(*vrh);
+
+	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
+		/* bail because we already have a command pending */
+		dev_err(&adapter->pdev->dev, "Cannot set RSS Hash function, command %d pending\n",
+			adapter->current_op);
+		return;
+	}
+	vrh = kzalloc(len, GFP_KERNEL);
+	if (!vrh)
+		return;
+	vrh->vsi_id = adapter->vsi.id;
+	vrh->rss_algorithm = adapter->hfunc;
+	adapter->current_op = VIRTCHNL_OP_CONFIG_RSS_HFUNC;
+	adapter->aq_required &= ~IAVF_FLAG_AQ_SET_RSS_HFUNC;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_RSS_HFUNC, (u8 *)vrh, len);
+	kfree(vrh);
+}
+
 /**
  * iavf_enable_vlan_stripping
  * @adapter: adapter structure
@@ -2142,6 +2170,19 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			dev_warn(&adapter->pdev->dev, "Failed to add VLAN filter, error %s\n",
 				 iavf_stat_str(&adapter->hw, v_retval));
 			break;
+		case VIRTCHNL_OP_CONFIG_RSS_HFUNC:
+			dev_warn(&adapter->pdev->dev, "Failed to configure hash function, error %s\n",
+				 iavf_stat_str(&adapter->hw, v_retval));
+
+			if (adapter->hfunc ==
+					VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC)
+				adapter->hfunc =
+					VIRTCHNL_RSS_ALG_TOEPLITZ_ASYMMETRIC;
+			else
+				adapter->hfunc =
+					VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC;
+
+			break;
 		default:
 			dev_err(&adapter->pdev->dev, "PF returned error %d (%s) to our request %d\n",
 				v_retval, iavf_stat_str(&adapter->hw, v_retval),
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index b7b6511d5bb2..f98115bb2136 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -999,6 +999,51 @@ static int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg)
 				     NULL, 0);
 }
 
+/**
+ * ice_vc_config_rss_hfunc
+ * @vf: pointer to the VF info
+ * @msg: pointer to the msg buffer
+ *
+ * Configure the VF's RSS Hash function
+ */
+static int ice_vc_config_rss_hfunc(struct ice_vf *vf, u8 *msg)
+{
+	struct virtchnl_rss_hfunc *vrh = (struct virtchnl_rss_hfunc *)msg;
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
+	u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
+	struct ice_vsi *vsi;
+
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto error_param;
+	}
+
+	if (!ice_vc_isvalid_vsi_id(vf, vrh->vsi_id)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto error_param;
+	}
+
+	if (!test_bit(ICE_FLAG_RSS_ENA, vf->pf->flags)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto error_param;
+	}
+
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto error_param;
+	}
+
+	if (vrh->rss_algorithm == VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC)
+		hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
+
+	if (ice_set_rss_hfunc(vsi, hfunc))
+		v_ret = VIRTCHNL_STATUS_ERR_ADMIN_QUEUE_ERROR;
+error_param:
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_CONFIG_RSS_HFUNC, v_ret,
+				     NULL, 0);
+}
+
 /**
  * ice_vc_cfg_promiscuous_mode_msg
  * @vf: pointer to the VF info
@@ -3742,6 +3787,7 @@ static const struct ice_virtchnl_ops ice_virtchnl_dflt_ops = {
 	.cfg_irq_map_msg = ice_vc_cfg_irq_map_msg,
 	.config_rss_key = ice_vc_config_rss_key,
 	.config_rss_lut = ice_vc_config_rss_lut,
+	.config_rss_hfunc = ice_vc_config_rss_hfunc,
 	.get_stats_msg = ice_vc_get_stats_msg,
 	.cfg_promiscuous_mode_msg = ice_vc_cfg_promiscuous_mode_msg,
 	.add_vlan_msg = ice_vc_add_vlan_msg,
@@ -3871,6 +3917,7 @@ static const struct ice_virtchnl_ops ice_virtchnl_repr_ops = {
 	.cfg_irq_map_msg = ice_vc_cfg_irq_map_msg,
 	.config_rss_key = ice_vc_config_rss_key,
 	.config_rss_lut = ice_vc_config_rss_lut,
+	.config_rss_hfunc = ice_vc_config_rss_hfunc,
 	.get_stats_msg = ice_vc_get_stats_msg,
 	.cfg_promiscuous_mode_msg = ice_vc_repr_cfg_promiscuous_mode,
 	.add_vlan_msg = ice_vc_add_vlan_msg,
@@ -4053,6 +4100,9 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event,
 	case VIRTCHNL_OP_CONFIG_RSS_LUT:
 		err = ops->config_rss_lut(vf, msg);
 		break;
+	case VIRTCHNL_OP_CONFIG_RSS_HFUNC:
+		err = ops->config_rss_hfunc(vf, msg);
+		break;
 	case VIRTCHNL_OP_GET_STATS:
 		err = ops->get_stats_msg(vf, msg);
 		break;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.h b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
index cd747718de73..60dfbe05980a 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
@@ -32,6 +32,7 @@ struct ice_virtchnl_ops {
 	int (*cfg_irq_map_msg)(struct ice_vf *vf, u8 *msg);
 	int (*config_rss_key)(struct ice_vf *vf, u8 *msg);
 	int (*config_rss_lut)(struct ice_vf *vf, u8 *msg);
+	int (*config_rss_hfunc)(struct ice_vf *vf, u8 *msg);
 	int (*get_stats_msg)(struct ice_vf *vf, u8 *msg);
 	int (*cfg_promiscuous_mode_msg)(struct ice_vf *vf, u8 *msg);
 	int (*add_vlan_msg)(struct ice_vf *vf, u8 *msg);
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
index 7d547fa616fa..5e19d48a05b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
@@ -68,6 +68,7 @@ static const u32 vlan_v2_allowlist_opcodes[] = {
 static const u32 rss_pf_allowlist_opcodes[] = {
 	VIRTCHNL_OP_CONFIG_RSS_KEY, VIRTCHNL_OP_CONFIG_RSS_LUT,
 	VIRTCHNL_OP_GET_RSS_HENA_CAPS, VIRTCHNL_OP_SET_RSS_HENA,
+	VIRTCHNL_OP_CONFIG_RSS_HFUNC,
 };
 
 /* VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC */
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index b0e060cc79ac..a44d9dc7e3eb 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -118,6 +118,7 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_GET_STATS = 15,
 	VIRTCHNL_OP_RSVD = 16,
 	VIRTCHNL_OP_EVENT = 17, /* must ALWAYS be 17 */
+	VIRTCHNL_OP_CONFIG_RSS_HFUNC = 18,
 	/* opcode 19 is reserved */
 	VIRTCHNL_OP_IWARP = 20, /* advanced opcode */
 	VIRTCHNL_OP_RDMA = VIRTCHNL_OP_IWARP,
@@ -919,6 +920,21 @@ enum virtchnl_rss_algorithm {
 	VIRTCHNL_RSS_ALG_XOR_SYMMETRIC		= 3,
 };
 
+/* VIRTCHNL_OP_CONFIG_RSS_HFUNC
+ * VF sends this message to configure the RSS hash function. Only supported
+ * if both PF and VF drivers set the VIRTCHNL_VF_OFFLOAD_RSS_PF bit during
+ * configuration negotiation.
+ * The hash function is initialized to VIRTCHNL_RSS_ALG_TOEPLITZ_ASYMMETRIC
+ * by the PF.
+ */
+struct virtchnl_rss_hfunc {
+	u16 vsi_id;
+	u16 rss_algorithm; /* enum virtchnl_rss_algorithm */
+	u32 reserved;
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_rss_hfunc);
+
 /* VIRTCHNL_OP_ENABLE_CHANNELS
  * VIRTCHNL_OP_DISABLE_CHANNELS
  * VF sends these messages to enable or disable channels based on
@@ -1542,6 +1558,9 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 							 vrl->lut_entries);
 		}
 		break;
+	case VIRTCHNL_OP_CONFIG_RSS_HFUNC:
+		valid_len = sizeof(struct virtchnl_rss_hfunc);
+		break;
 	case VIRTCHNL_OP_GET_RSS_HENA_CAPS:
 		break;
 	case VIRTCHNL_OP_SET_RSS_HENA:
-- 
2.34.1


