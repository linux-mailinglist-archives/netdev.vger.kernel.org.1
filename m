Return-Path: <netdev+bounces-204825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E49AFC30D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834C91882D5F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 06:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9C1221FBA;
	Tue,  8 Jul 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRrpjKOb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA12321B9D6;
	Tue,  8 Jul 2025 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957210; cv=none; b=dV1Fpw8pKwfppeS7pDHwsNr8DUPrx3m8+O8MBU2wV6FVOevvmvNY3VFRHjJyIE6iGqnO8adbyc3eGekKxUsTQ/ntjrMEpyPBiWwzv9OcQsyOro8/GpqXykhtkKhPxWn2mAFtRW5hNsSLbznejtj/8GFjeJIHGcGWG2wKiDmp/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957210; c=relaxed/simple;
	bh=/cApN7+nPLX4ympFWe9LXoIFG9iaQZgbTZy3sGnfWz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g73Yp2anRWAUiq6p46hFzNigW8H7RQyZ1WGp7eMVTJveCKTdwnICxuP1VB2AdmirJ7cqBwbC3sUaB28P6r/yj53g9dsWAKxygfgwThy9Cfjxq5h1i+OPUIeXWNJu+md+qzsB7Mtw05ilWpO61t4L9rg2m4ImOv2X6iUhgpUb+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRrpjKOb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso2147857a12.0;
        Mon, 07 Jul 2025 23:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751957208; x=1752562008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=awAK1sQvEZGu9RSuFaWauBkV5Ie3EeA43euQnu2ZDvY=;
        b=YRrpjKOb6dDO0XrqmoXzWmMru2cNfTll5TbikfPAa4daiAlYnmhLVHMI8BSsetlO/k
         0PT1TTlV0BczkwkJGpHbJ6mGpSA5AXbeeIHUEa2xqh3lbH9MGu0r+A7onZt82r6lfyI1
         499ibqv+KJTodkt9KdbfZaq8k5SqyovKJlnWR35+FhEsxkqUvKg1TgOlEBAUZHiCRDmW
         eEMt/NorLCFs2I2C371xiJj1BwQKMAFGMqDnrg5B/FPbq//yb6a2SP5Yri23Va4AvRox
         TP6JzqP8howobYorMuvXULNv1gG0tzinMLoLc5M2Db+LhRmEx88sBbTppBvgsEU+2Jzb
         IkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751957208; x=1752562008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awAK1sQvEZGu9RSuFaWauBkV5Ie3EeA43euQnu2ZDvY=;
        b=cvcrBucPjg7aRHqOMWSNkp9QX6N3PaQKCXQcY80GVKiCiwo9G/F+ZU2gJxfB9K78Oz
         fKlgt90mUW5hXkm/o9Y3Lm10sneQPDqsCx7rCduiSX2rYm5M6Iu5RgS+wZPDaKc2+6Cz
         pwrW3HC3KEVQWsJ7JmKLNgqvkpSLrKSSPFkdLi0Qspmjfe/dAvUw9AUk4azsY/sirlr7
         RYiYC+dJ0D35K4odIkM3LUlSLKVxEuZecPjO/iSsBU1UM4V2XI3SGJXXef5bi7pq0z05
         HA7sh859IEw7ir8rgHAM1z6ndYXVzTVIOgOtz2dSIRIdIf1DG2OQhCkXXxJ3pTfMpeUP
         mZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVMvT2BrrWdfjk68RS5J6aL+8kBPKx6GKiaYVu2su6a8A4dX3MrV6zutk+jPyzmIgEBLKiY5xZ@vger.kernel.org, AJvYcCX3tmORRA/5GxhFzisetUrTxFz98MmOZBd+nvCpyCcCvlPAewc2YJSNp8Ydn8fbgQ4cGIqMMcHweg0YeCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66h5foPkZE7sC+EkJq78Md98mkCxJH3YXKMwFYx6LGWm3WEEZ
	wB69Uu4nSD/13I2ik2SwnuhL63PpH2xfWB1RI04WTK3/idyHhmuVK+4N
X-Gm-Gg: ASbGncvY/RQfrHYaOqaGxNXfwYyUkYD+kjQPzebZ9XI6IgMfcFJBkI9HEVUOUxQ7LgJ
	30IOwfo+Gux5fYEmRKq+v0U4/PW6GrxUuC7rXjqzzLbI+xQxNEmOjA1XGoxZX/5g8KXa1T4QPLo
	7rObmIjSrkmAzoMrFK1IgzuAHx+F78Hn0g0VG3xliRB5CAQgCkACpEf5nRAs/O0E71PmZ5bv8hA
	LWdbxdBXKEhxdIi8h9RRPpJ4QKqHiHmMLF5wr+PnzeIKyfxVaTu7Sy4WJwu2n1yK1nBRardVoSD
	82DE3eISrJoWaq/PwEck9UfAFvsnU1IkujgG+qaUlV1sbccDo14eAuB3fbZ9Sw==
X-Google-Smtp-Source: AGHT+IHNx4OiWoCq7M9t3p40CvKjBGEYTQs9/RQVmrqVzX0hKDNozKjkB+NwYNXyY7dlbQecei9Awg==
X-Received: by 2002:a17:90b:2ed0:b0:311:f30b:c21 with SMTP id 98e67ed59e1d1-31aadd9fd46mr18022165a91.26.1751957208011;
        Mon, 07 Jul 2025 23:46:48 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c8457e15fsm103684335ad.154.2025.07.07.23.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:46:47 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Zixian Zeng <sycamoremoon376@gmail.com>,
	Guo Ren <guoren@kernel.org>
Cc: devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Subject: [PATCH v2] riscv: dts: sophgo: add ethernet GMAC device for sg2042
Date: Tue,  8 Jul 2025 14:46:25 +0800
Message-ID: <20250708064627.509363-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ethernet GMAC device node for the sg2042.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
Require the ethernet patch series for functional device:
https://lore.kernel.org/all/20250708064052.507094-1-inochiama@gmail.com/

Real board dts patch:
https://lore.kernel.org/linux-riscv/cover.1751700954.git.rabenda.cn@gmail.com/

Change from v1:
- https://lore.kernel.org/all/20250506093256.1107770-1-inochiama@gmail.com
1. separate from the original series and add dependency id
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 61 ++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 85636d1798f1..b3e4d3c18fdc 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -569,6 +569,67 @@ spi1: spi@7040005000 {
 			status = "disabled";
 		};

+		gmac0: ethernet@7040026000 {
+			compatible = "sophgo,sg2042-dwmac", "snps,dwmac-5.00a";
+			reg = <0x70 0x40026000 0x0 0x4000>;
+			clocks = <&clkgen GATE_CLK_AXI_ETH0>,
+				 <&clkgen GATE_CLK_PTP_REF_I_ETH0>,
+				 <&clkgen GATE_CLK_TX_ETH0>;
+			clock-names = "stmmaceth", "ptp_ref", "tx";
+			dma-noncoherent;
+			interrupt-parent = <&intc>;
+			interrupts = <132 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&rstgen RST_ETH0>;
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
 		emmc: mmc@704002a000 {
 			compatible = "sophgo,sg2042-dwcmshc";
 			reg = <0x70 0x4002a000 0x0 0x1000>;

base-commit: cc6a9fb055e446e76a23867e42f12c4eff44eb00
prerequisite-patch-id: 7a82e319b011e5d0486a6ef4216d931d671c9f53
prerequisite-patch-id: 5a30fb99ec483c1f5a8dca97df862c3a042c9027
prerequisite-patch-id: e0da79790a934916d9fc39c18e8e98c9596d27ab
--
2.50.0


