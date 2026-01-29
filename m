Return-Path: <netdev+bounces-254578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIdIMvLzemnDAAIAu9opvQ
	(envelope-from <netdev+bounces-254578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:45:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F355AC050
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DE84301A173
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB1D28980F;
	Thu, 29 Jan 2026 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FW84raqn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3BC2E888A
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665502; cv=none; b=irB1OvdCD7kZb8SunqHzPfpxCJfsgXadDiYuo7cyOF51KURYnbNgEoNRBQLZg+cOV6iSTgvdE8bPGK+AKZJaZdJ+0hfs2xHvnvRdhZvmWdAU1xYgbvt8rto7G62jBDGQT1OWfcAXmYtPGEPAZ5SkOxICVbMQDNqTF1xnEsZ2lBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665502; c=relaxed/simple;
	bh=mMUEjhgW/5EiONAKuIS8GKt+cJgfKaYbY6rN4sYHBj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4w7tZlgil9ul2ICdCTri/jZg+VFAHamMRKAvArYGOKkbET8soDgh++O4DUo/4/ayaRVW6a5gikN5MrpjoYPBgPwlmplokYiMqtND/KuCKWwpdm+LPhGRsf4nT9jSD9ZpXb1h2337ReBuemFHKqZCFSjhNwp12A7gPwiCMYEgdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FW84raqn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81f47610542so319537b3a.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769665500; x=1770270300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNKXP9GpRqv+eSR2XeMEVjl61X03fT0QbLuz4FZVIqk=;
        b=FW84raqnUo5HRe5JzNBrQJhiVYIJzaR/F3H2BwYZL9+8Y3RMvu1pfwsQGLRdTsQeB6
         xF64v3BF7bLGSxte1lUrHXquzZLz8LYSJ/YhGaqJxKjr5u+Pvwb46fD5giWIg/yyQsC1
         hxTrCFJpz2PUbr6Ag+FCdwLzUa+WQutflN2gcerf7SexyWX0Es763aikp5T7Ft1r/nEg
         yR0FND4b7rvf9kwplXWktP8EjIQCcsQ43Txpa3PojYNMQj4iY9vPpP0flfj0g7BkmEtx
         Dnr03JQ5OS8SbciXJFqmWWEoyWq698GqIj3wTqSDwBeSwuY2lHE3xv0XXE1JTR6Ys+Qr
         dLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769665500; x=1770270300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CNKXP9GpRqv+eSR2XeMEVjl61X03fT0QbLuz4FZVIqk=;
        b=Q+cd2XEzUJQC+gcpXbRTSj5uEs3YXiMS9C1fD238H5XpPn5XA06YP1CYX3uKm34D6F
         DEkkiPbgUZaa9l6CxEwjE0dm1kLoA7LnIn2A28U/9MVQfnRsgvDzOVcKE8aBEQNxB16d
         u7xKVkUSnEZf0Tl6+6TAPqdSG8Fc5dVnR8oFqcIdX2UeWnHurD8Fatr1sGGoUdASEegS
         itOA6xdkasdvw88zzCfvbbR6Xn8w4YYYnNCv/xzURaP8I0aQuKWFNMFOFMRuBSZGByvx
         J2GJiZW0wjMS5CXMAaJVBnmsnCzdoFQ1Emzgk0pw/dFhRJjSGejXgh6qjhSlHzrdJnGZ
         ISlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqFvE7fzvR6jpFB4eTrsdxovPaoK18oOUSiDyhpkAdiauO7/CF1BajSCNOj4mg7syPPAL7abU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ5+f241+Dm1JVJAbrG6zO8pr8rciqlOPFnaKD23TJUUl23Kb6
	P9pAE0WEnFAKswmGKJoqPU+s1FSe/khcSWflUuoKVZWnkUh6EbwtqcSz
X-Gm-Gg: AZuq6aKb02pnVTK7vNLdEXdKYcq0n38cXJeMw+HcI6FlZhWgLX1TqZG4VWzCuTSUz7T
	yk9UAMJjkqt2SHoAQa44pHPe8ZdbJs+LXYtnuR+jL1Z+ks2wEx6EnO+gsAjizGFN0/C+jH+Ctkw
	MVksek51J91zo1t2gEHYvFYfXD4fJjFDFzVUgm33EiDwBDbT0JYi4PmJSEvPpZGKROcqGl9oV+U
	QYtXI4IsVq/usFzmumuvAjUWRCUX1lkEHVLC8m2lzqXktvwRu88n2zAGn16MY/NvnMgSXWBVx9H
	Zzd6ZEnJbkT17TrsRtJfD80CcfQsupELPY8OPy52K/Vp/ZMzZDuvMXUyUgYOJpBSEzr0wpBdHOs
	IDSoWsJhBAfNfMzMk+uAENWX3Gqh6oLONdd5NcP37oDyKIzUOgKMrCJd3yZ+CUIY2HDNo2qPpEP
	dP98NigyBQUG2ftnpSzuJKFJS9vT7/QZmniSJYQGnVKVvIRjHW4LInBi1n+sGodZSTZcXQ44da
X-Received: by 2002:a05:6a00:4b05:b0:81b:ab6f:2974 with SMTP id d2e1a72fcca58-8236914c661mr6509292b3a.9.1769665500190;
        Wed, 28 Jan 2026 21:45:00 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c227c2sm4108364b3a.53.2026.01.28.21.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:44:59 -0800 (PST)
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
Subject: [PATCH net-next v10 2/3] arm64: dts: nuvoton: Add Ethernet nodes
Date: Thu, 29 Jan 2026 13:44:44 +0800
Message-ID: <20260129054445.416242-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129054445.416242-1-a0987203069@gmail.com>
References: <20260129054445.416242-1-a0987203069@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-254578-lists,netdev=lfdr.de];
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
	DBL_PROHIBIT(0.00)[2.111.199.128:email,2.100.46.192:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.1:email,0.0.0.0:email,2.100.85.208:email]
X-Rspamd-Queue-Id: 4F355AC050
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


