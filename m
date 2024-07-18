Return-Path: <netdev+bounces-112055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63022934C0B
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBCA1C21B67
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AEB132132;
	Thu, 18 Jul 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRnRuLqE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC0012D1FA
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300076; cv=none; b=tbOGd7DmDAY/xZH9ZNdmZ/eMMV2jUtmYVnUz3nP+OYfQL2OMIfHGw3zDLm/pfZSWNWBmYvmwW3E5lLKzRVU1bCKjOANeya/4iZbbvRiPZ4k1LTJi3m7gAZcPc7DcKbAkTSyVdDN8tKpcP1r7zC9Gof+9PcPNw+hDJyhLXS2YKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300076; c=relaxed/simple;
	bh=3OhgHRh8nxAMjEaek9NxgPz/4EOcVeGrFcuYF1uh2NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP+IatNIAjdhtBMiXB3fpBPuDSdFdzJduIv3EK/56IK0szxuoYD/FHNDeo/nRLpGPC69qoSyQt2d9EKyI2K73bsCcqBulBUtNnSHFcd9EUxuYmRCODpQbyPKEgZD4ySrv/9nvdFkO6uWDGZdhDVXBy6NBdU9MAPqyYrRoeY1z10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRnRuLqE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721300074; x=1752836074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3OhgHRh8nxAMjEaek9NxgPz/4EOcVeGrFcuYF1uh2NQ=;
  b=JRnRuLqEDfZP3ytvHi0P5bUjezuKM7aQpNuoLW9aeYKnZv5+Gj7Tanvf
   QgwqcQEw9vkvlE/QyeatyApoOcXwDTZ3oogOHx7KOS4G12/P2OlpbIWOA
   phPA33OrIRmiMdyBmNvWPC8FZ1JBzzeGbuJ7OvgQ5bqoSAMZ98tHaidlQ
   sBD+1Hum/pUGUdAA86Je4BL6cH2uRcr3ugxM8WHeDqS3bQ02p9ZHv/duv
   HDZqz/A5fiWY9ET7jqdCFmPy2AVwDXJ43dLkRonG+UXz5MhBkpQrORHpa
   Dlm+gSwF8eujAmJvTSK4pCD7R/odn5nMat6+rHf4BBTG3dnQaZun/M21v
   w==;
X-CSE-ConnectionGUID: EFiSGKvvT4Gqbcip+a5z7A==
X-CSE-MsgGUID: Bw5BFXqbQEOQ4VxHMucD+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18987497"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="18987497"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 03:54:34 -0700
X-CSE-ConnectionGUID: ZnUtUkCJT2WpPXPfj17t2A==
X-CSE-MsgGUID: x7thRLEySN+A5ZRAE2KE+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="50774592"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by orviesa009.jf.intel.com with ESMTP; 18 Jul 2024 03:54:33 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH iwl-next v4 3/5] ice: Initial support for E825C hardware in ice_adapter
Date: Thu, 18 Jul 2024 12:52:51 +0200
Message-ID: <20240718105253.72997-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718105253.72997-1-sergey.temerkhanov@intel.com>
References: <20240718105253.72997-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Address E825C devices by PCI ID since dual IP core configurations
need 1 ice_adapter for both devices.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index ad84d8ad49a6..903d0bc9e3e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -9,12 +9,14 @@
 #include <linux/spinlock.h>
 #include <linux/xarray.h>
 #include "ice_adapter.h"
+#include "ice.h"
 
 static DEFINE_XARRAY(ice_adapters);
 static DEFINE_MUTEX(ice_adapters_mutex);
 
 /* PCI bus number is 8 bits. Slot is 5 bits. Domain can have the rest. */
 #define INDEX_FIELD_DOMAIN GENMASK(BITS_PER_LONG - 1, 13)
+#define INDEX_FIELD_DEV    GENMASK(31, 16)
 #define INDEX_FIELD_BUS    GENMASK(12, 5)
 #define INDEX_FIELD_SLOT   GENMASK(4, 0)
 
@@ -24,9 +26,17 @@ static unsigned long ice_adapter_index(const struct pci_dev *pdev)
 
 	WARN_ON(domain > FIELD_MAX(INDEX_FIELD_DOMAIN));
 
-	return FIELD_PREP(INDEX_FIELD_DOMAIN, domain) |
-	       FIELD_PREP(INDEX_FIELD_BUS,    pdev->bus->number) |
-	       FIELD_PREP(INDEX_FIELD_SLOT,   PCI_SLOT(pdev->devfn));
+	switch (pdev->device) {
+	case ICE_DEV_ID_E825C_BACKPLANE:
+	case ICE_DEV_ID_E825C_QSFP:
+	case ICE_DEV_ID_E825C_SFP:
+	case ICE_DEV_ID_E825C_SGMII:
+		return FIELD_PREP(INDEX_FIELD_DEV, pdev->device);
+	default:
+		return FIELD_PREP(INDEX_FIELD_DOMAIN, domain) |
+		       FIELD_PREP(INDEX_FIELD_BUS,    pdev->bus->number) |
+		       FIELD_PREP(INDEX_FIELD_SLOT,   PCI_SLOT(pdev->devfn));
+	}
 }
 
 static struct ice_adapter *ice_adapter_new(void)
-- 
2.43.0


