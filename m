Return-Path: <netdev+bounces-29135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E161781ACA
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 20:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AC11C208E5
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E6A18AE4;
	Sat, 19 Aug 2023 18:47:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14AC6FB2
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 18:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2923FC433C7;
	Sat, 19 Aug 2023 18:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692470865;
	bh=BJ+Vmrf2zETrsPhc4tGOLa/FWnQ8dNlT9QP+rgPwfHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THTYi+mvO1xz5BPBZvFPagh18tF3MYpWU55ZWn495+qTH8hn+p3euCHJgEf6BoudZ
	 l1aAEL236HAJmvXdbBFUliFaCbugh99FUfY4fwg+uzoGsAmYIcCe9wMv6JYgoWPpox
	 yFQOeiKaE2mmm64YB1ssJft23ApU+vjdIAQ44S73keqzdNKbunCxkm00tLSx6r5zOW
	 WbHhA3qhwJwqBymDKNPykXoqQYwigo2HfNpO+0W/XfKETOhUOdFsbSEgVhkmcic7wd
	 Djgo5TxGV7V4y8WyEN+XcVoVFMGrSv6fToEeauUWM8oWNoMwg9MjZ1HDvzgQfr31xO
	 OCL/rhX0tCBdg==
Date: Sat, 19 Aug 2023 20:47:39 +0200
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/3] net: l2tp_eth: use generic dev->stats fields
Message-ID: <ZOEOS5Qf4o2xw1Gj@vergenet.net>
References: <20230819044059.833749-1-edumazet@google.com>
 <20230819044059.833749-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819044059.833749-4-edumazet@google.com>

On Sat, Aug 19, 2023 at 04:40:59AM +0000, Eric Dumazet wrote:
> Core networking has opt-in atomic variant of dev->stats,
> simply use DEV_STATS_INC(), DEV_STATS_ADD() and DEV_STATS_READ().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/l2tp/l2tp_eth.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c

...

> @@ -146,10 +138,10 @@ static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb,
>  
>  	priv = netdev_priv(dev);
>  	if (dev_forward_skb(dev, skb) == NET_RX_SUCCESS) {
> -		atomic_long_inc(&priv->rx_packets);
> -		atomic_long_add(data_len, &priv->rx_bytes);
> +		DEV_STATS_INC(dev, rx_packets);
> +		DEV_STATS_ADD(dev, rx_bytes, data_len);

Hi Eric,

W=1 builds with clang-16 and gcc-13 tell me that priv
is set but unused if this branch is taken.

>  	} else {
> -		atomic_long_inc(&priv->rx_errors);
> +		DEV_STATS_INC(dev, rx_errors);
>  	}
>  	rcu_read_unlock();
>  
> -- 
> 2.42.0.rc1.204.g551eb34607-goog
> 
> 

