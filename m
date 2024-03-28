Return-Path: <netdev+bounces-83092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1148A890B66
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 21:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421381C28C80
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 20:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A54A52F62;
	Thu, 28 Mar 2024 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u26sQAvG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366CF1849
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658156; cv=none; b=WyBxH8990kRW2C4HNk+sranIuFTqdVRc2RrCC0PujrZ+6tEsktPmGCUW79vGyWqKcSJuQowmcL/e01A94MX+XJSK3zE+G0oYznedb0I5KkIerk4nnpUDbeKWszfwf0fHmXK3XwMCMac9DeIhG6jXHNmcW/viB+d4DDETSKssqWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658156; c=relaxed/simple;
	bh=kRNEJC4VJoG40VlRd9UCkNbbI/ezYTboNDaCkIt1vs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3o2u4yh86maNgFaCDHwnodRtNxrYiVkcssodmZ0AeJG6zboih4SePcN3/ulxf4cLUmDJDg1wBmFylk6nl3sezMxy2UwZi+VziVOhhWFPceC4iASz4rVBQFGxpNzSrHvFRHyj8HyXZBVKUhIs5ov+3nhwpxIfcSEkJbYWnSVO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u26sQAvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68384C433F1;
	Thu, 28 Mar 2024 20:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658155;
	bh=kRNEJC4VJoG40VlRd9UCkNbbI/ezYTboNDaCkIt1vs0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u26sQAvGzJ8ppBGjWRyFmwJm1zXGwOi+TB+bmzjiqqm+hi8gpsWDzLdHY42qyiV3+
	 7TZYwvhTap4nKMQlYwdIHmukP2vcNsym/R0AnUe8zmxTPZd63xi6u+o+5Oh7Qw+lqI
	 OLMWVBxBPbooySso1kM26DeXrgJPK+ey+S06oCeHEaJDgIu4UkOambr5oX4WwBguGm
	 6epkNfwwRrO6q7kIGGRGyJv4lXMyRBKmVSW97PT1NIR4Fpj1W+envdYZ1/8X7J0Mo9
	 X1i6+/A5Hjfo39xW8QqfjZu1KH26QlpReifFXTdTDLpknwsIHhY8rA5cWdiiHYz99l
	 o2dvLPva2oROQ==
Message-ID: <34e94b33-94cb-42ae-bc58-8ab4f7b44801@kernel.org>
Date: Thu, 28 Mar 2024 21:35:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: do not consume a cacheline for system_page_pool
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
References: <20240328173448.2262593-1-edumazet@google.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240328173448.2262593-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28/03/2024 18.34, Eric Dumazet wrote:
> There is no reason to consume a full cacheline to store system_page_pool.
> 
> We can eventually move it to softnet_data later for full locality control.
> 
> Fixes: 2b0cfa6e4956 ("net: add generic percpu page_pool allocator")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>   net/core/dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9a67003e49db87f3f92b6c6296b3e7a5ca9d9171..984ff8b9d0e1aa5646a7237a8cf0b0a21c2aa559 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -429,7 +429,7 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
>    * PP consumers must pay attention to run APIs in the appropriate context
>    * (e.g. NAPI context).
>    */
> -static DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
> +static DEFINE_PER_CPU(struct page_pool *, system_page_pool);
>   
>   #ifdef CONFIG_LOCKDEP
>   /*

