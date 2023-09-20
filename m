Return-Path: <netdev+bounces-35335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD377A8EC2
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 23:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5383281782
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B6B405DF;
	Wed, 20 Sep 2023 21:57:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A5F41A80
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 21:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1837CC433C7;
	Wed, 20 Sep 2023 21:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695247030;
	bh=EYv6oIG2tjpF963WNyX9VaISAMF7JD4U2TJcaa4l/e0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DMBY/t+S5fba9PhWTxMJuxlg8vGG+XnQAPRUUwfzQjpUeBZ0ET8kamPFcaAjk3bb6
	 xC2tXg0VZ8uKyIttqdWLrLeIhKuMW4RE+yPMvVREavszWivY24kEk8xkDLUPIGyQml
	 eg6E6urcwidNL/x6k0yAnxcvUin9MsqTQz/zzOdsMZsut2sKJI9LAzUyFB/Yw6tJQ2
	 tCGtv9iPy434YQSQeOLlDgKIs7Aj4hTab17AzfTGxu6ZLYfk4oKwDJ+O4JYD+T7Uyq
	 tueHytldcsm93uFBbsMeqxFy7quRRhy9KfoonnEyFfTXwFLjryYr6FUwBySMJjAOqb
	 4r8eGjy5IR+4w==
Message-ID: <89a3cbd7-fd82-d925-b916-e323033ffdbe@kernel.org>
Date: Wed, 20 Sep 2023 15:57:09 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 3/3] tcp: derive delack_max from rto_min
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>,
 Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230920172943.4135513-1-edumazet@google.com>
 <20230920172943.4135513-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230920172943.4135513-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/23 11:29 AM, Eric Dumazet wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 1fc1f879cfd6c28cd655bb8f02eff6624eec2ffc..2d1e4b5ac1ca41ff3db8dc58458d4e922a2c4999 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3977,6 +3977,20 @@ int tcp_connect(struct sock *sk)
>  }
>  EXPORT_SYMBOL(tcp_connect);
>  
> +u32 tcp_delack_max(const struct sock *sk)
> +{
> +	const struct dst_entry *dst = __sk_dst_get(sk);
> +	u32 delack_max = inet_csk(sk)->icsk_delack_max;
> +
> +	if (dst && dst_metric_locked(dst, RTAX_RTO_MIN)) {
> +		u32 rto_min = dst_metric_rtt(dst, RTAX_RTO_MIN);
> +		u32 delack_from_rto_min = max_t(int, 1, rto_min - 1);

`u32` type with max_t type set as `int`

> +
> +		delack_max = min_t(u32, delack_max, delack_from_rto_min);
> +	}
> +	return delack_max;
> +}
> +
>  /* Send out a delayed ack, the caller does the policy checking
>   * to see if we should even be here.  See tcp_input.c:tcp_ack_snd_check()
>   * for details.
> @@ -4012,7 +4026,7 @@ void tcp_send_delayed_ack(struct sock *sk)
>  		ato = min(ato, max_ato);
>  	}
>  
> -	ato = min_t(u32, ato, inet_csk(sk)->icsk_delack_max);
> +	ato = min_t(u32, ato, tcp_delack_max(sk));

and then here ato is an `int`.
>  
>  	/* Stay within the limit we were given */
>  	timeout = jiffies + ato;


