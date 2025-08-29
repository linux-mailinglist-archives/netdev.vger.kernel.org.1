Return-Path: <netdev+bounces-218189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E2B3B713
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DBE9828A1
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C183043A1;
	Fri, 29 Aug 2025 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k7jNmAJB"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B1B2E36EC;
	Fri, 29 Aug 2025 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459263; cv=none; b=rjcVx+Op+DZNInKHC2tmHEHhIP+dommUexLO4grt8UNXJT8BejuQKBwDFeCtnjL7m8ebGGWWO9PUPuDKaiY45OaIN2rWyjmPrCyOF0zTOALa3v4k/FggmqlWJc8X9/nK4XXU9TA74VB+kxSa8M/4gjp2O/j3+N3IY6aw2skW1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459263; c=relaxed/simple;
	bh=bbhdKh1r1EnPchJMRAZm27A3o+cqajSQJpAToKjB2gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bc0j+B5ycwsyQsLUShDm9Z3ceMRBgONJx99kJ6Qx4BAgOOrPmn/H8us4tezS7T1Eu57WCrzAIF90/grlf9zBx+04qgwdjU8Ix1AoCbRXYKfr0uWjMXRf/lLx2/uSjjYUiVwiIcQoLsG/6sURq7M1vRWfOq8GSyZodzBAuQoSc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k7jNmAJB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756459253;
	bh=bbhdKh1r1EnPchJMRAZm27A3o+cqajSQJpAToKjB2gw=;
	h=From:To:Cc:Subject:Date:From;
	b=k7jNmAJBn6mV870W0svbNED8c3nmXJZMhGO5ulHEFcClCi7NBvTb+IaZhRTD2acVl
	 y7hAGV/SsEh9+C0cFZP6zNQSm5VlP9kOaBJW0ogyXBiDfRG46vSCxo8g7QyjoaJSdN
	 FlzZE5dhh7U9n0U0zmZnL848rwGoSXly7DIDP60Y3GUnwWNJMA5dzV53gpmxB3ecFk
	 3j63ECfQGJONmbgKhWAYukbFK1liIhij2DQC+6WBRLHvHTMHvdJpm2E2HEtTa2DAV0
	 hUE4lv9FI5YBwGKpaMgHIRLP7Wd6qT4Oh/wD3dxOCFasdNAIjuOOOakXvt8o/Pwey/
	 dkmF/AFL6Z7Xw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:f5b1:db54:a11a:c333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C3BA317E10F3;
	Fri, 29 Aug 2025 11:20:52 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com
Cc: guangjie.song@mediatek.com,
	wenst@chromium.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v5 00/27] Add support for MT8196 clock controllers
Date: Fri, 29 Aug 2025 11:18:46 +0200
Message-Id: <20250829091913.131528-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces support for the clock controllers on the
MediaTek MT8196 platform, following up on an earlier submission[1].

MT8196 uses a hardware voting mechanism to control some of the clock muxes
and gates, along with a fence register responsible for tracking PLL and mux
gate readiness. The series introduces support for these voting and fence
mechanisms, and includes drivers for all clock controllers on the platform.

[1] https://lore.kernel.org/all/20250307032942.10447-1-guangjie.song@mediatek.com/

Changes in v5:
- Used double negation in clk-mux/pll to return strict true/false values
- Dropped fenc_mask from clk-pll.c / clk-pll.h
- Moved MTK_WAIT_FENC_DONE_US definition to clk-mux.c
- Switched to dev_err_probe() / dev_err_ptr_probe() where applicable
- Added blank lines for separation when including binding headers
- Added struct mtk_gate * pointer in struct mtk_clk_gate, removed
  duplication in mtk_clk_register_gate()
- Dropped CLK_OPS_PARENT_ENABLE from gate macros when defining gates
  with different parents
- Used default COMMON_CLK_MT8196 for config COMMON_CLK_MT8196_MDPSYS in
  Kconfig

- Added vlp_clk26m definition in vlpckgen
- Renamed top_divs -> vlp_divs in vlpckgen
- Moved clk-mtk.h inclusion in clk-mux.c to the commit “clk: mediatek:
  clk-mux: Add ops for mux gates with HW voter and FENC”
- Renamed adsppll_ck -> adsppll in topckgen
- Fixed checkpatch warning in clk-mt8196-mdpsys.c (line too long)

- Dropped R-b tags on patches 6 (refactoring), 13 (vlp_clk26m defined,
  reparented audio clocks), 14, 15, 16, 19, 22 (dropped
  CLK_OPS_PARENT_ENABLE, changing the behavior of the
  affected clocks).

Link to v4: https://lore.kernel.org/all/20250805135447.149231-1-laura.nao@collabora.com/

Laura Nao (27):
  clk: mediatek: clk-pll: Add set/clr regs for shared PLL enable control
  clk: mediatek: clk-pll: Add ops for PLLs using set/clr regs and FENC
  clk: mediatek: clk-mux: Add ops for mux gates with set/clr/upd and
    FENC
  clk: mediatek: clk-mtk: Introduce mtk_clk_get_hwv_regmap()
  clk: mediatek: clk-mux: Add ops for mux gates with HW voter and FENC
  clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use
    mtk_gate struct
  clk: mediatek: clk-gate: Add ops for gates with HW voter
  clk: mediatek: clk-mtk: Add MUX_DIV_GATE macro
  dt-bindings: clock: mediatek: Describe MT8196 clock controllers
  clk: mediatek: Add MT8196 apmixedsys clock support
  clk: mediatek: Add MT8196 topckgen clock support
  clk: mediatek: Add MT8196 topckgen2 clock support
  clk: mediatek: Add MT8196 vlpckgen clock support
  clk: mediatek: Add MT8196 peripheral clock support
  clk: mediatek: Add MT8196 ufssys clock support
  clk: mediatek: Add MT8196 pextpsys clock support
  clk: mediatek: Add MT8196 I2C clock support
  clk: mediatek: Add MT8196 mcu clock support
  clk: mediatek: Add MT8196 mdpsys clock support
  clk: mediatek: Add MT8196 mfg clock support
  clk: mediatek: Add MT8196 disp0 clock support
  clk: mediatek: Add MT8196 disp1 clock support
  clk: mediatek: Add MT8196 disp-ao clock support
  clk: mediatek: Add MT8196 ovl0 clock support
  clk: mediatek: Add MT8196 ovl1 clock support
  clk: mediatek: Add MT8196 vdecsys clock support
  clk: mediatek: Add MT8196 vencsys clock support

 .../bindings/clock/mediatek,mt8196-clock.yaml | 112 ++
 .../clock/mediatek,mt8196-sys-clock.yaml      | 107 ++
 drivers/clk/mediatek/Kconfig                  |  71 ++
 drivers/clk/mediatek/Makefile                 |  13 +
 drivers/clk/mediatek/clk-gate.c               | 119 ++-
 drivers/clk/mediatek/clk-gate.h               |   3 +
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c  | 204 ++++
 drivers/clk/mediatek/clk-mt8196-disp0.c       | 170 +++
 drivers/clk/mediatek/clk-mt8196-disp1.c       | 170 +++
 .../clk/mediatek/clk-mt8196-imp_iic_wrap.c    | 118 +++
 drivers/clk/mediatek/clk-mt8196-mcu.c         | 167 +++
 drivers/clk/mediatek/clk-mt8196-mdpsys.c      | 186 ++++
 drivers/clk/mediatek/clk-mt8196-mfg.c         | 150 +++
 drivers/clk/mediatek/clk-mt8196-ovl0.c        | 154 +++
 drivers/clk/mediatek/clk-mt8196-ovl1.c        | 154 +++
 drivers/clk/mediatek/clk-mt8196-peri_ao.c     | 142 +++
 drivers/clk/mediatek/clk-mt8196-pextp.c       | 131 +++
 drivers/clk/mediatek/clk-mt8196-topckgen.c    | 985 ++++++++++++++++++
 drivers/clk/mediatek/clk-mt8196-topckgen2.c   | 568 ++++++++++
 drivers/clk/mediatek/clk-mt8196-ufs_ao.c      | 108 ++
 drivers/clk/mediatek/clk-mt8196-vdec.c        | 253 +++++
 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c    |  80 ++
 drivers/clk/mediatek/clk-mt8196-venc.c        | 236 +++++
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c    | 729 +++++++++++++
 drivers/clk/mediatek/clk-mtk.c                |  16 +
 drivers/clk/mediatek/clk-mtk.h                |  22 +
 drivers/clk/mediatek/clk-mux.c                | 122 ++-
 drivers/clk/mediatek/clk-mux.h                |  87 ++
 drivers/clk/mediatek/clk-pll.c                |  45 +-
 drivers/clk/mediatek/clk-pll.h                |   8 +
 .../dt-bindings/clock/mediatek,mt8196-clock.h | 803 ++++++++++++++
 .../reset/mediatek,mt8196-resets.h            |  26 +
 32 files changed, 6224 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8196-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-disp0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-disp1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-imp_iic_wrap.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mcu.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mdpsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ovl0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ovl1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-peri_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-pextp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-topckgen2.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-ufs_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8196-vlpckgen.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt8196-clock.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt8196-resets.h

-- 
2.39.5


