Return-Path: <netdev+bounces-118209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5EE950F51
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37B31F23B9E
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DA41AC442;
	Tue, 13 Aug 2024 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCUGLBQT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62B1AC426
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585826; cv=none; b=VC/B0os5kV1ReAYH6//NzBWs+CVFbWNZNMlgmwP8SNDmH19egJ2sASm/QxB0BgyPgp6OLJPRt8RTpNPTAPR/x7KV4Fg1SXNvxpN+WVrwdokU3PLxj5M4Ib7yQ8nmng3hDq4cphdoaXSb++kcKOcooAbqIlgZdukuAD93NrODPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585826; c=relaxed/simple;
	bh=WfNtwD6keXKCRe4ITugs3W/573UVYZ5rks1aEYnG6hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9oUQ9kJmquaCXiK33QVteTUC5mJz1llnlltKS+rIV3K9m/luaA5ZR6Ofjr9CqiQ4sCsMbmS0dR4sY326OtNk66F8WMHT5bHtgALItika+Ebui2UMwLItvgvVnZ+wJ1US+BjTekghKhCx260IkfRE5VagDHuz9WBPycjgOSwk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCUGLBQT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723585825; x=1755121825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WfNtwD6keXKCRe4ITugs3W/573UVYZ5rks1aEYnG6hA=;
  b=VCUGLBQTwaUBAu8TA48lZ2vPxvo5V1FHiGOUTpn6LrMqHmA7o9VdNx3R
   5+YIq2VRAZmreuqD6mXAYCl92XkNSxnRuYbdPRK6j9CaBploYkC6wnjCE
   2kbWMaYZ+isWHQXePZHh7rmTskSsqeda8TVRJCrQA8AJquzLyI4X+1pkt
   orIV6ezJvSxG+M2UpIbANvFoUXmbyDCxU2+Ng+nYIk6UunkM1i1Rn1XMX
   vJWzIx6+nMArfBsjNyyHVYmH32X86qBC6iQ5CnV/aOn1O8jPzJRok7RWg
   D3IxSY2utTSTVIB4R0tyJy0kKOmVA5SkQbMQVdtKoU4zsE4htpBNvLGBF
   A==;
X-CSE-ConnectionGUID: /enJFQ7PTVio3O8/84A8Cg==
X-CSE-MsgGUID: VZAxB6NxRtSMfiZOhP+x0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21748176"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21748176"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:50:08 -0700
X-CSE-ConnectionGUID: TEzn/YnPRKCzervDSYl5Iw==
X-CSE-MsgGUID: O7/sNFcRS9WVcIkth/MxNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58685584"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 13 Aug 2024 14:50:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jiri@nvidia.com,
	shayd@nvidia.com,
	wojciech.drewek@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com,
	pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v4 10/15] ice: don't set target VSI for subfunction
Date: Tue, 13 Aug 2024 14:49:59 -0700
Message-ID: <20240813215005.3647350-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
References: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Add check for subfunction before setting target VSI. It is needed for PF
in switchdev mode but not for subfunction (even in switchdev mode).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8d25b6981269..d327a397f670 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2407,7 +2407,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 					ICE_TXD_CTX_QW1_CMD_S);
 
 	ice_tstamp(tx_ring, skb, first, &offload);
-	if (ice_is_switchdev_running(vsi->back))
+	if (ice_is_switchdev_running(vsi->back) && vsi->type != ICE_VSI_SF)
 		ice_eswitch_set_target_vsi(skb, &offload);
 
 	if (offload.cd_qw1 & ICE_TX_DESC_DTYPE_CTX) {
-- 
2.42.0


