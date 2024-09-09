Return-Path: <netdev+bounces-126697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCAF9723D7
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD11B21FBE
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4891718B46E;
	Mon,  9 Sep 2024 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGcZPc2K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33118B464
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914347; cv=none; b=FEDdba6T63oEHEwmbj3am0e42nUhC0JnNO6N9+1Wn/Z8YdFfxqggfmgkl+u2+cWoucu0oTO69ElZFhto5an6RUGCx6frf34TEsDjSS0kR/eKQknOOZwL7nwKVGrgm7Id42dFrqpRZMrXIaHnBHTzW4dxjuq5lbndTZfbOCme574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914347; c=relaxed/simple;
	bh=l9YWFyi3pWxAoa7A/Jm+BQ7HKUCTnOhEJXioDIDl2hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0f7NgGs5jBq3Tgnlz/Xx4UkKytk0XYVxar8uNguR4AfcyXdFzJIxqQfQvlPU4rVasp50TrP3016TWty8roQCTxsZgGQgMM7u2NpOavjC+SC1GudGK7tc6gEY28qk9FcXkwl/FZlxk5tRaMOklknRTHCBC/STAP15R6ae21Erx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGcZPc2K; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725914345; x=1757450345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l9YWFyi3pWxAoa7A/Jm+BQ7HKUCTnOhEJXioDIDl2hs=;
  b=AGcZPc2KutCiPsBJwim4oykgHFAmOaqh851vDmIzL4o4ZJNNsdiRtq/r
   w+3FbXGMVOYJTWaOJAzteDFdSPeWxbCShiWOcczsJZ+QGbiJkdm3/i2Q3
   w1eUjhhlelI3vC6n0hPTouO99xieP6rD3lRygL7LvTc4hvA9AiR+Q/U1n
   Jj1yTywlZXqJY9ax61KVSEalpl5NGjRiNxY50xOsp7s3czIKbwFMMA04l
   oWn82Kqs7qRHJZjItKireN8vIUvff7zLdAYMX4K9zP0WiTdNBjiDMaE6U
   EgfMdDdCuXKKbjvZaVmYuKrsiZsqM+Rplt8yXMXfyEj9kmWzZMEyNzB79
   A==;
X-CSE-ConnectionGUID: AbkNAroBQMyod3gnsVA3LQ==
X-CSE-MsgGUID: v8mbKBejRpSunykh0xpYPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24787101"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24787101"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 13:39:00 -0700
X-CSE-ConnectionGUID: jqdHGkMJT4iRgrxs4ZA+cg==
X-CSE-MsgGUID: nAgUUdmHSSSqSfXQqhMyJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="67054807"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 09 Sep 2024 13:38:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	=?UTF-8?q?Mat=C4=9Bj=20Gr=C3=A9gr?= <mgregr@netx.as>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 1/5] ice: Fix lldp packets dropping after changing the number of channels
Date: Mon,  9 Sep 2024 13:38:37 -0700
Message-ID: <20240909203842.3109822-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240909203842.3109822-1-anthony.l.nguyen@intel.com>
References: <20240909203842.3109822-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

After vsi setup refactor commit 6624e780a577 ("ice: split ice_vsi_setup
into smaller functions") ice_cfg_sw_lldp function which removes rx rule
directing LLDP packets to vsi is moved from ice_vsi_release to
ice_vsi_decfg function. ice_vsi_decfg is used in more cases than just in
vsi_release resulting in unnecessary removal of rx lldp packets handling
switch rule. This leads to lldp packets being dropped after a change number
of channels via ethtool.
This patch moves ice_cfg_sw_lldp function that removes rx lldp sw rule back
to ice_vsi_release function.

Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
Reported-by: Matěj Grégr <mgregr@netx.as>
Closes: https://lore.kernel.org/intel-wired-lan/1be45a76-90af-4813-824f-8398b69745a9@netx.as/T/#u
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 737c00b02dd0..2405e5ed9128 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2413,13 +2413,6 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 	struct ice_pf *pf = vsi->back;
 	int err;
 
-	/* The Rx rule will only exist to remove if the LLDP FW
-	 * engine is currently stopped
-	 */
-	if (!ice_is_safe_mode(pf) && vsi->type == ICE_VSI_PF &&
-	    !test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags))
-		ice_cfg_sw_lldp(vsi, false, false);
-
 	ice_rm_vsi_lan_cfg(vsi->port_info, vsi->idx);
 	err = ice_rm_vsi_rdma_cfg(vsi->port_info, vsi->idx);
 	if (err)
@@ -2764,6 +2757,14 @@ int ice_vsi_release(struct ice_vsi *vsi)
 		ice_rss_clean(vsi);
 
 	ice_vsi_close(vsi);
+
+	/* The Rx rule will only exist to remove if the LLDP FW
+	 * engine is currently stopped
+	 */
+	if (!ice_is_safe_mode(pf) && vsi->type == ICE_VSI_PF &&
+	    !test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags))
+		ice_cfg_sw_lldp(vsi, false, false);
+
 	ice_vsi_decfg(vsi);
 
 	/* retain SW VSI data structure since it is needed to unregister and
-- 
2.42.0


