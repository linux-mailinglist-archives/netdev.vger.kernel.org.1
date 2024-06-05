Return-Path: <netdev+bounces-101081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E17A8FD31A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 18:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9EE2856FA
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F4D15666F;
	Wed,  5 Jun 2024 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="12NS9nwY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679F3211;
	Wed,  5 Jun 2024 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606095; cv=none; b=cjT896z7gSUPfzUjCNeO2srRbRsNAX68wJjAtuRC0seVef3ds6+lSNl0prZLo9qIofr8dlF4eY8DC53pma1VSh/sPxlEdNeP4kJaYBFXO5eihr82/eqcqiZEKqa+b8MLPA+rn+HZMD3WJwbiAze8TC2OpguPcSjcIfRooS0cyY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606095; c=relaxed/simple;
	bh=wHtGfezfsNTTRs+YiPxLytTLRj3+4i1IKUQga7xWP+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx/o01UaypsQ+U+/E6z8UObaq2OEl/e41X1VgZUkrK0ni6MjnfGg/0zyeCbQl3pmgv71bqwGI/JZ9x9XebHddJ+NJtGOzw3jGvj70dAT67KWcr7YDhnJX0F44PAeL+gulgUY6vRaOXpc78V4IZAns5RYes1aThj9CcUXdXWvIeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=12NS9nwY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Sy8IyTf9mqvpYa5qUP0eJiWGfhaQAqvgS6Uul5RkQbw=; b=12
	NS9nwYp9aHzjlrNI33SUIFY2Inj0vvOE/J9QploqMIpPOZjjfzeySLtZryZGwYGbtDV/x633u7K/x
	hBwivNh3bSUIcPXBUPM43vgIFfrK475NuCwugJaFd/NmpRiNETQYE0ynbUsYuFb/U3y0miBHdId+G
	JpQWriJeUL+YjsI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sEto2-00Gvnd-A4; Wed, 05 Jun 2024 18:48:10 +0200
Date: Wed, 5 Jun 2024 18:48:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, trivial@kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH 2/2] net: include: mii: Refactor: Use BIT() for
 ADVERTISE_* bits
Message-ID: <1c4d8c46-3124-4a90-bc50-788cc3883d93@lunn.ch>
References: <20240605121648.69779-1-csokas.bence@prolan.hu>
 <20240605121648.69779-1-csokas.bence@prolan.hu>
 <20240605121648.69779-2-csokas.bence@prolan.hu>
 <20240605121648.69779-2-csokas.bence@prolan.hu>
 <20240605141342.262wgddrf4xjbbeu@skbuf>
 <52b9e3f4-8dd4-4696-9a47-0dc4eb59c013@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52b9e3f4-8dd4-4696-9a47-0dc4eb59c013@prolan.hu>

On Wed, Jun 05, 2024 at 04:47:27PM +0200, Csókás Bence wrote:
> Hi!
> 
> On 6/5/24 16:13, Vladimir Oltean wrote:
> > On Wed, Jun 05, 2024 at 02:16:49PM +0200, Csókás, Bence wrote:
> > > Replace hex values with BIT() and GENMASK() for readability
> > > 
> > > Cc: trivial@kernel.org
> > > 
> > > Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>
> > > ---
> > 
> > You can't use BIT() and GENMASK() in headers exported to user space.
> > 
> > I mean you can, but the BIT() and GENMASK() macros themselves aren't
> > exported to user space, and you would break any application which used
> > values dependent on them.
> > 
> 
> I thought the vDSO headers (which currently hold the definition for `BIT()`)
> *are* exported. Though `GENMASK()`, and the headers which would normally
> include vdso/bits.h, might not be... But then again, is uapi/linux/mii.h
> itself even exported?

uapi .... I would expect everything below that is considered exported.

Take a look at the sources for mii-tool.c:

    if (bmcr & BMCR_ANENABLE) {
        if (bmsr & BMSR_ANEGCOMPLETE) {
            if (advert & lkpar) {
                strcat(buf, (lkpar & LPA_LPACK) ?
                       "negotiated" : "no autonegotiation,");
                strcat(buf, media_list(advert & lkpar, bmcr2 & lpa2>>2, 1));
                strcat(buf, ", ");
            } else {
                strcat(buf, "autonegotiation failed, ");
            }
        } else if (bmcr & BMCR_ANRESTART) {
            strcat(buf, "autonegotiation restarted, ");
        }
    } else {
        sprintf(buf+strlen(buf), "%s Mbit, %s duplex, ",
                ((bmcr2 & (ADVERTISE_1000HALF | ADVERTISE_1000FULL)) & lpa2 >> 2)
                ? "1000"
                : (bmcr & BMCR_SPEED100) ? "100" : "10",
                (bmcr & BMCR_FULLDPLX) ? "full" : "half");
    }
    strcat(buf, (bmsr & BMSR_LSTATUS) ? "link ok" : "no link");

So they are actually used as well. Try compiling this with your
changes made.

	Andrew

