Return-Path: <netdev+bounces-184894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06431A979B4
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853B11B63D57
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 21:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7822980B0;
	Tue, 22 Apr 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kq1Jl/LT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71227056E
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358516; cv=none; b=qV6bT7dlxwuAaIsRAUrbfDKLUj8olfknN/qBmXE1w7i3PsLn2SLKtMB8/f6cghuHst6MnwZufwDMz3C0dWqFbE4fSYDd45kGYIAex6rH8ENn521v7Rq8D4m4w+gQ0mpmM4JXgCcXsWSwvhmyFrM4Z6ZSmmwT2CoF5KAXuCCAstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358516; c=relaxed/simple;
	bh=yed63qB8hP2SnG+WxuvI9uycOPs4jNMKyHrSsBaFKmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjNcwmwks+fY4zCXqoqlZ79Gjs1ovshTBUdf/JlC+O+AFS8IKT0PwK4jKGPcM0MBg1a5rQ7oYoxupsFvhDBVIVU/c0ewNjf0HuBFo7yb3OsBIpLAMKZZsQCoAqg30Wyttzo6Y+nFg5E9lkuAkXzjhoEpnVforpApJs6hjF0kFAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kq1Jl/LT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745358515; x=1776894515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yed63qB8hP2SnG+WxuvI9uycOPs4jNMKyHrSsBaFKmQ=;
  b=kq1Jl/LTBla09fwCVDF2/zgARWyNZ7/tutBt7PiCfcR6AWOxu+tWcUlw
   +tCtMIkvJhX9jdxgQHq5v+knKDLg8HchpA0zJSUdGPg1onLj99nOjeHN6
   OUyv4qobvItrc2Bv6OaEowtYqgVVbTI8DaJ2/NPbvcYmjlbiZsdJThUiA
   6qCvciLgTFVERYKg8XR5MsGEh0kEn/PfAqcmCnHFLseiSKcNpcMDJnJga
   Ycm79v9dKYF8izrTn3mgN0Pz4AYDOBLob8DoTBK/MelSM1umYlWMxMOKd
   6oSPuPRa2jS9mOjx/sgRqLqweBWTywnfRAnBwClZcShjjjyzyDyqXa0Kg
   Q==;
X-CSE-ConnectionGUID: vnZnRaVcR2O2TnpKGshBlQ==
X-CSE-MsgGUID: FFsNbrUwTgymhvJ/NqRJbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46949145"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="46949145"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 14:48:33 -0700
X-CSE-ConnectionGUID: Mw35uTN9SCe15YV+vvHEgg==
X-CSE-MsgGUID: 9Szj18IDRD+VUDhKVpvdFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="163186557"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 22 Apr 2025 14:48:32 -0700
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
Subject: [PATCH net 3/3] idpf: fix offloads support for encapsulated packets
Date: Tue, 22 Apr 2025 14:48:07 -0700
Message-ID: <20250422214822.882674-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422214822.882674-1-anthony.l.nguyen@intel.com>
References: <20250422214822.882674-1-anthony.l.nguyen@intel.com>
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
 drivers/net/ethernet/intel/idpf/idpf.h     | 14 ++++--
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 57 ++++++++--------------
 2 files changed, 29 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 66544faab710..5f73a4cf5161 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -633,10 +633,18 @@ bool idpf_is_capability_ena(struct idpf_adapter *adapter, bool all,
 	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_TCP	|\
 	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_UDP)
 
+#define IDPF_CAP_TX_CSUM_L4V4 (\
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_TCP	|\
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_UDP)
+
 #define IDPF_CAP_RX_CSUM_L4V6 (\
 	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_TCP	|\
 	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_UDP)
 
+#define IDPF_CAP_TX_CSUM_L4V6 (\
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_TCP	|\
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_UDP)
+
 #define IDPF_CAP_RX_CSUM (\
 	VIRTCHNL2_CAP_RX_CSUM_L3_IPV4		|\
 	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_TCP	|\
@@ -644,11 +652,9 @@ bool idpf_is_capability_ena(struct idpf_adapter *adapter, bool all,
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


