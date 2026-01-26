Return-Path: <netdev+bounces-253412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBPXGxRBd2mMdQEAu9opvQ
	(envelope-from <netdev+bounces-253412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:25:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E5786D69
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B78D1301DE0B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4523132FA0D;
	Mon, 26 Jan 2026 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzPrZysJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA1D32F761
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422994; cv=none; b=lCWWtWRDhqJxj6DYoE4lp6KkylGxTOMtvHNBrnXmeVp4iZZdLlRZqmYmVibNq58g7cg8ptr50N9sXcy7RFx7NKDElKAA/Y0xD9Yp+Gj0aqEf9/7VGP7Qwk1/xBNDUMoDvZQvZQN/Kxu3SPwVGFRvVwAW6mzSI1QBXEf7/luu/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422994; c=relaxed/simple;
	bh=ULovLn4XyOEnXyl4EoSszEP7+/PiY/2l5JsqJdnUsmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwbJtYsK6H6Wrq0eDzvfruzr4VU13HQym48JT/Mr6Ay0v7mxOAJqyFC9UVPH8wv/+ngJp/740fJzOm5diqKXXs8G2EDwBdW90d9eToKZP5w9f/Pkz9LJHvb1n1LLSmGuB1nfeNgtlsf6fqJAXXq15hv0ZuE7HUshsFXd5yjTjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzPrZysJ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso2791506a12.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 02:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769422992; x=1770027792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YG5zC5nRKtuL2pWJfWd5vRZ0VVU+WDTQCf+ZvwSm3ng=;
        b=LzPrZysJ9GdegDfGz3rGTDQRyeYy9d3V4h/CQwmn7plf9AOk89pog1s5b1Sv57LJhP
         PFzH4ttXSg/bptx3SQF+M8auBq8zNA4wF8wNaiv9KnOU7S2q1yv7MFNAUY7ltRAaXEjX
         7dqPjXVpLxSQNe1z5Ta4MVRP/O/Ac/LtSUFBj9hmMP2aiZ1newk9qWSLfB9wHXztK4Dp
         QOEVAtz/OvIYT3C1fYcObhVvdnyk7BVuEMr9VgEyoDjmgZG0bSVJXRHPmuXiTY/kkCyd
         2P4rTDjt3lbAfPaUvf3jXfm75AIOV8UjrkRxwqd2teja6eUramdCKJXKUJOOxcWV8RBx
         rmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769422992; x=1770027792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YG5zC5nRKtuL2pWJfWd5vRZ0VVU+WDTQCf+ZvwSm3ng=;
        b=c4bYePa4ePE91h6sktxpVSejv7vUkWOA5DG8vYtIgLmtd1GY0z2Bd9eyKaGPRMN/bS
         EHqQdG3zwDJTuVT0VDw7U0KKlRQCrAniZxw2rk7XdbmXhf4BdOI6hbjZEqvmUU3sK3PU
         yWuPxJDPISgwJSli+1kRHU8F3rxirVLPIcJ2uAoCZKbLJfJe8vlNv4Dml5mWNvyLw01g
         GCioJML89j5MS85PXxq6h6clR6F8SDnEAWndK+lz+1dCaNwSDxWfyY2A9XhNBYK4v2Zi
         r4xeqAhMimL5cZu3CNvn20WgtTJRUz2JScB5CF1u6x1su172aKs8pNPbqx7mOsd9ibLq
         IzvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjYr6Kcv2Xrty+7yCFbmqc5E7rdlySh526pGZdN9PVHlDj7OZoLZrQU9geo8KJhUlBMNbb8bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSwjip4S+FNCZ4kT/9GEmK2JhhlCudKMu7jHjIDn99vTNQwNc
	aWIrXjLM5zunz2RJyWbRCrn8UVlwBSiCBNmIQlfoB6DnBHgtRPlCS0Qp
X-Gm-Gg: AZuq6aIwHkxO0Ar8dFeIWUsTbFagpOn6WFaOc7DYMrBr1L6AmxHVLwmlsBOfH5SR+ZZ
	I1JvpNVFFdhmROgjTLpdJDg+ZN5dYoFHhisODI1qgQ/ivCFcCuPyFdT8xyrFGwhWz8C8Txqj4+E
	Yefrz/il0o1fv2QxRYDNAxl6iI1fME1J38Kqr9l3vrz6C51SuV7bBbrjWm3UgcUmotm1TUnHtmN
	Ng5YvRSwxB195TD0OjYvlAqCKqfIiSqGn5Q3+EhahP1OhFgEmh74CR+24gg+1Jci2Nxs8Rags7Z
	fewV4qILhxhBYbZGG3AXpoprAmjwe7Ie5D+06JbSibP+v7A7Cc0nSlFNmTJBEdU51SoA/KtCbdv
	kPnNOEYw9aTZMwzGAZkqpGlDfLuBSknxih7lBcSbwfTxjpZIRfn9Y5ttykR0mNa3xUuz29l2zkB
	Q23xPJ5CAdIKkdNYn6+9hqXrXRyNygP54rncx5SbfJYu21iXeR864/i10z5Yr+McZwhYpygoYl
X-Received: by 2002:a17:902:e5d0:b0:295:425a:350e with SMTP id d9443c01a7336-2a845240123mr34633815ad.8.1769422992175;
        Mon, 26 Jan 2026 02:23:12 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcd776sm84958275ad.26.2026.01.26.02.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:23:11 -0800 (PST)
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
Subject: [PATCH net-next v9 2/3] arm64: dts: nuvoton: Add Ethernet nodes
Date: Mon, 26 Jan 2026 18:22:56 +0800
Message-ID: <20260126102257.2619862-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126102257.2619862-1-a0987203069@gmail.com>
References: <20260126102257.2619862-1-a0987203069@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-253412-lists,netdev=lfdr.de];
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
	DBL_PROHIBIT(0.00)[2.100.85.208:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.1:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,2.111.199.128:email,2.100.46.192:email]
X-Rspamd-Queue-Id: A8E5786D69
X-Rspamd-Action: no action

Add GMAC nodes for our MA35D1 development boards:
two RGMII interfaces for SOM board, and one RGMII
and one RMII interface for IoT board.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      | 33 +++++++++++++++++++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 32 ++++++++++++++++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 32 ++++++++++++++++++
 3 files changed, 97 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
index 9482bec1aa57..ee32cedf3d9b 100644
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
@@ -126,3 +128,34 @@ &uart14 {
 	pinctrl-0 = <&pinctrl_uart14>;
 	status = "okay";
 };
+
+&gmac0 {
+	phy-handle = <&eth_phy0>;
+	status = "okay";
+
+	mdio0: mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&gmac1 {
+	phy-mode = "rmii";
+	phy-handle = <&eth_phy1>;
+	status = "okay";
+
+	mdio1: mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy1: ethernet-phy@1 {
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index f6f20a17e501..b1b3e45280d5 100644
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
@@ -129,3 +131,33 @@ &uart16 {
 	pinctrl-0 = <&pinctrl_uart16>;
 	status = "okay";
 };
+
+&gmac0 {
+	phy-handle = <&eth_phy0>;
+	status = "okay";
+
+	mdio0: mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&gmac1 {
+	phy-handle = <&eth_phy1>;
+	status = "okay";
+
+	mdio1: mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy1: ethernet-phy@1 {
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index e51b98f5bdce..477515ba9a80 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -379,5 +379,37 @@ uart16: serial@40880000 {
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
+		};
 	};
 };
-- 
2.43.0


