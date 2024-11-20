Return-Path: <netdev+bounces-146455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902719D386E
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47578284E93
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB122187859;
	Wed, 20 Nov 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ycD4IP0/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114974040
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098919; cv=none; b=IrHGFwSHS2ka7U4iNxZagTL9ejGZXKvrdaFhhK80dIwss4n5UwW/PFLnfHRCbaIjkgi63w5oyI/J1VB5CzJAsUB7Kgjgoxt0yZ8by2164VZQ18gYgt+FMl0AKHLkrotiynLxb1DoRzwbCmprFA7JuGIiVk2wvdh/LkCiHlVZyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098919; c=relaxed/simple;
	bh=XnRn8fPMaE/oq34tllE91lDCQp2ao2urRaiU6rBouGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omXdyrR7RCfgt16aq1Q9LPaYtbC+d7zpDo5NCsvxFUpZnWHJQcduaxUCt5Z4kP1yJZTI0qDgfDCT1VMKDDkvJVnJmifpze+cj5M7jQsaLU1KpzHHH2vnp+Iwrcitoo6EdVnWsZ/1SHXwyROf13FpyVvcOt+hpX76qvIzV+FqUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ycD4IP0/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vk1zGBSoY4OhmdTphTqEqB7U0YmG4PuU12CSPPBAU1w=; b=ycD4IP0/qp2ThZSdj8CNyzM0Dp
	j8HcW36wc6eZtk2myqHaYft0GkGRrQyDkeyAEUwRY2LRfr3YAza/g+ITYXhvPOul6+gYln+WWnycL
	s0q1kBx9N0mJeZKNHBN2izzky0nQVpFBKDCaQ7ko+/Zu7Co44J9ZjtY0yeEkRmpbtApQ7PtKGfkvN
	5QjbQXQIIgY7LonxoPTF15XACgk+Z5OZIibQ6rbFJyVxbRR/LANcW3nVhWYawsOgGqgVUWDtXu9Qw
	Z2jpiXVJ4+64w+KJ8un9NYyeEMCCy4P2VpPXjggU8vSsXmOFLQru6NtkBCkQ0fFHcwYuqw8a8Rdwq
	nwyAtgTw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60048)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tDi3B-0005Ij-1m;
	Wed, 20 Nov 2024 10:35:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tDi39-00070Z-2T;
	Wed, 20 Nov 2024 10:35:07 +0000
Date: Wed, 20 Nov 2024 10:35:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net] net: phy: ensure that
 genphy_c45_an_config_eee_aneg() sees new value of
 phydev->eee_cfg.eee_enabled
Message-ID: <Zz27WyoSjlg73Shh@shell.armlinux.org.uk>
References: <a5efc274-ce58-49f3-ac8a-5384d9b41695@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5efc274-ce58-49f3-ac8a-5384d9b41695@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Nov 16, 2024 at 09:52:15PM +0100, Heiner Kallweit wrote:
> This is a follow-up to 41ffcd95015f ("net: phy: fix phylib's dual
> eee_enabled") and resolves an issue with genphy_c45_an_config_eee_aneg()
> (called from genphy_c45_ethtool_set_eee) not seeing the new value of
> phydev->eee_cfg.eee_enabled.
> 
> Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

