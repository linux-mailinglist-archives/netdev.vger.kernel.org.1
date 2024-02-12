Return-Path: <netdev+bounces-70934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14058511BB
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 12:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17414B2279A
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F8A2556F;
	Mon, 12 Feb 2024 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdGHDgGT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA72555B
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735843; cv=none; b=ARquwZrYHv0Os9crcUxC4aCFHpDvK+kvlgN3+3A5RyCzDHcskv2Qz2qggevFGifaZ0Lj+8qvGuQVtS1vT6F7afqJ/eTZ3y1boznUg7khM42GalFi9YP56aPZHXYR+JuMY7t/fexVsji+U60amKSy/MbRc7hJ+4CFW4sO6RXYWkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735843; c=relaxed/simple;
	bh=z+n97d6An88tJV5Y9V6/aZYxS3sbuofXU6LAu9LMEHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hYqnvs8sZPL+zk9/wmKyahwZriuPc7ddmYgexXJEoFFO7wkT20oSIQXGABk9ADhXZoeBlXyZN9871B/44ZkJtpKlDncCsYTqNKDxZ+7FkwajHjtlCQuE1tkSBCdx2hTM6hFsRPQddEsGkyJmevFFeqBocuhSo02KlgZhD5M68Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdGHDgGT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707735841; x=1739271841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z+n97d6An88tJV5Y9V6/aZYxS3sbuofXU6LAu9LMEHQ=;
  b=SdGHDgGT/NcXbM4TwmajEBo/Qsa7u5+i9ZtaudFlN6PalZFgHBb9p+kD
   KIqVjOgU4IpJoJYVy4gy0sAIRNX1/XDBA9k28qnvms76ox/GxrRKoj6Pv
   DMC3fV6BZahXfoFhtHQBnwGaT/FlCdmyjoR920IVLWTHPJi1lrOt3JGdz
   8aR842I2ic6ea8CvbCYoO0t979u+CG1yerSdOr8F8JtwFQ0IOWwTU/zz1
   HP+Ss2m41BpfClPJWt2Sy1HF5rjP08shjgXqON8dz+QEmxlIfbovg4xfw
   m/RBOZmlr/dObKXgW38sLUFchlqZsyjnJeW+uzN9J4W0ncRUGD6Ffhg9V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1831300"
X-IronPort-AV: E=Sophos;i="6.05,263,1701158400"; 
   d="scan'208";a="1831300"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 03:04:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,263,1701158400"; 
   d="scan'208";a="7211104"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 12 Feb 2024 03:03:56 -0800
Received: from lplachno-mobl.ger.corp.intel.com (lplachno-mobl.ger.corp.intel.com [10.237.140.88])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BCC43135F7;
	Mon, 12 Feb 2024 11:03:54 +0000 (GMT)
From: Lukasz Plachno <lukasz.plachno@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	brett.creeley@amd.com,
	horms@kernel.org,
	pmenzel@molgen.mpg.de,
	aleksander.lobakin@intel.com,
	Jakub Buchocki <jakubx.buchocki@intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Lukasz Plachno <lukasz.plachno@intel.com>
Subject: [PATCH iwl-next v7 2/2] ice: Implement 'flow-type ether' rules
Date: Mon, 12 Feb 2024 12:03:11 +0100
Message-Id: <20240212110307.12704-3-lukasz.plachno@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212110307.12704-1-lukasz.plachno@intel.com>
References: <20240212110307.12704-1-lukasz.plachno@intel.com>
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
Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>
---
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 130 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.c     |  27 ++++
 drivers/net/ethernet/intel/ice/ice_fdir.h     |   5 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 4 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index 9a1a04f5f146..6963e0da6518 100644
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
@@ -1193,6 +1201,112 @@ ice_set_fdir_ip6_usr_seg(struct ice_flow_seg_info *seg,
 	return 0;
 }
 
+/**
+ * ice_fdir_vlan_valid - validate VLAN data for Flow Director rule
+ * @fsp: pointer to ethtool Rx flow specification
+ *
+ * Return: true if vlan data is valid, false otherwise
+ */
+static bool ice_fdir_vlan_valid(struct ethtool_rx_flow_spec *fsp)
+{
+	if (fsp->m_ext.vlan_etype && !eth_type_vlan(fsp->h_ext.vlan_etype))
+		return false;
+
+	if (fsp->m_ext.vlan_tci &&
+	    ntohs(fsp->h_ext.vlan_tci) >= VLAN_N_VID)
+		return false;
+
+	return true;
+}
+
+/**
+ * ice_set_ether_flow_seg
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
+ * ice_set_fdir_vlan_seg
+ * @seg: flow segment for programming
+ * @ext_masks: masks for additional RX flow fields
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
@@ -1209,7 +1323,7 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 	struct device *dev = ice_pf_to_dev(pf);
 	enum ice_fltr_ptype fltr_idx;
 	struct ice_hw *hw = &pf->hw;
-	bool perfect_filter;
+	bool perfect_filter = false;
 	int ret;
 
 	seg = devm_kzalloc(dev, sizeof(*seg), GFP_KERNEL);
@@ -1262,6 +1376,16 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 		ret = ice_set_fdir_ip6_usr_seg(seg, &fsp->m_u.usr_ip6_spec,
 					       &perfect_filter);
 		break;
+	case ETHER_FLOW:
+		ret = ice_set_ether_flow_seg(dev, seg, &fsp->m_u.ether_spec);
+		if (!ret && (fsp->m_ext.vlan_etype || fsp->m_ext.vlan_tci)) {
+			if (!ice_fdir_vlan_valid(fsp)) {
+				ret = -EINVAL;
+				break;
+			}
+			ret = ice_set_fdir_vlan_seg(seg, &fsp->m_ext);
+		}
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -1823,6 +1947,10 @@ ice_set_fdir_input_set(struct ice_vsi *vsi, struct ethtool_rx_flow_spec *fsp,
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
index 1f7b26f38818..b51ca73ca6c4 100644
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
@@ -914,6 +921,22 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 	 * perspective. The input from user is from Rx filter perspective.
 	 */
 	switch (flow) {
+	case ICE_FLTR_PTYPE_NONF_ETH:
+		ice_pkt_insert_mac_addr(loc, input->eth.h_dest);
+		ice_pkt_insert_mac_addr(loc + ETH_ALEN, input->eth.h_source);
+		if (input->ext_data.vlan_tag ||
+		    input->ext_data.vlan_type) {
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
@@ -1201,6 +1224,10 @@ ice_fdir_comp_rules(struct ice_fdir_fltr *a,  struct ice_fdir_fltr *b)
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
index 6df7c4487ad0..391e48d2bb92 100644
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
2.34.1


