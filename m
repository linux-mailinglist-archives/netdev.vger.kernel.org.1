Return-Path: <netdev+bounces-103115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B534C906577
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C797C1C2025F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323682482;
	Thu, 13 Jun 2024 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DP2mWG9W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21457CB9;
	Thu, 13 Jun 2024 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264686; cv=none; b=eNJILOhbcO2t0W2X9ql07OIWIwEU1OfdRwbBSLEeQpBopgE0dfaam6D5upsU8YZXEqj5OgvYLIvjzkursca6MbOybIvSV8qbdH7OzUliPrzTHp1US/DqNsy9nx27hpNDc52IDdY37QCpqpKb7vOxl2IMpCgp9oZZ/FtrcknEoWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264686; c=relaxed/simple;
	bh=mel7bwaTI0YQ/pctqBNK1nhGmHDx+xhaXi+DHFUFFF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7+jpXinEHh/msiBK/ByHLOjFU5OZ83taZOEvf3h3Uio9oihU+5D5FfOmFW08iu7hkFIjABGqDpIg0ditLA+ScWg+YNZJ4deeVdM/uVmcgUVnrGk63zRyh1E9oaRf6QFVjqbBVD2WPeM53H9S9oeGawGQLDOykIjeVjGS4DeF5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DP2mWG9W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GT7AIZgIWhfB3f40JHe4sssXTLZj1T2xiSRKtERm9SM=; b=DP2mWG9WDbCmVmWFiyhxfuq1rN
	RX48xVvY9ADB7V6llW6XUtwt6ZJQ2fBFn8NfKJikaJWyxeR3FKDwTUkcw6AJg43zeXdURFyOPq3vm
	SNhfj6/hIpdjHvlZYWo2cKZupc4sQwUy65pCNxrUnKO12ir0516VHTJNvw8HH49IpAWd1K3Eq3PeU
	ASONUnDRob6PoxBlflH77PJuzZt2fSh2ewt6BmzAK9NtJf8xeXTMEwDxtPzAEvhCfPacrh8lFivQa
	36KG1Rz2ZUlNF665ws1oqPKFtKubiz1IFDMPD75D2B5FE5WX8oJ17WgwYNMLW5jV8JE04dBG9qala
	tGd3jAXw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42754)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sHf8L-0005hz-1s;
	Thu, 13 Jun 2024 08:44:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sHf8K-00013v-Ia; Thu, 13 Jun 2024 08:44:32 +0100
Date: Thu, 13 Jun 2024 08:44:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
	andrew@lunn.ch, sbauer@blackbox.su, hmehrtens@maxlinear.com,
	lxu@maxlinear.com, hkallweit1@gmail.com, edumazet@google.com,
	pabeni@redhat.com, wojciech.drewek@intel.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V4 1/3] net: lan743x: disable WOL upon resume to
 restore full data path operation
Message-ID: <ZmqjYEs0G9pGQTog@shell.armlinux.org.uk>
References: <20240612172539.28565-1-Raju.Lakkaraju@microchip.com>
 <20240612172539.28565-2-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612172539.28565-2-Raju.Lakkaraju@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 12, 2024 at 10:55:37PM +0530, Raju Lakkaraju wrote:
> @@ -3728,6 +3729,30 @@ static int lan743x_pm_resume(struct device *dev)
>  		return ret;
>  	}
>  
> +	ret = lan743x_csr_read(adapter, MAC_WK_SRC);
> +	netif_info(adapter, drv, adapter->netdev,
> +		   "Wakeup source : 0x%08X\n", ret);

Does this need to be printed at info level, or is it a debug message?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

