Return-Path: <netdev+bounces-160649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B07FA1AB14
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 21:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495E21882404
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 20:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E6F1A8408;
	Thu, 23 Jan 2025 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="sk9jR01+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1B146A71
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663510; cv=none; b=EVbH/xzA6qew9ycX5zxw482sK5mZV4hFedWXRNSc1FRCK9jdVeV8vQePqSHyMWvUsfYvNYHNaABeXsNFhtcWcsuu5WFNx/k9Ss5X3STkUqz+K9pTbh1mXtqPLCOKxAmJ1il+AsdDPpUE95hEt6TEbJ0my6skSzJkKqEew4hXcPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663510; c=relaxed/simple;
	bh=31KgoYf125z7wzPt6aBTz5F0sKTllwBuorKaap2ryF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Adk9rFqZafO0FxyFje0qjJ3eyroEyB3pM3rf1NLrIriqPsyrsMXIBLMsoTFmusZGz6jfP90ouwnG3UCbp88Zs9o/RudmLGULmFNzNsbuDogF0RlLElSFw7KTyj9rDQ0z9MBxSgilrnsB5ATVEVgEUrsHHpBnvlSfr/g3vyVNRQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=sk9jR01+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f78a4ca5deso1965760a91.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 12:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737663508; x=1738268308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDn8AmTSVB0kH3UfB4hskAhSERNxv7X8QRfonq5cAbM=;
        b=sk9jR01+wdNlE8PtEw3Xm5FdZk7G4TjIjEsuoe7adSWWUbXZGtDibpJueL1qnU77Qp
         mzwjkWYTUE57N6sy9IXgEmwlXwjF90vMRagdiM8JGRWtRU7i12Nf21HE6nbp0Ot0jL+C
         tU73NxQ1KyUmba735jM9TsUT8G5i2iYNodL0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737663508; x=1738268308;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDn8AmTSVB0kH3UfB4hskAhSERNxv7X8QRfonq5cAbM=;
        b=C5qd0ysJhEk8HsesMGqF/m+FTjjs98H4WwB2oc0uQY3Io5+v1i8oLE3o8diu5MJnkE
         c4TjkCCitWcYyP32KjtVRRlAB3ymiQ4u5GtjL4bS/tDhAQfjH0YRXRotUbnIyZfc9ja1
         ePSzdPBrFO5HMVXxQ+MHrmmxENO/ZaVH30z94qjkQ07D6N/9yy9FEbpH7X3BK3IN7m2p
         3WRIPlnDhoEMJY99U+5UP4xhSqS6KG4yTJ1/CEiw0Y4v69MMbinEJH7xGATf1oPYwugl
         7Phjkl2LYhqy3o3SbmB+m7ki4DtNw4eMkykQIaWTctUkJhh5gUQmeSgBkt0A8NmOhsvB
         oeuA==
X-Gm-Message-State: AOJu0Yyp1LGIWcvkWJ1xol7VJSca9qX/hsnNKIYZHAUtyi7ZF+nMPcQx
	RRJ018/8Gb/lhyuIUFx6KsigPEipgFcDva/NbFqHyTXuViy/Sokj7pPohnu9HMI=
X-Gm-Gg: ASbGnctmhp/KIlE/bdYcrhcQ1U57TtD46ELXC8Jr7+ICm20036CVoPoDlMOOHEpNOcd
	R/r9HSpUlGe4/v3z+5edGR5rMMWxREoxVJJiOWdU6qFjj4oirJDRCj1835p88X5rSG/de2frxUA
	m5RNb3SMGkAs3v6jLC1zC3Qez2b0pmPxRYO3A3cgsZoCyERn6++0KsLAeDMw96JbXOtg9MyfkEu
	ZsgFG1gFeVpASN9pqQaSk/UXqeAi043ca3Iae9lCfeGOTPN0jyj0kxgFoesibwO5xUWNeasG4j9
	RnO2+2uXcusCO2IweOWVks7lRZA5n9vxk+X+lqpDUFqwPKU=
X-Google-Smtp-Source: AGHT+IGG8mMT9xy63Q1Tci1v3aOjMG8ehE5VqEMdDOPs0ky+kTnInX/xnpgJBsYfjpMA0MHFjXNz7g==
X-Received: by 2002:a17:90b:534c:b0:2ee:e317:69ab with SMTP id 98e67ed59e1d1-2f782b01fafmr47985914a91.0.1737663508027;
        Thu, 23 Jan 2025 12:18:28 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa6a725sm143267a91.21.2025.01.23.12.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 12:18:27 -0800 (PST)
Date: Thu, 23 Jan 2025 12:18:24 -0800
From: Joe Damato <jdamato@fastly.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	horms@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	michael.chan@broadcom.com, tariqt@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	shayd@nvidia.com, akpm@linux-foundation.org, shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v6 2/5] net: napi: add CPU affinity to
 napi_config
Message-ID: <Z5KkEF-2NiX4SuB_@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, horms@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
	tariqt@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, shayd@nvidia.com,
	akpm@linux-foundation.org, shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com
References: <20250118003335.155379-1-ahmed.zaki@intel.com>
 <20250118003335.155379-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118003335.155379-3-ahmed.zaki@intel.com>

On Fri, Jan 17, 2025 at 05:33:32PM -0700, Ahmed Zaki wrote:
> A common task for most drivers is to remember the user-set CPU affinity
> to its IRQs. On each netdev reset, the driver should re-assign the
> user's settings to the IRQs.
> 
> Add CPU affinity mask to napi_config. To delegate the CPU affinity
> management to the core, drivers must:
>  1 - set the new netdev flag "irq_affinity_auto":
>                                        netif_enable_irq_affinity(netdev)
>  2 - create the napi with persistent config:
>                                        netif_napi_add_config()
>  3 - bind an IRQ to the napi instance: netif_napi_set_irq()
> 
> the core will then make sure to use re-assign affinity to the napi's
> IRQ.
> 
> The default IRQ mask is set to one cpu starting from the closest NUMA.

Maybe the above is helpful to add to
Documentation/networking/napi.rst ?

> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  include/linux/netdevice.h | 14 ++++++++++-
>  net/core/dev.c            | 51 +++++++++++++++++++++++++++++----------
>  2 files changed, 51 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 98259f19c627..d576e5c91c43 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -351,6 +351,7 @@ struct napi_config {
>  	u64 gro_flush_timeout;
>  	u64 irq_suspend_timeout;
>  	u32 defer_hard_irqs;
> +	cpumask_t affinity_mask;
>  	unsigned int napi_id;
>  };
>  
> @@ -393,8 +394,8 @@ struct napi_struct {
>  	struct list_head	dev_list;
>  	struct hlist_node	napi_hash_node;
>  	int			irq;
> -#ifdef CONFIG_RFS_ACCEL
>  	struct irq_affinity_notify notify;
> +#ifdef CONFIG_RFS_ACCEL
>  	int			napi_rmap_idx;
>  #endif
>  	int			index;
> @@ -1991,6 +1992,11 @@ enum netdev_reg_state {
>   *
>   *	@threaded:	napi threaded mode is enabled
>   *
> + *	@irq_affinity_auto: driver wants the core to manage the IRQ affinity.
> + *			    Set by netif_enable_irq_affinity(), then driver must
> + *			    create persistent napi by netif_napi_add_config()
> + *			    and finally bind napi to IRQ (netif_napi_set_irq).
> + *
>   *	@rx_cpu_rmap_auto: driver wants the core to manage the ARFS rmap.
>   *	                   Set by calling netif_enable_cpu_rmap().
>   *
> @@ -2401,6 +2407,7 @@ struct net_device {
>  	struct lock_class_key	*qdisc_tx_busylock;
>  	bool			proto_down;
>  	bool			threaded;
> +	bool			irq_affinity_auto;
>  	bool			rx_cpu_rmap_auto;
>  
>  	/* priv_flags_slow, ungrouped to save space */
> @@ -2653,6 +2660,11 @@ static inline void netdev_set_ml_priv(struct net_device *dev,
>  	dev->ml_priv_type = type;
>  }
>  
> +static inline void netif_enable_irq_affinity(struct net_device *dev)
> +{
> +	dev->irq_affinity_auto = true;
> +}

I'll have to look at the patches which use the above function, but
the first thing that came to mind when I saw this was does the above
need a WRITE_ONCE ?

The reads below seem to be protected by a lock; I haven't yet looked
at the other patches so maybe the write is also protected by
netdev->lock ?

>  /*
>   * Net namespace inlines
>   */
> diff --git a/net/core/dev.c b/net/core/dev.c
> index dbb63005bc2b..bc82c7f621b3 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[...]

>  
> +#ifdef CONFIG_RFS_ACCEL
>  static void netif_napi_affinity_release(struct kref *ref)
>  {
>  	struct napi_struct *napi =
> @@ -6901,7 +6908,7 @@ static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
>  	if (!rmap)
>  		return -EINVAL;
>  
> -	napi->notify.notify = netif_irq_cpu_rmap_notify;
> +	napi->notify.notify = netif_napi_irq_notify;

Same question as previous patch: does it make sense to only set the
callbacks below when all other operations have succeeded?

>  	napi->notify.release = netif_napi_affinity_release;
>  	cpu_rmap_get(rmap);
>  	rc = cpu_rmap_add(rmap, napi);

[...]

> @@ -6976,23 +6987,28 @@ void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
>  {
>  	int rc;
>  
> -	if (!napi->dev->rx_cpu_rmap_auto)
> -		goto out;
> -
> -	/* Remove existing rmap entries */
> -	if (napi->irq != irq && napi->irq > 0)
> +	/* Remove existing resources */
> +	if ((napi->dev->rx_cpu_rmap_auto || napi->dev->irq_affinity_auto) &&
> +	    napi->irq > 0 && napi->irq != irq)
>  		irq_set_affinity_notifier(napi->irq, NULL);
>  
> -	if (irq > 0) {
> +	if (irq > 0 && napi->dev->rx_cpu_rmap_auto) {
>  		rc = napi_irq_cpu_rmap_add(napi, irq);
>  		if (rc) {
>  			netdev_warn(napi->dev, "Unable to update ARFS map (%d)\n",
>  				    rc);
>  			netif_disable_cpu_rmap(napi->dev);
>  		}
> +	} else if (irq > 0 && napi->config && napi->dev->irq_affinity_auto) {
> +		napi->notify.notify = netif_napi_irq_notify;
> +		napi->notify.release = netif_napi_affinity_release;
> +
> +		rc = irq_set_affinity_notifier(irq, &napi->notify);
> +		if (rc)
> +			netdev_warn(napi->dev, "Unable to set IRQ notifier (%d)\n",
> +				    rc);

I see now that my comments on the previous patch are stale after
this patch is applied. I wonder if the "irq > 0" part can be pulled
out to simplify the branches here?

