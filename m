Return-Path: <netdev+bounces-131192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259A998D28A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570091C219D8
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD3D200111;
	Wed,  2 Oct 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIFjAOE2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946A81EC012
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870002; cv=none; b=kMIydAsdD8JFD/vQQ4wB75JHT3csx5AKiddjlsf+Zl2J+T3F2Cq+IC7lZy9aWTGaQWNLZa/3b+C44LbqZUsSbcaB/SYEN1HC380fiUR4IdC1kEzVV8c61E7ajE9uuwFfaFyEFtWiuJ5yzUIglPZS+jS4URx2teMDArTYMLovx9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870002; c=relaxed/simple;
	bh=Q1yTIsduVqIOGDDgsfBNfMeoNAlnl+VRtH7v9641Hd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgvX0mZUm5ET65z1vxQmz3pitpzPUANlQGJzd8KSqogfqIqhewHRk8f6hyPDEgxiTkoHBJx51T6wnmqZgE14hwocSMm0rYAaTTVxPeYldz2AjPo0EWtwxW+UinkSgRObT3ZqO+PJAHi7p88TUgOhGJ3GPC+bhJ6kiEbQJiuAVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIFjAOE2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727870001; x=1759406001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q1yTIsduVqIOGDDgsfBNfMeoNAlnl+VRtH7v9641Hd0=;
  b=mIFjAOE2V8+dZZf5LOK+vI8jL3p6srvWoGsFTSd+VrB4taxB1lbHZMLn
   wtcMgaAnCeRKcOEEyl0Bw71dhbP7Q0+bgUpR/Oc8BaP727YhpqS1Za2vM
   0CJA58o3jOp7dZKlSs6HrTszeEhJFsPpKD2ZW/MQ8hox8GqtpsjLoQulX
   WPxW9XtK53uGd1/NQACHRdSFd8Xn4e+3U/G/cBhIS2v7+xRa4y6o3EwAb
   RJUzeZ48dncdEY3mNUuR89nRms3lUfXtsxR5+93q3DOEbYkJkGfRgqmNk
   h0slWvcORW0nFKUa+yz50VIiblURxzta65Kfitqk8AaF1/OmyN5vlAnfc
   A==;
X-CSE-ConnectionGUID: gDWN6zktT6eO5j5Iiy8D+w==
X-CSE-MsgGUID: NMMmLG2gQr61YiASb23d5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27183848"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="27183848"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 04:53:20 -0700
X-CSE-ConnectionGUID: bvAv0O+2QdGaGgneUFgp5g==
X-CSE-MsgGUID: eses7engRIu4gk5Hvao7yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="78396378"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 02 Oct 2024 04:53:19 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.246.21])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id ADDB428169;
	Wed,  2 Oct 2024 12:53:17 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next 3/4] ice: minor: rename goto labels from err to unroll
Date: Wed,  2 Oct 2024 13:50:23 +0200
Message-ID: <20241002115304.15127-9-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002115304.15127-6-przemyslaw.kitszel@intel.com>
References: <20241002115304.15127-6-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up goto labels after previous commit, to conform to single naming
scheme in ice_probe() and ice_init_dev().

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f0903dddcb16..a043deccf038 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4797,7 +4797,7 @@ int ice_init_dev(struct ice_pf *pf)
 	if (err) {
 		dev_err(dev, "ice_init_interrupt_scheme failed: %d\n", err);
 		err = -EIO;
-		goto err_init_interrupt_scheme;
+		goto unroll_pf_init;
 	}
 
 	/* In case of MSIX we are going to setup the misc vector right here
@@ -4808,14 +4808,14 @@ int ice_init_dev(struct ice_pf *pf)
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
@@ -5320,18 +5320,18 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
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
2.46.0


