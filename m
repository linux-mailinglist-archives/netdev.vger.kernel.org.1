Return-Path: <netdev+bounces-225622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCED5B961F1
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86966446477
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E53F21FF49;
	Tue, 23 Sep 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cjh9lXJi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C102C18A;
	Tue, 23 Sep 2025 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636170; cv=none; b=gGG0ni/XT2lLEP8UdRpURVR9yln+uyKvv7ja7kkZeuS71HJr9dk5EQvSloN8s+TQNub8QGNgyHS/jUdutsiIudv+OMu+QNRWBOwwjn/Xalg4u2OBEO3QmgNjSIa7lbUQwk3+u/N14gF792OxqmPG4DEZLQ/dVUV93WMstz4Xv2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636170; c=relaxed/simple;
	bh=rx7cTQhbHRFL+3YWoqnP53MCOR0zwAA48Z7BXBg9pb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYw06d1LQvsBXCNYf0dMt75mWkhdjooiMHaijScQtaK898mqEZwc+s+Sajb0YjzCOJ1unJNygTgOAa7/xzmkcYG42yV9IIIR5xPuGOp5/oXW897lB4ReR4q4tIC+IatZS8TQqERqUJ2f9bZLGifZM1g5CGnCE1NHefi1GaJRcpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cjh9lXJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD4DC4AF09;
	Tue, 23 Sep 2025 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758636170;
	bh=rx7cTQhbHRFL+3YWoqnP53MCOR0zwAA48Z7BXBg9pb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cjh9lXJinGubymHzTR8iqkFWHo4/T+IVyPeOOJTqk5xNF0ysF0BFzz5ZP6X33I6iU
	 kjmFzhh9y0LP49AaQBa2TRdJrcu3gjyAsZLWMCCvuAlxdiJjlKbo4oqteslU5Jbv87
	 6iGmWxUmXiG6Rd4NU56EbrhPsOmiffgbU/AKhn8iaxfGJhaa7CbFNqci2nUutt0DZP
	 sAP7ZkImbREwAF5fu1W8oQB1juq9445HPePL88N+R+4Yu2hABq0Gl+460ssA+0wrX1
	 AYxVt63e7BKzqhLdN1sQ88s5SfUQkW01kkqBI1DBdLagBdwfrAo2eeRqIRVNZbwbsb
	 j0XG6YcGPjcbQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 35554606A9; Tue, 23 Sep 2025 22:02:48 +0800 (CST)
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
Subject: [PATCH net-next v7 4/6] arm64: dts: allwinner: a527: cubie-a5e: Enable second Ethernet port
Date: Tue, 23 Sep 2025 22:02:44 +0800
Message-ID: <20250923140247.2622602-5-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923140247.2622602-1-wens@kernel.org>
References: <20250923140247.2622602-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

On the Radxa Cubie A5E board, the second Ethernet controller, aka the
GMAC200, is connected to a second external Maxio MAE0621A PHY. The PHY
uses an external 25MHz crystal, and has the SoC's PJ16 pin connected to
its reset pin.

Enable the second Ethernet port. Also fix up the label for the existing
external PHY connected to the first Ethernet port. An enable delay for the
PHY supply regulator is added to make sure the PHY's internal regulators
are fully powered and the PHY is operational.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v1:
- Switch to generic (tx|rx)-internal-delay-ps properties
- Add PHY regulator delay
---
 .../dts/allwinner/sun55i-a527-cubie-a5e.dts   | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
index f82a8d121697..bfdf1728cd14 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
@@ -14,6 +14,7 @@ / {
 
 	aliases {
 		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 		serial0 = &uart0;
 	};
 
@@ -75,7 +76,7 @@ &ehci1 {
 
 &gmac0 {
 	phy-mode = "rgmii-id";
-	phy-handle = <&ext_rgmii_phy>;
+	phy-handle = <&ext_rgmii0_phy>;
 	phy-supply = <&reg_cldo3>;
 
 	allwinner,tx-delay-ps = <300>;
@@ -84,13 +85,24 @@ &gmac0 {
 	status = "okay";
 };
 
+&gmac1 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii1_phy>;
+	phy-supply = <&reg_cldo4>;
+
+	tx-internal-delay-ps = <300>;
+	rx-internal-delay-ps = <400>;
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
@@ -99,6 +111,16 @@ ext_rgmii_phy: ethernet-phy@1 {
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
@@ -250,6 +272,8 @@ reg_cldo4: cldo4 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc-pj-phy";
+				/* enough time for the PHY to fully power on */
+				regulator-enable-ramp-delay = <150000>;
 			};
 
 			reg_cpusldo: cpusldo {
-- 
2.47.3


