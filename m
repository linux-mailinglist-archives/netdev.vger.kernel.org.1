Return-Path: <netdev+bounces-33414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF3A79DCF2
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 02:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C957A1C20FAA
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 00:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBE937A;
	Wed, 13 Sep 2023 00:05:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C17F
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:05:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8F710E6
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 17:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694563510; x=1726099510;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=BeRRw9uMA460Bl8pm9R+d0lQVxnJlJGy6Uf6KOOayo0=;
  b=MKMAXlyJpMAqr4n2BdCVLQD/hL5TDbuXiqHlSqYpjemdAVFjg2GcbTuF
   5FMvBqUAB/QdmSNd9kYF0k3uThykH+a7RCS88mOeA7Szz/RryHP9vRz6T
   npjW9KWeKqEmZK+GjjN9CoVPj9qvQoraJwWDaRUzUaGUs/bzL7KY5q2sc
   vzBs0fna2zK6t6mZ5XEoVi3+7A6NsunVumgUQBk2lsSFRoA/JaiYjPHRc
   f6Zt5xLXgwmAnt/QvbOQ0wKeMqNqFmHphL13J3ycQjkNrNClPuzEr1DZT
   NNaAbZQANKhyKbmT9KKPXGJzHQF3ojWCX4W2Frc8urHrizEAzUV2rITb6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368793886"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="368793886"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 17:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809454474"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="809454474"
Received: from yizhang6-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.67.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 17:05:01 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Xabier Marquiegui <reibax@gmail.com>, netdev@vger.kernel.org
Cc: richardcochran@gmail.com, horms@kernel.org,
 chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com, reibax@gmail.com,
 ntp-lists@mattcorallo.com, shuah@kernel.org, davem@davemloft.net,
 rrameshbabu@nvidia.com, alex.maftei@amd.com
Subject: Re: [PATCH net-next v2 1/3] ptp: Replace timestamp event queue with
 linked list
In-Reply-To: <20230912220217.2008895-1-reibax@gmail.com>
References: <20230912220217.2008895-1-reibax@gmail.com>
Date: Tue, 12 Sep 2023 17:05:00 -0700
Message-ID: <875y4fos43.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xabier Marquiegui <reibax@gmail.com> writes:

> This is the first of a set of patches to introduce linked lists to the
> timestamp event queue. The final goal is to be able to have multiple
> readers for the timestamp queue.
>
> On this one we maintain the original feature set, and we just introduce
> the linked lists to the data structure.
>
> Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
> Suggested-by: Richard Cochran <richardcochran@gmail.com>
> ---
> v2:
>   - Style changes to comform to checkpatch strict suggestions
> v1: https://lore.kernel.org/netdev/20230906104754.1324412-2-reibax@gmail.com/
>
>  drivers/ptp/ptp_chardev.c | 16 ++++++++++++++--
>  drivers/ptp/ptp_clock.c   | 30 ++++++++++++++++++++++++++++--
>  drivers/ptp/ptp_private.h |  4 +++-
>  drivers/ptp/ptp_sysfs.c   |  6 +++++-
>  4 files changed, 50 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 362bf756e6b7..197edf1179f1 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -435,10 +435,16 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
>  __poll_t ptp_poll(struct posix_clock *pc, struct file *fp, poll_table *wait)
>  {
>  	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
> +	struct timestamp_event_queue *queue;
>  
>  	poll_wait(fp, &ptp->tsev_wq, wait);
>  
> -	return queue_cnt(&ptp->tsevq) ? EPOLLIN : 0;
> +	/* Extract only the first element in the queue list
> +	 * TODO: Identify the relevant queue
> +	 */
> +	queue = list_entry(&ptp->tsevqs, struct timestamp_event_queue, qlist);
> +
> +	return queue_cnt(queue) ? EPOLLIN : 0;
>  }
>  
>  #define EXTTS_BUFSIZE (PTP_BUF_TIMESTAMPS * sizeof(struct ptp_extts_event))
> @@ -447,12 +453,18 @@ ssize_t ptp_read(struct posix_clock *pc,
>  		 uint rdflags, char __user *buf, size_t cnt)
>  {
>  	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
> -	struct timestamp_event_queue *queue = &ptp->tsevq;
> +	struct timestamp_event_queue *queue;
>  	struct ptp_extts_event *event;
>  	unsigned long flags;
>  	size_t qcnt, i;
>  	int result;
>  
> +	/* Extract only the first element in the queue list
> +	 * TODO: Identify the relevant queue
> +	 */
> +	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
> +				 qlist);
> +
>  	if (cnt % sizeof(struct ptp_extts_event) != 0)
>  		return -EINVAL;
>  
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 80f74e38c2da..7ac04a282ec5 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -166,6 +166,18 @@ static struct posix_clock_operations ptp_clock_ops = {
>  	.read		= ptp_read,
>  };
>  
> +static void ptp_clean_queue_list(struct ptp_clock *ptp)
> +{
> +	struct timestamp_event_queue *element;
> +	struct list_head *pos;
> +
> +	list_for_each(pos, &ptp->tsevqs) {

Here it should be list_for_each_safe().

> +		element = list_entry(pos, struct timestamp_event_queue, qlist);
> +		list_del(pos);
> +		kfree(element);
> +	}
> +}
> +
>  static void ptp_clock_release(struct device *dev)
>  {
>  	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
> @@ -175,6 +187,7 @@ static void ptp_clock_release(struct device *dev)
>  	mutex_destroy(&ptp->tsevq_mux);
>  	mutex_destroy(&ptp->pincfg_mux);
>  	mutex_destroy(&ptp->n_vclocks_mux);
> +	ptp_clean_queue_list(ptp);
>  	ida_free(&ptp_clocks_map, ptp->index);
>  	kfree(ptp);
>  }
> @@ -206,6 +219,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  				     struct device *parent)
>  {
>  	struct ptp_clock *ptp;
> +	struct timestamp_event_queue *queue = NULL;
>  	int err = 0, index, major = MAJOR(ptp_devt);
>  	size_t size;
>  
> @@ -228,7 +242,13 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	ptp->info = info;
>  	ptp->devid = MKDEV(major, index);
>  	ptp->index = index;
> -	spin_lock_init(&ptp->tsevq.lock);
> +	INIT_LIST_HEAD(&ptp->tsevqs);
> +	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> +	if (!queue)
> +		goto no_memory_queue;
> +	spin_lock_init(&queue->lock);
> +	list_add_tail(&queue->qlist, &ptp->tsevqs);
> +	/* TODO - Transform or delete this mutex */
>  	mutex_init(&ptp->tsevq_mux);
>  	mutex_init(&ptp->pincfg_mux);
>  	mutex_init(&ptp->n_vclocks_mux);
> @@ -333,6 +353,8 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	mutex_destroy(&ptp->tsevq_mux);
>  	mutex_destroy(&ptp->pincfg_mux);
>  	mutex_destroy(&ptp->n_vclocks_mux);
> +	ptp_clean_queue_list(ptp);
> +no_memory_queue:
>  	ida_free(&ptp_clocks_map, index);
>  no_slot:
>  	kfree(ptp);
> @@ -375,6 +397,7 @@ EXPORT_SYMBOL(ptp_clock_unregister);
>  
>  void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
>  {
> +	struct timestamp_event_queue *tsevq, *tsevq_alt;
>  	struct pps_event_time evt;
>  
>  	switch (event->type) {
> @@ -383,7 +406,10 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
>  		break;
>  
>  	case PTP_CLOCK_EXTTS:
> -		enqueue_external_timestamp(&ptp->tsevq, event);
> +		/* Enqueue timestamp on all other queues */
> +		list_for_each_entry_safe(tsevq, tsevq_alt, &ptp->tsevqs, qlist) {

The _safe() version is for when the "pos" entry can be removed inside
the loop. No need to use it here.

> +			enqueue_external_timestamp(tsevq, event);
> +		}
>  		wake_up_interruptible(&ptp->tsev_wq);
>  		break;
>  
> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index 75f58fc468a7..314c21c39f6a 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -15,6 +15,7 @@
>  #include <linux/ptp_clock.h>
>  #include <linux/ptp_clock_kernel.h>
>  #include <linux/time.h>
> +#include <linux/list.h>
>  
>  #define PTP_MAX_TIMESTAMPS 128
>  #define PTP_BUF_TIMESTAMPS 30
> @@ -25,6 +26,7 @@ struct timestamp_event_queue {
>  	int head;
>  	int tail;
>  	spinlock_t lock;
> +	struct list_head qlist;
>  };
>  
>  struct ptp_clock {
> @@ -35,7 +37,7 @@ struct ptp_clock {
>  	int index; /* index into clocks.map */
>  	struct pps_device *pps_source;
>  	long dialed_frequency; /* remembers the frequency adjustment */
> -	struct timestamp_event_queue tsevq; /* simple fifo for time stamps */
> +	struct list_head tsevqs; /* timestamp fifo list */
>  	struct mutex tsevq_mux; /* one process at a time reading the fifo */
>  	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
>  	wait_queue_head_t tsev_wq;
> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> index 6e4d5456a885..2675f383cd0a 100644
> --- a/drivers/ptp/ptp_sysfs.c
> +++ b/drivers/ptp/ptp_sysfs.c
> @@ -75,12 +75,16 @@ static ssize_t extts_fifo_show(struct device *dev,
>  			       struct device_attribute *attr, char *page)
>  {
>  	struct ptp_clock *ptp = dev_get_drvdata(dev);
> -	struct timestamp_event_queue *queue = &ptp->tsevq;
> +	struct timestamp_event_queue *queue;
>  	struct ptp_extts_event event;
>  	unsigned long flags;
>  	size_t qcnt;
>  	int cnt = 0;
>  
> +	/* The sysfs fifo will always draw from the fist queue */
> +	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
> +				 qlist);
> +
>  	memset(&event, 0, sizeof(event));
>  
>  	if (mutex_lock_interruptible(&ptp->tsevq_mux))
> -- 
> 2.34.1
>
>

-- 
Vinicius

