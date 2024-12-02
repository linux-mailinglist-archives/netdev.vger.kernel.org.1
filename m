Return-Path: <netdev+bounces-148216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BC99E0DC1
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7060B165657
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399631E008B;
	Mon,  2 Dec 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDk+l1GN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3211DF98B;
	Mon,  2 Dec 2024 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174622; cv=none; b=Tud3l6hKO8dPcIQHclX4NJVkTbDAmCQMpDzo+Kn6J4vrEjo1JqKMjGlr2yCsRSOB2v3HbO1R/66dVMeZMG6lGnBMed/qkLMmVgUd3CjSh804Mc1InrS9AexB1GVZ03dX4W1dJ/XmkwkQL5YnpVEILXgU9kZetxfr64NKoUySzzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174622; c=relaxed/simple;
	bh=atjNlLzigxLFocWOYZ3P9pm/bgS/RCNfQxHKO7I/vHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kirbp1xCq4WGvlwco9fBgxbinR4PAZYBzFtuu2Xx0bLI5KpDC4dMnfBjOHgjf/Oi49wKrfdL2+Od8DA6I8Wmvk5dkBDXQOi4M//QwfZ0m4JghPzal2bIlpq1yj+FR7b6lJ3ADd+57e5NhQtxOcFM+8BM/vG58CXi/NhEm1FJmoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDk+l1GN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7242f559a9fso4661590b3a.1;
        Mon, 02 Dec 2024 13:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174620; x=1733779420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNJMkhvDACNxbVOybBT2qMig0uprGHP3aEgGM+RIyTQ=;
        b=DDk+l1GN9nLLhXdiYphRrRV7o8R2wyZNf4oTYuD2MAd684+g09jbu06GAOxnrvy5Gk
         HqaqPZA9rPDsuNocaoKZNTjRZ6+I2jbj0X/LEROOD4l88/NzkNLUV8PvXxxlIsnMV3GY
         aLEs6+gqnKH7WEKC/E/vUUdGvzLXvN4oLAYK0GuPA6fnJ433gQRlB7M+i/orRH/lzrvn
         KrDacqhhddoqDduyXmV7wopgU++tR6Th1orJKfnA7QMp2ctqZkbl4RUd27t47XGx9nPu
         WtzZaNezz1rWEyn6VXFbN9i7KpmnbfaJec9lwNWb03RstegWLlYvb6apupWMwfG0NCiE
         gmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174620; x=1733779420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNJMkhvDACNxbVOybBT2qMig0uprGHP3aEgGM+RIyTQ=;
        b=tQhzygiGKlyEOVCy9YrD8MhCj0qqAqYBXGF+doUfl9Fj6xNK1zOJeFfL+37jp/CxG0
         TBe/dXWu1T2pp0at9z19Ws1jDjLAYaN1OtbSXmmeW3rOFlX4525NbEMo7hibDnxZmcSH
         UXe4zGvIdULEAvB+zBa9jUc5fy8YPrN2pRAMU0oDXvZDBkDOqVSsK5LMQroVd3bjktEz
         t58I5ZMT4ZHeuoJgkX2FKUNtNs8P3bmIAweTvoobAHPHJLScqDSZHUlwIhwjKitJ2tZf
         SCwPv7EthfZ/t01q3wGoDjA/h9S2af4oYISKgBn41FUOhb+Uaq5QTzUxtik7ajSzlCBv
         KNwA==
X-Forwarded-Encrypted: i=1; AJvYcCXHimOZ6TcEakGOGJpcAR0ZXyE9XjRYcPMyimxIAXRh6aipBVLst7FnZTtx9+OUOs5c1S9ydc92RJssr1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpR8AyTaFUAv+K/rZAVSG90MefOs7MJqZUVSA/bbY6ae6RnC4
	p31kOaenWYAPxY1vEwjptCqNSTMnlDkNOPLQC+FGyssWPxw5IJpeUw888GbY
X-Gm-Gg: ASbGncsYy9wDcM5LKKP6PLDEimGagjGpUB8d839E084b7UId0DJC5cPNGhSJaoJtQZo
	dFoTEfpyjwP/ZmaLuJB94+5sG6HBC22NKiosTyWeJ05jTBa01xkT7EN2Y6P5DPb3LRpxNXLOo0Z
	cON69AjI+erb1aIqcEmPwG3yzxpCBAQUXz+VtDx1Ip3KairYIh4n2XUO3p/24QOCM9kwOn1kBgj
	qLwZtskAb1U9K5jliW0NkFGzw==
X-Google-Smtp-Source: AGHT+IG6SUCrlWHPfaz0GCAKMj23gwP3mzyXq8TY3Y186ZE337VT1kUHxY84bxpVywFPvDXaXpVG4A==
X-Received: by 2002:a17:902:e743:b0:215:4f98:da0d with SMTP id d9443c01a7336-215bd0d8968mr711855ad.15.1733174619770;
        Mon, 02 Dec 2024 13:23:39 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21598f3281fsm20729515ad.279.2024.12.02.13.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:23:39 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 05/11] net: fsl_pq_mdio: return directly in probe
Date: Mon,  2 Dec 2024 13:23:25 -0800
Message-ID: <20241202212331.7238-6-rosenp@gmail.com>
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

Instead of generating two errors in probe, just return directly to
generate one.

mdiobus_register was switched away from the of_ variant as no children
are being used.

No more need for a _remove function.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 640929a4562d..12b6c11d9cf9 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -415,7 +415,6 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	struct mii_bus *new_bus;
 	struct device_node *np;
 	struct resource *res;
-	int err;
 
 	data = device_get_match_data(dev);
 	if (!data) {
@@ -465,7 +464,6 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	priv->regs = priv->map + data->mii_offset;
 
 	new_bus->parent = dev;
-	platform_set_drvdata(pdev, new_bus);
 
 	if (data->get_tbipa) {
 		for_each_child_of_node(np, tbi) {
@@ -490,22 +488,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	if (data->ucc_configure)
 		data->ucc_configure(res->start, res->end);
 
-	err = of_mdiobus_register(new_bus, np);
-	if (err) {
-		dev_err(dev, "cannot register %s as MDIO bus\n", new_bus->name);
-		return err;
-	}
-
-	return 0;
-}
-
-
-static void fsl_pq_mdio_remove(struct platform_device *pdev)
-{
-	struct device *device = &pdev->dev;
-	struct mii_bus *bus = dev_get_drvdata(device);
-
-	mdiobus_unregister(bus);
+	return devm_mdiobus_register(dev, new_bus);
 }
 
 static struct platform_driver fsl_pq_mdio_driver = {
@@ -514,7 +497,6 @@ static struct platform_driver fsl_pq_mdio_driver = {
 		.of_match_table = fsl_pq_mdio_match,
 	},
 	.probe = fsl_pq_mdio_probe,
-	.remove = fsl_pq_mdio_remove,
 };
 
 module_platform_driver(fsl_pq_mdio_driver);
-- 
2.47.0


