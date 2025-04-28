Return-Path: <netdev+bounces-186583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F373A9FD4C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647885A63C8
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54D820FAA4;
	Mon, 28 Apr 2025 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGAgw0jT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F624C80;
	Mon, 28 Apr 2025 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745880654; cv=none; b=k0D+lqMkBTCbf0AHUwKKvTHHbtTo6tIpYPXaDbHGqi54tSxA4T2FX6V+B26ZJdc4H7bplk0z8/shCMRiVON/35bsI0a08cNi1pRFDTNHNucQxEfeD2vOZqE9b6xGYwdpH2XZeWZy+nRtZM0HDYo5lmSk+Y9fNHgHNH36KIDECMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745880654; c=relaxed/simple;
	bh=Tzdsf9kK0NGmmWnF6pyX+kuF4d22g/O4KYkrQy6PkTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9/uA9VmIGYqMl2diC2fqg9235c03ZGebHjT+VFRe0wUQ07fO0MOkUFq1nrEXhe0kddUOY//4lkTGz77CI2ODUr9IT72rqEBfHVLqRy56eBzPcaQWc8THLaxF7sKU25Tq4rsZxnjsYiI4V+r5aJ8Mm326fc8tFG1qeATp6oJ8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGAgw0jT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ADEC4CEE4;
	Mon, 28 Apr 2025 22:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745880654;
	bh=Tzdsf9kK0NGmmWnF6pyX+kuF4d22g/O4KYkrQy6PkTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PGAgw0jTtOQ9rwOUye1SbsUdQCUnG8hTI+lmfLD+BJPGPEk7sEzCWyWyuiaxdCK2k
	 8BIhekDE5xhqhh3x3ngYs9BrixU6hgs2E7//iOURq1ZC2pbVNNr6x5VoLId5xzzS5W
	 MCd9qXx/Xp5JzLtc78jY8UkPG3Zd/79csVRl4KzAH7COm26LVmj9eL0awtJhZWnGov
	 EXUEFlgjdLRoSU/UiUI8R6vkMWWsQF3UjcXETbXLpnnzNSc4s/lGzczzzYvoeTDwZ2
	 l1v5EUsrS31ckMN+mO+TDLwKZCnbot+fJ80jVzbrKEBNhvGHqZ6P979owp456gQIhu
	 X+tq9lfHikqlQ==
Message-ID: <12141842-39ff-47fc-ac2b-7a72d778117a@kernel.org>
Date: Mon, 28 Apr 2025 16:50:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv4: fib: Fix fib_info_hash_alloc() allocation type
Content-Language: en-US
To: Kees Cook <kees@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20250426060529.work.873-kees@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250426060529.work.873-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/25 11:05 PM, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> This was allocating many sizeof(struct hlist_head *) when it actually
> wanted sizeof(struct hlist_head). Luckily these are the same size.
> Adjust the allocation type to match the assignment.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: <netdev@vger.kernel.org>
> ---
>  net/ipv4/fib_semantics.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index f68bb9e34c34..37d12b0bc6be 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -365,7 +365,7 @@ static struct hlist_head *fib_info_laddrhash_bucket(const struct net *net,
>  static struct hlist_head *fib_info_hash_alloc(unsigned int hash_bits)
>  {
>  	/* The second half is used for prefsrc */
> -	return kvcalloc((1 << hash_bits) * 2, sizeof(struct hlist_head *),
> +	return kvcalloc((1 << hash_bits) * 2, sizeof(struct hlist_head),
>  			GFP_KERNEL);
>  }
>  

Reviewed-by: David Ahern <dsahern@kernel.org>

Fixes: fa336adc100e ("ipv4: fib: Allocate fib_info_hash[] and
fib_info_laddrhash[] by kvcalloc().)

