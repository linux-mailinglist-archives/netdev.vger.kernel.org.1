Return-Path: <netdev+bounces-100150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078D38D7F59
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383181C2182A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7A83CA0;
	Mon,  3 Jun 2024 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvKoq9DC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16481839F7
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407968; cv=none; b=iXcXI/TvMSCpcP9ybCWc1QCgdfqT0Ft4iANeGlUnhWVYCGo1TWNuIs3MXAtPqUH83hUW2Too5GPSrrdfJpXMEql1OOvU/5R1vpA3PR0DkFonk7FoafQZtmHZzfms7+pjs84gfqLvvzs7Sn3v6fmR8m0w9yBIfif0+NoVCLtRFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407968; c=relaxed/simple;
	bh=ZLH9MCdp3PkUz0FzDymBcsotd7P/pThRLfSB8f/2Kvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6w6uHaYLFn0YYl29V45h021FbkdnnM/TJkK4VDPHR5iP3p1WbOUnTr6QnDZbifDLTqjhBi++NCBrjkHiNpXCPAAYmi3yGPJpDAB+SRDndTOW3nDdhXMPHEG+X0nboWyB0Wowfwc5lOFlBc8kZQRCbVjItyDW1khKPdOQHKDzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvKoq9DC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717407967; x=1748943967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZLH9MCdp3PkUz0FzDymBcsotd7P/pThRLfSB8f/2Kvg=;
  b=cvKoq9DC/8zEKBODenYNDoBXZE02/J8PMKaOhzBfskWYEORqy9I+WhZz
   rlTLpHtwWqIlgPuFqCarNKitKc5kNte9kNukVcNnCckd+VUxQzfMjwSum
   wmOliQLhPDrT2X9nJk2AyaVu5c1d413Ne/vysTVblBHTgEmBMEa1IXrqS
   fWdsXvlL6Arb9etg9muLVuItbASWNueqE+2XcjYkuBBdiywCDYZdIQ9Ho
   RAd2vJhn+z5Kj1tWrSMKZGTdUsQba0RKwXXEiuCIEzaiqPBBzSkucAlys
   PUhB1a6GRwIxYYFQYesKmxRPVQIJ4s5oqdvBsejq29X4mM0RRNvXMzBot
   A==;
X-CSE-ConnectionGUID: 9jh9nWtxSdmOTpf5ELMeEw==
X-CSE-MsgGUID: 6TkcAdRLRB2BHXH3RJvxiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17732718"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="17732718"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 02:46:06 -0700
X-CSE-ConnectionGUID: 0DshS9FnQWSIBjDyPgLe5w==
X-CSE-MsgGUID: gU6Fafv8SeajpKAA/eogWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="37448247"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa007.jf.intel.com with ESMTP; 03 Jun 2024 02:46:02 -0700
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
Subject: [iwl-next v4 10/15] ice: don't set target VSI for subfunction
Date: Mon,  3 Jun 2024 11:50:20 +0200
Message-ID: <20240603095025.1395347-11-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240603095025.1395347-1-michal.swiatkowski@linux.intel.com>
References: <20240603095025.1395347-1-michal.swiatkowski@linux.intel.com>
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
index 8bb743f78fcb..fe96af89509b 100644
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


