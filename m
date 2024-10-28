Return-Path: <netdev+bounces-139410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA76F9B21DB
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 02:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6901C280EED
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 01:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB8912B17C;
	Mon, 28 Oct 2024 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0lkx+Nf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5B5684;
	Mon, 28 Oct 2024 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730078022; cv=none; b=FeB5lZ0GuMRm2ftSEPGfWlcXaCXXd85qgjkbGr8oeazexElZIECHFcdVyD+rn72a397Jl8Fra852eOM1kFuvF7zJ4S2Gq0SvJd6XWyrvCdJSlPP0XbHHAl/+onx7T24GBio73Tgbimzyt5M2XLupeG0lapNAVcGPQqRsYZZd3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730078022; c=relaxed/simple;
	bh=dXDziNV+kWqxHWT1Ki9ppIjBIDV3UFXWbSgHi9ecYNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YvODMlKoA0s40qG0lc5JOvxYyRyjUlAfI8IVVhzpKPPVEykVrHAv6/w0oUDnIIJXLB4m3myp59Is7UtUSH2oIoD3eduT2GQYOBfUveOkck5Zh7Z4BoSsCLXresYxTBZnwPDJfszvILXKsfAqt86V9yumSmH48+EDei2Jw1IwJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0lkx+Nf; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so2772216a12.0;
        Sun, 27 Oct 2024 18:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730078019; x=1730682819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3tCahJOmROdPw2eESwWsnhfLTfFzOuQiLcj0eIRRxE=;
        b=m0lkx+Nfo2FDpu8imhsmtftcsNxxKsCDGsNtlRRYy3nGXjZVnEfT+6aDnhXI/EElsf
         7ajQj2UIZD4x0EU3ro8gOj2fZ74Uua8PjyKZW1GaNhB7NXZ5wkoPmSg7/wHNy7wxs8PQ
         KZMdSHvxyS9SgnxGZeRVbe/lw98l0rIwdDxfWKLSjH8fUzsIaCHZuz5+BruLVK4SqrVY
         QhqpUzKCK9OKe0WQLVofPLqSxUV8nNld54b/XUL7RrGSyRjP8PUMrZb3qQL5Aqd7dGIk
         jblkUaSPWQDN7IVbfQpsKU4IjirQUEnofj+1KF0Iqk9VhkEi/Fk3UnLMiLIHESxH5H0k
         dWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730078019; x=1730682819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3tCahJOmROdPw2eESwWsnhfLTfFzOuQiLcj0eIRRxE=;
        b=eiL0oMDYMhFCcCn6tmbV06nwob3VMQ5vDQH7XyoujPE0+26x7aCYD9nOjXiaioLX+s
         4jm/DaJp1iUdyqQWtTj/vTsKbOgZdYnNi9bB4xxS+kjMmUpNHaxvxlyHT6NQ9+yMv6vv
         kRmvdHcxNrFbNTP7HgQNlSGk8nJ3l3qCdjYD0Ws2Qpjr729CV4e6B8xT8g7hg7F1aQ+K
         sVkB4s2dQiw/xfVntItgfaKRkSGCzPYNS6KXkDgqgvi7ei7quqxDLHaI68MS4HPw/4cC
         WTN9ObiHPZQqeFfSPFGJNqKmeuTJc+oUdR4k+IccB5nmFQVeKvGF2KXnvBc8+JM4eM3Q
         Durg==
X-Forwarded-Encrypted: i=1; AJvYcCUY+Lpts40rLEMAFAWh7MtGVYDhV3gCwh8E6JdilBkbQRuGpYcm3sj2fSUoE2ebvHWvj7popMxfOiMM304C@vger.kernel.org, AJvYcCWwmtdvsYLPkWTaukCabJZFQGuAf7Qtg1OpWfxQbP0PnwTfHxkQROX0VJVdHHkQ8DtkDgl2JfWAGFU7@vger.kernel.org, AJvYcCXWVgbTXjUC3Gcw0beSVBeiQmQVmMMgh0pph/4tU2exGuuUBQmeLWxM56DuhGVwm/oQn2GFRmUK@vger.kernel.org
X-Gm-Message-State: AOJu0YyxrbceXwvF3i70D8pM/iZj4BtyQVUBkKKBMQ2cfasPZ9BtQ3MZ
	S+00fk6PGlAKUgZTcWWXfFqPRDP5M8KuJPgAECQ2DjGJx60VCTFy
X-Google-Smtp-Source: AGHT+IEn22qT3aAgfP2GIkF4DIPGzct889HLqTlXcqnHoA/L+gK2jDOatquPmlzkbeGD1c41qaA4Wg==
X-Received: by 2002:a05:6a20:c997:b0:1d9:4639:396b with SMTP id adf61e73a8af0-1d9a83c186bmr9642710637.11.1730078019112;
        Sun, 27 Oct 2024 18:13:39 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72058052be4sm4744556b3a.142.2024.10.27.18.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 18:13:38 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Richard Cochran <richardcochran@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Liu Gui <kenneth.liu@sophgo.com>,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] riscv: dts: sophgo: Add ethernet configuration for cv18xx
Date: Mon, 28 Oct 2024 09:13:12 +0800
Message-ID: <20241028011312.274938-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT configuration for ethernet controller for cv18xx SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../boot/dts/sophgo/cv1812h-huashan-pi.dts    |  4 ++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 49 +++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
index 26b57e15adc1..a0acae675a82 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
@@ -55,6 +55,10 @@ &emmc {
 	non-removable;
 };
 
+&gmac0 {
+	status = "okay";
+};
+
 &sdhci0 {
 	status = "okay";
 	bus-width = <4>;
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index c18822ec849f..50933e5b4c75 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -210,6 +210,55 @@ i2c4: i2c@4040000 {
 			status = "disabled";
 		};
 
+		gmac0: ethernet@4070000 {
+			compatible = "snps,dwmac-3.70a";
+			reg = <0x04070000 0x10000>;
+			clocks = <&clk CLK_AXI4_ETH0>, <&clk CLK_ETH0_500M>;
+			clock-names = "stmmaceth", "ptp_ref";
+			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			phy-handle = <&phy0>;
+			phy-mode = "rmii";
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
+			mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				phy0: phy@0 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <0>;
+				};
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
2.47.0


