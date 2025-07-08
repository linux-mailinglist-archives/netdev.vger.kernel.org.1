Return-Path: <netdev+bounces-205081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE90DAFD15E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B7C487DE6
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFA12E5412;
	Tue,  8 Jul 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noAPn9hO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C51548C;
	Tue,  8 Jul 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992405; cv=none; b=PQEtVILlxtogCpG/uvz3H0eaMTp8eywbCP/XXoM7ZAtgddiglPbtdKL1d+bQezj4eH5pb4bWMTUHl37lFebd/OaKuXEfg92Lnjh0d56KFW3g66OSHfMIih0+uwMnq9Vc4AWUQo0W1knL+AA+ercrTmGCaAelm7o7Tn65GdDyxsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992405; c=relaxed/simple;
	bh=4OIgoWB92tOkZPp3k7NAFUE/9r2irLFtR99+gX3vSg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clNQ+Yw0cw3GRAsmmImTw2elJl9zOOY5CS+/oPHPTctayvRTOpM8lrghS78BS1JMNjJUFLwA7cAuu04V+Q/rbUHuDJ62YI+vNqeFyoPb1F2pJDJapIoJ0Nx/Za1lZFg1JdBAEWr7ykBdzLXP6uCjc0e46gNeodEQ+jSKpZCkV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noAPn9hO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE531C4CEED;
	Tue,  8 Jul 2025 16:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751992405;
	bh=4OIgoWB92tOkZPp3k7NAFUE/9r2irLFtR99+gX3vSg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=noAPn9hOCN8MCUlxHKm31evMfq/qx9DR4fIfXY+hzaKTBwIdkgp7aUomDDyL9ZLGc
	 eparDrfjphysm1VqTNQHOKOvcR07nSChFPdvLGLuH9Yaj1yDV3S8qWyWQ63aQTHd9H
	 UA5hw51doEGptcmkRBzbsSR1uQynjHlLmUt2U1DsXE8nUSaLp7meI75nw+Sg9p9nX5
	 Phzz26CNZ3pQg8OQbypyHCQBMbhzUaPaONHG4EpJERykdde7kmn6B6twPWkv1dbLSY
	 7ba6uPDhQnIigFgkvGMc6a72YSnEfUFF71fkr5QTpnRE+17wsDIqoLYuF+oJ5U/4kf
	 45uomp8HvXZLA==
Date: Tue, 8 Jul 2025 17:33:20 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tomasz Duszynski <tduszynski@marvell.com>
Subject: Re: [net] Octeontx2-vf: Fix max packet length errors
Message-ID: <20250708163320.GS452973@horms.kernel.org>
References: <20250702110518.631532-1-hkelam@marvell.com>
 <20250704151511.GE41770@horms.kernel.org>
 <aGzmxAEN9KFC/qce@test-OptiPlex-Tower-Plus-7010>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGzmxAEN9KFC/qce@test-OptiPlex-Tower-Plus-7010>

On Tue, Jul 08, 2025 at 03:07:08PM +0530, Hariprasad Kelam wrote:
> On 2025-07-04 at 20:45:11, Simon Horman (horms@kernel.org) wrote:
> > On Wed, Jul 02, 2025 at 04:35:18PM +0530, Hariprasad Kelam wrote:
> > > Implement packet length validation before submitting packets to
> > > the hardware to prevent MAXLEN_ERR.
> > > 
> > > Fixes: 3184fb5ba96e ("octeontx2-vf: Virtual function driver support")
> > > Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> > > ---
> > >  drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> > > index 8a8b598bd389..766237cd86c3 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> > > @@ -394,6 +394,13 @@ static netdev_tx_t otx2vf_xmit(struct sk_buff *skb, struct net_device *netdev)
> > >  	struct otx2_snd_queue *sq;
> > >  	struct netdev_queue *txq;
> > >  
> > > +	/* Check for minimum and maximum packet length */
> > > +	if (skb->len <= ETH_HLEN ||
> > > +	    (!skb_shinfo(skb)->gso_size && skb->len > vf->tx_max_pktlen)) {
> > > +		dev_kfree_skb(skb);
> > > +		return NETDEV_TX_OK;
> > > +	}
> > 
> > Hi Hariprasad,
> > 
> > I see the same check in otx2_xmit().
> > But I wonder if in that case and this one the rx drop counter for the
> > netdev should be incremented.
> >  
>   Assuming its tx_drop counter, Will add suggested change in V2.

Yes, I think so.

> > Also, do you need this check in rvu_rep_xmit() too?
> > 
>   ACK, will add this check in V2.

Thanks.

...

