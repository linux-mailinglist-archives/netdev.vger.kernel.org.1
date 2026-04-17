Return-Path: <netdev+bounces-279301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKd4Nzcb4mny1gAAu9opvQ
	(envelope-from <netdev+bounces-279301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 13:36:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD4341AD83
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 13:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5606309337A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39DE37F8B3;
	Fri, 17 Apr 2026 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfRHm7Lz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E3834DB6D
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425578; cv=none; b=BLw/bJZLj9BOOKBmeE9H9+oS6PUbXIcJ19WdRdknM4fUgylcEAR6zN2jV0tf/g6WAEJPdeUUJ1HyhIUq0/kQGDinb2HGRgBJIeWLEhDoMDr785NpuIHW9Be2bfw4ItKMze3LbWQOlaU8Hw3FVPs77VE8JRXzC4uBADB606umIQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425578; c=relaxed/simple;
	bh=1MLbXPE06SDad6v8rlI+y7wq+rnQo7dINrAfqUW4a8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f2UShi0cnc/fA4nnP0+UBlN4NXPOnO4IRKARQv5yojVI33DhWn5xFjBqBG7wIhCHJch6vTJyrq8X84P+DOA6B0kPEmiyxyPLLfxS8wi+YtKzU4KBda4odwAlr/7t0oFSszbMv50ZJl4HKKTdtyxGC8/AMBYa40mUPCRwTv3XPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfRHm7Lz; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d03db814eso929632f8f.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776425575; x=1777030375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4Ws3Fp0j5FbcqNDEVXW7kBezGoH6rxWa1ymfwLTzi8=;
        b=vfRHm7LzZPeyndSTwWaZvjqvfXobGyQFP8tfSYAENVxDyWRUTxInqgI/+G9ltjyYjg
         WnZbWgvKfgO7ZUkYM6qrrEGMNjOsUyxRkMQFtdow9BtSOvOzUmMfZ1Xn0aMYIlosOK/3
         MPpEWIaeYE46Xcd8v/9PwgKPd0Igegcb62buzGX0IbV8mNpe/8E5UAIglmIEOqdZud/D
         Le4uCFQX7ijSmBFYWxQnwKoiEsgaRwMZACWi6CA8/9dWU3Mca8Ey5Rhy5FauYvKDWSBY
         tIRhbEyYTVXGqr2Tubo6ZrABSFVlty6ZiLCN9Pwy0qt5IzfRbcauw+sx0lqN3lBCdyI8
         2ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776425575; x=1777030375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4Ws3Fp0j5FbcqNDEVXW7kBezGoH6rxWa1ymfwLTzi8=;
        b=HDcatpOMEcD7x0tCvESSgg/yp8luuPTDBPznmtJECkGyrPVLaxeA58CLxCE925HUtF
         Xfw/Hx+2G4o0Q/Y9HbBpvZs/B2j8KYm76lr45s5G3oTzstHEiF4jCkmA8T8nW4eN46f6
         hqEjTaQ6FXFk+pCGgiGWTVUcgUJBc41ix62MdKYBFDfWlU6jMCgIC28wX+UZu/yl6ojC
         f840IeKPYQUDik6LUj6YuYSsTKzOdU48r0j5n9/WxrWsRGx71q2EMSlo87Y39yZVaHCQ
         o2AJXySgmTtEDml7lFGrOk8C3cChcaU1W54fMywCXtAZM4pn2LfodR9rNXJVhmhPdgli
         CQfw==
X-Forwarded-Encrypted: i=1; AFNElJ8aE4eGrXzB/KDc7PZrWRNcDo02scDmkWZb5NJC25L1DYP4SYX6/MGZrIF+SF4mFrdhJNFBNHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQO1i7NHMQDd7/0W0dYF/q2/u/WVyU3rWk37ZTSD0XwSiEhy4j
	O8q4BULarkTlQ3Ybm5+U+m+0F2LJ6NGvafNiifcn8qkjNdPQyR322xuNuinH2NwroAarQlVxaNn
	YlMd16dO6XScQjRZVyA==
X-Received: from wruf17.prod.google.com ([2002:a5d:4dd1:0:b0:43d:8896:b950])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2f83:b0:43c:fd7e:72eb with SMTP id ffacd0b85a97d-43fe3e144b5mr3941450f8f.41.1776425574579;
 Fri, 17 Apr 2026 04:32:54 -0700 (PDT)
Date: Fri, 17 Apr 2026 11:32:53 +0000
In-Reply-To: <CAD4GDZxGo6p9A07rKAW4MZNdFOYrMVzjkYNjwTqKfFcqKkzU1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
 <20260415-binder-netlink-v3-2-84be9ba63ee2@google.com> <CAD4GDZxGo6p9A07rKAW4MZNdFOYrMVzjkYNjwTqKfFcqKkzU1g@mail.gmail.com>
Message-ID: <aeIaZc-3RbIrOJik@google.com>
Subject: Re: [PATCH v3 2/4] ynl_gen: generate Rust files from yaml files
From: Alice Ryhl <aliceryhl@google.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279301-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ynl_gen_c.py:url]
X-Rspamd-Queue-Id: CAD4341AD83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 11:54:05AM +0100, Donald Hunter wrote:
> On Wed, 15 Apr 2026 at 10:39, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > To generate netlink frames from Rust code easily, generate Rust
> > libraries with methods for generating different netlink messages as
> > appropriate.
> >
> > The new 'rust' type corresponds to a Rust version of the C target
> > 'kernel'. There is no Rust version of the 'uapi' target since Rust code
> > exports its uapi via C headers - choice of language is opaque to
> > userspace.
> >
> > This logic is kept in the existing ynl_gen_c.py file to reuse CodeWriter
> > and other shared pieces of logic in the existing python file. This has
> > the disadvantage that the gen_c part of the name is now wrong, as it
> > also generates Rust. One possible solution to this could be to rename
> > the file.
> 
> Hi Alice,
> 
> I started a rough refactor of ynl_gen_c a while ago, so that I could
> reuse CodeWriter and the gentypes in a code generator for strace
> decoders. I just rebased the work to net-next/main here:
> 
> https://github.com/donaldh/linux/tree/ynl-gen-strace
> 
> If that looks workable for a ynl_gen_rst then I'd be happy to help
> tidy it up into a patch series.

That sounds convenient!

Alice

