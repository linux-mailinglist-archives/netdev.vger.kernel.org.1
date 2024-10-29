Return-Path: <netdev+bounces-140097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B89B537B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B2D1C225D7
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA41020C48C;
	Tue, 29 Oct 2024 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDf0kneZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51A20C32F;
	Tue, 29 Oct 2024 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233460; cv=none; b=FEB7Rs1MBJeAApxJN+e6SA8O6iLVRmVGaCbm6i8W31s4AiXDjUSBRdYb65s6W78dppqic3NsY4bpeeUa9yk3T2ySYDkRma60sVYOakfYQ2B90Z/jegCs5ViOeIzBU4k4Rpz073zjnBSkVqmuRVii2ESvS0BgY9rqbdP/6W4vEPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233460; c=relaxed/simple;
	bh=lyDfov/ybt/QcFSaUdiUn6HM2V4phtEWCJeqcivNp3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fPsKo2dRSw1+pMW1Pi09hTbahuromBMLb2SI2v5IrABWLQUgKcLdkKnf+2OudTsHJy6KMaxYYNKREJ17PZcJA6rbxlN6vRyAs//WKHk8FexL6YYXM+KA3S4qXE7wydzdOjRe6CeC2G0hNDO3ice01cHdxgQH4qUkFUiN5mB85J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDf0kneZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d6716e200so888403f8f.3;
        Tue, 29 Oct 2024 13:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233457; x=1730838257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tTSvfcY2engLoiGHPIJF53AHZxPkJrdqu/6M46fx3k=;
        b=gDf0kneZ6lfM04qg3Cp8FXKykkdsEzWR5Fl2WvJKAGv36sloPIU+EuhdgfIvirZEp6
         AUGnSksdsKuRQjLbOnBHdksfRGPl/u3zEKjsiUIM8Xhs5wmC7v9VIMh5F6BZJM/0QdZ5
         8u2t41GAutgtieBby58rl7lwnPWP1VWwpfLz3nnSBY3afMeyU5QXr5HDWRuh8HGCQPPY
         3bbUuQfP+6X/vRQj1l6pICwCpJg35TMAv0ullCSBdPXPC9CvX42OrniNt4G33ttDV8Oc
         drHhPkf4F7LmtHh+GE5DnRhP2jJ3ErDx+qimosfqM3lj1w7QqmggjNQ7J8vUF4Beozji
         goaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233457; x=1730838257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tTSvfcY2engLoiGHPIJF53AHZxPkJrdqu/6M46fx3k=;
        b=rJDFOYV+1XOp7kFYUbcoVLkEWunEanHQjkM60nAcyt93Fu7SvJATFMdXL9KORJthVv
         xgC88pyStHHRk7Qs8CFyPnwFe8KVZREfy5J9SSSKglRZfTTrnHNtIAXif03annkefBD/
         HQFj5fWtsivJLnCiN0UeEy2FrlFUPrWOqC7JXLHi6HHFLx6M7hqx34vwcJRnhNmsay1b
         dZO6LSZggFgWvhLoXqGpl5mM6gII6mw7N6Sf2j5jWOLYalXAFc0d4hclds8CrB8/v3kF
         ua7gq6d+fS99PnWKZZRt5H3xCgtV1qiiPsWqwEzvDmBHISRWCDi2TF5FaOGww1aqTpJ7
         xHww==
X-Forwarded-Encrypted: i=1; AJvYcCUwTyuRjRHjpB6jS7oVTB7EvMTsacVjNGrga/XpSNBAgDYxVSfOfFDZUXi1HmBsfcVu4M3+g2RqnG6GdKMH@vger.kernel.org, AJvYcCVEfihcFWkVvcBq55xFQPIcoG3EGnJcMUJvknEx6sHTCaObuwhc9rSpFTsteSoPBgE7S5icP+Gy@vger.kernel.org, AJvYcCXJwLnmwwGQAjmwCs0XRp3fHcT9MepPOXeoPkv4K4m/1ZPAJlYZntYkOT+BizyjsQ7PoeFqhHOtt1qZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzibf+y/wcoMxxt/oHDMMJq3oEDyENPZr+cKr87el0oj9v5aUdm
	okfrBmivLINss03XFndPdGsrv56M73ijcUcJ/Q+TLqTmh46Bmsr9
X-Google-Smtp-Source: AGHT+IFZHa2p/2WYHjMbWD4QkGM4Xxq/XW82V4PVd0qgCPADVWpPLohHrOfpWMas0eZt6gssOojehw==
X-Received: by 2002:a5d:648c:0:b0:374:cc10:bb42 with SMTP id ffacd0b85a97d-380610f0ea9mr4649702f8f.2.1730233456731;
        Tue, 29 Oct 2024 13:24:16 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:15 -0700 (PDT)
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
Subject: [PATCH v4 14/23] ARM: dts: socfpga: add Enclustra base-board dtsi
Date: Tue, 29 Oct 2024 20:23:40 +0000
Message-Id: <20241029202349.69442-15-l.rubusch@gmail.com>
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

Add generic Enclustra base-board support for the Mercury+ PE1, the
Mercury+ PE3 and the Mercury+ ST1 board. The carrier boards can be
freely combined with the SoMs Mercury+ AA1, Mercury SA1 and
Mercury+ SA2.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga_enclustra_mercury_pe1.dtsi        | 33 +++++++++++
 .../socfpga_enclustra_mercury_pe3.dtsi        | 55 +++++++++++++++++++
 .../socfpga_enclustra_mercury_st1.dtsi        | 15 +++++
 3 files changed, 103 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe1.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe3.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_st1.dtsi

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe1.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe1.dtsi
new file mode 100644
index 000000000..abc4bfb7f
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe1.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&i2c_encl {
+	status = "okay";
+
+	eeprom@57 {
+		status = "okay";
+		compatible = "microchip,24c128";
+		reg = <0x57>;
+		pagesize = <64>;
+		label = "user eeprom";
+		address-width = <16>;
+	};
+
+	lm96080: temperature-sensor@2f {
+		status = "okay";
+		compatible = "national,lm80";
+		reg = <0x2f>;
+	};
+
+	si5338: clock-controller@70 {
+		compatible = "silabs,si5338";
+		reg = <0x70>;
+	};
+
+};
+
+&i2c_encl_fpga {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe3.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe3.dtsi
new file mode 100644
index 000000000..bc57b0680
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe3.dtsi
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&i2c_encl {
+	i2c-mux@74 {
+		status = "okay";
+		compatible = "nxp,pca9547";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom@56 {
+				status = "okay";
+				compatible = "microchip,24c128";
+				reg = <0x56>;
+				pagesize = <64>;
+				label = "user eeprom";
+				address-width = <16>;
+			};
+
+			lm96080: temperature-sensor@2f {
+				status = "okay";
+				compatible = "national,lm80";
+				reg = <0x2f>;
+			};
+
+			pcal6416: gpio@20 {
+				status = "okay";
+				compatible = "nxp,pcal6416";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+	};
+};
+
+&i2c_encl_fpga {
+	status = "okay";
+
+	i2c-mux@75 {
+		status = "okay";
+		compatible = "nxp,pca9547";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x75>;
+	};
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_st1.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_st1.dtsi
new file mode 100644
index 000000000..4c00475f4
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_st1.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&i2c_encl {
+	si5338: clock-controller@70 {
+		compatible = "silabs,si5338";
+		reg = <0x70>;
+	};
+};
+
+&i2c_encl_fpga {
+	status = "okay";
+};
-- 
2.25.1


