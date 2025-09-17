Return-Path: <netdev+bounces-223949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50226B7E6BE
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D282D17E7EA
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7D035CED8;
	Wed, 17 Sep 2025 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg6bK7tD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC6221FD4
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104239; cv=none; b=kJgTjhAZvJP1z9w424SlSLiMZIpfqfxuK8BcvBJXfAP8b9B2Hu7spTIlw8wMVZ+IUfzq8JsMsYXkOgj/WwZaoGMLKmlu9IH8xEkZPOOZ0WUtJ9XH+r47kkzl+v+cSI7poSOqT2dBqj8/k3PZde345gxPC7YlzIuMqxhEWUGK/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104239; c=relaxed/simple;
	bh=vCVSJobDeRU1Xiuziz61PIr5mpPfkqXujgbelfzUyPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fd1KLaG0PWhPqj+LoLQKFt6dUi7enecKyUiDcITUbuJrYw6XwRdd6te/vmWiPTpSnQrWvgMl58uX9cYRPASYajwLianOROkamg9CHfYEcSYmdz56d3w+g69dwu5ZXkY1lPRoSWRsghP7idXNQOyyGrIXY4ce+Ij8jdfaTaR4YWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg6bK7tD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A51C4CEF0;
	Wed, 17 Sep 2025 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104239;
	bh=vCVSJobDeRU1Xiuziz61PIr5mpPfkqXujgbelfzUyPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kg6bK7tDtSy/aB1nmZS5XLjenWbHkWxwgvfPAv1oyL1ywpCSpVtvzoi3nfPHdFRDQ
	 QA10k7X2DwmEgQ3JgLB6xmQavW4ziubSutWSgl0k4vsIFlk7uK2abrPCkfXqTRdW+3
	 N7OY+3X12DJH5+rhlFzCPk0AnjRK1uVJMTX2696pyK7ydj/rmpPAt/jK0ToC1wD6Yx
	 ZqLtMedBrLtCqe1GRgXYFJ10cQC2zFs8P6T4l0s8Ndkj8cqitnzwpSoaQo3s/y+7/B
	 39tRrRkRGiZzl3LrZxZ880iru/MM3/zZMWkhnQ5eOJS3KnPuCHqlgyhgHBILl2/ogM
	 xRgPBLY8eYDJA==
Message-ID: <4209a283-8822-47bd-95b7-87e96d9b7ea3@kernel.org>
Date: Wed, 17 Sep 2025 12:17:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 net-next 7/7] mptcp: Use __sk_dst_get() and
 dst_dev_rcu() in mptcp_active_enable().
Content-Language: en-GB, fr-BE
To: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>
References: <20250916214758.650211-1-kuniyu@google.com>
 <20250916214758.650211-8-kuniyu@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250916214758.650211-8-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

On 16/09/2025 23:47, Kuniyuki Iwashima wrote:
> mptcp_active_enable() is called from subflow_finish_connect(),
> which is icsk->icsk_af_ops->sk_rx_dst_set() and it's not always
> under RCU.
> 
> Using sk_dst_get(sk)->dev could trigger UAF.
> 
> Let's use __sk_dst_get() and dst_dev_rcu().
> 
> Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Thank you for the fix! It looks good to me!

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

> ---
> Cc: Matthieu Baerts <matttbe@kernel.org>
> Cc: Mat Martineau <martineau@kernel.org>
> Cc: Geliang Tang <geliang@kernel.org>
> ---
>  net/mptcp/ctrl.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index c0e516872b4b..e8ffa62ec183 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -501,12 +501,15 @@ void mptcp_active_enable(struct sock *sk)
>  	struct mptcp_pernet *pernet = mptcp_get_pernet(sock_net(sk));
>  
>  	if (atomic_read(&pernet->active_disable_times)) {
> -		struct dst_entry *dst = sk_dst_get(sk);
> +		struct net_device *dev;
> +		struct dst_entry *dst;
>  
> -		if (dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK))

Mmh, I don't know why but the condition was already wrong before your
patch. It should be the opposite: we should reset if we manage to open
an MPTCP connection on a non-loopback interface...

I don't want to block this series for this non-directly related issue.
If you prefer, I can send a fix when this series will be applied. I
guess it would be easier to send it to net-next to avoid conflicts,
which should be fine if we are close to the merge windows.

> +		rcu_read_lock();
> +		dst = __sk_dst_get(sk);
> +		dev = dst ? dst_dev_rcu(dst) : NULL;
> +		if (dev && (dev->flags & IFF_LOOPBACK))
>  			atomic_set(&pernet->active_disable_times, 0);
> -
> -		dst_release(dst);
> +		rcu_read_unlock();
>  	}
>  }
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


