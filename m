Return-Path: <netdev+bounces-282417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJcLIpUd8mm/oAEAu9opvQ
	(envelope-from <netdev+bounces-282417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:02:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF849676D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1174301CFA6
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D1C3382C7;
	Wed, 29 Apr 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkQCWANH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFC82E7BB6;
	Wed, 29 Apr 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474678; cv=none; b=VZlQYCDGwkelq5Joy5JVTD+HBV+mk5tLWdHGoPFFwOPOflzDYjb+NRLF0+Ng/pXExtqWAzdkXAJbR6mfDqgz9NeoAzKzSLijraNsmWGGFxvyy9tI9dozcsR7aZp5cHeO4lh1CNPTXpAxmmzPq/7dbzFkevHMfbkbUCKqlGHiujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474678; c=relaxed/simple;
	bh=9WZAE8P9ViOr6m9MQX8bi0lfuERiB2aUVRNMOWC4/kM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oun0erDAp1lG9Fhndc22vaEqSwFgpvmWxKDIsgdJW90Eje3kFxaWAKvVJeq/hiu4fQOIeECUCCuZziiavKTJEIm9adtWanbEaD/kw6kaYK6e7158mZOxpEQiCVoc7IZ0zM1cmywryTICVVsKKasci87+VicvUw7yJkXHNDIqjY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkQCWANH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DE6C2BCB8;
	Wed, 29 Apr 2026 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474678;
	bh=9WZAE8P9ViOr6m9MQX8bi0lfuERiB2aUVRNMOWC4/kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkQCWANHuCW06bfQnx19GcFzap1JYfxE6TZ7WOA8ncyrVvxR4fGsg+mgjz9zM7CmV
	 XQVhqBlUzlUHt9Guxw4vBO2oKpblwjOf4ZiFHUqhf1ILHZW7+7/tvPmOa3tIRJJe2q
	 bGnK5VkScU3bjLOg6E6eNPQLCvwjYpH0OMYYR10hIkBB5JhJROz6dOacJXBgPYJpw+
	 fkW1T3/1fAkWlspMMQaQtbbecOgsOlZbGUILBshgZKkKCBQBYdMI5qFWSvdJSdnUZs
	 ycJpxUI+r/MXvw9UIwrfoGS7Csan9PWDaVdmDeve7uNCHOGLa8dG78VyGwa9v+Fya2
	 yD7Ub0RIDLe6A==
From: Arnd Bergmann <arnd@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/2] ne2k: fold drivers/net/Space.c into ne.c
Date: Wed, 29 Apr 2026 16:55:46 +0200
Message-Id: <20260429145624.2948432-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260429145624.2948432-1-arnd@kernel.org>
References: <20260429145624.2948432-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 57EF849676D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282417-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email,mugnet.org:email,scyld.com:email,conectiva.com.br:email]

From: Arnd Bergmann <arnd@arndb.de>

drivers/net/Space.c is the last remnant of the linux-2.4.x driver model
that required each subsystem and device driver init function to be called
from init/main.c explicitly, before the introduction of initcall levels.

In linux-7.0, this was only used for a handful of ISA network drivers,
with the ne2000 driver being the last one.

Fold the code into ne.c directly, with minimal changes to preserve
the existing command line parsing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../admin-guide/kernel-parameters.txt         |   6 +-
 Documentation/arch/m68k/kernel-options.rst    |  24 +-
 drivers/net/Kconfig                           |   7 -
 drivers/net/Makefile                          |   1 -
 drivers/net/Space.c                           | 234 -----------------
 drivers/net/ethernet/8390/Kconfig             |   1 -
 drivers/net/ethernet/8390/ne.c                | 237 ++++++++++++++++--
 include/linux/netdevice.h                     |   1 -
 include/net/Space.h                           |   6 -
 9 files changed, 220 insertions(+), 297 deletions(-)
 delete mode 100644 drivers/net/Space.c
 delete mode 100644 include/net/Space.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 41c657cd362c..f739e0aae337 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4266,12 +4266,8 @@ Kernel parameters
 
 	n2=		[NET] SDL Inc. RISCom/N2 synchronous serial card
 
-	netdev=		[NET] Network devices parameters
+	netdev=		[NET] NE2000 ISA network devices parameters
 			Format: <irq>,<io>,<mem_start>,<mem_end>,<name>
-			Note that mem_start is often overloaded to mean
-			something different and driver-specific.
-			This usage is only documented in each driver source
-			file if at all.
 
 	netpoll.carrier_timeout=
 			[NET] Specifies amount of time (in seconds) that
diff --git a/Documentation/arch/m68k/kernel-options.rst b/Documentation/arch/m68k/kernel-options.rst
index 2008a20b4329..c59e7aaed44e 100644
--- a/Documentation/arch/m68k/kernel-options.rst
+++ b/Documentation/arch/m68k/kernel-options.rst
@@ -244,23 +244,7 @@ drive (with "root=").
 3) General Device Options (Amiga and Atari)
 ===========================================
 
-3.1) ether=
------------
-
-:Syntax: ether=[<irq>[,<base_addr>[,<mem_start>[,<mem_end>]]]],<dev-name>
-
-<dev-name> is the name of a net driver, as specified in
-drivers/net/Space.c in the Linux source. Most prominent are eth0, ...
-eth3, sl0, ... sl3, ppp0, ..., ppp3, dummy, and lo.
-
-The non-ethernet drivers (sl, ppp, dummy, lo) obviously ignore the
-settings by this options. Also, the existing ethernet drivers for
-Linux/m68k (ariadne, a2065, hydra) don't use them because Zorro boards
-are really Plug-'n-Play, so the "ether=" option is useless altogether
-for Linux/m68k.
-
-
-3.2) hd=
+3.1) hd=
 --------
 
 :Syntax: hd=<cylinders>,<heads>,<sectors>
@@ -273,7 +257,7 @@ itself. It exists just for the case that this fails for one of your
 disks.
 
 
-3.3) max_scsi_luns=
+3.2) max_scsi_luns=
 -------------------
 
 :Syntax: max_scsi_luns=<n>
@@ -284,7 +268,7 @@ be scanned. Valid values for <n> are between 1 and 8. Default is 8 if
 configuration, else 1.
 
 
-3.4) st=
+3.3) st=
 --------
 
 :Syntax: st=<buffer_size>,[<write_thres>,[<max_buffers>]]
@@ -297,7 +281,7 @@ total number of buffers. <max_buffer> limits the total number of
 buffers allocated for all tape devices.
 
 
-3.5) dmasound=
+3.4) dmasound=
 --------------
 
 :Syntax: dmasound=[<buffers>,<buffer-size>[,<catch-radius>]]
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 8ec98f6dfef9..ff79c466712d 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -630,11 +630,4 @@ config NET_FAILOVER
 	  a VM with direct attached VF by failing over to the paravirtual
 	  datapath when the VF is unplugged.
 
-config NETDEV_LEGACY_INIT
-	bool
-	depends on ISA
-	help
-	  Drivers that call netdev_boot_setup_check() should select this
-	  symbol, everything else no longer needs it.
-
 endif # NETDEVICES
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index b87a741fc952..88e4c485d6b2 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_MACVTAP) += macvtap.o
 obj-$(CONFIG_MII) += mii.o
 obj-$(CONFIG_MDIO) += mdio.o
 obj-$(CONFIG_NET) += loopback.o
-obj-$(CONFIG_NETDEV_LEGACY_INIT) += Space.o
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
 obj-$(CONFIG_NETKIT) += netkit.o
 obj-y += phy/
diff --git a/drivers/net/Space.c b/drivers/net/Space.c
deleted file mode 100644
index c3ce960110b9..000000000000
--- a/drivers/net/Space.c
+++ /dev/null
@@ -1,234 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * INET		An implementation of the TCP/IP protocol suite for the LINUX
- *		operating system.  INET is implemented using the  BSD Socket
- *		interface as the means of communication with the user level.
- *
- *		Holds initial configuration information for devices.
- *
- * Version:	@(#)Space.c	1.0.7	08/12/93
- *
- * Authors:	Ross Biro
- *		Fred N. van Kempen, <waltje@uWalt.NL.Mugnet.ORG>
- *		Donald J. Becker, <becker@scyld.com>
- *
- * Changelog:
- *		Stephen Hemminger (09/2003)
- *		- get rid of pre-linked dev list, dynamic device allocation
- *		Paul Gortmaker (03/2002)
- *		- struct init cleanup, enable multiple ISA autoprobes.
- *		Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 09/1999
- *		- fix sbni: s/device/net_device/
- *		Paul Gortmaker (06/98):
- *		 - sort probes in a sane way, make sure all (safe) probes
- *		   get run once & failed autoprobes don't autoprobe again.
- */
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/netlink.h>
-#include <net/Space.h>
-
-/*
- * This structure holds boot-time configured netdevice settings. They
- * are then used in the device probing.
- */
-struct netdev_boot_setup {
-	char name[IFNAMSIZ];
-	struct ifmap map;
-};
-#define NETDEV_BOOT_SETUP_MAX 8
-
-
-/******************************************************************************
- *
- *		      Device Boot-time Settings Routines
- *
- ******************************************************************************/
-
-/* Boot time configuration table */
-static struct netdev_boot_setup dev_boot_setup[NETDEV_BOOT_SETUP_MAX];
-
-/**
- *	netdev_boot_setup_add	- add new setup entry
- *	@name: name of the device
- *	@map: configured settings for the device
- *
- *	Adds new setup entry to the dev_boot_setup list.  The function
- *	returns 0 on error and 1 on success.  This is a generic routine to
- *	all netdevices.
- */
-static int netdev_boot_setup_add(char *name, struct ifmap *map)
-{
-	struct netdev_boot_setup *s;
-	int i;
-
-	s = dev_boot_setup;
-	for (i = 0; i < NETDEV_BOOT_SETUP_MAX; i++) {
-		if (s[i].name[0] == '\0' || s[i].name[0] == ' ') {
-			strscpy_pad(s[i].name, name);
-			memcpy(&s[i].map, map, sizeof(s[i].map));
-			break;
-		}
-	}
-
-	return i >= NETDEV_BOOT_SETUP_MAX ? 0 : 1;
-}
-
-/**
- * netdev_boot_setup_check	- check boot time settings
- * @dev: the netdevice
- *
- * Check boot time settings for the device.
- * The found settings are set for the device to be used
- * later in the device probing.
- * Returns 0 if no settings found, 1 if they are.
- */
-int netdev_boot_setup_check(struct net_device *dev)
-{
-	struct netdev_boot_setup *s = dev_boot_setup;
-	int i;
-
-	for (i = 0; i < NETDEV_BOOT_SETUP_MAX; i++) {
-		if (s[i].name[0] != '\0' && s[i].name[0] != ' ' &&
-		    !strcmp(dev->name, s[i].name)) {
-			dev->irq = s[i].map.irq;
-			dev->base_addr = s[i].map.base_addr;
-			dev->mem_start = s[i].map.mem_start;
-			dev->mem_end = s[i].map.mem_end;
-			return 1;
-		}
-	}
-	return 0;
-}
-EXPORT_SYMBOL(netdev_boot_setup_check);
-
-/**
- * netdev_boot_base	- get address from boot time settings
- * @prefix: prefix for network device
- * @unit: id for network device
- *
- * Check boot time settings for the base address of device.
- * The found settings are set for the device to be used
- * later in the device probing.
- * Returns 0 if no settings found.
- */
-static unsigned long netdev_boot_base(const char *prefix, int unit)
-{
-	const struct netdev_boot_setup *s = dev_boot_setup;
-	char name[IFNAMSIZ];
-	int i;
-
-	sprintf(name, "%s%d", prefix, unit);
-
-	/*
-	 * If device already registered then return base of 1
-	 * to indicate not to probe for this interface
-	 */
-	if (__dev_get_by_name(&init_net, name))
-		return 1;
-
-	for (i = 0; i < NETDEV_BOOT_SETUP_MAX; i++)
-		if (!strcmp(name, s[i].name))
-			return s[i].map.base_addr;
-	return 0;
-}
-
-/*
- * Saves at boot time configured settings for any netdevice.
- */
-static int __init netdev_boot_setup(char *str)
-{
-	int ints[5];
-	struct ifmap map;
-
-	str = get_options(str, ARRAY_SIZE(ints), ints);
-	if (!str || !*str)
-		return 0;
-
-	/* Save settings */
-	memset(&map, 0, sizeof(map));
-	if (ints[0] > 0)
-		map.irq = ints[1];
-	if (ints[0] > 1)
-		map.base_addr = ints[2];
-	if (ints[0] > 2)
-		map.mem_start = ints[3];
-	if (ints[0] > 3)
-		map.mem_end = ints[4];
-
-	/* Add new entry to the list */
-	return netdev_boot_setup_add(str, &map);
-}
-
-__setup("netdev=", netdev_boot_setup);
-
-static int __init ether_boot_setup(char *str)
-{
-	return netdev_boot_setup(str);
-}
-__setup("ether=", ether_boot_setup);
-
-
-/* A unified ethernet device probe.  This is the easiest way to have every
- * ethernet adaptor have the name "eth[0123...]".
- */
-
-struct devprobe2 {
-	struct net_device *(*probe)(int unit);
-	int status;	/* non-zero if autoprobe has failed */
-};
-
-static int __init probe_list2(int unit, struct devprobe2 *p, int autoprobe)
-{
-	struct net_device *dev;
-
-	for (; p->probe; p++) {
-		if (autoprobe && p->status)
-			continue;
-		dev = p->probe(unit);
-		if (!IS_ERR(dev))
-			return 0;
-		if (autoprobe)
-			p->status = PTR_ERR(dev);
-	}
-	return -ENODEV;
-}
-
-/* ISA probes that touch addresses < 0x400 (including those that also
- * look for EISA/PCI cards in addition to ISA cards).
- */
-static struct devprobe2 isa_probes[] __initdata = {
-#if defined(CONFIG_NE2000) /* ISA (use ne2k-pci for PCI cards) */
-	{ne_probe, 0},
-#endif
-	{NULL, 0},
-};
-
-/* Unified ethernet device probe, segmented per architecture and
- * per bus interface. This drives the legacy devices only for now.
- */
-
-static void __init ethif_probe2(int unit)
-{
-	unsigned long base_addr = netdev_boot_base("eth", unit);
-
-	if (base_addr == 1)
-		return;
-
-	probe_list2(unit, isa_probes, base_addr == 0);
-}
-
-/*  Statically configured drivers -- order matters here. */
-static int __init net_olddevs_init(void)
-{
-	int num;
-
-	for (num = 0; num < 8; ++num)
-		ethif_probe2(num);
-
-	return 0;
-}
-
-device_initcall(net_olddevs_init);
diff --git a/drivers/net/ethernet/8390/Kconfig b/drivers/net/ethernet/8390/Kconfig
index 5d12a595ab19..57d73a7747ec 100644
--- a/drivers/net/ethernet/8390/Kconfig
+++ b/drivers/net/ethernet/8390/Kconfig
@@ -90,7 +90,6 @@ config MCF8390
 config NE2000
 	tristate "NE2000/NE1000 support"
 	depends on (ISA || (Q40 && m) || MACH_TX49XX || ATARI_ETHERNEC)
-	select NETDEV_LEGACY_INIT if ISA
 	select CRC32
 	help
 	  If you have a network (Ethernet) card of this type, say Y here.
diff --git a/drivers/net/ethernet/8390/ne.c b/drivers/net/ethernet/8390/ne.c
index 961019c32842..1cbd5a4977ce 100644
--- a/drivers/net/ethernet/8390/ne.c
+++ b/drivers/net/ethernet/8390/ne.c
@@ -50,7 +50,6 @@ static const char version2[] =
 #include <linux/etherdevice.h>
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
-#include <net/Space.h>
 
 #include <asm/io.h>
 
@@ -182,7 +181,6 @@ static void ne_block_input(struct net_device *dev, int count,
 static void ne_block_output(struct net_device *dev, const int count,
 		const unsigned char *buf, const int start_page);
 
-
 /*  Probe for various non-shared-memory ethercards.
 
    NEx000-clone boards have a Station Address PROM (SAPROM) in the packet
@@ -918,31 +916,47 @@ static void __init ne_add_devices(void)
 	}
 }
 
-static int __init ne_init(void)
+/*
+ * This structure holds boot-time configured netdevice settings. They
+ * are then used in the device probing.
+ */
+struct netdev_boot_setup {
+	char name[IFNAMSIZ];
+	struct ifmap map;
+};
+#define NETDEV_BOOT_SETUP_MAX 8
+
+/* Boot time configuration table */
+static struct netdev_boot_setup dev_boot_setup[NETDEV_BOOT_SETUP_MAX];
+
+/**
+ * netdev_boot_setup_check	- check boot time settings
+ * @dev: the netdevice
+ *
+ * Check boot time settings for the device.
+ * The found settings are set for the device to be used
+ * later in the device probing.
+ * Returns 0 if no settings found, 1 if they are.
+ */
+static int netdev_boot_setup_check(struct net_device *dev)
 {
-	int retval;
-
-	if (IS_MODULE(CONFIG_NE2000))
-		ne_add_devices();
-
-	retval = platform_driver_probe(&ne_driver, ne_drv_probe);
+	struct netdev_boot_setup *s = dev_boot_setup;
+	int i;
 
-	if (IS_MODULE(CONFIG_NE2000) && retval) {
-		if (io[0] == 0)
-			pr_notice("ne.c: You must supply \"io=0xNNN\""
-			       " value(s) for ISA cards.\n");
-		ne_loop_rm_unreg(1);
-		return retval;
+	for (i = 0; i < NETDEV_BOOT_SETUP_MAX; i++) {
+		if (s[i].name[0] != '\0' && s[i].name[0] != ' ' &&
+		    !strcmp(dev->name, s[i].name)) {
+			dev->irq = s[i].map.irq;
+			dev->base_addr = s[i].map.base_addr;
+			dev->mem_start = s[i].map.mem_start;
+			dev->mem_end = s[i].map.mem_end;
+			return 1;
+		}
 	}
-
-	/* Unregister unused platform_devices. */
-	ne_loop_rm_unreg(0);
-	return retval;
+	return 0;
 }
-module_init(ne_init);
 
-#if !defined(MODULE) && defined(CONFIG_NETDEV_LEGACY_INIT)
-struct net_device * __init ne_probe(int unit)
+static struct net_device * __init ne_probe(int unit)
 {
 	int this_dev;
 	struct net_device *dev;
@@ -982,8 +996,187 @@ struct net_device * __init ne_probe(int unit)
 
 	return ERR_PTR(-ENODEV);
 }
+
+/******************************************************************************
+ *
+ *		      Device Boot-time Settings Routines
+ *
+ ******************************************************************************/
+
+/**
+ * netdev_boot_base	- get address from boot time settings
+ * @prefix: prefix for network device
+ * @unit: id for network device
+ *
+ * Check boot time settings for the base address of device.
+ * The found settings are set for the device to be used
+ * later in the device probing.
+ * Returns 0 if no settings found.
+ */
+static unsigned long netdev_boot_base(const char *prefix, int unit)
+{
+	const struct netdev_boot_setup *s = dev_boot_setup;
+	char name[IFNAMSIZ];
+	int i;
+
+	sprintf(name, "%s%d", prefix, unit);
+
+	/*
+	 * If device already registered then return base of 1
+	 * to indicate not to probe for this interface
+	 */
+	if (__dev_get_by_name(&init_net, name))
+		return 1;
+
+	for (i = 0; i < NETDEV_BOOT_SETUP_MAX; i++)
+		if (!strcmp(name, s[i].name))
+			return s[i].map.base_addr;
+	return 0;
+}
+
+#if !defined(MODULE) && defined(CONFIG_ISA)
+/**
+ *	netdev_boot_setup_add	- add new setup entry
+ *	@name: name of the device
+ *	@map: configured settings for the device
+ *
+ *	Adds new setup entry to the dev_boot_setup list.  The function
+ *	returns 0 on error and 1 on success.  This is a generic routine to
+ *	all netdevices.
+ */
+static int netdev_boot_setup_add(char *name, struct ifmap *map)
+{
+	struct netdev_boot_setup *s;
+	int i;
+
+	s = dev_boot_setup;
+	for (i = 0; i < NETDEV_BOOT_SETUP_MAX; i++) {
+		if (s[i].name[0] == '\0' || s[i].name[0] == ' ') {
+			strscpy_pad(s[i].name, name);
+			memcpy(&s[i].map, map, sizeof(s[i].map));
+			break;
+		}
+	}
+
+	return i >= NETDEV_BOOT_SETUP_MAX ? 0 : 1;
+}
+
+/*
+ * Saves at boot time configured settings for any netdevice.
+ */
+static int __init netdev_boot_setup(char *str)
+{
+	int ints[5];
+	struct ifmap map;
+
+	str = get_options(str, ARRAY_SIZE(ints), ints);
+	if (!str || !*str)
+		return 0;
+
+	/* Save settings */
+	memset(&map, 0, sizeof(map));
+	if (ints[0] > 0)
+		map.irq = ints[1];
+	if (ints[0] > 1)
+		map.base_addr = ints[2];
+	if (ints[0] > 2)
+		map.mem_start = ints[3];
+	if (ints[0] > 3)
+		map.mem_end = ints[4];
+
+	/* Add new entry to the list */
+	return netdev_boot_setup_add(str, &map);
+}
+
+__setup("netdev=", netdev_boot_setup);
+
+static int __init ether_boot_setup(char *str)
+{
+	return netdev_boot_setup(str);
+}
+__setup("ether=", ether_boot_setup);
 #endif
 
+/* A unified ethernet device probe.  This is the easiest way to have every
+ * ethernet adaptor have the name "eth[0123...]".
+ */
+
+struct devprobe2 {
+	struct net_device *(*probe)(int unit);
+	int status;	/* non-zero if autoprobe has failed */
+};
+
+static int __init probe_list2(int unit, struct devprobe2 *p, int autoprobe)
+{
+	struct net_device *dev;
+
+	for (; p->probe; p++) {
+		if (autoprobe && p->status)
+			continue;
+		dev = p->probe(unit);
+		if (!IS_ERR(dev))
+			return 0;
+		if (autoprobe)
+			p->status = PTR_ERR(dev);
+	}
+	return -ENODEV;
+}
+
+static struct devprobe2 isa_probes[] __initdata = {
+	{ne_probe, 0},
+	{NULL, 0},
+};
+
+/* Unified ethernet device probe, segmented per architecture and
+ * per bus interface. This drives the legacy devices only for now.
+ */
+
+static void __init ethif_probe2(int unit)
+{
+	unsigned long base_addr = netdev_boot_base("eth", unit);
+
+	if (base_addr == 1)
+		return;
+
+	probe_list2(unit, isa_probes, base_addr == 0);
+}
+
+/*  Statically configured drivers -- order matters here. */
+static int __init net_olddevs_init(void)
+{
+	int num;
+
+	for (num = 0; num < 8; ++num)
+		ethif_probe2(num);
+
+	return 0;
+}
+
+static int __init ne_init(void)
+{
+	int retval;
+
+	if (IS_MODULE(CONFIG_NE2000))
+		ne_add_devices();
+	else
+		net_olddevs_init();
+
+	retval = platform_driver_probe(&ne_driver, ne_drv_probe);
+
+	if (IS_MODULE(CONFIG_NE2000) && retval) {
+		if (io[0] == 0)
+			pr_notice("ne.c: You must supply \"io=0xNNN\""
+			       " value(s) for ISA cards.\n");
+		ne_loop_rm_unreg(1);
+		return retval;
+	}
+
+	/* Unregister unused platform_devices. */
+	ne_loop_rm_unreg(0);
+	return retval;
+}
+module_init(ne_init);
+
 static void __exit ne_exit(void)
 {
 	platform_driver_unregister(&ne_driver);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 99fcb5ac45bc..2f5de3e83ed6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3384,7 +3384,6 @@ static inline struct net_device *first_net_device(struct net *net)
 		net_device_entry(net->dev_base_head.next);
 }
 
-int netdev_boot_setup_check(struct net_device *dev);
 struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
 				   const char *hwaddr);
 struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
diff --git a/include/net/Space.h b/include/net/Space.h
deleted file mode 100644
index 1b9ab0da5a03..000000000000
--- a/include/net/Space.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* A unified ethernet device probe.  This is the easiest way to have every
- * ethernet adaptor have the name "eth[0123...]".
- */
-
-struct net_device *ne_probe(int unit);
-- 
2.39.5


