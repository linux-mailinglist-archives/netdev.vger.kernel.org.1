Return-Path: <netdev+bounces-200211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B78AE3C64
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B840B18962DF
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3B923BF9F;
	Mon, 23 Jun 2025 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QKuq8sfM"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3923BD1F;
	Mon, 23 Jun 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674630; cv=none; b=WX8jf5iLGaBJ8s09Pi0A1zLydjSYdLfE/MCGLMU4ftaHxN5oWTkj5Y69HXBvtlj7EK3RsPqGq+AMNsc7DgJOcFU8XTzbjWu+rbiEjbPuNLtu5zZzHNCJjiG20IH9Q9srwdb826aunJ8vvLIKWukGDusu18qj3gHBFI8VUsy+h+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674630; c=relaxed/simple;
	bh=WcdYiRrSUeJaJ1vmQuBR2TYhYYx6iD5jWduuKdPBCyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g3TK0rY6GpFZ8R59d/rTgBuq7iJhAAZqAc1y/dUhR/nvge0ItPrMTzGrUM44S4O1M2DguMZi7asHGODMjXeWeBbcI3BWj+vm2y/Ave6Yg+KfEdBQAVC8FiA/bumNIm4B7ngNWk4zvj4SM/PhASVteLpptCH42p0lOVKPJwA/K2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QKuq8sfM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750674626;
	bh=WcdYiRrSUeJaJ1vmQuBR2TYhYYx6iD5jWduuKdPBCyg=;
	h=From:To:Cc:Subject:Date:From;
	b=QKuq8sfM66+nYpdFgYI0t/5eDoDgvDJGADbGpPuIkBer1LFQ8i971+EoV6WnQqFCj
	 Dfo/OPkY+KNskyIK6hEpsosVMOhExcqHQ0hlaXnjR3cYxh+qr+i9iPjW1prVJ8RMDy
	 X4FDEUvDLD2PGcBEvw6EJ0K6/q6ZqO7k+6fK/dMgegPRjw9vtWdD9YKEKUw36wTtPx
	 VBM18+qepKGI2Tq3q+wNq+/orCx78uFtg/4zKWkNpi5n/ybDWRz2NPj+WqoVEcGiQ3
	 Qeygw5E/tKvfbyG3KDiVrKsicmUoKyI4d4N0Iplbg/4j/gw12YefxMQIE/8qtqspTf
	 4IHzyn82eAftA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:e046:b666:1d47:e832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0512017E0D64;
	Mon, 23 Jun 2025 12:30:24 +0200 (CEST)
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
Subject: [PATCH 00/30] Add support for MT8196 clock controllers
Date: Mon, 23 Jun 2025 12:29:10 +0200
Message-Id: <20250623102940.214269-1-laura.nao@collabora.com>
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

AngeloGioacchino Del Regno (2):
  dt-bindings: reset: Add MediaTek MT8196 Reset Controller binding
  clk: mediatek: mt8196: Add UFS and PEXTP0/1 reset controllers

Laura Nao (28):
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
  dt-bindings: clock: mediatek: Describe MT8196 peripheral clock
    controllers
  clk: mediatek: Add MT8196 apmixedsys clock support
  clk: mediatek: Add MT8196 topckgen clock support
  clk: mediatek: Add MT8196 topckgen2 clock support
  clk: mediatek: Add MT8196 vlpckgen clock support
  clk: mediatek: Add MT8196 peripheral clock support
  clk: mediatek: Add MT8196 ufssys clock support
  clk: mediatek: Add MT8196 pextpsys clock support
  clk: mediatek: Add MT8196 adsp clock support
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

 .../bindings/clock/mediatek,mt8196-clock.yaml |   79 ++
 .../clock/mediatek,mt8196-sys-clock.yaml      |   76 +
 drivers/clk/mediatek/Kconfig                  |   78 +
 drivers/clk/mediatek/Makefile                 |   14 +
 drivers/clk/mediatek/clk-gate.c               |  106 +-
 drivers/clk/mediatek/clk-gate.h               |    3 +
 drivers/clk/mediatek/clk-mt8196-adsp.c        |  193 +++
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c  |  203 +++
 drivers/clk/mediatek/clk-mt8196-disp0.c       |  169 +++
 drivers/clk/mediatek/clk-mt8196-disp1.c       |  170 +++
 .../clk/mediatek/clk-mt8196-imp_iic_wrap.c    |  117 ++
 drivers/clk/mediatek/clk-mt8196-mcu.c         |  166 +++
 drivers/clk/mediatek/clk-mt8196-mdpsys.c      |  187 +++
 drivers/clk/mediatek/clk-mt8196-mfg.c         |  150 ++
 drivers/clk/mediatek/clk-mt8196-ovl0.c        |  154 ++
 drivers/clk/mediatek/clk-mt8196-ovl1.c        |  153 ++
 drivers/clk/mediatek/clk-mt8196-peri_ao.c     |  144 ++
 drivers/clk/mediatek/clk-mt8196-pextp.c       |  131 ++
 drivers/clk/mediatek/clk-mt8196-topckgen.c    | 1257 +++++++++++++++++
 drivers/clk/mediatek/clk-mt8196-topckgen2.c   |  662 +++++++++
 drivers/clk/mediatek/clk-mt8196-ufs_ao.c      |  109 ++
 drivers/clk/mediatek/clk-mt8196-vdec.c        |  253 ++++
 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c    |   78 +
 drivers/clk/mediatek/clk-mt8196-venc.c        |  235 +++
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c    |  769 ++++++++++
 drivers/clk/mediatek/clk-mtk.c                |   16 +
 drivers/clk/mediatek/clk-mtk.h                |   23 +
 drivers/clk/mediatek/clk-mux.c                |  119 +-
 drivers/clk/mediatek/clk-mux.h                |   76 +
 drivers/clk/mediatek/clk-pll.c                |   46 +-
 drivers/clk/mediatek/clk-pll.h                |    9 +
 .../dt-bindings/clock/mediatek,mt8196-clock.h |  867 ++++++++++++
 .../reset/mediatek,mt8196-resets.h            |   26 +
 33 files changed, 6814 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8196-adsp.c
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


