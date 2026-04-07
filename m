Return-Path: <netdev+bounces-276133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH75AbFT1Wkf4wcAu9opvQ
	(envelope-from <netdev+bounces-276133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:57:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66B3B31A7
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7994301FC3A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E231195C;
	Tue,  7 Apr 2026 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1J9mEbO8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9D619CCF7
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588270; cv=none; b=RnUf88DHOwIzAoCx+70A1uDjbgwo/yKE39mhoPgrymzLKw0TMPvKkjhQgmBkHzSqT7rspAwcRoY23zg617vN1gx3SEJy1QSpRrLqRZN55UqOji+D3YRjfDNvK8bCJajF8KSNUCVN/CWUYAu5LXAYQm2hSICxdSnEnqOKoEuQIdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588270; c=relaxed/simple;
	bh=Vpu+rQBVIB/g5HYMJKzZHGGuWAVN+PxEEEY9IMGdbb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dncmPMEtX0tFWxZKoaWvbfxLKl7Shii4S+iYmDfqF2NexOABq3Src/wc1wW6C2YYJtPqhtT7IHNGIznaQ0CjPLX/fxxPGYfQrAwxtjU6rxEfi/VQVRxRiph26Y7RcvMD0fvtK7COlPAmdh6elsd+EQZPGUrApxTGixOZBqs/3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1J9mEbO8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nJmfixk0ZTaaiWN975SXJ4FIWPkSMsAENI+lagC+6a4=; b=1J9mEbO8RWxcbCK0gNB+A1dIqx
	nfA/5YzNSJWxz8HAZO4LuE6lSXLF5RYHe7rtba8CEk1Ud397eRj2e6+Q+Fv/1P/jQGRGFq7Ly7vNh
	KkM6Vp7V5zUjf6cxfmwcBMMYcMzFvAwipXFAyEd1GfoeEarri9zcUpUZIUJHxZg48c44=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wABcD-00FAni-Cp; Tue, 07 Apr 2026 20:57:33 +0200
Date: Tue, 7 Apr 2026 20:57:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Charles Perry <charles.perry@microchip.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	Tim Menninger <tmenninger@purestorage.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH net-next v2 1/2] net: phy: c45 scanning: Don't consider
 -ENODEV fatal
Message-ID: <edc33490-09b5-49fd-a1f9-72d76d5aaebf@lunn.ch>
References: <20240204-unify-c22-c45-scan-error-handling-v2-0-0273623f9c57@lunn.ch>
 <20240204-unify-c22-c45-scan-error-handling-v2-1-0273623f9c57@lunn.ch>
 <adVJ1YpHv1bWCxKL@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adVJ1YpHv1bWCxKL@bby-cbu-swbuild03.eng.microchip.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276133-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,purestorage.com,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C66B3B31A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 11:15:49AM -0700, Charles Perry wrote:
> On Sun, Feb 04, 2024 at 05:14:14PM -0600, Andrew Lunn wrote:
> > When scanning the MDIO bus for C22 devices, the driver returning
> > -ENODEV is not considered fatal, it just indicates the MDIO bus master
> > knows there is no device at that address, maybe because of hardware
> > limitation.
> > 
> > Make the C45 scan code act on -ENODEV the same way, to make C22 and
> > C45 more uniform.
> > 
> > It is expected all reads for a given address will return -ENODEV, so
> > within get_phy_c45_ids() only the first place a read occurs has been
> > changed.
> > 
> > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/net/phy/phy_device.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index 52828d1c64f7..962ab53c23ff 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -780,7 +780,7 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
> >   * and identifiers in @c45_ids.
> >   *
> >   * Returns zero on success, %-EIO on bus access error, or %-ENODEV if
> > - * the "devices in package" is invalid.
> > + * the "devices in package" is invalid or no device responds.
> >   */
> >  static int get_phy_c45_ids(struct mii_bus *bus, int addr,
> >  			   struct phy_c45_device_ids *c45_ids)
> > @@ -803,7 +803,11 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
> >  			 */
> >  			ret = phy_c45_probe_present(bus, addr, i);
> >  			if (ret < 0)
> > -				return -EIO;
> > +				/* returning -ENODEV doesn't stop bus
> > +				 * scanning
> > +				 */
> > +				return (phy_reg == -EIO ||
> > +					phy_reg == -ENODEV) ? -ENODEV : -EIO;
> 
> Hello Andrew,
> 
> Did you meant "ret" instead of "phy_reg" here?
> 
> "phy_reg" doesn't make sense here because you would have already returned
> in the previous iteration of the loop.

Hum, good catch. That makes no sense. Looks like i cut/pasted from the
C22 code, and did not fixup the variable name.

	Andrew

