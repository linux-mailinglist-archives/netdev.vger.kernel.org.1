Return-Path: <netdev+bounces-33416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF7679DCFE
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 02:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E44282373
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 00:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF17637A;
	Wed, 13 Sep 2023 00:11:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35E57F
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:11:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FB4170A
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 17:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694563862; x=1726099862;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xkf7l75g0O3i6EZ0z5UB0ChLZQIhjofCvcNQqKO/UNw=;
  b=LU0nDZfvJbouU6j3KqL0dwZMuOInaPwwGt9E9M7HhV6H+yXb9zNHeu4s
   Zvju2t+Ci8EzN8Z6UylRPWDsSIjg5mqVWhuAcORBVVTX5uqZohR7sPlq4
   AmgRgnm5ev49qj4XJmd/DA7o+pnpyMdv2WoC6m2r8iR7ANXBl2VrlZjms
   0tPeWXCQzSeTa4nQsLbfGd36bbPvpwdXLCKZCSHN+81EoVBT/eKTTfBAJ
   1UBvefBRGjzo7koEv7ZNVLwWMMSS9WzeWwqn5x2l0n/BDT9j2Rnj2VgSO
   KjVhKW10P8vxX1KxfsGx9aoj25HnlU6VpenE+D98H0APVsl9MEe4YtLpn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358800253"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="358800253"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 17:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747093104"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="747093104"
Received: from yizhang6-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.67.184])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 17:11:00 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Xabier Marquiegui <reibax@gmail.com>, netdev@vger.kernel.org
Cc: richardcochran@gmail.com, horms@kernel.org,
 chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com, reibax@gmail.com,
 ntp-lists@mattcorallo.com, shuah@kernel.org, davem@davemloft.net,
 rrameshbabu@nvidia.com, alex.maftei@amd.com
Subject: Re: [PATCH net-next v2 2/3] ptp: support multiple timestamp event
 readers
In-Reply-To: <20230912220217.2008895-2-reibax@gmail.com>
References: <20230912220217.2008895-1-reibax@gmail.com>
 <20230912220217.2008895-2-reibax@gmail.com>
Date: Tue, 12 Sep 2023 17:10:59 -0700
Message-ID: <871qf3oru4.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xabier Marquiegui <reibax@gmail.com> writes:

> Use linked lists to create one event queue per open file. This enables
> simultaneous readers for timestamp event queues.
>
> Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
> Suggested-by: Richard Cochran <richardcochran@gmail.com>
> ---
> v2:
>   - fix ptp_poll() return value
>   - Style changes to comform to checkpatch strict suggestions
>   - more coherent ptp_read error exit routines
> v1: https://lore.kernel.org/netdev/20230906104754.1324412-3-reibax@gmail.com/
>
>  drivers/ptp/ptp_chardev.c | 100 +++++++++++++++++++++++++++++---------
>  drivers/ptp/ptp_clock.c   |   6 +--
>  drivers/ptp/ptp_private.h |   4 +-
>  drivers/ptp/ptp_sysfs.c   |   4 --
>  4 files changed, 82 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 197edf1179f1..c9da0f27d204 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -103,9 +103,39 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
>  
>  int ptp_open(struct posix_clock *pc, fmode_t fmode)
>  {
> +	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
> +	struct timestamp_event_queue *queue;
> +
> +	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> +	if (!queue)
> +		return -EINVAL;
> +	queue->reader_pid = task_pid_nr(current);

Using the pid of the task will break when using some form of file
descriptor passing. e.g. Task A opened the chardev, called the ioctl()
with some mask and then passed the fd to Task B, that's actually going
to use the fd.

Is this something that we want to support? Am I missing something?

> +	list_add_tail(&queue->qlist, &ptp->tsevqs);
> +
>  	return 0;
>  }
>  
> +int ptp_release(struct posix_clock *pc)
> +{
> +	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
> +	struct list_head *pos, *n;
> +	struct timestamp_event_queue *element;
> +	int found = -1;
> +	pid_t reader_pid = task_pid_nr(current);
> +
> +	list_for_each_safe(pos, n, &ptp->tsevqs) {
> +		element = list_entry(pos, struct timestamp_event_queue, qlist);
> +		if (element->reader_pid == reader_pid) {
> +			list_del(pos);
> +			kfree(element);
> +			found = 0;
> +			return found;
> +		}
> +	}
> +
> +	return found;
> +}
> +
>  long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
>  {
>  	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
> @@ -435,14 +465,24 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
>  __poll_t ptp_poll(struct posix_clock *pc, struct file *fp, poll_table *wait)
>  {
>  	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
> +	pid_t reader_pid = task_pid_nr(current);
>  	struct timestamp_event_queue *queue;
> +	struct list_head *pos, *n;
> +	bool found = false;
>  
>  	poll_wait(fp, &ptp->tsev_wq, wait);
>  
> -	/* Extract only the first element in the queue list
> -	 * TODO: Identify the relevant queue
> -	 */
> -	queue = list_entry(&ptp->tsevqs, struct timestamp_event_queue, qlist);
> +	/* Extract only the desired element in the queue list */
> +	list_for_each_safe(pos, n, &ptp->tsevqs) {
> +		queue = list_entry(pos, struct timestamp_event_queue, qlist);
> +		if (queue->reader_pid == reader_pid) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return EPOLLERR;
>  
>  	return queue_cnt(queue) ? EPOLLIN : 0;
>  }
> @@ -453,44 +493,54 @@ ssize_t ptp_read(struct posix_clock *pc,
>  		 uint rdflags, char __user *buf, size_t cnt)
>  {
>  	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
> +	pid_t reader_pid = task_pid_nr(current);
>  	struct timestamp_event_queue *queue;
>  	struct ptp_extts_event *event;
> +	struct list_head *pos, *n;
>  	unsigned long flags;
> +	bool found = false;
>  	size_t qcnt, i;
>  	int result;
>  
> -	/* Extract only the first element in the queue list
> -	 * TODO: Identify the relevant queue
> -	 */
> -	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
> -				 qlist);
> +	/* Extract only the desired element in the queue list */
> +	list_for_each_safe(pos, n, &ptp->tsevqs) {
> +		queue = list_entry(pos, struct timestamp_event_queue, qlist);
> +		if (queue->reader_pid == reader_pid) {
> +			found = true;
> +			break;
> +		}
> +	}
>  
> -	if (cnt % sizeof(struct ptp_extts_event) != 0)
> -		return -EINVAL;
> +	if (!found) {
> +		result = -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (cnt % sizeof(struct ptp_extts_event) != 0) {
> +		result = -EINVAL;
> +		goto exit;
> +	}
>  
>  	if (cnt > EXTTS_BUFSIZE)
>  		cnt = EXTTS_BUFSIZE;
>  
>  	cnt = cnt / sizeof(struct ptp_extts_event);
>  
> -	if (mutex_lock_interruptible(&ptp->tsevq_mux))
> -		return -ERESTARTSYS;
> -
>  	if (wait_event_interruptible(ptp->tsev_wq,
>  				     ptp->defunct || queue_cnt(queue))) {
> -		mutex_unlock(&ptp->tsevq_mux);
> -		return -ERESTARTSYS;
> +		result = -ERESTARTSYS;
> +		goto exit;
>  	}
>  
>  	if (ptp->defunct) {
> -		mutex_unlock(&ptp->tsevq_mux);
> -		return -ENODEV;
> +		result = -ENODEV;
> +		goto exit;
>  	}
>  
>  	event = kmalloc(EXTTS_BUFSIZE, GFP_KERNEL);
>  	if (!event) {
> -		mutex_unlock(&ptp->tsevq_mux);
> -		return -ENOMEM;
> +		result = -ENOMEM;
> +		goto exit;
>  	}
>  
>  	spin_lock_irqsave(&queue->lock, flags);
> @@ -509,12 +559,16 @@ ssize_t ptp_read(struct posix_clock *pc,
>  
>  	cnt = cnt * sizeof(struct ptp_extts_event);
>  
> -	mutex_unlock(&ptp->tsevq_mux);
> -
>  	result = cnt;
> -	if (copy_to_user(buf, event, cnt))
> +	if (copy_to_user(buf, event, cnt)) {
>  		result = -EFAULT;
> +		goto free_event;
> +	}
>  
> +free_event:
>  	kfree(event);
> +exit:
> +	if (result < 0)
> +		ptp_release(pc);
>  	return result;
>  }
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 7ac04a282ec5..d52fc23e20a8 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -162,6 +162,7 @@ static struct posix_clock_operations ptp_clock_ops = {
>  	.clock_settime	= ptp_clock_settime,
>  	.ioctl		= ptp_ioctl,
>  	.open		= ptp_open,
> +	.release	= ptp_release,
>  	.poll		= ptp_poll,
>  	.read		= ptp_read,
>  };
> @@ -184,7 +185,6 @@ static void ptp_clock_release(struct device *dev)
>  
>  	ptp_cleanup_pin_groups(ptp);
>  	kfree(ptp->vclock_index);
> -	mutex_destroy(&ptp->tsevq_mux);
>  	mutex_destroy(&ptp->pincfg_mux);
>  	mutex_destroy(&ptp->n_vclocks_mux);
>  	ptp_clean_queue_list(ptp);
> @@ -246,10 +246,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
>  	if (!queue)
>  		goto no_memory_queue;
> +	queue->reader_pid = 0;
>  	spin_lock_init(&queue->lock);
>  	list_add_tail(&queue->qlist, &ptp->tsevqs);
> -	/* TODO - Transform or delete this mutex */
> -	mutex_init(&ptp->tsevq_mux);
>  	mutex_init(&ptp->pincfg_mux);
>  	mutex_init(&ptp->n_vclocks_mux);
>  	init_waitqueue_head(&ptp->tsev_wq);
> @@ -350,7 +349,6 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	if (ptp->kworker)
>  		kthread_destroy_worker(ptp->kworker);
>  kworker_err:
> -	mutex_destroy(&ptp->tsevq_mux);
>  	mutex_destroy(&ptp->pincfg_mux);
>  	mutex_destroy(&ptp->n_vclocks_mux);
>  	ptp_clean_queue_list(ptp);
> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index 314c21c39f6a..046d1482bcee 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -27,6 +27,7 @@ struct timestamp_event_queue {
>  	int tail;
>  	spinlock_t lock;
>  	struct list_head qlist;
> +	pid_t reader_pid;
>  };
>  
>  struct ptp_clock {
> @@ -38,7 +39,6 @@ struct ptp_clock {
>  	struct pps_device *pps_source;
>  	long dialed_frequency; /* remembers the frequency adjustment */
>  	struct list_head tsevqs; /* timestamp fifo list */
> -	struct mutex tsevq_mux; /* one process at a time reading the fifo */
>  	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
>  	wait_queue_head_t tsev_wq;
>  	int defunct; /* tells readers to go away when clock is being removed */
> @@ -124,6 +124,8 @@ long ptp_ioctl(struct posix_clock *pc,
>  
>  int ptp_open(struct posix_clock *pc, fmode_t fmode);
>  
> +int ptp_release(struct posix_clock *pc);
> +
>  ssize_t ptp_read(struct posix_clock *pc,
>  		 uint flags, char __user *buf, size_t cnt);
>  
> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> index 2675f383cd0a..512b0164ef18 100644
> --- a/drivers/ptp/ptp_sysfs.c
> +++ b/drivers/ptp/ptp_sysfs.c
> @@ -87,9 +87,6 @@ static ssize_t extts_fifo_show(struct device *dev,
>  
>  	memset(&event, 0, sizeof(event));
>  
> -	if (mutex_lock_interruptible(&ptp->tsevq_mux))
> -		return -ERESTARTSYS;
> -
>  	spin_lock_irqsave(&queue->lock, flags);
>  	qcnt = queue_cnt(queue);
>  	if (qcnt) {
> @@ -104,7 +101,6 @@ static ssize_t extts_fifo_show(struct device *dev,
>  	cnt = snprintf(page, PAGE_SIZE, "%u %lld %u\n",
>  		       event.index, event.t.sec, event.t.nsec);
>  out:
> -	mutex_unlock(&ptp->tsevq_mux);
>  	return cnt;
>  }
>  static DEVICE_ATTR(fifo, 0444, extts_fifo_show, NULL);
> -- 
> 2.34.1
>
>

Cheers,
-- 
Vinicius

