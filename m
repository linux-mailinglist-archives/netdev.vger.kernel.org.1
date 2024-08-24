Return-Path: <netdev+bounces-121672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C8995DF8D
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 20:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C071F217A9
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 18:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F3256742;
	Sat, 24 Aug 2024 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC7oP2gf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF1A4E1C4;
	Sat, 24 Aug 2024 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724523553; cv=none; b=meRyTI6XNwd0j5cF/6k4yqnL/gikN5cv+zMaVgTInmH1opcTPbOreik3W/UcrKWwU2DV83Cao0fM0TzRJWNdPZ+TgIMBKRsXgGaG7oBe+cwdakzJAgihyky36ivTD61Tr0Fr4NvWWR3zAds1GiHVmBRORhfR6bqaI6SV1a0h1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724523553; c=relaxed/simple;
	bh=8aqKhho5jBevbXsA2812aaKnGfNl0vxH6WQyxCWV1AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rijMKmea+SVpL8BE90PJXFdkCsjRO0ihUDKkDoTAZM6mK+Wq05fJW50ooNfV0f4Tu0GU2+6E76hg9fVpGuh6QVkKlq7TEA0lxr0h/rOBN4TUvZa/IB9wdwrid89hqrviK3q4yay1JVLTLMYWMtnONI7u6ebbfi9HJYO99uAD7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC7oP2gf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2021537a8e6so26781625ad.2;
        Sat, 24 Aug 2024 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724523551; x=1725128351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4WBcounhRBBqMevujzXDPEkHmwX6Czcm4dGuVpT39Jc=;
        b=EC7oP2gf4F7b0udl1+qO270DUdYDOA4iZq++acaKIBskWAWHwPxOxi8JIB7O1lD9jA
         25RlJIe4TYzQs8IP6v8ct4F25I3IS/WA7CA6gOy2XC+UspdODQqmSIakt51IbsMsbJ7f
         b6i1Xf6YkEILhk3+8Z1AKJQcx6N6FPdhGa+Ts2XSW5U6bpHILzuROySCFp4ITYUdkLV4
         AaRR4CtmRvxa3Pb33WapL0QDpk6lA9mh5Oowge//dPYoWfeqyADZPeqZtdvecjW/wQtB
         a2IkAKOdik+rriS0yskU/W5n6QJJBi9qEFzgc3mqReT7iNtMEThdFcWususuFNrMxMll
         R+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724523551; x=1725128351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WBcounhRBBqMevujzXDPEkHmwX6Czcm4dGuVpT39Jc=;
        b=XwBpr7Z1SvsJ7WNc/y5MQ0Ygbl2jIdgST+ooY88m8f9j8LM0S+oStwkVEGD2xsa6oh
         KNZPfuK1DERYCl1V2JWNjYHUQXV3aBDsBUv6YpfAgOuFg0PY5HK+TrbFQUlWAGS7uHuP
         6ITFgKbE57yIAW7DJKitqw2IWbb4K3Ve1hXltuZ7nIQCJEYIh1WE04/7dNFvXLpyuUE2
         xp20MYSUAmH4VdDPuIn03KACcS/ZmU+iLNSewxCiocj5DUa+3LuMWGA1fokIrTqjUFn3
         5895Clt+d9R1DjbLhvsGhxdUnR6406tzNPeSjq77ysLw7hdMbG6vmwTjFZi/vNsXTtv6
         RjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLrUwkPeiBLmAEXZgW3L1iP7Rgq5fxZ73CqTbzBtfahfE9YhKRzBXxecVgkSX+VW0SVDBPxlGAfe/MC7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrLn7pQzw7eYOUbDMLssUimGdLp2RHHGTw2kHb0hvC9iGYBeUf
	zzzTU9OEWx6hXs9z4gmSSc0NJfrk8fRrZMhuGF+7nFgy6MEboDq3maOVHQ==
X-Google-Smtp-Source: AGHT+IF2IaHXcF53weI1+/vfcantNK0ICH+Tr9Jt+AWXY0/biuA/8n/uc9y0UL9YZcKC4axi5wO8tA==
X-Received: by 2002:a17:902:db0a:b0:1fc:6c23:8a3b with SMTP id d9443c01a7336-2039e47bc3bmr92592495ad.17.1724523550671;
        Sat, 24 Aug 2024 11:19:10 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560df5csm44959515ad.205.2024.08.24.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 11:19:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de
Subject: [PATCHv3 net-next] net: ag71xx: get reset control using devm api
Date: Sat, 24 Aug 2024 11:18:56 -0700
Message-ID: <20240824181908.122369-1-rosenp@gmail.com>
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


