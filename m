Return-Path: <netdev+bounces-265186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDZiHpOYrGlarAEAu9opvQ
	(envelope-from <netdev+bounces-265186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:28:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E805C22DB42
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BE6E30209CC
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E63366DBE;
	Sat,  7 Mar 2026 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NU8GDp0g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340834D4F7
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772918923; cv=none; b=MPDfgseesqcvPUJNFjkTkkKf2ZoVNRwXlz0abwSQaxmQkQir8Gn80l1w24rv+MHVmHytp/76aAP7G7PV17zQamypiZ8DADvY/4ekbDWdvLccS1256QpEPwCMQ1ICXN7MrClKE5YwQUMM3zOG9lGERSB8kRDEZsulPLurk2ZkgQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772918923; c=relaxed/simple;
	bh=1bK4p5mzYeMCWDs67MGklTJGxrWR+9TZ2JdRQtnv8Ww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hg7V27fruuo16wFoO3Kx2URgP8v3ed7ghjVWo2xOQXQ4PYkX+eyfah8H9pjndlTecp0XOO7qx5PZGEg8WaBChArOrf30EdPqtnBu26fE7JqMpjOhNFZ1K0EUzBsg4bV9+XTyK5aWU5jfxPTr1Vo9UFz7RbWShMXYp7DcG8Ich40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NU8GDp0g; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-660f37136ecso1307643a12.0
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772918919; x=1773523719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXZ2BtMMwe7rXhuI9FW2OS3wA90krDOiJKGgmhoSpL0=;
        b=NU8GDp0g20o35tVSF2xZAWpKYNqzKc0JdJ0p2GzKlRGomkAI1xh2kfVeplpTnxKD7r
         978MPt33LOd/U/rygfzMtKvHQA4/GBEfK2cnuYh7nuJDOvGVX6CfsxZ5ljVFUFnXS3Is
         docUZYk+e434kTIFf3ZsbErf/KHulPGTKlA1v4jWdw+dOKe1oiLOYdLJXJXTlAvDrxW6
         ndTtTxuhC40YE4ZHYdwm+NeROrSby7P0WDdiwu1ffMX4YfeTSbktCRQ6PKkNjn+0haIR
         pPfelNjMrf2IExS+27TqN6LvxeACByxJnreqKkMwh06tGqUG8drEn3WlvJo32XrfrPvc
         erjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772918919; x=1773523719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXZ2BtMMwe7rXhuI9FW2OS3wA90krDOiJKGgmhoSpL0=;
        b=pGZFoMd/7DCewWtYn3yRtSnYxvNwnUFzdKOZvU4ffBfV8BJZHDj3M8Rd956Xprnk2V
         nBnCVnewYbfyf1TJXGfYIV/R2rEpMe5/N1erh7yeUHZmbl1nxKPYlzsg+6YP32/WbP9T
         opCZjCVkLdR6GP8ZLyiGtggsC38it7tLLXrOxpzFdKBR+RpRXWxFGjGGAtR5+z8Jqp2j
         UIkspmi+uDkWzAjewxjmjdKgv34Ek4y04Wvxp/7CjYSW6JuF0xn6ji5Wuvb34+VEQr2I
         N2U5ueqvZ1vyRF5GLqDc7zp5ZKGuuzGmeKOngx/py3C+kg6AMrk/rg9apRYWRT/1M3TR
         fyvw==
X-Forwarded-Encrypted: i=1; AJvYcCWjh7HA4yVNxp5l8cpxeiV+ag3hcX3qirnvn8NxdZJfSBKzNMkkgTKmVxh/9af1J5LJpFownL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoPnFD1lsGNfK2+TMrHIonX9PD4e6sKr8ATkZoRhwRNLhJPCMC
	ow87YmoicNd8Bhv5N/En9+//T6UX+J0DgcvBmqwNoHJSGd9lpob6wogTbk5mhqvvoxERXGNmUcL
	zpBQ975giNcB2pe1F3Q==
X-Received: from edse9.prod.google.com ([2002:aa7:d7c9:0:b0:660:e726:1fa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:42cb:b0:65f:7000:928f with SMTP id 4fb4d7f45d1cf-6619d2efe84mr3606718a12.0.1772918918922;
 Sat, 07 Mar 2026 13:28:38 -0800 (PST)
Date: Sat, 7 Mar 2026 21:28:38 +0000
In-Reply-To: <081b1f16-5c8b-4a18-a9f1-d56e757de4c0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <20260306-binder-netlink-v1-1-daceb5bc83f2@google.com> <081b1f16-5c8b-4a18-a9f1-d56e757de4c0@lunn.ch>
Message-ID: <aayYhgy3pRxFWbr7@google.com>
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
X-Rspamd-Queue-Id: E805C22DB42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265186-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netlink.rs:url]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 04:43:02PM +0100, Andrew Lunn wrote:
> > diff --git a/rust/kernel/netlink.rs b/rust/kernel/netlink.rs
> 
> ...
> 
> > +/// The default netlink message size.
> > +pub const GENLMSG_DEFAULT_SIZE: usize = bindings::GENLMSG_DEFAULT_SIZE;
> > +
> > +/// A wrapper around `struct sk_buff` for generic netlink messages.
> > +///
> > +/// # Invariants
> > +///
> > +/// The pointer has ownership over a valid `sk_buff`.
> > +pub struct SkBuff {
> > +    skb: NonNull<kernel::bindings::sk_buff>,
> > +}
> 
> struct sk_buff is a core data structure which appears all over the
> networking stack, but also other places like crypto, scsi, tty, file
> systems, etc. Since it is a top level data structure, it seems odd
> Rust puts it into netlink.rs.
> 
> How do you see the Rust SkBuff evolving to a general purpose data
> structure which can be used everywhere?

We can make a kernel::net module (rust/kernel/net/) and put it there
instead? I guess netlink.rs can also be a submodule of that.

Hmm ... but I'm currently using genlmsg_new() / nlmsg_free(), and I
assume the other use-cases do not go through those methods, since they
sound netlink specific.

To be honest, I'm new to the kernel's networking stack, so I probably
can't design Rust wrapper for sk_buff that supports all those different
usecases without someone walking me through how it works. It may or may
not be best to write a netlink-specific struct now and expand it later.

Alice

