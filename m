Return-Path: <netdev+bounces-115332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB06945E3D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D4E1C22858
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023851E4842;
	Fri,  2 Aug 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Uiq+V2F6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48751DF66E;
	Fri,  2 Aug 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603672; cv=none; b=JLla2Yh+Jle67MVNJR3Agpd5fuVYOz8KmV4FxYklosWPeOmvw7g2laiukRFa8LNcZ2ZJtQzBLOJrcMs3JeSJfwl9srHmbKUtIzji4/+VR8h49h1dC/lr0kaTsdxXlaa0+ycbNcbazR5Ne/HyufZyIE0KDyBgHH29T5Mn1zeNT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603672; c=relaxed/simple;
	bh=m6iSvV9AmND1hcZN2f+bPfnP14wQvEKYq43atXqwy38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bImQkCBxiuVtuXgWgr0dXhtHB5WzmL3YvhY/NCbDoWC0YsvKqVJdyM+5Nl9gYY4Zynf8an8YMXtDH/a7m6ZQkGQ+7PIxOp4RerWJNEC59TAzfc9SAlfILeIrOL/Z1flG2hUMHdA6cvKHLz8pPhiDEaVFjpEFUDxAoRo79bzZ/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Uiq+V2F6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PgzsDZJO5TJV6XeYvtT0REpDP+vDzAbSZioJj7fuDso=; b=Uiq+V2F6DvyppVyFElBewaa6tq
	oM6FI+xzIQWnl0MAXWwQIS4E9K43B50mnRNARXyuSAZA+EHyV6Jhj7vEAvkoevTrOfAy8TK8piEf4
	lwivZz7syNh9spjMfvjSzfIqne92wlJ+7LeRFUUxJboWMdu0OuHG58XjjWxnV9wTdMxtrpiCI+Viw
	D7T4Eh5LnMyHYD2PvuQcVPWI9Qh6JsH39H0SDq0yJRYjtGUANqYohEggSHyu3kZ4nlzJxCVC9ljTU
	LNPQ5jN2m1DlMr/Ce/4aNLlSz9PtUIeksTnRk/OknmtpxWaJaP8T2TDrnGODqeVz0ZbMcJxAl3S8H
	aNpO3pUQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38078)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZrty-0006l2-26;
	Fri, 02 Aug 2024 14:00:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZru1-00083F-Ib; Fri, 02 Aug 2024 14:01:01 +0100
Date: Fri, 2 Aug 2024 14:01:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/6] net: dsa: vsc73xx: allow phy resetting
Message-ID: <ZqzYjfCfpaLqOy+r@shell.armlinux.org.uk>
References: <20240802080403.739509-1-paweldembicki@gmail.com>
 <20240802080403.739509-6-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802080403.739509-6-paweldembicki@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 02, 2024 at 10:04:02AM +0200, Pawel Dembicki wrote:
> Now, phy reset isn't a problem for vsc73xx switches.
> 'soft_reset' can be done normally.
> 
> This commit removes the reset blockade in the 'vsc73xx_phy_write'
> function.

This commit message needs to explain more clearly why a soft reset is no
longer a problem. For example, which patch in this series makes it now
safe to do?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

