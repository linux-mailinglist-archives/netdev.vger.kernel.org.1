Return-Path: <netdev+bounces-277295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OAxCmqs2GljgwgAu9opvQ
	(envelope-from <netdev+bounces-277295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:53:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0CB3D39E1
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FD4930523CE
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5AA39E184;
	Fri, 10 Apr 2026 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTbEJEHz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818FC3A453B
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807380; cv=none; b=Ilc+IuQf5SkfxQqpHb9YKnQZCBx6PSkU/g7ajjBrFx5v6Apa91xbl4A2Iq3tMxENbP7x2OiZMcaHc3LwEC5T9JykHUSLABCAjSYPNZ7EygjORlH653xN2vd4S9JH1j8vgRSpVRAikKdp3Jl3ZbYo/ZaC1rigaVnsDIShXmpZmg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807380; c=relaxed/simple;
	bh=/GsckPs+NdN9rChj/2Ywk80a8qYQmlKLwO31lOo/oAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/7YQUcr2E3qiYTeu6kwDR7IPQbGQn+e7v8MUMHeyHAAUGGi0JIyPeLHTy9n0lCgWeHhKAYz9ADVKEeXdAQfQmURQt3xTa7HQLPHnVL0JEsP1T5STbFujyPIsdKCPWLzStJ+Pve5hlL3PHFQLmNeJTrGwsUcqtN0GhUYFV/KZu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTbEJEHz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775807378; x=1807343378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/GsckPs+NdN9rChj/2Ywk80a8qYQmlKLwO31lOo/oAA=;
  b=GTbEJEHzMxvfC9iI0ml3AGy7t/6T6ycaZNp+yI/r1TVHch4mbMV8K1yP
   d1TQt3eAWhINmbV/MH29Ek3xadMWBpT5nDS4/WzBjS0QOJ9VPP1k8Ubm4
   Kf+V75ZzM0ymS6jf3u7PUb+S7OodvG86HqA+agBmxscZSnOLS3wo4Mtde
   nvFPHE3qSk7cLt5NaN1NCX2VHwMTjLLkQHLs+Z3KURAfUxiiOOZr9F5UT
   16VQOKY73MiuJ6Y7mYGHYAbaoqRV/gCqDwbtGt3Z83XExPNN0aaKCE+54
   ZFo1sEBeO0Cbuav0sv125ezCjAIIKD20A/GgB06n2isk2n7y8dViUIsBp
   Q==;
X-CSE-ConnectionGUID: D9VfSpNvRjOaweIy6iGNIw==
X-CSE-MsgGUID: RgnwbA92RZ2/CiwJdvEujQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007944"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77007944"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 00:49:38 -0700
X-CSE-ConnectionGUID: zT8ceFmrThObprmwK0C0cg==
X-CSE-MsgGUID: b+wSATUkTWCA7gjGbjtZlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228941906"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:37 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH iwl-next 9/10] ice: use inline helpers instead of memcmp() for IPv6 mask checks in ice_ethtool_fdir
Date: Fri, 10 Apr 2026 09:49:20 +0200
Message-ID: <20260410074921.1254213-10-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277295-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B0CB3D39E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace static full_ipv6_addr_mask / zero_ipv6_addr_mask structs
and the associated memcmp() calls in ice_ethtool_fdir.c with the
kernel-provided ipv6_addr_any() helper and a new ice_ipv6_mask_full()
inline, reducing boilerplate and making intent clearer.

Suggested-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 57 ++++++-------------
 1 file changed, 16 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index aceec18..1d7c595 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -8,23 +8,10 @@
 #include "ice_fdir.h"
 #include "ice_flow.h"
 
-static struct in6_addr full_ipv6_addr_mask = {
-	.in6_u = {
-		.u6_addr8 = {
-			0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-			0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-		}
-	}
-};
-
-static struct in6_addr zero_ipv6_addr_mask = {
-	.in6_u = {
-		.u6_addr8 = {
-			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-		}
-	}
-};
+static bool ice_ipv6_mask_full(const __be32 *a)
+{
+	return (a[0] & a[1] & a[2] & a[3]) == cpu_to_be32(0xffffffff);
+}
 
 /* calls to ice_flow_add_prof require the number of segments in the array
  * for segs_cnt. In this code that is one more than the index.
@@ -1070,10 +1057,8 @@ ice_set_fdir_ip6_seg(struct ice_flow_seg_info *seg,
 	enum ice_flow_field src_port, dst_port;
 
 	/* make sure we don't have any empty rule */
-	if (!memcmp(tcp_ip6_spec->ip6src, &zero_ipv6_addr_mask,
-		    sizeof(struct in6_addr)) &&
-	    !memcmp(tcp_ip6_spec->ip6dst, &zero_ipv6_addr_mask,
-		    sizeof(struct in6_addr)) &&
+	if (ipv6_addr_any((struct in6_addr *)tcp_ip6_spec->ip6src) &&
+	    ipv6_addr_any((struct in6_addr *)tcp_ip6_spec->ip6dst) &&
 	    !tcp_ip6_spec->psrc && !tcp_ip6_spec->pdst)
 		return -EINVAL;
 
@@ -1097,24 +1082,20 @@ ice_set_fdir_ip6_seg(struct ice_flow_seg_info *seg,
 	*perfect_fltr = true;
 	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV6 | l4_proto);
 
-	if (!memcmp(tcp_ip6_spec->ip6src, &full_ipv6_addr_mask,
-		    sizeof(struct in6_addr)))
+	if (ice_ipv6_mask_full(tcp_ip6_spec->ip6src))
 		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV6_SA,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, false);
-	else if (!memcmp(tcp_ip6_spec->ip6src, &zero_ipv6_addr_mask,
-			 sizeof(struct in6_addr)))
+	else if (ipv6_addr_any((struct in6_addr *)tcp_ip6_spec->ip6src))
 		*perfect_fltr = false;
 	else
 		return -EOPNOTSUPP;
 
-	if (!memcmp(tcp_ip6_spec->ip6dst, &full_ipv6_addr_mask,
-		    sizeof(struct in6_addr)))
+	if (ice_ipv6_mask_full(tcp_ip6_spec->ip6dst))
 		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV6_DA,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, false);
-	else if (!memcmp(tcp_ip6_spec->ip6dst, &zero_ipv6_addr_mask,
-			 sizeof(struct in6_addr)))
+	else if (ipv6_addr_any((struct in6_addr *)tcp_ip6_spec->ip6dst))
 		*perfect_fltr = false;
 	else
 		return -EOPNOTSUPP;
@@ -1167,33 +1148,27 @@ ice_set_fdir_ip6_usr_seg(struct ice_flow_seg_info *seg,
 	if (usr_ip6_spec->l4_proto)
 		return -EOPNOTSUPP;
 	/* empty rules are not valid */
-	if (!memcmp(usr_ip6_spec->ip6src, &zero_ipv6_addr_mask,
-		    sizeof(struct in6_addr)) &&
-	    !memcmp(usr_ip6_spec->ip6dst, &zero_ipv6_addr_mask,
-		    sizeof(struct in6_addr)))
+	if (ipv6_addr_any((struct in6_addr *)usr_ip6_spec->ip6src) &&
+	    ipv6_addr_any((struct in6_addr *)usr_ip6_spec->ip6dst))
 		return -EINVAL;
 
 	*perfect_fltr = true;
 	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV6);
 
-	if (!memcmp(usr_ip6_spec->ip6src, &full_ipv6_addr_mask,
-		    sizeof(struct in6_addr)))
+	if (ice_ipv6_mask_full(usr_ip6_spec->ip6src))
 		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV6_SA,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, false);
-	else if (!memcmp(usr_ip6_spec->ip6src, &zero_ipv6_addr_mask,
-			 sizeof(struct in6_addr)))
+	else if (ipv6_addr_any((struct in6_addr *)usr_ip6_spec->ip6src))
 		*perfect_fltr = false;
 	else
 		return -EOPNOTSUPP;
 
-	if (!memcmp(usr_ip6_spec->ip6dst, &full_ipv6_addr_mask,
-		    sizeof(struct in6_addr)))
+	if (ice_ipv6_mask_full(usr_ip6_spec->ip6dst))
 		ice_flow_set_fld(seg, ICE_FLOW_FIELD_IDX_IPV6_DA,
 				 ICE_FLOW_FLD_OFF_INVAL, ICE_FLOW_FLD_OFF_INVAL,
 				 ICE_FLOW_FLD_OFF_INVAL, false);
-	else if (!memcmp(usr_ip6_spec->ip6dst, &zero_ipv6_addr_mask,
-			 sizeof(struct in6_addr)))
+	else if (ipv6_addr_any((struct in6_addr *)usr_ip6_spec->ip6dst))
 		*perfect_fltr = false;
 	else
 		return -EOPNOTSUPP;
-- 
2.52.0


