Return-Path: <netdev+bounces-87147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D068A1ECF
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890ADB2F2C5
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E185E126F1B;
	Thu, 11 Apr 2024 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nf3MeVMm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A41754B
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857139; cv=none; b=B0o6TTDeJpQck7ZLx1v4Bfd9vvKgPEhYRAysnliuvmLEvrOcO616aOJUs43A68tU0Ic8+cFNWjY9B6TxZmQ0htDaMJuayK2lcRAh18XRIXWeYKzcpjIJPMBl/yFvpNB1OSDdag655OSKBYiKHcfhePvzm577A6CZcus+14aD2Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857139; c=relaxed/simple;
	bh=t1v8jGsKAPrH5TmrE3jDtjQo7GcCEqE1M8RcbB55TRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6u2czBktJrWix0X9s/SLDGzhYnaT1OecUGlUkAF1Z9AKTSIbVUUqCsF0KNOecdDcKnfzgO9sa6dhujNJViG0eng/OUwJWVAz5QZhABvoeowWw+I1WaH+Onzryrd2qbV9gKKzYSOouyuofAyA2e1PE/9VreqD/uVPU+WAIrO+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nf3MeVMm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857138; x=1744393138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t1v8jGsKAPrH5TmrE3jDtjQo7GcCEqE1M8RcbB55TRQ=;
  b=nf3MeVMmrQtfS2TmekJ9ryCHvmZsdI3i8WsLNVNAoEG/ciz33438KCVX
   n0DwF5sopF8uABzPreJ/2pLLTP67gKr3HYtbswa0GzX3JW2y+Bi8AfxWS
   oz7Nqp7r/EGsPLLurqCnjrtNVOCcuq2RdtaFKWxaqPqYXdjwVLg/jmiKm
   kd03/qIl7hz4lvflrE9YecatF7eAIlh7kI2yGvWjUB7nIDCg6Yjvsrelg
   ObTbR+cw/K9kXN6na1/y9fSvubTgmq6Agb1ky21IO3yomI/Lu0iq2nEqM
   zhXzVydGKyqz9W7qquLeb83+WA4KgYsG60U5bHv/AFeCQQB/JfeUkhLRG
   A==;
X-CSE-ConnectionGUID: N4jlr1QETQGnqyISuK322Q==
X-CSE-MsgGUID: 0Hb4ohpoRfqcLG+kfRJ0Kw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="11252950"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="11252950"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:38:57 -0700
X-CSE-ConnectionGUID: wR7U2VF0Tze4DkuL9z3CpQ==
X-CSE-MsgGUID: N/FVFghZTsSOjgFLKcnJ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20949094"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Apr 2024 10:38:56 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Lukasz Plachno <lukasz.plachno@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/4] ice: Remove unnecessary argument from ice_fdir_comp_rules()
Date: Thu, 11 Apr 2024 10:38:41 -0700
Message-ID: <20240411173846.157007-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411173846.157007-1-anthony.l.nguyen@intel.com>
References: <20240411173846.157007-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Plachno <lukasz.plachno@intel.com>

Passing v6 argument is unnecessary as flow_type is still
analyzed inside the function.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fdir.c | 85 +++++++++++------------
 1 file changed, 39 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
index 5840c3e04a5b..1f7b26f38818 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
@@ -1189,52 +1189,54 @@ static int ice_cmp_ipv6_addr(__be32 *a, __be32 *b)
  * ice_fdir_comp_rules - compare 2 filters
  * @a: a Flow Director filter data structure
  * @b: a Flow Director filter data structure
- * @v6: bool true if v6 filter
  *
  * Returns true if the filters match
  */
 static bool
-ice_fdir_comp_rules(struct ice_fdir_fltr *a,  struct ice_fdir_fltr *b, bool v6)
+ice_fdir_comp_rules(struct ice_fdir_fltr *a,  struct ice_fdir_fltr *b)
 {
 	enum ice_fltr_ptype flow_type = a->flow_type;
 
 	/* The calling function already checks that the two filters have the
 	 * same flow_type.
 	 */
-	if (!v6) {
-		if (flow_type == ICE_FLTR_PTYPE_NONF_IPV4_TCP ||
-		    flow_type == ICE_FLTR_PTYPE_NONF_IPV4_UDP ||
-		    flow_type == ICE_FLTR_PTYPE_NONF_IPV4_SCTP) {
-			if (a->ip.v4.dst_ip == b->ip.v4.dst_ip &&
-			    a->ip.v4.src_ip == b->ip.v4.src_ip &&
-			    a->ip.v4.dst_port == b->ip.v4.dst_port &&
-			    a->ip.v4.src_port == b->ip.v4.src_port)
-				return true;
-		} else if (flow_type == ICE_FLTR_PTYPE_NONF_IPV4_OTHER) {
-			if (a->ip.v4.dst_ip == b->ip.v4.dst_ip &&
-			    a->ip.v4.src_ip == b->ip.v4.src_ip &&
-			    a->ip.v4.l4_header == b->ip.v4.l4_header &&
-			    a->ip.v4.proto == b->ip.v4.proto &&
-			    a->ip.v4.ip_ver == b->ip.v4.ip_ver &&
-			    a->ip.v4.tos == b->ip.v4.tos)
-				return true;
-		}
-	} else {
-		if (flow_type == ICE_FLTR_PTYPE_NONF_IPV6_UDP ||
-		    flow_type == ICE_FLTR_PTYPE_NONF_IPV6_TCP ||
-		    flow_type == ICE_FLTR_PTYPE_NONF_IPV6_SCTP) {
-			if (a->ip.v6.dst_port == b->ip.v6.dst_port &&
-			    a->ip.v6.src_port == b->ip.v6.src_port &&
-			    !ice_cmp_ipv6_addr(a->ip.v6.dst_ip,
-					       b->ip.v6.dst_ip) &&
-			    !ice_cmp_ipv6_addr(a->ip.v6.src_ip,
-					       b->ip.v6.src_ip))
-				return true;
-		} else if (flow_type == ICE_FLTR_PTYPE_NONF_IPV6_OTHER) {
-			if (a->ip.v6.dst_port == b->ip.v6.dst_port &&
-			    a->ip.v6.src_port == b->ip.v6.src_port)
-				return true;
-		}
+	switch (flow_type) {
+	case ICE_FLTR_PTYPE_NONF_IPV4_TCP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_SCTP:
+		if (a->ip.v4.dst_ip == b->ip.v4.dst_ip &&
+		    a->ip.v4.src_ip == b->ip.v4.src_ip &&
+		    a->ip.v4.dst_port == b->ip.v4.dst_port &&
+		    a->ip.v4.src_port == b->ip.v4.src_port)
+			return true;
+		break;
+	case ICE_FLTR_PTYPE_NONF_IPV4_OTHER:
+		if (a->ip.v4.dst_ip == b->ip.v4.dst_ip &&
+		    a->ip.v4.src_ip == b->ip.v4.src_ip &&
+		    a->ip.v4.l4_header == b->ip.v4.l4_header &&
+		    a->ip.v4.proto == b->ip.v4.proto &&
+		    a->ip.v4.ip_ver == b->ip.v4.ip_ver &&
+		    a->ip.v4.tos == b->ip.v4.tos)
+			return true;
+		break;
+	case ICE_FLTR_PTYPE_NONF_IPV6_UDP:
+	case ICE_FLTR_PTYPE_NONF_IPV6_TCP:
+	case ICE_FLTR_PTYPE_NONF_IPV6_SCTP:
+		if (a->ip.v6.dst_port == b->ip.v6.dst_port &&
+		    a->ip.v6.src_port == b->ip.v6.src_port &&
+		    !ice_cmp_ipv6_addr(a->ip.v6.dst_ip,
+				       b->ip.v6.dst_ip) &&
+		    !ice_cmp_ipv6_addr(a->ip.v6.src_ip,
+				       b->ip.v6.src_ip))
+			return true;
+		break;
+	case ICE_FLTR_PTYPE_NONF_IPV6_OTHER:
+		if (a->ip.v6.dst_port == b->ip.v6.dst_port &&
+		    a->ip.v6.src_port == b->ip.v6.src_port)
+			return true;
+		break;
+	default:
+		break;
 	}
 
 	return false;
@@ -1253,19 +1255,10 @@ bool ice_fdir_is_dup_fltr(struct ice_hw *hw, struct ice_fdir_fltr *input)
 	bool ret = false;
 
 	list_for_each_entry(rule, &hw->fdir_list_head, fltr_node) {
-		enum ice_fltr_ptype flow_type;
-
 		if (rule->flow_type != input->flow_type)
 			continue;
 
-		flow_type = input->flow_type;
-		if (flow_type == ICE_FLTR_PTYPE_NONF_IPV4_TCP ||
-		    flow_type == ICE_FLTR_PTYPE_NONF_IPV4_UDP ||
-		    flow_type == ICE_FLTR_PTYPE_NONF_IPV4_SCTP ||
-		    flow_type == ICE_FLTR_PTYPE_NONF_IPV4_OTHER)
-			ret = ice_fdir_comp_rules(rule, input, false);
-		else
-			ret = ice_fdir_comp_rules(rule, input, true);
+		ret = ice_fdir_comp_rules(rule, input);
 		if (ret) {
 			if (rule->fltr_id == input->fltr_id &&
 			    rule->q_index != input->q_index)
-- 
2.41.0


