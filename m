Return-Path: <netdev+bounces-196448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6DAD4DF2
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44874178D78
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E087239E63;
	Wed, 11 Jun 2025 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQnzrt+5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B4723958D;
	Wed, 11 Jun 2025 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629311; cv=none; b=behZp+hKDKLDzHQRzWWo8mBVEZTW7QIN3uy5Ph6xvVviCOgPGE2m8dhkfsWe2UursyJ/kdchqSsRjilRF4JOmhkA8peIYsa7AQn0KsxmiaYZ+wg43L6Qbf8DfKOKXyog2UnjFTS70HoXhRno/w14Pu7CSLCTkDvU1A5l+cpa+mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629311; c=relaxed/simple;
	bh=YUwag/sxrcaQERBtDLb3x3lAh0COgjATFIEenn0FikQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQqKEKTo5t/MZ1bcI9eilLBscUyaSqdK/LbUw3yfPj15FjHowQuEK2q5LIwfVJUzAel1Js4oIIWutfKktoS2MY9v8o3VfMkGvGiCOD0ZhkKLFc5NMHp9ueqe2W+2JwtE7p04/sGXoa21a8Cfb61aMszwsXNf05e/ZRwlj3kRygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQnzrt+5; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fafb6899c2so6724706d6.0;
        Wed, 11 Jun 2025 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629308; x=1750234108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ge003WgsMwudUMdpNi+b49fQSC43w6jsORUWEBCoqBQ=;
        b=nQnzrt+57FbOwjewHPsxBJwvhK/AgzY/R9qbA7xmh/8zqcq29K/70dj7mxB8lOc9SZ
         Th5Zq6FjRStf8NZO3I4+81ugxnbO4zvJwPVxFJr5SSrxzJf0Fp3r38HCNVXH9WF8vr8g
         BSLulDYJg3deHu2kxF9yCtH8m9d+FNVNMHX7/QphqxKieISeM1UngKnGXILLrkyyQSRX
         8MUa9nsZao8lrfsf2sKJt2j0jUa2qasgaoRQhW98pEyUcViuzBRpr3/tlZYZFz/m2pS5
         jI6c0eA1ZOiIl2OKFXuKt66NiRcXmK0KOHo03xW+nYufu09KHOMe9JXLim0Iql3NMvby
         Z1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629308; x=1750234108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ge003WgsMwudUMdpNi+b49fQSC43w6jsORUWEBCoqBQ=;
        b=r3La0Fp5scSzmpyhAcXWASSuvKG730cRjaAsFwHZvC3qKP28mBhDl5cqb5HRr8cQIc
         AzdYEHxkwiT9dL+iOKJfmP31kr/4MswFUvcmQ1r6TqUjw6NlUyouIilUULHQQ5414+IZ
         TZlBG0ZG4HzBnsORRNwnW3kRHvRiQKFcpHF0r8UVKO6SMrwFwHe1hchZxWXRcOKb1L2X
         7oxhhMrWu+ruHOWMP5u1QCOalZcLvl1/ErxeRYPTBOoQpwg6dmraD3ryGLjLlty8lCDd
         F11rdcrnJGE0je5w7lrdQH41Ag2ykS24ZKGYDIbIvaiTGpXV/Sl6Dee8IHRzk7Tg0zfR
         tfEw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ2ZSwhwbWblOxPFAReKWxCiQaOjuGXHYKqHQ8sLT/MiYgrFkkkyyCkv+lUvKCOY+KGfyXCIhWlr/2Hdel@vger.kernel.org, AJvYcCWpAhEq0BLzXCITtpoPYOCPko/ds1uGqjTdbabHWe3Qe5Khngf7loq/hI2/w177E+85/2DHYpP7dYIS@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTVxq5UvTN7+rIvKMOQkefG5MZuGMMmkKiCS5xxrhS0a0Jptp
	XdEe8/4pbhnvyxqdBEfSiIXIKlBjG9hV2oIrvsKNEXnJ//8tKhudgeum
X-Gm-Gg: ASbGncsisAUndTcdSOh7OdEW4SrBsRrXBnp1/P4qPeobrs0dHvKRnUJ5PdHZ1Vi/hVz
	hcevSIWoinU1mEFyg2XCniUOoZoHVO7NJdkfJcscyIB/wj/8dp8LKuL0P0vlZmsZUGaHrtLqMnK
	dblk6TBzyCY9VBJgnG5gxzmIRAykw8eA2oRDQsqdYXR2rcn6Ce7FB59jaoO6wME2kcjKWVN8v9h
	KC7b1i9ZAZD/FsEM8Ufft7ct2otyrwHOC1CB1/7NZ4LxBIpQFNS72QWkZcdbqLg9M2M72BclZrm
	eL/DxccF1CB6TAktNsY+AtgFY+NWYAAoAbQNxGt3N7yJYd3a
X-Google-Smtp-Source: AGHT+IFBz0E3rXdgSVz181RQOaZkyTs2eWSoYwoAfP1yHwV/b8ZHhiVjlkMydErBFnwNENizLT3OYw==
X-Received: by 2002:a05:6214:2aaf:b0:6fa:ad2a:7998 with SMTP id 6a1803df08f44-6fb2c3d48a8mr39200286d6.18.1749629308594;
        Wed, 11 Jun 2025 01:08:28 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d24b32073esm847127185a.0.2025.06.11.01.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:08:27 -0700 (PDT)
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
Subject: [PATCH net-next RFC 2/3] riscv: dts: sophgo: Add ethernet device for cv18xx
Date: Wed, 11 Jun 2025 16:07:07 +0800
Message-ID: <20250611080709.1182183-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611080709.1182183-1-inochiama@gmail.com>
References: <20250611080709.1182183-1-inochiama@gmail.com>
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
2.49.0


