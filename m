Return-Path: <netdev+bounces-166704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C096A37004
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 18:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E983AF1D2
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4482A1DDA2D;
	Sat, 15 Feb 2025 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0R+CpUN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2060714A088
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641991; cv=none; b=TwyE/WZsUxAgbq87iSSXYxJ3ll2qdNDkMPmmJtbGJd60cszf/tyJUfVYj3V/o/8P9yl25OZBbPAF0CTbUL9bo4arav2/XqjQbQL973ur8ofD8YxtwUl5JICtg1r9yWnEw9bYHoJMQ7Anb8yUhGhzB0i3qXXvSezUlQDMaaL8Exk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641991; c=relaxed/simple;
	bh=/VwOi7JHYXww23VMcFdE0eR8CHmnyINnz/AcYnfDQP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/5X6rNh9udBweAKnJneLJKK0XpjoT5P267WXvCRQk9H23uaidk4m+tqHEvChW+2K3MLTHUt9kl/8FvxTXW6GDHWimi5pLW8yN/UHVdgqdEdOqHwWs83ajg7d9vMALvipVpKR5csPZ7MzARU4YT8bWJt1fcHiCjk534YAhOjgos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0R+CpUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5793C4CEDF;
	Sat, 15 Feb 2025 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739641989;
	bh=/VwOi7JHYXww23VMcFdE0eR8CHmnyINnz/AcYnfDQP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m0R+CpUNiW1n1doiqpC0WL/3wWIQU+Jy28drehP+9AV+gQ4w11okvdfjpd/UpRxxH
	 XHF5l5tZ0ztcUe/AF57mMG1tXf/ky5pYiG8HWlpV5rP6YN68ex53IVgO8Db/GiT+42
	 mefae3H/1evbY3XJU7dZZTHL8A6SFBhnOhD8ZBC09n6cI5jCpEsNJH9AdK969ZVcdP
	 1LruU1viBH+5zAhVYtcWTXUZv3O6e9PWF+C7lyvyufHQFSsWUx5ahB1IuxrArmuE5k
	 MK3NgBvR4zNqZ8ZuVGzCSRj1CHBLG/Zmv01sl+xO8Cz+/geFE+S0hWUiLavv8SDa5r
	 rEhmO3N30CDtA==
Date: Sat, 15 Feb 2025 09:53:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com,
 kalesh-anakkur.purayil@broadcom.com, pavan.chebbi@broadcom.com, David
 Arinzon <darinzon@amazon.com>
Subject: Re: [PATCH net-next v8 2/6] net: move ARFS rmap management to core
Message-ID: <20250215095307.44063132@kernel.org>
In-Reply-To: <20250211210657.428439-3-ahmed.zaki@intel.com>
References: <20250211210657.428439-1-ahmed.zaki@intel.com>
	<20250211210657.428439-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 14:06:53 -0700 Ahmed Zaki wrote:
> +static void netif_napi_affinity_release(struct kref *ref)
> +{
> +	struct napi_struct *napi =
> +		container_of(ref, struct napi_struct, notify.kref);
> +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> +

We should only get here from our own cleanup path, otherwise locking
and state sync may be a concern:

	netdev_assert_locked(dev);
	WARN_ON(test_and_clear_bit(NAPI_STATE_HAS_NOTIFIER,
				   &napi->state));

> +	rmap->obj[napi->napi_rmap_idx] = NULL;
> +	napi->napi_rmap_idx = -1;
> +	cpu_rmap_put(rmap);
> +}
> +
> +static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
> +{
> +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> +	int rc;
> +
> +	napi->notify.notify = netif_irq_cpu_rmap_notify;
> +	napi->notify.release = netif_napi_affinity_release;
> +	cpu_rmap_get(rmap);
> +	rc = cpu_rmap_add(rmap, napi);
> +	if (rc < 0)
> +		goto err_add;
> +
> +	napi->napi_rmap_idx = rc;
> +	rc = irq_set_affinity_notifier(irq, &napi->notify);
> +	if (rc)
> +		goto err_set;
> +
> +	set_bit(NAPI_STATE_HAS_NOTIFIER, &napi->state);
> +	return 0;

some of this function is common with the code in 
netif_napi_set_irq_locked()
under 
	} else if (napi->dev->irq_affinity_auto) {

could you refactor this to avoid the duplication 
and make it clearer which parts differ?

> +err_set:
> +	rmap->obj[napi->napi_rmap_idx] = NULL;
> +	napi->napi_rmap_idx = -1;
> +err_add:
> +	cpu_rmap_put(rmap);
> +	return rc;
> +}
> +
> +int netif_enable_cpu_rmap(struct net_device *dev, unsigned int num_irqs)
> +{
> +	if (dev->rx_cpu_rmap_auto)
> +		return 0;
> +
> +	dev->rx_cpu_rmap = alloc_irq_cpu_rmap(num_irqs);
> +	if (!dev->rx_cpu_rmap)
> +		return -ENOMEM;
> +
> +	dev->rx_cpu_rmap_auto = true;
> +	return 0;
> +}
> +EXPORT_SYMBOL(netif_enable_cpu_rmap);
> +
> +static void netif_del_cpu_rmap(struct net_device *dev)
> +{
> +	struct cpu_rmap *rmap = dev->rx_cpu_rmap;
> +
> +	if (!dev->rx_cpu_rmap_auto)
> +		return;
> +
> +	/* Free the rmap */
> +	cpu_rmap_put(rmap);
> +	dev->rx_cpu_rmap = NULL;
> +	dev->rx_cpu_rmap_auto = false;
> +}
> +
> +#else
> +static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
> +{
> +	return 0;
> +}
> +
> +int netif_enable_cpu_rmap(struct net_device *dev, unsigned int num_irqs)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(netif_enable_cpu_rmap);
> +
> +static void netif_del_cpu_rmap(struct net_device *dev)
> +{
> +}
> +#endif
> +
> +void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
> +{
> +	int rc;

maybe netdev_assert_locked_or_invisible(napi->dev); ?

> +	if (napi->irq == irq)
> +		return;
> +
> +	/* Remove existing rmap entries */
> +	if (test_and_clear_bit(NAPI_STATE_HAS_NOTIFIER, &napi->state))
> +		irq_set_affinity_notifier(napi->irq, NULL);
> +
> +	napi->irq = irq;
> +	if (irq < 0)
> +		return;
> +
> +	rc = napi_irq_cpu_rmap_add(napi, irq);
> +	if (rc)
> +		netdev_warn(napi->dev, "Unable to update aRFS map (%d)\n", rc);
> +}
> +EXPORT_SYMBOL(netif_napi_set_irq_locked);
> +
>  static void napi_restore_config(struct napi_struct *n)
>  {
>  	n->defer_hard_irqs = n->config->defer_hard_irqs;

