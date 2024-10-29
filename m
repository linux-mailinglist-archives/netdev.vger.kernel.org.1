Return-Path: <netdev+bounces-140104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2BC9B5398
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093A41F23A08
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC40420F5B6;
	Tue, 29 Oct 2024 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KffcFfKy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867A520EA4F;
	Tue, 29 Oct 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233472; cv=none; b=STdZKg87Ifjover9nf6aurfTAtFV1tpWeZMNmyEoO1SNHOiY+SS7H6Yi2vw5UygNFZNbEGL4809c7HUn9lYTIdIrzSpR64mFFkqYvf/DiMp9Dsw6k9NXebZU7xmZHlRkpvx49bQpXOgnSIHKeTQ8Z4qMXjXu02wHGx2B+4heDU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233472; c=relaxed/simple;
	bh=yqFBZ5HwYNdpyrFZYRbb5VqKZv0W3oDP/XE4ZOzqORs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ik3/e8uZzjcLQ3xCnARciJWKp6OX+q2lEyIMK1trdjHAePe0jgtzO2Onkad6MsaR79hMmgyPmvrslQo3hpyrIuW+PavRR8bN+piPBbw8WXDSkdvOJskAcQxZwxpJKM/7Nx4NXWn109eSSr4ClXPp6X5eTFYRhmVgZEAf95ndhBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KffcFfKy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431506d4f3bso6272435e9.0;
        Tue, 29 Oct 2024 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233469; x=1730838269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0rrp5xrTxl0hGh1RK0+7VZvEHCMBhzUuqSkpHc7vyU=;
        b=KffcFfKySkXxEP+7DJ+is8atSJgtRRsoDmKssFSFebAc5Pc0pya78EDpTVKl/ONGfh
         mY1p6UdHX7rIZCz3Gb19PIImD0bKRhS2Kz9vzHubeLjhCVCoSjCBZWc4QGJlqQQUqhPd
         TvbmTzcpBdtWk239CiKhxMSk25iTGjbWnW6T4AgpnyTz3S/D8/1ujIoP+Y1SUjV5OcUu
         wpcrtV56E3QfugevlK/4By32LJxpkZmTBde4rZ4o0GmpeEGE/MemiHuhS1igySmM0VjH
         J+5jwh+gR1h/NMoIb0zF7vtMbMCVV14whe/j0Nmdjs7VSydCrodndb55M+hqLwsOT2oV
         Dz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233469; x=1730838269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0rrp5xrTxl0hGh1RK0+7VZvEHCMBhzUuqSkpHc7vyU=;
        b=UykMUkPBsV3DSf9wzNrfvFCAqFEpbyvU9+IMvT13RzoHIqa+aDJy4HpvDrK75IaXMT
         RpZ7KXjDJkVSlg4ThLATKJp8wXWIXI4Kl/KM/YJsoiarjwUq+m/oQhD89WJbi2jipQIJ
         Hg2ZktwrTEzQydZikTU4IeOUCY8SKBBvOP6CMJFKc+Ov2xctJ5jz6bllUOc3oxRKdIDQ
         YTMmdrCpqQt058sE0vFsw7wvQ2MZhygscydFLpk3Bli7r6lcm+PqlJ5aIx1doKeV9fmF
         49HKx1XWOYRBpavT7b99dBc673ukqaZ6bUy+n1JJkDWLTyFUffYrHhGPatS3n3H9AClp
         XGuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV10KDc1lQS78RrvbgknvGOWR5Hio8rMrxMldCA6IbgIJQPDZXphMKSkNKtQy87AJGNPQfjAy3i7amDOo7d@vger.kernel.org, AJvYcCWGMa24QYvcQIDU7SYmP/M0G7hHzIZc9praIf2aULismzLPhawhbGrt+EOyIDtF5BamxT1/Gn2y@vger.kernel.org, AJvYcCXgb/U/+qcmv869s1Y4ACemvRrT+omqWQ9c/gUXl54U/BF/KviRcqtW7kWoPO2wJ10TyIeCCrtUJU65@vger.kernel.org
X-Gm-Message-State: AOJu0YxLiVstc3cScu1z2P4/iCDGWaQaKEuP8F7GzXMvJT8vWPP5eUif
	piWTL/Ap6Kx3HwXfnW7cYijv7dTZrQlMAKcrm/QBYdLsDE3vNptH
X-Google-Smtp-Source: AGHT+IEhYwBOUVTvTj3Hj0ZMICPfIHBCtNgFSxbtpX78XFkcd9rCEeOvpqOMJ3bxsigpakj/rBHQPA==
X-Received: by 2002:a05:600c:3b13:b0:431:55f3:d34b with SMTP id 5b1f17b1804b1-4319aca248dmr50351615e9.3.1730233468766;
        Tue, 29 Oct 2024 13:24:28 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:28 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 21/23] ARM: dts: socfpga: removal of generic PE1 dts
Date: Tue, 29 Oct 2024 20:23:47 +0000
Message-Id: <20241029202349.69442-22-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029202349.69442-1-l.rubusch@gmail.com>
References: <20241029202349.69442-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the older socfpga_arria10_mercury_pe1.dts, since it is duplicate,
the hardware is covered by the combination of Enclustra's .dtsi files.

The older .dts was limited to only the case of having an Enclustra
Mercury+ AA1 on a Mercury+ PE1 base board, booting from sdmmc. This
functionality is provided also by the generic Enclustra dtsi and dts
files, in particular socfpga_arria10_mercury_aa1_pe1_sdmmc.dts. Since
both .dts files cover the same, the older one is to e replaced in
favor of the more modularized approach.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/intel/socfpga/Makefile      |  1 -
 .../socfpga/socfpga_arria10_mercury_pe1.dts   | 55 -------------------
 2 files changed, 56 deletions(-)
 delete mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts

diff --git a/arch/arm/boot/dts/intel/socfpga/Makefile b/arch/arm/boot/dts/intel/socfpga/Makefile
index c467828ae..d95862e34 100644
--- a/arch/arm/boot/dts/intel/socfpga/Makefile
+++ b/arch/arm/boot/dts/intel/socfpga/Makefile
@@ -2,7 +2,6 @@
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
 	socfpga_arria10_chameleonv3.dtb \
-	socfpga_arria10_mercury_pe1.dtb \
 	socfpga_arria10_socdk_nand.dtb \
 	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
deleted file mode 100644
index cf533f76a..000000000
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
+++ /dev/null
@@ -1,55 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2023 Steffen Trumtrar <kernel@pengutronix.de>
- */
-/dts-v1/;
-#include "socfpga_arria10_mercury_aa1.dtsi"
-
-/ {
-	model = "Enclustra Mercury+ PE1";
-	compatible = "enclustra,mercury-pe1", "enclustra,mercury-aa1",
-		     "altr,socfpga-arria10", "altr,socfpga";
-
-	aliases {
-		ethernet0 = &gmac0;
-		serial0 = &uart0;
-		serial1 = &uart1;
-	};
-};
-
-&gmac0 {
-	status = "okay";
-};
-
-&gpio0 {
-	status = "okay";
-};
-
-&gpio1 {
-	status = "okay";
-};
-
-&gpio2 {
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&mmc {
-	status = "okay";
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-	dr_mode = "host";
-};
-- 
2.25.1


