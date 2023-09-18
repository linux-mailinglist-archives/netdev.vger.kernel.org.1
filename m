Return-Path: <netdev+bounces-34824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0667A5518
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370FE2820CC
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588B22AB29;
	Mon, 18 Sep 2023 21:28:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB92828E06
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 21:28:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91982115
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 14:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695072527; x=1726608527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LX791F6QRijic6j/sTB0pQHCBJA9MVn9mFL0/olSSBU=;
  b=NODEfYte/svt7KDGiFOdg/wySjv3LoFiJ+ulSFCeV/4LVdp1SlYGgVYD
   Q83OGfut0j3GUV4afoqwfxsdKRkHwv2TuukzeTfXguEUq/8tvBcglqlyc
   Wa7ZY3YY3EC8oztS0GzQ4P3c2smmuXSMOYYaXMZA92CxQdrNkW485gwub
   KZBoUqKLZBYQrywxpaXT4noxIY/Qhm0LHDkVMe9h+giUQfMEdful4vGDB
   dbRfba+s9y396uZ3dyOa22gOiSV3l+yfd0+kPAmFKk7hNHbYu4SC1Pvoa
   KV1aiqGnlt4GCMybuFh4GkhNQRUBw0+ZrobnGpm/y8OxvUKncde/56DJA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359187267"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="359187267"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 14:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="749186221"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="749186221"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 18 Sep 2023 14:28:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next v2 07/11] ice: PTP: move quad value check inside ice_fill_phy_msg_e822
Date: Mon, 18 Sep 2023 14:28:10 -0700
Message-Id: <20230918212814.435688-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
References: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Karol Kolacinski <karol.kolacinski@intel.com>

The callers of ice_fill_phy_msg_e822 check for whether the quad number is
within the expected range. Move this check inside the ice_fill_phy_msg_e822
function instead of duplicating it twice.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 7c18dbac49d0..f839f186797d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -621,11 +621,14 @@ ice_write_64b_phy_reg_e822(struct ice_hw *hw, u8 port, u16 low_addr, u64 val)
  * Fill a message buffer for accessing a register in a quad shared between
  * multiple PHYs.
  */
-static void
+static int
 ice_fill_quad_msg_e822(struct ice_sbq_msg_input *msg, u8 quad, u16 offset)
 {
 	u32 addr;
 
+	if (quad >= ICE_MAX_QUAD)
+		return -EINVAL;
+
 	msg->dest_dev = rmn_0;
 
 	if ((quad % ICE_QUADS_PER_PHY_E822) == 0)
@@ -635,6 +638,8 @@ ice_fill_quad_msg_e822(struct ice_sbq_msg_input *msg, u8 quad, u16 offset)
 
 	msg->msg_addr_low = lower_16_bits(addr);
 	msg->msg_addr_high = upper_16_bits(addr);
+
+	return 0;
 }
 
 /**
@@ -653,10 +658,10 @@ ice_read_quad_reg_e822(struct ice_hw *hw, u8 quad, u16 offset, u32 *val)
 	struct ice_sbq_msg_input msg = {0};
 	int err;
 
-	if (quad >= ICE_MAX_QUAD)
-		return -EINVAL;
+	err = ice_fill_quad_msg_e822(&msg, quad, offset);
+	if (err)
+		return err;
 
-	ice_fill_quad_msg_e822(&msg, quad, offset);
 	msg.opcode = ice_sbq_msg_rd;
 
 	err = ice_sbq_rw_reg(hw, &msg);
@@ -687,10 +692,10 @@ ice_write_quad_reg_e822(struct ice_hw *hw, u8 quad, u16 offset, u32 val)
 	struct ice_sbq_msg_input msg = {0};
 	int err;
 
-	if (quad >= ICE_MAX_QUAD)
-		return -EINVAL;
+	err = ice_fill_quad_msg_e822(&msg, quad, offset);
+	if (err)
+		return err;
 
-	ice_fill_quad_msg_e822(&msg, quad, offset);
 	msg.opcode = ice_sbq_msg_wr;
 	msg.data = val;
 
-- 
2.38.1


