Return-Path: <netdev+bounces-195603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF9AD15D8
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967C23A4310
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 23:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8B726C38D;
	Sun,  8 Jun 2025 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeD6vUtR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC226B2DC;
	Sun,  8 Jun 2025 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749425423; cv=none; b=OShaiNS75gUHGTXu8+/CJ5Nw/hlC20XlwwatJPakbygcGXQ1FhGqB5TgM2Z8ddNBy9G4KVbvAkmiBITEhJyQioqzpNTvrA8rb2nGCMkSQstcFcLB9vX3wK/1gfQVbYu0eZ/HSeszl6daE2TsZ9rWz0XjEl3HGhTgjL/QFX3u7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749425423; c=relaxed/simple;
	bh=hKuiKWddi71V1a4NYuKQlXX2OOeDvG86kj/V8uak/Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djwhXntIUSM+m87erhhoTukwwzAolakbJx0JS5QHFyo43qCPDJT2DffqDC54Qq/x99UH3jKdY6EFmI7dc+h+UCt5ERsglFWBk6/B8EoNhGsoQX9Yna4vRZQap8lixhZy87ftn8fkxa7KKNa2J8uuTbI2PnG52Hvk0gRnREmQm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeD6vUtR; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so63556936d6.3;
        Sun, 08 Jun 2025 16:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749425420; x=1750030220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTMiZWOdHSxhmNoMeUDatOOm/HUxNIYFkar2Sv2iSWw=;
        b=JeD6vUtRN2LNQAa+4x5uzqGPvS3LJivEhsNUNfXg7I2Xx1ZvtTZKY6GCsURfsIXmlW
         0khfgQqKrtP2IOq2dpz+yDCCwXwtP4JsPflPq/m0h6GEzKv9M4lmE5mRsaYR0Q/oXVWD
         YKdDIqC0CULjxEN5FoNLP7SRfVEi991XDgLkfrbhIr73OUsxWl108eudI00OudtqvCOm
         hq9fBKtayE++5CQjoIucoGfH4GQ8IK2ORlAoLtg2yy6v0gFVemvDTSHJzm6V+QfNkHmX
         GT+rDCg8igUlbdPvYmzZNfx0pPD3n9zfgxV05gyOKx3kJwTwaEWw1OxmPQuvRz40TOVB
         KkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749425420; x=1750030220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTMiZWOdHSxhmNoMeUDatOOm/HUxNIYFkar2Sv2iSWw=;
        b=dAnVXYJqlHkkXk+edwg/qUQuczQQ5FFZs/kG8EVEMVcpo9g6xnBfXUquXhW5lMxA/t
         /5tN6lZwWXSSq861mJ2l2cHIFkIg75jxYCCcf4otrFLPFeFOOEtzp1lNSnwtIPlpil9w
         N8vQCHn0aZZZeaFx0a+QGldzJhvFsDEWxfR0VcNpqtVSXRCoLV4QsJvLwKpCiwIb3pqh
         +znDEadVtxJ4pGbkQ5Ns7AEKOgDyqzr6eUpgJ/4T2AhqLSmW3hEzejY0Aws2zvTDOAOZ
         7MvwWDmkdCClIM7v4Ib8vFu4Us7UnVHrLeXILbRnERvUrBQhRrAIXUX0UT/5i9Xb3qQD
         2jxw==
X-Forwarded-Encrypted: i=1; AJvYcCU1/QzKM7PiZhZaq3E3WK4bofC8oypbOxXpdxlsI8nRXrcEN1uJZSDiuyfSSeozXTxvWRWkllnMIu87@vger.kernel.org, AJvYcCXL2+twDRHRgZo7D1vZ7xr550nElfEa6rVebrm6GCntWa4IRETGbRRGgCw5M/eIus/hnnqkNXF0@vger.kernel.org, AJvYcCXPbWPwkryqCjMtKrkKM0ReWOas7I+4bMgW9L5hjabF9cbL+ZgMRhzwS3WL0N7ZatrfZRDu/xEurVZmTomU@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJBExl1iX/bF7/XjLgY+4iL/SGObsNL78IvYBl0fdhQGJe0+c
	3moy8P7NkF98W3lo6JdzSr4vyzLnmskb2R+ZEjpQv/lc/GcDX4MU51Fd
X-Gm-Gg: ASbGncvjAa2y8aSEC7FDaWsd3rcp/yFgENz4d0WvLVDZPZY+vzJ34j3gluTVXOUG3qI
	2adovq0PDG3ZrRv/EOmxUNKh3MMUJOtFu33/AZDUCVEBQ2XqMhowyzLXvjs15Q93es1L6otm6Pz
	fe5h0BGYgU3ZkuzCF5N6hriLG8iCJtpBnfbBicHg/+Ke+CX2n/02igxPUV0W80XIs1ei7tgki3k
	1ZKJ+x17L8h8SW44gNB5tJ1js/232gBF4X+AanAvYvF/paovmUwRvujDHRg+ixTDaznMtoc2z9g
	CkavHQSkx7mbD8nSVz1bmKc2fyVlJoPQNFyQZg==
X-Google-Smtp-Source: AGHT+IGD9lindtx6ymMs0nT5vWjSjRbMQlERRX74trFsu7rLb4EqGbCLgdn+/nyXchTLQeK+DBIMwQ==
X-Received: by 2002:a05:6214:d02:b0:6fa:cc39:90 with SMTP id 6a1803df08f44-6fb08fcd546mr174099416d6.29.1749425420312;
        Sun, 08 Jun 2025 16:30:20 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09ab94casm44170066d6.12.2025.06.08.16.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 16:30:20 -0700 (PDT)
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
Subject: [PATCH 11/11] riscv: dts: sophgo: add pwm controller for SG2044
Date: Mon,  9 Jun 2025 07:28:35 +0800
Message-ID: <20250608232836.784737-12-inochiama@gmail.com>
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

Add pwm device node for SG2044.

Signed-off-by: Longbin Li <looong.bin@gmail.com>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts |  4 ++++
 arch/riscv/boot/dts/sophgo/sg2044.dtsi               | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
index 01340f21848f..b50c3a872d8b 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
@@ -63,6 +63,10 @@ mcu: syscon@17 {
 	};
 };
 
+&pwm {
+	status = "okay";
+};
+
 &sd {
 	bus-width = <4>;
 	no-sdio;
diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index b65e491deb8f..f88cabe75790 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -347,6 +347,16 @@ portc: gpio-controller@0 {
 			};
 		};
 
+		pwm: pwm@704000c000 {
+			compatible = "sophgo,sg2044-pwm";
+			reg = <0x70 0x4000c000 0x0 0x1000>;
+			#pwm-cells = <3>;
+			clocks = <&clk CLK_GATE_APB_PWM>;
+			clock-names = "apb";
+			resets = <&rst RST_PWM>;
+			status = "disabled";
+		};
+
 		syscon: syscon@7050000000 {
 			compatible = "sophgo,sg2044-top-syscon", "syscon";
 			reg = <0x70 0x50000000 0x0 0x1000>;
-- 
2.49.0


