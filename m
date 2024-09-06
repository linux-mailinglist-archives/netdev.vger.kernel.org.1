Return-Path: <netdev+bounces-126102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 793B396FE01
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 00:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281851F2193A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 22:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7A315C15F;
	Fri,  6 Sep 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LkswbOn1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626E15B0E3
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661820; cv=none; b=axvlxSgyEcaWuJxEctu81YeHJJQXFNEKHV42z3XKDH5UVQmpSD+vK1XApzM5w6xxHNqNGLVZeUqNclLPil972hWWvl77fN/S/LpJQMqHcufWQSReCqSyjS6fsQQDoe8q4bSrkBikL9+fzuS1NWaCjg6HChqn3F/A6R34o3FhHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661820; c=relaxed/simple;
	bh=MFYPEn9TFwQnUbe01OkYmQr3sE0ohGrXwhTl/MALhmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lp1Z9hRXE6p5uX26Hqf8jyCJA7bLuD0eOR7Bj2lMeVB7CeJdOMfjug2Q6CPzYlPCnbyVRwrDgkuE7ntwrpYnrqtM+EVmfVDUvRNquAt/DUCFGiJ/ih6jbQzaWIATPixXlbY9x5M3i8AWfwu2YrrcYhUGguuZcPL4FkSaJDXJtnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LkswbOn1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725661820; x=1757197820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MFYPEn9TFwQnUbe01OkYmQr3sE0ohGrXwhTl/MALhmA=;
  b=LkswbOn1IBJjFkcrd34QWYK6lPt7LHb704T1BAaiV7TUuqemLZIZYsE1
   gJs4RkjRsyJYh+QYO0GcbbGD9Np/v12tgKy/CSwqD6XS1YEqJ+9CNSxTz
   a1mErqCZNlCt8kV1dPsq/OeIEzRuwTc/xYswG/bstARttHuv37WIYfnqY
   MvOQdFIdLyXfv9klWIJv0IKjyYnn01wsrVatJfwj3SaM7uYAbfOd/FgVL
   RkFhdo1Bav1WrRfTgSPDf3sqw51taUwOh9Egtm5Ryqdqw8fwOwKlnhAqf
   y7VkdZ4BlWT5Fk7lN2Z+pBNpdw6Ojz+8VDk3okTWRJi8YCn+o5G/pLcD3
   Q==;
X-CSE-ConnectionGUID: bGphA9R5TbS48eoD3dlDCg==
X-CSE-MsgGUID: wMs6q7cBSFOn4c6Wdo99Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35030748"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="35030748"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 15:30:18 -0700
X-CSE-ConnectionGUID: FozuVWFWSSeWk3NYKIoF7w==
X-CSE-MsgGUID: fkTiuGQ4TAu5Xoam4f1BOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="70490455"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2024 15:30:18 -0700
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
Subject: [PATCH net-next v5 10/15] ice: don't set target VSI for subfunction
Date: Fri,  6 Sep 2024 15:30:01 -0700
Message-ID: <20240906223010.2194591-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
References: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
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
index c9bc3f1add5d..8208055d6e7f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2368,7 +2368,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 					ICE_TXD_CTX_QW1_CMD_S);
 
 	ice_tstamp(tx_ring, skb, first, &offload);
-	if (ice_is_switchdev_running(vsi->back))
+	if (ice_is_switchdev_running(vsi->back) && vsi->type != ICE_VSI_SF)
 		ice_eswitch_set_target_vsi(skb, &offload);
 
 	if (offload.cd_qw1 & ICE_TX_DESC_DTYPE_CTX) {
-- 
2.42.0


