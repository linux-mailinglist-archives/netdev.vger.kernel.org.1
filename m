Return-Path: <netdev+bounces-26935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268BD779829
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 22:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578391C2180A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 20:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CBC2AB37;
	Fri, 11 Aug 2023 20:06:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C3B8468
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 20:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76388C433C8;
	Fri, 11 Aug 2023 20:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691784375;
	bh=SB9t+J5WjRhhx2UOgg7PcP04XRKE5+Hp78wvdsyKwRA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=JYLHW72t9i22LwX7nFnjJlQxxVrJyfXpaQRi2tindj53mdP2EGsamvhPjAOjzgefH
	 VvK5D54gH4D9UC7RuZvA5wrEXhO7oZdhkWbNdoWgG7fkCirD2yZaR//NGy6AcK6yMc
	 Blva0fUo8b3u5LGCQoDQ1Rf9eqoVZrUFxH9O7JXNp91vHxP+pn/0CrUPceE3JR91E1
	 hZJMXtgxBNG5fe9aonSXL+sawLrinaYs93sDpZq49fFcSWxHTookH79UZP13HW4rQ4
	 TqKPYgLqi3sBr0I8YBX+o+lUriqs2G65ycLe5phqND2cWovO+mY+65KhC9y+ElOtFn
	 e1glvonTdJckw==
Message-ID: <87e35743-f7d1-13de-45c0-3f50181abf5b@kernel.org>
Date: Fri, 11 Aug 2023 22:06:11 +0200
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
Subject: Re: [PATCH net-next] net: veth: Page pool creation error handling for
 existing pools only
Content-Language: en-US
To: Liang Chen <liangchen.linux@gmail.com>, horms@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linyunsheng@huawei.com
References: <20230811121640.13301-1-liangchen.linux@gmail.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230811121640.13301-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/08/2023 14.16, Liang Chen wrote:
> The failure handling procedure destroys page pools for all queues,
> including those that haven't had their page pool created yet. this patch
> introduces necessary adjustments to prevent potential risks and
> inconsistency with the error handling behavior.
> 
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---

Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")

But not a critical fix, so net-next is okay.

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
>   		page_pool_destroy(priv->rq[i].page_pool);
>   		priv->rq[i].page_pool = NULL;
>   	}

