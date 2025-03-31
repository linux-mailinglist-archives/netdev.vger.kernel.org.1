Return-Path: <netdev+bounces-178275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BB1A76440
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 12:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0993AB4DF
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 10:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D928B1E32DB;
	Mon, 31 Mar 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="hsibM70A"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521B1E1C3A;
	Mon, 31 Mar 2025 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417116; cv=none; b=BZ5wXAkCG86zSghFFem1EkSOA7jzu+JnDeak8yXPQ89ndMwKsM8ZIRyxvf9EXy8eKprx1dXAC8gzZTC7R4u8eGKL1t2BLkuZhlHhikjs/sKIVLJRO+H7aHJthU+aSeiTXPN/RLDhzTurAhE7UAz0PRJH8I/zn+5HlOqK+wy77lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417116; c=relaxed/simple;
	bh=wN3qf0SkaLpUV4KJsUkHNepClqiWTtBbjeGKCL7bgtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSdFkxh51q7dzwm/z5gw8d8cZ+sU1g2PGJqUUVz3i4a63OZdtWpO0hHZVzy+IuubEIN/04MeQ1icrKA8YPKku8pJWp5+0ZMmUQWDrRw4b1q7+gp0cVjQICDpkNellDN/HugO/rJfn2Wl7UXJMeg9Kp8WK80FgOn3MkDTJjU4ixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=hsibM70A; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A267B102512C5;
	Mon, 31 Mar 2025 12:31:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743417113; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ltyh3dVlhH/WEYYoQvaROCeowjenP0aYtYVh++kl38A=;
	b=hsibM70A+N7FwRupgVj74X4cypTWH2D58PrvWvOrHztEVw4Ml5Tf2/XOGJ/Re3D2FPEw2b
	GiLTBF2DSyUxQiKHowxPJvnRdqkGxwzrXDM9D1PdexUDm4NVAJHL2m1Qs5tnZOIJiqkwfu
	TmBrLFYiqMt4KL8wbWfl/NI/MVxtyU7fFxtKLq5JNjmQeBPEd/Dl4Y8Uwsm9I9Jc61deED
	vYkpdrD3cTplx+Fzd+cFZEOe3Nlrc8L/+3SULgV2xlHfZxiwbPq+iMgcy6qE2ZQ3b7VXT2
	AhPED6WjFDflnZBGHj6cn706kfBACmlhuSngwFwvzzZB/hvsz1l+KsboDb4gng==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3 3/4] ARM: dts: nxp: mxs: Adjust XEA board's DTS to support L2 switch
Date: Mon, 31 Mar 2025 12:31:15 +0200
Message-Id: <20250331103116.2223899-4-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331103116.2223899-1-lukma@denx.de>
References: <20250331103116.2223899-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The description is similar to the one used with the new CPSW driver.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Remove properties which are common for the imx28(7) SoC
- Use mdio properties to perform L2 switch reset (avoid using
  deprecated properties)

Changes for v3:
- Replace IRQ_TYPE_EDGE_FALLING with IRQ_TYPE_LEVEL_LOW
- Update comment regarding PHY interrupts s/AND/OR/g
---
 arch/arm/boot/dts/nxp/mxs/imx28-xea.dts | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
index 6c5e6856648a..8642578fddf3 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
@@ -5,6 +5,7 @@
  */
 
 /dts-v1/;
+#include<dt-bindings/interrupt-controller/irq.h>
 #include "imx28-lwe.dtsi"
 
 / {
@@ -90,6 +91,59 @@ &reg_usb_5v {
 	gpio = <&gpio0 2 0>;
 };
 
+&eth_switch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mac0_pins_a>, <&mac1_pins_a>;
+	phy-supply = <&reg_fec_3v3>;
+	status = "okay";
+
+	ethernet-ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mtip_port1: port@1 {
+			reg = <1>;
+			label = "lan0";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-mode = "rmii";
+			phy-handle = <&ethphy0>;
+		};
+
+		mtip_port2: port@2 {
+			reg = <2>;
+			label = "lan1";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-mode = "rmii";
+			phy-handle = <&ethphy1>;
+		};
+	};
+
+	mdio_sw: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reset-gpios = <&gpio3 21 0>;
+		reset-delay-us = <25000>;
+		reset-post-delay-us = <10000>;
+
+		ethphy0: ethernet-phy@0 {
+			reg = <0>;
+			smsc,disable-energy-detect;
+			/* Both PHYs (i.e. 0,1) have the same, single GPIO, */
+			/* line to handle both, their interrupts (OR'ed) */
+			interrupt-parent = <&gpio4>;
+			interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+		};
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			smsc,disable-energy-detect;
+			interrupt-parent = <&gpio4>;
+			interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+};
+
 &spi2_pins_a {
 	fsl,pinmux-ids = <
 		MX28_PAD_SSP2_SCK__SSP2_SCK
-- 
2.39.5


