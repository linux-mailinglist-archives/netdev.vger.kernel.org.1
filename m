Return-Path: <netdev+bounces-215544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25AB2F271
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8831BC33C2
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721F62D131A;
	Thu, 21 Aug 2025 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xpHmr9OU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533982877CA;
	Thu, 21 Aug 2025 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765053; cv=none; b=GO7vV+7Lmb8dAllHYoQ42Wg74IxvYVn+7jsPVllcOBsuhaq1doS6+Td+UzOCl7VK4IdC+AZTHFdWO4fbjqIdbGHtLf+jViIT2nrjrMG7pEV55KXS8saJZq7vYSBO+msXzmdx7LiB0blqKypFqpHvSGv4hgyNjClT/Ci6w/lA/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765053; c=relaxed/simple;
	bh=nAHExjg2GB1moowRbRupjfbdewBjSHwZlbBdNpYDk/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSwbE2759TTNuzPAXDnV+Ed5yEzT50TBNJ7m1qgkIwKRs7sqkYDcFiQ+Yei4Fso0BLjJLsVsVJ1SB6mzC0pANmyrNsVmE2+S5Tjz789RIMUgar+ca3eUEUaJeJCpVw5C7pCjlG80tHJqtY9C0W9fCkoiD7UQJJd6OHpNh7EFXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xpHmr9OU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=umqiuqpl92vLkFrBEOgMn4O1gLGgBbb+mOAsh/N+N04=; b=xpHmr9OUghCfQitUOyENjjAoOM
	5UjxlDxiDJJHE9B2yyFZZHMUgEjvtSxfRXnfBkmSi+PWjzDd+EyTBpMgdRa/ecKk0n3oQErpsGb/w
	Et2ZGaRSZuNMTcetfUmgqJA2ySVtvVaFTvuObomrbdy51NFAM/mQfOTUZJx5a6NZSdbuVcFmOFvWv
	EKpp37EwoqlWeGi2uLgvmo5NyaPc5v2Xto0dbkZ/nTxGbBLjGIECKIqYrQ43n8JFnZZJr6kJRo+jM
	Vn4TgxuwIaqy7o3dY6onVglOmjiMAkWsL9mEkk3lhhtJYz4qPNT0sRT9hh7n1bgbRpG5yF4ehZsgq
	8HsgFnfw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48070)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1up0h4-000000000qk-1iZn;
	Thu, 21 Aug 2025 09:30:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1up0h1-000000000w4-3HkS;
	Thu, 21 Aug 2025 09:30:43 +0100
Date: Thu, 21 Aug 2025 09:30:43 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v5 3/3] net: dsa: yt921x: Add support for Motorcomm
 YT921x
Message-ID: <aKbZM6oYhIN6cBQb@shell.armlinux.org.uk>
References: <20250820075420.1601068-1-mmyangfl@gmail.com>
 <20250820075420.1601068-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820075420.1601068-4-mmyangfl@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 20, 2025 at 03:54:16PM +0800, David Yang wrote:
> +static int
> +yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
> +		   const struct phylink_link_state *state)
> +{
> +	const struct yt921x_info *info = priv->info;
> +	struct device *dev = to_device(priv);
> +	enum yt921x_fixed fixed;
> +	bool duplex_full;
> +	u32 mask;
> +	u32 ctrl;
> +	int res;
> +
> +	if (state->interface != PHY_INTERFACE_MODE_INTERNAL &&
> +	    !yt921x_info_port_is_external(info, port)) {
> +		dev_err(dev, "Wrong mode %d on port %d\n",
> +			state->interface, port);
> +		return -EINVAL;
> +	}
> +
> +	fixed = YT921X_FIXED_NOTFIXED;
> +	ctrl = YT921X_PORT_LINK;
> +	if (mode == MLO_AN_FIXED)
> +		switch (state->speed) {

Someone clearly doesn't believe in reading the documentation before
writing code. This also hasn't been tested in any way. Sorry, but
I'm going to put as much effort into this review as you have into
understanding the phylink API, and thus my review ends here.

NAK.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

