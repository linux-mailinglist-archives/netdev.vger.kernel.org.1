Return-Path: <netdev+bounces-120584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A58C959E40
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264C21F21CB0
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359F4199943;
	Wed, 21 Aug 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b90cD9MS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C26199944
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245918; cv=none; b=cF/F097a4A/FL5rIuzk0a9Ou3bVaLnEclShBwqLCchYkTCl8XA20oCOAwtOVxjEf3MVENEYzSE2dBqkQzdn0EF/GpQOI1Ne2ImtJgVC56vuoYq2qrt1aZ0udDdBRhAujCQqzljcCVaEr7w4ZLkHV3wfFH18PdnEytKGGuizHNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245918; c=relaxed/simple;
	bh=IEGbVy55PtrER1w0R4CTaHxIvz5PVDbijqFOF1C+wh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FE+eQFfcNDHJzKtkcUVJzX9HSu3/vL7K+8HtG1xxqhX9R7QY/9qbfdvj0I7M0bIQSLaH4sTnWcjntPV89ZnhnJzFgPUZ9IqAAO59AYtAppqfK6XYvvjcX2VHwk7E0jYdw3AfMqQlCLmGnZdTEWJe3mKFEoOBuvJ9gtwXhA1p+Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b90cD9MS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724245916; x=1755781916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IEGbVy55PtrER1w0R4CTaHxIvz5PVDbijqFOF1C+wh0=;
  b=b90cD9MSSEod+HDX1fY+jYro0lc8crHtp/J1ZRYAGIcVDPjxjq/AW3ge
   OKhEd8wQyC6TwmJpZctKi8Y/8AKFKX007vasG0jIQKSGwvDmzG7vmTW9c
   nWjXvgLp4902GR/r5w1BPJ0J6S2c2Kgj84CX6CkK2VQJhHjU54GJoMJxY
   ELkv5Zmo7wSbPwLmqKvPv+rmcR9N0rgxwNMkaHlnUoeM9ilz+nKuCoKuq
   /6JIqdah0RgAlL2vfVyMFsfx11oN3V522ckqPfNl3uGM5EORyN/TQC4xB
   9vj8RpNepuDDgafYtUb3vLIvjfr+3rDA0jFqu21oDhwEWz5wXk/yXV0JC
   g==;
X-CSE-ConnectionGUID: goue0vaxTs2TptuX5UrK0A==
X-CSE-MsgGUID: ZJvOMU+DSD+wnVEQbi/XZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26356934"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26356934"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:11:56 -0700
X-CSE-ConnectionGUID: m613+2eaQpGcN5dWfsk29A==
X-CSE-MsgGUID: yhZCQCyOSQ2pECYoUMbFfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65432401"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2024 06:11:55 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v6 3/5] ice: Initial support for E825C hardware in ice_adapter
Date: Wed, 21 Aug 2024 15:09:55 +0200
Message-ID: <20240821130957.55043-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821130957.55043-1-sergey.temerkhanov@intel.com>
References: <20240821130957.55043-1-sergey.temerkhanov@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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


