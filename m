Return-Path: <netdev+bounces-212238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B796B1ED4C
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EA518C5BF2
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5DF2877E9;
	Fri,  8 Aug 2025 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cMkHCi4k"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6606A286891;
	Fri,  8 Aug 2025 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671969; cv=none; b=gFMtcoIM+ZRl9TKfXVfxVP3lW/QEAJBgijdECeqf4xLYzCWQuVNA+r+w7eOj3x0Cjnc3QGCxBpoL1py4MtknHKIW/+Bdf/TMhhTyDzXx3j6ujKeSF5tT9J9V+FylF7dEE4079X3nNvelUz/wJTPBUUoBi1G3y2XTcoPgErJqdIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671969; c=relaxed/simple;
	bh=DGvp8XTAbNeIQIdK1hHPZKMKWnCqv1hyvU/+vQAFNb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pfw6hhYacNbvCDvB0Y30yi6ckD9az4wF+XQl5Z25QfvZDgztZ2N4Xjm9mbkxbkqVrHKAWZGBwz1EITKkk0NM+Po5HgzZt9c1W+7LIdyS6Y/NOXLTvoGsOcakuo2aNWz10kQHr9TS1Gzf4NXog/YKT8b7XgH1fhy/Ix4r6aa6vvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cMkHCi4k; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3102442D2;
	Fri,  8 Aug 2025 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754671959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AccY9f1aSR6b7hyUSSVrdnIcUcn+hK4CKvMlg1bZh4Y=;
	b=cMkHCi4kzKOuZTawBpYhQhTfXGtimB0Ye8RtSf0JZvUti59e9yFKshptWJVmRdGQXtTB4x
	toN7hrNuHKvQ7TTAOSQbVCGHLEzkxaNMoVO+6l1jW9HQFShKagQJ2gfmQZ+ax/kbQ9pCDJ
	9LehJPy4VScyvUbtnqBTxer2wr78OAU3mmKdjxqBa/1nep7a01m6NND8pqTbF1EhNJAyFB
	AnVhH73n67nIkrd1gY3kpNhpWjTpMrKZTWhBy5ZvOcCGD35k+awwH6RnUJHrkRhWhhVUur
	SS1eNeflv+RIU2buGzB7HHlMIzDvFLYxd6aOi9bqoO9dUSijVAWmwif2ZgTuNg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Aug 2025 18:52:33 +0200
Subject: [PATCH net v3 01/16] dt-bindings: net: cdns,macb: allow tsu_clk
 without tx_clk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-macb-fixes-v3-1-08f1fcb5179f@bootlin.com>
References: <20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com>
In-Reply-To: <20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Harini Katakam <harini.katakam@xilinx.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepvfhhrohoucfnvggsrhhunhcuoehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelvefhkeeufedvkefghefhgfdukeejlefgtdehtdeivddtteetgedvieelieeuhfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgupdhhvghloheplgduledvrdduieekrddutddrvddvudgnpdhmrghilhhfrhhomhepthhhvghordhlvggsrhhunhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshdrfhgvrhhrvgesmhhitghrohgthhhiphdrtghom
 hdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehlihhnrghrohdrohhrghdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvh
X-GND-Sasl: theo.lebrun@bootlin.com

Allow providing tsu_clk without a tx_clk as both are optional.

This is about relaxing unneeded constraints. It so happened that in the
past HW that needed a tsu_clk always needed a tx_clk.

Fixes: 4e5b6de1f46d ("dt-bindings: net: cdns,macb: Convert to json-schema")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 559d0f733e7e7ac2909b87ab759be51d59be51c2..6e20d67e7628cd9dcef6e430b2a49eeedd0991a7 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -85,7 +85,7 @@ properties:
     items:
       - enum: [ ether_clk, hclk, pclk ]
       - enum: [ hclk, pclk ]
-      - const: tx_clk
+      - enum: [ tx_clk, tsu_clk ]
       - enum: [ rx_clk, tsu_clk ]
       - const: tsu_clk
 

-- 
2.50.1


