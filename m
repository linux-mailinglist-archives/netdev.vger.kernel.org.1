Return-Path: <netdev+bounces-283733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJxtFSxQ+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:52:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B60514B9A83
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55FB1304854D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F793164AA;
	Mon,  4 May 2026 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhSiJ/I2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5D313550;
	Mon,  4 May 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880779; cv=none; b=tyzaAIKC5H58POgCarQ4p3+pKz6THmWun++JlXPIj2vhIPpx9X9rF8qEeAnVgw5pm/z3sLh2EEWqT8mjz6l8w9eHwdrdpXao9ZsduTVuU6h+Kcbk4Ty1m6+uotQ1h0mwcwWX87nePIvq3jF+1b3YAnmoH5F3myLBL+jGvGIZmRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880779; c=relaxed/simple;
	bh=eWiDafMQMwRC0nyxBxxmZNLd3sCsMtlXeVrSMMmVBAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/sxVXEr1J3ANv3ylhwBChU6HCRSZuyFoKGy8muC52W0CyJacI1ms7Sia4o4Xl28Ic1FjRbCaGcgxf+sYpfcBT0Ad6pLqE96vDl4DTO5CeEsKsNjSQ/OzYfOwznv7CDThYmfFefGC2XkXeKEdIkdOdEg7c9p4yWBbjqwPVS+9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhSiJ/I2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777880779; x=1809416779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eWiDafMQMwRC0nyxBxxmZNLd3sCsMtlXeVrSMMmVBAE=;
  b=dhSiJ/I2RmXFlpV94836cdfVm3IYgmZjwHc8KODT82QNhTpcX6oy02LT
   VFwy+9sPbAEOHnxaB3kcQqO2zsoHAaNBgfkpGD26wI4WFGFTdFp73SDK2
   Uxf0Z9qrAATRUXc6cCB68T/FYg3GBPDmi+92tMGDKNTYe1S/6RrhMw0V1
   /NOeq3ap5D+v0gw0qXgvko/QC1ikBlxkMw4axDzGWePKcu4bN4yC6AWrS
   MrNEljauczFxFy0k2zTMvV8neaUIMKxq8eo804pR8W0Kq1TbQWidt3asZ
   8o91PB/i92CY+6hDPFLGqFShwS7MrM/fzmZzGXyW45iEDhgJbFenYxPKI
   Q==;
X-CSE-ConnectionGUID: AmHDv1TsT4yFTxPdvRsupA==
X-CSE-MsgGUID: +NKOiiGSR1qexWcMt8RlSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78440521"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78440521"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:46:18 -0700
X-CSE-ConnectionGUID: bfddln0cS+uladE+iBUOcw==
X-CSE-MsgGUID: EW+dhHYPTM6O19SrD5x8XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="235704841"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 04 May 2026 00:46:15 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 1CB81A1; Mon, 04 May 2026 09:46:11 +0200 (CEST)
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
Subject: [PATCH net-next v1 5/5] net: mdiobus: Hide acpi_mdio.h
Date: Mon,  4 May 2026 09:29:56 +0200
Message-ID: <20260504074610.40799-6-andriy.shevchenko@linux.intel.com>
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
X-Rspamd-Queue-Id: B60514B9A83
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
	TAGGED_FROM(0.00)[bounces-283733-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]

No more users outside of MDIO framework.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/mdio/acpi_mdio.c   |  3 ++-
 drivers/net/mdio/fwnode_mdio.c |  3 ++-
 drivers/net/mdio/mdio.h        |  4 ++++
 include/linux/acpi_mdio.h      | 33 ---------------------------------
 4 files changed, 8 insertions(+), 35 deletions(-)
 create mode 100644 drivers/net/mdio/mdio.h
 delete mode 100644 include/linux/acpi_mdio.h

diff --git a/drivers/net/mdio/acpi_mdio.c b/drivers/net/mdio/acpi_mdio.c
index 5d0f11f280cf..15c3fc05fad5 100644
--- a/drivers/net/mdio/acpi_mdio.c
+++ b/drivers/net/mdio/acpi_mdio.c
@@ -7,13 +7,14 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/acpi_mdio.h>
 #include <linux/bits.h>
 #include <linux/dev_printk.h>
 #include <linux/fwnode_mdio.h>
 #include <linux/module.h>
 #include <linux/types.h>
 
+#include "mdio.h"
+
 MODULE_AUTHOR("Calvin Johnson <calvin.johnson@oss.nxp.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ACPI MDIO bus (Ethernet PHY) accessors");
diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 7541df43ba6d..610753d55262 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/acpi_mdio.h>
 #include <linux/dev_printk.h>
 #include <linux/fwnode_mdio.h>
 #include <linux/of.h>
@@ -15,6 +14,8 @@
 #include <linux/phy.h>
 #include <linux/pse-pd/pse.h>
 
+#include "mdio.h"
+
 MODULE_AUTHOR("Calvin Johnson <calvin.johnson@oss.nxp.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("FWNODE MDIO bus (Ethernet PHY) accessors");
diff --git a/drivers/net/mdio/mdio.h b/drivers/net/mdio/mdio.h
new file mode 100644
index 000000000000..c053bb05368a
--- /dev/null
+++ b/drivers/net/mdio/mdio.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+int __acpi_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle *fwnode,
+			    struct module *owner);
diff --git a/include/linux/acpi_mdio.h b/include/linux/acpi_mdio.h
deleted file mode 100644
index 8e2eefa9fbc0..000000000000
--- a/include/linux/acpi_mdio.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * ACPI helper for the MDIO (Ethernet PHY) API
- */
-
-#ifndef __LINUX_ACPI_MDIO_H
-#define __LINUX_ACPI_MDIO_H
-
-#include <linux/phy.h>
-
-#if IS_ENABLED(CONFIG_ACPI_MDIO)
-int __acpi_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle *fwnode,
-			    struct module *owner);
-
-static inline int
-acpi_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle *handle)
-{
-	return __acpi_mdiobus_register(mdio, handle, THIS_MODULE);
-}
-#else /* CONFIG_ACPI_MDIO */
-static inline int
-acpi_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle *fwnode)
-{
-	/*
-	 * Fall back to mdiobus_register() function to register a bus.
-	 * This way, we don't have to keep compat bits around in drivers.
-	 */
-
-	return mdiobus_register(mdio);
-}
-#endif
-
-#endif /* __LINUX_ACPI_MDIO_H */
-- 
2.50.1


