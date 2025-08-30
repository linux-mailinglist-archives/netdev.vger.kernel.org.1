Return-Path: <netdev+bounces-218488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A70B3CA31
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 12:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAA9581712
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88103275861;
	Sat, 30 Aug 2025 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knQOXy7J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1696214210;
	Sat, 30 Aug 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756549788; cv=none; b=PnbJBLOyDv3DzQxbwiOeBRbe6kqqSbvj6jWPTZkF+083b/IOqYpka8tNTw03gKGAnt5JEN7aV4WSzx3xaMMBBQZl0hqbxKf7Cqpley7KnUlvc/tUhoVAzuwKSr9+IjqNZVXEvwq3De0JsKNja4lVf7haAFsKfGclfU47FRU+U0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756549788; c=relaxed/simple;
	bh=DPI+3qXhLHPrHXps9sBC/idDylCwXQMMcO8R1JUhvpA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jyTmeti1Jz/BH0rXovJR3ba772D50eMAqjgvCVigWsMlnDPVqhLEFefU6yD5URk6tCBlsdTT/AXIEWXUFnFnLK6JKDieo/OZf6kbImHJ0UEE17qGJnLAg595aazHs49TUXbuUbTo2a4tqieNP6Pem6iPFihpOybPULNslLR9GmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knQOXy7J; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61cbfa1d820so5588347a12.3;
        Sat, 30 Aug 2025 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756549785; x=1757154585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zW9iMTsNFJqzaVU+9Umz/LvOS9lH5xEq/8s2G/XEJxE=;
        b=knQOXy7JIHCV5fQ/kmq35Mgg65iUy/6gqEIivb99f2ww8NEIuhxNXxoK6ZtKDDafsv
         xNNwLUlCYvZD3x0LBnndJAlGeRTsytEFkVKCo21IU5YmiRPKWQ4akSoul4hR8Duy2ShY
         B2B9xWLQh03bj9w1X1XriMTuKcSl3PSPYTMd40kL2oIBhD9HLZQ6W4psB92RdCQNHRcy
         l+o2VkJ90gxWwg6jwmoxEyG5K2WB5c9vYeNQhk61BNPPh5y1x/WHyUr+SFr/3yjstlqG
         +WggN1VVPH2ih8KT0DTEmX6iU3rq6qu86SVvmcPX9ksZXd/eW2rUAUM6sGkuJxUYrfmJ
         A3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756549785; x=1757154585;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zW9iMTsNFJqzaVU+9Umz/LvOS9lH5xEq/8s2G/XEJxE=;
        b=XwI/Ye1RoGFPUx2kZU5PXAakSXv6GFYDs7teio69r3+Q/LmUH6BMbfJKOHqCYmM0Da
         DfpKzCxvNv8W3UJ4kL1qeaN6nzqvPPFStKlmKqOJLrz2rhVo37/iTMnjkm2uYH1OSrtQ
         buuA/R5tOckiXrUVA6xebU/6iEaUW+fz7AMoHiHxc461bpgLOpXRK0/IU4fhjSu4OYeR
         svF/BNONWE/F62OGi19UsjHHJumdZd5FLN++xK7qecaH+FG6TtY4DkyXHgsAT64cAozn
         rb/l2QJEs6kHlbOH8rgDqPIXJyv8BSce3Ye+OiGi0zUiON/Ra8EA5mboUIWubtBbxhdT
         b8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTgoZR8wKCP5W6xgnWcJenEkQT8iyuJ+/IdIrkhrt3LLjaih58xT1hSs6yFMw8P1s72nALANZwro0b@vger.kernel.org, AJvYcCWxlC5zvoSBs0w+KEXRK6/0rPCV0415A/6ekyx7qSJ6k8mShPvBRnF3FhLcUkdg9dCxt+amRIaZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2N8j2jPbtZCpXYN0yXGC96Wo7zNwM8aCNNdCyaMl2Zic6hFHU
	dpOWH014vg69fxJ2qA2G0LmpjP4DSzWjm6v/fiV0+IQKduBkM4LOq3q7
X-Gm-Gg: ASbGncu62m6tY3MJur6nX2HB1rpIMKHoUTjTaSHxs6HCji0ZwBIIp8EZSBv6TeYX84x
	G9/NgZaKVpxIsOarkl1zJ0jtWfRFsZm8WwqJlT+RiKzdTqPSw7aAuucOaVVTh9BK83J/n9OFocC
	HPxT9oeqE6vj2NMFSBBTgbftE5jEc0ZJuiahMrf2UmL21bNdhvIcUQSRzKtKLzWTVzOP/RUU2HS
	ih03Ep9ngfMWya0HwnYPDykaSpUaW1O4og4rfrKgurR11XkP/6O4RXG9Pk9XwSF9CjRCAxnM2HG
	+UafhhL7Pk6sbUziAHaunSTCisgGykbM6QTWdotikbp/0+pRlyupe1fNyfZaDz3iCFmVpRpZgZ3
	cjxSyw4iC1G0ZhS4YYb+1f0XxMW5eGu/z51jiEWwr6grE5RfRw/4NhcorPcyJ4evm4FOqeYDZcs
	fw7bDvt/HuhUyh5ETu7w5B2XvQkfUf/QztNdQa8QjNEacjBi9X18dG6B5w
X-Google-Smtp-Source: AGHT+IGdeSzlz//5vitphrudTeLP3+ohGqqg8AR+C2VuNQVE861iGJnmaLhDcyecyp7lhX1sBovH7A==
X-Received: by 2002:a05:6402:2714:b0:61b:cadd:d95 with SMTP id 4fb4d7f45d1cf-61d269974c9mr1189801a12.8.1756549785008;
        Sat, 30 Aug 2025 03:29:45 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:9b00:80c:a2fc:7bcf:3a2? (p200300ea8f2f9b00080ca2fc7bcf03a2.dip0.t-ipconnect.de. [2003:ea:8f2f:9b00:80c:a2fc:7bcf:3a2])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc21542asm3234360a12.18.2025.08.30.03.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 03:29:44 -0700 (PDT)
Message-ID: <1d6eeae6-96c9-4c25-a250-01fb7580c9be@gmail.com>
Date: Sat, 30 Aug 2025 12:29:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/5] net: mdio: remove support for old fixed-link
 binding
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The old array-type fixed-link binding has been deprecated
for more than 10 yrs. So remove support for it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/mdio/of_mdio.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index d8ca63ed8..5df01717a 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -379,21 +379,12 @@ struct phy_device *of_phy_get_and_connect(struct net_device *dev,
 }
 EXPORT_SYMBOL(of_phy_get_and_connect);
 
-/*
- * of_phy_is_fixed_link() and of_phy_register_fixed_link() must
- * support two DT bindings:
- * - the old DT binding, where 'fixed-link' was a property with 5
- *   cells encoding various information about the fixed PHY
- * - the new DT binding, where 'fixed-link' is a sub-node of the
- *   Ethernet device.
- */
 bool of_phy_is_fixed_link(struct device_node *np)
 {
 	struct device_node *dn;
 	int err;
 	const char *managed;
 
-	/* New binding */
 	dn = of_get_child_by_name(np, "fixed-link");
 	if (dn) {
 		of_node_put(dn);
@@ -404,10 +395,6 @@ bool of_phy_is_fixed_link(struct device_node *np)
 	if (err == 0 && strcmp(managed, "auto") != 0)
 		return true;
 
-	/* Old binding */
-	if (of_property_count_u32_elems(np, "fixed-link") == 5)
-		return true;
-
 	return false;
 }
 EXPORT_SYMBOL(of_phy_is_fixed_link);
@@ -416,7 +403,6 @@ int of_phy_register_fixed_link(struct device_node *np)
 {
 	struct fixed_phy_status status = {};
 	struct device_node *fixed_link_node;
-	u32 fixed_link_prop[5];
 	const char *managed;
 
 	if (of_property_read_string(np, "managed", &managed) == 0 &&
@@ -425,7 +411,6 @@ int of_phy_register_fixed_link(struct device_node *np)
 		goto register_phy;
 	}
 
-	/* New binding */
 	fixed_link_node = of_get_child_by_name(np, "fixed-link");
 	if (fixed_link_node) {
 		status.link = 1;
@@ -444,17 +429,6 @@ int of_phy_register_fixed_link(struct device_node *np)
 		goto register_phy;
 	}
 
-	/* Old binding */
-	if (of_property_read_u32_array(np, "fixed-link", fixed_link_prop,
-				       ARRAY_SIZE(fixed_link_prop)) == 0) {
-		status.link = 1;
-		status.duplex = fixed_link_prop[1];
-		status.speed  = fixed_link_prop[2];
-		status.pause  = fixed_link_prop[3];
-		status.asym_pause = fixed_link_prop[4];
-		goto register_phy;
-	}
-
 	return -ENODEV;
 
 register_phy:
-- 
2.51.0



