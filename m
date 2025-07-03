Return-Path: <netdev+bounces-203599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36088AF67D7
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 04:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BED7173476
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 02:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E881F582C;
	Thu,  3 Jul 2025 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKTkvG4I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C8B1DDC22;
	Thu,  3 Jul 2025 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508985; cv=none; b=qtyxf6+tim4Q5gXcj+dPezduuq9DmjadTXE/YlMhzVwqDDu/crOyfkmsdXc9Y7WRBNAQHNCElI75PCKzjcV1eNThoskSZdfr61ZlQQkHtA8JbfBNyGhQCo+vW+q+Lb56750fmBGK6Q2WbxQRefmMnyMv731oN0cMpGsDfQZ+jX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508985; c=relaxed/simple;
	bh=28w6W3M5RoMtkXpLoM2r5jUmQHSYfM+9m3hFwUL1h6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nd4qA55C1tPCQxS8941PuC7N+g8n4qGhTYg7oajffjudgiwd2lGzfAnDs5iYGUUHrZEav91IPP4BoV1XNaB1TJGdLqQRX4uT1Z+Qo3UgyvXCcZyvpbzgF6n1MqN4/rcGmt4h+MUvJlUqKCr0Y+9Dpfe/yZYytelt++EFFMatAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKTkvG4I; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7490cb9a892so5263188b3a.0;
        Wed, 02 Jul 2025 19:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751508984; x=1752113784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G8EsFLPHcydSdSrFsRKcmtgOEiF67NnihrfLuZNDOk=;
        b=BKTkvG4IaUr0MtSywrW8TjcRFkE5hZmsou+LkvJR0HBtHf5YWl2v5Uryhq7Fv0OKOY
         aexTLoRINZKINwawpgUfNKjxOL3fLOUXVcA8UhiuJ8M0X0JneTsStt5VrIzClT6RE6Th
         9gns+YMZ9fsMYE+1FnCqY91+7sMEPy5sM86j2fP6l26Db6MBmCjyXNFEANM79+lNMvPx
         JBUaWKN3cu2I+hYrL8/2ER9K+4ofx6aQstMZfvwrvG2N8nqVWXVsI1T7NsV0008w+5lO
         vZVm8XEg7LjXfRNbrIl3AYPuO+12OncuA+KSgNanscYo2rLlVnRO9VkfQGSVG1z5G4Hx
         0Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751508984; x=1752113784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9G8EsFLPHcydSdSrFsRKcmtgOEiF67NnihrfLuZNDOk=;
        b=UVd/h7xiz+ok00w0aDhNbSqc/w737zw4MiJ243PT2T8h0NrTdepdDoG1zX1jvAHcUM
         qEgAf81stpsqC9P8N4dr6FzroIiqhWsjLxgPr+RNndAlgTogwhzr3zjHorriyZm8xVnC
         /lAydxYPon/dFuI9fH+mDbo9HnyleJRP/Hjjdo4aqE9jG9eSnsclrKHks5q7HcueQJg1
         NqbUcjxCSil+x9jHhfqi7vPPg8o+8CdQGXqibiRC1IuYaXPjbBgufIBVc/zSw/Em4Zjm
         eu9fa0LmdhqBMtrJFr9dv80auDXwT4OWijFogelfhCslD3wsgh7sdQQ70EEc9NPgRBW5
         NX6A==
X-Forwarded-Encrypted: i=1; AJvYcCX3gSNa0AAwKkWMNNzhrubdhfryPItAY01Cznn8wE+m0/LwtvzWjINEd7ubQdI3cXK985pceZuNRAIemQ8=@vger.kernel.org, AJvYcCXru9r5TxCuDQrCrcVI4r6zbRUZNeCEG9yMK7yeyXnYjZQVYN1KEBTj8SW4LqVCEC7C0/sFgecF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+nUrRKKNVQf3ybe/jNUJmZ+Bq0rSKB4vee7Akib4zKIFpZiTt
	nIa7tYOZHhPBzHMzJXlCs+U750i7RchwiDxS3RFKo0Vc8m2TSd9J0BA5
X-Gm-Gg: ASbGnctMB8N6DZ80FZgCv2Ve4uExcqBr8tGrNKRT/wSM+zn4KOoc5lGPSj3CYsjvvV5
	c8Rt6de9HA0MlQ4zBdhdX57btCkj0IXgZ3nmzF+W4IIB5ywZV45KxORAzTKdAIKnKEykzwXfqPh
	onhszoAfMQ2FycxZiPleUWsvzKf2ag6Oo5eZuOxFHm9S8YKK/mJ9wW7rHZr8jOU/OS9FH7q/3nC
	5LOfAzhM+Uy+7QbsxJDM4SfXcZPLKSBnPsy/K/Mx2ZwXFCYgwup75Kj7vkZLlssJOwu9xa3/tag
	W9/OaAEpwZPz68/c4C5TItBJUzV3Az+5HU8BcWTDpA1A0vlsqsIkW6w9I5uK2g==
X-Google-Smtp-Source: AGHT+IEpfvICwsWVQEs2aV82TjO8nSl/wr+6JnI2pnLczgYzsPIqjZfU+7/+o1SmEX0puDeKxR7JHg==
X-Received: by 2002:a05:6a20:7fa5:b0:220:af86:7e01 with SMTP id adf61e73a8af0-2240c6a1815mr2739797637.29.1751508983597;
        Wed, 02 Jul 2025 19:16:23 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af57df5ddsm16245401b3a.127.2025.07.02.19.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 19:16:23 -0700 (PDT)
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
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Ze Huang <huangze@whut.edu.cn>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 1/3] riscv: dts: sophgo: Add ethernet device for cv18xx
Date: Thu,  3 Jul 2025 10:15:56 +0800
Message-ID: <20250703021600.125550-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703021600.125550-1-inochiama@gmail.com>
References: <20250703021600.125550-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ethernet controller device node for cv18xx SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index e91bb512b099..7eecc67f896e 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -189,6 +189,50 @@ i2c4: i2c@4040000 {
 			status = "disabled";
 		};
 
+		gmac0: ethernet@4070000 {
+			compatible = "sophgo,cv1800b-dwmac", "snps,dwmac-3.70a";
+			reg = <0x04070000 0x10000>;
+			clocks = <&clk CLK_AXI4_ETH0>, <&clk CLK_ETH0_500M>;
+			clock-names = "stmmaceth", "ptp_ref";
+			interrupts = <SOC_PERIPHERAL_IRQ(15) IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&rst RST_ETH0>;
+			reset-names = "stmmaceth";
+			rx-fifo-depth = <8192>;
+			tx-fifo-depth = <8192>;
+			snps,multicast-filter-bins = <0>;
+			snps,perfect-filter-entries = <1>;
+			snps,aal;
+			snps,txpbl = <8>;
+			snps,rxpbl = <8>;
+			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
+			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
+			snps,axi-config = <&gmac0_stmmac_axi_setup>;
+			status = "disabled";
+
+			gmac0_mdio: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			gmac0_mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <1>;
+				queue0 {};
+			};
+
+			gmac0_mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <1>;
+				queue0 {};
+			};
+
+			gmac0_stmmac_axi_setup: stmmac-axi-config {
+				snps,blen = <16 8 4 0 0 0 0>;
+				snps,rd_osr_lmt = <2>;
+				snps,wr_osr_lmt = <1>;
+			};
+		};
+
 		uart0: serial@4140000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04140000 0x100>;
-- 
2.50.0


