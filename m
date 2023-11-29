Return-Path: <netdev+bounces-51938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468D87FCC5E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861E9B214C9
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 01:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4161D1854;
	Wed, 29 Nov 2023 01:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvHe7j2e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B64EDD
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 01:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D103C433C7;
	Wed, 29 Nov 2023 01:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701221692;
	bh=efexJmwUPSN3UagnOJLevL/NsCUGG+z16mHHGRhUgOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mvHe7j2eTTKmJViyg0l2ofc7p417YsZnLcwujCTqpr1j/DA63JLH4gK/ezm304FSe
	 fGJiS3E3FecrcmKOw3pOR9KZcYnLD6yldiFVuzkSwFYBSYDXSZJxIMT4e5Yg0s06ON
	 pLN9/M81nHJz/is3gU0YnzNmsmxxfMqkzwvvon897i+WeENbW1uVAKEGrl6GAhr64X
	 nHwq683T4U3I0NWrayB1kMok7yULVshFjmhTrfG5AFa4lJmgbxUY8gX9xjOMRGMwYd
	 QyYKXU+VmpLKzkBFr+wzhSMlJvYvYTbvOOlPjd7o0o2pI1wJEB4Cb87g9ea1kwilsU
	 G4nIh8tNgJfWw==
Message-ID: <eb9a46a5-d074-445a-9e18-514ef78395d7@kernel.org>
Date: Tue, 28 Nov 2023 18:34:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] net/tcp: Don't add key with non-matching VRF on
 connected sockets
Content-Language: en-US
To: Dmitry Safonov <dima@arista.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Francesco Ruggeri <fruggeri05@gmail.com>,
 Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20231128205749.312759-1-dima@arista.com>
 <20231128205749.312759-6-dima@arista.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231128205749.312759-6-dima@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/23 1:57 PM, Dmitry Safonov wrote:
> If the connection was established, don't allow adding TCP-AO keys that
> don't match the peer. Currently, there are checks for ip-address
> matching, but L3 index check is missing. Add it to restrict userspace

you say L3 index check is missing - add it. yet ...

> shooting itself somewhere.
> 
> Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  net/ipv4/tcp_ao.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index bf41be6d4721..2d000e275ce7 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -1608,6 +1608,9 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
>  		if (!dev || !l3index)
>  			return -EINVAL;
>  
> +		if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
> +			return -EINVAL;

... this is checking socket state.


> +
>  		/* It's still possible to bind after adding keys or even
>  		 * re-bind to a different dev (with CAP_NET_RAW).
>  		 * So, no reason to return error here, rather try to be


