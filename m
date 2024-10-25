Return-Path: <netdev+bounces-139180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5929E9B0BCF
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D391F2312F
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC620C323;
	Fri, 25 Oct 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="EwYpP+Is"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629220C30D
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877984; cv=none; b=FS1dzXl/LTom+Ds25eQupUW79c1igOyFTnQBODpswyAlK8P3zGfvveqO1A1R/UFHZZ6wtLr5T39BXbwaQ5CBvXiEmNfa2cn7nYYc0e29mYGRYoEZHUkMvgfnnpSDfqRv0ohov/npxyE6kwJjQSSdPI2OvuPKeiKmKO993+Oj1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877984; c=relaxed/simple;
	bh=fm54hayvMANe3JxZyEsSTvLXltZ8DtFFJvJHij8VzGs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DFV1GGPCuPSvSuLX9g59rUM2s1f3AhMBwC16kV/ie783lOoPuyR/9fMTVdA1+YJSERTZP54mIdsL0TH1Mg4QXrmhfqQcehhJnfe2RoLUrc6oCoLOTKFgbtYCDYQ7M2AgzWoJRTtow0gf+lNTn6Edu+En8nFupQ72wO8d5yy6fZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=EwYpP+Is; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e30fb8cb07so1682252a91.3
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1729877980; x=1730482780; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rRtgBgW6s/EQDOLVk7vTju3fTexfS9nXJ3lju+LyV5U=;
        b=EwYpP+Isg21dcqb4LwodTM4ts4zf3onoCu3Vu+7kmJMGs0yX2kJN3xLyB3hjwNsrXP
         XV/K+KPekezduTuBgC+ylwZdAu1Y9mQ96Zv/5jBCiADFSlePz0EZj5rxTY2ZNkn/dndi
         q83WPt2OQ5ooC+WUYy0gK6JUfmtNMyfQ0DBO9eSidu5jPBcFpSNpAdkrBk//irXyz5WT
         29U02nrkGBUMWpOayz740JffLWqVYMoe23Uxd5v30/UMNDe4D4u1nMc4J2Fnt92xiaQp
         I/uMC7fa+94bDGXbKB8cnHBQ9tWYZpzBEw++PH7sTMIXD1N+4CYUZOM6DxmdKxEpoXfz
         kI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729877980; x=1730482780;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRtgBgW6s/EQDOLVk7vTju3fTexfS9nXJ3lju+LyV5U=;
        b=kaydL8R5yYBEqxen+y/+fjRyFBTUEExAz/nrNZ6sMtSjiQo2oF2P0uTFTEqskC6vQR
         8sUVaA9qqFSHELgX5rOJZIDivbJh9hJn0VuKZqHprYoG8LeFKZ46fO/ahNslWRn36oHX
         +z+gdU1eEDxbqGOvmzhkNl4MCYLcCy8pbDEYqnapS0v78488kyc1Qk1lnR+H3XvYcihY
         T9v+ibWbtx+xOXfGiVXYZv2jbr1PYGqSUmCOiZK/OxOcyrBGtWkehhEOgweWnO9OKwsl
         5lkC0W7uS2uW4/Br16WszLlUz6c5GLQ2oi41pNFs64P8EX2Odkyjlfeqt29PD9ppV2YO
         k7KQ==
X-Gm-Message-State: AOJu0YzHrIrsaAtFuCAApNek4TsrjSV/g/1FaPNrumVIHfsSPc1dk0Ob
	VD6T60g5SxvD/+DznFXRzE0gwF8SrFhQ779l3YVdg7ofrF6obHcI/lFiwSuh9sE=
X-Google-Smtp-Source: AGHT+IEaYZjwmDMtPye4RiuOg02mqdtcGwqC0dAPHwGmLr3SmAM/hWVbsZOksmPjY0Qxh811xJrTgQ==
X-Received: by 2002:a17:90b:3ec9:b0:2d3:da6d:8330 with SMTP id 98e67ed59e1d1-2e8f10507f6mr183354a91.4.1729877980066;
        Fri, 25 Oct 2024 10:39:40 -0700 (PDT)
Received: from [127.0.1.1] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4ca3fcsm3813961a91.13.2024.10.25.10.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:39:39 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Subject: [PATCH net-next v5 0/2] Add the dwmac driver support for T-HEAD
 TH1520 SoC
Date: Fri, 25 Oct 2024 10:39:07 -0700
Message-Id: <20241025-th1520-gmac-v5-0-38d0a48406ff@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALvXG2cC/x3MPQqAMAxA4atIZgM1WP+uIg6hRs1glbaIIN7d4
 vgN7z0QJahEGIoHglwa9fAZtizAbexXQZ2zgQzVlSGLaassGVx3dth23DbMvXENQS7OIIve/20
 ELwm93Amm9/0AtTd5gmcAAAA=
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Drew Fustini <drew@pdp7.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Drew Fustini <dfustini@tenstorrent.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1

This series adds support for dwmac gigabit ethernet in the T-Head TH1520
RISC-V SoC used on boards like BeagleV Ahead and the LicheePi 4A.

The gigabit ethernet on these boards does need pinctrl support to mux
the necessary pads. The pinctrl-th1520 driver, pinctrl binding, and
related dts patches are in linux-next. However, they are not yet in
net-next/main.

Therefore, I am dropping the dts patch for v5 as it will not build on
net-next/main due to the lack of the padctrl0_apsys pin controller node
in next-next/main version th1520.dtsi. It does exist in linux-next [1]
and the two patches in this series allow the ethernet ports to work
correctly on the LPi4A and Ahead when applied to linux-next.

The dwmac-thead driver in this series does not need the pinctrl-th1520
driver to build. Nor does the thead,th1520-gmac.yaml binding need the
pinctrl binding to pass the schema check.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/riscv/boot/dts/thead/th1520.dtsi

Changes in v5:
 - Rebase on net-next/main
 - Drop the dts patch from this series. It applies to linux-next but
   not net-next/main.
 - Remove repeated properties from required: in binding
 - Add Rb from Krzysztof for binding
 - Link to v4: https://lore.kernel.org/r/20241020-th1520-dwmac-v4-0-c77acd33ccef@tenstorrent.com

Changes in v4:
 - Rebase on next for pinctrl dependency
 - Add 'net-next' prefix to subject per maintainer-netdev.rst
 - Add clocks, clock-names, interrupts and interrupt-names to binding
 - Simplify driver code by switching from regmap to regualar mmio

Changes in v3:
 - Rebase on v6.12-rc1
 - Remove thead,rx-internal-delay and thead,tx-internal-delay properties
 - Remove unneeded call to thead_dwmac_fix_speed() during probe
 - Fix filename for the yaml file in MAINTAINERS patch
 - Link: https://lore.kernel.org/linux-riscv/20240930-th1520-dwmac-v3-0-ae3e03c225ab@tenstorrent.com/

Changes in v2:
 - Drop the first patch as it is no longer needed due to upstream commit
   d01e0e98de31 ("dt-bindings: net: dwmac: Validate PBL for all IP-cores")
 - Rename compatible from "thead,th1520-dwmac" to "thead,th1520-gmac"
 - Add thead,rx-internal-delay and thead,tx-internal-delay properties
   and check that it does not exceed the maximum value
 - Convert from stmmac_dvr_probe() to devm_stmmac_pltfr_probe() and
   delete the .remove_new hook as it is no longer needed
 - Handle return value of regmap_write() in case it fails
 - Add phy reset delay properties to the BeagleV Ahead device tree
 - Link: https://lore.kernel.org/linux-riscv/20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com/

Changes in v1:
 - remove thead,gmacapb that references syscon for APB registers
 - add a second memory region to gmac nodes for the APB registers
 - Link: https://lore.kernel.org/all/20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com/

---
Jisheng Zhang (2):
      dt-bindings: net: Add T-HEAD dwmac support
      net: stmmac: Add glue layer for T-HEAD TH1520 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
 .../devicetree/bindings/net/thead,th1520-gmac.yaml | 110 +++++++++
 MAINTAINERS                                        |   2 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |  10 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 268 +++++++++++++++++++++
 6 files changed, 392 insertions(+)
---
base-commit: 03fc07a24735e0be8646563913abf5f5cb71ad19
change-id: 20241025-th1520-gmac-78a76aa90c62

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>


