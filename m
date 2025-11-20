Return-Path: <netdev+bounces-240576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CACC76654
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 22:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 953444E52B7
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2C32E9EBB;
	Thu, 20 Nov 2025 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMvgJknz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE322259F
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674719; cv=none; b=FtZEBLuZVEh4dYasIHgwSys8F5qOCwIB3dM+RfI0HLN1xSzMbiiGhjLNw82YPYXpTqUInqEIJL1uP9JzFTv2lKyHPCQno4uX+Z8M6Al8PXC7iYRYbRMcO46da8LQWFT8mgqxUdIXdGt4SPi3mcZAEe+I/UEkaD80WmXWvd3+GxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674719; c=relaxed/simple;
	bh=Y0efvnYW+eSM394k4UkkYLAlJJqaQa7sEuGtHbXQwzk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NPJL+nLryf12BZvtf9/nbAzIdQbA0oKEa0d1GfETw+/xS4c+uFd7sFzDXUb2K9MbM+wkMB8FQgAafMnAIfUyv9IAfWeRW6MXy7gvDKND/56rToQiWBOES8/rY9u0fVRfOUtzNQdH3I2SS5WiKGVjD5mKEETBQNKYqje+WuqSxQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMvgJknz; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-343ff854297so1928097a91.1
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 13:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763674718; x=1764279518; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oic4BVwh+qFMk9xigP8owFPlA2EeqW1hA7c8LL97tvU=;
        b=bMvgJknzu8D8aWaE0qTzqT3MTjW6UsM0CTUPHsrgtqbV6NF4GHqNYJkc+SATkGXqAZ
         kHoXRofolmzIMPh23823+CFfAY2gT/QbDvtLTJrM5lTLf29pIZK+E0XzLid4GtNVGp03
         OSxdFcaSrMmRNMxzRdwXK+IPtYk8E/YHH8kbndYr7+DrM4wvVHf+23Vx/bodpPQ5K0ss
         6XZxn5kZiBmkPmznl5UdncOIpJ/F3+09BVOUfylw2yHmPklqDVZF/qfOzqS2y1AORK2L
         WMOUAxZrEMWPxQczXD0qPIGOk5MC3DkNofDmJEkmMyyxXk7zhKMDL50/4l3XiXsExOH/
         LOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763674718; x=1764279518;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oic4BVwh+qFMk9xigP8owFPlA2EeqW1hA7c8LL97tvU=;
        b=Owf+3Too8DRDjwDN3gKQfCLucrIsxZRS5k75EuwcvfklRUzfRuc93mKHyJY4qNbzUl
         NEJ1aoW1mb90GG+6SZyZHeZv7oeZHWacToaEBD23zInW9QZR8R+ZVd+Qp80oCqSsVHSt
         IJnXjIciIIsyAkTtKQjMA/WEIgWMz7VRb4ydMlapSZ4AFxrGU8HPGstbzhcNksx07yo7
         pzMSwaF4vLjKQkXNrjgChG6cElNvTy9zmrwyBuCGeZyZ9tVNo+8znIUwlUSMg6uk3kG/
         9F7w7Jj6NNXqk3BTQ2tJSA+A3Q+vQC7bTUT5aylF3KD2jEZZozFkhCqR2AuSYWvh2V1x
         JFeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZUk1mQvTzHFXEOMg9Z8vwxqb838evxmXJtJqN9IEQOBmp0kW1fUYA4+B6YmWWf33SrxXHOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweUXsWsLA4gvQ5znUpywUkX7Jv+KstaI1s6faJs8Bgo5r4GIJY
	mKxwn0r/8VH0Ic6SmT+aEPSyaFdxLSTqpXd/YjtzaXwKMLqK3+vtHpm2
X-Gm-Gg: ASbGnctC4d1JgtTQd6ZwxxqHBuQtfXfBFWYfi18o1lUGHhblmUBf1erhGzjOqf+1Pvi
	Zq7TPfmxhN6GzvpcBUXpD4Ll4VfbzlaYv2bDILBoCMNRyuxyjK+Ws5/5Ar4WTQbfhGKp9qsehaG
	hHmLbxAqiHCjMyWqtG1YQ+jsEtarnBWq0Yd1h3SZj5TeS9asE+aSH9AtvitpVa70ajDX0xvPx/5
	dI8qaLtmv6dkn8ttDl5BBrOkJ64297+2ZABOQrH9GTKG/GEUx2qIodeqtvVh4MPEjyxrIwhawEn
	SlsS2LGBl6I6ui/qpO7o9ykYb8HUhIv3SbwdDUwtWFKiAvNEKBPNQKyARdcnPHq+sHlfW2OBt9v
	3tKGXrio66eO1ArweQb/YCq8UMZqDMopUYA7zsmkkERvmvGXSkfsN51+aFla8g31DlxHi0ytYmG
	ezkAE0uNCi9DdSsNda
X-Google-Smtp-Source: AGHT+IGMJrKF9L1itrJx5jS2bFV3lpyInnC8nIidIwze7pM5BA5o2s2GqhwLJOqjTqB9hc+kWslwdw==
X-Received: by 2002:a17:90b:5251:b0:340:bc90:d9ad with SMTP id 98e67ed59e1d1-34727be88f5mr4852259a91.10.1763674717587;
        Thu, 20 Nov 2025 13:38:37 -0800 (PST)
Received: from SC-GAME.lan ([104.28.206.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727d6f48bsm3325479a91.17.2025.11.20.13.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:38:36 -0800 (PST)
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
Subject: [PATCH v2 1/2] ARM64: dts: mediatek: fix MT7531 reset GPIO polarity on multiple boards
Date: Fri, 21 Nov 2025 05:38:04 +0800
Message-Id: <20251120213805.4135-1-ptpt52@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The MT7531 reset pin is active-low, but several DTS files configured the
reset-gpios property without GPIO_ACTIVE_LOW. This causes the reset GPIO
to behave as active-high and prevents the switch from being properly reset.

Update all affected DTS files to correctly use GPIO_ACTIVE_LOW so that
the reset polarity matches the hardware design.

Boards fixed:
 - mt7622-bananapi-bpi-r64
 - mt7622-rfb1
 - mt7986a-bananapi-bpi-r3
 - mt7986a-rfb
 - mt7986b-rfb

Note: the previous DTS description used the wrong polarity but the
driver also assumed the opposite polarity, resulting in a matched pair
of bugs that worked together. Updating the DTS requires updating the
driver at the same time; old kernels will not reset the switch correctly
when used with this DTS.

Compatibility
-------------

Correcting the polarity creates intentional incompatibility:

 * New kernel + old DTS:
   The driver now expects active-low, but out-of-tree DTS still marks
   active-high, causing the reset sequence to invert.

 * Old kernel + new DTS:
   The old driver toggles reset assuming active-high, which now
   conflicts with the corrected active-low DTS.

This was unavoidable because the original DTS was factually wrong.
Out-of-tree DTS users must update their DTS together with the kernel.

Signed-off-by: Chen Minqiang <ptpt52@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 2 +-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 2 +-
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 2 +-
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts             | 2 +-
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts             | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

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
index 5d8e3d3f6c20..958ce291336b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -87,7 +87,7 @@
 	switch: switch@0 {
 		compatible = "mediatek,mt7531";
 		reg = <31>;
-		reset-gpios = <&pio 5 0>;
+		reset-gpios = <&pio 5 1>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
index 58f77d932429..0780b5a36259 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
@@ -64,7 +64,7 @@
 		switch@0 {
 			compatible = "mediatek,mt7531";
 			reg = <31>;
-			reset-gpios = <&pio 5 0>;
+			reset-gpios = <&pio 5 1>;
 
 			ports {
 				#address-cells = <1>;
-- 
2.17.1


