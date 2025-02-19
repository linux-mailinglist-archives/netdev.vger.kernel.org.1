Return-Path: <netdev+bounces-167785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05919A3C43F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4B73BABF2
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B0D1F8AE5;
	Wed, 19 Feb 2025 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPVcc+Pr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17CD1F4623
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980444; cv=none; b=sqU4MH3LWgmZOuKpvJ8f3WNNNpqCnUYt38iEMXBBpS0IR4P5BGLbZlKseltt8XmTG5KmkeMX21QrEGvqpzw2NmOiNJmbaEotWylsW566C+OWZkB1/5qguPVVFZ7/KGgh+2cWT03iixZg0xkPfV6SD+lQyFYENbppb3s06o7WzNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980444; c=relaxed/simple;
	bh=QUdADeL5jQW7K5lUQIzpIPvYucIfmOsIffX/gIHSJD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=unmDaRSSMQjTcqTKyViYc8KD9D18iRRjARa3NQpQ7hK6LJbiB50ZmAfFLvIa2ppZC8r6ySrwDJ2gubxO0q9WPZkMtiZPrcPWDvtXqvFTY3z74N3vUgKkTn/8bwRIUSRxlAHS/cnpUxewzqwXri0FCXlU8V1ie2Hq7Z8wZPixegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPVcc+Pr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45283C4CED1;
	Wed, 19 Feb 2025 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739980443;
	bh=QUdADeL5jQW7K5lUQIzpIPvYucIfmOsIffX/gIHSJD0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=EPVcc+ProF7mIhLiA4Io1biKtv/6PgEgH4i4OOL27XXubsdn3Nn3une4PMiVeXxBW
	 6fH9zzXBAK7/0B+W7fYV3/PceOxhwYA7Sngo/rr+cP/kxSMylghBcuPGG+pr7Vua6s
	 a42QHLZHuvvvudc2IEp6o4kyXdzkFjfD7uqwQGqWMlixqNK5Ijx9QzDCl2uu6VGzYX
	 s2AjiN2JwBrJdl3c1DoZwGm8Xa6v67yJzYxqcbeUa391hHN3N8Ud4SHRe/wJFaXunD
	 AbKAEJYA/NrNN1DljSn1ObHZ+3XyPbirZv3lrkIIwwadIvw3usRbG6LcZKa/GX/Nay
	 3aruuQyz5L3sg==
Message-ID: <99cd027a-19a8-4370-b826-acdb71396c5a@kernel.org>
Date: Wed, 19 Feb 2025 08:54:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ip: check return value of
 iproute_flush_cache() in irpoute.c
Content-Language: en-US
To: Anton Moryakov <ant.v.moryakov@gmail.com>, netdev@vger.kernel.org
References: <20250217162153.838113-1-ant.v.moryakov@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250217162153.838113-1-ant.v.moryakov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 9:21 AM, Anton Moryakov wrote:
> Static analyzer reported:
> Return value of function 'iproute_flush_cache', called at iproute.c:1732, 
> is not checked. The return value is obtained from function 'open64' and possibly contains an error code.
> 
> Corrections explained:
> The function iproute_flush_cache() may return an error code, which was
> previously ignored. This could lead to unexpected behavior if the cache
> flush fails. Added error handling to ensure the function fails gracefully
> when iproute_flush_cache() returns an error.
> 
> Triggers found by static analyzer Svace.
> 
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> ---
>  ip/iproute.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/ip/iproute.c b/ip/iproute.c
> index e1fe26ce..64e7d77e 100644
> --- a/ip/iproute.c
> +++ b/ip/iproute.c
> @@ -1729,7 +1729,10 @@ static int iproute_flush(int family, rtnl_filter_t filter_fn)
>  
>  	if (filter.cloned) {
>  		if (family != AF_INET6) {
> -			iproute_flush_cache();
> +			ret = iproute_flush_cache();
> +			if(ret < 0)
> +				return ret;
> +				
>  			if (show_stats)
>  				printf("*** IPv4 routing cache is flushed.\n");
>  		}

applied all 4 after fixups on the first 2. This patch has style errors
(extra tabs on the newline, space between `if(`.

patch 2 did not need brackets and the comment was not useful information.

