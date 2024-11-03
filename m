Return-Path: <netdev+bounces-141308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E37D89BA6BD
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 17:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745B1281B2B
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019D0189B81;
	Sun,  3 Nov 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Y7QFbkuh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F8A18784C
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730653089; cv=none; b=bbgpzquOWgIW9oq5IXpDxNaI/xNSdQMELMzOt2H0qzJxUi2uA5mZowTa53aIalE76eELkPMNuywoNrb3peu12qbvXYEwHLbN0+jDcStW59rua991QLkuwmbB2w+7B4Esw/y1zZXOwxJyuQ7eMNV56DzuGDnokcn2FEWz0xFEvjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730653089; c=relaxed/simple;
	bh=g4AfevjCkuFSvZMByzppVssD6Y1C/FGEqgJmCN//YAc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QLDEa1+Q7WLfQcIKmeCrsimMN2whCu7zbfa1O9f3rs7Jywt49jVfjt1/diDEkZa2TiVpniyaSBknCZTQ6i8Bb3tg4/3rxpvtBPGU/G9+UsAm/57RgXpXsRGT+IEP0bmbkvuN3IXxN+ZWHbUEEGZqoDch8oO4t1S+NS8WQpfUKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Y7QFbkuh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdb889222so32908975ad.3
        for <netdev@vger.kernel.org>; Sun, 03 Nov 2024 08:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1730653087; x=1731257887; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SiRHBTzAaAAcdz9wR1AEo/4hHR8Jww4cDbAZ/MX74uo=;
        b=Y7QFbkuhTHGd8FgY2+WAIb4hMs8ZjsUlA3/mpqSrD+N+eoIWd+cRUwa55HyWBLe5BQ
         ixQECMltaGEXjQ7zfPC5i/60bFfFDl0hPG/I1CFr05NfyUxC684rTuDI7ecJaCfGmlzA
         8FtKzg8O8I6dIqnKI7elQZ6MdGFiT2Bjz1DdlK2sYB0hYKi824O+XGr2NzMHAyEd1++e
         qW2Jj2wHPNhAiwOug3q2DGzjw4/0x3f5e8qqzuQCLJLaL06h0CcIfxzy5pMmw48zErIK
         UTCBfFsNl9uTwwNwsdIlUjywEXqk7AnTQKVonyVdXrh2CLp8vj6nZuUfg+BWuEiakGF8
         4BGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730653087; x=1731257887;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiRHBTzAaAAcdz9wR1AEo/4hHR8Jww4cDbAZ/MX74uo=;
        b=TI73c60HX70PPDxpPAMXiW1M0jW1BTpI6lgNX8NAUlnipFx/zzuz8ufS7zFjDkBJsM
         3KwNS1d168e2dSRoSBcukdaM6uPTNcE8UhTgtkEedxPHnYjNgrFuB6Twuyje36p5dwj5
         XfgwnU0g8p6NKNulVpDx8MmETvlQq6OWHSDW2hbAEEsaS2JHRwKANi1Fi+teYiQxgYEq
         C/yliAqKKpWVLADFfusUMi7iD6pc0x2DZfV7ADaDWmOu/qeFPkJtQjLpgVnrjkUunVta
         WScMG2/dmReEVQuLiprWtuhmRl4mKllSAVIfRAJ914HkljVyluTq6yOzxkHBOUiXd9Qc
         V9uQ==
X-Gm-Message-State: AOJu0YzSBTy9wTLBLHWymQwkqEdffaYlBqZR2JcTiwSqkU0nTwdhXTCH
	GnCvrPjtlS18a9lGOxefs9Pv93qmGmAu6NWyI18vaBolG2ssNRrDAxLlb+MJ4DI=
X-Google-Smtp-Source: AGHT+IHZ3SR688u4NeecI0FgN5pXp5mQEMhPTdsDVQGdNI3vsPP0cL6muQcMZTinATTJ8tXbeT7e2A==
X-Received: by 2002:a17:902:c40c:b0:20c:7d4c:64db with SMTP id d9443c01a7336-21103c7bfafmr179492615ad.49.1730653087220;
        Sun, 03 Nov 2024 08:58:07 -0800 (PST)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c9783sm47531355ad.236.2024.11.03.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 08:58:06 -0800 (PST)
From: Drew Fustini <dfustini@tenstorrent.com>
Subject: [PATCH net-next v7 0/2] Add the dwmac driver support for T-HEAD
 TH1520 SoC
Date: Sun, 03 Nov 2024 08:57:58 -0800
Message-Id: <20241103-th1520-gmac-v7-0-ef094a30169c@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJerJ2cC/23NTQ7CIBQE4KuYtxYDlD9deQ/jgtDXlkWpAUJqm
 t5dZKXR5WQy32yQMHpMcDlsELH45JdQgz4ewE02jEh8XzNwygWjXJI8MckpGWfriDZWK2vP1Ck
 OdfGIOPi1aTcImEnANcO9NpNPeYnPdlNk6/+KRRJKOtNTK4ygahiuGcN7GjHkk1vmphX1IXT0W
 1BVQGGYVr2QjKlfYd/3F0fDCcj4AAAA
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

Changes in v7:
 - Remove GMAC_RXCLK_DELAY_VAL(x), GMAC_RXCLK_DELAY_VAL(x) and
   GMAC_PLLCLK_DIV_NUM(x) marcos
 - Fix register write in thead_dwmac_fix_speed() by using FIELD_PREP()
   directly instead of the above macros
 - Fix thead_dwmac_init() to preserve bypass and invert bits when writing
   to GMAC_RXCLK_DELAY_CTRL and GMAC_TXCLK_DELAY_CTRL
 - Add sentinel to end of thead_dwmac_match[]
 - Normalize capitalization in dev_err_probe message
 - Link to v6: https://lore.kernel.org/r/20241030-th1520-gmac-v6-0-e48176d45116@tenstorrent.com

Changes in v6:
 - Remove unnecessary semicolon from end of switch() blocks
 - Add Rb from Andrew Lunn on both patches
 - Link to v5: https://lore.kernel.org/r/20241025-th1520-gmac-v5-0-38d0a48406ff@tenstorrent.com

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
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 273 +++++++++++++++++++++
 6 files changed, 397 insertions(+)
---
base-commit: 03fc07a24735e0be8646563913abf5f5cb71ad19
change-id: 20241025-th1520-gmac-78a76aa90c62

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>


