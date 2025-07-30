Return-Path: <netdev+bounces-211025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC1BB163E2
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3F5565A11
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88E2652B4;
	Wed, 30 Jul 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qZsyztBm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEF3C2C9
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890602; cv=none; b=GEY591g7bVBb/Mw5Z34KcxGqgozeiT2xKzaJs2s1oNwXcIG6+tSoA9FWCEOYwFwbnV+HvyaS/LYU3NnoVAvjOmFpXzxquGreVWPmRQveh4sZJ91pk86oPZYMItrw50NAERqsJ7DcLxIqMCkNWQMDZWfXLt7mjVAVYChLIhyMg9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890602; c=relaxed/simple;
	bh=e9kYErHjFhzUf3XeESIKPKrgFGNt9wqV9SjPW13Nerk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSvcDl8ES1chV3kqV7yz0EJLxNsEQDteDiUQ5rO11E/9yd/13yzCaQLnJyjyA4TnwxUqFi+USTWIwKOunUSuB21N0nBbjyyo32srhPWa0VJtNoLeuNBIrRyCfr4X/9KMeqLRptV49lyUKmDEWK4+3o2nidNkEBG5YjQPTH/HumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qZsyztBm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DX98Vz/xWZD2X73NvuuHorJ74GY9eVS0xZ3PXHU78QA=; b=qZsyztBmR11SRsiHq571va+/qO
	MBY1nDHyc6j3TAhBhiWkiwLKFt1oVNHbrNOJFCqqtF4548+aaPOWGNND3aTzY++TkiPfEvTkIXWox
	T2Xw9Cj/CrfAArR7lAh/6ZbVwVahw7PFshU/nmwaIJBwx2bcPzLuToQ9czugwLAw4Y4aJBqNcyIYI
	yOEZiPdToiRq3F6br4lzzv8Q2a4wv4rp/L33cKzmIlNo/YOfQEM8emoEkimrrdDNZf4Cs9DgJYgOh
	i60ucYJ0WiEUnf5tvVcYxJvGj94rhd2F/r/BUlNru0GzjbFoaHnHfEZzjqOu18Bw0L8HAW0Fp1UeS
	FoaGHh9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40004)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uh93t-0003hu-0n;
	Wed, 30 Jul 2025 16:49:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uh93p-00006z-1T;
	Wed, 30 Jul 2025 16:49:45 +0100
Date: Wed, 30 Jul 2025 16:49:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Braunwarth <daniel.braunwarth@kuka.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC ???net???] net: phy: realtek: fix wake-on-lan support
Message-ID: <aIo_GW9zvPzLd0zs@shell.armlinux.org.uk>
References: <E1uh2Hm-006lvG-PK@rmk-PC.armlinux.org.uk>
 <a14075fe-a0fc-4c59-b4d3-1060f6fd2676@lunn.ch>
 <aIoqvaRk3lL1Zeig@shell.armlinux.org.uk>
 <2842a6b1-ba65-4f7c-8699-aa2fd3de85b0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2842a6b1-ba65-4f7c-8699-aa2fd3de85b0@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 30, 2025 at 04:35:45PM +0200, Andrew Lunn wrote:
> > Not all interrupts are capable of waking the system up, and there is
> > no way for a PHY to know whether it's connected to an interrupt that
> > has that ability.
> 
> I was wondering about that. And maybe that enable_irq_wake() returns
> -EOPNOTSUPP if it cannot actually wake the system? But there is no
> documentation about that.

,,, and that means we can't use the wakeirq helpers.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

