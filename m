Return-Path: <netdev+bounces-202632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AC8AEE6A8
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 20:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEE93BCDE8
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EF41C861B;
	Mon, 30 Jun 2025 18:20:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF31C5D57;
	Mon, 30 Jun 2025 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307610; cv=none; b=YCyjJKhOSJxS/JU6oKPzhMJ+zed2uNHSHezQIw26GFljSlYWExCNdvdFRZvtYC97otYE4cynHxjmMbUvVpFEomroRToFGecsmmsPikzqVwzckeX3aOr1oewFnC3nm9Jzi3d6lMG8XmJRPW7rgtZhYgqBTjYTAw0LZFhL+eXZtGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307610; c=relaxed/simple;
	bh=6Y5Q9o6niBc1wW/qQciLoEiC649aCdmS1pSCDEfqP0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Et3Z71BZ+xiPTuh5sxy9s9ucBVgipxCt0oZq79U4MwFDnuRvZw/NPDFL8afS11/olhwv1ZcwPzUH8PF7W3Kh5U38g9LRi0EI344jNTXWwbJ4WjyRkx/Qg0MqR2KKB1982V5jCNviXwXe82m4KEy5EoTvpJY8iXE/LoIgt3YlO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uWJ6Y-000000006fR-2UuI;
	Mon, 30 Jun 2025 18:19:46 +0000
Date: Mon, 30 Jun 2025 19:19:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Horman <horms@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>,
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
Subject: Re: [PATCH net-next v2 3/3] net: ethernet: mtk_eth_soc: use genpool
 allocator for SRAM
Message-ID: <aGLVPo9M-RhTowmw@makrotopia.org>
References: <cover.1751229149.git.daniel@makrotopia.org>
 <61897c7a3dcc0b2976ec2118226c06c220b00a80.1751229149.git.daniel@makrotopia.org>
 <20250630162959.GA57523@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630162959.GA57523@horms.kernel.org>

On Mon, Jun 30, 2025 at 05:29:59PM +0100, Simon Horman wrote:
> On Sun, Jun 29, 2025 at 11:22:44PM +0100, Daniel Golle wrote:
> > Use a dedicated "mmio-sram" and the genpool allocator instead of
> > open-coding SRAM allocation for DMA rings.
> > Keep support for legacy device trees but notify the user via a
> > warning to update.
> > 
> > Co-developed-by: Frank Wunderlich <frank-w@public-files.de>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > v2: fix return type of mtk_dma_ring_alloc() in case of error
> > 
> >  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 120 +++++++++++++-------
> >  drivers/net/ethernet/mediatek/mtk_eth_soc.h |   4 +-
> >  2 files changed, 84 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> 
> ...
> 
> > @@ -5117,16 +5148,27 @@ static int mtk_probe(struct platform_device *pdev)
> >  			err = -EINVAL;
> >  			goto err_destroy_sgmii;
> >  		}
> > +
> >  		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM)) {
> > -			if (mtk_is_netsys_v3_or_greater(eth)) {
> > -				res_sram = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > -				if (!res_sram) {
> > -					err = -EINVAL;
> > -					goto err_destroy_sgmii;
> > +			eth->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
> > +			if (!eth->sram_pool) {
> > +				if (!mtk_is_netsys_v3_or_greater(eth)) {
> > +					/*
> > +					 * Legacy support for missing 'sram' node in DT.
> > +					 * SRAM is actual memory and supports transparent access
> > +					 * just like DRAM. Hence we don't require __iomem being
> > +					 * set and don't need to use accessor functions to read from
> > +					 * or write to SRAM.
> > +					 */
> > +					eth->sram_base = (void __force *)eth->base +
> > +							 MTK_ETH_SRAM_OFFSET;
> > +					eth->phy_scratch_ring = res->start + MTK_ETH_SRAM_OFFSET;
> > +					dev_warn(&pdev->dev,
> > +						 "legacy DT: using hard-coded SRAM offset.\n");
> > +				} else {
> > +					dev_err(&pdev->dev, "Could not get SRAM pool\n");
> > +					return -ENODEV;
> 
> Hi Daniel,
> 
> Rather than returning, should this
> jump to err_destroy_sgmii to avoid leaking resources?

Yes, you are right. I'll fix that in v3.

