Return-Path: <netdev+bounces-33656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FC879F0DC
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 20:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FE3281690
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 18:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A20200CF;
	Wed, 13 Sep 2023 18:04:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD422EE1
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 18:04:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF1D19AE
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694628268; x=1726164268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=26/CiIvt/6qb74d+P2hyZxrt+8O2E0LWkiNjTyDa9Wg=;
  b=EyH9PaSIyMD9Bhhrz7Opb2UHGJEcBDMskaEU8mGJTb6QOd9PTjAaHMYT
   ZAF8zucVaibMxnT6rA1pYA8f/O8v/FNtrl0izx5JkDeS4Acltvxoz0UJw
   fea6ZShbSUmhsv5TkFFR9KFQkBG6TwoUkBF05a7vX+vcOMTRAKNi7TAxe
   Ct000hWPg3T2ZAmFzTOi1FVuNCdux2pn8Ob71/v2pSbyK9tfsXEAQaHqD
   /u4ap+sn0jebM9p9AANi8MOa/SFuOBK72fh5RGLg1ccEieQe3L9K83CD1
   34cBaKuDZ573MDEeaw6/MXV4Fe0E4TYAsBxr2jFBC449l6j7DlRIGmcwU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378658471"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378658471"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747417174"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="747417174"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2023 11:03:55 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Norbert Zulinski <norbertx.zulinski@intel.com>,
	anthony.l.nguyen@intel.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 4/4] iavf: Add ability to turn off CRC stripping for VF
Date: Wed, 13 Sep 2023 11:03:34 -0700
Message-Id: <20230913180334.2116162-5-anthony.l.nguyen@intel.com>
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

From: Norbert Zulinski <norbertx.zulinski@intel.com>

Previously CRC stripping was always enabled for VF.

Now it is possible to turn off CRC stripping via ethtool:

    #ethtool -K <interface> rx-fcs on

To turn off CRC stripping, first VLAN stripping must be disabled:

    #ethtool -K <interface> rx-vlan-offload off

if any VLAN interfaces exists, otherwise VLAN stripping will be turned
off by the driver.

In iavf_configure_queues add check if CRC stripping is enabled for
VF, if it's enabled then set crc_disabled to false on every VF's
queue. In iavf_set_features add check if CRC stripping setting was
changed then schedule reset.

Signed-off-by: Norbert Zulinski <norbertx.zulinski@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  2 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 59 ++++++++++++++++++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  4 ++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 738e25657c6b..f32b0453584f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -406,6 +406,8 @@ struct iavf_adapter {
 			  VIRTCHNL_VF_OFFLOAD_VLAN)
 #define VLAN_V2_ALLOWED(_a) ((_a)->vf_res->vf_cap_flags & \
 			     VIRTCHNL_VF_OFFLOAD_VLAN_V2)
+#define CRC_OFFLOAD_ALLOWED(_a) ((_a)->vf_res->vf_cap_flags & \
+				 VIRTCHNL_VF_OFFLOAD_CRC)
 #define VLAN_V2_FILTERING_ALLOWED(_a) \
 	(VLAN_V2_ALLOWED((_a)) && \
 	 ((_a)->vlan_v2_caps.filtering.filtering_support.outer || \
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 36b94ee44211..a02440664bca 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4401,6 +4401,9 @@ static int iavf_set_features(struct net_device *netdev,
 	    (features & NETIF_VLAN_OFFLOAD_FEATURES))
 		iavf_set_vlan_offload_features(adapter, netdev->features,
 					       features);
+	if (CRC_OFFLOAD_ALLOWED(adapter) &&
+	    ((netdev->features & NETIF_F_RXFCS) ^ (features & NETIF_F_RXFCS)))
+		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
 
 	return 0;
 }
@@ -4522,6 +4525,9 @@ iavf_get_netdev_vlan_hw_features(struct iavf_adapter *adapter)
 		}
 	}
 
+	if (CRC_OFFLOAD_ALLOWED(adapter))
+		hw_features |= NETIF_F_RXFCS;
+
 	return hw_features;
 }
 
@@ -4685,6 +4691,55 @@ iavf_fix_netdev_vlan_features(struct iavf_adapter *adapter,
 	return requested_features;
 }
 
+/**
+ * iavf_fix_strip_features - fix NETDEV CRC and VLAN strip features
+ * @adapter: board private structure
+ * @requested_features: stack requested NETDEV features
+ *
+ * Returns fixed-up features bits
+ **/
+static netdev_features_t
+iavf_fix_strip_features(struct iavf_adapter *adapter,
+			netdev_features_t requested_features)
+{
+	struct net_device *netdev = adapter->netdev;
+	bool crc_offload_req, is_vlan_strip;
+	netdev_features_t vlan_strip;
+	int num_non_zero_vlan;
+
+	crc_offload_req = CRC_OFFLOAD_ALLOWED(adapter) &&
+			  (requested_features & NETIF_F_RXFCS);
+	num_non_zero_vlan = iavf_get_num_vlans_added(adapter);
+	vlan_strip = (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX);
+	is_vlan_strip = requested_features & vlan_strip;
+
+	if (!crc_offload_req)
+		return requested_features;
+
+	if (!num_non_zero_vlan && (netdev->features & vlan_strip) &&
+	    !(netdev->features & NETIF_F_RXFCS) && is_vlan_strip) {
+		requested_features &= ~vlan_strip;
+		netdev_info(netdev, "Disabling VLAN stripping as FCS/CRC stripping is also disabled and there is no VLAN configured\n");
+		return requested_features;
+	}
+
+	if ((netdev->features & NETIF_F_RXFCS) && is_vlan_strip) {
+		requested_features &= ~vlan_strip;
+		if (!(netdev->features & vlan_strip))
+			netdev_info(netdev, "To enable VLAN stripping, first need to enable FCS/CRC stripping");
+
+		return requested_features;
+	}
+
+	if (num_non_zero_vlan && is_vlan_strip &&
+	    !(netdev->features & NETIF_F_RXFCS)) {
+		requested_features &= ~NETIF_F_RXFCS;
+		netdev_info(netdev, "To disable FCS/CRC stripping, first need to disable VLAN stripping");
+	}
+
+	return requested_features;
+}
+
 /**
  * iavf_fix_features - fix up the netdev feature bits
  * @netdev: our net device
@@ -4697,7 +4752,9 @@ static netdev_features_t iavf_fix_features(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
-	return iavf_fix_netdev_vlan_features(adapter, features);
+	features = iavf_fix_netdev_vlan_features(adapter, features);
+
+	return iavf_fix_strip_features(adapter, features);
 }
 
 static const struct net_device_ops iavf_netdev_ops = {
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 0b97b424e487..8ce6389b5815 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -142,6 +142,7 @@ int iavf_send_vf_config_msg(struct iavf_adapter *adapter)
 	       VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2 |
 	       VIRTCHNL_VF_OFFLOAD_ENCAP |
 	       VIRTCHNL_VF_OFFLOAD_VLAN_V2 |
+	       VIRTCHNL_VF_OFFLOAD_CRC |
 	       VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM |
 	       VIRTCHNL_VF_OFFLOAD_REQ_QUEUES |
 	       VIRTCHNL_VF_OFFLOAD_ADQ |
@@ -312,6 +313,9 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 		vqpi->rxq.databuffer_size =
 			ALIGN(adapter->rx_rings[i].rx_buf_len,
 			      BIT_ULL(IAVF_RXQ_CTX_DBUFF_SHIFT));
+		if (CRC_OFFLOAD_ALLOWED(adapter))
+			vqpi->rxq.crc_disable = !!(adapter->netdev->features &
+						   NETIF_F_RXFCS);
 		vqpi++;
 	}
 
-- 
2.38.1


