Return-Path: <netdev+bounces-32331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC827942E3
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 20:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB02A281567
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289CE1097D;
	Wed,  6 Sep 2023 18:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006211192
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 18:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C0FC433C8;
	Wed,  6 Sep 2023 18:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694024033;
	bh=N6/aP+dFZ6VkjSuVO3aRPl5YaUOrK+t0rRNDevKHyrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fW5MimRVpuF7CxuIpk2JzmAf88zWw5MOTA1+NKCHXJuuwAQJpJMRC1IkesIXDWJbg
	 M00Hcw6AFbZQHtL2RaEprO4UOTjywtLq6BAC6Iwy7rwQyf8B2Tn5JiaRR9UhO7ThOM
	 2QElf75wymXQxIDX/UIYCAUP1ixLjKGjs8BlOwhrseQfCPomHpG2x5MQc4LZz8+ri1
	 s/NjCHRG4Gh6WPRx5HUbICuO/xTLI5vVNreYhU35D/XyTguw5vWxS6ci5xJ0mLjqly
	 E7l7eUIiRLUs1WOe0wOyQfWSy9OWWWE8w9Pl4BcnSST8KkdTuIJRZfSYyUfIv1lPzB
	 /pon4MxoCMxKg==
Date: Wed, 6 Sep 2023 20:13:49 +0200
From: Simon Horman <horms@kernel.org>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: richardcochran@gmail.com, chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com, netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com
Subject: Re: [PATCH 2/3] ptp: support multiple timestamp event readers
Message-ID: <20230906181349.GE270386@kernel.org>
References: <ZO+8Mlk0yMxz7Tn+@hoboy.vegasvil.org>
 <20230906104754.1324412-1-reibax@gmail.com>
 <20230906104754.1324412-3-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906104754.1324412-3-reibax@gmail.com>

On Wed, Sep 06, 2023 at 12:47:53PM +0200, Xabier Marquiegui wrote:
> Use linked lists to create one event queue per open file. This enables
> simultaneous readers for timestamp event queues.
> 
> Signed-off-by: Xabier Marquiegui <reibax@gmail.com>

Hi Xabier,

some minor feedback from my side

...

> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 1ea11f864abb..c65dc6fefaa6 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -103,9 +103,39 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
>  
>  int ptp_open(struct posix_clock *pc, fmode_t fmode)
>  {
> +	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
> +	struct timestamp_event_queue *queue;
> +
> +	queue = kzalloc(sizeof(struct timestamp_event_queue), GFP_KERNEL);
> +	if (queue == NULL)

nit: this could be: if (!queue)

> +		return -EINVAL;
> +	queue->reader_pid = task_pid_nr(current);
> +	list_add_tail(&queue->qlist, &ptp->tsevqs);
> +
>  	return 0;
>  }

...

> @@ -436,14 +466,25 @@ __poll_t ptp_poll(struct posix_clock *pc, struct file *fp, poll_table *wait)
>  {
>  	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
>  	struct timestamp_event_queue *queue;
> +	struct list_head *pos, *n;
> +	bool found = false;
> +	pid_t reader_pid = task_pid_nr(current);
>  
>  	poll_wait(fp, &ptp->tsev_wq, wait);
>  
>  	/*
> -	 * Extract only the first element in the queue list
> -	 * TODO: Identify the relevant queue
> +	 * Extract only the desired element in the queue list
>  	 */
> -	queue = list_entry(&ptp->tsevqs, struct timestamp_event_queue, qlist);
> +	list_for_each_safe(pos, n, &ptp->tsevqs) {
> +		queue = list_entry(pos, struct timestamp_event_queue, qlist);
> +		if (queue->reader_pid == reader_pid) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return -EINVAL;

Sparse complains that the return type for this function is __poll_t,
but here an int is returned. Perhaps returning EPOLLERR is appropriate here?

>  
>  	return queue_cnt(queue) ? EPOLLIN : 0;
>  }

...

