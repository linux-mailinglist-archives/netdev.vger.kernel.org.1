Return-Path: <netdev+bounces-253055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lzjeHESKdGnO6wAAu9opvQ
	(envelope-from <netdev+bounces-253055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:00:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF747D095
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 333573009503
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789AF262A6;
	Sat, 24 Jan 2026 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGLid30E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AFD3EBF2D
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769245249; cv=none; b=u8unkLHGRcZnBEl65b+u+0IAKEtv8euhbsG2Y+DX+WclAvr5Pzq/5IhhYmdPMdgYwq0KsiSGIJC9OVfowqJnKosUcuVK28593414DN18VPKK3zF2e/6wkZ4/JityjCaV7AEFAS6hcnxSU/JHWbVvwpN4Hnz5y1l7cG3nJefzBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769245249; c=relaxed/simple;
	bh=0eoK+H4cKYrfxEwI3mobaQsXtDLDhTd0n2mvPt2g+A0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=uk3ycYoETEZwLZnuUCk13wM7i5CxDc3i2RwNWAbTJGVsKVKh9wuN1/KrbcsKwiONp+70j/IazEFTg0Z4xNLKSOQDOcMYMgZDgzRgpnVWLhXLkiJ+ROOt1lZXs+JASontMZO1JKusOzfYuO7SwQi7oddHkgQjgf1gKXo96lD/UxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGLid30E; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-435a11957f6so2416295f8f.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 01:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769245246; x=1769850046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDILHwVqt4Ir+n0QsTY0f6/lRe5Knsnyhr/HCpAIxnA=;
        b=iGLid30EkPApMLyBcebxe3icwLt5qkqOobmDtVRgSxrSi86J3oo3bm5GOUkZpxlT3Q
         qXILvY4vbpkGLr6MdtHWXE07+ms2wuc7u/KJNB8wQlHitXWTmgHCp5CUmtyc3lmKzbLK
         uEKyC02s9Z/mvLoAmEUrhGBJC92D0xCxXypDnLnTy+/C7z3kf2X3wOQlJ1QDAmLTnccF
         P3rgJjjJaOQTANb58BydC/Sfv+1N+m8jLllYgIFIAYP5elXpWcK/aUXkZc8PgjcEJCWg
         vxCBUxZeTJKpn/zHpn9tp5qMpSjCxIfjdfifJy5Xv47otZAyrpfD+hDC33q8CftWUmQT
         tr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769245246; x=1769850046;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDILHwVqt4Ir+n0QsTY0f6/lRe5Knsnyhr/HCpAIxnA=;
        b=dL5akFAPoexY8oTLxLVnu+tWzDzjBLWkLBjO0dh6n7LRTFn2iP/43808ijjqaN3T3X
         q7pqmRP5bRBMvTYWjqENm/hkoSApRhQuystthqeXj1BxtWkIPsIOGCePqonh7MOna3sT
         D0yYLbJKYxECsGdFo//rlNxyhmUrpHJ13irhpPMJE6WDycf7IoEaZ5qrhT5sV8fRvBj9
         T7Hz/AjN76O2oSa87lZOJLtLxWn2edC4wKbKqC04T+rUt9jxPer6MssjUGjaaqhk5mlK
         zsBYcYqBBlXZ91xtqlFo22mWKwPD0nh0D6XuznPrrX8KUrv/Ot9nmFKTeM8DI855/NI+
         hEfQ==
X-Gm-Message-State: AOJu0Yyw350+45UtvvWh5tAAK+n0PcmaqM2a79ve45SFzfK55OfQXlDH
	9/zFB9LN5NXxhRuJvilOaxEasICCjURJIlu2oRxKpYPRpu7A/B17DjIO
X-Gm-Gg: AZuq6aKMkXFn66/GZkEFpAi77WfwKW8LX/Zn7YIs0ebDut+uUubGHE2108Cuf2fpAno
	xyiP3ecTm6lx8xaJ35+rJHKEJ3oIgX6v2bvNBR9whVhvzUT7rqgDaFQaA3B3ZMurMpSQrH9kaQ7
	K9UflBMKnNfKjxiNpKbBe+Fj0RWnP043T7QlfT0SeSInI5EWXK+1qiMuUr9GmwVQQQMTlrrdL0U
	ewyjiEb97x5LdUb06GGyrbyLLumPlJo03UmUFUvOkfbUJbVd9S4gAx6kl1h19ZNVNm4PekL+Xee
	mNBai8/ehHpszbq65JwDLB5eNPpuDL9bto+PVqSUVLBsDP6EOQ3qNOE3qYOcM1m1rIr7WpRXqxR
	THJewhoxHwoGCaEPPE7bDTBZsOAnWWP7R+jLXUGgNjIbCWBSJH+DgD28Hpwvvrmi4/cfZSjqcl3
	qJ826jsZAONRnn32Cya1mbdgMpRS9L027KdKKXYFD0Yk2eEx2mm6mNDIGf4g6zst+7PZ8KLs6d6
	rVoaWS5uJTWX1kA76kXV/Nws1HYH/5Ulm+lvm9jR4vPqog5zgM=
X-Received: by 2002:a05:6000:2c12:b0:431:c73:48a8 with SMTP id ffacd0b85a97d-435b15fa1fcmr10632903f8f.29.1769245245854;
        Sat, 24 Jan 2026 01:00:45 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2c:b000:3d2e:e0d:3c3c:bb94? (p200300ea8f2cb0003d2e0e0d3c3cbb94.dip0.t-ipconnect.de. [2003:ea:8f2c:b000:3d2e:e0d:3c3c:bb94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02d0dsm13067913f8f.4.2026.01.24.01.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 01:00:45 -0800 (PST)
Message-ID: <032517b9-18d5-42cc-bf84-d1232199ae8c@gmail.com>
Date: Sat, 24 Jan 2026 10:00:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] net: phy: make PHY fixup support always built-in
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
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
	TAGGED_FROM(0.00)[bounces-253055-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: AFF747D095
X-Rspamd-Action: no action

PHY fixup registration is used from platform code in init phase only.
Let's move the PHY fixup code from the modular part of phylib to the
always built-in part of phylib. This allows to annotate the fixup
registration as __init.

phy_needs_fixup() and phy_scan_fixups() wouldn't have to be moved to
the built-in part of phylib. But doing so allows to fully factor out
legacy fixup support into its own source code file, and make struct
phy_fixup and phy_fixup_list strictly private to phy_fixup.c.

phy_scan_fixups() is used after init phase only, then phy_fixup_list
is read-only. So we don't need the mutex when accessing the list.
Also when registering PHY fixups the mutex isn't needed, because
fixup registration is done sequentially from platform init code.
Actually there is only one platform with more than one fixup.

In addition this change lays the foundation for enabling modular
phylib on platforms where the fixup just sets a flag.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- document return value of phy_register_fixup
---
 drivers/net/phy/Makefile          |   2 +-
 drivers/net/phy/phy_device.c      |  90 --------------------------
 drivers/net/phy/phy_fixup.c       | 102 ++++++++++++++++++++++++++++++
 drivers/net/phy/phylib-internal.h |   1 +
 include/linux/phy.h               |   8 +--
 5 files changed, 108 insertions(+), 95 deletions(-)
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
index 8a3eb1839a3..fefc5254519 100644
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
index 00000000000..27f569da940
--- /dev/null
+++ b/drivers/net/phy/phy_fixup.c
@@ -0,0 +1,102 @@
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
+ * Returns: 0 or -ENOMEM
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
index 6f9979a2689..7d72def300b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2401,10 +2401,10 @@ int phy_get_mac_termination(struct phy_device *phydev, struct device *dev,
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


