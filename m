Return-Path: <netdev+bounces-102266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E4B902220
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191B01C21EC8
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F0A80C1D;
	Mon, 10 Jun 2024 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="K7iR9UNL"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DFC80C07
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024156; cv=none; b=MhAfRQFzA2Sbo1RE8ZYIQmk7hwuBluqGOa3b5uOzoBwD7pcxPKoTtmqxnEqZpNMHwH16zaMPq5ytNFrAgQR9vorTMoGCYwyGVctwqE/qvWzxZ/aHpgjV2hzKXl41nSVOoqjyaIffFh9Yzf49m9TFmkcd83j9WMVilidoKVJD3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024156; c=relaxed/simple;
	bh=UBV2W8SGGyjphPijFqfc5CnmiDyrA/XxsHXYlOGDX5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VX0jcjJrVVuGOiSf/8lEY8RyT3W4ipRFQ0ZTskUgLFvxUYZsJkkij5NbS9ohfy+1/XoccuaW999hexUsP43o4K1KnS8pluHowyoeyd5ssLaXwCrjNfbkV82GbMfgtGDzC58Hlyme2v0m3ThmD784wBGYvzoytk/bR4WiOo1BOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=K7iR9UNL; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sGeYX-00Cifx-Q3; Mon, 10 Jun 2024 14:55:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=GMqknHH3RTp2fhruXwQr/m2wsqGoKeB9wsxcCNKn0tk=; b=K7iR9UNL9W+ZysVngAP3gyARSi
	fluy+tadMZxVmw7hw5bGZMpcvejGKNFQGIFDpAGTVv7pAkpmwpdl7Ki8TZm29JmKYxJcdqsgAqa8F
	dDkGoQgOi+4Q9SAKs1nf2FkFvQgjoMA2tmIRIhURmNUv+0yQTHXWsCEQMUFqdm6m/7bo166WeSSPY
	fuO+HyCBzTEr+JQbRFZJ9C5M5ImxsRf4bOBc/0+LX1WNkCjePB28yqRYdrh7oNDTo+Tre4GFf2CtU
	EbWha/BErTOjrM7s8wDoD334L15dkquLNh2vk8AgMTDMQwIJkbMQe+TQyCYxxj0yMUml4hQOhgIg5
	uHzO0s7Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sGeYW-0003Tl-Aq; Mon, 10 Jun 2024 14:55:24 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sGeYH-00FQj6-Cs; Mon, 10 Jun 2024 14:55:09 +0200
Message-ID: <cc8a0165-f2e9-43a7-a1a2-28808929d27e@rbox.co>
Date: Mon, 10 Jun 2024 14:55:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under
 unix_state_lock() for truly disconencted peer.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <20240609195320.95901-1-kuniyu@amazon.com>
 <20240609210307.2919-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240609210307.2919-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/24 23:03, Kuniyuki Iwashima wrote:
> (...)
> Sorry, I think I was wrong and we can't use smp_store_release()
> and smp_load_acquire(), and smp_[rw]mb() is needed.
> 
> Given we avoid adding code in the hotpath in the original fix
> 8866730aed510 [0], I prefer adding unix_state_lock() in the SOCKMAP
> path again.
>
> [0]: https://lore.kernel.org/bpf/6545bc9f7e443_3358c208ae@john.notmuch/

You're saying smp_wmb() in connect() is too much for the hot path, do I
understand correctly?

> ---8<---
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index d3dbb92153f2..67794d2c7498 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -549,7 +549,7 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
>  	if (sk_is_tcp(sk))
>  		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
>  	if (sk_is_stream_unix(sk))
> -		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
> +		return (1 << READ_ONCE(sk->sk_state)) & TCPF_ESTABLISHED;
>  	return true;
>  }
>  
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index bd84785bf8d6..1db42cfee70d 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -159,8 +159,6 @@ int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool re
>  
>  int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>  {
> -	struct sock *sk_pair;
> -
>  	/* Restore does not decrement the sk_pair reference yet because we must
>  	 * keep the a reference to the socket until after an RCU grace period
>  	 * and any pending sends have completed.
> @@ -180,9 +178,9 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
>  	 * be a single matching destroy operation.
>  	 */
>  	if (!psock->sk_pair) {
> -		sk_pair = unix_peer(sk);
> -		sock_hold(sk_pair);
> -		psock->sk_pair = sk_pair;
> +		psock->sk_pair = unix_peer_get(sk);
> +		if (WARN_ON_ONCE(!psock->sk_pair))
> +			return -EINVAL;
>  	}
>  
>  	unix_stream_bpf_check_needs_rebuild(psock->sk_proto);
> ---8<---

FWIW, we've passed sock_map_sk_state_allowed(), so critical section can be
empty:

	if (!psock->sk_pair) {
		unix_state_lock(sk);
		unix_state_unlock(sk);
		sk_pair = READ_ONCE(unix_peer(sk));
		...
	}

Thanks,
Michal


