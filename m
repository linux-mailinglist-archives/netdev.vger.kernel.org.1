Return-Path: <netdev+bounces-32900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939AA79AABF
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB631C2094E
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014AB15AF2;
	Mon, 11 Sep 2023 18:11:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E071415AEE
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:11:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C059A103
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694455865; x=1725991865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zR4bj2mkzb2WNs+YaV3VL4m26wBKrKY9HabfD6GVpQ8=;
  b=VPNEIVqscSy5vgRIvyOeCQ2YrJSBx4+OAd3x01XWXlZiSz9kXnZJjj5J
   P32OMQiiyvq1z1HgEFUKi+j+77ljBVKn5RlQUVKV8eAuEeOGv9RBkpu4W
   D7Hc2qGUzWZaTAM9P7kFDzhknUndUi9FhEHGNoI1pfEeN2ft6K3KWM4JN
   QsmKWpdHJaiIDfacrY5dZOaqioThBmMZ3VqvLfg2PnULZ71ariEDrIMwk
   AHlHnION8TyXIL0pvogiGm3pRsTWwfmxW/JQo2kYduv35Y9YHesWHn3fV
   mtD6IRHZsjkTI3zTtV61OuBOliCWFNoro+EoXvlTsurKkUXhA+4QJRLWl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378075647"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378075647"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917129942"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917129942"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2023 11:11:01 -0700
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
Subject: [PATCH net-next 07/13] ice: PTP: move quad value check inside ice_fill_phy_msg_e822
Date: Mon, 11 Sep 2023 11:03:08 -0700
Message-Id: <20230911180314.4082659-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
References: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
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
index 489dfbbe7290..22650bcc3b06 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -495,11 +495,14 @@ ice_write_64b_phy_reg_e822(struct ice_hw *hw, u8 port, u16 low_addr, u64 val)
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
@@ -509,6 +512,8 @@ ice_fill_quad_msg_e822(struct ice_sbq_msg_input *msg, u8 quad, u16 offset)
 
 	msg->msg_addr_low = lower_16_bits(addr);
 	msg->msg_addr_high = upper_16_bits(addr);
+
+	return 0;
 }
 
 /**
@@ -527,10 +532,10 @@ ice_read_quad_reg_e822(struct ice_hw *hw, u8 quad, u16 offset, u32 *val)
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
@@ -561,10 +566,10 @@ ice_write_quad_reg_e822(struct ice_hw *hw, u8 quad, u16 offset, u32 val)
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


