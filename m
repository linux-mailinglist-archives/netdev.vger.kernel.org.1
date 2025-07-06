Return-Path: <netdev+bounces-204396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4F4AFA542
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 15:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336FD17B556
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 13:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE062192FC;
	Sun,  6 Jul 2025 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="xEeUP1Ni"
X-Original-To: netdev@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7BD1DF256;
	Sun,  6 Jul 2025 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751808160; cv=none; b=bUj+R4+q8gqDYirndznXvz699Q+gOdgzixRqr7cs0Mao/RKC/hmOuh54pZIrUX04rdqD2WqwLULnl5jFJXeBiTHcairOTF0feMrlRpEArdv/Wgvzk3WEc84KYic8glfxI+DyKZSeLjVtLu9ORvBltm5YjgChlzHAWB1dAfikyuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751808160; c=relaxed/simple;
	bh=6rXB9uhFua0CDavnN2LWnw7HTLqju5HTq/AgWYbkQns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3RicHcndx4YWn79eOh1b5KM0S5I1tuVvXUq5phTv/X2N7IRpWMCWu1wU4B8jW6eXNqpYyLCLcLlmeXoI16450ywQozH+l2obh9a+CBMiQFK2Mw40A1DvaY53InBZ8a49DlzPBiCMyXIB3CXLyufYhks1ZRro/q4i8W7hNZ37iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=xEeUP1Ni; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id CDC625FD70;
	Sun,  6 Jul 2025 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1751808152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Po3wYPbug5oitTRavuGEWn/QaJpRE4HKrgqN22L2B/4=;
	b=xEeUP1NiwhakivHU3ZoFgBpcXk03oJPO8y47empujIbr9D1EINc/ySTO0wUJtvMaZAtXsW
	+l83DM6N52kDa92ffDaQb9AvWqm55fN6jPYPXhBvQJb6wcu0afeOHCDQfl00Dkzy1berP/
	TxKPbRg5EHJo2KeGbUswggKNqIRu2hQ=
Received: from frank-u24.. (fttx-pool-194.15.86.111.bambit.de [194.15.86.111])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 751A71226F8;
	Sun,  6 Jul 2025 13:22:32 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v8 15/16] arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and link to gmac
Date: Sun,  6 Jul 2025 15:22:10 +0200
Message-ID: <20250706132213.20412-16-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250706132213.20412-1-linux@fw-web.de>
References: <20250706132213.20412-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add SFP cages to Bananapi-R4 board. The 2.5g phy variant only contains the
wan-SFP, so add this to common dtsi and the lan-sfp only to the dual-SFP
variant.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v4:
- update 2g5-board (reorder and drop phy-connection-type)
- order sfp properties
v3:
- enable mac with 2.5g phy on r4 phy variant because driver is now mainline
---
 .../mediatek/mt7988a-bananapi-bpi-r4-2g5.dts  | 11 +++++++++++
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  | 19 +++++++++++++++++++
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 19 +++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
index 53de9c113f60..6f0c81e3fd94 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
@@ -9,3 +9,14 @@ / {
 	model = "Banana Pi BPI-R4 (1x SFP+, 1x 2.5GbE)";
 	chassis-type = "embedded";
 };
+
+&gmac1 {
+	phy = <&int_2p5g_phy>;
+	phy-mode = "internal";
+	status = "okay";
+};
+
+&int_2p5g_phy {
+	pinctrl-0 = <&i2p5gbe_led0_pins>;
+	pinctrl-names = "i2p5gbe-led";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 36bd1ef2efab..4b3796ba82e3 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -8,6 +8,25 @@ / {
 	compatible = "bananapi,bpi-r4", "mediatek,mt7988a";
 	model = "Banana Pi BPI-R4 (2x SFP+)";
 	chassis-type = "embedded";
+
+	/* SFP2 cage (LAN) */
+	sfp2: sfp2 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp2>;
+		maximum-power-milliwatt = <3000>;
+
+		los-gpios = <&pio 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&pio 83 GPIO_ACTIVE_LOW>;
+		rate-select0-gpios = <&pio 3 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&pio 0 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&pio 1 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&gmac1 {
+	managed = "in-band-status";
+	phy-mode = "usxgmii";
+	sfp = <&sfp2>;
 };
 
 &pca9545 {
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index 20073eb4d1bd..4d709ee527df 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -63,6 +63,19 @@ reg_3p3v: regulator-3p3v {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	/* SFP1 cage (WAN) */
+	sfp1: sfp1 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp1>;
+		maximum-power-milliwatt = <3000>;
+
+		los-gpios = <&pio 54 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&pio 82 GPIO_ACTIVE_LOW>;
+		rate-select0-gpios = <&pio 21 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&pio 70 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&pio 69 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &cci {
@@ -133,6 +146,12 @@ map-cpu-active-low {
 	};
 };
 
+&gmac2 {
+	managed = "in-band-status";
+	phy-mode = "usxgmii";
+	sfp = <&sfp1>;
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
-- 
2.43.0


