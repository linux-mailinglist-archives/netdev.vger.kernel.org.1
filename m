Return-Path: <netdev+bounces-137081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651529A4483
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D95289DD2
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FCB2038DD;
	Fri, 18 Oct 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h7mFB0q5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785782036F0;
	Fri, 18 Oct 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272035; cv=none; b=J4EUJmroCqzJXLoIoOh+TUAKUQl2QrtIFcN6vftBzDKf2DtcmOcsTCRbO2gqnWvbcpb34Jdx+yWZ1+IZtF6/Qq7xTnR1RIwnDfn57dYgIVF9W9pv+AVODsat07OynJXmU2tMbOK9yrvWTcd8U0x6USLuK3rWuAXVx6VDSO1NG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272035; c=relaxed/simple;
	bh=dZ7YYya0q5B/8AAuZYQguFC1OFINiz7A33DEolg6Ll0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0tAgzPMfV7WLCDuC65dWScomMo/Lut9esPn8ON1KQ7lWY1GtaYNAYgXxxmns8qbhEyg8/Fl6vWEH+SzySlSEELCJGeG5WeWpxTk6FgEGoNk99vj3XkDP4iM63xGiizC+O8IgBBRXMW1f1v5w+44u2bxNduVk+EglD+xXdqCZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h7mFB0q5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UVt9/1lN7Rn1Hj2JXo4fdGFUv7BED5KttVlKyVJNmEU=; b=h7mFB0q5YEOSh7ExFBATyH1KiG
	C8LzixmOpEviOpxN4Qqy4gU4rZep6SF/es0uiV5kjU4c+lh3RGvBQiKyd6RIvSUhY9LpYHI2L4QaJ
	EGYwvIHUhl0eGSDcR6ouw9AwpQ0Li5VobG0+OfJYFNl0k1cIbDu58Fjt7TWRlCr5aJMI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1qeG-00AYNo-Tg; Fri, 18 Oct 2024 19:20:24 +0200
Date: Fri, 18 Oct 2024 19:20:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Davey <Paul.Davey@alliedtelesis.co.nz>
Cc: "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: aquantia: Add mdix config and
 reporting
Message-ID: <804d1825-8630-4421-925c-16e8f41f9a58@lunn.ch>
References: <20241017015407.256737-1-paul.davey@alliedtelesis.co.nz>
 <ZxD69GqiPcqOZK2w@makrotopia.org>
 <4e8d02f84d1ae996f6492f9c53bf90a6cc6ad32e.camel@alliedtelesis.co.nz>
 <ec453754-3474-4824-b4e3-e26603e2e1d8@lunn.ch>
 <858331af57bd1d9ab478c3ec6f5ecd19dcd205ef.camel@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <858331af57bd1d9ab478c3ec6f5ecd19dcd205ef.camel@alliedtelesis.co.nz>

> As auto-negotiation is required for 1000BASE-T (and higher speed
> twisted pair modes) the question of whether Auto MDI/MDI-X detection
> occurs when auto-negotiation is turned off is only really relevant for
> 10BASE-T and 100BASE-T being forced.

Yes.

> When I was wondering if mdix_ctrl being set to ETH_TP_MDI_AUTO should
> be rejected if auto-negotiation is disabled I meant for this specific
> PHY driver as it definitely does not appear to perform the Auto
> MDI/MDI-X resolution so if the wiring/cabling between and/or config on
> the link partner does not match the default (MDI I think for the AQR)
> then the link will not establish.

Well, as you say, 1000Base-T needs autoneg, so there is no need to
reject ETH_TP_MDI_AUTO for that link mode and above.

It seems like for lower speeds, ETH_TP_MDI_AUTO could work without
autoneg. So to me, this validation is not a core feature, but per PHY.
Please feel free to implement it for this PHY.

    Andrew

---
pw-bot: cr

