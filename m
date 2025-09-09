Return-Path: <netdev+bounces-221367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E55B50535
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFDD5E6CD1
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D132FB606;
	Tue,  9 Sep 2025 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="CKchVs2d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bhQuIBBN"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC2747F
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442567; cv=none; b=emYZ+I6TwG7nCPKIwltyDq4d9pMmTsnTDYJFEeQh5r2H9w7r9re9i90uP2xKnFgWqTvSRefs8qbV077NCVa2WRFG32DZlsYbN2cPh4o6vOaB0Twd4eCWFRp6Cv0uiWvbuyvf8Fk/08pq5Zhs1kNcpVjsf4Yhl4+jhHipcN9+ob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442567; c=relaxed/simple;
	bh=qbBJai5940HIcWQq2f0qe2/7vC+SBB6q/Yd76vAcmKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUWDyrO3JniNeX/gCkAgm5iSWBBjmCxCKt/JaVE23MZkSNAA8BfiaPHgXG8s6OWDm9uRmUGAAdhpkLp+rc233g6UHTtjwRNiUjMIyCIrEon6zN+FqGMhNN/snjqeM4dMruqhMcqbs+JmYlmS9tuY+m0tpzSWH8cytTxhAE1npkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=CKchVs2d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bhQuIBBN; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id E37FAEC00E3;
	Tue,  9 Sep 2025 14:29:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 09 Sep 2025 14:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757442563; x=
	1757528963; bh=PVEuytC2GkR3d5qKXg7Fjiik20jgWjKqO1k0K+JAE5Y=; b=C
	KchVs2dBs8jXi2xbiXgk7CNYgo8mRw/yxFl6onAcOAYj2rbmsMoyQR4dHfBOSA9B
	a5LKnbR9D5hhVIKoLNcp5K0+/IuIxELXg6E1f9lSQ7CYOXfJU/MSnTEr/0K3MLPW
	ME9J8RJKsIuAHnc3n2Km2hB594BZb/uSMYR6VA7XxkVq5u76jWC91XW2StaB3pr+
	Y4DhdFzyusccWQGNpACJtuB2KPjAW5FXIgZnzIYqNaKoF5KhFf5uPKFwpHO6IL1P
	fYjCZ4NBtJ+xJjrNbdE+vFOkiOqbLJhSG492JA2BzrRRuO6/Gk64D+qsx8ykgdhH
	5w9en0W7cbDHvQjwhSg5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757442563; x=1757528963; bh=PVEuytC2GkR3d5qKXg7Fjiik20jgWjKqO1k
	0K+JAE5Y=; b=bhQuIBBNsVEeOF3rBenRz8B0SFvTdySc+NK5s5z9HnRpq5kEUPx
	znS/scrMcubnPaWDf2ppsLemJK4m6P39TR7i0yKdR2gPxFCfcUVhc2PZOhQ/UXPM
	6mWMGXBy3Nzr1RUeX1mxcyXHV4tmarsk8uPwL/CzrCPzxLrCChov0z3Tk/K8KqdY
	ZcIsmNYtCIVouHuPAGkpvPlWcU38Kbn9RqqBM7dpZMRcO3ymoyi8boVA8Rauc2bG
	s9LAiXJrfmR1N6CsNXcAuR7KGfLb/efKkIZTp7hV7rv7EcJc50m+vDGsH22hVDBa
	rUPWBxjfYxZu/905vhctUkKPzPvxYnphpBA==
X-ME-Sender: <xms:A3LAaBpTYNfEi8A7lk-m-9WCyGIWAVGiktTQf_dY-vKHVQbKrHImtA>
    <xme:A3LAaPJQtwkUtJWoOIP-JGwMR4J-qgGmlhfdyoNHk0XdFjaRkVVamhD2ExKrWuvOg
    olAFx43NQLiCufppNA>
X-ME-Received: <xmr:A3LAaEoNgNYo40hD_NFN56ytoBlTniuhUToTqSoZvY9ILhhITPMXjPd-J3Lp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeejkeelveelkeefgfeuheevjeeukedvhedvueegvdekleeghfelgeeiveff
    tdeuudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeih
    rghnjhhunhdriihhuheslhhinhhugidruggvvhdprhgtphhtthhopehsthgvfhhfvghnrd
    hklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtthhopeigmhhusehrvggu
    hhgrthdrtghomh
X-ME-Proxy: <xmx:A3LAaHzhwwGOJwTIA0omu78frEQLxel6Xp2-j4Lawn0NYd0z6rwhFg>
    <xmx:A3LAaIPDSCcNrLIuAdFc4Vs8fkumUY0apswG4YYdNm36KB1u8CQJOA>
    <xmx:A3LAaM44oEaQk_bPeKAcbFJgSZBg2kUcFyGjKt5CmPQkTVUqviRR5Q>
    <xmx:A3LAaBmFmv6miNmtio7ZzBOT5GTmAMiNoQdWgeISQF8zv_QyLExxSg>
    <xmx:A3LAaEF5Y-WTBXkWQbtZDJNtgYQ8AWg9hLLELqZxrHYNxXGYILMHpkMC>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 14:29:22 -0400 (EDT)
Date: Tue, 9 Sep 2025 20:29:20 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Xiumei Mu <xmu@redhat.com>
Subject: Re: [PATCH ipsec] xfrm: fix offloading of cross-family tunnels
Message-ID: <aMByADrbXBAXzIJr@krikkit>
References: <1aaa7c722713167b09a9a22120a9870a25c87eda.1756126057.git.sd@queasysnail.net>
 <20250909092315.GC341237@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909092315.GC341237@unreal>

2025-09-09, 12:23:15 +0300, Leon Romanovsky wrote:
> On Mon, Aug 25, 2025 at 02:50:23PM +0200, Sabrina Dubroca wrote:
> > Xiumei reported a regression in IPsec offload tests over xfrmi, where
> > IPv6 over IPv4 tunnels are no longer offloaded after commit
> > cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback
> > implementation").
> 
> What does it mean "tunnels not offloaded"?

Offload is no longer performed for those tunnels, or for packets going
through those tunnels if we want to be pedantic.

> xdo_dev_offload_ok()
> participates in data path and influences packet processing itself,
> but not if tunnel offloaded or not.

If for you "tunnel is offloaded" means "xdo_dev_state_add is called",
then yes.


> Also what type of "offload" are you talking? Crypto or packet?

Crypto offload, but I don't think packet offload would behave
differently here.

> > Commit cc18f482e8b6 added a generic version of existing checks
> > attempting to prevent packets with IPv4 options or IPv6 extension
> > headers from being sent to HW that doesn't support offloading such
> > packets. The check mistakenly uses x->props.family (the outer family)
> > to determine the inner packet's family and verify if
> > options/extensions are present.
> 
> This is how ALL implementations did, so I'm not agree with claimed Fixes
> tag (it it not important).

Well, prior to your commit, offload seemed to work on mlx5 as I
describe just after this.

But yes, I opted for a Fixes tag more aimed at stable backports with
additional references to the commits. I don't mind putting all the
Fixes tags for each driver as well (except ixgbe/ixgbevf since it's
transport-only so not affected by this, as I wrote in the commit).

> > In the case of IPv6 over IPv4, the check compares some of the traffic
> > class bits to the expected no-options ihl value (5). The original
> > check was introduced in commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add
> > Innova IPSec offload TX data path"), and then duplicated in the other
> > drivers. Before commit cc18f482e8b6, the loose check (ihl > 5) passed
> > because those traffic class bits were not set to a value that
> > triggered the no-offload codepath. Packets with options/extension
> > headers that should have been handled in SW went through the offload
> > path, and were likely dropped by the NIC or incorrectly
> > processed.
> 
> The latter is more correct, so it raises question against which
> in-kernel driver were these xfrmi tests performed?

mlx5

> > Since commit cc18f482e8b6, the check is now strict (ihl !=
> > 5), and in a basic setup (no traffic class configured), all packets go
> > through the no-offload codepath.
> > 
> > The commits that introduced the incorrect family checks in each driver
> > are:
> > 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
> > 8362ea16f69f ("crypto: chcr - ESN for Inline IPSec Tx")
> > 859a497fe80c ("nfp: implement xfrm callbacks and expose ipsec offload feature to upper layer")
> > 32188be805d0 ("cn10k-ipsec: Allow ipsec crypto offload for skb with SA")
> > [ixgbe/ixgbevf commits are ignored, as that HW does not support tunnel
> > mode, thus no cross-family setups are possible]
> > 
> > Fixes: cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback implementation")
> > Reported-by: Xiumei Mu <xmu@redhat.com>
> > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > ---
> >  net/xfrm/xfrm_device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > index c7a1f080d2de..44b9de6e4e77 100644
> > --- a/net/xfrm/xfrm_device.c
> > +++ b/net/xfrm/xfrm_device.c
> > @@ -438,7 +438,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
> >  
> >  	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
> >  			    x->props.mode == XFRM_MODE_TUNNEL;
> > -	switch (x->props.family) {
> > +	switch (x->inner_mode.family) {
> 
> Will it work for transport mode too? We are taking this path both for
> tunnel and transport modes.

Yes, if you look at __xfrm_init_state, inner_mode will always be set
to whatever family is "inside".

> Thanks
> 
> >  	case AF_INET:
> >  		/* Check for IPv4 options */
> >  		if (ip_hdr(skb)->ihl != 5)
> > -- 
> > 2.50.0
> > 
> > 

-- 
Sabrina

