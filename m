Return-Path: <netdev+bounces-28617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8416677FFEE
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1E3282210
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC3A1C9EC;
	Thu, 17 Aug 2023 21:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872B1C9E3
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:29:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402DD10C7
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692307779; x=1723843779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WgBTWYmlyY1f4Hm79yLAsGqBmQxxsnRZRJNqYO/lC0o=;
  b=EGAREDFn47W9iwTu+NOsJKr+o1IekSC7FknzevarJAn/qJ5/vbDV4pQs
   4dXRvAeOr+XuGSjIAk3KaxWgDDCrwO+pOJZs7I5w7a9ONXuxInJYhZug6
   srF4vTnuTegSjDQg6QG2CoEJSXdI3mv0MmC6cWTiHpc+/nhR/lvYpa/Sa
   Aub3HM4yIbRjvmV5JVTeh8ScueYRDkkT7ac92lKQyVQ8c0U707tJmTZmi
   SfdKc4RZ+8lowLjFnJMerSTCkstpUwpxSDaMNbEMHN54xZFg7Pk/cRjuP
   HLuSyu+imDcOPyOlDyL+G2ZTkYBGi4YIFkcOuzIN226oWZ6PBgYNB6Q4P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363095076"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="363095076"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:29:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824813718"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="824813718"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 14:29:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jan Sokolowski <jan.sokolowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v2 07/15] ice: refactor ice_ptp_hw to make functions static
Date: Thu, 17 Aug 2023 14:22:31 -0700
Message-Id: <20230817212239.2601543-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
References: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jan Sokolowski <jan.sokolowski@intel.com>

As following methods are not used outside ice_ptp_hw,
they can be made static:
ice_read_phy_reg_e822
ice_write_phy_reg_e822
ice_ptp_prep_port_adj_e822

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 6 +++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index a0da1bb55ba1..68e2d5ca01f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -293,7 +293,7 @@ static bool ice_is_40b_phy_reg_e822(u16 low_addr, u16 *high_addr)
  *
  * Read a PHY register for the given port over the device sideband queue.
  */
-int
+static int
 ice_read_phy_reg_e822(struct ice_hw *hw, u8 port, u16 offset, u32 *val)
 {
 	struct ice_sbq_msg_input msg = {0};
@@ -370,7 +370,7 @@ ice_read_64b_phy_reg_e822(struct ice_hw *hw, u8 port, u16 low_addr, u64 *val)
  *
  * Write a PHY register for the given port over the device sideband queue.
  */
-int
+static int
 ice_write_phy_reg_e822(struct ice_hw *hw, u8 port, u16 offset, u32 val)
 {
 	struct ice_sbq_msg_input msg = {0};
@@ -1079,7 +1079,7 @@ ice_ptp_prep_phy_time_e822(struct ice_hw *hw, u32 time)
  *
  * Negative adjustments are supported using 2s complement arithmetic.
  */
-int
+static int
 ice_ptp_prep_port_adj_e822(struct ice_hw *hw, u8 port, s64 time)
 {
 	u32 l_time, u_time;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 07cd023b0efd..13547707b8e3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -141,11 +141,8 @@ int ice_ptp_init_phc(struct ice_hw *hw);
 int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready);
 
 /* E822 family functions */
-int ice_read_phy_reg_e822(struct ice_hw *hw, u8 port, u16 offset, u32 *val);
-int ice_write_phy_reg_e822(struct ice_hw *hw, u8 port, u16 offset, u32 val);
 int ice_read_quad_reg_e822(struct ice_hw *hw, u8 quad, u16 offset, u32 *val);
 int ice_write_quad_reg_e822(struct ice_hw *hw, u8 quad, u16 offset, u32 val);
-int ice_ptp_prep_port_adj_e822(struct ice_hw *hw, u8 port, s64 time);
 void ice_ptp_reset_ts_memory_quad_e822(struct ice_hw *hw, u8 quad);
 
 /**
-- 
2.38.1


