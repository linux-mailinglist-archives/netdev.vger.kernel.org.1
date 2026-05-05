Return-Path: <netdev+bounces-284275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMXjCMq1+WlKBAMAu9opvQ
	(envelope-from <netdev+bounces-284275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:18:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 305EE4C9714
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C851308F73C
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F4C30E0E5;
	Tue,  5 May 2026 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0jRbu6+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00376347BD4
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972222; cv=none; b=IO4VPoYlfZbpXJmDACfmjcaLUU+W4LdR6iQeiuh+hSZvOaAOQSnSwYose4sayrmtB35bD0lVWmZCXbJ8anXGIb7sUI1cXKtYpMoZaUHkjn+sEJUtSpgmTcz7t/AxFYHBQyZ4Ni6YqUooonUNSzssPt6W75qk4dr5ibGQGLYSpAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972222; c=relaxed/simple;
	bh=cRfHUAFGg57jog7PQsYBRdjiL7fC9Xj6KJYDTyDSrds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=STTBHdaKBVrieZYBG3OKdW20fEmq/NIVX+EnjEotm+LSo30M0dx4bqu933+t/j0IhUchz3AZh/1c/Vnc0NFu65vlFPNinjfQNQmQGAl9gRXRZCTfJKNuEI70zc+2Ch5laRyZuitw5Nid4J01BshU3rb0iBZFcM/S3/ErP4QzvMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0jRbu6+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48d144d3428so6639725e9.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 02:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777972219; x=1778577019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TV+dGkVQMRpG1tcF9GVXKJzex3tlmHkPz/lBk9KZDnc=;
        b=A0jRbu6+pPWzFS86kaDV13qbO63j0SSpWSf2CX2N22KmsOYqQ8COCXD3yQf1HzuiYx
         WxFI5DNMThTA51oCC6q/LP1mFJ+U/H53/FMVUJwcvMIBLk7ELuwJc06zYmSG1s2TEyoV
         ist3GW6FUH9ov6gAiPBHlInxWzoMGk2SY13G29KgvCpVSydgtAeQTTZK+7bD3UhxRqbv
         TzKxrqyeY3WH/cDuHgp+iydE4ROR0gSOzTLCuciRFeqL+ZhFnq46lB8BI3lWCWACTHyS
         oaBwGZh3v7gdJeiq2GdH75IBHHFQrnsB110o8hSN1C4YNOHhzHs+T1WFPWdB987TgQTJ
         L4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777972219; x=1778577019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TV+dGkVQMRpG1tcF9GVXKJzex3tlmHkPz/lBk9KZDnc=;
        b=MubQ0jFXZtxcWfvxy+EPW7Th3E5e/vDD8FC0x0zmk0fAeOjIKDGwUiaoZF3SD6IF9f
         PiCLwI3J4++wUH03tWjNKzamT0tv/IKQ75a/BfQznd4zPA5iRS1t9vHXBloWkXGW+5It
         nvzVYybfP1mmCC/7ujY6ldCssRykkyQihaLGdhLPI+vqrStF4onfCH2cTkB43C58LCf8
         v8GGGP1AXUsthdE23Zo6OauGunzC00QHrjOTBpy21RLAc4quXsp1uPTpouw/rTigY7e/
         Z+BuLCaT+7VxKDSxuJx6LGeVFtR9RMDRStwhvIh+JSZZz8Lux71dtfOBddUcGiQES6E+
         yPVA==
X-Forwarded-Encrypted: i=1; AFNElJ8A6ITJRpLBhcLE/Pc1RBAaxhdocnDWA6PpNOOYcE5j3njfIsSIXaZCF/7NCawlYRSjvkH6nQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8R3X4vX+sfx2Xrw5eRCs673N3UZmQJQKQ8GbxfFK+mPYU2oV9
	JamSxT1zUgzTJjudepslhzxR5uBFaJG6RyLBC1RxOgkSf7WUYHHcqUjOJBcgcbgZQKCzDVof4G8
	aFD3LJc9coARv61g8Ww==
X-Received: from wmd22.prod.google.com ([2002:a05:600c:6056:b0:489:1c31:2982])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3549:b0:48a:93d2:60d2 with SMTP id 5b1f17b1804b1-48a980fd5d4mr203597665e9.0.1777972218974;
 Tue, 05 May 2026 02:10:18 -0700 (PDT)
Date: Tue, 5 May 2026 09:10:17 +0000
In-Reply-To: <20260504165858.4882730b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504-binder-netlink-v4-0-601b41cd25b2@google.com>
 <20260504-binder-netlink-v4-2-601b41cd25b2@google.com> <20260504165858.4882730b@kernel.org>
Message-ID: <afmz-dgqXjuIntRM@google.com>
Subject: Re: [PATCH v4 2/4] ynl_gen: generate Rust files from yaml files
From: Alice Ryhl <aliceryhl@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 305EE4C9714
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284275-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,lunn.ch,gmail.com,davemloft.net,redhat.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ynl_gen_c.py:url]

On Mon, May 04, 2026 at 04:58:58PM -0700, Jakub Kicinski wrote:
> On Mon, 04 May 2026 09:04:55 +0000 Alice Ryhl wrote:
> >  tools/net/ynl/pyynl/ynl_gen_c.py | 139 ++++++++++++++++++++++++++++++++++++++-
> 
> No. Rust. In. This. File.
> 
> Just commit the artifacts. I truly hope that this is the only Netlink
> family we will have in Rust.

There's no reason to react like this. I have not ignored your concern.
Last time we discussed this, the discussion ended on splitting the file
into ynl_gen_c.py and ynl_gen_rust.py, which you did not reply to, and I
actually spent some time working on that. However, I felt the change was
non-trivial and I wanted to discuss whether that was the correct way
forward before spending more time on it. Therefore, I kept this patch
as-is for now and noted why it was non-trivial (sharing of CodeWriter)
in the commit message, until we could discuss further.

I think you are probably right that just comitting the artifacts is the
simplest way forward for now. Especially since Donald is apparently
working on splitting up the file for strace [1]. On the off-chance that
a second Netlink family is ever added, hopefully Donald's work has
already completed and we can easily add this support in a new file when
the time comes.

I guess another way forward is to commit a copy of the python script
with the Rust support to drivers/android/binder/ and I can run it
manually if the Binder yaml file is ever updated.

Alice

[1]: https://lore.kernel.org/r/CAD4GDZxGo6p9A07rKAW4MZNdFOYrMVzjkYNjwTqKfFcqKkzU1g@mail.gmail.com

