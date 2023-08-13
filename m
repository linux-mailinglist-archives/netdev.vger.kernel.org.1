Return-Path: <netdev+bounces-27124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C58977A6AB
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB591C2087E
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02646FB4;
	Sun, 13 Aug 2023 14:01:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C493263BF
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 14:01:29 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFD49D
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 07:01:28 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-98273ae42d0so108205766b.0
        for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 07:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691935286; x=1692540086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5M3Rzc1cs+dTUvNeC/T8UQdasBhluUn2gOeSKl8kUnE=;
        b=SUeHBeoVqExCogBhAwS2M+BnokBYN/gxg0JnqBXceXxLmr/I0nd0Y0jFWBewHopyfY
         9HOnw/fTLq9aYjI7Lwx/WgM2d7W7uCTit2oudW5oJsFMn3nUbP3ldrZ9mYkJ2ehKGSZc
         zBc8ajMxVZhTbbjIiVE+59/vYEjX6ckbN9d/JeKSfR9oRkeu3XcYvlR6bxUi/PviV5Gm
         UB5T6VY3vjQGMmKxvFZxXJ74SmxCb1g7sJTEnxkAkbC5rfTXiduoE6V9/X8hq85wYXbK
         FFf/yRDpdgS3+ulF29XVXoRVvQGa7hV8RUul7kMYVt3SBgdfLIqESNnrU+siGHsDBk7E
         x42Q==
X-Gm-Message-State: AOJu0YykIgspGLgauErYDYTl/TwF2s3vEdbX+4+99bsQoN/rYu5LNs7T
	JUMr5z4XDey5j7TIUOTxOqX06jCrArQ=
X-Google-Smtp-Source: AGHT+IEGbKeFa1oqlRlC60ZiU5WeydE/sB9OsrBPu9xRR2mm6gIf6SB9WQ+tZbFpqPn3oA/pcDkx8Q==
X-Received: by 2002:a17:906:220e:b0:99d:acdb:f709 with SMTP id s14-20020a170906220e00b0099dacdbf709mr277026ejs.5.1691935286191;
        Sun, 13 Aug 2023 07:01:26 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id lz15-20020a170906fb0f00b0099bc2d1429csm4617194ejb.72.2023.08.13.07.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:01:25 -0700 (PDT)
Message-ID: <6aa77bb8-8d22-3e40-c8fe-654b5c094b10@grimberg.me>
Date: Sun, 13 Aug 2023 17:01:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 14/17] nvmet-tcp: reference counting for queues
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230811121755.24715-1-hare@suse.de>
 <20230811121755.24715-15-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811121755.24715-15-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/23 15:17, Hannes Reinecke wrote:
> The 'queue' structure is referenced from various places and
> used as an argument of asynchronous functions, so it's really
> hard to figure out if the queue is still valid when the
> asynchronous function triggers.
> So add reference counting to validate the queue structure.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/tcp.c | 74 ++++++++++++++++++++++++++++++---------
>   1 file changed, 57 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index f19ea9d923fd..84b726dfc1c4 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -127,6 +127,7 @@ enum nvmet_tcp_queue_state {
>   };
>   
>   struct nvmet_tcp_queue {
> +	struct kref		kref;
>   	struct socket		*sock;
>   	struct nvmet_tcp_port	*port;
>   	struct work_struct	io_work;
> @@ -192,6 +193,9 @@ static struct workqueue_struct *nvmet_tcp_wq;
>   static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>   static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
> +static int nvmet_tcp_get_queue(struct nvmet_tcp_queue *queue);
> +static void nvmet_tcp_put_queue(struct nvmet_tcp_queue *queue);
> +static void nvmet_tcp_data_ready(struct sock *sk);
>   
>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>   		struct nvmet_tcp_cmd *cmd)
> @@ -1437,11 +1441,21 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
>   	struct socket *sock = queue->sock;
>   
>   	write_lock_bh(&sock->sk->sk_callback_lock);
> +	/*
> +	 * Check if nvmet_tcp_set_queue_sock() has been called;
> +	 * if not the queue reference has not been increased
> +	 * and we're getting an refcount error on exit.
> +	 */
> +	if (sock->sk->sk_data_ready != nvmet_tcp_data_ready) {
> +		write_unlock_bh(&sock->sk->sk_callback_lock);
> +		return;
> +	}

This is really ugly I think.

>   	sock->sk->sk_data_ready =  queue->data_ready;
>   	sock->sk->sk_state_change = queue->state_change;
>   	sock->sk->sk_write_space = queue->write_space;
>   	sock->sk->sk_user_data = NULL;
>   	write_unlock_bh(&sock->sk->sk_callback_lock);
> +	nvmet_tcp_put_queue(queue);
>   }
>   
>   static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
> @@ -1474,6 +1488,30 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
>   		nvmet_tcp_free_cmd_buffers(&queue->connect);
>   }
>   
> +static void nvmet_tcp_release_queue_final(struct kref *kref)
> +{
> +	struct nvmet_tcp_queue *queue = container_of(kref, struct nvmet_tcp_queue, kref);
> +
> +	WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
> +	nvmet_tcp_free_cmds(queue);
> +	ida_free(&nvmet_tcp_queue_ida, queue->idx);
> +	/* ->sock will be released by fput() */
> +	fput(queue->sock->file);
> +	kfree(queue);
> +}
> +
> +static int nvmet_tcp_get_queue(struct nvmet_tcp_queue *queue)
> +{
> +	if (!queue)
> +		return 0;
> +	return kref_get_unless_zero(&queue->kref);
> +}
> +
> +static void nvmet_tcp_put_queue(struct nvmet_tcp_queue *queue)
> +{
> +	kref_put(&queue->kref, nvmet_tcp_release_queue_final);
> +}
> +
>   static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   {
>   	struct page *page;
> @@ -1493,15 +1531,11 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	nvmet_sq_destroy(&queue->nvme_sq);
>   	cancel_work_sync(&queue->io_work);
>   	nvmet_tcp_free_cmd_data_in_buffers(queue);
> -	/* ->sock will be released by fput() */
> -	fput(queue->sock->file);
> -	nvmet_tcp_free_cmds(queue);
>   	if (queue->hdr_digest || queue->data_digest)
>   		nvmet_tcp_free_crypto(queue);
> -	ida_free(&nvmet_tcp_queue_ida, queue->idx);
>   	page = virt_to_head_page(queue->pf_cache.va);
>   	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
> -	kfree(queue);
> +	nvmet_tcp_put_queue(queue);

What made you pick these vs. the others for before/after the
final reference?

>   }
>   
>   static void nvmet_tcp_data_ready(struct sock *sk)
> @@ -1512,8 +1546,10 @@ static void nvmet_tcp_data_ready(struct sock *sk)
>   
>   	read_lock_bh(&sk->sk_callback_lock);
>   	queue = sk->sk_user_data;
> -	if (likely(queue))
> +	if (likely(nvmet_tcp_get_queue(queue))) {
>   		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
> +		nvmet_tcp_put_queue(queue);
> +	}

No... Why?

The shutdown code should serialize perfectly without this. Why add
a kref to the normal I/O path?

I thought we'd simply move release_work to do a kref_put and take
an extra reference when we fire the tls handshake...

>   	read_unlock_bh(&sk->sk_callback_lock);
>   }
>   
> @@ -1523,18 +1559,16 @@ static void nvmet_tcp_write_space(struct sock *sk)
>   
>   	read_lock_bh(&sk->sk_callback_lock);
>   	queue = sk->sk_user_data;
> -	if (unlikely(!queue))
> +	if (unlikely(!nvmet_tcp_get_queue(queue)))
>   		goto out;
>   
>   	if (unlikely(queue->state == NVMET_TCP_Q_CONNECTING)) {
>   		queue->write_space(sk);
> -		goto out;
> -	}
> -
> -	if (sk_stream_is_writeable(sk)) {
> +	} else if (sk_stream_is_writeable(sk)) {
>   		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>   		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
>   	}
> +	nvmet_tcp_put_queue(queue);

Same here...

Why not simply exclude the kref get/put to the tls handshake where
there is actually a race?

>   out:
>   	read_unlock_bh(&sk->sk_callback_lock);
>   }
> @@ -1545,7 +1579,7 @@ static void nvmet_tcp_state_change(struct sock *sk)
>   
>   	read_lock_bh(&sk->sk_callback_lock);
>   	queue = sk->sk_user_data;
> -	if (!queue)
> +	if (!nvmet_tcp_get_queue(queue))
>   		goto done;
>   
>   	switch (sk->sk_state) {
> @@ -1562,6 +1596,7 @@ static void nvmet_tcp_state_change(struct sock *sk)
>   		pr_warn("queue %d unhandled state %d\n",
>   			queue->idx, sk->sk_state);
>   	}
> +	nvmet_tcp_put_queue(queue);
>   done:
>   	read_unlock_bh(&sk->sk_callback_lock);
>   }
> @@ -1582,6 +1617,9 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	if (ret < 0)
>   		return ret;
>   
> +	if (unlikely(!nvmet_tcp_get_queue(queue)))
> +		return -ECONNRESET;
> +

Can this actually fail?

>   	/*
>   	 * Cleanup whatever is sitting in the TCP transmit queue on socket
>   	 * close. This is done to prevent stale data from being sent should
> @@ -1603,6 +1641,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   		 * If the socket is already closing, don't even start
>   		 * consuming it
>   		 */
> +		nvmet_tcp_put_queue(queue);
>   		ret = -ENOTCONN;
>   	} else {
>   		sock->sk->sk_user_data = queue;
> @@ -1636,6 +1675,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   
>   	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
>   	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
> +	kref_init(&queue->kref);
>   	queue->sock = newsock;
>   	queue->port = port;
>   	queue->nr_cmds = 0;
> @@ -1672,15 +1712,15 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
>   
>   	ret = nvmet_tcp_set_queue_sock(queue);
> -	if (ret)
> -		goto out_destroy_sq;
> +	if (!ret)
> +		return;
>   
> -	return;
> -out_destroy_sq:
> +	queue->state = NVMET_TCP_Q_DISCONNECTING;
>   	mutex_lock(&nvmet_tcp_queue_mutex);
>   	list_del_init(&queue->queue_list);
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
> -	nvmet_sq_destroy(&queue->nvme_sq);
> +	nvmet_tcp_put_queue(queue);
> +	return;
>   out_free_connect:
>   	nvmet_tcp_free_cmd(&queue->connect);
>   out_ida_remove:

