Return-Path: <netdev+bounces-145692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C419D064E
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 22:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 971F0B220F7
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50BD1DDC3E;
	Sun, 17 Nov 2024 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjMi5NXm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A02D1DDC0A;
	Sun, 17 Nov 2024 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731879097; cv=none; b=PZ5txwfJca4btL1Aezm5jfkwTnTaYTDJPDplpaCb0GmrqQ2a/qNcWwrnLzPeqZoeTevUW/JoZiIU8gdrf4tOvZLSCGOt+3fH5JqI+ZXZ+uHxmbAGuLYKQP2zikcwlGqgVPmUTEU2j+NfDrvbnW+mKmIDTQ+d1mginRLju+5eExc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731879097; c=relaxed/simple;
	bh=ozRvIq+5MLZjFrIsB9dsL65UNaZZtxTlG8giMAmKx58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4zxvOaHeAK5UOQ/xeeBfU7V0tabyJYV8dXwQMD/Ep3hGzpIZJBBaxYr82HCX4ndcsko06MYu1mkHS1pFuw/67Aue1JhFjxZl8MbUc0SViYcq56wbdlcisVgtPKjSgDO2xsdKRVyYFGDOS3uHUcWKyEYbMl3f+XlyqjiZ8Km+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjMi5NXm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20caccadbeeso25534925ad.2;
        Sun, 17 Nov 2024 13:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731879095; x=1732483895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iook0iJ9F0LvdQG0CTeBdy7oSyhdF855HqAsvOcFkV4=;
        b=hjMi5NXmLWVfW+16x7H31Nhjr8gAJdGgadE6yv4jJ8Isndmfj7thmptzgdotgH7Wf8
         PhiWnVG/JtISWDB62R0F4002R+2wNm6S5PIBSz6M2b0s16gNNR0fgwb8YlFgTRt/fvXI
         TInaZtnJ+7ikN6p2LayhvYZqilUnxHaR58JPFibDIsDPUna9Y3HmQQnvxAsLxy+vojRg
         gIEgsk7C3lUIHLTCseKMI9/ACV8X34cPEWHn0rzREduPVrp9ZGmngrl04CP4zqSRwvoI
         EF2qPl/w8Iz7TRfUlDaikSLJI4krOBiHGM5swvUS7vt/rvLNY1+5NFIdbeRFn3nJ2Rtr
         vv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731879095; x=1732483895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iook0iJ9F0LvdQG0CTeBdy7oSyhdF855HqAsvOcFkV4=;
        b=f/ESez/gIYb52JWqA+VTq5HXRzqqQHsr8L59SMfl3GRW7c5pTzjG6Zix0USrqBpAXs
         s2Uc8GMtVyspNNP9uwAJO2pZAuvrTTJmDmzEvYTsT1p8TrAFX34noRCq6kGrYOJ0n80q
         dRk4ePp9s9odvIJPChJNotEfwXo3i5OJ/j1L0eAJRoQcwhTTKKDSNZ3d7LvSxzU/v9Gs
         k43H0XuqQHDYwlMkLO06oOPx63g1JQ4ZpfzIp+bdkiOABoKt5ztkm5LW8HbGGdYcqLNj
         Fxasayy/3WFsyJcZSTH/CbeDcXO8CDuO4p+gkPrTFpAasFO7JB6Ui1wRg7rF8hD6z2jr
         7XxA==
X-Forwarded-Encrypted: i=1; AJvYcCUvz4FOtl3YyTqHKcr1G+vENjHMDk75P3u3r+j4F+3wnmKe/dUh18J0IbIk+emm9xkXDTDqWqjVEvbB6uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuoXQxzLcO7CcNEfPPyhxvapF8h0D+JRAyTZDEIW+byl5mmZO
	AoOj0v8Lql++ZYjN6vaVJUgX5aap1oPnZ/Z1W9goG1t4oBZoCOY1ZdqYtA==
X-Google-Smtp-Source: AGHT+IGR45dnuLOwoGZ/oITnX3sqfh7nKIR7jPyBkzLAuW7WuupTOzuVslPSNA5Wfp9z1mGzsJXokw==
X-Received: by 2002:a17:903:2a8d:b0:20c:a44b:3221 with SMTP id d9443c01a7336-211d0d70474mr140858495ad.15.1731879095512;
        Sun, 17 Nov 2024 13:31:35 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f54299sm44277805ad.254.2024.11.17.13.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 13:31:35 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	ansuelsmth@gmail.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/2] net: mdio-ipq8064: remove _remove function
Date: Sun, 17 Nov 2024 13:31:31 -0800
Message-ID: <20241117213131.14200-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117213131.14200-1-rosenp@gmail.com>
References: <20241117213131.14200-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change of_mdiobus_register to devm_mdiobus_register as devm allows
removing the _remove function as well as slightly cleaning up the probe
function.

Regular mdiobus_register is fine here as the platform device's of_node
is used. Removes two variables from _probe.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/mdio/mdio-ipq8064.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/net/mdio/mdio-ipq8064.c b/drivers/net/mdio/mdio-ipq8064.c
index e3d311ce3810..9f13e16edb17 100644
--- a/drivers/net/mdio/mdio-ipq8064.c
+++ b/drivers/net/mdio/mdio-ipq8064.c
@@ -109,12 +109,10 @@ static const struct regmap_config ipq8064_mdio_regmap_config = {
 static int
 ipq8064_mdio_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct ipq8064_mdio *priv;
 	struct resource *res;
 	struct mii_bus *bus;
 	void __iomem *base;
-	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -140,19 +138,7 @@ ipq8064_mdio_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	ret = of_mdiobus_register(bus, np);
-	if (ret)
-		return ret;
-
-	platform_set_drvdata(pdev, bus);
-	return 0;
-}
-
-static void ipq8064_mdio_remove(struct platform_device *pdev)
-{
-	struct mii_bus *bus = platform_get_drvdata(pdev);
-
-	mdiobus_unregister(bus);
+	return devm_mdiobus_register(&pdev->dev, bus);
 }
 
 static const struct of_device_id ipq8064_mdio_dt_ids[] = {
@@ -163,7 +149,6 @@ MODULE_DEVICE_TABLE(of, ipq8064_mdio_dt_ids);
 
 static struct platform_driver ipq8064_mdio_driver = {
 	.probe = ipq8064_mdio_probe,
-	.remove = ipq8064_mdio_remove,
 	.driver = {
 		.name = "ipq8064-mdio",
 		.of_match_table = ipq8064_mdio_dt_ids,
-- 
2.47.0


