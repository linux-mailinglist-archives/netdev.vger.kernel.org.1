Return-Path: <netdev+bounces-207668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F02B0823A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 03:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2984A3F00
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9441CEAC2;
	Thu, 17 Jul 2025 01:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVbIPsGh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B58710A1F;
	Thu, 17 Jul 2025 01:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715553; cv=none; b=VYwmMbGcSC5BcIkgjGxnNtrE28ASPxuGCB1nKoT7lyV9DoqpHIIpUqyXkQdHmQoWaUdcpd6jVOKn9gi8GrkAwHegpFt4VRpLKplN1Ig/Iydk5DCAj6bgjcKct9Ddm+a6Cn+WSHcRPruyZr8eog4UesTDH/xciNbXDIHXjCcv6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715553; c=relaxed/simple;
	bh=eJW4DqvpNT9WZHN3RA/qOqnzpM5aERTsDG8vrMculSo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uuWU51yhULpNM4dYMtYxA1ThQGlI1EopM6J8+m/Ccj6k9IVgu6H+iEZnpjQftXNU8gJXbQRfYywA075W/r+ARx4DBEoDKB0yBVijDlWBhd0FxeHiHxgKF1cSoSSML2UFAaviCMn1IcKYlmZZs5rQPjA+3cWzwqsSUN6RxX0F11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVbIPsGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EACC4CEE7;
	Thu, 17 Jul 2025 01:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752715553;
	bh=eJW4DqvpNT9WZHN3RA/qOqnzpM5aERTsDG8vrMculSo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RVbIPsGhNQVhy08SIkFMzDX9E2ZHDYGh89e3uIeEPpmPlh83AIxGQNQRQb5G0KL55
	 mO0BZ5TQx07gVZg9HSW5YhW+dY2kCj1vT5frvFTbO3HBa/lWPGPdROFdhhK4N9v5kq
	 B9OO0vX52zs9SBBtPN/AhJ0QV3f5HgNAIzrMgOQvDRj6M27mOzzDuznSzB/QdvydyV
	 bRWY9Ko9VYTL2u2Cxv3YiI7OqDqF8gN/YLOJgMmGC/KXSaW63HfskGCC9MSHMeWjkd
	 UJYaH1MqafFkrbArQzhNzQTdrjXRIPlSJxnvk+YJSFO0B2B+Bz71f9InJXcraWJ62i
	 ykhdavSsQtRnw==
Message-ID: <fe04c8823b6d17fc45430f4991322f400228ba1e.camel@kernel.org>
Subject: Re: [PATCH net-next 2/4] tcp: add tcp_sock_set_maxseg
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Neal Cardwell	 <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, David Ahern	 <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 17 Jul 2025 09:25:45 +0800
In-Reply-To: <20250716-net-next-mptcp-tcp_maxseg-v1-2-548d3a5666f6@kernel.org>
References: 
	<20250716-net-next-mptcp-tcp_maxseg-v1-0-548d3a5666f6@kernel.org>
	 <20250716-net-next-mptcp-tcp_maxseg-v1-2-548d3a5666f6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Wed, 2025-07-16 at 12:28 +0200, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Add a helper tcp_sock_set_maxseg() to directly set the TCP_MAXSEG
> sockopt from kernel space.
> 
> This new helper will be used in the following patch from MPTCP.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  include/linux/tcp.h |  1 +
>  net/ipv4/tcp.c      | 23 ++++++++++++++---------
>  2 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index
> 1a5737b3753d06165bc71e257a261bcd7a0085ce..57e478bfaef20369f5dba1cff54
> 0e52c9302ebf4 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -621,6 +621,7 @@ void tcp_sock_set_nodelay(struct sock *sk);
>  void tcp_sock_set_quickack(struct sock *sk, int val);
>  int tcp_sock_set_syncnt(struct sock *sk, int val);
>  int tcp_sock_set_user_timeout(struct sock *sk, int val);
> +int tcp_sock_set_maxseg(struct sock *sk, int val);
>  
>  static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
>  {
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index
> 31149a0ac849192b46c67dd569efeeeb0a041a0b..c9cdc4e99c4f11a75471b8895b9
> c52ad8da3a7ff 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3751,6 +3751,19 @@ int tcp_set_window_clamp(struct sock *sk, int
> val)
>  	return 0;
>  }
>  
> +int tcp_sock_set_maxseg(struct sock *sk, int val)
> +{
> +	/* Values greater than interface MTU won't take effect.
> However
> +	 * at the point when this call is done we typically don't
> yet
> +	 * know which interface is going to be used
> +	 */
> +	if (val && (val < TCP_MIN_MSS || val > MAX_TCP_WINDOW))
> +		return -EINVAL;
> +
> +	tcp_sk(sk)->rx_opt.user_mss = val;
> +	return 0;
> +}
> +
>  /*
>   *	Socket option code for TCP.
>   */
> @@ -3883,15 +3896,7 @@ int do_tcp_setsockopt(struct sock *sk, int
> level, int optname,
>  
>  	switch (optname) {
>  	case TCP_MAXSEG:
> -		/* Values greater than interface MTU won't take
> effect. However
> -		 * at the point when this call is done we typically
> don't yet
> -		 * know which interface is going to be used
> -		 */
> -		if (val && (val < TCP_MIN_MSS || val >
> MAX_TCP_WINDOW)) {
> -			err = -EINVAL;
> -			break;
> -		}
> -		tp->rx_opt.user_mss = val;
> +		tcp_sock_set_maxseg(sk, val);

Sorry, I forgot to set the return value here, it should be:

		err = tcp_sock_set_maxseg(sk, val);

I'll send a squash-to patch to fix this.

Thanks,
-Geliang

>  		break;
>  
>  	case TCP_NODELAY:

