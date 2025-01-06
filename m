Return-Path: <netdev+bounces-155368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9F0A02089
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23AB116211C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F17135942;
	Mon,  6 Jan 2025 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gvf7vOiQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5114A04
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151669; cv=none; b=Q6pW7anqbbDvlVyFbeAfgabwFqvBDrFJtthCPVml4VkuxgybaJaxaLysnL2sAYMFxWNtrThFnp6mu5RTwXVSyxV0V8diWbpr5Kvf9NNDB+08QVO5eS80HTItWKsW10D7IOHJmbarCbnN4H46S+nPl4zcGqW2uxrJRp6SsdT1IVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151669; c=relaxed/simple;
	bh=OSwSxa9R6S3DjyCyilBUO6+b7dq8tgvdND1xIZWBG0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHICBk7CV472JDcWvBsdb7IgaGgrLJpDA+ItF0uc4poYLAGRf42pzK6AA7jPkQu9xKci9vkU+GEBIqzdJCj+wEv2n2XKGbwjSPBD/dKK5dd7stzDxU//YiI89gPH06cizXVCudirp0a+KlYIcunokZ5tAlCNjTXwpduwrEzffs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gvf7vOiQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qOmXDzyTaMxazL0LDKrl4EGxFFFgph+mRVLzgb1OGYw=; b=gvf7vOiQ9lnv2sNz63xRpjQwRj
	PhdACP9CoFiCbHmKVx68uFLnR25ClhyYqHLT38t2ejIGsszwBelrWuduNyKiaBZrhk8xo+umr9pCS
	q1RERMQUXlcQUaPAJoYfX1ZwK0g1a3JNMAyhCatLJwZgE2kwZ3QkLofmj1D8e0C780wI3eVjHwc4m
	3dnmwNMvM343byztON7Xok5ztcbm9RBH71SGQULa8c0hRdUnGZG92uSi1dLnrNGTUgm9YxKxo4tAj
	oDS6gTKapf6DKjr9Hu8+TvJ94Rb7RecyQPDwVwi9SdsHNPEmw8fQg8Aw6Y4p49DyrTk9A8an/8ner
	5U3recSQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43560)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tUiLz-0005VT-19;
	Mon, 06 Jan 2025 08:20:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tUiLs-00047w-2g;
	Mon, 06 Jan 2025 08:20:44 +0000
Date: Mon, 6 Jan 2025 08:20:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com,
	marek.behun@nic.cz
Subject: Re: [PATCH v2 net 3/4] net: dsa: mv88e6xxx: Never force link on
 in-band managed MACs
Message-ID: <Z3uSXFH9bryiuVqX@shell.armlinux.org.uk>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-4-tobias@waldekranz.com>
 <Z3ZrH9yqtvu2-W7f@shell.armlinux.org.uk>
 <87zfk974br.fsf@waldekranz.com>
 <Z3bIF7xaXrje79D8@shell.armlinux.org.uk>
 <87pll26z2b.fsf@waldekranz.com>
 <Z3mxsEziH_ylpCD_@shell.armlinux.org.uk>
 <87msg66uh4.fsf@waldekranz.com>
 <Z3ph3P9AFankiZxW@shell.armlinux.org.uk>
 <87h66c7sa6.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h66c7sa6.fsf@waldekranz.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:30:25AM +0100, Tobias Waldekranz wrote:
> On sön, jan 05, 2025 at 10:41, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > On Sun, Jan 05, 2025 at 12:16:07AM +0100, Tobias Waldekranz wrote:
> >> On lör, jan 04, 2025 at 22:09, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >> > Host system:
> >> >
> >> >   ---------------------------+
> >> >     NIC (or DSA switch port) |
> >> >      +-------+    +-------+  |
> >> >      |       |    |       |  |
> >> >      |  MAC  <---->  PCS  <-----------------------> PHY, SFP or media
> >> >      |       |    |       |  |     ^
> >> >      +-------+    +-------+  |     |
> >> >                              |   phy interface type
> >> >   ---------------------------+   also in-band signalling
> >> >                                  which managed = "in-band-status"
> >> > 				 applies to
> >> 
> >> This part is 100% clear
> >
> > Apparently it isn't, because...
> >
> >> In other words, my question is:
> >> 
> >> For a NIC driver to properly support the `managed` property, how should
> >> the setup and/or runtime behavior of the hardware and/or the driver
> >> differ with the two following configs?
> >> 
> >>     &eth0 {
> >>         phy-connection-type = "sgmii";
> >>         managed = "auto";
> >>     };
> >> 
> >> vs.
> >> 
> >>     &eth0 {
> >>         phy-connection-type = "sgmii";
> >>         managed = "in-band-status";
> >>     };
> >
> > if it were, you wouldn't be asking this question.
> >
> > Once again. The "managed" property defines whether in-band signalling
> > is used over the "phy-connection-type" link, which for SGMII will be
> > between the PCS and PHY, as shown in my diagram above that you claim
> > to understand 100%, but by the fact you are again asking this question,
> > you do not understand it AT ALL.
> >
> > I don't know how to better explain it to you, because I think I've been
> > absolutely clear at every stage what the "managed" property describes.
> > I now have nothing further to add if you still can't understand it, so,
> > sorry, I'm giving up answering your emails on this topic, because it's
> > just too frustrating to me to continue if you still don't "get it".
> 
> I agree that you have clearly explained what it describes, many times.
> 
> My remaining question - which you acknowledge that I asked twice, yet
> chose not to answer - was how software is supposed to _act_ on that

I *have* answered it. Every time.

> description; presuming that the property is not in the DT merely for
> documentation purposes.

Utter claptap. Total rubbish. Completely wrong. It is acted on. It
causes phylink to enter in-band mode, and use the PCS to obtain the
in-band data instead of the PHY.

YOU are the one refusing to listen to what I'm saying, yet you claim
my explanations are clear and you understand them. You parently do
not.

End. Of. Discussion.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

