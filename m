Return-Path: <netdev+bounces-149065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AE89E3F5D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061F616197D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6C520B20E;
	Wed,  4 Dec 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XAg1MzUJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D41B4F02;
	Wed,  4 Dec 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328577; cv=none; b=LvTwHwmE2kucYfXRjd2tme06xWPUKaKURtj/gflDG3lg8sm9mue4YChOaVHet0ViK5F2XhY+i0KDZl5scXRYAXhYR+DWqWH5aMrK/Ald0zrPOHrrPov745lVs8sgpk3lZcgQATcE5aINbyeVKL90nYmJl2fTZteSdDT/b69lpY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328577; c=relaxed/simple;
	bh=SBu2YvTlrqHfC+dLORIFQy/m9/Qdh0LNMErAy8jazQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+AE/qDfdSPOvhLz/ykPqrGjvqA2fb7kFWt5XjzgDm8y7gh3XfaJK5soIB9bCo1P9PKF1ATXTrKatadow7Qhn5loO9eUnDEXb/yK91Z+ezAIjaNqBe6v8ZuEAoiqvZwTWDhi2nFovmXwOnl6hdGN+IsalcZohhZbd4UPE0AXle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XAg1MzUJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eUU9XaGJ8oP3HO88yZcl8mt8Hs0gYAb75dOSKaDRQS8=; b=XAg1MzUJJ8ogbZ1s5NCpWiADae
	Uxz4gMJxK7gRqwfOJYpgxT1/wPt9ueTBcWxan2LNiL8z3LNDsssfURWiP9VgCGXYCsbWMU5hrkeUg
	/37Ft8aQNX2VTcwo4nz6v8sVDQdJhMSghJMPIr4CoKYpwcSy8/C88WW7CZ4iCgLlIKTSargQlsmLr
	XxlE8g53UuQeQn2ciQyb0s1TZWAOhyvEgqI0Uaxk66w5X5fIGHVwkl9r4WdQBYgjib3j4cqUwaTro
	JN0PUY+ZEYaU4HeoAILkyslqFtYEiQA0JXEQcLb78uxMo78M2JVs/CB0aI5Y6DzKJHNTfnxTD63g1
	9OVm79Iw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60494)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tIrwM-0003bd-0f;
	Wed, 04 Dec 2024 16:09:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tIrwK-0005gJ-09;
	Wed, 04 Dec 2024 16:09:24 +0000
Date: Wed, 4 Dec 2024 16:09:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Divya.Koppera@microchip.com, Arun.Ramadoss@microchip.com,
	UNGLinuxDriver@microchip.com, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, richardcochran@gmail.com,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
Message-ID: <Z1B-s8-p1QC9SKGr@shell.armlinux.org.uk>
References: <20241203085248.14575-1-divya.koppera@microchip.com>
 <20241203085248.14575-4-divya.koppera@microchip.com>
 <67b0c8ac-5079-478c-9495-d255f063a828@lunn.ch>
 <CO1PR11MB47710AF4F801CB2EF586D453E2372@CO1PR11MB4771.namprd11.prod.outlook.com>
 <ee883c7a-f8af-4de6-b7d3-90e883af7dec@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee883c7a-f8af-4de6-b7d3-90e883af7dec@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 04, 2024 at 05:02:46PM +0100, Andrew Lunn wrote:
> > > How many different PTP implementations does Microchip have?
> > > 
> > > I see mscc_ptp.c, lan743x_ptp.c, lan966x_ptp.c and sparx5_ptp.c. Plus this
> > > one.
> > > 
> > 
> > These are MAC specific PTP. The library that we implemented is for PHYs.
> 
> And the difference is? Marvell has one PTP implementation they use in
> the PHYs and MACs in Ethernet switches. The basic core is the same,
> with different wrappers around it.

... and I have code that implements a library for Marvell PTP, which is
dependent on the timestamping stuff getting sorted. I tested it
recently, and at least the user API wasn't working as intended in
mainline kernels.

When we actually get to a point where we can choose between the MAC and
the PHY timestamper, I'll go back to working on that library. Sadly,
that's not yet.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

