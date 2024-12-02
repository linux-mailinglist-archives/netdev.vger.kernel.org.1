Return-Path: <netdev+bounces-148215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F59E0DBE
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1105D28284E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076A71DFE1A;
	Mon,  2 Dec 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg6qpsAz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2EC1DFD8D;
	Mon,  2 Dec 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174620; cv=none; b=F2Sw/x6BdZnckoRmrOMfKqX777vmNIzODBEOUk9oAUuXLT/0PLQnJQ34C0txph+yVoXWnfzh8swvcEmmcZ8LPDZqUCKTaTWdN9cRXNW6Qw96Pvj13nUevgX/ZLt+ewSs3fxkFy/VIHjlqorN/aM3vfJ3Fu6dRXu8cZRNir1Y5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174620; c=relaxed/simple;
	bh=bxNdSWBFOuU160wYi2ZuwoNG6N1rmqN5rH4LXYxLWWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBFphsRHwPCTx/zPPeM4CKMKt5ABEqN9p9B5MFHTZ+jfZ/bHueibs0QpDc7P1wlUzSAIpS/pEupCAM4rcEqOupXLIZ5b1lIRiJZvoboyd4TTmw087lV2yxIHqsktLqy3ttzna9Ld3lJrPXmbzlN1IqWtgxj0qASNGhDqJaGhKno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg6qpsAz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215b9a754fbso1507515ad.1;
        Mon, 02 Dec 2024 13:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174618; x=1733779418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ2w1hRvX2gv5YNJeLZGgNGigEr7WSReYY3PlM5Kufw=;
        b=Tg6qpsAzEbiJx2Mv9IWz+ilyXGX249HMYWvwDx9JQcCVc8aGyTXZLyMwvvG50wzwH5
         IF9SXw8ORWDsv5gZdC/hi38xtBwBFBAhj4xLTvi9aWVvA3a2wXE7HWtbBUgROZZ8V+BD
         E9zTpwl/RneU+QY9kRc2X65EM5ap0xx4ife6AaoJ5Y7WIEljzEEgS2w60KFwAN/Mqsae
         9ZYTN4S/MU59eoGYx8tXNNyzHEULFf241SJNb8WCeQp/4IXQlWVe5786mRhmiLA3MKpn
         zDY6JZi+wbIYaa072/goEgVgHlL9BsBBmQA6rn67NlEWFP4xenXh8TNeMrnRDuYo0W3N
         +E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174618; x=1733779418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ2w1hRvX2gv5YNJeLZGgNGigEr7WSReYY3PlM5Kufw=;
        b=eS7kFa4HwNQk1X9Ks2SOG8D2L/TnxmvOn4/JyG28Yu9NoH6v6iibu23pUXoCcsmvw/
         OEA5FMQ7w40bu1cTC6h28zL8LM3jARLy2wGdnbSEGXde4z9y6JFr2kaKL/Yf4wcpAtJo
         irldEqECaK+SIw0HJgXXcRNH980QTjS8EANzeg+ZMpAgKd1pDoOiVdRfTqLD1dfmyuhz
         yW1Zfw9rA4emVBCSv7t9CEhy5ubJzi3cab2lnSi+emmS2o9L0uiK3+Gc4ue4kam3lShi
         /dd6NhmyouC1R2kjytV+MCoNzJpq5agycUflbOcpo/Z/9EtK9PaVqiv8wBty09DYOffU
         PC4g==
X-Forwarded-Encrypted: i=1; AJvYcCVh2VZa7hZ4FeHQ0FX5RFpBhoApcoM9PCp8ycdiHSv50va3HJYr38w9felxbyBc2kn+EWy2Rji8MFrDEMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSd5KigPnr533O0B3I/1rin8TFP6RopLbqDVPfHSG98w/QQatr
	cpQqudkJ+zoz1ZlSJ3ju4J3J0O8K7XMEGlYl5YBO9daHKcnEn/+DXbfjOMy1
X-Gm-Gg: ASbGnctrzF1iVwlxkqtqInS3mVEhiM1fMIcL/hCE4IdsgN0Iqk/D9UPGT/1v0/gBXvN
	Ek8xojPJblORPnyQYRz7SfIuwYi/Kfw6j53zIM8UBSceq/+DucrWFrpTVrztz4mx6S57/BQGl2O
	IiH+gYqoxa8jY/gi1BMQFwys7DyNRFVPRPJlG7sDAMgrqPQBo/Hzltqn+sx4Uzi0W0BcsGn/a9q
	lKHNhO0PQ/EFya8ON/ZS/3IXA==
X-Google-Smtp-Source: AGHT+IHkKJR6eZ9FXINF3O++8Jx9b855BP3/uRz999zRe1Uw7yDq0t+se/JtFnPAIWtQTwx2gwmNRw==
X-Received: by 2002:a17:902:db06:b0:215:7dbf:f3de with SMTP id d9443c01a7336-215bd2005a9mr77445ad.28.1733174618501;
        Mon, 02 Dec 2024 13:23:38 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21598f3281fsm20729515ad.279.2024.12.02.13.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:23:38 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 04/11] net: fsl_pq_mdio: use devm for of_iomap
Date: Mon,  2 Dec 2024 13:23:24 -0800
Message-ID: <20241202212331.7238-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202212331.7238-1-rosenp@gmail.com>
References: <20241202212331.7238-1-rosenp@gmail.com>
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
2.47.0


