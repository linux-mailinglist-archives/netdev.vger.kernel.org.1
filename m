Return-Path: <netdev+bounces-279167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODHDN6ZS4Wl5rwAAu9opvQ
	(envelope-from <netdev+bounces-279167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 23:20:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 465A7414E0A
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 23:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7074130210DB
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A8937AA78;
	Thu, 16 Apr 2026 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IwP9FRrW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01889374E6F;
	Thu, 16 Apr 2026 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776374399; cv=none; b=WmqoE+48fq8b9cARz3njLebAKucoSPKfwfkB5NQTXh8dSCgDEAXDTWlimlxwOyTJKoH6x+6ElMP0H1yfYFNL9NJAsa56StXLldy+Akb3DAPV8+fLGFd+sM/V8LWzcV9Pl7wD9YrGDeNOIPCRM0z82i8xnXFVn7Z5Om7KG7odj88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776374399; c=relaxed/simple;
	bh=ZSmuUCYSQX+ReSpAG8a97WfXFXhBqEIsMUdmoVjtuOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKWlI6Jodw5X05gD9YesnlHseQCpkqsnHFKw7Bfhlj2bix5leuS/KePPkICeOJcCnNN4VabhIDPTnnrnnvsNL2h3+/4tpl++brqJAWrbjs0QvRep5eWN6YlI/eWs4PxPyuuiN3WZPGhHVoFL1PtYeyyF+bAeDtq3ROp6qtKxd6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IwP9FRrW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pa2WeFXbSj6DZwlDDThKtpaSORTIq6+pGCm6Jk5pofw=; b=IwP9FRrWFq4iWhoWR9CiBaTmdb
	wMdQohw/ocw0vyLlBgqaBIUuu5j1MnMqpwO7gqinYYk2OChIHh8tItcw5fU4v7OyKiADCoUdq0XpP
	uGPsMQgyN2t+xrUVSIJ5RG+1EboVWPoyTCTffEleWajbus0kUBfSyElBeEWuv8NKvy9Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wDU7f-00GKgg-MI; Thu, 16 Apr 2026 23:19:39 +0200
Date: Thu, 16 Apr 2026 23:19:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthew Maurer <mmaurer@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/4] rust: netlink: add raw netlink abstraction
Message-ID: <845b36ba-7b3a-41f2-acb2-b284f253e2ca@lunn.ch>
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
 <20260415-binder-netlink-v3-1-84be9ba63ee2@google.com>
 <CAGSQo03b4tTQW=bXiRrmjvF8NympD_dcJX=2jwPdMmguXLfifQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGSQo03b4tTQW=bXiRrmjvF8NympD_dcJX=2jwPdMmguXLfifQ@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-279167-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 465A7414E0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 01:06:42PM -0700, Matthew Maurer wrote:
> > +    /// Sends the generic netlink message as a multicast message.
> > +    #[inline]
> > +    pub fn multicast(
> > +        self,
> > +        family: &'static Family,
> > +        portid: u32,
> > +        group: u32,
> > +        flags: alloc::Flags,
> > +    ) -> Result {
> > +        let me = ManuallyDrop::new(self);
> > +        // SAFETY: The `skb` and `family` pointers are valid. We pass ownership of the `skb` to
> > +        // `genlmsg_multicast` by not dropping `self`.

Hi Matthew

Please trim when replying, to just the needed context.

> I think if genlmsg_multicast returns an error code we may need to drop
> to avoid leaking. Specifically, there is at least this path:
> 1. Set group to a large number (that's an unconstrained public parameter)
> 2. We suppress drop
> 3. We call genlmsg_multicast
> 4. We call genlmsg_multicast_netns
> 4. We call genlmsg_multicast_netns_filtered, which does an inbounds
> check for the `group`. If it is too large, it returns EINVAL without
> consuming the SKB - include/net/genetlink.h:493
> 5. We leak the skb
> 
> However, at the same time, if we pass that check and descend into
> `netlink_broadcast_filtered`, it will unconditionally consume the SKB,
> and possibly return an error code in other situations.

A quick grep of the code suggests very few callers of
genlmsg_multicast look at the return code.

drivers/scsi/pmcraid.c prints an error message, but does nothing with
the skb.

drivers/regulator/event.c returns the error code to its caller, which
discards is, and the skb is leaked.

net/ieee802154/netlink.c returns the error code up the call stack but
leaks the skb.

net/nfc/netlink.c returns the error code up the call stack but leaks
the skb.

So i would agree with you, freeing it on error somewhere within
genlmsg_multicast() would make sense.

	Andrew

