Return-Path: <netdev+bounces-307755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lJqAIqOHV2p5WQAAu9opvQ
	(envelope-from <netdev+bounces-307755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:14:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E8075E88C
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:14:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=Kp1qTzth;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307755-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307755-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F19C03052479
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44417420492;
	Wed, 15 Jul 2026 13:09:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E131420479;
	Wed, 15 Jul 2026 13:09:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120982; cv=none; b=m93gFyMrnJpL2j6waG0qYoe+2sz5Vhu9xkPtFx8Zq6W14SlZIJvknw+jZRFS6WF8ZktHbFJajmnRbVXwO8e3lSGwTeAFzTpDa184Ljp9+No9Cbyhyj/WQnXlXfMGZ2Uoiw0O7DvYrKCppaadRfwdE63KVN+e/E8uM4JVaSHEAXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120982; c=relaxed/simple;
	bh=ojDUQ4iBJ/OVI0br7vS0plf86AV0jx5oGoSQGlX5PcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFi5oWOTdi4N1pLqYGkDwRgi3gSPFEXVEAJlVJ20qqQLq+bsxLewWoNLKHQJX5efZvMVmKflh3Gtpey7HIIpKUyqm5rBALSUGHlEgLUpehwFQpv6s9lTua6TgoXkRPiSZt8okkKKz0ToeBb8GqxrVup7tYZLEo9hjovlBFKfF6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Kp1qTzth; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Fqd0VLkOvhwbAaaOYC0v6YOsmG08NzNd07uGCgd530Q=; b=Kp1qTzth/JVjqB5v7aj+qxX6Cs
	kQIqP7E25vopT53MsN91+pRHeENHd2eg5+Xh3cUCW/4naahfn0Ftq0IvV11zjhlN+J1VzxRdrtf1q
	2+4jkSLr0gAnV9L0f/ajGy5ts+lsjW3fgyzOoxBLhaL5tTqO/2DDL01cyzYQm8V56IfY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjzMf-00CM8k-GA; Wed, 15 Jul 2026 15:09:29 +0200
Date: Wed, 15 Jul 2026 15:09:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianmin.wang@motor-comm.com,
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
Message-ID: <7f1b935d-732d-4d2f-a2c3-a0517c9301d7@lunn.ch>
References: <20260714111203.3852126-1-kyle.switch@motor-comm.com>
 <46c380a2-74ab-4690-a289-6050cb33c1a4@lunn.ch>
 <47b67113-2903-49b5-a25e-84e704ac017d@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47b67113-2903-49b5-a25e-84e704ac017d@motor-comm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307755-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kyle.switch@motor-comm.com,m:Frank.Sae@motor-comm.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianmin.wang@motor-comm.com,m:ming.xu@motor-comm.com,m:xiaolin.xu@motor-comm.com,m:jie.han@motor-comm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[motor-comm.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5E8075E88C
X-Rspamd-Action: no action

On Wed, Jul 15, 2026 at 07:59:55PM +0800, Kyle Switch wrote:
> 
> 
> On 7/15/26 05:46, Andrew Lunn wrote:
> >> +static inline int ytphy_top_write(struct phy_device *phydev, u32 regnum,
> >> +				  u16 val)
> >> +{
> >> +	struct yt8521_priv *priv = phydev->priv;
> >> +	struct mii_bus *bus = phydev->mdio.bus;
> >> +
> >> +	return bus->write(bus, priv->top_phy_addr, regnum, val);
> >> +}
> > 
> > Please could you explain the architecture in detail. It seems like you
> > are accessing registers of some other device on the bus.
> > 
> > Maybe you need to use the code in phy_package.c?
> 
> Ans: YT8824 contains top extend reg space, and the addr is fixed, for 
> internal phy8824 the value is 9, and external phy8824 is (baseaddr + 4).

Does the "top extend reg space" have values in the ID registers, 2 and
3? Is Linux trying to probe this address space?

Anyway, it does sound like you need to use phy_package. That will give
you a better API for accessing the registers in the other address
space.

	Andrew

