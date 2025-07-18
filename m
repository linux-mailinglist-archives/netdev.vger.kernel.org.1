Return-Path: <netdev+bounces-208195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82123B0A823
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B74A1C8139F
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAA22E6125;
	Fri, 18 Jul 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Sc+0nxXh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CA22E611F;
	Fri, 18 Jul 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855072; cv=none; b=dj+F1hJZjOoCpDfPGyYTXyeZYX0+6GEk/JBzLBH/m3RSLovSBIjKQk6imQYESn3DgndnbvXS0oPjoba2cmPs0f21WB1THAyTi4KKCgKKktf3HdwNxhFJbXrOcC4LfUgyiQP8/8ExQjTAxo2YJKt/nJvl0PLF7FZuFofcUnxHfd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855072; c=relaxed/simple;
	bh=edJ75qXqFBPiDqu0QUODDa038aOzTIs/JrrivMJk9pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXsAq7N2P6/HzThhY9H2CjJQZ7XRcqJNtg0HnCLcjFVP7OZ+h1IsUs5b0RG6JqQYF5+IAxm82G+nVO0lznvtg2k/ZcFxT0BReqaKnsi5ab3ptij7WEJtHCQlQi0FmMSFZ+jQID66PD2llbakpEdk/gU1isuEyaq/ValuzGwekNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Sc+0nxXh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vG3+MphUuzezupsm99ahKL4+T2QuOqPKBUk1bgYCYSQ=; b=Sc+0nxXht8ryQHTDlNkhAhh55T
	oSktqoiMD7Gt563xejGhByb396WyFQ550CVuiwbcgMopNU9DBry/bQuwsSbNb/U3i9ckXk63IFB3v
	wF1CdpMNgd8ocKZ9bUPM7MQByEwUB3spy52BVgWXZ0ntPTJOP3dP+gx7dgtoEfBD63pCCglKeHOub
	plCA01MX2bRgfJbLc/2kXlu3su/Oepirh4KGel2PzFEcapN7HMIloocg0kekKD2Fwvz0rr4ufZpUD
	2W+k4JhyoCD7fie797vxUbFC4R+q0pOe4klxcJXJZOIKA1t1gMZFoY0GC25IHjorUXkCd0cAD8u3v
	ZJO4Cyug==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59924)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ucnfl-0003B0-1w;
	Fri, 18 Jul 2025 17:10:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ucnfi-0003JC-2w;
	Fri, 18 Jul 2025 17:10:54 +0100
Date: Fri, 18 Jul 2025 17:10:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Abid Ali <dev.nuvorolabs@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: Fix premature resume by a PHY driver
Message-ID: <aHpyDpI9PW8wPf6I@shell.armlinux.org.uk>
References: <20250718-phy_resume-v1-1-9c6b59580bee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-phy_resume-v1-1-9c6b59580bee@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jul 18, 2025 at 03:42:22PM +0000, Abid Ali wrote:
> There are possibilities for phy_resume to be executed when the ethernet
> interface is initially taken UP after bootup. This is harmless in most
> cases, but the respective PHY driver`s resume callback cannot have any
> logic that should only be executed if it was previously suspended.

Sorry but no. The PHY will be "resumed" from boot, even if it wasn't
"suspended". So the idea that resume should only be called if it was
previously suspended is incorrect.

E.g. .ndo_open -> ... -> phy_attach_direct() -> phy_resume() ->
	phydrv->resume()

During this path, the PHY may or may not be suspended, depending on
the state of the hardware when control was passed to the kernel,
which includes kexec().

PHY drivers must cope with an already functional PHY when their
resume() method is called.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

