Return-Path: <netdev+bounces-223412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57269B590D3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD7A17AC4B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3EE23313E;
	Tue, 16 Sep 2025 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ybEFblG3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F99257832
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011781; cv=none; b=Zri+ttwRdEDTsymbUnhLrOlKhnfGtC89JmDNjNuTcIDHUEK6a7mKLmCnKeeeZxY83S+UeFVLzRv58l7t8ZbGc99ZF6av4vubR1jMqtg9yJaIWuGXKP9roVDNg7VQgkdUAcAA0e75LKc+rnXH9qIcj8o0K+siu7Z5pecVNUzvZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011781; c=relaxed/simple;
	bh=PcOt1YdEe99dZ3ucLuERYzybH0NHjRcjoNDuDPAz48c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mj0zOZ0VoUCFvAcE7ks7OL0Vty3NToQBr8UVxH34oOz4dP3yWxB9l2gJY9gBU8aeBKAw8TOC9YQQCmsjmh9TloRtMWJp5oxLVUL/uLnv+08Sdw+RTiFMG7ww+PZrqjCscaeZQxu2XnvM0w3fUVWsD4J/NLIp0f76Fa8Y37vlQdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ybEFblG3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uXnecallvieHXm/544hME6OIqEiCVlVsI6JQmI/3x7M=; b=ybEFblG3bf3IqT7H+64YpsHWRM
	4XyL/v+pzd1EKxYcBNgC1WkRrStpOyZ4yZRhlHapjbSU6ARVj6krAmDSYJTx0ax1RZEtTBHxygT+4
	Xv6t0Pd83GTts/exxlAIDA4HtTOh1VCUhY20Qa/qkAvSLa/o3jWJZ2WxNK+MoCp/ZsmP219H58Nze
	BK88XrMQj2EcEeKiy1SN2KOcg8ZbMLnG7Ur6IElHIP3DIwUUYc/khAfR2TCVbCUpidxr0lopPsleW
	RBkZw19QYi4TKszizwW0hP94WwxS/0Ii9/wAxAXfNM/L/NOuS8B6yTS6ai5MKjZfTWMNZrFFeyGyW
	OUW5Y2Hg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35108)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyRAb-000000003n5-0Q6V;
	Tue, 16 Sep 2025 09:36:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyRAY-000000007Vr-1wwb;
	Tue, 16 Sep 2025 09:36:10 +0100
Date: Tue, 16 Sep 2025 09:36:10 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 5/5] net: dsa: mv88e6xxx: move
 mv88e6xxx_hwtstamp_work() prototype
Message-ID: <aMkhevTsmtsFtONe@shell.armlinux.org.uk>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
 <E1uy8uh-00000005cFT-40x8@rmk-PC.armlinux.org.uk>
 <20250916080903.24vbpv7hevhrzl4g@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916080903.24vbpv7hevhrzl4g@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 16, 2025 at 11:09:03AM +0300, Vladimir Oltean wrote:
> On Mon, Sep 15, 2025 at 02:06:35PM +0100, Russell King (Oracle) wrote:
> > Since mv88e6xxx_hwtstamp_work() is defined in hwtstamp.c, its
> > prototype should be in hwtstamp.h, so move it there.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> 
> This leaves the shim definition (for when CONFIG_NET_DSA_MV88E6XXX_PTP
> is not defined) in ptp.h. It creates an inconsistency and potential
> problem - the same header should provide all definitions of the same
> function.

The only caller of mv88e6xxx_hwtstamp_work() is from ptp.c, and both
hwtstamp.c which provides this function and ptp.c are only built if
CONFIG_NET_DSA_MV88E6XXX_PTP is set. So, this shim serves no useful
purpose.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

