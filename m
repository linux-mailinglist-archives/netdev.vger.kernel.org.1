Return-Path: <netdev+bounces-189533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F445AB28FF
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AA917623E
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5A3259CBB;
	Sun, 11 May 2025 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="dRkp7uOc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7F25A2AB;
	Sun, 11 May 2025 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746973568; cv=none; b=hRsr5kWuXNZ+261UJOkwTUommPKVL/Aikpix4Q/igt/y85+IxI3I2PD7UQI5hbh8uyPgsiWln+2ed09RcVA5CTbN2DoasgMkVNyoGfGE7ZCBwP+HmZqWAdJ9GU8spx41Z66bLA5GSqzUA5mK7N3b6jpMrAWaQsLK53RYmdBdzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746973568; c=relaxed/simple;
	bh=xr7hw9jQbx1PHW4jSljiTzjYw+6C1d+mvfyB69VL2ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZhgQ4Wng59gEQsigeqZn1gxYA2miQAMThxzr4UxfRkUvfV+T6zAcxQ6/V6HEUQ5nPTQU/zsxzvzk2zZo7PfnXHupRMTnxoGjHJWt6v/tSiaod5B1PcIo58j6WI+EETgjiFBGrQ5ghyI4hUhx0LQ90RrsEumrkwXKhBviYHBLezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=dRkp7uOc; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1746973558; x=1747578358; i=frank-w@public-files.de;
	bh=3EHXB+FxOQEuxjJuPZ3FDlU1soKtjeNeGrzIBOUM2w0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dRkp7uOc33hpr4LZp+COdYyo1EAkfc0KFy7sGtytb9qSiOUXIwhvuHGz3W//v5CS
	 sZXWIbPf0AfER9lMbM6CO6Esc2+JXVOAWomDRSX2rCmPqEY1vtZ1vxC26cQCyDXgW
	 nwjNkY44M68NHW/wnr4SQeda1qHg+1Pi1lwlR11krWmkdT5gt2UHe/4BVigjOqfdk
	 3s/d4FygiYG6a3EkgHj+UEy2gNhhUo7RDWKpQw98tEVxMPu69Vd5kBsrWvzFMPlj6
	 8yWnuKWCzqB89P1timTHStx9C6Wm8Kw2vEju42LTGAZQoZMGQ+FraJgEroTYiyR3H
	 E05Nwz/DXKg2z4APMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-u24 ([194.15.84.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My36T-1vDMoj1kTf-00z1uw; Sun, 11
 May 2025 16:25:58 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 09/14] arm64: dts: mediatek: mt7988: add switch node
Date: Sun, 11 May 2025 16:25:48 +0200
Message-ID: <20250511142549.10881-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vKiLc5DHpHJt5lRc77jonAK1eTfjqeCfBfejoAeoivlrnei2XED
 rU19O80TViMd9aYFM5UGn2dL5Tl6TJ0Jv9KS9B52SXD9eAsXZieK3YEv/aYCKAJ3DJ6QH+y
 jde+tOdfuKmbvfsFOWyxGdWN/2sN1XFIqxWicedhJh0IA2M92NsSY/RrIVivVyuvMaywgix
 V0W3cy28Z5Q7bkjXvxSdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GsdF6h121W4=;k/a7UcqLJK2SijwMcRc3VN0bUZM
 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
 TUX6Dt5MH39V2iF9ljdAbwz1l

Add mt7988 builtin mt753x switch nodes.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 166 ++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt7988a.dtsi
index aa0947a555aa..ab7612916a13 100644
=2D-- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -5,6 +5,7 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt65xx.h>
 #include <dt-bindings/reset/mediatek,mt7988-resets.h>
+#include <dt-bindings/leds/common.h>
=20
 / {
 	compatible =3D "mediatek,mt7988a";
@@ -742,6 +743,171 @@ ethsys: clock-controller@15000000 {
 			#reset-cells =3D <1>;
 		};
=20
+		switch: switch@15020000 {
+			compatible =3D "mediatek,mt7988-switch";
+			reg =3D <0 0x15020000 0 0x8000>;
+			interrupt-controller;
+			#interrupt-cells =3D <1>;
+			interrupt-parent =3D <&gic>;
+			interrupts =3D <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+			resets =3D <&ethwarp MT7988_ETHWARP_RST_SWITCH>;
+
+			ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				gsw_port0: port@0 {
+					reg =3D <0>;
+					label =3D "wan";
+					phy-mode =3D "internal";
+					phy-handle =3D <&gsw_phy0>;
+				};
+
+				gsw_port1: port@1 {
+					reg =3D <1>;
+					label =3D "lan1";
+					phy-mode =3D "internal";
+					phy-handle =3D <&gsw_phy1>;
+				};
+
+				gsw_port2: port@2 {
+					reg =3D <2>;
+					label =3D "lan2";
+					phy-mode =3D "internal";
+					phy-handle =3D <&gsw_phy2>;
+				};
+
+				gsw_port3: port@3 {
+					reg =3D <3>;
+					label =3D "lan3";
+					phy-mode =3D "internal";
+					phy-handle =3D <&gsw_phy3>;
+				};
+
+				port@6 {
+					reg =3D <6>;
+					ethernet =3D <&gmac0>;
+					phy-mode =3D "internal";
+
+					fixed-link {
+						speed =3D <10000>;
+						full-duplex;
+						pause;
+					};
+				};
+			};
+
+			mdio {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				mediatek,pio =3D <&pio>;
+
+				gsw_phy0: ethernet-phy@0 {
+					compatible =3D "ethernet-phy-ieee802.3-c22";
+					reg =3D <0>;
+					interrupts =3D <0>;
+					phy-mode =3D "internal";
+					nvmem-cells =3D <&phy_calibration_p0>;
+					nvmem-cell-names =3D "phy-cal-data";
+
+					leds {
+						#address-cells =3D <1>;
+						#size-cells =3D <0>;
+
+						gsw_phy0_led0: led@0 {
+							reg =3D <0>;
+							function =3D LED_FUNCTION_LAN;
+							status =3D "disabled";
+						};
+
+						gsw_phy0_led1: led@1 {
+							reg =3D <1>;
+							function =3D LED_FUNCTION_LAN;
+							status =3D "disabled";
+						};
+					};
+				};
+
+				gsw_phy1: ethernet-phy@1 {
+					compatible =3D "ethernet-phy-ieee802.3-c22";
+					reg =3D <1>;
+					interrupts =3D <1>;
+					phy-mode =3D "internal";
+					nvmem-cells =3D <&phy_calibration_p1>;
+					nvmem-cell-names =3D "phy-cal-data";
+
+					leds {
+						#address-cells =3D <1>;
+						#size-cells =3D <0>;
+
+						gsw_phy1_led0: led@0 {
+							reg =3D <0>;
+							function =3D LED_FUNCTION_LAN;
+							status =3D "disabled";
+						};
+
+						gsw_phy1_led1: led@1 {
+							reg =3D <1>;
+							function =3D LED_FUNCTION_LAN;
+							status =3D "disabled";
+						};
+					};
+				};
+
+				gsw_phy2: ethernet-phy@2 {
+					compatible =3D "ethernet-phy-ieee802.3-c22";
+					reg =3D <2>;
+					interrupts =3D <2>;
+					phy-mode =3D "internal";
+					nvmem-cells =3D <&phy_calibration_p2>;
+					nvmem-cell-names =3D "phy-cal-data";
+
+					leds {
+						#address-cells =3D <1>;
+						#size-cells =3D <0>;
+
+						gsw_phy2_led0: led@0 {
+							reg =3D <0>;
+							function =3D LED_FUNCTION_LAN;
+							status =3D "disabled";
+						};
+
+						gsw_phy2_led1: led@1 {
+							reg =3D <1>;
+							function =3D LED_FUNCTION_LAN;
+							status =3D "disabled";
+						};
+					};
+				};
+
+				gsw_phy3: ethernet-phy@3 {
+					compatible =3D "ethernet-phy-ieee802.3-c22";
+					reg =3D <3>;
+					interrupts =3D <3>;
+					phy-mode =3D "internal";
+					nvmem-cells =3D <&phy_calibration_p3>;
+					nvmem-cell-names =3D "phy-cal-data";
+
+					leds {
+						#address-cells =3D <1>;
+						#size-cells =3D <0>;
+
+						gsw_phy3_led0: led@0 {
+							reg =3D <0>;
+							function =3D LED_FUNCTION_LAN;
+							status =3D "disabled";
+						};
+
+						gsw_phy3_led1: led@1 {
+							reg =3D <1>;
+							function =3D LED_FUNCTION_LAN;
+							status =3D "disabled";
+						};
+					};
+				};
+			};
+		};
+
 		ethwarp: clock-controller@15031000 {
 			compatible =3D "mediatek,mt7988-ethwarp";
 			reg =3D <0 0x15031000 0 0x1000>;
=2D-=20
2.43.0


