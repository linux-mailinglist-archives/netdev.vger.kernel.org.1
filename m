Return-Path: <netdev+bounces-183818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E25A92217
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401C717BF4F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A92253F31;
	Thu, 17 Apr 2025 15:58:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29CD253B7E;
	Thu, 17 Apr 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905482; cv=none; b=k0gO3Z/zN4uQcH5XXo3UbwgGikgns/2KZEQcrD55TIezuvqySrVHuSHBEYkJclkwWwQQcoIfZLyPHsjAjJ1bf5ldEWZEWvvra4MHSwOar2P/5AZHBe8CZU8+d/ScZJW/bHC1lydhjDNX9hdF4utW6cVA0vCp2wxN4eVTM7SU93I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905482; c=relaxed/simple;
	bh=MgrM6VUX9CxNwUlss2Njm+86WUNpP/hZxAP3jwFwF+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5yBUR4Tmz2rH8OQWIP+kYmzvEVg/Fuq0lWCbnzHLU9Gfa+eX1tChzsiWTuUrievZWHtxXxJEmH7OCKWzW2W/LfqhDNApcPDbP+An9XDkk1L7RJKNp6ERzYFoU495O/AjSlWUM53OHtbULreVJl9AozsIHyklFuP2o9Q3YwtD5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u5Ra5-000000001zt-0Tra;
	Thu, 17 Apr 2025 15:57:51 +0000
Date: Thu, 17 Apr 2025 16:57:48 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 5/5] net: ethernet: mtk_eth_soc: convert cap_bit
 in mtk_eth_muxc struct to u64
Message-ID: <aAEk_J9JCi3lkuGD@makrotopia.org>
References: <8ab7381447e6cdcb317d5b5a6ddd90a1734efcb0.1744764277.git.daniel@makrotopia.org>
 <99177094f957c7ad66116aba0ef877df42590dec.1744764277.git.daniel@makrotopia.org>
 <20250417081325.0e0345ee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417081325.0e0345ee@kernel.org>

On Thu, Apr 17, 2025 at 08:13:25AM -0700, Jakub Kicinski wrote:
> On Wed, 16 Apr 2025 01:52:03 +0100 Daniel Golle wrote:
> > The capabilities bitfield was converted to a 64-bit value, but a cap_bit
> > in struct mtk_eth_muxc which is used to store a full bitfield (rather
> > than the bit number, as the name would suggest) still holds only a
> > 32-bit value.
> > 
> > Change the type of cap_bit to u64 in order to avoid truncating the
> > bitfield which results in path selection to not work with capabilities
> > above the 32-bit limit.
> 
> Could you please be more specific and name a bit or a field that goes
> over 32b? Since this is a fix ideally we'd also have impact to the user
> described in the commit message. But having enough info for the reviewer
> to quickly validate the change is the bare minimum.

I reckon it's too late to include that information in the commit
description. However, let me still illustrate the problem here now:

In mtk_eth_soc.h:

enum mkt_eth_capabilities {
	MTK_RGMII_BIT = 0,
	MTK_TRGMII_BIT,
	MTK_SGMII_BIT,
	MTK_USXGMII_BIT,
	MTK_2P5GPHY_BIT,
	MTK_ESW_BIT,
	MTK_GEPHY_BIT,
	MTK_MUX_BIT,
	MTK_INFRA_BIT,
	MTK_SHARED_SGMII_BIT,
	MTK_HWLRO_BIT,
	MTK_RSS_BIT,
	MTK_SHARED_INT_BIT,
	MTK_PDMA_INT_BIT,
	MTK_TRGMII_MT7621_CLK_BIT,
	MTK_QDMA_BIT,
	MTK_SOC_MT7628_BIT,
	MTK_RSTCTRL_PPE1_BIT,
	MTK_RSTCTRL_PPE2_BIT,
	MTK_U3_COPHY_V2_BIT,
	MTK_SRAM_BIT,
	MTK_36BIT_DMA_BIT,

	/* MUX BITS*/
	MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT,
	MTK_ETH_MUX_GMAC2_GMAC0_TO_GEPHY_BIT,
	MTK_ETH_MUX_U3_GMAC2_TO_QPHY_BIT,
	MTK_ETH_MUX_GMAC2_TO_2P5GPHY_BIT,
	MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII_BIT,
	MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII_BIT,
	MTK_ETH_MUX_GMAC123_TO_GEPHY_SGMII_BIT,
	MTK_ETH_MUX_GMAC123_TO_USXGMII_BIT,

	/* PATH BITS */
	MTK_ETH_PATH_GMAC1_RGMII_BIT,
	MTK_ETH_PATH_GMAC1_TRGMII_BIT,
	MTK_ETH_PATH_GMAC1_SGMII_BIT,
	MTK_ETH_PATH_GMAC2_RGMII_BIT,
	MTK_ETH_PATH_GMAC2_SGMII_BIT,
	MTK_ETH_PATH_GMAC2_2P5GPHY_BIT,
	MTK_ETH_PATH_GMAC2_GEPHY_BIT,
	MTK_ETH_PATH_GMAC3_SGMII_BIT,
	MTK_ETH_PATH_GDM1_ESW_BIT,
	MTK_ETH_PATH_GMAC1_USXGMII_BIT,
	MTK_ETH_PATH_GMAC2_USXGMII_BIT,
	MTK_ETH_PATH_GMAC3_USXGMII_BIT,
};

...

#define MTK_ETH_MUX_GDM1_TO_GMAC1_ESW		\
	BIT_ULL(MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT)
#define MTK_ETH_MUX_GMAC2_GMAC0_TO_GEPHY	\
	BIT_ULL(MTK_ETH_MUX_GMAC2_GMAC0_TO_GEPHY_BIT)
#define MTK_ETH_MUX_U3_GMAC2_TO_QPHY		\
	BIT_ULL(MTK_ETH_MUX_U3_GMAC2_TO_QPHY_BIT)
#define MTK_ETH_MUX_GMAC2_TO_2P5GPHY		\
	BIT_ULL(MTK_ETH_MUX_GMAC2_TO_2P5GPHY_BIT)
#define MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII	\
	BIT_ULL(MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII_BIT)
#define MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII	\
	BIT_ULL(MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII_BIT)
#define MTK_ETH_MUX_GMAC123_TO_GEPHY_SGMII	\
	BIT_ULL(MTK_ETH_MUX_GMAC123_TO_GEPHY_SGMII_BIT)
#define MTK_ETH_MUX_GMAC123_TO_USXGMII	\
	BIT_ULL(MTK_ETH_MUX_GMAC123_TO_USXGMII_BIT)

The above MTK_ETH_MUX_* macros are the ones used as values for cap_bit in
mtk_eth_path.c.
So technically MTK_ETH_MUX_GMAC123_TO_USXGMII == BIT_ULL(29)
which is still fine for a 32-bit value, but never the less BIT_ULL returns
a 64-bit type and hence using a 32-bit type to store the result is at
least misleading.

However, you are right that with the currently supported SoCs this doesn't
result in an actual bug (but it will with the upcoming addition of newer SoC
like MT7987).

