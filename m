Return-Path: <netdev+bounces-148213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F4E9E0DB9
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A2128289A
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934731DF981;
	Mon,  2 Dec 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+Oc3XFW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F091DF740;
	Mon,  2 Dec 2024 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174618; cv=none; b=rPJWQLRtPXYDCfiAFUchotJToOTBVd8dLRGt8OqCmZFRVMb723Q4Akpm1JGPZ2HhgCmTxCQDD1GpcB6QgnKTFBuVvTe8YBoHe7slOARgCAijRA2YTpkTG8K+c9J3wQBwJ7UuVx5VGIljiSTBsxT1Getry7zVG/XMtOh3eM5O8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174618; c=relaxed/simple;
	bh=XL14k83axPDHYcjLckdEaN0RAzq7HGpUmxCP8iY2EFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUs7tRG/yMX3TRuRr1QdrAlhQF3qJ9N93ka2pkf5hQReNJKUeYOtNVFWXlkgfybRiLRHtY+wQj8kb75B5GlKN5PxnGnOj+CxDWnlWy2IvehkQRRhcOJGHGka2lnXIro3OfbaxQaugum+22XLqZiFlwI+dWiFvRu8+/0EAjdKOK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+Oc3XFW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21539e1d09cso43212705ad.1;
        Mon, 02 Dec 2024 13:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174616; x=1733779416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRRatnkW2FFvyyS1UCowv2cxjzV8z8dktdXmCRcfyfY=;
        b=C+Oc3XFWDIc9SQoncpRRvNQwqI1dBdzQVtctIDhMpq0T9WpEIK73VHfdBzTBTfPumY
         EBUSrIxFB33kn6cljayrp4ua2MLZ+FeA+zJUgPDmPhLxlKhNLwLEXQ/J1uye7BWQRvkL
         3P0aPSLWX0e5FpfzRwMHyjBYRLVhyKlk7BveCOzBt/1TRldqcPi2BXnHokxXKfHZ4U2J
         4C489UHYwS0ZJOEZ6LwttjEn+jaHp1DBp2zVyCMonaYJfAQsB/QZFYIVPVtFL/nJmJRT
         MN7RnEdDYAI9CxZwpjz/B7tcuUSyQu7crtrYoSu7N2+QuxCmfXDizqw9wvYr8h85DOBF
         GwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174616; x=1733779416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRRatnkW2FFvyyS1UCowv2cxjzV8z8dktdXmCRcfyfY=;
        b=UKSeeKVnDsoIAzYVhvanqZTv7XxywCzBZpWaTmqtizs93lbAIyfb9ZKof0jmfq6iVK
         zdffc5aXqm3knWVLx2dK9FZ0Korl7bCrBqckgKWxhtonVbStjTQAn+FaW5ocGEJXyVcT
         bLUF+602XN3MDKeAxbtxE1UDf67riYpBhAxtPPUnjYoj5Aq+gKv8103yhHTkn8JTsg68
         4TpS4aUDQJ9KTvXCN+3hFLMk7AVb0rBucrcfgUKeM+GSJx/N8lwNnkmGZbUtcbA4bYIQ
         zD6WItnqMnnXtIMcgMaAzDW7gSGWvkuKyic/3j8WbeX/crb8+z64tEvQ1yGvkVIKm1yU
         n0tg==
X-Forwarded-Encrypted: i=1; AJvYcCXHlSr4FkVaQD1Jv+5lQ75MdLalZvlqPYbhbDNkML6Dy1CTp/X6KTTq3kTrNDcYSCRbyx4097INYcr1kTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaeCVrUcpeG52cLAcIf1/62zwpb7Yp7WQVpXNxgovE6voEeAtb
	loa+tQKJnkvzFmdlE5nQF1DuwuB5DSOAOhMThdzinRle1XyJt92nKudwN0rW
X-Gm-Gg: ASbGncuf9A4Yo7ct4xp4LbSGYBJlOq3Wk/gCIhaOYuZ27lAsLRAb7DY725KDzDgqE4L
	NHu55aXE+eYlSb2D+P9JSO3ECvhuleh4YgAq4uznK4UD8HX0quR7ok+5wZCM7IOS71o69eGsVew
	968hjIzyWyeuDCeBOP+NM21lTKalFwUzus+de/DFqiZajv2eBRS7da6Du6PGYATA94ik+HUUJxt
	DLwDMSCaV93N7D3y27SDw+89w==
X-Google-Smtp-Source: AGHT+IHyoADsXSYWCNjOIOEWnMQZv6NkeQvstYGxDU1iCY4YgqIAPemGrKNn5nkNzYwEm7+NYf10iA==
X-Received: by 2002:a17:902:dacc:b0:215:94eb:adb6 with SMTP id d9443c01a7336-21594ebb238mr83643765ad.40.1733174616073;
        Mon, 02 Dec 2024 13:23:36 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21598f3281fsm20729515ad.279.2024.12.02.13.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:23:35 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 02/11] net: fsl_pq_mdio: use devm for mdiobus_alloc_size
Date: Mon,  2 Dec 2024 13:23:22 -0800
Message-ID: <20241202212331.7238-3-rosenp@gmail.com>
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

Using devm avoids having to manually free. In the case of this driver,
it's simple enough that it's ideal for devm.

There also seems to be a mistake here. Using kfree instead of
mdiobus_free.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 108e760c7a5f..d7f9d99fe782 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -423,7 +423,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	new_bus = mdiobus_alloc_size(sizeof(*priv));
+	new_bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
 	if (!new_bus)
 		return -ENOMEM;
 
@@ -437,17 +437,15 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	err = of_address_to_resource(np, 0, &res);
 	if (err < 0) {
 		dev_err(dev, "could not obtain address information\n");
-		goto error;
+		return err;
 	}
 
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%pOFn@%llx", np,
 		 (unsigned long long)res.start);
 
 	priv->map = of_iomap(np, 0);
-	if (!priv->map) {
-		err = -ENOMEM;
-		goto error;
-	}
+	if (!priv->map)
+		return -ENOMEM;
 
 	/*
 	 * Some device tree nodes represent only the MII registers, and
@@ -502,8 +500,6 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	if (priv->map)
 		iounmap(priv->map);
 
-	kfree(new_bus);
-
 	return err;
 }
 
@@ -517,7 +513,6 @@ static void fsl_pq_mdio_remove(struct platform_device *pdev)
 	mdiobus_unregister(bus);
 
 	iounmap(priv->map);
-	mdiobus_free(bus);
 }
 
 static struct platform_driver fsl_pq_mdio_driver = {
-- 
2.47.0


