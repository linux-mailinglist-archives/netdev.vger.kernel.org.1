Return-Path: <netdev+bounces-144310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2309C689A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E2B1F2403E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EC717C7C9;
	Wed, 13 Nov 2024 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dneZAk/z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3BF17BB16;
	Wed, 13 Nov 2024 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731475207; cv=none; b=Bj9l7y3oEoU/7FMhY4+n0b6PbfujCQncSvJOCT68wbVzRnCGReLCASpHgk+e+1yusP8RNeSO8DHTQo5o3gyUEdGBKoCsGV11d+uSILV7qFIhpekXyhrDgD1AvzGlBoOGUUq2Yn0kUg1FGrAaWOSQ611Qbw4C1saY5kAvTLpXO2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731475207; c=relaxed/simple;
	bh=EgBrp4Ny2AVL96aL+BBe0BLBf3Nn7BuMDjdNyU9Geds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQbud5sToVIth3ZT7MlyxRm8q74kEZCwrlJIwbJ0Y1ML/0SOT/Zj4OjShyyBTU8n72CA9bkRp0aVlalzxOE2Czo/UU9bpnfGjKNyG29vmSZg050bCQ65TEJv7uSHs7Iz+mmFCafyhznt9+47k9vNeRIl5vfWuZKDR7UWBjgO0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dneZAk/z; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-72458c0e0d5so280677b3a.1;
        Tue, 12 Nov 2024 21:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731475206; x=1732080006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuVwXZjcL2Z1SKt3iutb0b2hQewo+6dCF311Yje5+1s=;
        b=dneZAk/zXoadUm418BL1gwjibdKU3dt7+AWxTjJpk0BYZ3e/pMYwABDiFteE9bm2Fd
         wrMIWK2Uj5fdFgA3Le4P4K8nOOlGW+P7AYvFC5fyJ9JkC9cROJOu99ch1NsQ5ZMM7Y5C
         ZfedyOcHOqz66Vo4ray38gZrH1SBhqJrjAHfVPw2yYOmfR3oNSupJKOd70c9HI8Ep2qh
         fNOgZd8WZ/fMsC6wmaaNgbrhUyc8Hm7n6EwYLsgWhdW9rSV1iB/o9bKWBeT/i9nZpffD
         oSRlu/XGTOY6BA+v1KhYOBHbMAldYE8AghksimcO9Hxocn9FvP8nh20EhSJ2G5pDYAHO
         hwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731475206; x=1732080006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuVwXZjcL2Z1SKt3iutb0b2hQewo+6dCF311Yje5+1s=;
        b=HI3oYk6CzqxHyQwfjJl22Xp0aPLy24yuhgLls1sUcbQbpCjLWfwp/N4buh1deHlDmm
         zO+30+wEGGIVKc4s/bn30MQldLiHFML+7XrlGUqWeSPr6w34r7C9WlQGePJjhtZuEbvu
         e5MIVAuvhKFLczrr7KHSwJlqv/vIdqnCIQfyZLimkbdPSuP2QwhqTe+ScXxt7fySaQfW
         FqMa5uTcNEyUGUJx2E5zE2mK4q53r5M4Alm9w5jhsWJ9RqtUc+7TOJBgc5lU+Sox7aUh
         3ydFuT/hM8Z31VM1v1NMt+noCHBSNUZj+rUe58IRN5gMz+7FYIiX3PJVSc7Pc5pOaemf
         gIiA==
X-Forwarded-Encrypted: i=1; AJvYcCVqtat10jH4C4IeP/KvPE5MMfrQjhHxF0JIJuJouMl9DgAnydl/uiJM7OD7V9pyic54Sr2K1CFZ6fHjS4E4@vger.kernel.org, AJvYcCVquAVfZSEpm0J5IX5PvgttwhvYOlm5CvkKaGkk+v+GDqGiIDkOayCnGiG+aCxoMEjdNfzC78km@vger.kernel.org, AJvYcCXSK/u3REfNxu+ztzyt8QE7kXapxWUloiRyZ+n6Q/iO9Yunlq77s6WU8vXzN5BNg5NZ3xDv8jWag5i+@vger.kernel.org
X-Gm-Message-State: AOJu0YzvtsDnLMceBrluE85xJkGwYjMh6Wj9+d3jZiywLPfZodubakV6
	tWhQ5/MvuncLvED2itzaaLhXoFNY//TFvWHl0Iq0/KruyIIgNE6m
X-Google-Smtp-Source: AGHT+IGpB0xrH/V27To/lXeqTaqAnf+loTtbj7zqhrRLdFwxCNZXnx6HW51bRSHSDDQRKdW0iMg6fw==
X-Received: by 2002:a05:6a21:3391:b0:1d3:418a:e42 with SMTP id adf61e73a8af0-1dc23321c26mr29010340637.10.1731475205616;
        Tue, 12 Nov 2024 21:20:05 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aaa01sm12644376b3a.100.2024.11.12.21.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:20:05 -0800 (PST)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	yclu4@nuvoton.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v2 2/3] arm64: dts: nuvoton: Add Ethernet nodes
Date: Wed, 13 Nov 2024 13:18:56 +0800
Message-Id: <20241113051857.12732-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113051857.12732-1-a0987203069@gmail.com>
References: <20241113051857.12732-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add GMAC nodes for our MA35D1 development boards:
two RGMII interfaces for SOM board, and one RGMII and one RMII
interface for IoT board.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      | 12 +++++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 10 ++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 52 +++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
index 9482bec1aa57..5cc712ae92d8 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
@@ -18,6 +18,8 @@ aliases {
 		serial12 = &uart12;
 		serial13 = &uart13;
 		serial14 = &uart14;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 	};
 
 	chosen {
@@ -126,3 +128,13 @@ &uart14 {
 	pinctrl-0 = <&pinctrl_uart14>;
 	status = "okay";
 };
+
+&gmac0 {
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&gmac1 {
+	phy-mode = "rmii";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index f6f20a17e501..08f5a7b5b507 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -18,6 +18,8 @@ aliases {
 		serial12 = &uart12;
 		serial14 = &uart14;
 		serial16 = &uart16;
+		ethernet0 = &eth0;
+		ethernet1 = &eth1;
 	};
 
 	chosen {
@@ -129,3 +131,11 @@ &uart16 {
 	pinctrl-0 = <&pinctrl_uart16>;
 	status = "okay";
 };
+
+&gmac0 {
+	status = "okay";
+};
+
+&gmac1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index e51b98f5bdce..7f7c7f8b7ad3 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -379,5 +379,57 @@ uart16: serial@40880000 {
 			clocks = <&clk UART16_GATE>;
 			status = "disabled";
 		};
+
+		gmac0: ethernet@40120000 {
+			compatible = "nuvoton,ma35d1-dwmac";
+			reg = <0x0 0x40120000 0x0 0x10000>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
+			clock-names = "stmmaceth", "ptp_ref";
+
+			nuvoton,sys = <&sys 0>;
+			resets = <&sys MA35D1_RESET_GMAC0>;
+			reset-names = "stmmaceth";
+			status = "disabled";
+
+			phy-mode = "rgmii-id";
+			phy-handle = <&eth_phy0>;
+			mdio0 {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eth_phy0: ethernet-phy@0 {
+					reg = <0>;
+				};
+			};
+		};
+
+		gmac1: ethernet@40130000 {
+			compatible = "nuvoton,ma35d1-dwmac";
+			reg = <0x0 0x40130000 0x0 0x10000>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clk EMAC1_GATE>, <&clk EPLL_DIV8>;
+			clock-names = "stmmaceth", "ptp_ref";
+
+			nuvoton,sys = <&sys 1>;
+			resets = <&sys MA35D1_RESET_GMAC1>;
+			reset-names = "stmmaceth";
+			status = "disabled";
+
+			phy-mode = "rgmii-id";
+			phy-handle = <&eth_phy1>;
+			mdio1 {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eth_phy1: ethernet-phy@1 {
+					reg = <1>;
+				};
+			};
+		};
 	};
 };
-- 
2.34.1


