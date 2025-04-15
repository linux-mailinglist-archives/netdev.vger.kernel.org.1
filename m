Return-Path: <netdev+bounces-182901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A1EA8A4E9
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AAA17EBB5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A997484FAD;
	Tue, 15 Apr 2025 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rnsHzzdS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9748D2DFA5B
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736728; cv=none; b=ZzJg1NJA2SqEibAmFk4rSY3ynQTMXfM65kC/LpoOJmCgeuvvNV2ganN6Bybh7PnTH3G23ity7frNh2BWaXCphZgHzrE4K32UXSfP/V4kQ4tRK3Kz7yOZ7yDyYBuyBI7czyw5E9i+mQbZrTv/9IqTW/J+vbreEelj1nTAioePI/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736728; c=relaxed/simple;
	bh=VutMaZYw6msU9X6Ywu9TUH3pYhZ8Ed8XcVm+BDkirvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoTRbweLT2107Cj0ZxFFk6HCxhXpJs1gFg9r/VQnmvMl0on2Uwb/ZNsC8XhqRaC6p8cY5WI9yVUssO91v0kMJZHwb7xRAgP5wptc0IO/T5D+CCQxeREjsjCtjz0WXxLV0oXZu3Y/gsoMbGSZd8apbc82hOzzjET/FcGLGwdhJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rnsHzzdS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a4i3hHxfGyCeIjXRMb2Hikf5itrwVDBNXFKOz3lUUvY=; b=rnsHzzdS+fdn5LgO4Nx57POx1i
	6sqbfLUyuVbRypb7Flmf+Yj/m3FH7J6sGHY5405bZc/R/B4ZcOnpxhfF9ia011SUguvNRnt3FjV5/
	72jUrMwXIifgfmkb7VrbGS2hpeDuFo9CbfnBtR/WlzoOxo1oZ+qEnmj/JIx9iToZpEsyghQ6gaQUH
	3//nqVr2F5/UTm4UQIWu+Y1ld4LGF57hvsF3q2omApLePPt4a0/o46WreZjDyBR7RkVfxdAzNvWLM
	pHgckEwXh+IYsg98BiKxMT89RnVP/2z0K+9AHV/qFd5+7/42OA+fPm3r3l5rJsncXX1To6olepKPb
	RTC60eSA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58348)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4jiq-00007M-1r;
	Tue, 15 Apr 2025 18:05:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4jio-0000XR-1q;
	Tue, 15 Apr 2025 18:05:18 +0100
Date: Tue, 15 Apr 2025 18:05:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: remove redundant dependency on
 NETDEVICES for PHYLINK and PHYLIB
Message-ID: <Z_6RzimpYVqeOHyN@shell.armlinux.org.uk>
References: <085892cd-aa11-4c22-bf8a-574a5c6dcd7c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085892cd-aa11-4c22-bf8a-574a5c6dcd7c@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Apr 13, 2025 at 11:23:25PM +0200, Heiner Kallweit wrote:
> drivers/net/phy/Kconfig is included from drivers/net/Kconfig in an
> "if NETDEVICES" section. Therefore we don't have to duplicate the
> dependency here. And if e.g. PHYLINK is selected somewhere, then the
> dependency is ignored anyway (see note in Kconfig help).
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

