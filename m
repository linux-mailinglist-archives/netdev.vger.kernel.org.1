Return-Path: <netdev+bounces-140955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAA89B8D3D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 09:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 320D2B21007
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BA4156C71;
	Fri,  1 Nov 2024 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7IvMgaz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E11156676;
	Fri,  1 Nov 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730450539; cv=none; b=qzBIpCwUCJrlmEiMnW5TJRb/bPINqI8VRW0L0m5wtuuryYDTXt9wM+aMWgYoqyFKrI7clfHb+4Id3L309ClK+6aYCNm4eWcRY7spq/Oslm9hTthQ2sMQ7aBdMD74TTs0kscQ2JVMkyIk3ocVHGDbM0+C9ywQRq8LR1qTyj0zto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730450539; c=relaxed/simple;
	bh=8p9zbFmVzSUJD32wGjAkv5U6GsUndhIha66dcsovZZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qes4DxXOVBOQ/irQ+kzRZtOVyw0gOrmgjCXOzlNTZ3tkMjRI34HVnufACnfUtEJMYBvT8Yn6diNAzb37gKeqANRZ+FPOnxu0MkUCjz/nrzfrWLWHzQSI5q9CXohGF0sQiHTQAem1fWdKkEDw4JmSQeZUSLZ/dyaHRbNGgJMm0LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7IvMgaz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730450537; x=1761986537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8p9zbFmVzSUJD32wGjAkv5U6GsUndhIha66dcsovZZo=;
  b=D7IvMgazyyaP9cYCVB0bn/IPoqNVeHZS3zn7I+vp1URfVIF7z+do2dKv
   res+ex9f27Y34DRZBiyJmVGxoEkk5DBDOGh/l0pbcIdOi8tPISslfPte+
   c3VPSeatnyavukoq6uo6mdwQH/1pWVWCo9WTS8r5TPqfnoN4B8g5oOk2f
   BWNcLzZa0+TbwoYnKSAcRpO81FizQe7Kvsi9u8E+iVyK94wMbcMHXZHRM
   xA+nREuh0dcETBLNorZbnrUECjWP9sjGZaU1BSX7RqYE2rUHdw2ZhQr4H
   Mn3Ih/nbl08LMxh52Kj1gXrH/7GKTsLsoWYV0azLt598C+336SsNOy+cy
   Q==;
X-CSE-ConnectionGUID: wfOPZgaHS6Ov44jzWd/vNQ==
X-CSE-MsgGUID: kyqFGlUPQ3uTYcb2dhMEVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="29643613"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="29643613"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:42:16 -0700
X-CSE-ConnectionGUID: rrzUIwwHQ5GLq5cixmpckw==
X-CSE-MsgGUID: ee/DLwKEScieBrtL84uZBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87681534"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 01 Nov 2024 01:42:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EA6CD1AC; Fri, 01 Nov 2024 10:42:13 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] nfc: st21nfca: Remove unused of_gpio.h
Date: Fri,  1 Nov 2024 10:42:12 +0200
Message-ID: <20241101084212.3363129-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove. The drivers in question
don't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nfc/st21nfca/i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 02c3d11a19c4..6d7861383806 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -11,7 +11,6 @@
 #include <linux/i2c.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/acpi.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


