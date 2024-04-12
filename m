Return-Path: <netdev+bounces-87543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EA78A3786
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 23:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577EA1F23BD7
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 21:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8FF1509B6;
	Fri, 12 Apr 2024 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYYkxxuj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2010F44361
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955946; cv=none; b=EYdXyDk4npvK31QAYYgCi+tKZYK1/uz0gG4RPwaDdFYtO8OMSknvnNg5lA7kKpIsHpemBnBWMrj3Hevz/hKywV0Em6AFwVWNgI2j/0h2UXHbRmGamIhRO+P34y1blX4GYYSuxdf1cjRpeUwODMVgPpBJxoCJ6arxWdD4TSP+ocM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955946; c=relaxed/simple;
	bh=eSzNnztJArmrYmwGq3OWBuKt9n759qROhPEpDYUjYY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQJfxzemJ90kO12vSO1wLYa8MtC6PmWraGZ9++2tTarP1FWQvo9RPXrrU4iBurcmN8HFR0Bu8NfwibEK8Z5XzZ/bdw0EAGG6dzSjE+zChBAVeq3dZ5aXBIRr9cAeGObWTTNqayOj/PweqnRpknVDQQh6lNVpQqk6zcKqdCZWrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYYkxxuj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712955944; x=1744491944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eSzNnztJArmrYmwGq3OWBuKt9n759qROhPEpDYUjYY4=;
  b=MYYkxxujr94QYW2YtCuM7elg4YH5SPhftbGd5gcoRVyfr1C4Ec5rud9w
   k4TeYf+M2HCmU7ztQqxP6MaalgwHq6VRpWLpJUrVdLKW92HfSYixiuVv2
   /1mQMQZ/KUPFqCV2WiWl/R3lw2kL9WBsDB5rIWyw09bGBP8xo87ADwGO5
   WcqllpAjAZLyJU9e6IpX7E/noj82RnTWi6zuPXh9UVKh2G7MuS+Crwxd6
   7v4ZfiilFHuYAcC1e9HyzsdYSxSCwjkrdLpPvUuIk+c7HUncSpLfHS1i+
   WnVVgXVcA0123XwkhvO0nR6CEK1gKCubHkRVTGDxbpiqly13OalOO+u6R
   Q==;
X-CSE-ConnectionGUID: 7nuSR6cNS2OaaqEJ6MaB1Q==
X-CSE-MsgGUID: B0yGcjMpQ/+qSviLsMwPTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575225"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575225"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:05:42 -0700
X-CSE-ConnectionGUID: QSAEyfY/QAa8v8XhDOnjHQ==
X-CSE-MsgGUID: mF3aF3xUTdSQOk07+l7PFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21836888"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 12 Apr 2024 14:05:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jakub Buchocki <jakubx.buchocki@intel.com>,
	anthony.l.nguyen@intel.com,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Lukasz Plachno <lukasz.plachno@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next v2 2/4] ice: Implement 'flow-type ether' rules
Date: Fri, 12 Apr 2024 14:05:31 -0700
Message-ID: <20240412210534.916756-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240412210534.916756-1-anthony.l.nguyen@intel.com>
References: <20240412210534.916756-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Buchocki <jakubx.buchocki@intel.com>

Add support for 'flow-type ether' Flow Director rules via ethtool.

Create packet segment info for filter configuration based on ethtool
command parameters. Reuse infrastructure already created for
ipv4 and ipv6 flows to convert packet segment into
extraction sequence, which is later used to program the filter
inside Flow Director block of the Rx pipeline.

Rules not containing masks are processed by the Flow Director,
and support the following set of input parameters in all combinations:
src, dst, proto, vlan-etype, vlan, action.

It is possible to specify address mask in ethtool parameters but only
00:00:00:00:00 and FF:FF:FF:FF:FF are valid.
The same applies to proto, vlan-etype and vlan masks:
only 0x0000 and 0xffff masks are valid.

Testing:
  (DUT) iperf3 -s
  (DUT) ethtool -U ens785f0np0 flow-type ether dst <ens785f0np0 mac> \
        action 10
  (DUT) watch 'ethtool -S ens785f0np0 | grep rx_queue'
  (LP)  iperf3 -c ${DUT_IP}

  Counters increase only for:
    'rx_queue_10_packets'
    'rx_queue_10_bytes'

Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
Co-developed-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 140 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.c     |  26 ++++
 drivers/net/ethernet/intel/ice/ice_fdir.h     |   5 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 4 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index 9a1a04f5f146..e3cab8e98f52 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -41,6 +41,8 @@ static struct in6_addr zero_ipv6_addr_mask = {
 static int ice_fltr_to_ethtool_flow(enum ice_fltr_ptype flow)
 {
 	switch (flow) {
+	case ICE_FLTR_PTYPE_NONF_ETH:
+		return ETHER_FLOW;
 	case ICE_FLTR_PTYPE_NONF_IPV4_TCP:
 		return TCP_V4_FLOW;
 	case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
@@ -72,6 +74,8 @@ static int ice_fltr_to_ethtool_flow(enum ice_fltr_ptype flow)
 static enum ice_fltr_ptype ice_ethtool_flow_to_fltr(int eth)
 {
 	switch (eth) {
+	case ETHER_FLOW:
+		return ICE_FLTR_PTYPE_NONF_ETH;
 	case TCP_V4_FLOW:
 		return ICE_FLTR_PTYPE_NONF_IPV4_TCP;
 	case UDP_V4_FLOW:
@@ -137,6 +141,10 @@ int ice_get_ethtool_fdir_entry(struct ice_hw *hw, struct ethtool_rxnfc *cmd)
 	memset(&fsp->m_ext, 0, sizeof(fsp->m_ext));
 
 	switch (fsp->flow_type) {
+	case ETHER_FLOW:
+		fsp->h_u.ether_spec = rule->eth;
+		fsp->m_u.ether_spec = rule->eth_mask;
+		break;
 	case IPV4_USER_FLOW:
 		fsp->h_u.usr_ip4_spec.ip_ver = ETH_RX_NFC_IP4;
 		fsp->h_u.usr_ip4_spec.proto = 0;
@@ -1193,6 +1201,122 @@ ice_set_fdir_ip6_usr_seg(struct ice_flow_seg_info *seg,
 	return 0;
 }
 
+/**
+ * ice_fdir_vlan_valid - validate VLAN data for Flow Director rule
+ * @dev: network interface device structure
+ * @fsp: pointer to ethtool Rx flow specification
+ *
+ * Return: true if vlan data is valid, false otherwise
+ */
+static bool ice_fdir_vlan_valid(struct device *dev,
+				struct ethtool_rx_flow_spec *fsp)
+{
+	if (fsp->m_ext.vlan_etype && !eth_type_vlan(fsp->h_ext.vlan_etype))
+		return false;
+
+	if (fsp->m_ext.vlan_tci && ntohs(fsp->h_ext.vlan_tci) >= VLAN_N_VID)
+		return false;
+
+	/* proto and vlan must have vlan-etype defined */
+	if (fsp->m_u.ether_spec.h_proto && fsp->m_ext.vlan_tci &&
+	    !fsp->m_ext.vlan_etype) {
+		dev_warn(dev, "Filter with proto and vlan require also vlan-etype");
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * ice_set_ether_flow_seg - set address and protocol segments for ether flow
+ * @dev: network interface device structure
+ * @seg: flow segment for programming
+ * @eth_spec: mask data from ethtool
+ *
+ * Return: 0 on success and errno in case of error.
+ */
+static int ice_set_ether_flow_seg(struct device *dev,
+				  struct ice_flow_seg_info *seg,
+				  struct ethhdr *eth_spec)
+{
+	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_ETH);
+
+	/* empty rules are not valid */
+	if (is_zero_ether_addr(eth_spec->h_source) &&
+	    is_zero_ether_addr(eth_spec->h_dest) &&
+	    !eth_spec->h_proto)
+		return -EINVAL;
+
+	/* Ethertype */
+	if (eth_spec->h_proto == htons(0xFFFF)) {
+		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_ETH_TYPE,
+				 ICE_FLOW_FLD_OFF_INVAL,
+				 ICE_FLOW_FLD_OFF_INVAL,
+				 ICE_FLOW_FLD_OFF_INVAL, false);
+	} else if (eth_spec->h_proto) {
+		dev_warn(dev, "Only 0x0000 or 0xffff proto mask is allowed for flow-type ether");
+		return -EOPNOTSUPP;
+	}
+
+	/* Source MAC address */
+	if (is_broadcast_ether_addr(eth_spec->h_source))
+		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_ETH_SA,
+				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
+				 ICE_FLOW_FLD_OFF_INVAL, false);
+	else if (!is_zero_ether_addr(eth_spec->h_source))
+		goto err_mask;
+
+	/* Destination MAC address */
+	if (is_broadcast_ether_addr(eth_spec->h_dest))
+		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_ETH_DA,
+				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
+				 ICE_FLOW_FLD_OFF_INVAL, false);
+	else if (!is_zero_ether_addr(eth_spec->h_dest))
+		goto err_mask;
+
+	return 0;
+
+err_mask:
+	dev_warn(dev, "Only 00:00:00:00:00:00 or ff:ff:ff:ff:ff:ff MAC address mask is allowed for flow-type ether");
+	return -EOPNOTSUPP;
+}
+
+/**
+ * ice_set_fdir_vlan_seg - set vlan segments for ether flow
+ * @seg: flow segment for programming
+ * @ext_masks: masks for additional RX flow fields
+ *
+ * Return: 0 on success and errno in case of error.
+ */
+static int
+ice_set_fdir_vlan_seg(struct ice_flow_seg_info *seg,
+		      struct ethtool_flow_ext *ext_masks)
+{
+	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_VLAN);
+
+	if (ext_masks->vlan_etype) {
+		if (ext_masks->vlan_etype != htons(0xFFFF))
+			return -EOPNOTSUPP;
+
+		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_S_VLAN,
+				 ICE_FLOW_FLD_OFF_INVAL,
+				 ICE_FLOW_FLD_OFF_INVAL,
+				 ICE_FLOW_FLD_OFF_INVAL, false);
+	}
+
+	if (ext_masks->vlan_tci) {
+		if (ext_masks->vlan_tci != htons(0xFFFF))
+			return -EOPNOTSUPP;
+
+		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_C_VLAN,
+				 ICE_FLOW_FLD_OFF_INVAL,
+				 ICE_FLOW_FLD_OFF_INVAL,
+				 ICE_FLOW_FLD_OFF_INVAL, false);
+	}
+
+	return 0;
+}
+
 /**
  * ice_cfg_fdir_xtrct_seq - Configure extraction sequence for the given filter
  * @pf: PF structure
@@ -1209,7 +1333,7 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 	struct device *dev = ice_pf_to_dev(pf);
 	enum ice_fltr_ptype fltr_idx;
 	struct ice_hw *hw = &pf->hw;
-	bool perfect_filter;
+	bool perfect_filter = false;
 	int ret;
 
 	seg = devm_kzalloc(dev, sizeof(*seg), GFP_KERNEL);
@@ -1262,6 +1386,16 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 		ret = ice_set_fdir_ip6_usr_seg(seg, &fsp->m_u.usr_ip6_spec,
 					       &perfect_filter);
 		break;
+	case ETHER_FLOW:
+		ret = ice_set_ether_flow_seg(dev, seg, &fsp->m_u.ether_spec);
+		if (!ret && (fsp->m_ext.vlan_etype || fsp->m_ext.vlan_tci)) {
+			if (!ice_fdir_vlan_valid(dev, fsp)) {
+				ret = -EINVAL;
+				break;
+			}
+			ret = ice_set_fdir_vlan_seg(seg, &fsp->m_ext);
+		}
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -1823,6 +1957,10 @@ ice_set_fdir_input_set(struct ice_vsi *vsi, struct ethtool_rx_flow_spec *fsp,
 		input->mask.v6.tc = fsp->m_u.usr_ip6_spec.tclass;
 		input->mask.v6.proto = fsp->m_u.usr_ip6_spec.l4_proto;
 		break;
+	case ETHER_FLOW:
+		input->eth = fsp->h_u.ether_spec;
+		input->eth_mask = fsp->m_u.ether_spec;
+		break;
 	default:
 		/* not doing un-parsed flow types */
 		return -EINVAL;
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
index 1f7b26f38818..26b357c0ae15 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
@@ -4,6 +4,8 @@
 #include "ice_common.h"
 
 /* These are training packet headers used to program flow director filters. */
+static const u8 ice_fdir_eth_pkt[22];
+
 static const u8 ice_fdir_tcpv4_pkt[] = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x45, 0x00,
@@ -416,6 +418,11 @@ static const u8 ice_fdir_ip6_tun_pkt[] = {
 
 /* Flow Director no-op training packet table */
 static const struct ice_fdir_base_pkt ice_fdir_pkt[] = {
+	{
+		ICE_FLTR_PTYPE_NONF_ETH,
+		sizeof(ice_fdir_eth_pkt), ice_fdir_eth_pkt,
+		sizeof(ice_fdir_eth_pkt), ice_fdir_eth_pkt,
+	},
 	{
 		ICE_FLTR_PTYPE_NONF_IPV4_TCP,
 		sizeof(ice_fdir_tcpv4_pkt), ice_fdir_tcpv4_pkt,
@@ -914,6 +921,21 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 	 * perspective. The input from user is from Rx filter perspective.
 	 */
 	switch (flow) {
+	case ICE_FLTR_PTYPE_NONF_ETH:
+		ice_pkt_insert_mac_addr(loc, input->eth.h_dest);
+		ice_pkt_insert_mac_addr(loc + ETH_ALEN, input->eth.h_source);
+		if (input->ext_data.vlan_tag || input->ext_data.vlan_type) {
+			ice_pkt_insert_u16(loc, ICE_ETH_TYPE_F_OFFSET,
+					   input->ext_data.vlan_type);
+			ice_pkt_insert_u16(loc, ICE_ETH_VLAN_TCI_OFFSET,
+					   input->ext_data.vlan_tag);
+			ice_pkt_insert_u16(loc, ICE_ETH_TYPE_VLAN_OFFSET,
+					   input->eth.h_proto);
+		} else {
+			ice_pkt_insert_u16(loc, ICE_ETH_TYPE_F_OFFSET,
+					   input->eth.h_proto);
+		}
+		break;
 	case ICE_FLTR_PTYPE_NONF_IPV4_TCP:
 		ice_pkt_insert_u32(loc, ICE_IPV4_DST_ADDR_OFFSET,
 				   input->ip.v4.src_ip);
@@ -1201,6 +1223,10 @@ ice_fdir_comp_rules(struct ice_fdir_fltr *a,  struct ice_fdir_fltr *b)
 	 * same flow_type.
 	 */
 	switch (flow_type) {
+	case ICE_FLTR_PTYPE_NONF_ETH:
+		if (!memcmp(&a->eth, &b->eth, sizeof(a->eth)))
+			return true;
+		break;
 	case ICE_FLTR_PTYPE_NONF_IPV4_TCP:
 	case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
 	case ICE_FLTR_PTYPE_NONF_IPV4_SCTP:
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.h b/drivers/net/ethernet/intel/ice/ice_fdir.h
index 1b9b84490689..021ecbac7848 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.h
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.h
@@ -8,6 +8,9 @@
 #define ICE_FDIR_MAX_RAW_PKT_SIZE	(512 + ICE_FDIR_TUN_PKT_OFF)
 
 /* macros for offsets into packets for flow director programming */
+#define ICE_ETH_TYPE_F_OFFSET		12
+#define ICE_ETH_VLAN_TCI_OFFSET		14
+#define ICE_ETH_TYPE_VLAN_OFFSET	16
 #define ICE_IPV4_SRC_ADDR_OFFSET	26
 #define ICE_IPV4_DST_ADDR_OFFSET	30
 #define ICE_IPV4_TCP_SRC_PORT_OFFSET	34
@@ -159,6 +162,8 @@ struct ice_fdir_fltr {
 	struct list_head fltr_node;
 	enum ice_fltr_ptype flow_type;
 
+	struct ethhdr eth, eth_mask;
+
 	union {
 		struct ice_fdir_v4 v4;
 		struct ice_fdir_v6 v6;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 08ec5efdafe6..4049ae40c4fb 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -203,6 +203,7 @@ struct ice_phy_info {
 enum ice_fltr_ptype {
 	/* NONE - used for undef/error */
 	ICE_FLTR_PTYPE_NONF_NONE = 0,
+	ICE_FLTR_PTYPE_NONF_ETH,
 	ICE_FLTR_PTYPE_NONF_IPV4_UDP,
 	ICE_FLTR_PTYPE_NONF_IPV4_TCP,
 	ICE_FLTR_PTYPE_NONF_IPV4_SCTP,
-- 
2.41.0


