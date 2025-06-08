Return-Path: <netdev+bounces-195594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB44AD15BD
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA77F168D29
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 23:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1103C267B12;
	Sun,  8 Jun 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My1q1oC3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C02267AF8;
	Sun,  8 Jun 2025 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749425392; cv=none; b=LUuzu37MJUuIcOhacc2lzID/UIZywQLYI7SkdUmJkbt/I5Jh+IYtlOLpPO8wYnXbgPGQxF3x5mwoJtqOOW2m8iwaJPDrzzkjxJmwkf1oNpXeGrSznSOj09P4nmCHSW6ig7ZDYo7oT5Bp9RI6kAYJl6z/VHvanvfjIAB4kTPBpzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749425392; c=relaxed/simple;
	bh=P6GnW41nXG1w+GDEwxNGovllpbTbaAJ2B/IEZM6cIDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqRa6ICEbdb0Py3bGVQY/I8jw4CfRALLeIBxv7u1wEkvDMtGemqLPOxb1l17ycCBhpt/j34gAL029iM7crwQndxLCib4xIcmXMrL/IjHGgJ6VtaFOQUJseI0CNzTs/3Qa9vWE1/xnHaP1B0+hjgY53NI7Bx56lzOvcOPKVpK+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=My1q1oC3; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d20f799fe9so355785485a.2;
        Sun, 08 Jun 2025 16:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749425389; x=1750030189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRmOcfIym+jztFj2oNw/dbYG2NDcS8k8iQRMon2PBA8=;
        b=My1q1oC3XD7qeHXgc08BhMcqaohkJw3rfqvL0C2YyDWyuv/3ihUUiIyKeJuzLWLRSN
         H8Ux63lw78StsHGlt1EcOz2C5k0G4+In55QGbAk3Dy6FcgGkyVrzs6/VATOU06lfItn3
         jF6ZdM5/RD8sAU+po+bTKHx/8R05U19m2ZY2CHlqbFAL8ezyVKtKiwHUFcpwbAhINXWO
         WokFinIrMu7d+rMsZEQUqdPxkp//cFSOptIWaasdH3nqdIFCmFunB/+xYq31Kxavc/W6
         Ir/1ho9spj5hUQ9iCipkw39lF6Rs+psxD8r+M68RlmsOnFR/vijuLCb79EYZJhum7Qhz
         5sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749425389; x=1750030189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRmOcfIym+jztFj2oNw/dbYG2NDcS8k8iQRMon2PBA8=;
        b=Yp1n9nI5v9dlw/bGe173cGGLJpKHAebj2QVvyX4w4Q/VdkYNrMNSTvXSXE23utYEep
         TRpmt15mhLMWjCZl9cWdIAvNkdXhiGi1RLgK8mr/4d+53qgJb8iysCOSMcihb3JvyloS
         7zODrYzLo/BBtmSNIeJIbKY21SIC0vP/qXPpjlw+KV3JdYbNnQ9zF8KCASuvFKkP6MuZ
         +QjVBUpfS8J44dLruOLhP1t3HLtTXvFSIlP1zopVOwwYVNSiqd0xBhy5RDRkaEiooY4B
         PoopA/zxtm35ha3/2N8poJF1GeUPV28O26KdD8DdBT7WIqsDuSENKWDt+dJN65sdORVP
         /Ujg==
X-Forwarded-Encrypted: i=1; AJvYcCUfcW34FCucGClg5m2x2uKFUj4APKKJRccaygOPSSXK9P6tc+iLzqkoD41E6oZ68mEemXuE+46ZTtLBnhcS@vger.kernel.org, AJvYcCWWn3Ntdu6EEBCJzAT5ipMJZvxnwOEWBxnJeJ8135io7b0yX1oxkfWfLWiuyFTuHaXIxhdxR3up@vger.kernel.org, AJvYcCXEXyKLdsKG3C67080Th62Z+Nu6xPnEEudlIQxjBHmXat9uwQYj+Jv1JqVkOuIT9I92MFscEClR7uoB@vger.kernel.org
X-Gm-Message-State: AOJu0YyWleUS7bqr0JRFnP+pSKX72g3ZC2kkfV37IF+5G+2WKZqlhQMZ
	x7KiBQLkCVDBcCXJaDmu1n9UGsCqK0AjxVRe2Ln5IdEuQH8RwNRtUSbY
X-Gm-Gg: ASbGncsmBsJPz/NeOZv9KArSDuzhu4VJE8mhlUN1hwUDd7bCYrE4sUBP7CvZY5Bw/U5
	RlM/6w7i8c/4qj4rQHrrFdUQx/yDs1hkZa43txYpkiwKrFiCybR3N5jVt2kwgdec0O435ldA2Bc
	+5G9qLqygaUWoF60/NkUqRRVSbFzVZEne2KVjvd27qUCtom95StY1xOUZ8mui1LyJpbaHV1+haC
	3VCaKPM3b4cpv7AKIjqRRHnfyqw6a7M/Spb5eHYZy14osSCzaPSV3X74vQIcXpYjn+Cpr+OnniX
	+1Nd4hLQg6j4GW4fTPyPhoCgvOdVS1qdvBnK5Q==
X-Google-Smtp-Source: AGHT+IE5/Gz8qqya3fci5rtlQe9R/OPJWsD97+s3Z1RsEKIEirjoWmQf9uF/h0NVyozgqLtYvjZHjg==
X-Received: by 2002:a05:620a:4154:b0:7cd:c6:40f3 with SMTP id af79cd13be357-7d22985c859mr1849137885a.2.1749425389266;
        Sun, 08 Jun 2025 16:29:49 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09b2abfcsm43841216d6.104.2025.06.08.16.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 16:29:48 -0700 (PDT)
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
Subject: [PATCH 02/11] riscv: dts: sophgo: sg2044: Add clock controller device
Date: Mon,  9 Jun 2025 07:28:26 +0800
Message-ID: <20250608232836.784737-3-inochiama@gmail.com>
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

Add clock controller and pll clock node for sg2044.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2044.dtsi | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index a0c13d8d26af..d21a59948186 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -3,6 +3,8 @@
  * Copyright (C) 2025 Inochi Amaoto <inochiama@gmail.com>
  */
 
+#include <dt-bindings/clock/sophgo,sg2044-pll.h>
+#include <dt-bindings/clock/sophgo,sg2044-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 #include "sg2044-cpus.dtsi"
@@ -32,6 +34,9 @@ uart0: serial@7030000000 {
 			compatible = "sophgo,sg2044-uart", "snps,dw-apb-uart";
 			reg = <0x70 0x30000000 0x0 0x1000>;
 			clock-frequency = <500000000>;
+			clocks = <&clk CLK_GATE_UART_500M>,
+				 <&clk CLK_GATE_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupt-parent = <&intc>;
 			interrupts = <41 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -44,6 +49,9 @@ uart1: serial@7030001000 {
 			compatible = "sophgo,sg2044-uart", "snps,dw-apb-uart";
 			reg = <0x70 0x30001000 0x0 0x1000>;
 			clock-frequency = <500000000>;
+			clocks = <&clk CLK_GATE_UART_500M>,
+				 <&clk CLK_GATE_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupt-parent = <&intc>;
 			interrupts = <42 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -56,6 +64,9 @@ uart2: serial@7030002000 {
 			compatible = "sophgo,sg2044-uart", "snps,dw-apb-uart";
 			reg = <0x70 0x30002000 0x0 0x1000>;
 			clock-frequency = <500000000>;
+			clocks = <&clk CLK_GATE_UART_500M>,
+				 <&clk CLK_GATE_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupt-parent = <&intc>;
 			interrupts = <43 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -68,6 +79,9 @@ uart3: serial@7030003000 {
 			compatible = "sophgo,sg2044-uart", "snps,dw-apb-uart";
 			reg = <0x70 0x30003000 0x0 0x1000>;
 			clock-frequency = <500000000>;
+			clocks = <&clk CLK_GATE_UART_500M>,
+				 <&clk CLK_GATE_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupt-parent = <&intc>;
 			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -83,6 +97,26 @@ syscon: syscon@7050000000 {
 			clocks = <&osc>;
 		};
 
+		clk: clock-controller@7050002000 {
+			compatible = "sophgo,sg2044-clk";
+			reg = <0x70 0x50002000 0x0 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&syscon CLK_FPLL0>, <&syscon CLK_FPLL1>,
+				 <&syscon CLK_FPLL2>, <&syscon CLK_DPLL0>,
+				 <&syscon CLK_DPLL1>, <&syscon CLK_DPLL2>,
+				 <&syscon CLK_DPLL3>, <&syscon CLK_DPLL4>,
+				 <&syscon CLK_DPLL5>, <&syscon CLK_DPLL6>,
+				 <&syscon CLK_DPLL7>, <&syscon CLK_MPLL0>,
+				 <&syscon CLK_MPLL1>, <&syscon CLK_MPLL2>,
+				 <&syscon CLK_MPLL3>, <&syscon CLK_MPLL4>,
+				 <&syscon CLK_MPLL5>;
+			clock-names = "fpll0", "fpll1", "fpll2", "dpll0",
+				      "dpll1", "dpll2", "dpll3", "dpll4",
+				      "dpll5", "dpll6", "dpll7", "mpll0",
+				      "mpll1", "mpll2", "mpll3", "mpll4",
+				      "mpll5";
+		};
+
 		rst: reset-controller@7050003000 {
 			compatible = "sophgo,sg2044-reset",
 				     "sophgo,sg2042-reset";
-- 
2.49.0


