Return-Path: <netdev+bounces-160858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8E6A1BDE4
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9872A7A359C
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 21:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4A1E990D;
	Fri, 24 Jan 2025 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSMTvdt4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA0F1E7C38
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737754344; cv=none; b=WpTaXAWEKG2qukokvdPRYg1+ilkHGlr5ulCJFLoiSRuTq2jT2Quvv1mC+uO+GZGWddG6OQlBlBpy6nOXdrjGaxflmNzfGayl+2pXfnbChhXqqr4PdneBGgr0cvZJdjXCWHnGmfGWH0plJEvADBrHMcHSTf2TKboCsLFu2/HBxUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737754344; c=relaxed/simple;
	bh=RLST+wEvPIdxiVmJ7UkI5OXguXZfGshIONW1OgmGTV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi/t8+uxDKoBT2HTBLTHvgGKmrWksbTPE6QhViC6XDwDcIZp5dW3Tn8rsXgRJ+K2//xrQniZNePRR2+KW3HFta3HituOXjiAHqSUY1azE3vEovKCtf/KU/kHQyMMy7OGNstQvBj3bnjnB+fAxSzW3D9MwA1V9ddjFODzbbErWwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSMTvdt4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737754343; x=1769290343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RLST+wEvPIdxiVmJ7UkI5OXguXZfGshIONW1OgmGTV0=;
  b=JSMTvdt4ExW/WNVSgHSZoxjqAjQv5Wte19bGqGH22Zo16RrQTTFTI43r
   l1dk9uUDJXdD03VDfqYxMfoBwqCoBMPm22zziViDb6jSBPClNAjBcL7SG
   xpNr8EZ0sVxSBmzICK63iE3zUXgfqaqKcc9IVEfdeSS0PZ1+I+MZy7D8a
   BWkW2TT/WSvNuQBlw0Z6CRBpVbK/ORANKo+JW8/wT6jfyxwj8OmYLv1AG
   14IhxUmfiYiFh6U1SJzHOx1pBlJoPiGKMW6oem/oJ8G/eUykA9M+ymqNm
   VMgjpaf9tghEngN/HZ96yTyD8g6xDLjZHGf0iCR1KHtHDJ2OFJy37tcvV
   w==;
X-CSE-ConnectionGUID: dhP+uLxRSn6MscNBLgnIEQ==
X-CSE-MsgGUID: Ab/M8cEbQ0ekHu/iXcKnQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41140418"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="41140418"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 13:32:18 -0800
X-CSE-ConnectionGUID: +8+X94HLQ8GZIyYdPaITew==
X-CSE-MsgGUID: ICfJQTjlQaeBrsbIoe4WaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="107861093"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 24 Jan 2025 13:32:17 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	dan.carpenter@linaro.org,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 6/8] ice: fix ice_parser_rt::bst_key array size
Date: Fri, 24 Jan 2025 13:32:08 -0800
Message-ID: <20250124213213.1328775-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
References: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Fix &ice_parser_rt::bst_key size. It was wrongly set to 10 instead of 20
in the initial impl commit (see Fixes tag). All usage code assumed it was
of size 20. That was also the initial size present up to v2 of the intro
series [2], but halved by v3 [3] refactor described as "Replace magic
hardcoded values with macros." The introducing series was so big that
some ugliness was unnoticed, same for bugs :/

ICE_BST_KEY_TCAM_SIZE and ICE_BST_TCAM_KEY_SIZE were differing by one.
There was tmp variable @j in the scope of edited function, but was not
used in all places. This ugliness is now gone.
I'm moving ice_parser_rt::pg_prio a few positions up, to fill up one of
the holes in order to compensate for the added 10 bytes to the ::bst_key,
resulting in the same size of the whole as prior to the fix, and minimal
changes in the offsets of the fields.

Extend also the debug dump print of the key to cover all bytes. To not
have string with 20 "%02x" and 20 params, switch to
ice_debug_array_w_prefix().

This fix obsoletes Ahmed's attempt at [1].

[1] https://lore.kernel.org/intel-wired-lan/20240823230847.172295-1-ahmed.zaki@intel.com
[2] https://lore.kernel.org/intel-wired-lan/20230605054641.2865142-13-junfeng.guo@intel.com
[3] https://lore.kernel.org/intel-wired-lan/20230817093442.2576997-13-junfeng.guo@intel.com

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/intel-wired-lan/b1fb6ff9-b69e-4026-9988-3c783d86c2e0@stanley.mountain
Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
CC: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_parser.h    |  6 ++----
 drivers/net/ethernet/intel/ice/ice_parser_rt.c | 12 +++++-------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
index 6509d807627c..4f56d53d56b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.h
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -257,7 +257,6 @@ ice_pg_nm_cam_match(struct ice_pg_nm_cam_item *table, int size,
 /*** ICE_SID_RXPARSER_BOOST_TCAM and ICE_SID_LBL_RXPARSER_TMEM sections ***/
 #define ICE_BST_TCAM_TABLE_SIZE		256
 #define ICE_BST_TCAM_KEY_SIZE		20
-#define ICE_BST_KEY_TCAM_SIZE		19
 
 /* Boost TCAM item */
 struct ice_bst_tcam_item {
@@ -401,7 +400,6 @@ u16 ice_xlt_kb_flag_get(struct ice_xlt_kb *kb, u64 pkt_flag);
 #define ICE_PARSER_GPR_NUM	128
 #define ICE_PARSER_FLG_NUM	64
 #define ICE_PARSER_ERR_NUM	16
-#define ICE_BST_KEY_SIZE	10
 #define ICE_MARKER_ID_SIZE	9
 #define ICE_MARKER_MAX_SIZE	\
 		(ICE_MARKER_ID_SIZE * BITS_PER_BYTE - 1)
@@ -431,13 +429,13 @@ struct ice_parser_rt {
 	u8 pkt_buf[ICE_PARSER_MAX_PKT_LEN + ICE_PARSER_PKT_REV];
 	u16 pkt_len;
 	u16 po;
-	u8 bst_key[ICE_BST_KEY_SIZE];
+	u8 bst_key[ICE_BST_TCAM_KEY_SIZE];
 	struct ice_pg_cam_key pg_key;
+	u8 pg_prio;
 	struct ice_alu *alu0;
 	struct ice_alu *alu1;
 	struct ice_alu *alu2;
 	struct ice_pg_cam_action *action;
-	u8 pg_prio;
 	struct ice_gpr_pu pu;
 	u8 markers[ICE_MARKER_ID_SIZE];
 	bool protocols[ICE_PO_PAIR_SIZE];
diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
index dedf5e854e4b..3995d662e050 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
@@ -125,22 +125,20 @@ static void ice_bst_key_init(struct ice_parser_rt *rt,
 	else
 		key[idd] = imem->b_kb.prio;
 
-	idd = ICE_BST_KEY_TCAM_SIZE - 1;
+	idd = ICE_BST_TCAM_KEY_SIZE - 2;
 	for (i = idd; i >= 0; i--) {
 		int j;
 
 		j = ho + idd - i;
 		if (j < ICE_PARSER_MAX_PKT_LEN)
-			key[i] = rt->pkt_buf[ho + idd - i];
+			key[i] = rt->pkt_buf[j];
 		else
 			key[i] = 0;
 	}
 
-	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "Generated Boost TCAM Key:\n");
-	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "%02X %02X %02X %02X %02X %02X %02X %02X %02X %02X\n",
-		  key[0], key[1], key[2], key[3], key[4],
-		  key[5], key[6], key[7], key[8], key[9]);
-	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "\n");
+	ice_debug_array_w_prefix(rt->psr->hw, ICE_DBG_PARSER,
+				 KBUILD_MODNAME ": Generated Boost TCAM Key",
+				 key, ICE_BST_TCAM_KEY_SIZE);
 }
 
 static u16 ice_bit_rev_u16(u16 v, int len)
-- 
2.47.1


