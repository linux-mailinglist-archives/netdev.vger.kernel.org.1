Return-Path: <netdev+bounces-202108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0F3AEC3D0
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 03:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DFF4A441E
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 01:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272951D8E1A;
	Sat, 28 Jun 2025 01:30:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B2EEA8;
	Sat, 28 Jun 2025 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751074233; cv=none; b=XMLzrxLnwm/HjdA4QIfNZ0azEqMptNHMUyd+TqE+HS2oWTRObqLjR8iUMFiBrsKLFTaaO0TS722hpnCLrxvtr4v8cYMQaKA1IpTDI8cqRW+3rff8TKEngjJuF+lp50I1FTFfYlGD7FpjtmuRddLE46OWCJjFMsGnIIvVeh2DAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751074233; c=relaxed/simple;
	bh=lgJwZIq209fXsXqy2AxJFhYz3tmsplLir33JPAd4o5c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BB/2YhjaqD+GUbBOQpnyp2mRl2zSJyEjwLMdYuDl5enP99dFLA8AGOCfQkqPdReF2zjRipJc1WYb3lW2My/qNl8Zw8IHW6a+5SbVFe6Zyj3ELN1WEmawTRxCurgg5XZMF0p01MFw/vkMLfe9sbI5AIeuT4NnZMtv7UGIWsnncsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uVKOY-000000004QA-0bQ9;
	Sat, 28 Jun 2025 01:30:18 +0000
Date: Sat, 28 Jun 2025 02:30:14 +0100
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
Subject: [PATCH net/next 0/3] net: ethernet: mtk_eth_soc: improve device tree
 handling
Message-ID: <cover.1751072868.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The series further improves the mtk_eth_soc driver in preparation to
complete upstream support for the MT7988 SoC family.

Frank Wunderlich's previous attempt to have the ethernet node included
in mt7988a.dtsi and cover support for MT7988 in the device tree bindings
was criticized for the way mtk_eth_soc references SRAM in device tree[1].

Having a 2nd 'reg' property, like introduced by commit ebb1e4f9cf38
("net: ethernet: mtk_eth_soc: add support for in-SoC SRAM") isn't acceptable
and a dedicated "mmio-sram" node should be used instead.

Support for the hard-coded offset and including the SRAM region as part of
the Ethernet's "reg" MMIO space will still be required in order to support
existing legacy device trees of the MT7981 and MT7986 SoC families.

While at it also replace confusing error messages when using legacy device
trees without "interrupt-names" with a warning informing users that they
are using a legacy device tree.

[1]: https://patchwork.ozlabs.org/comment/3533543/

Daniel Golle (3):
  net: ethernet: mtk_eth_soc: improve support for named interrupts
  net: ethernet: mtk_eth_soc: fix kernel-doc comment
  net: ethernet: mtk_eth_soc: use genpool allocator for SRAM

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 134 +++++++++++++-------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |   5 +-
 2 files changed, 94 insertions(+), 45 deletions(-)

-- 
2.50.0

