Return-Path: <netdev+bounces-213048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCCEB22EBD
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD13F7B08BD
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059632FD1B9;
	Tue, 12 Aug 2025 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zFvKESyF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F183E2FD1B5;
	Tue, 12 Aug 2025 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018913; cv=none; b=gPc+jOxPnNBxkaumLmNnosACxLM43ZM+RUn3J5n9bPtOpIVeiw/3YkwGDuTdMoBU0Hrjm/ffa5pBg/aZ1dnJl84kBaqr20omkKfyVrChr2oFSaMNOAA5W5aDbtJUA+DksTsszP4oFF4yrBB0RuoVO+nL1ytQdvRUGVe7Xbtl1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018913; c=relaxed/simple;
	bh=Tn+szjLDEVs+ARDfjdt/1JWaqTu7KCFXHjuPHK/cPwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea+5bPWFRfri862NZL/0FcTa/3fDFX/Lyi/knYWT/hy5xUObut85h9fc5ZlE6B11eQQTg59PSQ3vupyWBFEhlivHWEv5IrITX49niJjupcO1BvvFq0k9dzN62LNEVsGBXfquB19rK/nAmDinmQp+u49prvPpS0E2+gYEd7MRD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zFvKESyF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3sy9nbHbSFuSKLtuj4CqYwEENzw1jXXuBa8rw2XGnpE=; b=zFvKESyFu72IJY40eLO2llnMlJ
	sz2SOwS+DyLJdwv0auRs0R9NUjFE/fJSG/i8mfwVXCP3/JmmkQi/ULfeC0P/T3aCJbzoKSzGXivd+
	gqlSFdubttpJ0wNZwzaxC/iO4DdxzXwGVEXzVDUjK80F6PxmNR+pUi6kAbaSnrfvxbp7IEXzIoqnO
	jNdThJMhvSL+UhyKT3uLqrK0YuoVbL3eCO+oTUiCd2z6SfJQl5DGZGdHIFAFjmuJ5HpQ0x4BteNqd
	LaqXzzMSJ8xYffJun4GSvTpD5j76DdfqYB1pgeUriUUde1esnvXqMk1QWXNUpifzqvyuo8D4HcKIr
	zpUQHZPg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42238)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ulsaa-0005Jf-2p;
	Tue, 12 Aug 2025 18:15:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ulsaY-0004sy-2H;
	Tue, 12 Aug 2025 18:15:06 +0100
Date: Tue, 12 Aug 2025 18:15:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev-driver-reviewers@vger.kernel.org, netdev@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [ANN] netdev call - Aug 12th
Message-ID: <aJt2mg4vxRHSvDTi@shell.armlinux.org.uk>
References: <20250812075510.3eacb700@kernel.org>
 <aJtvp27gAVz-QSuq@shell.armlinux.org.uk>
 <aJtycOgN-QL7ffUC@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJtycOgN-QL7ffUC@pidgin.makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Aug 12, 2025 at 05:57:20PM +0100, Daniel Golle wrote:
> On Tue, Aug 12, 2025 at 05:45:27PM +0100, Russell King (Oracle) wrote:
> > On Tue, Aug 12, 2025 at 07:55:10AM -0700, Jakub Kicinski wrote:
> > > Hi!
> > > 
> > > The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> > > 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> > > 
> > > Sorry for the late announcement, I got out of the habit of sending
> > > these. Luckily Daniel pinged.
> > 
> > Only just seen this. Apparently, this is 4:30pm UK time, which was over
> > an hour ago.
> 
> I was also confused by the date in the subject (August 12th) and the mail
> body saying "tomorrow" which is the 13th...
> So tomorrow (13th of August) it is?

Hmm, if it's tomorrow, I can only spare the first 30 minutes up to 5pm
BST.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

