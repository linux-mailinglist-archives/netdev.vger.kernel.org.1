Return-Path: <netdev+bounces-187325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DEEAA6685
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC0F9A84E3
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D75269811;
	Thu,  1 May 2025 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjGMDxI3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8752676C2
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140079; cv=none; b=MoKXJJc+a4zkHaU42rWrUxexdpukebnhivnAwCucVkKepW43O+rqPS03vrD1JGBSxoLOnvvmSxE2ErQHa02qow7ISUEPZcF1OaBwzluSlQxZEZIjAKkHirWvFXWvYzcWPYtfgwcy8SyQqlSWEKWUvphkFLiybtZQwzKyjQRAZpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140079; c=relaxed/simple;
	bh=i6yz9gUqfNMOsLuVXEHqI35HTlMqcDcrJcOqHz69YgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aR5n7hBJU0fXCeAAdUWSTyMl0ilu1qkwQcFENk8bZzezU+oFFZ4nrPgqS6czkrPdv82UnzcIODmcmJUde2TU5QfgS1BEgcIEBye+tT7C+c4glVAA27Akvj9pKkKAdPO6JMGXS30bzeKjJkGvS3tGbHBgC3QnCre1WQ6MelSNLcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjGMDxI3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746140079; x=1777676079;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=i6yz9gUqfNMOsLuVXEHqI35HTlMqcDcrJcOqHz69YgQ=;
  b=QjGMDxI37CHew25RakAt/1GjzH0/fBDt6o+EVhM9/DR2YaaDpfv/VJz3
   RpskITpcZcLLk6QFiu3YtYlTd8ZVllFImMGAB6iqiKnfjwDTrHCKFBtmg
   TK1CXrWE1wq4KpJuF9U2hQXDgRlg3v9GxnhSQA8YuoiUUs/Zt+wsUVAg2
   KX16KuMktZDSxkMDkMd87SiyNBcXS0MLiP0eN+dqsq3/UUkwpFBmapgGJ
   CsdZWfENay/9LwTOIISvSVlS8OUi/m3FZ17qVIHitByRvReY8rS5lYmQ3
   sqY5LMTAk1NDhuHsMkKLzFzpoMCL8pMjL9qWrntgheKtxfiZbFjrEuWxM
   A==;
X-CSE-ConnectionGUID: 9ch1VPK/S92IgXzCrbzDSg==
X-CSE-MsgGUID: BkrO0CeeSYaUaDBhOh0wBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58811730"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="58811730"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:35 -0700
X-CSE-ConnectionGUID: XOZrdu4/SbKb7PyJMwEjbA==
X-CSE-MsgGUID: 4GZuejl/Rf+Pk4WTcNSU4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="138514294"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:34 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 01 May 2025 15:54:19 -0700
Subject: [PATCH v4 08/15] ice: clear time_sync_en field for E825-C during
 reprogramming
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-kk-tspll-improvements-alignment-v4-8-24c83d0ce7a8@intel.com>
References: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
In-Reply-To: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Milena Olech <milena.olech@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.14.2

When programming the Clock Generation Unit for E285-C hardware, we need
to clear the time_sync_en bit of the DWORD 9 before we set the
frequency.

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 2cc728c2b67897940af75cb0bc3bfaf5fd8e6869..8de1ad1da8346d4be4224b923de3baeffc954198 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -285,6 +285,11 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, dw23.val);
 	}
 
+	if (dw9.time_sync_en) {
+		dw9.time_sync_en = 0;
+		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, dw9.val);
+	}
+
 	/* Set the frequency */
 	dw9.time_ref_freq_sel = clk_freq;
 
@@ -296,6 +301,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		dw9.time_ref_en = 1;
 		dw9.clk_eref0_en = 0;
 	}
+	dw9.time_sync_en = 1;
 	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, dw9.val);
 
 	/* Choose the referenced frequency */

-- 
2.48.1.397.gec9d649cc640


