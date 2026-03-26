Return-Path: <netdev+bounces-271792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBjFL6GRxGnH0gQAu9opvQ
	(envelope-from <netdev+bounces-271792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:53:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A232E126
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA803305F523
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 01:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF0038C42F;
	Thu, 26 Mar 2026 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXc1FmZr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C805B34F275
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 01:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774489598; cv=none; b=OYKRtcKq23QdpKatfMU32bfnBmKctP3ZTNfhMi4Z+fPTxb8xF1HBWPa2+Mvg+bWpYfuB7UiNZmcGf1Bwq9Fv4eZjWAip/p0WR/BV4yjXi2s6eqZzoc2/xMGINRs0OLkjoutHZ8F8zP/BYY5ptheSOfb8vgJJBz7FPHh0tFIcMZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774489598; c=relaxed/simple;
	bh=2JdWtj8jHoziLokeQl/cJ1LmihyFXi4ry53iPjdK6Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkaBbePedf1tazxl53CThO1jPHAe4dH9lyFocGzWFKdCx5//98M4pdW0URDhEJ4k97CUostlYansVVtUO8CeWYiqLp9AWiF/BbA7dmj7I7DNSyQ4bTd/OJNi7Tp/qGe1E9dueGn5T2XCWkkj07uOypL5yWuB7CLUtA7AjqwUZx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXc1FmZr; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a094cc3e9so291448a91.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 18:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774489595; x=1775094395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FvrpaPMv4wQW9rLV6Y/lNvOSwC23X2i4bR0ncVYXo34=;
        b=NXc1FmZrLGkk+g/APMRhO+J2h5HWqjgT7iyfPmOOpO2HlxMn/wmym6iIgmBoJDyhc1
         TX455TUlCer7bbwGnh7VXIvmmhf01Cyqo4goH9hXPQPeTAb1o2VFP0HlZQYUSUirbf8W
         w62+QpscoWOkmvo8FJcWnpsseOgALE1vDBV34GKp02e4UH71m6ZM/3syO/Asd0XGBA00
         6cyM+GZRG+PmpXqw4Mixj3mbIW8+7/4ZMVQiYDb+aahfbcrZPMwzPAfAswV6Z4V0bDpP
         SHTRAzbkScmctJohM15fdWxPWFMqCIs2V5zHG6kcT+aVRH66hFJ6pK2LQl1YWqJqRmVW
         ieEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774489595; x=1775094395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvrpaPMv4wQW9rLV6Y/lNvOSwC23X2i4bR0ncVYXo34=;
        b=sTWYaD6eOBOAAVDdce70j0ldOanByaJ5h7XlMA8pRzLD5O+j655lXqRuiPmQw5e7/Z
         gp4RMhVk/KhPBwN2P9mbqO1GSxM52rXq+V+GbxwOLwdNfyvFtMeQv5nXn1ks2XYxeul6
         GSjZQBS2+6yXoBZ7r6io1S47z+oEMyOsANR1g+FORTB4kBjWy5xDE0hlMK446orPsitx
         Z4EB3siuW9i38arJEv0qwY1oh4Wp0RKP5BUr38TNIf5mEATfArInUwpW1gvrTFVmTyOx
         vmvD1kPosZSgztlCkAcBwwqrNTc9MBKag7VZAKH+MQy+g1ydg18PpsM656LHYxAUykUa
         y4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2LOm+fMGlOB9pgQ96n8CGojIN8RVF444KCY1+f07oIsd93Finj6+K1/c2NU6QmEWmqFuzP5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxvalM5YOVDGffhqCvUpwk7aqmICezjA8DvTP6MWx/VUguNwDp
	hjkZTofen/XgeJAcPFqaJyrkjD1/7Yv1gw6KbqMgS4U6IOajREtd5NrL
X-Gm-Gg: ATEYQzx+ZkWSEoKJU+phuniHk+IiUPBNo9RoDKqtApragcAYPwJWcG6I1jJ4eNUW2nc
	WHYUGrDlyQsSCyY4bd04mmMgUOypXtgrjyilzatT1N+YgYvRQzX8z+1NE6Q7N8Yb7qUg3pFzSo+
	/U2hDey2rwvG7eJqjDkpEbi2viIijaSuOz/6UclzwIRayVPoklGJ1KQBAYIlopT7FjL6Btutz8Y
	zcz5EqoK0Cqo8meHT08HMGjIVJBdhTTNO9mQJSCOqfgaVDvLF8n/Aho/Txd7iPyxXsQofX3U8+q
	uuIkbGs/7Yj61H9kim6WNhNQCo9Ablm2iTDQbxEJS1wHEeRUzwPh1trvx1dxpxrn+N8/cyLTXsm
	tAnDxaZdWDj0VhEn8RMv+o47baEu7D6p54N6Wm0LzK8700ie9fc/k+rsoc21DGpNL2QrOKXLJyJ
	vguTzx6+P0CprAtyuh2CwdlME=
X-Received: by 2002:a17:90b:518e:b0:35b:e56e:a17e with SMTP id 98e67ed59e1d1-35c0dd7ac8amr5444206a91.17.1774489595082;
        Wed, 25 Mar 2026 18:46:35 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c1dd3800bsm569329a91.1.2026.03.25.18.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 18:46:34 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v6] riscv: dts: spacemit: Add ethernet device for K3
Date: Thu, 26 Mar 2026 09:46:17 +0800
Message-ID: <20260326014617.1011732-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,gentoo.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271792-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	DBL_PROHIBIT(0.00)[5.245.225.0:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.1:email,cac82000:email,riscstar.com:email,cac8e000:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D1A232E126
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add all ethernet device nodes for K3 SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
Require the following patch series:
1. Basic DT device patch
https://lore.kernel.org/spacemit/20260304-01-dts-uart-full-v1-0-50a0aa53a245@kernel.org
2. Ethernet driver patch
https://lore.kernel.org/spacemit/20260316010041.164360-1-inochiama@gmail.com

Changed from v5:
1. Fix DT warning cause by stmmac-axi-config.

Changed from v4:
1. Fix pinctrl pin name
2. Remove alias for disabled node

Changed from v3:
1. Separate the pin as RGMII pin and INT pin.
2. Add comment for pin usage.
3. Rename the ethernet pinctrl node to address it is RGMII node.

Changed from v2:
1. keep aliases in alphabetical order.

Changed from v1:
1. remove interrupt-parents property
2. add aliases for ethernet node
---
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts |  20 ++++
 arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi |  34 ++++++
 arch/riscv/boot/dts/spacemit/k3.dtsi         | 117 +++++++++++++++++++
 3 files changed, 171 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
index b098dbd0e7a1..504fe6bd46b2 100644
--- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
+++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
@@ -3,6 +3,7 @@
  * Copyright (c) 2026 SpacemiT (Hangzhou) Technology Co. Ltd
  * Copyright (c) 2026 Guodong Xu <guodong@riscstar.com>
  */
+#include <dt-bindings/gpio/gpio.h>

 #include "k3.dtsi"
 #include "k3-pinctrl.dtsi"
@@ -12,6 +13,7 @@ / {
 	compatible = "spacemit,k3-pico-itx", "spacemit,k3";

 	aliases {
+		ethernet0 = &eth0;
 		serial0 = &uart0;
 	};

@@ -25,6 +27,24 @@ memory@100000000 {
 	};
 };

+&eth0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_rgmii_0_cfg>, <&gmac0_phy_0_cfg>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&phy0>;
+	status = "okay";
+
+	mdio {
+		phy0: phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			reset-gpios = <&gpio 0 15 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <10000>;
+		};
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_0_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
index efb0f1572188..a7b5d10c332e 100644
--- a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
@@ -11,6 +11,40 @@
 #define K3_GPIO(x)	(x / 32) (x % 32)

 &pinctrl {
+	gmac0_rgmii_0_cfg: gmac0-rgmii-0-cfg {
+		gmac0-rgmii-0-pins {
+			pinmux = <K3_PADCONF(0, 1)>,	/* gmac0_rxdv */
+				 <K3_PADCONF(1, 1)>,	/* gmac0_rx_d0 */
+				 <K3_PADCONF(2, 1)>,	/* gmac0_rx_d1 */
+				 <K3_PADCONF(3, 1)>,	/* gmac0_rx_clk */
+				 <K3_PADCONF(4, 1)>,	/* gmac0_rx_d2 */
+				 <K3_PADCONF(5, 1)>,	/* gmac0_rx_d3 */
+				 <K3_PADCONF(6, 1)>,	/* gmac0_tx_d0 */
+				 <K3_PADCONF(7, 1)>,	/* gmac0_tx_d1 */
+				 <K3_PADCONF(8, 1)>,	/* gmac0_tx_clk */
+				 <K3_PADCONF(9, 1)>,	/* gmac0_tx_d2 */
+				 <K3_PADCONF(10, 1)>,	/* gmac0_tx_d3 */
+				 <K3_PADCONF(11, 1)>,	/* gmac0_tx_en */
+				 <K3_PADCONF(12, 1)>,	/* gmac0_mdc */
+				 <K3_PADCONF(13, 1)>;	/* gmac0_mdio */
+
+			bias-disable;
+			drive-strength = <25>;
+			power-source = <1800>;
+		};
+
+	};
+
+	gmac0_phy_0_cfg: gmac0-phy-0-cfg {
+		gmac0-phy-0-pins {
+			pinmux = <K3_PADCONF(14, 1)>;   /* gmac0_int */
+
+			bias-disable;
+			drive-strength = <25>;
+			power-source = <1800>;
+		};
+	};
+
 	/omit-if-no-ref/
 	uart0_0_cfg: uart0-0-cfg {
 		uart0-0-pins {
diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
index a3a8ceddabec..5f4818cd5d6d 100644
--- a/arch/riscv/boot/dts/spacemit/k3.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
@@ -438,6 +438,123 @@ soc: soc {
 		dma-noncoherent;
 		ranges;

+		eth0: ethernet@cac80000 {
+			compatible = "spacemit,k3-dwmac", "snps,dwmac-5.40a";
+			reg = <0x0 0xcac80000 0x0 0x2000>;
+			clocks = <&syscon_apmu CLK_APMU_EMAC0_BUS>,
+				 <&syscon_apmu CLK_APMU_EMAC0_1588>,
+				 <&syscon_apmu CLK_APMU_EMAC0_RGMII_TX>;
+			clock-names = "stmmaceth", "ptp_ref", "tx";
+			interrupts = <131 IRQ_TYPE_LEVEL_HIGH>,
+				     <276 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			resets = <&syscon_apmu RESET_APMU_EMAC0>;
+			reset-names = "stmmaceth";
+			rx-fifo-depth = <8192>;
+			tx-fifo-depth = <8192>;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <32>;
+			snps,aal;
+			snps,tso;
+			snps,txpbl = <8>;
+			snps,rxpbl = <8>;
+			snps,force_sf_dma_mode;
+			snps,axi-config = <&gmac0_axi_setup>;
+			spacemit,apmu = <&syscon_apmu 0x3e4 0x3e8>;
+			status = "disabled";
+
+			mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			gmac0_axi_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <0xf>;
+				snps,rd_osr_lmt = <0xf>;
+				/* max axi burst len is 256 */
+				snps,blen = <256 128 64 32 16 0 0>;
+			};
+		};
+
+		eth1: ethernet@cac82000 {
+			compatible = "spacemit,k3-dwmac", "snps,dwmac-5.40a";
+			reg = <0x0 0xcac82000 0x0 0x2000>;
+			clocks = <&syscon_apmu CLK_APMU_EMAC1_BUS>,
+				 <&syscon_apmu CLK_APMU_EMAC1_1588>,
+				 <&syscon_apmu CLK_APMU_EMAC1_RGMII_TX>;
+			clock-names = "stmmaceth", "ptp_ref", "tx";
+			interrupts = <133 IRQ_TYPE_LEVEL_HIGH>,
+				     <277 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			resets = <&syscon_apmu RESET_APMU_EMAC1>;
+			reset-names = "stmmaceth";
+			rx-fifo-depth = <8192>;
+			tx-fifo-depth = <8192>;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <32>;
+			snps,aal;
+			snps,tso;
+			snps,txpbl = <8>;
+			snps,rxpbl = <8>;
+			snps,force_sf_dma_mode;
+			snps,axi-config = <&gmac1_axi_setup>;
+			spacemit,apmu = <&syscon_apmu 0x3ec 0x3f0>;
+			status = "disabled";
+
+			mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			gmac1_axi_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <0xf>;
+				snps,rd_osr_lmt = <0xf>;
+				/* max axi burst len is 256 */
+				snps,blen = <256 128 64 32 16 0 0>;
+			};
+		};
+
+		eth2: ethernet@cac8e000 {
+			compatible = "spacemit,k3-dwmac", "snps,dwmac-5.40a";
+			reg = <0x0 0xcac8e000 0x0 0x2000>;
+			clocks = <&syscon_apmu CLK_APMU_EMAC2_BUS>,
+				 <&syscon_apmu CLK_APMU_EMAC2_1588>,
+				 <&syscon_apmu CLK_APMU_EMAC2_RGMII_TX>;
+			clock-names = "stmmaceth", "ptp_ref", "tx";
+			interrupts = <130 IRQ_TYPE_LEVEL_HIGH>,
+				     <278 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			resets = <&syscon_apmu RESET_APMU_EMAC2>;
+			reset-names = "stmmaceth";
+			rx-fifo-depth = <4096>;
+			tx-fifo-depth = <4096>;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <32>;
+			snps,aal;
+			snps,tso;
+			snps,txpbl = <8>;
+			snps,rxpbl = <8>;
+			snps,force_sf_dma_mode;
+			snps,axi-config = <&gmac2_axi_setup>;
+			spacemit,apmu = <&syscon_apmu 0x248 0x24c>;
+			status = "disabled";
+
+			mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			gmac2_axi_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <0xf>;
+				snps,rd_osr_lmt = <0xf>;
+				/* max axi burst len is 256 */
+				snps,blen = <256 128 64 32 16 0 0>;
+			};
+		};
+
 		syscon_apbc: system-controller@d4015000 {
 			compatible = "spacemit,k3-syscon-apbc";
 			reg = <0x0 0xd4015000 0x0 0x1000>;
--
2.53.0


