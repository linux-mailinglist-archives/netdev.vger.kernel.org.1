Return-Path: <netdev+bounces-202715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0270EAEEBFF
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F0F3BEDA3
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E39C1AF0A4;
	Tue,  1 Jul 2025 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu2csu69"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D332419DF5F;
	Tue,  1 Jul 2025 01:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332678; cv=none; b=t99mcy1db8EAph4z5nLu2S53d9VejgNQb/4egUVht0rOOGbEItI8OcPPvqx7XSQI0wKGIXMkAVdQLJeftxRuTZT7Iiy43WHGK55/BNhR/C0UauU6uXljuHIcKNp2vkdOWynv7X4eusuLkdfW3LBH52T+X6o5lXio50pWqeKWO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332678; c=relaxed/simple;
	bh=28w6W3M5RoMtkXpLoM2r5jUmQHSYfM+9m3hFwUL1h6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLZvjNn+8HxBPd9S3r0pOO74bWnQcEKtAHJSjVwVSuugwoOy3vreugq823sAnorithBZt21WqQ23PqIBU37ThS3QCz9cZJ4knvDE2Q9zwgGyAtQxy6YB5MRdnDlI8nkdMdxE7/Xw/xk6qELuhobMDaPxJHT7QiS4mBcYf59/Qkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vu2csu69; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b31d578e774so5762003a12.1;
        Mon, 30 Jun 2025 18:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751332676; x=1751937476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G8EsFLPHcydSdSrFsRKcmtgOEiF67NnihrfLuZNDOk=;
        b=Vu2csu69Dgjfz2FIEKr/5VDZFMsx0wMo3Q4kRsEkupjPO+x4MqTBDTq7Xlf9Dx3VKe
         ee15vD31NE0VStyVtoJkrpR6p8tIEjg7uO8jHLl11dCQM/xywmtydwK/E4u5fX/UMz5L
         QFOd11BCtuo5fN21E4J2GJYbkSqVvU3PLQOXJe/5XBv3I0ckmVpDDtavkfa2eUQiq7O5
         2T6SsPsnR6ioX0gNND8xjJHZAE7yRdWgaWjvGat+nO4Z8RmhPSZ4eI6pWaGSpZ2KFIYK
         KzfKrUNAMex8KC5QTRa1zYK7RYhklphBPG/3euZxzQLZ8WoQl7Cn4M3z5CheFGcPGQr3
         7VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751332676; x=1751937476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9G8EsFLPHcydSdSrFsRKcmtgOEiF67NnihrfLuZNDOk=;
        b=SNqBHepVtQUumDmcUPwQ689QuGra3uO5Og/Q5ttrem/8zfOoWMO01dnkQQ1C3ruHWd
         J+5x2jqDZQl1tTrxk7ZiC8qHa8h8kcjrcynXcPNv+Woo0a676Ma4bxFS6FHmMauhB0Fv
         xuW1YcrQD4FTdpck+Pfh3l179vBx+vv2eIFc+cJDFDbSaXUFuoHezPkJ81I3oZ8QFJBu
         fSdSInly4NPp2AbX9SoSO7il8J1r9vkHA3lPKD0UVduCdBg+MT9HOAZ8eKJijb/ixnJ3
         +wCmgnK3htdDxp4KmIh6S1/K71uwCgEwg5VFw+stIEY/unsVfel0Icmw4Mp0oGpWsr8M
         fUUw==
X-Forwarded-Encrypted: i=1; AJvYcCUuxnY1pDItwkXeK2zUPTavwheoB+sNo6a9ooXFbCinhyxYXXoy3wsNxfZnh3mvPAkRK1PyAGAGtdGyF4Lh@vger.kernel.org, AJvYcCWOkMgKH2jCAXFQgwDcRJYF1yY8lQJmxa9MTEy86UAhguK1INcnj4nq00Qzu3NwcqF605ValW8/3Tzz@vger.kernel.org
X-Gm-Message-State: AOJu0Yziss8yH+3EtP+eGPwasiw3yGwSii94B6COW/mWz0qheVW7Dl1V
	CRIS6MmdZlbHjKhiwZbYZ7ltaK4wPAwkYk3MEIAk9jPgsSHOe6oLSEVU
X-Gm-Gg: ASbGnct9Qxbf8TxLRGKbi87c1BOfdOZPQId8t4tHG4BhObEZAuS7rq+dUPb0ssXBtgT
	9TwBRMdB1b8Nem9QUnCCqclZIa9wzglbEFslaefe6+pgcqNzyF+aiG3YMtpxyeNJP/3Faogg0Wb
	PY6OBuvbY/qHpDUDfBEPAzBc4s5HXF9wI/Wo19UyBID875V6cEnZM3ng5hPGFbcqCL4h19zmRov
	DhcBVoV757R8YMKU2sOGbTOK0mA5gZcvp7sTdIEJu6iF1rBxLQtPDa6sQ7HDdC2ajsGnHMT6Dmn
	FKJtOCVW/a/TRR68n+RONdEUvxToeauc7B3tGx3PM7zXW0bpWWWdMe6vqKEfgVeKZ+3RoZOK
X-Google-Smtp-Source: AGHT+IFM9lShrZ0gDhqDAmlJO1Tr5XQLrwGfLFH9sgY8PsJvx+UPrYvYdI+o7sjOwSyPkHhG0w+dDg==
X-Received: by 2002:a17:90b:5150:b0:313:d342:448c with SMTP id 98e67ed59e1d1-31939b6400bmr2096527a91.17.1751332676004;
        Mon, 30 Jun 2025 18:17:56 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2e325bsm93040705ad.29.2025.06.30.18.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 18:17:55 -0700 (PDT)
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
Subject: [PATCH net-next RFC v4 2/4] riscv: dts: sophgo: Add ethernet device for cv18xx
Date: Tue,  1 Jul 2025 09:17:27 +0800
Message-ID: <20250701011730.136002-3-inochiama@gmail.com>
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

Add ethernet controller device node for cv18xx SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index e91bb512b099..7eecc67f896e 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -189,6 +189,50 @@ i2c4: i2c@4040000 {
 			status = "disabled";
 		};
 
+		gmac0: ethernet@4070000 {
+			compatible = "sophgo,cv1800b-dwmac", "snps,dwmac-3.70a";
+			reg = <0x04070000 0x10000>;
+			clocks = <&clk CLK_AXI4_ETH0>, <&clk CLK_ETH0_500M>;
+			clock-names = "stmmaceth", "ptp_ref";
+			interrupts = <SOC_PERIPHERAL_IRQ(15) IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&rst RST_ETH0>;
+			reset-names = "stmmaceth";
+			rx-fifo-depth = <8192>;
+			tx-fifo-depth = <8192>;
+			snps,multicast-filter-bins = <0>;
+			snps,perfect-filter-entries = <1>;
+			snps,aal;
+			snps,txpbl = <8>;
+			snps,rxpbl = <8>;
+			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
+			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
+			snps,axi-config = <&gmac0_stmmac_axi_setup>;
+			status = "disabled";
+
+			gmac0_mdio: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			gmac0_mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <1>;
+				queue0 {};
+			};
+
+			gmac0_mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <1>;
+				queue0 {};
+			};
+
+			gmac0_stmmac_axi_setup: stmmac-axi-config {
+				snps,blen = <16 8 4 0 0 0 0>;
+				snps,rd_osr_lmt = <2>;
+				snps,wr_osr_lmt = <1>;
+			};
+		};
+
 		uart0: serial@4140000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04140000 0x100>;
-- 
2.50.0


