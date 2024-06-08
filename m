Return-Path: <netdev+bounces-102023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFFA9011AD
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 15:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04480B213E7
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6649178384;
	Sat,  8 Jun 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqe3wi6Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B329CF7
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717853148; cv=none; b=Janmd7oXTjLWjd6kODyTDYAfc0bmkQtKI453wHTo9RUi7qDWdO1Vu3asAcjcsjX1ZNc0NztYfjDdd7/CSS8dxtHR1O7mgvwi+MBHyr3fN6o+EuLdXkc6RBfhvrTHtCarCSgKrMPc484uWV+BgnvAEDpHjspb0FF6ljg/NqzXB8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717853148; c=relaxed/simple;
	bh=+oNKNScFLvU6wjivXynKB7s9P3Go8tlTF0E9xxnhnvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAjP5+DljRmDrfnktaKRTbe03lnKGHoNzc5uegI2sxpSqM87SQCJuooZymnnCpNevPUhjzRZK0dxCbUQobHNkR1/xUkHZXyRPpdk8MY+dwaO8lB/tviO0v/VUTnd+xAJUDtx7Ql4naq9EbaulvfrF8Ihn7TzF1q9zhxbJwc/PQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqe3wi6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B28C2BD11;
	Sat,  8 Jun 2024 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717853148;
	bh=+oNKNScFLvU6wjivXynKB7s9P3Go8tlTF0E9xxnhnvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gqe3wi6ZS9lBatrI/81ns0eBmzoNyvNc5vqcjJk5EiGcaK325xbD6MDPw91/Lp7qk
	 dGRLZ541I56bbmONFRxSeG8JYsapYuVDRg7VMFWl77rz5icQrgBaXljK91MtybLZs3
	 OB71YVurSq32VIrIIhKq+1JajkdaMK+EKsHwKOP9McuuN7ukh+5B1aRN5a1E/KJBNm
	 crO9/3HyzqaI/9DPH9U/XwXghz/C/iIvmzlIgo+XhJ330VDdPIlROD65BSnWSzaS1C
	 8Bh5HJzSmcOg81APstAw835buAQChht6Rk2eCmM5kkMa37zwI7g23jJmf1cF3Qo3Tl
	 kxQ+HfmSaOP7g==
Date: Sat, 8 Jun 2024 14:25:44 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
	eric.dumazet@gmail.com, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net] tcp: fix race in tcp_v6_syn_recv_sock()
Message-ID: <20240608132544.GF27689@kernel.org>
References: <20240606154652.360331-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606154652.360331-1-edumazet@google.com>

+ David Ahern

On Thu, Jun 06, 2024 at 03:46:51PM +0000, Eric Dumazet wrote:
> tcp_v6_syn_recv_sock() calls ip6_dst_store() before
> inet_sk(newsk)->pinet6 has been set up.
> 
> This means ip6_dst_store() writes over the parent (listener)
> np->dst_cookie.
> 
> This is racy because multiple threads could share the same
> parent and their final np->dst_cookie could be wrong.
> 
> Move ip6_dst_store() call after inet_sk(newsk)->pinet6
> has been changed and after the copy of parent ipv6_pinfo.
> 
> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/ipv6/tcp_ipv6.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 8c577b651bfcd2f94b45e339ed4a2b47e93ff17a..729faf8bd366ad25d093a4ae931fb46ebd45b79c 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1439,7 +1439,6 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
>  	 */
>  
>  	newsk->sk_gso_type = SKB_GSO_TCPV6;
> -	ip6_dst_store(newsk, dst, NULL, NULL);
>  	inet6_sk_rx_dst_set(newsk, skb);
>  
>  	inet_sk(newsk)->pinet6 = tcp_inet6_sk(newsk);
> @@ -1450,6 +1449,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
>  
>  	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
>  
> +	ip6_dst_store(newsk, dst, NULL, NULL);
> +
>  	newsk->sk_v6_daddr = ireq->ir_v6_rmt_addr;
>  	newnp->saddr = ireq->ir_v6_loc_addr;
>  	newsk->sk_v6_rcv_saddr = ireq->ir_v6_loc_addr;
> -- 
> 2.45.1.467.gbab1589fc0-goog
> 
> 

