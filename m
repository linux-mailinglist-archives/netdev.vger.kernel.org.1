Return-Path: <netdev+bounces-137815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2309A9E84
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123F21F21DC1
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C27175D35;
	Tue, 22 Oct 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HA/wXe+2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97AC1494CF
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589422; cv=none; b=Jpv3wEHimxiI5s4TA3ENL5bJIBci/I+AZhYBQ2ZemQeHaKahvyUFFfnM6L1+xSofYvLIJCSK5CmlxL6c0rTdUP4XZaB7ersJI1xZocv7nIJSarvQMiVuCUSEongOc5I4mZQKCa9oSUBO8Lt4YOIxZkr04YcSZopg1lALOMNrO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589422; c=relaxed/simple;
	bh=lwWaIKUDLrASIs+YuQAsWWsBGuSYfndTaa6AQqKGnxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIr4wWd7gg6ksd72g7+ZrgzhPLjJQyao5RAJBdMTqg7PkaF3zAWahUmmfNyzMQyu4no8fYubrHX+J3nKa0Weqs9L5x3LVAgqEY13Cdb2FDJ0Yh/0KZrdl7b5kDMbdcy1vSpLtqJQWHzRF4omhCkWLQGmoy02iqBjrflNe3FBSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HA/wXe+2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nYelBhaN5oKAcdk01/RIcwHYXV4unuzMcDbElnc1alg=; b=HA/wXe+2FQMX08DdM0Of6psn48
	nTKx1x+OaFg0kntwhaTwpUVBeZu8nBCVCZCz1i04sTwZS4LjK6g5x8HPJ1rJWSs4xCWWS7u04HmYw
	PpJPdmq2TvYQo42IXYavq2xg1CUBff9pDXq3KwUdq9sqT0LXdFYDgKcLS6vzPIWSajOpcAvgfkaOF
	Kx6WxIULs3m3kixpPvQmF0vgQ2gighnY1HzhJtquwcFbFL6cLAsx8QgHocv+61IVeyFUhjxEpU1jn
	xCxTWcBGmrdCdVCKdMvHKC+S+V5g0xjQSddYjCbqKFtbOlt96zZMV1Qj3o7nKtvJNUDFwj1/10iys
	5HaMEr3g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32972)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t3BDR-0004dX-0R;
	Tue, 22 Oct 2024 10:30:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t3BDO-0002bd-39;
	Tue, 22 Oct 2024 10:30:10 +0100
Date: Tue, 22 Oct 2024 10:30:10 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] net: pcs: xpcs: yet more cleanups
Message-ID: <ZxdwomfrljH6uSQz@shell.armlinux.org.uk>
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
 <ZxdpicVgg8F3beow@shell.armlinux.org.uk>
 <e5aefe89-ef71-4e50-ab3a-ac0e72b99fa7@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5aefe89-ef71-4e50-ab3a-ac0e72b99fa7@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 22, 2024 at 11:23:30AM +0200, Paolo Abeni wrote:
> On 10/22/24 10:59, Russell King (Oracle) wrote:
> > I see patchwork has failed again. It claims this series does not have a
> > cover letter, but it does, and lore has it:
> > 
> > https://lore.kernel.org/all/ZxD6cVFajwBlC9eN@shell.armlinux.org.uk/
> > 
> > vs
> > 
> > https://patchwork.kernel.org/project/netdevbpf/patch/E1t1P3X-000EJx-ES@rmk-PC.armlinux.org.uk/
> > 
> > I guess the kernel.org infrastructure has failed in some way to deliver
> > the cover message to patchwork.
> 
> Thanks for the head-up!
> 
> I can't investigate the issue any deeper than you, lacking permissions
> on the relevant hosts, but I verified that the merged script fetch the
> cover letter correctly, so no need to repost just for that.

Thanks for checking. Johannes explained that the checks are done by
Jakub's nipa bot and uploaded to patchwork.

https://github.com/linux-netdev/nipa/blob/main/tests/series/series_format/test.py

Seems nipa (or Jakub?) missed out on the cover message.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

