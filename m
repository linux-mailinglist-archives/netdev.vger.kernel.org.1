Return-Path: <netdev+bounces-239991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C67C6EE81
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC6C54E9D50
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721333CEA5;
	Wed, 19 Nov 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="B4qYBeBK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FEC27442
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558647; cv=none; b=rgUnGd84U7L4S8gPpCbVSNUfmG2XB2AuM8DQvmdWJ3q7fsXqhHxJZXyXDe8MnPYEXDblyKwTbGzx6ATH+i3p0yKwHeu/lHtN/OFQYk5L/jX7RhJkhQmjYHBa+EUD7PT0Lgb+BMIKMMOwJmtrE9xCGVcpR3geq0Pm3R3GTZMCt54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558647; c=relaxed/simple;
	bh=8sMVqkOCHrjU/kW5JgQX6yl4uatXGFFW/42JtvRvFHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkypwCEvErPjMd6QtWGkv3V+xMwMhRQlMEMp8jtsRy0NJ/aj8ETBALaUWIVAvKSS56XKZY1NxFMFh2UsqFbcPYBohNcnr0TM6j9AMY8QexMHCnGD+NE4vZCLtZ5j9JOXlRCKcSyCH/vGNcHbq5TZDHSpXLUA7D/lua7Mmj84Gt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=B4qYBeBK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h43gkT99mnmnYd7C4RyHXoBqdQoH1R5Pr2bTd8nqcUM=; b=B4qYBeBKvwpJKELzvkVn6bEheL
	hp2VglPAuxp2SFff6ObAhaCzXLMaO3n979gnHtLbfmwDKn18hlIe0ZDTCZuBzTR+YIMRQbaxr6YTo
	2r9rnkPQoBAFo9oHtJnXTcyYLTGzriG9y6zlSpjKMxkRYBOPR15MrbmSaCgvJZLzOje0KHrU5lXOt
	c4mgDwjxU+2Rjef4J8aHGu61hmslSuIyLutfWVC0L5bPZyNqll+Ln+7ssohsdgRLoBj7A4mwni80v
	MFOs3Wk1uDhZFQFDXl/dFzU9XP51QSqtMLVLP3YNT9rLgYq/XbRUTDwSY+WH14PS83c75+l4ra8gy
	S7DCNJww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47346)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLi9o-000000004pB-1jpv;
	Wed, 19 Nov 2025 13:23:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLi9l-000000003SW-2MUT;
	Wed, 19 Nov 2025 13:23:33 +0000
Date: Wed, 19 Nov 2025 13:23:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/9] phy: rename hwtstamp callback to
 hwtstamp_set
Message-ID: <aR3E1TSutl91o1CT@shell.armlinux.org.uk>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
 <20251119124725.3935509-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119124725.3935509-2-vadim.fedorenko@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 19, 2025 at 12:47:17PM +0000, Vadim Fedorenko wrote:
> PHY devices has hwtstamp callback which actually performs set operation.
> Rename it to better reflect the action.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

