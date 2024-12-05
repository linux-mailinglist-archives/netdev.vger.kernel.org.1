Return-Path: <netdev+bounces-149372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208489E54E4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009391656A1
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094FE21773E;
	Thu,  5 Dec 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Xc7icjyX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308791D63C5;
	Thu,  5 Dec 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400172; cv=none; b=EZVne2vwUVEQ182mDSf7eKtlOKeVCAG76gNjsKm1EJBBb+ki90Xa2F/AixV16A5BKpB3RoqqXkQIxL3z/XoxovfarchtPgOsaci0Kibe5Cgm2bwZGvMt6gheCZU85/EHiGSUcNZkJ6tAuODCLSrVEjV2baA3zKTuhzyh8MfdeGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400172; c=relaxed/simple;
	bh=QviPwX4i1+oGiQ0z7Lj2wfw4JcQbZSTXITIQDql5joU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFc08eDWyXYHHiX0eMPTuLIIua+hbbHzmj4aZZGfi9AOPdhnrJCXuxskA+yz1dGj/jm8Pp594rnZoj3IDSX4hZnkvIQOwWtp5A4LV3rwGZPvNUCkCByPRG8c4GIeZlZO3rLf/QSxCCPO9RiZxu7rKeQo/XQ1tjijvMLUqfikPdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Xc7icjyX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cH/uRS4ajyoldPGNzhQX9EFCmhy17ZLZf2YfVGbhuVM=; b=Xc7icjyXgBpyRNegnkQSYTJV+s
	Sg53JA/JrfkUjRdAV62EagjT0ICJrfTc+yuX3sEnXwKL/TW/8SNRfquwuWRZG0KMY9iyi+GMPcEcM
	Emt8AgDuMEc3fFlO0BM9VibntPde4YO6u8zKSipI92V/Gu0m35El094if24t0V7u8GMDkjokFTjTH
	6pRcCOOQ1pgqbk8kYJ+wmL4Zt73Zlnz16h1DAUD1LaO5LWFJXksUbfTQxE83JTr4IFwOtfm8WwN6w
	E1hr2rouhTE4HttpwDHMmOCZ0A3ceeH8Eiy+pTcTSK5vmilvf33oG0wCqrfTRyXCq43T21y1wm5iD
	6aaNSR1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45000)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJAYw-0004jA-2r;
	Thu, 05 Dec 2024 12:02:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJAYl-0006Wi-22;
	Thu, 05 Dec 2024 12:02:19 +0000
Date: Thu, 5 Dec 2024 12:02:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 3/7] phy: replace bitwise flag definitions
 with BIT() macro
Message-ID: <Z1GWSwtWrUKPZBU7@shell.armlinux.org.uk>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203075622.2452169-4-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 03, 2024 at 08:56:17AM +0100, Oleksij Rempel wrote:
> Convert the PHY flag definitions to use the BIT() macro instead of
> hexadecimal values. This improves readability and maintainability.

Maybe only readability. One can argue that changing them introduces the
possibility of conflicts when porting patches which adds maintenance
burden.

However, this change looks fine to me:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

