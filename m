Return-Path: <netdev+bounces-140100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC3F9B538C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9CF1C22BD7
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C37A20E016;
	Tue, 29 Oct 2024 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ve/qalet"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F020B217;
	Tue, 29 Oct 2024 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233466; cv=none; b=eDwDnwc5Y4IK7VTEipyqvwfsYf+toMJB+LaKb1FvdHAS9Ckxz14Apq1+R2XBmJZbut866dTk3+gqd57taQFibE+IUIn9IC1mOfjmUD/ZH9DwTpk1YsvfXWMLSt+lFyFxkA3044NZZwzddKc6aWGXQjBJu9DO+PfDPv7UspY0ThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233466; c=relaxed/simple;
	bh=6tG3oG/RTIx1QWgVM1BQmjZAJm6du+mpOCVm6KPBVUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5csjFTN0DmwSjOMpO3FmANkX6A3oAxl6WAFbx6x9HR/wTmrYDjZzQivt4CHOHp/Ey1DmhP1lKxKZq0M9huOWjOvAX5as/kDRPx0CzxmsIzG6DBC4r8bD8kPE+ZUP8tWjk43uDJwuTdGH+DMD3yp8AR2vuHAUTcE6vZ7BExT4H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ve/qalet; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4ee8d15aso611392f8f.2;
        Tue, 29 Oct 2024 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233462; x=1730838262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4xgLdJ/zq3TT39TRO4Bl0cM7YUtWPRkmL+0elQ1sU4=;
        b=Ve/qaletTVS8HBdNjS0gQtPrEydcJMVgmXBXvKOdM9sWqHmlBT6gfM9X/jFvmuEN5N
         ldWyYCgefbWr75YlQ1UaAQ10863VEYcL8IVbRm7Cv6qsuxRuBOMtQe/shuDpl9Ebrb4k
         EPJJawvAZqRBoHZriLeoIx1RoYdTfU+w2W2lIYooDCDWYt7AefvFbkCyfMHOLFMd9X2c
         dRQ/lukL4Pi2zUV2oDZy6PdEAUg1h8QcojR/aq/8mRGT9AYX79TQfHYpBKAeXLBgjtek
         5glvjlvlNyTW6EJeiQ4V+LRdl0+L2QWvSt6qTHecC/cE+0z78Gkhu91m0o6lFRMyd9Q8
         ix1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233462; x=1730838262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4xgLdJ/zq3TT39TRO4Bl0cM7YUtWPRkmL+0elQ1sU4=;
        b=Q4LMTksi2W6QVGTyzB1H/4JFtLR7siIjbPvS39+hf8o9HID7Djr7DMEGVRng9dleHK
         0sS8vIoOvfzgprtn52DaJ8UXI3jCIIPDBWubRkN2m0fgmDnGx9DnzkS5GFXMAie4Id3d
         DZjwuGQjSVvepkIK8G7sN2WL8gUVzigdUPnN9Dg6U07ItJcFTTmNT1eg9F3At4F+KEdX
         l3SbJ0jxDSncvulykDA4rJKaN6laCRR0kdFS5sOvYjh3xqEkZYgOSye223bUltw+oNxX
         LBqGZ3S/Xqy/CL3s02+W/3tgSHCDUE1HYxN1I3+Z7xkppAzuJJYpy++nV44Kot38fe51
         UalA==
X-Forwarded-Encrypted: i=1; AJvYcCWpBN26xYWyAEMsut04dsdu1EP6l5vUDU+AwcIkw9nTGwDgWCVDG5Kd7QCf7beYyVSCfrJHAE8Joaw4@vger.kernel.org, AJvYcCXGuXKiqBNzbnpzXJzyfIby/8xGFZsQnum5BBtWUCKyqq0mnYDjfQua3/fEJ8stP9qOTVa+UzLx@vger.kernel.org, AJvYcCXMjsTb2SZpmzwkxsitqT1pVfZcY+K7asCi2oThN3ecznzLkJ9AzNfyczaLv/zvYNQBsIfSa29uX4bceg3W@vger.kernel.org
X-Gm-Message-State: AOJu0YzJpvyhbGH61Onrx++HwHB7gwcgK4OtQRdwFb63LcI5cepIkZRp
	DDRAKDzH0vR4CfqrcLajcq/qLRirID+Jchoq/lbi4IQo10diu7s7swvKDQ==
X-Google-Smtp-Source: AGHT+IF93dy2QhF/y0X6NxrgGak42ukUVq6DpefMzo9/fdczPIrjlQ18RH2F/E3f6Oam9A3PljccUQ==
X-Received: by 2002:a5d:6481:0:b0:37c:cf75:3945 with SMTP id ffacd0b85a97d-3806121a3c8mr4720122f8f.13.1730233461933;
        Tue, 29 Oct 2024 13:24:21 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:21 -0700 (PDT)
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
Subject: [PATCH v4 17/23] ARM: dts: socfpga: add Enclustra Mercury+ SA2
Date: Tue, 29 Oct 2024 20:23:43 +0000
Message-Id: <20241029202349.69442-18-l.rubusch@gmail.com>
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

Introduce Enclustra's Mercury+ SA2 SoM based on Intel Cyclone5
technology as a .dtsi file.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga/socfpga_cyclone5_mercury_sa2.dtsi | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi
new file mode 100644
index 000000000..f46f1410f
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+#include "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2";
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
+		reg = <0x0 0x80000000>; /* 2GB */
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
+
+	atsha204a: crypto@64 {
+		compatible = "atmel,atsha204a";
+		reg = <0x64>;
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


