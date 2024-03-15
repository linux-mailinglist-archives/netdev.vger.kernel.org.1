Return-Path: <netdev+bounces-80090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B767E87CF86
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EF7B21D5F
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF63A1DF;
	Fri, 15 Mar 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCZpcIxd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC81B7F8
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514532; cv=none; b=S1B2Nh8yY138AGkb5vtIO9QbXFkI4fVS7t8MeflUKII36HEZLwhTE6TJz9phcDhRPv0HHEba7b/WyX+d2GmWkLNT8RPPZ3NQttebmzfaxfzvTgwSCkp1EoZdLdvPFObxnS1QxF9UoONbO+rQ7Y0UEi1YTVaGKufTUE2LeZnu8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514532; c=relaxed/simple;
	bh=eaw3u0zqeEl3ibqFAztz2vWzh5inPnHS8GuPUsbaGH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvb+D2oc38b7wndvNhNxzA4IIQ88W1cVGQnSTx/1UKcCH0cUIUGELSHDMmMn814zrAnQOuazz63oZktUX4KXaPd/ySVZTfLjKCmP3Gy/kqOluQfbJ5xxspDV2pRruqa1Kiomxo/aBvMzqSZqkQzYQ8hPf3qDWiBfvmolWXmF/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCZpcIxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D38C433F1;
	Fri, 15 Mar 2024 14:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710514532;
	bh=eaw3u0zqeEl3ibqFAztz2vWzh5inPnHS8GuPUsbaGH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eCZpcIxdK28jontd3syizBY1HNFIbO3I+6sXcmI0CNddtr1nenJjk/NWCf1wEquNq
	 BP6P/gkrfslpwp2DK8uTO6oAQtjFPiYHnqY2PjNqTNI/kdbeHAZ6PZfuekCIjDqJXs
	 iuRnkxsAQRnXmW/8egpVT+L+syCdV/47GEdQyKU4peI9FUncKPeqXTYaY3yp0VVL0K
	 InJANZsN53FC0Y2tJ+Y/Mv05p1AK54N4XE7gwSUV43rXiqLzjYPqI6MZ2v4E3AIEEm
	 X7q2ZAbkKDwnvg7UsggkDDdOLFvvJqO8C875he5zYKUP07ChPY0grsZqKinPoO0wsM
	 +Gf/m6vd38asQ==
Message-ID: <dfe28f4e-183b-4df1-a8e9-2f7fe6439fe0@kernel.org>
Date: Fri, 15 Mar 2024 08:55:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv4: raw: Fix sending packets from raw sockets
 via IPsec tunnels
Content-Language: en-US
To: Tobias Brunner <tobias@strongswan.org>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <c5d9a947-eb19-4164-ac99-468ea814ce20@strongswan.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <c5d9a947-eb19-4164-ac99-468ea814ce20@strongswan.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 8:35 AM, Tobias Brunner wrote:
> Since the referenced commit, the xfrm_inner_extract_output() function
> uses the protocol field to determine the address family.  So not setting
> it for IPv4 raw sockets meant that such packets couldn't be tunneled via
> IPsec anymore.
> 
> IPv6 raw sockets are not affected as they already set the protocol since
> 9c9c9ad5fae7 ("ipv6: set skb->protocol on tcp, raw and ip6_append_data
> genereated skbs").
> 
> Fixes: f4796398f21b ("xfrm: Remove inner/outer modes from output path")
> Signed-off-by: Tobias Brunner <tobias@strongswan.org>
> ---
>  net/ipv4/raw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 42ac434cfcfa..322e389021c3 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -357,6 +357,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
>  		goto error;
>  	skb_reserve(skb, hlen);
>  
> +	skb->protocol = htons(ETH_P_IP);
>  	skb->priority = READ_ONCE(sk->sk_priority);
>  	skb->mark = sockc->mark;
>  	skb->tstamp = sockc->transmit_time;


Reviewed-by: David Ahern <dsahern@kernel.org>


