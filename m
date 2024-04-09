Return-Path: <netdev+bounces-85993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F31489D3BD
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 10:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A8EB20B67
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 08:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842E97D40E;
	Tue,  9 Apr 2024 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ljqvtNNG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A979955
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649864; cv=none; b=BBLHDPl0qla1wZAmP2CH6k2PjnXoG4rjnIyQtgY8FpN1i7McmlHb1SZyptkCQ9xpZcm4C22k4yhpR+Y6ZY2f5DccMafEFjxdOH1/UBIZ6cDnPAZQ9cRXOavGV3GxjB9vtbletAPMYmhhAaDvR7fEtTte36fUPHRxgbWNT0F5nsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649864; c=relaxed/simple;
	bh=dPNjXSxx+IC/vdRfz2vvre/Y9jJcxa2jArSRSB+2cG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8g9gA5ND0l7IWssGA62NQ4Cvx8lw8CrNK4Rf5DBy0mudDXPPDT1NfcBL8bD3MEDuAyhvQGKR9Qad3hcDoIZ8WHAYT3BNx7UhyEyoZiWB1DSshCqyvZQXSxCm7eOljHi0BviT2TX9hAevsyZ5+Z4dsy+dPc+18E+hadiUNF5Aik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ljqvtNNG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wi0woxGcbdQfbFrTCMc/ZSMz8i6dIciPlcb7kODLNOg=; b=ljqvtNNGKZsoqym7AEu4+1sve3
	cYIZSpPyXbBKFz4ZG77YmvuEJz7ZvN/rGSkwYh4tUXFLgUNJRddc3RszdO62n1s8FWDYo3C9rXyRy
	QG7xoRs4GslF7REquu6aIHlYhv7jpCc3tr5PXywVvgdh3Xi7W8k48/BWEWJjxCG2UdfqrpLh7Ccii
	E1wCvICtBFJ2E4UqbxaUdArM0T9DKRL847w5CjXdTuNPPgzia1ddG1DFnZPgdq/yRvwrofiG/QkZc
	Gzi+Akipuzm/GmxfRGmCvIMDnrmTWZRjqGwSCTN6KY3QLRaJR5o6d4POp7bzBPdMggMZ4RpP2Uirz
	BgzMu6ng==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57886)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ru6Se-00063h-1j;
	Tue, 09 Apr 2024 09:04:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ru6Sd-0004un-CB; Tue, 09 Apr 2024 09:04:07 +0100
Date: Tue, 9 Apr 2024 09:04:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Message-ID: <ZhT2d0bivo/yRfDs@shell.armlinux.org.uk>
References: <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>
 <202404091147.pdi8izJ3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404091147.pdi8izJ3-lkp@intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 09, 2024 at 11:15:01AM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
> >> net/dsa/port.c:1981:6: warning: unused variable 'port' [-Wunused-variable]
>            int port = dp->index;
>                ^
>    1 warning generated.

Sigh... I don't get this warning when I build it. I guess that's because
unused variable warnings are normally turned off. I'll respin dropping
this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

