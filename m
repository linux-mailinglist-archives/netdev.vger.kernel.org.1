Return-Path: <netdev+bounces-152961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D707B9F671F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C2F1722BF
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA841BEF7A;
	Wed, 18 Dec 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUJJ0dYG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45B1C5CC9
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527601; cv=none; b=Nt90/GfwQj9KgrbmKlNhoA2vi7HemGZsqm9jv5z0qSD/ViFtHen1uz6vG/HhGOCLBbm5Lbv9iAMMnx2FZxg74Z0qpnvJ5dGNC2rnhfQMcBrqUjsf09ftyFkmL0+14GtYgGR1Hd32C73ANdO4VbrC0KmFfLtOwNhYm1hpliN2zaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527601; c=relaxed/simple;
	bh=RiM0PsOgUFlrINJbsCWgonnbsteTL2ePM2B3IzPf8/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn1ptJcrBozvVkzHBZX3KAkfrN4oPo1iPDTXdWhwB/rvKxho2HxP+NND6YL+PYNZpyAT02N0bwtMvK5CsHKyB2Cp54YYhPplHzJHhXC8JLo5TelKthqBJOM5MjT9GWwlUdPyW1nkDNQ6xnbWIJrA2ksIecABpjAvPOYGYqUt8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUJJ0dYG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734527600; x=1766063600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RiM0PsOgUFlrINJbsCWgonnbsteTL2ePM2B3IzPf8/w=;
  b=jUJJ0dYGx3k64f8qVEQZa4WG7ToQrLTV68k6GqsXlO5CsDRCHS4Ik2bl
   epVa/9d5Fhk6S3Son22PiUlUnuPHqDfFdK8biKFEqhKFejOThdxZaT9Wm
   AB7YASjyV6SP5RCOKKTljUajWxVhaQsNYSuRmFboUN0eJcGHAF7Q/BS5M
   5zRZ58e2Ari/I+y1LII+wXqHp28Vff0TerjSQEAJ+Lg/H5kLet/SscE7B
   GEqueNoNPe/SEa+6ODeC95rgmprt6kjwE1UOxV4v9GGCWqItIw4KMBIXg
   Midpp9keBKMNAj82V+lqq1b4kqA3BzC2PCb/cJj7gW0IjvAygjEKmTFNf
   Q==;
X-CSE-ConnectionGUID: vVp93gHPT8yknlA/mKI4AA==
X-CSE-MsgGUID: QQvXuHB1Tf+/YebhYODOUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22589659"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="22589659"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 05:13:18 -0800
X-CSE-ConnectionGUID: K4ZH83JEQBO4DtRxWliHTw==
X-CSE-MsgGUID: LO7hICXLSMS/oVO9u4zcHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102471150"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.245.118.127])
  by fmviesa005.fm.intel.com with ESMTP; 18 Dec 2024 05:13:16 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH iwl-next v3 1/2] PCI: Add PCI_VDEVICE_SUB helper macro
Date: Wed, 18 Dec 2024 14:12:37 +0100
Message-ID: <20241218131238.5968-2-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218131238.5968-1-piotr.kwapulinski@intel.com>
References: <20241218131238.5968-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI_VDEVICE_SUB generates the pci_device_id struct layout for
the specific PCI device/subdevice. Private data may follow the
output.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index db9b47c..414ee5f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1046,6 +1046,20 @@ struct pci_driver {
 	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0
 
+/**
+ * PCI_VDEVICE_SUB - describe a specific PCI device/subdevice in a short form
+ * @vend: the vendor name
+ * @dev: the 16 bit PCI Device ID
+ * @subvend: the 16 bit PCI Subvendor ID
+ * @subdev: the 16 bit PCI Subdevice ID
+ *
+ * Generate the pci_device_id struct layout for the specific PCI
+ * device/subdevice. Private data may follow the output.
+ */
+#define PCI_VDEVICE_SUB(vend, dev, subvend, subdev) \
+	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
+	.subvendor = (subvend), .subdevice = (subdev), 0, 0
+
 /**
  * PCI_DEVICE_DATA - macro used to describe a specific PCI device in very short form
  * @vend: the vendor name (without PCI_VENDOR_ID_ prefix)
-- 
2.43.0


