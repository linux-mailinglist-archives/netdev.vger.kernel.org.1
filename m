Return-Path: <netdev+bounces-221553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F832B50D86
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 07:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BBD87AD9FC
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 05:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA631D392;
	Wed, 10 Sep 2025 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOJWUusm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0CE31D370
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757483156; cv=none; b=fOVOmgyycfsxx0WsHTy9BptO71xNxXogIh4Nne4i5lC6XhUTBnhZ+2a80gNvRx5U+XkKlGPor5HvlsciSWcqgNNxkbxuzoMnPGidHbABXs9a7X5vKT15U5bVqNT209PpGCMadocVc2a8qnphsm5sV4I+L8K6SvsWZaExEFdbOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757483156; c=relaxed/simple;
	bh=E8gJl/om+W0uBuTkpIgR4ZV5rfta8591Zse7Xvhnn1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flOrARzFwQNhab9nFz2N4rtdUN42utJuBFDLzfSkXWXJR7sUU6TZ7O0aUS1o6Hgd1c+xhqNR+7S3EyOzM7abrALGXykYmVSl6d3upV57d6WgAoXl+z3Y6MmBsXb2xtou2nYTZKMCn6PggnTHyUTrKoMUwprWAP2R1XHFVzNKC6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOJWUusm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A59C4CEF0;
	Wed, 10 Sep 2025 05:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757483156;
	bh=E8gJl/om+W0uBuTkpIgR4ZV5rfta8591Zse7Xvhnn1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOJWUusmg5+HlP8TEJr7ZnopxQ9ID/ZEJp/3dfno/O7jridG2ik3jCap2gJECTqh3
	 QhV1W6sY5AgNZIIbEkSfUsa+OAPEhEBoJfPJBNB81n3Km/k3TpnSn0SE71ptI4i4jl
	 gD1eccJ46FjH2kEC8kworZ8f1ekn6mrkI4PCbX/HEW/59lpfobo7Z/0YRkfPAdmlUs
	 52gfLnReKMF7Y4uNBLomOZ9t3Xu+qGY26cAxaK2KGW6D3N7mLOvv/h+G0gMGizAnkO
	 8dj5ahxAqtoBvVIDtnnE5fh9gmEDUZERJEst3xDbrnQEPLBgREB08od1eano6MWr3E
	 vY9V6zb+ULVYw==
Date: Wed, 10 Sep 2025 08:45:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Xiumei Mu <xmu@redhat.com>
Subject: Re: [PATCH ipsec] xfrm: fix offloading of cross-family tunnels
Message-ID: <20250910054550.GI341237@unreal>
References: <1aaa7c722713167b09a9a22120a9870a25c87eda.1756126057.git.sd@queasysnail.net>
 <20250909092315.GC341237@unreal>
 <aMByADrbXBAXzIJr@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMByADrbXBAXzIJr@krikkit>

On Tue, Sep 09, 2025 at 08:29:20PM +0200, Sabrina Dubroca wrote:
> 2025-09-09, 12:23:15 +0300, Leon Romanovsky wrote:
> > On Mon, Aug 25, 2025 at 02:50:23PM +0200, Sabrina Dubroca wrote:
> > > Xiumei reported a regression in IPsec offload tests over xfrmi, where
> > > IPv6 over IPv4 tunnels are no longer offloaded after commit
> > > cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback
> > > implementation").
> > 
> > What does it mean "tunnels not offloaded"?
> 
> Offload is no longer performed for those tunnels, or for packets going
> through those tunnels if we want to be pedantic.
> 
> > xdo_dev_offload_ok()
> > participates in data path and influences packet processing itself,
> > but not if tunnel offloaded or not.
> 
> If for you "tunnel is offloaded" means "xdo_dev_state_add is called",
> then yes.

Yes, "offloaded" means that we created HW objects.

> 
> 
> > Also what type of "offload" are you talking? Crypto or packet?
> 
> Crypto offload, but I don't think packet offload would behave
> differently here.

It will, at least in the latest code, we have an extra check before
passing packet to HW.

  765         if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET) {
  766                 if (!xfrm_dev_offload_ok(skb, x)) {
  767                         XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
  768                         kfree_skb(skb);
  769                         return -EHOSTUNREACH;
  770                 }

> 
> > > Commit cc18f482e8b6 added a generic version of existing checks
> > > attempting to prevent packets with IPv4 options or IPv6 extension
> > > headers from being sent to HW that doesn't support offloading such
> > > packets. The check mistakenly uses x->props.family (the outer family)
> > > to determine the inner packet's family and verify if
> > > options/extensions are present.
> > 
> > This is how ALL implementations did, so I'm not agree with claimed Fixes
> > tag (it it not important).
> 
> Well, prior to your commit, offload seemed to work on mlx5 as I
> describe just after this.

It worked by chance, not by design :)

> 
> But yes, I opted for a Fixes tag more aimed at stable backports with
> additional references to the commits. I don't mind putting all the
> Fixes tags for each driver as well (except ixgbe/ixgbevf since it's
> transport-only so not affected by this, as I wrote in the commit).

No problem, like I wrote, it is not important.

> 
> > > In the case of IPv6 over IPv4, the check compares some of the traffic
> > > class bits to the expected no-options ihl value (5). The original
> > > check was introduced in commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add
> > > Innova IPSec offload TX data path"), and then duplicated in the other
> > > drivers. Before commit cc18f482e8b6, the loose check (ihl > 5) passed
> > > because those traffic class bits were not set to a value that
> > > triggered the no-offload codepath. Packets with options/extension
> > > headers that should have been handled in SW went through the offload
> > > path, and were likely dropped by the NIC or incorrectly
> > > processed.
> > 
> > The latter is more correct, so it raises question against which
> > in-kernel driver were these xfrmi tests performed?
> 
> mlx5

It is artifact.

> 
> > > Since commit cc18f482e8b6, the check is now strict (ihl !=
> > > 5), and in a basic setup (no traffic class configured), all packets go
> > > through the no-offload codepath.
> > > 
> > > The commits that introduced the incorrect family checks in each driver
> > > are:
> > > 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
> > > 8362ea16f69f ("crypto: chcr - ESN for Inline IPSec Tx")
> > > 859a497fe80c ("nfp: implement xfrm callbacks and expose ipsec offload feature to upper layer")
> > > 32188be805d0 ("cn10k-ipsec: Allow ipsec crypto offload for skb with SA")
> > > [ixgbe/ixgbevf commits are ignored, as that HW does not support tunnel
> > > mode, thus no cross-family setups are possible]
> > > 
> > > Fixes: cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback implementation")
> > > Reported-by: Xiumei Mu <xmu@redhat.com>
> > > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > > ---
> > >  net/xfrm/xfrm_device.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > > index c7a1f080d2de..44b9de6e4e77 100644
> > > --- a/net/xfrm/xfrm_device.c
> > > +++ b/net/xfrm/xfrm_device.c
> > > @@ -438,7 +438,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
> > >  
> > >  	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
> > >  			    x->props.mode == XFRM_MODE_TUNNEL;
> > > -	switch (x->props.family) {
> > > +	switch (x->inner_mode.family) {
> > 
> > Will it work for transport mode too? We are taking this path both for
> > tunnel and transport modes.
> 
> Yes, if you look at __xfrm_init_state, inner_mode will always be set
> to whatever family is "inside".

I believe that you need to rephrase commit message around meaning of "offloaded"
but the change looks ok to me.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

