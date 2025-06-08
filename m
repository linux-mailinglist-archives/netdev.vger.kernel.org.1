Return-Path: <netdev+bounces-195602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71367AD15D3
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2454E188B287
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 23:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6039D26B2DA;
	Sun,  8 Jun 2025 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XunwDGZa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644B266EFA;
	Sun,  8 Jun 2025 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749425421; cv=none; b=WDhauMMSHQgS/+IJxoBUNUi3h8tiP8/SKElq8vsdU2PdFtgWN/kRZogKQGR5vH1O5iUnMkiaYq1Y6h3y6OYl492eybS91j0TtxLTQVOchutLEy5vXxuAZryoCIVpsKq1xFD+nuWanCitoBTaIvmSs5iUgtLad/HHtswqqc+grNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749425421; c=relaxed/simple;
	bh=MEg4g1tI2gzPjiDAg/RMFo42I/O8x0ABz40/UB7t7qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTqBdG49Q+r748+VqEK1kDzQjJHvijmOusk9qQ0TvihKs9S8f2y9SisGN9oytw0VIZi+lzHVYuHXSLlybkjsmWKchD7sFbys+VmA58ZT7QunSyiVY0C4CFdcYoOmggjG+cL3jKp3HXPHLUsEP4mqDkgf0q1Oc2BdD7lliraePF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XunwDGZa; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a5903bceffso48358011cf.3;
        Sun, 08 Jun 2025 16:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749425417; x=1750030217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGqZ6H9vgVgHpW8k4kYrkONK2GRCAnNYk099WHkJuBU=;
        b=XunwDGZaOfmHJDUbu8rh+pXkhpiS/wVioyP4VTpSOt+0uGntUJB4U4NtLPFKdURXPG
         PJJRnhxYR0qS+HHu/E5H4VjlOcpDbEjjiwnOi7Pg0/hJqQgAqKhsy7irGsEemX4vwRqA
         X+cgocawFLP9/D8+hBlnJmbsNAi5o8ZtPYFJ14lBAyxH+G/0oe91bLMSB0W4YiIEoB+L
         GZW+m0jpiMWcseDEOsvoalAun5JeO8wFUrk0T3cKrjraBtuofAtxLugJfQJ2Gl2gIcEg
         LfC1/+qBaKFkIt553u6DQyAayq2xeokjEvFM1b/XkOVG1jReXTjyTWxyxupTMO7/VHEA
         om3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749425417; x=1750030217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGqZ6H9vgVgHpW8k4kYrkONK2GRCAnNYk099WHkJuBU=;
        b=Tc9kmQBnoR0juTgy+pIBCdQreJrWWAknzjY/PtBQNzrvNAaPW36HFaY+hH4JnJrjU8
         qYkmkJCkhgxydZ51HuRyai2Q/AOU/5L2GMbxpbVTm6a5ZfgztXhi4ADZ7I+YHoJ92py/
         nkmAiP7Ej9WeDQ7znusCfF/cpR5n7JKSiJQOLt7Q9695wMK7OMYKFC6icBLM1awBsRvF
         qO4g3cCSiSJmjSl7clBTbNToP7cROmw8Ps1/v59WISyNC5D11o4GGroE8KfoiG9Ue6xf
         /rW96CJFPbq+m3papl433kQLhuzqgY24INebgQQdFVpi4foYbRb4ajc45lnVNnuQRssB
         CSJg==
X-Forwarded-Encrypted: i=1; AJvYcCVMflVUjpftX+Z5M/Erk3SvgOsv6WMbFOjFnhe/+RI34jkWU3gEnh02JH5zh3dqfp512Mzl8Vm3JM7QLXip@vger.kernel.org, AJvYcCWO4CgLxXqee6THVGZiaLMof84QFvArhFVfBTC49ZUtjGO9/gjCe7EFQAuqswLXfSsS607Kuy5W@vger.kernel.org, AJvYcCX7uDGhXsDBaVpsi2IxpDUl6NMNud0Us8evcbI1gPfJ0Tv6dB0ymxmn3GlmoVR0b9pPRFOUU0hb/37p@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1C7pqsWR6LVEwwEYjspTEl5/3sUfzHeIz7UT4mRl2TKlUbPc
	y1SnoqiTpIXxhlNYp9+Yi+Eno+5R/1+OIHRPFBD6aU4PxRuVt3+FEvA8
X-Gm-Gg: ASbGnctUBosM1SMmKD43sbtfYtsxumFtmbqgCiylI9OKC/gDSG8CtsepVEtpQg5g20C
	FgisFjkYAaGFnlJM1JlBPvVCiSpF7eV2w2dlYeXbvJ3W0OlOh24aQdCHUgNJyTBGEfBoXbFV9rn
	B0sCSGOd5aFfK19iyE4KmbCXVutefluMAwvmDdpPKl2TbbZLLM8KjhXFMJq/JFc2c/b5VsOOptR
	9tBThPJtShbCv3gBc3O96ZRs9B9rpXhdgcxKoK09DpCTkWPM+A6jP57PMgj/5OJwjejVHLEjuvU
	LIT0A+tY4Z6BzaD5trvR3qc5ay5ctMyVb+YD/poxGio2edtw
X-Google-Smtp-Source: AGHT+IFxasvm0DM58Er+rulpc8xCIg1aEcLZoSpXNO7+uLu6yJcvr0q0o85JQaJvO6S8Up+1XYUevQ==
X-Received: by 2002:a05:622a:999:b0:4a4:30cf:c213 with SMTP id d75a77b69052e-4a5b9dd44eemr176529811cf.48.1749425416628;
        Sun, 08 Jun 2025 16:30:16 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a611150479sm48333501cf.5.2025.06.08.16.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 16:30:15 -0700 (PDT)
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
Subject: [PATCH 10/11] riscv: dts: sophgo: add SG2044 SPI NOR controller driver
Date: Mon,  9 Jun 2025 07:28:34 +0800
Message-ID: <20250608232836.784737-11-inochiama@gmail.com>
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

From: Longbin Li <looong.bin@gmail.com>

Add SPI NOR device node for SG2044.

Signed-off-by: Longbin Li <looong.bin@gmail.com>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2044.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index be20efd8e2ac..b65e491deb8f 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -32,6 +32,30 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
+		spifmc0: spi@7001000000 {
+			compatible = "sophgo,sg2044-spifmc-nor";
+			reg = <0x70 0x01000000 0x0 0x4000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clk CLK_GATE_AHB_SPIFMC>;
+			interrupt-parent = <&intc>;
+			interrupts = <37 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_SPIFMC0>;
+			status = "disabled";
+		};
+
+		spifmc1: spi@7005000000 {
+			compatible = "sophgo,sg2044-spifmc-nor";
+			reg = <0x70 0x05000000 0x0 0x4000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clk CLK_GATE_AHB_SPIFMC>;
+			interrupt-parent = <&intc>;
+			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_SPIFMC1>;
+			status = "disabled";
+		};
+
 		dmac0: dma-controller@7020000000 {
 			compatible = "snps,axi-dma-1.01a";
 			reg = <0x70 0x20000000 0x0 0x10000>;
-- 
2.49.0


