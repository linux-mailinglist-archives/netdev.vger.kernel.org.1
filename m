Return-Path: <netdev+bounces-127048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55434973D7A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853891C25285
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F91A2550;
	Tue, 10 Sep 2024 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3O48FADX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F29A1940B2;
	Tue, 10 Sep 2024 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986265; cv=none; b=RSsqvRRmOD7Zw34lX+3UI9GGQ+RUC0m+1DNFTkc5l9jWX6Z5Lpzmp3SYz65YeUaRuUDrBngpLBHNkezjWspJbjWnbwdET6h3eW5l1uIBBb/q6UZXIrszhf5K7LunF0wKXqtGGxqYndBNwuTBqdrZttWahxeGIHpLoYNQmnA9YQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986265; c=relaxed/simple;
	bh=7VF9rgboRzL0mm+07/GKAlL0SNO6DEB/S1PzLp/6snc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsvuW7I9BlaDSk7mXZx/M8lLBeRyrjLZ/pQtRi8s1uofzi8YPBqbGIP7jW5WhXp9ShT5M7ITCPaHvkP6AkJToYuRUdgLYA59Q0mRJYLqGLr7jlEO7co+CDenwZ8Obp8kJt5jy4JJY3pHSetGneHAreZHKOMC6EFPNGSmIeYnMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3O48FADX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hi0em5bL+poiFC0wfvmHbEWvS+L21GYAWoJomxsOdMk=; b=3O48FADXv5Ng+QE04b5xm6jNLQ
	FKLUkhRs3Ivw/syeEr12KGoJWWIj+ntRHjZ16iWhTHPBM8dQvv6JpbOR3OObxuOtXIOe5g7GFBBTM
	S/ltAStxn1S459Kj5EDFxPKsT4xg8/Gv1wkGqILmEKfhjMSIpugutDCcWyrpCNZmV2Oc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1so3s1-0077tk-7Q; Tue, 10 Sep 2024 18:37:37 +0200
Date: Tue, 10 Sep 2024 18:37:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCH net-next 1/4] net: ibm: emac: tah: use devm and dev_err
Message-ID: <76049027-f24b-4b7d-9bcc-5dae001233d3@lunn.ch>
References: <20240907222147.21723-1-rosenp@gmail.com>
 <20240907222147.21723-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907222147.21723-2-rosenp@gmail.com>

On Sat, Sep 07, 2024 at 03:21:44PM -0700, Rosen Penev wrote:
> Simplifies the driver by removing manual frees and using dev_err instead
> of printk. pdev->dev has the of_node name in it. eg.
> 
> TAH /plb/opb/emac-tah@ef601350 initialized
> 
> vs
> 
> emac-tah 4ef601350.emac-tah: initialized
> 
> close enough.

There are lots of different things going on in this patch. It would be
better to split it up.

> -void tah_reset(struct platform_device *ofdev)
> +void tah_reset(struct platform_device *pdev)

Search/replace would be one patch.

>  {
> -	struct tah_instance *dev = platform_get_drvdata(ofdev);
> +	struct tah_instance *dev = platform_get_drvdata(pdev);
>  	struct tah_regs __iomem *p = dev->base;
>  	int n;
>  
> @@ -56,7 +56,7 @@ void tah_reset(struct platform_device *ofdev)
>  		--n;
>  
>  	if (unlikely(!n))
> -		printk(KERN_ERR "%pOF: reset timeout\n", ofdev->dev.of_node);
> +		dev_err(&pdev->dev, "reset timeout");

printk() to dev_err() another patch.

> -	rc = -ENOMEM;
> -	dev = kzalloc(sizeof(struct tah_instance), GFP_KERNEL);
> -	if (dev == NULL)
> -		goto err_gone;
> +	dev = devm_kzalloc(&pdev->dev, sizeof(struct tah_instance), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
>  

devm another patch.

>  	mutex_init(&dev->lock);
> -	dev->ofdev = ofdev;
> +	dev->ofdev = pdev;

It seems odd to not also rename dev->ofdev to dev->pdev, so it is
consistent.

    Andrew

---
pw-bot: cr


