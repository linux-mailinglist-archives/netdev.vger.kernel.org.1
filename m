Return-Path: <netdev+bounces-123266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF354964580
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CBB9B2923E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26E5193077;
	Thu, 29 Aug 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e7einvKD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A6D1B14F7;
	Thu, 29 Aug 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935848; cv=none; b=jYjMjYWf/xklxAB6c/Qe0ShXtNB04EIq4jINtNlttJ/rUqw13DML9r+sBVdixMEqPezlC9z5QH0KEfGIkPfgRUjPxPx6t2xfEJW7QRjHQs8XcPtK2O9V/h9wdzgnG4Td8GtTR7g/XODUXe3qkTB0QBCs6uK18j9a3JWxyduyKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935848; c=relaxed/simple;
	bh=5xU26c5sExm+sdszRopYjUXlzuu8TUdyZT/44mOQYHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHmVpT57dzQoB04uGchhUeAlyVwQ2nReIqaVNOnS/ZLONQCU8IR7lMp8JPTqPOT5lG0iLzJXv51+UJpxjpoJ0vhCqG8cQ5/kRNpVxNnYrlXlU/OvvFK5AMrz6y4ltS8qEjgPNkK7SB0v60xYcg1SEMP4Hj9+BAWCMCoZ+SN2mhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e7einvKD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x8bnkkn9uV0EFuhUKaodndY7GSkEJencD9eHTXpVbO8=; b=e7einvKDfrJg4Bghrnxa3bNsfS
	Yd7JihsyUOqI9kbU6NsknodGzy/KA8T/k4Uua0rmcFlqgol7DdqOQP0RJlUhmJKj5FXMvKO9OHMGb
	h42509kzoN76CzNmgMGMjXClJYoBQ0awOjz7vpznpMzfPhwQ1ImLWJ45X7NXXUN5iKWc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjebd-006279-Tv; Thu, 29 Aug 2024 14:50:29 +0200
Date: Thu, 29 Aug 2024 14:50:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: woojung.huh@microchip.com, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	justin.chen@broadcom.com, sebastian.hesselbarth@gmail.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, wens@csie.org,
	jernej.skrabec@gmail.com, samuel@sholland.org,
	mcoquelin.stm32@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, ansuelsmth@gmail.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	krzk@kernel.org, jic23@kernel.org
Subject: Re: [PATCH net-next v3 05/13] net: phy: Fix missing of_node_put()
 for leds
Message-ID: <60afa68f-677a-490d-8c65-fad9e64beb51@lunn.ch>
References: <20240829063118.67453-1-ruanjinjie@huawei.com>
 <20240829063118.67453-6-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829063118.67453-6-ruanjinjie@huawei.com>

On Thu, Aug 29, 2024 at 02:31:10PM +0800, Jinjie Ruan wrote:
> The call of of_get_child_by_name() will cause refcount incremented
> for leds, if it succeeds, it should call of_node_put() to decrease
> it, fix it.
> 
> Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is a fix. You were asked to break it out of the series, and post
it to net, not net-next.

Jonathan, please could you step in and do some mentoring. Huawei is
big enough it should not need Maintainers to teach its developers the
basics.

	Andrew

