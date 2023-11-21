Return-Path: <netdev+bounces-49795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F637F3804
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3901C20DA7
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 21:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DE654672;
	Tue, 21 Nov 2023 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RlTTjJG5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1451AC
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 13:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700601580; x=1732137580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bssGAbRo6EZ7uH9j8e/gpjKd/Bpnhc8jnprKFrUZrJs=;
  b=RlTTjJG5j6r2DEpXc5ig8YKOZMWqGm/AMoP2EEWlHZ5WT+Wj1euthDZN
   U2XtdplPTeNVyiuGN+7Wo8yLW/9BcYikZHr1vYDlASpTiRBrHeM+B12Pi
   blEGVGxO4j/wYvkMxMNzSJQp300ng6rSqOs6u+8hILIH0fdUktnGa3yM5
   Krq8CKcy5Ba2ITrI/dRIjMFrb/mKJlKmLtJX2r67+zoFUJz26fUgY/RwL
   d0VzO3XLI4GQy2MaQdNlU3TIcQHKWVvON6HBLEAbBws4CBYaVcdlfNccw
   JbiNNjB4QhErGAX/p5hUzSjAfrQzIUgDERwuzKTkAMtyXT5KeA8lYNKj3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="423022064"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="423022064"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:19:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="716630531"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="716630531"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:19:37 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v1 01/13] e1000e: make lost bits explicit
Date: Tue, 21 Nov 2023 13:19:09 -0800
Message-Id: <20231121211921.19834-2-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231121211921.19834-1-jesse.brandeburg@intel.com>
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For more than 15 years this code has passed in a request for a page and
masked off that page when read/writing. This code has been here forever,
but FIELD_PREP finds the bug when converted to use it. Change the code
to do exactly the same thing but allow the conversion to FIELD_PREP in a
later patch. To make it clear what we lost when making this change I
left a comment, but there is no point to change the code to generate a
correct sequence at this point.

This is not a Fixes tagged patch on purpose because it doesn't change
the binary output.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/e1000e/80003es2lan.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/80003es2lan.c b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
index be9c695dde12..74671201208e 100644
--- a/drivers/net/ethernet/intel/e1000e/80003es2lan.c
+++ b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
@@ -1035,17 +1035,18 @@ static s32 e1000_setup_copper_link_80003es2lan(struct e1000_hw *hw)
 	 * iteration and increase the max iterations when
 	 * polling the phy; this fixes erroneous timeouts at 10Mbps.
 	 */
-	ret_val = e1000_write_kmrn_reg_80003es2lan(hw, GG82563_REG(0x34, 4),
-						   0xFFFF);
+	/* these next three accesses were always meant to use page 0x34 using
+	 * GG82563_REG(0x34, N) but never did, so we've just corrected the call
+	 * to not drop bits
+	 */
+	ret_val = e1000_write_kmrn_reg_80003es2lan(hw, 4, 0xFFFF);
 	if (ret_val)
 		return ret_val;
-	ret_val = e1000_read_kmrn_reg_80003es2lan(hw, GG82563_REG(0x34, 9),
-						  &reg_data);
+	ret_val = e1000_read_kmrn_reg_80003es2lan(hw, 9, &reg_data);
 	if (ret_val)
 		return ret_val;
 	reg_data |= 0x3F;
-	ret_val = e1000_write_kmrn_reg_80003es2lan(hw, GG82563_REG(0x34, 9),
-						   reg_data);
+	ret_val = e1000_write_kmrn_reg_80003es2lan(hw, 9, reg_data);
 	if (ret_val)
 		return ret_val;
 	ret_val =
-- 
2.39.3


