Return-Path: <netdev+bounces-175108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED53EA63562
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 12:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F197C3AC761
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 11:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137DA1922DC;
	Sun, 16 Mar 2025 11:32:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.servers.dxld.at (mail.servers.dxld.at [168.119.78.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4446FC5;
	Sun, 16 Mar 2025 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.78.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742124732; cv=none; b=OCXpezHoGXfuhWY/Ksnee5ISVwdhS1fZ6r5rXsAbb873umRNdfk2IVfMpIHdyHmUaS7uXfSvTc2zswOsuJ0/FCVABEOkijp0RINRKAixIYgxPX/qp90RJV83DkYt6uG7wrwzlXgTVi8DjyMNzlvUNM4+l0+113DUWg+TuQ2EnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742124732; c=relaxed/simple;
	bh=FCYHIP4JKxQLzH0PfhX+Q/h0X8BqcIVf4bvkz4S+1gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKgCQXilOWm2nrLOiGYBEbfX3sbFdrF08oLx+H9r1IpGsSK4e+N91t+39fTiVP24xTsE7MXN2Yi5mFRVx/IfLpSt47CcOE8cd9aAVhe1RIROUQerBD6uLut+A4W1bJ9eYvAZs6nJ2+jHl1SxXezD5XZwv3+CgttGDY6YtObJTtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=darkboxed.org; spf=pass smtp.mailfrom=darkboxed.org; arc=none smtp.client-ip=168.119.78.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=darkboxed.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkboxed.org
Received: mail.servers.dxld.at;
	Sun, 16 Mar 2025 12:15:20 +0100
Date: Sun, 16 Mar 2025 12:15:16 +0100
From: Daniel =?utf-8?Q?Gr=C3=B6ber?= <dxld@darkboxed.org>
To: greearb@candelatech.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	dsahern@kernel.org, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: wireguard: Allow binding to specific ifindex
Message-ID: <20250316111516.4vxnot4osduc7oeh@House.clients.dxld.at>
References: <20241203193939.1953303-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203193939.1953303-1-greearb@candelatech.com>

Hi Ben,

I sent a more general patch adding essentially same feature quite a while
ago (Nov 2023) "wireguard: Add netlink attrs for binding to address and
netdev"
https://lore.kernel.org/netdev/20240219114334.3057169-1-dxld@darkboxed.org/T/

Which also came with ready-to-go wireguard-tools userspace support.

Unfortunately I never got any real feedback on it.

I managed to catch Jason at FOSDEM this year at least and he seems to not
be convinced either address or inteface binding are useful or necessary
features for wg.

The 1) "scaling" argument in the v3 patch was shot down due to Linux not
being scalable in the number of interfaces due to linked lists anyway,
which is fair if true. I added that argument in v3 to make the patch more
apealing, previously I had some handwaving about multihoming
https://lists.zx2c4.com/pipermail/wireguard/2023-November/008256.html :-)

I still think there's plenty of operational reasons to want to do this
outside of that consideration and I just seem to be failing to communicate
them in a way that appeals to Jason's design beauty aesthetic.

Perhaps you could explain your use-case in more depth to make the technical
argument stronger than what I can muster? :-)

Quickly comparing your code with mine I see you set fl.flowi*_oif in
addition to bind_ifindex, did you find that necessary for packets to be
emited on the right device?

Thanks,
--Daniel

PS: I'm aware the v3 patch proably still has a subtle uninitialized memory
problem, just haven't had the motivation to work on it due to lack of
feedback.

PPS: Sorry for the late response I don't read netdev regularly and
apparently Jason's wireguard list has been more broken than I've been aware
of.  I've got some sieve hacks to get wireguard mail from netdev now.

On Tue, Dec 03, 2024 at 11:39:39AM -0800, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Which allows us to bind to VRF.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
> 
> v2:  Fix bad use of comma, semicolon now used instead.
> 
>  drivers/net/wireguard/device.h  |  1 +
>  drivers/net/wireguard/netlink.c | 12 +++++++++++-
>  drivers/net/wireguard/socket.c  |  8 +++++++-
>  include/uapi/linux/wireguard.h  |  3 +++
>  4 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireguard/device.h b/drivers/net/wireguard/device.h
> index 43c7cebbf50b..9698d9203915 100644
> --- a/drivers/net/wireguard/device.h
> +++ b/drivers/net/wireguard/device.h
> @@ -53,6 +53,7 @@ struct wg_device {
>  	atomic_t handshake_queue_len;
>  	unsigned int num_peers, device_update_gen;
>  	u32 fwmark;
> +	int lowerdev; /* ifindex of lower level device to bind UDP transport */
>  	u16 incoming_port;
>  };
>  
> diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
> index f7055180ba4a..5de3d59a17b0 100644
> --- a/drivers/net/wireguard/netlink.c
> +++ b/drivers/net/wireguard/netlink.c
> @@ -27,7 +27,8 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
>  	[WGDEVICE_A_FLAGS]		= { .type = NLA_U32 },
>  	[WGDEVICE_A_LISTEN_PORT]	= { .type = NLA_U16 },
>  	[WGDEVICE_A_FWMARK]		= { .type = NLA_U32 },
> -	[WGDEVICE_A_PEERS]		= { .type = NLA_NESTED }
> +	[WGDEVICE_A_PEERS]		= { .type = NLA_NESTED },
> +	[WGDEVICE_A_LOWERDEV]		= { .type = NLA_U32 },
>  };
>  
>  static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
> @@ -232,6 +233,7 @@ static int wg_get_device_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		if (nla_put_u16(skb, WGDEVICE_A_LISTEN_PORT,
>  				wg->incoming_port) ||
>  		    nla_put_u32(skb, WGDEVICE_A_FWMARK, wg->fwmark) ||
> +		    nla_put_u32(skb, WGDEVICE_A_LOWERDEV, wg->lowerdev) ||
>  		    nla_put_u32(skb, WGDEVICE_A_IFINDEX, wg->dev->ifindex) ||
>  		    nla_put_string(skb, WGDEVICE_A_IFNAME, wg->dev->name))
>  			goto out;
> @@ -530,6 +532,14 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
>  			wg_socket_clear_peer_endpoint_src(peer);
>  	}
>  
> +	if (info->attrs[WGDEVICE_A_LOWERDEV]) {
> +		struct wg_peer *peer;
> +
> +		wg->lowerdev = nla_get_u32(info->attrs[WGDEVICE_A_LOWERDEV]);
> +		list_for_each_entry(peer, &wg->peer_list, peer_list)
> +			wg_socket_clear_peer_endpoint_src(peer);
> +	}
> +
>  	if (info->attrs[WGDEVICE_A_LISTEN_PORT]) {
>  		ret = set_port(wg,
>  			nla_get_u16(info->attrs[WGDEVICE_A_LISTEN_PORT]));
> diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
> index 0414d7a6ce74..7cef4b27f6ba 100644
> --- a/drivers/net/wireguard/socket.c
> +++ b/drivers/net/wireguard/socket.c
> @@ -25,7 +25,8 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
>  		.daddr = endpoint->addr4.sin_addr.s_addr,
>  		.fl4_dport = endpoint->addr4.sin_port,
>  		.flowi4_mark = wg->fwmark,
> -		.flowi4_proto = IPPROTO_UDP
> +		.flowi4_proto = IPPROTO_UDP,
> +		.flowi4_oif = wg->lowerdev,
>  	};
>  	struct rtable *rt = NULL;
>  	struct sock *sock;
> @@ -111,6 +112,9 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
>  	struct sock *sock;
>  	int ret = 0;
>  
> +	if (wg->lowerdev)
> +		fl.flowi6_oif = wg->lowerdev;
> +
>  	skb_mark_not_on_list(skb);
>  	skb->dev = wg->dev;
>  	skb->mark = wg->fwmark;
> @@ -360,6 +364,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
>  		.family = AF_INET,
>  		.local_ip.s_addr = htonl(INADDR_ANY),
>  		.local_udp_port = htons(port),
> +		.bind_ifindex = wg->lowerdev,
>  		.use_udp_checksums = true
>  	};
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -369,6 +374,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
>  		.local_ip6 = IN6ADDR_ANY_INIT,
>  		.use_udp6_tx_checksums = true,
>  		.use_udp6_rx_checksums = true,
> +		.bind_ifindex = wg->lowerdev,
>  		.ipv6_v6only = true
>  	};
>  #endif
> diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
> index ae88be14c947..f3784885389a 100644
> --- a/include/uapi/linux/wireguard.h
> +++ b/include/uapi/linux/wireguard.h
> @@ -29,6 +29,7 @@
>   *    WGDEVICE_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
>   *    WGDEVICE_A_LISTEN_PORT: NLA_U16
>   *    WGDEVICE_A_FWMARK: NLA_U32
> + *    WGDEVICE_A_LOWERDEV: NLA_U32
>   *    WGDEVICE_A_PEERS: NLA_NESTED
>   *        0: NLA_NESTED
>   *            WGPEER_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
> @@ -83,6 +84,7 @@
>   *    WGDEVICE_A_PRIVATE_KEY: len WG_KEY_LEN, all zeros to remove
>   *    WGDEVICE_A_LISTEN_PORT: NLA_U16, 0 to choose randomly
>   *    WGDEVICE_A_FWMARK: NLA_U32, 0 to disable
> + *    WGDEVICE_A_LOWERDEV: NLA_U32, ifindex to bind lower transport, 0 to disable
>   *    WGDEVICE_A_PEERS: NLA_NESTED
>   *        0: NLA_NESTED
>   *            WGPEER_A_PUBLIC_KEY: len WG_KEY_LEN
> @@ -157,6 +159,7 @@ enum wgdevice_attribute {
>  	WGDEVICE_A_LISTEN_PORT,
>  	WGDEVICE_A_FWMARK,
>  	WGDEVICE_A_PEERS,
> +	WGDEVICE_A_LOWERDEV,
>  	__WGDEVICE_A_LAST
>  };
>  #define WGDEVICE_A_MAX (__WGDEVICE_A_LAST - 1)
> -- 
> 2.42.0
> 
> 

