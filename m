Return-Path: <netdev+bounces-159817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE16A17028
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663763A1256
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8868E1E9B19;
	Mon, 20 Jan 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YH6hCH9S"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD2E19BA6;
	Mon, 20 Jan 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390560; cv=none; b=PvNIMrOgWxAP9QhneCQls4ig1+7+m946CMmmmtoJttfiZ7hz1yzBxIQ0QJL99J1io8Ap3C2+NgoEKax7BO4GBuHc5glf96Rm99fbj06CZjWZsn5B1np7n3MTBscI8lYElogbh/wriQWgll+5LzMcRWQX5UlQGdNj1ISUUGlgfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390560; c=relaxed/simple;
	bh=QslexI+iskRFnWWPOH/4OQ/tYXjKgfOLmxX1E4x8WxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTjXhI5Wn6L66lcJz1qqeEIkTEzfoTFgyTJ+jUoZodM1IzUVGj/OJFH+/U5L3NwkAhQyXMdN4DATn9mac3f/6UTK6vr+YVl0lRvv61D34rRHwr39OTLwg6lfC8Q9ZMjqvC+dbrDp22h5UEQ67Z+HVkEWBOBUijDA6NAupeYe+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YH6hCH9S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xNs+0v/MS6t8eju7mr6BWfenMDdj2wARnf6j1yi+EWs=; b=YH6hCH9SB34cbJRXo8i1rANxQ8
	tzEmNZK2Goar9mf3nJApaxNcxQ3N5uajFQSwNr4V9K2kA2XQGIYLU7bxwP3YlMdqub4YTbJoUd5db
	YkvvBAUmjL6ieLFNcVWF6Hy5zi/Zd1Ug6e/ZiCZa5d61NvezqDPhXwAvK8fDUTnOHpTs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tZue5-006NvO-CL; Mon, 20 Jan 2025 17:29:01 +0100
Date: Mon, 20 Jan 2025 17:29:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: stmmac: Limit FIFO size by hardware feature
 value
Message-ID: <0c54a6ef-83ab-4739-bf2e-414c4d4621dc@lunn.ch>
References: <20250116020853.2835521-1-hayashi.kunihiko@socionext.com>
 <636bad71-8da8-4fda-a433-1586d93683a5@lunn.ch>
 <6aa0671d-beb2-429b-a34e-cb35651e1c12@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aa0671d-beb2-429b-a34e-cb35651e1c12@socionext.com>

On Mon, Jan 20, 2025 at 02:20:23PM +0900, Kunihiko Hayashi wrote:
> Hi Andrew,
> 
> On 2025/01/17 5:16, Andrew Lunn wrote:
> > On Thu, Jan 16, 2025 at 11:08:52AM +0900, Kunihiko Hayashi wrote:
> > > Tx/Rx FIFO size is specified by the parameter "{tx,rx}-fifo-depth" from
> > > the platform layer.
> > > 
> > > However, these values are constrained by upper limits determined by the
> > > capabilities of each hardware feature. There is a risk that the upper
> > > bits will be truncated due to the calculation, so it's appropriate to
> > > limit them to the upper limit values.
> > 
> > Are these values hard coded in the platform layer? Or can they come
> > from userspace?
> 
> My explanation is insufficient and misleading.
> "From the platform layer" means the common layer of stmmac described in
> "stmmac_platform.c".
> 
> > If they are hard coded, we should also fix them. So maybe add a
> > netdev_warn(), and encourage the platform maintainers to fix their
> > platform. If they are coming from userspace, we should consider
> > failing the ethtool call with an -EINVAL, and maybe an extack with the
> > valid range?
> 
> These values are derived from the devicetree and stored in the stmmac
> private structure. They are hardware-specific values, so I think this
> fix is sufficient.

But if they are coming from device tree, the device tree developer has
made an error, which has been silently ignored. Do we want to leave
the device tree broken? Or should we encourage developers to fix them?
Printing a warning would facilitate that.

	Andrew

