Return-Path: <netdev+bounces-134641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF4399AAAF
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CBA28291E
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4463198A21;
	Fri, 11 Oct 2024 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="h0l9dorG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110E7F9
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669125; cv=none; b=NoNfh2kJwTTX3GqFEQbIbcFGsVxlh6jxZ/GY6h3+aSn2/QyRARW+2XweIdrnxvn/M5uTiozo68Yt7mVW1lut4uDn0nyHD5Y2pQhDZgJq39ICUBR+UGwvY4UW0emSjsqVI8ntQGIcop2m2OFvoDFatKHvBzSRvozIxTlHmwexSWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669125; c=relaxed/simple;
	bh=idM4hrGSTsj4oIYGhEgfOTEC1ZMGD/lfhoLjGccxfRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLRhS8GaItUospGCtZtw+nHwkBvtg1ST9kxo0pu1ooCTbvvG/TY4ouvxkxm5yl/+zO2Ke4Ia6bl1OWiHqVaa2azyvzO7TSsu0X8BGJrQUQiAnwmiyHX7vx6y2ujF+2A82zZcUuj1vPvnR7gN3CFYFweEyQayzLddB5MQScHQO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=h0l9dorG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r+ITUsJivpSGYOdsCk30KxYLyfp6+2k+qYwVp0mv3Og=; b=h0l9dorGc8F6zZSf4gIeafEArv
	4frTIeuOc0Kgqxk1LmWuWpbN1pr97yAglrW6dg7N+gu2GutT3ecnGA75D64HCwpI9+GwaSzQk92GO
	SSzyYebhVc2vCpUDE49cqLAylu/yscSW8d6yaWnZkNmU/tXGPIOChmb5xIb6B7nHx4XlEnrRKncK9
	fmhQ8ArLZyGB+DvgQqL0PYUezfxP/P2Lh8P3qkQZaw5QHoeG6JFyNVU5DjEJ+jL4C8nTXIhEwdSAe
	DMwLfQFZlpCVKoSb7P7c5zidhDlqSIjk33SKAOOsOf5CYXiycQoMs7g3qoEJre8o7KGGEu90UThD8
	MAErvIag==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34370)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1szJnv-0004OH-0v;
	Fri, 11 Oct 2024 18:51:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1szJnr-0008T3-1v;
	Fri, 11 Oct 2024 18:51:51 +0100
Date: Fri, 11 Oct 2024 18:51:51 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: remove "using_mac_select_pcs"
Message-ID: <Zwllt43iS5EDvjHN@shell.armlinux.org.uk>
References: <20241011103912.wmzozfnj6psgqtax@skbuf>
 <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
 <E1syBPE-006Unh-TL@rmk-PC.armlinux.org.uk>
 <20241009122938.qmrq6csapdghwry3@skbuf>
 <Zwe4x0yzPUj6bLV1@shell.armlinux.org.uk>
 <ZwfP8G+2BwNwlW75@shell.armlinux.org.uk>
 <20241011103912.wmzozfnj6psgqtax@skbuf>
 <ZwkEv7rOlHqIqMIL@shell.armlinux.org.uk>
 <ZwkEv7rOlHqIqMIL@shell.armlinux.org.uk>
 <20241011125421.eflqwvpnkrt4pdxh@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011125421.eflqwvpnkrt4pdxh@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 11, 2024 at 03:54:21PM +0300, Vladimir Oltean wrote:
> On Fri, Oct 11, 2024 at 11:58:07AM +0100, Russell King (Oracle) wrote:
> > On Fri, Oct 11, 2024 at 01:39:12PM +0300, Vladimir Oltean wrote:
> > > On Thu, Oct 10, 2024 at 02:00:32PM +0100, Russell King (Oracle) wrote:
> > > > On Thu, Oct 10, 2024 at 12:21:43PM +0100, Russell King (Oracle) wrote:
> > > > > Hmm. Looking at this again, we're getting into quite a mess because of
> > > > > one of your previous review comments from a number of years back.
> > > > > 
> > > > > You stated that you didn't see the need to support a transition from
> > > > > having-a-PCS to having-no-PCS. I don't have a link to that discussion.
> > > > > However, it is why we've ended up with phylink_major_config() having
> > > > > the extra complexity here, effectively preventing mac_select_pcs()
> > > > > from being able to remove a PCS that was previously added:
> > > > > 
> > > > > 		pcs_changed = pcs && pl->pcs != pcs;
> > > > > 
> > > > > because if mac_select_pcs() returns NULL, it was decided that any
> > > > > in-use PCS would not be removed. It seems (at least to me) to be a
> > > > > silly decision now.
> > > > > 
> > > > > However, if mac_select_pcs() in phylink_major_config() returns NULL,
> > > > > we don't do any validation of the PCS.
> > > > > 
> > > > > So this, today, before these patches, is already an inconsistent mess.
> > > > > 
> > > > > To fix this, I think:
> > > > > 
> > > > > 	struct phylink_pcs *pcs = NULL;
> > > > > ...
> > > > >         if (pl->mac_ops->mac_select_pcs) {
> > > > >                 pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
> > > > >                 if (IS_ERR(pcs))
> > > > >                         return PTR_ERR(pcs);
> > > > > 	}
> > > > > 
> > > > > 	if (!pcs)
> > > > > 		pcs = pl->pcs;
> > > > > 
> > > > > is needed to give consistent behaviour.
> > > > > 
> > > > > Alternatively, we could allow mac_select_pcs() to return NULL, which
> > > > > would then allow the PCS to be removed.
> > > > > 
> > > > > Let me know if you've changed your mind on what behaviour we should
> > > > > have, because this affects what I do to sort this out.
> > > > 
> > > > Here's a link to the original discussion from November 2021:
> > > > 
> > > > https://lore.kernel.org/all/E1mpSba-00BXp6-9e@rmk-PC.armlinux.org.uk/
> > > > 
> > > > Google uselessly refused to find it, so I searched my own mailboxes
> > > > to find the message ID.
> > > 
> > > Important note: I cannot find any discussion on any mailing list which
> > > fills the gap between me asking what is the real world applicability of
> > > mac_select_pcs() returning NULL after it has returned non-NULL, and the
> > > current phylink behavior, as described above by you. That behavior was
> > > first posted here:
> > > https://lore.kernel.org/netdev/Ybiue1TPCwsdHmV4@shell.armlinux.org.uk/
> > > in patches 1/7 and 2/7. I did not state that phylink should keep the old
> > > PCS around, and I do not take responsibility for that.
> > 
> > I wanted to add support for phylink_set_pcs() to remove the current
> > PCS and submitted a patch for it. You didn't see a use case and objected
> > to the patch, which wasn't merged.
> 
> It was an RFC, it wasn't a candidate for merging anyway.

What does that have to do with it????????????

An idea is put forward (the idea of allowing PCS to be removed.) It's
put forward as a RFC. It gets shot down. Author then goes away believing
that there is no desire to allow PCS to be removed. That idea gets
carried forward into future patches.

_That_ is what exactly happened. I'm not attributing blame for it,
merely explaining how we got to where we are with this, and how we've
ended up in the mess we have with PCS able to be used outside of its
validated set.

You want me to provide more explanation on the patch, but I've
identified a fundamental error here caused as an effect of a previous
review comment.

I'm now wondering what to do about it and how to solve this in a way
that won't cause us to go around another long confrontational discussion
but it seems that's not possible.

So, do I ignore your review comments and just do what I think is the
right thing, or do I attempt to discuss it with you? I think, given
_this_ debacle, I ignore you. I would much rather involve you but it
seems that's a mistake.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

