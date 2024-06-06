Return-Path: <netdev+bounces-101513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D548FF244
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 18:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF58A1F26B41
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E747198E96;
	Thu,  6 Jun 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5URKs/X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C91990A8;
	Thu,  6 Jun 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690559; cv=none; b=B8E8FiyNd6arXoLu7G/nTNEEbQw/QMGiX5E0KWL2esc5PiXOhBd0CMlJA6S/fwBmkgfjI6XngxXijmghXPQ9EHcCi955l7ShPttOdfOOGOqm8U6haNhTEo25Brwb1Tz/GUe1YnHEB+DBMrA1mydlby+bMgEVj0t6HCfaFHchVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690559; c=relaxed/simple;
	bh=tLHKMNNtrQ426bUGhUYVfREzh8JRc0nm5Ra/LTxjX3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qmX+Swg7BDcKKZywrbls7scEMXYr7Y2jeq/FvTYRxpT6GxTWKVaNW7O0klGBfoZjtJlwyL+nX8M0bNgtibrnZRRVbWWoDo0+hNrJTHtmToJlOwf2HROmbx/Aq5vnwFefTP5jCozp3J3A1pKYsqy+pxH6i3dtPOhBpDzERRv5oYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5URKs/X; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717690559; x=1749226559;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tLHKMNNtrQ426bUGhUYVfREzh8JRc0nm5Ra/LTxjX3Q=;
  b=M5URKs/XlcQxhMtcV7Rg0jqdFQb2QGYwfiBi7djgpT+XYjMUBJntzFj3
   LjgiLHyjnSnvVnsDnxOh83zh3w0irX6IpQnsfoBGmYWivAjSLqUjZ6Rqy
   Og/JAtkJGZSYEJadOYa6i6V9BhicOsaY9kB/y97AYO3aL+GWvvapGZJ6z
   z0G2lezr/uRO0f94qa8TSa/pGoC0cmHIB601DZEzFGIm7YvTBQ8BaA6uy
   xQmSIkHa75VIx1lZVmKGORSIZriuMvUnHqrbRRgEEmn14sqwRSFy48fJp
   bo+wGwVzr6rN7iCBRPzx+rkHX3rymkj83ywScyexGMA5wosy1x15Lwb9t
   A==;
X-CSE-ConnectionGUID: 6xaLbLppQviKqh+AnckeBQ==
X-CSE-MsgGUID: 9p87HlUrRcSRtRLIYf7Psw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14526393"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14526393"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:15:58 -0700
X-CSE-ConnectionGUID: 8sMfRC2NSBSngIq3Sd542A==
X-CSE-MsgGUID: RcUaROZbTAqtd5so5aTGdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38697898"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 06 Jun 2024 09:15:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BB8F72A4; Thu, 06 Jun 2024 19:15:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 1/1] net: dsa: hellcreek: Replace kernel.h with what is used
Date: Thu,  6 Jun 2024 19:15:49 +0300
Message-ID: <20240606161549.2987587-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel.h is included solely for some other existing headers.
Include them directly and get rid of kernel.h.

While at it, sort headers alphabetically for easier maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/dsa/hirschmann/hellcreek.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/hirschmann/hellcreek.h b/drivers/net/dsa/hirschmann/hellcreek.h
index 6874cb9dc361..9c2ed2ba79da 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.h
+++ b/drivers/net/dsa/hirschmann/hellcreek.h
@@ -12,14 +12,16 @@
 
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/container_of.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/mutex.h>
-#include <linux/workqueue.h>
 #include <linux/leds.h>
+#include <linux/mutex.h>
 #include <linux/platform_data/hirschmann-hellcreek.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/timecounter.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
 #include <net/dsa.h>
 #include <net/pkt_sched.h>
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


