Return-Path: <netdev+bounces-258890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEueKrgfk2mM1gEAu9opvQ
	(envelope-from <netdev+bounces-258890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:46:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D866144098
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 507BD30586FE
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94BD30EF6D;
	Mon, 16 Feb 2026 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N1gG3pEv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC330E838;
	Mon, 16 Feb 2026 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249335; cv=none; b=R8DMrfHNORAy/aHsqyT7Qd4fGuwne5Hg3K7pgVK4VqlsEAUG6g4vv4BLIsxEibEU86uhsIYbz77IYoQhWU6Y0bbaN2mlEIESZWY2X5oGN5qBX7DLYc1WtK8uwO1Ppm70Zig8eO2mx8kQCs+ptkpSzx025xM+la5Us3RBc982QFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249335; c=relaxed/simple;
	bh=GNWCQqqGfNWNeP2iOBVB+h1W8ogcrloCRVb5BE3eboQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCnzIimLOMwtc3QesIOdHpQOVJVlgWxWeYF//PUy7oe0qglKPu7EJhX8mq9VGxF3elruW7CwXyei4n7K6g3v1+zSrLRFy8JmFDi75gzsFGAcPJ+I974K85DAIBqfWuzkATAPsJjCB2sUZfz0YQcDsvmQxJm7Pj3NkwHg5m8hJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N1gG3pEv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=D2wGKaKsyqqLnbGP3MV7n3A9KE6lDqyLwg0tYMssZOg=; b=N1gG3pEvFzOHxCEuI4hcNzRP+1
	TstMQGFzQ19ujY4DNiQg7dXyfqaUtWWDt/d163rBOnhcJHeNPDEbvHIVQE8GSyOFLJXBmwFEbpniZ
	elq3UV0TS/qh9CBiRIYino4RAbMEUrZoEvFZIZv3zM/QydMn1vjAzlDlJglekueeNErQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vryrV-007UhI-EC; Mon, 16 Feb 2026 14:42:05 +0100
Date: Mon, 16 Feb 2026 14:42:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Cedric Jehasse <cedric.jehasse@luminex.be>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add partial support for
 TCAM entries
Message-ID: <9cd71e84-3e2a-41a1-a6d0-875fd354d578@lunn.ch>
References: <20260213-net-next-mv88e6xxx-tcam-v1-1-051e552e2afc@luminex.be>
 <179960d4-7963-41b6-8c1d-a09376fb0d60@lunn.ch>
 <PR3P194MB15057C0D7A6A99A912B18783EA6CA@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR3P194MB15057C0D7A6A99A912B18783EA6CA@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258890-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D866144098
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 01:31:37PM +0000, Cedric Jehasse wrote:
> > Have you looked at other generations of switches? The TCAM has been
> > around a while. We need a clear understanding of what is generic, and
> > what is specific to the mv88e6390 and mv88e6393. You can then pick the
> > appropriate function names. Anything which is specific to these two
> > devices needs to use the prefix mv88e6390 and mv88e6393. Anything
> > which is generic to all switches with a TCAN can use the prefix
> > mv88e6xxx. The 6320, 6341, 6352 families have a TCAM, so we need the
> > naming to reflect if there is anything specific to a family, so
> > somebody can later add TCAM support for the other families without
> > having to rename things.
> 
> I've looked at the TCAM documentation for the other families.
> 
> The 6320 and 6352 use device address 0x1d for the TCAM registers, 
> while the 6341, 6390, and 6393 use device address 0x1f.

The mv88e6xxx_info structure already has:

        unsigned int global1_addr;
        unsigned int global2_addr;

So i would suggest adding tcam_addr next to them. And you
mv88e6xxx_has_tcam() helper can look for any value other than 0.

> The match registers (pages 0 and 1) are almost identical across all of these
> families.
> The only difference is the register at page 0 offset 0x01 is used on the 6393
> and is reserved on all the others.

So a helper to access that register would be
mv88e6393_tcam_set_match() or similar.

> The action registers differ between families:
> * The devices with address 0x1d (6320 and 6352) share the same ingress action
>   registers (page 2).

Just to be clear, you don't need to implement TCAM for other families,
just get the naming and structure correct to allow somebody else to do
it in the future, without requiring a bit refactoring.

	Andrew

