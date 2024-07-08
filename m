Return-Path: <netdev+bounces-109900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2282092A3A8
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE871F223CE
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A98137923;
	Mon,  8 Jul 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sy25OWAg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE7813D272;
	Mon,  8 Jul 2024 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445398; cv=none; b=Z0jUGzhYXjspABd+yo2FrOw4dCL1uZOmKhIMZ7QRULyAqaCJd2K31oTJL/4dzS3EWlzNg69HsXOC2pS8Lazwu6gxO3qn0sBli2UbBq+rfTxtUFNDHeVzDu8Gt1hInz2ypWsrITFu9D/dpe5MxkYeziI7zBPu6J3mH3MVXQ2LaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445398; c=relaxed/simple;
	bh=zLtzfflkACcCU+hZpxYEWivw4ucq6iKAsrRUXCdURr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlGJ0nzPIal29QarPBtO5+NOofAJ7vj0jY9W1xOFyuQlXH3umTnSp4trFb/HxECIvNrzPd1H4nBPmmteGa0GPrmqxTNNGagnlaKc+1fKANs203k2OAt0KvhYopm21dRDBmvLyyas3nXmqXl/nfjpk/TAvLN91EaOLCRqvLM4QWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Sy25OWAg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j3pIkdVyZRpeKtxUsSKKbC2YLF/Mo1HThT+liR+14c8=; b=Sy25OWAg1upF24t5LN3fXSp0zp
	12TPemmb2rGfz/RQyOy6KXpRSPjK6TUq/LL6XoAIJ8WSRUc72U3avK6X4EfjR5Cbo95ptWcsTXJxN
	rrffAe5hG0d0gXgnCRXt+fqDw0ZPsonS2USXYU1xI/g8mGaoMAI1dXNOD2068djszUPY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sQoR9-0022jK-IF; Mon, 08 Jul 2024 15:29:47 +0200
Date: Mon, 8 Jul 2024 15:29:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Michal Kubecek <mkubecek@suse.cz>, Woojung.Huh@microchip.com,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v1 1/1] ethtool: netlink: do not return SQI value if
 link is down
Message-ID: <392fd432-3e2d-4223-ab97-c3548430734a@lunn.ch>
References: <20240704054007.969557-1-o.rempel@pengutronix.de>
 <dbfa3bc1-fff0-4dc7-a9f2-6cd304d4eaf8@lunn.ch>
 <ZoebO_i6P33iX4B1@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoebO_i6P33iX4B1@pengutronix.de>

> If -ENETDOWN is returned:
> Settings for spe4:
>         Supported ports: [ TP ]
>         Supported link modes:   100baseT1/Fulli
>         Supported pause frame use: No
>         Supports auto-negotiation: No
>         Supported FEC modes: Not reported
>         Advertised link modes:  100baseT1/Full
>         Advertised pause frame use: No
>         Advertised auto-negotiation: No
>         Advertised FEC modes: Not reported
>         Speed: 100Mb/s
>         Duplex: Full
>         Auto-negotiation: off
>         master-slave cfg: forced slave
>         master-slave status: unknown
>         Port: Twisted Pair
>         PHYAD: 6
>         Transceiver: external
>         MDI-X: Unknown
>         Supports Wake-on: d
>         Wake-on: d
> netlink error: Network is down
> 
> Instead of "Link detected: no", we will get netlink error.

Thanks. This is not great. There was a slim chance it looked at each
individual return value, and would of put "SQI: Network is down", but
it does not. So not including the value does seem the best.

	Andrew

