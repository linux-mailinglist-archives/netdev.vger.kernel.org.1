Return-Path: <netdev+bounces-37278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 042767B484A
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 17:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A71E6282192
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392E517992;
	Sun,  1 Oct 2023 15:06:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB85247
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 15:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74742C433C8;
	Sun,  1 Oct 2023 15:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696172780;
	bh=9ycBs/E3VKS6FnpElHe45CjMEj/JLsMAiH7Cxekezfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGaVcmNlL1Th/q7bXrsSf7Af9cMxocqLPPL22Gm0cRR718UC9BwfNe8Fe8I6YteO1
	 9DDKFhYWam+g/ldoVc/+KqrbgM+JMA7fXm8NvYvsa5pRf1gP2Th9dVC0woJtkdyfvX
	 iEVcm61Knx1e0c+JIMY8g2gZUrCwSxIuj7ORR++yiAKXYlGbO6r3dbhWTdGPVlVhLu
	 kt6iUbTgQbSsXYZ7cx4P3ArDejlP1Gv6yEg7zCnKq9O/tJffbnw1ngeeIE84DAHCxF
	 l1c2hhYWRmk7lXygbVU34U313+VYtd17eTbrnhfMmFJC+oDw5duVCnkDH/49j6ZNXO
	 SBtZHSq2YFezQ==
Date: Sun, 1 Oct 2023 17:06:15 +0200
From: Simon Horman <horms@kernel.org>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
	chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	ntp-lists@mattcorallo.com, vinicius.gomes@intel.com,
	alex.maftei@amd.com, davem@davemloft.net, rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: Re: [PATCH net-next v3 2/3] ptp: support multiple timestamp event
 readers
Message-ID: <20231001150615.GP92317@kernel.org>
References: <20230928133544.3642650-1-reibax@gmail.com>
 <20230928133544.3642650-3-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928133544.3642650-3-reibax@gmail.com>

On Thu, Sep 28, 2023 at 03:35:43PM +0200, Xabier Marquiegui wrote:
> Use linked lists to create one event queue per open file. This enables
> simultaneous readers for timestamp event queues.
> 
> Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
> Suggested-by: Richard Cochran <richardcochran@gmail.com>

Hi Xabier,

some minor feedback from Smatch via myself follows.

> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 197edf1179f1..65e7acaa40a9 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -101,14 +101,74 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
>  	return 0;
>  }
>  
> -int ptp_open(struct posix_clock *pc, fmode_t fmode)
> +int ptp_open(struct posix_clock_user *pcuser, fmode_t fmode)
>  {
> +	struct ptp_clock *ptp =
> +		container_of(pcuser->clk, struct ptp_clock, clock);
> +	struct ida *ida = ptp_get_tsevq_ida(ptp);
> +	struct timestamp_event_queue *queue;
> +
> +	if (!ida)
> +		return -EINVAL;
> +	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> +	if (!queue)
> +		return -EINVAL;
> +	queue->close_req = false;
> +	queue->reader_pid = task_pid_nr(current);
> +	spin_lock_init(&queue->lock);
> +	queue->ida = ida;
> +	queue->oid = ida_alloc(ida, GFP_KERNEL);
> +	if (queue->oid < 0) {
> +		kfree(queue);

queue is freed on the line above but dereferenced on the line below.

As flagged by Smatch.

> +		return queue->oid;
> +	}
> +	list_add_tail(&queue->qlist, &ptp->tsevqs);
> +	pcuser->private_clkdata = queue;
> +
>  	return 0;
>  }

...

> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c

...

> @@ -243,15 +275,23 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	ptp->devid = MKDEV(major, index);
>  	ptp->index = index;
>  	INIT_LIST_HEAD(&ptp->tsevqs);
> +	INIT_LIST_HEAD(&ptp->closed_tsevqs);
>  	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
>  	if (!queue)
>  		goto no_memory_queue;
> +	queue->close_req = false;
> +	queue->ida = kzalloc(sizeof(*queue->ida), GFP_KERNEL);
> +	if (!queue->ida)
> +		goto no_memory_queue;

It's not clear to me that queue isn't leaked here.

As flagged by Smatch.

> +	ida_init(queue->ida);
>  	spin_lock_init(&queue->lock);
>  	list_add_tail(&queue->qlist, &ptp->tsevqs);
> -	/* TODO - Transform or delete this mutex */
> -	mutex_init(&ptp->tsevq_mux);
> +	queue->oid = ida_alloc(queue->ida, GFP_KERNEL);
> +	if (queue->oid < 0)
> +		goto ida_err;
>  	mutex_init(&ptp->pincfg_mux);
>  	mutex_init(&ptp->n_vclocks_mux);
> +	mutex_init(&ptp->close_mux);
>  	init_waitqueue_head(&ptp->tsev_wq);
>  
>  	if (ptp->info->getcycles64 || ptp->info->getcyclesx64) {
> @@ -350,9 +390,10 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	if (ptp->kworker)
>  		kthread_destroy_worker(ptp->kworker);
>  kworker_err:
> -	mutex_destroy(&ptp->tsevq_mux);
>  	mutex_destroy(&ptp->pincfg_mux);
>  	mutex_destroy(&ptp->n_vclocks_mux);
> +	mutex_destroy(&ptp->close_mux);
> +ida_err:
>  	ptp_clean_queue_list(ptp);
>  no_memory_queue:
>  	ida_free(&ptp_clocks_map, index);

...

