Return-Path: <netdev+bounces-202746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D03AEED0E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 05:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A83F7A3F2A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6693D1DED47;
	Tue,  1 Jul 2025 03:43:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633A1862A;
	Tue,  1 Jul 2025 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751341401; cv=none; b=jNf+P46mnkm3SKfKr5p51ssggVLZlTiAJf/8bmSmxNqg7xLSQgQ3+tL4biPiVVmpL4b1N07DqUAmXgxJkxs6Q+GejjdHeWwG52Dm6VWUm0cVuli0dm6fITtDTogtON3q1tM3DRsKRLwi5ioR+1emJwH8IEIY2nQAHjMXAyztJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751341401; c=relaxed/simple;
	bh=iVNh8aIhXLNmcR6kEfw10ctuzfsid98qCR5uOaZr0nM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hu4pStvyoefTt4UO4Xsnzv5RZlJnDf9AuSwARYkivhA7a3DeRFxeguGuBXT2iJv9TJsI1CwPpKh3tSvHslcCRT/Z3MMCHmPIOvDH3x0e6BedpOZufWV6vwxIVHluKRHqIB03yEEIQ1xxS/UO7+GMkh+/rHgo9hbdPxonafOdttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uWRtf-000000008Tg-49Ij;
	Tue, 01 Jul 2025 03:43:04 +0000
Date: Tue, 1 Jul 2025 04:42:55 +0100
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
Subject: Re: [PATCH net-next v3 3/3] net: ethernet: mtk_eth_soc: use genpool
 allocator for SRAM
Message-ID: <aGNZP5JFXzFcBVla@makrotopia.org>
References: <cover.1751319620.git.daniel@makrotopia.org>
 <ec99dca250c0805a2307b0aaa9cf30b29ee2a989.1751319620.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec99dca250c0805a2307b0aaa9cf30b29ee2a989.1751319620.git.daniel@makrotopia.org>

On Mon, Jun 30, 2025 at 10:47:02PM +0100, Daniel Golle wrote:
> Use a dedicated "mmio-sram" and the genpool allocator instead of
> open-coding SRAM allocation for DMA rings.
> Keep support for legacy device trees but notify the user via a
> warning to update.
> 
> Co-developed-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: fix resource leak on error in mtk_probe()
> v2: fix return type of mtk_dma_ring_alloc() in case of error
> 
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 117 +++++++++++++-------
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h |   4 +-
>  2 files changed, 83 insertions(+), 38 deletions(-)
> 

I just noticed I forgot to 'git add' the Kconfig change adding 'select
GENERIC_ALLOCATOR' for NET_MEDIATEK_SOC... I will include that in v4 and
also add a patch dropping the open coded static partitioning of the SRAM
in favor of always using the gen_pool allocator even with legacy device
trees.

Meanwhile I would still be thankful to see this patch reviewed as apart
from the Kconfig addition it won't change.

