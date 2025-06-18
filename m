Return-Path: <netdev+bounces-198995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914DEADE9C9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE6E1898088
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00FB295DA6;
	Wed, 18 Jun 2025 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="brA+zQqS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643A28B503;
	Wed, 18 Jun 2025 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245511; cv=none; b=UY/8uwpQeVSw+cOQyBXoqCUNWl257vsibF00aIzTfL5lvTUIie4f9WpFdQvZql/vO8OiTilpKQrraVrCp7pzCKqqPKDbpkZwuyxVd2PjZ9/f0oxPk9nxhzv4tAxjfXalQokad5DsYGAu8YxX9cxB88Bz8FGEQvv3KwQZV+HX5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245511; c=relaxed/simple;
	bh=q/UKtqSzP/EsB4/fYo8kcyOaPDvWb2CMF4Flj4CIB7E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJP4gTpisccfhygm4KVhpjMxOInWXoAL/2LkjOklNUrqtrGjNzC1I4aKS+kWXqjGhUowsZXtyQS++4sG5gPj2B7DFD77x7B6zGIu0eEq/+bSywPO8Ce2aOAFdswGhdJ2nNT2hNSx+l5wIBT+N+WJnzkBwjKubKMsVQHvJ+s+Uvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=brA+zQqS; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I8xnc1025707;
	Wed, 18 Jun 2025 04:18:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=GPufhOiEHKlWyx42+26tPyGee
	PcA5wQzpXISYdEx5kI=; b=brA+zQqS1YwSuz7qk1FswJRF0rrsYv/cwPUPqJct4
	D8C62JnN39ZYNyJMgqugM5dDUfy1XF1ctwBmHJcmapEZmn4XNaiSaIBphhsKTbRA
	kKBK3p/UVVTqnnqSAKvLhHFU8neSmgnwC6r0pIQHF7bEPnWllNbmjGHa0kFybYJG
	b0D+qJ2mwEbIOCVGfMNpUOxK9xPluSU7onWMsf9A9yAscvjbf4TRMwVPw8ciOLxJ
	5X+K2g47Dt1vPyB0svad+6BPg1PER0gD1iPFNQ8WqOpmcVZWe7ifm0mxw3Uux0Hz
	nNjwCYzScC+ei4MuSZO+uRQ44o53OJE+NoRQgIA8iJ9ww==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47bj4xs8a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 04:18:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Jun 2025 04:18:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Jun 2025 04:18:12 -0700
Received: from de6bfc3b068f (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id E5C063F7044;
	Wed, 18 Jun 2025 04:18:09 -0700 (PDT)
Date: Wed, 18 Jun 2025 11:18:07 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jun Miao <jun.miao@intel.com>
CC: <kuba@kernel.org>, <oneukum@suse.com>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <qiang.zhang@linux.dev>
Subject: Re: [PATCH v5] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Message-ID: <aFKgb-Stl-rIJH6g@de6bfc3b068f>
References: <20250618050559.64974-1-jun.miao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250618050559.64974-1-jun.miao@intel.com>
X-Authority-Analysis: v=2.4 cv=ULrdHDfy c=1 sm=1 tr=0 ts=6852a075 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=QyXUC8HyAAAA:8 a=5IwCtlCqhDlfZ9k7iu4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NiBTYWx0ZWRfX+YAnxTvj/Sse txfFk7mo5mNmqaasCJk5niBCMinjyDNur77AKkh7zwMKD9/iYMY1o7s+yYJcFFeu21aRNVp4qVz SwsbS/Jm+aZegYNSbgYvfujVDBziL+bVnRVaZe2tiLgNJlj+6VmDaiwlolBQIDN8ot0VgAJtm9L
 k8RvgevaHqfxTj5czWYrxeVzMNJNN+oZfKGT+V6I0pGPD2/3QvLuqGDWZ5abMh+84gFrhT/kiod F49d1yASekE75HybDGfTDnNbixueX+/qdTNArD+dNTJHGAWe2O2m9QlZNPEHwT+LeN7F4ly5GdA XafqnfcKXWDKf2p021OeaSsmaQOvbdl7NJqNCwpFdDeCdzoY9+GH3BD0f9OJYGNUa4v+4NqmDNu
 QJyNr5hj0G/GLbEyqGHH9MODAH/4n1g5rMmkktQJ4SloB1U1Pq5LPXjMkXX/iK+2ZbQV9ySz
X-Proofpoint-GUID: xIqRVgh_aZMgYnds_lRp3vrJa68HyLWT
X-Proofpoint-ORIG-GUID: xIqRVgh_aZMgYnds_lRp3vrJa68HyLWT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01

On 2025-06-18 at 05:05:59, Jun Miao (jun.miao@intel.com) wrote:
> Migrate tasklet APIs to the new bottom half workqueue mechanism. It
> replaces all occurrences of tasklet usage with the appropriate workqueue
> APIs throughout the usbnet driver. This transition ensures compatibility
> with the latest design and enhances performance.
> 
> As suggested by Jakub, we have used the system workqueue to schedule on
> (system_bh_wq), so the action performed is usbnet_bh_work() instead of
> usbnet_bh_workqueue() to replace the usbnet_bh_tasklet().

No need to write review comments in commit message.
Patch LGTM.

Thanks,
Sundeep
> 
> Signed-off-by: Jun Miao <jun.miao@intel.com>
> ---
> v1->v2:
>     Check patch warning, delete the more spaces.
> v2->v3:
>     Fix the kernel test robot noticed the following build errors:
>     >> drivers/net/usb/usbnet.c:1974:47: error: 'struct usbnet' has no member named 'bh'
> v3->v4:
> 	Keep "GFP_ATOMIC" flag as it is.
> 	If someone want to change the flags (which Im not sure is correct) it should be a separate commit.
> 
> v4->v5:
> 	As suggested by Jakub, we have used the system workqueue to schedule on(system_bh_wq), 
> 	replace the workqueue with work in usbnet_bh_workqueue() and the comments.
> ---
>  drivers/net/usb/usbnet.c   | 36 ++++++++++++++++++------------------
>  include/linux/usb/usbnet.h |  2 +-
>  2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index c39dfa17813a..234d47bbfec8 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -461,7 +461,7 @@ static enum skb_state defer_bh(struct usbnet *dev, struct sk_buff *skb,
>  
>  	__skb_queue_tail(&dev->done, skb);
>  	if (dev->done.qlen == 1)
> -		tasklet_schedule(&dev->bh);
> +		queue_work(system_bh_wq, &dev->bh_work);
>  	spin_unlock(&dev->done.lock);
>  	spin_unlock_irqrestore(&list->lock, flags);
>  	return old_state;
> @@ -549,7 +549,7 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
>  		default:
>  			netif_dbg(dev, rx_err, dev->net,
>  				  "rx submit, %d\n", retval);
> -			tasklet_schedule (&dev->bh);
> +			queue_work(system_bh_wq, &dev->bh_work);
>  			break;
>  		case 0:
>  			__usbnet_queue_skb(&dev->rxq, skb, rx_start);
> @@ -709,7 +709,7 @@ void usbnet_resume_rx(struct usbnet *dev)
>  		num++;
>  	}
>  
> -	tasklet_schedule(&dev->bh);
> +	queue_work(system_bh_wq, &dev->bh_work);
>  
>  	netif_dbg(dev, rx_status, dev->net,
>  		  "paused rx queue disabled, %d skbs requeued\n", num);
> @@ -778,7 +778,7 @@ void usbnet_unlink_rx_urbs(struct usbnet *dev)
>  {
>  	if (netif_running(dev->net)) {
>  		(void) unlink_urbs (dev, &dev->rxq);
> -		tasklet_schedule(&dev->bh);
> +		queue_work(system_bh_wq, &dev->bh_work);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(usbnet_unlink_rx_urbs);
> @@ -861,14 +861,14 @@ int usbnet_stop (struct net_device *net)
>  	/* deferred work (timer, softirq, task) must also stop */
>  	dev->flags = 0;
>  	timer_delete_sync(&dev->delay);
> -	tasklet_kill(&dev->bh);
> +	disable_work_sync(&dev->bh_work);
>  	cancel_work_sync(&dev->kevent);
>  
>  	/* We have cyclic dependencies. Those calls are needed
>  	 * to break a cycle. We cannot fall into the gaps because
>  	 * we have a flag
>  	 */
> -	tasklet_kill(&dev->bh);
> +	disable_work_sync(&dev->bh_work);
>  	timer_delete_sync(&dev->delay);
>  	cancel_work_sync(&dev->kevent);
>  
> @@ -955,7 +955,7 @@ int usbnet_open (struct net_device *net)
>  	clear_bit(EVENT_RX_KILL, &dev->flags);
>  
>  	// delay posting reads until we're fully open
> -	tasklet_schedule (&dev->bh);
> +	queue_work(system_bh_wq, &dev->bh_work);
>  	if (info->manage_power) {
>  		retval = info->manage_power(dev, 1);
>  		if (retval < 0) {
> @@ -1123,7 +1123,7 @@ static void __handle_link_change(struct usbnet *dev)
>  		 */
>  	} else {
>  		/* submitting URBs for reading packets */
> -		tasklet_schedule(&dev->bh);
> +		queue_work(system_bh_wq, &dev->bh_work);
>  	}
>  
>  	/* hard_mtu or rx_urb_size may change during link change */
> @@ -1198,11 +1198,11 @@ usbnet_deferred_kevent (struct work_struct *work)
>  		} else {
>  			clear_bit (EVENT_RX_HALT, &dev->flags);
>  			if (!usbnet_going_away(dev))
> -				tasklet_schedule(&dev->bh);
> +				queue_work(system_bh_wq, &dev->bh_work);
>  		}
>  	}
>  
> -	/* tasklet could resubmit itself forever if memory is tight */
> +	/* work could resubmit itself forever if memory is tight */
>  	if (test_bit (EVENT_RX_MEMORY, &dev->flags)) {
>  		struct urb	*urb = NULL;
>  		int resched = 1;
> @@ -1224,7 +1224,7 @@ usbnet_deferred_kevent (struct work_struct *work)
>  fail_lowmem:
>  			if (resched)
>  				if (!usbnet_going_away(dev))
> -					tasklet_schedule(&dev->bh);
> +					queue_work(system_bh_wq, &dev->bh_work);
>  		}
>  	}
>  
> @@ -1325,7 +1325,7 @@ void usbnet_tx_timeout (struct net_device *net, unsigned int txqueue)
>  	struct usbnet		*dev = netdev_priv(net);
>  
>  	unlink_urbs (dev, &dev->txq);
> -	tasklet_schedule (&dev->bh);
> +	queue_work(system_bh_wq, &dev->bh_work);
>  	/* this needs to be handled individually because the generic layer
>  	 * doesn't know what is sufficient and could not restore private
>  	 * information if a remedy of an unconditional reset were used.
> @@ -1547,7 +1547,7 @@ static inline void usb_free_skb(struct sk_buff *skb)
>  
>  /*-------------------------------------------------------------------------*/
>  
> -// tasklet (work deferred from completions, in_irq) or timer
> +// work (work deferred from completions, in_irq) or timer
>  
>  static void usbnet_bh (struct timer_list *t)
>  {
> @@ -1601,16 +1601,16 @@ static void usbnet_bh (struct timer_list *t)
>  					  "rxqlen %d --> %d\n",
>  					  temp, dev->rxq.qlen);
>  			if (dev->rxq.qlen < RX_QLEN(dev))
> -				tasklet_schedule (&dev->bh);
> +				queue_work(system_bh_wq, &dev->bh_work);
>  		}
>  		if (dev->txq.qlen < TX_QLEN (dev))
>  			netif_wake_queue (dev->net);
>  	}
>  }
>  
> -static void usbnet_bh_tasklet(struct tasklet_struct *t)
> +static void usbnet_bh_work(struct work_struct *work)
>  {
> -	struct usbnet *dev = from_tasklet(dev, t, bh);
> +	struct usbnet *dev = from_work(dev, work, bh_work);
>  
>  	usbnet_bh(&dev->delay);
>  }
> @@ -1742,7 +1742,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
>  	skb_queue_head_init (&dev->txq);
>  	skb_queue_head_init (&dev->done);
>  	skb_queue_head_init(&dev->rxq_pause);
> -	tasklet_setup(&dev->bh, usbnet_bh_tasklet);
> +	INIT_WORK(&dev->bh_work, usbnet_bh_work);
>  	INIT_WORK (&dev->kevent, usbnet_deferred_kevent);
>  	init_usb_anchor(&dev->deferred);
>  	timer_setup(&dev->delay, usbnet_bh, 0);
> @@ -1971,7 +1971,7 @@ int usbnet_resume (struct usb_interface *intf)
>  
>  			if (!(dev->txq.qlen >= TX_QLEN(dev)))
>  				netif_tx_wake_all_queues(dev->net);
> -			tasklet_schedule (&dev->bh);
> +			queue_work(system_bh_wq, &dev->bh_work);
>  		}
>  	}
>  
> diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
> index 0b9f1e598e3a..208682f77179 100644
> --- a/include/linux/usb/usbnet.h
> +++ b/include/linux/usb/usbnet.h
> @@ -58,7 +58,7 @@ struct usbnet {
>  	unsigned		interrupt_count;
>  	struct mutex		interrupt_mutex;
>  	struct usb_anchor	deferred;
> -	struct tasklet_struct	bh;
> +	struct work_struct	bh_work;
>  
>  	struct work_struct	kevent;
>  	unsigned long		flags;
> -- 
> 2.43.0
> 

