Return-Path: <netdev+bounces-202893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ACBAEF933
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73FF3B69E0
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD626C398;
	Tue,  1 Jul 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCT9E9CL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928325B301;
	Tue,  1 Jul 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374299; cv=none; b=b9bluacM5EPk69Y6Pnf2kMb7nR7JMjksmLbvkpOwNmojDrVeKo8xzIIPqQuU3q3FHeCXyQAD0rFmOFyEhxhyQDBIBerf5N/7+ENuK705UBRem+GBXhc7NnvbNGadUkOb+mteBUSqb/qft+XV8op+AVLOVNL6SakoNXULbASNLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374299; c=relaxed/simple;
	bh=hcZz3rU5GXHb1XwGjVGR0cCvs4ggRLDrLsKOp0GI6yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnKiJsXuMSbYKNyMsrcZI76YZxDWHPM7ZphQ/iYIGkV630DyL7g2Y7GdkLrarMr/X/TvItQ+vxdR+5CwzelzyXpDO7xKs6rZUz8O4VkSp6+D/Xxfez4iAsCChbb5FHmk4yo7f0hqegnuA1t3csPDEN8nKxxdrW0xy7kQ24wt3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCT9E9CL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4D2C4CEEB;
	Tue,  1 Jul 2025 12:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374299;
	bh=hcZz3rU5GXHb1XwGjVGR0cCvs4ggRLDrLsKOp0GI6yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OCT9E9CLG+oV0efdzT66es8TgBeQDw2n0sCcdC9KxaF1ZLQzoYQ6GnJvF6RMqQS0K
	 7R+00L0purFY8aNvakdp5I99wV3JQDUTdjkzerSV3+1EPEjcO9hF8c6cwu8twaJiTe
	 m4L1MjY28l4vQOP9Ar039RGk1iOO/fsOdMJ1a0QkN/HiY9Bv9iJ6rmSmGi0b39kAGU
	 84YZjvF9TeD2lgpnLgaK/+93PNTYwMPNJZMxsL0TkJS4XAroV7hcQug1Kj695cizYC
	 Uqi0ChRgr8gx5BrC8Q5LpmSSoBpuwe8Wz7BfeL5zyH2FWcnJeF3J5Am/gbAhPAYBiE
	 hQYb5J+AIgeew==
Date: Tue, 1 Jul 2025 13:51:33 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
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
Message-ID: <20250701125133.GQ41770@horms.kernel.org>
References: <cover.1751229149.git.daniel@makrotopia.org>
 <61897c7a3dcc0b2976ec2118226c06c220b00a80.1751229149.git.daniel@makrotopia.org>
 <20250630162959.GA57523@horms.kernel.org>
 <aGLVPo9M-RhTowmw@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLVPo9M-RhTowmw@makrotopia.org>

On Mon, Jun 30, 2025 at 07:19:42PM +0100, Daniel Golle wrote:
> On Mon, Jun 30, 2025 at 05:29:59PM +0100, Simon Horman wrote:
> > On Sun, Jun 29, 2025 at 11:22:44PM +0100, Daniel Golle wrote:
> > > Use a dedicated "mmio-sram" and the genpool allocator instead of
> > > open-coding SRAM allocation for DMA rings.
> > > Keep support for legacy device trees but notify the user via a
> > > warning to update.
> > > 
> > > Co-developed-by: Frank Wunderlich <frank-w@public-files.de>
> > > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > > v2: fix return type of mtk_dma_ring_alloc() in case of error
> > > 
> > >  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 120 +++++++++++++-------
> > >  drivers/net/ethernet/mediatek/mtk_eth_soc.h |   4 +-
> > >  2 files changed, 84 insertions(+), 40 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > 
> > ...
> > 
> > > @@ -5117,16 +5148,27 @@ static int mtk_probe(struct platform_device *pdev)
> > >  			err = -EINVAL;
> > >  			goto err_destroy_sgmii;
> > >  		}
> > > +
> > >  		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM)) {
> > > -			if (mtk_is_netsys_v3_or_greater(eth)) {
> > > -				res_sram = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > -				if (!res_sram) {
> > > -					err = -EINVAL;
> > > -					goto err_destroy_sgmii;
> > > +			eth->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
> > > +			if (!eth->sram_pool) {
> > > +				if (!mtk_is_netsys_v3_or_greater(eth)) {
> > > +					/*
> > > +					 * Legacy support for missing 'sram' node in DT.
> > > +					 * SRAM is actual memory and supports transparent access
> > > +					 * just like DRAM. Hence we don't require __iomem being
> > > +					 * set and don't need to use accessor functions to read from
> > > +					 * or write to SRAM.
> > > +					 */
> > > +					eth->sram_base = (void __force *)eth->base +
> > > +							 MTK_ETH_SRAM_OFFSET;
> > > +					eth->phy_scratch_ring = res->start + MTK_ETH_SRAM_OFFSET;
> > > +					dev_warn(&pdev->dev,
> > > +						 "legacy DT: using hard-coded SRAM offset.\n");
> > > +				} else {
> > > +					dev_err(&pdev->dev, "Could not get SRAM pool\n");
> > > +					return -ENODEV;
> > 
> > Hi Daniel,
> > 
> > Rather than returning, should this
> > jump to err_destroy_sgmii to avoid leaking resources?
> 
> Yes, you are right. I'll fix that in v3.

Thanks.

