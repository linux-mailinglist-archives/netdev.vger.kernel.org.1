Return-Path: <netdev+bounces-157589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94056A0AEFD
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C701885599
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 05:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D755232360;
	Mon, 13 Jan 2025 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRNyg+0O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A1231C9D;
	Mon, 13 Jan 2025 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736747784; cv=none; b=Pml1DTlo2q1LoBUzdwX121zE2XzOZoJ3LgvwEUdFaYw7YE+0vOnXhK2wwi9lfgqV6omesIXtJH8DKkGj0AoOyVyOrf8xjvmmLi01OqQpWTLbt3tn2AoX80GoyQkh20mIbhTJjRsJJYRKFO9J8ROlagc7UJLYxd/cT1jyw407yJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736747784; c=relaxed/simple;
	bh=7QHtYiEXXd2CunAbPu2hxjeykFqPPAEToyifi5b7h/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=liqtm1oYjBtt8fmntRJyCzN1vbXlM9PB1b8dSiypbR2EIEwQZ3mhNq/BKrSAWrFJyzB/5LYQFDORHpgPe7KgBXkbgjPRfD3I3ldNJeHslkVIvAK6tIsOfQkl0Car1+PdyxQmJ1S3bUgqcjAIazap2/6Yvp19Y/oqzRv7I1Kw7hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRNyg+0O; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso5207197a91.1;
        Sun, 12 Jan 2025 21:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736747782; x=1737352582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSQkyqkgqScHqXzJErwqcEAXUJOMjLKNEmybZd7oQIk=;
        b=NRNyg+0OdDqvOZlcrNFtIBm6t0xBgtfJ7mtGp6Jvj0b42Kw+5kh4AuueRgpZxBfNuU
         grVX4uImYMVdL+n1kpLPGSakUWHFJdUqDQC+Zinoynsqh+8fJVlEIEuoDoY9c3u4uBWi
         +1FkdA0B3WQODXEEQMtTs3bFvIXiZHF8RLNQrI6+7UfOxxOr0Lbxyy012kEU0nrKkK5t
         d1JbDKaDfjC+j7R0j6varp7oertuwEcuIQqABMZzueMp+vAGbJWNWZByvFa92FSOIDFY
         H/NuHMCaEEfAiPq4nX2vFs4CMQvMEitXB4mi1PdFjpoq8FZFiZvx5ULKjC+zNJ589EsZ
         ZHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736747782; x=1737352582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSQkyqkgqScHqXzJErwqcEAXUJOMjLKNEmybZd7oQIk=;
        b=WAXMwG6odNQkZ02uVffGHalsbOhB+fikbYHWMLFm8PoVKbwdhmp+OEFwccY8eawf3z
         +bnMDiBJYMnAxty/p34EyumN1LOWpx92StXCFeh9MXRbQcn8mkyHyackAfnVthL3dwSv
         vm0H3iWuwOqFjsi6L0nG2Ie1NrwJl9gIwhi7hIuuzRnx76smIv3hzltR5PtQBzT3zj6C
         6fjfrCDT+OaHlZ+nX53mn6JE+/y6Bit+fuL2Oa1SkGXV0bWIuzcB3x3pCSvB8vU9lPen
         7t5BTukkT8lyqUNJvMZuqu//xCyzHsQtMwNsQM6gSlfvhCXehHZs7tu+tu5p4MfgWI2x
         Z8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcoF39B2Mla7b32eIQmCNSWiA+BW647A6BAzMrWdb73yzKheu8ilhIVFfuSpJsEP6CsYT98R0m@vger.kernel.org, AJvYcCV5UE+wjCfroEy5HuiIh5bMj+It1AFvxnT3t1lSZtgmzEVI3xuUzAxndfVzKxFYakBZrPSAgZ8Lt3l9@vger.kernel.org, AJvYcCWnkz1KoTYPYfAp1aV3W3l3o/c2XbR5dqTe8rtZWR+bsye9E5r7IgOrsgKJCIy5sO2A9vGzjP70TiM0SeLh@vger.kernel.org
X-Gm-Message-State: AOJu0Yysm9R5DCTcxnxplIZoEwDHR723PSuOspHcoji18bZ5FPhUHYLP
	Nb9G2evaZcfvGUfCutT4iayDLyK+b/tDlKdnCr7Eaj1Qe1LK3Qbv
X-Gm-Gg: ASbGncuTuN73JKnt/gCD4v+M/YaKo8ip0bfPb9tPZ7sYzE0SQd5ecTwxYB9ZsE3DYBF
	3DTaAgGyd/oQV1BPdFViPSkbhUH5ert2boU3O+qXXx7hyj2D6uoQTHqnBlXHAjpr0nVi8Mz5TMe
	kdyiODRjN77fxgPStVw32rTGI98sb/TTlLDuNt8e1wy6Rl9OxKKw3rDXmuraWRLXlBbfCnZ32v0
	royGviT2MPdQ2gj5rdDk6ogMTxDcSIX6E6NRvbHNnrz7lrINUrEKujCVmZvvdKEBrInVsQCEqCf
	EdJn+UT9j+DJwjJJoN6N0Q==
X-Google-Smtp-Source: AGHT+IGK0pCUlGTYvHgXQyXKxRtr0riStVYSpTVlyPsCu8rNr3XTWRKoYOATBlijrdcahHUK+OCu1w==
X-Received: by 2002:a17:90b:224a:b0:2ee:49c4:4a7c with SMTP id 98e67ed59e1d1-2f548ec8a4emr31105280a91.18.1736747782317;
        Sun, 12 Jan 2025 21:56:22 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f55942188csm7768806a91.23.2025.01.12.21.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 21:56:21 -0800 (PST)
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
Subject: [PATCH net-next v7 2/3] arm64: dts: nuvoton: Add Ethernet nodes
Date: Mon, 13 Jan 2025 13:54:33 +0800
Message-Id: <20250113055434.3377508-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113055434.3377508-1-a0987203069@gmail.com>
References: <20250113055434.3377508-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add GMAC nodes for our MA35D1 development boards:
two RGMII interfaces for SOM board, and one RGMII and one RMII interface for IoT board.

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


