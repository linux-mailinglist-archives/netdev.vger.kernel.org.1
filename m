Return-Path: <netdev+bounces-266930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF+yDxZjsmntMAAAu9opvQ
	(envelope-from <netdev+bounces-266930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 07:54:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA9C26E0FC
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 07:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78A3A301A53F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 06:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA9F3A382D;
	Thu, 12 Mar 2026 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N1sqMSex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19839B96A
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773298451; cv=none; b=j1UbGYRAIH0dtjbQ+mfvHi2SMrMtPMb2/yMjgEjg35lhNNVdbmwKqlhLOfL2034uQbG9Nypb/WSXNngZ/ZL50JRNDMTxwjTOToHB+72dGU1tNCVCq7adRtcVJUTGlikX7DS3s95WuFeLXkUoDPSdBIrjivzmN//PR5cJwaKK5Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773298451; c=relaxed/simple;
	bh=PV2KW+B+16f4whHFM1Va04VxOs8VP+ZJG+J8NyMoyP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WBGpR2UICPPktO9tc8E3TXPT/fgqGoacQLYPenz3xp9Fg5pwgO2hLXLLjy0wMtPu0QMz8Yi5i89+XMTioBLQL3o6QjFQBT1lch9EUwbxmYGBA4L4gAsAO88VDfUCv4db02d7Wp5DzFUSItI9qjELh9ucOojrthdXtC9RlbxXbPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N1sqMSex; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-38a34e45d28so3256611fa.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 23:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773298444; x=1773903244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FxHREOl1gWgasyiRcE2Gelqt0sxFq70SlRQGJSqCTEA=;
        b=N1sqMSexI1pMnuX8M6iU/kW/lzC9MyHyiCdzdRgbljCengqalVdSFNn/w/VD7y4jhF
         A8ET/YKVm7+4zOLyTHHr9zpnYcVtE1e8vAKTpbWzxkk2bJ3/r7hQc25IsU6+ecZWP2qS
         /PgA93i6UCo0dlbFuRHmeWX7spgzc+s2HC7vMPTf2php3scWTKJqTYHNYn4iuMvEUwES
         a+c7dbDDjAUN4KtSvAPRW1aVla1uFc0HudgpwIv/DqoyulNKlDIKawV7z3bA9eVN/mR9
         MR8ZvNyfEQ75hOpTfoOyMaxRNVXMvi3NMEiR9K8DsB856rhTCDVWT/eB0vYmDJEwgJ+n
         cs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773298444; x=1773903244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxHREOl1gWgasyiRcE2Gelqt0sxFq70SlRQGJSqCTEA=;
        b=dUqq1TdhWXk2B/+e3EbhVLQk2tnHz2bCmJ/wJRdaAVcPQkn9po5Aht8nzoWgvTK6gs
         OMbckSd60UNJW5xt0AmyapMnxkNGRjRpaCjjLbOGtMYWiV0Jf1hbTuRGJB3GkRdxcK6K
         wI5Mm4pmmLKRWLFVJ8Urd5hqt8r8Ob6ScicvzOSL1frUEwVxcA8LLAZVEa6ehp5k4Pzg
         N942Ggr6T7QBZ0PbV1wkjPWjnsltCJzHx3tTzDl5JA4BPbDkLOYU6p+CSkruV0xmKnyk
         6HWWpRVL/BtNvX+2arRrgfQQe16rTF5vvpev739mpnFwaVrrcqPmFCQxX1HAvzhWBKiZ
         KWzA==
X-Forwarded-Encrypted: i=1; AJvYcCUoEd9V0BR5ELEM9K1D9YQGC6WimWr+Xr+OkkSZL6HDpVnNzqZs7VKgy4dxNKPVy9dnwAbrfqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsBLo08rUq47XeFjd9LhlvNdX9n/iDYXyxk+zZtmAt0yWmfoYi
	a4XBI3ubvYmd+wQU4VFmPdv0S7JA4rM1KgO+eguYEF1PBOvoqo9RWwSPvRiSjsXqPr4JBdoRM5I
	RKBt5tL9Y3snAjUCgYg==
X-Received: from wmej4.prod.google.com ([2002:a05:600c:42c4:b0:485:2cf0:2668])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e2a:b0:483:c771:10e with SMTP id 5b1f17b1804b1-48526957d6cmr135306345e9.20.1772983387265;
 Sun, 08 Mar 2026 08:23:07 -0700 (PDT)
Date: Sun, 8 Mar 2026 15:23:06 +0000
In-Reply-To: <f93ee07b-5dfd-4748-a7f2-814539e60d81@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <20260306-binder-netlink-v1-1-daceb5bc83f2@google.com> <081b1f16-5c8b-4a18-a9f1-d56e757de4c0@lunn.ch>
 <aayYhgy3pRxFWbr7@google.com> <f93ee07b-5dfd-4748-a7f2-814539e60d81@lunn.ch>
Message-ID: <aa2UWlN8waUrQ8ij@google.com>
Subject: Re: [PATCH 1/4] rust: netlink: add raw netlink abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[87];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-266930-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,netlink.rs:url]
X-Rspamd-Queue-Id: AAA9C26E0FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 08, 2026 at 03:48:40PM +0100, Andrew Lunn wrote:
> > We can make a kernel::net module (rust/kernel/net/) and put it there
> > instead? I guess netlink.rs can also be a submodule of that.
> > 
> > Hmm ... but I'm currently using genlmsg_new() / nlmsg_free(), and I
> > assume the other use-cases do not go through those methods, since they
> > sound netlink specific.
> > 
> > To be honest, I'm new to the kernel's networking stack, so I probably
> > can't design Rust wrapper for sk_buff that supports all those different
> > usecases without someone walking me through how it works. It may or may
> > not be best to write a netlink-specific struct now and expand it later.
> 
> At its core, an skbuff represents a block of memory. Normally that
> memory would be packet data flowing through the network stack. You can
> append to the front and back of the data in the buffer. You can add
> the buffer to linked lists, there are reference counting operations,
> so the buffer can have multiple users, there are places you can store
> per protocol data, and places you can store data while within one
> protocol layer, etc.
> 
> When using sk_buff for packet data, you are generally on a fast path,
> so much of the code is in header files as inline functions. This is
> going to make rust binding harder, my current understanding is that it
> is hard to make use of such functions from rust.
> 
> However, for netlink, its is slow path code, it seems like all the
> functions you need to call are in object files, not inline headers.

There are several static inline methods that I need to call. Here is the
list:

- genlmsg_new
- genlmsg_multicast
- genlmsg_cancel
- genlmsg_end
- nlmsg_free
- genl_has_listeners

And on Android devices running this code, they will in fact have been
inlined into Rust code, permitting fast code without function call
overhead. Inlining happens via my other (recent) patchset [1], which the
Android kernel is already using in production.

[1]: https://lore.kernel.org/all/20260203-inline-helpers-v2-0-beb8547a03c9@google.com/

> I also suspect, but don't know, that the netlink upper API is disjoint
> to the packet handling upper API. How you allocate a skbuff for
> netlink is different to packet data. It is very likely an error if you
> try to transmit out an interface an skbuff allocated for netlink
> usage, etc.

If that is the case, then it sounds like the correct API design would be
to have a separate NetlinkSkBuff type so that you cannot mix them up
with an sk_buff used for packet data.

> So, maybe you can have a base definition of skbuff in rust/kernel/net,
> and build on top of that to make a netlink specific skbuff, with a
> limited list of methods which can access it, those needed for netlink?
> Make use of the Rust type system? And leave the messy fast path packet
> data things for somebody else.

That makes sense to me. If there is duplication between the two sk_buff
types, then one can be defined in terms of the other (or maybe it's
easier to not do that).

Alice

