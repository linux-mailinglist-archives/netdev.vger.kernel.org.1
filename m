Return-Path: <netdev+bounces-153745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2B59F989F
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 18:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA107A2444
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5099F229B0B;
	Fri, 20 Dec 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfORZ6fi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C05621CA09
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715438; cv=none; b=NX8bt8Id3UTq5DkmcUY+IugBgMEuQdOC52ok2MMEmd7fso/neAKCuZnM6/dBGhTnCLZHsd9I93grijebPnnNK0ssfjpXXvman8/jWb15zMOxay/EGrKriu/hg3Wz3e/oXQVU5gQ3B4rLCriZCFT75hgWxG3jEwEGT76olTdoJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715438; c=relaxed/simple;
	bh=y87VLdF5d2f4POgxkE6UMOkUIbV8zOdiEIsbrBIDqt8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BH0IJ0/YItUYA038bUlcd+jGTQU6HygfIW3HHPDxp+B/cQr+U8H5QpL05MmZ66rqvVrBzCn5JYSBR6CMTLYYDE2cdO/JbhOEycbPQkLhopbl7A0ZIHOzwKXv2Z+PkKQfj6ywmAdd+bm4dvJqUVuMrr53y96d5dpcyeS3inqsGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfORZ6fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EBAC4CECD;
	Fri, 20 Dec 2024 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734715437;
	bh=y87VLdF5d2f4POgxkE6UMOkUIbV8zOdiEIsbrBIDqt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KfORZ6fi8IYAwyWtbtHd8LiOE50f04K6XjDeWVvCaHMcL+k+y/5xq65UIi9jlPSoq
	 a/aEhq+ECtQF7yI/NbwZtOlYW/JePiBZdRgfJzPYrO8P9pKnF7ZKjKwOQBqoY4tR0K
	 koD3HF9fqAsS7uvDIBrbaFQr6zCGIBG1lL3rEBpEGJnqADPkciA/CdXs/YgGw8QDvO
	 WCuBhaqpJOz/3FasBXgSF6jTYNqf8s7E25njMGGWtp7MpOTxXX+VG89vt2gEW9lfYr
	 g3UbMLnzsXT69XmAuT1f47Lh1YvW2ICWs47C74IJMhmqCU5ewfzuU+zPYzAY/BmBb/
	 sNuMJl9Q3+YfA==
Date: Fri, 20 Dec 2024 09:23:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
 <davem@davemloft.net>, <michael.chan@broadcom.com>, <tariqt@nvidia.com>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <jdamato@fastly.com>, <shayd@nvidia.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH net-next v2 4/8] net: napi: add CPU affinity to
 napi->config
Message-ID: <20241220092356.69c9aa1e@kernel.org>
In-Reply-To: <cf836232-ef2b-40c8-b9e5-4f0dffdcc839@intel.com>
References: <20241218165843.744647-1-ahmed.zaki@intel.com>
	<20241218165843.744647-5-ahmed.zaki@intel.com>
	<20241219194237.31822cba@kernel.org>
	<cf836232-ef2b-40c8-b9e5-4f0dffdcc839@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 07:51:09 -0700 Ahmed Zaki wrote:
> On 2024-12-19 8:42 p.m., Jakub Kicinski wrote:
> > On Wed, 18 Dec 2024 09:58:39 -0700 Ahmed Zaki wrote:  
> >> +	if (!glue_created && flags & NAPIF_IRQ_AFFINITY) {
> >> +		glue = kzalloc(sizeof(*glue), GFP_KERNEL);
> >> +		if (!glue)
> >> +			return;
> >> +		glue->notify.notify = netif_irq_cpu_rmap_notify;
> >> +		glue->notify.release = netif_napi_affinity_release;
> >> +		glue->data = napi;
> >> +		glue->rmap = NULL;
> >> +		napi->irq_flags |= NAPIF_IRQ_NORMAP;  
> > 
> > Why allocate the glue? is it not possible to add the fields:
> > 
> > 	struct irq_affinity_notify notify;
> > 	u16 index;
> > 
> > to struct napi_struct ?  
> 
> In the first branch of "if", the cb function netif_irq_cpu_rmap_notify() 
> is also passed to irq_cpu_rmap_add() where the irq notifier is embedded 
> in "struct irq_glue".

I don't understand what you're trying to say, could you rephrase?

> I think this cannot be changed as long as some drivers are directly 
> calling irq_cpu_rmap_add() instead of the proposed API.

Drivers which are not converted shouldn't matter if we have our own
notifier and call cpu_rmap_update() directly, no?

Drivers which are converted should not call irq_cpu_rmap_add().

