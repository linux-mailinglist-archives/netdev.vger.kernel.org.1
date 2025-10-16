Return-Path: <netdev+bounces-229959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0825BE2B20
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B509C4E33CB
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F57232BF48;
	Thu, 16 Oct 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oSGfSCm7"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8531E107;
	Thu, 16 Oct 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609342; cv=none; b=bgUinYR0TuPZb2/qZcw/Qp9CKeED+cKvn6IqujdIY+nr7nY7k9thB/Kj5MzrdBWjIoB6guGkEzTYXGKl3Bm3zXBx6tBZmxb4tRPqcwiuVw6/Ncgd0Hbyj3GkieNPMda6YbqlGJh8yxwY1HhI/IAtlLGwMZxSgZ1/vDpM9XgTcLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609342; c=relaxed/simple;
	bh=afFY8d06YR6Xe0mRxobtGmvJrl4DTV7aEVRQ2QIq/r0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qy5GZc9guTUpe4c1Vsbv+X/dtVoKbJqjfPgn0SEZp5suOdxjVzyUd8Q1khXR1bV2DsyK9BEvEY6va8bs7STlx8l7Df6bMdjPCmwrl5Vu1MdW+yNj245r0t40qedbFUhp/f86YPzKH4RrndZ8DIYQY3Ik7kHqj/V8K3UC+8a4tlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oSGfSCm7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760609334;
	bh=afFY8d06YR6Xe0mRxobtGmvJrl4DTV7aEVRQ2QIq/r0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oSGfSCm7mQgqcQGeuEt+uG+gb/EysmochzTYczJ3QIPFUONJmMI5FOikniJx6xgzw
	 STcVwsER77GIwib1IMca9+yNoWn56micy/WqUP/4kTfpz9R7JRGOvi0SOeIphvJvdO
	 TKkvODvOKj4wpDqJD0pTiK1fRD7pOjVe8MJZ6kwN8+3nZy9HlYALXefetLijoKsbqd
	 hf4Auh4Eh8GrYKRF7fClm1FIlqIoCVSObAnVNM9JBuxJCfKjGw4q/aT/HRQNhf0p4P
	 p+w89q4zVfW+sk/a4yri5BwR4aZUzs651OLvdTAM/4Kxk2//0UTxZi2TQzKjU7vYkc
	 G2enIYaziYT7w==
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CC97117E1412;
	Thu, 16 Oct 2025 12:08:54 +0200 (CEST)
Received: by beast.luon.net (Postfix, from userid 1000)
	id BEC0B10C9C796; Thu, 16 Oct 2025 12:08:53 +0200 (CEST)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Thu, 16 Oct 2025 12:08:47 +0200
Subject: [PATCH 11/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 SPI NOR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-openwrt-one-network-v1-11-de259719b6f2@collabora.com>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
In-Reply-To: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>, 
 Sjoerd Simons <sjoerd@collabora.com>
X-Mailer: b4 0.14.3

The openwrt one has a SPI NOR flash which from factory is used for:
* Recovery system
* WiFi eeprom data
* ethernet Mac addresses

Describe this following the same partitions as the openwrt configuration
uses.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index b6ca628ee72fd..9878009385cc6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
@@ -3,6 +3,7 @@
 /dts-v1/;
 
 #include "mt7981b.dtsi"
+#include "dt-bindings/pinctrl/mt65xx.h"
 
 / {
 	compatible = "openwrt,one", "mediatek,mt7981b";
@@ -54,6 +55,25 @@ mux {
 		};
 	};
 
+	spi2_flash_pins: spi2-pins {
+		mux {
+			function = "spi";
+			groups = "spi2";
+		};
+
+		conf-pu {
+			bias-pull-up = <MTK_PUPD_SET_R1R0_11>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			pins = "SPI2_CS", "SPI2_WP";
+		};
+
+		conf-pd {
+			bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			pins = "SPI2_CLK", "SPI2_MOSI", "SPI2_MISO";
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		mux {
 			function = "uart";
@@ -62,6 +82,69 @@ mux {
 	};
 };
 
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_flash_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				reg = <0x00000 0x40000>;
+				label = "bl2-nor";
+			};
+
+			partition@40000 {
+				reg = <0x40000 0xc0000>;
+				label = "factory";
+				read-only;
+
+				nvmem-layout {
+					compatible = "fixed-layout";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					eeprom_factory_0: eeprom@0 {
+						reg = <0x0 0x1000>;
+					};
+
+					macaddr_factory_4: macaddr@4 {
+						reg = <0x4 0x6>;
+						compatible = "mac-base";
+						#nvmem-cell-cells = <1>;
+					};
+
+					macaddr_factory_24: macaddr@24 {
+						reg = <0x24 0x6>;
+						compatible = "mac-base";
+						#nvmem-cell-cells = <1>;
+					};
+				};
+			};
+
+			partition@100000 {
+				reg = <0x100000 0x80000>;
+				label = "fip-nor";
+			};
+
+			partition@180000 {
+				reg = <0x180000 0xc80000>;
+				label = "recovery";
+			};
+		};
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins>;

-- 
2.51.0


