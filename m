Return-Path: <netdev+bounces-172990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E36A56C38
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871297A5A52
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112521D01B;
	Fri,  7 Mar 2025 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bGc5tA3K"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF121CC7C;
	Fri,  7 Mar 2025 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361714; cv=none; b=OyVS8ud72WRQMG6nAAydHM6YbqW5dAm4d4sEFaUUQ/EvrO1ad4VlywzVo3ZBPFxN3pG23i7sSJ08vwZM+MRcA3rEgP6q/9LJaOG/j6uoJT+b+IAUtkolqmuZJNoC2n8D01UFwC1n526kb//ct6BTHjLGwNaOWhNb0qSYdgxJ78I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361714; c=relaxed/simple;
	bh=zpDzNzMQTz7b7/qntlneyT/nKeNHRUPJIdqF4FdT5GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSOTn3S7iXmk8EV/K/TD7CnUUBgPhwlYbmFXH5y9rLKnBhnqtgAWEVaaQZ7CvyTpARsrOyr8FQpgpZVvYrATy5yUqdBIdNlR+0jMtdvFtzD9rk8KWixWhQPfK2qM4UHiyaeI2CUKMwFcvyw/S/YL+yjTEyEDHn77aNcCfP7ZluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bGc5tA3K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hCshOJoEiJOSmt4EMGwGg+lny2/v+WdYh03qhKxiJ/0=; b=bGc5tA3KbdA/PPZAg53oSE+w3r
	ha2dbU/dEeNSx02jKLsnXuahA6Xmpp5kKEUdJstHEMUxoPAg01ChRd7BB0fRaiIJWltp1vAvIkfnF
	N+oRxqvu5c385AwEXQK7JM55jykYsSFxGxlDlVa+SocAjjRojhOdkO7bGbEvVQ/wkJDM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqZj1-003B1F-RW; Fri, 07 Mar 2025 16:34:59 +0100
Date: Fri, 7 Mar 2025 16:34:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: dimitri.fedrau@liebherr.com, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: phy: dp83822: Add support for changing
 the MAC series termination
Message-ID: <d57aff5b-7d1d-43bf-95a1-ee90689f5ac0@lunn.ch>
References: <20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com>
 <6aee57d3-8657-44d6-ac21-9f443ca0924e@lunn.ch>
 <20250307142252.GA2326148@legfed1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307142252.GA2326148@legfed1>

> Should I add the proper description in the bindings ? Description of the
> properties are somehow short. However will expand the description.

Yes, please expand the description. For well known concepts, we can
keep the binding description short. But i would not consider this a
well known concept, so we need to spell out in detail what it is.

My knowledge of transmission lines and termination is not so good....

So this configures the resistor on the PHY outputs. Do PHY inputs also
need termination resistors? Could there be PHYs which also allow such
resistors to be configured? Are there use cases where you need
asymmetric termination resistors?

My questions are trying to lead to an answer to your question:

> Should I rename then "mac-series-termination-ohms" to
> "output-mac-series-termination-ohms" or similar ?

We should think about this from the general case, not one specific
PHY, and ideally from thinking about the physics of termination.

https://electronics.stackexchange.com/questions/524620/impedance-termination-of-marvell-phy

This seems to suggest RGMII only has termination resistors at the
outputs. So "mac-series-termination-ohms" would be O.K.

	Andrew

