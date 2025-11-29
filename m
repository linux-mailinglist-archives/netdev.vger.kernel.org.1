Return-Path: <netdev+bounces-242753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF04C94928
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 00:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B74E23470D9
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 23:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A06258CDF;
	Sat, 29 Nov 2025 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuFCVSg8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4C7FBA2
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764459985; cv=none; b=mHu+isDRSlfF3SnTJhLwRw+lSmKmNeK9o3P1czSrP+IdCYZ0x9wE4uXXIv73UsP+4ZEDjaDwZuDJ1pi9ibKZ4wPYHxFdkoYPyQyg2T4NyIxYUcfpNtStsLZeg6cyqe0OhetdzYd+sTqd+n6AIZItLuc6NdH0csvZilkz9N6fIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764459985; c=relaxed/simple;
	bh=Y0efvnYW+eSM394k4UkkYLAlJJqaQa7sEuGtHbXQwzk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=i1RRN11oG4tvQmSk1pUpi33d+tQNLflyzr7OG1QI4E1x9UUE4xbme4gWCSSz0Tg/kcjjca0olpAb1WZ20l+4JaR12Bo22KChgyZo5FWIg8crXW7X3bLOmRqx5TXtzByKcDwqx6CVA1i7Z2jzJEoa64Deq23b+f8mYF2XIUuQY8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuFCVSg8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so2613434b3a.3
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 15:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764459983; x=1765064783; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oic4BVwh+qFMk9xigP8owFPlA2EeqW1hA7c8LL97tvU=;
        b=RuFCVSg8pa/vf8zXBiblhxq+0/OTwVvXT89iMIYNnfW7Dlx5xtbBTeD8P+GrNm5qKN
         985FB9D0yUcyxrhYqSmHd04Q3XlFjh6EaYvOkiD1SQiRPI4Y5NDz2skf7yITkscQmyc6
         CmS/SB3ehlCgqU1OaIdC0mLlwHXrr4h04iLVkb6pCksKbpy/Nj8MMpOiSi3Dyj+tvmAJ
         Dc7ImHG027EZelt+ZdYrjqJHGnAHfGPhSjmLYMjaslp3OIQGXdv/YkiCP1Gl+ajJCSoO
         QsPAlpCndo4NDYyXBO5VsN1GxcI0/n3a5QpKsNHgbyw2eO3z1/O+khSfsut0NOowxayq
         eZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764459983; x=1765064783;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oic4BVwh+qFMk9xigP8owFPlA2EeqW1hA7c8LL97tvU=;
        b=e30ksby8L5T06G3Ma+SaIkLr4V6Xn8orXPa//voUNyWnX7S3jKJFw34e3jDxhOuF/e
         JaKuO1bZKdps2PZqiO6GEyzdhfMLuuILUCMDpEyZ4iLxfLHp65CVRF7fJabFw1+A4mNy
         Nmjf9PBoJH8XguCJEn6t5gZtyu7pMzm8X35GBCRYr8+88T5yeDMcloPxPXfy2KfsHZuv
         8MBFJN7ycmxqQ+Uybkvl5VzCO4Mf1YwD3shU1i/DSZS4roU3BZWsDJiVv3cHJEGAD94w
         NzDwkxN6SFLt5x44xcsnBVYj8yYJjKLwN7QtBS4NbyGFnUpVl89Hrg0xgVIYfVMYwe6J
         OfGg==
X-Forwarded-Encrypted: i=1; AJvYcCWR6FRR2Y1YCh7d3RsjWegjGyrHhHTYA+VYKoKu75tuMQc2jRVYV8Gwm1nJicjjMpRwvM3bBXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlwTzy5c8t2u7zs1JXz8SkQ/HOjGyf3Yt4Kv6hx4+molaMqH1b
	YdbuvpsmGykgFvOLCs9oSheA9SGPIBcfHNmMdQtMRYQzEgSxMlAV6qiC
X-Gm-Gg: ASbGncsOHsunfBe1zGwHuf+wCJYVWpPRBDwRAquKWSUAGpeQAug2G2F+UsCdWzZqw8C
	SHsWfdi90s3JskZkFNugAjjSVAhlXpRbrR+XMXxfdPc2IDW+10tykNK2NzWKGfzWY6GaxMnG9xz
	jhdKJujyKw6oQOA9HBjemPUsI+zP+HRUfhnCjiX++hiGvQ2JK6BGHL2M/arDDJF8zeTntPu+AVV
	+r7k69glQKJmG3P5HYapU8Q8mAjMqhJiOTDQwSpHhVyMV66AclObHt24zP0BLEG69FIidnFS8ZC
	F1Vm8zWooq6KXXxFm5ONNiktM+/2izphuKEhpnnX0opUGPheotMILIXELYuj61jlW5E9nfkT5C7
	mRZRJZTNE76BSY/A8ahJrzHdylHEz3Skef9SAECBT4vnlMFcf+sP5MdiRPo0GP4gZ+yiIrZGf0q
	Sl/gTtGvgeRwq5W7m8FtmYysl4/Q==
X-Google-Smtp-Source: AGHT+IG1ssiyNwGsFp5F+wk0jylpdPRdZeUSnJ9+OhyOhmGPlt2Dzx5MOnNqeZxTuc6PCZk9MVCk1w==
X-Received: by 2002:a05:6a00:2389:b0:7aa:bd80:f4db with SMTP id d2e1a72fcca58-7ca8740ec4cmr18933879b3a.5.1764459982924;
        Sat, 29 Nov 2025 15:46:22 -0800 (PST)
Received: from SC-GAME.lan ([104.28.201.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fc08bd1sm8921049b3a.63.2025.11.29.15.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 15:46:22 -0800 (PST)
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
Subject: [PATCH v3 1/2] ARM64: dts: mediatek: fix MT7531 reset GPIO polarity on multiple boards
Date: Sun, 30 Nov 2025 07:46:02 +0800
Message-Id: <20251129234603.2544-1-ptpt52@gmail.com>
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


