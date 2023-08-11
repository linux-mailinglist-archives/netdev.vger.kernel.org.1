Return-Path: <netdev+bounces-26739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7299F778BDB
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D331C20CB8
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130726FC9;
	Fri, 11 Aug 2023 10:19:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D1C6FA1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 10:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05D7C433C7;
	Fri, 11 Aug 2023 10:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691749194;
	bh=E04nCDCoEElo4GIeU5ymaI8EKIYj8gGmoaOYtAc6NpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqiguNGyppu7QC5FxvDPyIzXVoXA8vHP4LuAQz4VVya+3nJRE8kHhTnrrVmOG5yWm
	 dsl3ID3HJ4gbutI7smEsYhlsbHysYlqPIR9HZ0rwGxMbc0a5x4twydhjxvGKhb9Stg
	 xO0nTtTbEuiasoDfrqs03iDsiuYydqOVRMlWjpCnTmwN9+J8ggab4/0ZstxOoImjzs
	 7yUsYkr0nJRDI22VItjwTLtu8XkYsuYcqqDL1bOZr5jmwYsT1aQEkmandKjx+0wEkB
	 Cee1GQsgHOJsodzFOWDtDwTXDbmfEfyFpykLaJjpGB2HQRYMw+s6Ddfmd+Y9/XVFHK
	 m6Zx+uURpgCCQ==
Date: Fri, 11 Aug 2023 12:19:50 +0200
From: Simon Horman <horms@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 07/17] nvme-tcp: allocate socket file
Message-ID: <ZNYLRqZVjr5o3bst@vergenet.net>
References: <20230810150630.134991-1-hare@suse.de>
 <20230810150630.134991-8-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810150630.134991-8-hare@suse.de>

On Thu, Aug 10, 2023 at 05:06:20PM +0200, Hannes Reinecke wrote:
> When using the TLS upcall we need to allocate a socket file such
> that the userspace daemon is able to use the socket.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

...

> @@ -1512,6 +1514,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>  	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>  	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>  	int ret, rcv_pdu_size;
> +	struct file *sock_file;
>  
>  	mutex_init(&queue->queue_lock);
>  	queue->ctrl = ctrl;
> @@ -1534,6 +1537,13 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>  		goto err_destroy_mutex;
>  	}
>  
> +	sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
> +	if (IS_ERR(sock_file)) {
> +		sock_release(queue->sock);

Hi Hannes,

Is it correct to call sock_release() here?
sock_alloc_file() already does so on error.

Flagged by Smatch.

> +		queue->sock = NULL;
> +		ret = PTR_ERR(sock_file);
> +		goto err_destroy_mutex;
> +	}
>  	nvme_tcp_reclassify_socket(queue->sock);
>  
>  	/* Single syn retry */

...

