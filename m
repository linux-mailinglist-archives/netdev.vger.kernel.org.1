Return-Path: <netdev+bounces-118595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C49522F7
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 21:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827BF282442
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34851C230E;
	Wed, 14 Aug 2024 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtFOKU8N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA321C2304
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665389; cv=none; b=h9Cn8C+MUf/8tlwSIDUbV5QzSrOdXWtXw7i8pGmOmdXUC3Qz5/I5q2Q4jDLy1mlygIgyaIW6RAkrPaA2bX+kzb+P8KF6z0UravJbymIE8e8nXs2zCT97ju+yyT4Tl+S7OYE+zPuX0cruOO54WY5V4ACvzQq/UuQS/7yffmtUNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665389; c=relaxed/simple;
	bh=IEGbVy55PtrER1w0R4CTaHxIvz5PVDbijqFOF1C+wh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aucKwWFhkb2wUFiErAccKq18WOeH05rCMGp3ITjanpnPZQgfbhubZAoies6cdcKhD3CsPK39oA99g1IPpIT60vUWTVJR4WsMClCWMOlkAGVAfgVrA7oCcX36f30UgCNuIJHT2OuTgBskrYkvQ3Pe20k6zZhU//Ay2yoXtDnlYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtFOKU8N; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723665388; x=1755201388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IEGbVy55PtrER1w0R4CTaHxIvz5PVDbijqFOF1C+wh0=;
  b=PtFOKU8NbhaNdmhwVDaa7W2np8Q0i+1+gHgGJ4TlwjW0lYpeah90/tnY
   18TqSehZOWA/yUNwUS7UfpwUhXaKra9r3jOOAPXw23zLYbiR6DyMybKkg
   NKzlvNIvGOLqm2/rOzuurY970ssIsNsMrM+Wr7lR4kANCOtqk7PouP8fd
   7nfrhBNYS46zMBoJ+3V0brHegtvA6huBnjj7R5npc0eC8kL2J3bldYPQr
   Mp7Wa383HfIvmgScPLaLJbCQjIs//gUox5WVgcG6tT7eqtHUTn2Dmg/je
   CWMePuG9J8ShVfYsmrQ+v2C5gvDvqtfsEr6RMXT/SDvyqRiXfeY261fWM
   Q==;
X-CSE-ConnectionGUID: F26i4RwaR72uXH56LiJuXQ==
X-CSE-MsgGUID: RnZ0FPHbScG2wVGVxmVMeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33292517"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="33292517"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 12:56:28 -0700
X-CSE-ConnectionGUID: rwR6mW6RQkGtE8qbWG+CUw==
X-CSE-MsgGUID: xN7PG5eDTnCq9L3mZcU19A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59869720"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by orviesa008.jf.intel.com with ESMTP; 14 Aug 2024 12:56:27 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v5 3/5] ice: Initial support for E825C hardware in ice_adapter
Date: Wed, 14 Aug 2024 21:54:32 +0200
Message-ID: <20240814195434.72928-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814195434.72928-1-sergey.temerkhanov@intel.com>
References: <20240814195434.72928-1-sergey.temerkhanov@intel.com>
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


