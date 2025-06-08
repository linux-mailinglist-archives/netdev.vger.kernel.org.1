Return-Path: <netdev+bounces-195595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EBEAD15C0
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F878188728C
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 23:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B827267F57;
	Sun,  8 Jun 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKZuIMTh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3D267389;
	Sun,  8 Jun 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749425395; cv=none; b=uB49m1vSwPJ4INGO7LubSWiZ6IC4223f1s0jjygsJFeozuWxrk689lGNNYefiy+8AA7wjNzy7bOgE0OjF+4ABmt3GCRLMOA99+jnllRmbDEDzjhK55TfEtP1JZhttm3T+Jo1oKR+zLddW8KJkATik9wrqCvoe9jrt3GQrY1B7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749425395; c=relaxed/simple;
	bh=IPKyQjpwy+vLXCBDiOQVfNpLKtpiZoWJuJN0aCh8Vw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rauF5JSqQeYE+mufQ65jkFcWUZIjnBH9PvQdJNKJOgICzGX6Mgb9/nOPNrM7avCWUKUOKJ/a19+iS5HFQgkWEA8TcFlq4YZnRMeaJzgGqacPhrahP1F7dSwkGv+gdeZB80RLYxI4M4W7vSKMqBgp9Dy6GpFMuS7kLqlxp+NqJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKZuIMTh; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a5903bceffso48356001cf.3;
        Sun, 08 Jun 2025 16:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749425392; x=1750030192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e01iukVTtzr1W38d9A787H6idtfIXQJY27IM4e3no+o=;
        b=FKZuIMThs8txO2LF1P7Gpb59/NiN+tCHO1W3gGaLHxonzJfw9sv+CokAy0S9Hg6uKn
         M7EdiHl66BOXwFXGXAGbBhy2I60jJptRC3bHQkseT4hecHzwHWuRackt+AGaf9yJCAy4
         HjKvVD/YLSAm972SjOb5q5OymTtzxKgOfcCahVceP00AvY7JO8ytMoRVphWV2qtmAKFk
         GQwkvBhBuAjrVuUVIJLcAuKe3zfhe/UoiHe4vyZDiUKTZRmH4jkROwnBYPinyqvGa6CH
         F/qzWNrTu+SW3Ck5S+JXuqQ+GdflIb/bPjI8UunK07ReVvHQOqwiM0uXHkp+MsJRsZHs
         KRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749425392; x=1750030192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e01iukVTtzr1W38d9A787H6idtfIXQJY27IM4e3no+o=;
        b=VvDwb+6K/93YgJqh0MHYgkvKr2OjCISEzIU2dr1B+shl7IS+jUo+o35efP5PkpJWH0
         Izt98qjmYvCemW54yo6EiJA8DbPA2apG3pRCU5OI7NMCsUvNXlhOlSfnc1Td6VQeEB+a
         h7BED6s8jT+pS0Fa/pkkk6DsXLqBqmg1nbySkbZTWCqO787c3aTPSYdN6MpFrX7Ap6vY
         thiZmpeJVhAPgZFCXX4ezkxVOd2twVpMoiIXWjIS6FfbpXkMUfgUk4bwRdpQ14+iY0qm
         ZEo/ize23/kQWtvcAh4mxRpGk+NxrnOdTyEueXtaM3J7YgGars/YS9CicTXprVFxBC5C
         rwNg==
X-Forwarded-Encrypted: i=1; AJvYcCUwET+5HauH2eEsAFKSfEkwQiytaqqj9Qjyp/HR+/OjW+9idMYC87sMdsVf6eWuenXfmC3FKN2quyY6FGal@vger.kernel.org, AJvYcCVkyqcW0PyBVbbi2RTahQ+575yyKq21OgeY9y+wYWZpixGoJomGAebEknl0f2Ksg5YUtBDFLFuwQNRe@vger.kernel.org, AJvYcCWK4i1QS8tU0rtTgNeDEOwgaZsO6ZnwpywVG5YgpLPdH5DgdoPHPvM7n22HJlBNXEIa9U9ogMrr@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUJsYsbi4vpEAIB2FBFmekz34+6siZE5MXEX4J8o7sORKc5rq
	bOYJ99ob0X2Zi42CJmkR2mRYWtIOZ7VxQVDdUXAcVaDfFjYXOtsy/wDf
X-Gm-Gg: ASbGncvG+9cFK1UAGC20ipTbs4LpyHOk3cki+pH0zhJtFMFieyWQFB6JzzpUvGtHZZs
	Jr7O0xhXjaauOSPlGHeNDJq6ltOIAth/bWbRxza1EkuPsSCNKp6metvpa9ZS9fY4w3in+K6RksH
	aZCAmJUp1Qdj79V/tPyZ/vf2C0IhxHwlwIPL4gO7i/6c1ey/AnjjEEsERaNJVX2B3Ci3opR39Ob
	5X9Jm6+KyjYBPsDYHIe/gv4iakkNoKCMWDVcbtEeKCweEgu5SHsNpLTbi+vRrHgiqoO6WjepmNd
	zu+2MBpZt0EalhGC+ioGjZMWj7RPh5VRD7N0FA==
X-Google-Smtp-Source: AGHT+IHI4CDrPXFr0/NZvPWIdM0m0CmSVQ7zO1EJkq9vwOjsqhwAlmzwrnYunhr2lKOAZxXLpMJWNQ==
X-Received: by 2002:ad4:5ced:0:b0:6e8:fe16:4d44 with SMTP id 6a1803df08f44-6fb08fcc15bmr200667496d6.31.1749425392442;
        Sun, 08 Jun 2025 16:29:52 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09aba066sm44196886d6.17.2025.06.08.16.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 16:29:52 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Longbin Li <looong.bin@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 03/11] riscv: dts: sophgo: sg2044: Add GPIO device
Date: Mon,  9 Jun 2025 07:28:27 +0800
Message-ID: <20250608232836.784737-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608232836.784737-1-inochiama@gmail.com>
References: <20250608232836.784737-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO controller is a standard Synopsys IP, which is already
supported by the kernel.

Add GPIO DT node for SG2044 SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2044.dtsi | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index d21a59948186..70d1096f959f 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/sophgo,sg2044-pll.h>
 #include <dt-bindings/clock/sophgo,sg2044-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 
 #include "sg2044-cpus.dtsi"
 #include "sg2044-reset.h"
@@ -90,6 +91,75 @@ uart3: serial@7030003000 {
 			status = "disabled";
 		};
 
+		gpio0: gpio@7040009000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x70 0x40009000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clk CLK_GATE_APB_GPIO>,
+				 <&clk CLK_GATE_GPIO_DB>;
+			clock-names = "bus", "db";
+			resets = <&rst RST_GPIO0>;
+
+			porta: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&intc>;
+				interrupts = <26 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio1: gpio@704000a000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x70 0x4000a000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clk CLK_GATE_APB_GPIO>,
+				 <&clk CLK_GATE_GPIO_DB>;
+			clock-names = "bus", "db";
+			resets = <&rst RST_GPIO1>;
+
+			portb: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&intc>;
+				interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio2: gpio@704000b000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x70 0x4000b000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clk CLK_GATE_APB_GPIO>,
+				 <&clk CLK_GATE_GPIO_DB>;
+			clock-names = "bus", "db";
+			resets = <&rst RST_GPIO2>;
+
+			portc: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&intc>;
+				interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		syscon: syscon@7050000000 {
 			compatible = "sophgo,sg2044-top-syscon", "syscon";
 			reg = <0x70 0x50000000 0x0 0x1000>;
-- 
2.49.0


