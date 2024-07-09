Return-Path: <netdev+bounces-110235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3449E92B911
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33A0281B24
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E80158202;
	Tue,  9 Jul 2024 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAxFPG1u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661B15698B;
	Tue,  9 Jul 2024 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526966; cv=none; b=uwtP6Z5Hdi7TbhlFAjL7lsgYX4bZdCD65w4lmnzs7j8aEopPEC1/CB9CDK8919joINe9oDgVCx+k5Jz3Ifykb4XV703qdVksQVuTbUWKXgO/5Tibuxm2Ak67hv9N0qM6f9NH1NEvgbqWJw/F9jA23kX8uJrrfFfeVeN6KVirBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526966; c=relaxed/simple;
	bh=N6uJbMj7JJjxIBnZJqgZ4bxBOAheygBP8PcnbYWljHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFl9JE6jQ78L3+YtrvfSXKvJexLBDM6yHB/15t8GXzeCL50Mpikqj5KhNpp/X2UsnLOHDLQXepfdkRl40NHFfg5t2nqXgN4J6B5ie4zru4faTu1RlIBqMUMoEPyE1U2nkklGDPx6ZSrMDF1/y52tE8sdiBtMldjomqM6EkPUUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAxFPG1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E326C3277B;
	Tue,  9 Jul 2024 12:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720526965;
	bh=N6uJbMj7JJjxIBnZJqgZ4bxBOAheygBP8PcnbYWljHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAxFPG1u+x8bpLlJeh+GxukTqN3VlDLEGHNXlwnrZjdKxNuDZZGGFHkwVR2ulFTch
	 j7NWrHcFK1+nwnSk35Tv9WaZP4AapCjvTGul0bGppaJ+/Qmf9T1Pbd3zuFCUyzm2wZ
	 0Z+8/qgBs5WTpk9ptT/xr1EGTvHwgo9Bk7MiibA/Cm1NY1ZsBVQ5NC90HxvcF1PLKV
	 s9forepR80W0KAZO1gc6cqM1GD79uOlFigMQ0zboQw1o73fS7lO/JE8FdJGDjhLn1F
	 ops3Fb6h0wr31uS1qhcXJpLb6A1wLuDadLapuv81+FbiJexfb+XcUhPXYMtb2ayaBP
	 Wv9MqGf0QYP3g==
Date: Tue, 9 Jul 2024 13:09:19 +0100
From: Simon Horman <horms@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, idosch@nvidia.com, amcohen@nvidia.com,
	petrm@nvidia.com, gnault@redhat.com, jbenc@redhat.com,
	b.galvani@gmail.com, martin.lau@kernel.org, daniel@iogearbox.net,
	aahila@google.com, liuhangbin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: vxlan: enable local address bind
 for vxlan sockets
Message-ID: <20240709120919.GH346094@kernel.org>
References: <20240708111103.9742-1-richardbgobert@gmail.com>
 <20240708111103.9742-2-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708111103.9742-2-richardbgobert@gmail.com>

On Mon, Jul 08, 2024 at 01:11:02PM +0200, Richard Gobert wrote:
> This patch adds support for binding to a local address in vxlan sockets.
> It achieves this by using vxlan_addr union to represent a local address
> to bind to, and copying it to udp_port_cfg in vxlan_create_sock.
> 
> Also change vxlan_find_sock to search the socket based on the listening address.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 53 ++++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index ba59e92ab941..9a797147beb7 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -72,22 +72,34 @@ static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
>  }
>  
>  /* Find VXLAN socket based on network namespace, address family, UDP port,
> - * enabled unshareable flags and socket device binding (see l3mdev with
> - * non-default VRF).
> + * bounded address, enabled unshareable flags and socket device binding
> + * (see l3mdev with non-default VRF).
>   */
>  static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
> -					  __be16 port, u32 flags, int ifindex)
> +					  __be16 port, u32 flags, int ifindex, union vxlan_addr *saddr)

nit: Where it can trivially be achieved, please limit lines to 80 columns
     wide as is still preferred in Networking code.

     Flagged by ./scripts/checkpatch.pl --max-line-length=80

>  {
>  	struct vxlan_sock *vs;
>  
>  	flags &= VXLAN_F_RCV_FLAGS;
>  
>  	hlist_for_each_entry_rcu(vs, vs_head(net, port), hlist) {
> -		if (inet_sk(vs->sock->sk)->inet_sport == port &&
> +		struct sock *sk = vs->sock->sk;
> +		struct inet_sock *inet = inet_sk(sk);
> +
> +		if (inet->inet_sport == port &&
>  		    vxlan_get_sk_family(vs) == family &&
>  		    vs->flags == flags &&
> -		    vs->sock->sk->sk_bound_dev_if == ifindex)
> -			return vs;
> +		    vs->sock->sk->sk_bound_dev_if == ifindex) {
> +			if (family == AF_INET && inet->inet_rcv_saddr == saddr->sin.sin_addr.s_addr) {
> +				return vs;
> +			}
> +#if IS_ENABLED(CONFIG_IPV6)
> +			else if (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, &saddr->sin6.sin6_addr) == 0)

1. There is a '{' missing form the line above, so this doesn't compile
   (if IPV6 is configured).
2. Probably the '{}' can be dropped from this if / else if conditional.

> +				return vs;
> +			}
> +#endif
> +		}
> +
>  	}
>  	return NULL;
>  }

-- 
pw-bot: changes-requested

