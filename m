Return-Path: <netdev+bounces-73252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1300B85B9B1
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3991C21FDB
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B6C657CD;
	Tue, 20 Feb 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1b20KPe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5FF65BCB
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426546; cv=none; b=Sgf+zH0IuP0jviIIWDISjkvDovQrAsQfLiqLgDXf4eNW0/jRLAMdRiVliE5D8GKxNuUJvrnbd8KkW/jaKT16k2YTUrQSZlZFLk9EbFD4CP4e0EM7NZFqGfSC9o5yrc7F2s/MNoqxr+xpNXS8tht/RWYvRKjPEiWnGjwk9KxhBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426546; c=relaxed/simple;
	bh=qRdd7V9+5UqspDmYuA4NwNeiQqMIyHWNaPrJQWScN5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNTf5n9y25RY0wdgoExaqDLytVp8BcdIZ+fkPvYJXSjnzzanIUwH9YFF+UsOOK1KoArTXEKl0Q/hbB2rcoyNy3ODBKVTiv+rBISbov5NF0FO5gqYyhbmPAJqsVwbt89G0DauXQ5EFjUf3kr06FxE/owHKdOXmjyQqtSpyWZC0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1b20KPe; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708426545; x=1739962545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qRdd7V9+5UqspDmYuA4NwNeiQqMIyHWNaPrJQWScN5A=;
  b=H1b20KPe57XBU3t1TzndTRP6RawbApMEDhT4YLJj3sV9Ry7co5dORBup
   lfupRceG1tYoIceqRHz6WbZXgFOO8kxwOARXFo2/s49/Hgw2iiMgY9OtL
   zFA7DTlGfWsnChMDzCpjo08WaTkoufsFXhhJ4P8wQ6lwkydAQ/nk/rzLp
   Y3T95LU7MdstJVifsMx9pnv0lFTW+pharjFONTd/3zpax07ohCMppP5J1
   SFbrO7cxPC0tIK8mf6pVXyVyOAoMzwXIbwpfYX/pQdbTepKcDK0zWgh7h
   zoc7WEALrTgBHY4f5oWudTc8ZFXzvBGvhc6+pYWQ+VmxgqHS1peI/2OE1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13934165"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13934165"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 02:55:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4734494"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa010.fm.intel.com with ESMTP; 20 Feb 2024 02:55:42 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [iwl-next v1 2/2] ice: tc: allow ip_proto matching
Date: Tue, 20 Feb 2024 11:59:50 +0100
Message-ID: <20240220105950.6814-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240220105950.6814-1-michal.swiatkowski@linux.intel.com>
References: <20240220105950.6814-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new matching type. There is no encap version of ip_proto field.

Use it in the same lookup type as for TTL. In hardware it have the same
protocol ID, but different offset.

Example command to add filter with ip_proto:
$tc filter add dev eth10 ingress protocol ip flower ip_proto icmp \
 skip_sw action mirred egress redirect dev eth0

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 17 +++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 49ed5fd7db10..f7c0f62fb730 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -78,7 +78,8 @@ ice_tc_count_lkups(u32 flags, struct ice_tc_flower_lyr_2_4_hdrs *headers,
 		     ICE_TC_FLWR_FIELD_DEST_IPV6 | ICE_TC_FLWR_FIELD_SRC_IPV6))
 		lkups_cnt++;
 
-	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))
+	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
+		     ICE_TC_FLWR_FIELD_IP_PROTO))
 		lkups_cnt++;
 
 	/* are L2TPv3 options specified? */
@@ -530,7 +531,8 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
 	}
 
 	if (headers->l2_key.n_proto == htons(ETH_P_IP) &&
-	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))) {
+	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
+		      ICE_TC_FLWR_FIELD_IP_PROTO))) {
 		list[i].type = ice_proto_type_from_ipv4(inner);
 
 		if (flags & ICE_TC_FLWR_FIELD_IP_TOS) {
@@ -545,6 +547,13 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
 				headers->l3_mask.ttl;
 		}
 
+		if (flags & ICE_TC_FLWR_FIELD_IP_PROTO) {
+			list[i].h_u.ipv4_hdr.protocol =
+				headers->l3_key.ip_proto;
+			list[i].m_u.ipv4_hdr.protocol =
+				headers->l3_mask.ip_proto;
+		}
+
 		i++;
 	}
 
@@ -1515,7 +1524,11 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 
 		headers->l2_key.n_proto = cpu_to_be16(n_proto_key);
 		headers->l2_mask.n_proto = cpu_to_be16(n_proto_mask);
+
+		if (match.key->ip_proto)
+			fltr->flags |= ICE_TC_FLWR_FIELD_IP_PROTO;
 		headers->l3_key.ip_proto = match.key->ip_proto;
+		headers->l3_mask.ip_proto = match.mask->ip_proto;
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
index 65d387163a46..856f371d0687 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
@@ -34,6 +34,7 @@
 #define ICE_TC_FLWR_FIELD_VLAN_PRIO		BIT(27)
 #define ICE_TC_FLWR_FIELD_CVLAN_PRIO		BIT(28)
 #define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT(29)
+#define ICE_TC_FLWR_FIELD_IP_PROTO		BIT(30)
 
 #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF
 
-- 
2.42.0


