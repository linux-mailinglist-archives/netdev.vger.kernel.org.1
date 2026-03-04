Return-Path: <netdev+bounces-263649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP91DXLtp2mWlwAAu9opvQ
	(envelope-from <netdev+bounces-263649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:29:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C781FCA08
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60DF03032CD4
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C0038839B;
	Wed,  4 Mar 2026 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXUKNM1B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF436390CB9
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612779; cv=none; b=akGDBnaCEOEvj1dx+AsbUyy88hW5pY/aDIyAQ27T9AMcplMUC57Hb2CvIAaWb2SWBhwtjTxNdMmpRQgJZUZafZ67kpb//8V9Mvh+8H42hyRK5zCwYdkupU/stHc569IPpfwQpxCYT2jWqCTXzFa6UBEMsXuTdSdYeSOfJVOHBkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612779; c=relaxed/simple;
	bh=KsKAPs16NFdju1/0K64Cu51clPSA8TzJO1IbUwhFMfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b25XsFVD0utoj1N/nj7NrRdPAzy0HY1I8dww66HoehLihxG5dnVCvuItq53YJ0D6rpvwhDHtcEQwTceZEOs1IWBBq4RovqeJzGGWWS09Kj0PuKawf3tuyX11oWaKdkEyq5lNQyfs93rFyb8/wslCD+VqT/5qe3n+98vVbReoIMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXUKNM1B; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8297310ce0aso187288b3a.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 00:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772612773; x=1773217573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+0Gl/6jsm6dp6ffbeXLRnGklOmDo7AmQYEeUc9n0f0=;
        b=WXUKNM1By1/oO1+QG7opWNVMLbl2Q39VrgHJ6vYqmJGpe7SORyunxU/g9gCKtdDy/m
         b+UQtCi/JH4PEChg2FxW0ajZEazeQeXK1raw9mJqq4czNPCKZ28/pPKBZzN3hSpfStQc
         OzEd6285dB62HUgafHjN8PBNlcaAImHOc7GXUHLRbsyCAfAzjQ3RwdPr+tC8zVpN7sRo
         /ebwlFcXmc1S2/ZaPBd6T8RCvUqngtXdSCClG9KzuUmQU3Vt9SQOOTgwhzkGjpz7gWQI
         Hx9746EiXv7+Xf+NClnOgCb0VL/TSwXODgl4lJm1h08QjxxjrRf85WbuBWSEvWlmauLJ
         z8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772612773; x=1773217573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+0Gl/6jsm6dp6ffbeXLRnGklOmDo7AmQYEeUc9n0f0=;
        b=UmZJrY1Di3OKcoOmLs/JJaTHGzfduK2izL2FsvIcXjiqrclkynRupHFpu7tR0/OZhw
         IdsFX55wNM3wmWVAQCRbdV6vTo/e8fbeNHPiSdb2aS0CGdRaGAK5sVnjWri4Do6ruuTl
         jtKDliIbui7++EhOtUlfSwJxUKGmbuXI1SBJyktpVHwrTiaRxTjlbQOirCWktP6n8+IQ
         +eBPTTekREIxdUgagi3TFAja0XPCR8L4jov1eascPN3u1BGih58tFtESi8lq1u4qVPSS
         +5lp6R2khe1QjHh8K0Bx3d+8GRxP7iUJtYuM0uowIeQMmHXlQbN0TAAm7Badia2oB+qo
         yzHg==
X-Forwarded-Encrypted: i=1; AJvYcCUaKoiP6arxDF8RtC6uvG/AFc3LatOTgOvNQcY48+m1s7vxA7K5pXTMjCP8u6KflRhu/p2ru1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWniSxjqh2QtWe75iAti5IXCn7Nb2VLxqx17DfnE1UsJddTQow
	/4dEVnZvr2puDqph6ZzB3jJYQFDVHSgyCJt5kx4whpSwvwcc65B0SScG
X-Gm-Gg: ATEYQzx1tWFgaASU9R5vUh04ThunfQ9T/ceEsso5/Pz/igvvtHTrw3iZmI7DG+Y799u
	62/e5RVPDa2Ev1jP+yzNO5VJrTUNitqX3p+mfg41dpoIRqp7zsh3mwVPNIOhHadIDkxJikWmHYl
	Qnuv/UxKJSVZ0GLUYGSKWtYfJuzUHRwHjb3QA2TnlRi+9FdsmW5Y+Q7IR+attWrbHfzH+fRxR19
	nMSMQP7o8k0rJOd0N9SyDhj+d6kYTyCDWsjYxL3l9rvDZtsSpVNZYQKZiloHFnPkAiVnMDqy5iP
	UhcHm033RRTnAhN5i1W0vETUbUW8gV7PFiIsw+mKWgi0mmHGrfPlCSoI4MVah79qH0xYxjxfJS7
	VP8lAAwvvp93RUXdabCrf94gR5O13ns+xX5/vevkOrC7AUDHG/P90VdHe1GOsV6g2NXbKhhQLnv
	jAyR3U82xcWHBNPf+cyXSbABtPClZcQdMwEA==
X-Received: by 2002:a05:6a20:26aa:b0:394:5ac7:8ffa with SMTP id adf61e73a8af0-3982ded341amr1286519637.16.1772612772757;
        Wed, 04 Mar 2026 00:26:12 -0800 (PST)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7377062904sm1274642a12.30.2026.03.04.00.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:26:12 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] riscv: dts: spacemit: k3: Add ethernet device node
Date: Wed,  4 Mar 2026 16:25:41 +0800
Message-ID: <20260304082541.1786223-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C7C781FCA08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263649-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,gentoo.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cac80000:email,0.0.0.1:email,d4015000:email,cac82000:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cac8e000:email,5.245.225.0:email]
X-Rspamd-Action: no action

Add all ethernet device nodes for K3 SoC. And enable the available
ethernet device for the PICO ITX board.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
Require the following patch series:
1. Basic DT device patch
https://lore.kernel.org/spacemit/20260304-01-dts-uart-full-v1-0-50a0aa53a245@kernel.org
2. Ethernet driver patch
https://lore.kernel.org/spacemit/20260304080721.1658224-1-inochiama@gmail.com
---
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts |  20 ++++
 arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi |  38 +++++++
 arch/riscv/boot/dts/spacemit/k3.dtsi         | 106 +++++++++++++++++++
 3 files changed, 164 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
index b098dbd0e7a1..47e4fa824417 100644
--- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
+++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
@@ -6,6 +6,7 @@

 #include "k3.dtsi"
 #include "k3-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>

 / {
 	model = "SpacemiT K3 Pico-ITX";
@@ -25,6 +26,25 @@ memory@100000000 {
 	};
 };

+&eth0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_cfg>;
+
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
index efb0f1572188..256880192846 100644
--- a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
@@ -21,4 +21,42 @@ uart0-0-pins {
 			drive-strength = <25>;
 		};
 	};
+
+	gmac0_cfg: gmac0-cfg {
+		gmac0_base_pins: gmac0-0-pins {
+			pinmux = <K3_PADCONF(0, 1)>,
+				 <K3_PADCONF(1, 1)>,
+				 <K3_PADCONF(2, 1)>,
+				 <K3_PADCONF(3, 1)>,
+				 <K3_PADCONF(6, 1)>,
+				 <K3_PADCONF(7, 1)>,
+				 <K3_PADCONF(11, 1)>,
+				 <K3_PADCONF(12, 1)>,
+				 <K3_PADCONF(13, 1)>;
+
+			bias-disable;
+			drive-strength = <25>;
+			power-source = <1800>;
+		};
+
+		gmac0_rgmii_add_pins: gmac0-1-pins {
+			pinmux = <K3_PADCONF(4, 1)>,
+				 <K3_PADCONF(5, 1)>,
+				 <K3_PADCONF(8, 1)>,
+				 <K3_PADCONF(9, 1)>,
+				 <K3_PADCONF(10, 1)>;
+
+			bias-disable;
+			drive-strength = <25>;
+			power-source = <1800>;
+		};
+
+		gmac0_int_pins: gmac0-3-pins {
+			pinmux = <K3_PADCONF(14, 1)>;
+
+			bias-disable;
+			drive-strength = <25>;
+			power-source = <1800>;
+		};
+	};
 };
diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
index a3a8ceddabec..237fb00e4bc4 100644
--- a/arch/riscv/boot/dts/spacemit/k3.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
@@ -438,6 +438,112 @@ soc: soc {
 		dma-noncoherent;
 		ranges;

+		gmac_axi_setup: stmmac-axi-config {
+			snps,wr_osr_lmt = <0xf>;
+			snps,rd_osr_lmt = <0xf>;
+			/* max axi burst len is 256 */
+			snps,blen = <256 128 64 32 16 0 0>;
+		};
+
+		eth0: ethernet@cac80000 {
+			compatible = "spacemit,k3-dwmac", "snps,dwmac-5.40a";
+			reg = <0x0 0xcac80000 0x0 0x2000>;
+			clocks = <&syscon_apmu CLK_APMU_EMAC0_BUS>,
+				 <&syscon_apmu CLK_APMU_EMAC0_1588>,
+				 <&syscon_apmu CLK_APMU_EMAC0_RGMII_TX>;
+			clock-names = "stmmaceth", "ptp_ref", "tx";
+			interrupt-parent = <&saplic>;
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
+			snps,axi-config = <&gmac_axi_setup>;
+			spacemit,apmu = <&syscon_apmu 0x3e4 0x3e8>;
+			status = "disabled";
+
+			mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
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
+			interrupt-parent = <&saplic>;
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
+			snps,axi-config = <&gmac_axi_setup>;
+			spacemit,apmu = <&syscon_apmu 0x3ec 0x3f0>;
+			status = "disabled";
+
+			mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
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
+			interrupt-parent = <&saplic>;
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
+			snps,axi-config = <&gmac_axi_setup>;
+			spacemit,apmu = <&syscon_apmu 0x248 0x24c>;
+			status = "disabled";
+
+			mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		syscon_apbc: system-controller@d4015000 {
 			compatible = "spacemit,k3-syscon-apbc";
 			reg = <0x0 0xd4015000 0x0 0x1000>;

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
prerequisite-patch-id: 68c4d869548687dc115dd91e2ffb8f4c11482d86
prerequisite-patch-id: fdadcf964c2cb3406160edb579d99a8d5695f8e6
prerequisite-patch-id: 73b9e745338b0499b849fa4f7f9508987ab39a59
prerequisite-patch-id: cd26770c2160c3c31a406bd8a6b01ab666180ae0
prerequisite-patch-id: 93a515969fca3b15f827b3507979422dda14db8b
prerequisite-patch-id: a637cffacb823aa7ae91e03ed42831ef8fbd0d1f
prerequisite-patch-id: 40c49afe4eb71457913c45ddb720a9c8917aa827
--
2.53.0


