Return-Path: <netdev+bounces-173609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C1BA59FFC
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764AC1718E8
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7905233D72;
	Mon, 10 Mar 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4ktZ1f3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D4D233727
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628710; cv=none; b=J3Ud6sauc/1sNoWywlRubZ0eStjvCadaiyA+qXpIabV6TSAxBiPq+puS6kkdagBKmqiIt1lHX0eGdI4EbyPdAGOypbEkWS/ll4GDoXF6BjJ7Ag1tspul2Zk7I9J4vCdqgOcIZwgjrMjKkuBormTqkFDa3hKbHTHy/1scHuM9RXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628710; c=relaxed/simple;
	bh=2C557/yO6NfgkutDE0xeB92RtZ3bgqIGdR7aOwxVfYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzDfFm6BI67GNm6aB/ocuQadBI3w3TASoBy1sbm/DFtFsW9yVFyPCGn78+uZmM0kMrub39mxJyFvnbYQA2IAOMQoCXrx4+Ky1Nnvvr8EJV8SgbxGAiofhI19Q87+KJvB9t7t2FXNtBc5vlRsfmxN2qwAsRbBuDX46waf9vfMUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4ktZ1f3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741628709; x=1773164709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2C557/yO6NfgkutDE0xeB92RtZ3bgqIGdR7aOwxVfYo=;
  b=l4ktZ1f3zq07Togm5WZhTYoza4TXf3txJM9deVoM1Fa1pBw13BstTP6j
   Gtw5zJUR+OFMOilJFgihnsf3VhSpQcV4aDo62s03b/W49GdcRuSaV1th3
   QwjKk+UsjDEDa+RhCB4ekVwBWyMEoky9DJkSoIUf/H7g8TuNpq4c/r3Kt
   dAgJgU+PfoB25Ce82llHYJ8e6x2SH9hHnj2w0j9Ok67zfdDmrZGfU1HLQ
   Br2wpo80YOFhPtwK+KfdmUsHCOzWVaHglRc/3CKcY8DV0p62614TqaBRm
   bd7lIHD6RwX7V1z7Ox6ZW5PTVc+IpK+EuY4NbZFYZvT4G/a9huq+7ygxP
   A==;
X-CSE-ConnectionGUID: 538EuQkeRliyAOm5S025cw==
X-CSE-MsgGUID: zznjcbjgR2ao2S00gQPxxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46548992"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="46548992"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:45:06 -0700
X-CSE-ConnectionGUID: 8nJLRGpaQ7Cg7jBuSxR9NQ==
X-CSE-MsgGUID: 8OhJ1gvxSzmxagoacZb0ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120950791"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2025 10:45:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 3/6] ice: Refactor E825C PHY registers info struct
Date: Mon, 10 Mar 2025 10:44:56 -0700
Message-ID: <20250310174502.3708121-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310174502.3708121-1-anthony.l.nguyen@intel.com>
References: <20250310174502.3708121-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Simplify ice_phy_reg_info_eth56g struct definition to include base
address for the very first quad. Use base address info and 'step'
value to determine address for specific PHY quad.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_ptp_consts.h   | 75 ++++---------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  6 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  4 +-
 3 files changed, 20 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index ac46d1183300..003cdfada3ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -10,70 +10,25 @@
 /* Constants defined for the PTP 1588 clock hardware. */
 
 const struct ice_phy_reg_info_eth56g eth56g_phy_res[NUM_ETH56G_PHY_RES] = {
-	/* ETH56G_PHY_REG_PTP */
-	{
-		/* base_addr */
-		{
-			0x092000,
-			0x126000,
-			0x1BA000,
-			0x24E000,
-			0x2E2000,
-		},
-		/* step */
-		0x98,
+	[ETH56G_PHY_REG_PTP] = {
+		.base_addr = 0x092000,
+		.step = 0x98,
 	},
-	/* ETH56G_PHY_MEM_PTP */
-	{
-		/* base_addr */
-		{
-			0x093000,
-			0x127000,
-			0x1BB000,
-			0x24F000,
-			0x2E3000,
-		},
-		/* step */
-		0x200,
+	[ETH56G_PHY_MEM_PTP] = {
+		.base_addr = 0x093000,
+		.step = 0x200,
 	},
-	/* ETH56G_PHY_REG_XPCS */
-	{
-		/* base_addr */
-		{
-			0x000000,
-			0x009400,
-			0x128000,
-			0x1BC000,
-			0x250000,
-		},
-		/* step */
-		0x21000,
+	[ETH56G_PHY_REG_XPCS] = {
+		.base_addr = 0x000000,
+		.step = 0x21000,
 	},
-	/* ETH56G_PHY_REG_MAC */
-	{
-		/* base_addr */
-		{
-			0x085000,
-			0x119000,
-			0x1AD000,
-			0x241000,
-			0x2D5000,
-		},
-		/* step */
-		0x1000,
+	[ETH56G_PHY_REG_MAC] = {
+		.base_addr = 0x085000,
+		.step = 0x1000,
 	},
-	/* ETH56G_PHY_REG_GPCS */
-	{
-		/* base_addr */
-		{
-			0x084000,
-			0x118000,
-			0x1AC000,
-			0x240000,
-			0x2D4000,
-		},
-		/* step */
-		0x400,
+	[ETH56G_PHY_REG_GPCS] = {
+		.base_addr = 0x084000,
+		.step = 0x400,
 	},
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index fbaf2819e40e..89bb8461284a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1010,7 +1010,7 @@ static int ice_phy_res_address_eth56g(struct ice_hw *hw, u8 lane,
 
 	/* Lanes 4..7 are in fact 0..3 on a second PHY */
 	lane %= hw->ptp.ports_per_phy;
-	*addr = eth56g_phy_res[res_type].base[0] +
+	*addr = eth56g_phy_res[res_type].base_addr +
 		lane * eth56g_phy_res[res_type].step + offset;
 
 	return 0;
@@ -1240,7 +1240,7 @@ static int ice_write_quad_ptp_reg_eth56g(struct ice_hw *hw, u8 port,
 	if (port >= hw->ptp.num_lports)
 		return -EIO;
 
-	addr = eth56g_phy_res[ETH56G_PHY_REG_PTP].base[0] + offset;
+	addr = eth56g_phy_res[ETH56G_PHY_REG_PTP].base_addr + offset;
 
 	return ice_write_phy_eth56g(hw, port, addr, val);
 }
@@ -1265,7 +1265,7 @@ static int ice_read_quad_ptp_reg_eth56g(struct ice_hw *hw, u8 port,
 	if (port >= hw->ptp.num_lports)
 		return -EIO;
 
-	addr = eth56g_phy_res[ETH56G_PHY_REG_PTP].base[0] + offset;
+	addr = eth56g_phy_res[ETH56G_PHY_REG_PTP].base_addr + offset;
 
 	return ice_read_phy_eth56g(hw, port, addr, val);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 8442d1d60351..cca81391b6ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -65,14 +65,14 @@ enum ice_eth56g_link_spd {
 
 /**
  * struct ice_phy_reg_info_eth56g - ETH56G PHY register parameters
- * @base: base address for each PHY block
+ * @base_addr: base address for each PHY block
  * @step: step between PHY lanes
  *
  * Characteristic information for the various PHY register parameters in the
  * ETH56G devices
  */
 struct ice_phy_reg_info_eth56g {
-	u32 base[NUM_ETH56G_PHY_RES];
+	u32 base_addr;
 	u32 step;
 };
 
-- 
2.47.1


