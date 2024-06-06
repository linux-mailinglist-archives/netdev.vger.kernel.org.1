Return-Path: <netdev+bounces-101510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C15CC8FF238
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 18:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503D61F23C5A
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0596319883B;
	Thu,  6 Jun 2024 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="allw4ZzG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D678197A8E;
	Thu,  6 Jun 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690441; cv=none; b=q/0BrzVrlsPIsRSeU4rHdT4FdLDs+/yJyHi+qcxKLk+LSGRjH4o8cnBAmU6c5vExJYiZf4exI9gyz96jIeBVr+rQxpPkYYbyoCVEBhdmG02btUultiHa4+YNORv367t8vE7WiaOloszL7EF+kMPDP/4w6IQ6MRDWHHmNUyns11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690441; c=relaxed/simple;
	bh=mepfrNbOi1hjCED03erLNzGsbXFr7ZtXsrXGV+VfSkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/uD0Nw+TG899MRlkY2WeZKBFbZ2yqRBGMjGPtPI0JepJ9FSxGOZG0iDdCl4IBeiupnqM+ZucUGAWJsxaF3tvRhM5H2VMYyHSu1amMW9hrgaHj1fieWKwE18Vc5C/jWkjfNdCPrUDlfSvqbHA7YZ2VKvl+p1lNPQLL0j+RUBGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=allw4ZzG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717690441; x=1749226441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mepfrNbOi1hjCED03erLNzGsbXFr7ZtXsrXGV+VfSkE=;
  b=allw4ZzG9dCLruX3QSeJ27GPXXNPocZl33OHtv1DSw4Yqbn8G1v6HrhJ
   4XME/z57B7nrDZnj6FdjRycdIH1fXUnVYUyragm3396vcYjYRHm1KknLU
   gLvigysdXUw8B6yobO3Hf3+7YUWgAjBCvrukRajE6GRAie7SRxeitY4wj
   Yf5Psn7XLO3PodG7pzl7cTMr9cgS7mM3xqAclh5Jb7jbS63ZcyFMQKbcg
   Yspg3glCAgTF1rNS6ypteaRSX0eNk0x/CkU8QpyGWaUmXmVVLJH41LZJH
   1Te0zF/37Y9FJj7g0C3eZUejpA7b348FFNw5InR+L0t/pbKTJ/TiZ4Qba
   g==;
X-CSE-ConnectionGUID: LJc+yDRKQkCJsNNI0odPQg==
X-CSE-MsgGUID: kjjpNWCbTv6KAtOoEAtS/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14209121"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14209121"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:14:00 -0700
X-CSE-ConnectionGUID: /1J96yc2SHy24HaVEMjz5A==
X-CSE-MsgGUID: zr937IJ1Stuu9jUW7IS4QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="68810250"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 06 Jun 2024 09:13:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0FFE62A4; Thu, 06 Jun 2024 19:13:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 1/1] net dsa: qca8k: fix usages of device_get_named_child_node()
Date: Thu,  6 Jun 2024 19:13:03 +0300
Message-ID: <20240606161354.2987218-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for device_get_named_child_node() mentions this
important point:

"
The caller is responsible for calling fwnode_handle_put() on the
returned fwnode pointer.
"

Add fwnode_handle_put() to avoid leaked references.

Fixes: 1e264f9d2918 ("net: dsa: qca8k: add LEDs basic support")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added one missed call (Jacub), added tag (Simon)
 drivers/net/dsa/qca/qca8k-leds.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index 811ebeeff4ed..43ac68052baf 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -431,8 +431,11 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
 		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d",
 						 priv->internal_mdio_bus->id,
 						 port_num);
-		if (!init_data.devicename)
+		if (!init_data.devicename) {
+			fwnode_handle_put(led);
+			fwnode_handle_put(leds);
 			return -ENOMEM;
+		}
 
 		ret = devm_led_classdev_register_ext(priv->dev, &port_led->cdev, &init_data);
 		if (ret)
@@ -441,6 +444,7 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
 		kfree(init_data.devicename);
 	}
 
+	fwnode_handle_put(leds);
 	return 0;
 }
 
@@ -471,9 +475,13 @@ qca8k_setup_led_ctrl(struct qca8k_priv *priv)
 		 * the correct port for LED setup.
 		 */
 		ret = qca8k_parse_port_leds(priv, port, qca8k_port_to_phy(port_num));
-		if (ret)
+		if (ret) {
+			fwnode_handle_put(port);
+			fwnode_handle_put(ports);
 			return ret;
+		}
 	}
 
+	fwnode_handle_put(ports);
 	return 0;
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac


