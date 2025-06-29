Return-Path: <netdev+bounces-202305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 907B4AED19B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 00:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732C71892448
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 22:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4C91F1527;
	Sun, 29 Jun 2025 22:21:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721032BAF9;
	Sun, 29 Jun 2025 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751235711; cv=none; b=kfNzF0BT6FKy/W4eP7La1CDx/nc5NiWtB1mpc72sSupKU23hOAMgVqSPC7JdJ2CHlvRloZwDvFf2i1hNRl6LcjxJ5noVayx4JJXIqdpZzE4v4f11txv9U15h0cFAehnj04wT5RiVDYgxSwDI2H6YKQzJaOf6Se3CpGQx6d1CEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751235711; c=relaxed/simple;
	bh=EZRuKPARgIYLB6wIpfxuIXfAZZXKfyPzftYWLR92HpM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a5TMgrpaHw9m+LoXmGHUBbXw/HHxYQLsRahSul8RR2kEPvicw0+VIfGKTT8jCw1iR1oA1s8svO4IsPjfBt1W3TwcTOz+G3LiaT/ufVb0/VZrfWlUPzQuKYDJal24dS5potXIfWLACI1GeiuI69WU0bsaB0M9NJfdO6qguhXmBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uW0Oz-000000002Iz-2I42;
	Sun, 29 Jun 2025 22:21:33 +0000
Date: Sun, 29 Jun 2025 23:21:28 +0100
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
Subject: [PATCH net-next v2 0/3] net: ethernet: mtk_eth_soc: improve device
 tree handling
Message-ID: <cover.1751229149.git.daniel@makrotopia.org>
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

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 135 +++++++++++++-------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |   5 +-
 2 files changed, 95 insertions(+), 45 deletions(-)

-- 
2.50.0

