Return-Path: <netdev+bounces-140098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EC09B537F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687291F240E1
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2E120CCD2;
	Tue, 29 Oct 2024 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZFBsufD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E9F20C47F;
	Tue, 29 Oct 2024 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233462; cv=none; b=PgXg8Hu2X3OTcuJAvavi5XVhxGKgG4QUpKjli7yEV7K8eax7sXBlr6/Rz6CAhJrt8e0+VpRkTr/9UuJP8/dm7HqDtVdjTfZK/z6WGqTL6+SzEdllkyN0NcBqMol6IryZnT6L8stUt5rDFMR26iXoTRQ+h4/RuphVHQPnvTOqsPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233462; c=relaxed/simple;
	bh=FW0PVbgij6XcN4CJL4xrCu0kFfOmSbmYZEZ3CxaA95I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2sP8P/8jWj5tgtXBgeeRHEXqkjm0A+R+JQI8K64fEEgzhsypjCBpmyPDPakBt9qEDcGbW+/NkGBDiQwlIplHNAocYF3TDyOJ0lipvOQst4/4VhVk4AuAGtn1U694PDrEz/g9MUd7Gq7fUH8fsfc5broMzxEYIwxdf40cdiDXdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZFBsufD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315855ec58so7085685e9.2;
        Tue, 29 Oct 2024 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233458; x=1730838258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDfFcQtwlsb8sdhUPifGiCfwGPVjyTJuTkWI2AmcsHY=;
        b=nZFBsufD+dQXq4mrd5WYkBF0xNlrdp9CkiCIgWHjglQbiR9G7CxkN6U6JDlQN9B0tf
         ZRO4tj+VSimvorYpUGIsqNgVWy893Pa4jTjIVwOrReEzukZ6R1dzBx5sQHW5yRYyAbzd
         8xv04NfLLn9IWi++T6mqBPSrFxkNyYt937ouoQuc77sLvLPSbAEFqHS8AL868ns9p5Co
         4UFx9QrMszhujp6gr+4+EENQsHy9worc3ORLlzTOhymKr8T+Foat8Yt+ThZ4HFKwY7Xw
         NwQSStS2lIfvUHkAL4eMc5KYxzCUpQA8D/ZXKA9veIYANq0D7hQ5me62PReIaSe5R/gk
         MkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233458; x=1730838258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDfFcQtwlsb8sdhUPifGiCfwGPVjyTJuTkWI2AmcsHY=;
        b=POS7obh65zthZWxOiK6r2tSZv4AHN42GIEkYX/7XZN5hJuxPNRETMgXe3s1j9NZVmF
         LDPGraHGYLkLapgyATnZcdpOJPsquWrGoiKk9VjkdzDaPJROGtcw1XgSipx9UsIX8R8j
         QfwatQ7OLq5Va1KfHXO3exfbT/pqJNSro2wC9uDI9SX0NUZYL6cfnXeyWPN1aL4Xv04A
         8S8yfLRGp2hakL0EuccilVT6mRGavldyjWoP9ogxIBwUlc8cUp+5UD0UVdq3Hh8Nic8e
         SqNwLPzLV+IPB8MtF6fB95g8d/r2tdSFyu5zzROkP7atJbRp2ttVT8F2J/rlLa8Ezyaj
         3kIA==
X-Forwarded-Encrypted: i=1; AJvYcCU+FLPxz3gkG7iUhDwyZk08nf0xiUVDfjMY1sDjAyxTuKkSybrtHLObRclwOYwENQxpl58Uz+cednv+@vger.kernel.org, AJvYcCU+dUweLhgNA6iaCD766C1YVMcPuYl8Ej0lq5R4uv8rZ/2sVht3kYmNNMzdKRHnUfnJ+XPeCj0OYLv0LvC2@vger.kernel.org, AJvYcCUNdcmu3XQgxl2SVrtvke83zDqxmPiHe2MldoZZnbdyPDgmSttGip1ayHNhZzsoOoZVu+g12+oT@vger.kernel.org
X-Gm-Message-State: AOJu0YyfMwv3tNpJgAFmB7DPT9lk5BzCLRR1eDfnU1sLkPulmwJ5ejtY
	8BUC70k+fNeEkFhY0JVCQ8PykrRcPKH4EfTjWM7HzsNRkvPzqA37
X-Google-Smtp-Source: AGHT+IFE7f+mcTgw3Qv3uKYNuqGe8n7rqs8Z6UWT4HyGHwg4bDM68NzHpmbNTH0uzMtZGXQ9VNYBUQ==
X-Received: by 2002:a05:600c:1c29:b0:431:50b9:fa81 with SMTP id 5b1f17b1804b1-4319ad368f4mr46961705e9.7.1730233458241;
        Tue, 29 Oct 2024 13:24:18 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:17 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/23] ARM: dts: socfpga: add Enclustra Mercury SA1
Date: Tue, 29 Oct 2024 20:23:41 +0000
Message-Id: <20241029202349.69442-16-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029202349.69442-1-l.rubusch@gmail.com>
References: <20241029202349.69442-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for Enclustra's Mercury SA1 SoM based on Intel Cyclone5
technology as a .dtsi file.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga/socfpga_cyclone5_mercury_sa1.dtsi | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi
new file mode 100644
index 000000000..2041088b7
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+#include "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1";
+	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		ethernet0 = &gmac1;
+	};
+
+	/* Adjusted the i2c labels to use generic base-board dtsi files for
+	 * Enclustra Arria10 and Cyclone5 SoMs.
+	 *
+	 * The set of i2c0 and i2c1 labels defined in socfpga_cyclone5.dtsi and in
+	 * socfpga_arria10.dtsi do not allow for using the same base-board .dtsi
+	 * fragments. Thus define generic labels here to match the correct i2c
+	 * bus in a generic base-board .dtsi file.
+	 */
+	soc {
+		i2c_encl: i2c@ffc04000 {
+		};
+		i2c_encl_fpga: i2c@ffc05000 {
+		};
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x40000000>; /* 1GB */
+	};
+};
+
+&osc1 {
+	clock-frequency = <50000000>;
+};
+
+&i2c_encl {
+	i2c-sda-hold-time-ns = <300>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	isl12020: rtc@6f {
+		compatible = "isil,isl12022";
+		reg = <0x6f>;
+	};
+};
+
+&i2c_encl_fpga {
+	i2c-sda-hold-time-ns = <300>;
+	status = "disabled";
+};
+
+&uart0 {
+	clock-frequency = <100000000>;
+};
+
+&mmc0 {
+	status = "okay";
+	/delete-property/ cap-mmc-highspeed;
+	/delete-property/ cap-sd-highspeed;
+};
+
+&qspi {
+	status = "okay";
+
+	flash0: flash@0 {
+		u-boot,dm-pre-reloc;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl512s", "jedec,spi-nor";
+		reg = <0>;
+
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		spi-max-frequency = <10000000>;
+
+		cdns,read-delay = <4>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partition@raw {
+			label = "Flash Raw";
+			reg = <0x0 0x4000000>;
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gmac1 {
+	status = "okay";
+	/delete-property/ mac-address;
+	phy-mode = "rgmii";
+	phy-handle = <&phy3>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy3: ethernet-phy@3 {
+			reg = <3>;
+
+			/* Add 2ns RX clock delay (1.2ns + 0.78ns)*/
+			rxc-skew-ps = <1680>;
+			rxd0-skew-ps = <420>;
+			rxd1-skew-ps = <420>;
+			rxd2-skew-ps = <420>;
+			rxd3-skew-ps = <420>;
+			rxdv-skew-ps = <420>;
+
+			/* Add 1.38ns TX clock delay (0.96ns + 0.42ns)*/
+			txc-skew-ps = <1860>;
+			txd0-skew-ps = <0>;
+			txd1-skew-ps = <0>;
+			txd2-skew-ps = <0>;
+			txd3-skew-ps = <0>;
+			txen-skew-ps = <0>;
+		};
+	};
+};
+
+&usb1 {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.25.1


