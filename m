Return-Path: <netdev+bounces-195596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6140AD15C3
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB24168B9F
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 23:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F25268C5D;
	Sun,  8 Jun 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2Z7Otdk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E3268698;
	Sun,  8 Jun 2025 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749425398; cv=none; b=NJTvysTy6HBLgHnl6BAbN8Bs5gNgqNyGg8gC7JGENMNqrcnhb24//diZUVZSx++jY6EEZL7JdeVJNhjAeHSMMGJn167hs0XG2l/oPBKD9F0xaVUXEw5nY5VaYScs1ucMSMP0fdFBpxCf1ZC2FqflLSYHaXH3tEx7EmfeM4JA2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749425398; c=relaxed/simple;
	bh=xapA1CHJjr1I1KXvM9NNUzE3Fb5YnoqfxPlZi8DGQqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNf0v9muw/N1/I/lbhQ3zQxbGX0pXMOtORixCI5H9SAM28DT9yvbzPBy/kpJM/Vbk7LW7zW7CM9YnXDSpO0KtzYVN+ZlusquMjugIt827F/hp7lDfMYuWUVcqVsn64Ml4X+2SPRtIXmI1CODefdP6XFcdk6qa8YhQSeieltwsS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2Z7Otdk; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a440a72584so36678441cf.2;
        Sun, 08 Jun 2025 16:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749425395; x=1750030195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9s+OR8R49kht0oCLKo0xvH8vU3cihaJW7otzDR/klE=;
        b=k2Z7OtdkNVmZfyeDH8ZHvshM9FmGrlVJ5mW9Kuhod8bY4G1jln1cQFHuguhygbwrG0
         fAPzZICje+RAo/mZZVIqj4ntyQSczifbxuuj2qtclAkUmYxebjKziDXnhfebqO7XZphC
         DJ8u4oX4E5yz0dvXCXMdhL8yyNBhpUQuKp3McxseX4AmfjVJySRZMwI/hvBxpySoci3p
         YUGwSp8/gaKLF7OPBwtVAXA/Fd40DpV4yLGHZ+nC5FO2FVMbomodxDKqhkIKEb1omr08
         bA5yJvLM7hBKxpnEFjWaraoZFvuU3841991xagx8/8iWMA2Ldvui2j5uo5xi6b2N7HYs
         1PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749425395; x=1750030195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9s+OR8R49kht0oCLKo0xvH8vU3cihaJW7otzDR/klE=;
        b=F56xlnbTHdKd7CFrdl6ghK1SIvAlRH3Eobo6Z9ZTkuZQy6d95DR8IKKjjM5IQS8R9g
         QNSZChTMZ3mq+dKz3eruPkZcdCt7XUnaQHqstADDU/za3SlPd6sZ9Or0nauY4ljwGJ14
         /hXuL8zDpFs84UDBtMSNC4UYk1Wue9ZGSxIvMw9j5KOeIysUAVM/+z64QmXOPsgOVhFA
         epLSSJZFlRR4Qak7i2tRY+y5QDOfBGC/uU1/EbtTV/FiDPnG7jRykxIcvDllWL+QIGZd
         snTB28sncHq0rWCpMwvm3WRGK7Pw3W8WY3DyIx+O9XbJMBICXVvD+e+Qugd5BkGWT2Ku
         rSzA==
X-Forwarded-Encrypted: i=1; AJvYcCU2lIsmNoT1rpto/OiM+uhIGNdtAn7O/bpZhaRoCtk0JSypmlDmhrxXWqg8F8hmzDgfUw6m0cm+X4DtJCmi@vger.kernel.org, AJvYcCVkTRD8LEb3zUvMaWm681XDKwxDRPshVuM/vzU0THB6iFcIcafZAI6k9/NLkOIB2VZQbgIxq/yCwcj1@vger.kernel.org, AJvYcCXin6qOnKIxbPkaLrtQJqLSy3EakoFsG/fNyZakiOW2ShuTMddNf1e/FbtzNH2hx90QQc8iHQSp@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZUb4LdyL4t6rLPMH74JBB6mI51Q85NLoGoUYsjoTcnFssJ+W
	4mMEC0RX5HZ8Onz53pJ16MNaBVI1qwW4fIqhyyXkM2Njc2JCCLTlK3Uq
X-Gm-Gg: ASbGncuP1MOJ5934keG7I1ct7obiEkZ/J3PZLMiYMzYP8OCkjfmxUJrm416Mi0/X0kB
	/cFfvxPDklYiSu7rjSOMnGK8s6VMquQHKCXffBUznpSa5lkYh7g5NQjPctTL/UW6zbBDWZndcEp
	8fS0GzY015p/obWxaH/7P3hL9oX0u6zu7NiRaZOwjuvYzdu+0b97nHtIIiT72+VZ34zt5ZQJSTa
	o6yhrpYIi6Sa79vqRhNjWPVwAUl1bQ2RXlWpB2CqOxSfAMwUZfoAJLTGye/jzSrSeoomv1erTaI
	jMuYFsf2hMoolhLCFV+zz/cjlTEdqDAKoTFr/g==
X-Google-Smtp-Source: AGHT+IGVTE7AStEym8OCBDDJDYJzCP+mLeMVtHSUB2sGRL4PF3E9St8SXV/iVZLVAiLmOZXbB+WmAg==
X-Received: by 2002:a05:6214:d02:b0:6fa:cdc9:8aff with SMTP id 6a1803df08f44-6fb08f612c7mr204216496d6.25.1749425395577;
        Sun, 08 Jun 2025 16:29:55 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09b1ce38sm44503256d6.68.2025.06.08.16.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 16:29:55 -0700 (PDT)
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
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 04/11] riscv: dts: sophgo: sg2044: Add I2C device
Date: Mon,  9 Jun 2025 07:28:28 +0800
Message-ID: <20250608232836.784737-5-inochiama@gmail.com>
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

The I2C controller of SG2044 is a standard Synopsys IP, with one
the ref clock is need.

Add I2C DT node for SG2044 SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2044.dtsi | 56 ++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index 70d1096f959f..a25cbb78913d 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -91,6 +91,62 @@ uart3: serial@7030003000 {
 			status = "disabled";
 		};
 
+		i2c0: i2c@7040005000 {
+			compatible = "sophgo,sg2044-i2c", "snps,designware-i2c";
+			reg = <0x70 0x40005000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <100000>;
+			clocks = <&clk CLK_GATE_APB_I2C>;
+			clock-names = "ref";
+			interrupt-parent = <&intc>;
+			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_I2C0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@7040006000 {
+			compatible = "sophgo,sg2044-i2c", "snps,designware-i2c";
+			reg = <0x70 0x40006000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <100000>;
+			clocks = <&clk CLK_GATE_APB_I2C>;
+			clock-names = "ref";
+			interrupt-parent = <&intc>;
+			interrupts = <32 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_I2C1>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@7040007000 {
+			compatible = "sophgo,sg2044-i2c", "snps,designware-i2c";
+			reg = <0x70 0x40007000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <100000>;
+			clocks = <&clk CLK_GATE_APB_I2C>;
+			clock-names = "ref";
+			interrupt-parent = <&intc>;
+			interrupts = <33 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_I2C2>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@7040008000 {
+			compatible = "sophgo,sg2044-i2c", "snps,designware-i2c";
+			reg = <0x70 0x40008000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <100000>;
+			clocks = <&clk CLK_GATE_APB_I2C>;
+			clock-names = "ref";
+			interrupt-parent = <&intc>;
+			interrupts = <34 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_I2C3>;
+			status = "disabled";
+		};
+
 		gpio0: gpio@7040009000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x70 0x40009000 0x0 0x1000>;
-- 
2.49.0


