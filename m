Return-Path: <netdev+bounces-205923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE6DB00D51
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9133E1C871CA
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8722FE392;
	Thu, 10 Jul 2025 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny1eTjCT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F9E2FE369
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180039; cv=none; b=Q2C5ssJU/FhOF0ia5Ll9ggKPqdVDqX0T5d7Prbdbz1hz5R/pdzDgG0nsyDnqTU2d5SVZ3deaqQgbZpJU7jiO3dVzE8+SrhIijG/yyCHBT+sHPlqrGnPbbkerHWZnKTb9wbdOIIu5Hn28KsG/r/z8KABCtytiZ9V0TZ23GqMsOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180039; c=relaxed/simple;
	bh=iQuHO8Yk9nkiwSU1m47YlsR58CrsG1syZLBi1I0r5OM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cieU4U6XOIVY+WYLGwNQCVShWJaifHEOVvxj1UwmbpO3lQ7WT5I0ipFR3bRXIQ2uimRpNZFCFcuWZgz2y1rJiVSDiAvIk0zOk3gmZ44sY8/tZ6oS5OBsk8lnFiFUtI4++E2FmckCqxbKDJgqAnuW8IDZj8D9wKun4ZKC/pS/0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny1eTjCT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so1723422a12.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752180037; x=1752784837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNPbjjVG+KzuOOjxmUJlLix50zLTraK8B0vcdqQ2kuw=;
        b=Ny1eTjCTqYKky8tCEJdfPZoMvW9eqJ1UhNNi06ir4LDixlZBDZCAwfx+70lEKrdajl
         adneuqyjT/ENHOdAg3oiJMD+i6rrF6V98WDhl7A1Rrhm/wn21PLFRe1QjvTYLiC/OMz9
         DrDr8haeVf4wTBv9ftuxRbW/s+x2hDHP9yGbF801ag1SoSktsd6zaU+5l8xp+jxFf9nd
         VmDvwnX45f97XkcZZTMj5cQktjtxr92/Evp3laPiQBYGWOXEkRgLDJLennfx+/31JjuV
         QgvBj1e8E+pIOtaXkuXqcK6HOfumyucWc6Q9OUj67Kra/p0Po1aGLngqemOLLqliuPsa
         lUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180037; x=1752784837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNPbjjVG+KzuOOjxmUJlLix50zLTraK8B0vcdqQ2kuw=;
        b=P9sARV292LXm1sA9QH22gVGhRZlQ9Anshiy7tbZ2ZnSRwfT8vYMVZtOUX8GQDCAevh
         aQG5m5CaKGBoNRzwAEn6tDgriNGTM+XnIg+WvX+5LM4fUAEg61dNLsDdf/ahrs/Ywh0A
         DtYMqypGuRR8mqYAWNzzGXJIAGciGC3aRfQNAdFQVGv8uHLKNv/q/miqrdVnwsnxGpkC
         oaHJtxWSui/9yO/wN29nZ8f1yqQ0SdljFBOelSHI0XodwuR0M1ysY3AA3Sarcm4zY1RK
         GYvVPsX9HHk5r/QgnAtXiWSMukm+hKJW7Ivy1kiIz5ZV+rf9QC3qDiqbiANnzdt+8OoA
         nH0w==
X-Gm-Message-State: AOJu0Yz0Ki+gRufpLng6JawOa2Qjcxr7YFDw1TnsInvX4flkqPrqYC3w
	fjvdh5hB1X9kFnF9Wzznej5oPlHm9Uu09g/7wAC8vq1U03SgXWLltN3JHvfIo/bX
X-Gm-Gg: ASbGncvGyTgmgW4cf/r3xT8vVL+U+G0hTT+4KLOPr6oNSywu/KaVjIQ4yYDxMRQ9maN
	7PeuENoNFmU77DJUeLnfBRZYHWuOgnkbPReWlss9SZBV26FCxOviKqBMFYlzw3Af6CPmKjlTSWu
	YL64eh68/X4cXR4I52of16Kt/yZgQ2yFRFKwbM7u8/vnZ0JkRfpvW4PHq9lmhVzfEubhG1bhX3F
	/UNZpOdEr+2LazIcJMm7m0q2ZqYh3VjbDKttf1Ew9/hJnlXn5o52ZhNZXZtdAYUHhprF9i7KW/k
	Rdp02yCAHuEuaHvgCv7sM7HSgjUP29gSsMwSo0Y+m20=
X-Google-Smtp-Source: AGHT+IGDkiTQfvebdOLParTem+ulwvQMNZU6WFqVyTct5Qs+rTyCUEq6sZFprjb9NYyIknxkUOb/Wg==
X-Received: by 2002:a17:90b:4a81:b0:31a:9004:899d with SMTP id 98e67ed59e1d1-31c4ccd89b4mr1352588a91.18.1752180036640;
        Thu, 10 Jul 2025 13:40:36 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f4d7sm3547861a91.46.2025.07.10.13.40.36
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:40:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 04/11] net: fsl_pq_mdio: use devm for of_iomap
Date: Thu, 10 Jul 2025 13:40:25 -0700
Message-ID: <20250710204032.650152-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710204032.650152-1-rosenp@gmail.com>
References: <20250710204032.650152-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using devm for of_iomap avoids having to manually iounmap in error paths
for this simple driver.

Add a note for why not devm_platform helper.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 24 ++++++++------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index f14607555f33..640929a4562d 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -443,7 +443,12 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%pOFn@%llx", np,
 		 (unsigned long long)res->start);
 
-	priv->map = of_iomap(np, 0);
+	/*
+	 * While tempting, this cannot be converted to
+	 * devm_platform_get_and_ioremap_resource as some platforms overlap the
+	 * memory regions with the ethernet node.
+	 */
+	priv->map = devm_of_iomap(dev, np, 0, NULL);
 	if (!priv->map)
 		return -ENOMEM;
 
@@ -455,8 +460,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	 */
 	if (data->mii_offset > resource_size(res)) {
 		dev_err(dev, "invalid register map\n");
-		err = -EINVAL;
-		goto error;
+		return -EINVAL;
 	}
 	priv->regs = priv->map + data->mii_offset;
 
@@ -477,8 +481,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 				dev_err(dev,
 					"missing 'reg' property in node %pOF\n",
 					tbi);
-				err = -EBUSY;
-				goto error;
+				return -EBUSY;
 			}
 			set_tbipa(*prop, pdev, data->get_tbipa, priv->map, res);
 		}
@@ -490,16 +493,10 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	err = of_mdiobus_register(new_bus, np);
 	if (err) {
 		dev_err(dev, "cannot register %s as MDIO bus\n", new_bus->name);
-		goto error;
+		return err;
 	}
 
 	return 0;
-
-error:
-	if (priv->map)
-		iounmap(priv->map);
-
-	return err;
 }
 
 
@@ -507,11 +504,8 @@ static void fsl_pq_mdio_remove(struct platform_device *pdev)
 {
 	struct device *device = &pdev->dev;
 	struct mii_bus *bus = dev_get_drvdata(device);
-	struct fsl_pq_mdio_priv *priv = bus->priv;
 
 	mdiobus_unregister(bus);
-
-	iounmap(priv->map);
 }
 
 static struct platform_driver fsl_pq_mdio_driver = {
-- 
2.50.0


