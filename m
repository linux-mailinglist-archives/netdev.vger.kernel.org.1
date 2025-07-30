Return-Path: <netdev+bounces-210949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDF3B15E96
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 12:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105777B0355
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 10:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75B1294A1C;
	Wed, 30 Jul 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lW8Gg+Ge"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE418C928;
	Wed, 30 Jul 2025 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873097; cv=none; b=mjH7gco/x4EEWU0kVLsfQWOI+Wuqbe+VOiYOCHEL20YTaYU1f59S8GgQFCJQyd/TT2D7F0lE7AbiNs39ViGxGgxT+Eaf4MtHz7MZ04hOSgHhAISUC+sx/Wk5pZNEvow7/nO+5qVP/h+QRWyvNW8+cw0NpSmcXIwxlcy9EioGIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873097; c=relaxed/simple;
	bh=lYv7QHbDNZ0Rc0wYrcyojYSl0/lSp3gFzLiTa6zBXlY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pa636sJ4DtvUjp0j+Ar5F/vZTFLDpxICv1Uncd3Yr9B7Mr2qgnd+ZpmpY0eJNa/W9M1/KFwO9Ng5XvLrm2G/uSPSOY6ohoI7IwYZ7Um3rle1TCkpOiLA/dtVVC3Clqd6/NjNWPuU3YuLtrgb6TeN2wdSC8orzftHBfG4N1nX+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lW8Gg+Ge; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753873086;
	bh=lYv7QHbDNZ0Rc0wYrcyojYSl0/lSp3gFzLiTa6zBXlY=;
	h=From:To:Cc:Subject:Date:From;
	b=lW8Gg+GeZCJ9O8G3LKJcykUKKJbkTpmyGUycdZchqGWe0jTwwl7ejAwNzKgyYjoNw
	 qAK7vYEdH3ZiQ7c15eCC9Cl/rDm+2Rg/L01XqJcTxECJeZd5aED5Tiu49JHZZaImnL
	 OYqHmUXwldaDKg1waTILTaUglqVEVp/g4qS5hni9bPdJFbKfP8Ar6b/h25jY44pKxy
	 qECYxEzCUkRA0bMNv7oN4J/VNcdUtRZyF1i6ogUDy8ukK1UB8lav1o998PzWpIV/a0
	 4ehYdZMGogmBOBC+O721hqkhGvOPUmJwAFt0nIrx1dofTx3BTzDoCuLavTnfd0uC3v
	 qo3FjjI19katQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4db2:e926:c82d:3276])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EA0B817E130E;
	Wed, 30 Jul 2025 12:58:04 +0200 (CEST)
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
Subject: [PATCH v3 00/27] Add support for MT8196 clock controllers
Date: Wed, 30 Jul 2025 12:56:26 +0200
Message-Id: <20250730105653.64910-1-laura.nao@collabora.com>
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

Changes in v3:
- Removed duplication in clock parent lists in the topckgen, topckgen2, and vlpckgen drivers
- Added vlp_clk26m parent and index table for audio clocks in the vlpckgen driver
- Added APLL tuner initialization to the probe function of the vlpckgen driver
- Dropped the adsp driver
- Merged reset controller binding into the clock binding doc commit
- Dropped .owner entry from mfg driver
- Added R-b tags

Link to v2: https://lore.kernel.org/all/20250624143220.244549-1-laura.nao@collabora.com

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

 .../bindings/clock/mediatek,mt8196-clock.yaml |  86 ++
 .../clock/mediatek,mt8196-sys-clock.yaml      |  81 ++
 drivers/clk/mediatek/Kconfig                  |  71 ++
 drivers/clk/mediatek/Makefile                 |  13 +
 drivers/clk/mediatek/clk-gate.c               | 106 +-
 drivers/clk/mediatek/clk-gate.h               |   3 +
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c  | 203 ++++
 drivers/clk/mediatek/clk-mt8196-disp0.c       | 169 +++
 drivers/clk/mediatek/clk-mt8196-disp1.c       | 170 +++
 .../clk/mediatek/clk-mt8196-imp_iic_wrap.c    | 117 +++
 drivers/clk/mediatek/clk-mt8196-mcu.c         | 166 +++
 drivers/clk/mediatek/clk-mt8196-mdpsys.c      | 187 ++++
 drivers/clk/mediatek/clk-mt8196-mfg.c         | 149 +++
 drivers/clk/mediatek/clk-mt8196-ovl0.c        | 154 +++
 drivers/clk/mediatek/clk-mt8196-ovl1.c        | 153 +++
 drivers/clk/mediatek/clk-mt8196-peri_ao.c     | 144 +++
 drivers/clk/mediatek/clk-mt8196-pextp.c       | 131 +++
 drivers/clk/mediatek/clk-mt8196-topckgen.c    | 984 ++++++++++++++++++
 drivers/clk/mediatek/clk-mt8196-topckgen2.c   | 567 ++++++++++
 drivers/clk/mediatek/clk-mt8196-ufs_ao.c      | 109 ++
 drivers/clk/mediatek/clk-mt8196-vdec.c        | 253 +++++
 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c    |  79 ++
 drivers/clk/mediatek/clk-mt8196-venc.c        | 235 +++++
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c    | 726 +++++++++++++
 drivers/clk/mediatek/clk-mtk.c                |  16 +
 drivers/clk/mediatek/clk-mtk.h                |  23 +
 drivers/clk/mediatek/clk-mux.c                | 119 ++-
 drivers/clk/mediatek/clk-mux.h                |  87 ++
 drivers/clk/mediatek/clk-pll.c                |  46 +-
 drivers/clk/mediatek/clk-pll.h                |   9 +
 .../dt-bindings/clock/mediatek,mt8196-clock.h | 802 ++++++++++++++
 .../reset/mediatek,mt8196-resets.h            |  26 +
 32 files changed, 6160 insertions(+), 24 deletions(-)
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


