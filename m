Return-Path: <netdev+bounces-200103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F4EAE3320
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 02:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8213D7A61F2
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 00:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E06F2F2;
	Mon, 23 Jun 2025 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR8mItBL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548A7260C;
	Mon, 23 Jun 2025 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750638667; cv=none; b=YXuvpkQpGG5lPgXfJ8v37crJnTwKwyec/I1T4+uH0sSkZqo7LOsBFu21y8OmpX2cgFOsiwwCpliCtoujWWgvxIUprAn7aEjjkvjPV2uCWzy2RTvMOrr5Krk7I5Doom3jHVnT6u04GeG85a+LzWMMhklmRK8DU+1gFgUFxOTvV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750638667; c=relaxed/simple;
	bh=28w6W3M5RoMtkXpLoM2r5jUmQHSYfM+9m3hFwUL1h6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGMt7CNVgn4QM31eb2zcsWWJd81ZGJvpBBpXLMwXAZf26IVud/WnVqHyQOsQ+Eh/NsbzQsvwxadRvz/J2o32ILo7C7wXf6CaVeSoIop1I0469jWtvgSik2sWRD7kbw0JS4u+8xHvSMqY8gDAXWaVeTLc3mmGmzCigf6nZejdEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DR8mItBL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234b9dfb842so31043785ad.1;
        Sun, 22 Jun 2025 17:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750638664; x=1751243464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G8EsFLPHcydSdSrFsRKcmtgOEiF67NnihrfLuZNDOk=;
        b=DR8mItBLMMFjHiPhOpd/7HvPsP5lh7KWsI8FXtGyEm5NxHyMliu9IQFuwwErBaTA9x
         xnlisoKwVtOY4B2+iwwU+eeBaWS+WdyOdei6Y7Jx12c8CfHiAkanjdi2IOrRNqzEEfLU
         APPvnoinxT94fYRL8emmydf1D2u49Du40pzPFQ9o97Xw7kNW4R9s9pyk0Y+Nz5hBkIat
         gQrPt09zkBYEeqWuXa7rEmNOLevnBWte4KO9UHue9m8Z1odq7fUhEGVP6FAxvhDgVDIp
         vE8WYFILRl3KW5RfoSk3ic/1aG+jlMxZIZpwD9KOu9WG5RNTBGyFHNdfTRHX6hg+4rwh
         vtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750638664; x=1751243464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9G8EsFLPHcydSdSrFsRKcmtgOEiF67NnihrfLuZNDOk=;
        b=UFzPcT9McxJHgYp6byf7UTjxU39HjcmJwXRVtdVZ5+jJgnyapTJg0E1kvY9egbiOuy
         tx1cCMimc5Cs/EjT0uqiptvkRZGjZMkE2Y+idoltd/zaVx2nwJgOZuCzIpV+3fewv+pS
         /bg8yvt87N7risvBiwFDAESNM/3XZzZDTQggyihNjjaDZO5OCMpNyJKz4EWxBosbBhKI
         fZpynk5Gr0ypO7hUn5BNBjrYoNy8/CTPQpVnwgivgOZNzsWkFaSG2OMkMtWr1DBRsDHG
         f8UqdOrjvqR6A/bBEP9C74RlZaF7dWY/+n5ciN+1y7AEdFROWyIgp9uoJHH9e/gzs/R8
         EQkw==
X-Forwarded-Encrypted: i=1; AJvYcCV0SubdWtCDoUjbtsUqivqpljb1WucmVN/nhZmCCV9JS+2KafCHi1DvMop81DPJXqq114NeuIKUUkti@vger.kernel.org, AJvYcCW6al0YQ5fS6E70iBrT31mKFnycL7x0OJiGOy0nJXZOZjfwH5+drdt5taWkx3f14n96EWWdr3IUnTXIlRRW@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxnNZy9IvH7nqFD28ZRcCkzqkbU2aZkSAbDWuT0fpK6G9qGZH
	hVWbOQ0kvclvF8X3R68DNljdM0xrlCR7FbVIEktAHa6AJda/ZTTaJ5nF
X-Gm-Gg: ASbGnctfyOKo7c/5HohFMKSFfs5roRfICB/A7b+XGTMei/Nknoc878wHrJddFfcljfO
	rQa5rwUpSIGQnw7uNsCjShbLqWk1IEm2WlNSURauBGsuf/bQO4iJw6AkzmImukoAcZVSYymKL13
	Ispjj2Bpt56Wk3hyZ0r3fp/fYA7/4fmk3mguXCordunTqRWmfR6AI3U1evD7cQdc4zofDUJ/Nbt
	f9xVRzLSTxWHxoIyqncOOwZO/VUUY9I3uJHvQmSqX8vJt77UiF6QmC24Btk+Qz5Mhjlh/1s0B6H
	WLBKX1DTX9XcqYBtOsY+C17TMFBZyUX0YhH95K8jLkVQDAjeEedNCyLl9XS0lw==
X-Google-Smtp-Source: AGHT+IH9nFpNJSObaAZYjqO9Xl+MXCzAAap0YDff4CiKEVwvDjlQgHiHJJhK3EZNLfia51iUp2PVwA==
X-Received: by 2002:a17:902:eb8a:b0:234:c86d:4572 with SMTP id d9443c01a7336-237d9a42e01mr143684805ad.30.1750638664409;
        Sun, 22 Jun 2025 17:31:04 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d8391494sm70195695ad.1.2025.06.22.17.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 17:31:04 -0700 (PDT)
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
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>,
	Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next RFC v2 2/4] riscv: dts: sophgo: Add ethernet device for cv18xx
Date: Mon, 23 Jun 2025 08:30:44 +0800
Message-ID: <20250623003049.574821-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623003049.574821-1-inochiama@gmail.com>
References: <20250623003049.574821-1-inochiama@gmail.com>
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


