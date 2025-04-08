Return-Path: <netdev+bounces-180406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923EAA81389
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C841E8A1643
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A7123E259;
	Tue,  8 Apr 2025 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiK/7qj+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AACB23DEAD
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133068; cv=none; b=s5tjRQEZGSU2OTSYOWXVeCxNzMgvSUiKd24jCp7xO13K42zb80YJK4up/eA8ZDDLdDyofAg03IwpYcjSrRHiuHfNC2hnagg9P000yIGNyPG2ZASxnHKkVUmoZ9uqDN5o3VT+dqRheGzorwTfGmZEBb3LPf1yWnJQriDqNS5FglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133068; c=relaxed/simple;
	bh=czEDXFnNkqKkADGnIpQkXX/OpJWya2iTcsdE0n02nWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZkR8PTFWD/bKmQy6zLkWJ330GBMwa+VtgSzyYSzPaTOd+Hf/zWt2Fc9qq6T8Tc/gm/6Qpya484UyqBEXHC32YE6De5+SQ0eK+16NqKc4f3n36jrZMqHgpSrKS5bGIQ9aUU8GXMgt/xNIRPUfI8fa9UmPwxvoYjTMDPnWst0zTRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiK/7qj+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744133066; x=1775669066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=czEDXFnNkqKkADGnIpQkXX/OpJWya2iTcsdE0n02nWA=;
  b=SiK/7qj+EQiVTlV0DtGLbBv+j1XnlfzPt4oGNsRaZyJDibNSjEZnjarp
   L1gDOT9+wuMCYrSIcQQErfGlWcFLaUCvTUQnF0qIhIPfWa9p8sDYuPi8b
   qrciNwCWfVuiqCLLoyKNz189uEaI61eq210iCXNl5rUykUGh1k6euxOQ7
   KmOlIHVDi0icRwST58uPkWutLBVGOWz4quLgO9SGEX8DehZBZ3eFKPIA2
   YKAmlN2DcFNbVzyNg3AeMdzSXfdV/n8w8NtIiD4KMf2H/VnFvLfIbnpOe
   KyOtD8Zt6s0YLXgjj7V0Em5k8uyWmmhRQh92lc5vARGKyXH5FhqNoavRn
   g==;
X-CSE-ConnectionGUID: YcZT8gjsSTaP5BDo/F9c6w==
X-CSE-MsgGUID: /0WYScdnSda37DbkMWIE1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45744151"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="45744151"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 10:24:26 -0700
X-CSE-ConnectionGUID: krcTZdwNToiDmvJwfwVCrg==
X-CSE-MsgGUID: 6cSsDEVjQIq+wLcTf6kytg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="128839700"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa010.fm.intel.com with ESMTP; 08 Apr 2025 10:24:25 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next v4 3/3] ice: add ice driver PTP pin documentation
Date: Tue,  8 Apr 2025 19:18:36 +0200
Message-Id: <20250408171836.998073-4-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250408171836.998073-1-arkadiusz.kubalewski@intel.com>
References: <20250408171836.998073-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Add a description of PTP pins support by the adapters to ice driver
documentation.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v4: no changes
---
 .../device_drivers/ethernet/intel/ice.rst           | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index 3c46a48d99ba..0bca293cf9cb 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -927,6 +927,19 @@ To enable/disable UDP Segmentation Offload, issue the following command::
 
   # ethtool -K <ethX> tx-udp-segmentation [off|on]
 
+PTP pin interface
+-----------------
+All adapters support standard PTP pin interface. SDPs (Software Definable Pin)
+are single ended pins with both periodic output and external timestamp
+supported. There are also specific differential input/output pins (TIME_SYNC,
+1PPS) with only one of the functions supported.
+
+There are adapters with DPLL, where pins are connected to the DPLL instead of
+being exposed on the board. You have to be aware that in those configurations,
+only SDP pins are exposed and each pin has its own fixed direction.
+To see input signal on those PTP pins, you need to configure DPLL properly.
+Output signal is only visible on DPLL and to send it to the board SMA/U.FL pins,
+DPLL output pins have to be manually configured.
 
 GNSS module
 -----------
-- 
2.38.1


