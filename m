Return-Path: <netdev+bounces-273656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH3rF2PYy2mILwYAu9opvQ
	(envelope-from <netdev+bounces-273656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:21:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 097E136AD7B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC58D302AB56
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05543DFC7D;
	Tue, 31 Mar 2026 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g18L0I2k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892E3E3D80;
	Tue, 31 Mar 2026 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966875; cv=none; b=uJuxhjggCDvpQdpZ43laE42sZv4ZLdMSQMh+nUNIvXeHvBgZ0/ASJWGgUwsye2ugtJwBJJqYXFXhfWJz4HFAkw6H5hCBOFBtH6CIwJ5IPhsOJFCe/+Zvuo8hacA1QzQvd9nAjJ17z1+c7ZmddE2YvIGD2SjAJKS3AuxP5Eite+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966875; c=relaxed/simple;
	bh=ogfaQLQlyDpOQb4seHz1KZGd8zJR/VT19HK6oxXwq7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Afj5q3yoVXHjpr0g5kOmc5azzp+I5ZgQpSf+CtjTfUGu3MCk2JlkUZweuKeRE9l3uh43shYpC+MKXRCc9b9A9738WvYpKS04xvMKrgaVJmgT8ia97NyGfdcurvs1sAfqR10dGyag3SUZLHRCj0YMRZfdg81gT3zuxm1qZjIuXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g18L0I2k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c69qMTeBzZSF344k7eJDz2pg38b+rRvVNKaXAZmEmuM=; b=g18L0I2k2UnFnKb14BbM5bAz/6
	zxYWwcFrUEHrZqe0gSCek7/QSa1qc2SEHT763dpwl/Az3/1uc8xAs8RGKIJ3eyK00+1mS70nNWeya
	1zD7A806PYQtaRFBfEwhomcK4a5kp3PJFKAFQGAzmBO/0YQ+Jmw2Sknf/mnkP6gcBsMs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7Zxf-00ECvC-I5; Tue, 31 Mar 2026 16:20:55 +0200
Date: Tue, 31 Mar 2026 16:20:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Charles Perry <charles.perry@microchip.com>, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: mdio: add a driver for
 PIC64-HPSC/HX MDIO controller
Message-ID: <88d652b9-ed4f-4bf4-b0ab-8703c15ce58b@lunn.ch>
References: <20260331123858.1912449-1-charles.perry@microchip.com>
 <20260331123858.1912449-3-charles.perry@microchip.com>
 <acvEpk1grDFAahzd@shell.armlinux.org.uk>
 <acvPKuuikqvfXauy@bby-cbu-swbuild03.eng.microchip.com>
 <acvUqDgepCIScs8M@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acvUqDgepCIScs8M@shell.armlinux.org.uk>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,vger.kernel.org,bootlin.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-273656-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 097E136AD7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 03:05:28PM +0100, Russell King (Oracle) wrote:
> On Tue, Mar 31, 2026 at 06:42:02AM -0700, Charles Perry wrote:
> > I don't know if there's any value in waiting for write completion here as
> > write completion doesn't mean that the effects of the write are available
> > right now. I also didn't run into any issues in my testing. Let me know if
> > you know of a use case where this wouldn't work.
> > 
> > I can add a wait for transaction completion if that's expected by phylib.
> 
> Consider a PHY using a shared interrupt line, and the interrupt being
> disabled in at the PHY before being torn down... wouldn't we want the
> write to the register which enables interrupts to complete before we
> unregister the interrupt handler for the particular PHY?
> 
> I do notice that other MDIO drivers don't wait. Some PHY drivers don't
> access the PHY after the write to disable interrupts either. So, maybe
> phy_free_interrupt() should read-back from the PHY before calling
> free_irq() to guarantee that the write has completed?
> 
> Andrew?

The general pattern is to not wait on write.

Interrupts is not a case i've thought about. Yes, a read to flush the
write would make sense, maybe in phy_disable_interrupts().

      Andrew

