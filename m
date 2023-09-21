Return-Path: <netdev+bounces-35616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 604BC7AA2F1
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 23:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id E3E76B20A41
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70740199C3;
	Thu, 21 Sep 2023 21:43:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617551947B
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 21:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32C1C433C7;
	Thu, 21 Sep 2023 21:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695332613;
	bh=Y6bFPfkkO6qcZgXwuTDH+EvOgNtkp6C+OnOSAJn+fIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=capmzZ2foQYMZEhjVU0PLTsKCu1mjKJTq1wIHOtey79fmIO2FM6Yr5WKx+q4nFyHt
	 X0hnnVLSC+4QyFTSZig2ptkrlbQvaNjEgyMV8f/BVL2z4RQByfrktmJj3cyatQu5rC
	 VZVfWCY4FMXh60oGnD05BuVpiId3wwdyC+fL6yZiFQTl3PN55s51eb6odDw6WHXgyn
	 qF5q6ZWyNYs5PVwGceQm9fN01d4JflXueiJk2hArQ5MZPkls/CMEbqBVRigFj0pDe+
	 ZFMYrr5Zei9LsQUvfh66eW50UEyaLTu7cDRJqFEDqeW2CGg8jHo8DV2GaShkMx1WTR
	 k+JiyT2uk4xIw==
Date: Thu, 21 Sep 2023 22:43:25 +0100
From: Simon Horman <horms@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while
 closing listen socket
Message-ID: <20230921214325.GS224399@kernel.org>
References: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>

On Wed, Sep 20, 2023 at 08:08:34PM +0800, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> Consider the following scenarios:
> 
> smc_release
> 	smc_close_active
> 		write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
> 		smc->clcsock->sk->sk_user_data = NULL;
> 		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
> 
> smc_tcp_syn_recv_sock
> 	smc = smc_clcsock_user_data(sk);
> 	/* now */
> 	/* smc == NULL */
> 
> Hence, we may read the a NULL value in smc_tcp_syn_recv_sock(). And
> since we only unset sk_user_data during smc_release, it's safe to
> drop the incoming tcp reqsock.
> 
> Fixes:  ("net/smc: net/smc: Limit backlog connections"

The tag above is malformed. The correct form is:

Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")

> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  net/smc/af_smc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index bacdd97..b4acf47 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -125,6 +125,8 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  	struct sock *child;
>  
>  	smc = smc_clcsock_user_data(sk);
> +	if (unlikely(!smc))
> +		goto drop;
>  
>  	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
>  				sk->sk_max_ack_backlog)
> -- 
> 1.8.3.1
> 
> 

