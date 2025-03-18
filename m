Return-Path: <netdev+bounces-175761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4EBA6769F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF03164294
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA7720E6FD;
	Tue, 18 Mar 2025 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNMzfweX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF220E6EE;
	Tue, 18 Mar 2025 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308685; cv=none; b=Up4JKWSS+mWdOQykEnHLRQqP1pM1EshJ+KcABnpf3SIdULYcvEsbKlX14dCXicfgB3xOppukP3TdlzWUdyI6ddJzQIgSij+aLPSTyLJ5q2Xg1GyWI1jgsWATOqeUfClSBJ4+5SnSxypWARJ/6oC9k5nv/KQA+Q+UANPHqxrzgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308685; c=relaxed/simple;
	bh=ejwnBF4GIKGig2EDSu4c8/gX/9wW1c6s/CBnynlL8iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCEYfZSvn+4cFX3rFhFXnsW2M/jP/hRiF9bYLmIeP1v3nFpvLDjFRmxOpa7h2r5WE5quPMRf3Jn4FaU+qGGQPIw7IENo9RHr/8Nn3x2Iu852EyO6VqNheNkq7r55Jg8dWOISVlYPpGlCHPTv8HMRf/z5+cu9KbsA0FuiJk04GTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNMzfweX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6012C4CEDD;
	Tue, 18 Mar 2025 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742308685;
	bh=ejwnBF4GIKGig2EDSu4c8/gX/9wW1c6s/CBnynlL8iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNMzfweXxxDkbaWkIr/QLOh1qfnx/be+WZ4N5FAgQwfdl0F/Zt1iYTqkRTlA8KLde
	 3sk2qtBYJshllQpzb7W9DBnZaoVwF7EHfWuSMyE6aSLNeHNSBtrGUJFWe72n/PsvYK
	 8gvr02vKfkYhEBqpZtY2/x5dMwb9sn4I2Nx+NBmmMcaQrg0+s6eYqIZSC5lM5dnBVj
	 SUGcNeHmvlAL5lA5CNXvTGeOjcXigh9LKYhk7UiK4BiA7gT74F7k0AnrlyNUTtZnAV
	 BQEbndLoH0QvJdh/e328b6bff5yUpB0DtDCcADGkiuS2tx36zlnN8YFCVpi/P4lmxA
	 d7u3TAh9V+VJg==
Date: Tue, 18 Mar 2025 14:38:00 +0000
From: Simon Horman <horms@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, fw@strlen.de,
	daniel@iogearbox.net, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: fix NULL pointer dereference in l3mdev_l3_rcv
Message-ID: <20250318143800.GA688833@kernel.org>
References: <20250313012713.748006-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313012713.748006-1-wangliang74@huawei.com>

On Thu, Mar 13, 2025 at 09:27:13AM +0800, Wang Liang wrote:
> When delete l3s ipvlan:
> 
>     ip link del link eth0 ipvlan1 type ipvlan mode l3s
> 
> This may cause a null pointer dereference:
> 
>     Call trace:
>      ip_rcv_finish+0x48/0xd0
>      ip_rcv+0x5c/0x100
>      __netif_receive_skb_one_core+0x64/0xb0
>      __netif_receive_skb+0x20/0x80
>      process_backlog+0xb4/0x204
>      napi_poll+0xe8/0x294
>      net_rx_action+0xd8/0x22c
>      __do_softirq+0x12c/0x354
> 
> This is because l3mdev_l3_rcv() visit dev->l3mdev_ops after
> ipvlan_l3s_unregister() assign the dev->l3mdev_ops to NULL. The process
> like this:
> 
>     (CPU1)                     | (CPU2)
>     l3mdev_l3_rcv()            |
>       check dev->priv_flags:   |
>         master = skb->dev;     |
>                                |
>                                | ipvlan_l3s_unregister()
>                                |   set dev->priv_flags
>                                |   dev->l3mdev_ops = NULL;
>                                |
>       visit master->l3mdev_ops |
> 
> Add lock for dev->priv_flags and dev->l3mdev_ops is too expensive. Resolve
> this issue by add check for master->l3mdev_ops.

Hi Wang Liang,

It seems to me that checking master->l3mdev_ops like this is racy.

> 
> Fixes: c675e06a98a4 ("ipvlan: decouple l3s mode dependencies from other modes")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  include/net/l3mdev.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/l3mdev.h b/include/net/l3mdev.h
> index f7fe796e8429..b5af87a35a9f 100644
> --- a/include/net/l3mdev.h
> +++ b/include/net/l3mdev.h
> @@ -165,6 +165,7 @@ static inline
>  struct sk_buff *l3mdev_l3_rcv(struct sk_buff *skb, u16 proto)
>  {
>  	struct net_device *master = NULL;
> +	const struct l3mdev_ops *l3mdev_ops;

If you end up respinning for some other reason, please rearrange the lines
above in reverse xmas tree order - longest line to shortest.

>  
>  	if (netif_is_l3_slave(skb->dev))
>  		master = netdev_master_upper_dev_get_rcu(skb->dev);
> @@ -172,8 +173,12 @@ struct sk_buff *l3mdev_l3_rcv(struct sk_buff *skb, u16 proto)
>  		 netif_has_l3_rx_handler(skb->dev))
>  		master = skb->dev;
>  
> -	if (master && master->l3mdev_ops->l3mdev_l3_rcv)
> -		skb = master->l3mdev_ops->l3mdev_l3_rcv(master, skb, proto);
> +	if (!master)
> +		return skb;
> +
> +	l3mdev_ops = master->l3mdev_ops;
> +	if (l3mdev_ops && l3mdev_ops->l3mdev_l3_rcv)
> +		skb = l3mdev_ops->l3mdev_l3_rcv(master, skb, proto);
>  
>  	return skb;
>  }
> -- 
> 2.34.1
> 

