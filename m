Return-Path: <netdev+bounces-233637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85776C16C1E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27233355CBF
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98F2C11CB;
	Tue, 28 Oct 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbxakLAk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8A429E0F8
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683126; cv=none; b=DW3tiHmJoM1aJEEz6w8T3vsA/VP7i+/42ZrbuT9K9zvs+txKaTfkb69AP4n9UgA/iX4pior4s9HG/pMPGAFvRiFeLvBOwi2yXqI5QUape0TQsxxxIUXWTxsuJRBLWICWzbUXiqgR8AnFf/LxDVCB2xpupGXxto23lk9gJYxff9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683126; c=relaxed/simple;
	bh=kXgIwPeEnZwQf/ag7q7910rKMp4/bOnVeQrPrPEt8g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJoCND1xLKboeM2NydN3U/0WY99+YnOa1PN+Fg3ltIn7ia/QdML84AR845evxXBThZVbGalA3r//atnhw6wW8b8JSzBOlPAM/t1eFJIrsABgMH98WT+q4DqIjQo8io9RlMMmiGD+cE0vDp4FwLfM53+X2FWmCljl5eurtWH6pwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbxakLAk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761683124; x=1793219124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kXgIwPeEnZwQf/ag7q7910rKMp4/bOnVeQrPrPEt8g4=;
  b=cbxakLAkFr5K2Em9fxAAytVFV55gq5T5fO93YhPOBv4ccOSBdyPdPujw
   zynqUuCjXw2XhsFs08PUAM7ooop7P3QKRcf6kQbGE5Zao8wTbpTU5Qh6c
   XcWBmbR2sKLLsWldnnDiXbyT5BVoydoHmq+u72gsyIWDfzDIDkMKquJWO
   473thI8kAF1t4BgJw6foXTFFqv2/duwo1ksJ+QMyLzSWGckhP+BpSddIR
   5Q2l9s0CNKGnTyBCXaeQyXX6uzjOZ7dw9sct+Y5/F3d7QOzIWnJ8KPAjY
   eKYChDUkN2E5sCqc6T8EGQtNjZSKfBC2XfkpOrwD10/naQsGKJZuTvRnX
   Q==;
X-CSE-ConnectionGUID: JSTVohgRQ6+JTOT3PvyqWw==
X-CSE-MsgGUID: Pwp3AAmhRXGhCLzvlGRwbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62825146"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="62825146"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:25:23 -0700
X-CSE-ConnectionGUID: vIBTi6UQRdmwa55pVS8p3A==
X-CSE-MsgGUID: 4hBTSLGaSpusQLEcs32Q9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="185790148"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2025 13:25:23 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 1/8] ice: fix lane number calculation
Date: Tue, 28 Oct 2025 13:25:06 -0700
Message-ID: <20251028202515.675129-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251028202515.675129-1-anthony.l.nguyen@intel.com>
References: <20251028202515.675129-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

E82X adapters do not have sequential IDs, lane number is PF ID.

Add check for ICE_MAC_GENERIC and skip checking port options.

Also, adjust logical port number for specific E825 device with external
PHY support (PCI device id 0x579F). For this particular device,
with 2x25G (PHY0) and 2x10G (PHY1) port configuration, modification of
pf_id -> lane_number mapping is required. PF IDs on the 2nd PHY start
from 4 in such scenario. Otherwise, the lane number cannot be
determined correctly, leading to PTP init errors during PF initialization.

Fixes: 258f5f9058159 ("ice: Add correct PHY lane assignment")
Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2250426ec91b..28d74bf56ffc 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4382,6 +4382,15 @@ int ice_get_phy_lane_number(struct ice_hw *hw)
 	unsigned int lane;
 	int err;
 
+	/* E82X does not have sequential IDs, lane number is PF ID.
+	 * For E825 device, the exception is the variant with external
+	 * PHY (0x579F), in which there is also 1:1 pf_id -> lane_number
+	 * mapping.
+	 */
+	if (hw->mac_type == ICE_MAC_GENERIC ||
+	    hw->device_id == ICE_DEV_ID_E825C_SGMII)
+		return hw->pf_id;
+
 	options = kcalloc(ICE_AQC_PORT_OPT_MAX, sizeof(*options), GFP_KERNEL);
 	if (!options)
 		return -ENOMEM;
-- 
2.47.1


