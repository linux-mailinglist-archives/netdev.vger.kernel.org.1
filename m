Return-Path: <netdev+bounces-101211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 006638FDC46
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 03:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB424285608
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A206113FEE;
	Thu,  6 Jun 2024 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DPJRm9Pe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0038C623;
	Thu,  6 Jun 2024 01:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717638268; cv=none; b=CXZvjtGtxTwv+vrueGM9WTPNqkBz6spEXTXOBDb4fr2lWmUyZvycsfxL3oNT+LwKs5PNlsRW8+fqwHllLRxRyCQ4woJNYQFAp5o3zAzaIVBMEMhhhv4CU5pkABFc1xr52f7P8UJ2wLHRd6UUDXD6GQ7zdmZIlv/aAPGKbB6ls74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717638268; c=relaxed/simple;
	bh=IuoxsVE87G9eOmuwqPnjYc4nLdBdjvbejV+uNRrFa+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNCeKVW4ioWlG1rZoo8mCRyNCFkGX/I7UYuKK1O5EDyBkDSkL7U+jENMvoFAr3xcKTClgakzdCAy34ixfMgAKbwmLlG7s1KCdStey15h3tarslvB85I/eIBssG+rbPFRPkwNyqAWbAFXK46wrwaYp4IPRr2xMcZu/HAnm67dVmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DPJRm9Pe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OFneTQnso6hVKtXKpCXdUh8sCSAm/mIhdqxDjRNNyUk=; b=DPJRm9PeswAyhUcd5nIp7csTVM
	YTQNGOGh6WkjP9+I0kYelW8jsC0rgSXEYkCyCj1z4AcUNyAmLkQ7V6k+XNh4t7xYiS1d5eCTj8BDJ
	G1Ka7lARnbBWRqTacYVXrYNRhMTxJT5ZhExpufe7cGdyuF+jWgMRomIY3vV/S1XRQdHk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sF2Ak-00GxuR-QX; Thu, 06 Jun 2024 03:44:10 +0200
Date: Thu, 6 Jun 2024 03:44:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v3 1/4] net: macb: queue tie-off or disable
 during WOL suspend
Message-ID: <90da3dd6-e361-46d0-b547-c662b649b03d@lunn.ch>
References: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
 <20240605102457.4050539-2-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605102457.4050539-2-vineeth.karumanchi@amd.com>

> @@ -5224,17 +5257,38 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  
>  	if (bp->wol & MACB_WOL_ENABLED) {
>  		spin_lock_irqsave(&bp->lock, flags);
> -		/* Flush all status bits */
> -		macb_writel(bp, TSR, -1);
> -		macb_writel(bp, RSR, -1);
> +
> +		/* Disable Tx and Rx engines before  disabling the queues,
> +		 * this is mandatory as per the IP spec sheet
> +		 */
> +		tmp = macb_readl(bp, NCR);
> +		macb_writel(bp, NCR, tmp & ~(MACB_BIT(TE) | MACB_BIT(RE)));

Is there any need to wait for this to complete? What if there is a DMA
transaction in flight?

	Andrew

