Return-Path: <netdev+bounces-145241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12E09CDE39
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A9BB21568
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A02D1B6D18;
	Fri, 15 Nov 2024 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+WZAjzr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531C1B85F6
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731673590; cv=none; b=cQ/uGSSL62+BAdE/LlY8ISxLvKlSw2tRl/XxS65LhDhczfI0Cdok5fAOe+7wiw/04MzV7iTxzUnC9w+3FD3EtRT0CWD3pw8MGLUE35pDiaMft68r/0jW1J/d+eH1oA65+BHAXs4wPhTYnrSpNEDI8HftRdxD9KPWCgJC+foUvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731673590; c=relaxed/simple;
	bh=yTSI2j1PiELG/RhwT3m9w4NRuiU6Qe0f3dTyG5sC/7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JFxGJSWvDKfgtbrP16ah48my1HX6mtJp+AhfcnRIDBlETA2Nl0MnYHwKT0nlFBKZwx+AYC9XacosIFXTzdHXYha+0jVeKKNJkZgz9F1nAiOyZ89LLRSv/tnoBf8ZkLbByXn+s1AsPjOrXdsB0Hx3Rzcwwg5+27+cwln/7D08EvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+WZAjzr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731673589; x=1763209589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yTSI2j1PiELG/RhwT3m9w4NRuiU6Qe0f3dTyG5sC/7E=;
  b=L+WZAjzr32YbA1Qz71NhHKVh0xLPdyNokuFBHgNbmBoIRs8MQDHJ1Sjw
   prleRR0yQS0TOJKl8VpViqjGdivL775kvismlWAGa/kLY7hZBmjbf98hR
   PgyrzmVuG2oKVnzlezqQLk1dGY9YQX/xO9GnHwb0KNhe9j+EMd2oHUAcU
   Ydk/ByV8+M9c6UcbZSbzF2Mu7c6duRnTS9NypIjn0dqRtIIAzFVYvM303
   SSx/AR/u6I1A+tbMDdQ4w0HHHe6wd4n+hVKjvnwHPQipaMa9W7yeSUiCB
   bcdGRyEVF71+RhySty3udOCh2R86HeU2hushUu0qOYnJrT+eC6HnAluVF
   g==;
X-CSE-ConnectionGUID: Iho3Qbs9RkWvEY41mHB9Sw==
X-CSE-MsgGUID: czBVava5Q6iPIswmU/wXcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="43076929"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="43076929"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 04:26:28 -0800
X-CSE-ConnectionGUID: iIGnaJcMSlyc7ry0/P1nMQ==
X-CSE-MsgGUID: MgDbaiHxQKKxEGqi7G930g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="126089718"
Received: from pae-dbg-r750-02-263.igk.intel.com ([172.28.191.215])
  by orviesa001.jf.intel.com with ESMTP; 15 Nov 2024 04:26:26 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v2] ice: fix PHY timestamp extraction for ETH56G
Date: Fri, 15 Nov 2024 13:25:37 +0100
Message-Id: <20241115122536.117595-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect PHY timestamp extraction for ETH56G.
It's better to use FIELD_PREP() than manual shift.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
Changelog
v2:
remove legal footer
v1:
https://lore.kernel.org/intel-wired-lan/20241107113257.466286-1-przemyslaw.korba@intel.com
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 3 ++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 75c68b0325e7..3d45e4ed90b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1553,7 +1553,8 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
 	 * lower 8 bits in the low register, and the upper 32 bits in the high
 	 * register.
 	 */
-	*tstamp = ((u64)hi) << TS_PHY_HIGH_S | ((u64)lo & TS_PHY_LOW_M);
+	*tstamp = FIELD_PREP(TS_PHY_HIGH_M, hi) |
+		  FIELD_PREP(TS_PHY_LOW_M, lo);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 6cedc1a906af..4c8b84571344 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -663,9 +663,8 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
 #define TS_HIGH_M			0xFF
 #define TS_HIGH_S			32
 
-#define TS_PHY_LOW_M			0xFF
-#define TS_PHY_HIGH_M			0xFFFFFFFF
-#define TS_PHY_HIGH_S			8
+#define TS_PHY_LOW_M			GENMASK(7, 0)
+#define TS_PHY_HIGH_M			GENMASK_ULL(39, 8)
 
 #define BYTES_PER_IDX_ADDR_L_U		8
 #define BYTES_PER_IDX_ADDR_L		4

base-commit: 182ff3dabe8f127049c09660346cad492bcc0ceb
-- 
2.31.1


