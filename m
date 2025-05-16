Return-Path: <netdev+bounces-191139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84173ABA26E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC4E7B6921
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979C527FD5D;
	Fri, 16 May 2025 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="AEBfa2Dy"
X-Original-To: netdev@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363427AC4D;
	Fri, 16 May 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418530; cv=none; b=KDEr3oE/JiD4IzHtQ3NpOGORkaQofYT/3Jm+PVajCHpguUQuKPEK7pFF7B66adUpk11tshhxm+f3qCwAkdR26HX8e6bXJpyUIbG7Qf0T7c9GpYOm3jsVn+C6fV34WiI/sDujCeoo8rTJpjGusmd5yTgrDetKsRdm9Wv+21b1bIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418530; c=relaxed/simple;
	bh=2Q3Lh8RzFPt5G0ZmLhPVEopmeU5KWn/0EC2Iut2Gi+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLX4CMMnZzNaIQY+kydZ+iVKzAXerpVR3Cwy1dOPWdPuMohF3SYTs/9P4ZuG+Awpn1AQZdbT44ks+rtQVYzf7diTVw78ppT4rN4oE5neI7RZ+75B94/0/DMUARnqYCqpnNs+8aBLsAFrVTigMu19cfqLoMFyxXKfSUEgJMiqVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=AEBfa2Dy; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id 43CF11007D9;
	Fri, 16 May 2025 18:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1747418520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDKwXO4W7gl7E+DfM+kKfgbEcodSxNbRXwjNIlU84So=;
	b=AEBfa2DyrBYvNlT632AR13bSsOAc33Wx8Cos7GJIi9ttjOZe/InxjRTNRBeGNriqggZpMH
	YqwXfgPdJRoiNYzUUTGyS6HctDezfsouaXCHJH9aO7zD9AEMj7s9UQ1Mh0s+PlHcc+9qfW
	GqhtOTCOloPflj9RMEknhYZ9jtjcUcg=
Received: from frank-u24.. (fttx-pool-157.180.226.139.bambit.de [157.180.226.139])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id E91C71226F2;
	Fri, 16 May 2025 18:01:59 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
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
Subject: [PATCH v2 14/14] arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and leds
Date: Fri, 16 May 2025 20:01:45 +0200
Message-ID: <20250516180147.10416-16-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250516180147.10416-1-linux@fw-web.de>
References: <20250516180147.10416-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Assign pinctrl to switch phys and leds.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v2:
- add labels and led-function and include after dropping from soc dtsi
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index d40c8dbcd18e..9e4ae4c4ea17 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/richtek,rt5190a-regulator.h>
+#include <dt-bindings/leds/common.h>
 
 #include "mt7988a.dtsi"
 
@@ -126,6 +127,66 @@ &gmac2 {
 	phy-mode = "usxgmii";
 };
 
+&gsw_phy0 {
+	pinctrl-names = "gbe-led";
+	pinctrl-0 = <&gbe0_led0_pins>;
+};
+
+&gsw_phy0_led0 {
+	status = "okay";
+	function = LED_FUNCTION_WAN;
+	color = <LED_COLOR_ID_GREEN>;
+};
+
+&gsw_port0 {
+	label = "wan";
+};
+
+&gsw_phy1 {
+	pinctrl-names = "gbe-led";
+	pinctrl-0 = <&gbe1_led0_pins>;
+};
+
+&gsw_phy1_led0 {
+	status = "okay";
+	function = LED_FUNCTION_LAN;
+	color = <LED_COLOR_ID_GREEN>;
+};
+
+&gsw_port1 {
+	label = "lan1";
+};
+
+&gsw_phy2 {
+	pinctrl-names = "gbe-led";
+	pinctrl-0 = <&gbe2_led0_pins>;
+};
+
+&gsw_phy2_led0 {
+	status = "okay";
+	function = LED_FUNCTION_LAN;
+	color = <LED_COLOR_ID_GREEN>;
+};
+
+&gsw_port2 {
+	label = "lan2";
+};
+
+&gsw_phy3 {
+	pinctrl-names = "gbe-led";
+	function = LED_FUNCTION_LAN;
+	pinctrl-0 = <&gbe3_led0_pins>;
+};
+
+&gsw_phy3_led0 {
+	status = "okay";
+	color = <LED_COLOR_ID_GREEN>;
+};
+
+&gsw_port3 {
+	label = "lan3";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
-- 
2.43.0


