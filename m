Return-Path: <netdev+bounces-242387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10359C90018
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACB4A34ACEF
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 19:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6DB2DA760;
	Thu, 27 Nov 2025 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tBdF/LeY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B750149C6F
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764271258; cv=none; b=TJzAdmdiuymfs8oW5W0YzhXU5sOYCZmtBAq6NwVf6BClDd8aPRSZ6016A/I0jtmQFEwkItr+vu/q0s2ygP2Yu5RgI9BOYXA9oT5DkQ9hoKl/eOLgdmU0rpHMX5uDdwjUQxDSDbWJB48ZxGy6FlEa9JTbi2+nFu4ljzjL41GMsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764271258; c=relaxed/simple;
	bh=m6g3hYHjsqfT3tExxFNza3ml4EskI9SWcEotb0i35e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D50CICh2FfhR5oG5dCeHs/nyq7ehR/g1KQRjxNVgf7+JdyD9Rqz5DromvzHAgAVrSXTovMNZQ+DqEuCNId3drDjJaXhJ1o7E7N2airIC7M21lt+XA2IpFE5eENffZLmiBo0rN3nwxcdcZU7iwXMjpeD3QsgJyTkTgB7oWqgHgGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tBdF/LeY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NRxLA18Q6HjWuZV5oIkAX1GINlV8uf9w6gCww5tYJyI=; b=tBdF/LeYSBabPW2LJIc7NHfDPo
	XcK9mCLiAkHEuYSDaAK7tAtVMfPUS27wE7VUiX8hFW7xnY2tRSsjLwlLa52rTIatWPvyXxnbWRqV3
	yklsOgx+rGuuLedmSrlblD9AO3QntbQUN3mgAEYR8p6KAPHQ06JAvqxAHyH42UTqBWvw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vOhXx-00FI9F-IU; Thu, 27 Nov 2025 20:20:53 +0100
Date: Thu, 27 Nov 2025 20:20:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: netdev@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: thunderbolt: Allow reading link
 settings
Message-ID: <3ac72bf4-aa0e-4e3f-b6ef-4ed2dce923e1@lunn.ch>
References: <20251127131521.2580237-1-mika.westerberg@linux.intel.com>
 <20251127131521.2580237-4-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127131521.2580237-4-mika.westerberg@linux.intel.com>

> +static int tbnet_get_link_ksettings(struct net_device *dev,
> +				    struct ethtool_link_ksettings *cmd)
> +{
> +	const struct tbnet *net = netdev_priv(dev);
> +	const struct tb_xdomain *xd = net->xd;
> +	int speed;
> +
> +	ethtool_link_ksettings_zero_link_mode(cmd, supported);
> +	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
> +
> +	/* Figure out the current link speed and width */
> +	switch (xd->link_speed) {
> +	case 40:
> +		/* For Gen 4 80G symmetric link the closest one
> +		 * available is 56G so we report that.
> +		 */
> +		ethtool_link_ksettings_add_link_mode(cmd, supported,
> +						     56000baseKR4_Full);
> +		ethtool_link_ksettings_add_link_mode(cmd, advertising,
> +						     56000baseKR4_Full);
> +		speed = SPEED_56000;

Please add SPEED_80000.

I commented on the previous version. Is supported and advertising
actually needed? If not, please leave them blank.

	Andrew

