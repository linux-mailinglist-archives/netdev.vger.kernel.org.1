Return-Path: <netdev+bounces-130006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638639878FF
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 20:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC11283BC2
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 18:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E85715D5B8;
	Thu, 26 Sep 2024 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="XwhhjM97"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72EE1509BF
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374579; cv=none; b=iBYBP5bODhPs38UiEokBym6QCKPHHaODz1CZoqpPFKzrEsHDDrJ+Khs/SHUXExlHgawq39kivGZoIKNNQfRTKsy5R6lulgrEGGkHxS2foi0heLIBNMDemG1ol5CdkzEg4y0Lu/JyuU3FbHYBLCNkMQ1qcxeJJn8bBCWlMkLADv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374579; c=relaxed/simple;
	bh=uG/kkM+HuDydja+Ds1fmJEnCaZJL2H2loYRXeERcgT0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hk/XvkpYxaknJ8y1p6/1uANoDCiJbneZX+KTcIab7ckgiZyjc7zKIodWAIQNWDmdVrjlLYsNcTg6SyHmyqlLiCvE7K4Y/Nd8ivuwbFpaH3hMUjFV3NXo68DuSayf1oIv8T2oOLKnyu6wG5oUfxqZk7Lc0S7V+k+dyCatKfEZ4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=XwhhjM97; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-207115e3056so10925245ad.2
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1727374577; x=1727979377; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BafvbNIW0TpRsFlOtdIQQkficdW6Q756VnEt7t1F6Gs=;
        b=XwhhjM97em50GOyzdt8f2KgJf9VnAQczdtRPpFCtkidl97/F/a0cvgXnWVTkCoqAXG
         T2n1EwxzB/92Uvoprf/76KnYUu8zimAlhZ75ix9Ok3S8zn7Pum6EibPziu3rbHFkvoAK
         +F9fFlyTTAV2CK3kz/ypZ/wo+scx3Lx9iwZUiCawC6cDI1dHwhQ0vZkwOdaKcYM58uHj
         yY6iF3ClvzhashPkLnI2a+ykfswzez1ayVB5O8LR+6tsTnZnVodcrQQihc+gCSlT/8gQ
         SQk7ubgmaPNjPtm4rFxuOdiVJXT984fdOk9f+bxp+nMNclsRv1zWP5wMIqPJwlnM3btu
         mNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727374577; x=1727979377;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BafvbNIW0TpRsFlOtdIQQkficdW6Q756VnEt7t1F6Gs=;
        b=wS9FdKAhv+U4clckmoJ81sbbckS8nKcTrj0d+34KKEcb+SQF5wvTtpJyXXN+sC4PUG
         GDUp57vugijaVr5duWJ/FWhljonK1pTNbbaUUrmnWfj29mQPv3oykCz8qLDAuOz0s0Rg
         vDlgZJtttEWF/6FTMHr4KI0mx7kOb9Qzfxis0dM05LqKDYn6fygohcxYnekiHM+MV9Sl
         LICVmDusMrSa6WgJNgemXsoWKcMs0FQT714VtHaFWHEm9nV+b5QJkNn/5zTftearGpK9
         GO4F7OxERDUKTBvsPspe8Z8GIJVOjxPfv2g61CvNbkhyZ+Z50Qx9FZhYBe2O1peKQIoh
         9XDQ==
X-Gm-Message-State: AOJu0YyLzUmScivfSG487fchg1jPaoL1SmOLcTkjtXdqbfwKOix/PSSM
	AU6T10fPRwk9MSKaJbSI/qlyLuTElTIEeJdMoOq5dOoA1+p1fIPWK/qlFWpnpcM=
X-Google-Smtp-Source: AGHT+IEyzkN+DIrx1wACmvKc5dT19k6znIBitdGcdcuefU2qZ7VOn0P7BZP4KJHexxJOOBaRiDJ4Qw==
X-Received: by 2002:a17:903:1c9:b0:1fd:5eab:8c76 with SMTP id d9443c01a7336-20b37b74f55mr7481515ad.41.1727374577120;
        Thu, 26 Sep 2024 11:16:17 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d5ef5dsm1454145ad.32.2024.09.26.11.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:16:16 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Subject: [PATCH v2 0/3] Add the dwmac driver support for T-HEAD TH1520 SoC
Date: Thu, 26 Sep 2024 11:15:49 -0700
Message-Id: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANWk9WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDSyNj3ZIMQ1MjA92U8tzEZF1T00RjI4PEVAPDRDMloJaCotS0zAqwcdG
 xtbUAQM7eAl4AAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Drew Fustini <dfustini@tenstorrent.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
X-Mailer: b4 0.14.1

This patch series is based on linux-next which contains the TH1520 clk
dts patches in my v6.12 pull request:

 https://lore.kernel.org/linux-riscv/ZsWs8QiVruMXjzPc@x1/

This patch also depends on this TH1520 pinctrl series:

 https://lore.kernel.org/linux-riscv/20240914-th1520-pinctrl-v2-0-3ba67dde882c@tenstorrent.com/

I have a branch with this series and the dependencies:

 https://github.com/pdp7/linux/tree/b4/th1520-dwmac

Regarding clocks, the gmac nodes in th1520.dtsi have the "stmmac_clk"
clock set to CLK_GMAC_AXI in the AP_SUBSYS clock controller. This
corresponds to the enable bit for the GMAC axi4_clk gate which is
handled by the clk-th1520-ap driver. thead_dwmac_fix_speed() does not
modify anything in the AP_SUBSYS clock controller. It only writes to
GMAC APB registers. It seems unnecessary to create a new clock driver
just for the GMAC APB registers. Refer to section 1.6.2 in the TH1520
Peripheral Interface User Manual [1].

Regarding rx and tx internal delays, that same section in the manual
doesn't specify what unit is represented by the delay_ctrl bit field in
GMAC_RXCLK_DELAY_CTRL and GMAC_TXCLK_DELAY_CTRL. It is only 5 bits and
a max value of 31 seems too small to represent picoseconds. The vendor
kernel [2] uses properties named "rx-clk-delay" and "tx-clk-delay" but
doesn't indicate any units. I see ti,dp83867.yaml adds vendor specific
rx and tx delay properties so that is what I've now done in this series.
Note: the hardware default value of 0 for delay_ctrl works okay for the
TH1520 hardware that I have.

There was a question in my v1 series about if the phy required a delay
after reset in the BeagleV Ahead device tree. The board has the Realtek
RTL8211F-CG phy [3]. According to this datasheet I found [4], the reset
pin must be asserted low for at least 10ms for the internal regulator.
Software must wait least 50ms before accessing the phy registers. I've
now added reset-delay-us and reset-post-delay-us with those values.

[1] https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs
[2] https://github.com/revyos/thead-kernel/blob/lpi4a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
[3] https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/blob/main/BeagleV-Ahead_SCH.pdf
[4] https://www.lcsc.com/datasheet/lcsc_datasheet_1912111437_Realtek-Semicon-RTL8211F-CG_C187932.pdf

Changes since v1:
 - Drop the first patch as it is no longer needed due to upstream commit
   d01e0e98de31 ("dt-bindings: net: dwmac: Validate PBL for all IP-cores")
 - Rename compatible from "thead,th1520-dwmac" to "thead,th1520-gmac"
 - Add thead,rx-internal-delay and thead,tx-internal-delay properties
   and check that it does not exceed the maximum value
 - Convert from stmmac_dvr_probe() to devm_stmmac_pltfr_probe() and
   delete the .remove_new hook as it is no longer needed
 - Handle return value of regmap_write() in case it fails
 - Add phy reset delay properties to the BeagleV Ahead device tree
 - Link: https://lore.kernel.org/all/20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com/

Changes since Jisheng v2:
 - remove thead,gmacapb that references syscon for APB registers
 - add a second memory region to gmac nodes for the APB registers
 - Link: https://lore.kernel.org/all/20230827091710.1483-1-jszhang@kernel.org/

Changes since Jisheng v1:
 - rebase on the lastest net-next
 - collect Reviewed-by tag
 - address Krzysztof's comment of the dt binding
 - fix "div is not initialised" issue pointed out by Simon
 - Link: https://lore.kernel.org/all/20230820120213.2054-1-jszhang@kernel.org/

---
Emil Renner Berthing (1):
      riscv: dts: thead: Add TH1520 ethernet nodes

Jisheng Zhang (2):
      dt-bindings: net: Add T-HEAD dwmac support
      net: stmmac: Add glue layer for T-HEAD TH1520 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
 .../devicetree/bindings/net/thead,th1520-gmac.yaml | 109 +++++++
 MAINTAINERS                                        |   2 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  91 ++++++
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    | 135 +++++++++
 arch/riscv/boot/dts/thead/th1520.dtsi              |  50 ++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 319 +++++++++++++++++++++
 9 files changed, 719 insertions(+)
---
base-commit: eb9913a02c55913317dcb4797026f958ce2c97d5
change-id: 20240923-th1520-dwmac-55a320ae01a6

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>


