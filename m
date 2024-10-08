Return-Path: <netdev+bounces-133306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585889958FC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8CF1C21419
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09300215F54;
	Tue,  8 Oct 2024 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eBNO0PQh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD121DF99B;
	Tue,  8 Oct 2024 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728422056; cv=none; b=d8IrkF1hBYvRztp3Yr3YuIruKfBeAdi9jdVgxg7w89BGaB8DmqesSM4ke2snQ0PNMVp0VNy8n1z/xZSj9kub++WEvcoXbFapFuIM1D8mPnuDNlRxVJY/YgeotQJywfrt6hNcklufnZxWNBEjPjvIrwy2FyKbXW8geyaocbBShqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728422056; c=relaxed/simple;
	bh=/dliGEewKRZribczQoNeiV6X+4qsNadUl7k0K75up9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIIMf5uFo5yaryukwc25CelnmxBpRmhnlHpXrZZ1A1juCfSCor0i9jdIST6UlPfJ7v1c79X7HoUcZ/tkyQi9xfrTlU7P7hGkrrcHjMhX/mMCqcc3dvak6qY8Fz3vaXorLK30Te/nI8ENaaXaFKeaFfwNmFhRTrMkO8FMhTFprbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eBNO0PQh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fXa2rjQqSmEEprIVSsvVh1O3dTW7jIaPiGYIOj8vgEM=; b=eBNO0PQh9wrStrPWtR3+RdCmzS
	sZ3xchEC5hgUFjuibTqsvYiII76/6KkDsPUZjeWacGXigWFVqbEn1dsHjSmqHzbmuHjlIvS2BpWfO
	2jqiOak5ArKMU/IccXFpcGH9JmtJnLigHycizAvV+mnXyhmfwPRRJkop5A+E/vlvkJ+4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syHWn-009Pka-Jq; Tue, 08 Oct 2024 23:13:57 +0200
Date: Tue, 8 Oct 2024 23:13:57 +0200
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
	=?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: phy: aquantia: allow forcing order
 of MDI pairs
Message-ID: <c5339983-d768-4a1c-a951-dbc99ae16b21@lunn.ch>
References: <7ccf25d6d7859f1ce9983c81a2051cfdfb0e0a99.1728058550.git.daniel@makrotopia.org>
 <9ed760ff87d5fc456f31e407ead548bbb754497d.1728058550.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ed760ff87d5fc456f31e407ead548bbb754497d.1728058550.git.daniel@makrotopia.org>

On Fri, Oct 04, 2024 at 05:18:16PM +0100, Daniel Golle wrote:
> Despite supporting Auto MDI-X, it looks like Aquantia only supports
> swapping pair (1,2) with pair (3,6) like it used to be for MDI-X on
> 100MBit/s networks.
> 
> When all 4 pairs are in use (for 1000MBit/s or faster) the link does not
> come up with pair order is not configured correctly, either using
> MDI_CFG pin or using the "PMA Receive Reserved Vendor Provisioning 1"
> register.
> 
> Normally, the order of MDI pairs being either ABCD or DCBA is configured
> by pulling the MDI_CFG pin.
> 
> However, some hardware designs require overriding the value configured
> by that bootstrap pin. The PHY allows doing that by setting a bit in
> "PMA Receive Reserved Vendor Provisioning 1" register which allows
> ignoring the state of the MDI_CFG pin and another bit configuring
> whether the order of MDI pairs should be normal (ABCD) or reverse
> (DCBA). Pair polarity is not affected and remains identical in both
> settings.
> 
> Introduce property "marvell,mdi-cfg-order" which allows forcing either
> normal or reverse order of the MDI pairs from DT.
> 
> If the property isn't present, the behavior is unchanged and MDI pair
> order configuration is untouched (ie. either the result of MDI_CFG pin
> pull-up/pull-down, or pair order override already configured by the
> bootloader before Linux is started).
> 
> Forcing normal pair order is required on the Adtran SDG-8733A Wi-Fi 7
> residential gateway.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

