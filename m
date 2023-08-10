Return-Path: <netdev+bounces-26561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E852E778231
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 22:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6DC281E8E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB0320F92;
	Thu, 10 Aug 2023 20:32:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638DDEAD9
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 20:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5626C433C8;
	Thu, 10 Aug 2023 20:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691699562;
	bh=SRv5DtqNA/rqfrEgRedurzXWUixkLpPGUOBef8eHY5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XSWoDcBTjo2Qzk/UQHFM07811bQ9YjZDSOyjpF63KjT81JFOmtAs2b40P9PFsq/9e
	 NmaclxzWskIy6SSP4Y44ooedtIIErAIVD80NgeBP3BgdJWtX0XPxLCudOw0rT3ZkZN
	 rEMv86izp/U6pxiFDIRqrRPBWOibcWowozHoRRWD67CNSjjvCJeTk5UYWVnRVra7Ta
	 jBwkdwqAKL9pxdP9t8RMUBt0j5PWF/edTxV0Lguar/blb3tynbXi7dvjyE3yKuROeO
	 foJGG0/ldPti4W8h5AxdoKz7HPO07WdREH+qSSMKJWllTCiDPGfTjIhRUQtyWRcWI2
	 9OswPYHfnbSvw==
Date: Thu, 10 Aug 2023 22:32:36 +0200
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, apetlund@simula.no,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net] net: fix the RTO timer retransmitting skb every 1ms
 if linear option is enabled
Message-ID: <ZNVJZKBA698aRXmR@vergenet.net>
References: <20230810112148.2032-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810112148.2032-1-kerneljasonxing@gmail.com>

On Thu, Aug 10, 2023 at 07:21:48PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> In the real workload, I encountered an issue which could cause the RTO
> timer to retransmit the skb per 1ms with linear option enabled. The amount
> of lost-retransmitted skbs can go up to 1000+ instantly.
> 
> The root cause is that if the icsk_rto happens to be zero in the 6th round
> (which is the TCP_THIN_LINEAR_RETRIES value), then it will alway be zero

nit: alway -> always

     checkpatch.pl --codespell is your friend

> due to the changed calculation method in tcp_retransmit_timer() as follows:
> 
> icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
> 
> Above line could be converted to
> icsk->icsk_rto = min(0 << 1, TCP_RTO_MAX) = 0
> 
> Therefore, the timer expires so quickly without any doubt.
> 
> I read through the RFC 6298 and found that the RTO value can be rounded
> up to a certain value, in Linux, say TCP_RTO_MIN as default, which is
> regarded as the lower bound in this patch as suggested by Eric.
> 
> Fixes: 36e31b0af587 ("net: TCP thin linear timeouts")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp_timer.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index d45c96c7f5a4..b2b25861355c 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -599,7 +599,9 @@ void tcp_retransmit_timer(struct sock *sk)
>  	    tcp_stream_is_thin(tp) &&
>  	    icsk->icsk_retransmits <= TCP_THIN_LINEAR_RETRIES) {
>  		icsk->icsk_backoff = 0;
> -		icsk->icsk_rto = min(__tcp_set_rto(tp), TCP_RTO_MAX);
> +		icsk->icsk_rto = clamp(__tcp_set_rto(tp),
> +					    tcp_rto_min(sk),
> +					    TCP_RTO_MAX);

nit: this indentation looks a bit odd.

		icsk->icsk_rto = clamp(__tcp_set_rto(tp),
				       tcp_rto_min(sk),
				       TCP_RTO_MAX);

>  	} else if (sk->sk_state != TCP_SYN_SENT ||
>  		   icsk->icsk_backoff >
>  		   READ_ONCE(net->ipv4.sysctl_tcp_syn_linear_timeouts)) {
> -- 
> 2.37.3
> 
> 

