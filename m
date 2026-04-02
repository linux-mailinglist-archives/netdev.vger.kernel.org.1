Return-Path: <netdev+bounces-274648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAoGGPCwzml+pQYAu9opvQ
	(envelope-from <netdev+bounces-274648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:09:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A572F38CEA5
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14F0A3025E66
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 18:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36248370D75;
	Thu,  2 Apr 2026 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v7Q7tc4Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CEB248896;
	Thu,  2 Apr 2026 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153362; cv=none; b=IriWsiI33Wp3tGjSOIYqQ+6GaME5KGa9o/DyvIgUdimq1LQeEUW+nMmonzV+wtPWIm+LXFzuicYatSunx3stkIWp3k0tZN5DbYB6PaYVjn1xV2u3x/VHl8bBMFYH6OesycK2Asp9afYxhdqpF0ok4rGV7cOMa1XbvBMe30ufCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153362; c=relaxed/simple;
	bh=OxTv7yY3uM6xNky71nBtWAeX5mMQRrg/MxsRr+fr6bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F747BL0adv02tbjKQYJhnxcvLovSoMAUk7W6S3JWbZ8GvqMwqgAKLiInitpXAXTu2Bv7D7gdR4oX06KGbINGr26QvIfZpP9GoSlDa+/YA9Am43x9H3v81Gwf91joGIJmFPMvnDp2gX+tk8GEhKWk+/lq6I1TDmyVPEOy93Ajffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v7Q7tc4Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4cO+IF++io//C6y+K7sIeFhMvmU025SAspAUxfzVhfc=; b=v7Q7tc4Yut4ptXkLLD0Wxy2TaZ
	Z9dWKfu4Xw/hY17S3tH92lqcWc8SJx7wsYPkOYf14UFhC/It/G5alj8z+LLmFHBqsKKQQU2WGoe63
	14+Fw/Cgn71PSZnmvyosqza8di6RwJPr/jesw/QYJupbzQGhQvPkiN0GVYrA+lbUAqoo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8MTa-00EYXc-Rv; Thu, 02 Apr 2026 20:09:06 +0200
Date: Thu, 2 Apr 2026 20:09:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Charles Perry <charles.perry@microchip.com>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: phy: add a PHY write barrier when
 disabling interrupts
Message-ID: <b40dfafe-7e8f-4686-a743-31b097c84954@lunn.ch>
References: <20260402131229.319599-1-charles.perry@microchip.com>
 <20260402131229.319599-4-charles.perry@microchip.com>
 <6bb3aec4-1635-4287-b7ce-f15b693563ea@lunn.ch>
 <ac6vfhsW2ThF8i2_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac6vfhsW2ThF8i2_@shell.armlinux.org.uk>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-274648-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A572F38CEA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 07:03:42PM +0100, Russell King (Oracle) wrote:
> On Thu, Apr 02, 2026 at 03:31:52PM +0200, Andrew Lunn wrote:
> > > +static int phy_write_barrier(struct phy_device *phydev)
> > > +{
> > > +	int err;
> > > +
> > > +	err = phy_read(phydev, MII_PHYSID1);
> > > +	if (err < 0)
> > > +		return err;
> > 
> > There are a small number of MDIO busses which don't implement C22,
> > only C45. You are likely to get -EIO or maybe ENODEV, -EOPNOTSUPP,
> > -EINVAL for such a read. Returning the error than makes
> > phy_disable_interrupts() fail, etc.
> 
> If it returns -EOPNOTSUPP (meaning, at least, that bus->read is not
> implemented), do we want to issue a C45 read instead?

Maybe.

get_phy_c45_ids() first reads MDIO_MMD_PMAPMD : MII_PHYSID1. That
seems like a safe option.

      Andrew

