Return-Path: <netdev+bounces-90409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D0B8AE0D0
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D2C1C217E5
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 09:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89945730D;
	Tue, 23 Apr 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRuU7baC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9221345
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863734; cv=none; b=d0FCzsDYj5MhXgTiIZ1a6Mf3c6XFDI70BMA7JGz9ClAhiUkyQEm741MFKrIWSY14k8PbmrV0WbjfTvzV9osxod+4dsPZs16s9pLLJc7eln/gvqNHsPOsTRZOtcR3TDh4QUz4Is7xOG03tGQIyKed/EBDsep/Qn3kOYEXG02hQR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863734; c=relaxed/simple;
	bh=zENXedFIh6Tmz/JHiVkv82LEMexdoV9DEhKBzO9s4ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqguUzHxf/wBkTMBQS+9EEtO0B28/Nh7P5pLKBC0szC2lYY8MUaA42Zsseyrx6BAEXeaGrFNFfwVuxsW4Km8I1oW5TSZvEBeQlmUE9KLZnO0RNckFV+Sn/baZ9qfjonA9lO13Gjofn0VmLQgGZArjuvjVURklLOWiNpL1GhD4Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRuU7baC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713863733; x=1745399733;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zENXedFIh6Tmz/JHiVkv82LEMexdoV9DEhKBzO9s4ec=;
  b=GRuU7baCWX2IQK7XXXU5ynx7oQTIjmnKF8cOY/fWESS0FdyOrJmWwKzh
   IALpwbzOeOPmfW7BdTk3K2oN19higotSR//alAxskjY3rusgnEfsQYi+E
   5FGA1HmDV4yFHpw3kpHS/2t+eO5yCx4DZmzZVYb9wC+nsJm5h5LouIC5O
   p2CN57ll+7WkzWs80jPvrz4z2P/tRXhm619C/tI0fWIrEFL+NDdphvK35
   RJVcI/VLy65gKoAg8R0+Eep6GbuVjkJq1X4WmI7bLnzSGsM5eG/3XOrcq
   aFpQwnfdnxA6Aax8T0sOh8dpp6XZimHo3GUndbYRpipZd4bFETNVYmeCk
   A==;
X-CSE-ConnectionGUID: Sr1OSpeFSnGc2Q+2N81G1A==
X-CSE-MsgGUID: VEh8ydFcRoKjmFXgvVruXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="34835649"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34835649"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 02:15:32 -0700
X-CSE-ConnectionGUID: Zm4+HrTHTLuxjd73darihQ==
X-CSE-MsgGUID: jWLiRbgcSTWRGEWq3jT6kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28811170"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa003.fm.intel.com with ESMTP; 23 Apr 2024 02:15:31 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v2] ice: Extend auxbus device naming
Date: Tue, 23 Apr 2024 11:14:59 +0200
Message-Id: <20240423091459.72216-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Include segment/domain number in the device name to distinguish
between PCI devices located on different root complexes in
multi-segment configurations. Naming is changed from
ptp_<bus>_<slot>_clk<clock>  to ptp_<domain>_<bus>_<slot>_clk<clock>

v1->v2
Rebase on top of the latest changes

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 402436b72322..744b102f7636 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2993,8 +2993,9 @@ ice_ptp_auxbus_create_id_table(struct ice_pf *pf, const char *name)
 static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
 {
 	struct auxiliary_driver *aux_driver;
+	struct pci_dev *pdev = pf->pdev;
 	struct ice_ptp *ptp;
-	char busdev[8] = {};
+	char busdev[16] = {};
 	struct device *dev;
 	char *name;
 	int err;
@@ -3005,8 +3006,10 @@ static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
 	INIT_LIST_HEAD(&ptp->ports_owner.ports);
 	mutex_init(&ptp->ports_owner.lock);
 	if (ice_is_e810(&pf->hw))
-		sprintf(busdev, "%u_%u_", pf->pdev->bus->number,
-			PCI_SLOT(pf->pdev->devfn));
+		snprintf(busdev, sizeof(busdev), "%u_%u_%u_",
+			 pci_domain_nr(pdev->bus),
+			 pdev->bus->number,
+			 PCI_SLOT(pdev->devfn));
 	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_%sclk%u", busdev,
 			      ice_get_ptp_src_clock_index(&pf->hw));
 	if (!name)
@@ -3210,8 +3213,9 @@ static void ice_ptp_release_auxbus_device(struct device *dev)
 static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
 {
 	struct auxiliary_device *aux_dev;
+	struct pci_dev *pdev = pf->pdev;
 	struct ice_ptp *ptp;
-	char busdev[8] = {};
+	char busdev[16] = {};
 	struct device *dev;
 	char *name;
 	int err;
@@ -3224,8 +3228,10 @@ static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
 	aux_dev = &ptp->port.aux_dev;
 
 	if (ice_is_e810(&pf->hw))
-		sprintf(busdev, "%u_%u_", pf->pdev->bus->number,
-			PCI_SLOT(pf->pdev->devfn));
+		snprintf(busdev, sizeof(busdev), "%u_%u_%u_",
+			 pci_domain_nr(pdev->bus),
+			 pdev->bus->number,
+			 PCI_SLOT(pdev->devfn));
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_%sclk%u", busdev,
 			      ice_get_ptp_src_clock_index(&pf->hw));
-- 
2.35.3


