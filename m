Return-Path: <netdev+bounces-210758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04250B14AEF
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E915546E71
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08EA286D78;
	Tue, 29 Jul 2025 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UTfonjKq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58F4233158
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780469; cv=none; b=fFYfFKzwdpoeri3fCt3B1nHwwkH656LlEbyyA+Y+OoriP6UHF0CV1ez2Y9CY44QHspAmCw6AMAtutDqot1g+an7T3gQWOSWPwkm7K+wFtifxqSsderSgB4rNIrxfZlqBicF/rwdCs+T4sgb1YKiUkYXBrEhVq1MmoYA24YmI2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780469; c=relaxed/simple;
	bh=3T92tbraDZaUkfA6qaF8bfvFsO936C68OYHLSFedWNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLq8NQ9ps6jkMMsp3okvJKWULgosJAP6mGb5J0Hx3l95psOFwtmbG3BNIaTlA8GDPXoe7bmmAsi6GcFJ5yfB0WmtdNUOgvyqalfGvVTxWPQDPoiNSJWw+CjkGSCtOxGbH2zyovuvj2LMS+s+AF3gE4myFE0oWKS5C3TJ5/GVk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UTfonjKq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BDb4J5a+AiGLZI7v9e7yzeDvRtwwpyCg2pNHaK7xfOI=; b=UTfonjKqPZWb97am0NhvQMxJ3G
	L8uQyv5HsuohTsD4JC7FSV6pnzjYCZxOXGTwMtSrbfBIFhFBzk0WmnwQQ8m5+e08P4SHXxhv1FCnB
	GDkAiF/xcXnBDGTFz/YVI7AAseRF/aS3/HMEHLR6taygI4xAP4BZj+j9i1zf5oOiyK2LwzJMqW9hJ
	a9zxncFZXGABYCayhilVg5zHJLTT4URhTPKmYTzc6JZiEZoyDZYNa5898ahZAmQWwhpJ1e3Dpp0sS
	zG2HtxqDVguqdhBdh4/psmtJpbIbnI9uL6tK/i84ylBNNhB079EQeCTFuwr1paITdi8FVLF3MUmsf
	NtJS3/mg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48204)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uggPe-0001ds-0d;
	Tue, 29 Jul 2025 10:14:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uggPb-0007HU-03;
	Tue, 29 Jul 2025 10:14:19 +0100
Date: Tue, 29 Jul 2025 10:14:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Linux-stm32] [PATCH RFC net-next 6/7] net: stmmac: add helpers
 to indicate WoL enable status
Message-ID: <aIiQ6qnj1M2qTudc@shell.armlinux.org.uk>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ33-006KDR-Nj@rmk-PC.armlinux.org.uk>
 <eaef1b1b-5366-430c-97dd-cf3b40399ac7@lunn.ch>
 <aIe5SqLITb2cfFQw@shell.armlinux.org.uk>
 <77229e46-6466-4cd4-9b3b-d76aadbe167c@foss.st.com>
 <aIiOWh7tBjlsdZgs@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIiOWh7tBjlsdZgs@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 29, 2025 at 10:03:22AM +0100, Russell King (Oracle) wrote:
> Without Thierry's .dts patch, as I predicted, enabling WoL at the
> PHY results in Bad Stuff happening - the code in the realtek driver
> for WoL is quite simply broken and wrong.
> 
> Switching the pin from INTB mode to PMEB mode results in:
> - No link change interrupts once WoL is enabled
> - The interrupt output being stuck at active level, causing an
>   interrupt storm and the interrupt is eventually disabled.
>   The PHY can be configured to pulse the PMEB or hold at an active
>   level until the WoL is cleared - and by default it's the latter.
> 
> So, switching the interrupt pin to PMEB mode is simply wrong and
> breaks phylib. I guess the original WoL support was only tested on
> a system which didn't use the PHY interrupt, only using the interrupt
> pin for wake-up purposes.

I will also state that the only way the WoL support for Realtek that
was merged can possibly work is if there is some other agent in the
system which configures the PHY such that PMEB only pulses on WoL
packet reception. Unless this is the case, the PMEB pin will be
pulled active on the first matching WoL packet, and remain there.
That means WoL will work for the first attempt and not after.

This makes the WoL support that was merged completely broken for the
general case where there isn't some other agent configuring the PHY
e.g. at boot time.

I am in two minds whether it should be reverted until it can be
correctly implemented. It's a relatively recent addition to the
kernel - the patch is dated 29th April 2025. See
https://patch.msgid.link/20250429-realtek_wol-v2-1-8f84def1ef2c@kuka.com

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

