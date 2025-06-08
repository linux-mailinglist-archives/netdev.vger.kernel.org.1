Return-Path: <netdev+bounces-195598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4B2AD15CA
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B873AB497
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77160269AFD;
	Sun,  8 Jun 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPMHwdWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15752698AF;
	Sun,  8 Jun 2025 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749425405; cv=none; b=upgSnxaIVZ+RAKr2fJk3//JcKX1yR3fGNLg1vFbR3CK5AgCstKHJt19OjmghklhQ29I00/NWjx+vSoqQsdjcDywHYncGX3Aft2Tk1KcjE61jDcgjj+Na6NujBTNO7BVgqSje4zhjwFL552wqr1hLCjb/u0RtDlkvDsVvCNBygIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749425405; c=relaxed/simple;
	bh=kKSJSzDgmtp7GAPS+CSdDmN5CtbYe+06/Vh4apMiD2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQGAEiZiqO8px7Cov7QT6fJubwktoTf2NaShRjCND0ORIzp2CFd1cPGGmnUbcHyPsRW6Dr1p7gM6azitOadRUuh3Af4gl0EO4Jr1vpvlUuaL6D8PJdoYh1026U5FPy+efbhW8E/ppNsBB4EbhRlSxBXbVexLLMucyLGbUgXDOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPMHwdWv; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a43cbc1ab0so45421441cf.0;
        Sun, 08 Jun 2025 16:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749425403; x=1750030203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmTQdXSUpQ4hD4RssfVmKVveK6myf0C+7VFTgPHTK8k=;
        b=IPMHwdWvrb88iBrloFv9C7oOXkzDZLWFaR4MFjfOREfNDxT+2UOqC6/CTS3ddHiqwB
         dlfp6RyM0c3j3922/J3JEk6Z5wBD802d7GW+SU/VJn4igAFS0q7iOggsJHJbs7BD3ghR
         CX5cE9eOeelGnLsxW1z/ffNdnuVye/EYfKppXcD8sYF0Cn2fx96BZsBDcMMcqxrjF/Wi
         QUHse7sYcDCiVQHY/S08lQX8ifztrFSsCEpRSUrPP7wRHhsQps9lTzWjv/LCrFZ2gFoK
         qJapkocE3fpteLh8c+O6TzZc/Ae9GbSBil4PsPm92Y3hK7agreWLAVTVNy4qNNG6s6ER
         1QtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749425403; x=1750030203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmTQdXSUpQ4hD4RssfVmKVveK6myf0C+7VFTgPHTK8k=;
        b=L/AUktZDaUoH32Csquhe8iK4M90RQa7ch7G1F8Tf7ywTmKl4Jr2+/JFHlQ/+Sdaufi
         ES5UYUzh90ALlBGAQAyQd/qdw8iABR0CwXVJ+2e53nqovJ9IXwDJdK9lNsEUKHh/fTcy
         +eenCVr4x5dRoHI7I0JsAQLpRWuHp0cnErK0p3Zf1Evdf6czLSPVhAGeziXArHyRcENG
         1Md5cx3jN3IOyv84NoxiQd+/b+qqztUWw+GrrenFqb1MsofyT5YsBft1PFkOKvYPBI5E
         c+TZSjc2rNZ3vKqA2LX075nIVlsQGC23mNgYAGf89WunRehQsG5kz6TCflSdPd74NFMm
         HyWg==
X-Forwarded-Encrypted: i=1; AJvYcCU9Op4yWDMNPZ4SX0alOVwKjFx9WLf4UFKXrLZ+jmWYsZUeY6q9x2yjM0ig8njo1iAQ/cGEZwZ8@vger.kernel.org, AJvYcCWeTdDVbAwgJKJFRgdIqiK/JoVLqxad4JW+pjzHsDJB6BmSL7ecPNtvjxw5GaOCbEVG71j5hqTuGktH@vger.kernel.org, AJvYcCXupgymZceVoqujfgbJx7cyG3L0xRMb3KDdzCb0PS1fYseymWyXUo4cHua+60uesAu6AlTE2AF9JA6BRQBQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxLtryNkbr2MoPGFiSnWc497TIX40z1zg5HYnzAcB2G/8h9eoTn
	g++Opomzd9gLmod6qlIASY9AmdXBYQJohlPoB97wfXnCiYTuCe39KclI
X-Gm-Gg: ASbGncvEOM3wL9fdiFtiU38TUUh3qlzoJ9WIaGmNCwBQ6yXucm7uAPiWp02dO8bP4AT
	/W1V2HzNqzfsdkyMYnNxcjH2NIs6xkM31gJm63Aa/uTttjK3SZ3zteHeDq7CDK3PRaEkFv+Os5e
	xWAur2Ex2W8ft9D41NwANLB517RPoeIKbv9cHel+rpEFGvc9DTdfhahGR0z5jbTG+fjlrPR+ZIv
	GFDEKueuCR7COCH4AS1FI2oPrSkOH38OY4cQOUGC0h5Xr01drXAltvRUNXmW2ATR1RNT5EcO7ES
	hYmbTUD4WvN661+VkAd1G/vTInY=
X-Google-Smtp-Source: AGHT+IGtPVr3vTtnHXhXGMrBCPsB3mR48xsd0pogO36byxImz47783KZFg2uYMwvdFSvrVGfpQLmDg==
X-Received: by 2002:a05:6214:2426:b0:6fa:bf2f:41a4 with SMTP id 6a1803df08f44-6fb08f4d14bmr179466146d6.1.1749425402761;
        Sun, 08 Jun 2025 16:30:02 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09adc0d9sm44053546d6.52.2025.06.08.16.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 16:30:02 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Longbin Li <looong.bin@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 06/11] riscv: dts: sophgo: sg2044: Add MMC controller device
Date: Mon,  9 Jun 2025 07:28:30 +0800
Message-ID: <20250608232836.784737-7-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608232836.784737-1-inochiama@gmail.com>
References: <20250608232836.784737-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add emmc controller and sd controller DT node for SG2044.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../boot/dts/sophgo/sg2044-sophgo-srd3-10.dts | 17 +++++++++++++
 arch/riscv/boot/dts/sophgo/sg2044.dtsi        | 24 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
index 54cdf4239d5f..d077923097e8 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
@@ -27,6 +27,23 @@ &osc {
 	clock-frequency = <25000000>;
 };
 
+&emmc {
+	bus-width = <4>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	wp-inverted;
+	status = "okay";
+};
+
+&sd {
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	wp-inverted;
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index a4d2f8a13cc3..6067901cde1e 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -111,6 +111,30 @@ uart3: serial@7030003000 {
 			status = "disabled";
 		};
 
+		emmc: mmc@703000a000 {
+			compatible = "sophgo,sg2044-dwcmshc", "sophgo,sg2042-dwcmshc";
+			reg = <0x70 0x3000a000 0x0 0x1000>;
+			clocks = <&clk CLK_GATE_EMMC>,
+				 <&clk CLK_GATE_AXI_EMMC>,
+				 <&clk CLK_GATE_EMMC_100K>;
+			clock-names = "core", "bus", "timer";
+			interrupt-parent = <&intc>;
+			interrupts = <298 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		sd: mmc@703000b000 {
+			compatible = "sophgo,sg2044-dwcmshc", "sophgo,sg2042-dwcmshc";
+			reg = <0x70 0x3000b000 0x0 0x1000>;
+			clocks = <&clk CLK_GATE_SD>,
+				 <&clk CLK_GATE_AXI_SD>,
+				 <&clk CLK_GATE_SD_100K>;
+			clock-names = "core", "bus", "timer";
+			interrupt-parent = <&intc>;
+			interrupts = <300 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		i2c0: i2c@7040005000 {
 			compatible = "sophgo,sg2044-i2c", "snps,designware-i2c";
 			reg = <0x70 0x40005000 0x0 0x1000>;
-- 
2.49.0


