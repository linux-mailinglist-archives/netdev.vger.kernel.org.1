Return-Path: <netdev+bounces-140083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275549B534F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A812A1F23E99
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719272076D6;
	Tue, 29 Oct 2024 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bizggs0p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5434192B74;
	Tue, 29 Oct 2024 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233436; cv=none; b=HH/UeXmoIRfUEirS3vlq5JkMWuAU6WU3bE0PS7XVwcB805POsB5ybG798tbpxaWAxXp0GnsGwFUfhf5IXoRsnt3kwsmHG4+OImR+gvC9a4K4s0yUJU0iwXPiQXn9hWPjRYaxoOxzz7xPWy3dvm2StBuJxG+fPKd+FI6IiIQ9gUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233436; c=relaxed/simple;
	bh=/7wyiogOSmw3I9TDee9Zv17VHrKk7/JF3y8QrE9pGsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hxgTeCBEasELaYNrMUoZzzhMIMMesVCdcFVltK/uONhYOra3TU6kr481eeagli7t9M+GLNxvon08C+F7zoUK+miNq1+shhMHRIRit1NOtKFlyrqR6WgCAB56X9r4na5KKS3mxSloBGGqAu1BzgZDEkwYU6xNxcoGWmSMRe9B67E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bizggs0p; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3807e72c468so244871f8f.3;
        Tue, 29 Oct 2024 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233432; x=1730838232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fmaJ2cGgy9S2swZZo1UerLLaJvJoBIutdhI6IzAFbxA=;
        b=Bizggs0pwb01tCljfY8nWAnemulr65PDpPUp8fc7e4u6+R8SZpuWU7k8DAJXWJAiCU
         EcAKZ+hOGwyVfD1/TqGLcDfKFN1qQPy9v0V2KWeAxvBwmb6gTwOruGYNFz2PyhqORpyZ
         kkTBsWdXkTSWkN7xmRmo/fMPQ58qurNjUx/fcsQRaWuQK7reVpve0jqwF10cMXK2ot84
         TtMVT1eG/RPQKuqvX7DLVyQQxHA2WBvfIQPxjJitOp5kye5wZQ9KHRpIBvgcC8cVNQS7
         hQVpW2L69kaUXaPbmltjHFk2Cljf6uMkQJlKXyb0cD7/zJcMWoiAfIdA1p5N50ayepQm
         6XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233432; x=1730838232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmaJ2cGgy9S2swZZo1UerLLaJvJoBIutdhI6IzAFbxA=;
        b=gGbS4xSoeMGyY6UcNLMobQ25Ak4Yfj5EOmGd2yb399dYQZdE0XJnIHWeZ7++2c6lpT
         tpFZn37oxq0EH17Ko6p0aCl+QkUOrugkRIjkC78+Xni6NGx5iuAT2fC+Lcy9EZc90GVi
         i3IBR5F7wpqA34fIri/qHSMjw4avwI0Wl3IrFthMB++C397JaPJBUp0MhpXNBZTPNHr9
         a6+hx4jB4UoHmtEWDpnJlN3MCZ4gwxl7WCSmt9oWuQ9wc0tyQhiRjwlNoldiKOyoV3j7
         HRjCdOnlyGFuMRMS/k3nKwfAnzF8950ppYVcZi+FRczsQwOtqxmtMFO8dSo8vKNLTf55
         TAmw==
X-Forwarded-Encrypted: i=1; AJvYcCV6jch1GfxfRrwdvzKNaH1zUKA3MAPXqvgFNPF/e6klUdE/6w94M4mTZg2MGFHrngCWDlMNuizd35z3@vger.kernel.org, AJvYcCVJujYTwP9F28jmhHP3gb176vRe0VVJhC64u43pxx3x/Y1PQm5F/GN+eHvo03FExibnYczpj3DIxHqohdpg@vger.kernel.org, AJvYcCVbSptSwdCVsUt+KaLVo6NiMFAKhN9tFxZE+H+uSSJqIF5H7ZmvRB5JhcoNZTB/I+Ijj6jUhF3k@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbh6OjDFjM6bxaMq4opMm05QDZ7cguLNh0Mij7QAgd38lS4YgA
	Z1ihokUE/c3WK/LCUaRgcdwTrrtmzCtG/FgpEZzPnuLjMxIi9kWS
X-Google-Smtp-Source: AGHT+IE4eVnaZPidUHeSY1WAuGOgaGW6tLvUl8un5Y9u46tplJhMw2SpOUD20rey7JdzrkLSVHdpYg==
X-Received: by 2002:a05:6000:156a:b0:37d:5313:ee45 with SMTP id ffacd0b85a97d-3806100755dmr4716128f8f.0.1730233431682;
        Tue, 29 Oct 2024 13:23:51 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:23:51 -0700 (PDT)
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
Subject: [PATCH v4 00/23] Add Enclustra Arria10 and Cyclone5 SoMs
Date: Tue, 29 Oct 2024 20:23:26 +0000
Message-Id: <20241029202349.69442-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device-tree support for the following SoMs:

- Mercury SA1 (cyclone5)
- Mercury+ SA2 (cyclone5)
- Mercury+ AA1 (arria10)

Further add device-tree support for the corresponding carrier boards:

- Mercury+ PE1
- Mercury+ PE3
- Mercury+ ST1

Finally, provide generic support for combinations of the above with
one of the boot-modes
- SD
- eMMC
- QSPI

Almost all of the above can be freely combined. Combinations are
covered by the provided .dts files. This makes an already existing
.dts file obsolete. Further minor fixes of the dtbs_checks are
added separtely.

The current approach shall be partly useful also for corresponding
bootloader integration using dts/upstream. That's also one of the
reasons for the .dtsi split.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v3 -> v4:
- add separate patch to match "snps,dwmac" compatible in corresponding
  driver, required by binding check
- replace non-standard node names in .dtsi files by node names recommended
  by the device tree standard v0.4

v2 -> v3:
- dropped the patch to add the socfpga clock bindings:
  Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
  reason: refactoring the "altr,socfpga-" TXT files to .yaml files is a
  different story involving several other files, thus can be part of a
  future patch series, not related to the current upstreaming the
  Enclustra DTS support, so dropped
- adjust comments on boot mode selection
- adjust titles to several bindings patches

v1 -> v2:
- split bindings and DT adjustments/additions
- add several fixes to the socfpga.dtsi and socfpga_arria10.dtsi where
  bindings did not match
- extend existing bindings by properties and nods from arria10 setup
- implement the clock binding altr,socfpga-a10.yaml based on existing
  text file, rudimentary datasheet study and requirements of the
  particular DT setup
---
Lothar Rubusch (23):
  ARM: dts: socfpga: fix typo
  ARM: dts: socfpga: align bus name with bindings
  ARM: dts: socfpga: align dma name with binding
  ARM: dts: socfpga: align fpga-region name
  ARM: dts: socfpga: add label to clock manager
  ARM: dts: socfpga: add missing cells properties
  ARM: dts: socfpga: fix missing ranges
  ARM: dts: socfpga: add clock-frequency property
  ARM: dts: socfpga: add ranges property to sram
  ARM: dts: socfpga: remove arria10 reset-names
  net: stmmac: add support for dwmac 3.72a
  dt-bindings: net: snps,dwmac: add support for Arria10
  ARM: dts: socfpga: add Enclustra boot-mode dtsi
  ARM: dts: socfpga: add Enclustra base-board dtsi
  ARM: dts: socfpga: add Enclustra Mercury SA1
  dt-bindings: altera: add Enclustra Mercury SA1
  ARM: dts: socfpga: add Enclustra Mercury+ SA2
  dt-bindings: altera: add binding for Mercury+ SA2
  ARM: dts: socfpga: add Mercury AA1 combinations
  dt-bindings: altera: add Mercury AA1 combinations
  ARM: dts: socfpga: removal of generic PE1 dts
  dt-bindings: altera: removal of generic PE1 dts
  ARM: dts: socfpga: add Enclustra SoM dts files

 .../devicetree/bindings/arm/altera.yaml       |  24 ++-
 .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
 arch/arm/boot/dts/intel/socfpga/Makefile      |  25 ++-
 arch/arm/boot/dts/intel/socfpga/socfpga.dtsi  |   6 +-
 .../dts/intel/socfpga/socfpga_arria10.dtsi    |  26 ++--
 .../socfpga/socfpga_arria10_mercury_aa1.dtsi  | 141 ++++++++++++++---
 .../socfpga_arria10_mercury_aa1_pe1_emmc.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_pe1_qspi.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_pe1_sdmmc.dts |  16 ++
 .../socfpga_arria10_mercury_aa1_pe3_emmc.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_pe3_qspi.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_pe3_sdmmc.dts |  16 ++
 .../socfpga_arria10_mercury_aa1_st1_emmc.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_st1_qspi.dts  |  16 ++
 .../socfpga_arria10_mercury_aa1_st1_sdmmc.dts |  16 ++
 .../socfpga/socfpga_arria10_mercury_pe1.dts   |  55 -------
 .../socfpga/socfpga_cyclone5_mercury_sa1.dtsi | 143 +++++++++++++++++
 .../socfpga_cyclone5_mercury_sa1_pe1_emmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_pe1_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_pe3_emmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_pe3_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_st1_emmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa1_st1_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts |  16 ++
 .../socfpga/socfpga_cyclone5_mercury_sa2.dtsi | 146 ++++++++++++++++++
 .../socfpga_cyclone5_mercury_sa2_pe1_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa2_pe3_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts |  16 ++
 .../socfpga_cyclone5_mercury_sa2_st1_qspi.dts |  16 ++
 ...socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts |  16 ++
 ...cfpga_enclustra_mercury_bootmode_emmc.dtsi |  12 ++
 ...cfpga_enclustra_mercury_bootmode_qspi.dtsi |   8 +
 ...fpga_enclustra_mercury_bootmode_sdmmc.dtsi |   8 +
 .../socfpga_enclustra_mercury_pe1.dtsi        |  33 ++++
 .../socfpga_enclustra_mercury_pe3.dtsi        |  55 +++++++
 .../socfpga_enclustra_mercury_st1.dtsi        |  15 ++
 .../ethernet/stmicro/stmmac/dwmac-generic.c   |   1 +
 .../ethernet/stmicro/stmmac/stmmac_platform.c |   1 +
 41 files changed, 992 insertions(+), 93 deletions(-)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_sdmmc.dts
 delete mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe1.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe3.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_st1.dtsi

-- 
2.25.1


