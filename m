Return-Path: <netdev+bounces-233216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A705C0EA4C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0787C4FEA16
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCC92C0269;
	Mon, 27 Oct 2025 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irefmkdV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0713B7A3
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576608; cv=none; b=PUJUzY0dWwqRIVyLXbFahTvndMSvvvNnFDlxmmcWGS3U8BNhf8nfoAQn15wSAPtxoZJpZSyxwg9LfSTw67+ErvVqds0j+uLKHXnSKJ9jldLAfRe8jyhh/Nn1Qd2ZHfuZV9PYIdZKZ21Xs9renwPCsQmEYJ/SFALw6dny5Afwz5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576608; c=relaxed/simple;
	bh=ZaYc0AXzN+1Lo1qTbRp6ynukLO72J/oqO7y+iagLfL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjjDgV97rncWRrFRi6X6h5XRRX0TxAQsHl2dpvXvNeU3NeW1Tz1oRP1S8+z0cP6dohsOhwaSvqonbroqBE5g1RZf3T/xZrgNjkwiE3wVVq8v/P+yvaE0S/f1pr4Iks33ga6Ngj0ytyeJ5G1LVhNUkI9/GDfPT9WeqSWEeQSVleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irefmkdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FBCC4CEF1;
	Mon, 27 Oct 2025 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761576606;
	bh=ZaYc0AXzN+1Lo1qTbRp6ynukLO72J/oqO7y+iagLfL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=irefmkdVXNOJ21VTG+Uqa8tsjEA7czd4DUSUKrcvgNOEHa4O3VjEtWAhy5ifcQ5UO
	 L5GED2YgEruQ6pM/Bl1jJ7p4QMaO1b5C5spXNVM/gIqmAQV7qDcg113DiUshgrrm3A
	 wfME3Zp89fMkJlsRtyRXM2ecRuAmzmJmBMYA9i7b8pqGDQXDryYx0AW0nGRhIJbUQK
	 /BcltzHfyvUqB+2k4CSAFZfl3qCk2/wK/cZdTfB/Miuwa4M9puzh5QLvn3wSBDfErn
	 6W0qoTQhC1jIaXskocMxdfC4wlQHBzmGFX81p6SaflmGtwWLq2C1pS117E9KPJfs15
	 5pFRkmFFdQaMQ==
Message-ID: <d4d71883-d249-4fbd-a703-930e62a16b96@kernel.org>
Date: Mon, 27 Oct 2025 15:50:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/3] tcp: add newval parameter to tcp_rcvbuf_grow()
Content-Language: en-GB, fr-BE
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20251027073809.2112498-1-edumazet@google.com>
 <20251027073809.2112498-3-edumazet@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251027073809.2112498-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 27/10/2025 08:38, Eric Dumazet wrote:
> This patch has no functional change, and prepares the following one.
> 
> tcp_rcvbuf_grow() will need to have access to tp->rcvq_space.space
> old and new values.
> 
> Change mptcp_rcvbuf_grow() in a similar way.

Thank you for the v2, and for having adapted MPTCP as well.

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/tcp.h    |  2 +-
>  net/ipv4/tcp_input.c | 15 ++++++++-------
>  net/mptcp/protocol.c | 16 ++++++++--------
>  3 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 5ca230ed526ae02711e8d2a409b91664b73390f2..ab20f549b8f9143671b75ed0a3f87d64b9e73583 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -370,7 +370,7 @@ void tcp_delack_timer_handler(struct sock *sk);
>  int tcp_ioctl(struct sock *sk, int cmd, int *karg);
>  enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
> -void tcp_rcvbuf_grow(struct sock *sk);
> +void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
>  void tcp_rcv_space_adjust(struct sock *sk);
>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
>  void tcp_twsk_destructor(struct sock *sk);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 31ea5af49f2dc8a6f95f3f8c24065369765b8987..600b733e7fb554c36178e432996ecc7d4439268a 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -891,18 +891,21 @@ static inline void tcp_rcv_rtt_measure_ts(struct sock *sk,
>  	}
>  }
>  
> -void tcp_rcvbuf_grow(struct sock *sk)
> +void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
>  {
>  	const struct net *net = sock_net(sk);
>  	struct tcp_sock *tp = tcp_sk(sk);
> -	int rcvwin, rcvbuf, cap;
> +	u32 rcvwin, rcvbuf, cap, oldval;
> +
> +	oldval = tp->rcvq_space.space;

Even if the series as a whole is OK, NIPA (and the MPTCP CI) are
complaining about this line, because in this patch, 'oldval' is set but
not used. It is used in the next patch.

I guess we want to fix this to prevent issues with 'git bisect'. If yes,
do you mind moving the declaration to the next patch please?

> +	tp->rcvq_space.space = newval;
>  
>  	if (!READ_ONCE(net->ipv4.sysctl_tcp_moderate_rcvbuf) ||
>  	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
>  		return;
>  
>  	/* slow start: allow the sender to double its rate. */
> -	rcvwin = tp->rcvq_space.space << 1;
> +	rcvwin = newval << 1;
>  
>  	if (!RB_EMPTY_ROOT(&tp->out_of_order_queue))
>  		rcvwin += TCP_SKB_CB(tp->ooo_last_skb)->end_seq - tp->rcv_nxt;
> @@ -943,9 +946,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
>  
>  	trace_tcp_rcvbuf_grow(sk, time);
>  
> -	tp->rcvq_space.space = copied;
> -
> -	tcp_rcvbuf_grow(sk);
> +	tcp_rcvbuf_grow(sk, copied);
>  
>  new_measure:
>  	tp->rcvq_space.seq = tp->copied_seq;
> @@ -5270,7 +5271,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
>  	}
>  	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
>  	if (sk->sk_socket)
> -		tcp_rcvbuf_grow(sk);
> +		tcp_rcvbuf_grow(sk, tp->rcvq_space.space);
>  }
>  
>  static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0292162a14eedffde166cc2a2d4eaa7c3aa6760d..f12c5806f1c861ca74d2375914073abc37c940d6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -194,17 +194,19 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
>   * - mptcp does not maintain a msk-level window clamp
>   * - returns true when  the receive buffer is actually updated
>   */
> -static bool mptcp_rcvbuf_grow(struct sock *sk)
> +static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	const struct net *net = sock_net(sk);
> -	int rcvwin, rcvbuf, cap;
> +	u32 rcvwin, rcvbuf, cap, oldval;
>  
> +	oldval = msk->rcvq_space.space;

Same here in MPTCP:

>   net/mptcp/protocol.c: In function 'mptcp_rcvbuf_grow':
>   net/mptcp/protocol.c:201:34: error: variable 'oldval' set but not used [-Werror=unused-but-set-variable]
>     201 |         u32 rcvwin, rcvbuf, cap, oldval;
>         |                                  ^~~~~~

Apart from this small detail, the rest looks good to me.

> +	msk->rcvq_space.space = newval;
>  	if (!READ_ONCE(net->ipv4.sysctl_tcp_moderate_rcvbuf) ||
>  	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
>  		return false;
>  
> -	rcvwin = msk->rcvq_space.space << 1;
> +	rcvwin = newval << 1;
>  
>  	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
>  		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;
> @@ -334,7 +336,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  	skb_set_owner_r(skb, sk);
>  	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
>  	if (sk->sk_socket)
> -		mptcp_rcvbuf_grow(sk);
> +		mptcp_rcvbuf_grow(sk, msk->rcvq_space.space);
>  }
>  
>  static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
> @@ -2049,8 +2051,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
>  	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
>  		goto new_measure;
>  
> -	msk->rcvq_space.space = msk->rcvq_space.copied;
> -	if (mptcp_rcvbuf_grow(sk)) {
> +	if (mptcp_rcvbuf_grow(sk, msk->rcvq_space.copied)) {
>  
>  		/* Make subflows follow along.  If we do not do this, we
>  		 * get drops at subflow level if skbs can't be moved to
> @@ -2063,8 +2064,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
>  
>  			ssk = mptcp_subflow_tcp_sock(subflow);
>  			slow = lock_sock_fast(ssk);
> -			tcp_sk(ssk)->rcvq_space.space = msk->rcvq_space.copied;
> -			tcp_rcvbuf_grow(ssk);
> +			tcp_rcvbuf_grow(ssk, msk->rcvq_space.copied);
>  			unlock_sock_fast(ssk, slow);
>  		}
>  	}

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


