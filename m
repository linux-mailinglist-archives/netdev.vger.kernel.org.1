Return-Path: <netdev+bounces-251952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBsQLMsLcWmPcQAAu9opvQ
	(envelope-from <netdev+bounces-251952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:24:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 215E35A79B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77AA7A8F186
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2810F481658;
	Wed, 21 Jan 2026 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="B4m8KS98"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0E481FD5;
	Wed, 21 Jan 2026 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008004; cv=none; b=DwKLH5LazEvnWQZO/ikaHeJR5f8MCRawB2sqPklIKJWHEi+6vtPrdE1dZOFQZ21tg/LzPUOunOm4dP7ZKDU5qfyVoG0TEnD2zu+AW8Ugt7xH5ov2WBtIGwCMu/pkFneHHwb1q70tgnhuhgXBRueEi9/Muigmfhg/iFwXZuL5Cy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008004; c=relaxed/simple;
	bh=M7MsxlC9KyWbVWfWNFtGsZtbTT6YKSLupmZ5MqLWBRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fbsu0fhM6pqyJqP3gLPVb21YkKW0PChggT1loj2yPPb+PdX0BkCR41UE3YAtjBrSmohvZiswvuzvcrNGIEF/RvDvCWTc96haJS7r2UPxXXgXxUQSGzT1o2FRlTYYGv80RvuJZaD3hcNP/iw+JhLENoOoQhe0hsAYBmeil1uxJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=B4m8KS98; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1r/Pf02A4GwFDRYb5SnMez8WFIQwQWouLfrLnnf0PtE=; b=B4m8KS98z1yuNxMGnh6La9sQUO
	IeWYFE9mKPYiEx7NLgVHnKPn1MPN9GMMX+3bArv8YUZPVslHCrB1P5+S7eYsDVyIcn3G8Km0uu85e
	q27QBUzvvf/dsUyzwwZKlQRU6cYyPg0Hu3tPxHq7t2FvBfmgtwvJX9+NBBS3uI0jtcHfJ6JZhIlIm
	rc1dWQVICJZ0HTqXAevl6fp40+9l5zZj528th4zgs+SzNapSeA6cnQxr87Wtu9Ioc+2cdMBN4koWn
	KjE+qrowUPTH8a+XxwMCd2HBS82pN4pOhGLvZ3LGSccGbrvxB93xyxlreqq/iDx0WbpzF9S3Zxbjx
	vg5rXbDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54494)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1viZn2-000000007f6-18Rw;
	Wed, 21 Jan 2026 15:06:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1viZn0-0000000006K-13K9;
	Wed, 21 Jan 2026 15:06:34 +0000
Date: Wed, 21 Jan 2026 15:06:34 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 1/2] net: phy: marvell: 88e1111: define
 gigabit features
Message-ID: <aXDreiHjK06lHY9h@shell.armlinux.org.uk>
References: <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
 <20260101-cisco-1g-sfp-phy-features-v2-1-47781d9e7747@solid-run.com>
 <aVe-SlqC0DfGS6O5@shell.armlinux.org.uk>
 <b8cafe50-c87b-4bd4-a47e-d11c11c16f7c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8cafe50-c87b-4bd4-a47e-d11c11c16f7c@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : No valid SPF,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[solid-run.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251952-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 215E35A79B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 10:27:52AM +0100, Maxime Chevallier wrote:
> Hi Russell, Josua,
> 
> On 02/01/2026 13:47, Russell King (Oracle) wrote:
> 
> > If the operational mode of the PHY is reconfigured at runtime, then I
> > think it would be reasonable to re-read the supported linkmodes.
> > However, I think this will cause issues for phylink, as currently it
> > wants to know the link modes that are supported so it can choose an
> > appropriate interface mode.
> 
> Russell, I agree that your patches for phydev->supported_interfaces
> are required, but I also think we need another piece of the puzzle to
> solve Josua's issue.

I haven't had the time to respond until now, sorry (it's been total
chaos over the last few days.)

> From what I get, it's impossible from the PHY driver's perspective only,
> to know which configuration the PHY is in, i.e. is it in :
> 
>  1000X to 1000T
>  SGMII to 1000T
>  SGMII to something else ?

Note that phydev->supported_interfaces is only about the host side
interface.

> This is one of the issues I was facing with the SGMII to 100FX adapters.
> 
> Selecting the right phy_interface, is one thing, but it doesn't address
> the fact that whe don't know which linkmodes to put in phydev->supported.
> 
> The approach I took to address that is in patch 3 of this series [1] :
> 
>  - The SFP's eeprom should ideally store information about the MDI of the
>   module, is it outputing fiber at 1G, at 100M, is it BaseT, etc.

While they do, it's the EEPROM is horrendously unreliable. I had hoped
that Fibrestore would do better, but sadly not - it's the same rubbish
I've come to expect from SFP vendors.

From my database, for copper RJ45 SFPs, the majority specify their
connector as LC. Then, the next is RJ45 (correct) and finally "unknown".

I don't have enough 100FX SFPs to base any data upon.

Cabled SFPs seem to do well, 100% of those I have are "Copper pigtail".

Fibre SFPs seem to all state LC as well.

xPON SFPs... are basically a total mess.

For the transceiver codes, it's even worse.

Cabled SFPs again do well, 100% indicate that they're some kind of
cable, but not all of them provide all the capabilities you'd expect.

Fibre SFPs... yea, random.

Copper RJ45 SFPs... can look like fibre, fibrechannel, but may also
state a copper based type.

xPON... total trainwreck, Some gives some kind of random fibre types,
some even give copper types. Some basically state they support every
transceiver type out there.

If you want to try and work out what the media side should be, then
I think we're basically going to end up needing our own database for
every transceiver out there... which leads us towards the model that
vendors use: only accepting transceivers we know about (which leads
to claims of "vendor lock-in" for this technology.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

