Return-Path: <netdev+bounces-100674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955BB8FB8A6
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E707282CE7
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C904147C98;
	Tue,  4 Jun 2024 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRse4xFr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9399913D635;
	Tue,  4 Jun 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517781; cv=none; b=kn5Pdw+XilYtcnAZ8dWzujIEIhI+4WQ4WKj7kGu+w/zx6bzyEUyqH3ciieQkE4D3NPMEIV28l6uiNb7fBgTrk4e19agsRjCJvIowu8nCfp6aWAIk7itZVK5zDIs+GhOQGM4gS2TzV+Pa0wrf/d9JZWPIDMJEh6rjXkaTzgGoWp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517781; c=relaxed/simple;
	bh=XYwRliGG6vqwmqRscOEguPLD97v+obXl0lmknTVhOmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCoxELoJZscVBwgiQt79YRiwcQvzVsCl0PGIlXRgWj13k17SrFjKwIfs75TGKHE1tx9t5gJqaUSq8k5JCGdgNSHBgA1Mx5lsI136GzuifH1UheuBE4Z7O3PIPkkXHHVssA/+xCTUsYz4HPNaEWgD5BivSqUvoR5291rFTEYczmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRse4xFr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717517780; x=1749053780;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XYwRliGG6vqwmqRscOEguPLD97v+obXl0lmknTVhOmU=;
  b=hRse4xFrx9hvlmVeY5JYqBRgh4uN+o1N7FjbAVqUhrFNtfp9BNxVdTdl
   RQcDhRTW0XdzmvP4JnJVBaKEJCJETDrE/C3McC5b/aP+I0oB3J5y5XuhN
   UY7cHsCr5UJckSAphbS6VIiljCDCZL9R4k4HAgm+j7Wgmhbs9Ypox6Vd1
   KcA8LvtTs3VVP5schKjkKzfPDC39YlRUGPpsp4mvfpxQSqFj/5o111qEF
   sFhqxW0mvJEzzSqVdrYoa6XQJh1JhFW4jDqW2eKZzMkYnKakh7vUXQYya
   P7c/aWyM7PkxVqfXz0+nEHJNd+d5aP3JEH4o3wov/GzhLXF0+Qc5aGjtb
   g==;
X-CSE-ConnectionGUID: 6CNgZH53Qs2WUhPoyTLBGg==
X-CSE-MsgGUID: b1/wSVvBQGuWWjuoQ5h7rQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13919490"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="13919490"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:16:03 -0700
X-CSE-ConnectionGUID: 7fkVkoAPR1a+blKuqpTKQA==
X-CSE-MsgGUID: YOlWfs+USnOPzP+FZEWsSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="42400135"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 04 Jun 2024 09:15:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1948A2DC; Tue, 04 Jun 2024 19:15:57 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net v1 1/1] net dsa: qca8k: fix usages of device_get_named_child_node()
Date: Tue,  4 Jun 2024 19:15:51 +0300
Message-ID: <20240604161551.2409910-1-andriy.shevchenko@linux.intel.com>
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
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/dsa/qca/qca8k-leds.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index 811ebeeff4ed..ef529615237c 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -431,8 +431,10 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
 		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d",
 						 priv->internal_mdio_bus->id,
 						 port_num);
-		if (!init_data.devicename)
+		if (!init_data.devicename) {
+			fwnode_handle_put(leds);
 			return -ENOMEM;
+		}
 
 		ret = devm_led_classdev_register_ext(priv->dev, &port_led->cdev, &init_data);
 		if (ret)
@@ -441,6 +443,7 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
 		kfree(init_data.devicename);
 	}
 
+	fwnode_handle_put(leds);
 	return 0;
 }
 
@@ -471,9 +474,13 @@ qca8k_setup_led_ctrl(struct qca8k_priv *priv)
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


