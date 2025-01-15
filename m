Return-Path: <netdev+bounces-158308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C13CDA115DF
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0713A6C54
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C978BAD24;
	Wed, 15 Jan 2025 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QfP8fWFU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F00620ED
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899736; cv=none; b=m9+IWike3Jo5mpBYrSo477UA2rTKmbdEs3XStlc2CJXsWqHCZ7wtmJ4gMaAtKpTcjumJmhGfH0BUiNnbHezcgzeJ1fzrZO19NGjpHb8YUtGyjoDZjTn8m9nC4hSAlnkiNPSP+RHWg/SFANJGv61wrB+ZK5MlUVvuNhV5TGXGDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899736; c=relaxed/simple;
	bh=H2rjiwuBDH+v++VYQzOQXaoIqU6zYrlDWgNkO9LruCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUBjNWhUklUXEDijubGMdzZgAdJ9X3QA53//u+1ULCbcYoB98+mibjt6mzCeEYd1uq9uQ7KoznVuSz39qaTfjICovDpi/Zfk1AsAAocIZxqq7GOb5EUYwMEdKwOGfC5vdSoSY9UNpnxbFXgyl8wrEfM1vaqZvjC2Q+0mZtChgLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QfP8fWFU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736899734; x=1768435734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H2rjiwuBDH+v++VYQzOQXaoIqU6zYrlDWgNkO9LruCo=;
  b=QfP8fWFUPBeQsF5lYAQVVEX/Urlh+IfIwB8sx61J6L/wT/D6UcXtMGdx
   qw0WGeaefu+qh08qGnhxkvcESMGdFpaKlXdStBVK49b0foJb0qR8vQvMg
   ES4u1Jbk3I+b5HOxrmu/NNKKls+UkQpr7GJJvQ5lHGOBkc3e2a/fnfb06
   1UJasxTxvHxcZ222A5vcCOTTVbM1ITnk+RavYbnu8Rf7299h9Ccrm5NWE
   FvoOqPsCO3QPElO8IpuZwHvoy6kbEk4xO1WEThjgQmsWJ/TTyRiv312XO
   QwND+eHeITRTD/MVNYTH2ULs5oh7Z8dwfs/HCeCKhqqYR7V+CUUX1OEKe
   g==;
X-CSE-ConnectionGUID: pgbrobdCT0yjz1F1NtqeeQ==
X-CSE-MsgGUID: zU3lBsynQuGzuC+PR+j+Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40897464"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40897464"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:08:52 -0800
X-CSE-ConnectionGUID: DLB97dZYSVi5bsj3j27Tyw==
X-CSE-MsgGUID: mRbSAJHdSiGwDYYSaRk62A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128211397"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 16:08:51 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v2 03/13] ice: minor: rename goto labels from err to unroll
Date: Tue, 14 Jan 2025 16:08:29 -0800
Message-ID: <20250115000844.714530-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
References: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Clean up goto labels after previous commit, to conform to single naming
scheme in ice_probe() and ice_init_dev().

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5d7d4a66fbcd..7fd79482116f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4799,7 +4799,7 @@ int ice_init_dev(struct ice_pf *pf)
 	if (err) {
 		dev_err(dev, "ice_init_interrupt_scheme failed: %d\n", err);
 		err = -EIO;
-		goto err_init_interrupt_scheme;
+		goto unroll_pf_init;
 	}
 
 	/* In case of MSIX we are going to setup the misc vector right here
@@ -4810,14 +4810,14 @@ int ice_init_dev(struct ice_pf *pf)
 	err = ice_req_irq_msix_misc(pf);
 	if (err) {
 		dev_err(dev, "setup of misc vector failed: %d\n", err);
-		goto err_req_irq_msix_misc;
+		goto unroll_irq_scheme_init;
 	}
 
 	return 0;
 
-err_req_irq_msix_misc:
+unroll_irq_scheme_init:
 	ice_clear_interrupt_scheme(pf);
-err_init_interrupt_scheme:
+unroll_pf_init:
 	ice_deinit_pf(pf);
 	return err;
 }
@@ -5324,18 +5324,18 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	devl_lock(priv_to_devlink(pf));
 	err = ice_load(pf);
 	if (err)
-		goto err_load;
+		goto unroll_init;
 
 	err = ice_init_devlink(pf);
 	if (err)
-		goto err_init_devlink;
+		goto unroll_load;
 	devl_unlock(priv_to_devlink(pf));
 
 	return 0;
 
-err_init_devlink:
+unroll_load:
 	ice_unload(pf);
-err_load:
+unroll_init:
 	devl_unlock(priv_to_devlink(pf));
 	ice_deinit(pf);
 unroll_hw_init:
-- 
2.47.1


