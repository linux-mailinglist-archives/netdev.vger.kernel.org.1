Return-Path: <netdev+bounces-122051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD0295FB92
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 23:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9976F1C2104D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F274213D53F;
	Mon, 26 Aug 2024 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBNdXHoF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC8881E;
	Mon, 26 Aug 2024 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707329; cv=none; b=ZZfyHP9ASJ+nUc6J1c4z6N+EtjypNPpHyf27YJH6p5jx7Uu3x/KRiC2mNwOdPnL1qXFwSLL42fke9d28P8pC/5jETQt7ig+tHM4EiPI6IFyUEpaXVaImwfsHyv3qWESUPMnAk3czlTVe5QBT8EZqy4XZ6uaFwFXJULZYf2ByYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707329; c=relaxed/simple;
	bh=TC37VVPniD0xcpWs6hA8hpK2vJeJlfhXQ1u24MF7o+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DseJ2o1iRnIPBhoroqIlRrgTS42eDusw+Ia1DaJ1wAErXFY6HYouaZcIAktRWB87EdykdN9gbPxdxAjxxrvhkcpZ88KN0yI87jxdizlCh7HojNyENQchqzXXgjZLvCPC4VsAP2Ohdi43X6tPNJIFO58Y4RTwpRMLyOPXkHDqgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBNdXHoF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20203988f37so46890405ad.1;
        Mon, 26 Aug 2024 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724707328; x=1725312128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JkjIiL1O9FFHI4xlYtzFY2W3gVPxww5X2yTtZ8zdV0U=;
        b=WBNdXHoFDkdEOYFhsqku5YWs2wTWEFP6NcrP6bZBIFv5sS7MCx7j7fG4F2wC1rKb0h
         StOtZeNtzrMiET7CRmZ7CFQKHOlLrlYgF6nzT9vV8XGjRzGcoToHtuW4rdNvo4Pm+Mnj
         APNzYwOAE65Ac3ztmtFP8e+JCeaVfNYn1/lN+XiBcaxgGPjsfYFcb6L3UegbXAsks2ua
         JNG9x/D3IZ5I80Y7wj/Lgr4UNRZOb9jZ+r5VGo0sJHQgTD+Y3uiLwkd0d1+EhPQrPyh2
         ZPl6Yw80mBFEjZfLYp1H8QSZXB3WbBOu8PooF/nGv3W2r5kj0KGZMNK5+jc4W4Aqavou
         9qNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707328; x=1725312128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkjIiL1O9FFHI4xlYtzFY2W3gVPxww5X2yTtZ8zdV0U=;
        b=d54/O3de/0FzMRwV4av/3JS3WMiQqp+e49xN7FVegiORiH6fYk2sElR5ofgAV6o1yF
         pr/X0Xz3O+f1+zc/vbMepG/T1GWT++A9DRsJ4oXWLgYpAM8/AknyPCN5MSgP3qnoitph
         7Q5Lf1SkK5HB8CrcP3wEco3iR1Pb0bLjX1wwTCy6rTzgbfGyAMNbD3crDktLSLM+Bjw1
         D9jmOkZFs9RvqTQmUCjjxS68zIB2JyPuA//P4ckizYYbWooVYUnAyiyyXwBnW+d8il90
         OWkbZHxVXLGREW3o4JTzzK5RBMOql5JRK5zkpJi0+yBUGjh2vemd/BOu8FrEYOxd4X10
         HmFg==
X-Forwarded-Encrypted: i=1; AJvYcCWC0KhOUjyVBby8OGjdAhcYz+/+8XG8XT1Vi7FHHTaUpLGhWSMqgRa/AH7aDULPoLpacOeEJg2A0x4tXYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX81r82r80lX1noWh+y661wj5OP6GTxpdhEMahlD73z8dYou5R
	H9XtcIxJ3Wxcjd2Vbec2eU/3CDejtCO/2JBIi7C1uL1ahgGF1z6NgyN1zg==
X-Google-Smtp-Source: AGHT+IGoI1aVeSjYIz+6dfRdFdoQRbYTEWMYc3ql1Rhe2gOK8ZPbSNLhKuDC0v0weJvg9aIvf1sg2g==
X-Received: by 2002:a17:902:d492:b0:201:fd3c:a321 with SMTP id d9443c01a7336-2039e54c1afmr103993975ad.62.1724707327483;
        Mon, 26 Aug 2024 14:22:07 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613703c94sm10400331a91.10.2024.08.26.14.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:22:07 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCHv4 net-next] net: ag71xx: get reset control using devm api
Date: Mon, 26 Aug 2024 14:21:57 -0700
Message-ID: <20240826212205.187073-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the of variant is missing reset_control_put in error paths.
The devm variant does not require it.

Allows removing mdio_reset from the struct as it is not used outside the
function.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: don't call after ag71xx_mdio_probe. Already done.
 v3: use devm instead.
 v4: resend to bump the CI
 drivers/net/ethernet/atheros/ag71xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 89cd001b385f..d81aa0ccd572 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -379,7 +379,6 @@ struct ag71xx {
 	u32 fifodata[3];
 	int mac_idx;
 
-	struct reset_control *mdio_reset;
 	struct clk *clk_mdio;
 };
 
@@ -683,6 +682,7 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	struct device *dev = &ag->pdev->dev;
 	struct net_device *ndev = ag->ndev;
 	static struct mii_bus *mii_bus;
+	struct reset_control *mdio_reset;
 	struct device_node *np, *mnp;
 	int err;
 
@@ -698,10 +698,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	if (!mii_bus)
 		return -ENOMEM;
 
-	ag->mdio_reset = of_reset_control_get_exclusive(np, "mdio");
-	if (IS_ERR(ag->mdio_reset)) {
+	mdio_reset = devm_reset_control_get_exclusive(dev, "mdio");
+	if (IS_ERR(mdio_reset)) {
 		netif_err(ag, probe, ndev, "Failed to get reset mdio.\n");
-		return PTR_ERR(ag->mdio_reset);
+		return PTR_ERR(mdio_reset);
 	}
 
 	mii_bus->name = "ag71xx_mdio";
@@ -712,10 +712,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	mii_bus->parent = dev;
 	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s.%d", np->name, ag->mac_idx);
 
-	if (!IS_ERR(ag->mdio_reset)) {
-		reset_control_assert(ag->mdio_reset);
+	if (!IS_ERR(mdio_reset)) {
+		reset_control_assert(mdio_reset);
 		msleep(100);
-		reset_control_deassert(ag->mdio_reset);
+		reset_control_deassert(mdio_reset);
 		msleep(200);
 	}
 
-- 
2.46.0


