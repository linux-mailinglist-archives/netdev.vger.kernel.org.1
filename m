Return-Path: <netdev+bounces-22624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD72D76859E
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 15:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0571C209FB
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BC31FD6;
	Sun, 30 Jul 2023 13:32:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A821FBD
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 13:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FD6C433C9;
	Sun, 30 Jul 2023 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690723943;
	bh=lNmBx86vKk1Fzpc/aMLSCl3TcRlTY1pUXLYarmo2pTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WiyhJf/JlEM3+yEEfz61ekspCLhw4VVM5YFbjKmiPtvC/p46njQUPm5eiwnnx4nRa
	 7DRNR3xccX+xeUh4F4swYl9TYC9fKRr2xvUvnqktyDhdqhlWxEzl+oC/eyTraxwbxl
	 wz4U0KPCK5tUmDYKY5Wcosh1K19Dmq/Ezl7nOjsGicPTMVwCGV9+BQzoRDvuCpdz0m
	 VdR/hulwoMW9kYakGWfRU8K/a7FBs1ZV/GEAPVUQ32VefgbexhS1xd1+hsVJKHCtVL
	 t5dxMM4A+9s2tS3nbUBSs4JaZmoek+UbkNstf7eny7naYiKSRTZy8Ez6v3y8/6ICwg
	 PQflrtI1Vvn7w==
Date: Sun, 30 Jul 2023 16:32:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next] net: make sure we never create ifindex = 0
Message-ID: <20230730133219.GG94048@unreal>
References: <20230729015623.17373-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729015623.17373-1-kuba@kernel.org>

On Fri, Jul 28, 2023 at 06:56:23PM -0700, Jakub Kicinski wrote:
> Instead of allocating from 1 use proper xa_limit, to protect
> ourselves from IDs wrapping back to 0.
> 
> Fixes: 759ab1edb56c ("net: store netdevs in an xarray")
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Link: https://lore.kernel.org/all/20230728162350.2a6d4979@hermes.local/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: leon@kernel.org
> ---
>  net/core/dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index b58674774a57..2312ca67b95e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9587,7 +9587,8 @@ static int dev_index_reserve(struct net *net, u32 ifindex)
>  
>  	if (!ifindex)
>  		err = xa_alloc_cyclic(&net->dev_by_index, &ifindex, NULL,
> -				      xa_limit_31b, &net->ifindex, GFP_KERNEL);
> +				      XA_LIMIT(1, INT_MAX), &net->ifindex,
> +				      GFP_KERNEL);
>  	else
>  		err = xa_insert(&net->dev_by_index, ifindex, NULL, GFP_KERNEL);
>  	if (err < 0)
> @@ -11271,7 +11272,6 @@ static int __net_init netdev_init(struct net *net)
>  	if (net->dev_index_head == NULL)
>  		goto err_idx;
>  
> -	net->ifindex = 1;
>  	xa_init_flags(&net->dev_by_index, XA_FLAGS_ALLOC);

You don't need to change xa_limit_31b, just change XA_FLAGS_ALLOC to be XA_FLAGS_ALLOC1
and allocations will start from 1.

Thanks

>  
>  	RAW_INIT_NOTIFIER_HEAD(&net->netdev_chain);
> -- 
> 2.41.0
> 

