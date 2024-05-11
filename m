Return-Path: <netdev+bounces-95625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D13F8C2DCB
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3461F221D8
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 00:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F757184;
	Sat, 11 May 2024 00:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RumPPV8B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735D623A9
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 00:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386302; cv=none; b=OIx5pEuF9zjvcI1c/NBGDiBIR0Qi5DdM9ZYt0arjmeJjzcZieA4IZVq9hvpF5YDMAELBJNsDyvECc3yB8P3+AdYFt4kHMnUw5euo7DYgjh8JPjJKkwyOlWC6bf/XvZjL7AqCVjEVfTMB7476WQScb76tXWKPYbh0f9YieorvRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386302; c=relaxed/simple;
	bh=K3by3DjOrZwXfU4wZxFHidx7ValhSjSrZNBQ5vU4QvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlLl3EeqOBIy2YQ/wN2pcuG3VzyPSQ+hXbjd8zXpJ8k5Xjz28XLzpq7qEf5/zXEYkZIgYM9lhmGAIysoYIyUAmmsUHJW2zqQAoVSHAsqn6sad99xWvuIag8Kp8Bb+qOUgM23Oj7HCBYo/UY40FZJ6M/rLs1W7zm9KkP1/XzZf/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RumPPV8B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VumH+IGmAAGuEK6rL98cdNOhspsTWnZd0mVucWcisj8=; b=RumPPV8BU/el+7tdHGpAZ06E7F
	aWGePA5BQzcQY083G8QgU/tvfRULZFpgB1uTVV+GocOU9hcFb9rTPjs1GHTAUOkvVkccBTF0aRTRB
	/sPm9iabedzKkwVwOCJHG+pKNYVeeWY8dSjBTpMltW0/GW1BcUqqQagJthGE34hr1TnA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5aKo-00FApv-Cg; Sat, 11 May 2024 02:11:30 +0200
Date: Sat, 11 May 2024 02:11:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] net: ethernet: cortina: Implement
 .set_pauseparam()
Message-ID: <78fb31fb-98a6-4ab5-9896-f1db8ce5d0fd@lunn.ch>
References: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
 <20240511-gemini-ethernet-fix-tso-v2-5-2ed841574624@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511-gemini-ethernet-fix-tso-v2-5-2ed841574624@linaro.org>

On Sat, May 11, 2024 at 12:08:43AM +0200, Linus Walleij wrote:
> The Cortina Gemini ethernet can very well set up TX or RX
> pausing, so add this functionality to the driver in a
> .set_pauseparam() callback.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index d3134db032a2..137242a4977c 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -2145,6 +2145,17 @@ static void gmac_get_pauseparam(struct net_device *netdev,
>  	pparam->autoneg = true;
>  }
>  
> +static int gmac_set_pauseparam(struct net_device *netdev,
> +			       struct ethtool_pauseparam *pparam)
> +{
> +	struct phy_device *phydev = netdev->phydev;
> +
> +	gmac_set_flow_control(netdev, pparam->tx_pause, pparam->rx_pause);
> +	phy_set_asym_pause(phydev, pparam->rx_pause, pparam->tx_pause);

This is a bit of an odd implementation. Normally the value of the
pparam.autoneg is used to decide if to directly program the hardware,
or to pass it to phylib.

Also, the adjust link callback probably should know so that it does
not take the autoneg values when auto-neg of pause is disabled.  Or,
as in your first version, don't allow pparam.autoneg == False.

    Andrew

