Return-Path: <netdev+bounces-137592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147E9A7163
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFF11C21F4C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44961EBFFD;
	Mon, 21 Oct 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIRA2q3E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA41A1EABC4
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533097; cv=none; b=UgcqnbErPab+1aNJyrJkXJ+y8+VHoIsAnbv6WBB6iTufeWUuj8kIjSyaTHnqV0tPVvAQ+fZpVOdTUnjWqVt9hBzYgY1TFcUThae52IY2en/My52X2RVG8gbgX09VzhRnXD51NTNIafNYjR6wA1Wh6I1u/pRvRT0/VarWSZSqx1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533097; c=relaxed/simple;
	bh=JO8od5lIO5yqBO7zdQQTueovoLevF6ARnW7R0bscbE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBa9XPeAkbkS6g8MpHveruHQSrFQ80SvKUGNQRRzfotP3ZkAS3Sd4WpdmljINWmfa693Ix6GHsfK3Qt8FDRGLwyfq9HR4JCMU+8d/JT/2WhrTGtaWQgDlfBp5EwwOmdIUYW2Gy18MJhTS4DkhXB0w6zzHKNOVaJYWmMdfRWHOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIRA2q3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE85C4CEC7;
	Mon, 21 Oct 2024 17:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533097;
	bh=JO8od5lIO5yqBO7zdQQTueovoLevF6ARnW7R0bscbE4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qIRA2q3Eu/Ggwn1Mo6pt5Vai6VEmDJ4Golti45tQIZPsBgEPO7Fv/VbQmqmERd60z
	 978WMTNeMyT94FsEgkmRKQQzf5/31BL4iI8lFBIWc0ms30+dhc/naZq982D0Hy+h7a
	 jmz1iOIQGQY88eJ757vOg51X21DkwcLrDRhz7zT+EY5XK2dRwRmlDkyQ9xNKy2yn7V
	 UA0uQhlzLGj4CJ9gEOD0c1K61mLZtClhsy7GfmAeTJGlxP7FiXxpb5k19kD5pLQdGn
	 gnsnIgtFGO2P8fmce8hW4Bp1NAT+FKqeVf+CASwMR8pjCOkbRgJjIsBgF24WgpUhT2
	 lATx9m6e11u3A==
Message-ID: <7cc508a4-24d1-428c-bf63-ae5dbcc305bc@kernel.org>
Date: Mon, 21 Oct 2024 11:51:36 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] tcp: add more warn of socket in
 tcp_send_loss_probe()
Content-Language: en-US
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241021155245.83122-1-kerneljasonxing@gmail.com>
 <20241021155245.83122-3-kerneljasonxing@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241021155245.83122-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 9:52 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Add two fields to print in the helper which here covers tcp_send_loss_probe().
> 
> Link: https://lore.kernel.org/all/5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com/
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> --
> v2
> Link:https://lore.kernel.org/all/CAL+tcoAr7RHhaZGV12wYDcPPPaubAqdxMCmy7Jujtr8b3+bY=w@mail.gmail.com/
> 1. use "" instead of NULL in tcp_send_loss_probe()
> ---
>  include/net/tcp.h     | 4 +++-
>  net/ipv4/tcp_output.c | 4 +---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 8b8d94bb1746..78158169e944 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2433,12 +2433,14 @@ void tcp_plb_update_state_upon_rto(struct sock *sk, struct tcp_plb_state *plb);
>  static inline void tcp_warn_once(const struct sock *sk, bool cond, const char *str)
>  {
>  	WARN_ONCE(cond,
> -		  "%sout:%u sacked:%u lost:%u retrans:%u tlp_high_seq:%u sk_state:%u ca_state:%u advmss:%u mss_cache:%u pmtu:%u\n",
> +		  "%scwn:%u out:%u sacked:%u lost:%u retrans:%u tlp_high_seq:%u sk_state:%u ca_state:%u mss:%u advmss:%u mss_cache:%u pmtu:%u\n",
>  		  str,
> +		  tcp_snd_cwnd(tcp_sk(sk)),
>  		  tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
>  		  tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
>  		  tcp_sk(sk)->tlp_high_seq, sk->sk_state,
>  		  inet_csk(sk)->icsk_ca_state,
> +		  tcp_current_mss((struct sock *)sk),
>  		  tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
>  		  inet_csk(sk)->icsk_pmtu_cookie);
>  }
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 054244ce5117..36562b5fe290 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2954,9 +2954,7 @@ void tcp_send_loss_probe(struct sock *sk)
>  	}
>  	skb = skb_rb_last(&sk->tcp_rtx_queue);
>  	if (unlikely(!skb)) {
> -		WARN_ONCE(tp->packets_out,
> -			  "invalid inflight: %u state %u cwnd %u mss %d\n",
> -			  tp->packets_out, sk->sk_state, tcp_snd_cwnd(tp), mss);
> +		tcp_warn_once(sk, tp->packets_out, "");

you dropped the "invalid inflight: " string for context.

>  		smp_store_release(&inet_csk(sk)->icsk_pending, 0);
>  		return;
>  	}

Besides the nit:
Reviewed-by: David Ahern <dsahern@kernel.org>


