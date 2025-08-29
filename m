Return-Path: <netdev+bounces-218228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D69F1B3B888
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A2D1CC0EEC
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F7530ACED;
	Fri, 29 Aug 2025 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WLHPAU2/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EBF303C9B;
	Fri, 29 Aug 2025 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462568; cv=none; b=lv7JPm3NNcYWqt5zH+NVyMdjL0v9xVKJ/RUAmeQEIh7w/ODQulAH4BQ0hlAoorr1LrMDOGW5mv6m9mC7QUTrmSGwy/STGXvXHXOuEcyGec5rZHXt0v6NuxwNiN+RwSctRM7jlPXcZkMCxgQsdSAKsa8pYkZuMeJxYhmB1ZPA55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462568; c=relaxed/simple;
	bh=WbLgjcBljJWng7F/PmRJAuLpmT5rWVoOSKtbwSZn5pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuABRIiFsM7hQ5dN4PBQa1nmyxcBnbc7xmXQjyBu36z/od9+2CzVn036SHQUTqdRJhdb6SOCG7cFmCxMsksShnca2rjDiktwsjjGfJ21c7OUCuJ7n+prUK+rV2GE+XdpxDBJG4+7a+rAfNguU6NtGNWFyhJnEWpVUUhJrDOn/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WLHPAU2/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dzvn+HkcEQf6uCQurQB3v/7VM2IOdyfF0THhqpg4hCI=; b=WLHPAU2/vGxJlarInNuVj7fpXo
	iLQDtjUPgCaKSF2rNyn2jFK5lTFK8fsfXal/quIQze3FKtV+A8aB9iulhS5Vvi2pLKroxNm3tMAdO
	+z5qi8mOiK//LQA94S6RCFWFwrFYf39W7Nwxr4/IT+AbVfmyqk9FSd0XLQ9y8t7gsLlKCnOFk0WAp
	qi0Vhr77/rViqDEM5im0Cxqs7tOwZmipizZxxgb+MA/pEXx3CboltE/IK40UutgUV3syfVuvbuiy9
	2keSk/eba1OuMAOqkbEq+LxqQrWC3n39D2fV8nPhxqWEzhh7qxTeKOQ8cSFUcHi0ZeO7pOC41P9+Q
	zHwCryMw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44750)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1urw9F-000000002dl-1Ray;
	Fri, 29 Aug 2025 11:15:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1urw9C-000000003yv-26gq;
	Fri, 29 Aug 2025 11:15:54 +0100
Date: Fri, 29 Aug 2025 11:15:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, Parthiban.Veerasooran@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: phy: micrel: Add PTP support for
 lan8842
Message-ID: <aLF92l2Sbl2elYBn@shell.armlinux.org.uk>
References: <20250828073425.3999528-1-horatiu.vultur@microchip.com>
 <20250828073425.3999528-3-horatiu.vultur@microchip.com>
 <aLAS9SV_AhEeQIGM@shell.armlinux.org.uk>
 <20250829062654.mr7fos3yp63d2wjv@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829062654.mr7fos3yp63d2wjv@DEN-DL-M31836.microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 29, 2025 at 08:26:54AM +0200, Horatiu Vultur wrote:
> The 08/28/2025 09:27, Russell King (Oracle) wrote:
> > On Thu, Aug 28, 2025 at 09:34:25AM +0200, Horatiu Vultur wrote:
> > > @@ -457,6 +457,9 @@ struct lan8842_phy_stats {
> > >
> > >  struct lan8842_priv {
> > >       struct lan8842_phy_stats phy_stats;
> > > +     int rev;
> > 
> > Maybe make this a u16 and move it at the end of the struct?
> 
> Yes, I can make it u16 and move it at the end.
> Just for understanding, do you want to move it at the end not to have
> any holes in the struct?

Correct. It makes sense to avoid holes where it doesn't detract from
readability.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

