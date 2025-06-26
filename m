Return-Path: <netdev+bounces-201436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7806AE9760
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0E317D026
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B23825E448;
	Thu, 26 Jun 2025 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3bQmW4s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E06325D8FB;
	Thu, 26 Jun 2025 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924878; cv=none; b=J1c9vvlyqV2Jlh5NVzsboZ2Q9Odm/8pZfbd6zJ7gRz0SXUZQYO5k7YLALtBjh9/+iy0ryfgNkhe6NoYu7Y1380MMo6xxQiZgq+7GF6lmFFPN2lKnOTKSHmSPNnJS+DWB/54fx7nerHB6UQPkCsusI9whQVAErQ2mB4KehHHqRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924878; c=relaxed/simple;
	bh=28w6W3M5RoMtkXpLoM2r5jUmQHSYfM+9m3hFwUL1h6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsChHR3WJH16vhvKYUgq/H3EIHaX2UGcnLKHwsZQ99i+d8Ao+20a8+0s+SseDtKUPmO65+xDDJBLiYRvdRgJV0Aa/Krb0Kv1EWG3XS/WqBtP8dY6TWctLHJxZG8R9r9ydruu/rHWojOzahc7Ju8VmN1lLL596iCXuqL5mHKTMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3bQmW4s; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso783976b3a.2;
        Thu, 26 Jun 2025 01:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750924876; x=1751529676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G8EsFLPHcydSdSrFsRKcmtgOEiF67NnihrfLuZNDOk=;
        b=I3bQmW4swNcc7JbqosrB9DxlGSDhU8uHisnxRLY60nhW3vlZLtWewfFMlzdJRdi8Gn
         QRT5fCX6FJzfUpr7Tog2o17vrhHsbtyBzl9pTUvzYTxLbPykBom89g6N5+2Oy2tllPvV
         A6rauWWiLb+NwlqXm9UgaXnRYZoSW8JXc887fmH4fPCqgusONFFBQq1E/av/eU16PLO0
         xKJDZJ2fK+lZ1e6eIxgqiTH6L3nr2qFRBZ38jw9XAZOC9J2EAihMDmhfBIBdo9UW9O/d
         /SS0puobnPiKPtogNCZU+A0kIeGTpZQ+hv1M4Gh1yBNOgA2339Usrg0Hax/n5MpjuD8w
         9JSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750924876; x=1751529676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9G8EsFLPHcydSdSrFsRKcmtgOEiF67NnihrfLuZNDOk=;
        b=ngxNc8rB1eJlAzJR4ZprYxm3J1tdCiMD1YGVIMCDp8GVDexKHCCZiBIZ9L3diDl5CA
         r7Moh/PP1meT/SLuo9+lIFAHjTiw29WwRw5f+Cf9lL5UpYboN1tXJ+uYRmXRdi0GxK84
         7DbHw2dIIQdkPZfKa7EBlqCTX+VhY5pf4IzQ4NjxXlfQSPkEdhP6jMO3iu82Vr/Onew1
         NaFX++IHF+UGekgtebWyP3kRKsXCoQlAJS/leifjLgiMCqJH5woA5J2cVx4Erz3VKY8p
         UuqqNpuj+xkW4RHRRfC1v6VWJsUnHMsuN710Vrw9kVuLQg2LQkoUa78Ow9vzGm0eYF7K
         pxRw==
X-Forwarded-Encrypted: i=1; AJvYcCUSaJxtQsg09cukR1jv/pjvFoYVUXGeG8kAeWS+BoodPbqhSA6+sx5yTGFYCKT3l646WfOgpeS0HDg6hHM2@vger.kernel.org, AJvYcCWr6MaJzNxqA0P78DeD/eZXbd4sSj9i3a2v3Ob7+j4oeZcO+QfLWXOebYQq4W0CyhhKZwByskTY+0Bv@vger.kernel.org
X-Gm-Message-State: AOJu0YzqhnQtAKz1qqR1qctiZZ71dUqhoXd3p81RvTSOOp0eJ8ocrjjY
	M9ahse5w+KIdHGD8PR8re2qmwpvFb3wzLmgJPLbgTFvv9Xbl2z3ps2xy
X-Gm-Gg: ASbGncvtVRhlrxd90xTgocyTdyqtwfsk6ouy4i2T+dFwpYg2VIDhFdSHIanQX8sQ6Mo
	ILpf9a4Sp2KW5RB+QwKEvQHs6FSYeDAzRxl3eO4bYDpQoVGm53MksmNi/PtWFf0EMjfg86n1d1/
	8n7ijpcQGps/g1x4YGLbFQmGUWmZHRCfLtVdFfb/5EwrBLmPP+uFwNpBEfQSlsVbRD4X7i5QFPM
	+ZpSAKgIpcyL1Fm6ORbamGDbICFgY3mN1DIkNN82eOLzqCo0HTd1vT2D7fJugR0mVgSSwd6OIFO
	k5IvFc8fajWzTNYsq9KXq1KhDPvJwfYuOpZ4f9WnjHRRyHE8sgP0SOYxCEssVw==
X-Google-Smtp-Source: AGHT+IEeIBWKO8E5PCuCUGThQMx4lBDCQNancA7w0a6KHPfjh8T/RV1VkMb32vMY4xaiTzsYTWtccg==
X-Received: by 2002:a05:6a00:800a:b0:74a:e29c:2879 with SMTP id d2e1a72fcca58-74ae29c2a25mr3579898b3a.15.1750924875839;
        Thu, 26 Jun 2025 01:01:15 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74a9697817esm6108788b3a.124.2025.06.26.01.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:01:15 -0700 (PDT)
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
	Ze Huang <huangze@whut.edu.cn>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next RFC v3 2/4] riscv: dts: sophgo: Add ethernet device for cv18xx
Date: Thu, 26 Jun 2025 16:00:52 +0800
Message-ID: <20250626080056.325496-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250626080056.325496-1-inochiama@gmail.com>
References: <20250626080056.325496-1-inochiama@gmail.com>
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


