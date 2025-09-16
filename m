Return-Path: <netdev+bounces-223718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950D2B5A3C7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA932A7929
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497D8283FC2;
	Tue, 16 Sep 2025 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qpqu09QQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE092877C1
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057753; cv=none; b=WpVkAix8jTmgq76H3ATiAgmg1Hqu1OijAl+FbO9Uw/Iu523zTYv+K09ebLIyChEbcLTnY/kWpLmpvhYHT8TAer6jGqmLeUh7xt3+9LwSzv4gBz8H1Yy+BL5NYIszeVWrLvmpEP9+/TKAlo16wr59l7/6cULMZbXHrPHZ40LIFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057753; c=relaxed/simple;
	bh=+jvcMiLnfD4i6zJzLDIXCcPmQHBn40LTU35VsRktKt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/JV0/adxhf5UYXsnfL0MwmRYeg/dNXzkQbr9fFrudtugPsjBG22PiACJuS9Mq+VeiW2EUvjhZ72YK9016bfkT2ZuZscY81wGjiRbP/MMQO5yi6iM1dlTaVqpSQ7OQnxCLUG6+Ol84e1x2XdamYcndJU2J/8SGyboy2l+ht/eXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Qpqu09QQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9gO1bEneKYqrxemk74wXPwbNJQphdoGowwHZ4MHMiJ4=; b=Qpqu09QQSVL90Olq3BkI4+U2r2
	eHsbeCXQ5mmx376B8SndfocbWj6MFEfg5vh1JRr7tyhYsCH2ecmq1E48cKy6bKQ2UWsYnsPZ8URHO
	KyAmjYzNoXPRFjHGo9VIsohdwCb+q4rVsFTh3O9XSMmbt0n5HejtthgnuNLuApQI0ob5aPrny08P4
	53Px0Ng8v9/jdipMDobgT4Mi4XJGayHJzi0iKzMoSq5nl3wsSxK1AylRSTyobyWLPRkyz96NRMDJu
	bZGzeW+hkJPdFUC3q4IOm2YLN5K7S5zT8jvR7bTuM3OH+s2GuevRso7eHpBILOtSHuXdOy0xFEmv8
	7BrVMnng==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53652)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyd7y-000000006Hz-0zjX;
	Tue, 16 Sep 2025 22:22:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyd7u-000000007zN-10oB;
	Tue, 16 Sep 2025 22:22:14 +0100
Date: Tue, 16 Sep 2025 22:22:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Dumazet <edumazet@google.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org,
	Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH net-next 2/2] ptp: rework ptp_clock_unregister() to
 disable events
Message-ID: <aMnVBgMG3Nnjgr8E@shell.armlinux.org.uk>
References: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
 <E1uyAP7-00000005lGq-3FqI@rmk-PC.armlinux.org.uk>
 <9d197d92-3990-4e48-aa35-87a51eccb87a@linux.dev>
 <aMmGFQx5lWdXQq_j@shell.armlinux.org.uk>
 <b6e0d1e5-bd50-464a-9eae-05ecd11de4ee@linux.dev>
 <aMm-k47VdNlGP84m@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMm-k47VdNlGP84m@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 16, 2025 at 08:46:28PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 16, 2025 at 05:20:19PM +0100, Vadim Fedorenko wrote:
> > On 16/09/2025 16:45, Russell King (Oracle) wrote:
> > > Having used NTP with a PPS sourced from a GPS, I'd personally want
> > > the PPS to stop if the GPS is no longer synchronised, so NTP knows
> > > that a fault has occurred, rather than PPS continuing but being
> > > undiscplined and thus of unknown accuracy.
> > > 
> > > I'd suggest that whether PPS continues to be generated should be a
> > > matter of user policy. I would suggest that policy should include
> > > whether or not userspace is discplining the clock - in other words,
> > > whether the /dev/ptp* device is open or not.
> > 
> > The deduction based on the amount of references to ptp device is not
> > quite correct. Another option is to introduce another flag and use it
> > as a signal to remove the function in case of error/shutdown/etc.
> > > Consider the case where the userspace daemons get OOM-killed and
> > > that isn't realised. The PPS signal continues to be generated but
> > > is now unsynchronised and drifts. Yet PPS users continue to
> > > believe it's accurate.
> > 
> > And again, there is another use-case which actually needs thisunsynchronised
> > signal
> 
> For my use case (Marvell platforms) we only support EXTTS there, so I'm
> happy to restrict this behaviour to EXTTS. If drivers need e.g. timers
> or workqueues to support the other pin functions, then this will need
> to be revisited so they can safely tear down their software resources.

I think I've missed another source of trouble here: PPS input, enabled
via PTP_CLK_REQ_PPS, which seems to be a purely software construct
where the hardware triggers e.g. an interrupt to forward a PPS event.

As this is not a pin, this doesn't get disabled. This is subject to
all the same race conditions that EXTTS is subject to, so I think
ptp_unregister_clock() needs to deal with this too.

New patches on their way shortly...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

