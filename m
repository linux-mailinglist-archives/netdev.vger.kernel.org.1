Return-Path: <netdev+bounces-197989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06953ADAC67
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DB73AD8D5
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B40226E153;
	Mon, 16 Jun 2025 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mfoqK15q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B691FDA
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067567; cv=none; b=Y9Mfux7e9QcUkVTwh/LUg2UA34K0lojaAesO6TA27dZA25PSNRW0LNC2+fKpFsIQUdDeLgf83+4sCxutT1GqHUIpcRZ0EXBrcug0bh2/TbbFZ/cTn8XnKBkkTk7oblu0+Bx0uA2ONGUOOJUXZgh8EFBfsptbmafYgCGQspOKz18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067567; c=relaxed/simple;
	bh=eyCCFeXpNJkuoRvNuLvZERCSSHr9nR4B6i/r7pyX3l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNzzOyVV240UN3nEpUtUe2DKqf9ZpORsfHf0J8rSmHfwW+TsWQOoBlzfMZ3ikTWs+d3/aOV1GitNWR/6eVXN9mkGI4o9AKfDtchfa6euFhoKO+1abqAvHC6bTnwnBUr985kfzo1rteL7lpVkUFq+TXMZjz1KY1oGaSsiYgxANgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mfoqK15q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ESHTWsIsHIJfmh6ItbhYiVPgnEK6vFeZu09cq2P1rsw=; b=mfoqK15q5qSByZkB3fuPUOmzry
	7i+NX4jPxVJHjLAYzIiNZXfjBppK3qAL5o5+pe3EDD4S4lfRZYOg5toyZzF/6KEazyx87ux35FGU2
	8gsBDQq7qhYdfbJEV3NGzmeU0YIa2RGub30pfRqnUl3m26fuUDvc4ZrFbcZtmuEWNlzx1SjyZVm0o
	YRzqK4qnUrH321IzGGGb8mruU0lubudu2ZaTBYBlTlyKIDGQ7Fo61bFp3YhMAc1W8U9IG5v+zBWmw
	zVny402muAPNoh24x0QMSwW2XOip2n2psvbvxlZ+dDD509r/g6ae+WgFFJ5y3AEH4ICs9OIz17m27
	oSic+3+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42394)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uR6W8-0003Xa-1T;
	Mon, 16 Jun 2025 10:52:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uR6W7-0004iU-1B;
	Mon, 16 Jun 2025 10:52:39 +0100
Date: Mon, 16 Jun 2025 10:52:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net: phy: add flag is_genphy_driven to
 struct phy_device
Message-ID: <aE_pZxQX0mtBJxzQ@shell.armlinux.org.uk>
References: <5778e86e-dd54-4388-b824-6132729ad481@gmail.com>
 <3f3ad6dc-402e-4915-8d5a-2306b6d5562b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f3ad6dc-402e-4915-8d5a-2306b6d5562b@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jun 14, 2025 at 10:30:43PM +0200, Heiner Kallweit wrote:
> In order to get rid of phy_driver_is_genphy() and
> phy_driver_is_genphy_10g(), as first step add and use a flag
> phydev->is_genphy_driven.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

