Return-Path: <netdev+bounces-153766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD79F9A98
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB9A167CAF
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 19:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8E8220684;
	Fri, 20 Dec 2024 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPxXkZoX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C619DF61
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723433; cv=none; b=iVeRSrSOqqqFtAHpXIUtAihH/uWdujOa1benZ0im1o7LWGAes/P4q+B5qNeLVx1GtdrWKi2ANE7W/gmutaUEeRrRm5PZOF9jzxs4tWBY9hSuQxC3KfCpKoNlrhePweyOURSonbbNTKEQEf2rvy9QT67gvSK+RIbFxZrWZNJ6FLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723433; c=relaxed/simple;
	bh=TxNjdNBPDUPVWyiLgYG3IUbsLDUHysJGXU6IvUYBqfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGU8aqCSQNGUZTkI0My6M92QTDEqCHspkRk+u7jBaupsNwFqsmR5SPqgjrMypZV2gj5xG4ot8f5fK6RzlpLEeWIlgEYT8Y+tk9MdTLS5db8eWRTB4iMHOthzL0ncLcA9wCjx10UgGY0P3ThOJd5/CL8zYps7364mM4zQCn3jjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPxXkZoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37EAC4CED4;
	Fri, 20 Dec 2024 19:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734723433;
	bh=TxNjdNBPDUPVWyiLgYG3IUbsLDUHysJGXU6IvUYBqfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SPxXkZoXUAsFtT61toQ1KGeUeopbO9yXrucq73cl0zPU+stXjVI9tkdWJH/mEpA5X
	 huOp48KKEGHc53ze02VUA3hyY+ScjAd0SMKKH8PIvsIdwQtMmC8sR0EZ5sure4oeoc
	 QmS0QbTagaZD2YCYDmhIwMgbyphG7oNg4MDVcshEuTCGZyohyPGQnxi+GmIG+IhkyW
	 q5O+jdWczFcu7WHF+4f1om2zIjJblE19Pb0JklraseJ4UHPSk4aXVo2vs70lxEoyiD
	 M75iuM44cMtM9R1KzfYU+Wu2sR59tu+aw63TaKoLfZPDFhSuR8fs+eGnhChUmyuI38
	 gByTcGED5wB0w==
Date: Fri, 20 Dec 2024 11:37:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
 <davem@davemloft.net>, <michael.chan@broadcom.com>, <tariqt@nvidia.com>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <jdamato@fastly.com>, <shayd@nvidia.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH net-next v2 4/8] net: napi: add CPU affinity to
 napi->config
Message-ID: <20241220113711.5b09140b@kernel.org>
In-Reply-To: <35441a41-d543-4e7b-b0dc-537062d32c9c@intel.com>
References: <20241218165843.744647-1-ahmed.zaki@intel.com>
	<20241218165843.744647-5-ahmed.zaki@intel.com>
	<20241219194237.31822cba@kernel.org>
	<cf836232-ef2b-40c8-b9e5-4f0dffdcc839@intel.com>
	<20241220092356.69c9aa1e@kernel.org>
	<35441a41-d543-4e7b-b0dc-537062d32c9c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 12:15:33 -0700 Ahmed Zaki wrote:
> > I don't understand what you're trying to say, could you rephrase?  
> 
> Sure. After this patch, we have (simplified):
> 
> void netif_napi_set_irq(struct napi_struct *napi, int irq, unsigned long 
> flags)
>   {
> 	struct irq_glue *glue = NULL;
>   	int  rc;
> 
>   	napi->irq = irq;
> 
>   #ifdef CONFIG_RFS_ACCEL
>   	if (napi->dev->rx_cpu_rmap && flags & NAPIF_IRQ_ARFS_RMAP) {
> 		rc = irq_cpu_rmap_add(napi->dev->rx_cpu_rmap, irq, napi,
> 				      netif_irq_cpu_rmap_notify);
> 		.
> 		.
> 		.
>   	}
>   #endif
> 
> 	if (flags & NAPIF_IRQ_AFFINITY) {
> 		glue = kzalloc(sizeof(*glue), GFP_KERNEL);
> 		if (!glue)
> 			return;
> 		glue->notify.notify = netif_irq_cpu_rmap_notify;
> 		glue->notify.release = netif_napi_affinity_release;
> 		.
> 		.
> 	}
>   }
> 
> 
> Both branches assign the new cb function "netif_irq_cpu_rmap_notify()" 
> as the new IRQ notifier, but the first branch calls irq_cpu_rmap_add() 
> where the notifier is embedded in "struct irq_glue". So the cb function 
> needs to assume the notifier is inside irq_glue, so the second "if" 
> branch needs to do the same.

First off, I'm still a bit confused why you think the flags should be
per NAPI call and not set at init time, once.
Perhaps rename netif_enable_cpu_rmap() suggested earlier to something
more generic (netif_enable_irq_tracking()?) and pass the flags there?
Or is there a driver which wants to vary the flags per NAPI instance?

Then you can probably register a single unified handler, and inside
that handler check if the device wanted to have rmap or just affinity?

