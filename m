Return-Path: <netdev+bounces-78974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB9987720E
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 16:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC632B20FC1
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551D245C04;
	Sat,  9 Mar 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="heZy+aDX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867AA4594C
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709999704; cv=none; b=vBj1gzh7MdNO/E6RNgAcJJOUOwCMutKMbSJyZkV3szL2OCLuSZiT2uwCkI7p1sZVpTjpV+Ohd9t1QNeDB0sVSWRKNaaEioMyW+UbCImupWilFnwY+0xj3bfBqYgGoJLzyy3Qes2gyDDw3Eqcaqja02QQeHs1aslHYkM/1VRGcmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709999704; c=relaxed/simple;
	bh=oxb58H+3dJL1CUmBT7+dL71n3m5oVb4JbCJojOpkuYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVfRBZHw3bxG3yth90wPPgqcwREoZxRj1TG5NXGppSlNnPusaymwiTnMqWWkPCnnUd524Vd2cV9WEJW+Lw4l5TbVb1gG4aW1FCuz8fmEIhgL0KYV3ElrjA+yCODZIE6YdhveqoBuINPDpj0YGCbSQKkHiqSmcLDpCqVXLqGq//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=heZy+aDX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5683576ea18so1488604a12.3
        for <netdev@vger.kernel.org>; Sat, 09 Mar 2024 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1709999701; x=1710604501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLBg9xRWeOEFGDBrQs7OucUs0Od0oeREZgUIErgurhk=;
        b=heZy+aDXlJeGbKVWKYgYdQT8r/MrQSG2MRcfUTnMwMntU1BZCwnBrnVizOKvHmdeev
         J3e4qE4X73ZFlD8fyXEX9AeR5tDwkfNWKyAS0MadIyhU9zoj4+gXrLFs86I0RqV00cFQ
         LyaEbe3CC1Ek0z3DoIZ3f62CX4icO1UTpk4J3KX+bctWyaURlUeg7O0igVy2pvQh0AWd
         LvKc00yZwcoIMu+tY4fFnnJipNOKZirT6m2RRawmb/dYkSNSUqCP+VOYYxhSLzEJH8dj
         cJcGDu/hGS+i9tNP5d3/OZbxzmkvoht/quqatTXLJ6RZ1oEDs+qmDmIsXYnpOAiDG7WQ
         GnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709999701; x=1710604501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLBg9xRWeOEFGDBrQs7OucUs0Od0oeREZgUIErgurhk=;
        b=CmexaOWbNG+Z68ECgTsMDL+tnfdRlnZR/d0yTiu3dNrFxV2YoS9cbzO2aLLWC2aXuX
         5jPogn2vCFK/cSDnb6rM5Wpt1Lrqwx8tN5qnJEh4UUlNVfxHp8pRlQ3qaL/ozdqXpaEr
         uozVOz2/r8SOkdNeRVnU7J0lnQiKjjcW9Brb2ycsKVDIFlsn85F1w/X49yGXp/XeHy4H
         tdRzvEbc4QoJsUoElEa8MbWVApnanl9VyNUH27fGJ1zznxcZAG8MlFgqke0XtJer9BQK
         33BXp4bYOzRvUdJuGiqjD6BFC9gC9mVaCP+9Zb7Sr7s3cwNLIGDoVzJIrDmiDNX3M4TB
         qdgw==
X-Forwarded-Encrypted: i=1; AJvYcCW5c0xBSgkeX+8fzs4CrO/PtKIN8xSbMNB3EPSwhuBOzyL6p4mM/iFEOgoo6qwps2IsqGYR8H99Jg6mjs5FNNe0QI8Xr4qR
X-Gm-Message-State: AOJu0YygQtIQm0ceXP5GyMHo3mYcJi0VUt5HXCZ8gvPi/f830zO+Ox45
	B8VvflN2pENsjv5fXWBeJ/fXSEOQWFofW1ez9e5WGAz27v6mGlyGN4ooyOGZq/c=
X-Google-Smtp-Source: AGHT+IHFKrKh+q85JxwpYDVCMdheOuNJVT349n5QNXE4KZnL8RYGyBx+xA62cTryxrHnY6Xf4F1XTw==
X-Received: by 2002:a17:906:c183:b0:a44:2ba0:8200 with SMTP id g3-20020a170906c18300b00a442ba08200mr1106169ejz.26.1709999700834;
        Sat, 09 Mar 2024 07:55:00 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8c6a.dip0.t-ipconnect.de. [79.204.140.106])
        by smtp.googlemail.com with ESMTPSA id kq17-20020a170906abd100b00a40f7ed6cb9sm1005216ejb.4.2024.03.09.07.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 07:55:00 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next 2/2] ravb: Add support for an optional MDIO mode
Date: Sat,  9 Mar 2024 16:53:34 +0100
Message-ID: <20240309155334.1310262-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240309155334.1310262-1-niklas.soderlund+renesas@ragnatech.se>
References: <20240309155334.1310262-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver used the OF node of the device itself when registering the
MDIO bus. While this works it creates a problem, it forces any MDIO bus
properties to also be set on the devices OF node. This mixes the
properties of two distinctly different things and is confusing.

This change adds support for an optional mdio node to be defined as a
child to the device OF node. The child node can then be used to describe
MDIO bus properties that the MDIO core can act on when registering the
bus.

If no mdio child node is found the driver fallback to the old behavior
and register the MDIO bus using the device OF node. This change is
backward compatible with old bindings in use.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/ethernet/renesas/ravb_main.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index fa48ff4aba2d..b62f765ce066 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2564,6 +2564,7 @@ static int ravb_mdio_init(struct ravb_private *priv)
 {
 	struct platform_device *pdev = priv->pdev;
 	struct device *dev = &pdev->dev;
+	struct device_node *mdio_node;
 	struct phy_device *phydev;
 	struct device_node *pn;
 	int error;
@@ -2582,8 +2583,20 @@ static int ravb_mdio_init(struct ravb_private *priv)
 	snprintf(priv->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
 		 pdev->name, pdev->id);
 
-	/* Register MDIO bus */
-	error = of_mdiobus_register(priv->mii_bus, dev->of_node);
+	/* Register MDIO bus
+	 *
+	 * Look for a mdio child node, if it exist use it when registering the
+	 * MDIO bus. If no node is found fallback to old behavior and use the
+	 * device OF node. This is used to be able to describe MDIO bus
+	 * properties that are consumed when registering the MDIO bus.
+	 */
+	mdio_node = of_get_child_by_name(dev->of_node, "mdio");
+	if (mdio_node) {
+		error = of_mdiobus_register(priv->mii_bus, mdio_node);
+		of_node_put(mdio_node);
+	} else {
+		error = of_mdiobus_register(priv->mii_bus, dev->of_node);
+	}
 	if (error)
 		goto out_free_bus;
 
-- 
2.44.0


