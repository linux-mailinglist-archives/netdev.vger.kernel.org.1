Return-Path: <netdev+bounces-35942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896537AC0FC
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 13:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B5E571C208A3
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 11:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AF010A3C;
	Sat, 23 Sep 2023 11:09:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2527615E86
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 11:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D867C433CB;
	Sat, 23 Sep 2023 11:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695467361;
	bh=e37JXLkjckwyEOLM1hEeXYZkcwLtZZL+05FSb2iFGk4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qOnK59hSWOIsYO8C4AiRJH+dIt+83j/Gw9TwLEwr4gFwbaDx6ml2OVI6sSS9zdgE2
	 e8Q+CrIwPpQl5kkbWA814ja5AFjrmmQXPWXjm+YrtMi25RirmBIbsnf6UZdfXOE5KD
	 iYbKL0mVTd3ZAAyAUejRXOn5guf4lF6ESe6QA8kFLPBFkE0sVdm15oUX8cerEnpS+R
	 E4vJLTkb9FWTwdtdJHxu/ZJ6WgW+SWRT8wG8v0ufexObHQyaNvdL43AqqNyTmQXult
	 IfPAdLMyw3L98Fq3+LaJ5TWdR5CFTQ43QlxSTbGUlJCJQD3qG3R/370PK6sZViF7KU
	 omaNPSuM05S0Q==
Message-ID: <664f9e63-ec6b-835f-874f-afbae8209b39@kernel.org>
Date: Sat, 23 Sep 2023 13:08:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 2/4] tcp_metrics: properly set tp->snd_ssthresh
 in tcp_init_metrics()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230922220356.3739090-1-edumazet@google.com>
 <20230922220356.3739090-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230922220356.3739090-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/23 4:03 PM, Eric Dumazet wrote:
> We need to set tp->snd_ssthresh to TCP_INFINITE_SSTHRESH
> in the case tcp_get_metrics() fails for some reason.
> 
> Fixes: 9ad7c049f0f7 ("tcp: RFC2988bis + taking RTT sample from 3WHS for the passive open side")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_metrics.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index 4bfa2fb27de5481ca3d1300d7e7b2c80d1577a31..0c03f564878ff0a0dbefd9b631f54697346c8fa9 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -470,6 +470,10 @@ void tcp_init_metrics(struct sock *sk)
>  	u32 val, crtt = 0; /* cached RTT scaled by 8 */
>  
>  	sk_dst_confirm(sk);
> +	/* ssthresh may have been reduced unnecessarily during.
> +	 * 3WHS. Restore it back to its initial default.
> +	 */
> +	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;

This would read easier with newlines after sk_dst_confirm and again here.
>  	if (!dst)
>  		goto reset;
>  
> @@ -489,11 +493,6 @@ void tcp_init_metrics(struct sock *sk)
>  		tp->snd_ssthresh = val;
>  		if (tp->snd_ssthresh > tp->snd_cwnd_clamp)
>  			tp->snd_ssthresh = tp->snd_cwnd_clamp;
> -	} else {
> -		/* ssthresh may have been reduced unnecessarily during.
> -		 * 3WHS. Restore it back to its initial default.
> -		 */
> -		tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
>  	}
>  	val = tcp_metric_get(tm, TCP_METRIC_REORDERING);
>  	if (val && tp->reordering != val)

Reviewed-by: David Ahern <dsahern@kernel.org>


