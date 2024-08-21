Return-Path: <netdev+bounces-120672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822CC95A28E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 18:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D2A1C2215E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8264014F9F3;
	Wed, 21 Aug 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ciTN5uQ/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0F814F9E1;
	Wed, 21 Aug 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256851; cv=none; b=URQDbpjzoCMmSXkrKxgzPOXyKnpXOViyH5ZODIlj3tepgF3J7wx1qTKkeDbp7ms8RNfItKkg3ydMRA9RyMyeoV8TbWbATbgah+WPElv2iihITFUTMv6lsSvVCsxD86WoB8wGmNoRGhgrdFKN1LEgSCxOWjo9lI7jWy7y4Lx4iqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256851; c=relaxed/simple;
	bh=S5Yj0vGb5fCP5I/rslesLN4v6D0QJdf+JBcc9/hBrrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVzBMmwPhXvmlsxBt99snR30v0O0zdDaKeuMBQwr7l6bEXwHW40Bzg9ENKzADGS/j36c4CBtAq4mIMmrf1jdWi3Eg1f0kYFMmOMlD7HcaN+8pIjw9EQTPoEagAQ1WPnkuZhJ1jyZN1NDri+OgCMMw6LkcM5Jbxa18lDAVOiMbiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ciTN5uQ/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FrWrrx+C7Q18TcUo6GOge+v9NwsexFUCl+eyKzUnLnQ=; b=ciTN5uQ/Sz4nzJV91y4WwA1HE/
	KPVOnJB1ifV6dbmI6+aKRg6rNvvK4C0p/7pcLMtCi9aXeN2pxWFZSJX9DgIc02SH1QyKiyVyNYj71
	2TIKUKoqtLDfCYwFywPviQ5I/E8T6GmiSERumAKufpTHaauAx5onRS7ZfxGOgwA7q720=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgny8-005LX9-7N; Wed, 21 Aug 2024 18:13:56 +0200
Date: Wed, 21 Aug 2024 18:13:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Chad Monroe <chad.monroe@adtran.com>,
	John Crispin <john@phrozen.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: marvell,aquantia: add
 properties to override MDI_CFG
Message-ID: <6e018572-0a74-40af-bf5d-74aed60853a6@lunn.ch>
References: <5173302f9f1a52d7487e1fb54966673c448d6928.1724244281.git.daniel@makrotopia.org>
 <2c4e03e9-6965-4e81-a986-e169eaea9e4b@lunn.ch>
 <ZsYRB54U5XPNZxiT@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsYRB54U5XPNZxiT@makrotopia.org>

On Wed, Aug 21, 2024 at 05:08:39PM +0100, Daniel Golle wrote:
> On Wed, Aug 21, 2024 at 06:00:36PM +0200, Andrew Lunn wrote:
> > On Wed, Aug 21, 2024 at 01:46:30PM +0100, Daniel Golle wrote:
> > > Usually the MDI pair order reversal configuration is defined by
> > > bootstrap pin MDI_CFG. Some designs, however, require overriding the MDI
> > > pair order and force either normal or reverse order.
> > 
> > Could you explain that in a bit more detail. Are you talking about
> > changing the order of the 4 pairs? Or reversing the polarity within
> > pairs?
> 
> It's about changing the order of the 4 pairs, either ABCD or DCBA.
> Polarity of each pair is not affected by this.

So when i do

ethtool -s 42 mdix off

to enable straight through, are you saying the PHY actually does
crossover, because the pull-up tells it the wrong thing about how the
cable is wired? And `mdix on` for crossover gives straight?

'mdix auto' just works as expected, since it tried all the
combinations until it works?

      Andrew


