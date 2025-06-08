Return-Path: <netdev+bounces-195600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B19AD15CD
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB1E169BF5
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 23:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28FE267732;
	Sun,  8 Jun 2025 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgwMdJZm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236C26A1B4;
	Sun,  8 Jun 2025 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749425412; cv=none; b=qRsYffIn/opXWSQ+6fWuCIRY/ZtBCjztyBjxq0tbLrIej8aQ8ugM8MKpqB//kTsg5x63PJ6s/0qbZF7z1dia051ogznMmx5StRUcu2GKAXUqW3FdiUye5xLQZfz3lTrLigOZgvBnH1Fk6wjQV7QFR3p6sNYhUuV57rvDw6NGWjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749425412; c=relaxed/simple;
	bh=5VUqSYlSo/Buy2lm3tgc3Swi8jf9sGGImqhcq3u+iGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaSvQ2oT+t+23EdZolyyvgmw1nukhZqwq4S3LH1EKRChAHAN6qNp6Sf0U1eWYeAdQFENZwsQfURHlsaH5wBLls9R8ZnLancoDi4EhKQQSOOcjm/wR853GGi33U0vquViw9Mb2s3MSGpykK96UgWUSFqBL24lW4ohrt6qK89cZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgwMdJZm; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d20f799fe9so355797185a.2;
        Sun, 08 Jun 2025 16:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749425410; x=1750030210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmpEekK1exJPpnoGidNY1S75lqWDRnDWJRIusLvDb6g=;
        b=TgwMdJZmlY+SsZJ1++zzsY6ijdlv2plk5uZ/MUD1S6ecBG8oDGpsY5vW2/gOBhPuNz
         PN9F7HcoNqnEQ21jGLXzGjppYqVUL8rFR4wi8Hb1fuIFjwvDbwGvc9vLXMx34D8wFazd
         UROoMKZSFs/JrDk7D/pP6x0bB9KJNrfYRU9amYFFlcYIUr0tcxI6D/98IGFZBbaa2Nub
         KL1KQ530fW7gWnDhx6lDMyodXlsmUHQDNcY6VDyBiNQc/kzoqlNFH+PH2LeR6NRNIIon
         5xOL4ECMpJYpcAD4/0tXRRTnXph5xLDWKRaZwmIqOKSJuLHygK/fQGU1ltSI0/BNHQNT
         wlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749425410; x=1750030210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmpEekK1exJPpnoGidNY1S75lqWDRnDWJRIusLvDb6g=;
        b=OHIujSeNdNMCVKDTkmpsyGi7L5+TRX8Ws20QNy2xTR5q+lK2DmCVoRTJAV7ZFv1ijy
         ZXbkJaPui4PpvI9Xhoj1NOJjCQAis3k6t+pjvn6PQJDBLMmA5q4G0vlOPU75iEiZ3SxM
         c+qnqg+YC1IfoTyxvqOoh6t9LkldWkBkj15pLQ3VzGUqaPgHn7JSvJrBgSivKFw9Yi/s
         stWVnZu1QVrRnY3AuwGGqVpALauUsEQfg3YsIAaiyQGtLecRdwNYQA/7mJh5tpoCPFIO
         LhMHyFuWYWSlXIVXRHKHey2g6A/0HJIlOpAYZWb8fQtmSr4OvrQp6SaKNO6K5+xhKUlR
         r4yg==
X-Forwarded-Encrypted: i=1; AJvYcCW8NKW7OGBWIVBxlIx6/S97iGctFUL5xKpjKehB3FLNLQ0S6vsXNY552kUdg/0qFvDOdO11R07nJT7dkjzc@vger.kernel.org, AJvYcCWNJFfUY3Ro3LxM2U6pVR25kftfhEq4z0FlyR4dcLAYK5HCWXfq9pVpsGFqIHaS1BXsB5Z9qhyqxIup@vger.kernel.org, AJvYcCXC4uzJMQNpz6U2ifstxXoGkHiL/XnuhBrcvTTJFKCPf+kCKW9RCHYoht4pik5nsUtzfspA9y1v@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6Dz0espnWJDByDFzK5M1MaqjO9Qvr6e1iC9cdcq0MJ7Hm/rw
	xniKh6Nn+NHBgGgMt9QWdknwnrWNYRvDERkqTu5zjoOvwcxMjUDF5V6AQY+xu9ex
X-Gm-Gg: ASbGncvJJ1oOpUNJFFKbOPfusrKVpqeCwKRaVhwePcqELYT5kCEsMKyug1aYTPDt+44
	cMxOioJtIFtu9HtyVFwkafVdTKuZ4Txptbey/bfkfxNCphVdSkZiKygmomLffEpzgrLHGmIDnY+
	pwGSRew8JfmQW+TJZ1TO1VwyCR/9q9B6fnVjKxWm5Z/1ZUmuyLoTOwYizDct3LQjbMBOnTwk0nN
	ERCYY4mrQv95Vncn9PK36k1pEmRcTII8YaV240oBvCT2XQ5q4fSVEVjKr7/LB4X20YIixVs9D8T
	I80zkkrCGEFYvz04MP1bPyLtfKRK/uCQaycBKA==
X-Google-Smtp-Source: AGHT+IH4mdTeanbw7zBF+9/nISjw3MNAkAWHlSCzX4O+dmLV8Xf9YTcpy4gwDq/IqG6kdY05P5pZ0Q==
X-Received: by 2002:a05:620a:4112:b0:7cd:1d87:6c79 with SMTP id af79cd13be357-7d2298eba35mr1783805685a.53.1749425409927;
        Sun, 08 Jun 2025 16:30:09 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d25a53745esm466605285a.46.2025.06.08.16.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 16:30:09 -0700 (PDT)
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
Subject: [PATCH 08/11] riscv: dts: sophgo: sg2044: Add ethernet control device
Date: Mon,  9 Jun 2025 07:28:32 +0800
Message-ID: <20250608232836.784737-9-inochiama@gmail.com>
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

Add ethernet control node for sg2044.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../boot/dts/sophgo/sg2044-sophgo-srd3-10.dts | 17 +++++
 arch/riscv/boot/dts/sophgo/sg2044.dtsi        | 62 +++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
index 75564b2719cd..01340f21848f 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
@@ -36,6 +36,23 @@ &emmc {
 	status = "okay";
 };
 
+&gmac0 {
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	mdio {
+		phy0: phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			reset-gpios = <&porta 28 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <10000>;
+			rx-internal-delay-ps = <2050>;
+		};
+	};
+};
+
 &i2c1 {
 	status = "okay";
 
diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index 6067901cde1e..bbf4191fb87d 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -111,6 +111,68 @@ uart3: serial@7030003000 {
 			status = "disabled";
 		};
 
+		gmac0: ethernet@7030006000 {
+			compatible = "sophgo,sg2044-dwmac", "snps,dwmac-5.30a";
+			reg = <0x70 0x30006000 0x0 0x4000>;
+			clocks = <&clk CLK_GATE_AXI_ETH0>,
+				 <&clk CLK_GATE_PTP_REF_I_ETH0>,
+				 <&clk CLK_GATE_TX_ETH0>;
+			clock-names = "stmmaceth", "ptp_ref", "tx";
+			dma-noncoherent;
+			interrupt-parent = <&intc>;
+			interrupts = <296 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&rst RST_ETH0>;
+			reset-names = "stmmaceth";
+			snps,multicast-filter-bins = <0>;
+			snps,perfect-filter-entries = <1>;
+			snps,aal;
+			snps,tso;
+			snps,txpbl = <32>;
+			snps,rxpbl = <32>;
+			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
+			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
+			snps,axi-config = <&gmac0_stmmac_axi_setup>;
+			status = "disabled";
+
+			mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			gmac0_mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <8>;
+				snps,rx-sched-wsp;
+				queue0 {};
+				queue1 {};
+				queue2 {};
+				queue3 {};
+				queue4 {};
+				queue5 {};
+				queue6 {};
+				queue7 {};
+			};
+
+			gmac0_mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <8>;
+				queue0 {};
+				queue1 {};
+				queue2 {};
+				queue3 {};
+				queue4 {};
+				queue5 {};
+				queue6 {};
+				queue7 {};
+			};
+
+			gmac0_stmmac_axi_setup: stmmac-axi-config {
+				snps,blen = <16 8 4 0 0 0 0>;
+				snps,wr_osr_lmt = <1>;
+				snps,rd_osr_lmt = <2>;
+			};
+		};
+
 		emmc: mmc@703000a000 {
 			compatible = "sophgo,sg2044-dwcmshc", "sophgo,sg2042-dwcmshc";
 			reg = <0x70 0x3000a000 0x0 0x1000>;
-- 
2.49.0


