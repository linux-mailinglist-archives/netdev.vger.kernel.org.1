Return-Path: <netdev+bounces-117299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D69294D808
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 22:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81D81F219F5
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 20:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB63160860;
	Fri,  9 Aug 2024 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IhkIq164"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CB33D1;
	Fri,  9 Aug 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235125; cv=none; b=VPHZwSUbSfhn6cqBZpa0/CNgCVotZiLXy/TvFEWfcSm+fCmXoNZ2kZxGaq2ln07zaAr6mKEoOkO/kyTc1X8ey9O6GWYuIShVQ/DHQ1MR63M8CU2RtEOvePpD1ynSzHW/LLwZwqiEzbnrTAmDH8Ul2Qx1n4krRRpehQCuV6BI1H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235125; c=relaxed/simple;
	bh=McNVXp3LoZaVmqb1YpE0NscgQUM6eBi1PCWQqxjCkU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBQ6LNf1mCe6PI/d78UcN25hXF700t9WELwze3/iWykDf/kLBc3e9tp7UIwRv5nEyMo1xRpLr2iA+PWt4QKOqCSJQq60B8e0GI0ziybTfHNjwTVRNW1p4BydtMB3Nx8YnfT8lJXI2C0xj4h+qLWnTLfG347icfyWRHA+KKP8Pts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IhkIq164; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+schTQf5j96nlsICJifEdmP7l92zlexNKlgDIVIPHcg=; b=IhkIq1646ATrXJgIt9QNpjXl8q
	qK/iSgh2HPM/WkIKC3hmvSfv0IJjEn6SeV3MhKz+pivmOxrB3rs6zdOUxjN5VDgHasuUNEIg1pQLY
	kBQSpgK+moDlfC+qC4CoKUQB2wQMlg6bmxNaQyDGMCK0++3JfjVlQQxez7Rt1JiYbq6A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scWAf-004PdU-Km; Fri, 09 Aug 2024 22:25:09 +0200
Date: Fri, 9 Aug 2024 22:25:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tan En De <endeneer@gmail.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
	Tan En De <ende.tan@starfivetech.com>
Subject: Re: [net,1/1] net: stmmac: Set OWN bit last in dwmac4_set_rx_owner()
Message-ID: <06297829-0bf7-4a06-baaf-e32c39888947@lunn.ch>
References: <20240809144229.1370-1-ende.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809144229.1370-1-ende.tan@starfivetech.com>

On Fri, Aug 09, 2024 at 10:42:29PM +0800, Tan En De wrote:
> Ensure that all other bits in the RDES3 descriptor are configured before
> transferring ownership of the descriptor to DMA via the OWN bit.

Are you seeing things going wrong with real hardware, or is this just
code review? If this is a real problem, please add a description of
what the user would see.

Does this need to be backported in stable?

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

If it does, you should add a Fixes: tag and 'Cc: stable@vger.kernel.org'

This will also decide which tree you need to base the patch on:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

>  static void dwmac4_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
>  {
> -	p->des3 |= cpu_to_le32(RDES3_OWN | RDES3_BUFFER1_VALID_ADDR);
> +	p->des3 |= cpu_to_le32(RDES3_BUFFER1_VALID_ADDR);
>  
>  	if (!disable_rx_ic)
>  		p->des3 |= cpu_to_le32(RDES3_INT_ON_COMPLETION_EN);
> +
> +	dma_wmb();
> +	p->des3 |= cpu_to_le32(RDES3_OWN);

Is the problem here that RDES3_INT_ON_COMPLETION_EN is added after the
RDES3_OWN above has hit the hardware, so it gets ignored?

It seems like it would be better to calculate the value in a local
variable, and then assign to p->des3 once.

	  Andrew

