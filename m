Return-Path: <netdev+bounces-203600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD7CAF67DB
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 04:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D259D3B898B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 02:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE94821FF58;
	Thu,  3 Jul 2025 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjiRFPln"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F812192F8;
	Thu,  3 Jul 2025 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508988; cv=none; b=pYg4LkUMrH3dc5pCPe7/ihYNW9Yq3vzqBwGCSXQgJR8nQcdAWh+3rI8mPMizLUCbKJQSmGZan9BsGs4FlxgieZ8zD2aSBdQmaJP57YoVDolUI9sdcueg93uaJ+jt6I5uUZOdEoDosfgh3zWzvrUpoOwak72RJGU9LeqRpMNzaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508988; c=relaxed/simple;
	bh=R3+mZ/ahgSxUz73+rZU26mssIWzCroveyiCdoSoe6Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PldCCRZ3oEtdK3aPbP0s8fwUcR9RZlFt1fsMJ0dJ6VN3ViL8AncqbSbXzbI3JOPa4/EpOhKPSqykQWYutYDfpY4teD9zfZuM1sZgE/GbP6hdMFDQct2kef/aIfkfS+h5qea1+NJYTTfUn3w/O2kCk8BPjMizDIbb3fqeKn/JohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjiRFPln; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313f68bc519so3702808a91.0;
        Wed, 02 Jul 2025 19:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751508987; x=1752113787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2YnPV5R9z5TbfIfu+epngB5XBVjG855v9YBWyemiuo=;
        b=kjiRFPlndEcAn+x3GSMENEEiYCx42XLYWeyp9iWk9V+z//46vW5owXEIEkvK5PAmXd
         +g1B+tQiYr/FDXPPF4XE9DclUvd7GazZS+7EFSuUj/jQ8+Bm2UODlbI/EPyLmzavCn2J
         KTBs8NuAdifa4Frm5lrbrbBYgfPBNqyg0gXk7VOsiuF8KnNP2uNPW7/LaEuc+H3rvPV/
         u3fnBUG9gPGk51EnMUIhRa1aMp8D+S4FwAdPhcQoi32AFvc6bWdD3dNNBYAb9XOhwYfE
         gk1iW2867JOSGpUg39uxN2uKfK3tDuWdmLPvHlpWQD1FO1RyWCPgiJzvq+MUjljqPPAB
         YMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751508987; x=1752113787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2YnPV5R9z5TbfIfu+epngB5XBVjG855v9YBWyemiuo=;
        b=NNySykmzF8yjvAVY+rva0f4vS5XShg7i7isdIClnNohsboIC5vcWfhlEi0Lk5PP6vN
         2KYmJHHHsDYl0tarZdylz+Bx6az/cR+ktHqTSN6ktYPD1OQAuc5s2hvVHBEY6vq2asFG
         GmkLfh0qyE6fJgK7nncq3IeI9NTbDwINKjvaGVfKCwp6MzXT0mxWbqD/GytBYD19QcB1
         iqkIbolVRx9rQoulDcKNni2z7T/ZhUCybunJH4GVEPWOfpY5zMx3nE2xaCiWTZbDftoo
         Nf7UnZviJHmrNgtNjUdGkmBH2VMrGLgC32qOpWhfF6/lzfmI8DsbfRPJa+wjEJzADM3l
         1D8g==
X-Forwarded-Encrypted: i=1; AJvYcCV/oZzV2/z+AD7iQpqSYf2FhkaxM/WyJGk5yEUEUFZzdVR0pBMcKRBH0ihHh3vmimjDcVBtB0UL@vger.kernel.org, AJvYcCVlM2nfTxWzv+gZGKdTtE4w7xrcPs1IkcjEtKhbjhkVaR+SGnqAwlpR/xe26jGQQRywq9U4n+yL7DjXbEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOg6lmq33fwKMtz0UDrdR/Ll1a5qNnJcKxUqdi5XfmIaF4si15
	LNJALhJlVmZdOghVNZIM02utu0ojz7nGxiENE/Z5C5/HPByb4jyrXZtW
X-Gm-Gg: ASbGncvoa7Dll6TS8nokJDQuLO4csxNo8Jdy9UOxruVZZTnOsbs7RZnzslUxcKkTw3V
	OZyuhCHHtJL5w3b+kYWzukuB4NoDWDUJYiFu/Sydtmz5JgfS5iSybcKs54x9M6hwSyzfuG+n5Rq
	hh8k49g0PopnCULHfL6Ci7KQzurZiNBBSeFd0Qp3MI0MhdyOZd8k+k67+1Y6a4B95znkZ6ImpLy
	pKmkzjVEHOf5IzeP5Yh9ussDh0JLHj6TOzSOIOxlx9Xx3fqjyTPVe4wx9FjjzUWVXcsW9Ae3F1G
	kurlk6h4xRu2MuOK+S9VIuVTt2xOqkwVwgvqhuxf/Dy6e50Z0+YVAWljHiVbWF7ocg/MpTvF
X-Google-Smtp-Source: AGHT+IHSEMW9eiJM2jAiH3yvHUFxCLUuLck/E/k8l3c6BfFYTR43saftR5J6mphdwx+U28fhcLnfZA==
X-Received: by 2002:a17:90b:4a4a:b0:313:db0b:75d7 with SMTP id 98e67ed59e1d1-31a90befeb3mr6810465a91.27.1751508986742;
        Wed, 02 Jul 2025 19:16:26 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31a9ccf86b3sm928863a91.30.2025.07.02.19.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 19:16:26 -0700 (PDT)
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
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Ze Huang <huangze@whut.edu.cn>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 2/3] riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
Date: Thu,  3 Jul 2025 10:15:57 +0800
Message-ID: <20250703021600.125550-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703021600.125550-1-inochiama@gmail.com>
References: <20250703021600.125550-1-inochiama@gmail.com>
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


