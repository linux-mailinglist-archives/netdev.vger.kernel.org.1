Return-Path: <netdev+bounces-77639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB1287271D
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3E528BFA8
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9774E5C602;
	Tue,  5 Mar 2024 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hG2rvsB+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9A2511E
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665069; cv=none; b=K2v6xVR4u59yk3H9uZ/I3DjSb5RA5IsyLz9UWmrJ0IyZJhxCHKkItdL3/OmvIZ0/J77VxQ4CTOuhIWCL4Qt3hFg4umCEMuX3Bc8ETYzPu19zqpEScy9H2a9XYJUsVdwnQGIWKU8yrst3O6FqgSX7JIFeM632Yy0nOoz1JKSsEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665069; c=relaxed/simple;
	bh=de5Uyw2W6pC2UwMv9ytLLhxrL6czjAJ/sGw9aT1RE44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJGY8zTIY+tKzni3YF4xib9MOtm3u6d8eqxr9+zH/3XnwL4q9lGkGUFqIFrJsiFh9kiYsc19L0w0HYjIQ+Sn/gAvgAS4jipinCopfDMf1XxKO3YfZD+OcX/LeLam9jrf37onM5kfrmrrZO2u8275f3r0HHF8ljV/xH8W3/XqlGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hG2rvsB+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709665068; x=1741201068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=de5Uyw2W6pC2UwMv9ytLLhxrL6czjAJ/sGw9aT1RE44=;
  b=hG2rvsB+ycYkPCyfQyvGbAIqAsIexb3O8oZ94o3qWx95Kg4V8qcFHj3b
   UW0BoDknIqHEaZK+4JAsjiBAExemxVNtR55HYj60RSVlRdvkSPm1s/TYa
   kh+R1JUHVh28vOkBGjMpZfei7o/zkHnrqvZpRq4apwCTdz1idGasLlcUZ
   a6hFp/pPH6kTXjjcKA30EikUl3rScF4TmktQHPh/kHlMfBUdj2grZDVkn
   U8imWV+4lETeXenRoQ9goC5O0rbdR7z/1efyOA6OZK+oX4tnw/jTsJn7p
   GSyZJwF7okDtOa49hKDDN7zCvkBUbJ9+GMWdgGw0c0eTQIFTg15gEETu5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4822216"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4822216"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 10:57:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9337223"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2024 10:57:44 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com
Subject: [PATCH net 6/8] i40e: Fix firmware version comparison function
Date: Tue,  5 Mar 2024 10:57:34 -0800
Message-ID: <20240305185737.3925349-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
References: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Helper i40e_is_fw_ver_eq() compares incorrectly given firmware version
as it returns true when the major version of running firmware is
greater than the given major version that is wrong and results in
failure during getting of DCB configuration where this helper is used.
Fix the check and return true only if the running FW version is exactly
equals to the given version.

Reproducer:
1. Load i40e driver
2. Check dmesg output

[root@host ~]# modprobe i40e
[root@host ~]# dmesg | grep 'i40e.*DCB'
[   74.750642] i40e 0000:02:00.0: Query for DCB configuration failed, err -EIO aq_err I40E_AQ_RC_EINVAL
[   74.759770] i40e 0000:02:00.0: DCB init failed -5, disabled
[   74.966550] i40e 0000:02:00.1: Query for DCB configuration failed, err -EIO aq_err I40E_AQ_RC_EINVAL
[   74.975683] i40e 0000:02:00.1: DCB init failed -5, disabled

Fixes: cf488e13221f ("i40e: Add other helpers to check version of running firmware and AQ API")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_prototype.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index af4269330581..ce1f11b8ad65 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -567,8 +567,7 @@ static inline bool i40e_is_fw_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
  **/
 static inline bool i40e_is_fw_ver_eq(struct i40e_hw *hw, u16 maj, u16 min)
 {
-	return (hw->aq.fw_maj_ver > maj ||
-		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));
+	return (hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min);
 }
 
 #endif /* _I40E_PROTOTYPE_H_ */
-- 
2.41.0


