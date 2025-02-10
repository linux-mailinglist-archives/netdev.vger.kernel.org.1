Return-Path: <netdev+bounces-164770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E30A2EFB5
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A95F18882C7
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5CE2528F0;
	Mon, 10 Feb 2025 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fd0fglPz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D942528E1
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197595; cv=none; b=hZtFRUZFFV10vfH7TV2kVlxjcm65N4Mu6CrLjydqHXOSGfVKoH7nySn+INtnVqjPpCzb/2W9rEe5OGH3Hac1FOgWchDIS6yO50q9AfWq2tB1ylP1MmZFRDNRPS/AMv09MnyGJLNXCftFoOwW1yxDgSoBbC4uj//cSnLFpgdyQkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197595; c=relaxed/simple;
	bh=bH1sZwDqXrR+FIbM9nV2iSH1TYW3RdI9u0dhr2wyygA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEPt8Uos1u4Liu0vY0eTSi5R+bq9PcW76Adjq0IiQsmqpXjGWbaBEMpwyNBoJkmDU0OGBJCyPe34MfIwXFv5vmIXXTqdGy2LaiZWDDzc51sB2+X3NhcokfLYNFjuMNcIZO0YvMvHYkfZvofRAADnViV/eS+sPIykMdqpxpFKL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fd0fglPz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WHL3dN12cZfiqrpQ91ncKM7YasTAZTmSy6+gYCoByzs=; b=fd0fglPztCXBx8mpibEUk4hjrb
	U/mdf7XKKn380K0TMQLav6Nif2k/ZPUOWfkkBHhpS8EgBMXoPsmFnO7oaSEXrGLbNnakGndmL0Ilf
	ljmLgU+AxBphLAYtBDDDu9vIB5HJJHYNSUZZXAONu26tK553VeO32vjtJiMSGwklDhZ9+OdZlbWRP
	GapFrAroqfysPv00Hz1II24f8MuGhEYueF+d3DazlcQEjfqjguciZ639hdI8fal/dQu95ETYTYQFt
	YPeidu3lAImAMobwYlDxgUPoCVf8OwZhJALFqZajuQOM1IqEvIq7inpV2M81pSOfp/OJNZXn4mjTu
	pcYniMWw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58998)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1thUju-000794-1B;
	Mon, 10 Feb 2025 14:26:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1thUjr-0007ZG-0z;
	Mon, 10 Feb 2025 14:26:19 +0000
Date: Mon, 10 Feb 2025 14:26:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v3 1/3] net: phylink: provide
 phylink_mac_implements_lpi()
Message-ID: <Z6oMi8rTeuwHHDt8@shell.armlinux.org.uk>
References: <Z6nWujbjxlkzK_3P@shell.armlinux.org.uk>
 <E1thR9g-003vX6-4s@rmk-PC.armlinux.org.uk>
 <20250210132054.oaqb5mboh6qiixfv@skbuf>
 <Z6oHxrtBHAvaMqd3@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6oHxrtBHAvaMqd3@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 10, 2025 at 02:05:58PM +0000, Russell King (Oracle) wrote:
> On Mon, Feb 10, 2025 at 03:20:54PM +0200, Vladimir Oltean wrote:
> > On Mon, Feb 10, 2025 at 10:36:44AM +0000, Russell King (Oracle) wrote:
> > > diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> > > index 898b00451bbf..0de78673172d 100644
> > > --- a/include/linux/phylink.h
> > > +++ b/include/linux/phylink.h
> > > @@ -737,6 +737,18 @@ static inline int phylink_get_link_timer_ns(phy_interface_t interface)
> > >  	}
> > >  }
> > >  
> > > +/**
> > > + * phylink_mac_implements_lpi() - determine if MAC implements LPI ops
> > > + * @ops: phylink_mac_ops structure
> > > + *
> > > + * Returns true if the phylink MAC operations structure indicates that the
> > > + * LPI operations have been implemented, false otherwise.
> > 
> > This is something that I only noticed for v3 because I wanted to leave a
> > review tag, so I first checked the status in patchwork, but there it says:
> > 
> > include/linux/phylink.h:749: warning: No description found for return value of 'phylink_mac_implements_lpi'
> > 
> > I am aware of this conversation from November where you raised the point
> > about tooling being able to accept the syntax without the colon as well:
> > https://lore.kernel.org/netdev/87v7wjffo6.fsf@trenco.lwn.net/
> > 
> > but it looks like it didn't go anywhere, with Jon still preferring the
> > strict syntax for now, and no follow-up that I can see. So, the current
> > conventions are not these, and you haven't specifically said anywhere
> > that you are deliberately ignoring them.
> 
> It was explained in this email as part of that thread:
> 
> https://lore.kernel.org/netdev/ZzjHH-L-ylLe0YhU@shell.armlinux.org.uk/
> 
> The reason is that it goes against natural grammar. The only time that
> "Returns:" would make sense in grammar is when listing with e.g. a
> bulleted list, where the part before the colon doesn't have to be a
> complete sentence.
> 
> This is why it's going to be an uphill battle - grammatically it is
> wrong, and thus it doesn't flow when thinking about documenting the
> return value.
> 
> If we want to go to a bulleted list, then it will be natural to add
> the colon.
> 
> I'm not going to explain to this level of detail in every email, and
> because of the grammatical nature of this, it's going to be very
> difficult to use a form that goes against proper grammar.

Also note that it follows the style already present in that file
with one exception (which is one of the few cases I remembered to use
the new format.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

