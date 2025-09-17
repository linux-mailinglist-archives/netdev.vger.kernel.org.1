Return-Path: <netdev+bounces-224088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2170AB8099E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB69C188DAE5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E95E332A44;
	Wed, 17 Sep 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHfSPTL0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896D13B2A4
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123257; cv=none; b=f9lY5aWCX5Jln/Ty2Caf1KIbO643N1uATopbP4AmmXnh1L/MWIkvqUDs/C73udcVfvO/wEkG6cz6isuSXWYWZeDes9G/UPJhpRIYWNqeRrbnM3LCaw+lTZVcfritqKpOPl3CTE2qbPXKl1IHggshRqXv2FPj1VU9FAD1N8ldhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123257; c=relaxed/simple;
	bh=SMx2qTUw6uLyXwy8AJ7OaWQeHuSZlz8MEJLhXcTonuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+tBkpNWLIMQohvGmH9ZejKubA42gtejOw1IUGPgGid4IcHayos047JGJvN73N8+MAhC7FBPKkeBJ8yYkxFgaFmRxcFg+A43eLuwLq8RvEpqeAI8/Y0VSptVTn/29uRsFZF7MMaeff1qa1yEO1osTfHt9x5Ez6zkw9dL/Dxd20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHfSPTL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69C4C4CEE7;
	Wed, 17 Sep 2025 15:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758123257;
	bh=SMx2qTUw6uLyXwy8AJ7OaWQeHuSZlz8MEJLhXcTonuw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AHfSPTL0pk7e4KAM/4+W1XIBMcJbxCFIfhQgmf3UGwme1MUKKI8+r7TukCMIWHFDz
	 mtoAqHphqfeLfLBWhn+pNGaHlDSaBIhGCrwoUrkiKhPYfC+ymojS9Cgjq73UtxnB5t
	 WVXVjNcM1pcqewRffaQw/bLxoiQl+PUG5fm17s85f7xZCKtlyQM2g7gkjisU49nIKs
	 ldAgCuWfQuzvKmM7652khbve0kTCSWpzDPkg250NyvaqmvNCMqUd26NbVp25/iRbqq
	 X83Rfj6MYK52mR0UCioaxykN3++HXpP+4gZN8CR4Tvk+ifwq24NX1JuAR0x/0FZ3WA
	 5EO7xCLNBM1Tw==
Message-ID: <27179899-2e67-474e-bb93-82f52c793028@kernel.org>
Date: Wed, 17 Sep 2025 09:34:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/10] ipv6: np->rxpmtu race annotation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250916160951.541279-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 10:09 AM, Eric Dumazet wrote:
> Add READ_ONCE() annotations because np->rxpmtu can be changed
> while udpv6_recvmsg() and rawv6_recvmsg() read it.
> 
> Since this is a very rarely used feature, and that udpv6_recvmsg()
> and rawv6_recvmsg() read np->rxopt anyway, change the test order
> so that np->rxpmtu does not need to be in a hot cache line.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/raw.c | 2 +-
>  net/ipv6/udp.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index 4ae07a67b4d4f1be6730c252d246e79ff9c73d4c..e369f54844dd9456a819db77435eaef33d162932 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -445,7 +445,7 @@ static int rawv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	if (flags & MSG_ERRQUEUE)
>  		return ipv6_recv_error(sk, msg, len, addr_len);
>  
> -	if (np->rxpmtu && np->rxopt.bits.rxpmtu)
> +	if (np->rxopt.bits.rxpmtu && READ_ONCE(np->rxpmtu))
>  		return ipv6_recv_rxpmtu(sk, msg, len, addr_len);
>  
>  	skb = skb_recv_datagram(sk, flags, &err);
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index b70369f3cd3223cfde07556b1cb1636e8bc78d49..e87d0ef861f88af3ff7bf9dd5045c4d4601036e3 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -479,7 +479,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	if (flags & MSG_ERRQUEUE)
>  		return ipv6_recv_error(sk, msg, len, addr_len);
>  
> -	if (np->rxpmtu && np->rxopt.bits.rxpmtu)
> +	if (np->rxopt.bits.rxpmtu && READ_ONCE(np->rxpmtu))
>  		return ipv6_recv_rxpmtu(sk, msg, len, addr_len);
>  
>  try_again:

if that pattern is needed again, it should be a helper ...

Reviewed-by: David Ahern <dsahern@kernel.org>


