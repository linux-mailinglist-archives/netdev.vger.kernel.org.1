Return-Path: <netdev+bounces-221600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81111B511A1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042AF3B179D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A725E2BF3CF;
	Wed, 10 Sep 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJwZbD9s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3D24A058
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493632; cv=none; b=iMeYKfSHfCsbAX5C6hwY2lWN0KmH+F5xRczCQBKmXpCFvQRjObfahjHCC5cGdT738EMru5Qpnx5F/uJJnX0n8Su1BT1LyBo34Z3IkvPvdp2gRb1EuLPIpTV58o+b5I6CelDvmmkyEKk4TS3xc1cpyDksLuRglLu+u3Fp2TVuLiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493632; c=relaxed/simple;
	bh=dqzOebhYtBEm/9mdnkeCrdoukRPVSibFUQqAe+v50KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcLVOMe0bICu9b4e3wntRb0UXxNanCwTDSWKbSZBU5b6j6c3u60Kohl0XVTSlVphiIOIRmuqluLvEi/dTjXTGNtloA6XGp2Q6qa/pl25HwzPr/fnszdCEyWMwu5WgGZ/TiQlxIRcj0e62I+yy9mm9PqPkNzwMNSwWd7CrKE7g8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJwZbD9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C16AC4CEFC;
	Wed, 10 Sep 2025 08:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757493632;
	bh=dqzOebhYtBEm/9mdnkeCrdoukRPVSibFUQqAe+v50KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJwZbD9s5jPqDoV20gcRFE8VgiUyMTNnpIzA8VzK9PeLYi6swB+uA5AvsLuWl3cjl
	 zAbVMq1U9Fpbi1NoDAFH8GfOkmtr/1h3Zj+rztysJOLnTnYcWt6Fxugb5opetD+h0d
	 TppZ9/UKqLDmXF9kA9bWAwYdsG0eFJJMoDz1gS4ezMWOpITnrA8wzIqtSnOsUG48Ur
	 DrpmTAbVNodfFYlrX6wabrCV/s/jspNAKU5L/eVzbqRvxIaiqOgbd2BIUTrx8HLzHX
	 CG0WyKtLWC7Tt6pMzuVCv09oa/Z77dAgoJox8YG2Q4rnjTJErRmGAmo1LqSNDTu6Tv
	 voRynZYLezNxA==
Date: Wed, 10 Sep 2025 11:40:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Xiumei Mu <xmu@redhat.com>
Subject: Re: [PATCH ipsec] xfrm: fix offloading of cross-family tunnels
Message-ID: <20250910084027.GL341237@unreal>
References: <1aaa7c722713167b09a9a22120a9870a25c87eda.1756126057.git.sd@queasysnail.net>
 <20250909092315.GC341237@unreal>
 <aMByADrbXBAXzIJr@krikkit>
 <20250910054550.GI341237@unreal>
 <aMExEjj3I4ahnMHc@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMExEjj3I4ahnMHc@krikkit>

On Wed, Sep 10, 2025 at 10:04:34AM +0200, Sabrina Dubroca wrote:
> 2025-09-10, 08:45:50 +0300, Leon Romanovsky wrote:
> > On Tue, Sep 09, 2025 at 08:29:20PM +0200, Sabrina Dubroca wrote:
> > > 2025-09-09, 12:23:15 +0300, Leon Romanovsky wrote:
> > > > On Mon, Aug 25, 2025 at 02:50:23PM +0200, Sabrina Dubroca wrote:
> > > > > Xiumei reported a regression in IPsec offload tests over xfrmi, where
> > > > > IPv6 over IPv4 tunnels are no longer offloaded after commit
> > > > > cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback
> > > > > implementation").
> > > > 
> > > > What does it mean "tunnels not offloaded"?
> > > 
> > > Offload is no longer performed for those tunnels, or for packets going
> > > through those tunnels if we want to be pedantic.
> > > 
> > > > xdo_dev_offload_ok()
> > > > participates in data path and influences packet processing itself,
> > > > but not if tunnel offloaded or not.
> > > 
> > > If for you "tunnel is offloaded" means "xdo_dev_state_add is called",
> > > then yes.
> > 
> > Yes, "offloaded" means that we created HW objects.
> 
> For me "offloaded" can mean either the xfrm state or the packets
> depending on context, and I don't think there's a strict definition,
> but whatever.
> 
> Xiumei reported a regression in IPsec offload tests over xfrmi, where
> the traffic for IPv6 over IPv4 tunnels is processed in SW instead of
> going through crypto offload, after commit [...].
> 
> It's getting too verbose IMO, but does that work for you?

Yes, it is perfectly fine.

> 
> 
> For the subject, are you ok with the current one? It's hard to fit
> more details into such a short space.

Leave subject as is, you describe issue well enough in the commit
message.

> 
> > > > Also what type of "offload" are you talking? Crypto or packet?
> > > 
> > > Crypto offload, but I don't think packet offload would behave
> > > differently here.
> > 
> > It will, at least in the latest code, we have an extra check before
> > passing packet to HW.
> > 
> >   765         if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET) {
> >   766                 if (!xfrm_dev_offload_ok(skb, x)) {
> >   767                         XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> >   768                         kfree_skb(skb);
> >   769                         return -EHOSTUNREACH;
> >   770                 }
> 
> So it looks like packet offload is also affected. We get to
> xfrm_dev_offload_ok, it does the wrong check, and the packets will get
> dropped instead of being sent through SW crypto. Am I misreading this?

There is no fallback in packet offload, so dropping packet which can't
be handled by HW is right thing to do. I agree that we shouldn't fail
here.

> 
> 
> > > > > Commit cc18f482e8b6 added a generic version of existing checks
> > > > > attempting to prevent packets with IPv4 options or IPv6 extension
> > > > > headers from being sent to HW that doesn't support offloading such
> > > > > packets. The check mistakenly uses x->props.family (the outer family)
> > > > > to determine the inner packet's family and verify if
> > > > > options/extensions are present.
> > > > 
> > > > This is how ALL implementations did, so I'm not agree with claimed Fixes
> > > > tag (it it not important).
> > > 
> > > Well, prior to your commit, offload seemed to work on mlx5 as I
> > > describe just after this.
> > 
> > It worked by chance, not by design :)
> 
> Sure.
> 
> [...]
> > > > The latter is more correct, so it raises question against which
> > > > in-kernel driver were these xfrmi tests performed?
> > > 
> > > mlx5
> > 
> > It is artifact.
> 
> Sorry, I'm not sure what you mean here.

I'm saying that "works" depends on FW and HW revision.

> 
> [...]
> > > > Will it work for transport mode too? We are taking this path both for
> > > > tunnel and transport modes.
> > > 
> > > Yes, if you look at __xfrm_init_state, inner_mode will always be set
> > > to whatever family is "inside".
> > 
> > I believe that you need to rephrase commit message around meaning of "offloaded"
> > but the change looks ok to me.
> > 
> > Thanks,
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Thanks. I'll send a v2 when we agree on the wording, to avoid
> resending multiple times.
> 
> -- 
> Sabrina

