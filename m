Return-Path: <netdev+bounces-140953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D08129B8D39
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 09:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1661C20FFE
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 08:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B1A156C70;
	Fri,  1 Nov 2024 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0RajtaQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867C15665E;
	Fri,  1 Nov 2024 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730450358; cv=none; b=cyriobU2d8AlNPFjpjGDtSW5u7y/AC9jmk4ssWRO6WcW1lt1jMWvY3tYkGBxw+FQWQR9aihkNFzs99PIqnPgbem1erHQhNWDXrTlU5vOC28RC5IZTI+3aHeMKdzmzI1Yepmo/5rbZprCxO0sO1ap+/DShV+be+idhtsEccP7lU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730450358; c=relaxed/simple;
	bh=iDr4q8fYZcr9ntsRwmck/+vUSSOtQ8CnR+Ua/SEe7WM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J/kiCu8qkTqN4Z2YNm3TCMNOtr7LazEJzkAeoq4l2oFapIVUiqPypQ9F+boS2hn6/FoZkjZ+E0gNVySXY2FyA2Rb6pWzZDIfjIWVcWnIEJaksbGNTy/FbGFUvkh7yMMJWf2SrO3D7giecBA7FsoqZuPGlqtI6K/x6EVopt13Upk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0RajtaQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730450357; x=1761986357;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iDr4q8fYZcr9ntsRwmck/+vUSSOtQ8CnR+Ua/SEe7WM=;
  b=R0RajtaQ2eo1uhZY57J8O+2tK2O4uf5vEL0syyftCR0LLdeFS2Ww86Mi
   jfpUmIXhw7buAebS4/oWlVajUguUo+J3pvvc4X3n65wakEnF0b3NA8ybl
   YlBnNVfVp5GaLGIMgY40DphbzAudNA8Y4n+4UIPyJeS8uSVyztJ98rK/K
   sN41SY2X4Jb0eBSAMwnTCSvwt5NiM96CLWyixAIfgBpqMPP9qmc7GOmzE
   waFSQbhPJk0S7jiBmViLTVgUhAA8x01IX3E9H+Grll7u3JbLRtnqLagPv
   yN4oA6GQHF9nQO+vO5p+Sk0awKjIisHHDSC9kltBN9vyCDQ5qgIhy9/Zt
   A==;
X-CSE-ConnectionGUID: ucJkbt0pRjGJv50+I7EWOQ==
X-CSE-MsgGUID: 8foWuz7cTHyMu7UfiUfXcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33902877"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33902877"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:39:17 -0700
X-CSE-ConnectionGUID: 3g15tqEWTouj4KZMoAc5fw==
X-CSE-MsgGUID: Va+lsToYR5+wwlmUTt1sZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83713725"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 01 Nov 2024 01:39:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 28ADF1AC; Fri, 01 Nov 2024 10:39:13 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH net-next v1 1/1] nfc: mrvl: Don't use "proxy" headers
Date: Fri,  1 Nov 2024 10:39:10 +0200
Message-ID: <20241101083910.3362945-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nfc/nfcmrvl/uart.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 956ae92f7573..2037cd6d4f4f 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -5,11 +5,16 @@
  * Copyright (C) 2015, Marvell International Ltd.
  */
 
-#include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/of_gpio.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/printk.h>
+
 #include <net/nfc/nci.h>
 #include <net/nfc/nci_core.h>
+
 #include "nfcmrvl.h"
 
 static unsigned int hci_muxed;
-- 
2.43.0.rc1.1336.g36b5255a03ac


