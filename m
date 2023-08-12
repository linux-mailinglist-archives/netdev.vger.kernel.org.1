Return-Path: <netdev+bounces-27043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D9D77A013
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 15:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA06281050
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E321763D1;
	Sat, 12 Aug 2023 13:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8A91CCAF
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 13:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320AAC433C9;
	Sat, 12 Aug 2023 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691845850;
	bh=PTDMYrMnnvEC3+6KgZIJedMq4d0m0EkMnMs4B0NEo/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lkan7IkCezGBzBZdH+bNQraGsS/Vq27RKUllz0Ms58XnOsbSODxEGxmwwZkDHIjmG
	 Y/GMdlW6xS/+IN1aPCcjRXKnAYZI+31YfkLJTuDU6NvXReqtBcsO+USHEbe0zr35rx
	 6G9tqb17jkhNQDfEYnW8K57GbX2R6+y7qrS8xnxC1doM9BE0RJm//nrz6UB2WSf1Ib
	 GisCbgbVV//awI8/nWE0dtYs7n6ytZBfD6A2vetNMygE9GQBA6I9bT3wYDmcmyWfjP
	 1vqfSAIM2bqyp2eSTWw8sfTIrJ5HbTV9FO63IJb+qL4oLwhE6Y0FI4ZbGG39KWQZXW
	 SKtQ54VZbhT0Q==
Date: Sat, 12 Aug 2023 15:10:46 +0200
From: Simon Horman <horms@kernel.org>
To: Sishuai Gong <sishuai.system@gmail.com>
Cc: ja@ssi.bg, Linux Kernel Network Developers <netdev@vger.kernel.org>,
	lvs-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH] ipvs: fix racy memcpy in proc_do_sync_threshold
Message-ID: <ZNeE1nYMgWAZqRfc@vergenet.net>
References: <B556FD7B-3190-4C8F-BA83-FC5C147FEAE1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B556FD7B-3190-4C8F-BA83-FC5C147FEAE1@gmail.com>

On Thu, Aug 10, 2023 at 03:12:42PM -0400, Sishuai Gong wrote:

+ Pablo Neira Ayuso <pablo@netfilter.org>
  Florian Westphal <fw@strlen.de>
  Jozsef Kadlecsik <kadlec@netfilter.org>
  netfilter-devel@vger.kernel.org
  coreteam@netfilter.org

> When two threads run proc_do_sync_threshold() in parallel,
> data races could happen between the two memcpy():
> 
> Thread-1			Thread-2
> memcpy(val, valp, sizeof(val));
> 				memcpy(valp, val, sizeof(val));
> 
> This race might mess up the (struct ctl_table *) table->data,
> so we add a mutex lock to serilize them, as discussed in [1].
> 
> [1] https://archive.linuxvirtualserver.org/html/lvs-devel/2023-08/msg00031.html
> 
> Signed-off-by: Sishuai Gong <sishuai.system@gmail.com>

Probably this is a fix for nf and should have:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

In any case, this change looks good to me.

Acked-by: Simon Horman <horms@kernel.org>

> ---
>  net/netfilter/ipvs/ip_vs_ctl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 62606fb44d02..4bb0d90eca1c 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -1876,6 +1876,7 @@ static int
>  proc_do_sync_threshold(struct ctl_table *table, int write,
>  		       void *buffer, size_t *lenp, loff_t *ppos)
>  {
> +	struct netns_ipvs *ipvs = table->extra2;
>  	int *valp = table->data;
>  	int val[2];
>  	int rc;
> @@ -1885,6 +1886,7 @@ proc_do_sync_threshold(struct ctl_table *table, int write,
>  		.mode = table->mode,
>  	};
>  
> +	mutex_lock(&ipvs->sync_mutex);
>  	memcpy(val, valp, sizeof(val));
>  	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
>  	if (write) {
> @@ -1894,6 +1896,7 @@ proc_do_sync_threshold(struct ctl_table *table, int write,
>  		else
>  			memcpy(valp, val, sizeof(val));
>  	}
> +	mutex_unlock(&ipvs->sync_mutex);
>  	return rc;
>  }
>  
> @@ -4321,6 +4324,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  	ipvs->sysctl_sync_threshold[0] = DEFAULT_SYNC_THRESHOLD;
>  	ipvs->sysctl_sync_threshold[1] = DEFAULT_SYNC_PERIOD;
>  	tbl[idx].data = &ipvs->sysctl_sync_threshold;
> +	tbl[idx].extra2 = ipvs;
>  	tbl[idx++].maxlen = sizeof(ipvs->sysctl_sync_threshold);
>  	ipvs->sysctl_sync_refresh_period = DEFAULT_SYNC_REFRESH_PERIOD;
>  	tbl[idx++].data = &ipvs->sysctl_sync_refresh_period;
> -- 
> 2.39.2 (Apple Git-143)
> 

