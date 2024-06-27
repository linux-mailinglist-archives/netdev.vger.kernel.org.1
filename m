Return-Path: <netdev+bounces-107366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1391AAED
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E23281A80
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81BB198E71;
	Thu, 27 Jun 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mwVfIhDw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63658197555;
	Thu, 27 Jun 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501367; cv=none; b=ofHyOdxwnV+sro/qkr9XvyGGR8UdNfYQKXoLtzN8LMlK4sDzefA+AJ0OAbul7GZPFt5/futpmUTWiZoXLkwn4sAoqAmxqVMkF6D1Drv/sizkRJ07j3aGuiTUEGye6hRcWvJ/jtlX5TV+cSBRP1MQcP7v7GABlRHctzYmuNLc4VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501367; c=relaxed/simple;
	bh=Edgf2el7vfsPa7gk4PEhJ0JF9QtzPXpxY3Pe1JoTo1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nieM4XEAW0yG5d4gizqHxavt/7/YXUeWRfNh9/at3VufoCiwYi9UDBT7tHfM2VPfG9hDrAvDLm99ERF4JLRl+bhcVYYv46b0eWKlCduFzMctT5kr73IAiL+2KzeHZn/ul2DsZiKRNOCFjxCKGQNfiOiI8habuwm1SUXS0rhziJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mwVfIhDw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QKCRMBwJDf5cHZ/yhnI+yJCQsyATUHSXjQblCJTVe3Q=; b=mwVfIhDwHKSNaCMinHIFYrWYcy
	Ci9uGmNuK4rVfOiVYAZMTz/6tGc3ues7nW9mgqDHbTB1fyiH9cA2zIlsHK5lvCir/7Iz8Bc4EOWZE
	aH0ve4E8mbx+pN38lkhktjYZQZD3YVaeZAVu8OpGm+7rT0RiHFRnBfq1EWbmcwLjXFyg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMqqo-001B7c-Q2; Thu, 27 Jun 2024 17:15:54 +0200
Date: Thu, 27 Jun 2024 17:15:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Lucas Stach <l.stach@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 2/3] net: dsa: microchip: lan937x: force
 RGMII interface into PHY mode
Message-ID: <f610effb-34af-4150-a320-c8882117b632@lunn.ch>
References: <20240627123911.227480-1-o.rempel@pengutronix.de>
 <20240627123911.227480-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627123911.227480-3-o.rempel@pengutronix.de>

On Thu, Jun 27, 2024 at 02:39:10PM +0200, Oleksij Rempel wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> The register manual and datasheet documentation for the LAN937x series
> disagree about the polarity of the MII mode strap. As a consequence
> there are hardware designs that have the RGMII interface strapped into
> MAC mode, which is a invalid configuration and will prevent the internal
> clock from being fed into the port TX interface.

What i think is missing from this is that you are talking about the
CPU port. For a normal user point, RGMII MAC mode would make sense, if
there is an external RGMII PHY attached. And the code only does this
if the port is a CPU port.

So maybe:

... that have the CPU port RGMII interface ...

	Andrew

