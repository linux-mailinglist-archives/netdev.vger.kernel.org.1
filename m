Return-Path: <netdev+bounces-87052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9B58A1755
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 16:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5E91C20C22
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 14:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1272310F7;
	Thu, 11 Apr 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aP6taUqV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3311C2E
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846116; cv=none; b=BV8dFROSVBTMiJ0kCo61y8RuT7I14iHyq+UDLRvGzAs7k3Of6jtWMKo6+pOkWUsmMC0sxTeIJkMh//NsiyYw4D+Ggiu1Z95KBNR7fgJGW6wXwIz6Nm2no47XaT/UBVr8pT1ZvL2MjX1dLX0hoJz6spCQ7s9VvN4OVrXM1OG3jeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846116; c=relaxed/simple;
	bh=cZ5YUlRRUoMKXrKTwST2RLraGsw6fJnPUABSQM5CzGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3KL+9xHYvkhbaBXaFoFK5cOWtsSG9v6DbLUXZmiZkTYMpu7mI7HtKHmQLXIp4YybPxznSlZSJzwyIoyX0LVhNYOOYATGAAeIxDVLJmgtjgnyWzqpds9zr/MMXaPK6F2K3UAjP2LhymXMoKt7iBPdsE1WFimFGMB+Rjq/2eeDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aP6taUqV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EYVDdYeh04okbdMI/eWdfGqzvMINUwe8OiPw454oS+o=; b=aP6taUqVnTAmjsQf8LZY+DGFc7
	UGh3P9xu34c8NtdTJ0ecntYP/4ZUH9maN1330IZjeh04MVBu0BUYipGxj0vh2f42+mLtjxMbtoM9M
	pX3moxDpjrQGftpL91Zw50FwMkQNrKFm3SPSVnG20392paM+KE12hVnLw3zdYU3KUDDY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ruvW4-00CmWx-Q5; Thu, 11 Apr 2024 16:35:04 +0200
Date: Thu, 11 Apr 2024 16:35:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: genet: Fixup EEE
Message-ID: <843316df-162f-4551-97ec-8e30dc054b41@lunn.ch>
References: <20240408-stmmac-eee-v1-1-3d65d671c06b@lunn.ch>
 <4826747e-0dd5-4ab9-af02-9d17a1ab7358@broadcom.com>
 <67c0777f-f66e-4293-af8b-08e0c4ab0acc@lunn.ch>
 <c2a16e3c-374c-4fd1-9ca7-bf0aeb5ed941@broadcom.com>
 <ZhdycHAooDITV1a3@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhdycHAooDITV1a3@pengutronix.de>

On Thu, Apr 11, 2024 at 07:17:36AM +0200, Oleksij Rempel wrote:
> Hi Florian,
> 
> On Wed, Apr 10, 2024 at 10:48:26AM -0700, Florian Fainelli wrote:
> 
> > I am seeing a functional difference with and without your patch however, and
> > also, there appears to be something wrong within the bcmgenet driver after
> > PHYLIB having absorbed the EEE configuration. Both cases we start on boot
> > with:
> > 
> > # ethtool --show-eee eth0
> > EEE settings for eth0:
> >         EEE status: disabled
> >         Tx LPI: disabled
> >         Supported EEE link modes:  100baseT/Full
> >                                    1000baseT/Full
> >         Advertised EEE link modes:  100baseT/Full
> >                                     1000baseT/Full
> >         Link partner advertised EEE link modes:  100baseT/Full
> >                                                  1000baseT/Full
> > 
> > I would expect the EEE status to be enabled, that's how I remember it
> > before.
> 
> Yes, current default kernel implementation is to use EEE if available.

We do however seem to be inconsistent in this example. EEE seems to be
disabled, yet it is advertising? Or is it showing what we would
advertise, when EEE is enabled?

> > Now, with your patch, once I turn on EEE with:
> > 
> > # ethtool --set-eee eth0 eee on
> > # ethtool --show-eee eth0
> > EEE settings for eth0:
> >         EEE status: enabled - active
> >         Tx LPI: disabled
> >         Supported EEE link modes:  100baseT/Full
> >                                    1000baseT/Full
> >         Advertised EEE link modes:  100baseT/Full
> >                                     1000baseT/Full
> >         Link partner advertised EEE link modes:  100baseT/Full
> >                                                  1000baseT/Full
> > #
> > 
> > there is no change to the EEE_CTRL register to set the EEE_EN, this only
> > happens when doing:
> > 
> > # ethtool --set-eee eth0 eee on tx-lpi on
> > 
> > which is consistent with the patch, but I don't think this is quite correct
> > as I remembered that "eee on" meant enable EEE for the RX path, and "tx-lpi
> > on" meant enable EEE for the TX path?
> 
> Yes. More precisely, with "eee on" we allow the PHY to advertise EEE
> link modes. On link_up, if both sides are agreed to use EEE, MAC is
> configured to process LPI opcodes from the PHY and send LPI opcodes to
> the PHY if "tx-lpi on" was configured too. tx-lpi will not be enabled in
> case of "eee off".

Florian seems to be suggesting the RX and TX path could have different
configurations? RX EEE could be enabled but TX EEE disabled? That i
don't understand, in terms of auto-neg. auto-neg is for the link as a
whole, it does not appear to allow different results for each
direction. Does tx-lpi only make sense when EEE is forced, not
auto-neg'ed?

	Andrew


