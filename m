Return-Path: <netdev+bounces-247608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 324EBCFC49A
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A39CC3002BA2
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5522777FD;
	Wed,  7 Jan 2026 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlUcglXt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91616250BEC
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769836; cv=none; b=CFchcER1gytBJfXz29TpKINx9xj2CCLqx+ZIQzWFLBMNuUcoZLGbcAxpMr8IAdr3JoZdngYFfiwvK9bVrvHs+z1j/LdJCNErzy7ZmggYdtH2Sjr1KfPpifWEaNELO3i7kw+PNUpLaWsAXsElIzLVYMoTpPvVc3r1HRV0sANnuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769836; c=relaxed/simple;
	bh=oscjy2s2M3ikv5PoNVr7eb3C9J2uZGMq6KCJArhIdVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXq09QKqEWqAAA9hzC4QLuWZg8FAjF1AxdMoluR8ehOFOXdzC3jZVdajyZWixnDZzd0E2niF086SFBSF2IWxwEjCr1bd/rm2ZYZk9FNsI8xDl+qSkmYEfWLsuo6Gmsflh4eqOAZAfzApJTlxpva8IF/4OZNXx10Dg4dttzfT/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlUcglXt; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-121b14d0089so1245120c88.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 23:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767769833; x=1768374633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8Xkuu41aByp3A5R9L/oXxxwCvJMtEdql040u/hj7m8=;
        b=DlUcglXtZCYv7zQ7dbwexw4v6y/JPzTL3WqGt55IZA57CHVMX9LXClmRoi+TYcVC2H
         K/uqMz3kbYCdfG66i7eNvXc4+rNNacxahlOxVTuOoLXgyh3pIa0god8sEnIyidR8YMZH
         tIVvGAtSPyTG0NsKOPXtJ0+N9oMCtgi4P/cWC3Z1s7a4avdAIbMN/PcVb0Eswwe0VQNr
         3XKAySlZgNPR7czJqW4drNPxz+wNZMrPpubu2Bp9NgGVwFJVrk6u+Qvwmo0AQ7CKgu4b
         zMe+kt1wrdOsRM4y8y47mS2XLompM+2sAHhfrdy+UAnaY+TEA9KB3KLUV52VZDU7ApQH
         3uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767769833; x=1768374633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o8Xkuu41aByp3A5R9L/oXxxwCvJMtEdql040u/hj7m8=;
        b=JwnFuXQGUOnwklEFOrNshDi8jUHkXVoA336VPwktu8bkOpjWfELcB+QGgmyYOoJWmw
         kA9+nPqCJ7Qd0rDM1/3vtF4vfEPaG2NZXYtfEeTekjRe5Whgn8Ggj9ZKJp2ncJzMRH2g
         E3MuB2TIGFCtUip90y/lLGLphyEmHQqWCGEkckKkJnqeirt5Smr8OOw5NeqRXIZmijKv
         tvAoUS2EU6dla5Bvfk8fzDoPXZUXIFF7yf06ggy/vV6XbG8QrjjoOi6j7pTutyCr/Kre
         WWuT5LeqARklSbQngOHVpolc5R0i8JbyHeA8VH4ZUjOFK7tNuCfPp9hQLWK3AjW2soso
         Sd0w==
X-Gm-Message-State: AOJu0Yxe4vTGd9AR8DIvIF1xv/eAaTaDEh7Dhh/nUZylqxVw6GP/mS51
	/8pROtIQii24B0ZNuSKE7fIunGlHbpV3m+RQCdt+nUxDB9tNQ7pc9iFAvq8/4dm3
X-Gm-Gg: AY/fxX5OvNK7RKbi3CWLHgDUAved7Diwpcpyt08OZlmjABc6AGt80OC3S4JhqYBV+Dw
	fBX30sOkT5exiMINhHdTa7enZQv2X1680cux7h4085BQnbIbqcv3xHZOupoBn6utjcAZ5kHEXqk
	bQaoXOIAm93GiEnGVLPjYHjpAYezLX0YBVbjTpk4rDFVQ9Cmi+oENW3Rnmyya+8OapyuPgRs24y
	sNELc5PwO9TynR8b0k+i9nZQs/tDZH8N+q2z0HXYNKyX4fbxmPiCOgvvOgHgCPnHEg2twfCT71A
	yIavM/hRfk1NczoX0RycvQJ4ghnruPd2XtTZZB4nDMcLM2kmBKMjFKaGt0yraPr+fd26Yddgqfi
	kHuCST6FtgQofYkwCPy/fw5PZBO6NFEa4c1LrMAtuorAOHU0rFZ7pgO0cyC6DWtRARZK4+KFtmN
	LtTIHuJ3y+56ppB8Z54RAt5r9Nfs2elcjpRHI5dZ9bCt9Kg7RmT5OVqtOfVcsDBXfRsnx0zzP3z
	hnuIeh8X9LReSsoTkJk8BefTJz1cEymOCK3h3TEtMhckSj+IahoDpZB+CpvsBJSSNE4J4b8i75E
	FvaQ
X-Google-Smtp-Source: AGHT+IGcusRHTzTo5rOZXcxnh077EIxkTNY5WaejN+9jgOW0XVLoTRZZbpXPx5dNX/UUlJD1uSafbQ==
X-Received: by 2002:a05:7022:3d12:b0:11b:c86b:386a with SMTP id a92af1059eb24-121f8af824fmr1485131c88.5.1767769833476;
        Tue, 06 Jan 2026 23:10:33 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a53f0sm6091593eec.10.2026.01.06.23.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 23:10:33 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH net-next] net: 8139too: switch to module_pci_driver; remove driver version
Date: Tue,  6 Jan 2026 23:10:14 -0800
Message-ID: <20260107071015.29914-2-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107071015.29914-1-enelsonmoore@gmail.com>
References: <20260107071015.29914-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module version is useless, and the only thing the
rtl8139_init_module routine did besides pci_register_driver was to print
the driver name and version.

Also replace hardcoded DRV_NAME macro with KBUILD_MODNAME,
which has the same value.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/realtek/8139too.c | 48 +++-----------------------
 1 file changed, 4 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
index a73dcaffa8c5..a22360185e63 100644
--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -91,10 +91,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#define DRV_NAME	"8139too"
-#define DRV_VERSION	"0.9.28"
-
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/compiler.h>
@@ -115,8 +111,6 @@
 #include <linux/if_vlan.h>
 #include <asm/irq.h>
 
-#define RTL8139_DRIVER_NAME   DRV_NAME " Fast Ethernet driver " DRV_VERSION
-
 /* Default Message level */
 #define RTL8139_DEF_MSG_ENABLE   (NETIF_MSG_DRV   | \
                                  NETIF_MSG_PROBE  | \
@@ -623,7 +617,6 @@ struct rtl8139_private {
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@pobox.com>");
 MODULE_DESCRIPTION ("RealTek RTL-8139 Fast Ethernet driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
 
 module_param(use_io, bool, 0);
 MODULE_PARM_DESC(use_io, "Force use of I/O access mode. 0=MMIO 1=PIO");
@@ -788,7 +781,7 @@ static struct net_device *rtl8139_init_board(struct pci_dev *pdev)
 		goto err_out;
 
 	disable_dev_on_err = 1;
-	rc = pci_request_regions (pdev, DRV_NAME);
+	rc = pci_request_regions (pdev, KBUILD_MODNAME);
 	if (rc)
 		goto err_out;
 
@@ -955,17 +948,6 @@ static int rtl8139_init_one(struct pci_dev *pdev,
 
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
@@ -2382,8 +2364,7 @@ static int rtl8139_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 static void rtl8139_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
-	strscpy(info->version, DRV_VERSION, sizeof(info->version));
+	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
 	strscpy(info->bus_info, pci_name(tp->pci_dev), sizeof(info->bus_info));
 }
 
@@ -2649,32 +2630,11 @@ static int __maybe_unused rtl8139_resume(struct device *device)
 static SIMPLE_DEV_PM_OPS(rtl8139_pm_ops, rtl8139_suspend, rtl8139_resume);
 
 static struct pci_driver rtl8139_pci_driver = {
-	.name		= DRV_NAME,
+	.name		= KBUILD_MODNAME,
 	.id_table	= rtl8139_pci_tbl,
 	.probe		= rtl8139_init_one,
 	.remove		= rtl8139_remove_one,
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
-- 
2.43.0


