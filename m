Return-Path: <netdev+bounces-143701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F41A69C3BAA
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0ED1F22269
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA5A175D53;
	Mon, 11 Nov 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mABxQ8lV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17886149C4D;
	Mon, 11 Nov 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319543; cv=none; b=nknMVL2F1nW21+xJz+yBnNYgshL6cClsuLWcKcbXg8sUr7n9/+tF907g1E3fImp/ydv05DI0jCq0U0jiXKiEmMKTl2NbvVdYT90S9fLz3BQeWgV1eve2KrCeptQ8TncAnZQoDSoFXkl502kxQ+a3hFhYsOvwWY5GgP7ezYp++bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319543; c=relaxed/simple;
	bh=5E4PiUM6H2VzK82LbZdFXQ38ZKEEGPaaBLZf/X2cVJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5RwhkRrzmpaGvdR0AyIZFzHOmq4inIpkfj9tTco6oU3vemWUTF+ywY+3IbnRnhGVDlwvWQHPEl273nTrhVrVAqcitYgDnbs9bkPk4JhX/CjJRwFP1Exhqu8o1lmL8RstZMIrRzQSyd6ZFOPll2Xo+qWb5g8GCUN1IKIhnZ1hM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mABxQ8lV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5gcABcMx6atSEt4fk9ejpJtZtz28kmeVOewSAuA6sX0=; b=mABxQ8lV8HByVFKbyOILVaFIhI
	/bAFLgh8SQ0dE0kn0a19+wDoSr08vUqjlCsHGkzmIh4yznANZ0+u17qm37e4cNHpYl4/xB2bljqUy
	/xk0xQIkQwn3HHbyiOGuT0R6GCfiy9bpn4lNhoPWEcLZJCaDToFhevvKbI8wrbmA6WLtAY4g+ua4b
	tue8aTgCCV4KjXvdoLFv4tGMVk0tQGeT3J59mbr6qYxj44Xes/HZa+vPz1temYGm1s5bO1e+b7Dv1
	Wdan37bEOIrKGCL7ubcZnPpKrhphBNX/OiQkZ+KOU+IqUG6yys6iO5QKBLDVAAul86MIFu6MDnthb
	uQztfB7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54736)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tARIX-0001vb-1Y;
	Mon, 11 Nov 2024 10:05:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tARIR-0006Kb-1y;
	Mon, 11 Nov 2024 10:05:23 +0000
Date: Mon, 11 Nov 2024 10:05:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: WangYuli <wangyuli@uniontech.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com, zhanjun@uniontech.com,
	f.fainelli@gmail.com, sebastian.hesselbarth@gmail.com,
	mugunthanvnm@ti.com, geert+renesas@glider.be
Subject: Re: [PATCH] net: phy: fix may not suspend when phy has WoL
Message-ID: <ZzHW4wOAH769WSJ0@shell.armlinux.org.uk>
References: <ACDD37BE39A4EE18+20241111080627.1076283-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ACDD37BE39A4EE18+20241111080627.1076283-1-wangyuli@uniontech.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 11, 2024 at 04:06:27PM +0800, WangYuli wrote:
> From: Wentao Guan <guanwentao@uniontech.com>
> 
> When system suspends and mdio_bus_phy goes to suspend, if the phy
> enabled wol, phy_suspend will returned -EBUSY, and break system
> suspend.
> 
> Commit 93f41e67dc8f ("net: phy: fix WoL handling when suspending
> the PHY") fixes the case when netdev->wol_enabled=1, but some case,
> netdev->wol_enabled=0 and phydev set wol_enabled enabled, so check
> phydev->wol_enabled.

I think a better question would be... why do we propagate the -EBUSY
error code from phy_suspend() in mdio_bus_phy_suspend() ? It returns
-EBUSY "If the device has WOL enabled, we cannot suspend the PHY" so
it seems ignoring this error code would avoid adding yet more
complexity, trying to match the conditions in mdio_bus_phy_may_suspend()
with those in phy_suspend().

In any case, there's a helper for reading the WoL state.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

