Return-Path: <netdev+bounces-201646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C24AFAEA377
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65891C448B7
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6319213E74;
	Thu, 26 Jun 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2MUjmbs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DCB211484
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955372; cv=none; b=oGFANynU71y746f+sVjXKj8r+DnDFL/B//U5bmHW9BsBXUPGQRUmjliXwwCvBhSgs96qGBwiktad9aZ+aUDxYpWsrdjafvP2gJl4qW4x3I72dO2K5ZYWcdkOsveTbndRXFP7h3MTsQ//aOUce3Ta4Ndu0oUcCUbXzBDzot2q0jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955372; c=relaxed/simple;
	bh=LBWfUsAGByKQ5Wyas9ngPGt6BQjMoKf689WDvDDHPI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0zqc1p/TBr/CW+c4MC2gmbMlXb1UDUXOhAsWhyoGeg3XyTDYc7DONOOYkDQd2IQo6LqXjSzbkxdIXi32fQS+JUgoV3dLa6C4UXN6dCAbisDvpBd9np3qrlxIuN5oxcjsUVtp6G9Guh5WPTyMFWSR/TOBriZUPW3ccURiLUhkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2MUjmbs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750955371; x=1782491371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBWfUsAGByKQ5Wyas9ngPGt6BQjMoKf689WDvDDHPI0=;
  b=j2MUjmbs6G8LnfmRFVGAzuKSIXqzCe8nEYiWqFEbILi3EZqYOn0c6vYH
   6/JK0npYkzKW8yJinzaV289GEjOC22JpPXTyTPViRKp1xBcK6KSO/WtMx
   STKNHFYs+ByeHXYmhkeBVYeR1SdJNqPrku8DRLA7gQZZNojNc7UVp/fmZ
   8/yoYp3J0mvcn5UV703g4odXz9q1jkyOKo/Pw6DI9dCvq5vhPXPpxhYG6
   1jZfwbfWSomeGAPUOesMU+6KgYDtmrUUNTd31T1Uuu41kqzCHRbupKNfE
   9T0V1EIaHtA+b1A1LYHdKMsVCghXU+7ZudBVlkrEiCC2vRPbqu4c4gLgW
   A==;
X-CSE-ConnectionGUID: 88UlUJABT/KmBCgCq1MlEA==
X-CSE-MsgGUID: CA7/WbCtT9OLxzEX/UyPOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="70830004"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="70830004"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:29:30 -0700
X-CSE-ConnectionGUID: LAIAikBfSNScQAFOUQbF0Q==
X-CSE-MsgGUID: j/+Bae3CTJ+rPpWfGj2iVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="156852473"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 26 Jun 2025 09:29:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	karol.kolacinski@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com
Subject: [PATCH net-next 1/8] ice: clear time_sync_en field for E825-C during reprogramming
Date: Thu, 26 Jun 2025 09:29:12 -0700
Message-ID: <20250626162921.1173068-2-anthony.l.nguyen@intel.com>
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

From: Jacob Keller <jacob.e.keller@intel.com>

When programming the Clock Generation Unit for E285-C hardware, we need
to clear the time_sync_en bit of the DWORD 9 before we set the
frequency.

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 08af4ced50eb..e2f07d60fcdc 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -342,6 +342,14 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 			return err;
 	}
 
+	if (dw9.time_sync_en) {
+		dw9.time_sync_en = 0;
+
+		err = ice_write_cgu_reg(hw, ICE_CGU_R9, dw9.val);
+		if (err)
+			return err;
+	}
+
 	/* Set the frequency */
 	dw9.time_ref_freq_sel = clk_freq;
 
@@ -353,6 +361,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		dw9.time_ref_en = 1;
 		dw9.clk_eref0_en = 0;
 	}
+	dw9.time_sync_en = 1;
 	err = ice_write_cgu_reg(hw, ICE_CGU_R9, dw9.val);
 	if (err)
 		return err;
-- 
2.47.1


