Return-Path: <netdev+bounces-265412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHQqAxuHrmnKFgIAu9opvQ
	(envelope-from <netdev+bounces-265412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:38:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6123F2358ED
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8109D3035247
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5002D0620;
	Mon,  9 Mar 2026 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5w9yr7A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C72701B8
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773045487; cv=none; b=L/sXcnLbKeFQIdz5FUSM1WZ5e39wVlx/w4Ugc4WLD7eUba8DgjeC+PihwqqqBcd52jtJ0c8guakL4CcZjVinAOr04tltm0TDXOQNAPIHMVDSqlnyXshUbFVkMDZY5CzlyGfW/pUfT/fLYPjDfS7lDeOgHeYzqiVznXu19rUITcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773045487; c=relaxed/simple;
	bh=LAXfqfhLjEz/vccTbHYHqComphgsNBknaq/HgydD83U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b3MXJgBGMMYOdPTSrKQ/mSyqXOFLqx6tO4Nzf7yL/aFw/HMc5PmI+enp4voEmPuZC1qba4si49at73O7+GHPtjvzys6N7UuaywEDzhjlwVwA9eRYEnC0GSQFx9Ed2C24YP9c0R5wYeZ/BoaOYz3BjKSnMtPmey8fbbI4TbVz3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5w9yr7A; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-660f37136ecso2283284a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773045483; x=1773650283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpCisJYUS/zIUy8dvtPRFx4mGY6K6itoONwU+IWy+Zo=;
        b=X5w9yr7AfCw0WcUtmawzX6nlCFAuonvNv8ZUBBYyvvaEkqDJpCLhcvg56U0Uh+2Mf7
         qO3Fn/raSQcctujJNalUOVCkYXk/ou0TYxvv1y0UxpS0+XSRyFgvEuTZsHWvcCktA0v1
         mlRTuiR/m2iTTEn6bi3L9ac0OYILtQo4T0Wq7G63RyxguXUhkWUTtDvcfncXcDN0wZzq
         00cmTki+YL5yzFd2HfxwI3lmeTgvTyBgFQUbTGijjsTAE/nypkXKYTq1gPdiFm+Enk+c
         zkAD7NGq40J8anSPkcdr0ZQ2A3X9+flblJJZgl1N4GrtcopwZTfrNEsDv8l/kSd8DpIE
         Jc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773045483; x=1773650283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpCisJYUS/zIUy8dvtPRFx4mGY6K6itoONwU+IWy+Zo=;
        b=OWZrWbnufRq3E3SUXeb60rb9uRt2amk8MzWIrybmNQIy8P+9OXqT3wBQV/bzKNZ+kg
         AZ6TO9Vo721wQOwu7c9g3hYYvrjXVYVLAD2s3l4eGgr0whbmwLmC3O5yjbY2U5ubDQmf
         qlhcbJMXj4IF90wEmLurGOl8/j5jTB9gCPGwG+d0CI6sKzu89S8LRWLbl3q56pGXCDVD
         6i3hvzQs3dl6tDxllZgECJ6hzzF9RuTpiKpRexeBDzVteyieokidgG9lg/QW7EWqBcJn
         HhmvTdcd+Mo8/+spTAjBlKPYUWWwCgnO4W7tN9jPKwsFNnNVj7DIK8WZOm6/bbS6hLT8
         Jk7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5KFVUvbp0OsizmmCUfyWIliVvWD7RakDBSqRyJyNYpIjBGbAem+dPtkcNEix2q3NciT+5Utk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzobFwe9zZLdZZfLOp4tIuLtfnh1rPVrwdHBJ+oNIJnLX8Nlai
	Ho3t65b05X2cw/9aRYqOmKzgkFd9IkWEF3BoR6iEwnqZG1z+uSJnMkVROjUouoWJ6Y3UqY9Ks68
	1a786XOqKQ0t2Oi6zVA==
X-Received: from edxf7.prod.google.com ([2002:a05:6402:14c7:b0:660:ee31:dc16])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1ec8:b0:660:48f:22bd with SMTP id 4fb4d7f45d1cf-6619d4c7b1cmr5809698a12.11.1773045483342;
 Mon, 09 Mar 2026 01:38:03 -0700 (PDT)
Date: Mon, 9 Mar 2026 08:38:02 +0000
In-Reply-To: <6022a652-36f2-4dc6-b24e-54c27b095e97@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <20260306-binder-netlink-v1-1-daceb5bc83f2@google.com> <081b1f16-5c8b-4a18-a9f1-d56e757de4c0@lunn.ch>
 <aayYhgy3pRxFWbr7@google.com> <f93ee07b-5dfd-4748-a7f2-814539e60d81@lunn.ch>
 <aa2UWlN8waUrQ8ij@google.com> <6022a652-36f2-4dc6-b24e-54c27b095e97@lunn.ch>
Message-ID: <aa6G6sLatJ3W631D@google.com>
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
X-Rspamd-Queue-Id: 6123F2358ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265412-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 06:24:16PM +0100, Andrew Lunn wrote:
> > If that is the case, then it sounds like the correct API design would be
> > to have a separate NetlinkSkBuff type so that you cannot mix them up
> > with an sk_buff used for packet data.
> > 
> > > So, maybe you can have a base definition of skbuff in rust/kernel/net,
> > > and build on top of that to make a netlink specific skbuff, with a
> > > limited list of methods which can access it, those needed for netlink?
> > > Make use of the Rust type system? And leave the messy fast path packet
> > > data things for somebody else.
> > 
> > That makes sense to me. If there is duplication between the two sk_buff
> > types, then one can be defined in terms of the other (or maybe it's
> > easier to not do that).
> 
> Probably struct sk_buff is one of those complex things where we make
> our best guess design now, and be prepared to redesign and refactor
> the code as we learn more. To me, it feels like we need a base SkBuff
> with full access to all API methods. And then a restricted type for
> NetlinkSkBuff on top of that for users of netlink.

Agreed. Though in this patchset, I don't believe I use any of the base
skbuff methods, except for the fact that the nlmsg methods seem to wrap
them. So it is probably dead code to add much right now unless I bypass
the nlmsg wrappers.

Alice

