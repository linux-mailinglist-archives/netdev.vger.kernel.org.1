Return-Path: <netdev+bounces-159625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20E0A16284
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 16:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C651885C9D
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 15:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4091DF27E;
	Sun, 19 Jan 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pbECHzt3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B14315F;
	Sun, 19 Jan 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737299631; cv=none; b=fiqpI8EqszmEGX7vp0o3seeD9L0R9cDvE7OyhT0GXhtMLc3N3tpmIgEsBYu2daAj1Qdj0oYUXExLerpJ6Y+ohxuvSWYpIOIUaNbCzX/OoNuep8IsUa49ZTqE/N8gOaJcyJS/c6pZOIyGQQQ+A5BALRJ6vRPp2Eog9yT1jrWLTpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737299631; c=relaxed/simple;
	bh=+BEF0bV2AYeoxChZxg0X7HNCIbeCM8dZSM0yxLDsPc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aG14v2dgyRWW23WAmeBZrkZ5P+nBaOWijV5J64V0f+FtN9J2277a1qhKaqCUXSL1oU71or/mTXhPXgYQeRqGCHNHTIkPGCRM9yNqwdc8adjCkT12AD3cXhNUJXYUie+PXhN3HnC/DMzIRgHQ1owN+13Ta8n4StJSKjUfn+E81qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pbECHzt3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+BKApviZbKOtFG0ErRA2dV5y3fesSYbnNbVtybZaCtU=; b=pbECHzt3CWWowzwNxNLHPHRLqG
	0A3VY0/MxcS8EmxS7lO3wqSIAKucmP87CDuP8pos4U/1KN/4tClv4YrDUjQl2UhYsTnZ3AiKAyhtg
	LqbHGhMPUXClOqKAmyDN6TJlCago8EJOs+GAVq9S1+C88HEft9Xew0TG3mnJUwpTMCqO3x2oO8Qf4
	wODyDaRbAh1ATDOM47YVjVxMpxFcW93N5hV/FYHZmcdw3NzeSYJXUEeu/I8Dsr4iEYy7fq4jmX6os
	QA7LXPQcpIY9+aisNHz3XKlnJuNM+NdeQRAS5zaQeKVjw/lTvKxeWY289B2rLHBOd60ev3eJyMtpS
	xprBzxIA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45824)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tZWzZ-0005Kg-20;
	Sun, 19 Jan 2025 15:13:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tZWzV-0001xB-2z;
	Sun, 19 Jan 2025 15:13:33 +0000
Date: Sun, 19 Jan 2025 15:13:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Oleksandr Makarov [GL]" <Oleksandr.Makarov@qsc.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: BUG: UDP Packet Corruption Issue with stmmac Driver on Linux
 5.15.21-rt30
Message-ID: <Z40WnTc09OOnCZ3p@shell.armlinux.org.uk>
References: <BLAPR16MB392407EDC7DFA3089CC42E3CF0BE2@BLAPR16MB3924.namprd16.prod.outlook.com>
 <CANn89iL_p_pQaS=yjA2yZd2_o4Xp0U=J-ww4Ztp0V3DY=AufcA@mail.gmail.com>
 <BLAPR16MB392430582E67F952C115314CF0BE2@BLAPR16MB3924.namprd16.prod.outlook.com>
 <BLAPR16MB3924BB32CE2982432BAE103FF0622@BLAPR16MB3924.namprd16.prod.outlook.com>
 <BLAPR16MB3924E3DF8703DDCBC1C033BBF0E42@BLAPR16MB3924.namprd16.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLAPR16MB3924E3DF8703DDCBC1C033BBF0E42@BLAPR16MB3924.namprd16.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jan 19, 2025 at 12:46:54PM +0000, Oleksandr Makarov [GL] wrote:
> I bisected kernel from 6.12, where the issue with trimming fragmented UDP packets was fixed, down to 5.15.21.
> 
> I have identified that commit  "47f753c1108e287edb3e27fad8a7511a9d55578e net: stmmac: disable Split Header (SPH) for Intel platforms" is fixing the problem.

It sounds like you're saying that it's been fixed on mainline, but the
fix hasn't been backported to 5.15.21. Well, it won't ever be. 5.15.21
is one instance of the 5.15-stable kernel tree, and the 5.15-stable
tree is now at 5.15.176.

Try moving your stable kernel forward. If you're locked in to 5.15.21
by an upstream vendor, then you need to complain to them.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

