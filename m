Return-Path: <netdev+bounces-252646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBGuBjYac2mwsAAAu9opvQ
	(envelope-from <netdev+bounces-252646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:50:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 618A871262
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08EA33009517
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 06:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B2306B0A;
	Fri, 23 Jan 2026 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2u1kd+Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2F27874F
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 06:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151027; cv=none; b=Nsw1M6+RkLVkyWDaZyaVsg3lMnd9bQMciwwRhIxv37uEcPXJyWq4H1rJbjK/O5TW3VXuO4r2TWH4j1ZXK6618UpCXfOkvE8L6d0hYc46cxoocV8ThiS9X1ihSSZwUzPv26MnWqAU58/Bp9ft1A/1zo7ECtVDNaYDqrFRNrCKonI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151027; c=relaxed/simple;
	bh=Cjq501TqzlpFBUsSmvLVd6/SvO21X7q3Hg3RhKecv6Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=e57GRAYKbFuC8bvsla5sNtCuvuLsqYKWfF8Cka0gc2FGpvLaNYBy1orjW6BNopUn1v3y9g/Fi2pJg3HFRxvIiyKn4toaIwCXV96nIZ8ck1IHO6sGN1oDHxmrvVsZsIEP+QdIbFzC6xQNCATRtWl3VO9RcV17D1JLYzqetQqfNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2u1kd+Q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso18083555e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 22:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769151023; x=1769755823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6spVyNehIjk6wRL49yQ2CMhgFp4/M9ZJ4dRKB7aua58=;
        b=C2u1kd+Qs/5mkFSeEZpwIGV8MH1YjdIIZcYYhw8r80fqwqLt29OILRaP81M7N/JmZi
         tr1DfqdfRS6oc2PxhukGyLinwBpg8qLXoZne/7gp0RO4/po6mFXf2eSI7H6WjLoUXlCo
         P1wOL43Z/qP0dKf6yZaFkgO5lyT+jTRq2qjMpEwO/2/vhATXaZdnVFrfFCzsQoXOdo9s
         pOlI17hsI5ld2wMqGylnK1ILfyBYsDhqLU7g4hSyOJc8D3YQBETWoDlcIAa6w/R1fDLE
         4sbtWlnIaT4+Qj2WJ0irgfU30u2nKixcVNsWOjn0VTcP98cLgZ35LVNxJlYWQu5jJvSq
         JREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769151023; x=1769755823;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6spVyNehIjk6wRL49yQ2CMhgFp4/M9ZJ4dRKB7aua58=;
        b=YmysPtKSz15k3Vqc6I2Yhi0N5/+5lNHXFYxb/glsrQBVryQzhlY0ggrObPYOrPIgux
         T+/sLpjUvPZFmP3I1Z4/P7cX9a9Gk7pKhRKDGccGX8vrrjth1m70fsBrIkh3YYBNKuHf
         NTeMjYywe0Z33U1S0n5r8dazjOuN3VzW5E499xy5VbpjtMdQxiVnx008agZQwHIQ20Dj
         xgwwwENX3+QL2HTRZ222Sjl3C7xKYawxIrf4WDJfXJ5wpqA5StO9ohuKUpvhOLK28Lzx
         A86UxUe+uBXX9HyGrHsn3rphqINOAytfegE+MM8zLkNkSVOedX+hRN9UMZ/S40xgeV5j
         L0pQ==
X-Gm-Message-State: AOJu0YymspeqM/cFmGo+wNw49Kf393e7ZcFIS7QOVXEWCeLWVkuNIWrU
	SpMrC3lTJO3z7+1SvN5qUNIdnTok8L8fNaQbPNG3pobUlgdxSdof0fr9
X-Gm-Gg: AZuq6aIAvH4Hih0r98bAUA1c5EfHA9r9vaTxTn7phcRW7NQrUm+YFCOVwmFOd9ZhKXl
	9ucFrQ0ZPYDh0wDIGiYq4L1QotfdTM6z4Fe2Hl71ih7To46cyDf7V8/J9L69kaBx38FBL6UMF96
	m6lDDnSynRVxhRE3t061BzPzQm67PFYYkJFXEofibyBubu1dltE1okQb/OsOZIJgI1Cpt1sWhMS
	HiXBH90/M96EJ5CntsFz1+dZMK1KGkfcVQ6Oq7W+2czUDxtD2hbXlaVokXVFv2wzWxNAfqocvx0
	GZ93OragsOPGFYookBLDLnNmWKW9Mo0UJx2Gwg7eGgMlc8HMMcMzEmmHAsVCIde+88L8IlWgiqb
	5+47O+HnZpcOsZIdGLYBIQkN9aXpc9Iz+xmVFqj0TJKzGMbSOo95v3DyDmkxE4mdNcx1Rp/U/YU
	Fmu9BL8mujqmxgw3auCGvtdNuWatIHv22cxO5CI1VoGnnu8DfUVuPmAm1tbkKvdZoB8UsDefEcf
	ydE+h6f0L1rgMIgJYyPmvJ4qkDb6bZwpmqEtXXdz3INOoNvibSxRA==
X-Received: by 2002:a05:600c:3f0f:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-480512676fcmr5302075e9.35.1769151023314;
        Thu, 22 Jan 2026 22:50:23 -0800 (PST)
Received: from ?IPV6:2003:ea:8f45:2d00:e509:e5ce:fa2e:3b01? (p200300ea8f452d00e509e5cefa2e3b01.dip0.t-ipconnect.de. [2003:ea:8f45:2d00:e509:e5ce:fa2e:3b01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470bfe88sm110331655e9.11.2026.01.22.22.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 22:50:22 -0800 (PST)
Message-ID: <800595c6-496a-443e-92e3-37251195e610@gmail.com>
Date: Fri, 23 Jan 2026 07:50:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: make PHY fixup support always built-in
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 618A871262
X-Rspamd-Action: no action

PHY fixup registration is used from platform code in init phase only.
Let's move the PHY fixup code from the modular part of phylib to the
always built-in part of phylib. This allows to annotate the fixup
registration as __init.

phy_needs_fixup() and phy_scan_fixups() wouldn't have to be moved to
the built-in part of phylib. But doing so allows to fully factor out
fixup support into its own source code file, and make struct
phy_fixup and phy_fixup_list strictly private to phy_fixup.c.

phy_scan_fixups() is used after init phase only, then phy_fixup_list
is read-only. So we don't need the mutex when accessing the list.
Also when registering PHY fixups the mutex isn't needed, because
fixup registration is done sequentially from platform init code.
Actually there is only one platform with more than one fixup.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/Makefile          |   2 +-
 drivers/net/phy/phy_device.c      |  90 --------------------------
 drivers/net/phy/phy_fixup.c       | 101 ++++++++++++++++++++++++++++++
 drivers/net/phy/phylib-internal.h |   1 +
 include/linux/phy.h               |   8 +--
 5 files changed, 107 insertions(+), 95 deletions(-)
 create mode 100644 drivers/net/phy/phy_fixup.c

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 3a34917adea..52bbb441e87 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -8,7 +8,7 @@ mdio-bus-y			+= mdio_bus.o mdio_device.o
 
 ifdef CONFIG_PHYLIB
 # built-in whenever PHYLIB is built-in or module
-obj-y				+= stubs.o
+obj-y				+= stubs.o phy_fixup.o
 endif
 
 libphy-$(CONFIG_SWPHY)		+= swphy.o
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f624218bf36..7dd73a11f86 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -49,14 +49,6 @@ MODULE_DESCRIPTION("PHY library");
 MODULE_AUTHOR("Andy Fleming");
 MODULE_LICENSE("GPL");
 
-struct phy_fixup {
-	struct list_head list;
-	char bus_id[MII_BUS_ID_SIZE + 3];
-	u32 phy_uid;
-	u32 phy_uid_mask;
-	int (*run)(struct phy_device *phydev);
-};
-
 static struct phy_driver genphy_c45_driver = {
 	.phy_id         = 0xffffffff,
 	.phy_id_mask    = 0xffffffff,
@@ -237,9 +229,6 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
 
 static struct phy_driver genphy_driver;
 
-static LIST_HEAD(phy_fixup_list);
-static DEFINE_MUTEX(phy_fixup_lock);
-
 static bool phy_drv_wol_enabled(struct phy_device *phydev)
 {
 	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
@@ -427,85 +416,6 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(mdio_bus_phy_pm_ops, mdio_bus_phy_suspend,
 			 mdio_bus_phy_resume);
 
-/**
- * phy_register_fixup - creates a new phy_fixup and adds it to the list
- * @bus_id: A string which matches phydev->mdio.dev.bus_id (or NULL)
- * @phy_uid: Used to match against phydev->phy_id (the UID of the PHY)
- * @phy_uid_mask: Applied to phydev->phy_id and fixup->phy_uid before
- *	comparison (or 0 to disable id-based matching)
- * @run: The actual code to be run when a matching PHY is found
- */
-static int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
-			      int (*run)(struct phy_device *))
-{
-	struct phy_fixup *fixup = kzalloc(sizeof(*fixup), GFP_KERNEL);
-
-	if (!fixup)
-		return -ENOMEM;
-
-	if (bus_id)
-		strscpy(fixup->bus_id, bus_id, sizeof(fixup->bus_id));
-	fixup->phy_uid = phy_uid;
-	fixup->phy_uid_mask = phy_uid_mask;
-	fixup->run = run;
-
-	mutex_lock(&phy_fixup_lock);
-	list_add_tail(&fixup->list, &phy_fixup_list);
-	mutex_unlock(&phy_fixup_lock);
-
-	return 0;
-}
-
-/* Registers a fixup to be run on any PHY with the UID in phy_uid */
-int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
-			       int (*run)(struct phy_device *))
-{
-	return phy_register_fixup(NULL, phy_uid, phy_uid_mask, run);
-}
-EXPORT_SYMBOL(phy_register_fixup_for_uid);
-
-/* Registers a fixup to be run on the PHY with id string bus_id */
-int phy_register_fixup_for_id(const char *bus_id,
-			      int (*run)(struct phy_device *))
-{
-	return phy_register_fixup(bus_id, 0, 0, run);
-}
-EXPORT_SYMBOL(phy_register_fixup_for_id);
-
-static bool phy_needs_fixup(struct phy_device *phydev, struct phy_fixup *fixup)
-{
-	if (!strcmp(fixup->bus_id, phydev_name(phydev)))
-		return true;
-
-	if (fixup->phy_uid_mask &&
-	    phy_id_compare(phydev->phy_id, fixup->phy_uid, fixup->phy_uid_mask))
-		return true;
-
-	return false;
-}
-
-/* Runs any matching fixups for this phydev */
-static int phy_scan_fixups(struct phy_device *phydev)
-{
-	struct phy_fixup *fixup;
-
-	mutex_lock(&phy_fixup_lock);
-	list_for_each_entry(fixup, &phy_fixup_list, list) {
-		if (phy_needs_fixup(phydev, fixup)) {
-			int err = fixup->run(phydev);
-
-			if (err < 0) {
-				mutex_unlock(&phy_fixup_lock);
-				return err;
-			}
-			phydev->has_fixups = true;
-		}
-	}
-	mutex_unlock(&phy_fixup_lock);
-
-	return 0;
-}
-
 /**
  * genphy_match_phy_device - match a PHY device with a PHY driver
  * @phydev: target phy_device struct
diff --git a/drivers/net/phy/phy_fixup.c b/drivers/net/phy/phy_fixup.c
new file mode 100644
index 00000000000..ace78512686
--- /dev/null
+++ b/drivers/net/phy/phy_fixup.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PHY fixup support
+ */
+
+#include <linux/list.h>
+#include <linux/phy.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "phylib-internal.h"
+
+static struct list_head phy_fixup_list __ro_after_init =
+	LIST_HEAD_INIT(phy_fixup_list);
+
+struct phy_fixup {
+	struct list_head list;
+	char bus_id[MII_BUS_ID_SIZE + 3];
+	u32 phy_uid;
+	u32 phy_uid_mask;
+	int (*run)(struct phy_device *phydev);
+};
+
+/**
+ * phy_register_fixup - creates a new phy_fixup and adds it to the list
+ * @bus_id: A string which matches phydev->mdio.dev.bus_id (or PHY_ANY_ID)
+ * @phy_uid: Used to match against phydev->phy_id (the UID of the PHY)
+ *	It can also be PHY_ANY_UID
+ * @phy_uid_mask: Applied to phydev->phy_id and fixup->phy_uid before
+ *	comparison
+ * @run: The actual code to be run when a matching PHY is found
+ */
+static int __init phy_register_fixup(const char *bus_id, u32 phy_uid,
+				     u32 phy_uid_mask,
+				     int (*run)(struct phy_device *))
+{
+	struct phy_fixup *fixup = kzalloc(sizeof(*fixup), GFP_KERNEL);
+
+	if (!fixup)
+		return -ENOMEM;
+
+	if (bus_id)
+		strscpy(fixup->bus_id, bus_id, sizeof(fixup->bus_id));
+	fixup->phy_uid = phy_uid;
+	fixup->phy_uid_mask = phy_uid_mask;
+	fixup->run = run;
+
+	list_add_tail(&fixup->list, &phy_fixup_list);
+
+	return 0;
+}
+
+/* Registers a fixup to be run on any PHY with the UID in phy_uid */
+int __init phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
+				      int (*run)(struct phy_device *))
+{
+	return phy_register_fixup(NULL, phy_uid, phy_uid_mask, run);
+}
+
+/* Registers a fixup to be run on the PHY with id string bus_id */
+int __init phy_register_fixup_for_id(const char *bus_id,
+				     int (*run)(struct phy_device *))
+{
+	return phy_register_fixup(bus_id, 0, 0, run);
+}
+
+static bool phy_needs_fixup(struct phy_device *phydev, struct phy_fixup *fixup)
+{
+	if (!strcmp(fixup->bus_id, phydev_name(phydev)))
+		return true;
+
+	if (fixup->phy_uid_mask &&
+	    phy_id_compare(phydev->phy_id, fixup->phy_uid, fixup->phy_uid_mask))
+		return true;
+
+	return false;
+}
+
+/**
+ * phy_scan_fixups - runs any matching fixups for this phydev
+ * @phydev: the phydev to search and run fixups for
+ * Returns: 0 or an errno
+ */
+int phy_scan_fixups(struct phy_device *phydev)
+{
+	struct phy_fixup *fixup;
+
+	list_for_each_entry(fixup, &phy_fixup_list, list) {
+		if (phy_needs_fixup(phydev, fixup)) {
+			int err = fixup->run(phydev);
+
+			if (err < 0)
+				return err;
+
+			phydev->has_fixups = true;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(phy_scan_fixups);
diff --git a/drivers/net/phy/phylib-internal.h b/drivers/net/phy/phylib-internal.h
index dc9592c6bb8..ca3794ffe04 100644
--- a/drivers/net/phy/phylib-internal.h
+++ b/drivers/net/phy/phylib-internal.h
@@ -19,6 +19,7 @@ void of_set_phy_eee_broken(struct phy_device *phydev);
 void of_set_phy_timing_role(struct phy_device *phydev);
 int phy_speed_down_core(struct phy_device *phydev);
 void phy_check_downshift(struct phy_device *phydev);
+int phy_scan_fixups(struct phy_device *phydev);
 
 int genphy_c45_read_eee_adv(struct phy_device *phydev, unsigned long *adv);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5972f19af16..ec09159e546 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2400,10 +2400,10 @@ int phy_get_mac_termination(struct phy_device *phydev, struct device *dev,
 void phy_resolve_pause(unsigned long *local_adv, unsigned long *partner_adv,
 		       bool *tx_pause, bool *rx_pause);
 
-int phy_register_fixup_for_id(const char *bus_id,
-			      int (*run)(struct phy_device *));
-int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
-			       int (*run)(struct phy_device *));
+int __init phy_register_fixup_for_id(const char *bus_id,
+				     int (*run)(struct phy_device *));
+int __init phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
+				      int (*run)(struct phy_device *));
 
 int phy_eee_tx_clock_stop_capable(struct phy_device *phydev);
 int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable);
-- 
2.52.0


