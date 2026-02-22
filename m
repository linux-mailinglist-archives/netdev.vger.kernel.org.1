Return-Path: <netdev+bounces-259846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jZyqLQZLmmmgaQMAu9opvQ
	(envelope-from <netdev+bounces-259846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 01:17:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F018716E4DC
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 01:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 685B23009169
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1349AD4B;
	Sun, 22 Feb 2026 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ycjEh0Bt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5853EBF36;
	Sun, 22 Feb 2026 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771719427; cv=none; b=WcPihoRPOnP3h8bW637TIYSJFdnsU4woACbhyxJgsigM1JcHbV3houki2jPUTXdHRgilSWH+YIYWQU+oLD1xy6NRuX8R6Jf7HQ5OIsKXeMEcrLfeBcU5TP3pyQ1XmXtKf/ACQA3DUagBhSKbX0R7uRdgWIUO4wEOYePtupnA6q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771719427; c=relaxed/simple;
	bh=03myFq7sQRtLq130qEOY9/6xZX5dBP+XGCyCxkj9mfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxLa6aHJDO77Ug6eRG18aSl4cP/3uxIeSQqqwxNs+Y+I+IonXiMAnuI1fxELIB7wMr27qQHPa/jtQmOurbGRxV00l6HzBr5ykp4mtISmdMmzuL4SVgUQ9hIG8twbJTpjNrToOtSZqZsa6uQAdRa1XV1dgxOfYSaMOY0SZZKildI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ycjEh0Bt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jhCpriwcJEGX+TTw2LeGFuZAxm0zmE4H5M2is51zovQ=; b=yc
	jEh0BtcnRZ7G9cHl73fB0XcdpcG6DuDYKW18WWIMb9SB8ingnEYNvgW5rFYXa1T5sKt98GIEzXeRs
	zKFODz+jRCARLBMKaxgm7fQJ0e6fuM6XlafRdNxn00mvP60C7hi2NJGml9DEDUf6CnmxtpZM3lokS
	tg9W2owZyS0hkOw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vtx9X-008DZv-Rv; Sun, 22 Feb 2026 01:16:51 +0100
Date: Sun, 22 Feb 2026 01:16:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub =?utf-8?B?VmFuxJtr?= <linuxtardis@gmail.com>
Cc: Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sai Krishna <saikrishnag@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: phy: motorcomm: yt8821: disable MDIO
 broadcast address 0
Message-ID: <3e9812a5-401b-400d-9d9b-eec8ec8d0acf@lunn.ch>
References: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259846-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[motor-comm.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F018716E4DC
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 12:46:53AM +0100, Jakub Vaněk wrote:
> The YT8821 PHY responds on two MDIO addresses by default: the address
> selected by its strapping pins and the broadcast address 0.
> 
> On platforms where another PHY is hardwired to respond only on address 0
> (e.g. the internal Gigabit PHY in the MediaTek MT7981B SoC), this can lead
> to MDIO bus conflicts. The YT8821 may incorrectly respond to transactions
> intended for the other PHY, leaving it in an inconsistent state. The
> following issues were observed on a Cudy M3000 router:

I don't think you can reliably fix this in this way.

Linux enumerates and probes the bus in two different ways.

When mdiobus_register() is used, it enumerates the bus in address
order.  So the probe of the internal Gigabit PHY will happen first at
address 0, and then the YT8821 will later be probed, by which times it
has already caused bus conflicts and potentially messed up the
internal PHY.

If of_mdiobus_register() is used, it first probes the PHYs listed in
DT, based on the order of the child nodes. If the child nodes are
first reg=<0> for the internal PHY, and then reg=<??> for the YT8821,
you have the same issue, bus conflicts. And ordering the nodes this
way is part of the DT coding style...

Now you could vary carefully put the nodes in the correct order, with
a big fat warning that the board design is FUBAR and will only work
with the nodes in this specific order. And you need another big fat
warning in the YT8821 driver that just because broadcast is turned off
at probe does not on its own make it reliable, it could of already
destroyed another PHYs configuration by the time the driver probes.

So to me, this sounds unreliable, a potential foot gun.

I can think of two better ways to fix this:

1) In the bootloader. If the bootloader supports TFTP booting, or any
networking, it needs to fix the same issue. It can poke around on the
MDIO bus before it probes the PHYs.

2) Split of_mdiobus_register() into two, so that you can register the
bus, then do some platform specific fixups to disable the broadcast
address in the PHY, and then do the second half of
of_mdiobus_register() which probes the PHYs, once it is safe to use
address 0 on the bus.

I prefer 1).

	Andrew

