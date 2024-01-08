Return-Path: <netdev+bounces-62431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1E8272DE
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 16:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C211C21C06
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 15:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EE14C3AD;
	Mon,  8 Jan 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uauxp6eD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96951015
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 15:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E952FC433CB;
	Mon,  8 Jan 2024 15:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704727175;
	bh=b5gRE7Nr+AEDqF5KOAlx9+OChOjzu4SZ+vlPmj7gtvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uauxp6eDR4uogr2jqNR/pKxG0V+GFlxiyBHJ0Ai/bKkUdvfDcgoxkFsmXjHkrABlr
	 egyIn6gZKehh76qhINT6Vsn7TXJD7lt6r/lCORYxL8CLqg3tBVDzf7Vwmqs6y1Exgc
	 sBjf/HFmzGRYKxxzsUMpg5WhzgDPGqoc2XaUkV2XbDAMZ8Zm4FfcPkeDqyWoukaSxL
	 rLLB9cfEMij+AHjR62MohVWiqaQ2CbkuWdDmmYI8IQJWUHvds6DRHCcPd8WazJwX4a
	 mkOrl0jQPWC8+vSQi+5x3JhcuPlNMdIWaB7DejGL/HEdegaUeQVvTduUngInX6v8vU
	 1BfBRj9uXX48g==
Date: Mon, 8 Jan 2024 07:19:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.com, vsankar@lenovo.com, danielwinkler@google.com,
 nmarupaka@google.com, joey.zhao@fibocom.com, liuqf@fibocom.com,
 felix.yan@fibocom.com, Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v3 2/3] net: wwan: t7xx: Add sysfs attribute for
 device state machine
Message-ID: <20240108071933.4fd3a873@kernel.org>
In-Reply-To: <MEYP282MB2697CEBA4B69B0230089AA51BB9EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20231228094411.13224-1-songjinjian@hotmail.com>
	<MEYP282MB2697CEBA4B69B0230089AA51BB9EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 17:44:10 +0800 Jinjian Song wrote:
> From: Jinjian Song <jinjian.song@fibocom.com>
> 
> Add support for userspace to get the device mode,
> e.g., reset/ready/fastboot mode.

We need some info under Documentation/ describing the file / attr
and how it's supposed to be used.

> diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
> index 24e7d491468e..ae4578905a8d 100644
> --- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
> +++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
> @@ -192,6 +192,7 @@ static irqreturn_t t7xx_rgu_isr_thread(int irq, void *data)
>  {
>  	struct t7xx_pci_dev *t7xx_dev = data;
>  
> +	atomic_set(&t7xx_dev->mode, T7XX_RESET);

Why is ->mode atomic? There seem to be no RMW operations on it.
You can use READ_ONCE() / WRITE_ONCE() on a normal integer.

>  	msleep(RGU_RESET_DELAY_MS);
>  	t7xx_reset_device_via_pmic(t7xx_dev);
>  	return IRQ_HANDLED;
> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
> index 91256e005b84..d5f6a8638aba 100644
> --- a/drivers/net/wwan/t7xx/t7xx_pci.c
> +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
> @@ -52,6 +52,68 @@
>  #define PM_RESOURCE_POLL_TIMEOUT_US	10000
>  #define PM_RESOURCE_POLL_STEP_US	100
>  
> +static ssize_t t7xx_mode_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev;
> +	struct t7xx_pci_dev *t7xx_dev;
> +
> +	pdev = to_pci_dev(dev);
> +	t7xx_dev = pci_get_drvdata(pdev);
> +	if (!t7xx_dev)
> +		return -ENODEV;
> +
> +	atomic_set(&t7xx_dev->mode, T7XX_FASTBOOT_DL_SWITCHING);

This function doesn't use @buf at all. So whenever user does write()
to the file we set to SWITCHING? Shouldn't we narrow down the set
of accepted values to be able to add more functionality later?

> +	return count;
> +};

unnecessary semi-colon

