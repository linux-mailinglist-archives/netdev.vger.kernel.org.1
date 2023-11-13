Return-Path: <netdev+bounces-47314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDCB7E9974
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 10:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843401F20C96
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248EA1A597;
	Mon, 13 Nov 2023 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNbU158A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BED1A590
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC25C433C8;
	Mon, 13 Nov 2023 09:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699869217;
	bh=gaXTGrSknZ1OavnmXv0BGImmFrNcv1YuQ5p0rTRPT8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNbU158A8sqljO9NTIswY4x5F62vwETge/FeZlCi9OIQ6Wjsxwuz0z9EIboiSjrOG
	 XyxZTPsGlZxs4/1PukL2LITIbrP5iUDSNKG67PVvte5jX93daO4Wfg3ZE4lCBq/yT/
	 u8L72RHGYM1xEuzjeFftG0fnuJcHdCCAHyL0NIQO1VUxu/MafHdqZXI6RsDe5Xd110
	 UxlfEcrn+punnhQFUWBcF6oYp7FqXoBRZ02r4IjC9jkqTn7ZschHGyMTGsEmmj1+dO
	 Ya8J4T4rmlHnl9FRCtzzXGvqHXvgqEP36BbefE+828uQCwvqR2RWztsrDiXVxTJb2i
	 hUsBW4YnBHoIQ==
Date: Mon, 13 Nov 2023 09:53:33 +0000
From: Simon Horman <horms@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Vlad Buslov <vladbu@nvidia.com>
Subject: Re: [PATCH net] net: Fix undefined behavior in netdev name allocation
Message-ID: <20231113095333.GM705326@kernel.org>
References: <20231113083544.1685919-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113083544.1685919-1-gal@nvidia.com>

On Mon, Nov 13, 2023 at 10:35:44AM +0200, Gal Pressman wrote:
> Cited commit removed the strscpy() call and kept the snprintf() only.
> 
> When allocating a netdev, 'res' and 'name' pointers are equal, but
> according to POSIX, if copying takes place between objects that overlap
> as a result of a call to sprintf() or snprintf(), the results are
> undefined.
> 
> Add back the strscpy() and use 'buf' as an intermediate buffer.
> 
> Fixes: 9a810468126c ("net: reduce indentation of __dev_alloc_name()")

Hi Gal,

perhaps my eyes are deceiving me, but I wonder if this fixes the following:

  7ad17b04dc7b ("net: trust the bitmap in __dev_alloc_name()")

> Cc: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  net/core/dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0d548431f3fa..af53f6d838ce 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1119,7 +1119,9 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
>  	if (i == max_netdevices)
>  		return -ENFILE;
>  
> -	snprintf(res, IFNAMSIZ, name, i);
> +	/* 'res' and 'name' could overlap, use 'buf' as an intermediate buffer */
> +	strscpy(buf, name, IFNAMSIZ);
> +	snprintf(res, IFNAMSIZ, buf, i);
>  	return i;
>  }
>  
> -- 
> 2.40.1
> 
> 

