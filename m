Return-Path: <netdev+bounces-26746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E50C778C17
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D99281C27
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F43FC8;
	Fri, 11 Aug 2023 10:30:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B288746F
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 10:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2BDC433C9;
	Fri, 11 Aug 2023 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691749809;
	bh=roMmYrgyQf7KBy7Bht+pmDDNZCxvp/8xKlMP5epKOpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCdOEFSAuKDu0T4cchKKRFys4NoqU5HU2mrdOwX4nneiER58kVkANE0O0K/m1Zxif
	 LJtmQDAIc8H0x/hX3+Kmub7/2wiMQ4aramaqJ3/N+u3/hcrwko17BshhlzAqfw0/t4
	 YcReQgIvC1GZlX7BhV88sjlIPaJdki9Xbt+N4XPMJ5suolywBGdp1yk3LddxsYYOqg
	 r7Qr3bLaXvk+Y13alMqErWcL/tDMIfy5Gm0BNvvJeISt9V3gx0X6mEKgByO8yyCz1c
	 +cw3bLgBxDycxwaYVnZsp52IyRZNs70nzNI/IGbZrXpJFrv9K+C0vUh25KHV9FiLde
	 BPekgX1aVDuvA==
Date: Fri, 11 Aug 2023 12:30:05 +0200
From: Simon Horman <horms@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 14/17] nvmet-tcp: reference counting for queues
Message-ID: <ZNYNrYXSS02Qqlvn@vergenet.net>
References: <20230810150630.134991-1-hare@suse.de>
 <20230810150630.134991-15-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810150630.134991-15-hare@suse.de>

On Thu, Aug 10, 2023 at 05:06:27PM +0200, Hannes Reinecke wrote:
> The 'queue' structure is referenced from various places and
> used as an argument of asynchronous functions, so it's really
> hard to figure out if the queue is still valid when the
> asynchronous function triggers.
> So add reference counting to validate the queue structure.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/target/tcp.c | 73 ++++++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index ce1d1c5f4e90..a79ede885865 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -127,6 +127,7 @@ enum nvmet_tcp_queue_state {
>  };
>  
>  struct nvmet_tcp_queue {
> +	struct kref		kref;
>  	struct socket		*sock;
>  	struct nvmet_tcp_port	*port;
>  	struct work_struct	io_work;
> @@ -192,6 +193,8 @@ static struct workqueue_struct *nvmet_tcp_wq;
>  static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>  static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>  static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
> +static int nvmet_tcp_get_queue(struct nvmet_tcp_queue *queue);
> +static void nvmet_tcp_put_queue(struct nvmet_tcp_queue *queue);
>  
>  static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>  		struct nvmet_tcp_cmd *cmd)
> @@ -1437,11 +1440,21 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
>  	struct socket *sock = queue->sock;
>  
>  	write_lock_bh(&sock->sk->sk_callback_lock);
> +	/*
> +	 * Check if nvmet_tcp_set_queue_sock() has been called;
> +	 * if not the queue reference has not been increased
> +	 * and we're getting an refcount error on exit.
> +	 */
> +	if (sock->sk->sk_data_ready != nvmet_tcp_data_ready) {

Hi Hannes,

it seems that nvmet_tcp_data_ready is used here,
but doesn't exist until patch 16/17.

> +		write_unlock_bh(&sock->sk->sk_callback_lock);
> +		return;
> +	}
>  	sock->sk->sk_data_ready =  queue->data_ready;
>  	sock->sk->sk_state_change = queue->state_change;
>  	sock->sk->sk_write_space = queue->write_space;
>  	sock->sk->sk_user_data = NULL;
>  	write_unlock_bh(&sock->sk->sk_callback_lock);
> +	nvmet_tcp_put_queue(queue);
>  }

...

