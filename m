Return-Path: <netdev+bounces-47862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCA67EB97B
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 23:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB896B20ABA
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E67915AFF;
	Tue, 14 Nov 2023 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flVef475"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F173306C
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 22:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D24BC433C8;
	Tue, 14 Nov 2023 22:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700001479;
	bh=3h525mpcTJXfGcN1d/YikPiH3wUabMZCV3fu3yOA5sU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=flVef4753t7ddK0p3zuX3mcJ5EQRTR3jIUOEOVNITULsbyMSwYk1tg7k6QmvQp6rr
	 SUEs53BfCjVsf2/IJQdhFsuHdOqRQhKWvpscAfppgVJ+x5ofbBsBPrTOOCWHF9Tv97
	 bz/swB/Yfo/UYhZTwQW0BSLJVkGwz3sM4bAl9pvMOe36VB0qBcWbpNlleeSN1U733e
	 XN07Dw0Ir6Q9TSMic9QY37LsFDN4HdXKtysynomRTHKtimZO1iC9AlrydEW+QhTgaL
	 sXIJ2j9qJFExv717kxPGmrfhfoDBr/OHGHDO2LYMvzVxnb5/PsmMhB7YMKXJbpUhPr
	 iIyx0kRlyj0zg==
Date: Tue, 14 Nov 2023 17:37:57 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Li RongQing <lirongqing@baidu.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 Liam.Howlett@oracle.com, anjali.k.kulkarni@oracle.com, leon@kernel.org,
 fw@strlen.de, shayagr@amazon.com, idosch@nvidia.com, razor@blackwall.org,
 linyunsheng@huawei.com, netdev@vger.kernel.org
Subject: Re: [PATCH][net-next][v2] rtnetlink: instroduce vnlmsg_new and use
 it in rtnl_getlink
Message-ID: <20231114173757.0910964e@kernel.org>
In-Reply-To: <20231114095522.27939-1-lirongqing@baidu.com>
References: <20231114095522.27939-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 17:55:22 +0800 Li RongQing wrote:
> -	nskb = nlmsg_new(if_nlmsg_size(dev, ext_filter_mask), GFP_KERNEL);
> +	nskb = vnlmsg_new(if_nlmsg_size(dev, ext_filter_mask));

Why vnlmsg_new()? nlmsg_ is a prefix, for netlink message.
prefixes do not combine like you're trying to make them.
Can you call it nlmsg_new_large() or similar?

>  	if (nskb == NULL)
>  		goto out;
>  
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index eb086b0..17587f1 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1204,7 +1204,7 @@ struct sock *netlink_getsockbyfilp(struct file *filp)
>  	return sock;
>  }
>  
> -static struct sk_buff *netlink_alloc_large_skb(unsigned int size,
> +struct sk_buff *netlink_alloc_large_skb(unsigned int size,
>  					       int broadcast)

You need to fix the alignment of the continuation line.
Perhaps it now fits in 80chars so line break is not needed?

