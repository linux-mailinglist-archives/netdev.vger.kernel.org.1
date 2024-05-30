Return-Path: <netdev+bounces-99397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50F88D4C05
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71518282BF2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3EE17FADD;
	Thu, 30 May 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gXQYtdz1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890517F4E3;
	Thu, 30 May 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073476; cv=none; b=RBr3WJQFi/Qdx94z0raOYLVVSO0dRJJQAQFKSjFwmyZGIVdvHfJ2SHlkzeGbJlPOMkA2dANMT+yN9kC3aXrZ4REgARGDP86bDDuj2iKWszWVD4yqJF9nEgX+MNLwWmiXTAoY33kmf/QPwVkop1dr3xJUmc/Bb2/jQWmNrVjHoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073476; c=relaxed/simple;
	bh=FM/o12UO78tssoamv7cLYoLJcwoDUK6wJjjfANsu2WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqmMzR2q2c5QMVrt1sYnF8JCa6jrpyp0bN3l3TVK3KpLiaDd4dNsIrJCo0ikKji/jYkUYAVVJ+1CXU2PA+vcAq6kX0vE9bP1Vz6KYMSp9C4nMN3Qd4u2R3MauQPv8nz8nyg5RMsxWELNzPgt1Uf/sPp3THGdwexj/ue16W+I9No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gXQYtdz1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=R1lF1wuasm5jFlbWmNPDithSHl/LG9a64ccE2zsJSIo=; b=gXQYtdz193aVp73jZH9Gw6CyYL
	7mdQGhJE3gKkmibVaS500roNOY6CeeXKed4RkbYypg+cH+B1wQT+bdHDTTbeBUpYyMmb9e3bvO7tW
	TFw9HsK6SuPszPSZQSRhIuVkNV4Cl5B9tyfbdXfsAcdlbbyKzRgT3u92tbV/vOjc8QW4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sCfF6-00GLY9-Te; Thu, 30 May 2024 14:50:52 +0200
Date: Thu, 30 May 2024 14:50:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: linux@armlinux.org.uk, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net v2 PATCH] net: stmmac: Update CBS parameters when speed
 changes after linking up
Message-ID: <f8b0843f-7900-4ad0-9e70-c16175e893d9@lunn.ch>
References: <20240530061453.561708-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530061453.561708-1-xiaolei.wang@windriver.com>

>  static void stmmac_configure_cbs(struct stmmac_priv *priv)
>  {
>  	u32 tx_queues_count = priv->plat->tx_queues_to_use;
>  	u32 mode_to_use;
>  	u32 queue;
> +	u32 ptr, speed_div;
> +	u64 value;
> +
> +	/* Port Transmit Rate and Speed Divider */
> +	switch (priv->speed) {
> +	case SPEED_10000:
> +		ptr = 32;
> +		speed_div = 10000000;
> +		break;
> +	case SPEED_5000:
> +		ptr = 32;
> +		speed_div = 5000000;
> +		break;
> +	case SPEED_2500:
> +		ptr = 8;
> +		speed_div = 2500000;
> +		break;
> +	case SPEED_1000:
> +		ptr = 8;
> +		speed_div = 1000000;
> +		break;
> +	case SPEED_100:
> +		ptr = 4;
> +		speed_div = 100000;
> +		break;
> +	default:

No SPEED_10 ?

> +		netdev_dbg(priv->dev, "link speed is not known\n");
> +	}
>  
>  	/* queue 0 is reserved for legacy traffic */
>  	for (queue = 1; queue < tx_queues_count; queue++) {
> @@ -3196,6 +3231,12 @@ static void stmmac_configure_cbs(struct stmmac_priv *priv)
>  		if (mode_to_use == MTL_QUEUE_DCB)
>  			continue;
>  
> +		value = div_s64(priv->old_idleslope[queue] * 1024ll * ptr, speed_div);
> +		priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);

Rather than masking off the top bits, shouldn't you be looking for
overflow? that indicates the configuration is not possible. You don't
have a good way to report the problem, since there is no user action
on link up, so you cannot return -EINVAL or -EOPNOTSUPP. So you
probably want to set the hardware as close as possible.

Also, what happens if the result of the div is 0? Does 0 have a
special meaning?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 222540b55480..d3526ad91aff 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -355,6 +355,9 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  	if (!priv->dma_cap.av)
>  		return -EOPNOTSUPP;
>  
> +	if (!netif_carrier_ok(priv->dev))
> +		return -ENETDOWN;
> +

Now that you are configuring the hardware on link up, does that
matter?

	Andrew

