Return-Path: <netdev+bounces-283732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD+kCQNP+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:47:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD984B9954
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58529300B5B2
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971F0315D33;
	Mon,  4 May 2026 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CidCTsQp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6A4313283;
	Mon,  4 May 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880779; cv=none; b=JJxFp08uR8AuV9LLngdgx9T0kwqgT/y9nT/HHxpU8x0WcbksiamzvlJfJ4QBJDSGdTYS0BECF0hOO5If10SVR88IzxQt94DqxXPi1Qlq24QOz7ituIM51yj3rsHvrGEW8CGKvsWBTSUtXZZsUkCTTpl26uEyUHqXEBQlKbcXdEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880779; c=relaxed/simple;
	bh=hRoH7UJKUSaguJukQsRvVJDD5jLQpLyatbwN1cfqG1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYY/uhfz5yV85opJR5/EeGhMZCN9AdHMGn6C3R9NzG2cKNrqgR6qi5o+8hT6rdqMPdQULazCsO7ARe2uNCDDtXxjcMgZOL7C4eEkf23Jg6qUyB0k3Bn9w5jN20ZqrG8MEJ4NF07GLYEzq3JI5/QRCne6DmK4NibmhuboQCX4zE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CidCTsQp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777880778; x=1809416778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hRoH7UJKUSaguJukQsRvVJDD5jLQpLyatbwN1cfqG1Y=;
  b=CidCTsQpMPTTORu33ZTwMcPk0Nx1w8scLnO6Xh39QLbjgmK/t8Hd9aMo
   XEZjXKtqmkamLWCmVMQOh7nS3cdVwe0oLy7HZ5o53jsv1KwWOJ/0ktnV0
   5Zjzy/meMaWA/5sqMHn/JPxtJxLcQ67WNJK6ckbDpm2jiBykaCF9JfaNu
   zwSgLI84ecKlxIAf63lRHOrqczTW+YFgCHizH1gt80X8/RGxysPJQ/VbL
   DddeEcLalo/LuHESYi4ejjUSNc+0z1Yrhm7T2CfBqG2XuqFCsWx/0j3H5
   88AD1Ci5AcVX4Fn7fvIFAhqgb91uvtSBVHijHj41F8805dO3psfcPir37
   A==;
X-CSE-ConnectionGUID: qMPoVrPsTfat0HUXhLugeA==
X-CSE-MsgGUID: 5tKSovcSTwGYovaRzSdhTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78440514"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78440514"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:46:15 -0700
X-CSE-ConnectionGUID: WzO3z+zRTMq8iFFQ8/O+Rw==
X-CSE-MsgGUID: X7ptk3A1RlKYVpEhnn0Gnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="235704824"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 04 May 2026 00:46:12 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0B72099; Mon, 04 May 2026 09:46:11 +0200 (CEST)
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
Subject: [PATCH net-next v1 1/5] net: mdiobus: Provide fwnode_mdiobus_register()
Date: Mon,  4 May 2026 09:29:52 +0200
Message-ID: <20260504074610.40799-2-andriy.shevchenko@linux.intel.com>
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
X-Rspamd-Queue-Id: BDD984B9954
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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

Provide an agnostic helper to register MDIO bus independently on
the firmware node provider.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/mdio/fwnode_mdio.c | 15 +++++++++++++++
 include/linux/fwnode_mdio.h    | 17 +++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index ba7091518265..7541df43ba6d 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -7,9 +7,11 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/acpi_mdio.h>
 #include <linux/dev_printk.h>
 #include <linux/fwnode_mdio.h>
 #include <linux/of.h>
+#include <linux/of_mdio.h>
 #include <linux/phy.h>
 #include <linux/pse-pd/pse.h>
 
@@ -187,3 +189,16 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 	return rc;
 }
 EXPORT_SYMBOL(fwnode_mdiobus_register_phy);
+
+int __fwnode_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle *fwnode,
+			      struct module *owner)
+{
+	if (is_of_node(fwnode))
+		return __of_mdiobus_register(mdio, to_of_node(fwnode), owner);
+
+	if (is_acpi_node(fwnode))
+		return __acpi_mdiobus_register(mdio, fwnode, owner);
+
+	return mdiobus_register(mdio);
+}
+EXPORT_SYMBOL(__fwnode_mdiobus_register);
diff --git a/include/linux/fwnode_mdio.h b/include/linux/fwnode_mdio.h
index faf603c48c86..c316b738333a 100644
--- a/include/linux/fwnode_mdio.h
+++ b/include/linux/fwnode_mdio.h
@@ -16,6 +16,14 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 				struct fwnode_handle *child, u32 addr);
 
+int __fwnode_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle *fwnode,
+			      struct module *owner);
+
+static inline int
+fwnode_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle *fwnode)
+{
+	return __fwnode_mdiobus_register(mdio, fwnode, THIS_MODULE);
+}
 #else /* CONFIG_FWNODE_MDIO */
 int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 				       struct phy_device *phy,
@@ -30,6 +38,15 @@ static inline int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 {
 	return -EINVAL;
 }
+
+static inline int fwnode_mdiobus_register(struct mii_bus *mdio, struct
+					  fwnode_handle *fwnode)
+{
+	/* Fall back to mdiobus_register() function to register a bus.
+	 * This way, we don't have to keep compat bits around in drivers.
+	 */
+	return mdiobus_register(mdio);
+}
 #endif
 
 #endif /* __LINUX_FWNODE_MDIO_H */
-- 
2.50.1


