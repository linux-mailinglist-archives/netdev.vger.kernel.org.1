Return-Path: <netdev+bounces-108584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B0392471D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306091C22CB7
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7981BC074;
	Tue,  2 Jul 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="b7Hjzm1e"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B51D1BA898;
	Tue,  2 Jul 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719944043; cv=none; b=LJqipJq85M74Om5Wl9aiWRQVtRoi2FvT2d2lQNkq4pD12dccGbxajK0BxYceqihpebb3mEz7bEgiE9LJLS4N9u7nmsyVxvyttLfAjjvOlLf5UGsThVqEJBMCsP9i9pishImCjAXbU5/hXOTMoHxPWZOOMApSPSVYK6cqepjGb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719944043; c=relaxed/simple;
	bh=EIPZEjRJ8N8RpDgtd387K6uzMFw3+qQbSdd1Ek9xHsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd0gJ/4dSshbxofU7oO9Xzs7+zuyztDcB5+YQ8Ki3S4rUwawMWOl7i0Rl0FZWC980VBnfPzY0v7Ei/9bLAUctRDzKemQLEbg5NF+SWw5wgQZEVs1q7DR21+VvPg4FRhltwtO1o8SvoGuBkzzzydyHN/NG1yvKHW9fcB7w4Hmvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=b7Hjzm1e; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1vI3OD5MioJJkEt9hn2vCnrQ3brAdTmVUzJOaAxBrOE=; b=b7Hjzm1evGn9fzPeI3Im/y7G1B
	z44jzt4FjrsTuNpI/pQR+TbNlmKwrmJV6PEOwzMdZtPUxP53qoYs3yULyFHKqeKh7b3qw4bCw7cDF
	5e0RH3TyPoS7MPPRuLFT9LV1us/UI1m1H/cbqhY8kvnQrrzdJnUv8il4akV5OIO1NdvKPJArZifOl
	Xrbxg8dzB2WGqQIKQQo1yQC6as1Ny3MuOo+lPWi43fyJjZBj3LQ/KUMgpUGWTSfoKwXo5PYWg04yd
	mkFTt2gB5UkuqDr0cotRMsiA/aLvrZU/pyO2ix14gwgldt6CKkHuqE13YYgZSR0D02sxiwSs59mbe
	4BmjOyvQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53934)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sOi0i-0004UT-0z;
	Tue, 02 Jul 2024 19:13:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sOi0k-00028a-4h; Tue, 02 Jul 2024 19:13:50 +0100
Date: Tue, 2 Jul 2024 19:13:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] net: phy: dp83869: Support SGMII SFP modules
Message-ID: <ZoRDXvO/4sxJuotC@shell.armlinux.org.uk>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-5-a71d6d0ad5f8@bootlin.com>
 <f9ed0d60-4883-4ca7-b692-3eedf65ca4dd@lunn.ch>
 <2273795.iZASKD2KPV@fw-rgant>
 <b3ff54a1-5242-46d7-8d9d-d469c06a7f7b@lunn.ch>
 <20240702165628.273d7f11@fedora-5.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702165628.273d7f11@fedora-5.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 02, 2024 at 04:56:28PM +0200, Maxime Chevallier wrote:
> But I do agree with you in that this logic should not belong to any
> specific PHY driver, and be made generic. phylink is one place to
> implement that indeed, but so far phylink can't manage both PHYs on the
> link (if I'm not mistaken).

This is not a phylink problem, but a phy*lib* implementation problem.
It was decided that phy*lib* would take part in layering violations
with various functions called *direct* from the core networking layer
bypassing MAC drivers entirely.

Even with phy*link* that still happens - as soon as netdev->phydev
has been set, the networking core will forward PHY related calls
to that phydev bypassing the MAC driver and phylink.

If we want to start handling multiple layers of PHYs, then we have
to get rid of this layering bypass.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

