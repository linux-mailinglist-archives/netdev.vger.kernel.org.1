Return-Path: <netdev+bounces-292686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMaWBCI5GGrdhAgAu9opvQ
	(envelope-from <netdev+bounces-292686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:46:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6F05F23BD
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 984C8301C103
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FF83EFD0E;
	Thu, 28 May 2026 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NP1beM3H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5CB3D093E;
	Thu, 28 May 2026 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972380; cv=none; b=YB1ODX8zHhTpSJHRhkujgyEqLkIA+A9QEnlTG6Scv5ZmcYhFclGE1aZSOSwehdZTum2EHBckk09/1t8Zn1Ae4jrHAOjL0IjUMYXDRoFVa2AEJ23YNo4lZDnqlfOxUmaIU+qP9gwn/cmte+VNQr4pEg4ygDLwSQ0Gb/B5b7RFofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972380; c=relaxed/simple;
	bh=OD7o9MDgjTj8YX8g90cEbBLX0ChOGs0N34DwDMOZenM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beKG1K1NVy1oLnwUUp1dfqnfUxXQUnVGGrFPA9gpPR2MPmILiYBLT6sm1wwtyve0GZDnvavVe8H5WSI0+Izm6y2r8U/av3k2dsk+mQhb8mNwd+dR9WGNIw9CL+qg9xXTPLZrKWNTUAxgnu3GdZTdOKWbBab/+3GebPoExdvdwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NP1beM3H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ut/Qe9YdI4WHkXTTJGwEVhJ+o8KwuXlfpkvaFGgGtTo=; b=NP1beM3HPdc3Zfmy0dtCgbc8X7
	G6+9lEgOPk5xVh0m5H31CLThw3ZPXWWng53y303yK5A4zpXSyESlSuUNqMAyr4DjfRHEtg0u5jTZ/
	TuIa5kZ/uNi2K5JRmKeXj2wD8ypEtofGoeM07tEXOz/OzDFTpVEmBJyqim7DvNkQYCjw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSa7k-004tyP-1m; Thu, 28 May 2026 14:46:08 +0200
Date: Thu, 28 May 2026 14:46:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
	Cedric Jehasse <cedric.jehasse@luminex.be>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kieran Tyrrell <kieran@sienda.com>,
	Max Hunter <max@huntershome.org>
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
Message-ID: <723c23da-69e4-4cdb-8b72-9a3af5f8dba3@lunn.ch>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
 <C0F865AD-24CD-4EA7-B0AB-16D91914ABAD@padl.com>
 <PR3P194MB1505960E42BBFB9AD9E8B18DEA0B2@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
 <885A5B11-A34A-4F69-9E9F-ABF10159B789@padl.com>
 <CABvLYuA85b1X9wHH073HPX=xv_1uZ2+anhcr+3MMkoVF-3DVcA@mail.gmail.com>
 <2E4F8243-8687-4591-A03D-4402D4FBEC02@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E4F8243-8687-4591-A03D-4402D4FBEC02@padl.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292686-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,luminex.be,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,sienda.com,huntershome.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 6D6F05F23BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> It would be good to support both, particularly for switches with >4
> queues. Maybe this can be keyed the presence of the DT property (now
> renamed, marvell,avb-mode).

You need to be careful with DT. It represents hardware. Configuration
of that hardware, or policy, should not be in DT.

	Andrew

