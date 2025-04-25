Return-Path: <netdev+bounces-186168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C55A9D579
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282F87B2A99
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE053292928;
	Fri, 25 Apr 2025 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKBJnJVF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D92918E2
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745620010; cv=none; b=NvBZEA5TaLq+nsHOK+NZLiMrwB/55aB8SUSpMv+O75rQ2EkYun+pgdPs/qSJINZdh/MEn61jljxL3ENlTKyFKmbXeWEW9R+k3eo7OvIhySctO5i+hbOEcHmoGbmTPmHxR7NJro+oGGFSChf4diR+4qJZH/8lDLtVGWkNVdt8F7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745620010; c=relaxed/simple;
	bh=/IaNfy8kkD4EAg6MhbpB1m5PC+ONb0+8y5lpurwawIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGnx0M7UEtG/HFpnd5oLoFV66/GfSnTcl2YeOavovbrtgHJkYEFBnf2CjLjOCCQCkgZJ2ppUlMdSsLr1QLxg3m436Nzb1m4rKbs7heXITNB8MOgR86jubrzNgHOJi+Nxnp/YBKttT/eJqIClhFySuRJii1GbBd3WDp4Sj/fOKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKBJnJVF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745620009; x=1777156009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/IaNfy8kkD4EAg6MhbpB1m5PC+ONb0+8y5lpurwawIg=;
  b=iKBJnJVF59jEDmr9KcfGOQrxryHeE6jBfeI5lgaooju/okYgcgsTJ/O5
   9u0k0PSjmh+rMRgCAf1l6FtUNeiN2eARvALsgB/ZWZ3mzbUZMy/3dnAXE
   kxQa3ShjJQr1hhb6MPPPNp34Nt1+/qUkwS+1NNbmO+vkkyOV8ewhs0hz/
   d0ypGwvXiYooUGNAiQpLEvt/solCTiknZOHn/j1A4YosJbRMBOgPQPlik
   Lci/Deq0WpZOLBo58adjCfmosV4xgFtasLUVqwlcJMbY+5/jxuswuPqDn
   0QezGGr8PfWAzKUEU2DyI/oxo6SnVETvUUKu09ssOTvvkihzK3t5jmMWV
   g==;
X-CSE-ConnectionGUID: Ozce2ru1SYyH9Jau/fe4Yg==
X-CSE-MsgGUID: vtiqr8+4RLuz18y+xkek7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="50961387"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="50961387"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 15:26:45 -0700
X-CSE-ConnectionGUID: Gs2lgYosQMeLqBbNc2TmPg==
X-CSE-MsgGUID: wghvixGuSuCluA1YrG5eig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="133533706"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 25 Apr 2025 15:26:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Madhu Chittim <madhu.chittim@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Zachary Goldstein <zachmgoldstein@google.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net v2 3/3] idpf: fix offloads support for encapsulated packets
Date: Fri, 25 Apr 2025 15:26:33 -0700
Message-ID: <20250425222636.3188441-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425222636.3188441-1-anthony.l.nguyen@intel.com>
References: <20250425222636.3188441-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Madhu Chittim <madhu.chittim@intel.com>

Split offloads into csum, tso and other offloads so that tunneled
packets do not by default have all the offloads enabled.

Stateless offloads for encapsulated packets are not yet supported in
firmware/software but in the driver we were setting the features same as
non encapsulated features.

Fixed naming to clarify CSUM bits are being checked for Tx.

Inherit netdev features to VLAN interfaces as well.

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
Tested-by: Zachary Goldstein <zachmgoldstein@google.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h     | 18 +++----
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 57 ++++++++--------------
 2 files changed, 27 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 66544faab710..aef0e9775a33 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -629,13 +629,13 @@ bool idpf_is_capability_ena(struct idpf_adapter *adapter, bool all,
 	VIRTCHNL2_CAP_RX_HSPLIT_AT_L4V4	|\
 	VIRTCHNL2_CAP_RX_HSPLIT_AT_L4V6)
 
-#define IDPF_CAP_RX_CSUM_L4V4 (\
-	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_TCP	|\
-	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_UDP)
+#define IDPF_CAP_TX_CSUM_L4V4 (\
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_TCP	|\
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_UDP)
 
-#define IDPF_CAP_RX_CSUM_L4V6 (\
-	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_TCP	|\
-	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_UDP)
+#define IDPF_CAP_TX_CSUM_L4V6 (\
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_TCP	|\
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_UDP)
 
 #define IDPF_CAP_RX_CSUM (\
 	VIRTCHNL2_CAP_RX_CSUM_L3_IPV4		|\
@@ -644,11 +644,9 @@ bool idpf_is_capability_ena(struct idpf_adapter *adapter, bool all,
 	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_TCP	|\
 	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_UDP)
 
-#define IDPF_CAP_SCTP_CSUM (\
+#define IDPF_CAP_TX_SCTP_CSUM (\
 	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_SCTP	|\
-	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_SCTP	|\
-	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_SCTP	|\
-	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_SCTP)
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_SCTP)
 
 #define IDPF_CAP_TUNNEL_TX_CSUM (\
 	VIRTCHNL2_CAP_TX_CSUM_L3_SINGLE_TUNNEL	|\
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index aa755dedb41d..730a9c7a59f2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -703,8 +703,10 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport_config *vport_config;
+	netdev_features_t other_offloads = 0;
+	netdev_features_t csum_offloads = 0;
+	netdev_features_t tso_offloads = 0;
 	netdev_features_t dflt_features;
-	netdev_features_t offloads = 0;
 	struct idpf_netdev_priv *np;
 	struct net_device *netdev;
 	u16 idx = vport->idx;
@@ -766,53 +768,32 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 
 	if (idpf_is_cap_ena_all(adapter, IDPF_RSS_CAPS, IDPF_CAP_RSS))
 		dflt_features |= NETIF_F_RXHASH;
-	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_RX_CSUM_L4V4))
-		dflt_features |= NETIF_F_IP_CSUM;
-	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_RX_CSUM_L4V6))
-		dflt_features |= NETIF_F_IPV6_CSUM;
+	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_TX_CSUM_L4V4))
+		csum_offloads |= NETIF_F_IP_CSUM;
+	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_TX_CSUM_L4V6))
+		csum_offloads |= NETIF_F_IPV6_CSUM;
 	if (idpf_is_cap_ena(adapter, IDPF_CSUM_CAPS, IDPF_CAP_RX_CSUM))
-		dflt_features |= NETIF_F_RXCSUM;
-	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_SCTP_CSUM))
-		dflt_features |= NETIF_F_SCTP_CRC;
+		csum_offloads |= NETIF_F_RXCSUM;
+	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_TX_SCTP_CSUM))
+		csum_offloads |= NETIF_F_SCTP_CRC;
 
 	if (idpf_is_cap_ena(adapter, IDPF_SEG_CAPS, VIRTCHNL2_CAP_SEG_IPV4_TCP))
-		dflt_features |= NETIF_F_TSO;
+		tso_offloads |= NETIF_F_TSO;
 	if (idpf_is_cap_ena(adapter, IDPF_SEG_CAPS, VIRTCHNL2_CAP_SEG_IPV6_TCP))
-		dflt_features |= NETIF_F_TSO6;
+		tso_offloads |= NETIF_F_TSO6;
 	if (idpf_is_cap_ena_all(adapter, IDPF_SEG_CAPS,
 				VIRTCHNL2_CAP_SEG_IPV4_UDP |
 				VIRTCHNL2_CAP_SEG_IPV6_UDP))
-		dflt_features |= NETIF_F_GSO_UDP_L4;
+		tso_offloads |= NETIF_F_GSO_UDP_L4;
 	if (idpf_is_cap_ena_all(adapter, IDPF_RSC_CAPS, IDPF_CAP_RSC))
-		offloads |= NETIF_F_GRO_HW;
-	/* advertise to stack only if offloads for encapsulated packets is
-	 * supported
-	 */
-	if (idpf_is_cap_ena(vport->adapter, IDPF_SEG_CAPS,
-			    VIRTCHNL2_CAP_SEG_TX_SINGLE_TUNNEL)) {
-		offloads |= NETIF_F_GSO_UDP_TUNNEL	|
-			    NETIF_F_GSO_GRE		|
-			    NETIF_F_GSO_GRE_CSUM	|
-			    NETIF_F_GSO_PARTIAL		|
-			    NETIF_F_GSO_UDP_TUNNEL_CSUM	|
-			    NETIF_F_GSO_IPXIP4		|
-			    NETIF_F_GSO_IPXIP6		|
-			    0;
-
-		if (!idpf_is_cap_ena_all(vport->adapter, IDPF_CSUM_CAPS,
-					 IDPF_CAP_TUNNEL_TX_CSUM))
-			netdev->gso_partial_features |=
-				NETIF_F_GSO_UDP_TUNNEL_CSUM;
-
-		netdev->gso_partial_features |= NETIF_F_GSO_GRE_CSUM;
-		offloads |= NETIF_F_TSO_MANGLEID;
-	}
+		other_offloads |= NETIF_F_GRO_HW;
 	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_LOOPBACK))
-		offloads |= NETIF_F_LOOPBACK;
+		other_offloads |= NETIF_F_LOOPBACK;
 
-	netdev->features |= dflt_features;
-	netdev->hw_features |= dflt_features | offloads;
-	netdev->hw_enc_features |= dflt_features | offloads;
+	netdev->features |= dflt_features | csum_offloads | tso_offloads;
+	netdev->hw_features |=  netdev->features | other_offloads;
+	netdev->vlan_features |= netdev->features | other_offloads;
+	netdev->hw_enc_features |= dflt_features | other_offloads;
 	idpf_set_ethtool_ops(netdev);
 	netif_set_affinity_auto(netdev);
 	SET_NETDEV_DEV(netdev, &adapter->pdev->dev);
-- 
2.47.1


