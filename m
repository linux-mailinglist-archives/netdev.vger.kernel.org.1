Return-Path: <netdev+bounces-238464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F71BC5922D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD8F735C1DA
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF98A35B123;
	Thu, 13 Nov 2025 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZCz4JxpK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10BD35A943
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054157; cv=none; b=YTMxfp8/qXHvbcfc4bPGjJPF6buGIwS96xzBxSAlm7G/q1pJ8H6fEStSZJhDo2cZ0F1g6bTwzFSZCJutg7TUCVWVumT18KBYJIYuFfLdPV3MdbJXRHkns4ego1b3GnybJG70rGU6/sLEjo5qj9dX4s4PNyyOnA+nOgRLsIEdNXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054157; c=relaxed/simple;
	bh=b9plA5LC79rty0Oxpsno9nzD8DTQmuZuJtNe5i77was=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpjEyC6wZgB2faaYvBe9Z1fukUCNQLTi4WUp99foRgyP3y8FU8f7ss3rndyTzYUAPdSbW5cZRrshIq+MCg5jdLfRDRCbseKUmdrPuKnKZXJ+JA2BnPuS2DalMqs3SpEYDKIlDHK7rTFqT7/jlo0mWt4oqiF1Tp7rsl0YjpPYvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZCz4JxpK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T25nbryeELQl1PUN7y3nFlmETger+xuU2bhWsagHc7o=; b=ZCz4JxpKB759k54yc2hxgu4G6y
	TfuWF5iBIfL0wBDnFlgB7xluaUL5OdFivvBhCS06vMixyRw2CY/pacclZ4c6PLSFUcLrwGzNp9vWH
	ZDdGsQOC3wjH2OO2J16E+nat3ffxeD7NmAWGwv6D4f+GmJvEGgn5EWWu+T5tS0WwdUQ3BakofkI3a
	Hip7C/xExjtdI4adjJR/0/8KdazIE9rwusHtUQBzlsfwMbmXQoRGxWtdRQRNuCXBB0OZofV048OF9
	YogQryjZESXtpbBxepbw9pWbQ55oojxW9w1rPW46EoGdFu7myMh2v0g1FEXxXYJuHKrSvqevkSdU0
	7OxxUFwQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44628)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJav9-000000005lR-413k;
	Thu, 13 Nov 2025 17:15:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJav6-0000000052X-2DSo;
	Thu, 13 Nov 2025 17:15:40 +0000
Date: Thu, 13 Nov 2025 17:15:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/9] phy: add hwtstamp_get callback to phy
 drivers
Message-ID: <aRYSPKmGennbjxwj@shell.armlinux.org.uk>
References: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
 <20251113113207.3928966-3-vadim.fedorenko@linux.dev>
 <aRXIuckumra-3Y0L@shell.armlinux.org.uk>
 <12c8b9e9-4375-4d52-b8f4-afccba49448c@linux.dev>
 <a4b391f4-7acd-4109-a144-b128b2cc09b2@lunn.ch>
 <b428f0f0-d194-4f93-affd-dae34d0c86f1@linux.dev>
 <aRYN-r7T9tz2eLip@shell.armlinux.org.uk>
 <69ec62f4-649b-4d88-8c06-6bf675160b0b@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ec62f4-649b-4d88-8c06-6bf675160b0b@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 13, 2025 at 05:05:18PM +0000, Vadim Fedorenko wrote:
> On 13/11/2025 16:57, Russell King (Oracle) wrote:
> > On Thu, Nov 13, 2025 at 04:48:00PM +0000, Vadim Fedorenko wrote:
> > > If the above is correct, then yes, there is no reason to implement
> > > SIOCGHWTSTAMP, and even more, SIOCSHWTSTAMP can be technically removed
> > > as a dead code.
> > 
> > I think you're missing the clarification in this sentence "... to
> > implement SIOCGHWTSTAMP in phy_mii_ioctl(), and even more,
> > SIOCSHWTSTAMP can be removed from this function as dead code.""
> 
> Ok, it's better to "there is no reason to have SIOCGHWTSTAMP chunk,
> provided in patch 2 of this series"
> 
> Or are you asking for the clarification of SIOCSHWTSTAMP removal?
> I don't plan to remove it, at least not in this series. I just wanted
> to mention that there will be no way to reach SIOCSHWTSTAMP case in
> phy_mii_ioctl() from user-space ABI. Does it make sense?

I'm not asking. I'm trying to work out what you're trying to say, and
suggesting a clarification to your last paragraph that would clarify
what I thought you mean. Now I'm even more confused about what you're
proposing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

