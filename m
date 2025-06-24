Return-Path: <netdev+bounces-200566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2B0AE61CD
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD0F1B624C3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E0727C17E;
	Tue, 24 Jun 2025 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALUc5ILB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAA24500A
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750759656; cv=none; b=Au2Yv1PRKEmmap/9Kvcl8Z1L0ua2pM7fVMSmvtAL8uZHkUKvKNIHjjY2rWWxThL+pAH5o9jeVRiYK9HW2VhqwurboJBo7o3Z5BdczrC+YZf8mjTf+9vglM+YBjD0nGE9v7qNDWMExz1GYclKsmlRpvc3lcM8h8TQm2M25FdxoQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750759656; c=relaxed/simple;
	bh=xefSx1wRgI7n8DHq6ASFIeX2Mwzkl89ly+dTVL1gfnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUzaB8f6il2DKxqhm0eJFeh9bDNMup1AB7rZ8V62c2tYjN/FnfyK2LgTRKLqOiz8alIi0QqnY25uraR3xu/JwZkn+WmAjH6cifRfPqXurzaTOFlQaD7etuk58AZrA7uSymWgqb4gpgv1yoss4ADjCpuePSJ93XMw7wol4y5Wi0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALUc5ILB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750759655; x=1782295655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xefSx1wRgI7n8DHq6ASFIeX2Mwzkl89ly+dTVL1gfnY=;
  b=ALUc5ILBHbVqCZLyUiopqTvv/r00LecqoTp4iw0IOdIs1jdfJv2ohI0G
   UU8VULF5+YHa1QHBGKGosVNMHqdiYZ2vaBU3Trb6ZVBTa6roy/78tsdaW
   FCYhJInA/A/bVTouC3UncVEL8TKi+ZcHzDZT6QotofsYVGisDpsQppmKe
   9jFCGkbpcFRlsubU5f/bsCa4tJMS4brZkg/1vRJARG0DyMeEA6NcyIaK3
   5DCgkjmWa0ZGteUzeVLrNTpfBuVm3kr7SXKCKfKvFMSHouSc63Wkt1egY
   oAxREGgMR3qNKlCfdhm17VUU7Bha1UJ5lv1XjLyuORTvd5XcbSlTRMhpk
   A==;
X-CSE-ConnectionGUID: y/UfwhXiSEWZ8cNCx/wJlg==
X-CSE-MsgGUID: C4hZ85fQQTaoEhIM+YwI9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="64053073"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="64053073"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 03:07:34 -0700
X-CSE-ConnectionGUID: L2Yz06IJTGGtZIT8D9jOFw==
X-CSE-MsgGUID: s/+iqz9kRF+jDpXSSPVQoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152400221"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa008.fm.intel.com with ESMTP; 24 Jun 2025 03:07:33 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-net v1] ice: check correct pointer in fwlog debugfs
Date: Tue, 24 Jun 2025 11:26:36 +0200
Message-ID: <20250624092636.798390-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pf->ice_debugfs_pf_fwlog should be check for an error here.

Fixes: 96a9a9341cda ("ice: configure FW logging")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 9fc0fd95a13d..cb71eca6a85b 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -606,7 +606,7 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 
 	pf->ice_debugfs_pf_fwlog = debugfs_create_dir("fwlog",
 						      pf->ice_debugfs_pf);
-	if (IS_ERR(pf->ice_debugfs_pf))
+	if (IS_ERR(pf->ice_debugfs_pf_fwlog))
 		goto err_create_module_files;
 
 	fw_modules_dir = debugfs_create_dir("modules",
-- 
2.49.0


