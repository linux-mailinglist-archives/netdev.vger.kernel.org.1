Return-Path: <netdev+bounces-237707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF0C4F233
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7964B189CD2F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62D3A5E73;
	Tue, 11 Nov 2025 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oo53m6Jr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA49393DE4;
	Tue, 11 Nov 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879964; cv=none; b=uRPdcyzFFMyltnAxwu1E//uqIForctapTXm9t/7CjDwaOpKaYH2sJNBqUxW30AMmCk4ac921B71ZYJxNy1MTA61lwigdXa3m6OJppI4D+G+3vQPwJdwek3qxZEzFdMfANRBQYNXWGOi6/sqmvTZ1LcuSbX1aX8pYRdjnVo0K9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879964; c=relaxed/simple;
	bh=CNbIw9fNzTPV1RkVKp4DE66YjQbF8SqInj7PpgPBGEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMBvOo9UK3N02U4j7ck52+/YHXu34MW4uumi4IIVskqf1Jub6i/MqUaqmLuqhjCB7EHB3xAhpQ/c/o8YYirV5VILIbaynKgUQEcVPvq1ojv08ya6olbJ0MuJFPSuX5iuJqAXX1qMJC8dhP3AHLfojrGGoNRbU6mmdGMXliaTLNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oo53m6Jr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762879962; x=1794415962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CNbIw9fNzTPV1RkVKp4DE66YjQbF8SqInj7PpgPBGEc=;
  b=Oo53m6Jr8TNEkq6SMDH6KbKk+lItpt9TE9g/PGwjxrQbXFLipCjYQ6w2
   oQPreMYMMZdHJ0QSScgr99fayQrWdBwMduFbjCpxc8gNCPTa0ZIhCOdqX
   xMiW23tdxHMrII8QQ85hPFmVvYM6tA6lF76kvYF02KxFKvWWWjug2VByC
   PFo5vfOEUTs3hfHuYOoxa3JyQ9UPO+vXWaraOc/a/RvuSPHMjGD+Da0lB
   z81dyXnuinCQVMSYL2N0vhPvhEFxSv0quGzUVl0mM04O7EgtkJ4IllQNR
   eH4PjJHa6WGVMNECH3bDkTTTB+yU6WA1CiNWipM93SezNHx1e1OS/D4tH
   A==;
X-CSE-ConnectionGUID: gb2HY82GQCiDEnetdTGo7w==
X-CSE-MsgGUID: n9ECiYVFRU26Lz9kp0wODg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="76049278"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="76049278"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:52:40 -0800
X-CSE-ConnectionGUID: 6JGWJySLSmOq6t4wa7aCTQ==
X-CSE-MsgGUID: jEloUee4QJexVjRb9dIPqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="193112860"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 11 Nov 2025 08:52:38 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8747C9D; Tue, 11 Nov 2025 17:52:33 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 7/7] ptp: ocp: don't use "proxy" headers
Date: Tue, 11 Nov 2025 17:52:14 +0100
Message-ID: <20251111165232.1198222-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
References: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use) principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 984293a2a696..4b18f1e5ae9a 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -1,28 +1,53 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2020 Facebook */
 
-#include <linux/bits.h>
+#include <linux/array_size.h>
+#include <linux/bitops.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/container_of.h>
 #include <linux/crc16.h>
 #include <linux/debugfs.h>
+#include <linux/device.h>
 #include <linux/dpll.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kstrtox.h>
+#include <linux/limits.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
+#include <linux/mutex.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/pci.h>
 #include <linux/platform_data/i2c-ocores.h>
 #include <linux/platform_data/i2c-xiic.h>
 #include <linux/platform_device.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/seq_file.h>
 #include <linux/serial_8250.h>
+#include <linux/slab.h>
 #include <linux/spi/altera.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/xilinx_spi.h>
+#include <linux/spinlock.h>
+#include <linux/sprintf.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/time.h>
+#include <linux/timekeeping.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include <asm/byteorder.h>
+
 #include <net/devlink.h>
 
 #define PCI_DEVICE_ID_META_TIMECARD		0x0400
-- 
2.50.1


