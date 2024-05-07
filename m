Return-Path: <netdev+bounces-94080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816AF8BE136
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE73B25EE3
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E75156885;
	Tue,  7 May 2024 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HP6WC+/t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5F8156C78
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082040; cv=none; b=U1KUyhVEWVRiRcad3X0hs7gznpAHj2YYd/bQS8gDRNyWTZbAfRY+5ZwDVq3VHlQGIq2zHDv8G5NUn4cEuSPrZ+nJ7fnDvBMIIDenU1fnxrEJI/k42GzlHg1l9udZwByCE/z4zDYt/ppN/R3Hx3jYAARMFf9Cnk0kmyFnL1gmhC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082040; c=relaxed/simple;
	bh=eMS+oxn1tYp+rxus1jdEnm2eqSOO3ayeaJRU5iz4V2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5mU1TpQgKOu+aSMd+f+VKhJq7LL2oe6ZkpI5jUkUi+0CF2hk6IvmHbFQ2o3MrEgy3L8D9MGkMqfDFSpQ2N99hoq9bUMiKnyN6zNVwMqASjOEGhLLwIhGi81n1SQ/T6RXT2zWAXTRfrgdb6aFtHY7eyjIKYJGdRqhUeygdDguZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HP6WC+/t; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715082040; x=1746618040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eMS+oxn1tYp+rxus1jdEnm2eqSOO3ayeaJRU5iz4V2o=;
  b=HP6WC+/tQ1+iV6SvDzfW0QlMYQ/S09fxV42WnVj90dpqidPDBR7I4H7W
   hMMpPGbXQbPRZKG/YMut+y9IMEEUvsh8J67MMNDJRqhLZPexya6iHDiy3
   wqig3s6ZEdK0I+KlZz8TzBt3K3VTdy2a6Mb3H4U7SkO/JlzLswCjS0C0v
   5u0AeCRMe8asu1H8yLnsWkUbswHVJjZsC5tNImXbNXY6e2+DM627RUbdh
   E1BT8+JaWGD0K2JriOFlnoXG/uBufUyaXaY0E74f61z/jSTDc6xldy3Kt
   8pNhIGJyF6L1eCz9gVAzkbR9XL9zQLiPudxyNnsKJibKqcf/pdVK5pm+z
   g==;
X-CSE-ConnectionGUID: +UWcDW/5SfCyIYG/lhZCUQ==
X-CSE-MsgGUID: UqAgb5hxSTGmiNyup/4mWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22029257"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="22029257"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 04:40:40 -0700
X-CSE-ConnectionGUID: JlShoNYRQECW6H+9ptThQQ==
X-CSE-MsgGUID: C1c1cCk5SmWbinrikK7lIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="28576708"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 07 May 2024 04:40:36 -0700
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
	shayd@nvidia.com
Subject: [iwl-next v1 09/14] ice: don't set target VSI for subfunction
Date: Tue,  7 May 2024 13:45:10 +0200
Message-ID: <20240507114516.9765-10-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for subfunction before setting target VSI. It is needed for PF
in switchdev mode but not for subfunction (even in switchdev mode).

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


