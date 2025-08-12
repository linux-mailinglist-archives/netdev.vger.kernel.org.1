Return-Path: <netdev+bounces-212810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938B7B2214E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA715630C5
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC0F2E762F;
	Tue, 12 Aug 2025 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="k9Y/WJsl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kz6i6TTp"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB02E7629;
	Tue, 12 Aug 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987430; cv=none; b=KOIWKxhG1ND+18Jd/7eLCjqEYONMA1aURC5wXB/1LPYXYfeCyAVkyfW4jlR7coWttCKNOe7ArmlFlHdro5c47TemmLusxl3kpx4YH1BpoTHHs0WKHgxy5/gi+tRBft3Bh/SHA+AAXXJd7E8pmurEBWdCFf3TfvCrIIc6TKGDsI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987430; c=relaxed/simple;
	bh=tIffv34cZv8t/+FUsWabqju0OasZ57hNt3N2GVlWJgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXuuIOLP8cQFprX8aYDiyuNsNVRRuq3KdhwptzxWhNG9WgyFoCmAiUjBS+g7h5Aen4E1ui7QUGcFJi9HuHnJbsx/MAfQmpzA07Ol2r9jUidGse9XxRFbJrGU99Wlh2QAoCCuLjCPolfg7yegi+eBmpU334paD+txhZjVOqdfgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=k9Y/WJsl; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kz6i6TTp; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c1PpB5r24z9t7J;
	Tue, 12 Aug 2025 10:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1YD7czIezP2aaNO9p/uVgWG790RJXUfVEQIPjK8GJ0=;
	b=k9Y/WJslMYCoGj6EpN8m6HkmwKc7qW37eno6uRpfxGGtRJ11o6mV7JUgMeofSxRfRbGUpK
	1q63gWqX658MHSaTo8ZHRZd9XkKPYmWoDc72hKn/382iOxiOj7HmWo44B1S2aBwrmo59br
	dPR6/9PvhZ8eMeYppi/qbdvO4MnXHecqPOPlVZJpocVoSOSXlystAXReyJaoqa6lY2Bt8T
	5lbNR/ELnJYmCPR1eBgTcEpdybBNs3+hIwDpixm6siDsC9pZ+rhZz5B6Qw8TZSj5eVEyCz
	ZMmHazp4b3XlPHHdDIYCp4IYBw1lJjyHf8epwiNVxNrOkVwLsiN2KnvnWLtLSA==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1YD7czIezP2aaNO9p/uVgWG790RJXUfVEQIPjK8GJ0=;
	b=kz6i6TTpcAo+rCl/79rvgzP+pJG+WyPYA1D8ggCqPZgCi0b4CWHghWFqcoFJm9JAXqMdUN
	FJ3XXfJxqYzuRJVj6StTuCDOUpJye/o3ix6SR1Dg9vrD4u/ykcHdSGNGPwdFaRQEv4tpYW
	/EEQRZ4z/66vOarxXVAOaGWE7Vofbikd5eWr8FHHOcxXflwm6T5ww+MAQUxJhTmGdTCBYo
	/LOKxRXiDcwGPy8FD6IBCZrmEKYFthUGm/89N/FbdwJkmaEMxvD5jS0X2EpO+ufS9P9u1Z
	633PbB4EoQ5wrDNsFFGtF4/xhYx/c5KneRBJ6IZSfiTwrpfZppnvV9CVB+rung==
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
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [net-next RESEND v17 03/12] ARM: dts: nxp: mxs: Adjust XEA board's DTS to support L2 switch
Date: Tue, 12 Aug 2025 10:29:30 +0200
Message-Id: <20250812082939.541733-4-lukasz.majewski@mailbox.org>
In-Reply-To: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
References: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d6d1dae3f2d574fad95
X-MBO-RS-META: rdzm1ma5xy4wb1u49hhcr3kg9373xsan

The description is similar to the one used with the new CPSW driver.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

---
Changes for v2:
- Remove properties which are common for the imx28(7) SoC
- Use mdio properties to perform L2 switch reset (avoid using
  deprecated properties)

Changes for v3:
- Replace IRQ_TYPE_EDGE_FALLING with IRQ_TYPE_LEVEL_LOW
- Update comment regarding PHY interrupts s/AND/OR/g

Changes for v4:
- Use GPIO_ACTIVE_LOW instead of 0 in 'reset-gpios'
- Replace port@[12] with ethernet-port@[12]

Changes for v5:
- Add proper multiline comment for IRQs description

Changes for v6 - v17:
- None
---
 arch/arm/boot/dts/nxp/mxs/imx28-xea.dts | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
index 6c5e6856648a..69032b29d767 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
@@ -5,6 +5,7 @@
  */
 
 /dts-v1/;
+#include<dt-bindings/interrupt-controller/irq.h>
 #include "imx28-lwe.dtsi"
 
 / {
@@ -90,6 +91,61 @@ &reg_usb_5v {
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
+		mtip_port1: ethernet-port@1 {
+			reg = <1>;
+			label = "lan0";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-mode = "rmii";
+			phy-handle = <&ethphy0>;
+		};
+
+		mtip_port2: ethernet-port@2 {
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
+		reset-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
+		reset-delay-us = <25000>;
+		reset-post-delay-us = <10000>;
+
+		ethphy0: ethernet-phy@0 {
+			reg = <0>;
+			smsc,disable-energy-detect;
+			/*
+			 * Both PHYs (i.e. 0,1) have the same, single GPIO,
+			 * line to handle both, their interrupts (OR'ed)
+			 */
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


