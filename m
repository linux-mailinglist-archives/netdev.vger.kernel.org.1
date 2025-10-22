Return-Path: <netdev+bounces-231817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D139BFDCD1
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEEC19C38E9
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFB1315D29;
	Wed, 22 Oct 2025 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eYqIBWwz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4532AAAE
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157252; cv=none; b=qpBCzjHXLw1m0TDwqyeUZQfs252UYYjWnJkYA9WJWXCUQOX5EwRsL6wn+cIbMlcunBulW8VTFwiRg7dFn6OGidEzdgaOnhLUipAhm2AaztiHTZfCck4ishAbBEmedbiAEgivgrQvPbjRs67jfgWKKrtC875qb68YXXXYWGrLo3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157252; c=relaxed/simple;
	bh=2yd4yS/64ARZJEJKeCA4TfQv/5KvaeRsYTgL3hmqU+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQG3qDj12NtXlnRFdOIYPqrPh/pvI9/3DUIzR3YInT8idmycGd4xfbqJD/NFOHGa3I7cuP0LnxAmPcVjvTb7QF/m9pnD/l5Zjv9l03p8BjhwFEOOdRPvY9u6tk0hn3WyVbN+QVjDJCUacC9v5SvX+CuyKf0iwdBGDRx1V3nyEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eYqIBWwz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2eg5VCKhxpUu6/CBY1uNQQlvIa7Z/RikQOCRPOIN5rs=; b=eYqIBWwzr42NbDZUgJACt+frDZ
	i7ljnO/w9b5sT4KjlaNpTFUbK5JNnvqHzCflRrJZYUk5yHDXajRMQfblY8A3PDMu2g7jrLcnFZaFv
	hwZp/RHAkQaM7d9Jk3pU8g6t4hCJNeSnx817L7Vipz3TsRTTbt8IDMA1EpWZv/coVNrsMet0TjGI9
	cMWI7Nzb11DBcFfC9oiB5aGvK4DKqX6/GaWmWkXTTIU+eJFWGUmtqbd1CKse7sCk3GIPiEfUIzEza
	SwKecesTrtcNMIYnPeI7rd3RitMEk/VCq++jvTiZCOQxcG7B3yeVFk+ScGQKPVS7Zh85hQc3G2Vz0
	uFUxJIaQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38592)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vBdS0-000000005IZ-1ACS;
	Wed, 22 Oct 2025 19:20:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vBdRy-000000000v1-1be2;
	Wed, 22 Oct 2025 19:20:42 +0100
Date: Wed, 22 Oct 2025 19:20:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/6] net: phy: add phy_may_wakeup()
Message-ID: <aPkgeuOAX98aT-T7@shell.armlinux.org.uk>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
 <E1v9jCO-0000000B2O4-1L3V@rmk-PC.armlinux.org.uk>
 <ad16837d-6a30-4b3d-ab9a-99e31523867f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad16837d-6a30-4b3d-ab9a-99e31523867f@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 22, 2025 at 03:43:20PM +0200, Maxime Chevallier wrote:
> Hi Russell,
> 
> That's not exactly what's happening, this suggest this is merely a
> wrapper around device_may_wakeup().
> 
> I don't think it's worth blocking the series though, but if you need to
> respin maybe this could be reworded.
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

I've updated the description as I think patch 4 needs a repost:

+/**
+ * phy_may_wakeup() - indicate whether PHY has wakeup enabled
+ * @phydev: The phy_device struct
+ *
+ * Returns: true/false depending on the PHY driver's device_set_wakeup_enabled()
+ * setting if using the driver model, otherwise the legacy determination.
+ */
+bool phy_may_wakeup(struct phy_device *phydev);
+

Do you want me to still add your r-b?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

