Return-Path: <netdev+bounces-247609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3320DCFC4A0
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A3E8303899D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE422765F8;
	Wed,  7 Jan 2026 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyFE6yVC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EF1F63CD
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769837; cv=none; b=RBcG6NYDKMs4WVmwjyUUjI7vUeqvSEeot0poR9FVeLF3/Cg1ZDjKg1adXT+y20cezDAQwid9sxlObtFWooQHhIkK2S2GQmibAQRtOobn+OTEZLrZ6B6WagF3w++PHYvW1fQ9YQ3o1VUq/PO1di7fv+ipKejIkHOFpZjsWVgD11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769837; c=relaxed/simple;
	bh=Tag4uW1gJKIbFMRBQGpgPZqok5VYlk0s010/2wTSRLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iN7IepBJpwgkHFjFd2LQ5jz+VrmidSWueqQZhDPVSi2mghMxqx3Xxdfo+umCgVFaerfv96MY5+7/phtdbEeXCiy8ZIMu0WF6MRJqWkP2+ipdmaS6jc38VqMo0zLXSfyjQeNYqh2nWffx0kc4Zf+Im4TnLCWnBFhsSyWl9+8rY4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyFE6yVC; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2ae57f34e22so1623160eec.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 23:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767769835; x=1768374635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SmTNJ1Y/tJtwUpON+YJlGyMTfU5DwilWF+vv967P/M=;
        b=YyFE6yVCoOias+Yo8Lwyf21Fmfj+GPdMp7IWqx7OhVx6GqwtoYwsHSUAwEa/zdPCHI
         /7xzi/aqIrmjBitpJOa2OrAlSXcwg7OYiI/YsAcaprvhLHrgoXnj1BIiNhFlTut5CB0r
         D/cXHDfxDEv47lbgDUlLeVbsh3Qon7QKqmcG9x621DDRbRVWS1/pXqr94ckGy1bDxLEf
         TxLO32BswMHm0P85cL3JOo4DFey/kEUO45B494yv6g9yZ0CW8RmnDfMbn1EdDRgKCcwq
         Bdv75RxDruQeXvdOPAq+S1/Yq4QIovAlHLaSf5ljrkwECB5M3Cv/0kso1J4if9J+2Sfs
         kYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767769835; x=1768374635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8SmTNJ1Y/tJtwUpON+YJlGyMTfU5DwilWF+vv967P/M=;
        b=o7Uc/7RBhWl/nD7e2SgyXIw+l9US9VnAz+lEv1CbD6/CWw8bQdkIWtUZPe2A43qBVF
         932jh8EsEH2RfZkigFu7ZNkfbw/NYp9o3fFWw7gc6UY01b7L1Xib2RRMyQH1LzV4kXZ0
         5Gqupu3GdJT0hHzWdBOtuzyYrniGRDCmdGbHihmVYrsrmma+4rs+RVYvjjUJiuQ9qk9A
         mPSkutCcoWJEg0XimWTNLqBIg7nzrgrH6Xh8RfONLGeA9/Ko009AtnvEQ0N3yFxN/hME
         Fho4e/kYj3IM2lMlLMPZz7oau3EDahKKbqQaRKZ2QvqFGLaIblsEWDiITDsHlQJymzK0
         saUg==
X-Gm-Message-State: AOJu0YwD/f4WyTae6UYLTPWk/75t/kQrY6wW452QDlFkq6/406IXZIUj
	9rtv1qVbIXUNO6wUPLtcVWnsuN3LRuaJUaISA5il4e53koEOBhU0c+xqWfmix+p/
X-Gm-Gg: AY/fxX7Ip0y13LUKUc7Zvr2aMqlbnnExPVPoqQ6e70uSCpKapExNVtk7FDpS1swsQ89
	bn1sCYjAbuH4uMcdG5qawG935sdbSWsg6hjN5d8vrJEShKWdAGc1+irijVrq0wWAU8hLkBIeysP
	7TloRsrgPsv+7TJvfM9h43/CYgJ+46/6EvyLZGz8Q7najjBkdq0S59pME7CBuAzBi9DBNkNNcz1
	83m8B1OMxIVwmIuIclVJvg5X+GstWHoiwXMXaoyUVGKiiRdUz6fIEA1xQi2YNtCtxsByrgv3eye
	lMW0YaTMSZxRONWPabVst0GkpCh5wArT12c62ofXYojPiJVat8gV3QE1OuGciY9gPQuC1xImC39
	CekOSWu4ZCdI5qIl1mnoc3qQbgyLyGMXnqlQn/kdMqAUkCggak2oA0BDWVQn8lNV+X9sT7j3eUg
	R3fFKiA8cNK++sAEJJiKruLJcxwCIHHUxTXl8X5sqRklO6VQlntgih05u7F/V/zQirPd0XXl4p/
	NKK1wwyW7talVJSNhRRvpDX1R2swc0239wLMsjxPuG0bEZRAztURmQcH+Kb9VqWoWTQi73xMB30
	JBeA6K84n1uFEPQ=
X-Google-Smtp-Source: AGHT+IEM0Djs13xBO1962zCB2rl5tFWUEiCWqXtNyAd+s50eRCqI66s8JdGHy/8PwEJkIPOEFCX/lQ==
X-Received: by 2002:a05:7300:fb86:b0:2b0:4e86:814c with SMTP id 5a478bee46e88-2b17d207b17mr1359482eec.13.1767769835194;
        Tue, 06 Jan 2026 23:10:35 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a53f0sm6091593eec.10.2026.01.06.23.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 23:10:35 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH net-next] sis900: remove module version and switch to module_pci_driver
Date: Tue,  6 Jan 2026 23:10:15 -0800
Message-ID: <20260107071015.29914-3-enelsonmoore@gmail.com>
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


