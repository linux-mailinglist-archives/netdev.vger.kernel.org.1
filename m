Return-Path: <netdev+bounces-201651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F613AEA37E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 18:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70821C44AC6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2257E2ECEA6;
	Thu, 26 Jun 2025 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDygFOC+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2E2EACF5
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955376; cv=none; b=mCIaixKuVxVmmR0PQ3wDa5wmWkjF0bN4XyAXYrKxXqwIZSmtiIfwy1JQPxChVIZMBGbUFfImUn8/kr/Kx5OZccfTOXZlxxMUI7hSxPUP8wA6ujURXRxeREoppMVQF2MgFyqtSy4z1kTRnHJ9ePQnJT2UfZBD/J5rmV98Pgy7mbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955376; c=relaxed/simple;
	bh=TPfetGsOtJYOtqMFUJ8OPMMYxs+Hgztmp2NxI19AW/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3UKZ/XrNtqOpi0oFbguCl1y3nwHNP7OlQOMhCnFgSjHq8Tj6vqgGjave2zHqqur8cXIgMyuBu0zHYEsaERS9ulOM+ZeoOI2sRKDMQ2VFG+6iANPFlXHtRzlJikbUffVHGXFtNygWRdCfjX+SG87QPA6DK5rdOPMUWKcE3wy+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDygFOC+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750955375; x=1782491375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TPfetGsOtJYOtqMFUJ8OPMMYxs+Hgztmp2NxI19AW/Q=;
  b=LDygFOC+c0l+9kYj/eyfnm47hm2OI5fAQGP0J3yN/Szu+Su75YLRvNKK
   83ONPgFlUissA37WBxPzUWA7AEafqxhFBuxfRppi/Il4l9FRZJqCa6j7I
   VTjwMqvmCiNvHhvVDsUvtgHQVhjzaE2Fkuf/yyjbKA2Ah5/mLFsHRZttQ
   CNgQN/R3c/yUHTbrYsZKFze/jwDL1f8GpxfJksUC5qOCWEtVHpZRnXB69
   UZI1Q2/MqDcyfup7CqgHS/bk7STf5ZGAGjymdyKud6r3HwPQQCl040vVS
   AY0XqEMNLgufREgge5ORJBkBfgXB5lVQlJUcS3HNDjUumGJx5pPHrB09i
   g==;
X-CSE-ConnectionGUID: 79Dpr0XbRxaZHvpsXIl+Hw==
X-CSE-MsgGUID: 0u4N91PMTBCo88D1jeUsUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="70830052"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="70830052"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:29:32 -0700
X-CSE-ConnectionGUID: AEV9OMqVQu68weyeQpsKAw==
X-CSE-MsgGUID: +i4q2WuRSLGPWfruo9NAbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="156852524"
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
	Milena Olech <milena.olech@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 6/8] ice: fall back to TCXO on TSPLL lock fail
Date: Thu, 26 Jun 2025 09:29:17 -0700
Message-ID: <20250626162921.1173068-7-anthony.l.nguyen@intel.com>
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

TSPLL can fail when trying to lock to TIME_REF as a clock source, e.g.
when the external clock source is not stable or connected to the board.
To continue operation after failure, try to lock again to internal TCXO
and inform user about this.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index abd9f4ff2f55..886a18b2e65f 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -605,5 +605,17 @@ int ice_tspll_init(struct ice_hw *hw)
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
2.47.1


