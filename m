Return-Path: <netdev+bounces-51912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E187FCAC2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815881C20DCF
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992865C3D9;
	Tue, 28 Nov 2023 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V0HNEa/j"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78D2198
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lpI0Vra9X/HY3qlu19ZgxU3xjt12DSRdhjrzgh/m9Tk=; b=V0HNEa/jcSALpnNF97T1vz7zgC
	fI8eLtxuuGWn2NeuV976+PZcXDybCiu0CFjtEiRjf+tzcJ9v2Mk3VUQYH9U0ePZa7Nq/q8vv+UNWZ
	g3HtVUBPyQC/6jbWYXrX78zicq7dgOj7VBSVQKFIoB2PHNqm464619AFRu0mgjivQ1cg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r87Op-001VJG-ON; Wed, 29 Nov 2023 00:21:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC net-next 7/8] arm: boot: dts: mvebu: linksys-mamba: Add Ethernet LEDs
Date: Wed, 29 Nov 2023 00:21:34 +0100
Message-Id: <20231128232135.358638-8-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231128232135.358638-1-andrew@lunn.ch>
References: <20231128232135.358638-1-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

List the front panel Ethernet LEDs in the switch section of the
device tree. They can then be controlled via /sys/class/led/

The node contains a label property to influence the name of the LED.
Without it, all the LEDs get the name lan:white, which classes, and so
some get a number appended. lan:white_1, lan:white_2, etc. Using the
label the LEDs are named lan1:front, lan2:front, lan3:front, where
lanX indicates the interface name, and front indicates they are on the
front of the box.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../dts/marvell/armada-xp-linksys-mamba.dts   | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
index 7a0614fd0c93..f3949e992d56 100644
--- a/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
@@ -19,6 +19,7 @@
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include "armada-xp-mv78230.dtsi"
 
 / {
@@ -278,26 +279,91 @@ ports {
 			port@0 {
 				reg = <0>;
 				label = "lan4";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_WHITE>;
+						function = LED_FUNCTION_LAN;
+						label = "front";
+						default-state = "keep";
+					};
+				};
 			};
 
 			port@1 {
 				reg = <1>;
 				label = "lan3";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_WHITE>;
+						function = LED_FUNCTION_LAN;
+						label = "front";
+						default-state = "keep";
+					};
+				};
 			};
 
 			port@2 {
 				reg = <2>;
 				label = "lan2";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_WHITE>;
+						function = LED_FUNCTION_LAN;
+						label = "front";
+						default-state = "keep";
+					};
+				};
 			};
 
 			port@3 {
 				reg = <3>;
 				label = "lan1";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_WHITE>;
+						function = LED_FUNCTION_LAN;
+						label = "front";
+						default-state = "keep";
+					};
+				};
 			};
 
 			port@4 {
 				reg = <4>;
 				label = "internet";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_WHITE>;
+						function = LED_FUNCTION_LAN;
+						label = "front";
+						default-state = "keep";
+					};
+				};
 			};
 
 			port@5 {
-- 
2.42.0


