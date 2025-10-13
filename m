Return-Path: <netdev+bounces-228717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE9ABD3031
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610A53C5506
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 12:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5491925BEE5;
	Mon, 13 Oct 2025 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jfru59pM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB09B267714
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358974; cv=none; b=r7DG/higs5guFztR72xmwhG8EaoLLnBt3md0Hkf6IEJGuqERgSp2CXvpA0GscAR0mK8fRO5W/AewL+rzwjqdNC91cg1jkv6lsz4cvNXx5K+Rs5rGmGgrCO+j1SgDu7pguNkYFBqJLytOWjmeRVY7tSLbKJ8csyT6BWeD6LZdRTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358974; c=relaxed/simple;
	bh=tvpkuIhyHlF2GYoB4RvQsCMgyMuCSfSXzKmG4p2lsow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkZ+h0F12YGZoWqlHNwGCDVC1bODTrqdfHFckNZsjHxDIz653Pbd+L+kqie6M5X6RJOy8RbRM+uU2IBkT56zz37jA2jIWB0GWv04XcR1ucQZo1fDJALugzqRET4BiK8fU1uecHtimsD1rnDfTZZA0LuDGCBlcWsaKrfnC1oxTfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jfru59pM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=711VVvRV946xKTh/O+1tuL2juF3oeljtpIu2zz5ku2o=; b=jfru59pMvD1BawADGHW5vgPNM3
	3uPhzIyek/aNBsm7Q054zscRygOXRhYbzfGnascHIFoV/dPB1BsRT56Y8oL7eq0oVmlLSZ5q8yzGL
	iPJrbuugh/qmKiMQhTm/LOwvtLWLpB3JoxPU1rwg82ntq3Pt/G8IVNMC6Mx/vCMQTbVI16rkqgGcf
	CmmguMjysp191i3ygJDm63aTiM18VKNveVWxAMmsy6eDKUWlJE3yHeiSDpfb0E4QDB8gPt18sDd72
	hnZAfIJOXJS462egKZPuvaHRgmcPQvYxipvpPSENPCyA8TfZrwFAoRtu/LudojfJysaexUSf+YHY2
	bUj2NBWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33536)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v8HmO-000000001yw-0CJa;
	Mon, 13 Oct 2025 13:35:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v8HmI-000000000KV-3Kmo;
	Mon, 13 Oct 2025 13:35:50 +0100
Date: Mon, 13 Oct 2025 13:35:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net,PATCH] net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not
 present
Message-ID: <aOzyJuegXDTNCire@shell.armlinux.org.uk>
References: <20251011110309.12664-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011110309.12664-1-marek.vasut@mailbox.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Oct 11, 2025 at 01:02:49PM +0200, Marek Vasut wrote:
> The driver is currently checking for PHYCR2 register presence in
> rtl8211f_config_init(), but it does so after accessing PHYCR2 to
> disable EEE. This was introduced in commit bfc17c165835 ("net:
> phy: realtek: disable PHY-mode EEE"). Move the PHYCR2 presence
> test before the EEE disablement and simplify the code.
> 
> Fixes: bfc17c165835 ("net: phy: realtek: disable PHY-mode EEE")
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>

This looks obvious.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
> Cc: Michael Klein <michael@fossekall.de>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Russell King <linux@armlinux.org.uk>

Please drop this line.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

