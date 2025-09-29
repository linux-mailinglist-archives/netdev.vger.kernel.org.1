Return-Path: <netdev+bounces-227161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E0FBA9551
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 15:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E973A41BC
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B782FBDFE;
	Mon, 29 Sep 2025 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MFhXsYdG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940126ACC
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152473; cv=none; b=XrBtowfZbI6tveUIsjIHGNeEP9IwqmQcagZ9j6hXbnMHMf0L8sZ+zRJcidPmPLNvucxTPnF4NN6HGG6Yix0BOrV/RZB6kj/ynm4MMbGEkCrrTHQkjn9O+b2E+2yD0W3taq8ifgakhM3BLh8zLd7uPikiveJV5ZtD15KhuEEOeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152473; c=relaxed/simple;
	bh=P+dXr1UriXWG2XRgfoUBoEYYrQuAdrRzitRE6G6yb8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqvBv+HmdmY35Qd9G/4+5lNONhbv6Oy0yB9vb+twvYu0/GBOtX0twsXQBreDP2fbQ+G0PtFzvluNs1sz5NL46Khpw/k9vIqf8aXlw5tEsWXR1V/fS6kFBfyYPsvwfjcWLRzHX/03w/q327VIqdhoIjM4ebkN558/bS5lhtQElLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MFhXsYdG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N2jpK4glGSnYrwdkVuavgjiQHFdPnl3XP+zSF0kAb04=; b=MFhXsYdGva+Y7yVFx2eIqqfTiz
	IKuDLOP9bR5EU18APtEXUA9UTVEoYRfOBK4usD4xaFVFlLyJmgllpExoF91AR7A22MrpQJHjC+BDD
	JoaWkjQUqVQYkOM2PjthzUIZqQwHXntCELMIUrMjlzbmg6mrfQQ71wBo2YhffRc6B1ZldSrSJQ0CB
	dK+wr3/nf2BWa/pfAP4qSjuL8PUEYyQ7g0hVsndCtqGl0Qixxlswu7/wxFtHK5DLchYfJWqHZ25b+
	aay09EonwTYkCQT4bFwoC6kUeNFkm/LdQ3GaC09Kbdd82+myb+/UCthE4J0VijgykPrJJojcMKy+/
	fYjbe3HA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57542)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v3Duo-000000006eI-3QaY;
	Mon, 29 Sep 2025 14:27:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v3Dum-000000003a0-09SB;
	Mon, 29 Sep 2025 14:27:40 +0100
Date: Mon, 29 Sep 2025 14:27:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH RFC] increase i2c_mii_poll timeout for very slow SFP
 modules
Message-ID: <aNqJS6sUp-lk2-xC@shell.armlinux.org.uk>
References: <d73c74c0-5832-4358-a18e-1f555e928e79@kabelmail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d73c74c0-5832-4358-a18e-1f555e928e79@kabelmail.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 29, 2025 at 01:44:24PM +0200, Janpieter Sollie wrote:
> originally developed by Marek,
> commit 09bbedac72d5a9267088c15d1a71c8c3a8fb47e7
> 
> while most SFP cages do function properly in i2c_rollball_mii_poll(),
> SFP+ modules from no-name vendors  seem to behave slowly.
> This gets even worse on embedded devices,
> where power constraints are in place.
> i2c_rollball_mii_poll() could timeout here.
> 
> dynamically increase waiting time, so the phy gets more time to finish the job.
> It it beyond my knowledge how much the target gets interrupted by a poll() call.
> 
> A better method might be to add a kconfig option "allow very slow SFP MDIO",
> so strict timeout errors can be detected where useful,
> and be avoided when the kernel is built to work on embedded devices.
> 
> Janpieter Sollie
> 
> --- a/drivers/net/mdio/mdio-i2c.c       2025-09-19 16:35:52.000000000 +0200
> +++ b/drivers/net/mdio/mdio-i2c.c       2025-09-27 14:11:59.406323627 +0200
> @@ -248,12 +248,15 @@ static int i2c_rollball_mii_poll(struct mii_bus *bus, int bus_addr, u8 *buf,
>         msgs[1].len = len;
>         msgs[1].buf = res;
> 
> -       /* By experiment it takes up to 70 ms to access a register for these
> -        * SFPs. Sleep 20ms between iterations and try 10 times.
> +       /* By experiment it takes  up to 70 ms
> +        * to access a register for normal SFPs.
> +        * Sleep at least 20ms between iterations and try 10 times.
> +        * Slower modules on embedded devices may need more.

Your persistent attempts to differentiate between the platforms that
this code was developed on (allegedly, according to you, "high
performance") and your "embedded devices" is becoming very very
wearing.

Please come back when you've changed your attitude.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

