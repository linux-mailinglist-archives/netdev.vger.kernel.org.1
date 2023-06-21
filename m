Return-Path: <netdev+bounces-12452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2854E737973
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4C61C20C2A
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66BA17C6;
	Wed, 21 Jun 2023 03:03:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413915BE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03ACC433C8;
	Wed, 21 Jun 2023 03:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687316588;
	bh=w2ndax/dIn8hHqRy2GYj3R5SQpIQobIRN1xdBilDOAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ulEKOqncD0TzcZAJbJ/bKEu3UGhtRJ68LnvzU2rdEgAlY4m2qNoaukYimvt50gHTL
	 mR9TVB/BQ1gQwEITI57SurXEBr+om25sVGUA5lDNZxM5BUezSNGWOhR1lsaKCFiXBb
	 PrSZsFQ852f+SitMqZ5GqufLr6KTa6SPGUIze1w4FqWNeNQubVC9S731GYSTIlzu0p
	 mZNgRmCpom3RU42zpSaSk880Fx9isrnlM8jPvO4NkEApP06FjkowmrStJoXq2LUUGd
	 1Wn9tp7cn2Smqi9wTcknL8yOytiUNYz5yr/oi7ivAbsVyGp3SAW+fWbm7CbN1zZHSm
	 bM+7GXzA9YHAQ==
Date: Tue, 20 Jun 2023 20:03:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 opendmb@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, richardcochran@gmail.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, simon.horman@corigine.com
Subject: Re: [PATCH net-next v8 03/11] net: bcmasp: Add support for ASP2.0
 Ethernet controller
Message-ID: <20230620200306.48781299@kernel.org>
In-Reply-To: <1686953664-17498-4-git-send-email-justin.chen@broadcom.com>
References: <1686953664-17498-1-git-send-email-justin.chen@broadcom.com>
	<1686953664-17498-4-git-send-email-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jun 2023 15:14:16 -0700 Justin Chen wrote:
> Add support for the Broadcom ASP 2.0 Ethernet controller which is first
> introduced with 72165. This controller features two distinct Ethernet
> ports that can be independently operated.

First of all - thanks for splitting the patches up.
This one is still a bit big but much better and good enough.

> +	/* Probe each interface (Initialization should continue even if
> +	 * interfaces are unable to come up)
> +	 */
> +	i = 0;
> +	for_each_available_child_of_node(ports_node, intf_node) {
> +		priv->intfs[i] = bcmasp_interface_create(priv, intf_node, i);
> +		i++;
> +	}
> +
> +	/* Drop the clock reference count now and let ndo_open()/ndo_close()
> +	 * manage it for us from now on.
> +	 */
> +	bcmasp_core_clock_set(priv, 0, ASP_CTRL_CLOCK_CTRL_ASP_ALL_DISABLE);
> +
> +	clk_disable_unprepare(priv->clk);
> +
> +	/* Now do the registration of the network ports which will take care
> +	 * of managing the clock properly.
> +	 */
> +	for (i = 0; i < priv->intf_count; i++) {
> +		intf = priv->intfs[i];
> +		if (!intf)
> +			continue;
> +
> +		ret = register_netdev(intf->ndev);
> +		if (ret) {
> +			netdev_err(intf->ndev,
> +				   "failed to register net_device: %d\n", ret);
> +			bcmasp_interface_destroy(intf, false);
> +			continue;

Did you mean to clear the priv->intfs[i] pointer after destroy?
Otherwise remove will try to free it again.

> +		}
> +		count++;
> +	}
> +
> +	dev_info(dev, "Initialized %d port(s)\n", count);
> +
> +of_put_exit:
> +	of_node_put(ports_node);
> +	return ret;

And in case the last register_netdev() fails .probe will return an
error, meaning that .remove will never get called.

Why are you trying to gracefully handle the case where only some ports
were registered? It's error prone, why not fail probe if any netdev
fails to register?

> +}
> +
> +static int bcmasp_remove(struct platform_device *pdev)
> +{
> +	struct bcmasp_priv *priv = dev_get_drvdata(&pdev->dev);
> +	struct bcmasp_intf *intf;
> +	int i;
> +

since .shutdown is defined this callback should probably clear the priv
pointer and check whether priv != NULL before proceeding. It's a bit
unclear whether both .remove and .shutdown may get called for the same
device..

> +	for (i = 0; i < priv->intf_count; i++) {
> +		intf = priv->intfs[i];
> +		if (!intf)
> +			continue;
> +
> +		bcmasp_interface_destroy(intf, true);
> +	}
> +
> +	return 0;
> +}

> +MODULE_AUTHOR("Broadcom");

Companies cannot be authors. MODULE_AUTHOR() is not required,
you can drop it if you don't want to put your name there.

> +	if (unlikely(skb_headroom(skb) < sizeof(*offload))) {
> +		new_skb = skb_realloc_headroom(skb, sizeof(*offload));

That's not right, you can't push to an tx skb just because there's
headroom. Use skb_cow_head().

> +	if (tx_spb_ring_full(intf, nr_frags + 1)) {
> +		netif_stop_queue(dev);
> +		netdev_err(dev, "Tx Ring Full!\n");

rate limit this one, please

> +		/* Calculate virt addr by offsetting from physical addr */
> +		data = intf->rx_ring_cpu +
> +			(DESC_ADDR(desc->buf) - intf->rx_ring_dma);
> +
> +		flags = DESC_FLAGS(desc->buf);
> +		if (unlikely(flags & (DESC_CRC_ERR | DESC_RX_SYM_ERR))) {
> +			netif_err(intf, rx_status, intf->ndev, "flags=0x%llx\n",
> +				  flags);

ditto

> +			u64_stats_update_begin(&stats->syncp);
> +			if (flags & DESC_CRC_ERR)
> +				u64_stats_inc(&stats->rx_crc_errs);
> +			if (flags & DESC_RX_SYM_ERR)
> +				u64_stats_inc(&stats->rx_sym_errs);
> +			u64_stats_inc(&stats->rx_dropped);

Not right, please see the documentation on struct rtnl_link_stats64
These are errors not drops. Please read that comment and double
check all your stats.

> +			u64_stats_update_end(&stats->syncp);
> +
> +			goto next;
> +		}
> +
> +		dma_sync_single_for_cpu(kdev, DESC_ADDR(desc->buf), desc->size,
> +					DMA_FROM_DEVICE);
> +
> +		len = desc->size;
> +
> +		skb = __netdev_alloc_skb(intf->ndev, len,
> +					 GFP_ATOMIC | __GFP_NOWARN);

maybe napi_alloc_skb()? 

> +		if (!skb) {
> +			u64_stats_update_begin(&stats->syncp);
> +			u64_stats_inc(&stats->rx_errors);
> +			u64_stats_update_end(&stats->syncp);
> +
> +			netif_warn(intf, rx_err, intf->ndev,
> +				   "SKB alloc failed\n");

error counter is enough for allocations, OOMs are common

> +			goto next;
> +		}

-- 
pw-bot: cr

