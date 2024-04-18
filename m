Return-Path: <netdev+bounces-89133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA828A981F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE0C1C209F2
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F9215E207;
	Thu, 18 Apr 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9+ZVBXG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53ED15B969
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438230; cv=none; b=PFSbECoSqu5MsjqN9ZEdOAqXKQ6h9S4gwp6N3jLGn1AXlhcnRXXsvL1jho23yxmD2zVY2CkBCo96fse6Z8KhGV5LCSamVh70Ur4GnlzYWKPQivCkU0amnVicqDpAW2cNCNYfcU8qRqlqfsYGTMJI/euRebmQNHyQVLUdPgH7SD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438230; c=relaxed/simple;
	bh=eAVw/Rm28PRAbnn5C8EDuezCyUUUpKWahTorxk/3Nt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nw9pqUDi1fgRZNv9WeXKKv5+ZW863syuXlmHqjEhi/b6Ud9DsN1egUFUvJV9gJqkarLGUzcO4T00b/LGOQQOVQClUa4kYYb5kG1YPM8jyDwwbDoJYz8nIQ5S7R62zkRLGzmAmE9K7ez4NLjt0t7W9gQJ2NgJXxvpiGRsfqNUQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9+ZVBXG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713438227; x=1744974227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eAVw/Rm28PRAbnn5C8EDuezCyUUUpKWahTorxk/3Nt4=;
  b=i9+ZVBXGig7RWEOV9oZbPQa9z55gETR9IEjcCzAxlr3rYyODJf2uZ01b
   atyNvx93LD6Xn3WYqznsHfqsfPpg3pXqpAIkvHX1F6IP53NBhjcs9cA4+
   NImwdp2PzFapikMoZi5yYz7DsK0ZWJyGVhrV0CLj0/msbSzsjZEZky6BH
   fAgNK6grtvTUdLEE3VV88pwrwfx2yYi+DJcN2gHYeR7e3mrkvOsO3mv8O
   st8RZD7uPiH2ldPIfzHZjWHyWMs1VKyEyZq+/MGG0tdkscYMEHG+QsOCd
   XJLj08ilccsw9oF/WH6zV8fvUBQ6+1cKsanwuV+iJub+TBuBKuTZ/N5Ah
   Q==;
X-CSE-ConnectionGUID: zDnUiIpESqiRb1hIg2uP7w==
X-CSE-MsgGUID: Voq8WbBARCW1di1XIqcVrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12763758"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12763758"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:03:46 -0700
X-CSE-ConnectionGUID: rp+MM2n5QnW6wQO2sVPBdw==
X-CSE-MsgGUID: q1Uq+MiOSmiGEPggHSDVwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23021657"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa008.fm.intel.com with ESMTP; 18 Apr 2024 04:03:45 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next] ice: Extend auxbus device naming
Date: Thu, 18 Apr 2024 13:03:18 +0200
Message-Id: <20240418110318.67202-1-sergey.temerkhanov@intel.com>
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
multi-segment configurations

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0f17fc1181d2..54fe1931d598 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2893,6 +2893,7 @@ ice_ptp_auxbus_create_id_table(struct ice_pf *pf, const char *name)
 static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
 {
 	struct auxiliary_driver *aux_driver;
+	struct pci_dev *pdev = pf->pdev;
 	struct ice_ptp *ptp;
 	struct device *dev;
 	char *name;
@@ -2903,8 +2904,9 @@ static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
 	aux_driver = &ptp->ports_owner.aux_driver;
 	INIT_LIST_HEAD(&ptp->ports_owner.ports);
 	mutex_init(&ptp->ports_owner.lock);
-	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
-			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
+	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_%u_clk%u",
+			      pci_domain_nr(pdev->bus), pdev->bus->number,
+			      PCI_SLOT(pdev->devfn),
 			      ice_get_ptp_src_clock_index(&pf->hw));
 	if (!name)
 		return -ENOMEM;
@@ -3106,6 +3108,7 @@ static void ice_ptp_release_auxbus_device(struct device *dev)
 static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
 {
 	struct auxiliary_device *aux_dev;
+	struct pci_dev *pdev = pf->pdev;
 	struct ice_ptp *ptp;
 	struct device *dev;
 	char *name;
@@ -3118,8 +3121,9 @@ static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
 
 	aux_dev = &ptp->port.aux_dev;
 
-	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
-			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
+	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_%u_clk%u",
+			      pci_domain_nr(pdev->bus), pdev->bus->number,
+			      PCI_SLOT(pdev->devfn),
 			      ice_get_ptp_src_clock_index(&pf->hw));
 	if (!name)
 		return -ENOMEM;
-- 
2.35.3


