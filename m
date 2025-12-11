Return-Path: <netdev+bounces-244335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53106CB507D
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 08:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 013853006F72
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1CF29B79B;
	Thu, 11 Dec 2025 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6aYv6nv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD951A238F
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765439872; cv=none; b=TB0H5bOEf4aRFO6kqxKLP+/ZzWhmK8VLVGLL5m5FqQHK25KaTvGTVdEhhxG9xQDodlLsDyzHz0ynb0hDju6SiDBJK2tH6Ov1/AxtrqBD1H7SiWbXSS9KcuiLOnfdEsaHXVHsjJSGtoja/joeTCWuaP7D8hqxO8zSVynXFmxwCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765439872; c=relaxed/simple;
	bh=Tag4uW1gJKIbFMRBQGpgPZqok5VYlk0s010/2wTSRLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWCqk3XnSzAuWOy4hMft8gGpV2cAPieoow6eJ6kfxtzFwtj4HUjY+RcFiIWfOepNlyiQKlozJ92UcxDV0PwVtDbjwNd89S7EZT5cmj9ZGapXXgTRmKlPUYnmzsyxHGRq7y/hTRbsuXnPoVHeEacXl7vV5kEeYRFZZN37D3qnLu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6aYv6nv; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso382725a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 23:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765439870; x=1766044670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8SmTNJ1Y/tJtwUpON+YJlGyMTfU5DwilWF+vv967P/M=;
        b=j6aYv6nvUXIAgWs01dp5UZakAtuRxra8Gj4V/dLeLAp6LT9tVpj8X48B2bGTyj/Tlr
         KhjrdS8Z4zf6bn+SVbPouYr8+XhDn/mKBIM67QtQEFzKbrA4T91JupqFeidCIPmqdGnE
         WD0wC3oYB1El2P9fLB8Enj30bDmTU/l/Ur9V0MoEqveXG2v1soiaA9XiR1a7cEwUBoOE
         OpmmeOo2Kxi4o8ATTxNGKD5IoubthHzVnwxKTBK2DnRCKVp/GNSIkagMsEy0RLWJb6p3
         KWZFXD7vWJRBMMUr4d97fSVjE+6WfX99fn7CkSMWMTTmmDnuGiFNq0BtnhlNxW7oPN3t
         KnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765439870; x=1766044670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SmTNJ1Y/tJtwUpON+YJlGyMTfU5DwilWF+vv967P/M=;
        b=j9gZzkuTcomw8VU20zm9yZ191K3j7dq+sOQqJIognkjPW3eFJjlDPxkDUqMSBAmIhq
         TQnIGOmMTamY3ZO3mPYlvOcLPDemqC16oY53WbIdSDZYCplTY6N6IegNLo4T3Fi+VCoZ
         r+iYEkLh8ylIFoLrHxVNAAeiVfyWmBWMZ3kJ9N+sMZ9G/XZjTZL2x5JD05UDnT95wrTL
         9GerMGMqvjcl/TEARYzcZo+LIXYGrAyvxFlnvY3z48FEg+ph8ZuC4vgI14IsSuvJRWBs
         vG7kN+LsMZeAP0fMXruD91fGJWnBBr504HH75R6nSSOi9aUUwuqCgF5ctU+pcXzwSsi9
         42HQ==
X-Gm-Message-State: AOJu0Ywg6db3hL10EgL3efKONtKa2/ULnwdZM5+12LLRjw7GEajilLMd
	pnpJmfxetTbfekOUR1G0cseXEhAuGLATbOtdb+Y5au7j8FtQYInQ8iuqlTP3P1JoO5JjPQ==
X-Gm-Gg: AY/fxX64SjhmhxNkEABMdJJ7Va50igIF6VHmjuWrI+7bf6/YMo8IzcNvOltTqEwqAgN
	hSJ71wZcPuugtNnPJf+IU3khYh0XuuGRby/JPTmYuaJ5ryG6+Bycus9SUrnpVUpvlTv39FciSZ5
	CC5HiF/ZHVbEVV+pyzRENVMI/k+TXiZgx0Knc5/Qa7kBWyjSswi6d3w4tSppDxqFqiOPRROIquH
	oijG+CnrSLu7XfUSYEf3VvJ+aqW5Z0QAglD0PxQjfyRqrMs5Didllb4h+smN+1CjiASbdEFOcOQ
	z8ZLKkHesrXdMOL4ZAv/L0P751bwAKfPls5cGRVWh6z2HzKZ7Xv44fPTuGzLH6jX4oiZhJ4bCm/
	+/TXtmT5O2EqRl99ix37RkO/g9Od3eV3f6Juc6hY+3M9r41Wcz4wJuU3OyCKth1RVvMznd/Jprc
	3VBo/4W/XOXu9yIQ460BtMgjf85xADJt+9HTv+Lr+rhx2VQkH9H3Cbfvd0roRADG3FenYJqwhlt
	Gh7
X-Google-Smtp-Source: AGHT+IEwkgG2PCoN2VVYQYz383HJDLCuNe14Skovns9aiYz6qImYkf5P9HHeO2Gx1fM6r1cRwlldvA==
X-Received: by 2002:a05:7022:6881:b0:11a:2ec8:de1c with SMTP id a92af1059eb24-11f296b406dmr4933166c88.36.1765439869950;
        Wed, 10 Dec 2025 23:57:49 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2b4bb8sm4502522c88.7.2025.12.10.23.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:57:49 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH] sis900: remove module version and switch to module_pci_driver
Date: Wed, 10 Dec 2025 23:57:34 -0800
Message-ID: <20251211075734.156837-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module version is useless, and the only thing the
sis900_init_module routine did besides pci_register_driver was to print
the version.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/sis/sis900.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

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
-- 
2.43.0


