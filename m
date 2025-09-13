Return-Path: <netdev+bounces-222782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156AEB56012
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 12:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF6B585C73
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4F72ECE8A;
	Sat, 13 Sep 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGaktS2U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B742ECD2C;
	Sat, 13 Sep 2025 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758437; cv=none; b=kBKlhq5/4RBE6bh4J7+KOMb6iJASHMPkZBjTTuUdgvvOG0ngQgBE9kSZ2t1G/Opst3c1klVuNIDMlU0lgZOZmHadqi3L7zpZgF4Zd1seCLniHPTZ5KQPb2zOwdXjNo7cP6kqkSeqUybQ7Af595jM1k+U8YbscnFLqto+2hj2F8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758437; c=relaxed/simple;
	bh=DMZOlPHKGGqu2GeBUhHX5OGLOzhVhpJibAq4mRN3kNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ma+ziQux/Q9TwMlVmIA4ia663p1YeTc5FUAyUIFO5LZv5nzJ8ktiDeToAP2FmuBViZFQwRvVG8GeJv+SKY8i5aeVD2rzM2ZDsw86nebHszyJyUoA8XLsge3H+5gbv4LgYTpyBgINxy3llAoN7Hyohi/PnEtEBOFHjGc7D9hGOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGaktS2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5744DC4CEF8;
	Sat, 13 Sep 2025 10:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757758437;
	bh=DMZOlPHKGGqu2GeBUhHX5OGLOzhVhpJibAq4mRN3kNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGaktS2UaEUclwr79I8quEPNzZSanM1g/BstUnAVgTInkxU57BTm43qmqAZipU6WB
	 GZkZU9ILcVTGmgu3y2ZO+iv+NA9j3QCIE/jkbJmlYaijsKy8WQOGiP/8xjT7QPHTvd
	 2jqBuYMBu6guKS3dDEsdVsUQ4MQ6JCTPt+V/AFFpM2Dj2HxMIm8rWhkZ7UdQneEgxJ
	 5PxwthGCFduxexAVKJA5akLDUiQ9VH5GGLUFzX4c5ss4TGSGHEUy7PUDnx0Vz7p85K
	 UuHvOxIiplFNMDnPr0PtrfhdsDxzv8/E4MoSxfeubxfujw79kKDqznPSdtgtnfrXBf
	 n22MOmg8+KQ9A==
Received: by wens.tw (Postfix, from userid 1000)
	id 6065A5FEE9; Sat, 13 Sep 2025 18:13:53 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v6 5/6] arm64: dts: allwinner: t527: avaota-a1: enable second Ethernet port
Date: Sat, 13 Sep 2025 18:13:48 +0800
Message-Id: <20250913101349.3932677-6-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250913101349.3932677-1-wens@kernel.org>
References: <20250913101349.3932677-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

On the Avaota A1 board, the second Ethernet controller, aka the GMAC200,
is connected to a second external RTL8211F-CG PHY. The PHY uses an
external 25MHz crystal, and has the SoC's PJ16 pin connected to its
reset pin.

Enable the second Ethernet port. Also fix up the label for the existing
external PHY connected to the first Ethernet port.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v1:
- Switch to generic (tx|rx)-internal-delay-ps properties
---
 .../dts/allwinner/sun55i-t527-avaota-a1.dts   | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index e7713678208d..f540965ffaa4 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -13,6 +13,7 @@ / {
 
 	aliases {
 		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 		serial0 = &uart0;
 	};
 
@@ -67,7 +68,7 @@ &ehci1 {
 
 &gmac0 {
 	phy-mode = "rgmii-id";
-	phy-handle = <&ext_rgmii_phy>;
+	phy-handle = <&ext_rgmii0_phy>;
 	phy-supply = <&reg_dcdc4>;
 
 	allwinner,tx-delay-ps = <100>;
@@ -76,13 +77,24 @@ &gmac0 {
 	status = "okay";
 };
 
+&gmac1 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii1_phy>;
+	phy-supply = <&reg_dcdc4>;
+
+	tx-internal-delay-ps = <100>;
+	rx-internal-delay-ps = <100>;
+
+	status = "okay";
+};
+
 &gpu {
 	mali-supply = <&reg_dcdc2>;
 	status = "okay";
 };
 
 &mdio0 {
-	ext_rgmii_phy: ethernet-phy@1 {
+	ext_rgmii0_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
 		reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
@@ -91,6 +103,16 @@ ext_rgmii_phy: ethernet-phy@1 {
 	};
 };
 
+&mdio1 {
+	ext_rgmii1_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		reset-gpios = <&pio 9 16 GPIO_ACTIVE_LOW>; /* PJ16 */
+		reset-assert-us = <10000>;
+		reset-deassert-us = <150000>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo3>;
 	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */
-- 
2.39.5


