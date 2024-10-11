Return-Path: <netdev+bounces-134562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8274899A228
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 12:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F1C1F22C58
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE830212F10;
	Fri, 11 Oct 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rzvG6oW4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B420CCE8
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644299; cv=none; b=DwSuaTbQwTDgyeDkXRtmdVfjiDF6vmuTb15zAb1lyP0qRqMkhXBX04clYFkJnv4MxtrC4HHk2g/USaGP2xZsIpTR4l1PnXBUZ7eoQl7YBxw+T3oMi/LAm0ta4rwPrSi1hvhfo0ARf8LT9T24E4ImxqedtueiHdKGelQ2Rnlnmug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644299; c=relaxed/simple;
	bh=oOInqhhCGujD5uvTv9nECaqhkNmLSjaUdXO/ARoC1bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKx6pRcfWAFg+TwZfYkJu8kKNW45UVKptlQCNEJdIe3x2VqF8MpAqnsJ741tEUgA7W8aTcwSUp4ECf1EGoiki255B8HwZPI67nW66Dj6ZlWnO9h9ELG8qFO+BVXv0EPNawXlIcC0v7nIs1Qj80VQb29akXET6pv0N2Yfk9kVqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rzvG6oW4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gDiYj69kfEDencTdVODV9T3p189FgKXCjAgWcJolJbY=; b=rzvG6oW4C5rhVIhPIbX7w5pm/m
	73nw8tat/iTRVbhRC7arUiOnJe49kR0hdE7VnclbAgIo2sQieXCH27yRXo2dKup3iBaZ9fiNebN6h
	EGItPw/UhUYvjjXez89lklvOuDGDCLQXerITlOC8xl6EeF23abXwVqVF27hPIdu7rUEbL7Mt7iV6U
	25fJDIV+WEGqKAahQZGRuEFPWhiuN6h/zNexC26tSc0w2fSxyyT2GrT1PtaJb33vncm6TiTHfx5TE
	XaHmJLBTl7ndf8q/EuLvtzEYkyYj7TM1KWqZW2rZW0f4AK7dBNh/yMBXWuXsQgispN9eH/fnGw2JV
	eGImY7hw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37054)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1szDLW-0003tS-2R;
	Fri, 11 Oct 2024 11:58:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1szDLT-0008Ez-2J;
	Fri, 11 Oct 2024 11:58:07 +0100
Date: Fri, 11 Oct 2024 11:58:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: remove "using_mac_select_pcs"
Message-ID: <ZwkEv7rOlHqIqMIL@shell.armlinux.org.uk>
References: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
 <E1syBPE-006Unh-TL@rmk-PC.armlinux.org.uk>
 <20241009122938.qmrq6csapdghwry3@skbuf>
 <Zwe4x0yzPUj6bLV1@shell.armlinux.org.uk>
 <ZwfP8G+2BwNwlW75@shell.armlinux.org.uk>
 <20241011103912.wmzozfnj6psgqtax@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011103912.wmzozfnj6psgqtax@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 11, 2024 at 01:39:12PM +0300, Vladimir Oltean wrote:
> On Thu, Oct 10, 2024 at 02:00:32PM +0100, Russell King (Oracle) wrote:
> > On Thu, Oct 10, 2024 at 12:21:43PM +0100, Russell King (Oracle) wrote:
> > > Hmm. Looking at this again, we're getting into quite a mess because of
> > > one of your previous review comments from a number of years back.
> > > 
> > > You stated that you didn't see the need to support a transition from
> > > having-a-PCS to having-no-PCS. I don't have a link to that discussion.
> > > However, it is why we've ended up with phylink_major_config() having
> > > the extra complexity here, effectively preventing mac_select_pcs()
> > > from being able to remove a PCS that was previously added:
> > > 
> > > 		pcs_changed = pcs && pl->pcs != pcs;
> > > 
> > > because if mac_select_pcs() returns NULL, it was decided that any
> > > in-use PCS would not be removed. It seems (at least to me) to be a
> > > silly decision now.
> > > 
> > > However, if mac_select_pcs() in phylink_major_config() returns NULL,
> > > we don't do any validation of the PCS.
> > > 
> > > So this, today, before these patches, is already an inconsistent mess.
> > > 
> > > To fix this, I think:
> > > 
> > > 	struct phylink_pcs *pcs = NULL;
> > > ...
> > >         if (pl->mac_ops->mac_select_pcs) {
> > >                 pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
> > >                 if (IS_ERR(pcs))
> > >                         return PTR_ERR(pcs);
> > > 	}
> > > 
> > > 	if (!pcs)
> > > 		pcs = pl->pcs;
> > > 
> > > is needed to give consistent behaviour.
> > > 
> > > Alternatively, we could allow mac_select_pcs() to return NULL, which
> > > would then allow the PCS to be removed.
> > > 
> > > Let me know if you've changed your mind on what behaviour we should
> > > have, because this affects what I do to sort this out.
> > 
> > Here's a link to the original discussion from November 2021:
> > 
> > https://lore.kernel.org/all/E1mpSba-00BXp6-9e@rmk-PC.armlinux.org.uk/
> > 
> > Google uselessly refused to find it, so I searched my own mailboxes
> > to find the message ID.
> 
> Important note: I cannot find any discussion on any mailing list which
> fills the gap between me asking what is the real world applicability of
> mac_select_pcs() returning NULL after it has returned non-NULL, and the
> current phylink behavior, as described above by you. That behavior was
> first posted here:
> https://lore.kernel.org/netdev/Ybiue1TPCwsdHmV4@shell.armlinux.org.uk/
> in patches 1/7 and 2/7. I did not state that phylink should keep the old
> PCS around, and I do not take responsibility for that.

I wanted to add support for phylink_set_pcs() to remove the current
PCS and submitted a patch for it. You didn't see a use case and objected
to the patch, which wasn't merged. I've kept that behaviour ever since
on the grounds of your objection - as per the link that I posted.
This has been carried forward into the mac_select_pcs() implementation
where it explicitly does not allow a PCS to be removed. Pointing to
the introduction of mac_select_pcs() is later than your objection.

Let me restate it. As a *direct* result of your comments on patch 8/8
which starts here:
https://lore.kernel.org/netdev/E1mpSba-00BXp6-9e@rmk-PC.armlinux.org.uk/
I took your comments as meaning that you saw no reason why we should
allow a PCS to ever be removed. phylink_set_pcs() needed to be modified
to allow that to happen. Given your objection, that behaviour has been
carried forward by having explicit additional code to ensure that a
PCS can't be removed from phylink without replacing it with a different
PCS. In other words, mac_select_pcs() returning NULL when it has
previously returned a PCS does *nothing* to remove the previous PCS.

Maybe this was not your intention when reviewing patch 8/8, but that's
how your comments came over, and lead me to the conclusion that we
need to enforce that - and that is enforced by:

                pcs_changed = pcs && pl->pcs != pcs;

so pcs_change will always be false if pcs == NULL, thus preventing the
replacement of the pcs:

        if (pcs_changed) {
                phylink_pcs_disable(pl->pcs);

                if (pl->pcs)
                        pl->pcs->phylink = NULL;

                pcs->phylink = pl;

                pl->pcs = pcs;
        }

I wouldn't have coded it this way had you not objected to patch 8/8
which lead me to believe we should not allow a PCS to be removed.

Review comments do have implications for future patches... maybe it
wasn't want you intended, but this is a great example of cause and
(possibly unintended) effect.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

