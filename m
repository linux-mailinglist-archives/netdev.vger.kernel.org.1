Return-Path: <netdev+bounces-179887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 144F4A7ECF5
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20261681DF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733A4255E2B;
	Mon,  7 Apr 2025 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OA2QuLR1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF4219A75
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053042; cv=none; b=a4C3kkF0OcQ5k+Z3J3HC1y7h6THAq040qaTg5tfBhAiUyPy8GlUir4gz8AM2yUCi57fBGlRbS5MS3zJ8sauoPIuQsgD+yJ5ACPbKK/1kGOc7R94+mY2ibPuICsJfpuXWuXQbV/dj9tWD2ImdoCteRuomkLGcwOQH3tZ1LaaGEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053042; c=relaxed/simple;
	bh=XdPEmCvv5SE6rROCgfMBNV4BB3soaiUGgPzfxL0Jfxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T41TOeYbUcDvZZW/isqLQvElOybuw25uTSKemNatA//+ioEohPjnhLs3vUAw206FUOWToZga6SfifBkxb3tVKb5CsJ7kKniaLJPR0RFGDGhec0Ex+2Hze1NDLS545Ea+Z35mX/YJHjOEyyrUqNSVmkqFI5Wy1tOOfqxT6cK40VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OA2QuLR1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744053041; x=1775589041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XdPEmCvv5SE6rROCgfMBNV4BB3soaiUGgPzfxL0Jfxc=;
  b=OA2QuLR10LDsl8eYalU5x/nZa0lEKegPqhUlwvppvvLFDj2XdgRcuGNq
   PX2rWYIaps29g9Gij7Kf7UyGOUhlJaDfqDLQzhCzOAiFj+xparwAhei0r
   aUdYlY3jA8KTw6emz16EQ7DYXeqhZ+sOn90/xXXI6iqgbMR/jYkgifBCg
   1lV95hpNc6avWz3JdWhU8CubTHAekIpCLsjSN9DeIfGQdFJWI6DaIsI6Y
   xGclND3m5qQ2IPwxZD5o6hrtt/lbXc3ekP+jcfx8J9uJk5PASxGB3VF6W
   MzO7NwbvFqzxpxpPeae6LzjC7BRexJG4MQHo6VGtRb43yV7JI3gP22242
   Q==;
X-CSE-ConnectionGUID: 8Ifr91V8Taa8ULXJgwzusg==
X-CSE-MsgGUID: sxVaz9t9STGnjXeT2x9GAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45550375"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45550375"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:10:41 -0700
X-CSE-ConnectionGUID: KgywRTzOTrS/HkPu9pyftA==
X-CSE-MsgGUID: HnpwelkGRxiVdKPI7liCHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="132177619"
Received: from puneetse-mobl.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.57])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:10:34 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	ahmed.zaki@intel.com,
	sridhar.samudrala@intel.com,
	aleksandr.loktionov@intel.com,
	aleksander.lobakin@intel.com,
	dinesh.kumar@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	almasrymina@google.com,
	willemb@google.com
Subject: [PATCH iwl-next v2 1/3] virtchnl2: rename enum virtchnl2_cap_rss
Date: Mon,  7 Apr 2025 13:10:15 -0600
Message-ID: <20250407191017.944214-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407191017.944214-1-ahmed.zaki@intel.com>
References: <20250407191017.944214-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "enum virtchnl2_cap_rss" will be used for negotiating flow
steering capabilities. Instead of adding a new enum, rename
virtchnl2_cap_rss to virtchnl2_flow_types. Also rename the enum's
constants.

Flow steering will use this enum in the next patches.

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 20 +++++------
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 16 ++++-----
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 34 +++++++++----------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 5f73a4cf5161..4e1c0b9e0bda 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -610,16 +610,16 @@ bool idpf_is_capability_ena(struct idpf_adapter *adapter, bool all,
 			    enum idpf_cap_field field, u64 flag);
 
 #define IDPF_CAP_RSS (\
-	VIRTCHNL2_CAP_RSS_IPV4_TCP	|\
-	VIRTCHNL2_CAP_RSS_IPV4_TCP	|\
-	VIRTCHNL2_CAP_RSS_IPV4_UDP	|\
-	VIRTCHNL2_CAP_RSS_IPV4_SCTP	|\
-	VIRTCHNL2_CAP_RSS_IPV4_OTHER	|\
-	VIRTCHNL2_CAP_RSS_IPV6_TCP	|\
-	VIRTCHNL2_CAP_RSS_IPV6_TCP	|\
-	VIRTCHNL2_CAP_RSS_IPV6_UDP	|\
-	VIRTCHNL2_CAP_RSS_IPV6_SCTP	|\
-	VIRTCHNL2_CAP_RSS_IPV6_OTHER)
+	VIRTCHNL2_FLOW_IPV4_TCP		|\
+	VIRTCHNL2_FLOW_IPV4_TCP		|\
+	VIRTCHNL2_FLOW_IPV4_UDP		|\
+	VIRTCHNL2_FLOW_IPV4_SCTP	|\
+	VIRTCHNL2_FLOW_IPV4_OTHER	|\
+	VIRTCHNL2_FLOW_IPV6_TCP		|\
+	VIRTCHNL2_FLOW_IPV6_TCP		|\
+	VIRTCHNL2_FLOW_IPV6_UDP		|\
+	VIRTCHNL2_FLOW_IPV6_SCTP	|\
+	VIRTCHNL2_FLOW_IPV6_OTHER)
 
 #define IDPF_CAP_RSC (\
 	VIRTCHNL2_CAP_RSC_IPV4_TCP	|\
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3d2413b8684f..895f98304efc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -878,14 +878,14 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 			    VIRTCHNL2_CAP_SEG_TX_SINGLE_TUNNEL);
 
 	caps.rss_caps =
-		cpu_to_le64(VIRTCHNL2_CAP_RSS_IPV4_TCP		|
-			    VIRTCHNL2_CAP_RSS_IPV4_UDP		|
-			    VIRTCHNL2_CAP_RSS_IPV4_SCTP		|
-			    VIRTCHNL2_CAP_RSS_IPV4_OTHER	|
-			    VIRTCHNL2_CAP_RSS_IPV6_TCP		|
-			    VIRTCHNL2_CAP_RSS_IPV6_UDP		|
-			    VIRTCHNL2_CAP_RSS_IPV6_SCTP		|
-			    VIRTCHNL2_CAP_RSS_IPV6_OTHER);
+		cpu_to_le64(VIRTCHNL2_FLOW_IPV4_TCP		|
+			    VIRTCHNL2_FLOW_IPV4_UDP		|
+			    VIRTCHNL2_FLOW_IPV4_SCTP		|
+			    VIRTCHNL2_FLOW_IPV4_OTHER		|
+			    VIRTCHNL2_FLOW_IPV6_TCP		|
+			    VIRTCHNL2_FLOW_IPV6_UDP		|
+			    VIRTCHNL2_FLOW_IPV6_SCTP		|
+			    VIRTCHNL2_FLOW_IPV6_OTHER);
 
 	caps.hsplit_caps =
 		cpu_to_le32(VIRTCHNL2_CAP_RX_HSPLIT_AT_L4V4	|
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 63deb120359c..2e692fff0e3a 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -141,22 +141,22 @@ enum virtchnl2_cap_seg {
 	VIRTCHNL2_CAP_SEG_TX_DOUBLE_TUNNEL	= BIT(8),
 };
 
-/* Receive Side Scaling Flow type capability flags */
-enum virtchnl2_cap_rss {
-	VIRTCHNL2_CAP_RSS_IPV4_TCP		= BIT(0),
-	VIRTCHNL2_CAP_RSS_IPV4_UDP		= BIT(1),
-	VIRTCHNL2_CAP_RSS_IPV4_SCTP		= BIT(2),
-	VIRTCHNL2_CAP_RSS_IPV4_OTHER		= BIT(3),
-	VIRTCHNL2_CAP_RSS_IPV6_TCP		= BIT(4),
-	VIRTCHNL2_CAP_RSS_IPV6_UDP		= BIT(5),
-	VIRTCHNL2_CAP_RSS_IPV6_SCTP		= BIT(6),
-	VIRTCHNL2_CAP_RSS_IPV6_OTHER		= BIT(7),
-	VIRTCHNL2_CAP_RSS_IPV4_AH		= BIT(8),
-	VIRTCHNL2_CAP_RSS_IPV4_ESP		= BIT(9),
-	VIRTCHNL2_CAP_RSS_IPV4_AH_ESP		= BIT(10),
-	VIRTCHNL2_CAP_RSS_IPV6_AH		= BIT(11),
-	VIRTCHNL2_CAP_RSS_IPV6_ESP		= BIT(12),
-	VIRTCHNL2_CAP_RSS_IPV6_AH_ESP		= BIT(13),
+/* Receive Side Scaling and Flow Steering Flow type capability flags */
+enum virtchnl2_flow_types {
+	VIRTCHNL2_FLOW_IPV4_TCP		= BIT(0),
+	VIRTCHNL2_FLOW_IPV4_UDP		= BIT(1),
+	VIRTCHNL2_FLOW_IPV4_SCTP	= BIT(2),
+	VIRTCHNL2_FLOW_IPV4_OTHER	= BIT(3),
+	VIRTCHNL2_FLOW_IPV6_TCP		= BIT(4),
+	VIRTCHNL2_FLOW_IPV6_UDP		= BIT(5),
+	VIRTCHNL2_FLOW_IPV6_SCTP	= BIT(6),
+	VIRTCHNL2_FLOW_IPV6_OTHER	= BIT(7),
+	VIRTCHNL2_FLOW_IPV4_AH		= BIT(8),
+	VIRTCHNL2_FLOW_IPV4_ESP		= BIT(9),
+	VIRTCHNL2_FLOW_IPV4_AH_ESP	= BIT(10),
+	VIRTCHNL2_FLOW_IPV6_AH		= BIT(11),
+	VIRTCHNL2_FLOW_IPV6_ESP		= BIT(12),
+	VIRTCHNL2_FLOW_IPV6_AH_ESP	= BIT(13),
 };
 
 /* Header split capability flags */
@@ -448,7 +448,7 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_version_info);
  * @seg_caps: See enum virtchnl2_cap_seg.
  * @hsplit_caps: See enum virtchnl2_cap_rx_hsplit_at.
  * @rsc_caps: See enum virtchnl2_cap_rsc.
- * @rss_caps: See enum virtchnl2_cap_rss.
+ * @rss_caps: See enum virtchnl2_flow_types.
  * @other_caps: See enum virtchnl2_cap_other.
  * @mailbox_dyn_ctl: DYN_CTL register offset and vector id for mailbox
  *		     provided by CP.
-- 
2.43.0


