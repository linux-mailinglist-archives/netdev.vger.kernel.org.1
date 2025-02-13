Return-Path: <netdev+bounces-166046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70976A340E2
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9DA1882A98
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC724BC09;
	Thu, 13 Feb 2025 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gkZtbL8j"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7F24BC0D;
	Thu, 13 Feb 2025 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454939; cv=none; b=ceQrW02MGDp9N21tgsTImlc2oQ8iMWo3t2we9k+wb+GmIFUfi4I0UQ5/DjPJxnxQTq+UULeqg27dtX3YTW25DOZihcpFy6Z7WolHTrBicMLGpAecCCEPVm/c+jpcT7V2A+KPykavJNhhJ/vrHuyTA3XMqBa3C3t9RRgLOBicnXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454939; c=relaxed/simple;
	bh=dxAlnetG+xfsiBNq0fcAIpV/X+mjVmjq2DG/r9QyAWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMqluAM8vQwk2XllFJrmwfk8OdfvtZF8x+/VDQyTl0Z4ZMBNffwC9FjixdwRLQNQGICX6jEsu/hzuVNpRU0leacgGWC5saGALOm/6VQUzIjVfIl76eiWJAT7S9dsIwzVeqExBKQ3dbMWQ6AHFhhxuZ7jQzh0xUfrDetbVgkW3Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gkZtbL8j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iSIJAx4EpNXrVsBR/rpvqubaa9T4PDr1XsPwpgCesCw=; b=gkZtbL8jtyFaX5I7SQPe1yOCe9
	UWSxm5Ie8L9UyWPhu5BlROG5LnnlOBATL2gTmW8b7+NvDxFwlfulajbuPd/ZwZxWER6fDYhZIDIjB
	64NFBb8/q7lqP1EXLk/fZAh5drzeQeTVYUA3BSGfq3Q8KnIUUrJv6qv5MPc1zdWHkZSw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiZgZ-00DklN-Ck; Thu, 13 Feb 2025 14:55:23 +0100
Date: Thu, 13 Feb 2025 14:55:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, joel@jms.id.au,
	richardcochran@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] soc: aspeed: Add NULL pointer check in
 aspeed_lpc_enable_snoop()
Message-ID: <2d5c9d87-abbc-4118-9031-f2c7b5c96085@lunn.ch>
References: <20250212212556.2667-1-chenyuan0y@gmail.com>
 <f649fc0f8491ab666b3c10f74e3dc18da6c20f0a.camel@codeconstruct.com.au>
 <CALGdzuoeYesmdRBG_QPW_rkFcX7v=0hsDr0iX3u5extEL5qYag@mail.gmail.com>
 <8e6c7913fda39baa50309886f9f945864301660f.camel@codeconstruct.com.au>
 <CALGdzurifZaqatjGRZGxA4FyNBHOYJdVXpKHSM4hQdA3qZtYvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALGdzurifZaqatjGRZGxA4FyNBHOYJdVXpKHSM4hQdA3qZtYvQ@mail.gmail.com>

On Wed, Feb 12, 2025 at 07:50:49PM -0600, Chenyuan Yang wrote:
> Hi Andrew,
> 
> I've drafted the following patch to address the resource cleanup issue:

Please just follow the normal procedure of submitting a patch.

	Andrew

> 
> ```
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index 9ab5ba9cf1d6..4988144aba88 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -200,11 +200,15 @@ static int aspeed_lpc_enable_snoop(struct
> aspeed_lpc_snoop *lpc_snoop,
>   lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
>   lpc_snoop->chan[channel].miscdev.name =
>   devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
> + if (!lpc_snoop->chan[channel].miscdev.name) {
> + rc = -ENOMEM;
> + goto free_fifo;
> + }

You were asked to first add cleanup, then fix this possible NULL
pointer dereference.

> I have a couple of questions regarding the cleanup order:
> 
> 1. Do we need to call misc_deregister() in this case, considering that
> the registration happens before return -EINVAL?
> 2. If misc_deregister() is required, is there a specific order we
> should follow when calling misc_deregister() and
> kfree(lpc_snoop->chan[channel].miscdev.name);?

As a general rule, cleanup is the opposite order to setup.

Also, you want to do some research about that devm_ means.

	Andrew

