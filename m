Return-Path: <netdev+bounces-31055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A0E78B1B7
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FFA280DF9
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90A0125DB;
	Mon, 28 Aug 2023 13:23:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7C3125D8
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 13:23:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA8112D;
	Mon, 28 Aug 2023 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693228964; x=1724764964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D5MgsKcpX/FPTPvHOLU70qPy9lFMe+MChaL85o2pA8g=;
  b=kM8qNFu/zJnL7dvWh1k17IR5zzLXFgxed14B/jNXd0D31OeVXEgLuYj2
   hls6U4hdEtd14juSWciKZsmGnmbWVLLhIeaIDZ0+EwsRr/p0Si7vpXq3h
   JRBmiSnHPYbTqYr7F6cy5R+vAx+w6u7+nzpy44SxYay0iD+uOQuZ1orDd
   aPX28GAbEkRTHaG+uYgbkMD4ytda73C3YXgQwQhWkYLdxAvdABAwTnB0J
   cUMwxy69FAMHfQEFgo+v52pJTdLqNiWGLKfvP3gYaeKFa+x5PjpR0Ej9v
   RJet8bLfABAmWbFQq9DSV9Gy3rXloExI2xejf1YX+IFQolyHEjrLQTkQF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="365302859"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="365302859"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 06:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="861837363"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="861837363"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 Aug 2023 06:20:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BE776241; Mon, 28 Aug 2023 16:20:00 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: haozhe chang <haozhe.chang@mediatek.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] wwan: core: Use the bitmap API to allocate bitmaps
Date: Mon, 28 Aug 2023 16:19:53 +0300
Message-Id: <20230828131953.3721392-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
It is less verbose and it improves the type checking and semantic.

While at it, add missing header inclusion (should be bitops.h,
but with the above change it becomes bitmap.h).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/wwan/wwan_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 284ab1f56391..87df60916960 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2021, Linaro Ltd <loic.poulain@linaro.org> */
 
+#include <linux/bitmap.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/debugfs.h>
@@ -395,7 +396,7 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
 	char buf[0x20];
 	int id;
 
-	idmap = (unsigned long *)get_zeroed_page(GFP_KERNEL);
+	idmap = bitmap_zalloc(max_ports, GFP_KERNEL);
 	if (!idmap)
 		return -ENOMEM;
 
@@ -414,7 +415,7 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
 
 	/* Allocate unique id */
 	id = find_first_zero_bit(idmap, max_ports);
-	free_page((unsigned long)idmap);
+	bitmap_free(idmap);
 
 	snprintf(buf, sizeof(buf), fmt, id);	/* Name generation */
 
-- 
2.40.0.1.gaa8946217a0b


