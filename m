Return-Path: <netdev+bounces-201649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A5BAEA37C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 18:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5204D1C44C7A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEADD2EACFE;
	Thu, 26 Jun 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EfEA3tOv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3E624DD13
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955374; cv=none; b=SX6uXL1PjKgZOgkdaLZgha8JztOu6eoXf743AHGemmZYIOnVXiZ35pXlzxdRZc/tN7e/ccmY/NZFp/nLtN/8iyk0Zkzng5hKNMe7gtALn9GKXoSkjhmD079jNqL+aYiSK+O8pAZwJjr0Se7jlxFRVU2qCgDq2OWaS3nYgU88Kxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955374; c=relaxed/simple;
	bh=dX3OVeaF1QMZ38rqKtxVoK/KZ91b89zavrNItqBrFO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blrCuh20snG9H/XPm3/JngAmXReOE/p9ALV/YIWQIWZPPL5Q0xEt9gaGh2jMiYkeOVqLJeGz60GU1YUYhM1j8ULmv5itTSBSEho/KIgdSwfFRMeNd3PCTLtm/fStgUaQFtSd34GOXVqlpV/+hLiy/XDn3TkrZD6gLQ1I2rjNXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EfEA3tOv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750955373; x=1782491373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dX3OVeaF1QMZ38rqKtxVoK/KZ91b89zavrNItqBrFO0=;
  b=EfEA3tOvdgnL7UdKvSO9E6hSF3ziRxxBRpil6OkAQZBn7IcaiS8mZMS3
   B19+nqQ7R3jnEqNK4a+U8EQ7+Q2QmnNwTWNIvx7Xd/veenk6rGeAsEgv6
   nAFl2CbvkJCy/oArTS2sYb6aEzrCZIQi+j9GZEJfzf1TfpFQV9CTN11Td
   ZbBRtUW/Tpx0zmzt+JZprQwCyx5G51daf5rxs8ZfG7jMZOJ3PMUjEtbtn
   433cXAePWQotZTkJJ/Tiei+U6qXXtPS3/eaHe0hth3QHWwzE7JnWd9tsl
   KK6fng+clpncS84vzVOQD6/Bogl/TrLmO0QWb1lIsHq89tHTTHXKJrYGr
   Q==;
X-CSE-ConnectionGUID: NEEJwdiNTXqaV1KWuvyHCQ==
X-CSE-MsgGUID: 6B8JnV4hQtGPQVcPFcrQIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="70830035"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="70830035"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:29:31 -0700
X-CSE-ConnectionGUID: H/ZlWHCFT4e471Uo+gIYrw==
X-CSE-MsgGUID: U2n0iZvtTvSmgGgIU5MMpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="156852488"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 26 Jun 2025 09:29:31 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH net-next 5/8] ice: wait before enabling TSPLL
Date: Thu, 26 Jun 2025 09:29:16 -0700
Message-ID: <20250626162921.1173068-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250626162921.1173068-1-anthony.l.nguyen@intel.com>
References: <20250626162921.1173068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

To ensure proper operation, wait for 10 to 20 microseconds before
enabling TSPLL.

Adjust wait time after enabling TSPLL from 1-5 ms to 1-2 ms.

Those values are empirical and tested on multiple HW configurations.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index e7b44e703d7c..abd9f4ff2f55 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -261,6 +261,9 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
+	/* Wait to ensure everything is stable */
+	usleep_range(10, 20);
+
 	/* Finally, enable the PLL */
 	r24 |= ICE_CGU_R23_R24_TSPLL_ENABLE;
 
@@ -268,8 +271,8 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	/* Wait to verify if the PLL locks */
-	usleep_range(1000, 5000);
+	/* Wait at least 1 ms to verify if the PLL locks */
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
 
 	err = ice_read_cgu_reg(hw, ICE_CGU_RO_BWM_LF, &val);
 	if (err)
@@ -445,6 +448,9 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
+	/* Wait to ensure everything is stable */
+	usleep_range(10, 20);
+
 	/* Finally, enable the PLL */
 	r23 |= ICE_CGU_R23_R24_TSPLL_ENABLE;
 
@@ -452,8 +458,8 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	/* Wait to verify if the PLL locks */
-	usleep_range(1000, 5000);
+	/* Wait at least 1 ms to verify if the PLL locks */
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
 
 	err = ice_read_cgu_reg(hw, ICE_CGU_RO_LOCK, &val);
 	if (err)
-- 
2.47.1


