Return-Path: <netdev+bounces-162008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C89A2521C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 06:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C89B3A46DC
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 05:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C164F1CDFCE;
	Mon,  3 Feb 2025 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHG4ViFe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223311922F6;
	Mon,  3 Feb 2025 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738561434; cv=none; b=AOtlaUOSdFMNgKErHP4Hncr7uQ7iFLbxSp5zV/EakucjtGniOhXc5Xaz1dc/PBLzKpxHD8tARGzrnzcyXxtoCFU6WEFkbQ2PwwAqhGARTRVKurQUekFr4FtXB1XxWp9pYy3Z0aoYlynrhnpu4MGPiDc2D4PA0XREzVGzIBZLf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738561434; c=relaxed/simple;
	bh=IDLJJ2YOHF1ML++m2NbewV6g5gr8AafZHHoTDkPCGUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DxTectu0mfJN0WilYx4l6oA/ZM5q7221hPt4sxOZdHHPYI3EB20mdqZlRgXEUWUk4q2CsTYtoQH8cLTW5QSUR54E5WKcjcZ9+v3+ZJswn7kGj1vqBojJTZxJohkqXgY6CnAiDptqaKiVXCtv93FXcVSA3yW0fGLZUc1251DN11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHG4ViFe; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so5023048a91.2;
        Sun, 02 Feb 2025 21:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738561432; x=1739166232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31XzgfEM+1LFHGxho2u9u4JYE7XQW6zgDynf3Dbgkps=;
        b=BHG4ViFewGO7KkpA2TPxupRSzh20th8Op4ioDYJz5u0S+GV3bl/D4M6JWQBVq/XrWJ
         a/22zU/3E0hqKyZz3qSk6KZqvI39+T78ot2YZaCetsrlPgJug/0KU8QGWswKiK1UBRVy
         VTj+pfFyEHMX7OgY6eGo4NzF9T2oS90mq5+FmIM2JebRjKbTU7fuRr1vJccikeSVldpd
         PVUU8qiGHg6UUee4ueTsE8YNygmlk2AFJ3SRNBFO8Ohl4ZnSY6t+5m8xjSagEsbQMwjI
         Tl6hggeDsUej7OUnAig+WHkiGf8dsMQRc+9ODZvh7ajR8WbNAyN1UyJdXIsJpfv1Q19h
         pX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738561432; x=1739166232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31XzgfEM+1LFHGxho2u9u4JYE7XQW6zgDynf3Dbgkps=;
        b=uLVWH7spID8t3s3ldcAPVkc5lQWdZn8s7GPVBCH58xd+0+Dmf5WxRuvhuhbAddh+sw
         lkigfWSVK3htRadEreNZI/x5IDrs0P8mp3KRMZonSBfR3WB52Isjnn68DrpRirzr6a5r
         PAiLi+Pw+h1cvlHQ8tYJUHmW93EbMKF0yjRuNJ65Xx6x4H9uUdVjiVuNf2z6YokaJPYP
         AjkMfDQPMBmxTvJ6BzO/7viNevBEd+KSXg4t3eBLGYj6dhZ436FPt+CBz9kY8MUuTy6L
         Xov2tu35oWobPzI1g7h5w/p80cjrOMpPflD/phuV5WnicYRoORDbFjJtNwwbg/R1sIBw
         WOrw==
X-Forwarded-Encrypted: i=1; AJvYcCUNnZRwtMv1JyWhbK4PLYGlxeYLQ6lpt7iIcHDBRXQyaAY5r8pVDxCsXgsRYOGrr1w96lYB6+GHyeZz8h6R@vger.kernel.org, AJvYcCX6ZafY31BFhNXt1Pr9/+77vegoiEkTqdo/Gdd4xtr98uERq0VNW3BVLmTjJKUQlJG3+QyswswV@vger.kernel.org, AJvYcCXABbjsDGifSk1Dc7O0NmijOD2FX0scZ9N7Vsd42eXuwL5Qj3VGrt2qo66vFqsFv+RL7keW1DlaFX4I@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Eke0UVryqY31J93Hyr8EjOKvZHlQGQ/wwp85dRGQlH7IViFB
	l8EtWquVKgKdlkEMChb7k63FRuQZAbnISPMv8O3MAtjEh6iwhvFh
X-Gm-Gg: ASbGncuHzh9jYtm/dhX6vkCnRFD4wXfhzdSMYPLAfyQclWK7i29u8YMzaN2FEUyg8QV
	3R1obY0jEN9sOfs1hMoggv+aKa5fAm36FZWM6S2f5NowICvfmXTT6olopeMJRJNT1ZgTbmiIaPC
	UvuUT3IHg9ZUdTxJXQ2Axa6bfByT1zbiXzTRWU+4G39Iy1+rSliL6ifKfIMWgLpoiaKXS9TzNJq
	2pKHKNo3dQ1dBfS63lrMFmOCHajC00n7ARDNb2f31nP234k8alHasinLEFR9wORmLHUg5yr/32g
	ofO0lENy7qm8TiLRF2pFwPPPTRjb91w9pkzU4VNZrY3fpbGrphJ0AV8j
X-Google-Smtp-Source: AGHT+IEebl6qnAhUV7DcuC2+Gaci6mLgBlvTtBDmEY8dNeLsOpTRgjxFkU8HCj/XYZqe5f2xfVUW6w==
X-Received: by 2002:a17:90b:3a4b:b0:2ee:bbd8:2b9d with SMTP id 98e67ed59e1d1-2f83ac87b59mr25632915a91.34.1738561432261;
        Sun, 02 Feb 2025 21:43:52 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea5fesm66894555ad.132.2025.02.02.21.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 21:43:52 -0800 (PST)
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
	peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH net-next v8 2/3] arm64: dts: nuvoton: Add Ethernet nodes
Date: Mon,  3 Feb 2025 13:41:59 +0800
Message-Id: <20250203054200.21977-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203054200.21977-1-a0987203069@gmail.com>
References: <20250203054200.21977-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add GMAC nodes for our MA35D1 development boards:
two RGMII interfaces for SOM board, and one RGMII
and one RMII interface for IoT board.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      | 12 +++++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 10 ++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 54 +++++++++++++++++++
 3 files changed, 76 insertions(+)

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
index f6f20a17e501..1d9ac350a1f1 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -18,6 +18,8 @@ aliases {
 		serial12 = &uart12;
 		serial14 = &uart14;
 		serial16 = &uart16;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
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
index e51b98f5bdce..89712e262ee6 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -379,5 +379,59 @@ uart16: serial@40880000 {
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
+
+			phy-mode = "rgmii-id";
+			phy-handle = <&eth_phy0>;
+			status = "disabled";
+
+			mdio0: mdio {
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
+
+			phy-mode = "rgmii-id";
+			phy-handle = <&eth_phy1>;
+			status = "disabled";
+
+			mdio1: mdio {
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


