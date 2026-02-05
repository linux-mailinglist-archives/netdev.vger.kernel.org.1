Return-Path: <netdev+bounces-256901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCPaBVT1g2kwwQMAu9opvQ
	(envelope-from <netdev+bounces-256901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:41:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC1EDBE4
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2529301C6F9
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 01:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFAC2BEC34;
	Thu,  5 Feb 2026 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbkNVdhG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19729AAEA
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770255620; cv=none; b=c23N3/BT3A7P0do4P8yPqlGoTqQV4OiMgyZ8h6x0Wdr1U6evXZG7G+FvJ9o0lm4axQS3x+q2SAD4tUFNg9vNU9tx1qVwIAFVhJkLuv3NeRjK4TB+e4et2R8hEAx/VlGpN3LL5p8L/ffwo7todnaTf/paJhHJVmLf84VxfiayAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770255620; c=relaxed/simple;
	bh=mMUEjhgW/5EiONAKuIS8GKt+cJgfKaYbY6rN4sYHBj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxXmjs1DynGntzaST/NKurSc4rcMqDi8eQroV8/I27ajLULPkjQwZO3itpWy3tvIKTALvTbOdS0Ilk19FV6Z2gsnwhIHHFS9dhl3ylUq2n7XJlq/afZh4x9WPBr5J2mz1D9C9CESjVdythfoS+pIaoQMn/5QZkJ20/mT63C7O/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbkNVdhG; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-352c414bbbeso801780a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 17:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770255620; x=1770860420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNKXP9GpRqv+eSR2XeMEVjl61X03fT0QbLuz4FZVIqk=;
        b=HbkNVdhG6io1nbfKJRdEKIDpibI+0EkKdarTbgPyLZY7CR51eVSLhawn259ZP3uw00
         XvJ9LNEhHBTarMJ2HnCr+DJnADEhrvlpKPB1Hq5o1QAU0ZuCbxmWsVmW80t4gH1pxobg
         +uoutY2ZT5SzNTc+BGtCH+zyvjbqNwucDprm8nYK4Uw06YW2YFyS5g9kBTmGyGKTPzxT
         2fFwFF1c7g4Wn9HiIMWHxmijOHq0ehwPdb3Lov90LKi7ghgdFF1Nmv2mD7UyNE8hJ/Ba
         yT37r6LnzJ1pslIea/vWV+GxQnTgsNeHcMNEsNmE2UWQJB6W29f+Ecfg5YnrufjvNMvo
         nrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770255620; x=1770860420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CNKXP9GpRqv+eSR2XeMEVjl61X03fT0QbLuz4FZVIqk=;
        b=RhUqqFUHf+oqtK7PbuyX7rkt6A1Wku2rIzwNywukQU3Qgv684jaSDQGpjYgNGyBtzn
         HX9VE6o3umzavEdvYh6CmVm+fDJfiRevKWT0IQygLVGTG1Ve8XOyQGbPE+tlT3jw+Th2
         x+2hL0Fm/cdTIjL5YBbdPW1qHubyy915mBDCFP56OZhNcla2gErwfjsoWf7gYDQIhpGk
         e0Jl7KGbfgdaquiEy+Jc8/XtlqAwGSXqDcrTMuLfeCfYIC+29FbuJdUZVQNJRqnAATjh
         8q9lZhijLTulNLfkmJDz3Gz+9bVWS2SVHoFljFbTId6/jJuv/JW4IPrp+SAIt2zbhHE2
         Tccw==
X-Forwarded-Encrypted: i=1; AJvYcCXPTpuK+nKRPt7SgmUOYwM/vYw3cSs8u8RUxbg0lnCMHpUaaZRC7+7LC4nArgypiQp02yPXxUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGbzDNMZDA8c5Re+kqLF0y/RK1Fdm59cXsbg9/y8oqFtrzocP
	8LMqzPG0uPIxno6f6YYurz5txyGU12EMD9UuJv39NDum3Xit/dBvt+zY
X-Gm-Gg: AZuq6aJulpm31OyLBi8zvyi9lsUWk7Wu5iFmxT33Mbse7i5+hXKCX6L806xkpZQ63ra
	hFl2c5BxyysDxDHe79Q7fS/nCkaP0+hDZ1Bo+v7iq0uJ7nQwMuK0BksD+Ynh+sz2F7vK/C7Ym8e
	hZWbQekYgWKZD74/l3MfoIOVynfhZMr/wuMJ9IrVlj6sSYr8kJmS33quRQcpxUJ13/JKUaeCYQa
	awy2B9o1P7GIBV60+IWOTYk068mOt+OxgBGLTKkPps77MR8zak9EyR1ypxKdNehLmnU7iaResjh
	2Fw9W1XKvFfdsxCRxBenqpZeLDTHe8ljohhygT0ugOWmx/hXFY82NdAshRwxH35uHF6t9HD0PhB
	+8RFWWgrjSw/BqdKLaLSEnkZXKb/k8vwMn3lZoNiZVX53y+ahuAhGEjHIRFFL2/R7mEE8D4HG3a
	yTsA9fH0TSOAJTV5GlLhvGXBnrFMGAW8i9gHqdW7RWq+fE7SWavd/qSAPcY4yRimDMZ1mhhc4e
X-Received: by 2002:a17:90b:3145:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-3549be5a5f5mr861415a91.5.1770255619864;
        Wed, 04 Feb 2026 17:40:19 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c487a7bsm673571a91.16.2026.02.04.17.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 17:40:19 -0800 (PST)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	yclu4@nuvoton.com,
	peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH net-next v11 2/3] arm64: dts: nuvoton: Add Ethernet nodes
Date: Thu,  5 Feb 2026 09:40:04 +0800
Message-ID: <20260205014006.735408-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205014006.735408-1-a0987203069@gmail.com>
References: <20260205014006.735408-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-256901-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[a0987203069@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	DBL_PROHIBIT(0.00)[2.100.46.192:email,0.0.0.0:email,2.111.199.128:email,2.100.85.208:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.1:email]
X-Rspamd-Queue-Id: 82CC1EDBE4
X-Rspamd-Action: no action

Add GMAC nodes for our MA35D1 development boards:
two RGMII interfaces for SOM board, and one RGMII
and one RMII interface for IoT board.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      | 25 +++++++++++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 24 ++++++++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 44 +++++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
index 9482bec1aa57..78534d613486 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
@@ -18,6 +18,8 @@ aliases {
 		serial12 = &uart12;
 		serial13 = &uart13;
 		serial14 = &uart14;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 	};
 
 	chosen {
@@ -126,3 +128,26 @@ &uart14 {
 	pinctrl-0 = <&pinctrl_uart14>;
 	status = "okay";
 };
+
+&gmac0 {
+	status = "okay";
+	phy-handle = <&eth_phy0>;
+};
+
+&mdio0 {
+	eth_phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&gmac1 {
+	status = "okay";
+	phy-mode = "rmii";
+	phy-handle = <&eth_phy1>;
+};
+
+&mdio1 {
+	eth_phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index f6f20a17e501..a029b660e8dc 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -18,6 +18,8 @@ aliases {
 		serial12 = &uart12;
 		serial14 = &uart14;
 		serial16 = &uart16;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 	};
 
 	chosen {
@@ -129,3 +131,25 @@ &uart16 {
 	pinctrl-0 = <&pinctrl_uart16>;
 	status = "okay";
 };
+
+&gmac0 {
+	status = "okay";
+	phy-handle = <&eth_phy0>;
+};
+
+&mdio0 {
+	eth_phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&gmac1 {
+	status = "okay";
+	phy-handle = <&eth_phy1>;
+};
+
+&mdio1 {
+	eth_phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index e51b98f5bdce..a39c3640b322 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -379,5 +379,49 @@ uart16: serial@40880000 {
 			clocks = <&clk UART16_GATE>;
 			status = "disabled";
 		};
+
+		gmac0: ethernet@40120000 {
+			compatible = "nuvoton,ma35d1-dwmac";
+			reg = <0x0 0x40120000 0x0 0x10000>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
+			clock-names = "stmmaceth", "ptp_ref";
+
+			nuvoton,sys = <&sys 0>;
+			resets = <&sys MA35D1_RESET_GMAC0>;
+			reset-names = "stmmaceth";
+
+			phy-mode = "rgmii-id";
+			status = "disabled";
+
+			mdio0: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		gmac1: ethernet@40130000 {
+			compatible = "nuvoton,ma35d1-dwmac";
+			reg = <0x0 0x40130000 0x0 0x10000>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clk EMAC1_GATE>, <&clk EPLL_DIV8>;
+			clock-names = "stmmaceth", "ptp_ref";
+
+			nuvoton,sys = <&sys 1>;
+			resets = <&sys MA35D1_RESET_GMAC1>;
+			reset-names = "stmmaceth";
+
+			phy-mode = "rgmii-id";
+			status = "disabled";
+
+			mdio1: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
 	};
 };
-- 
2.43.0


