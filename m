Return-Path: <netdev+bounces-134160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B918998369
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF896282284
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA681BE857;
	Thu, 10 Oct 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfAzzQhB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0A1BDAB8;
	Thu, 10 Oct 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555728; cv=none; b=qDbupsWn2WU58+q8RT0ZkOGcDaVMS+aE94wTmbwDc8oT1BWFojol9AROInJ3e+pCcJ15XgEi86VEPjvJn5nJuT6Y/GKb14+HBwroo21s+DSa3uD4MJDzxmIBvoBpNr7bs6I/fKyiwK6SAsVwiTHoG4LNw8snmWBpg1WJ1Io+z/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555728; c=relaxed/simple;
	bh=noMQNUM0FgQjj7sTljBuE+0agFGGBwUO1uePFbZXEoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0PZYhC521GW6Q+lhtF4HHGnUtmfenDF7Gi+Od4UN2Wwdv5hYozohezxU0l1VkDAUh3GGDvwl9MmFXLWejR1v2KM4TH5RY0u6RPwOwXIGUlyBKI23v95wGCZbgzQ/taKht9JVr11wU5E/iofOQ0gR61hcI/Zm7ILcN7QrE+df+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfAzzQhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6061FC4CED4;
	Thu, 10 Oct 2024 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728555727;
	bh=noMQNUM0FgQjj7sTljBuE+0agFGGBwUO1uePFbZXEoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfAzzQhB7zXjxgBqto5C6yVPKnsNdIhtv8ZUuDlmzP/q34AgMSUUQhCCPZSVWMu9l
	 0CjN+Pqpl9lcyV57cAolX8onG1L2/dlwY4ofv3Oszmg7fpVQYJash268DpTuh7nI6T
	 rtMJ1NdsHUyU0R3stPra2CEta2W2YOliuxtxyvyRBV8eun2TZH46vMn86iYtoHpN24
	 NE5p2pmFGiYX1O1G7mQZU/Cs1J+C9k6q0ZzEVAckSQQVK3nLZ0buzbvdH2aXkAcPhA
	 Nm7nIIGQF0hu9jrLU6fzFVpnPoBHCTn5LjGPekxlllfuwEwCKzKdKz4VDwC4LLQgxi
	 NQQ2tiMi1dJ/Q==
Date: Thu, 10 Oct 2024 11:22:01 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
	jdamato@fastly.com, kalesh-anakkur.purayil@broadcom.com,
	christophe.jaillet@wanadoo.fr, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11 net-next 04/10] net: hibmcge: Add interrupt supported
 in this module
Message-ID: <20241010102201.GG1098236@kernel.org>
References: <20241008022358.863393-1-shaojijie@huawei.com>
 <20241008022358.863393-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008022358.863393-5-shaojijie@huawei.com>

On Tue, Oct 08, 2024 at 10:23:52AM +0800, Jijie Shao wrote:
> The driver supports four interrupts: TX interrupt, RX interrupt,
> mdio interrupt, and error interrupt.
> 
> Actually, the driver does not use the mdio interrupt.
> Therefore, the driver does not request the mdio interrupt.
> 
> The error interrupt distinguishes different error information
> by using different masks. To distinguish different errors,
> the statistics count is added for each error.
> 
> To ensure the consistency of the code process, masks are added for the
> TX interrupt and RX interrupt.
> 
> This patch implements interrupt request, and provides a
> unified entry for the interrupt handler function. However,
> the specific interrupt handler function of each interrupt
> is not implemented currently.
> 
> Because of pcim_enable_device(), the interrupt vector
> is already device managed and does not need to be free actively.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

...

> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c

...

> +static const char *irq_names_map[HBG_VECTOR_NUM] = { "tx", "rx", "err", "mdio" };
> +
> +int hbg_irq_init(struct hbg_priv *priv)
> +{
> +	struct hbg_vector *vectors = &priv->vectors;
> +	struct device *dev = &priv->pdev->dev;
> +	int ret, id;
> +	u32 i;
> +
> +	/* used pcim_enable_device(),  so the vectors become device managed */
> +	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to allocate MSI vectors\n");
> +
> +	if (ret != HBG_VECTOR_NUM)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "requested %u MSI, but allocated %d MSI\n",
> +				     HBG_VECTOR_NUM, ret);
> +
> +	/* mdio irq not requested, so the number of requested interrupts
> +	 * is HBG_VECTOR_NUM - 1.
> +	 */
> +	for (i = 0; i < HBG_VECTOR_NUM - 1; i++) {
> +		id = pci_irq_vector(priv->pdev, i);
> +		if (id < 0)
> +			return dev_err_probe(dev, id, "failed to get irq number\n");
> +
> +		snprintf(vectors->name[i], sizeof(vectors->name[i]), "%s-%s-%s",
> +			 dev_driver_string(dev), pci_name(priv->pdev),
> +			 irq_names_map[i]);
> +
> +		ret = devm_request_irq(dev, id, hbg_irq_handle, 0,
> +				       vectors->name[i], priv);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to requset irq: %s\n",

nit: request

> +					     irq_names_map[i]);
> +	}
> +
> +	vectors->info_array = hbg_irqs;
> +	vectors->info_array_len = ARRAY_SIZE(hbg_irqs);
> +	return 0;
> +}

...

