Return-Path: <netdev+bounces-213035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2309B22E3C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF6518997A5
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03AD2FD1BF;
	Tue, 12 Aug 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ealar7uc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44012FD1A1;
	Tue, 12 Aug 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017136; cv=none; b=Yf2yVHwbBaWb3XzBWdsIy9puxFd83GQSjrf3JBWhIiZeWM5Gl3bITDon7ahY0mbjWVpW6Kmpb6tOFZefeEnElhaNti/589BrHYjRxvcsPpcblmSvWJFtykR/nQE3ek+DFezF6FAUVIDKU+xNHFZS/owCJIKRLkTckdAu1n6C9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017136; c=relaxed/simple;
	bh=DcapWqQQWGs/sDE0K3IbyqDy3KJsndBWaNbR5/LCaOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiUaBmp2vkzwAmSC3ewwVlHdQcv2BeKwrhugccWJAw/x9FkbC4szOQzDEYTAb6qyhUiHtZUIJyqykBL2/WouUSZxRJmu7OffM98JjNeqVuDN+T6p6i97+yG6nBdzA0moIuox1zW2UCzQLZa/6T+qYW4Cw1uEQja3xmlcP5P5k/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ealar7uc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2ZPzfwoZS8pYtzvXpyrQDwV7ZNwRJAl8HtIP0BEN7+k=; b=Ealar7ucIfPLmV9VPIuNSpgya5
	iTYYwhrV9Cm6KhVmnpTGK+WMjtzJU8U0kOfXjIyKHnqNhHOLkZ0IEr8YfLXPqmS2JR13bJWFurJlm
	PUvGaKFfYVuQxiuEq2upb9HmlDnIQqL7THtayLYrCeNfv7FYdRItdvK123Shf1PiEzNrS9XyFb3kO
	WB2+TL7YRrNoOrN+MN44K2M0JvXbRFLF0hmgrHv00BkLafLRA24q+hwxjC3NYHI1fMeLzW8Jjk4R1
	mueBY39tVuAPKS20vIiADPrXThph8+owznkqGfmMibjYkEk3XS6hLUXmcOY9mzjzRIjFTqwQsrfEW
	QvrnM/5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39618)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uls7u-0005HP-1O;
	Tue, 12 Aug 2025 17:45:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uls7r-0004ri-1z;
	Tue, 12 Aug 2025 17:45:27 +0100
Date: Tue, 12 Aug 2025 17:45:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-driver-reviewers@vger.kernel.org, netdev@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Daniel Golle <daniel@makrotopia.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [ANN] netdev call - Aug 12th
Message-ID: <aJtvp27gAVz-QSuq@shell.armlinux.org.uk>
References: <20250812075510.3eacb700@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812075510.3eacb700@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Aug 12, 2025 at 07:55:10AM -0700, Jakub Kicinski wrote:
> Hi!
> 
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> 
> Sorry for the late announcement, I got out of the habit of sending
> these. Luckily Daniel pinged.

Only just seen this. Apparently, this is 4:30pm UK time, which was over
an hour ago.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

