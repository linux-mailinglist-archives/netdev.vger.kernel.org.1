Return-Path: <netdev+bounces-255340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id m7szIZWFfWkKSgIAu9opvQ
	(envelope-from <netdev+bounces-255340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:31:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB02C0A56
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C802300A109
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5EE2690EC;
	Sat, 31 Jan 2026 04:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXrGhFe8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57433EBF04
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 04:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769833874; cv=none; b=m3z2BAFRs1c+FxAbSOWsgn1+5TqVqhWE0AM3rpOvtmf3x1T7KNGoyltg4jmk9twsXz3rfwwEZD7izVU84tRFqNZJDkE+KMpu07K5ar6GUybnZF9qOXz1jPcxXVAuHStwD2eo2ql9X7mLzcglKaQ7C0rV2pGl0mIZMfVeBuLs8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769833874; c=relaxed/simple;
	bh=4Xn7Hjpyu36JQr4N4wukFZQUqO2+RnwdxeBlAxkT8fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzFcZ5f1Mogiz3tDF1ob15wW17K9mfaCLFYEslfn5bXkrWDd2EUxJJCo8HaiNE5hYZxdr8ZFCmeeKja32OH9WHbrcUI2mlKjEm7w4FeaLdRmfAdaKH8b4k99ChHrhNmapDyTaMQCyzmBtqQWKutkKuczJ0VdRh/a/VZ7beq+b/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXrGhFe8; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3530e7b3dc2so2202663a91.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 20:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769833869; x=1770438669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9X+q9Enj27QmJKptB3clHG1n72J5b+esRL7gI/OLG0=;
        b=iXrGhFe8tslOeOu28NHnzDzQv169hlXMZLFb1AQMihgkOqILHwBB+EkrmFtSod0uHn
         wOUJ45HZ0Paqf9RmTg9ZlFs8yKb66DkxwwgYGwD6mAjepg4Ofk17XNvbjLVhoak1BHtH
         oXyNnjcGTcaGDsUh2LY5Nhfy8ckguYhKxvOOQsFYG5MtIvGTufez8lCtvSa3qUhtoycQ
         rfgBTFAy1RmjgneiXxKOOQ+BGWVw5xGkCo4LNPIxrNXDRbgDNHgEhZNDzlLNQFxJa7V6
         L+5JIHQfcLCduFtfvRMKhyAADdgVegtkGR+zpHk7KLSVCaRyuj380CXY3u2HMF0AZvAp
         Ftnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769833869; x=1770438669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9X+q9Enj27QmJKptB3clHG1n72J5b+esRL7gI/OLG0=;
        b=vBhISR1qMYsxTEsOVQ9nINK9ScLiIkJvxvoCL6QXBd4AY4MOLS6PHuMBnUvTyI885F
         0QZb0DS4p49+PRDrq9IU6HhHLYhS3vjBuKzTDSb5fTfrpx1nMbwN90J5qWUoAXseMpAJ
         Xqmb/H+tRLdA1ShjwAbelz2o3rugqFhJm4/BsvfyuL2Af2sAph9wt0A+VG3bxucqExp+
         /ca3hdKWN0SobGWO6AOI05cMTKPtZ+Fvo4bX9OlH1mlh54Ton2MQL3HtAedsOWlasjHb
         NkwA1n5K0zixZTqnI0V7NR1UpJfi/SFWk60duamUGr0G2KKdG48ps5XlumJQNXtXFj77
         ZO1w==
X-Gm-Message-State: AOJu0YyMFQfCvFTjaFxuEg/5eXprfqQeMm7WuwgYng2OADtnwZbnwGif
	D0r2QTStGmcfXgPsEfeu7sOBFwB4tf8PmTbUofhRTofux6htQ5uuYNOqcqBzWCE4
X-Gm-Gg: AZuq6aKLWCvqN0b1TDXBCbNKYLvTB7AanfQJj2mVehI5MSUtmfCI+f92kmtFYHkwdLX
	f0hd4a71MNoOpmuuA4NWzBYO3USxN0j3JsGQfwyypldx6JeKPWSG56FCzAGojOiHCWvuEtVe1g8
	SwarTPzedqdJgr6xcueTS3zlNJGaijtROPXF2EskZSMhE3xTlx+TWKUq3lUQDY/is9jRu3b3KVP
	wQId2lmxSwjcLLsc+PyIeYPssp9/Vmd4sU9OBgqCblvdaDkYlt5HWUyEridr7U2u53aymeGPBb0
	vcyPwiLFa5zYWjCjD+u5Bwc6lgMAnrGHObw7nK/Xltz88V0DEZ7okosTFozYS3HRZbcCeIhgi7D
	PDrjsfP7gBzVh9B2tp9aOBmmxbE0TAwsHBPZPWj74EscWBreqUhVj8HTu3ubAs22OoE6lRxzGZh
	vk7+QIBklUZlNmUTOE3F88NqESNZfUjE2D0vnasWkm02rweYf+Y+spMyqmVB8NDpHhZD3Sa9/DT
	m68K617dBiMpr/Pa1fk1owMXpc23q7FHxOqtvwiycNp8iM6yY5+owNsfpSuAEQX+YuBO7LEvW6Z
	uBMZ
X-Received: by 2002:a05:7300:5709:b0:2a4:3592:cf83 with SMTP id 5a478bee46e88-2b7c8909901mr2304708eec.39.1769826324121;
        Fri, 30 Jan 2026 18:25:24 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8f2sm14978373eec.7.2026.01.30.18.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 18:25:23 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Simon Horman <horms@kernel.org>,
	Sai Krishna <saikrishnag@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniele Venzano <venza@brownhat.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH net-next] net: ethernet: use module_pci_driver; remove useless driver versions
Date: Fri, 30 Jan 2026 18:24:30 -0800
Message-ID: <20260131022441.56274-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fr.zoreil.com,kernel.org,marvell.com,lunn.ch,davemloft.net,google.com,redhat.com,brownhat.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-255340-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zoreil.com:email,marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFB02C0A56
X-Rspamd-Action: no action

The module version is useless, and the only thing these drivers' init
routines did besides pci_register_driver was to print the driver name
and/or version.

Acked-by: Francois Romieu <romieu@fr.zoreil.com> (epic100)
Reviewed-by: Simon Horman <horms@kernel.org> (epic100, sis900)
Reviewed-by: Sai Krishna <saikrishnag@marvell.com> (epic100)
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
This patch is almost the same as my previous three patches to use
module_pci_driver, but merged into one. The only changes are to rebase
it on the latest net-next tree, remove an unrelated 8139too change to
use KBUILD_MODNAME, add received tags, and CC maintainers.

 drivers/net/ethernet/realtek/8139too.c | 40 +-------------------------
 drivers/net/ethernet/sis/sis900.c      | 31 +-------------------
 drivers/net/ethernet/smsc/epic100.c    | 35 +---------------------
 3 files changed, 3 insertions(+), 103 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
index a73dcaffa8c5..a8532ebd42ec 100644
--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -92,8 +92,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #define DRV_NAME	"8139too"
-#define DRV_VERSION	"0.9.28"
-
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -115,8 +113,6 @@
 #include <linux/if_vlan.h>
 #include <asm/irq.h>
 
-#define RTL8139_DRIVER_NAME   DRV_NAME " Fast Ethernet driver " DRV_VERSION
-
 /* Default Message level */
 #define RTL8139_DEF_MSG_ENABLE   (NETIF_MSG_DRV   | \
                                  NETIF_MSG_PROBE  | \
@@ -623,7 +619,6 @@ struct rtl8139_private {
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@pobox.com>");
 MODULE_DESCRIPTION ("RealTek RTL-8139 Fast Ethernet driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
 
 module_param(use_io, bool, 0);
 MODULE_PARM_DESC(use_io, "Force use of I/O access mode. 0=MMIO 1=PIO");
@@ -955,17 +950,6 @@ static int rtl8139_init_one(struct pci_dev *pdev,
 
 	board_idx++;
 
-	/* when we're built into the kernel, the driver version message
-	 * is only printed if at least one 8139 board has been found
-	 */
-#ifndef MODULE
-	{
-		static int printed_version;
-		if (!printed_version++)
-			pr_info(RTL8139_DRIVER_NAME "\n");
-	}
-#endif
-
 	if (pdev->vendor == PCI_VENDOR_ID_REALTEK &&
 	    pdev->device == PCI_DEVICE_ID_REALTEK_8139 && pdev->revision >= 0x20) {
 		dev_info(&pdev->dev,
@@ -2383,7 +2367,6 @@ static void rtl8139_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
 	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
-	strscpy(info->version, DRV_VERSION, sizeof(info->version));
 	strscpy(info->bus_info, pci_name(tp->pci_dev), sizeof(info->bus_info));
 }
 
@@ -2656,25 +2639,4 @@ static struct pci_driver rtl8139_pci_driver = {
 	.driver.pm	= &rtl8139_pm_ops,
 };
 
-
-static int __init rtl8139_init_module (void)
-{
-	/* when we're a module, we always print a version message,
-	 * even if no 8139 board is found.
-	 */
-#ifdef MODULE
-	pr_info(RTL8139_DRIVER_NAME "\n");
-#endif
-
-	return pci_register_driver(&rtl8139_pci_driver);
-}
-
-
-static void __exit rtl8139_cleanup_module (void)
-{
-	pci_unregister_driver (&rtl8139_pci_driver);
-}
-
-
-module_init(rtl8139_init_module);
-module_exit(rtl8139_cleanup_module);
+module_pci_driver(rtl8139_pci_driver);
diff --git a/drivers/net/ethernet/sis/sis900.c b/drivers/net/ethernet/sis/sis900.c
index b461918dc5f4..d85ac8cbeb00 100644
--- a/drivers/net/ethernet/sis/sis900.c
+++ b/drivers/net/ethernet/sis/sis900.c
@@ -79,10 +79,6 @@
 #include "sis900.h"
 
 #define SIS900_MODULE_NAME "sis900"
-#define SIS900_DRV_VERSION "v1.08.10 Apr. 2 2006"
-
-static const char version[] =
-	KERN_INFO "sis900.c: " SIS900_DRV_VERSION "\n";
 
 static int max_interrupt_work = 40;
 static int multicast_filter_limit = 128;
@@ -442,13 +438,6 @@ static int sis900_probe(struct pci_dev *pci_dev,
 	const char *card_name = card_names[pci_id->driver_data];
 	const char *dev_name = pci_name(pci_dev);
 
-/* when built into the kernel, we only print version if device is found */
-#ifndef MODULE
-	static int printed_version;
-	if (!printed_version++)
-		printk(version);
-#endif
-
 	/* setup various bits in PCI command register */
 	ret = pcim_enable_device(pci_dev);
 	if(ret) return ret;
@@ -2029,7 +2018,6 @@ static void sis900_get_drvinfo(struct net_device *net_dev,
 	struct sis900_private *sis_priv = netdev_priv(net_dev);
 
 	strscpy(info->driver, SIS900_MODULE_NAME, sizeof(info->driver));
-	strscpy(info->version, SIS900_DRV_VERSION, sizeof(info->version));
 	strscpy(info->bus_info, pci_name(sis_priv->pci_dev),
 		sizeof(info->bus_info));
 }
@@ -2567,21 +2555,4 @@ static struct pci_driver sis900_pci_driver = {
 	.driver.pm	= &sis900_pm_ops,
 };
 
-static int __init sis900_init_module(void)
-{
-/* when a module, this is printed whether or not devices are found in probe */
-#ifdef MODULE
-	printk(version);
-#endif
-
-	return pci_register_driver(&sis900_pci_driver);
-}
-
-static void __exit sis900_cleanup_module(void)
-{
-	pci_unregister_driver(&sis900_pci_driver);
-}
-
-module_init(sis900_init_module);
-module_exit(sis900_cleanup_module);
-
+module_pci_driver(sis900_pci_driver);
diff --git a/drivers/net/ethernet/smsc/epic100.c b/drivers/net/ethernet/smsc/epic100.c
index 45f703fe0e5a..389659db06a8 100644
--- a/drivers/net/ethernet/smsc/epic100.c
+++ b/drivers/net/ethernet/smsc/epic100.c
@@ -26,8 +26,6 @@
 */
 
 #define DRV_NAME        "epic100"
-#define DRV_VERSION     "2.1"
-#define DRV_RELDATE     "Sept 11, 2006"
 
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
@@ -89,12 +87,6 @@ static int rx_copybreak;
 #include <linux/uaccess.h>
 #include <asm/byteorder.h>
 
-/* These identify the driver base version and may not be removed. */
-static char version[] =
-DRV_NAME ".c:v1.11 1/7/2001 Written by Donald Becker <becker@scyld.com>";
-static char version2[] =
-"  (unofficial 2.4.x kernel port, version " DRV_VERSION ", " DRV_RELDATE ")";
-
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("SMC 83c170 EPIC series Ethernet driver");
 MODULE_LICENSE("GPL");
@@ -329,11 +321,6 @@ static int epic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	void *ring_space;
 	dma_addr_t ring_dma;
 
-/* when built into the kernel, we only print version if device is found */
-#ifndef MODULE
-	pr_info_once("%s%s\n", version, version2);
-#endif
-
 	card_idx++;
 
 	ret = pci_enable_device(pdev);
@@ -1393,7 +1380,6 @@ static void netdev_get_drvinfo (struct net_device *dev, struct ethtool_drvinfo *
 	struct epic_private *np = netdev_priv(dev);
 
 	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
-	strscpy(info->version, DRV_VERSION, sizeof(info->version));
 	strscpy(info->bus_info, pci_name(np->pci_dev), sizeof(info->bus_info));
 }
 
@@ -1564,23 +1550,4 @@ static struct pci_driver epic_driver = {
 	.driver.pm	= &epic_pm_ops,
 };
 
-
-static int __init epic_init (void)
-{
-/* when a module, this is printed whether or not devices are found in probe */
-#ifdef MODULE
-	pr_info("%s%s\n", version, version2);
-#endif
-
-	return pci_register_driver(&epic_driver);
-}
-
-
-static void __exit epic_cleanup (void)
-{
-	pci_unregister_driver (&epic_driver);
-}
-
-
-module_init(epic_init);
-module_exit(epic_cleanup);
+module_pci_driver(epic_driver);
-- 
2.43.0


