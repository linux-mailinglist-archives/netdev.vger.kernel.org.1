Return-Path: <netdev+bounces-130333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC7898A1F2
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9252836E9
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDEE191F7E;
	Mon, 30 Sep 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KmVHdHPa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB98191F85
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698242; cv=none; b=a9DXpbiog1kH9fPpVCQECEYkZQWF4GIuTzP7KUSc5P+LA6q14euvcqkII+9GJ6GOXvB73Zl3EEptdw3UHTkfE1yBbRT8j6Xzg7mH56OePS585EGzvo9t423ISVNyQ8dEPWmh9z9smTviGL/SsYPz51NROVcMZVNXnnOPpDBWmeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698242; c=relaxed/simple;
	bh=OLhQyk8UDnW+4coEU2wXN6cUwFnhao/AAG26hJM2Kkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ib6utPONHaG8fkdhK0N4Fa3u6v6m1Yin9gAa8plfQUaZ7Gjl1r6Hb9zs927xZJSXxr5CyESTUyi9OcoOD7GuUsDMMcUstCq6ZI2meiXsKvuASLt61r4v16IyHEOsXJ3+nGtsYtqhcbjU3SjwC0zzE6eosOu1hKlDXSSU4WygEAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KmVHdHPa; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727698241; x=1759234241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OLhQyk8UDnW+4coEU2wXN6cUwFnhao/AAG26hJM2Kkw=;
  b=KmVHdHPaaWBCn+jHLVhjhNrMaIuVWYMvF/0PLw42XBQNa0YQ3S6tyRtN
   abHyJdRXeIDvGJ2deBEcrrdESkbKE1NUXcgwc2ncnSkaKev72C/pwvCBM
   WUveilgMRsWJAEjYsv9a2paNakt7l8Ch9aw8Pys6gIV7SzP9AIbDDX7cv
   7sV9Id8XaEF8ETL77yt7fCcT63mCpJGZGkfBUQToMPb+9fAgWjOIPz9xc
   /f+OO3lXd/6apmj1Zq3ZFq4wDWcnJsHg4de5OHYTNkziprFWbuGGxUS9L
   N5RI81P1cfrjpqhKIXfxSUIKCqbmkMbmCLgpIb4GKjc5/P0cTEE6GFdcF
   A==;
X-CSE-ConnectionGUID: crncF4DdTWSUoFS+8DXn4w==
X-CSE-MsgGUID: SkuobSsMQ4O9T7SjHYgyBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26736091"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26736091"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:10:40 -0700
X-CSE-ConnectionGUID: 93ZMryksTpOCLXzSuqwpIg==
X-CSE-MsgGUID: qqpfVj/NQXCJh8pXbKLbJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78037024"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by orviesa005.jf.intel.com with ESMTP; 30 Sep 2024 05:10:37 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net 3/5] ice: Fix ETH56G FC-FEC Rx offset value
Date: Mon, 30 Sep 2024 14:08:41 +0200
Message-ID: <20240930121022.671217-4-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240930121022.671217-1-karol.kolacinski@intel.com>
References: <20240930121022.671217-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.46.1


