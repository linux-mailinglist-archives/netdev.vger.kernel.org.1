Return-Path: <netdev+bounces-195599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C432AD15CF
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0943A352D
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A66726A0CC;
	Sun,  8 Jun 2025 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nICrxeMa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986E266B77;
	Sun,  8 Jun 2025 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749425409; cv=none; b=G7EUbsqs3BoSdrrKeF2FP0RDlBkpUQCERdqKuon8M4q00hAZQ6fP8YGjK1xotYKBAXarZPutyA4tBc1grD4opCnDQek0ME/P4Xi6pI/nG85LWhjfOK//ZCVZ3G6e9mW+0QMSgy1kvR3gXv1niHqcllnzGp+cnobdhRReNY5nuOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749425409; c=relaxed/simple;
	bh=MWElUnMvqvOdk28WeZ3kixapSyP3QUlNs0cWd7Y3wsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwHNoTFqWOA0iwlMy7yjSL1FLupqnsLHrnxniE0o49PvYcuBv8w/vrwNVbtXbtM2OAWw0ZXR2+yTVQgrWcjlmA7AKObRFdnHaTdzdJfdKzM3xJyWpcG+1OhgLzYprKNWk+VKTICF7Cn2HPdl4otMAMt+fngmmDgMYed0rkAyN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nICrxeMa; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a58e0b26c4so63103861cf.3;
        Sun, 08 Jun 2025 16:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749425406; x=1750030206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MPhc4m2BlLMTsqjKbpZeSk/tMLZcSiM106HiMt2a30=;
        b=nICrxeMaRZlot5yRFVXDhT78YIcl/3viqE0j0AdjFm77NfQVVhnVdD5DM5XZaxvLkU
         YISF2WA/r2j7m1RNgsfJd8RV5Ye+4pswLp7V2RJSjv4xH5ebJy+Mmx2Lm4rcBUhk0iPO
         b2Nv16w8sPc9JPUmAn1XoVwpD9Mwx2hROB6IBbFv1xDCtUimjEMjj91HYXqFTUq1iS1v
         NuLm8+mVM6nDJRMdcnaDGmIMiduCJsPkMnyRyFwyyiddMUYeAm2Mb0TcubnX2pIBbO1L
         n4jBQFeNvtUT34WZqAySZ/Aokm3QCvGdWA9ztG2zxQx+fViYrFV6SnUv0gwTFX6OYE5z
         xA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749425406; x=1750030206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MPhc4m2BlLMTsqjKbpZeSk/tMLZcSiM106HiMt2a30=;
        b=O4pPrUWyegDb4sRe4yhATUbVDBxc11zOoKLzqMKyeuN1bcXyiEMCddyxA0I+/Ruh1g
         f9AScqHj5oExEts7aay1+317QNn3gPWF9s5JzS2jvZ435mvwa9mGL4aeuAjyxdgKgZAe
         F9AkC5gnJsiYRhOjTRC6YPWtrntZOvwgvspH6DVQB3mKYe+FUlBYr1i746sNwfuYOuds
         3RJ+UZMHUxS1mUPIQG0P6Gm8a+SO/mtqFcplK21lFk7hg9bq1ZSPwzhe5TY/mnnqEbjd
         qwYlAPEa3CM2m9fwVD8cpsE9nt8gIL3ydzlFbFK9w0Q3dHC0rPZoIJBwa2xh66A9TTQn
         KZmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlXKiAgVE2QHVPM2i4JoGkP2IWiD55EBJt6zYspCXQJE1IGb8Einjq6emIM5QIpFAkNvCAKor/pJh8@vger.kernel.org, AJvYcCVDZ/XurE19jalKBoHQTael53vzHUMXHBXMgBpQzo2xZk+ld0c5rhgJXMHBjJ2W4n/l+Mh9iXRnIqJJ9FA2@vger.kernel.org, AJvYcCVkFZiaf+sB9Ex4q/jhFfrA4PGpSal/X+bVRZBUx3wGoHNSw/Zw7jal1AtBvqM6owW8noH4vFg3@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9K61KVt2U4IcrnuCQ9OI365Rk3Mg641XoURZcprK9B7JiaF3
	q1MswnFMfVmiG6OD2Hg0J3eVijHGixUHBhLJiYtBYJvcyAuq94NV3F3u
X-Gm-Gg: ASbGncttU/WLe+Z+hxFd2lqvdFLU3/PTkopw8jMwxNoul+EOn+fpkLDCOPZlbd2Njph
	ZXH2aT7QcVzz6bb1o1RVviphcoC7/0CwQ5JlCKUsjVp8H3OVeLQ/kaZp7KyJ6N4x/hwjjfPj/To
	OzrGJJvsVWDozW/r/wiwdXmQJI/+3m2Q5a/dJuzMxOvC+jTzOGVTr45MIlwK1fNq6dxRhP0SwUl
	9sEnQPLnqY0ckdE8OhZ3wKEeJSQX95QI5OXAnxS3kC3nEc4dEbQbOHefF0i2xcwTYVASk2EQmZP
	zBWGaQ9BEy0nVG5z+8xbDD9s8AI=
X-Google-Smtp-Source: AGHT+IHStic3inQZFI5nmv82JIFqhS8ZN7gZGzEplcgmQgDRVr59jgDMXWjQUVqyNlZ6QMJ/fIJ8qQ==
X-Received: by 2002:a05:622a:2606:b0:476:8fcb:9aa3 with SMTP id d75a77b69052e-4a5b9a2891dmr263302531cf.13.1749425406381;
        Sun, 08 Jun 2025 16:30:06 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a6fc3c36f7sm10256631cf.66.2025.06.08.16.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 16:30:05 -0700 (PDT)
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
Subject: [PATCH 07/11] riscv: dts: sophgo: sophgo-srd3-10: add HWMON MCU device
Date: Mon,  9 Jun 2025 07:28:31 +0800
Message-ID: <20250608232836.784737-8-inochiama@gmail.com>
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

Add MCU devicetree node for Sophgo SRD3-10 board. This is used to
provide SUSP function for the board.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
index d077923097e8..75564b2719cd 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-srd3-10.dts
@@ -36,6 +36,16 @@ &emmc {
 	status = "okay";
 };
 
+&i2c1 {
+	status = "okay";
+
+	mcu: syscon@17 {
+		compatible = "sophgo,sg2044-hwmon-mcu", "sophgo,sg2042-hwmon-mcu";
+		reg = <0x17>;
+		#thermal-sensor-cells = <1>;
+	};
+};
+
 &sd {
 	bus-width = <4>;
 	no-sdio;
-- 
2.49.0


