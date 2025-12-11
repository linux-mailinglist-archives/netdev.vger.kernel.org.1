Return-Path: <netdev+bounces-244333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9202ECB5040
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 08:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B638B30084FB
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD2E21578F;
	Thu, 11 Dec 2025 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeQPKraE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47172D2496
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765439417; cv=none; b=CwJx6fb9BEXqu4nkIN1vhkLZDHzIgLUjMSisx2vznoZnPtnOonkAVU9bUVlP4ghnoBEJ3XMHwQ+eU7/dVARIvC6EhOSYLhy52TqlO8q81fMkKkIHt7NNn7hW9ser4nK6PEAAvshi0DAjkFqjDaghv03q4rwR54w0bMIL6dP3lGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765439417; c=relaxed/simple;
	bh=owbnL//r+KWquRqNdJqfrO9+/Ug3LQButOa1NWg1nX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grhr1ojkWXaKEZmdi6tqbwYpxoDl10XrntZHO0mLtMmVgCGh6hom+buwYa0zKXWkQf2JBqQuidIZVJVbe8rMpEyV2+YYfSilTei7ujUDWBUEQuHoREEIS62ZM4DUkpVaJLnOSaXEfQbpAp/Speb8YyLTIthtK2JeFEkPgyAUBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeQPKraE; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29808a9a96aso9154535ad.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 23:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765439411; x=1766044211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLhGc7IKbF/fuiSg+oDoM37x+oEbH4F5P1GptqNy0N8=;
        b=FeQPKraEKZxw44AAnTgkcArC6Uap2HbYTDFjkZlQyvUcN6rIG5bH9mxU42WIGUOPoF
         mRJqkyV6QH5lBhAsZfz6Ybd3ASkw9hdCBDljfZ/K/y0NpegFiele3+dl9xr7Gqr61XoD
         n0cL+5qaxuGEECg1QQZEcxOCekCRKEtGJq/qQpGHMJaAy5OsQEpSnNjIhqdyEIplFFLj
         8vNexqtBFn4NwI74KNU5gUj7Ro+2A7C2EEdTMMIPpvhvora+4CRTaQgFpgI5v2BctHSY
         OD7MfxZjNyZb9jE0dV3uR9jbdqGEWPOMI162Cs+CowiGSy2r64h207fXlPsNsjysfg2Q
         HziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765439411; x=1766044211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLhGc7IKbF/fuiSg+oDoM37x+oEbH4F5P1GptqNy0N8=;
        b=iABPiobEVz9fTumgR0ZiZ9+uJJCdyaT82pJfwM2T5ectaa7X/vdW7PjshOgdmkHuOa
         eZoZUbT1Cs3vXBbML9yk4DJll3HO31OqUgxPmVp4uXEaZImFA9xnV2tes0Ig1zyjrZ2F
         270Gi7af8KcSh3aXUGWOJn2cAHXuwgEsZL3BlUR1M1NRS/KTxSpkcuQ4zkk02XN8WXdk
         R7GNNo9ucjizJH9mcSf9/0qFGmDjY1Espka0XrTcQMEbQ2vVzc2RhqXZLrVoN/xokVOm
         g4ma3m5cfh+qCE5kt3tmp2LEDzW/DuI1XYNcnO8qQUBS5EuPR1dVqdxG2PwW+C+DvLI/
         lulQ==
X-Gm-Message-State: AOJu0Yzb1FbXqEfzYQr5+OaitnWYFph5mA0c68cDlEZ52wJZQ6OJNv38
	+DdN5iWat1D4dCH/D/a3E2fsusG17X9NF28ZW64cSDWqa1NSRDaUElFE0JiKRpDCZ96sfw==
X-Gm-Gg: AY/fxX6Ex7ZpjnRWUMo9wB8CTU8Qp5Mm0LxE0+5kG+Nd3p1GMBKkOfL76afvAVV+Bma
	6dGxe9jmExXPlypgFfVa8B0O8p8+9UaSmXYKgCk8HsWV+Qqe6BknqFk/0WJIrXon5sUqn6ilvXO
	F9ot+OnX3n7+O3BHI9rNtc3Ju2f0AK6ojHxS1BDCmx3r8Riayci8dvz14eQ7+GbE2gY5geb7cAp
	cfVHK7W2r/KBJNQP32iPeDR795SddcjiaHLzzkcqPTtEbKJgDIBiFUu76pep1pKQva0SSOGNUez
	aGBZcyyHU4K5OnyCcBaB+q7jdpUR4fBTLe/RVEotUEaPyaB4JdB0Ksnv4CnLJqIH/hU+MQx0KJK
	Hrxn6xm5qM+zR7G2CIKACAOEaKtNavdsYL5ZPYq5IgVgPy79NP5dUeOkT5foeDQAA7MGxGlJqrv
	zHxousIWMZE6zDEeBmRd36IWdnniiYLuJR/YPeinww7kJC1LHtZOZr5JKCvlk+mfQ8ZJUXJ7t+M
	oZW
X-Google-Smtp-Source: AGHT+IGUgFcns7AUX4B4bcPbfODOCMG+a0rWyI+y4GP57JowinENGfrbuxpnd5FT4QSB16rniXxUWw==
X-Received: by 2002:a05:7022:984:b0:11b:c1ab:bdd0 with SMTP id a92af1059eb24-11f296dc7d9mr4458913c88.35.1765439410682;
        Wed, 10 Dec 2025 23:50:10 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ffae2sm4505735c88.9.2025.12.10.23.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:50:10 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH] epic100: remove module version and switch to module_pci_driver
Date: Wed, 10 Dec 2025 23:49:22 -0800
Message-ID: <20251211074922.154268-1-enelsonmoore@gmail.com>
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


