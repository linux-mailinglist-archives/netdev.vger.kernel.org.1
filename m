Return-Path: <netdev+bounces-283730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GSnNuFO+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:46:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F5E4B992B
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA38730060A6
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5CB31326C;
	Mon,  4 May 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjVPwiCu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067F2E06EA;
	Mon,  4 May 2026 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880777; cv=none; b=QWQGe5UgU571aJFSLJbm023mNOdNdbbxwCHQSi40p/Rq2GGHDOIyWFgh5XrQnk+/25ECei4qVytGqxx53iMsqGOm+fhjuKAg13Bl+cS/MM9fYy/XdMYnr/ZkEayfSoqL+qW4obLRTgsYD7VeyJMfXhykKMxeeEcYi5VnaqFwVG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880777; c=relaxed/simple;
	bh=aWh5XPV7NxPO7wbXrBkRLohQeAHIEWt6E/0ZBfVhZUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl3PTFlR17eeKeAFGPmRmwaM9gabZPai0X6JPbi0w14bd7QGmU8TKNYrlV5A0bieeZG5nKa45fmKwsb6HHmZ9OZysl5A0f1CpgO0xQYuZmYj7oMEYl4bwvw3ksWMCSvPwwJhQC4k0GP566k+/yZh0y9GgigTX+b3oeOmDMHrbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjVPwiCu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777880777; x=1809416777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aWh5XPV7NxPO7wbXrBkRLohQeAHIEWt6E/0ZBfVhZUk=;
  b=DjVPwiCuFC/fx8TG7XqTcP/1i9G5TyvqzJEAnaAfFiT7VD+zSlTQjDTi
   sEV+LFcDt2aSRBb4brqPp03etHOLmJtKKcsqiL6FHbTTsBRDkQpQlFR4I
   m6GmDSaKTlwycxrdrQrG4ZFd7j4P43HWgPwXL7OIzhb4N0K4saQIG5kfN
   goDXGye3XB+OPKS/YLPoH6UnUQCRCORZ58NNGt6DZv69mPgBwdWLmBidC
   bp4kmWtkBYkk/E6j0XD1ab5J0o2IKzEP3AWNbEZ0eWfOviSk370On451U
   P8VkkHyZD/JKdYWmb+veeDWaJbSTDAgTTv+q5QhaaRDoOtLnrQ59qJnMH
   A==;
X-CSE-ConnectionGUID: 9NmMcjyzQ52GnezBzziAfw==
X-CSE-MsgGUID: nIPmzIawTYmoKiUOqFnAWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78440487"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78440487"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:46:15 -0700
X-CSE-ConnectionGUID: 6jRoQb+0Sm2+6T8mAGzI/w==
X-CSE-MsgGUID: twPWmymxT7GJv2NC7zIGDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="235704821"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 04 May 2026 00:46:12 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 144B19D; Mon, 04 May 2026 09:46:11 +0200 (CEST)
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
Subject: [PATCH net-next v1 3/5] net/fsl: xgmac_mdio: Switch to using fwnode_mdiobus_register()
Date: Mon,  4 May 2026 09:29:54 +0200
Message-ID: <20260504074610.40799-4-andriy.shevchenko@linux.intel.com>
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
X-Rspamd-Queue-Id: C1F5E4B992B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283730-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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

Replace custom implementation of fwnode_mdiobus_register().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/freescale/xgmac_mdio.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/xgmac_mdio.c b/drivers/net/ethernet/freescale/xgmac_mdio.c
index 65dc07d0df0f..b63c8a3d6daf 100644
--- a/drivers/net/ethernet/freescale/xgmac_mdio.c
+++ b/drivers/net/ethernet/freescale/xgmac_mdio.c
@@ -13,14 +13,13 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/acpi_mdio.h>
 #include <linux/clk.h>
+#include <linux/fwnode_mdio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mdio.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_mdio.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -370,7 +369,7 @@ static void xgmac_mdio_set_suppress_preamble(struct mii_bus *bus)
 
 static int xgmac_mdio_probe(struct platform_device *pdev)
 {
-	struct fwnode_handle *fwnode;
+	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
 	struct mdio_fsl_priv *priv;
 	struct resource *res;
 	struct mii_bus *bus;
@@ -422,13 +421,7 @@ static int xgmac_mdio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	fwnode = dev_fwnode(&pdev->dev);
-	if (is_of_node(fwnode))
-		ret = of_mdiobus_register(bus, to_of_node(fwnode));
-	else if (is_acpi_node(fwnode))
-		ret = acpi_mdiobus_register(bus, fwnode);
-	else
-		ret = -EINVAL;
+	ret = fwnode_mdiobus_register(bus, fwnode);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot register MDIO bus\n");
 		return ret;
-- 
2.50.1


