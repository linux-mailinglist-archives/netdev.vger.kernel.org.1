Return-Path: <netdev+bounces-139667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3B09B3C41
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5D81F23458
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD671E1A27;
	Mon, 28 Oct 2024 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sivs7Y98"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514C51E1049
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148572; cv=none; b=Swsqc+i/finRZYGBbn/p0HfWTByW5bSS2ZqRvlVmkOp7PR2pg6oBpWPiHyPTJ4HIXtwKyE2i4gfiv5JubggJuVY3GmfmA4zPHtANndsqVZeRvJpykhUwEi2+zNObJZwQ0AoFd4vq+T9Zudd7L1trjVTnvLzFOxXrdUhEKb9bFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148572; c=relaxed/simple;
	bh=biS9PpsZukdARCT2UtGImUoOkdDZ1ON6YK3e5b1v/dU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ujo+sBQaMQcAXxsAB1HIP6/Is42GeAmywQYSqak/Kc4Xm4afVY9XxxjwguMlx8L4zZ23GM+k5CDhVVw4QXPnuuXfgGH87xE6vKdHgV43WqX/orEV8+NJWX5QMN4LPfiQSohWFKp/Hom7rNMVIV7yFBj4LiSphl8LhZBjBm/FaMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sivs7Y98; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730148570; x=1761684570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=biS9PpsZukdARCT2UtGImUoOkdDZ1ON6YK3e5b1v/dU=;
  b=Sivs7Y98UaZbOlb5HgYv6GnTrkvVZEumg/xgBR0/gQBujkG+nHzdUE6S
   QXRD1FEXgrCWplHKPFHw+u37Vl1NoK1R+82LPqY871ReK5nlmh0nTCAbp
   33Wm7L4JUGHEk2FTmYvSm8q+7h/SnBbSdi1pzuWYeHqRPF4KM8jaEpq2c
   6QeCuUcdqXpaHf9kt+vafbfKy/hV8Sy2jpQVbxzBmeRlSVajg3cClW/i/
   5+VzaGWh9w3Y6p8dZHIrfSD/a1HdivoxAtJYLTFh1jm5SwC9XIGjxhA90
   inrst6pASt/n5j4gkZodu+pKLoS1xnMpUDLmO1jX7qXmCLHdR0J1mhmyo
   Q==;
X-CSE-ConnectionGUID: 3bbyVVlgQPebGJunEEU04Q==
X-CSE-MsgGUID: cj4Pa4gyQzCnn8+1cRU9nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="33685564"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="33685564"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 13:49:30 -0700
X-CSE-ConnectionGUID: viuexy25RuyvgsRMcbtVWw==
X-CSE-MsgGUID: U9s741yGRQ+rB5BMlwkU4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86529951"
Received: from unknown (HELO gklab-003-001.igk.intel.com) ([10.211.3.1])
  by orviesa005.jf.intel.com with ESMTP; 28 Oct 2024 13:49:28 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v3 iwl-net 3/4] ice: Fix ETH56G FC-FEC Rx offset value
Date: Mon, 28 Oct 2024 21:45:42 +0100
Message-Id: <20241028204543.606371-4-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241028204543.606371-1-grzegorz.nitka@intel.com>
References: <20241028204543.606371-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Fix ETH56G FC-FEC incorrect Rx offset value by changing it from -255.96
to -469.26 ns.

Those values are derived from HW spec and reflect internal delays.
Hex value is a fixed point representation in Q23.9 format.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index e63f2a36eabf..339b9f59ddde 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -86,7 +86,7 @@ struct ice_eth56g_mac_reg_cfg eth56g_mac_cfg[NUM_ICE_ETH56G_LNK_SPD] = {
 		.rx_offset = {
 			.serdes = 0xffffeb27, /* -10.42424 */
 			.no_fec = 0xffffcccd, /* -25.6 */
-			.fc = 0xfffe0014, /* -255.96 */
+			.fc = 0xfffc557b, /* -469.26 */
 			.sfd = 0x4a4, /* 2.32 */
 			.bs_ds = 0x32 /* 0.0969697 */
 		}
-- 
2.39.3


