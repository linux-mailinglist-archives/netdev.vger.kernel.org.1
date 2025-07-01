Return-Path: <netdev+bounces-202716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FD2AEEC03
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B557C189DCA8
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817E51D5AB5;
	Tue,  1 Jul 2025 01:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQo2xL65"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEFC1C84B3;
	Tue,  1 Jul 2025 01:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332681; cv=none; b=YRH2wyxbderjGT7p0uMuklYN9hXA1KIysuQ4jc2ZGMN/WtBChLm6/cXwlNE0DaYzDdOkWiFOztyem5wjeHTQdPRvqeK+h3fXgtca1aQ36twDR2Hg9Gr4zOXbUzY2DAhHCGoGYt5Z3olDq81pm1+kjlmD8AzFVuU+jY1Xj7cmenw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332681; c=relaxed/simple;
	bh=R3+mZ/ahgSxUz73+rZU26mssIWzCroveyiCdoSoe6Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rn5EZkVTafLAzQp0YU2n55meOqLLUOKwoAZbTI5NHvP1EzrOrDJIuEqhk1LB9DNYqJwIZSE/rzG4MvKv/UuwzUS2IV8VLb2Ztg34ZGW8oaUes/jiIaDK4YcUigQePZVWaOxJveoMble6ZRZ+ZhbBZxrygkhe2KAVZR4zbMOKyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQo2xL65; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234c5b57557so25247425ad.3;
        Mon, 30 Jun 2025 18:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751332679; x=1751937479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2YnPV5R9z5TbfIfu+epngB5XBVjG855v9YBWyemiuo=;
        b=mQo2xL65wMgCHimTGCdRSO2TQS43Tvnuf9SIEl/av3vsLKJ1AHauHVMtBI2r3UT6zb
         TDwgPRvyyo2TVgM8Mca7ytCU6skxEMBPyS/6Hc8zuGhLcwfLwlJRTtHob2db8gnwCBLa
         aGbv0aSKfYcakgtwCAhZnpZgLjRGZm685Sf6i8Pw6GGSF5uWHJRxwTDyQ7HPrk8EkPG/
         WNgXrarsFvzylSWyMJiRpX8HiWssXc/kQff4GkhHapY6ykEf4eulFhiexANPUU7ENKKM
         qQvtyrFX4AaEDBv4aPkeLhO5GO8WpR19eNFg83ruZZsP7v4aMFpEBwhbiygQli9FKfYD
         VV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751332679; x=1751937479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2YnPV5R9z5TbfIfu+epngB5XBVjG855v9YBWyemiuo=;
        b=NVM1mXOP9X7Zib3jAM/8EXrYnS4TGkZD8wedJ2lO5/lOiKzNCKSXelrlg2qhdLlyCZ
         oyTkWu2/inqvEH+aEOqcdXXvrA/VNH9kw8//u4prdQVw+zA5odsX/saCZ0NDxD53TK3+
         Z1NQp+qhgNjjy87klnwZUMHOsy8IpkqlR4jyRynvfzZ2N4tYZ8/6XNo1jOTX+R9mBEoj
         j0BwCMPcedcFZHxIh1KvbcZdMz2ppUoh6ulo0cfOa2mQ+v0aSnDtgKMorjlIOovJz+GY
         FkWoZRBzxB8JMyDzWayqwmsMmVY+1r4hARBZhb2OxTZkao6z0xsDjoCPdgBv13O7CfIl
         ATfg==
X-Forwarded-Encrypted: i=1; AJvYcCVI0K+v5Df3SWsskBvCl+bVUX4LmoP94vnaswsd66mNv8X/sT/eJJqtNMoOXeyANjZCpSmIHPJySaxHv/RD@vger.kernel.org, AJvYcCXsUEW9VTznWg+7Tzrd54/EPE8dF/pR4IKb1Bvqbr2K+gxMLBjpMfbArJV9UDNC5bWIUWOe6FMxTDM/@vger.kernel.org
X-Gm-Message-State: AOJu0YzO2ElSSNZDEoAfO+6U/W9sTMHnpKKSYNUFeFrri4+0br4i0qQ2
	jy0vrihlLniT/pR5vLFMnPDr6XkkrIwtkIoE2O3KFadoOar6zjoakNLJ
X-Gm-Gg: ASbGnctPaXettzkewcTk1sM2Vc2YUcwAaX8W79pZ987NQ/4OxFrBVoFzvTdp7NzxYpr
	6pRPOKBf+FwT1iOsG/+ow2dGx52fDk6jSPhc+5brQlu/Idrnr+DNkn7D/Asvnwj0tv4mHRMO+NJ
	Feoqcmyu0OTxSv94OWRKoIb7a6bKg6AeJPwQeDn6Ny69QFeKNpzQ6MfzRPRM8bCglyCD8rKHoPz
	Zwa/U1Jgrdwq+dsTnR2rfUbYln3J5xBGbwO6sM0bW7T7JUJgu7yL7o5M3qNQM4tCRoCyi9VM9Ot
	MphsGWBzoTU2hxzj2hC6TanM5CnRaPtBIhREGtQ6XNNAyok0/8SGDHjjG1fU7Q==
X-Google-Smtp-Source: AGHT+IEPm2Op+KWjehC59VQnKMDkBVgZ/YpPUASGIk3XgNcj6OU/ub8JMgiDzUUFauKHKc2q4eWCfg==
X-Received: by 2002:a17:903:b86:b0:235:c9a7:d5f5 with SMTP id d9443c01a7336-23ac3cf5f89mr243983855ad.13.1751332679204;
        Mon, 30 Jun 2025 18:17:59 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2f0b91sm99104865ad.53.2025.06.30.18.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 18:17:58 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next RFC v4 3/4] riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
Date: Tue,  1 Jul 2025 09:17:28 +0800
Message-ID: <20250701011730.136002-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701011730.136002-1-inochiama@gmail.com>
References: <20250701011730.136002-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT device node of mdio multiplexer device for cv18xx SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index 7eecc67f896e..3a82cc40ea1a 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -31,6 +31,33 @@ rst: reset-controller@3003000 {
 			#reset-cells = <1>;
 		};
 
+		mdio: mdio@3009800 {
+			compatible = "mdio-mux-mmioreg", "mdio-mux";
+			reg = <0x3009800 0x4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mdio-parent-bus = <&gmac0_mdio>;
+			mux-mask = <0x80>;
+			status = "disabled";
+
+			internal_mdio: mdio@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+
+				internal_ephy: phy@0 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <1>;
+				};
+			};
+
+			external_mdio: mdio@80 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x80>;
+			};
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
@@ -196,6 +223,8 @@ gmac0: ethernet@4070000 {
 			clock-names = "stmmaceth", "ptp_ref";
 			interrupts = <SOC_PERIPHERAL_IRQ(15) IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
+			phy-handle = <&internal_ephy>;
+			phy-mode = "internal";
 			resets = <&rst RST_ETH0>;
 			reset-names = "stmmaceth";
 			rx-fifo-depth = <8192>;
-- 
2.50.0


