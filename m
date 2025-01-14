Return-Path: <netdev+bounces-158255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B74A113D3
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D429188A92C
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA520CCD1;
	Tue, 14 Jan 2025 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQDaUtxH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE01ADC73
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736892496; cv=none; b=IxRhKbD9UZ200dtkMD9RZYxtfavUw8Sfvt6Ej9ck95htJlFJNu/Pus+0yIhur1plQ1+Dd5l6zNBP0jHI3tKqVurg4nt4Q9S6FTuXeoxVDE1Oxwos6Qj3rFepukh6x/mdCYyc99Vn3DqXNLaQaJ6E2NDfqgy0YyiFCzorUy+ovWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736892496; c=relaxed/simple;
	bh=ItiB0l+fKlNWAxsQbsxn9LxOAZq5zvV0CpkPFjCUabM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmXjQyGafPkC2ErkNK/j7aCVFhxRGL8PIdHDezTgLoYi8R0qF/N1JEKXiaB14Uvx0Zbou5EikaW6wpfTYRflfl54rtWrfx2RvPmuDX24czIDDKzl173K+Xz7PUdHRGWap1gUW7CDYsjdP3IA7Re6K+9dvjsh8aVkvvHl5FHgZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQDaUtxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D78C4CEDD;
	Tue, 14 Jan 2025 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736892495;
	bh=ItiB0l+fKlNWAxsQbsxn9LxOAZq5zvV0CpkPFjCUabM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iQDaUtxHqtf5EApRGlWnSV/qmMjOJS1oWEipTskRDJlkQwp9mHNCok6dLUwZgQ/4f
	 cRMGe3tTYQIw9NlG9bHETKsKH3T/MZs+sB4hrWPP6yQckPIKAuLO061mj9pR2WQCgO
	 Ps1AdygTABSP5fDi9WWCrfIRnpS+XVxKg3hlxKU708ZUpoW9ZsIknXPnxrBPTEEBtu
	 wHxPWAN5b77lC4VPz8fnZVFBaglnLcciXZCl0AWGeyaZt0d/Dp+lKZ52zq1uqHsAtI
	 Yk8Br+TdrG7kM2EKUqTd4+JTbFbjCSMotKSS9R5Lr1fg28EQ3C2gWM51XxDiab9BgY
	 T+jGIPw4ggScw==
Date: Tue, 14 Jan 2025 14:08:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com,
 kalesh-anakkur.purayil@broadcom.com, pavan.chebbi@broadcom.com,
 yury.norov@gmail.com, darinzon@amazon.com
Subject: Re: [PATCH net-next v5 1/6] net: move ARFS rmap management to core
Message-ID: <20250114140813.5a7d527f@kernel.org>
In-Reply-To: <20250113171042.158123-2-ahmed.zaki@intel.com>
References: <20250113171042.158123-1-ahmed.zaki@intel.com>
	<20250113171042.158123-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 10:10:37 -0700 Ahmed Zaki wrote:
> -#endif /* CONFIG_RFS_ACCEL */
> +	return netif_enable_cpu_rmap(adapter->netdev, adapter->num_io_queues);
> +#else
>  	return 0;
> +#endif /* CONFIG_RFS_ACCEL */

Let's try to eliminate some of the ifdef-ery on the driver side.
netif_enable_cpu_rmap() should simply do nothing if !CONFIG_RFS_ACCEL

> @@ -2398,6 +2401,9 @@ struct net_device {
> 	struct lock_class_key	*qdisc_tx_busylock;
> 	bool			proto_down;
> 	bool			threaded;
> +#ifdef CONFIG_RFS_ACCEL
> +	bool			rx_cpu_rmap_auto;
> +#endif

similar point, don't hide it, it's just one byte and we can just leave
it as false if !CONFIG_RFS_ACCEL. It can save us a bunch of other ifdefs

> +#ifdef CONFIG_RFS_ACCEL
> +static void netif_disable_cpu_rmap(struct net_device *dev)
> +{
> +	free_irq_cpu_rmap(dev->rx_cpu_rmap);
> +	dev->rx_cpu_rmap = NULL;
> +	dev->rx_cpu_rmap_auto = false;
> +}

Better do do:

static void netif_disable_cpu_rmap(struct net_device *dev)
{
#ifdef CONFIG_RFS_ACCEL
	free_irq_cpu_rmap(dev->rx_cpu_rmap);
	dev->rx_cpu_rmap = NULL;
	dev->rx_cpu_rmap_auto = false;
#endif
}

IOW if not relevant the function should do nothing

> +int netif_enable_cpu_rmap(struct net_device *dev, unsigned int num_irqs)
> +{
> +	dev->rx_cpu_rmap = alloc_irq_cpu_rmap(num_irqs);
> +	if (!dev->rx_cpu_rmap)
> +		return -ENOMEM;
> +
> +	dev->rx_cpu_rmap_auto = true;
> +	return 0;
> +}
> +EXPORT_SYMBOL(netif_enable_cpu_rmap);

here you can depend on dead code elimination:

int netif_enable_cpu_rmap(struct net_device *dev, unsigned int num_irqs)
{
	if (!IS_ENABLED(CONFIG_RFS_ACCEL))
		return 0;

	...
}

> +#endif
> +
> +void netif_napi_set_irq(struct napi_struct *napi, int irq)
> +{
> +#ifdef CONFIG_RFS_ACCEL
> +	int rc;
> +#endif
> +	napi->irq = irq;
> +
> +#ifdef CONFIG_RFS_ACCEL
> +	if (napi->dev->rx_cpu_rmap && napi->dev->rx_cpu_rmap_auto) {
> +		rc = irq_cpu_rmap_add(napi->dev->rx_cpu_rmap, irq);
> +		if (rc) {
> +			netdev_warn(napi->dev, "Unable to update ARFS map (%d)\n",
> +				    rc);
> +			netif_disable_cpu_rmap(napi->dev);
> +		}
> +	}
> +#endif

Declare rc inside the if to avoid the extra ifdef on variable decl

> +}
> +EXPORT_SYMBOL(netif_napi_set_irq);
> +
>  static void napi_restore_config(struct napi_struct *n)
>  {
>  	n->defer_hard_irqs = n->config->defer_hard_irqs;
> @@ -11421,6 +11461,10 @@ void free_netdev(struct net_device *dev)
>  	/* Flush device addresses */
>  	dev_addr_flush(dev);
>  
> +#ifdef CONFIG_RFS_ACCEL
> +	if (dev->rx_cpu_rmap && dev->rx_cpu_rmap_auto)

don't check dev->rx_cpu_rmap, dev->rx_cpu_rmap_auto is enough

> +		netif_disable_cpu_rmap(dev);
> +#endif
>  	list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
>  		netif_napi_del(p);
>  

IRQs are often allocated in ndo_open and freed in ndo_stop, so
you need to catch netif_napi_del or napi_disable and remove
the IRQ from the map.

Similarly netif_napi_set_irq() may get called with -1 to clear
the IRQ number, which you currently treat at a real IRQ id, AFAICT.
-- 
pw-bot: cr

