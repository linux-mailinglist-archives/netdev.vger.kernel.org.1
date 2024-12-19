Return-Path: <netdev+bounces-153329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632199F7AD7
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C408188406D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA92222D50;
	Thu, 19 Dec 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M75VgKu3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FE1FCFCB
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609553; cv=none; b=cjzntv6jc1x7JIHyZ4WGs3SsZRh/+hx5U82liQG2gGN6vLhuOjW+Ye0vBxcmGw4KvtTJKI7gJbsQ+f03tp83PIoQhjO1q9/OsjkmAyUqj+uAMDgCxTYpZK7ZjnONOEkLnsfUYEeV1jiV1+vZHTYJkVNSid+/TBe3lIv1F++RMdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609553; c=relaxed/simple;
	bh=+bdHV52BGeozxqr7FfB0hzqeypAkNCGVG+/cZlO10cM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CyRBMYLq8dvP+Q0ciUXl7EO+D4d2v495l3YN1cDYw40cXWoyypn/vMwhrotNSVwUh+YlTXglS6rwdX+Y0vOXSkazdFpDDm/F8lCefsOnDlZCqs4HAukJJmTCTJZO/r9Lh678WN0yeT5ETEY1Cisj/3dJYxFkS0IUKj09+T4SBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M75VgKu3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734609551; x=1766145551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+bdHV52BGeozxqr7FfB0hzqeypAkNCGVG+/cZlO10cM=;
  b=M75VgKu3gccAiMv3VkcYhx2RwoUGQ3E4k72l2GCDSuDKR4ovxBCJfw6P
   wLhn1HifgoS316FocHfWcI7pZE2mCigWFpr6Om5Ast9ZdGeSW1SNnf0z5
   IVJVPTnf/eoHetLNonlaAHud5SRDVKOkiHcr8yrw7WlVTXzWgzcLnrmU6
   IhBp4adNeQQ/727jpP2TBJCjGA8ccQ1fo1VS6m3XQR/p1TsOytBBqJEep
   7kcZ11SVg5g37+awL8rO9UVOzOcn0B0PvWhka0dAr3dK2srZYtFQTm3HL
   /0pwf8Kd/NcKlZN/zB7rWUYn4qjFNy7HdLnGvIkSy5PHFkEi2/IvwtGbh
   A==;
X-CSE-ConnectionGUID: lL3phScATFCvDSZNDSvpyA==
X-CSE-MsgGUID: wDfqxJOvTceLmvI4CYZJ1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="37957678"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="37957678"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 03:59:10 -0800
X-CSE-ConnectionGUID: W5nWXNKZQr+VZNW5opciRQ==
X-CSE-MsgGUID: PBhipDHvTtaLg0dTGXUPbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="98000111"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa007.fm.intel.com with ESMTP; 19 Dec 2024 03:59:08 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DC46F28778;
	Thu, 19 Dec 2024 11:59:06 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH iwl-net v3] ice: fix ice_parser_rt::bst_key array size
Date: Thu, 19 Dec 2024 12:55:16 +0100
Message-Id: <20241219115516.11708-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
resulting in the same size of the whole as prior to the fix, and miminal
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
---
v3: mention printing change in commit msg, separate prefix from the debug log (Simon)

v2: same as v3, but lacks code change :(

v1: https://lore.kernel.org/intel-wired-lan/20241216170548.GI780307@kernel.org/T/#mbf984a0faa12a5bdb53460b150201fdd7cc1826a
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
2.39.3


