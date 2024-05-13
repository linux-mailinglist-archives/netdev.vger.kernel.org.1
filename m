Return-Path: <netdev+bounces-95989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C848C3F3D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849581F246D3
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C2214EC7A;
	Mon, 13 May 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEgZvw4g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5E14EC6A;
	Mon, 13 May 2024 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596781; cv=none; b=Q0ngCZDfexc3tf1+9LW/E1mrsuMaFbPGusp0sMHAZfYVHu+/bb08ntByRz1m+E8+Q+1/NrCcF70O7rZqpzwHyEO5i1lcuAGGrnc5TVGwYCuXsbDa3cH2yrrMls0PGMm4g0u9VdPBKp41V8L3Qt2vPnKrKqpA6e1R7JlRR5wfAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596781; c=relaxed/simple;
	bh=LnDI8ECmyOwaPF9450szty9CSHo1Xk8N8ohrNbKrGTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6gY9fMKmxqC5+gK5fskp67xsU8GXesw1kNRb2SAJXEPj5v5sCZXDmw+6WnJUgOwzNcKpbXOmBDI5l3auuHWDFgn0NYnVWRvZhpAdXJZGZ2a5Yw11cp0WC9MYeTUqwMqmla0/XTghqxw38LAXmo0l3KwlwdoWpsfbSOm24i05j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEgZvw4g; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596779; x=1747132779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LnDI8ECmyOwaPF9450szty9CSHo1Xk8N8ohrNbKrGTw=;
  b=NEgZvw4gCQAh4eCcRXH9/l+B1EkbDAjHcaH2qdIRF8inAqIH+5eeE4y0
   IE1R190kJ2Vf8Du+c3lOb9vcLAHjxO/I8GL2QE8/fgPxPhr/+h7zvG09L
   t6/OFaisnugRMduL6ZRWKBlpIRGMMEZ2M0QyUOHIeMC4uk1PvdPZPb2R5
   5sU5c/TKF2yROyG5cexSRoQIrKzqT3Q5YfFruq22YVUTsnub6h0zL0L+4
   sXveZkfC14p5RE3Uuh4Pj0GK+7eGaY7XDZWAY490Mfn8bFvfBcb1Gmqog
   SVutE/1VvfSWVmqlFpogJiYt/Nv+Xr2RDdWZLKgsKwU3SMfQxc6hKHKex
   A==;
X-CSE-ConnectionGUID: Uw3MlEPRQsWTXYpLM9wBGw==
X-CSE-MsgGUID: ydrJShp0RFCoIXuPAFbArw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29039186"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="29039186"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:39:38 -0700
X-CSE-ConnectionGUID: UtjDBr70QbO/cGb0j/aMFQ==
X-CSE-MsgGUID: 5/3nhQKxSMuXqRjPARFSpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="61481885"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2024 03:39:32 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v8 12/12] ABI: pps: Add ABI documentation for Intel TIO
Date: Mon, 13 May 2024 16:08:13 +0530
Message-Id: <20240513103813.5666-13-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
References: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Document sysfs interface for Intel Timed I/O PPS driver.

Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 Documentation/ABI/testing/sysfs-platform-pps-tio | 7 +++++++
 MAINTAINERS                                      | 1 +
 2 files changed, 8 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio

diff --git a/Documentation/ABI/testing/sysfs-platform-pps-tio b/Documentation/ABI/testing/sysfs-platform-pps-tio
new file mode 100644
index 000000000000..74f3244b55dc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-pps-tio
@@ -0,0 +1,7 @@
+What:		/sys/devices/platform/INTCxxxx/enable
+Date:		June 2024
+KernelVersion:	6.11
+Contact:	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
+Description:
+		(RW) Enable or disable PPS TIO generator output, read to
+		see the status of hardware (Enabled/Disabled).
diff --git a/MAINTAINERS b/MAINTAINERS
index 28e20975c26f..97606c072e3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17670,6 +17670,7 @@ M:	Rodolfo Giometti <giometti@enneenne.com>
 L:	linuxpps@ml.enneenne.com (subscribers-only)
 S:	Maintained
 W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
+F:	Documentation/ABI/testing/sysfs-platform-pps-tio
 F:	Documentation/ABI/testing/sysfs-pps
 F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
 F:	Documentation/driver-api/pps.rst
-- 
2.35.3


