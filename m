Return-Path: <netdev+bounces-184773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9844FA971F5
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C52440649
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1603A290BB5;
	Tue, 22 Apr 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHY09NnG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A658290BAE
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338067; cv=none; b=GqRDe+coPZn9fMd5COo/p6jmXdq656k6dYyM/vvHN9CrgvD87xtJAVizoZVwcj+vxUCTRimBwtSKoWBK6gz62YvOZoIo3SFgvlQ836d+JnSPTkrmKzw0g1psoMCu+CdX3QECXz6x8VvuaDcNxk6ZqrCw6c2HTDuU8lK5xyaMDdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338067; c=relaxed/simple;
	bh=Ucct7ug/sc59MUthipbdjNfLgEhVwF3WKl6PurlN2Ug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2ZHfYfZ/ovRruHd0ikptds0SN7KZDOnE/aY2jzy+cUDWsjYcMC5oThqHFC0CBIzYlkiEGE5VKHmN1IZtR8EltwvDtarMOLgTlJD+wRtsMeR8MZi7al+Aj3KH5EoZuVu3KlXbYMej88xCFuMgz8z/NtYv3h61Z+JA2kKB30B710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHY09NnG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745338066; x=1776874066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ucct7ug/sc59MUthipbdjNfLgEhVwF3WKl6PurlN2Ug=;
  b=KHY09NnGXr1LGJwsmqOqUkgkgBkJyddM48DmbDAWnXaB2Ikf5BslvLN7
   MNmyGT1DxvJgQg5is0F15mCpliuoDFA0ho9iv2rv7JmJJKjc7nRwVJCa9
   4/wypmsPaXqTCKGu+EsvZuLAZxgSFPqA6N83YU6oYk8My17NmHCzPTcxj
   1kOR+Q9Z1psuZId/H//16tnk2OM1QtKH9wjSSLRgJ6bwgDTJCjERnS+fM
   xgoz826/mNuxjwCRL7G364164gAzN5h7ugm1SM1zZY+qETYjiOYxO7vER
   vZYpjwnAdKYE4yCbEeL/D+Q2W9iTLkKjb8zZHQU+8DWbplU3mIjEXCcRM
   w==;
X-CSE-ConnectionGUID: +oo5dCwjTiK/rf8fq67I6g==
X-CSE-MsgGUID: OqW5nmwVSbaL95GLsJMT6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50709028"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="50709028"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 09:07:46 -0700
X-CSE-ConnectionGUID: TpDil5afQviMSHMAe+6D9A==
X-CSE-MsgGUID: 2+rcNoRNT+mXQL7PlJRKIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="132592468"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa007.jf.intel.com with ESMTP; 22 Apr 2025 09:07:44 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next v5 3/3] ice: add ice driver PTP pin documentation
Date: Tue, 22 Apr 2025 18:01:49 +0200
Message-Id: <20250422160149.1131069-4-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250422160149.1131069-1-arkadiusz.kubalewski@intel.com>
References: <20250422160149.1131069-1-arkadiusz.kubalewski@intel.com>
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
v5:
- no change.
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


