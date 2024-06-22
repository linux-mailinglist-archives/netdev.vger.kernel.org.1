Return-Path: <netdev+bounces-105895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503CA9136B1
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 00:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37DF281E8C
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 22:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E08676F17;
	Sat, 22 Jun 2024 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="j+uVSS+w"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441DB4CDEC
	for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719096238; cv=none; b=YetBt0sOP0j1MZym2zMSLj6SSj1vk3PcFaWrgqnb/WP2BeRNgp+ocSOTDI63lhwcSemLgynJ+doaQAd5bOJm1XIb/XQ47/+L7byITd0gtFzrcwpjp2YdPKPmwRe8x+OVSnmnJBBtYyhf8E9exEP9WdECpLBbGmrEJbZDgC+HXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719096238; c=relaxed/simple;
	bh=0IY38fb9q0I1ymWSOkdvW6KVWzlrwliDzvRMyRo7Q70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDPbLkF5hBMqyIK4JmfchUnFPXWae+JqtXY9HUZnLSDIo41SPo3TpfNIEKhLJtjVjv6y6Jr+La8w32t11bvA7Q3HhHg5qkcfS/zBEX0+Fv8/yO4MY58u6RWQWMg0QeAuer4QFo1rmeOPaLgJzNxvd7lP50Lt6pvvseUPZiAwwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=j+uVSS+w; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sL9SV-00AlAH-2s; Sun, 23 Jun 2024 00:43:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=6Lrlt/hGP80NkVBf4DVXz1bLbyYw0OQ5aVlGkCdWWQ4=; b=j+uVSS+w+q9Zbf4nWQYlZcKji8
	Qc7t3k28FwP7YuNAAvJCKju2l7nmA9iKEDs85khhjfR2i23mo3j4UuOOvdvzcn6WiLrofFU1Do6ql
	1RYL64vfvabgOQ5zPJHA9Gk9H2rbkkgmDo7Ll+qJEoI21xDIPlsPg28A868qlNboJTzO+KwJ+yV2P
	InDJIZ8GeFFrhgGljf6X3v8s/CV+N2iaBb2+tROxeHNhFkniomM6po5U7jqeyz0PCNHhnNghYXaZi
	zNSMWvUrEnKyXVyWh7AkiQI7Jpu+LCIy6feHXNYTMFuzbEyBVy6+QOzJBItP7zYJRb8j0BlR+mv8x
	93KOsvNA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sL9SU-0002Qj-EK; Sun, 23 Jun 2024 00:43:46 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sL9SD-007C7k-0z; Sun, 23 Jun 2024 00:43:29 +0200
Message-ID: <2d34e8df-cbb0-486a-976b-c5c72554e184@rbox.co>
Date: Sun, 23 Jun 2024 00:43:27 +0200
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
References: <b29d7ead-6e2c-4a52-9a0a-56892e0015b6@rbox.co>
 <20240620215616.64048-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240620215616.64048-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/24 23:56, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Thu, 20 Jun 2024 22:35:55 +0200
>> In fact, should I try to document those not-so-obvious OOB/sockmap
>> interaction? And speaking of documentation, an astute reader noted that
>> `man unix` is lying:
> 
> At least I wouldn't update man until we can say AF_UNIX MSG_OOB handling
> is stable enough; the behaviour is not compliant with TCP now.

Sure, I get it.

> (...)
> And we need
> 
> ---8<---
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 5e695a9a609c..2875a7ce1887 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2614,9 +2614,20 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>  	struct unix_sock *u = unix_sk(sk);
>  
>  	if (!unix_skb_len(skb) && !(flags & MSG_PEEK)) {
> -		skb_unlink(skb, &sk->sk_receive_queue);
> -		consume_skb(skb);
> -		skb = NULL;
> +		struct sk_buff *unlinked_skb = skb;
> +
> +		spin_lock(&sk->sk_receive_queue.lock);
> +
> +		__skb_unlink(skb, &sk->sk_receive_queue);
> +
> +		if (copied)
> +			skb = NULL;
> +		else
> +			skb = skb_peek(&sk->sk_receive_queue);
> +
> +		spin_unlock(&sk->sk_receive_queue.lock);
> +
> +		consume_skb(unlinked_skb);
>  	} else {
>  		struct sk_buff *unlinked_skb = NULL;
>  
> ---8<---

I gotta ask, is there a reason for unlinking an already consumed
('consumed' as in 'unix_skb_len(skb) == 0') skb so late, in manage_oob()?
IOW, can't it be unlinked immediately once it's consumed in
unix_stream_recv_urg()? I suppose that would simplify things.

