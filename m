Return-Path: <netdev+bounces-106828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FFD917D35
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876A01F21999
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F65F176AC6;
	Wed, 26 Jun 2024 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajfh2Ky9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A3176AAA
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396269; cv=none; b=T2uqMluLwSh3YGkiLB/dKyPOn9ImYivTAguXV2VBO2Aa9lMH41t3Fa/vttWLwvXJjokPOtkHNvfqjqMxLCcNYpDiDfNsGcv8Uq5yiszGeEwFMRmHuOADX5KpTQF8B8hEaBqY37j3GP147gCv/8HXWqxzsjN/Bwjn7aJMguy2D6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396269; c=relaxed/simple;
	bh=Kgm79J/9HIpSamxDHxgb0s+EnshfsoIo4vFa62yHGAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9xwEMqKEuEIcvN6gVqC6ej4qM8rf+RkfHFE5laNwA4ZvhHI8yGXAYxWaxoWgZprwXhCHxkdIJeL+GIdRo/lfZ3cOx2HFtccMVTXXTnNKtl7NCQZ8bvI0mwtM/QjAQQXscgfEqRRM2D1Z3NGY5TJ9SVhuwCKxLqglkISuE2N9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajfh2Ky9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719396267; x=1750932267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kgm79J/9HIpSamxDHxgb0s+EnshfsoIo4vFa62yHGAE=;
  b=ajfh2Ky9Y9c64/YiW79wr9ufGrxvY7+U6zBsA8jCxJnOKd9PNCXXNG9a
   YqBz9klOcK44BDNjFkZ35dTI0jpGRpiB4qr/qtuk3buGuhItBss74WyEg
   xqPhU6Ij+wXTq9NkIxZrqNdVdidD6MaCGrxSkScwl5eeZL3AGWhPNyRtA
   /8VRZ2+Qwi4HMK3k9wsu/TPqL3N9wtLuUWIgbXITxSdYJqYzz943Yn8z1
   fzRDj9MKNCWsDpkYI4NMIgcrLJGP/5OwRorJbV0kGaQzocZHUvlhEZ7v3
   2mZ94ygcbak3a6pn4PCSVhNB+MrMudfeNLz6F56OFEATaLsFsDfUqOxn5
   Q==;
X-CSE-ConnectionGUID: j5ExDgBOSpqqF44Urat03g==
X-CSE-MsgGUID: +cLp55UTSkKUID0ybAr4qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27145094"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="27145094"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:04:27 -0700
X-CSE-ConnectionGUID: agQ8X6tATRyyh+VrC/oC+w==
X-CSE-MsgGUID: lDsXIbISSlGJzlKWn4qpKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="67162098"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jun 2024 03:04:26 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v1 2/4] ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
Date: Wed, 26 Jun 2024 12:03:05 +0200
Message-ID: <20240626100307.64365-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626100307.64365-1-sergey.temerkhanov@intel.com>
References: <20240626100307.64365-1-sergey.temerkhanov@intel.com>
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
index 2f32dcd42581..8f9a449a851c 100644
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


