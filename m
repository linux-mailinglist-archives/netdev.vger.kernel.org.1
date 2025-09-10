Return-Path: <netdev+bounces-221579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBBAB5109D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD53441516
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA72830F544;
	Wed, 10 Sep 2025 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0Ig17JDg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304FA26AAAB
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491670; cv=none; b=qs5XDYt8bkTe70XY6dYeNygIQR9UEbgj1VDMsQRtPISNPHzef1fbGw1rCX0ZVnNfgjGjaIHI8CktMmy/170Evbij8vnGX08lfv6Z/okHjkZGFPsW+JFtpXS7ZJfvwu39utDgaT8EjieFNPrTJ8eGIsNZsnlLbb7uaJB+5CwRR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491670; c=relaxed/simple;
	bh=jEbsMly2FhQ711GN2jP5t9Qv9vt4zsmwcTKD0IWsKSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UqhlLQvFSvNrT3S9WAHIHBCZCemxvYZVmk4C9DJMqU+HbmQ3fGBgefA7xrkJeJv1KcsEbl2Q+0spWwE+d8pnT9VPKRJtwXznOix0FKZ2X5UTf6jXscTetyT/5jD/mp6+7sImJ1eCPM6i4J5YJ3LA1lhKD9sUe3Q1TMf9AIBeCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0Ig17JDg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45df09c7128so3233735e9.1
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757491666; x=1758096466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1alLi5TCWrgqVg4gWAi4guSOwfn7tcAcmAIIueAQAFg=;
        b=0Ig17JDg62mPBhDX25I1XWg+q6ToxeJhsYehamK3dYN7vIGIOkyI0aeZSA5qZmG86l
         2pP5KEIX6RlRy6AEa/U0rT7DAPm9QQu6YxeXgjpnesjfPqoq0hre5bm83tkBYika0Rby
         TdXrHC0ckRCs0l0QoJm8WzaaV6Gh2SxWHQzKB8zOsWgk42Y9aIvDv+78tRTPP6GTZnfr
         z54p5mJeDP6eeLJb38ftvBPnAio+GzcHNGzDwO+8IL+nTtlVwO9yvuU/waNM8L46pDlO
         ZUAqdlveIBNqJM15lSpKbpOIFvGh6kuJc9JLbpGQG7G2rBCffyQqHVqavUSwjTtgdQ33
         hNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491666; x=1758096466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1alLi5TCWrgqVg4gWAi4guSOwfn7tcAcmAIIueAQAFg=;
        b=h4jSA5IJv+GFxjpUN7w4gT50RM05DPfvSKr5q/uw9VlcL8hKnr/WMlBnsyksXZZOPa
         q1oRWOc8bLpiH7G0hZ5J50EGFixTBB9IdI+sft+ivdYa45sGXMreKkOjAdLA6FDRSFja
         pnApU6zXqELtKDvC+S7RwwznH6lve7rwmv8HVoA4go0D7mMIwRCNpSn8lFTjhiwEYuc2
         4LbM4VdWSud2kboYHi1RxIcZElEyCmDnLCgms5+BtCIZTlNieyk0EopSQZQttQ2d3hpY
         r6C0dEJwP6Qum9I3RrgYoJlZ80ybmQaVmpYMiO/32UEL9IGeIAGLlxc5ZFIto3BfcTJR
         bJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4CFFB7YcWbS2zvS3ejQhyz6hoh7qlXl/ddUTuOm96baE1JBEFqRmtrS9NoSDCVLMRUbZCODs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmO4n9Qxb8Jfi4b94qIvBczD2yL48zKLx+nlTUjx99N+VBR5mb
	uwoBun4c8TLRrd6qmwaEQhUm65iirYks8efjzfVol5IoinPwTjZxcua79yFC2W1vYSQ=
X-Gm-Gg: ASbGncvyMX0NKND2mNNMiB7xLP9Bm7aMCOZUhtogRYxnZKBT4JjK0WuX/5XyPVqRUde
	Z0ztbST6mRH8SKKqhIbVyYAczOQtu1gLMJ6gqscvuQmcLS1z4TurqnoV/50qrNtPLVJd1p1yP4b
	T82QifCXXqtL/rPge0fhkDVGMTr4oBb8Flp7VkVp7etW8FkMBEYsMtsAo3MgrtPqthxEV4RO3Kf
	T8jAt2KuIIWmkauYHf9TrC4vSksxiN/NOMLQOazK7z4Qg6FPHDGXFHDGzIB1Pb7pciR6/zS405n
	W9PmtBiEgAK2iXHXseuwYN2bQI0YgA/0dEnxlK5NbPD3VsQj7su+WNbHaEqhS9voQ0EW3bB1q38
	rgc0ah53j+CgPsA0kwA==
X-Google-Smtp-Source: AGHT+IHUfNjE0pY7vZ+IcCgXIXh8Lahm+PtGcdsfEFu9OwRBe2SmxKxdGyY8wQLIJhN0eScOcZH4jg==
X-Received: by 2002:a05:600c:3b97:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45dde200426mr141421605e9.11.1757491666390;
        Wed, 10 Sep 2025 01:07:46 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3936:709a:82c4:3e38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8247cc6sm17813605e9.12.2025.09.10.01.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:07:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Sep 2025 10:07:38 +0200
Subject: [PATCH 1/9] arm64: dts: qcom: sa8255: add ethernet nodes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-sa8255p-emac-v1-1-32a79cf1e668@linaro.org>
References: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
In-Reply-To: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6804;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=6sz23anPDRYU+tsW+2XaI9tMLFTu/c/A2ZuoT/MQdio=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBowTHMW6xqaogABRNf5jUw3TNxGIijVhn0iE2mz
 +JPHFY9Xq6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaMExzAAKCRARpy6gFHHX
 cokeEACkWEntE6cCSgV4bnEfG5JjbhSGi4KEv3WLjNNIVMmMVfSOm8K2pX2w4btzgnQP+pc/PR0
 R5RfDyNuRpjDjawkEmAmVI0gghRTBaPea5XNfJczc+FUAAquNr9BdGAnpejL1TP2LLYzb0pCu5Z
 HyVPHLlx5pXLQSREfLTxbal4NI99m4QzS6KNSrlYX5+pT7Xmx2Xfgmxk1VWv3/2irrZBEwjkUHW
 JFOiMMHtTe3oSNvZJMn/b1uyakFUGedEdNwc6UgfHZR9qMJcxpMQHC0hVX7EpUaAB3K8bNGBjxs
 VLK200yoFl0u+z9eyPIjFg1G2n04kpT4UavsqwSS2VVABsVElOxCCc94fWbsh+NC5+We34qaejf
 V/IaglWkftnQnnkByHw2TCpYqGVvqq1RQ6MZgBjxB5BsgMs8SW6kg7Ef4b6J+0DSFYZCW1gNRJz
 YiOXauKAIoa07K+tpYqBXZr3sh9P0aSmRD5pE+lvI5yA6wynpcAsE5QOVsS0ByV+ZmO3Dng1cbn
 Vw/wfzOxLt4CCA9L7J6clGkNzKrcwk7Wupq6z+9ng05E9IbPIdkgtRXGbaJeVsfSJgUWB3eZXzn
 Tf3FJkOwlVdpodvRNFeQfGlcUg2JYOUVwiqGvm9/JXSKVgOEb3zfqV8yV5+yOHnDZX5yXjlbuyw
 rWEI0tlQdSBnq7g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add ethernet nodes for sa8255 SoC and enable them on sa8255p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8255p-ride.dts | 201 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8255p.dtsi     |  44 +++++++
 2 files changed, 245 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8255p-ride.dts b/arch/arm64/boot/dts/qcom/sa8255p-ride.dts
index cb866f897d0a372ed82b08a1734202fddb4e4d3e..62b3101caeca2ef43b2eb096753dd38b665684c6 100644
--- a/arch/arm64/boot/dts/qcom/sa8255p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8255p-ride.dts
@@ -16,6 +16,8 @@ / {
 	compatible = "qcom,sa8255p-ride", "qcom,sa8255p";
 
 	aliases {
+		ethernet0 = &ethernet0;
+		ethernet1 = &ethernet1;
 		serial0 = &uart10;
 		serial1 = &uart4;
 	};
@@ -31,6 +33,179 @@ &adreno_smmu {
 	status = "okay";
 };
 
+&ethernet0 {
+	phy-handle = <&sgmii_phy0>;
+	phy-mode = "2500base-x";
+
+	pinctrl-0 = <&ethernet0_default>;
+	pinctrl-names = "default";
+
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+	snps,ps-speed = <1000>;
+
+	power-domains = <&scmi7_pd 0>, <&scmi7_pd 1>, <&scmi7_dvfs 0>;
+	power-domain-names = "power_core", "power_mdio","perf_serdes";
+
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sgmii_phy0: phy@8 {
+			compatible = "ethernet-phy-id31c3.1c33";
+			reg = <0x8>;
+			device_type = "ethernet-phy";
+			resets = <&scmi7_rst 0>;
+			reset-names = "phy";
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
+
+		sgmii_phy1: phy@0 {
+			compatible = "ethernet-phy-id31c3.1c33";
+			reg = <0x0>;
+			device_type = "ethernet-phy";
+			resets = <&scmi8_rst 0>;
+			reset-names = "phy";
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
+&ethernet1 {
+	phy-handle = <&sgmii_phy1>;
+	phy-mode = "2500base-x";
+
+	snps,mtl-rx-config = <&mtl_rx_setup1>;
+	snps,mtl-tx-config = <&mtl_tx_setup1>;
+	snps,ps-speed = <1000>;
+
+	power-domains = <&scmi8_pd 0>, <&scmi8_pd 1>, <&scmi8_dvfs 0>;
+	power-domain-names = "power_core", "power_mdio","perf_serdes";
+
+	status = "okay";
+
+	mtl_rx_setup1: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup1: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
 &gpll0_board_clk {
 	clock-frequency = <300000000>;
 };
@@ -59,6 +234,14 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&scmi7 {
+	status = "okay";
+};
+
+&scmi8 {
+	status = "okay";
+};
+
 &scmi11 {
 	status = "okay";
 };
@@ -75,6 +258,24 @@ &sleep_clk {
 	clock-frequency = <32000>;
 };
 
+&tlmm {
+	ethernet0_default: ethernet0-default-state {
+		ethernet0_mdc: ethernet0-mdc-pins {
+			pins = "gpio8";
+			function = "emac0_mdc";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		ethernet0_mdio: ethernet0-mdio-pins {
+			pins = "gpio9";
+			function = "emac0_mdio";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+	};
+};
+
 &uart4 {
 	power-domains = <&scmi11_pd 4>, <&scmi11_dvfs 4>;
 	power-domain-names = "power", "perf";
diff --git a/arch/arm64/boot/dts/qcom/sa8255p.dtsi b/arch/arm64/boot/dts/qcom/sa8255p.dtsi
index bde94f8af8f7d2844855fe7ce432dbbaa996b6cc..144745b2ac75b5d42b682bb107ebe4b27afb6644 100644
--- a/arch/arm64/boot/dts/qcom/sa8255p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8255p.dtsi
@@ -1093,6 +1093,50 @@ cpufreq_hw: cpufreq@18591000 {
 			clock-names = "xo", "alternate";
 			#freq-domain-cells = <1>;
 		};
+
+		ethernet1: ethernet@23000000 {
+			compatible = "qcom,sa8255p-ethqos";
+			reg = <0x0 0x23000000 0x0 0x10000>,
+			      <0x0 0x23016000 0x0 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+
+			iommus = <&apps_smmu 0x140 0x7>;
+
+			interrupts = <GIC_SPI 929 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 781 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "sfty";
+
+			dma-coherent;
+
+			snps,tso;
+			snps,pbl = <32>;
+			rx-fifo-depth = <16384>;
+			tx-fifo-depth = <16384>;
+
+			status = "disabled";
+		};
+
+		ethernet0: ethernet@23040000 {
+			compatible = "qcom,sa8255p-ethqos";
+			reg = <0x0 0x23040000 0x0 0x10000>,
+			      <0x0 0x23056000 0x0 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+
+			iommus = <&apps_smmu 0x120 0x7>;
+
+			interrupts = <GIC_SPI 946 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 782 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "sfty";
+
+			dma-coherent;
+
+			snps,tso;
+			snps,pbl = <32>;
+			rx-fifo-depth = <16384>;
+			tx-fifo-depth = <16384>;
+
+			status = "disabled";
+		};
 	};
 
 	thermal-zones {

-- 
2.48.1


