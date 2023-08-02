Return-Path: <netdev+bounces-23574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FC476C8D2
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337B6281C43
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2207E5672;
	Wed,  2 Aug 2023 08:56:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37F410F8
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCCDC433C8;
	Wed,  2 Aug 2023 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690966579;
	bh=zp23WPmkSwtuj1HRL8AUlLFN3VIgce2JGc1dndKSmno=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=orakVg71I/8oHfMw31ANzKFpHxnxrf4pElcswGPsomLQ+CgBfkx+e0dghScry6uIT
	 PYpYRuluiWrT1wfwDsXNswJEtFucyxz6kLRKR1lFJ5QKBzjFIi0X00jLtiVpOUFfOq
	 CZq4GmSC5nE91dAxlAc6UVec2LGlYDr1gsDRLYP4oAT/Q+LudD6I+J3dAkEpJIPlXW
	 QpBOjou0voqnWeab+6g0exV7ARMGH3HUDCV1M8DeCRQAmEsb+8fNdsvKrEwvu96p5C
	 ssl8M9/rq5StgkXVK6KKPZN/ET8OpLJ4PrHWVf7Uck7jrwr5LhzzPbQlk6Ta4ewCdP
	 EAg2hChxkaOzg==
Message-ID: <f586f586-5a24-4a01-7ac6-6e75b8738b49@kernel.org>
Date: Wed, 2 Aug 2023 10:56:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, daniel@iogearbox.net,
 ast@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2 1/2] net: veth: Page pool creation error
 handling for existing pools only
Content-Language: en-US
To: Liang Chen <liangchen.linux@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linyunsheng@huawei.com
References: <20230801061932.10335-1-liangchen.linux@gmail.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230801061932.10335-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/08/2023 08.19, Liang Chen wrote:
> The failure handling procedure destroys page pools for all queues,
> including those that haven't had their page pool created yet. this patch
> introduces necessary adjustments to prevent potential risks and
> inconsistency with the error handling behavior.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>   drivers/net/veth.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 614f3e3efab0..509e901da41d 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1081,8 +1081,9 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
>   err_xdp_ring:
>   	for (i--; i >= start; i--)
>   		ptr_ring_cleanup(&priv->rq[i].xdp_ring, veth_ptr_free);
> +	i = end;
>   err_page_pool:
> -	for (i = start; i < end; i++) {
> +	for (i--; i >= start; i--) {

I'm not a fan of this coding style, that iterates backwards, but I can
see you just inherited the existing style in this function.

>   		page_pool_destroy(priv->rq[i].page_pool);
>   		priv->rq[i].page_pool = NULL;
>   	}

The page_pool_destroy() call handles(exits) if called with NULL.
So, I don't think this incorrect walking all (start to end) can trigger 
an actual bug.

Anyhow, I do think this is more correct, so you can append my ACK for 
the real submission.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


