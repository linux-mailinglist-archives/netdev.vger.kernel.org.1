Return-Path: <netdev+bounces-113850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F8E94016A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 00:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A556E1C21F9D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 22:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B642D145A18;
	Mon, 29 Jul 2024 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="imiVwvg7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07F1448C6;
	Mon, 29 Jul 2024 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722293654; cv=none; b=DlkXDhWf5LK16dsvYtPigZ/Y975X6GvQwXd8GcUk3VavnFWMBZLDGgrmzpKGZ/0YtV4Dpc9voPFeOOXdBns3O8z6uSi93ox47KKwm+/cJFhk4uVAOcNI/ekfrqJz/Q9CzAfC6NpWVkjPDVzO0YZoHauSWBlQ8gaimLW68Lc0JE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722293654; c=relaxed/simple;
	bh=A4NUHweu7W9bA/qpS7RZ+IxtPFCsInF/r8woYJtzm8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcuCiDKLPMnsfmUWZ30liWL9d1rwCw4Xuqw/nFTiPuAPVjyMScikXcKegvKOAkSjXaGrFCFiKqENgwWA9Ovv4PbzBdlIZFYIoIglLOQe8oWVMtPaAWh//AFgX55Nj524n10oZ8QDvUhkcfasPXd0VZvT8QEDKVyOzdp/Wtfq5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=imiVwvg7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hVn/jXY0R8V+8elImCZToQy0N198aIg7bzmntNAen8E=; b=imiVwvg7HkJVqicYWZzu2ZaOMR
	pgFHfLHXtqkyTk7dZg2q8nOb6WfAf4MPydy1hqPwP49kPYm43Gw+jZQ1kOPs3Tt4wrxK8dpqUvH1P
	voMJ7tnIkTTP0/dKS++fek1e7DgB4jRGTKrJCPeHXasYbvf+7sQZTh2fkgJSnjGJKim0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYZFY-003Vzv-Kk; Tue, 30 Jul 2024 00:53:52 +0200
Date: Tue, 30 Jul 2024 00:53:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/9] net: dsa: vsc73xx: fix MDIO bus access and
 PHY operations
Message-ID: <83562533-2291-40d9-8bf4-4e1f30188b61@lunn.ch>
References: <20240729210615.279952-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729210615.279952-1-paweldembicki@gmail.com>

On Mon, Jul 29, 2024 at 11:06:06PM +0200, Pawel Dembicki wrote:
> The VSC73xx driver has issues with PHY configuration. This patch series
> fixes most of them.
> 
> The first patch fixes the phylink capabilities, because the MAC in the
> vsc73xx family doesn't handle 1000BASE HD mode.
> 
> The second patch synchronizes the register configuration routine with the
> datasheet recommendations.
> 
> Patches 3-5 restore proper communication on the MDIO bus. Currently,
> the write value isn't sent to the MDIO register, and without a mutex,
> communication with the PHY can be interrupted. This causes the PHY to
> receive improper configuration and autonegotiation could fail.
> 
> The sixth patch speeds up the internal MDIO bus to the maximum value
> allowed by the datasheet.
> 
> The seventh patch removes the PHY reset blockade, as it is no longer
> required.
> 
> After fixing the MDIO operations, autonegotiation became possible.
> The eighth patch removes the blockade, which became unnecessary after
> the MDIO operations fix. It also enables the MDI-X feature, which is
> disabled by default in forced 100BASE-TX mode like other Vitesse PHYs.
> 
> The last patch implements the downshift feature and enables it by default.

Please separate fixes from new development. Fixed should target net,
while new features should be for net-next.

      Andrew

