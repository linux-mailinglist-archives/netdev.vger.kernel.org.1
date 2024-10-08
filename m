Return-Path: <netdev+bounces-133334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F0B995B47
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274A92831DF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096D4217326;
	Tue,  8 Oct 2024 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QR5KKoNH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5858721265D
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428472; cv=none; b=OpeL21AhknLuyQ88dZsfNd6esGTOkv0DyMuYr9j/YQR2KnhUhbpzWgB/AF9WEw7JKWDomTc8zzPVmrNd1s653YyBh4LqJLAmG/urSV71c4WNvTjGhUc+vzRet0vQY6D0dmyheBimx0rjENbE2lJM2aenl8WQ3bZ2Rvb5aJphQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428472; c=relaxed/simple;
	bh=MxJXCxTKXAjqP+xHbBRY5zuTrUgWf7qq2Y7UuuWGOS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZWd3euNuCDuNB3wU/zLgSgbqcKdE4cVjFtJYGsoshXmE4xhmDPaAfvn4EE2WfSVOUY5s5L27nH3QGbuztMC96uO4Sit3V+AVIWr2RF5QCM5KdVZDfqlB8DouryuP7jrhaDlc4FWjeCUg2MIk31k8Kmpo14GZ7264wh7Y3+/Gps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QR5KKoNH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728428471; x=1759964471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MxJXCxTKXAjqP+xHbBRY5zuTrUgWf7qq2Y7UuuWGOS0=;
  b=QR5KKoNH4JkflMAz5ix3vnSMddQNM3IBY0pqjRB5rzN5nrnyVmOyStA4
   kJ5uE0IMGTMYDl/WImXMV/oI6RPZ0rZDauWPqvbwyTQBsbVvEssPIyba1
   ZPcnmchTVKQGrU6FyR3CS8Wf6eWepnHIDutVBrMXekI3mjKKdnkoNBBn8
   eg3t4lfY6dGQrNzDlm5i1U/RG5fv5Y9+6PGbZDgzLGqI5+Zh6ZU4JotOK
   VXVFnoX4eOHoUmw0oRzRCfUq0u3own4aWS4uj3f0i22tohcwc672oriIy
   S/bgoG+4NHaCqh+3TkiekGPyv5g1/mitSWH4q5k6HF4QkoLV+6VA82knI
   w==;
X-CSE-ConnectionGUID: hkG/Kru0SCyYUvAm1LMx5Q==
X-CSE-MsgGUID: L4w/30nyQOm37zuAMbZQog==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="15302402"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="15302402"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:01:09 -0700
X-CSE-ConnectionGUID: IQgS+pKwSgywb25C3UVHuQ==
X-CSE-MsgGUID: YkbO4pVIRy657bO8SEqoIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106787572"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:01:03 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	mateusz.polchlopek@intel.com,
	maciej.fijalkowski@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 1/7] ice: Fix entering Safe Mode
Date: Tue,  8 Oct 2024 16:00:39 -0700
Message-ID: <20241008230050.928245-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
References: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

If DDP package is missing or corrupted, the driver should enter Safe Mode.
Instead, an error is returned and probe fails.

To fix this, don't exit init if ice_init_ddp_config() returns an error.

Repro:
* Remove or rename DDP package (/lib/firmware/intel/ice/ddp/ice.pkg)
* Load ice

Fixes: cc5776fe1832 ("ice: Enable switching default Tx scheduler topology")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index fbab72fab79c..da1352dc26af 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4767,14 +4767,12 @@ int ice_init_dev(struct ice_pf *pf)
 	ice_init_feature_support(pf);
 
 	err = ice_init_ddp_config(hw, pf);
-	if (err)
-		return err;
 
 	/* if ice_init_ddp_config fails, ICE_FLAG_ADV_FEATURES bit won't be
 	 * set in pf->state, which will cause ice_is_safe_mode to return
 	 * true
 	 */
-	if (ice_is_safe_mode(pf)) {
+	if (err || ice_is_safe_mode(pf)) {
 		/* we already got function/device capabilities but these don't
 		 * reflect what the driver needs to do in safe mode. Instead of
 		 * adding conditional logic everywhere to ignore these
-- 
2.42.0


