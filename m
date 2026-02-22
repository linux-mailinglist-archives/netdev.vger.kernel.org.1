Return-Path: <netdev+bounces-259878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nT39GtEdm2kKtAMAu9opvQ
	(envelope-from <netdev+bounces-259878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 16:16:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B36B316F7E0
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 16:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B1FF30038E2
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4535E13D51C;
	Sun, 22 Feb 2026 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gpANW711"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0FDA92E;
	Sun, 22 Feb 2026 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771773388; cv=none; b=WWOKtSUqLHfd1OntJVuZZwb+K+4qUgBZnaM+sccb00s1j5VLhK1bGIVWEmcZrhA3DL5HfjuUQ+n8lb1gV4JUd7ulKSNQLePelo8t48TxEvx+Ji0uxwnk5scTMxyzkbPKVP846tJAFt3A5zUjIueQrgPfMHsf3bfcup+xamO7dCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771773388; c=relaxed/simple;
	bh=31DzUZyRDV9G3POPnz3XyokVQpflAdevGzfkq+t5PqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYsXXcyrlBGByxHfecNmUPsFRnFzeAxK7MHIS+4daJ3jnTHRHUSks/MTiWbaZpm9aTBdHaP3VK7Y17UA4NDAXpRgX6dCT4rBfz5gagJBOxSqt9PObi3N4fOUNBqU3AVH6a7xXMzTq4AB57kXFIR0eleCfJs+9m1wMoehAoKCFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gpANW711; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=BzGX6MaTDV6GiONbDY7em3BeiLqQVhTVEDeNgzbNog4=; b=gp
	ANW711pO9W1AZEM5fN4y13hnXtVvK4/s55L+7M1oIRMFeuMAYovdBt+HGEJDfjbWL8IQ7ypNMR4UN
	am6HLVOnXLFNlfBVV2j15LRfjxnvVkl8NXznUSpwW3PuWD+qVQToSRp9eYgskLNoRpLZTjb47daRO
	Oa73yOY1Y35y18E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vuBBf-008IgM-QM; Sun, 22 Feb 2026 16:15:59 +0100
Date: Sun, 22 Feb 2026 16:15:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub =?utf-8?B?VmFuxJtr?= <linuxtardis@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sai Krishna <saikrishnag@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: phy: motorcomm: yt8821: disable MDIO
 broadcast address 0
Message-ID: <557033a0-e5c8-4384-8f40-21f37c2e7dc1@lunn.ch>
References: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
 <0308e736-c3e7-45d2-86f7-e729af9cb487@gmail.com>
 <3e64d8d1-87c1-45e0-9556-0ca844a90f73@lunn.ch>
 <740e8351-d8a5-4f4c-91e4-c278e4b7d248@gmail.com>
 <aZq-SbHC0eU9OenG@shell.armlinux.org.uk>
 <6d248bec-cb87-4238-9ccc-e901926e3226@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d248bec-cb87-4238-9ccc-e901926e3226@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259878-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[armlinux.org.uk,makrotopia.org,gmail.com,mediatek.com,motor-comm.com,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B36B316F7E0
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 10:52:28AM +0100, Jakub Vaněk wrote:
> On 2/22/26 09:28, Russell King (Oracle) wrote:
> > On Sun, Feb 22, 2026 at 05:22:55AM +0100, Jakub Vaněk wrote:
> >> I had hoped this would not happen on the Cudy router. The MediaTek
> >> Ethernet subsystem driver uses of_mdiobus_register(), so PHY address 0
> >> should not be probed unless it is explicitly described in the device
> >> tree. That said, I agree that with mdiobus_register() this would still
> >> be an issue.
> >>
> >> I was also hoping that moving the internal PHY would provide more
> >> flexibility in the device tree description of the YT8821. If the
> >> workaround were implemented in U-Boot by writing YT8821 MDIO registers
> >> at boot time, Linux would not be able to assert the YT8821 reset pin
> >> without losing that workaround.
> > 
> > Why would you want to assert the reset pin?
> > 
> 
> I don't currently have a solid reason to assert the reset pin.
> The two reasons I had in mind were mostly precautionary:

Being able to drive a PHY reset pin in Linux is relatively new. It was
added in 2016. Before that, we lived without this feature. If
anything, being able to reset the PHY causes more issues than it
solves.

So unless the PHY is actually broken and needs a reset to make it
work, it is probably better not to list the reset.

       Andrew

