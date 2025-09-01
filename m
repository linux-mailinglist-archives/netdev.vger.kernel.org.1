Return-Path: <netdev+bounces-218681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB9AB3DEA8
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7311888E0C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A982FB986;
	Mon,  1 Sep 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DYoYTFfX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679FF248F66
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719293; cv=none; b=EONOxLw6WI6TdyzUwFhCJ/qhEzcDOvh6VwZgt4xy1DB8Caz72nW1LCMJEvhlIE1MZZPk46pjl05P0067LoX+HM3mHis6amS/MdQAD/0JuaDr2MTgKPeehDEiEzJ10YPDN8rsaJiF1m0O2rrr7LY0WLj36kpyeIoCa4tSzv7numg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719293; c=relaxed/simple;
	bh=6pbX6e3rKlWX+5zTbRIjiiy6v+d3kQi9uRwQtgVRWLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePtXqaAOn1WF1bu/Vvevwgt547mbblTOrGphXo8SiFDR9bwJukkI1DrlG7KttMfxW0ZEY7AjzN5URHB8gkVx1L8hCmSN0i7x8M+BcmfIipgzBmH/Lde+lCBzob7ioP7KrRlGPbXohTffS5UHOFoeOAS1toyz8kNzCpJi3WXHuSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DYoYTFfX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qdCoAKETmQcYptl0OnpN//2WvCGwJmvxXbBVPduZW2I=; b=DYoYTFfXPjsIqB6QZAdr04O+CU
	GN1xCfwlQdOPrkn0DPdiM/ybr189ZXy0f9gvLkMFLg8U0mtN4ops5lqC6Ig3Fq46tZp/gCggoL0ki
	K6SUOVVYrkGaMFc59VA8ycPFaYE3ahsYkMG8m+ezacrXw9t3WjeD84jT3VSp3Adf/4eg5OvJBkr52
	FQxb7fhReD+rqKxgWnruk+m20gr7qMVuGqe2hubadQcX9xyBy/ZjB9VCOOqLBcf74XNpnIJOTHmOR
	8LXYU8PaJoA4vviNaqyv44M547e966tIiVFhWVuS7prEZx2AIFNg4Gc2vXMimG8GCRulKrPGyMn9c
	gPX70/7A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50762)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ut0vz-000000005w5-3Lsg;
	Mon, 01 Sep 2025 10:34:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ut0vy-000000006uQ-0GSE;
	Mon, 01 Sep 2025 10:34:42 +0100
Date: Mon, 1 Sep 2025 10:34:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net] net: phy: fix phy_uses_state_machine()
Message-ID: <aLVosUZtXftPC-OY@shell.armlinux.org.uk>
References: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Aug 31, 2025 at 05:38:11PM +0100, Russell King (Oracle) wrote:
> phy_uses_state_machine() is called from the resume path (see
> mdio_bus_phy_resume()) which will be called for all devices whether
> they are connected to a network device or not.
> 
> phydev->phy_link_change is initialised by phy_attach_direct(), and
> overridden by phylink. This means that a never-connected PHY will
> have phydev->phy_link_change set to NULL, which causes
> phy_uses_state_machine() to return true. This is incorrect.
> 
> Fix the case where phydev->phy_link_change is NULL.
> 
> Reported-by: Xu Yang <xu.yang_2@nxp.com>
> Link: https://lore.kernel.org/r/20250806082931.3289134-1-xu.yang_2@nxp.com
> Fixes: fc75ea20ffb4 ("net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> The provided Link: rather than Closes: is because there were two issues
> identified in that thread, and this patch only addresses one of them.
> Therefore, it is not correct to mark that issue closed.
> 
> Xu Yang reported this fixed the problem for him, and it is an oversight
> in the phy_uses_state_machine() test.

While looking at this after Vladimir's comments, I've realised that
phy_uses_state_machine() will also return true when a PHY has been
attached and detached by phylink - phydev->phy_link_change remains
set to phylink_phy_change after it has been detached. So, there will
definitely be a v2 for this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

