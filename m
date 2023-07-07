Return-Path: <netdev+bounces-16147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B609674B8BE
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 23:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8951C210D6
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830517ABC;
	Fri,  7 Jul 2023 21:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A5D171C7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 21:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0304C433C7;
	Fri,  7 Jul 2023 21:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688766026;
	bh=UE8yy9+73KRh9TGbYeib3LOt6Js9O/ptX9xjt1QIl6A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=UvRvZvtW4CtpZGZ346KE75kMolCnJXeyJApIijyoycXgLHMPEX/VJyDVcKWELJlEV
	 FPWVXWXh9qWVarP+4FbXpssAqKCQg7nNPCBFs7ad+8yh3C6LnqrjrmIgkueFEqPWMl
	 2y4ON101XYy0FN3dKmNV4N0sHTdQLgXWlXDwaGl5avPmlBlFCVnDVB7uZaJgs+L6XS
	 DXKvdU7y645uNPyl+saDpzovCp/w/uDuhzXyk88nL401sb68ibSX7w5U63uNgwqPx+
	 MnpkEOnBw6OPWExe7pxSvwwoZEYziCEd3G0peBo4hGT6tYHsXpX8YE1RrnFcRrpdXZ
	 G74/lKMcoTTYw==
Message-ID: <1340947f-2f66-e93d-9dab-055e40e1f9f9@kernel.org>
Date: Fri, 7 Jul 2023 15:40:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] net: gro: fix misuse of CB in udp socket lookup
Content-Language: en-US
To: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, tom@herbertland.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com
References: <20230707121650.GA17677@debian> <20230707122627.GA17845@debian>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230707122627.GA17845@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/23 6:26 AM, Richard Gobert wrote:
> This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
> `udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch the
> device from CB. The fix changes it to fetch the device from `skb->dev`.
> l3mdev case requires special attention since it has a master and a slave
> device.

put your cover letter details in here; no need for a cover letter for a
single patch.

> 
> Fixes: a6024562ffd7 ("udp: Add GRO functions to UDP socket")
> Reported-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/udp.h      |  2 ++
>  net/ipv4/udp.c         | 21 +++++++++++++++++++--
>  net/ipv4/udp_offload.c |  7 +++++--
>  net/ipv6/udp.c         | 21 +++++++++++++++++++--
>  net/ipv6/udp_offload.c |  7 +++++--
>  5 files changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 4d13424f8f72..48af1479882f 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -299,6 +299,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
>  int udp_lib_setsockopt(struct sock *sk, int level, int optname,
>  		       sockptr_t optval, unsigned int optlen,
>  		       int (*push_pending_frames)(struct sock *));
> +void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
>  struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
>  			     __be32 daddr, __be16 dport, int dif);
>  struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
> @@ -310,6 +311,7 @@ struct sock *udp6_lib_lookup(struct net *net,
>  			     const struct in6_addr *saddr, __be16 sport,
>  			     const struct in6_addr *daddr, __be16 dport,
>  			     int dif);
> +void udp6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
>  struct sock *__udp6_lib_lookup(struct net *net,
>  			       const struct in6_addr *saddr, __be16 sport,
>  			       const struct in6_addr *daddr, __be16 dport,
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 42a96b3547c9..0581ab184afd 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -550,15 +550,32 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
>  				 inet_sdif(skb), udptable, skb);
>  }
> 
> +void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
> +{
> +	*iif = inet_iif(skb) || skb->dev->ifindex;
> +	*sdif = 0;
> +
> +#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
> +	if (netif_is_l3_slave(skb->dev)) {
> +		struct net_device *master = netdev_master_upper_dev_get_rcu(skb->dev);
> +		*sdif = *iif;
> +		*iif = master ? master->ifindex : 0;
> +	}
> +#endif
> +}

there are existing iif and sdif lookup functions. I believe this gro
path needs a different version, but it should have a comment of when it
can be used vs the existing ones. Also, it is small enough to be an
inline like the existing ones. e.g., see inet_sdif


