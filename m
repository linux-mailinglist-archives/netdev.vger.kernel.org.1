Return-Path: <netdev+bounces-240467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF52C75537
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D99022BC24
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3610365A14;
	Thu, 20 Nov 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atzGGabg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349773644B2
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655784; cv=none; b=N4VTv3DyQc8XS4tM+0vNxWkTrgi2O3FJ6ir568/H0l3tiNw1dj3qB0Btp4enrhdy4cUCkYKD/m4MKrxT6/bkJWcegYKn8cEIEOtOAlak/Mw9AoJ43igl4ijywOIkbun026OCtkVcBY3fY1fr69K5mUtu3CEEKYV4if88eTBIgs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655784; c=relaxed/simple;
	bh=I5DRp9GCbJVM21gv/C/FhaowG/g9St4qT1k2xEXxtJ8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rSWQNdgGTiaVq05x2zjq9FzFxqrT16XcEQ/1MvM6fidABR6wbfEuNZwXd9VOReHGRfqz4t8508r+LJtf357kd0RoSJCdjlgUFhPfh68QiTSrWmzS3Js1T8d2/pHZxvzoyx2ieise5XaZvQWB1PC3wKyGxUcN2fsyIB1XSi4IAtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atzGGabg; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c765f41346so430648a34.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 08:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763655781; x=1764260581; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0tdadcaOllwZN0zF3sys/aIhLtv2I4tkzaAzDlX5eE=;
        b=atzGGabgzDRk1WA/kZtzqm9PLTxrhZBDiaZJwZnJys0b4baSMkdMaUFj251rbM2BGx
         pbW3YYBtbD0BvogIxUsA0cPMAWqj5+mJFvrlEPMcjLAFpHTqHRsmQpZxP7i8OcFMSD76
         iiFRDxWERkKSbBatpx/JCKYY9jLsNaf6xjF3XUAjMWDKxT1mkBngHmR4gcTdn9FNdfEB
         aaDIRe3CTcjOZueIoW0LJs1LN9zSuzFfEYQ+OqNM52pkT1Wy5D11ZXOmYrhOylWQf5EO
         J//U9rRFrG4rNtPjxYFLjxuCw92mEW3YionC3q65QyVZiyJuRJBIX1/r7k5yG++yM6CR
         OHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763655781; x=1764260581;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d0tdadcaOllwZN0zF3sys/aIhLtv2I4tkzaAzDlX5eE=;
        b=XHXgBkDP0IdWWzdl7UF4OEsCPxr/RYbBhbT/QarX4+2CzgLwGzlZ2uwoiiJzx9QMAC
         AZ9ldFV7jOPomx5nF0he3DddWaUrdkOr1pICRRKs4H6e/Uc20gZEsh50+jcOw41UUokS
         9EcZeU2jvuVe/QpyTSe5wZgG9N6wv4ouNMcp8N8aqqpBA2jIGFgRzcKEhzv09mbRvmH1
         wkq89yYfn9BEilJHssQKR2SrqNcjigaeCNLuck+KNd1FxVtMwOFLkJG4IxaAlTzradw/
         dh+rseYFO+QnTu7ZyTG8iJtHU7H1/7RLoSSH3TNLfWJ0tfK6cHsY+Rvk5f52ZXdOtOZT
         GcvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOcp85DeeTyNIUSjgx8IVvV+9x9kkQBMKTkuEK4WxMsqRyEQaLEwfukYQNH4Yb7i/TH7HyVBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCp5b07/HPkvwWg24VGcTPM5W/zFLL0CYh9p6nxLLkSxumdCZN
	8DEqR5/T+zZX4b/U8m6YECP4j70AhHiEX9uGPBiogf7Fv8BCKU1fnUJd
X-Gm-Gg: ASbGncty2NFGW/M0yPlMFqPxLzLGcHf9sIv/El+qdkyIzTeZIpEOPLyX+RDXLLx+AmW
	B39i7xf2XhtzExO24q1XP3bZMCsbtkAo6I5DwTVOUzSCTa2jtHM93HTuGTIACGo2TVelHI+BFxk
	0TwACIeui6ORX6lDGWetF/vLj/E1MI5QtRVcI6VZYrfwBNAQaWgzo0XUZvhTTDv7xcnFMusMv9a
	ssAq4c1t5zeEOaeu6ajNW1mzCHmH/Yf5SE6vZYuqYZEfkBtsijT6wsjL17hJlJyIiuQJMl8EfQW
	kZQjJGLkylrE9qabccT1BMiSBOsrUJ7f+MkLb53adsdAeawD/i+FtzN7CE5dTl/7XTeZHRlbBiS
	mcUpz7UnjV5bVQe67PyxsY22WYlhjKyEUPzYYv1Ii8VxfQCn7I/1WJP73qMmIUCXFVwzA7bYLlj
	DkhDQ6BYWffzzYyvU=
X-Google-Smtp-Source: AGHT+IF7ftfalNRw8ZNUBYR+5ucJXrX7efoW1K3ADp3krYp2GnXALht8+9gG/fjl1hp4DrgVDHKMJg==
X-Received: by 2002:a05:6808:1b26:b0:44d:a0ec:712f with SMTP id 5614622812f47-4510ee8ea7fmr71818b6e.17.1763655781076;
        Thu, 20 Nov 2025 08:23:01 -0800 (PST)
Received: from SC-GAME.lan ([172.245.56.104])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450fffbf1fbsm766947b6e.19.2025.11.20.08.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 08:23:00 -0800 (PST)
From: Chen Minqiang <ptpt52@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	Chen Minqiang <ptpt52@gmail.com>
Subject: [PATCH] ARM64: dts: mediatek: fix MT7531 reset polarity and reset sequence
Date: Fri, 21 Nov 2025 00:22:24 +0800
Message-Id: <20251120162225.13993-1-ptpt52@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The MT7531 reset pin is active-low, but multiple MediaTek boards describe
the reset-gpios property without GPIO_ACTIVE_LOW or incorrectly mark it
as active-high. With an active-low GPIO, gpiod_set_value(1) drives the
line low (assert reset) and gpiod_set_value(0) drives it high (deassert).

Update all affected DTS files to explicitly use GPIO_ACTIVE_LOW so that
the reset polarity matches the hardware design.

Additionally, adjust the mt7530 driver reset sequence to correctly assert
reset by driving the GPIO low first, wait for the reset interval, and
then deassert reset by driving the GPIO high.

Boards fixed:
 - mt7622-bananapi-bpi-r64
 - mt7622-rfb1
 - mt7986a-bananapi-bpi-r3
 - mt7986a-rfb
 - mt7986b-rfb

This ensures the MT7531 receives a proper low-to-high active-low reset
pulse and initializes reliably.

Signed-off-by: Chen Minqiang <ptpt52@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 2 +-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 2 +-
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 2 +-
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts             | 2 +-
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts             | 2 +-
 drivers/net/dsa/mt7530.c                                 | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 9f100b18a676..6f29ce828fdb 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -155,7 +155,7 @@
 			interrupt-controller;
 			#interrupt-cells = <1>;
 			interrupts-extended = <&pio 53 IRQ_TYPE_LEVEL_HIGH>;
-			reset-gpios = <&pio 54 0>;
+			reset-gpios = <&pio 54 GPIO_ACTIVE_LOW>;
 
 			ports {
 				#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 8c3e2e2578bc..6600f06ccebf 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -137,7 +137,7 @@
 		switch@0 {
 			compatible = "mediatek,mt7531";
 			reg = <0>;
-			reset-gpios = <&pio 54 0>;
+			reset-gpios = <&pio 54 GPIO_ACTIVE_LOW>;
 
 			ports {
 				#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index e7654dc9a1c9..8ec2ec78ee46 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -203,7 +203,7 @@
 		interrupt-parent = <&pio>;
 		interrupts = <66 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <1>;
-		reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 5 GPIO_ACTIVE_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index 5d8e3d3f6c20..732dc4f5244f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -87,7 +87,7 @@
 	switch: switch@0 {
 		compatible = "mediatek,mt7531";
 		reg = <31>;
-		reset-gpios = <&pio 5 0>;
+		reset-gpios = <&pio 5 GPIO_ACTIVE_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
index 58f77d932429..91809cdb4499 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
@@ -64,7 +64,7 @@
 		switch@0 {
 			compatible = "mediatek,mt7531";
 			reg = <31>;
-			reset-gpios = <&pio 5 0>;
+			reset-gpios = <&pio 5 GPIO_ACTIVE_LOW>;
 
 			ports {
 				#address-cells = <1>;
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 548b85befbf4..e4caedc3eee5 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2405,9 +2405,9 @@ mt7530_setup(struct dsa_switch *ds)
 		usleep_range(5000, 5100);
 		reset_control_deassert(priv->rstc);
 	} else {
-		gpiod_set_value_cansleep(priv->reset, 0);
-		usleep_range(5000, 5100);
 		gpiod_set_value_cansleep(priv->reset, 1);
+		usleep_range(5000, 5100);
+		gpiod_set_value_cansleep(priv->reset, 0);
 	}
 
 	/* Waiting for MT7530 got to stable */
-- 
2.17.1


