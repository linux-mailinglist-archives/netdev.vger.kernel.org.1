Return-Path: <netdev+bounces-236990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAFCC42EE1
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 16:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A33188B48F
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 15:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8C320102B;
	Sat,  8 Nov 2025 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ART/2v1Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58AB1DFD96
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762616532; cv=none; b=pFTk3TtE4m+VCUPhWlu93BIArjVXsA5O704sopM7HYWDh8EuoiEFaBJAM1zMJYrbwgU7DSJGe5FPhnTDg4TA4M9PSckDheniSL1GhIkR/YsHSXuKagII+4jfuYUhcPkQboFar59bDr/adsext+v3rKLL7069jAw0jP0xnKnH1U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762616532; c=relaxed/simple;
	bh=p8nPerCqYcOWMRYV3CQ1oewheE0CnwbtkxifwB13poY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bChFNBZLT1PejxBT3UUJx42yuyFltJGyH4rRGaPLL90b/nRnCFUz8NLGJIkvEOs0krZ9WD8BStuqcnwhmCAvSGmKGLYNmFvJeA8u43gPaqH27jZS8zJnkorRMI+p4nhaM/92poHS51P++YBnKgOZz+Gu33lcETOVdsLDvGNMW6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ART/2v1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA62CC4CEFB;
	Sat,  8 Nov 2025 15:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762616531;
	bh=p8nPerCqYcOWMRYV3CQ1oewheE0CnwbtkxifwB13poY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ART/2v1YHr72ef59zmPoEtavMNJzsBkBRopNkMP01XAp27BwMyZQh645gxlZNE5z/
	 oCw2E+PZl8bKdlm1+fv2y4JszUZO3Y0yckS2OSB8ZcBJUO9fuxHvg1NuJuoIyhpp3R
	 W6CxVJU6fjGBP3+juqG3f7gQUw27Iac0nDIqZ52tmGk9rJ35/+hsOW6XNY6PKXnRzz
	 OPU6pKLSQihJ06MsMOzAKsik7gG/uE1YLTzW/kDRymwo5781Cu4HHIV2bGnTzh8EXd
	 qfhzD7drxx81dZis3LnHPeMl5YU83qEqYH8ZpcvJu2jNmpb+RaSQvYj8IwV4WZevVo
	 pH57ztE2XYNow==
Date: Sat, 8 Nov 2025 15:42:06 +0000
From: Simon Horman <horms@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v10 1/5] eea: introduce PCI framework
Message-ID: <aQ9kziDzlq2Y4a_I@horms.kernel.org>
References: <20251105013419.10296-1-xuanzhuo@linux.alibaba.com>
 <20251105013419.10296-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105013419.10296-2-xuanzhuo@linux.alibaba.com>

On Wed, Nov 05, 2025 at 09:34:15AM +0800, Xuan Zhuo wrote:
> Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).
> 
> This commit implements the EEA PCI probe functionality.
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

...

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c

...

> +int eea_device_reset(struct eea_device *edev)
> +{
> +	struct eea_pci_device *ep_dev = edev->ep_dev;
> +	int i, err;
> +	u8 val;
> +
> +	eea_pci_io_set_status(edev, 0);
> +
> +	while (eea_pci_io_get_status(edev))
> +		msleep(20);

If eea_pci_io_get_status never returns true, then this will loop forever.

Meanwhile the read_poll_timeout() call below seems to implement
the same check as above, but with a timeout. Perhaps this is
an editing artifact and the loop above should simply be removed?

> +
> +	err = read_poll_timeout(cfg_read8, val, !val, 20, EEA_RESET_TIMEOUT_US,
> +				false, ep_dev->reg, device_status);

> +
> +	if (err)
> +		return -EBUSY;
> +
> +	for (i = 0; i < ep_dev->msix_vec_n; ++i)
> +		synchronize_irq(pci_irq_vector(ep_dev->pci_dev, i));
> +
> +	return 0;
> +}

...

