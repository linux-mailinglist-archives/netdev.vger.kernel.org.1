Return-Path: <netdev+bounces-73978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E8285F84E
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C13F1F24310
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA612DDBC;
	Thu, 22 Feb 2024 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6+ueE8T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2312DDAE
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605342; cv=none; b=QZ/zbG3g8sW8h3WJSdvXjVmDW/vR1XtPLhMCjPdHMnMYOBb8BW6oPBoYTsYDjzfMVQPT3RQV0a8/6zyAXlNC2CIMhHiZPKtZguGzYZjpyIGgIS2Ml9fPECinsL6N1UFEz993vMoIxgykLZIefiL5MP2iRFJ8dJZHHdQ7Hjm6aOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605342; c=relaxed/simple;
	bh=ESZSTSJBQuVw5Q3xfrdDncyNP1YqzXp/ly1ZX4iT4vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpwpgYAa5oEG24LVWQ15+ZpwERHpNHYpZVlH8WMnXT3l8z9Tl68x7OKU7aR8jeRm1nVQLKGoLUEFsr69ai3m/4BYrU++J5RMQoGyX+XQ/4qRz9G6CxboaZgtCT/k9XYCA4foe1wwlHQkeTTWAyogGpfwGptmqyWbfIiCFB7nk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6+ueE8T; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708605341; x=1740141341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ESZSTSJBQuVw5Q3xfrdDncyNP1YqzXp/ly1ZX4iT4vE=;
  b=W6+ueE8T2kTqG1y+S8jCsaGMGr3t7VLtvw6tiXE3mxTXPuGQF5eg0bej
   6YA65GX0GrW+Hk3xi6py4j+5W0xONvM3KMchwvTBCTTGCmW6yAz7OEiwJ
   VLJ1W/jT44Nk2YL9UcZkat2egev35LQ6oOVmcUY6VQ0BDEHEUB4y6+DxP
   SwdF96EYaBRJvk1YJFHnKUOVeKDPVLFdp2wLRhuF7ZaHeZCexXyC/mRp2
   xr4UJG0vwDdM1cVkxC2oPW1Vg/qpZxLGvt23EEJQTMBeSwbQjWwNuYTB8
   HdzXesuSFOCvdBqAvlkISXRYUSKVhOMCne53Qy/LGWSyTkHnA/NLjwjgX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28267859"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="28267859"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10216255"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa005.jf.intel.com with ESMTP; 22 Feb 2024 04:35:39 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com,
	pmenzel@molgen.mpg.de,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [iwl-next v2 2/2] ice: tc: allow ip_proto matching
Date: Thu, 22 Feb 2024 13:39:56 +0100
Message-ID: <20240222123956.2393-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240222123956.2393-1-michal.swiatkowski@linux.intel.com>
References: <20240222123956.2393-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new matching type for ip_proto.

Use it in the same lookup type as for TTL. In hardware it has the same
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


