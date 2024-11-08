Return-Path: <netdev+bounces-143130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C519C139E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E0CB21F6C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B6FDF60;
	Fri,  8 Nov 2024 01:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZKnvFLI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348EBA4A;
	Fri,  8 Nov 2024 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029331; cv=none; b=d4V3VxGJUSkhtHUA7IfpwPWV+rAW4VQVnOe5+4OBkRlRSRIIfWz0YmIgPsdQQ7SYV5Nc7UT/lJhI2marWtt1hUhO05+8h3SAKJLlobquir1YgkX5RKINeJqFxJqzKI+2k+WGJc+mmB4A4zQNQ3c1ke52DHRsuW1p4af3APDF7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029331; c=relaxed/simple;
	bh=fBvFFMhZ/pMrm8br32Jp2RVmPAmyF6kukszcO8s7j0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUFZhhLVcBkyktTYrxWeAED20sSgrGLSkgRmeiXFpcSnFW/4Y1JWLNogthxNoKx+jWDdZW2YBuUDZCdrQRKYwsTIaDIHPTSTA4bXFTnGI0OAozZi2F6j7t3lLs3NCcg4b6bqeQ5ukRnMySblXS+9vK0EfxyCTqCypOfhP+yTZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZKnvFLI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cf3e36a76so17393155ad.0;
        Thu, 07 Nov 2024 17:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731029329; x=1731634129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7l8kfD9rO+T0B/VqCAqNwFI36BFclG1R7lET9C1Kvg=;
        b=YZKnvFLIB64XqiYpVXXSm2NRIYt2nVY29CNr/zGtLTENMkmJ6N2V5HjiDS4nFCMVW0
         NoihGa/EJzQFkKiytNMkZnTiFa8kmiOg+jRr0LuE1mCbJo6CWInk63ePVP86cCLIpybh
         cg/5VbDjYsXOQjwJTwerqin7FfZ8utmtG5Wvd5GJQM2qIItGlIwZhC2HY2Wds5FV1BBZ
         bMUi/QxuHNDr5jxCHtBX5SfHmuiZp7MJxNQnGw/eOCCPkEZg2T2mAFXOqbz8p9WlgVHO
         3rYFtjMfXzW4JwQM0zv3NRPiIbpL3JdO5C4yHDr4IHzJPoEWPMwwI/0OWEGB6QxARrL4
         iXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731029329; x=1731634129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7l8kfD9rO+T0B/VqCAqNwFI36BFclG1R7lET9C1Kvg=;
        b=XfJ641W9iOWSTEnDs0kyt4JKFHfUYOMICajkNkzwgF6Dw3Ijr8xZT/9OwBoz6oc0cD
         TFV75bDN9viPpiYrB12gB43GXcw+gG0SgSjSPv2OZO6VEeYc/pMPxsYM6D6NRBNt233/
         QyBEwTUPThgGKUR07cGriEe3OVTgu/Tl0e9jCrgyMJ9KDXZmVsgvOXpDi6jhatnxftVW
         I88vZljVk5tBVuK3dGMuri70pyxV+8zmh8yQd6iKw3q73PPb46oXX/pBPyWR2EQIUxnc
         M7vUspD/PVUOBScjOUyinWVtuZzl6xzfocXfe24t0IDdNeOpmWu3LePcaNcvqXav97b1
         mtsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7EmJQsra0Mn9scXY4vkkcJuqvEVU/LEQNpMURROmchX380+/FoawU9/gV4I99aSHliMoIOWMK0ME=@vger.kernel.org, AJvYcCXkeLAEX4sxYhyer9RBElyFSA+hKm64UIrJK6G1+afo7DiIDl1kPCy1cUm3RGz8nu0x73nPsK0CCMoWBcGt@vger.kernel.org
X-Gm-Message-State: AOJu0YwWyYjVb6OYT6prcyZcM2+JqITH2twV1zBhtlMCtMnA+bY/7IS0
	sLMXA9Mr8r6WGIo2TpS0NODf9uVXgfpVMyAKD7IWDVqXiLjWp9GOiEM8
X-Google-Smtp-Source: AGHT+IFLE2H8ErH49cmhOvBNSlOpBHivzFiF7S9kKZTK9B1RZ0pc1S1S1eibjiX0zJps/r0859NQvw==
X-Received: by 2002:a17:903:41c3:b0:210:fce4:11ec with SMTP id d9443c01a7336-211834f31e4mr11200905ad.1.1731029328774;
        Thu, 07 Nov 2024 17:28:48 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7d61sm19536665ad.55.2024.11.07.17.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 17:28:48 -0800 (PST)
Date: Thu, 7 Nov 2024 17:28:47 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Yi Lai <yi1.lai@linux.intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net v2 1/2] net: fix SO_DEVMEM_DONTNEED looping too long
Message-ID: <Zy1pT_VcNpFoGjq-@mini-arch>
References: <20241107210331.3044434-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107210331.3044434-1-almasrymina@google.com>

On 11/07, Mina Almasry wrote:
> Exit early if we're freeing more than 1024 frags, to prevent
> looping too long.
> 
> Also minor code cleanups:
> - Flip checks to reduce indentation.
> - Use sizeof(*tokens) everywhere for consistentcy.
> 
> Cc: Yi Lai <yi1.lai@linux.intel.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v2:
> - Retain token check to prevent allocation of too much memory.
> - Exit early instead of pre-checking in a loop so that we don't penalize
>   well behaved applications (sdf)
> 
> ---
>  net/core/sock.c | 42 ++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 039be95c40cf..da50df485090 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1052,32 +1052,34 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
>  
>  #ifdef CONFIG_PAGE_POOL
>  
> -/* This is the number of tokens that the user can SO_DEVMEM_DONTNEED in
> - * 1 syscall. The limit exists to limit the amount of memory the kernel
> - * allocates to copy these tokens.
> +/* This is the number of tokens and frags that the user can SO_DEVMEM_DONTNEED
> + * in 1 syscall. The limit exists to limit the amount of memory the kernel
> + * allocates to copy these tokens, and to prevent looping over the frags for
> + * too long.
>   */
>  #define MAX_DONTNEED_TOKENS 128
> +#define MAX_DONTNEED_FRAGS 1024
>  
>  static noinline_for_stack int
>  sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
>  {
>  	unsigned int num_tokens, i, j, k, netmem_num = 0;
>  	struct dmabuf_token *tokens;
> +	int ret = 0, num_frags = 0;
>  	netmem_ref netmems[16];
> -	int ret = 0;
>  
>  	if (!sk_is_tcp(sk))
>  		return -EBADF;
>  
> -	if (optlen % sizeof(struct dmabuf_token) ||
> +	if (optlen % sizeof(*tokens) ||
>  	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
>  		return -EINVAL;
>  

[..]

> -	tokens = kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);

Oh, so we currently allocate optlen*8? This is a sneaky fix :-p

> +	num_tokens = optlen / sizeof(*tokens);
> +	tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
>  	if (!tokens)
>  		return -ENOMEM;
>  
> -	num_tokens = optlen / sizeof(struct dmabuf_token);
>  	if (copy_from_sockptr(tokens, optval, optlen)) {
>  		kvfree(tokens);
>  		return -EFAULT;
> @@ -1086,24 +1088,28 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
>  	xa_lock_bh(&sk->sk_user_frags);
>  	for (i = 0; i < num_tokens; i++) {
>  		for (j = 0; j < tokens[i].token_count; j++) {

[..]

> +			if (++num_frags > MAX_DONTNEED_FRAGS)
> +				goto frag_limit_reached;
> +

nit: maybe reuse existing ret (and rename it to num_frags) instead of
introducing new num_frags? Both variables now seem to track the same
number.

