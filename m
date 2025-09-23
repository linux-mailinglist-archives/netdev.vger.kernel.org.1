Return-Path: <netdev+bounces-225628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D59B96230
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEDC19C2AB9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADC325DB12;
	Tue, 23 Sep 2025 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUp0aMdO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5525A357;
	Tue, 23 Sep 2025 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636173; cv=none; b=JyNIMoEm+jU0go1iwKkZjsZ537rfCpQyUBchXTrhoDHzG419RYCyqnBiMPBvG9s9O8mKXT5qtZFLWplpDnMt3ns+BbkbfAGeLTED9N+BM/Z2RUsrhZt0rhzSZ/s+1yR2H9xqGhC5yiBOl3uM3h6+DAZk3wEb8ssgjrRCNFiRYMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636173; c=relaxed/simple;
	bh=Qg34C9exkp2NB8HBKF6gQRoaPUtMAb5daqSaeZ5VcOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6r3vhW6ZbBw0Kk+CDuTSXIWSVMjCxT6Kgl64pqUVqug3K7LpPV7zzFDM67gUN/QyinONtSqEOIj9955opwH+CXgXcqJXo3RQWqxKWThSb2iJ3j9vl3Io/oLPiTAOqQgrfc1NKqPPXk9HehswBKySDPl9V2Hg+U6M6ZMU5qI7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUp0aMdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB2DC19423;
	Tue, 23 Sep 2025 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758636172;
	bh=Qg34C9exkp2NB8HBKF6gQRoaPUtMAb5daqSaeZ5VcOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rUp0aMdO5ZtjRnqrzLLuX8BbdqZ+4uxgtW6rUXzh7F5DBC2rNEc23n8NM7BBRfEPY
	 3gpkUuh4eD2ptjdd26nk7U/r/5JuikR3D6gHHeQ3RamrOLtQlJfwSN44tWkPzM/2D1
	 mNhNCrVt8zPLR/qaoPBhd+JZ25zPjqamL1qaH7b+YrFi4nc10BgnrE3vneIAvvU/El
	 kGrAoWZDbv9H5NOe08sexZnoWw1cgC1A/Uv5JbqoK0y4TI9YziSUlaC9zfC3L5oYUZ
	 po3V4AgAaq9+aDwy+0V84jRVo3snDhnVpJi1Hv6Wi4gG2QOAARoxY+JAFrqfgOKQb2
	 vj2j8SxtbHXZQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 50B67606B2; Tue, 23 Sep 2025 22:02:48 +0800 (CST)
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
Subject: [PATCH net-next v7 6/6] arm64: dts: allwinner: t527: orangepi-4a: Enable Ethernet port
Date: Tue, 23 Sep 2025 22:02:46 +0800
Message-ID: <20250923140247.2622602-7-wens@kernel.org>
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

On the Orangepi 4A board, the second Ethernet controller, aka the GMAC200,
is connected to an external Motorcomm YT8531 PHY. The PHY uses an external
25MHz crystal, has the SoC's PI15 pin connected to its reset pin, and
the PI16 pin for its interrupt pin.

Enable it.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v1:
- Switch to generic (tx|rx)-internal-delay-ps properties
---
 .../dts/allwinner/sun55i-t527-orangepi-4a.dts | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
index 39a4e194712a..9e6b21cf293e 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
@@ -15,6 +15,7 @@ / {
 	compatible = "xunlong,orangepi-4a", "allwinner,sun55i-t527";
 
 	aliases {
+		ethernet0 = &gmac1;
 		serial0 = &uart0;
 	};
 
@@ -102,11 +103,33 @@ &ehci1 {
 	status = "okay";
 };
 
+&gmac1 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_cldo4>;
+
+	tx-internal-delay-ps = <0>;
+	rx-internal-delay-ps = <300>;
+
+	status = "okay";
+};
+
 &gpu {
 	mali-supply = <&reg_dcdc2>;
 	status = "okay";
 };
 
+&mdio1 {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		interrupts-extended = <&pio 8 16 IRQ_TYPE_LEVEL_LOW>; /* PI16 */
+		reset-gpios = <&pio 8 15 GPIO_ACTIVE_LOW>; /* PI15 */
+		reset-assert-us = <10000>;
+		reset-deassert-us = <150000>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo3>;
 	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */
-- 
2.47.3


