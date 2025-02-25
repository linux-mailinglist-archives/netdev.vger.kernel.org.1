Return-Path: <netdev+bounces-169470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31863A44138
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD6D7ADA7E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BBC2698AD;
	Tue, 25 Feb 2025 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMajdOsI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA362638AE
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491089; cv=none; b=Vxzb53WlDJQWQp/e9UUYbSn2Ue9FaV6/1w8/By/y6J5x59kLukkkhqWnBQuuQLSg/LJi8I8ZcrQncAlbsuM1+WXLJZxXt25evh+YH2GnWadgpILB24A/3umOgA6MlgiMqPwx83llNw8zdUhTNhY197RrgjieTzoVake5sNkW/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491089; c=relaxed/simple;
	bh=n+RxzZHRUBGKVEMeXI9IeFSvvMS6jsZYYzWjVTruOos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUAYMIOBSA8T8kiGFsvHc586gyZW05xc3bJGC+32Z952+B529Taot6N6MPyp9lbQZSFdEFo5/lB/XIcUSHtT+lGyZK/8LivvruVW001veTJ66E61fxrLSxJZrdcbQAG9p1Nz7+sspZZLI7fl2P4eUS5wSkzX9VvzWOvU/Ld18e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMajdOsI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740491088; x=1772027088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n+RxzZHRUBGKVEMeXI9IeFSvvMS6jsZYYzWjVTruOos=;
  b=PMajdOsI/kpKm4SJsfK5e9Og1SV9LlvIOYzkUfk50jrLUcaOfBIBSlXk
   0Wzw5BF4tXCJtlFY133iLTO6pTclGsBMWsJ8hoSfPZzEr7YoXVtbvOaYG
   l50l2ouDtrmc7MVH0BW5tcRnIXUn17PVSN56FuUhy7EsMRx4bzM0lNCBA
   tWO1CJFy4spqbO6Wx6VsEbbCk2XMv4kw+wItyN2CPWUCigRMtJAH5uKpi
   6bo+qarptNM9CVjjNc47YE0Fudo5p2+HbQb3MvN07x/N6w0eAUTLeuT77
   tOaLW0jD0dOw4yJJf0Uj2oLw/aEL1xSLNMQKSrUMI8+sntG57h7dwY2Ky
   w==;
X-CSE-ConnectionGUID: FA1/o66jTfeP2SbYLIEFHw==
X-CSE-MsgGUID: eb+jAemjTduzAXIbwzhtpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28885203"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="28885203"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 05:44:47 -0800
X-CSE-ConnectionGUID: dy/9jhOETQSYm/UiQnMMvg==
X-CSE-MsgGUID: GtQsOQzLRMmjt8DajDliNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="121003835"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by fmviesa005.fm.intel.com with ESMTP; 25 Feb 2025 05:44:45 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v2] ice: fix fwlog after driver reinit
Date: Tue, 25 Feb 2025 14:40:10 +0100
Message-ID: <20250225134008.516924-3-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue when firmware logging stops after devlink reload action
driver_reinit or driver reset. After the driver reinits and resumes
operations, it must re-request event notifications from the firmware
as a part of its recofiguration.
Fix it by restoring fw logging when it was previously registered
before these events.

Restoring fw logging in these cases was faultily removed with new
debugfs fw logging implementation.

Failure to init fw logging is not a critical error so it is safely
ignored. Information log in case of failure are handled by
ice_fwlog_register function.

Fixes: 73671c3162c8 ("ice: enable FW logging")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---

v2:
commit message extended, no changes in code

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


