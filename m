Return-Path: <netdev+bounces-183442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B576A90AC0
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D1C1888342
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE80217673;
	Wed, 16 Apr 2025 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OH6qEwFH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8648212FBC
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826618; cv=none; b=tOryEFYqnBoT+zhix5LPmQdaX0h7DZI4S9pZpo/jWwkqWv9xb1TIkF+KWUapryewVpyb1ladd6GliHS0LQ0SP3N1YBoT+QvYtjlW1EyAzZpyUXpTvzP9qOBSM671UiEUah/sof+CkFJgqQMUqm1njNJ/ANb+Oh0rqRxboJpH2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826618; c=relaxed/simple;
	bh=JXXLstJzDc6pB6ceGZw9Ys0bNMB2Sx221nOmuQMp/Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpzVe94O84GLj95mg1IIx3zKMiNcZgCMO8vuzW1VDOfgOe67KFRZ4+bafIDsKTkhzPbRjSVDCvJhld3O71ZkHtXhwMbT/+4Ng7/r39zK34RHk4pVQ+jgV0R+h/R2pw3U0CKVeqUbCtXxYOU/9cLHfi6ptCDo7Z3Tvi4eMKJOiUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OH6qEwFH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NJezJ3JKJn/lT7bV9zFqb3A9+YwgHaor3OWOH2QhrfY=; b=OH6qEwFHc99Ha7JqwKv7jMP/VA
	I+OxXNDjHtKYzKMGYs/zxhUe0+ZWnqGJ3zNiAOihoC2jTDMThgiHTw/CTK5z2Ek53gqxTw0/s/dZo
	uXyj4Qc3NPwaUN392Mhj+9rsbliM7UnI+NhBxZQP+6ztCGKnMGy/ao+69nciB7cP7/Wq4Rkjmi0gA
	U+aPBkgQKOP9gB4lpCkBPoTe2Jhnjw4V2BKwaitBzQ29vdyQsAJPMs1aKscY52Dh1w7kEcMnUcH+l
	ZYX/zldrDIY2Zq+zD0eNlVoXMVe80MJ8dGH1NrTgj+qKKmNm0mEAy3h9H9qk/yl66JJr1zhLxSpKZ
	yefTPZ7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57022)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u576b-0001lk-0h;
	Wed, 16 Apr 2025 19:03:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u576W-0001bU-1K;
	Wed, 16 Apr 2025 19:03:20 +0100
Date: Wed, 16 Apr 2025 19:03:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: call phylink_start() and
 phylink_stop() in XDP functions
Message-ID: <Z__w52jL05YbqSTW@shell.armlinux.org.uk>
References: <Z/ozvMMoWGH9o6on@shell.armlinux.org.uk>
 <E1u3XG6-000EJg-V8@rmk-PC.armlinux.org.uk>
 <20250414174342.67fe4b1d@kernel.org>
 <Z_4s5DmCPKB8SUJv@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_4s5DmCPKB8SUJv@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 15, 2025 at 10:54:44AM +0100, Russell King (Oracle) wrote:
> On Mon, Apr 14, 2025 at 05:43:42PM -0700, Jakub Kicinski wrote:
> > IIUC this will case a link loss when XDP is installed, if not disregard
> > the reset of the email.
> 
> It will, because the author who added XDP support to stmmac decided it
> was easier to tear everything down and rebuild, which meant (presumably)
> that it was necessary to use netif_carrier_off() to stop the net layer
> queueing packets to the driver. I'm just guessing - I know nothing
> about XDP, and never knowingly used it.
> 
> > Any idea why it's necessary to mess with the link for XDP changes?
> 
> Depends what you mean by "link". If you're asking why it messes with
> netif_carrier_foo(), my best guess is as above. However, phylink
> drivers are not allowed to mess with the netif_carrier state (as the
> commit message states.) This is not a new requirement, it's always
> been this way with phylink, and this pre-dates the addition of XDP
> to this driver.
> 
> As long as the code requires the netif_carrier to be turned off, the
> only way to guarantee that in a phylink using driver is as per this
> patch.
> 
> I'm guessing that the reason it does this is because it completely
> takes down the MAC and tx/rx rings to reprogram everything from
> scratch, and thus any interference from a packet coming in to be
> transmitted is going to cause problems.

I'd like the "what do you mean by link" clarified before I update the
commit message.

If you're referring to the carrier state via netif_carrier_off() /
netif_carrier_on(), then nothing actually changes in that respect
because the carrier manipulation is being done by the driver today,
behind phylink's back. That changes to inside phylink with phylink's
knowledge.

It is my understanding that netif_carrier_off() / netif_carrier_on()
get notified to userspace, so this is visible today when XDP changes.

If you are referring to the messages that appear on the kernel console,
then yes, phylink will print those in addition, which actually makes
it more consistent with what's being reported to userspace.

Depending which you are referring to changes what I should say in the
commit message. E.g.

"We retain the changes to carrier state, which are already being
reported to userspace as link loss/link gain events, but we gain
kernel messages reporting the link state."

if you're referring to the carrier state. Or maybe:

"This change will have the side effect of printing link messages to
the kernel log, even though the physical link hasn't changed state.
This matches the carrier state."

if you're referring to the additional kernel messages.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

