Return-Path: <netdev+bounces-98387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036118D136A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 06:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7621F23B41
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 04:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402D01BC4B;
	Tue, 28 May 2024 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOpyXmur"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCD82E64C
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716870820; cv=none; b=liYEirWv7FUxY0SGz3AufjxPoN0l3mBfy2y+VfgQz59RB0koE0qgdBzQyVeNtDSZbog8gxoDUHgrE6YfrdrUUdGwNnN3iddtdqYcxcoER13ZVz2ivWO1IxyV2Flc1rQmMhdJ25VrMmw0stV8SpARvsHNFgn7i7d1xnHSDDNkAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716870820; c=relaxed/simple;
	bh=eMS+oxn1tYp+rxus1jdEnm2eqSOO3ayeaJRU5iz4V2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKXDN+OtwFTKHUkuDfBAZ25vJ44Jj17JCwMkmzdg0wUTf4Xjlp6AtvupOhO69coaLrS5uwjAT+avQGNGJstnAd2rLnlmKoi+gGrYpxU5TaBuBvkq4pbpr9Lvud5XOtBLCYA13jigcksDS6AV2aB+NBvs9u8wadhsvJ8ZOMemJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOpyXmur; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716870819; x=1748406819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eMS+oxn1tYp+rxus1jdEnm2eqSOO3ayeaJRU5iz4V2o=;
  b=lOpyXmurQqxOaYvOj5344bGL1r4av2JFiaDum6QTyuGHJfwoyJGUMcc8
   XnFOhOEqiHDsNziSQ/b4y3w8JN4NdS3vAG0EAd5BQnbE9r2Flis557hKI
   46z0MYCF7y0l9V2M11y1oX7WAym98gpIVslfoeDIQ/mDk11w6YNnv0Mwi
   ogLHWlSwWO8i814dLxOVMeIrY8zc6ACqVxADLGrTHVJk5OcYr3e3fAWU5
   3w71SATzXkL3aoOCKZ+0H/+84rS7uNJGdaQ3zcU8auoEVPX+dIbZMtyFd
   UhleYZTTegHjifKvLsWZQkUvzg0L9QuVQtdzlVLU+uI+CMHlisUbDT5zO
   g==;
X-CSE-ConnectionGUID: Xe0BO7WwTZSkSom8eRoHPA==
X-CSE-MsgGUID: 2o4HhA5eQeGqceXBtJdNNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13020134"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13020134"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:33:39 -0700
X-CSE-ConnectionGUID: L1eglQUdQpChQYJBUzjobg==
X-CSE-MsgGUID: NfM+C1Z5TSy6oogU1fmFGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="66152430"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 27 May 2024 21:33:36 -0700
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
	kalesh-anakkur.purayil@broadcom.com
Subject: [iwl-next v3 10/15] ice: don't set target VSI for subfunction
Date: Tue, 28 May 2024 06:38:08 +0200
Message-ID: <20240528043813.1342483-11-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
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


