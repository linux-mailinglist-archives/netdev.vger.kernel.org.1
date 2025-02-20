Return-Path: <netdev+bounces-168170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DF8A3DDFB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187867A9A52
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8706E1FE45B;
	Thu, 20 Feb 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlTxSYij"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0231D5CFB
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063968; cv=none; b=DzzgtVwp7wETxo/5irlVxi5asSoovDUEV7J2wm0j8MgXHZ5pLvWbxONW4XAVgpKlZ+RFeVgqxhM42fntAbIlMg5HRHePozRHsoBLbmMRNFkFtP/KGcdadH26n/hd333iF96+M4tQB8gJBHSkejbWV1gfIFEsTHRmoowaLVl0SO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063968; c=relaxed/simple;
	bh=N8pSyv8OVgoNMKzhCWhIHqDZt2cLj11E5ZpGKsek5sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XyfybjaaMRRmmdzqQ5uyGpoj6fD/owSQv3wvjjb6JbzU0HEg1zzHc9Vkh3QCE4rYuPDlCz79CECeLUmg/yyWXXTwR8mOclhGt8pMt2Om+he6Hr16RwbUbFPCUSIRVcm2/7tedS8JgLXmxM3G4vAKx797txJ83I/D25+Kah0cUKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlTxSYij; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740063967; x=1771599967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N8pSyv8OVgoNMKzhCWhIHqDZt2cLj11E5ZpGKsek5sM=;
  b=TlTxSYijA3kkRvKbzg0v7zlThV0nCp1f19HVYeM91wYdbVaeGGDrVYfq
   3tRWXtcjQg7fz27T8KKZ+cAF1bzu4beLsizAfYgZTlTkz3KnC+h12Lu8o
   ezPpDGPObDpi5LQOUtfng4iNCyrZ3U9+0B+8LeBhLEJDlzBf51oL6vl7G
   anesDiar4ek0VML6EVfYlO2H1pZS6MMNISYkKv0fbizgBXnMnol6eNenE
   xhW7flVsGzSt6ZgQAYkRxLBJMHvyY8JLe2aGaPsx6FdQDpSdxvYcbG4Bk
   7QBb+ewSVOpmRUtGq9cxfk6t1OPiArZYm7gIQcIBaes/MVOkJNC2HbjXQ
   g==;
X-CSE-ConnectionGUID: zcOb2WaFSXqQZ9JjfdwvnA==
X-CSE-MsgGUID: JKM7l7NSRnKEsfPqjO1IVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40966329"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40966329"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:06:07 -0800
X-CSE-ConnectionGUID: GlqfI6puRCq6MSxpErXl4Q==
X-CSE-MsgGUID: pQiNB5hEQuOp/dG/+HOrWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152257748"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa001.jf.intel.com with ESMTP; 20 Feb 2025 07:06:05 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] ice: fix fwlog after driver reinit
Date: Thu, 20 Feb 2025 16:04:40 +0100
Message-ID: <20250220150438.352642-3-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue when firmware logging stops after devlink reload action
driver_reinit or driver reset. Fix it by restoring fw logging when
it was previously registered before these events.
Restoring fw logging in these cases was faultily removed with new
debugfs fw logging implementation.
Failure to init fw logging is not a critical error so it is safely
ignored.

Fixes: 73671c3162c8 ("ice: enable FW logging")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a03e1819e6d5..6d6873003bcb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5151,6 +5151,13 @@ int ice_load(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
+	if (pf->hw.fwlog_cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
+		err = ice_fwlog_register(&pf->hw);
+		if (err)
+			pf->hw.fwlog_cfg.options &=
+				~ICE_FWLOG_OPTION_IS_REGISTERED;
+	}
+
 	vsi = ice_get_main_vsi(pf);
 
 	/* init channel list */
@@ -7701,6 +7708,13 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		goto err_init_ctrlq;
 	}
 
+	if (hw->fwlog_cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED) {
+		err = ice_fwlog_register(hw);
+		if (err)
+			hw->fwlog_cfg.options &=
+				~ICE_FWLOG_OPTION_IS_REGISTERED;
+	}
+
 	/* if DDP was previously loaded successfully */
 	if (!ice_is_safe_mode(pf)) {
 		/* reload the SW DB of filter tables */
-- 
2.47.0


