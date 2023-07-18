Return-Path: <netdev+bounces-18620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E44A757FF0
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAC31C20D47
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3440DD532;
	Tue, 18 Jul 2023 14:44:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2AAD4B
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 14:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D1BC433C7;
	Tue, 18 Jul 2023 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689691488;
	bh=R74vvnkunVYr72agQflTDuDRh//LNi4fRwR1K/EFs9s=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=V5x8x2E31svySxVbnbAZB/Pj+81OABdeq1vfiIGaNVeV3QlfmnTMrRcz/0gEE8QeP
	 6DPb4edSDu0iNGaYdhgNugtJKp6Nxqy6aXWR9TFTYh3scMadwt2sO+HYOb27dx7ecr
	 Zc+4Lcj9nvYkHemCOIyUZ1caDk4N6txKnLZjI96cKEuh1eAtJNctVdBkcAjTkx/tyr
	 XcY2KZdMoReOaSGOQ9PcdIh1y2QfLLXRzzr2J25vu6xy+7KeeIRoj9q8NdltdheXyC
	 YuGO5QtgHSXVfWgM0/GMW/4PKvJIIcNThNOuM9+Z2j9CumuZAPEwISky8VjDiLN8m0
	 VlgF6LqJE3qSg==
Message-ID: <f6831ace-df6c-f0bd-188e-a2b23a75c1a8@kernel.org>
Date: Tue, 18 Jul 2023 08:44:47 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] net: ipv4: fix return value check in
 esp_remove_trailer()
Content-Language: en-US
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
References: <20230717144930.26197-1-ruc_gongyuanjun@163.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230717144930.26197-1-ruc_gongyuanjun@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/23 8:49 AM, Yuanjun Gong wrote:
> return an error number if an unexpected result is returned by
> pskb_tirm() in esp_remove_trailer().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  net/ipv4/esp4.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index ba06ed42e428..0660bf2bdbae 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -732,7 +732,10 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
>  		skb->csum = csum_block_sub(skb->csum, csumdiff,
>  					   skb->len - trimlen);
>  	}
> -	pskb_trim(skb, skb->len - trimlen);
> +	if (pskb_trim(skb, skb->len - trimlen)) {
> +		ret = -EINVAL;

pskb_trim returns the error from ___pskb_trim; use it instead of
changing it here.


> +		goto out;
> +	}
>  
>  	ret = nexthdr[1];
>  


