Return-Path: <netdev+bounces-166705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EA2A37006
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 18:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D97716A3F1
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E33D1E5B77;
	Sat, 15 Feb 2025 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcU+8KPG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31C194C61
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739642316; cv=none; b=L+N/pabwXYXDY6k02PZTmwL4bfEUiHE67CWY5pzNrN1OMmfkK16ia6bHq0MFDlsUl5gMlhd2VrfXba2kPu+EUUCrrEEB+IaXHPP/YisLDWgCqVSwewFRhACnP5vR+BSZvqpIa/tSoRjb7kReHm36Yp2wIf4j3FwOvpjQqm9FIRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739642316; c=relaxed/simple;
	bh=MhdHAwfVerP/+KdwSgCSiIHb8HB1mk3tyt3VInWBKL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYSDcYszJuAKmTpeu1NjclatMdNTGSrgMpW2XWdUkCdPx7qScOkCg7B4pH4kazlzz5ZezZQCRpoMCHTxCX1SpQ9z9Nrl8TZZAPTXxJX9QTeHRKNL67eduegk666gOxqseyF1nc7TwOCoxxeBROSjVp83zRlpyvnvki4pS8mbrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcU+8KPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F73C4CEDF;
	Sat, 15 Feb 2025 17:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739642315;
	bh=MhdHAwfVerP/+KdwSgCSiIHb8HB1mk3tyt3VInWBKL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FcU+8KPGSUOtq2thnW5VdOci5oOm9vfHnuH3lZ1f1d4MFMXCTaFAhzxO1vPR5fCZN
	 J5U3sjysFMOpXZpRwocq0lCaisHVT7kt/fNHzYbD1dvoagp+F/WDQg3P3mswmJ7y6h
	 kHbQr2JCDBDzC//JEG2RClR2V3HHRm4wSW5B1I+KrxveDZOwpWMe8DroNmFUzApCtS
	 8uiQTQFK0HE0HU6f8UPEEFnS4Y1bQmm1/sV0Fo7QDMfN9h8eUWK8ADIdFOrc7tWL8R
	 4rcMGWw9cpA83JjgwBMY5LYbwoBjLoxy086TaOQrConypxP6HA/jSEjdaHEdn4BZrw
	 1lSfo/+f8xVeg==
Date: Sat, 15 Feb 2025 09:58:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com,
 kalesh-anakkur.purayil@broadcom.com, pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next v8 3/6] net: napi: add CPU affinity to
 napi_config
Message-ID: <20250215095834.6cfc923f@kernel.org>
In-Reply-To: <20250211210657.428439-4-ahmed.zaki@intel.com>
References: <20250211210657.428439-1-ahmed.zaki@intel.com>
	<20250211210657.428439-4-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 14:06:54 -0700 Ahmed Zaki wrote:
> @@ -11575,9 +11615,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  		void (*setup)(struct net_device *),
>  		unsigned int txqs, unsigned int rxqs)
>  {
> +	unsigned int maxqs, i, numa;
>  	struct net_device *dev;
>  	size_t napi_config_sz;
> -	unsigned int maxqs;
>  
>  	BUG_ON(strlen(name) >= sizeof(dev->name));
>  
> @@ -11679,6 +11719,11 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  	if (!dev->napi_config)
>  		goto free_all;
>  
> +	numa = dev_to_node(&dev->dev);

Does this work? dev->dev is the "software" device, IOW the netdev itself.
The HW dev is dev->dev.parent but it won't be set at this stage, we'd
need to move the init to register, or maybe netif_enable_cpu_rmap() /
netif_set_affinity_auto() ?

> +	for (i = 0; i < maxqs; i++)
> +		cpumask_set_cpu(cpumask_local_spread(i, numa),
> +				&dev->napi_config[i].affinity_mask);

