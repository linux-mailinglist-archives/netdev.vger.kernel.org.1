Return-Path: <netdev+bounces-134279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2639699897C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557C01C21B2C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74741CCEE8;
	Thu, 10 Oct 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0zTY/bs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED21CCB5B
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570197; cv=none; b=p9tQ4FwgBx2wmSpPxB4q+AsBqNURW8c7CEccS5HA+qql7UAQ8wB7fL4mZ8oatNoq8y7OquV+Bkq6btKsKpqD72RVW1yc1uzmCv0YL96JD+B7WOWCxOuZO1mysnoDMlQTnH0HN7ByXR3+Km1f0lET5DsiDEmt3ZCgqh0KvwSSMWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570197; c=relaxed/simple;
	bh=jiPvPXxBq3tdFiDO1nLpvgYWsPIczFNWPyj+6nTmfuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcBINbTorLW9AQswr3qwWnTpMElc1uAjhQJnBMNBeb68Vr64Yc6R9SoFDc5QQRFB6kWUHtshqiEkngzNVUeu4t4zr3t5HNifBAY0kca/JQQ5WWOtcvHBwwa/OcIlUASGU5Oe4vxDw32oeMkg68IK3r//9hWa1uJw5HsbMi57nXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0zTY/bs; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570196; x=1760106196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jiPvPXxBq3tdFiDO1nLpvgYWsPIczFNWPyj+6nTmfuo=;
  b=V0zTY/bsa9XZGvIeUpgGqUYrvNMHzZrF4fhpIKAyV4xN5A+GVSc+C1Qf
   Rk3KZ9ZJPVj3cd1sOI8ipGtJyfJJtGTkUguvhBTmic91lkmDbdjBIgQO+
   KVwA3HtQqP9Uuy7BtIebAYPZ9/WP1rq4DeI3V5no1iAWbnPuwlKswW9Zh
   OpvhvFldXMK79eDtuzqnhBKPYUJmKbrF9zhQt5qDjlTLTbWX5UVrTYv8E
   /Fvdf00bFHHGUIYJIdGXjNWjILZxCQw+gm0R3NKGoFFsf4cv56T0LelFD
   cId39AKfD+WbEhgoOWT9WtpmSZPTRswYOT28d8E32NNTDM0Puoe9Sh0eb
   A==;
X-CSE-ConnectionGUID: dnP0V0D2S0algJKIyKkgAQ==
X-CSE-MsgGUID: cEjp7FsFRwKaV5+qI02rmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39321115"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="39321115"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:23:16 -0700
X-CSE-ConnectionGUID: z5YbTlAgSCOkAHgaLif7fw==
X-CSE-MsgGUID: 4a+QwLGySWeioCns9+2NEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="99937516"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by fmviesa002.fm.intel.com with ESMTP; 10 Oct 2024 07:23:14 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v2 iwl-net 3/4] ice: Fix ETH56G FC-FEC Rx offset value
Date: Thu, 10 Oct 2024 16:21:16 +0200
Message-ID: <20241010142254.2047150-4-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010142254.2047150-1-karol.kolacinski@intel.com>
References: <20241010142254.2047150-1-karol.kolacinski@intel.com>
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
2.46.2


