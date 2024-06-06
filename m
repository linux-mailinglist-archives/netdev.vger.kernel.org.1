Return-Path: <netdev+bounces-101381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4EA8FE536
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E12E28788D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED35E19539A;
	Thu,  6 Jun 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYnLrR1T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B801957FB
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672846; cv=none; b=FpEBaHWs74WdeVABinZHdgB0C/zLln4fIfducasb7FwYDon6hTZbe3IOZWdqMwykvIMu8DAtLMAF4xhD1wp72lh/PU4rraNnTC1a6h6QFEhk+0n16Rl2wvpL/SqDiMpsKoYZVghqPcLnM48X4MjxqmAf+I6kjx3H7MPlCur30vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672846; c=relaxed/simple;
	bh=XRacSA3WWFsdAIMvKjGR3jueZmKP+bga1wUx7zkkWqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSQq41SS+E0IUxpfCN+ck3blCM2rMTUmAycpbQ9HnlwLJKx3WEYE6Ep5b6eEQhKkeRR8EOG3Vz2f9YTbBgp6XqyBGIrKqlCC6N8kZnfcS70TAda4lFsRUeZZwdL/pgCytBeHfO4B3hLNCMKorcmDbFXMsgokXTNRBPiCrAEZPpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYnLrR1T; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717672844; x=1749208844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XRacSA3WWFsdAIMvKjGR3jueZmKP+bga1wUx7zkkWqA=;
  b=JYnLrR1TEdIu8F7OEorjawM5Oxkxq+/DVUDLyqwlndkR1CRHtJyY6Ren
   FJWt4cOXFL7XDaHyrdEjGT6lL/FHkwcmo8XR8QGU1uXWtmBoOTqAfahUq
   dZLa/wVFs5O5X5Z8xP/P+ovQiXJpwzKR+UqitJwNe80RI72dk1w0yfV8L
   DU/ZNFMVoLBbuOVIVS7E2B/BnDnK09VMZdd/eVzit3ftx2+itJrl2VU1n
   vFkONvaqqkg+eJucNcMSvTRIkC+RPJK6VROLfxAQqQpLlmd72CFMKzXe6
   MmZmwflNG9EkIK58U93RQ5bO8Cq5jbSr5SPAPIpqXlneeMqR5RIh933xO
   w==;
X-CSE-ConnectionGUID: iWCDmIx2TiqxMgOaUosdOA==
X-CSE-MsgGUID: CUAy6gxST9mNu5TzeK/VHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18123787"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="18123787"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 04:20:44 -0700
X-CSE-ConnectionGUID: wD2afCCdSLOBOkQg518Ong==
X-CSE-MsgGUID: WeGsUz98TRKbK4KuzIzwvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42864640"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa003.jf.intel.com with ESMTP; 06 Jun 2024 04:20:42 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com,
	shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com,
	horms@kernel.org
Subject: [iwl-next v5 10/15] ice: don't set target VSI for subfunction
Date: Thu,  6 Jun 2024 13:24:58 +0200
Message-ID: <20240606112503.1939759-11-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
References: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for subfunction before setting target VSI. It is needed for PF
in switchdev mode but not for subfunction (even in switchdev mode).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4c115531beba..277e8ea3e06c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2405,7 +2405,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 					ICE_TXD_CTX_QW1_CMD_S);
 
 	ice_tstamp(tx_ring, skb, first, &offload);
-	if (ice_is_switchdev_running(vsi->back))
+	if (ice_is_switchdev_running(vsi->back) && vsi->type != ICE_VSI_SF)
 		ice_eswitch_set_target_vsi(skb, &offload);
 
 	if (offload.cd_qw1 & ICE_TX_DESC_DTYPE_CTX) {
-- 
2.42.0


