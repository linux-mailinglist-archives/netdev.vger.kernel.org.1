Return-Path: <netdev+bounces-247607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351CCFC49D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A47A301028C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B27E22FE11;
	Wed,  7 Jan 2026 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCAd8xZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D731F63CD
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769834; cv=none; b=UlUy/xF4ogzSdlV4paxZ0uVpYYQDLDUTScpBZAjNGtdszK0U1sZ97YTJIWIRS8E/MMplNsgRJH+u6OJcEILgjFIHZUtngAQpRmpV3+sIilLYDmvrzAE8Oknl6Xm1l8odlWaukuLx+Lykb5aB7ZlpXfitrP0g6DcSRGndSeWwgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769834; c=relaxed/simple;
	bh=owbnL//r+KWquRqNdJqfrO9+/Ug3LQButOa1NWg1nX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7ey6p5ym7MB1XGB+7z4wCnmN/s6yKkqwuLN4681TyRElj/0yP8S9/io5hccuEz9+j3zUT8/qLdgu4EhmBLFDuq83hNZKy1giAK9pR4mn79IqnZVp+0vN7aWZMPECPWLT2Pzi1fhYGk8milogC6fJdAY+9023TImg6097zCc+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCAd8xZu; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so2722457eec.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 23:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767769828; x=1768374628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLhGc7IKbF/fuiSg+oDoM37x+oEbH4F5P1GptqNy0N8=;
        b=DCAd8xZuSq84V3/WydWhre+u0pUXCqE/nwZ0fk+foeSZIxdCBFjU7378CdNNF6s5f0
         o2VjNHy+noSrG233WZK5WOtOrJxPSYdfbXhoC+5Co4ro0TV2VmGSQXe2f7bmt57Eag3S
         fzksYIDIDCYFioIhqRYKdCcC0ukF+P77zwSo6kMvsR8rbOWLMQHsSdRVYuE8SvA1QxkF
         iwFU2qtRFY8n5+lqjtvStipIqbeC4xD7L5Vc0dCIyA1uaJKDLq0teR0LpIX4cxipP2my
         pQYMNNVpiz0J/IYlA9WYYmMNNAA0+QSDUGFMaCO7Yn7HUxBR7yCsnS8Ze2RfUvlfp3qS
         HdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767769828; x=1768374628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLhGc7IKbF/fuiSg+oDoM37x+oEbH4F5P1GptqNy0N8=;
        b=uizpk/i+YqQXbxr8QG9tJZQDZHwTDZcTTSME+PJscN3cL4gDFETSq9+zNZqbnvBsa2
         NyS1tvfQd5qidEDwz/ymaodLOsUuL7Pwj4lPwYvY9zRjPJ8f7rsyPPgt6yQTy7+AKzV/
         R4DQV9Lz/s864UaiBK1FARmLTxXRSm1t9GutDpY9Wb89+408iFkf/oQAp9pUPwq+3zOQ
         hfu+GSpPyZCR9Gac0Yg67ABWeOcVzki1R07bT1+iV1VU0U5N3mJfVwrYoWrvyAZeqfSm
         X1DmfXvvG5re4uTs77yrOIsp2lBubt8VQEDhL618QyFkHguT+Q5KN94Jh2kVd7rzqJXg
         SL4g==
X-Gm-Message-State: AOJu0YyR00aak3V6Vo1sPFbQs15jS6qjBMJDNvHtO6BBqzd4IPlkc98K
	NuvGzFykyd1tpUbtNEm/EmRzVghCQ8It4gC8t7h8s51svOmHJM7J2xnyf+7WfPZN
X-Gm-Gg: AY/fxX7RKB0dxp3FcbG9OWuhXwAz3ojJkMzpNAy9qMdiIp74qWxZJVlpMxHmnbL1iro
	wJyLzXBWeNnA4axzWBKUGDZCLzdy0kK+FLeb0sTYSzdUn+aNXuUujsvggNyIDM9+o1vyqwoEDGL
	weinTB9gziQ4NA7HyqwuRF8zAWKfnfE92hO0uJMfX/wHlKFe1BDaw8nNf3NpmGfVkh4QZ29/osL
	aA38UXsyacM0VWDk4h36+2176i39Y4e8OZvZBfl9d7zBmOlC28C+jTGkKyIpMP6AKurhYYFK/N9
	4lN0pDC2hrUMyzzUMFhx6LhM1lHsNq9GDO9BGZX6wbxIQ+mBNT3WJuNajDygq32ZxIjc/0WInQm
	Tv1o7vWVnwjPWAAsZthR/pdP0PnbDkfeiHx1q89icVteANYwMpXvIXSewUyUVZiOANSTWonx0mN
	exD/AyFT27TWgRRy3rsACzC+f1Zc8qL2B55oOpi1Kk4XA/pBMDQ+UZpTHZIcbUQfaY1oz4ISi/i
	DbOcX41+MYGh+F3XmzsUmKa/GqHwjPfdDNI+TNZ+qLRdPzRoEiJW0S/2Ec+VMcydrafttQINJY4
	LsY8ZHG2HSLtq+E=
X-Google-Smtp-Source: AGHT+IGxTS4vYeArUV4aYClUrWKE4o5kMCbI5NAWAsaOBhcnGo2ZPg9QE3IG2QdtDZei625SJj/c9Q==
X-Received: by 2002:a05:7301:4097:b0:2a4:3594:d552 with SMTP id 5a478bee46e88-2b17d31c02cmr1583845eec.31.1767769828094;
        Tue, 06 Jan 2026 23:10:28 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a53f0sm6091593eec.10.2026.01.06.23.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 23:10:27 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH net-next] epic100: remove module version and switch to module_pci_driver
Date: Tue,  6 Jan 2026 23:10:13 -0800
Message-ID: <20260107071015.29914-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module version is useless, and the only thing the epic_init routine
did besides pci_register_driver was to print the version.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/smsc/epic100.c | 35 +----------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

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


