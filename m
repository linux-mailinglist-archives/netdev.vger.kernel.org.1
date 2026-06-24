Return-Path: <netdev+bounces-301582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZHcLB96eO2rcaQgAu9opvQ
	(envelope-from <netdev+bounces-301582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:09:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6497A6BCD2D
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:09:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=I89uvAlv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301582-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301582-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83E5B30E8620
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37037647E;
	Wed, 24 Jun 2026 09:04:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956E1305669
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 09:04:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291867; cv=none; b=utJkGfCG/Q/N2iZKzv1ci5CDrv8/xCwXqNWH1dcVJn8oDF9GF12urTLYhDK7H4w/7mfVX/gkoTqxF/BWu6GbpU0RXEw6petgIxQI4pz+S4WyTQZwpRWP/HGbqTzWwGCrdLXUioxaMvhwIMOeFZz/5xmNpk4ipN8lEVn/SzsR02s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291867; c=relaxed/simple;
	bh=TKHf6LFZ6qy6at9qzY3w2/k1Dk8gfqxmmvJBmN/bvS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBGmCL5JYSkEJtifWvqQblSa7ibIr8kXDaKqgVUNmlXssdI4rmeQOevjQ8H06K3p9Un+LRsZySbaD2aVjnzScg7R63pJZTOQsK/vzRTXrxG7OzfQQQGvQ/PEIpFb9mO7Dq0VnFGnka59XmitxT5ObmkURWBHQX64AQZfH/T6rCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I89uvAlv; arc=none smtp.client-ip=209.85.214.194
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2c0b9328c4aso4004605ad.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782291865; x=1782896665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoUdoHzqhvRaG+QdP+Evvt/ejkkExmNeHFiO7MTEkWA=;
        b=I89uvAlvof1f5R31K3yQUPeMwPsNqaofPz6a+XLjaBVeHjRUJqkwj3PDCfC4DAnd3x
         6wCFYox/8+5y1HULDkboU/51smhti3+zYja04x528low19sPOuAcl1f7OVj6Xz59hYJf
         SK9rEN56MozWDOknUXQp2OYqBkxFCTzyXBVwtQeqhOqifjDlNXXHiuf8L9dnFxiQfLIy
         qncJP/KAhD9yuAUvYk9EahOW/4hWyqoQzY07EkQN3h1M2ayMAZz6+I21uUKEewhiPmKS
         miRP45PBGdOKSgaqwbpVgICTYvW6Y1boe+zS5ZxjDxG/wLLiLuctjgDlYTAKtoLC8j7h
         AGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782291865; x=1782896665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MoUdoHzqhvRaG+QdP+Evvt/ejkkExmNeHFiO7MTEkWA=;
        b=UuqOu/fBxjWjEc9OiG/bg3ePHZjBF79ua+SYizxUzcWimbTXlN+S6fenOow/ZRlrU7
         LMcXjPjqpT3F2Z/NMK+K55mRl99Wh7izLtnrM6Qzc1xYVOqTXmGb5WcXPoxpO2qHX3+H
         bJarjY/Vn1WLYwlKK3kIeOLfNGntx4QpYCiILHaD+2epr41c79EIJZyu5laAoE6ERYHT
         lj8bX7daG0tn1lBm2A83XTftOJrn04YrFc2Y8bbrMo7KQx/jV/DosY3mjB2KXh7o52NS
         XuUugm1A/8kQXIvXKyBP80hw06vNHzch0V8byQA/8EqHBg+/RoXmgn961PdshPiBsvg/
         vzUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8AGTXsDormvIc/9TMk23m5S6qoU2/2c0MuYSzc2RHHLdQbLT0uM7LB3DbJgQkbkWEo/5dvoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSeIFhoGlETEKLIK+SrCqE2bSY63DSQCM5TRGSCX/lc2NvxaQ
	qHjaxLkyT+qDbi0M3yO/SrBa8i0L8wL/SxfZUhjfttqWE9ewmBbZjhPw
X-Gm-Gg: AfdE7ckslkDZDSZsshhR9R9tP8MasstIsoUeNUV9TWVAn1INJwAHyYy9RggbYTth6XQ
	RDCUR4+/qlxUuobKp1zhoQsmBMWytRbAH3m/ZHY02pnqcgVA5182VJ58uDoDrmePyr2cpqKOCuy
	oCofMhRVR5oqMGd10BlubY0C48l5TbgjhC3DNGhxzdm0r4/mNldKpZvXfYP6JQPYOuzwQD8p9g1
	LJTfUoPmvpeK+7noFLbE2EvlG415/PvFT9HXenfSr32dSrGoxGxIWvd3via0MNnzKO/3QZ9Zmri
	niMnET9KXGkFND496oKu+16FPC0KMSKVe9b5At3ciO+6vrkaFCcJe+jml3TY5mOCtpWDeb29Fh1
	0+j05LlbeIb7bqTZH1s1RvjD1eNg80cAAepcncsIHbeDrcz1Ls5GrnkRGDtWhP1vo28N/3iChSN
	ceCdiSntHzOglg
X-Received: by 2002:a17:903:4b4e:b0:2c6:d710:3e58 with SMTP id d9443c01a7336-2c742b79e68mr191166655ad.36.1782291864779;
        Wed, 24 Jun 2026 02:04:24 -0700 (PDT)
Received: from fedora ([218.194.36.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af585sm134292515ad.5.2026.06.24.02.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:04:23 -0700 (PDT)
From: Yanan He <grumpycat921013@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	david.wu@rock-chips.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	grumpycat921013@gmail.com
Subject: [PATCH 7/7] ARM: dts: rockchip: Add Alientek DLRV1126
Date: Wed, 24 Jun 2026 17:02:47 +0800
Message-ID: <20260624-rv1126-alientek-dlrv1126-v1-7-dc42d99f75a7@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624-rv1126-alientek-dlrv1126-v1-0-dc42d99f75a7@gmail.com>
References: <20260624-rv1126-alientek-dlrv1126-v1-0-dc42d99f75a7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782291360; l=14599; i=grumpycat921013@gmail.com; s=20260618; h=from:subject:message-id; bh=TKHf6LFZ6qy6at9qzY3w2/k1Dk8gfqxmmvJBmN/bvS4=; b=NOC3MnDpGl4+oVWciaQMkfgxHERMhlZF43CN24EzvgI9/jVdCfjc7lpKxp+X9x4ZXWT/FesB2 Z50iLEHIiT+A8Caxi+NB7D5r8BvpoS2R8I+UBrvb2wOP0wXVZUJCGMP
X-Developer-Key: i=grumpycat921013@gmail.com; a=ed25519; pk=oWrY8KwXIunZWlYBV76NG2A3V4p1bJ+aD45Mr56ErTw=
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301582-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.wu@rock-chips.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:grumpycat921013@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,sntech.de,lunn.ch,davemloft.net,google.com,redhat.com,rock-chips.com,gmail.com,foss.st.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6497A6BCD2D

The board consists of a CLRV1126F core module and a DLRV1126 carrier
board. The core module contains the RV1126 SoC, eMMC and RK809 PMIC,
while the carrier board provides Ethernet, SD card, AP6212 WiFi and
Bluetooth, PCF8563 RTC, ADC keys, GPIO LEDs and audio connectors.

The board has been tested with Ethernet/NFS boot, eMMC, SD card, SDIO
WiFi enumeration, Bluetooth LE scanning, RTC, ADC keys, GPIO LEDs and
RK809 audio card registration.

Signed-off-by: Yanan He <grumpycat921013@gmail.com>
---
 arch/arm/boot/dts/rockchip/Makefile                |   1 +
 .../dts/rockchip/rv1126-alientek-clrv1126f.dtsi    | 277 +++++++++++++++++++++
 .../boot/dts/rockchip/rv1126-alientek-dlrv1126.dts | 258 +++++++++++++++++++
 3 files changed, 536 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/Makefile b/arch/arm/boot/dts/rockchip/Makefile
index d0154fd7ff24..e9f9e0ac3bfd 100644
--- a/arch/arm/boot/dts/rockchip/Makefile
+++ b/arch/arm/boot/dts/rockchip/Makefile
@@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rv1108-evb.dtb \
 	rv1109-relfor-saib.dtb \
 	rv1109-sonoff-ihost.dtb \
+	rv1126-alientek-dlrv1126.dtb \
 	rv1126-edgeble-neu2-io.dtb \
 	rv1126-sonoff-ihost.dtb \
 	rk3036-evb.dtb \
diff --git a/arch/arm/boot/dts/rockchip/rv1126-alientek-clrv1126f.dtsi b/arch/arm/boot/dts/rockchip/rv1126-alientek-clrv1126f.dtsi
new file mode 100644
index 000000000000..9bee424b1797
--- /dev/null
+++ b/arch/arm/boot/dts/rockchip/rv1126-alientek-clrv1126f.dtsi
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2026 Yanan He <grumpycat921013@gmail.com>
+ */
+
+#include "rv1126.dtsi"
+
+/ {
+	compatible = "alientek,clrv1126f", "rockchip,rv1126";
+
+	aliases {
+		mmc0 = &emmc;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_cmd &emmc_clk &emmc_rstnout>;
+	rockchip,default-sample-phase = <90>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB1 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <1>;
+		#sound-dai-cells = <0>;
+		clock-output-names = "rk808-clkout1", "rk808-clkout2";
+		clock-names = "mclk";
+		clocks = <&cru MCLK_I2S0_TX_OUT2IO>;
+		assigned-clocks = <&cru MCLK_I2S0_TX_OUT2IO>;
+		assigned-clock-parents = <&cru MCLK_I2S0_TX>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l>;
+		rockchip,system-power-controller;
+		wakeup-source;
+
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc5-supply = <&vcc_buck5>;
+		vcc6-supply = <&vcc_buck5>;
+		vcc7-supply = <&vcc5v0_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc5v0_sys>;
+
+		regulators {
+			vdd_npu_vepu: DCDC_REG1 {
+				regulator-name = "vdd_npu_vepu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <6001>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_arm: DCDC_REG2 {
+				regulator-name = "vdd_arm";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <725000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc3v3_sys: DCDC_REG4 {
+				regulator-name = "vcc3v3_sys";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_buck5: DCDC_REG5 {
+				regulator-name = "vcc_buck5";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <2200000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <2200000>;
+				};
+			};
+
+			vcc_0v8: LDO_REG1 {
+				regulator-name = "vcc_0v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc1v8_pmu: LDO_REG2 {
+				regulator-name = "vcc1v8_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd0v8_pmu: LDO_REG3 {
+				regulator-name = "vcc0v8_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <800000>;
+				};
+			};
+
+			vcc_1v8: LDO_REG4 {
+				regulator-name = "vcc_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc_dovdd: LDO_REG5 {
+				regulator-name = "vcc_dovdd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_dvdd: LDO_REG6 {
+				regulator-name = "vcc_dvdd";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_avdd: LDO_REG7 {
+				regulator-name = "vcc_avdd";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG8 {
+				regulator-name = "vccio_sd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sd: LDO_REG9 {
+				regulator-name = "vcc3v3_sd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_5v0: SWITCH_REG1 {
+				regulator-name = "vcc_5v0";
+			};
+
+			vcc_3v3: SWITCH_REG2 {
+				regulator-name = "vcc_3v3";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
+&pinctrl {
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	pmuio0-supply = <&vcc3v3_sys>;
+	pmuio1-supply = <&vcc3v3_sys>;
+	vccio1-supply = <&vcc_1v8>;
+	vccio2-supply = <&vccio_sd>;
+	vccio3-supply = <&vcc_1v8>;
+	vccio4-supply = <&vcc_3v3>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_3v3>;
+	vccio7-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/rockchip/rv1126-alientek-dlrv1126.dts b/arch/arm/boot/dts/rockchip/rv1126-alientek-dlrv1126.dts
new file mode 100644
index 000000000000..c8123a3c4746
--- /dev/null
+++ b/arch/arm/boot/dts/rockchip/rv1126-alientek-dlrv1126.dts
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2026 Yanan He <grumpycat921013@gmail.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include "rv1126-alientek-clrv1126f.dtsi"
+
+/ {
+	model = "Alientek ATK-DLRV1126";
+	compatible = "alientek,dlrv1126", "alientek,clrv1126f", "rockchip,rv1126";
+
+	aliases {
+		ethernet0 = &gmac;
+		mmc1 = &sdio;
+		mmc2 = &sdmmc;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-esc {
+			label = "esc";
+			linux,code = <KEY_ESC>;
+			press-threshold-microvolt = <0>;
+		};
+
+		button-right {
+			label = "right";
+			linux,code = <KEY_RIGHT>;
+			press-threshold-microvolt = <400781>;
+		};
+
+		button-left {
+			label = "left";
+			linux,code = <KEY_LEFT>;
+			press-threshold-microvolt = <801562>;
+		};
+
+		button-menu {
+			label = "menu";
+			linux,code = <KEY_MENU>;
+			press-threshold-microvolt = <1198828>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "sys-led";
+			gpios = <&gpio3 RK_PD4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+		};
+
+		led-1 {
+			label = "user-led";
+			gpios = <&gpio3 RK_PD6 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+			default-state = "on";
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Analog RK809";
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,widgets =
+			"Speaker", "Speaker",
+			"Headphone", "Headphones",
+			"Microphone", "Mic Jack";
+		simple-audio-card,routing =
+			"Speaker", "SPKO",
+			"Headphones", "HPOL",
+			"Headphones", "HPOR",
+			"MICL", "Mic Jack";
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&rk809>;
+		};
+	};
+
+	vcc5v0_sys: regulator-vcc5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	sdio_pwrseq: pwrseq-sdio {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		reset-gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
+		post-power-on-delay-ms = <200>;
+		power-off-delay-us = <20000>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	pcf8563: rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PD0 IRQ_TYPE_LEVEL_LOW>;
+		clock-output-names = "xin32k";
+	};
+};
+
+&gmac {
+	phy-mode = "rgmii";
+	clock_in_out = "input";
+	assigned-clocks = <&cru CLK_GMAC_SRC>, <&cru CLK_GMAC_TX_RX>,
+			  <&cru CLK_GMAC_ETHERNET_OUT>;
+	assigned-clock-parents = <&cru CLK_GMAC_SRC_M1>,
+				 <&cru RGMII_MODE_CLK>;
+	assigned-clock-rates = <125000000>, <0>, <25000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmiim1_miim &rgmiim1_bus2 &rgmiim1_bus4
+		     &clk_out_ethernetm1_pins>;
+	tx_delay = <0x2a>;
+	rx_delay = <0x1a>;
+	phy-handle = <&phy>;
+	status = "okay";
+};
+
+&mdio {
+	phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		clocks = <&cru CLK_GMAC_ETHERNET_OUT>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&eth_phy_rst>;
+		reset-gpios = <&gpio3 RK_PA0 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+	};
+};
+
+&pinctrl {
+	ethernet {
+		eth_phy_rst: eth-phy-rst {
+			rockchip,pins = <3 RK_PA0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	bt {
+		bt_enable: bt-enable {
+			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_wake_dev: bt-wake-dev {
+			rockchip,pins = <1 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_wake_host: bt-wake-host {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wifi {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&sdio {
+	bus-width = <4>;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	max-frequency = <25000000>;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc1_clk &sdmmc1_cmd &sdmmc1_bus4>;
+	rockchip,default-sample-phase = <90>;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	card-detect-delay = <200>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_bus4 &sdmmc0_det>;
+	rockchip,default-sample-phase = <90>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_ctsn &uart0_rtsn>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43430a1-bt";
+		shutdown-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&gpio1 RK_PD1 GPIO_ACTIVE_HIGH>;
+		clocks = <&rk809 1>;
+		clock-names = "lpo";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA5 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "host-wakeup";
+		max-speed = <115200>;
+		vbat-supply = <&vcc_3v3>;
+		vddio-supply = <&vcc_1v8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_enable>, <&bt_wake_dev>, <&bt_wake_host>;
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&i2s0 {
+	rockchip,trcm-sync-tx-only;
+	rockchip,i2s-rx-route = <3 1 2 0>;
+	rockchip,i2s-tx-route = <0 1 2 3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s0m0_sclk_tx>,
+		    <&i2s0m0_mclk>,
+		    <&i2s0m0_lrck_tx>,
+		    <&i2s0m0_sdo0>,
+		    <&i2s0m0_sdo1_sdi3>;
+	status = "okay";
+};

-- 
2.54.0


