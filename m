Return-Path: <netdev+bounces-283728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCtaI9tP+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:50:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F42004B9A51
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A886301F9D3
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3402853FD;
	Mon,  4 May 2026 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNgYU/QE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DC3033EC;
	Mon,  4 May 2026 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880776; cv=none; b=qkiNZ4XzMLsmLr/2BDEoLpRbmc1CFQK0am5TotCQyoRLTtJha+bGy5myX4di4imjdI/aR+EdIaGdXlS4BegdlNGsiRSmPygAVQf1DrNF/vf2tNXeV8g6v87KHMCwlepLSaGJDTW54+419imeSrihZHTf4Y3EA+oW3U7uM4WRE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880776; c=relaxed/simple;
	bh=vMfNyKMONRyqw8j3XQar6RdcrR5te7y/VqOgX1PiZkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPywf7a2DldLpdRVdby9HtPDr+C8YskAsdqfTmqCcnnt7/21vyi7OrDynYSyAd3rowkOsFurZGEk85qrqrQzHjN9LcjUCLeV8CpErsdXzTe5ncFz1NrkDdZciE2ttd9Ij9dBDAUBz8nhr7RnMbTY9BWiC1lUyoPumoC00a1z+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNgYU/QE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777880775; x=1809416775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vMfNyKMONRyqw8j3XQar6RdcrR5te7y/VqOgX1PiZkY=;
  b=MNgYU/QESt0trFTM8FdT4N6ds+i/X/DYEoaXOHq0rwLN7/FK5VQo0CX4
   cvPY5IyokKqJ2EEZRNwPAy0PYUcDYV+7EhMe+r2ZhbHTPT6LuyIfjKfHA
   x7wBZrQZFuK1E7JhqFJFNU6U0AMlLsH8HdNgkljPHlz/NWOO3ztJ+0+cN
   wNWiEqW+js90WqiCAMgmsliYfLaPhykrXAeCJCHKLYFxMP3ouI5y+Ejyo
   GMpTaRwwF829LwOtu5NFV81pcu5aumkUjuKYjHUzyvdVWj/wLjDqnfYae
   rQbM8AhbRGBXqqXrAltNV6EN39dYRi6W1uYAwMVmcmq0h6No9Ix8iosYf
   A==;
X-CSE-ConnectionGUID: g/CU+8UBRQqIMj3/pTgnOQ==
X-CSE-MsgGUID: GDuGVhhtQ3ClEaRHZ9w6Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78440504"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78440504"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:46:15 -0700
X-CSE-ConnectionGUID: oPrfcMxJRmeNo0CJ7Tomzw==
X-CSE-MsgGUID: d8XAqoliSZC4NkvG4XZngg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="235704823"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 04 May 2026 00:46:12 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 18B439E; Mon, 04 May 2026 09:46:11 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v1 4/5] net/fsl: xgmac_mdio: Reuse existing pointer to fwnode
Date: Mon,  4 May 2026 09:29:55 +0200
Message-ID: <20260504074610.40799-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260504074610.40799-1-andriy.shevchenko@linux.intel.com>
References: <20260504074610.40799-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F42004B9A51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283728-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]

The probe function has already been using pointer to fwnode.
Reuse it instead of doing this several times.

While at it, amend the header inclusions regarding to the used APIs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/freescale/xgmac_mdio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/xgmac_mdio.c b/drivers/net/ethernet/freescale/xgmac_mdio.c
index b63c8a3d6daf..f31c36b8ec98 100644
--- a/drivers/net/ethernet/freescale/xgmac_mdio.c
+++ b/drivers/net/ethernet/freescale/xgmac_mdio.c
@@ -12,16 +12,16 @@
  * kind, whether express or implied.
  */
 
-#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/fwnode_mdio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mdio.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 /* Number of microseconds to wait for a register to respond */
@@ -407,12 +407,12 @@ static int xgmac_mdio_probe(struct platform_device *pdev)
 	/* For both ACPI and DT cases, endianness of MDIO controller
 	 * needs to be specified using "little-endian" property.
 	 */
-	priv->is_little_endian = device_property_read_bool(&pdev->dev,
+	priv->is_little_endian = fwnode_property_read_bool(fwnode,
 							   "little-endian");
 
-	priv->has_a009885 = device_property_read_bool(&pdev->dev,
+	priv->has_a009885 = fwnode_property_read_bool(fwnode,
 						      "fsl,erratum-a009885");
-	priv->has_a011043 = device_property_read_bool(&pdev->dev,
+	priv->has_a011043 = fwnode_property_read_bool(fwnode,
 						      "fsl,erratum-a011043");
 
 	xgmac_mdio_set_suppress_preamble(bus);
-- 
2.50.1


