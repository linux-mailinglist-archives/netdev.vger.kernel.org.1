Return-Path: <netdev+bounces-95912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A878C3D4F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C671F21EC2
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899C0147C93;
	Mon, 13 May 2024 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/UdMNPq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CEF148316
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589187; cv=none; b=VHdnzTGsvjTyJ0zFE2r3zqKxeh4mOfwaSLU+fqMbDaU8yfe/1+h/gQpWR3A1MKCD0DIAhYt/9aL4jdGWh9dSMdywrIdzSuZ8IIti8vzbH64bQQAAPwTr4TisVTw5TQGN7g8CdXttGtESwhBmJud6Jihvzzu0qMuiVvw720f+NkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589187; c=relaxed/simple;
	bh=eMS+oxn1tYp+rxus1jdEnm2eqSOO3ayeaJRU5iz4V2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHxT41GUawvtrScwTl689GjhJcG7Y5JhREkm9G8s/8hrbyix5aUy90NfPhH7xkqiaKok+489KklO9vnXQxjfqqtS5Xx27qUrXvh1GO7awfH7R/Do82l0zmwOnfSlbw6kzmZr3opGI8kPzVeInzd4HXwCiSGjvmg8xI9VZ1daQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/UdMNPq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715589187; x=1747125187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eMS+oxn1tYp+rxus1jdEnm2eqSOO3ayeaJRU5iz4V2o=;
  b=c/UdMNPq2999tAKc1rMkrKcCRdJlNd2FJz2IPil1b8z8hr18lKKw/ykh
   n7IQeNQ+JUwHui8XjrwVsURRYsD6nHjugyrm2HqAcePLPGZnGJSBxtybB
   QsBtWmktsR8fn7Ngx90ei3TKhrIveLJfw5yELeooMaVzcHPzzQIylfvMy
   9VNKya2hubuvSON6hEvSaZM7GE6zivn5vhMv/D1uu5uFIEwBynHC4xTjZ
   /WsaoBDa97GzhtgA8bJ7mJQWcZs77iByziPrLyFhgO5On5E7IzApi8q8P
   FPuajQDPv4Zo0YWcPCjkkvGAlu8UEKkPxpr9x9X+vM0Wte8VA1A10jeLh
   w==;
X-CSE-ConnectionGUID: e4wqEWEjSNS9NYH1cPa7vA==
X-CSE-MsgGUID: RxcI3GZRSqWatqln9+KjjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22914860"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="22914860"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 01:33:07 -0700
X-CSE-ConnectionGUID: aHm/ZgJSSf2oW8+B2ZSzAw==
X-CSE-MsgGUID: BMCKDbRCR1aL8PiVT63lKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="30303587"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa006.fm.intel.com with ESMTP; 13 May 2024 01:33:03 -0700
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
Subject: [iwl-next v2 10/15] ice: don't set target VSI for subfunction
Date: Mon, 13 May 2024 10:37:30 +0200
Message-ID: <20240513083735.54791-11-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
References: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
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


