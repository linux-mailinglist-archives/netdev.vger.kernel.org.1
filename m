Return-Path: <netdev+bounces-144155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 890D29C6089
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F802B298E3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF85205AAC;
	Tue, 12 Nov 2024 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dm18XPwS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED51FF606;
	Tue, 12 Nov 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429151; cv=none; b=VU16dV6nzr31FpLcW1w/Qn25q0eLtylCqnC9SnmO9LuxPMD4LjoLCpkaWlBw1jBKom+loYFIM50zc7IfaNOrzkzKoqlWCWbO3G8SWRmdZtAMBwz7fjJ8WTqBOAASGpFWZxvwhsDLwz2sJV/9KJ6uWWtTfzV2fQ3l3x1Fh1LLKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429151; c=relaxed/simple;
	bh=F/XCPeO4O8tZN4eAcsA8CztI64hU6XKdoR4/jrSSK+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hu3SWg9w0NeO9M0BooFwX8wQZK8D9HY3tXE07D6YBUyFCrY69rF7MP5qzcMsPzlXvPxMqmuQS1gtTiJ2EOcvO1VW0jxQfDkrnGl/MOArIZw8SV+grZAoLR+WDTY+FplE79xmaJRfh8NHfKmgNV2pMd0cvr4A0WxpLFoU4yNfdLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dm18XPwS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Nu4Sd3KnZDWtn2DFp/yCpmc9h6SD4LwdQmAnX+pJ3qg=; b=dm18XPwSkIk2Gd4GhmDSBPzR/j
	j21k7+lwtSBsSVyO+fagzEbYD81nqsvBuDcMhk/9QkS7UETnN3OV6IintX0Q1LXOCbg4dyOu4c/Ba
	4Zo9ahr2WmLZpvYKpmxHwbwsOhKUxsxz+1/1OgNkV9h5gJGguU4DuN0WnqtggmxpBIcA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tAtoQ-00D3Cf-2g; Tue, 12 Nov 2024 17:32:18 +0100
Date: Tue, 12 Nov 2024 17:32:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net-next 5/7] net: hibmcge: Add pauseparam supported
 in this module
Message-ID: <d22285c6-8286-4db0-86ca-90fff08e3a42@lunn.ch>
References: <20241111145558.1965325-1-shaojijie@huawei.com>
 <20241111145558.1965325-6-shaojijie@huawei.com>
 <efd481a8-d020-452b-b29b-dfa373017f1f@lunn.ch>
 <98187fe7-23f1-4c52-a62f-c96e720cb491@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98187fe7-23f1-4c52-a62f-c96e720cb491@huawei.com>

On Tue, Nov 12, 2024 at 10:37:27PM +0800, Jijie Shao wrote:
> 
> on 2024/11/12 1:58, Andrew Lunn wrote:
> > On Mon, Nov 11, 2024 at 10:55:56PM +0800, Jijie Shao wrote:
> > > The MAC can automatically send or respond to pause frames.
> > > This patch supports the function of enabling pause frames
> > > by using ethtool.
> > > 
> > > Pause auto-negotiation is not supported currently.
> > What is actually missing to support auto-neg pause? You are using
> > phylib, so it will do most of the work. You just need your adjust_link
> > callback to configure the hardware to the result of the negotiation.
> > And call phy_support_asym_pause() to let phylib know what the MAC
> > supports.
> > 
> > 	Andrew
> 
> Thanks for your guidance,
> 
> I haven't really figured out the difference between phy_support_sym_pause()
> and phy_support_asym_paus().

sym_pause means that when the MAC pauses, it does it in both
directions, receive and transmit. Asymmetric pause means it can pause
just receive, or just transmit.

Since you have both tx_pause and rx_pause, you can do both.

> +static void hbg_ethtool_get_pauseparam(struct net_device *net_dev,
> +				       struct ethtool_pauseparam *param)
> +{
> +	struct hbg_priv *priv = netdev_priv(net_dev);
> +
> +	param->autoneg = priv->mac.pause_autoneg;
> +	hbg_hw_get_pause_enable(priv, &param->tx_pause, &param->rx_pause);
> +}
> +
> +static int hbg_ethtool_set_pauseparam(struct net_device *net_dev,
> +				      struct ethtool_pauseparam *param)
> +{
> +	struct hbg_priv *priv = netdev_priv(net_dev);
> +	struct phy_device *phydev = priv->mac.phydev;
> +
> +	phy_set_asym_pause(phydev, param->rx_pause, param->tx_pause);

Not needed. This just tells phylib what the MAC is capable of. The
capabilities does not change, so telling it once in hbg_phy_connect()
is sufficient.

	Andrew

