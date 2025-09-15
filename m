Return-Path: <netdev+bounces-223122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C80F2B58046
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867A1480EEA
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E6231D722;
	Mon, 15 Sep 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZnQtBxEc"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A115D1;
	Mon, 15 Sep 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949688; cv=none; b=aJMcsW1f9Kiip5ddc4IM4q0v2MgOpNnjtUmu7eQvYDzVA+UINWeHgydgozi32J/U/PQ7Ygh79JIB9uDHK9T22iCH7DCnxW2PhH0J/XfYDpMhcyWzwzE5kICLG1Z3LNvXZ20/CEswi9bq66ODa/y5/fmw4MK9fYyfgEaD5Wc43B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949688; c=relaxed/simple;
	bh=gtM2QscaPzR4xfedL0O2h+0MwhbJv7L7+rVQtjSfix4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qpZM2aoVMHP5VGcullnF8XkRxKarJhOXvayUTPr+qqPBArMB2+QYHr14a1RPvPYeaVROvbadDFCnXC45bSApe7VVNXN1qMHIOJtmzj8I83YlkWWVAYK8KMBeBO4NSoTBSJGx4H65JOhCOaiemrqYAm2OWaKNOWrkgxbYv34ThY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZnQtBxEc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757949684;
	bh=gtM2QscaPzR4xfedL0O2h+0MwhbJv7L7+rVQtjSfix4=;
	h=From:To:Cc:Subject:Date:From;
	b=ZnQtBxEcdpoSZJludpjeppay19kRf+JxYUd/FXeWXaExetQRhHPXEq8GeTv+AKE6X
	 Hec/m03fwJJ8Glz4rfz1D1Pq+oOvIUVk3mit6IVjW13UaXAzIJDH+oOwiPmjLv+PAf
	 yZO8cJt+/mESmCPnINE4ij/5RA51wQSdYnGJetGyq5QguES+YEgE90tA9s36v0pQCt
	 2pl0nSpYCEeLBmMNWCpL/LAcs/tNKZCbDVhyrPldmxk1G54Zx1DVtOf12qygQYPKeT
	 WAa1whbf4UakRwCaxjdWKhEndFQTpAR/7/H+fj3YwyapYEs2ahy+dIGjqvTm1OFB9V
	 Vs7cIJZ2UN+rQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:1c8d:f5ba:823d:730b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6C69517E046C;
	Mon, 15 Sep 2025 17:21:22 +0200 (CEST)
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
Subject: [PATCH v6 00/27] Add support for MT8196 clock controllers
Date: Mon, 15 Sep 2025 17:19:20 +0200
Message-Id: <20250915151947.277983-1-laura.nao@collabora.com>
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

Changes in v6:
- Removed unnecessary braces in clk-mux and clk-gate
- Excluded clk26m from the parent lists of vlp_audio_h, vlp_aud_engen1,
  vlp_aud_engen2, and vlp_aud_intbus
- Reordered entries in of_match_clk_mt8196_mdpsys
- Converted mfg_eb clock into a mux with a gate

Link to v5: https://lore.kernel.org/all/20250829091913.131528-1-laura.nao@collabora.com/

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
 drivers/clk/mediatek/clk-gate.c               | 117 ++-
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
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c    | 725 +++++++++++++
 drivers/clk/mediatek/clk-mtk.c                |  16 +
 drivers/clk/mediatek/clk-mtk.h                |  22 +
 drivers/clk/mediatek/clk-mux.c                | 120 ++-
 drivers/clk/mediatek/clk-mux.h                |  87 ++
 drivers/clk/mediatek/clk-pll.c                |  45 +-
 drivers/clk/mediatek/clk-pll.h                |   8 +
 .../dt-bindings/clock/mediatek,mt8196-clock.h | 803 ++++++++++++++
 .../reset/mediatek,mt8196-resets.h            |  26 +
 32 files changed, 6216 insertions(+), 35 deletions(-)
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


