Return-Path: <netdev+bounces-69960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B071C84D22C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF888B239E1
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50685943;
	Wed,  7 Feb 2024 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXbdJC/0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213D91EA72
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333432; cv=none; b=q52/3iG4+eM9K+govrhBM4v4lGimNVeub1eJPu/sQegwcq+K7qfSoD3cySGbhQ9SgBT1bdymZfwZkp/kANLdmezEToXnSieblJUxOYXganCyB+qw+r1gdUm6R4hUY5VJLqHX/TvHvqhhUXVViYgP/i3cP2TQlCR/p20MuGtyNkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333432; c=relaxed/simple;
	bh=FSeZnkqvOGaQsutC+szVTo0RdsXSLsvmupjrtuLzAU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqUJXAFY7J7yJlnBwDA10+IhJ6z4OxsK6P5MouYNXszSSwJPIWv+rerByCk2t44eh9odjlhaR5Srkt3AiSodygG+sO4HEGpvrMGxCNhUIFeYBAsxYvH6BnPQUqFwpClJh2qsvz6ZUCvYjUjTEtuGImhjS0HmY+L59LWG0V6ZSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXbdJC/0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707333428; x=1738869428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FSeZnkqvOGaQsutC+szVTo0RdsXSLsvmupjrtuLzAU4=;
  b=LXbdJC/0TkaKSoWbBbZkIFrf//g8HaZjNIbLNrdHfe79tpqqo0QjGxW7
   2ybo/B2+vWrCU/NoYxO1YtnljRaZ3UYfK4ta0tYCyMd9rlB6bSxpKa04i
   Q/NY4w1skyuTvESKaSs6x8SsMr61qlhShJC666EbHhagvgoovgw3QYj2Y
   ECME4+7c5XRJcbVHJOL3SMPM5iBf3yfk9zPX0K+52i0VHqh/mO+8MfNyu
   aebkvwZoBIaSj0rgu68IhVlfngpDzecfs4y3zIfzP4fd4ceQRUT/Vv0w5
   b6pliek7b+0g6e4FpBzM1yS+7gwKSzU6YLirRNal1naiC1uqGpd7Xbj+M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="953483"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="953483"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 11:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1780666"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 07 Feb 2024 11:17:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next 3/3] igc: Unify filtering rule fields
Date: Wed,  7 Feb 2024 11:16:54 -0800
Message-ID: <20240207191656.1250777-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240207191656.1250777-1-anthony.l.nguyen@intel.com>
References: <20240207191656.1250777-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kurt Kanzenbach <kurt@linutronix.de>

All filtering parameters such as EtherType and VLAN TCI are stored in host
byte order except for the VLAN EtherType. Unify it.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  4 ++--
 drivers/net/ethernet/intel/igc/igc_main.c    | 10 ++++++----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 75f7c5ba65e0..d5833c057de4 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -585,7 +585,7 @@ enum igc_filter_match_flags {
 struct igc_nfc_filter {
 	u8 match_flags;
 	u16 etype;
-	__be16 vlan_etype;
+	u16 vlan_etype;
 	u16 vlan_tci;
 	u16 vlan_tci_mask;
 	u8 src_addr[ETH_ALEN];
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 7f844e967421..47c797dd2cd9 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -981,7 +981,7 @@ static int igc_ethtool_get_nfc_rule(struct igc_adapter *adapter,
 
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE) {
 		fsp->flow_type |= FLOW_EXT;
-		fsp->h_ext.vlan_etype = rule->filter.vlan_etype;
+		fsp->h_ext.vlan_etype = htons(rule->filter.vlan_etype);
 		fsp->m_ext.vlan_etype = ETHER_TYPE_FULL_MASK;
 	}
 
@@ -1249,7 +1249,7 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
 
 	/* VLAN etype matching */
 	if ((fsp->flow_type & FLOW_EXT) && fsp->h_ext.vlan_etype) {
-		rule->filter.vlan_etype = fsp->h_ext.vlan_etype;
+		rule->filter.vlan_etype = ntohs(fsp->h_ext.vlan_etype);
 		rule->filter.match_flags |= IGC_FILTER_FLAG_VLAN_ETYPE;
 	}
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 91297b561519..c3fe62813f43 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3614,10 +3614,12 @@ static int igc_add_flex_filter(struct igc_adapter *adapter,
 					  ETH_ALEN, NULL);
 
 	/* Add VLAN etype */
-	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE)
-		igc_flex_filter_add_field(&flex, &filter->vlan_etype, 12,
-					  sizeof(filter->vlan_etype),
-					  NULL);
+	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE) {
+		__be16 vlan_etype = cpu_to_be16(filter->vlan_etype);
+
+		igc_flex_filter_add_field(&flex, &vlan_etype, 12,
+					  sizeof(vlan_etype), NULL);
+	}
 
 	/* Add VLAN TCI */
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_TCI)
-- 
2.41.0


