Return-Path: <netdev+bounces-195597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E55AAD15C6
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A39188A1CB
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 23:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAECD26980D;
	Sun,  8 Jun 2025 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTV+86yg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29426268C6B;
	Sun,  8 Jun 2025 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749425401; cv=none; b=OtNYa1QJxwo6ny5RkFBqdqecOLZ2wFT00qTCPL/+ebxH9yw2OUSEkYvHTmYBRLZsUd9qunHrCv3QKRZHEuULlGMkMy1ILs93RI0dRg9uEIlnwNXKzizrTMi51xAIV1712PorpkmJLCXTCu4pyFGopWPiJvsrVK79iD9isu2s1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749425401; c=relaxed/simple;
	bh=0wJ/HWUUsDvlvcs/Wp6NepvS/OITvhDLuYG2E/dbhWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mD9wW2+DT3sqGsNx/uSiDWNjtgwd+mLUUDTXMdN8B5GFGDT0eI27HuDJ2VdQSoEsKIjMCKp9XCMTuEGih4K6kub3IHAJujEZ6F/MM9P/SjSI74bzi/eWZHZy3kXNzRQFaAs2GFLhixrkzmQTNaIk5FH4Ir9tS5HXAA0c5R6QPD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTV+86yg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a43d2d5569so50642111cf.0;
        Sun, 08 Jun 2025 16:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749425399; x=1750030199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIbMjxTvPEYfM1wLVh1S1rjKcW/pphi5tKLotbN01b8=;
        b=jTV+86ygCnQKC6ocz32q7uigL1hSEMve4j1e4fYQx4qAI0n8loiWCzLNv+CMN2U2sq
         Mhlhuvx2/YQV5yQDIlNvFUThdWIzA6WR046MqWGILfxidG9PUN86heL7aG60W3JVtUfW
         LhbPmwyqvnPFrpFopsIlikeOyTMqmnOWk9eSl/Fu1DIz383hdY1vxLk5R61WB1acLCuR
         n4v9Y55QxJFetsEPAlmhIbd55nrBlNvndLp60oHawbSqIZalJdK6xKNM5o+oPwYhjGSV
         dQdnnN7S2+XWEpw/BxHKaC9+p4tVXhMJgl3wJEweH2COXfcFOWNgbQU0HB6P1lquGD6O
         lzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749425399; x=1750030199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIbMjxTvPEYfM1wLVh1S1rjKcW/pphi5tKLotbN01b8=;
        b=HcSKX6eRmWUn23kJDxtTxIjh4SS86/wL4EdtRTESzy2g8IGjOVMn862jlc2NMnFANq
         CV437oofq3hpTrdiEWHGR642OuJmRmEX0sumHxg1d/blEINxcqcze6HcoYhNL39gJ/I1
         29kCJfZZhGvD//S+Ud7i+JwROJf4/d4iz3VRwp5C7JP8M8DC8mW1+BBKHU9V38iOdAPC
         oBzZjzeyOisIvlKJlETQGTesrL3hYvLxT8IXUs7K1M0hz9XeISBL4L0f+PJbCXWSPzOB
         VlBn6zeGbL13NSNfYazEeTvbHQrcFvlLBc+FY9M923pFs6ohzlyai9E6QZAE4B04RMfd
         eYwg==
X-Forwarded-Encrypted: i=1; AJvYcCV9hXHHvIfwJ4ISscgfrIZGZ16Bl5OIPrf3tz8FsKwwEqmq2UGrnG9bqdNtU2hlkskJtajqnKNC@vger.kernel.org, AJvYcCXUkoPQcm6uH1OYkEDDobhfIKB5XDFhucXyesxqlnuOIaNe7RMXQHand80uKEgYaVjmQyqBT65QVy7UT6K9@vger.kernel.org, AJvYcCXxQ0J/ywjpm8qS2oIWiF2KX8Ef7Z+rXOteuBP/nYvLDooKJJF2hJQEtdiJ8Yw4qA4Kj9byL1LrThPt@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3mR81p4YNdCdU2dKlQEieytnuehwZYscY1YDUsSZTUVqh8tu
	YsgM+pfj3t7VxSDvtV9QtZRlMvlvQbhDFTZOpZGEtzap+DzZ2PkLqPeL2N2RaQtO
X-Gm-Gg: ASbGncs+ZjUgCY+NroD4o4A5YTkJwnPfZ/o+EUrjkA4ADbC7LcAiYPJlLrMJFGDX+dZ
	gHJjw6V74UuYBl2JhkPyI4SQljuUfWVuNQ+RAH2G76POhxWw4j0Iv27MYsX7PXZQoFijqnJFnbK
	aqurfp5vxVHgjTG8xSmQPA4qamdI+Alw8UapBruGEGQ6E/cUNqsBN7/motvvq43L6+TBymPt2U/
	ZPO+9KAVH0pp4dWDPz0J9oMHya+FP0M3yxFcJtU+q1MvBRb+wjpHZql1vrrJXKhxnxxkB2Faf8W
	bS8b4OX4MwPG4q/kgB8fPNmt/v4ZHn56UZGNdM/VrYdehyE/
X-Google-Smtp-Source: AGHT+IGZUz6F5c0pXbN6o8Jj5csJX5GQPNNaA7JPElzs5JJ3JB4U3Aw34Dkaijp9bRjqsXUX+NbBgg==
X-Received: by 2002:a05:622a:5c87:b0:476:9474:9b73 with SMTP id d75a77b69052e-4a5b9da89c4mr211494501cf.42.1749425399168;
        Sun, 08 Jun 2025 16:29:59 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a61114ff23sm48697571cf.15.2025.06.08.16.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 16:29:58 -0700 (PDT)
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
Subject: [PATCH 05/11] riscv: dts: sophgo: sg2044: add DMA controller device
Date: Mon,  9 Jun 2025 07:28:29 +0800
Message-ID: <20250608232836.784737-6-inochiama@gmail.com>
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

The DMA controller of SG2044 is a standard Synopsys IP, which is
already supported by the kernel.

Add DMA controller DT node for SG2044.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2044.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index a25cbb78913d..a4d2f8a13cc3 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -31,6 +31,26 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
+		dmac0: dma-controller@7020000000 {
+			compatible = "snps,axi-dma-1.01a";
+			reg = <0x70 0x20000000 0x0 0x10000>;
+			#dma-cells = <1>;
+			clock-names = "core-clk", "cfgr-clk";
+			clocks = <&clk CLK_GATE_SYSDMA_AXI>,
+				 <&clk CLK_GATE_SYSDMA_AXI>;
+			dma-noncoherent;
+			interrupt-parent = <&intc>;
+			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <8>;
+			snps,priority = <0 1 2 3 4 5 6 7>;
+			snps,block-size = <4096 4096 4096 4096
+					   4096 4096 4096 4096>;
+			snps,dma-masters = <2>;
+			snps,data-width = <2>;
+			snps,axi-max-burst-len = <4>;
+			status = "disabled";
+		};
+
 		uart0: serial@7030000000 {
 			compatible = "sophgo,sg2044-uart", "snps,dw-apb-uart";
 			reg = <0x70 0x30000000 0x0 0x1000>;
-- 
2.49.0


