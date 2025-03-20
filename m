Return-Path: <netdev+bounces-176466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77533A6A711
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2824176D2B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7D3214A88;
	Thu, 20 Mar 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UukUAibz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D41DFE00;
	Thu, 20 Mar 2025 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477052; cv=none; b=AuMGBzivTXvewIBrKJOr+KnGpRldg+5EKoi/NNLARuPT5vR4gHU03fYHiUb9vvkV9nrKL2HUsYF8XsZiRgwFFsG5CqWL1ujLo0Lg2Jakym1yAA00vUyDZ15yCWiIVErRd79UdoeCak5DJZahCBoKZdbPAT3I0zh+aO5M+vKbDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477052; c=relaxed/simple;
	bh=+TpLCsKFfjMwGBDtTsipoHPUIvdSM3dn8mNDo87/f8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deFZT3Xk+SVNA0A+5iv4fcTzC+sWx9bL2JmPYmuCLUlrbaXOtK7Igvpbo+5Oar5j2Ya2uJjMGNyLsaQVC0w5ryJGV+rRQ1t+ab9wxhNAjT23ghIeXK+PktHyzQSEiMm4rpGb1cEAw5/APhZgliBwqGp06nUMJ/PHEu0iw0D5V8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UukUAibz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m/Tu4PfY/OmYLj9IINFcwahi6xEnQdf1mSKCgFo1yJI=; b=UukUAibzOcZU1Qa6sLw0/3vXzu
	4ZoM+SY8VlP2g4RqKALQ3cXbGQeWoBKt4q6hU9Ea5/ljiytKmxVsOC/bAcEQeMjCGRwYbgeyE4vpn
	AoKW6s0OoCYMqD7ajG5TmxtsaLEM+wlvdwCyOAOTpL6+H5FXO+okIovtDhVTpdg5hE5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tvFsG-006Tmp-SM; Thu, 20 Mar 2025 14:23:52 +0100
Date: Thu, 20 Mar 2025 14:23:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Marek Vasut <marex@denx.de>, Simon Horman <horms@kernel.org>,
	Ronald Wahl <ronald.wahl@raritan.com>, Peng Fan <peng.fan@nxp.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>
Subject: Re: [PATCH net-next] net: ethernet: Drop unused of_gpio.h
Message-ID: <46bbe18e-05d8-40e3-a50a-b9c31d5ddede@lunn.ch>
References: <20250320031542.3960381-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320031542.3960381-1-peng.fan@oss.nxp.com>

On Thu, Mar 20, 2025 at 11:15:24AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> of_gpio.h is deprecated. Since there is no of_gpio_x API, drop
> unused of_gpio.h. While at here, drop gpio.h and gpio/consumer.h if
> no user in driver.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

net-next.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

