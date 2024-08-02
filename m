Return-Path: <netdev+bounces-115257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3451D945A1A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588941C23137
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184BB1C2307;
	Fri,  2 Aug 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DQQ0iris"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E5F1CAB3;
	Fri,  2 Aug 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587846; cv=none; b=p5gTx4bfYCHXnJrva3bPPvEo59yXkdkUhHu8ddP7Y/VR8W2q7+aSZGyD8Ew6D7O+DHUZjgJLZlJhs/PWVzsjSu+mDzQlsoPIWPeWXmTmHF8VwpHlTklyhsN9pXb4XkkBpAsH4dgVC6mkz77Tw0H+St3vfXUu0v4ZEDQ45z7/ESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587846; c=relaxed/simple;
	bh=gMpVP+i/SLNYTAXprwY5KhVFurne7mqpU9lWyE+mvMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9hfvYbiPaUEpon3cWP05ey8wMGRBzkx1RiVgWihTN8i5CeuUbUJsRASgjd/BtS50/tIIq/UkIOHkNvQIxNHHfrve13X+ZcbpcXSd3RhqsMbEq67nBT1fFKNoNc7xtK24S0uNJQ4rhN/BzUhN04Inf7oF+/2IvKIxCj3J+ZR5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DQQ0iris; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dAS8o2POPE/atG9dDvuPZleU9MToXu7UDTD2Zc7Jfl4=; b=DQQ0iris75pbOUuA9sc2Z0L2nZ
	ZFufiqlvOOaendF44dF7yPoXQB4gZwUZil/g+/bQ02cNG+g5n7Wz0+ekkbYUTjdkBwamsRJWmav0M
	VasjsR64ZjD8hrg4Gmc1bfm2JsyDwd4mB3IyOpIj8Q50TaaVtNl9rE+RfXMUkTiXWS7p9Jhnv1jJz
	/q3S6vdQ+l0ECUG7u2n8DjSU8EhjX/Ta6BMWzlCHkvnz7jyORz+F1tbWrS8CM+fAiZIA+3Wlu23z5
	Z02dw8xU1W8wAZ4LeBralAH0I9f1LBg5QdW8bBJyqMt3E9ksiKj0qnHNihDI8ADpR9GBLf+yIfwpf
	XOUMa30Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42206)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZnmj-00057N-0D;
	Fri, 02 Aug 2024 09:37:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZnml-0007ta-9O; Fri, 02 Aug 2024 09:37:15 +0100
Date: Fri, 2 Aug 2024 09:37:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ronnie.Kunin@microchip.com
Cc: Raju.Lakkaraju@microchip.com, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	horms@kernel.org, hkallweit1@gmail.com, richardcochran@gmail.com,
	rdunlap@infradead.org, Bryan.Whitehead@microchip.com,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V3 3/4] net: lan743x: Migrate phylib to phylink
Message-ID: <Zqyau+JjwQdzBNaI@shell.armlinux.org.uk>
References: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
 <20240730140619.80650-4-Raju.Lakkaraju@microchip.com>
 <Zqj/Mdoy5rhD2YXx@shell.armlinux.org.uk>
 <ZqtrcRfRVBR6H9Ri@HYD-DK-UNGSW21.microchip.com>
 <Zqu3aHJzAnb3KDvz@shell.armlinux.org.uk>
 <PH8PR11MB79655D0005E227742CBA1A8A95B22@PH8PR11MB7965.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB79655D0005E227742CBA1A8A95B22@PH8PR11MB7965.namprd11.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 01, 2024 at 11:46:41PM +0000, Ronnie.Kunin@microchip.com wrote:
> Hi Russell,
> Raju can comment more on it when he comes online tomorrow (IST time), but I recall this was discussed with you last year and my understanding is that the outcome was that as long as the need to use the dynamic fallback from phy to fixed_phy mode is explained in the commit message - which Raju did in the commit description - , it was acceptable to do this in phylink. Unless the "mechanism where a MAC driver can tell phylink to switch to using a fixed-link with certain parameters" has been implemented since then (apologize if it has, I am not a linux expert by any means, but don't seem to see it), I would guess the reasons for doing this are still valid.
> 
> Attached is the email thread with that discussion and the relevant comments are copied below.
> 
> > The reason this should work is because the fixed-phy support does emulate a real PHY in software, and phylink will treat that exactly the same way as a real PHY (because when in phylink is in PHY mode, it delegates PHY management to phylib.)
> >
> >Using fixed-phy with phylink will certainly raise some eyebrows, so the reasons for it will need to be set out in the commit message - and as you've dropped Andrew from this thread, I suspect he will still raise some comments about it.
> >
> >In the longer term, it would probably make sense for phylink to provide a mechanism where a MAC driver can tell phylink to switch to using a fixed-link with certain parameters.

Note the last two paragraphs...

What I never understand is why many software engineers working on Linux
are focused purely on the driver code and seem to have a complete
aversion to touching/improving anything outside of their driver,
prefering instead to come up with hacks.

Given that what you quote from me was from 26th September, I have to
wonder what you would define as "longer term" as we're 10 months on
from that statement.

I think it's time to implement the suggestion in the last paragraph
rather than using fixed-phy.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

