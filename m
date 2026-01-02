Return-Path: <netdev+bounces-246561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BBACEE52F
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 12:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29040300451B
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 11:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088A62E22B5;
	Fri,  2 Jan 2026 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lLtaXHfy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7F2690EC;
	Fri,  2 Jan 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767352933; cv=none; b=H6vT3X/dtfDgLud6TNIGD2J0QJIXQuMUnTcq8tGoWKa9hvbgef/Ry4uNtrfHqo3iPqoKBpL3Mqi8zRTN3Av+xEpauBkwd1Q6R3c/LcCu5Kzt0ieUdP5gQaTU1qmOeD7SvpfBvvZFcSmxXMSen6mL74N6owmxMFrOKLPICGZk0sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767352933; c=relaxed/simple;
	bh=DFNwcvFT6CS+U/63LNkTD/dJXIepoj/tpicP/GPrJoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYd2Vdc5y4pWXiwrEcpmHsBYzKps/5t+dwnirly0m5isrDGCVz0hYcD75Eg41KFVwjwKktYaIPilX3cRaXVIzJB6tg5pjyw+8m905NOnCPbWGi1bzTDmGX4JpiY5qBFdai2BuAuyNTndkIkNXIzFxZREPqtlzBPOtIdihF3C6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lLtaXHfy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rrfz9N7B8i7I9HCUv8haUfs2CvkRvGTfH+5BsheLZBU=; b=lLtaXHfy41/OGO9VMemuNM2qCN
	aQCtTkrRyG3YE3BHfhO6gUm9iERpxWT+3o9KHwljC3DMg+QBAuRKB6RhYwzmLq61gf5OA3yPWeq89
	i4h8cuYTyM8yWAIdo+WyrzfOJyXJgiZfw4DQ/J9Mo9TMUVENc/pFHnmdCrIKOMUySgpb+7piu1sTO
	DOqUk1vyxTdzdOVOr8icU3MMJnbXmiiTL6FxezeO2fb9v+uYehsVWeGPJKQf5dnWntVE6SCEYyEa7
	TU5wET3rI9K5gV6UBbdpzDG8d+h6SDiI8a3evCJeqyrKT6fDSoMqzm7D8Zfcl13SUmBtyImw0qmtT
	raHNy8ZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36608)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vbdE8-000000005tv-3Z3i;
	Fri, 02 Jan 2026 11:21:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vbdE0-000000004zr-2CR7;
	Fri, 02 Jan 2026 11:21:44 +0000
Date: Fri, 2 Jan 2026 11:21:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wangxun: move PHYLINK dependency
Message-ID: <aVeqSLtI0SgjsQP-@shell.armlinux.org.uk>
References: <20251216213547.115026-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216213547.115026-1-arnd@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 16, 2025 at 10:35:42PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The LIBWX library code is what calls into phylink, so any user of
> it has to select CONFIG_PHYLINK at the moment, with NGBEVF missing this:
> 
> x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_nway_reset':
> wx_ethtool.c:(.text+0x613): undefined reference to `phylink_ethtool_nway_reset'
> x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_get_link_ksettings':
> wx_ethtool.c:(.text+0x62b): undefined reference to `phylink_ethtool_ksettings_get'
> x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_set_link_ksettings':
> wx_ethtool.c:(.text+0x643): undefined reference to `phylink_ethtool_ksettings_set'
> x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_get_pauseparam':
> wx_ethtool.c:(.text+0x65b): undefined reference to `phylink_ethtool_get_pauseparam'
> x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_set_pauseparam':
> wx_ethtool.c:(.text+0x677): undefined reference to `phylink_ethtool_set_pauseparam'
> 
> Add the 'select PHYLINK' line in the libwx option directly so this will
> always be enabled for all current and future wangxun drivers, and remove
> the now duplicate lines.
> 
> Fixes: a0008a3658a3 ("net: wangxun: add ngbevf build")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

