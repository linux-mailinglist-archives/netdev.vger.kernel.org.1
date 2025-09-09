Return-Path: <netdev+bounces-221147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A56B4A7F2
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29B5177F5F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE4F2C2361;
	Tue,  9 Sep 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaX04Jt+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90EE2C21F8
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409800; cv=none; b=p3bqRWydX2tSWcswxEhifDGSvZX/Hz8zc5wWj7hyrPD7pTWgq35XO5E2COhcmOGjicP57YEiWc02fy5Np58IuAmahp2kwLov0Q9unwaRWvmBfQ6m8xg7SiFScxtVPMj2131xmfoQQwsETupeuXjmTrGJ+kOmEIIkbNATZqsQCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409800; c=relaxed/simple;
	bh=ZtUxTF7SCvaPXz0xumFUnj3btwu5AIXrNfPfcFNSuwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1njeFCfBcHimRjBbLXbxLT0aaghpYK0t+k3o4PtQyAEJw1Xbz3DuGRIvA+Rb9JD7TOW4nZdoe6fzR6J2cCxB1Oj9MZ/TPU0EasK3Tb/swiIQKf4+SU6pbLyisO8AbdIKyqGx2CUGN1CW7HVt5+j8Pz2RxQz4L9iEX+hNjGFZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaX04Jt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4FDC4CEF4;
	Tue,  9 Sep 2025 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757409800;
	bh=ZtUxTF7SCvaPXz0xumFUnj3btwu5AIXrNfPfcFNSuwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VaX04Jt+J51CC6pAvNqoreavF+jJY0bcE85qLx/uLu82eA8nFWG06+a81SK1Z9K5o
	 /BIabv5okFswTXAlRWKK8q4qEVx56WPDxz4VI/UuEbBEJBcPn5J5JmS0ryPivls6yr
	 AJ58WSEEnFHGlQhXfRXs/ekAIY5V9ByUiCzWRX4BVnn848DmruLtYOdffh1RRTAlqg
	 I42IxFd5t1gSy+f9hxSf+yiWPo+FA3ZCi8b5WHdsEFfFzaGmyhhTSXm2MgrJxabueO
	 lA9ki6arWAsoIRM410o4A5kT21YgTLLl0Fu3Wp1Y2J4JB2G0MVJ9c6nsiClVlXtn9i
	 1mmjHSeYeZuiQ==
Date: Tue, 9 Sep 2025 12:23:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Xiumei Mu <xmu@redhat.com>
Subject: Re: [PATCH ipsec] xfrm: fix offloading of cross-family tunnels
Message-ID: <20250909092315.GC341237@unreal>
References: <1aaa7c722713167b09a9a22120a9870a25c87eda.1756126057.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aaa7c722713167b09a9a22120a9870a25c87eda.1756126057.git.sd@queasysnail.net>

On Mon, Aug 25, 2025 at 02:50:23PM +0200, Sabrina Dubroca wrote:
> Xiumei reported a regression in IPsec offload tests over xfrmi, where
> IPv6 over IPv4 tunnels are no longer offloaded after commit
> cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback
> implementation").

What does it mean "tunnels not offloaded"? xdo_dev_offload_ok()
participates in data path and influences packet processing itself,
but not if tunnel offloaded or not.

Also what type of "offload" are you talking? Crypto or packet?

> 
> Commit cc18f482e8b6 added a generic version of existing checks
> attempting to prevent packets with IPv4 options or IPv6 extension
> headers from being sent to HW that doesn't support offloading such
> packets. The check mistakenly uses x->props.family (the outer family)
> to determine the inner packet's family and verify if
> options/extensions are present.

This is how ALL implementations did, so I'm not agree with claimed Fixes
tag (it it not important).

> 
> In the case of IPv6 over IPv4, the check compares some of the traffic
> class bits to the expected no-options ihl value (5). The original
> check was introduced in commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add
> Innova IPSec offload TX data path"), and then duplicated in the other
> drivers. Before commit cc18f482e8b6, the loose check (ihl > 5) passed
> because those traffic class bits were not set to a value that
> triggered the no-offload codepath. Packets with options/extension
> headers that should have been handled in SW went through the offload
> path, and were likely dropped by the NIC or incorrectly
> processed.

The latter is more correct, so it raises question against which
in-kernel driver were these xfrmi tests performed?


> Since commit cc18f482e8b6, the check is now strict (ihl !=
> 5), and in a basic setup (no traffic class configured), all packets go
> through the no-offload codepath.
> 
> The commits that introduced the incorrect family checks in each driver
> are:
> 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
> 8362ea16f69f ("crypto: chcr - ESN for Inline IPSec Tx")
> 859a497fe80c ("nfp: implement xfrm callbacks and expose ipsec offload feature to upper layer")
> 32188be805d0 ("cn10k-ipsec: Allow ipsec crypto offload for skb with SA")
> [ixgbe/ixgbevf commits are ignored, as that HW does not support tunnel
> mode, thus no cross-family setups are possible]
> 
> Fixes: cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback implementation")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  net/xfrm/xfrm_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index c7a1f080d2de..44b9de6e4e77 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -438,7 +438,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
>  
>  	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
>  			    x->props.mode == XFRM_MODE_TUNNEL;
> -	switch (x->props.family) {
> +	switch (x->inner_mode.family) {

Will it work for transport mode too? We are taking this path both for
tunnel and transport modes.

Thanks

>  	case AF_INET:
>  		/* Check for IPv4 options */
>  		if (ip_hdr(skb)->ihl != 5)
> -- 
> 2.50.0
> 
> 

