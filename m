Return-Path: <netdev+bounces-111536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5339317CC
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC8F1F21BA1
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E931D18F2E8;
	Mon, 15 Jul 2024 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0MAghp7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ADE18FA14
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058045; cv=none; b=Bw9VqNDEjiD7CEuqf29dP9hBIfazrpcuc4WYj9YiUpjmEXUDqfc4q7uaP3CXU1J8mWgp8GymJm4wRnMAmGlyG/TwuCg6mJuVyW0a4O84baDE/PqVmC1pDwl9cIQtHOgnt+L7nX8NrClORk9VMOkdZtFXeLeTrjx5RGlvWhqeAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058045; c=relaxed/simple;
	bh=+hBmgCtmu/DK90QJduJYhArW2EqndSlIgHnT/yc0jos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FW2eFa6eTD06TsJed9L0UiH56deQAYmelu5qYW/HzG/tP18xCF9O+KlE5qws0UUyQO84UfxyfRmDKJgAzQPOfFt9RsLkzk7WqGRIasH9YsB/EN+HnjVzlpDzZVSuJUTxsHTI60oGooFX3HRL9T6jQkjQqneSFydydLEe/RD2anw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0MAghp7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721058044; x=1752594044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+hBmgCtmu/DK90QJduJYhArW2EqndSlIgHnT/yc0jos=;
  b=R0MAghp7ki1zSJhoL8br/6ReUBySh3g/8glTnE8VsFxLVOul01JfrIPq
   AIz+kyhvH4o05J74I6uzE0dFQsm4q8LKakkpSUDSfsmj+Ck85S6C1t43a
   /0OluIqW5ngjuCah7cktgk0mO4IW2mCyC2BoDx8MvMa/8uQjBPCVZXru8
   VNq03YePWZeKKjJV3etyZx80F2fuDJZUzTMO8AyW3gVCjtYB5JA00Iztv
   wtZhAqIRWoNAAro7g71iqeu8vqYz2mFE6a6W/bcvR61CW96D9TJDryC2P
   LHSiahda5ESf4Yll96DEoQqWQsJGlAjSUPvvSaecq068+NKyzGy6Juxst
   A==;
X-CSE-ConnectionGUID: E5bVSqUGTTOua+RfSHI7Mg==
X-CSE-MsgGUID: 9eELQxcoTySXxFI7clUxaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="35987682"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="35987682"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 08:40:44 -0700
X-CSE-ConnectionGUID: Z1EM64evTWe8v3gw+E4kTA==
X-CSE-MsgGUID: jCVa6wxNS1ixvKLsguEVgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49408491"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa006.fm.intel.com with ESMTP; 15 Jul 2024 08:40:42 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v2 2/2] ice: Skip PTP HW writes during PTP reset procedure
Date: Mon, 15 Jul 2024 17:39:11 +0200
Message-ID: <20240715153911.53208-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715153911.53208-1-sergey.temerkhanov@intel.com>
References: <20240715153911.53208-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Block HW write access for the driver while the device is in reset to
avoid potential race condition and access to the PTP HW in
non-nominal state which could lead to undesired effects

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Fixes: 4aad5335969f ("ice: add individual interrupt allocation")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 11fbf2bbcae7..40a07d0bb341 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1408,6 +1408,10 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 	/* Update cached link status for this port immediately */
 	ptp_port->link_up = linkup;
 
+	/* Skip HW writes if reset is in progress */
+	if (pf->hw.reset_ongoing)
+		return;
+
 	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		/* Do not reconfigure E810 PHY */
-- 
2.43.0


