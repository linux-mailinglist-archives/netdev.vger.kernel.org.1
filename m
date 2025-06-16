Return-Path: <netdev+bounces-197948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2FEADA7EB
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 08:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9AA16D5AA
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 06:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1031A13D503;
	Mon, 16 Jun 2025 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Gok1gYV8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01757111AD;
	Mon, 16 Jun 2025 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750053815; cv=none; b=bEhEKzxvt73L0ykOQIOaLTBvei9d1PRkrZnnntBy9ELMo7LePXtnYu0JGdTQsPkuXy2XocOfLQkm0WrN7owtTG/uZbT0O7QH1TZc82JRz5ZEJEIPYnQUxdUE9jOobS+AAyFolpupSWcLiZr8K/hMgHF/o2tem6hLN9GK6Szljqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750053815; c=relaxed/simple;
	bh=mAkQKMb5DZzKW1NS7hwLN9n3+aIz8ZE8fCjPohcXpTs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPFwgQA0nQTqIDxOkgtho8oMLQuBsfiiO8D72BpYE7pSwyCRs2g0uuNqTisb2cK3I2vC4xJMlrDMVc+PGA4TSHeK0uDRhpm+FnDivGU02paM/HlYRqN04pEqM3PmxoW2N9aSZOUNNQno2eWCdjVlwoSb1OvRiQdr9Ihov9+RfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Gok1gYV8; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNV4XC027502;
	Sun, 15 Jun 2025 23:03:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=qY9gN4ReLVhh52McRvfekNpNc
	9LC3gIc4VvlDUL6AF4=; b=Gok1gYV897q5mSB5qRQPhxqtsmah/wCMjJ+jmjwt/
	1ws6nQY5OmfS+RBLh5YphIksg7kEtQ53Ha7cu/e4Nu8icVoG04+npPXFWb6mcEfd
	Fmy2ILwfK90ovq+aA/l6HSeZ/KEu6AqeHSVX6KsfjTq62e8HAiV6HhpFc67Dq10I
	zdt7ejtUos+tEfBZaQaHbitMvVeNvLgoH4bJuc90jjVNdG1h5cYMcy+lYFe4bCfk
	vFAU0D8cAX2XDEjyR91Qn37DS4yZfku7liHfE4jKIwkjofq/vhZvugN6ajvwmzKk
	yz17JiHbjNakOf7y5Fs/0Olad/UiX3lx8cW8no4XkGr1A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47a7w70hnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jun 2025 23:03:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Jun 2025 23:03:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Jun 2025 23:03:07 -0700
Received: from 31f81e0f6c72 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id C0EA15E688C;
	Sun, 15 Jun 2025 23:03:04 -0700 (PDT)
Date: Mon, 16 Jun 2025 06:03:02 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jun Miao <jun.miao@intel.com>
CC: <kuba@kernel.org>, <oneukum@suse.com>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <qiang.zhang@linux.dev>
Subject: Re: [PATCH v4] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Message-ID: <aE-zljYFebNksxw3@31f81e0f6c72>
References: <20250615015315.2535159-1-jun.miao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250615015315.2535159-1-jun.miao@intel.com>
X-Authority-Analysis: v=2.4 cv=BIyzrEQG c=1 sm=1 tr=0 ts=684fb39c cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=5IwCtlCqhDlfZ9k7iu4A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAzOCBTYWx0ZWRfX4XIN+aeWnhe6 wJnWgb5UPkiUFrGvp2E6GsJY0cVVhejewRoSTkeI7wWBW0uSSkpqlVSm/ImZeMUoq67+ThNF5Sp 5WRELYIMPQHv4BMtYXNPwheryKovGLbNoGdxyBOi6Cnf95i4ayBMbK0SsCEQhuAwalXpgUkZvmI
 EAGB2Vg7Qu4Jea6u3ENi6WiJwm/bNGfkyMSb1/VxF3pWg+wTgTQmiJrXgaQNx98Hq/afPFQvB0m Vce7QHlteyCs0AMkYP4q4uEa1P11zV16H3hyyDP/XfZ7sWSvOUGcvDbBTFoyBc2DTozk6Q8TPpj iOSuIxMB2wfqZViCnz9nTs6Op1YvBSrUSytA5gnKTXrml2bDmoS7Tb3Q/rubxhW8ZbcOoi91G+2
 aF/mrOy1BywboyoeaRn09k1w4aAfsyU5G3Pb97y9VvLO8Z/IoD3ZhQFjiC30oAbZIqIlw2fO
X-Proofpoint-ORIG-GUID: 4hpwubIaS66VmsY7WNHek6WY6_quThoP
X-Proofpoint-GUID: 4hpwubIaS66VmsY7WNHek6WY6_quThoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_02,2025-06-13_01,2025-03-28_01

On 2025-06-15 at 01:53:15, Jun Miao (jun.miao@intel.com) wrote:
> Migrate tasklet APIs to the new bottom half workqueue mechanism. It
> replaces all occurrences of tasklet usage with the appropriate workqueue
> APIs throughout the usbnet driver. This transition ensures compatibility
> with the latest design and enhances performance.
> 
> Signed-off-by: Jun Miao <jun.miao@intel.com>

 Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

 Thanks,
 Sundeep

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
> ---
>  drivers/net/usb/usbnet.c   | 36 ++++++++++++++++++------------------
>  include/linux/usb/usbnet.h |  2 +-
>  2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index c04e715a4c2a..7d3791366509 100644
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
> +	INIT_WORK(&dev->bh_work, usbnet_bh_workqueue);
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
> 2.27.0
> 

