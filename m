Return-Path: <netdev+bounces-203112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D754DAF0883
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51859164B37
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21EE1A072C;
	Wed,  2 Jul 2025 02:38:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCEB16E863;
	Wed,  2 Jul 2025 02:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423884; cv=none; b=ZUKrvy+ajQKrK/AakNi5n8qwI9u0tqj2gyD/drLZ7IdX3GOvSudVsEDb4447Q5bIbmXAp6acSJ2aM/alAZKRucXlppRkzK8y0pibwKlwin+AZggpPyB/iqI8/OLhY01pv11maESyOoGoZlF2igEax2hCd3BwYCzLkB3h+DkrN50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423884; c=relaxed/simple;
	bh=pQET3LimeNTjhg0Ps/AYZMyJeXizcXhkG/Op6lf6ZVA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LPUDMadM8qB5qB9hgrCdc2kmCEHLZ7tiDcA/GwWWUbxkotpFOBgpBJCa71uFXHMfxhyNC56XOKkpHki6din/Ar+KSto4tD2La2K6coDvJ0ePrzW1ieK2paNp1Epceec9wl3R+5SD/+QH63Sp/+kpwfSpngqrMTAKSW2b7weK87g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uWnM0-000000005DE-34JB;
	Wed, 02 Jul 2025 02:37:44 +0000
Date: Wed, 2 Jul 2025 03:37:40 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>,
	Frank Wunderlich <frank-w@public-files.de>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Sky Huang <skylake.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v4 0/3] net: ethernet: mtk_eth_soc: improve device
 tree handling
Message-ID: <cover.1751421358.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series further improves the mtk_eth_soc driver in preparation to
complete upstream support for the MediaTek MT7988 SoC family.

Frank Wunderlich's previous attempt to have the ethernet node included
in mt7988a.dtsi and cover support for MT7988 in the device tree bindings
was criticized for the way mtk_eth_soc references SRAM in device tree[1].

Having a 2nd 'reg' property, like introduced by commit ebb1e4f9cf38
("net: ethernet: mtk_eth_soc: add support for in-SoC SRAM") isn't
acceptable and a dedicated "mmio-sram" node should be used instead.

In order to make the code more clean and readable, the existing
hardcoded offsets for the scratch ring, RX and TX rings are dropped in
favor of using the generic allocator. In this way support for the
hard-coded offset and including the SRAM region as part of the
Ethernet's "reg" MMIO space is kept as it will still be required in
order to support existing legacy device trees of the MT7986 SoC family.

While at it also replace confusing error messages when using legacy
device trees without "interrupt-names" with a warning informing users
that they are using a legacy device tree.

[1]: https://patchwork.ozlabs.org/comment/3533543/

Daniel Golle (3):
  net: ethernet: mtk_eth_soc: improve support for named interrupts
  net: ethernet: mtk_eth_soc: fix kernel-doc comment
  net: ethernet: mtk_eth_soc: use generic allocator for SRAM

 drivers/net/ethernet/mediatek/Kconfig       |   1 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 155 +++++++++++---------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  11 +-
 3 files changed, 95 insertions(+), 72 deletions(-)

-- 
2.50.0

