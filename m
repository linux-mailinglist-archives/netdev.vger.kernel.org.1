Return-Path: <netdev+bounces-95988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B6B8C3F3A
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AD21C22CF0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8232C153575;
	Mon, 13 May 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEPX+Xju"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5014B06E;
	Mon, 13 May 2024 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596774; cv=none; b=BgZjsGcys2lbV5dh6U3oXIa4HEw3sMr9DOdfSF0FMSPC5/Tg3dspgreLkNAtQisxjA9TtROVJtTeNIsB/2f/zVTLCewcXaB/zKRHfjfg1NvNcQX2AF9DwBChYoPFp9tFtgsJf16c8qtVGYKX5KQaLFyjBNXR4oobQ7CFG8OviA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596774; c=relaxed/simple;
	bh=9iwioP7RAGt6CZjyiP2VZXazdAn5HXvP+jiooI94v+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GQkpSfPPsjyHY3m46onhAeFsDQD5c9pqsflNnBl932vwPyou088EG8kEDukNiEGcpvg3Q09DBrNE6ILwnnzETazXa8JJWvM9Q+5n+A8UO4o59QJw2/51Ta1Yy1U4ZVIw4vr2zt9u0BO6telJ4oB2xmSrsIoxg+CpEi3yF6ELqT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEPX+Xju; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596773; x=1747132773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9iwioP7RAGt6CZjyiP2VZXazdAn5HXvP+jiooI94v+E=;
  b=jEPX+XjuDQaQ8U83tr9lZ3gLnAAVydRHiu/5VU8ZBrZjR/JHE1V9QgWr
   6b/TY+LEWWvKV1dJryPduZBRsdMB7IJ/2Ng79HgrHTEPEyXwcoaFSc1uh
   VCJP4c+MAqQkj1nVrBqVUbE6P1mwsbbn5Ji5Ez7tMr8H7zbwA1C+zARJV
   64UZRZTZ7hHVjjm6SGLsFYpq/iF8IMk37n9OK5u+ln9hskWN4hhUOQ4iP
   WZc8eXBUxmy7oJ6bs3A3jGsIFjKr8TjTAKE3nRWWpuAocDLC3RiMtnVjX
   ZsR+EL5UNJczGWHAaCSW8XbejZ8+Pu9+iSv7/R6M+DFfrcgdXYHhQ4HmC
   g==;
X-CSE-ConnectionGUID: FWBdrBjkSlGJnVo96MjLRg==
X-CSE-MsgGUID: v6wOUrC+QdSMYeaN0cd2eA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29039165"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="29039165"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:39:31 -0700
X-CSE-ConnectionGUID: YcPM5iW/QQyTmMhJEdPLPg==
X-CSE-MsgGUID: v5twAhKHQtu1OQuEE0slSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="61481873"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2024 03:39:25 -0700
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
Subject: [PATCH v8 11/12] Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
Date: Mon, 13 May 2024 16:08:12 +0530
Message-Id: <20240513103813.5666-12-lakshmi.sowjanya.d@intel.com>
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

Add Intel Timed I/O PPS usage instructions.

Co-developed-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
---
 Documentation/driver-api/pps.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
index 78dded03e5d8..52a6d5faf885 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -246,3 +246,25 @@ delay between assert and clear edge as small as possible to reduce system
 latencies. But if it is too small slave won't be able to capture clear edge
 transition. The default of 30us should be good enough in most situations.
 The delay can be selected using 'delay' pps_gen_parport module parameter.
+
+
+Intel Timed I/O PPS signal generator
+------------------------------------
+
+Intel Timed I/O is a high precision device, present on 2019 and newer Intel
+CPUs, that can generate PPS signals.
+
+Timed I/O and system time are both driven by same hardware clock. The signal
+is generated with a precision of ~20 nanoseconds. The generated PPS signal
+is used to synchronize an external device with system clock. For example,
+share your clock with a device that receives PPS signal, generated by
+Timed I/O device. There are dedicated Timed I/O pins to deliver the PPS signal
+to an external device.
+
+Usage of Intel Timed I/O as PPS generator:
+
+Start generating PPS signal::
+        $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
+
+Stop generating PPS signal::
+        $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable
-- 
2.35.3


