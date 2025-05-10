Return-Path: <netdev+bounces-189459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F513AB2367
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 12:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101153A7E9E
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D59023507F;
	Sat, 10 May 2025 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvPB1fTC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A10A24291A;
	Sat, 10 May 2025 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746872678; cv=none; b=mCIx6BH8+1y5vfGRHGrl+ZdGvXjYQlTz5rot4Q2iSxlexizbmXJcFrAqRiwkLmM3opimTGyksupMSMAMTDdsM0AU94fOMsXLcBklqCL9w6DcEstAUsT2Nb6JxcWeKtlxOha73wZZq0sdOq+VWEmU7k6g0pXCmO1QBkGXcXKOK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746872678; c=relaxed/simple;
	bh=CQQRGPRya/T/RQmdK5luqPwFwvLJepnnIgqfBudN7ww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfIIc1QCa09N4zaVBCFc8WwkEw4q2kJ36vovBbgNZ5VNGeUZDFXh2QjqzBrsWVtowX+Wv673VMjhZgaMQOy2ZKW2oA3p9nT0iPBCDlqptAKDIHN0JNhedKNIZgurPsu8lPPFGVXq2RudgNOMhBrfxt0CikS1UM51IADVa8wT8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvPB1fTC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso13731995e9.0;
        Sat, 10 May 2025 03:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746872675; x=1747477475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkLGswoAoqo/118QvnKQBtIy92ngW50tFunPEBOrZ/k=;
        b=EvPB1fTCKZdZBh0zV/k4Q3QN96NHuY9xmAXQr+D7XX/t1FxjgFfcnTRYnUsofduhrT
         KsyIAir6v1RCgjH5ipbUVM0j44vhsb7zsJo2vBt/gQ54AXJxVKfXlz2I2VKlNZQTs1e8
         ge50e+IaXAUfV/e2/v0R15qnd3YtIwQ5g3tsK5SUgGJadd0gcLMzGxjWQ+WO2MNxg9Ay
         UiOdju06gXZWvMNvTdKZLH1C1EcfgfqS6KsDYqdLSavjT+8aMHyXi1RkIumwyrYRMTKR
         8SNLiFp0vuoqME+AnJZnDzEHllxec0d6oW0FDdCjbfe1sQfanrqaHWK7CZd97IPnbQiN
         e7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746872675; x=1747477475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkLGswoAoqo/118QvnKQBtIy92ngW50tFunPEBOrZ/k=;
        b=G0KsZfQLazRjNbyqGAwyeSXntn8Jwri3c8hbAEhlo/9mzLoeoRRU8YBPRKxiJdDifq
         kqHu1KgmaW8HjI2q/UU9PAVW18B5jv0yLonQL9HieC+6Spb7BSYXYe6YczS5HHyYknqw
         dp+2IDOAciayLN8gwSyv6YluSkgHaKZRJYh3RoTSyU8RNrPFgRQKr3g/jpWNN5V2rsNP
         c8L3xRfAk4w88e+exHmdn1VtEotS5GL2XYqClx5Iz2ZxshMtUJgkF0y8mnpUb3KdGcVf
         j4dlwh7QW3wVvTAO08G1TLPj1h8fQknjMBIg0wug+ZUaqFhQnvMipaOkP41vkokMHfY4
         V1HQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2amGSHiBxeLX3xLVqa06FQpNhgbpfOtYiitgICEK2PnuMugXRQ8izbk+BpO8B8dBsv+zXmEwE@vger.kernel.org, AJvYcCXWFYHwlmFKiTq94G1NnWJ4KTliq4k8zxMxMuy8glSjhdlGZk3obPLCdEdftHol9r+8UJN0tuW6/TBl@vger.kernel.org, AJvYcCXuv9wC7P9lf8mqg9CSMOlOEDbaqKuZ+xGWhOLPci6AK4zhMLpmj/jiIgaG7dmCFvcKFkIQaNrsdHH1QjxU@vger.kernel.org
X-Gm-Message-State: AOJu0YxlEOOE1NJFKeMFUMvL7nn98YF2XNXmPAg6OKkx+xVBkY0acDm+
	OA69i2yrqcNpTQBL+eu6QqQrbnR3fAvTKWh1YIkTVZCacvPlf41z
X-Gm-Gg: ASbGnctbjIfcJ6zShQQ3tVf1p6nLDfbWROSfSratQQReaiEZnUug1VV9ojubB2ZvlI3
	d+5u5JEY4VIGCDxyzYtulIRuFq3cYlhCQ/OQlW1gtoGGbsRzEXw+BZhERqVFIExn0tFJqOfPVLk
	IYdWJh/XfD37Bvnqlo+VeL4kNTRLdv3aVICMpzF0K8fJK559Y+CWbY1Bojr9mVUm+ZFtuuz0G6D
	dEU7TpDt9GoCYrfXJFN9qMfHCqKWCMA5niY/2lTEi5/Rr6grZHSpDjgM6+RlYB0P13bJG+omRmF
	e5vUsJRjSTLusVjQD4EfRza8cRDvaIDt70FI7Uvp6segS4UIqygiYwZ4S/rzVJXSmhmksNL09OB
	C4IJkm9at5o9QB8Z1KS12kWlv1LR2qZo=
X-Google-Smtp-Source: AGHT+IF+JafMQQHPYahURsqe3MBC8A7z4wtt0SPihBLmK4C7mZNRKXhccsPRtICBBzpKTSQeCySnfg==
X-Received: by 2002:a05:600c:450a:b0:441:d437:ed19 with SMTP id 5b1f17b1804b1-442d6d448afmr45525425e9.11.1746872674462;
        Sat, 10 May 2025 03:24:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67df639sm57981265e9.13.2025.05.10.03.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 03:24:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [net-next PATCH v3 07/11] dt-bindings: net: ethernet-controller: permit to define multiple PCS
Date: Sat, 10 May 2025 12:23:27 +0200
Message-ID: <20250510102348.14134-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510102348.14134-1-ansuelsmth@gmail.com>
References: <20250510102348.14134-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the limitation of a single PCS in pcs-handle property. Multiple PCS
can be defined for an ethrnet-controller node to support various PHY
interface mode type.

It's very common for SoCs to have a 2 or more dedicated PCS for Base-X
(for example SGMII, 1000base-x, 2500base-x, ...) and Base-R (for example
USXGMII,10base-r, ...) with the MAC selecting one of the other based on
the attached PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 7cbf11bbe99c..60605b34d242 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -84,8 +84,6 @@ properties:
 
   pcs-handle:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      maxItems: 1
     description:
       Specifies a reference to a node representing a PCS PHY device on a MDIO
       bus to link with an external PHY (phy-handle) if exists.
-- 
2.48.1


