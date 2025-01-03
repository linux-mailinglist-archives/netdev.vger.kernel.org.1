Return-Path: <netdev+bounces-154934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE72EA00673
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AE71624E7
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9A1CD21C;
	Fri,  3 Jan 2025 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KcY/IIf6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11E1BD014
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895322; cv=none; b=gK9IyNk5n1u+PQWaz/d5NEzhGd7TdHkRicM7jPSWROVGLGFxEzEsEWdbyCxcZWQWGyO5+0Yp7qoGFN3+RxKKpTeBrmEpw8yuoPnagr2tiHjfDrZ++XjtO2NcvPfhh14zDf2ZwK3F81ZWaOaBtjbRvEk11fn4YTrAfYYZFcO85JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895322; c=relaxed/simple;
	bh=EubadRbocUH9VnJTgCdSDYbqda0BVP2Vlcvy3+nRuK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjUSoEcfCiwdshoudrUnjbj9ramobIFRRHRl3l8LL46CokTwb9KKkIb8rXoLaL6fXBqcY6M8/7YII7jet/Jf1GM9EwQbRAhEYnxFK2hmp5omYmuKE+cZF1PBOos2/OdC+8qATo4Ov4rGpQJaDP+UABgJaYnUW9p+dge31Y0doM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KcY/IIf6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wsyh+5boNyaBATGIrUPzvAmr0/G9SuJcgFITeVyp4dg=; b=KcY/IIf6eSj2Du/8485QS1wYql
	InvwZPboDvWbPctqlvTcNt3I59XuOhfs3oR1vycblsPUtLGHSRVF1hcV9YmOYl1Z5bZpOwX9ylvPv
	0rfC4BBc7iqt1/EijPIUDpgpAWxqpMYWvAdMuQ8jO9Qq4s0PDMc1Pzfc9bFcCBef2s6CxDoZr3r1x
	8fosqteYtRsC3CffwK3SnzOH0WhxY9JsfYGljIqeoZBeoQ5yb68U5Qp0/wVEpEKVb/wvXVM3xqf1F
	dnh5qUiJ3fNBdTQoQpyOBv8U4Ot1ClB9GPh1rlLF9fecWpyzqvpAo5VSGtcc/e2nn8C1OZk1yyO11
	5c6EWqpg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32782)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTdfN-0002sj-1F;
	Fri, 03 Jan 2025 09:08:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTdfK-0001At-1M;
	Fri, 03 Jan 2025 09:08:22 +0000
Date: Fri, 3 Jan 2025 09:08:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: mvpp2: tai: warn once if we fail to
 update our timestamp
Message-ID: <Z3epBvz_hgythDYH@shell.armlinux.org.uk>
References: <E1tM8cA-006t1i-KF@rmk-PC.armlinux.org.uk>
 <Z10UGg_osMZ6TZrc@hoboy.vegasvil.org>
 <Z3a-HOwAVyJGEg67@shell.armlinux.org.uk>
 <Z3ejTGIpl8nF1Ku8@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3ejTGIpl8nF1Ku8@hoboy.vegasvil.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 03, 2025 at 12:43:56AM -0800, Richard Cochran wrote:
> On Thu, Jan 02, 2025 at 04:26:04PM +0000, Russell King (Oracle) wrote:
> 
> > If we fail to read the clock, that will be because the hardware didn't
> > respond to our request to read it, which means the hardware broke in
> > some way. We could make mvpp22_tai_tstamp() fail and not provide
> > timestamps until we have successfully read the HW clock, but we would
> > still want to print a warning to explain why HW timestamps vanish.
> 
> Sure, keep the warning, but also block time stamp delivery.
> 
> > This is to catch a spurious failure that may only affects an occasoinal
> > attempt to read the HW PTP time. Currently, we would never know,
> > because the kernel is currently completely silent if that were to ever
> > happen.
> 
> Is the failure spurious, or is the hardware broken and won't recover?

I have absolutely no idea. I've never seen it happen.

That's why I think going further than I have (and as you are suggesting)
is totally overkill.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

