Return-Path: <netdev+bounces-173484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F179A59279
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F743A4DD2
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7F2229B1C;
	Mon, 10 Mar 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1VvHwXd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE72229B23
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605270; cv=none; b=kxm3be2eS4GU7fKnpRL1cB9/Br266z0G9PnyfDnNzw1Vrub2RFaj3Fxt5UbtcV5unhQPW+QUcM5l5sjuJhw5Q3BURHm30YCvaTan74LMtExsuSr6/WrHSD827o4jptMR0Ya2M6in7dK8IJue8YjtXmktAIHBaa1nmgXVaD+2fHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605270; c=relaxed/simple;
	bh=5lCAtdB9hJ5Uh5qbsi4JkKe3aHncd9dTlRcYSJ5GQEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8TRfHzmq5zQT6fzrF2RnWgSkiIqOnpeqeCs5+HvvxwEntDoGjSx9jiUPwnJEYpsiv4amw98yb9V3Zdjh2rFc65uL0xyuoPoyzCig8yk4fcFvWldjysJJrqBJXDRyiqJ0avmkq/lVrZ6UikO7OzTIuBS8i7vDep9bJ+ntWJxDrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1VvHwXd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741605269; x=1773141269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5lCAtdB9hJ5Uh5qbsi4JkKe3aHncd9dTlRcYSJ5GQEc=;
  b=N1VvHwXdEX4cAUGDF5RuTSoDU7+YVOgFaEAjQssjtpwjdwheylNExS95
   61q29RKQGrJaBBMJWkWNNR508E5K+J50RE331gWRhM1dNkthjy/4/TdLB
   iy98RNvzpQWYKb0OJU6dkQLb2BI3/2QJ8Jq0NJ2AGkSsC7TMExHGcx/Sd
   83kIU7ozPdhmmcYBBqVWYikp6A7vzPLXrCOqDCQh0QwYCuR4iUraql/QA
   4gJR3HG5WQjCHW5UDY6UPXofSduI2eP1iptvXv6lA/pyG1zvVeqCJ+Euu
   2r1G0RrMwj2y4sLsjwzp7kk7xLiyxtgpSFxJ+XBpaMoms0+fPTovBFqup
   g==;
X-CSE-ConnectionGUID: nJxK1KBCT2af1cdnp3cs9w==
X-CSE-MsgGUID: PL+J85qqSRqqFdaHGoHoEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="65048707"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="65048707"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 04:14:28 -0700
X-CSE-ConnectionGUID: AZZEvCm0TVWa+sOkaneutQ==
X-CSE-MsgGUID: IGw2DvFYR4+sBBsiFzdJvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119968336"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2025 04:14:27 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena-olech@intel.com>
Subject: [PATCH iwl-next 09/10] ice: fall back to TCXO on TSPLL lock fail
Date: Mon, 10 Mar 2025 12:12:53 +0100
Message-ID: <20250310111357.1238454-21-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310111357.1238454-12-karol.kolacinski@intel.com>
References: <20250310111357.1238454-12-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TSPLL can fail when trying to lock to TIME_REF as a clock source, e.g.
when the external clock source is not stable or connected to the board.
To continue operation after failure, try to lock again to internal TCXO
and inform user about this.

Reviewed-by: Milena Olech <milena-olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 62da095d32ef..37fcfdd5e032 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -487,5 +487,17 @@ int ice_tspll_init(struct ice_hw *hw)
 	/* Configure the TSPLL using the parameters from the function
 	 * capabilities.
 	 */
-	return ice_tspll_cfg(hw, tspll_freq, clk_src);
+	err = ice_tspll_cfg(hw, tspll_freq, clk_src);
+	if (err) {
+		dev_warn(ice_hw_to_dev(hw), "Failed to lock TSPLL to predefined frequency. Retrying with fallback frequency.\n");
+
+		/* Try to lock to internal TCXO as a fallback. */
+		tspll_freq = ice_tspll_default_freq(hw->mac_type);
+		clk_src = ICE_CLK_SRC_TCXO;
+		err = ice_tspll_cfg(hw, tspll_freq, clk_src);
+		if (err)
+			dev_warn(ice_hw_to_dev(hw), "Failed to lock TSPLL to fallback frequency.\n");
+	}
+
+	return err;
 }
-- 
2.48.1


