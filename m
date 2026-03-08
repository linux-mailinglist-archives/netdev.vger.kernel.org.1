Return-Path: <netdev+bounces-265324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFCCKN+wrWnh6AEAu9opvQ
	(envelope-from <netdev+bounces-265324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 18:24:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EC823164E
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 18:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B367300B049
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7093C389E1D;
	Sun,  8 Mar 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pJfA/QzF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9781D47B4;
	Sun,  8 Mar 2026 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772990684; cv=none; b=pBsmAIraTnjYE4yD75GCAUfZNq41BnhYCc0ttqVzFN+WiJWPjaPgd5AnrN+DDAVs1tas+jN8FjteH/LkAO+wiWDWIiy4+VUrXqJCkRte95RtAxntr6AKcQoPFI0PiYAS8wDI7ojaXMtuQqfjk8vRAuBp9ZlnlvroPpmaztbizKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772990684; c=relaxed/simple;
	bh=Js6+J8FrZIZXz9hkHhKXAmD6TjO3YIHI6E163FtXD44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p21Xj+upDdTJDDk0liwsy5vL3mwLO3z57PJ7Ji8uZE79UHBA3Dd5ZVjJzQYoe8y3cfgC/4rhA3QXpQ17wIYngRNx49paB6NYcwIsDZUeKzWYuxm0+vZ8L86UHteWBBkZAfFca/oy7KYvo0cH7mUw983obL1hFQKLmAol+O0zyVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pJfA/QzF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ReResUgiOVZEYUpTUm4H7wmMtoALi/tpDRfIKPL/HCo=; b=pJfA/QzFvNbdMyE9IhutS9nYbm
	e3NkEOG8f8EMaqKbQh5tvoNDgAINkcG5oEym6ePqaKttcoHwkYrjkuF98QbEowvlYKPScV5fNYHU+
	+05tRiZj+lttn/KwhzRc09nTxk4r3JvOdkf7lvraAJBn4gy2LqZTNNInmZRfGbjJBFPY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vzHrU-00Ajgm-Uw; Sun, 08 Mar 2026 18:24:16 +0100
Date: Sun, 8 Mar 2026 18:24:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
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
Subject: Re: [PATCH 1/4] rust: netlink: add raw netlink abstraction
Message-ID: <6022a652-36f2-4dc6-b24e-54c27b095e97@lunn.ch>
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <20260306-binder-netlink-v1-1-daceb5bc83f2@google.com>
 <081b1f16-5c8b-4a18-a9f1-d56e757de4c0@lunn.ch>
 <aayYhgy3pRxFWbr7@google.com>
 <f93ee07b-5dfd-4748-a7f2-814539e60d81@lunn.ch>
 <aa2UWlN8waUrQ8ij@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa2UWlN8waUrQ8ij@google.com>
X-Rspamd-Queue-Id: C9EC823164E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265324-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Action: no action

> There are several static inline methods that I need to call. Here is the
> list:
> 
> - genlmsg_new
> - genlmsg_multicast
> - genlmsg_cancel
> - genlmsg_end
> - nlmsg_free
> - genl_has_listeners
> 
> And on Android devices running this code, they will in fact have been
> inlined into Rust code, permitting fast code without function call
> overhead. Inlining happens via my other (recent) patchset [1], which the
> Android kernel is already using in production.
> 
> [1]: https://lore.kernel.org/all/20260203-inline-helpers-v2-0-beb8547a03c9@google.com/

Ah, cool. That is going to be very useful in networking.

> If that is the case, then it sounds like the correct API design would be
> to have a separate NetlinkSkBuff type so that you cannot mix them up
> with an sk_buff used for packet data.
> 
> > So, maybe you can have a base definition of skbuff in rust/kernel/net,
> > and build on top of that to make a netlink specific skbuff, with a
> > limited list of methods which can access it, those needed for netlink?
> > Make use of the Rust type system? And leave the messy fast path packet
> > data things for somebody else.
> 
> That makes sense to me. If there is duplication between the two sk_buff
> types, then one can be defined in terms of the other (or maybe it's
> easier to not do that).

Probably struct sk_buff is one of those complex things where we make
our best guess design now, and be prepared to redesign and refactor
the code as we learn more. To me, it feels like we need a base SkBuff
with full access to all API methods. And then a restricted type for
NetlinkSkBuff on top of that for users of netlink.

	Andrew

