Return-Path: <netdev+bounces-261598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECQgGhS4oGnClwQAu9opvQ
	(envelope-from <netdev+bounces-261598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:16:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E742F1AF95E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 748FA306B58F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452E73A1E82;
	Thu, 26 Feb 2026 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dJcs1HMi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D59943D4FE;
	Thu, 26 Feb 2026 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140449; cv=none; b=NFPS0MWDkz1IL2xFh+yY9Khz/ObaV3J0GyESDefqMSGSUswJcHlCTTBn3DTlhZfiacEdGosoQ/5CVtfEDitc0YaV/Zhl3aiFUi4BgcaHCs+vW1mfptW8J5hz5oraFlC7XbvC4c2+z2fGd5pI8gvNEFuubCvud/YduwQKTzUvOsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140449; c=relaxed/simple;
	bh=VpkFxaJY0t2RaubYZ2lohNndwJRPBe0DTl1Pf0bYMqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RN8NRggBAfuHQpDgeV3zJqVYqSLHcaeYgM3cB2YeB2nYT5toAmR0bBXpg9xzKF+UGBGvWEXBO4EU6cGmugi7Pm+jxdxSByyCYNyYgWafekKcKgL9k3q+uBdlsoMgukW5rOvj3O5CtbssNety/VW9qlg+NzNTu3cSpZA3Mxy3Kvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dJcs1HMi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zrdzkyND9JB1vrZ6ianE9uiQBRzSoKHBkoKh/JiEzvc=; b=dJcs1HMinilNt929oLVlujGS+a
	cm7Nb6BAJWRh7IqcELoTI0MbcDpkN0N673COwjaiOkGuKLJi2jDd14mZcoGHqNoI9zTj4zb8Y6UYg
	j64Zpc6R2lNDtrGhYdsMxOZ9WF7EalWCxDLYjocn6DHXP6BtwaTKnsVoAFlMCxVXs/2w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvigF-008wuX-TE; Thu, 26 Feb 2026 22:13:55 +0100
Date: Thu, 26 Feb 2026 22:13:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH net-next v3 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
Message-ID: <a190ac2a-351b-4588-9514-4d822f7a2925@lunn.ch>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
 <20251023-macb-eyeq5-v3-5-af509422c204@bootlin.com>
 <20260226-folic-excitable-82eff83a125a@spud>
 <aaCd_zV5kY-s1RBL@shell.armlinux.org.uk>
 <20260226-perennial-sanctity-25c6adae5ec0@spud>
 <aaCwxeMHMSCHk0nx@shell.armlinux.org.uk>
 <20260226-marry-blend-0a63d3572d76@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-marry-blend-0a63d3572d76@spud>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261598-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: E742F1AF95E
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:05:28PM +0000, Conor Dooley wrote:
> On Thu, Feb 26, 2026 at 08:44:53PM +0000, Russell King (Oracle) wrote:
> 
> > Ethernet PHYs are described in Ethernet controller DT using the
> > "phy-handle" property (and previously "phy" or "phy-device"
> > 
> > Generic PHYs are described using the "phys" property.
> 
> Ahh, this was key and I think I understand the analysis now.
> Thanks for explaining Russell.

There is history here.

In Linux, PHY has meant Ethernet PHY for a few decades. But then
SERDES came along which has a completely different sort of PHY as
well. So things like PCIe, USB, SATA, and MAC chips using speeds >
1Gbps all can make use of Generic PHYs for their SERDES.

So you need to be careful with wording, are we talking about PHYs or
Generic PHYs.

	Andrew

