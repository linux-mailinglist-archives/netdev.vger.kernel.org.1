Return-Path: <netdev+bounces-166912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F11BA37D97
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AD43AE53E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D464B1A5B98;
	Mon, 17 Feb 2025 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Cd24yS5h"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2760F1A4F21
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782533; cv=none; b=nD9NIRUklR29BWSsiJl6dwoUxKUnqfvbB9i14tkvFnljr6/ypkhsCW99Zdh5xGVMQ1/Ld9mQjHxsmZdD29v5HzYTXRPyXsYXi4uNmeCXybbQoGlvX0+2VqsymxofqOOV0mwGH+XZ6m8yGQUzLUr/s6lAj3cEjzzk5LUdgLIf+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782533; c=relaxed/simple;
	bh=Ua2fkggrqdxxEBNSjLXPbQT2MS5vJ9CZ7kw8dpU9/kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXhsQaSXiBG3MFG0LmGuxilcdjHNlbyLf64EhSBayy9q4wvIFz2K2poSuqaESnyjD0oCza0UFHPYjRHYtrkhxaJIGsNow59D5XvhOY/WCK4yz3K07UkEVUb9rNu68NcoMnJCmM5MgGgjdudqXDdwIRZ70pmqAo5G77aGDc30K8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Cd24yS5h; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zkE03wwGYiDZm17RyxTQhXUXY1Op+Z+AgaxwG08nGnE=; b=Cd24yS5hUePf/d52PZeWGCkyv8
	+p5s+jOiYAJAoPpuBXA/COlXbCxVoLWQDwQxsqlCX8RkytA/5eKoWmzHFnNgrSTvaMqLCCbojT4S5
	7SrAn25s1gQ0GzeQt8BEA43xFck0bX9exRoGdUelSuOx3yOu7WOxgyGOrW28CS87S8GpCnrK2HhK7
	oJ2Xy0uqgFQ2cY5UJIC1d90gY15UbRUwf/b6J7JE9+cKWEEfIYcCP21/mvngNbAw8hzRQS93eA5qu
	DgSsyzZh/mf0VSWiwAbq27XufLT6yoDPKXW27Pgu5OMKVO+bbMvsVvWUzqH3OtnTveGSdOHSH9KYF
	U/kA0dGw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57814)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tjwuU-0005sb-3A;
	Mon, 17 Feb 2025 08:55:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tjwuT-000657-2X;
	Mon, 17 Feb 2025 08:55:25 +0000
Date: Mon, 17 Feb 2025 08:55:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 5/6] net: phy: c45: use cached EEE advertisement
 in genphy_c45_ethtool_get_eee
Message-ID: <Z7L5fWGrX-l2OdPG@shell.armlinux.org.uk>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
 <e57ed3d4-d0bc-4f91-83f6-8f48dfb6d7d7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e57ed3d4-d0bc-4f91-83f6-8f48dfb6d7d7@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 16, 2025 at 10:19:23PM +0100, Heiner Kallweit wrote:
> Now that disabled EEE modes are considered when populating
> advertising_eee, we can use this bitmap here instead of reading
> the PHY register.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

