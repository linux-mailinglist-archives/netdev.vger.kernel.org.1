Return-Path: <netdev+bounces-213641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BBDB260CF
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9F6188C6AD
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313562E9EBD;
	Thu, 14 Aug 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lA1Zpkgu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE03D271465;
	Thu, 14 Aug 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163347; cv=none; b=PAh9+Hn0o5wyIO+Z/PY2yv156WoQxK3Ql6HaXviiwmDmE+P7SRhf2w4Cvxpem3A/vamol7+a0rnHWURImK4niHgo8Ve06N+OkocZVySZXGIlq//6CLaibjQ132kDX1N3jrAO2tiUzh6HA+qVD7ine1GBR3UU/oSftzdVYuN9lLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163347; c=relaxed/simple;
	bh=Phg9MkubuxaWQUFj43sHfZ1An1zIUa2py5iBlUX9mfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iI6sh4BtnalSScw8tBkDaF6TRyzEM/J8nENVx/tverkTquFDywlq1fI9lHSir9Kf0Ivy1dKufsnUvFU9vpZXg7bJDkE+LyOdaoRa//NyateR8kIYngO0iGitOgpYE107xgB4MmwTXrGluC1KmrTwVJn77vR8Xpsxn/MP9dF5tqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lA1Zpkgu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q3yvJ1ZKQ/ypgfMfd1m0c30uJ5dz5zquEtlwfVv6cAs=; b=lA1Zpkgui1eFxiHuDHKpINnxNJ
	MhOVL3U+mDj8kf8n16nV2btk6MYKqsTL5N0vko53n+qtiKrqWLHsxklZ+bPVzhTZm/forR8IHrHO0
	u2m663aoQ2+SrT6sth0qgtAyexfI+7pMeMembSa5tE5znX6hKHMctcUcTGvUulfFXS3ifmTvudJsD
	oLKqsX5b/NOiP+Mgu4TPVf0eQJstUW7SOiYPkPPKXpYSwibbAyFzu9605EplyHtL/V3zazck/Py6d
	6ra2wzx/AXVgdXEjDxQVbDpsYtmbZTtb3aiHhf+GtfcBsBvNkUmrpVNzHsqupNG5dJQd9KKsYYPDl
	9H9r6g/w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45322)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1umUA3-00083H-0T;
	Thu, 14 Aug 2025 10:22:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1umUA0-0006h7-1B;
	Thu, 14 Aug 2025 10:22:12 +0100
Date: Thu, 14 Aug 2025 10:22:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, o.rempel@pengutronix.de,
	alok.a.tiwari@oracle.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/4] net: phy: micrel: Introduce
 lanphy_modify_page_reg
Message-ID: <aJ2qwwycF_Ol6726@shell.armlinux.org.uk>
References: <20250814082624.696952-1-horatiu.vultur@microchip.com>
 <20250814082624.696952-3-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814082624.696952-3-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 14, 2025 at 10:26:22AM +0200, Horatiu Vultur wrote:
> As the name suggests this function modifies the register in an
> extended page. It has the same parameters as phy_modify_mmd.
> This function was introduce because there are many places in the
> code where the registers was read then the value was modified and
> written back. So replace all this code with this function to make
> it clear.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Looks good to me.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

