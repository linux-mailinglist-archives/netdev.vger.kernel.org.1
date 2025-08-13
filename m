Return-Path: <netdev+bounces-213375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC228B24CA9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCEC3AE8D7
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9971C2FFDF0;
	Wed, 13 Aug 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/tw9UyR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74E2FFDC3;
	Wed, 13 Aug 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096950; cv=none; b=NJQKETe8LBYOpyvV3GlXN6Z8HiEC4LuslT+OKSgpO8Av89kQ4rU/PxrpQPbqjbDCEJQbmuwdEfGlYd+O0KRQBR0B2isDpjWWpNUiLNP+Y/ETEdugtIMwgkLqm9I5Uardp6NJaVgNSDQNBK1Ey1MJ9PbSE9BZ9qNUIIM0r1eCMKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096950; c=relaxed/simple;
	bh=5v1d2ZPdszghDIrJGhbTRJ0+vB3QSvZx9Rmgr+KUWTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/L5Iy+J1eEDbx5/27xaS4FRgCKyE5xnSBHJSCgOWqnAuZl7tC8FO8HLQmOum8dGhFIL8BjjjyPpbARaXAWm5AOgU/SryXQ7ATnOBk1xaj4j4BAq9MuPiY0Me64Z//LDjY+7H4CFRDpc+VTiUcJNMPcbFiDLYJokeey667iHvrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/tw9UyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FF8C4CEF7;
	Wed, 13 Aug 2025 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096950;
	bh=5v1d2ZPdszghDIrJGhbTRJ0+vB3QSvZx9Rmgr+KUWTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/tw9UyRi9WYAJpGYKFhq/mzhwsoJ9WvfHDmvHoORmD9os65C3G8v7G8n24guF39l
	 +Ul0dpo0nlD7HyHP3LtVb+SZWbE535S8lmnQ8CLUkVnlKvK9KpInLx0xFvEXmsj2L8
	 zQM85epB76RtyEyelkpmpDJ4rgfCAknVgEb5G2P/F2N6bylYEvM7fKunH1d57hMNTA
	 nkkM/PInbP33R62/RmZcV+eQSuajZ/mNwvdA/7pCMAj1kZVEBFTtbw/El6Me9CiYh+
	 pej+180DDPjBxq0ukp/6CpuidncOY0o7R/fXd7Hu/v61+5cUqhWT9bTU5cDuOY/JJQ
	 UqZD7RENdW0hQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 610145FF91; Wed, 13 Aug 2025 22:55:45 +0800 (CST)
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
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH net-next v2 10/10] arm64: dts: allwinner: t527: orangepi-4a: Enable Ethernet port
Date: Wed, 13 Aug 2025 22:55:40 +0800
Message-Id: <20250813145540.2577789-11-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813145540.2577789-1-wens@kernel.org>
References: <20250813145540.2577789-1-wens@kernel.org>
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

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v1:
- Switch to generic (tx|rx)-internal-delay-ps properties
---
 .../dts/allwinner/sun55i-t527-orangepi-4a.dts | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
index d07bb9193b43..b604d961c4fd 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
@@ -15,6 +15,7 @@ / {
 	compatible = "xunlong,orangepi-4a", "allwinner,sun55i-t527";
 
 	aliases {
+		ethernet0 = &gmac1;
 		serial0 = &uart0;
 	};
 
@@ -95,11 +96,33 @@ &ehci1 {
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
2.39.5


