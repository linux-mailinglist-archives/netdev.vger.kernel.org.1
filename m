Return-Path: <netdev+bounces-94534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE18BFC8D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5C2287745
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9475F7E105;
	Wed,  8 May 2024 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2DkkJds"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48881AD0;
	Wed,  8 May 2024 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168726; cv=none; b=MXzaw++NvXtDKz//J5U6qdxu/ldh9OsjQ0hI4PPIuQo1Lb7iFQVc84Lmw8aOXvA0o0riFWmJHBarHzrMuS+DErgYPDIAiqIY5eDjjuQXcowKPCs+eOO5YwNWWCxZ60X/mpGD44DjxYoNixXcFrAKKNDg1DOh4Iylmn0DNVlC4vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168726; c=relaxed/simple;
	bh=ysQMPzsDmdSKglgataWxi6Vk6YGZw5N5O//e4R4eqdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h31LE0W5myDk31eLoZ5Ntx2iCc/T8kwULMPHSD1fDDs7yIdr5Ya4ixgTmFm5HyP7ZoYACCRbQ+j9IL5wGLyfq2N6LJU6gxVKWwYlNHh1pYBZguFmzZz5CrN4ulVCXZdADMR8LO5qrlUMOTKgTRd3sUcfAPPjS16lDfqjMdDk53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2DkkJds; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715168725; x=1746704725;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ysQMPzsDmdSKglgataWxi6Vk6YGZw5N5O//e4R4eqdg=;
  b=d2DkkJdsdllueGRiR1xNHD2oWYmAgKowBaSWfZ8lF9R/cMyV15d2nOPj
   mcX/r7PQ+nwOh5vAsJ1Q4JD0+cqfgjqmPdyhtVAj4ayh3LxN9aEF7s7qw
   f3osq33a1gz1QcHewI4Yz6A5J2rEMlan88JP6C5PlWsuMbyHHHMRj5qUy
   9laamy2wPGJQW/Zm6jNJAr7NipWNkmmY3Eaz86NvXLXsBkAqs8QosxMTS
   IflEhgXVXjn2vlEbDrxRn/WO5yKzffiJsf5TDJ+6zlhOaLjFxOElnmMR7
   Jo0Ml6Nwio9bkyzx/H4/PvcVxug8VbmZHXnSQfBCAnz8N8fGUlCUheLw9
   A==;
X-CSE-ConnectionGUID: LGvDU9NdRByURblp/td/sA==
X-CSE-MsgGUID: 7JXF34PQSgGSVAr66k8Rvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11234275"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11234275"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 04:45:25 -0700
X-CSE-ConnectionGUID: IHQsn8PmQdWC0SWNtEbnJg==
X-CSE-MsgGUID: NDgYrUWXQdykbmw35d1DeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33697538"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 08 May 2024 04:45:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 892E611F; Wed, 08 May 2024 14:45:21 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] net: ethernet: adi: adin1110: Replace linux/gpio.h by proper one
Date: Wed,  8 May 2024 14:45:19 +0300
Message-ID: <20240508114519.972082-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linux/gpio.h is deprecated and subject to remove.
The driver doesn't use it directly, replace it
with what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/adi/adin1110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 8b4ef5121308..0713f1e2c7f3 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -11,10 +11,10 @@
 #include <linux/crc8.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/gpio/consumer.h>
 #include <linux/if_bridge.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
-#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/mii.h>
 #include <linux/module.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


