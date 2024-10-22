Return-Path: <netdev+bounces-137798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD3E9A9DBC
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9606B1F2142C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359D717BEA2;
	Tue, 22 Oct 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sDgKs6uM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C59811F1
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587612; cv=none; b=HWl/32dzOo0zHRT0GkM+Om12HosuA6Zqj8q6MCZrJJQzvUC2nEVPgjCMxEXuQ2uhT7DR6B4DLtxQ43ln4ReclB7++Maj5IqWSCC1ZPabftLn3ldA/ckBPzSjLOh5PNllod/jOEqnnCyfWZQIJljA/cPLc864kVEQisu4txb6rqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587612; c=relaxed/simple;
	bh=dvOQzHDfqqFJMtoJ/m8GC3fRpE6Cnmn8CscMgESkJ5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzRY1U5OEdFZoSdZyNrPlbGmDwTR6+cGSn6ZrGEhCfwdG57POTvepKfTbWP4QaXm48YmTXn84xHAubuJNFo/NDeey0ll0vgdadHWpuOsVkiBg8oirP8J66d4IDedthaWtE+DioFP4LHYvbgevkCJtBfpcKT0+p/v6/9Rh2QQSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sDgKs6uM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oGqZ5RDFwvj8pDZwRWXIFx1i5Pp0PASkGbmVNLacn9s=; b=sDgKs6uMHGhKsM/KSrZ6axozn8
	4brjpY8rINMoRIeWgNCXF3cXszh4BI7NpbSzHiACw3JyQewxe06VLx11c4ZFbWpCX+4E3rE5MgV+r
	YA3esmEVXTpg6yACvKtN505MO4rLy3MFEUZpVs0DCg6kRQJigCV2CYwG7t1+pws0zYJh8xAvkAYWc
	Pfw8bXKS/Qe3eFdqkTASYgVzVr6juhBP6ezcYzB2cShNhGROEW7ipOUSgr+PcLrCEPch7u+/QgC5z
	ZcnRORoo4qrB/AX39DTBDguvmJxMp87x+9RVUnIoMcrogL6mE3X22nbmnujLWmr7TMqhSZ5BKfP3H
	plOiKKgA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54356)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t3Ak8-0004aW-2t;
	Tue, 22 Oct 2024 09:59:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t3Ak6-0002aF-07;
	Tue, 22 Oct 2024 09:59:54 +0100
Date: Tue, 22 Oct 2024 09:59:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/7] net: pcs: xpcs: yet more cleanups
Message-ID: <ZxdpicVgg8F3beow@shell.armlinux.org.uk>
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi netdev maintainers,

I see patchwork has failed again. It claims this series does not have a
cover letter, but it does, and lore has it:

https://lore.kernel.org/all/ZxD6cVFajwBlC9eN@shell.armlinux.org.uk/

vs

https://patchwork.kernel.org/project/netdevbpf/patch/E1t1P3X-000EJx-ES@rmk-PC.armlinux.org.uk/

I guess the kernel.org infrastructure has failed in some way to deliver
the cover message to patchwork.

On Thu, Oct 17, 2024 at 12:52:17PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> I've found yet more potential for cleanups in the XPCS driver.
> 
> The first patch switches to using generic register definitions.
> 
> Next, there's an overly complex bit of code in xpcs_link_up_1000basex()
> which can be simplified down to a simple if() statement.
> 
> Then, rearrange xpcs_link_up_1000basex() to separate out the warnings
> from the functional bit.
> 
> Next, realising that the functional bit is just the helper function we
> already have and are using in the SGMII version of this function,
> switch over to that.
> 
> We can now see that xpcs_link_up_1000basex() and xpcs_link_up_sgmii()
> are basically functionally identical except for the warnings, so merge
> the two functions.
> 
> Next, xpcs_config_usxgmii() seems misnamed, so rename it to follow the
> established pattern.
> 
> Lastly, "return foo();" where foo is a void function and the function
> being returned from is also void is a weird programming pattern.
> Replace this with something more conventional.
> 
> With these changes, we see yet another reduction in the amount of
> code in this driver.
> 
>  drivers/net/pcs/pcs-xpcs.c | 134 ++++++++++++++++++++++-----------------------
>  drivers/net/pcs/pcs-xpcs.h |  12 ----
>  2 files changed, 65 insertions(+), 81 deletions(-)
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

