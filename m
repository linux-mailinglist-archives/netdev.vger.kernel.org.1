Return-Path: <netdev+bounces-96323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944508C5062
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74161C20BB3
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669313D257;
	Tue, 14 May 2024 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0WNav8J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B35A0FE;
	Tue, 14 May 2024 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683293; cv=none; b=g8grSj/5ucY8IUI/cmfnsbLpage0JmjEPGV4pU0WN0I1UyIjJgZVUR76wyQTo38G+hjdyelzEKurh2en19RRSTav3GgCn98jLxSfWD0gPhNV89kCgei3UT4QD2jYExF2btwQYbc/sd7NssMd+LOx1mJ64XW2cUJbclhNw5FO4PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683293; c=relaxed/simple;
	bh=w7MCKplwmEPm2+rsZLZIRIf6nKYLrP/0X/bZOgC19tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoH18/SAYn9B20llLe0lm5zOG6XJHDSidcuHf1AQNpio7yMQqDJN31RgUiF03jefxyBuki/iT6lni1yTZLtr1d+qcwmZhQQBnuv9lpkeEEswpWg/o+7kk9/6X14Wk4PNNHc5ziVU+goHO9XotGf2NHhhC4OMhfc92ixpvJt0j00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0WNav8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36985C32781;
	Tue, 14 May 2024 10:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715683292;
	bh=w7MCKplwmEPm2+rsZLZIRIf6nKYLrP/0X/bZOgC19tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0WNav8JKqo/LYSDUidQdaEnaKUq2hTLXnSjeu2V+WuTi6M0ES4c4QMQ1JAgRx6tR
	 AAnHtM9q+ko//a5UuoS3smR/4BwVKr8wfjGuIloc/bEcAunZm6IijJCHynOsqbxwGu
	 8ncIIYTzruQuCuE0Ze0nXTK3vnkAuHf/Rza53sg5LnDOlnkiNHnmx7Wn9qrZR9dcOO
	 1IKdtcnl9e7sgtreQP0SQB6BsZuiK8n7/HM+tqcliW6yEAGr9dUYD1ZTGXgAhs0Zn8
	 vPNpDRK//q3m7315+CbSZxjMI9v6pp4lxE8u/Ei/rFNowXX+kIWH1r6QaUmhObj7hu
	 J/F9oOfgLXeuQ==
Date: Tue, 14 May 2024 11:41:25 +0100
From: Simon Horman <horms@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>
Subject: Re: [EXTERNAL] Re: [net-next,v2 3/8] octeontx2-af: Disable
 backpressure between CPT and NIX
Message-ID: <20240514104125.GD2787@kernel.org>
References: <20240513105446.297451-1-bbhushan2@marvell.com>
 <20240513105446.297451-4-bbhushan2@marvell.com>
 <20240513161447.GR2787@kernel.org>
 <SN7PR18MB53149716909DE5993145509AE3E32@SN7PR18MB5314.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR18MB53149716909DE5993145509AE3E32@SN7PR18MB5314.namprd18.prod.outlook.com>

On Tue, May 14, 2024 at 06:39:45AM +0000, Bharat Bhushan wrote:
> Please see inline
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Monday, May 13, 2024 9:45 PM
> > To: Bharat Bhushan <bbhushan2@marvell.com>
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> > Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> > <gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
> > Hariprasad Kelam <hkelam@marvell.com>; davem@davemloft.net;
> > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jerin Jacob
> > <jerinj@marvell.com>; Linu Cherian <lcherian@marvell.com>;
> > richardcochran@gmail.com
> > Subject: [EXTERNAL] Re: [net-next,v2 3/8] octeontx2-af: Disable backpressure
> > between CPT and NIX
> > 
> > 
> > ----------------------------------------------------------------------
> > On Mon, May 13, 2024 at 04:24:41PM +0530, Bharat Bhushan wrote:
> > > NIX can assert backpressure to CPT on the NIX<=>CPT link.
> > > Keep the backpressure disabled for now. NIX block anyways
> > > handles backpressure asserted by MAC due to PFC or flow
> > > control pkts.
> > >
> > > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > 
> > ...
> > 
> > > @@ -592,8 +596,16 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu
> > *rvu,
> > >  	bp = &nix_hw->bp;
> > >  	chan_base = pfvf->rx_chan_base + req->chan_base;
> > >  	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
> > > -		cfg = rvu_read64(rvu, blkaddr,
> > NIX_AF_RX_CHANX_CFG(chan));
> > > -		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan),
> > > +		/* CPT channel for a given link channel is always
> > > +		 * assumed to be BIT(11) set in link channel.
> > > +		 */
> > > +		if (cpt_link)
> > > +			chan_v = chan | BIT(11);
> > > +		else
> > > +			chan_v = chan;
> > 
> > Hi Bharat,
> > 
> > The chan_v logic above seems to appear twice in this patch.
> > I'd suggest adding a helper.
> 
> Will fix in next version.
> 
> > 
> > > +
> > > +		cfg = rvu_read64(rvu, blkaddr,
> > NIX_AF_RX_CHANX_CFG(chan_v));
> > > +		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
> > >  			    cfg & ~BIT_ULL(16));
> > >
> > >  		if (type == NIX_INTF_TYPE_LBK) {
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > > index 7ec99c8d610c..e9d2e039a322 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > > @@ -1705,6 +1705,31 @@ int otx2_nix_config_bp(struct otx2_nic *pfvf,
> > bool enable)
> > >  }
> > >  EXPORT_SYMBOL(otx2_nix_config_bp);
> > >
> > > +int otx2_nix_cpt_config_bp(struct otx2_nic *pfvf, bool enable)
> > > +{
> > > +	struct nix_bp_cfg_req *req;
> > > +
> > > +	if (enable)
> > > +		req = otx2_mbox_alloc_msg_nix_cpt_bp_enable(&pfvf-
> > >mbox);
> > > +	else
> > > +		req = otx2_mbox_alloc_msg_nix_cpt_bp_disable(&pfvf-
> > >mbox);
> > > +
> > > +	if (!req)
> > > +		return -ENOMEM;
> > > +
> > > +	req->chan_base = 0;
> > > +#ifdef CONFIG_DCB
> > > +	req->chan_cnt = pfvf->pfc_en ? IEEE_8021QAZ_MAX_TCS : 1;
> > > +	req->bpid_per_chan = pfvf->pfc_en ? 1 : 0;
> > > +#else
> > > +	req->chan_cnt =  1;
> > > +	req->bpid_per_chan = 0;
> > > +#endif
> > 
> > IMHO, inline #ifdefs reduce readability and reduce maintainability.
> > 
> > Would it be possible to either:
> > 
> > 1. Include the pfc_en field in struct otx2_nic and make
> >    sure it is set to 0 if CONFIG_DCB is unset; or
> > 2. Provide a wrapper that returns 0 if CONFIG_DCB is unset,
> >    otherwise pfvf->pfc_en.
> > 
> > I suspect 1 will have little downside and be easiest to implement.
> 
> pfc_en is already a field of otx2_nic but under CONFIG_DCB. Will fix by adding a wrapper function like:

Thanks. Just to clarify, my first suggestion was to move
pfc_en outside of CONFIG_DCB in otx2_nic.

> 
> static bool is_pfc_enabled(struct otx2_nic *pfvf)
> {
> #ifdef CONFIG_DCB
>         return pfvf->pfc_en ? true : false;

FWIIW, I think this could also be:

	return !!pfvf->pfc_en;

> #endif
>         return false;
> }

Also, I do wonder if the following can work:

	return IS_ENABLED(CONFIG_DCB) && pfvf->pfc_en;

> 
> Using same like..
> ...
>         if (is_pfc_enabled(pfvf)) {

If so, perhaps this can work:

	if (IS_ENABLED(CONFIG_DCB) && pfvf->pfc_en) {
		...

>                 req->chan_cnt = IEEE_8021QAZ_MAX_TCS;
>                 req->bpid_per_chan = 1;
>         } else {
>                 req->chan_cnt = 1;
>                 req->bpid_per_chan = 0;
>         }
> ...

