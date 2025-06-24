Return-Path: <netdev+bounces-200529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6BAAE5E3A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923321637E5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F0256C6A;
	Tue, 24 Jun 2025 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhyPU5DY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE1D252906
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750889; cv=none; b=twTjZsw/acQE5lk55LV+qpxocnfmYsrHo0q5yldMhxEspVAw7VdhqiWa/0l3qlj9Xdt5A1mIIP+4w4S0WIRXkvZukuK6C/LOTpdCMZTPBeDSVhktukg695rgc2l55UJYuQnZrM1+pEG9wPnRJefBDJ37A03dZ5tyqPifZx69Xwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750889; c=relaxed/simple;
	bh=8KaQ27YfEuzAxCT7uSkSgFEl9GkEuMH1t/mIAC24JoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dNouk9mdOZY0/jnmcnP9+EdMQ1a6zAOT71OjsLOCfvy3obBZXrC+Yx0ogQmxhN96D6guYFLAaSovR5lc888lvtSGaIhmPyQ8ipYyGMl7nCWdpBxBE7+28nnY7RIKdhZATJ9oPktndLbOPZtbjN/rXs5T7iiwlonvu0pwCfnXJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rhyPU5DY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553e5df44f8so3556632e87.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750750886; x=1751355686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeyHV1RvuQ5k3vKKTfzoakN+4H2W0EzitrNAtVqTxwE=;
        b=rhyPU5DYyjw8d9WVYLumA8yMpvaJ+WrSHhuDSVTNM+fRlNJr5Gl2AYAPOTG7vxmXEB
         xim3FHvS2KFRP5+/9L6WuYi9XAcgQZQkooeVrrxeLTb/JXU14rHGGDR15j7+fVUYB2KD
         lovzh53RxCCdQT3jUFNVApYgXuGJf+lWVjU4ktKoQ3nJm2OQbIOx0jLVWPIYFFgFLMMB
         TgO4jI8tF59bH2pqCTuCBEGuafHeHTG/xlC61LUL06OOZxjX0Fp+Mzq6NHGyWEJUNRjV
         sedgyBM1/YK19RXJJkMPMK77vdx9xfvjPSABbVO9Cw6hqbwmlUoz5bZTU9Mc9eF4G6eK
         vmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750750886; x=1751355686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeyHV1RvuQ5k3vKKTfzoakN+4H2W0EzitrNAtVqTxwE=;
        b=gz2vMZEfjC5mfnNk2R4ZBeHkB+cpZowAUk34JUgcGUhjVzloBFIF1U3owA80KuaTWO
         C07nLNO4buOKIITFBfqfY3zwzGeh+y6nT/CSBG8qDP6Zo4EM2rolOrmTTq607b/LKYVy
         xcxU4LNjxv+9IjXQC2zACwhFmxXlrlWwhdUoT2VKhMwxnRN+ll0794YDiKNivOXxOlSR
         FAbs0V5AIS/67bUlpefT6FTP1HPOVDxcmJyZJn/qsIVFjuRnYOSQoUaCJ4eJ/E9ZKtD7
         +2Lnqno7ifdxTRkOc5l2iquuhw/k59fAiKj5IyDJi8Ypofk/CbMDpDZXRqRg02DmOacs
         FSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWytYYI+8Na/H4jqRpeARelp7wRVJjFLvO+f97u83fzkLGw4HB43V1dr5uaCOAnB9XLIR66+Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUyLFj6RTWYI0zVfGE7tnuevpuCvNlyEs7R4bnj/EBW1CKi1Aw
	sKN3H5ecaoSzUV8G4AOVrJ8nr7grzUdsHIzX2b5fFRZU+9LO7ZiIJaxAh/vkxGZvdZs=
X-Gm-Gg: ASbGncs6dWPx8MP9KnYQiLFxvxcwmLPQBjOy13Mkbd0R2JLvih8Z+yFYzRNa/59vbAK
	KorKykb59qVLl+eYgXdMWJbOIvG3Bg5I0hAkB6ojtPNgww9sfEQh7aBAfbKCuxbYYx2DkqF42bY
	FTOQuqqVTYNEVCvklsQ/kGcFFgq4h8Y7E8d4UPvWxAXbgwcCPu2J0DE0AA4YVSR4GOipcY070vk
	OwYvemol6d/+jt930RZ/cp5F/fi+Tr2bUSyrv9quuKp3bixT7PxPkK+khIMuWN6w4EfZ0/lc9uT
	Fd72sqcMa+OdSV45OFF64RmGCojo+nvUusfZ+JiZh5Eo2xbhbLKTrINb8ExnbpB4dtEOtU2PWco
	W3cz5LsI=
X-Google-Smtp-Source: AGHT+IFwpP8Cp8fnaHniAJXxGZifqgjwzLJkRX96CrK7PEM9CdUtrVoJI4K0iImqg8PzVL9zpEi2mw==
X-Received: by 2002:a05:6512:a8c:b0:553:2dce:3aab with SMTP id 2adb3069b0e04-553e3bf8c8bmr3901782e87.40.1750750885531;
        Tue, 24 Jun 2025 00:41:25 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41cc0d4sm1702545e87.197.2025.06.24.00.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 00:41:24 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 24 Jun 2025 09:41:12 +0200
Subject: [PATCH net-next 2/2] ARM: dts: Fix up wrv54g device tree
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-ks8995-dsa-bindings-v1-2-71a8b4f63315@linaro.org>
References: <20250624-ks8995-dsa-bindings-v1-0-71a8b4f63315@linaro.org>
In-Reply-To: <20250624-ks8995-dsa-bindings-v1-0-71a8b4f63315@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Imre Kaloz <kaloz@openwrt.org>
Cc: Frederic Lambert <frdrc66@gmail.com>, Gabor Juhos <juhosg@openwrt.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

Fix up the KS8995 switch and PHYs the way that is most likely:

- Phy 1-4 is certainly the PHYs of the KS8995 (mask 0x1e in
  the outoftree code masks PHYs 1,2,3,4).
- Phy 5 is likely the separate WAN phy directly connected
  to ethc.
- The ethb is probably connected as CPU interface to
  the KS8995.

There are some confused comments in the old board file
replicated into the device tree like ethc being "connected
to port 5 of the ks8995" but this makes no sense as it
is certainly connected to a phy.

Properly integrate the KS8995 switch using the new bindings.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts  | 75 +++++++++++++++++-----
 1 file changed, 59 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts
index 98275a363c57cde22ef57c3885bc4469677ef790..14b766083e3a870a1154a93be74af6e6738fe137 100644
--- a/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts
+++ b/arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts
@@ -72,10 +72,50 @@ spi {
 		cs-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
 		num-chipselects = <1>;
 
-		switch@0 {
+		ethernet-switch@0 {
 			compatible = "micrel,ks8995";
 			reg = <0>;
 			spi-max-frequency = <50000000>;
+
+			ethernet-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ethernet-port@0 {
+					reg = <0>;
+					label = "1";
+					phy-mode = "rgmii";
+					phy-handle = <&phy1>;
+				};
+				ethernet-port@1 {
+					reg = <1>;
+					label = "2";
+					phy-mode = "rgmii";
+					phy-handle = <&phy2>;
+				};
+				ethernet-port@2 {
+					reg = <2>;
+					label = "3";
+					phy-mode = "rgmii";
+					phy-handle = <&phy3>;
+				};
+				ethernet-port@3 {
+					reg = <3>;
+					label = "4";
+					phy-mode = "rgmii";
+					phy-handle = <&phy4>;
+				};
+				ethernet-port@4 {
+					reg = <4>;
+					ethernet = <&ethb>;
+					phy-mode = "rgmii-id";
+					fixed-link {
+						speed = <100>;
+						full-duplex;
+					};
+				};
+
+			};
 		};
 	};
 
@@ -134,41 +174,44 @@ pci@c0000000 {
 			<0x0800 0 0 2 &gpio0 10 IRQ_TYPE_LEVEL_LOW>; /* INT B on slot 1 is irq 10 */
 		};
 
-		/*
-		 * EthB - connected to the KS8995 switch ports 1-4
-		 * FIXME: the boardfile defines .phy_mask = 0x1e for this port to enable output to
-		 * all four switch ports, also using an out of tree multiphy patch.
-		 * Do we need a new binding and property for this?
-		 */
-		ethernet@c8009000 {
+		ethb: ethernet@c8009000 {
 			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 20>;
-			phy-mode = "rgmii";
-			phy-handle = <&phy4>;
+			phy-mode = "rgmii-id";
+			fixed-link {
+				speed = <100>;
+				full-duplex;
+			};
 
 			mdio {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				/* Should be ports 1-4 on the KS8995 switch */
+				/* Should be LAN ports 1-4 on the KS8995 switch */
+				phy1: ethernet-phy@1 {
+					reg = <1>;
+				};
+				phy2: ethernet-phy@2 {
+					reg = <2>;
+				};
+				phy3: ethernet-phy@3 {
+					reg = <3>;
+				};
 				phy4: ethernet-phy@4 {
 					reg = <4>;
 				};
-
-				/* Should be port 5 on the KS8995 switch */
 				phy5: ethernet-phy@5 {
 					reg = <5>;
 				};
 			};
 		};
 
-		/* EthC - connected to KS8995 switch port 5 */
-		ethernet@c800a000 {
+		ethc: ethernet@c800a000 {
 			status = "okay";
 			queue-rx = <&qmgr 4>;
 			queue-txready = <&qmgr 21>;
-			phy-mode = "rgmii";
+			phy-mode = "rgmii-id";
 			phy-handle = <&phy5>;
 		};
 	};

-- 
2.49.0


