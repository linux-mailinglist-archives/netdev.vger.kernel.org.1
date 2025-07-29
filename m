Return-Path: <netdev+bounces-210846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6D2B15168
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B113E18A1C6D
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4B4226CEB;
	Tue, 29 Jul 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Yn7TvtWA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B3226D0D
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806927; cv=none; b=iQe71OHjjJMhYPYs+nNiVAYnQ+IdcX7M4M5wEPpA7YjJcJBBqIQQxWNz2HvUs7ljy8AXHWSVwXm1dOmXExn96BVbjDFkq1yk3oVaszrM2le2DL6Lhc1Cqb64SDaCHccm6MBoNF0G6jmLcue4GFs2yeZwdTxUSl6iYUajnzCHN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806927; c=relaxed/simple;
	bh=qNv0DsvTNtk7+6bO1rUWcjPZ9X6JHGjEDfvIzo71uOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF3xlUBzX5cdgmK1nfNLZhbTDq0Tbqlg9l7oBc45/+VP1cFBzSgfiTeeimob8wITjJadASY5SM48FaE/xXyQ4/j87sOwtILpykJfoGl5qpZjJC98likT1PSN01O/vS34K/3bx938w7gmYQPEMkl9XKAOer8yt9JSdka1fUrSKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Yn7TvtWA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LUnLUSkkHQ0KtmeifxLqpV19mfTPS/23h/uc9Q4JzE4=; b=Yn7TvtWASbRMJEShmmX8wbGU29
	w8cc/jSobrXubE6LcPAHIPHD9MOcuyRGTOgzRIWmlbJiaK63XqQRuZHIMOiNnaCdff5y/+k2l4ENc
	ThplDkSAXq+0F0v8DHWd13z4lrPwaS38uBIDYnZnukOfuGD/GC+ttx64ddeXSfrZLVip9jFeMxQl1
	LC4Tmzk3E8g9Jz/o8dsvL8yB12YZQ3oyzzBYzJSTZuvJQHdYvS5hpYksPkktYsH+k3ybGhKIJvt+j
	4Zyrft+4Mb2JQD1RJXAFDNJWFDLUMEOLhETH10NCigvvjMY0dlP8BQlup4QnZDRuftMd+TcTdBcmn
	P4ZJ9Shg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37072)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ugnIN-0002Cl-1t;
	Tue, 29 Jul 2025 17:35:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ugnIJ-0007YC-2w;
	Tue, 29 Jul 2025 17:35:15 +0100
Date: Tue, 29 Jul 2025 17:35:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Linux-stm32] [PATCH RFC net-next 6/7] net: stmmac: add helpers
 to indicate WoL enable status
Message-ID: <aIj4Q6WzEQkcGYVQ@shell.armlinux.org.uk>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ33-006KDR-Nj@rmk-PC.armlinux.org.uk>
 <eaef1b1b-5366-430c-97dd-cf3b40399ac7@lunn.ch>
 <aIe5SqLITb2cfFQw@shell.armlinux.org.uk>
 <77229e46-6466-4cd4-9b3b-d76aadbe167c@foss.st.com>
 <aIiOWh7tBjlsdZgs@shell.armlinux.org.uk>
 <aIjCg_sjTOge9vd4@shell.armlinux.org.uk>
 <d300d546-09fa-4b37-b8e0-349daa0cc108@foss.st.com>
 <aIjePMWG6pEBvna6@shell.armlinux.org.uk>
 <186a2265-8ca8-4b75-b4a2-a81d21ca42eb@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <186a2265-8ca8-4b75-b4a2-a81d21ca42eb@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 29, 2025 at 05:34:49PM +0200, Gatien CHEVALLIER wrote:
> For STMMAC:
> I'm a bit lost there. I may be missing something. I thought that using
> PHY WoL (therefore having STMMAC_FLAG_USE_PHY_WOL) superseded the MAC
> WoL usage.

I'll simply point you to Andrew's message:

https://lore.kernel.org/r/5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch

The PHY and the MAC are supposed to inter-operate so that one ends
up with the union of the WoL capabilities.

stmmac gets this wrong right now, but (as I've written previously)
this is going to be a *very* difficult problem to solve, because
the PHY drivers are - to put it bluntly - "utter crap" when it
comes to WoL.

I'll take the rtl8211f again as an example - its get_wol()
implementation is quite typical of many PHY drivers. Someone comes
along and decides to implement WoL support at the PHY. They add the
.get_wol() method, which unconditionally returns the PHY's hardware
capabilities without regards for the rest of the system.

Consider the case where a PHY supports WoL, but the signalling for
WoL to wake up the system is not wired. The .get_wol() method happily
says that WoL is supported. Let's say that the PHY supports magic
packet, and so does the MAC, and the MAC WoL is functional.

Now, with what Andrew said in his email, and consider what this means.
.set_wol() is called, requesting magic packet. The PHY driver says "oh
yes, the PHY hardware supports this, I'll program the PHY and return
zero". At this point, the MAC thinks the PHY has accepted the WoL
configuration.

The user suspends the system. The user sends the correct magic
packet. The system does not wake up. The user is now confused.

However, if the PHY driver were to behave correctly according to what
Andrew says, and not allow WoL if it can't wake the system, then
instead we would program the MAC to allow magic packet, and the user
would be happy because their system would wake up as expected.

This is why we can't simply "fix" stmmac - not without all the PHY
drivers that are being used with stmmac behaving properly. Can it
ever be fixed to work as Andrew suggests? I really don't know. I
suspect not, because that will probably involve regressing a lot of
setups that work today (fixing the PHY drivers will likely cause
user visible regressions.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

