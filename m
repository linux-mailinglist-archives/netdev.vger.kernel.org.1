Return-Path: <netdev+bounces-197715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C44AD9B05
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 09:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C933B1AAE
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 07:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9171F4C83;
	Sat, 14 Jun 2025 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YGwdqC8J"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02981F4626;
	Sat, 14 Jun 2025 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885575; cv=none; b=ZWzp6RLD0mBRmPp0fxwXkV2De4Q5D9XcNBU6GE9+jNrCHqBJws0TfLwMog5Fekv8D2s330SlI3CM2VMyICXRG+qJ5ohFrj9VJfqrm0fVSO63NcZVPgdzD7uw3tEf3K223n7FrKerjhVz+QSmzWxS6t7Lws36rJhSrRtbVf/EOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885575; c=relaxed/simple;
	bh=8rtOYA/WZA+rjDDAmZHHbofQb/8+nZK6tFv8eqgUPvg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfDGL1GqDrdxP9NKwY8wlMlzVHXL7AnNB+eUEEQnVbOfu8EGYwyx7LnwE8CcfKXdDgtMyHvZHLUP164rY1ilfTipNtSDBKd9hCKLg97QCTb3WFcIuNo5SAxQa7pMVhUhbKVIdEg2boQIRGGMsWo577//ByRmlSxMv6Ti8U5Xu20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YGwdqC8J; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55E6txwR019299;
	Sat, 14 Jun 2025 00:19:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=R9EP+4e5xygse6/H3jcmwVm8O
	FDv9fIdVCviaza10iE=; b=YGwdqC8JcLmsj9oosnKqycpRNAvT0nm9rGJdhw2oD
	zJIf5aPTZwp1v0lfXCb3uYFec19xkOw79nfVvtP0us5tYgwfUZljmT5F+ip99b0O
	HfS8rJjMKw+HoHaFK89JwFFJY3T2X9rfaz/qfaR9aAeoHklJdF8vrtxbRUkIH+nQ
	76VBmj5CLMxHwgA668jYi3WzzBD5J7dsqUeu1Sv8FKZ5gvUKPPtceYnFE6l0SIKH
	A8p8ArUoPECs28bvZ9VQwXkA8o2WvC4mx+n1Tw68gjN0/djq+PdWd9I1Iwq4qZAG
	mCFcNHWwcYHCeNkjlIac1eWIDEqdCZSTxEpPPWCGZ0RWQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4792mkr3vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Jun 2025 00:19:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 14 Jun 2025 00:19:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 14 Jun 2025 00:19:18 -0700
Received: from 3763e0283353 (unknown [10.28.168.138])
	by maili.marvell.com (Postfix) with SMTP id CFEF25C68E2;
	Sat, 14 Jun 2025 00:19:14 -0700 (PDT)
Date: Sat, 14 Jun 2025 07:19:12 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jun Miao <jun.miao@intel.com>
CC: <kuba@kernel.org>, <oneukum@suse.com>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <qiang.zhang@linux.dev>
Subject: Re: [PATCH v1] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Message-ID: <aE0icNX2nBiopztj@3763e0283353>
References: <20250613124318.2451947-1-jun.miao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250613124318.2451947-1-jun.miao@intel.com>
X-Authority-Analysis: v=2.4 cv=IPYCChvG c=1 sm=1 tr=0 ts=684d2277 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=QyXUC8HyAAAA:8 a=X-fdUdr0RTnJSFWCzdYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE0MDA1OSBTYWx0ZWRfX1/NaLzmyzXcQ P+N/xhthkRf0gQQg7aXpL27ZTMCN4Vy2gMiYCCQl7KeMLSGKN0nbrNjZxC1UvqYNwqBKRAhbOus cfMhjtqO/rsZSVJgMxl3L6iducG7sz5aJlrjdv711K/xY/P4uFPQZXn56WJvXrdtPfU6zGf5PSr
 OAk4ZLk1FZIU9+nX9VF4ZuFmOFbwrNW4u0alN15wctM8kmrqF6wZBUhSr22gdvvfg0g0HH0zf6n 3ldg1AOp4RlEI+jObj9sjVz647QBRilvR03kvQ5yeL9IxV0KLDyvMKYZVsjB5fV491Zf3eusjm3 WqbjobEh24C6oKPBsiZ8fSgo3V/7/S2BecPrc0MQ3LrliJTtsD/tzSOuRoUzka1Zvv1CsQUYOFK
 xLD1ke2sqSkjwEjcqDwgLDLlRUviScfD/a7Rcb9KA+v5iSxb7CFuveqRjYY+vfMsdSu/OCAY
X-Proofpoint-ORIG-GUID: 4roc--ARxm2PqOErGhr521HfKxQCMqsW
X-Proofpoint-GUID: 4roc--ARxm2PqOErGhr521HfKxQCMqsW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-14_02,2025-06-13_01,2025-03-28_01

Hi,

On 2025-06-13 at 12:43:18, Jun Miao (jun.miao@intel.com) wrote:
> Migrate tasklet APIs to the new bottom half workqueue mechanism. It
> replaces all occurrences of tasklet usage with the appropriate workqueue
> APIs throughout the usbnet driver. This transition ensures compatibility
> with the latest design and enhances performance.
> 
> Signed-off-by: Jun Miao <jun.miao@intel.com>
> ---
>  drivers/net/usb/usbnet.c   | 36 ++++++++++++++++++------------------
>  include/linux/usb/usbnet.h |  2 +-
>  2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index c04e715a4c2a..566127b4e0ba 100644
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
> +	/* workqueue could resubmit itself forever if memory is tight */
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
> +// workqueue (work deferred from completions, in_irq) or timer
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
> +static void usbnet_bh_workqueue(struct work_struct *work)
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
> +	INIT_WORK (&dev->bh_work, usbnet_bh_workqueue);

WARNING: space prohibited between function name and open parenthesis '('
#160: FILE: drivers/net/usb/usbnet.c:1745:
+	INIT_WORK (&dev->bh_work, usbnet_bh_workqueue);

total: 0 errors, 1 warnings, 0 checks, 144 lines checked

checkpatch warning here please fix this minor thing and resubmit.

Thanks,
Sundeep

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
> 2.32.0
> 

