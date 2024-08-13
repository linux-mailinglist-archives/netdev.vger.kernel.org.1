Return-Path: <netdev+bounces-118087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78577950787
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328D92810B3
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3850319DF62;
	Tue, 13 Aug 2024 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdyU5s58"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557019D8A8;
	Tue, 13 Aug 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559304; cv=none; b=rUAF9+LE3t4eh+VuJBGeApOm3EGVqAVJnvQ9mOyrh6VL57SMGTElTz4gDxxn2UiPSI+Dq0Q9oh9Aky6c2XQH3He5IiWfFY5g2cby72iJUlhXgbqstyDOrGDZg+WfuL0A39RQHp7jL/igrfceBE5UXvU6AzDjsuflrc7YuFknp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559304; c=relaxed/simple;
	bh=MNnLV25K6YhULXYYlXhNI0BKUG+LUYqABdwm34GgDDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAXGNtATrz0hvCpIOQVzz/OgiEBo8ccoZfea/SUHx5ZSMWYWggMvidJNZIkz7NHB0iZqRn/mmLauRVZbmF84kK4ZTX03L2zINx4NKsVAvTfpWp6IvpFVII06vZYylDu1BS/AOfZq/RTWAj9XAs0oR5ZRYOp+k3oig+PKZ6D5gVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdyU5s58; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a728f74c23dso604528466b.1;
        Tue, 13 Aug 2024 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723559301; x=1724164101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t11NvRdsE6tRyZHoH+rh9Stx+kDJmXVz4PuKIrvrxow=;
        b=NdyU5s580dt7Bl3LRh0gkNmX8Thzo2KeOaKWsbkBS+KMGA8L4n8Ijl3XhwPQFh/txS
         N+ssBJKbCZot+zCJK4hKNz2AOPk+52zkmSS7UuEN2Fjm7QHCWfa6v2Cw1JyfAahJM8C4
         veMC2JX8SWdpWD/CdXcTy6H3qJYldqZ3XFGcAoT2NM4J7636Y7e0RaDfIlOS3PjkccpC
         MtTLghPnhRUorpuynWPWd8Z8l5SbYEL8BgP8fk9BMotLZxD1BAz2xZYsq+SRPAn2Pc/W
         MqNJYlMZBxcUTlqlhha165OvEN87XM/IqfUnq9IWOr0r88tV7M0VeqhbosN+8nnVAXdA
         Sscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559301; x=1724164101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t11NvRdsE6tRyZHoH+rh9Stx+kDJmXVz4PuKIrvrxow=;
        b=US83qjWkCgoU9Ln8Hx74LNB/p7HXAMen6EmNiQXloagtsa7wspatNzY8L2JOvnLGxD
         BH8narUO3NSw6HvzcBB0rhk2OfZB3vZaf0G4rnaiz6fcHsmJWWXmijOc966UuA95Knys
         a6BpbbZwqpuzM7/g1HzqSZezFmzjz4L1UwmxKx4u6WljD6J9lyVBE76NMOsPviNWNo6/
         5NwTrl48n6brCG7nyVCwYFmj7TvLWaj8E/0JKf89eU7dGXt16ETtLTkLxlme5uPTVj2z
         XzEGL2BeEVJNRAAGXN7+CfjFDVb++FTKyYksPFxUROu2PW244n+9oh8v6l4jWUASfS8w
         fmiA==
X-Forwarded-Encrypted: i=1; AJvYcCVUrm1eEfszWe+bBd9zCQ1hL8FcW8oEBULCh/OYMRHreXJGEyhtex9WQthuh42B4ME1jFXxC4b2jpDCN3I3mYceyWp6xf9nIFnE2dp/yqp3veqiKv/qUxFyl8yXSnVQ4R2nSj0sKUMtd/ctQgUWmdBN6wrgAw50ILAAnIErH27sJA==
X-Gm-Message-State: AOJu0YxRlP6udYfeTTATMVgCNiHQdqZkl4vU9I1JCbCw7LXOXUaajJDe
	oXIuI7IJwt3Ega+m9h6xdu3GqAMwECqVdZCqVktemLRLEeNTzJhT
X-Google-Smtp-Source: AGHT+IFsboUZaUUm1Sx2dLOzWRa2oRGzXKVAUyM9tAAdJxylh0l8912MH2Vx7s9hghDKmieybyAvvw==
X-Received: by 2002:a17:907:7f8a:b0:a80:f747:30c4 with SMTP id a640c23a62f3a-a80f7473748mr189898266b.1.1723559300406;
        Tue, 13 Aug 2024 07:28:20 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa7c27sm74345166b.66.2024.08.13.07.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:28:20 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David S Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next v6 1/6] dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
Date: Tue, 13 Aug 2024 16:27:35 +0200
Message-ID: <20240813142750.772781-2-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813142750.772781-1-vtpieter@gmail.com>
References: <20240813142750.772781-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Add microchip,pme-active-high property to set the PME (Power
Management Event) pin polarity for Wake on Lan interrupts.

Note that the polarity is active-low by default.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 52acc15ebcbf..c589ebc2c7be 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -51,6 +51,11 @@ properties:
       Set if the output SYNCLKO clock should be disabled. Do not mix with
       microchip,synclko-125.
 
+  microchip,pme-active-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates if the PME pin polarity is active-high.
+
   microchip,io-drive-strength-microamp:
     description:
       IO Pad Drive Strength
-- 
2.43.0


