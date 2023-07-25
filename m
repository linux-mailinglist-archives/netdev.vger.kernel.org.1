Return-Path: <netdev+bounces-20816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A1B761364
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 13:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796C01C20CB8
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A371D302;
	Tue, 25 Jul 2023 11:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4906C1EA7E
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 11:10:27 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1CD199D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 04:10:24 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VoCzvI0_1690283420;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VoCzvI0_1690283420)
          by smtp.aliyun-inc.com;
          Tue, 25 Jul 2023 19:10:21 +0800
Message-ID: <1690283405.6083395-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix race between set queues and probe
Date: Tue, 25 Jul 2023 19:10:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org,
 mst@redhat.com,
 jasowang@redhat.com
References: <20230725072049.617289-1-jasowang@redhat.com>
In-Reply-To: <20230725072049.617289-1-jasowang@redhat.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 25 Jul 2023 03:20:49 -0400, Jason Wang <jasowang@redhat.com> wrote:
> A race were found where set_channels could be called after registering
> but before virtnet_set_queues() in virtnet_probe(). Fixing this by
> moving the virtnet_set_queues() before netdevice registering. While at
> it, use _virtnet_set_queues() to avoid holding rtnl as the device is
> not even registered at that time.
>
> Fixes: a220871be66f ("virtio-net: correctly enable multiqueue")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0db14f6b87d3..1270c8d23463 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4219,6 +4219,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>
> +	_virtnet_set_queues(vi, vi->curr_queue_pairs);
> +
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
>  	rtnl_lock();
>
> @@ -4257,8 +4259,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_unregister_netdev;
>  	}
>
> -	virtnet_set_queues(vi, vi->curr_queue_pairs);
> -
>  	/* Assume link up if device can't report link status,
>  	   otherwise get link status from config. */
>  	netif_carrier_off(dev);
> --
> 2.39.3
>

