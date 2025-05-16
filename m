Return-Path: <netdev+bounces-191140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA9ABA26F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 550FA7B6956
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9D027FD60;
	Fri, 16 May 2025 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="E8iqsaXj"
X-Original-To: netdev@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36B327AC4E;
	Fri, 16 May 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418530; cv=none; b=GcWIWVdhDO3QA3bVYMNk75Usx/aPuLnzZav0zDVE45dkyq4ShW7BzvbS2lgWX1dOJINLrJ3cJabf0lC1ey5PXCgZO7ezn0HJVHHo3ZOUSu90cGm7C7+IDRBw/LbHENKGXE6ekOp74gsbzyOj5AJxq83B3DSTBcrTI38ZIaL9KBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418530; c=relaxed/simple;
	bh=7Jjblv4yG5YMN+/JXUJbLWbcWP0q8ENN+0a9DbtrRIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+n+P1NLCP+xFWd63iQcedUqe70XCtS3Q1+g2hK5WrzWDesqwksjFzRieIjDm6L/d9gCKlLt2zC8lgteHWtyapN+SpJNMt8ysfqKuZcvB8JviooWm9vAcYnww4sj8sA1n5HOmhhwT6JxsYryCjeFUS8bDzUXDxvcGIIWUH4N3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=E8iqsaXj; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id E1AF540772;
	Fri, 16 May 2025 18:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1747418519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RHbYPq/h+v4flSJokaAuA/cakf8tYhXsyBD00AeipyA=;
	b=E8iqsaXjKJ/qJZ+Ipt0fdEhrky4FrF6JIXdOk5YxZEHaJvlUiWsbyIpmJpmbcWg1Cd8/j5
	0Zj1uYhlTD7oPoYMRykR3hn4vvR5owojmXyuU9p9Ugh6hrTjtivaDYPdC+bzPO9gYJ2JIj
	ZjlGgm4U38p0gwJ5uyRIZz5HNfMroqg=
Received: from frank-u24.. (fttx-pool-157.180.226.139.bambit.de [157.180.226.139])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 96BA31226C1;
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
Subject: [PATCH v2 13/14] arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and link to gmac
Date: Fri, 16 May 2025 20:01:44 +0200
Message-ID: <20250516180147.10416-15-linux@fw-web.de>
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

Add SFP cages to Bananapi-R4 board. The 2.5g phy variant only contains the
wan-SFP, so add this to common dtsi and the lan-sfp only to the dual-SFP
variant.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../mediatek/mt7988a-bananapi-bpi-r4-2g5.dts   | 11 +++++++++++
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts   | 18 ++++++++++++++++++
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi  | 18 ++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
index 53de9c113f60..574ac1b853a6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
@@ -9,3 +9,14 @@ / {
 	model = "Banana Pi BPI-R4 (1x SFP+, 1x 2.5GbE)";
 	chassis-type = "embedded";
 };
+
+&gmac1 {
+	phy-mode = "internal";
+	phy-connection-type = "internal";
+	phy = <&int_2p5g_phy>;
+};
+
+&int_2p5g_phy {
+	pinctrl-names = "i2p5gbe-led";
+	pinctrl-0 = <&i2p5gbe_led0_pins>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 36bd1ef2efab..3136dc4ba4cc 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -8,6 +8,24 @@ / {
 	compatible = "bananapi,bpi-r4", "mediatek,mt7988a";
 	model = "Banana Pi BPI-R4 (2x SFP+)";
 	chassis-type = "embedded";
+
+	/* SFP2 cage (LAN) */
+	sfp2: sfp2 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp2>;
+		los-gpios = <&pio 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&pio 83 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&pio 0 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&pio 1 GPIO_ACTIVE_HIGH>;
+		rate-select0-gpios = <&pio 3 GPIO_ACTIVE_LOW>;
+		maximum-power-milliwatt = <3000>;
+	};
+};
+
+&gmac1 {
+	sfp = <&sfp2>;
+	managed = "in-band-status";
+	phy-mode = "usxgmii";
 };
 
 &pca9545 {
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index afa9e3b2b16a..d40c8dbcd18e 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -38,6 +38,18 @@ reg_3p3v: regulator-3p3v {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	/* SFP1 cage (WAN) */
+	sfp1: sfp1 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp1>;
+		los-gpios = <&pio 54 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&pio 82 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&pio 70 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&pio 69 GPIO_ACTIVE_HIGH>;
+		rate-select0-gpios = <&pio 21 GPIO_ACTIVE_LOW>;
+		maximum-power-milliwatt = <3000>;
+	};
 };
 
 &cci {
@@ -108,6 +120,12 @@ map-cpu-active-low {
 	};
 };
 
+&gmac2 {
+	sfp = <&sfp1>;
+	managed = "in-band-status";
+	phy-mode = "usxgmii";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
-- 
2.43.0


