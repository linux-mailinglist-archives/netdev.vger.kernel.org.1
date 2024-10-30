Return-Path: <netdev+bounces-140503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56719B6A33
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736C72817A6
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEBA219497;
	Wed, 30 Oct 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="OW3nqos0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC968217453
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307481; cv=none; b=iCRhiFm6qSZ6DR/6r/wvhsx6YEze0U+FHqKajkVIcjXkiF2wZULmHTqPK3dtO2O13+KjzlmbV2nj+E5Gp54qXTKtrrcWC+bQxs1TBSQd60wKHRGysihEaFDefu1WgHL8Y3k4o4ARnN/k3jRVid8LbhqVRdlA4rKT/LLXctrnSGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307481; c=relaxed/simple;
	bh=8rKk7389YGBIL6EbzRDNuzKgulzkwL/2NSFmtXt+pfw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j17Px9UrfY2VV2VNKpYWhAaTzNCVJLhlixnN7p9zTBqNzxEKpdnAxV+UtIuynUtInj054v0xcTC8PJJbPEmFsKUPR088fK6FS0ZY54DhnL/okpCzQjNEGs9cYfP6E//xWlbu4Ho6eZQjOZ7Zz1w8iMfXB1Cd2g5LRme31u9GRIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=OW3nqos0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so10603b3a.2
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1730307478; x=1730912278; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3cY75BHXNmweywFmWSeI4nTOgqt0J0ThjFEmmpT3Pw=;
        b=OW3nqos02/CeV7SQ8n1kTbEky30F+IxBr9vhhOEbAHCWU4lsTqLFGRPdQaPHP8Hgpv
         KYMod0CxfhD685hKP2H8dk3J22U1M3KquLYcynigPbtsvVZv3gPUckAbJMnqRVfpekyL
         yNmbXy7+KeOS4G0IVFi3d9vYSjbOsqYC3lPQDetJ2OOnaDER2t/8Hx+DAmsKsWzPKFip
         TVM8LFwLdZt4/wlphtnVCyt+FxPmCyh5en328Ah/2w49KwKilUQzd9wfkgVobTtmq+9L
         vu5gJy6Cpne8Am2VRUAowXOcbSxYla3JcgZajk+PV7mCsG5o/YwlDS7S2dFM6ngm+npX
         KKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730307478; x=1730912278;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3cY75BHXNmweywFmWSeI4nTOgqt0J0ThjFEmmpT3Pw=;
        b=a4nEQfFRM1WNNuAUjegfqwIIRRwjurd2G99B30VC1Yx3foJBj4/zHkGfcN8TCbgiHm
         G8AWAsoZV2YYvYMRf+IxrjiIMNqyy0ILaTjfh9/uF//rdWbRb3OK6mBCMUPYPFNsL1yh
         bWziX1gd7n89GGphn6k9zBKLLewB/uZBAvPYQQTyTOu/k68QY+/1Bv9mFsUXSdn8+JfI
         gSwiorHXlHHnPnR3WnmXDFHDF6sJixbXmKidnyo+7Sls4cb1pwHxDUom9SzcPCsuuC1/
         5canll8Hx1eW1mEb0oK2k+YtIs5rkB+5UlH19q20nwbVMCATxqPNqzoSadMEfqXuUl2B
         pCFQ==
X-Gm-Message-State: AOJu0Ywzt4xww71UwEmiVBH/ZpjB9V2/ffdjmVzJmEgzTRXpsxVG0mh2
	rAOzATOvkIoq0Ja81UdYxTFbgLYvGFw9r5Vkor7dsJsGJWOPAiP+8r0YdYEMxWg=
X-Google-Smtp-Source: AGHT+IFPHksQZP6e8UWi8zk4bshtiITtL2PSHAiSSYJzIXWW2rk419GyCPz8eiYwnahJu8NaW3tnRg==
X-Received: by 2002:a05:6a20:d98:b0:1cf:44bb:1cc4 with SMTP id adf61e73a8af0-1d9a851d257mr21593375637.40.1730307477921;
        Wed, 30 Oct 2024 09:57:57 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1f1ddsm9810776b3a.149.2024.10.30.09.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:57:57 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Subject: [PATCH net-next v6 0/2] Add the dwmac driver support for T-HEAD
 TH1520 SoC
Date: Wed, 30 Oct 2024 09:57:43 -0700
Message-Id: <20241030-th1520-gmac-v6-0-e48176d45116@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdlImcC/22NQQ6DIBBFr2Jm3WlGKki76j0aFwRHYSE2QIiN8
 e6lrrt8+Xnv75A4ek7waHaIXHzya6igLg1YZ8LM6MfKIEh0LQmJ2bVSEM6Lsdhr0ytj7mSVgGq
 8I09+O2svCJwx8JZhqIvzKa/xc94Uee5/i0Ui4U2PZDrdkZqmZ+bwUyOHfLXrAsNxHF9fjJYKt
 gAAAA==
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 268 +++++++++++++++++++++
 6 files changed, 392 insertions(+)
---
base-commit: 03fc07a24735e0be8646563913abf5f5cb71ad19
change-id: 20241025-th1520-gmac-78a76aa90c62

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>


