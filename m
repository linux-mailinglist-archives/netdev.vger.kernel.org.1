Return-Path: <netdev+bounces-67246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65BE84275A
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CB81F25869
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A46182D80;
	Tue, 30 Jan 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWswmyEF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AAD82D60
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626704; cv=none; b=eDXL4wUWdBpgI7tx8s0jpCbxcAdsHgGtLB6JbXQ0bcz5aATZFT8GXZ0n7cYnyVO/eGx8mpvHmTOCC2f6hQ6taIKIWZrQETXlnnSsxfDMIm/1e4aG/nkDikqnIhRuw5eKtDIAIizQV5uU4Gm1cYZcGewMLhJJdL/gNYUNZT9v1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626704; c=relaxed/simple;
	bh=u8obcy1IgfbkrMDCvicrV9kH2F2/xLok2g82VK77BsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeEkDk0XzmvD8gQ2jalTgUuBmOZdzwajLioH+5XmEBB8WiPyrSQGUWQv0b5AveUMpezJ9hUsadcXxaHJLPEfIkSSWk0kezGkEUogHdWfT3d2/1HxGCfyr11AKwsW8RbudOcl87AQ4HJHaNEwUkNq9ocuiVbEeEkBjcYu1gqDpsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWswmyEF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706626700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XI6pMe0kUjVi8EnOOEz1gfLA1PE3+qLt1UlOFkwNfTw=;
	b=ZWswmyEFjWvN70A068A91Ox5LZSH6574jCs6dA+r47/E9WV3gaBo/mb/bCsAv2/hbnh31p
	S8exuw9ycE5Ogn3nYuKCNEpQUdgkJOuNiypJ0Yb+NUUOjmu14E2lbRs0QHwgMiaJyoky3H
	SA9dBJZhwtAi5wFeFBZoX372UU7TZjo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-iXgc65Q_P_esjzXxdO6_cA-1; Tue, 30 Jan 2024 09:58:18 -0500
X-MC-Unique: iXgc65Q_P_esjzXxdO6_cA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40efad468a5so9606885e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 06:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626697; x=1707231497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI6pMe0kUjVi8EnOOEz1gfLA1PE3+qLt1UlOFkwNfTw=;
        b=f4txUbnEpuA8/wGkxiLDzW4YFpJgAerI8s4tpV7Ix3QAtx+2FzPA/abqMmBFtPeyt6
         9TjQufZpGQpql/U+f/9P+bbM0oBXtYjRMm3oZZxS+uNE3MPoSMKGOplIjffinVL3qXNZ
         z0aJApah9+keqdRYnIarQNQAZaJPuvH0DABQ+8jJYlE58UZNs4HP2C7H70CDQwrqia3s
         CFlljiuO8p/dvU1TrV46S3qxlpppL26CtBDJ3yymCAk2wwAfXADi4uqHdO8pt0wsEaQp
         WNa8yMkXsSxzZoAq06ssMrKr+qNPFml3WloK3e1Ecb5ZX5lwDeM98nJVgjlI+j6OyB7d
         6TCw==
X-Gm-Message-State: AOJu0YxbM9U1NZhA3AnCfxPWzUbMHfMqaYvp99vtHKVx76uGl66A40LW
	LhQWbX76UXwpa3lnJ4E/1M3gXSSRksBtnmD0M+gy7cdMBOooHYC5Zkv7tEa9jsecfEEDd2xA618
	dRgkQOgLBvPkKfWNz/jw08pXWMR3K5/m/Abd1PPZK+48tjSELezXOBg==
X-Received: by 2002:a5d:4f8c:0:b0:33a:f6ab:7854 with SMTP id d12-20020a5d4f8c000000b0033af6ab7854mr1942438wru.37.1706626697096;
        Tue, 30 Jan 2024 06:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgfMp95sZl9OlfaM0bE9bV05+rr8FjV4V/yXb7oosR5Khg5bNlBlOlfh7bID4ye6VyV6mm+g==
X-Received: by 2002:a5d:4f8c:0:b0:33a:f6ab:7854 with SMTP id d12-20020a5d4f8c000000b0033af6ab7854mr1942426wru.37.1706626696764;
        Tue, 30 Jan 2024 06:58:16 -0800 (PST)
Received: from redhat.com ([2.52.129.159])
        by smtp.gmail.com with ESMTPSA id ay12-20020a5d6f0c000000b0033ad47d7b86sm11046946wrb.27.2024.01.30.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 06:58:16 -0800 (PST)
Date: Tue, 30 Jan 2024 09:58:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, abeni@redhat.com,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240130095645-mutt-send-email-mst@kernel.org>
References: <20240130142521.18593-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130142521.18593-1-danielj@nvidia.com>

On Tue, Jan 30, 2024 at 08:25:21AM -0600, Daniel Jurgens wrote:
> Add a tx queue stop and wake counters, they are useful for debugging.
> 
> 	$ ethtool -S ens5f2 | grep 'tx_stop\|tx_wake'
> 	...
> 	tx_queue_1_tx_stop: 16726
> 	tx_queue_1_tx_wake: 16726
> 	...
> 	tx_queue_8_tx_stop: 1500110
> 	tx_queue_8_tx_wake: 1500110
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Hmm isn't one always same as the other, except when queue is stopped?
And when it is stopped you can see that in the status?
So how is having two useful?


> ---
>  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3cb8aa193884..7e3c31ceaf7e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -88,6 +88,8 @@ struct virtnet_sq_stats {
>  	u64_stats_t xdp_tx_drops;
>  	u64_stats_t kicks;
>  	u64_stats_t tx_timeouts;
> +	u64_stats_t tx_stop;
> +	u64_stats_t tx_wake;
>  };
>  
>  struct virtnet_rq_stats {
> @@ -112,6 +114,8 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
>  	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
>  	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
>  	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
> +	{ "tx_stop",		VIRTNET_SQ_STAT(tx_stop) },
> +	{ "tx_wake",		VIRTNET_SQ_STAT(tx_wake) },
>  };
>  
>  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
> @@ -843,6 +847,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  	 */
>  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
>  		netif_stop_subqueue(dev, qnum);
> +		u64_stats_update_begin(&sq->stats.syncp);
> +		u64_stats_inc(&sq->stats.tx_stop);
> +		u64_stats_update_end(&sq->stats.syncp);
>  		if (use_napi) {
>  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
> @@ -851,6 +858,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  			free_old_xmit_skbs(sq, false);
>  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>  				netif_start_subqueue(dev, qnum);
> +				u64_stats_update_begin(&sq->stats.syncp);
> +				u64_stats_inc(&sq->stats.tx_wake);
> +				u64_stats_update_end(&sq->stats.syncp);
>  				virtqueue_disable_cb(sq->vq);
>  			}
>  		}
> @@ -2163,8 +2173,14 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>  			free_old_xmit_skbs(sq, true);
>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
> -		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> +		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> +			if (netif_tx_queue_stopped(txq)) {
> +				u64_stats_update_begin(&sq->stats.syncp);
> +				u64_stats_inc(&sq->stats.tx_wake);
> +				u64_stats_update_end(&sq->stats.syncp);
> +			}
>  			netif_tx_wake_queue(txq);
> +		}
>  
>  		__netif_tx_unlock(txq);
>  	}
> @@ -2310,8 +2326,14 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	virtqueue_disable_cb(sq->vq);
>  	free_old_xmit_skbs(sq, true);
>  
> -	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> +	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> +		if (netif_tx_queue_stopped(txq)) {
> +			u64_stats_update_begin(&sq->stats.syncp);
> +			u64_stats_inc(&sq->stats.tx_wake);
> +			u64_stats_update_end(&sq->stats.syncp);
> +		}
>  		netif_tx_wake_queue(txq);
> +	}
>  
>  	opaque = virtqueue_enable_cb_prepare(sq->vq);
>  
> -- 
> 2.42.0


