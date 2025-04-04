Return-Path: <netdev+bounces-179242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 725A1A7B82D
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 09:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6006F3B8EE0
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC332186E40;
	Fri,  4 Apr 2025 07:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="crfDSJH3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE812B94
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 07:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743751025; cv=none; b=CPR68bfNkNU3FtEBEc4kgK+EmjR+toQrR/CW6mh23rDWDAOCg5v3i3o+cf7WFMOU7N7ogCA9EuCulNT9nIN+DEMLbhphKxFRiqdLiDLd28+/CyXvIKsPqtgPbcYO0PtgfJUtadF/bgniIEg4sF+VT3pBzCF8uLMggAeSN1ZgfFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743751025; c=relaxed/simple;
	bh=e+nFrXQ4lw9vEDh8RaNEuZytJKFGPcbHIjtOzzvVey0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QY3EwOi2W1gWE5OATe/MBl9zIZQ1s0h1R3ASmzdm5FJoxxjtUhTvm7D+ja/hIM72YREspJTpPw9s8HOldOAOG9lh7DTVCyLAcOcAnIdwnXsj9I4nCcHrzyBtgOCQvlhHJXIdkzB4LhFdBkGtUe6OqynfOhW9BBx6eHNZSXqGb50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=crfDSJH3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rZSmq0X+Xmz5AxH3GuVK8gl4HLsv8ywr4awRNCXiHKA=; b=crfDSJH3wJ4lrUTVGp/h71rilv
	2lq1OuIRBhPxcPd/WwXhkZy1XFZjgsd7Z1cmUvnSSnE8sE+nQ0WJb4d7abuJwqXwX7LFvdZLYHFl3
	Be96QZvboSGp/64WDguAoF2H/jqX2bs+py2FIul3xWslpFSGX0dwdN1IxnwxWhHlixs2mA20JhZ8G
	WY7xJsSnVKVM/ESSTKhvNgImJOhEdgqkT5KNC9zicn4YXMwYcG9w+FpVljPp4zRHksJUQ+8WmPj6v
	JRmspGKyjmcBdI/OB4ISMLBelwn2/IJ/9TW6ODdBsWtyjrV6ny1qqJcuwxD5+nHx317yiZMZwECL0
	3hmCGNsw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47776)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u0bIO-0001Pu-0q;
	Fri, 04 Apr 2025 08:16:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u0bIK-0005az-1n;
	Fri, 04 Apr 2025 08:16:52 +0100
Date: Fri, 4 Apr 2025 08:16:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <Z--HZCOqBvyQcmd9@shell.armlinux.org.uk>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
 <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
 <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8ZFzlAl1zys63e@shell.armlinux.org.uk>
 <8acfd058-5baf-4a34-9868-a698f877ea08@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8acfd058-5baf-4a34-9868-a698f877ea08@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 04, 2025 at 03:46:01AM +0200, Andrew Lunn wrote:
> On Fri, Apr 04, 2025 at 12:26:15AM +0100, Russell King (Oracle) wrote:
> > On Thu, Apr 03, 2025 at 02:53:22PM -0700, Alexander Duyck wrote:
> > > How is it not a fixed link? If anything it was going to be more fixed
> > > than what you described above.
> > 
> > I had to laugh at this. Really. I don't think you quite understand the
> > case that Andrew was referring to.
> > 
> > While he said MAC to MAC, he's not just referring to two MACs that
> > software can program to operate at any speed, thus achieving a link
> > without autoneg. He is also talking about cases where one end is
> > fixed e.g. by pinstrapping to a specific configuration including
> > speed, and using anything different on the host MAC side results in
> > no link.
> 
> Yep, this is pretty typical of SOHO switches, you use strapping to set
> the port, and it never changes, at least not without a soldering iron
> to take off/add resistors. There are also some SOHO switches which
> have a dedicated 'cpu port' and there is no configuration options at
> all. The CPU MAC must conform to what the switch MAC is doing.

From the sounds of it, Alexander seems to want to use fixed-link
differently - take parameters from firmware, build swnodes, and
set the MAC up for a fixed link with variable "media" type. So
it's not really fixed, but "do what the firmware says". I can't see
that being much different to other platforms which have firmware
that gives us the link parameters.

Presumably in Alexander's case, the firmware also gives link up/down
notifications as well, so it seems to me that this isn't really a
fixed link at all.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

