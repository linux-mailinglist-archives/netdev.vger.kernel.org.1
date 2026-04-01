Return-Path: <netdev+bounces-274161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FcLGgRCzWkkbAYAu9opvQ
	(envelope-from <netdev+bounces-274161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:04:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7CB37DA71
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A88F3011BF0
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B827F36494A;
	Wed,  1 Apr 2026 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pTwVqz/B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B774376BD3
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057913; cv=none; b=ETB7BFEfwNZXR9h9YYOlswM9xHZ9pOryhECr3J8bSEnErIqSPFK7fQTYZUjD4oaqAp1/OebM6FNGuyNCkbMGKK5IKDH96NK0mjgknztej3Akd0QZtCZfJ4cgVf32QyU54oWVVcumnAZCYY443jt47qfz+tTJjzzW7o1SFfIZMss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057913; c=relaxed/simple;
	bh=PV2WUyCNxZsTEzWvaE6YE1Uo9Sqb9ySZd54noc/aseg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVPaFVqDX6iPf4ryIYcpShGbsHayb4XDYnkRqOCpjCZ584N2u+I4K38QSpBagIViT2sukDlJ68MuLCx/P4At07ZEKqVpu53Q3shpvoaLC/WJi4+JkPyjjbUL5I3s0nvJF0+0VuCMRDWUzLJoGSxlweXqH9kV2k9cKTaa0nJ6/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pTwVqz/B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dlvekUpkNUvVrcxx8wGKU4Wqnvw5G90EbFLhti+p1u0=; b=pTwVqz/Bk8fnteG1sl1TsHBsnv
	7STf73U+sSDdDK9LGRhX07NYXNxHGE/5H3pfUq7Z1YhOf3G51cwMrS1yjBbwD/GhQEdFiL573bhPg
	PunbpT9XzjqmT+q/kgmJDuisC+3ocUMspgUd69PggCTXzArH1m9njItfZf2qceIEbl2Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7xeB-00ENUI-1q; Wed, 01 Apr 2026 17:38:23 +0200
Date: Wed, 1 Apr 2026 17:38:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Subject: Re: RFC: phylink: disable PHY autonomous EEE when MAC manages LPI
Message-ID: <ea94e96c-3e76-4c2b-a08c-43ce6decca08@lunn.ch>
References: <d86c53213a6328b701b8aabbde5d1c83@tipi-net.de>
 <04ff15af-26be-4278-bc2a-889e7802d271@lunn.ch>
 <aczMqBNesQH-tHx0@shell.armlinux.org.uk>
 <ccb68eaaca5512d5d662326d0817bd50@tipi-net.de>
 <48abd3e3-a3ee-4e85-a3d8-20c8ceedfb77@lunn.ch>
 <ac00PIpzXPjxktzC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac00PIpzXPjxktzC@shell.armlinux.org.uk>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_FROM(0.00)[bounces-274161-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD7CB37DA71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 04:05:32PM +0100, Russell King (Oracle) wrote:
> On Wed, Apr 01, 2026 at 03:11:24PM +0200, Andrew Lunn wrote:
> > > Thanks Russell and Andrew. You're both heading in the same direction,
> > > so to make sure I understand correctly:
> > > 
> > > 1. Add a new phylib interface (separate from phy_ethtool_set_eee) to
> > >    control PHY-autonomous EEE, e.g. phy_set_autonomous_eee(phydev,
> > >    enable) and phy_get_autonomous_eee(phydev) to query the current
> > >    state.
> > 
> > In the end, we want the MAC driver using phylib to just call the
> > phylib methods for configuring EEE, and the MAC driver should not care
> > if EEE is actually implemented in the PHY or the MAC. The adjust_link
> > callback would simply not enable LPI if the PHY is doing EEE.
> 
> This won't work.
> 
> If we mask out eee.tx_lpi_enabled when calling into phylib to tell
> phylib drivers to disable SmartEEE (that's what I'm calling it here
> because it's easier to type)),

We need phylib to handle some state information. Are we doing MAC EEE
or SmartEEE? We can then set phydev->enable_tx_lpi == True to indicate
if the MAC should be sending LPI indications, if and only if the
phylib knows we are doing MAC EEE and it should be enabled because the
user said so.

then phylib records that tx_lpi_enabled
> was false. This then makes the following in phy_check_link_status():
> 
>                 phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled &&
>                                         phydev->eee_active;

Which will need to change to take into account the state information.

However, i think this is down the road. If the MAC driver calls
phy_support_eee(), we should call the SmartEEE disable method of the
PHY driver. When we add support for SmartEEE then we need this
additional state information.

	Andrew

