Return-Path: <netdev+bounces-104536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E490D2DD
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66DC4B263D9
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BF01A2FC6;
	Tue, 18 Jun 2024 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJfIwFHp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F6C13C8F0
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716415; cv=none; b=jrEY/lN+wt6npOfDlgWAQAQLs2RAZnUMPiKMCYkJ1Yhe71xUwf7IadTh2oDmNevQki9OOQtQQ3d1kHZIqQ47fWEpnnFTWD/QsB1kOiQKaFRoDA7hGnjvsUMHU2tfz1fmpx9h+CZkQZC+Pv7g0RjQnIdzKnK55TvS3504Z7V2AMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716415; c=relaxed/simple;
	bh=ox4UVVD8l0UB7uOobj3iQqzlawl6rmOUvrHDfuEAzK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXIgaXk5e6ArMoCx7AcOtlvxqG0IiJd9OSUr7AL+GN2swbPw+v57aBWQ7NnEOb/FT8G9pmmVmUT93iHDby73KIkOefniKEyZCe8bYtNTKnkJaFSpbBVuP9DhglXUpwbOqw5uz+6r3TYxEC3/WZAnMsHcJgisanxfiawmR4OgYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJfIwFHp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718716414; x=1750252414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ox4UVVD8l0UB7uOobj3iQqzlawl6rmOUvrHDfuEAzK8=;
  b=ZJfIwFHpfVA3WB4p4PY6icmtET1ZektfoGA6GWVqg0a6K1HNsEbI0y9F
   eYVZCqdDYMFEW18TAi3+REyWLL1kvOlTcpr42vOL0W1PxmJmp4Tu9qV0J
   dXaZExKrn0A7jgODY+m9/YM8HB3HP9eTI1N67dayGsygvkAiHo5Eq7/hs
   03ZbauUu5+dd7kmrKxpQydORILj7Kj1fl+QbMZKNijxPePd8Dk1w0vJY5
   yN3Q837GCAxxW6RUIamyBlXj4O8jEWzd1RcGE8GBcwkIrIfW7+HCx43TT
   6ucMxnS/g4R9Mp66oI8oIkKCJVOg9zER0VZr0cQAr/jTekqckHwLmPspa
   g==;
X-CSE-ConnectionGUID: Uke46JSuQlKp/rM2gMx/sA==
X-CSE-MsgGUID: z6s58XztRuC6XBpCK9hioQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15560425"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15560425"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 06:13:34 -0700
X-CSE-ConnectionGUID: ic6obKutQPa0TPrENfW5Ig==
X-CSE-MsgGUID: DkvbJ7JXRSivPrGmYZl4bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46668329"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by orviesa004.jf.intel.com with ESMTP; 18 Jun 2024 06:13:32 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [RFC PATCH iwl-next v1 2/4] ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
Date: Tue, 18 Jun 2024 15:12:06 +0200
Message-ID: <20240618131208.6971-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618131208.6971-1-sergey.temerkhanov@intel.com>
References: <20240618131208.6971-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Add ice_get_ctrl_ptp() wrapper to simplify the PTP support code
in the functions that do not use ctrl_pf directly

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 57e1e5a5da4a..a2578bc2af54 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -16,6 +16,18 @@ static const struct ptp_pin_desc ice_pin_desc_e810t[] = {
 	{ "U.FL2", UFL2, PTP_PF_NONE, 2, { 0, } },
 };
 
+static struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
+{
+	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
+}
+
+static struct ice_ptp *ice_get_ctrl_ptp(struct ice_pf *pf)
+{
+	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
+
+	return !ctrl_pf ? NULL : &ctrl_pf->ptp;
+}
+
 /**
  * ice_get_sma_config_e810t
  * @hw: pointer to the hw struct
-- 
2.43.0


