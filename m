Return-Path: <netdev+bounces-163489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D3BA2A64B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A01F1674AE
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39F0225A35;
	Thu,  6 Feb 2025 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BIHfj6YI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED61F60A
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738838869; cv=none; b=Ko7F5BvoPYa2qIxJRh/7PeCckIM4Smu4smxjXaLPRvG4JkAhVbmQyHIPMjkNRaQF5AsySQHRmpjOZ066OmIHRU7JT05Z9tdcru3yXndlPRYJFu37W9/2wVtHy0LI/REZbsIOYAAZ7WSWdUt8EPXZZ0YloNtOuy7o27jeW0HqNR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738838869; c=relaxed/simple;
	bh=QlThTfXOHqDh4yZndnZ2uqzgxa+yvQSGKU2EwOd3e0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUmiwDpMxa/JbHB+VsVHwodnWgsfkGCzqq030oSJ+89+SPYs3FylXBUxUO6GmV0LCN6yBfRmYpiqXfIzCVnQVg57tqVJUxOVvhy4qpwwcpi2MMvcV42i7VwkvPqSSeM2o/Xa5X9TGw8IqPGdGTb9VglWRRzUoJzZ/tXcTUnMTfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BIHfj6YI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6ih0vTgIRG71UdmqFP4/qdzylk6AkxFKsTts6yUtzYE=; b=BIHfj6YIbRDZFdO9ZZtShujABm
	userF61Hy9yhwgP5nkGWyFxChpyFKXYxyF6BidELnuAQKCaHGc9LvbSC4Ior//F5rsopVKNxgF6ye
	f38ooUKmLZb0NhHx2eAch6c/JVGF/XSEs1ZRaJiBtsae9D1J2tTOES2CzPC2ErMafbe5ET16Lqomq
	E59eI5kV78330zzh/yDGOm78HXgqARurUhTwGCkwSXpYoevQiXlDbOjgWJak/BinuAnKxoezVM4Is
	Pknvglxm1ywPfD7G3VTyfaZU25CNZtYCAoMYR/AP5qZxRFpI2dCW2hJQxIwQiGZESQvlf7XYBGdBk
	WSx/XQsw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52382)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tfzQ4-0001nS-1b;
	Thu, 06 Feb 2025 10:47:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tfzQ1-0003Mv-2j;
	Thu, 06 Feb 2025 10:47:37 +0000
Date: Thu, 6 Feb 2025 10:47:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] Revert "net: stmmac: Specify hardware capability
 value when FIFO size isn't specified"
Message-ID: <Z6STSb0ZSKN1e1rX@shell.armlinux.org.uk>
References: <E1tfeyR-003YGJ-Gb@rmk-PC.armlinux.org.uk>
 <2cff81d8-9bda-4aa0-80b6-2ef92cd960a6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cff81d8-9bda-4aa0-80b6-2ef92cd960a6@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 06, 2025 at 09:08:10AM +0100, Paolo Abeni wrote:
> On 2/5/25 1:57 PM, Russell King (Oracle) wrote:
> > This reverts commit 8865d22656b4, which caused breakage for platforms
> > which are not using xgmac2 or gmac4. Only these two cores have the
> > capability of providing the FIFO sizes from hardware capability fields
> > (which are provided in priv->dma_cap.[tr]x_fifo_size.)
> > 
> > All other cores can not, which results in these two fields containing
> > zero. We also have platforms that do not provide a value in
> > priv->plat->[tr]x_fifo_size, resulting in these also being zero.
> > 
> > This causes the new tests introduced by the reverted commit to fail,
> > and produce e.g.:
> > 
> > 	stmmaceth f0804000.eth: Can't specify Rx FIFO size
> > 
> > An example of such a platform which fails is QEMU's npcm750-evb.
> > This uses dwmac1000 which, as noted above, does not have the capability
> > to provide the FIFO sizes from hardware.
> > 
> > Therefore, revert the commit to maintain compatibility with the way
> > the driver used to work.
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Link: https://lore.kernel.org/r/4e98f967-f636-46fb-9eca-d383b9495b86@roeck-us.net
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Given the fallout caused by the blamed commit, the imminent net PR, and
> the substantial agreement about the patch already shared by many persons
> on the ML, unless someone raises very serious concerns very soon, I'm
> going to apply this patch (a little) earlier than the 24h grace period,
> to fit the mentioned PR.

Thanks. Here's the missing Fixes tag that I missed:

Fixes: 8865d22656b4 ("net: stmmac: Specify hardware capability value when
FIFO size isn't specified")

Not sure if patchwork will pick that up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

