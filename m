Return-Path: <netdev+bounces-169937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3A5A46865
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0584C1720E0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECACD229B2D;
	Wed, 26 Feb 2025 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJzkrPev"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653F229B1E
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592083; cv=none; b=Hjcn4C/45Nh2wi3eoV6mzRe1mwnTU7t6pFey5TxAYlw+iShlx0YFWZh/I/lOCfUmzqmyQXFJmp1r2I4pMs/4gsrlriInSH6mU67z5c5n75ggibWa0lCuAt4SR1SHIS+tFbPmA6+pe5vjebehZ6T50anfhibqfFWB0O7KO8Y3SCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592083; c=relaxed/simple;
	bh=MYnt9mjZPNb5GrFY8k2HQiElf9pPQeytT4r7m8uXxxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGp8jhKfo4pLGMxXpUyRG3QRlHdWbP2TQFBfptbi31Vy9txkAw1pzzTHVuX128FnaR+Heu5takeMfI8dGYBHmlBet31bAFRikMWZXcfonSCXro8ly06fdvBebnYQPaJIwz0iA578V7MF1hBHZ7s70dHMV+XHzKe939Uf6M1qouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJzkrPev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00292C4CED6;
	Wed, 26 Feb 2025 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740592083;
	bh=MYnt9mjZPNb5GrFY8k2HQiElf9pPQeytT4r7m8uXxxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cJzkrPevp/MuO0wTeeqdsqwFBP5Ywh5jta5Sk9TNl/vCxU01Xi0QQ+bRqlQlum9wF
	 Cf0RLcyenoJstYFsJ7L4LuzOuAmoXng/b/qoQBgoRZcYcm+plXjq3jn83DGUM98rDn
	 gA08Y+nj2vjnVMVZwtscSVzKx9Yw2172op2C6UzwR7bM/sseiAYN3s4tQadDe+Fil6
	 8a3PqTm+W51P8LvfuZm7fTkmQbpaMVZ7apR9XudKUH8U4X8JhOTnTQSv9yoSChYIJZ
	 4gN/zck0/eTWnopBvAQsM1DZTHCwrrWhLlerpIC3LYCAwUi1y9+faTvYhP4NkBLs9f
	 QDW/D+PpjCqSA==
Message-ID: <35e7f0a9-3c8d-479c-9a4c-012354f08c5d@kernel.org>
Date: Wed, 26 Feb 2025 10:48:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 03/12] ipv4: fib: Allocate fib_info_hash[]
 during netns initialisation.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20250225182250.74650-1-kuniyu@amazon.com>
 <20250225182250.74650-4-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250225182250.74650-4-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 11:22 AM, Kuniyuki Iwashima wrote:
> diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
> index 6730e2034cf8..dbf84c23ca09 100644
> --- a/net/ipv4/fib_frontend.c
> +++ b/net/ipv4/fib_frontend.c
> @@ -1615,9 +1615,15 @@ static int __net_init fib_net_init(struct net *net)
>  	error = ip_fib_net_init(net);
>  	if (error < 0)
>  		goto out;
> +
> +	error = fib4_semantics_init(net);
> +	if (error)
> +		goto out_semantics;
> +
>  	error = nl_fib_lookup_init(net);
>  	if (error < 0)
>  		goto out_nlfl;
> +
>  	error = fib_proc_init(net);
>  	if (error < 0)
>  		goto out_proc;
> @@ -1627,6 +1633,8 @@ static int __net_init fib_net_init(struct net *net)
>  out_proc:
>  	nl_fib_lookup_exit(net);
>  out_nlfl:
> +	fib4_semantics_init(net);

_exit?



