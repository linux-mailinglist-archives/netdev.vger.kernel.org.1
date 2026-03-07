Return-Path: <netdev+bounces-265200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOZNMo2prGkbsgEAu9opvQ
	(envelope-from <netdev+bounces-265200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 23:41:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 476A722DDA0
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 23:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6A32301E3D8
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 22:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE162BFC7B;
	Sat,  7 Mar 2026 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="or7ofdcw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356CB244661
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772923273; cv=none; b=gkJnCIgORVUeo9fGgDLnj60C1CoBR2KoqURAVwnGIhlqptcsUNKVRH3RguAE/PClsAGJmQux9UXGvDRMCLM5WJNA/Hh86DlMGiD0bXlbf3Mmw3Ar/0aCQxTBsrthsB+nLvqca/OAkPfPoLb8mepYBAWKcP7CJNkGQs/UF+PUIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772923273; c=relaxed/simple;
	bh=I4VtaTm8XHSftyNG90a7MzUKFwrfQloyAsT6smzws+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a6A173Hwm/I7dYteiSMl1QOGArD3RzT+uR9YZvjwAEQWpEKVl/nZVqjEzuIOxTUl8ApHAkjFkfHZdbNYXhhuVNgu58s+pjLUiL5PNOhiArSGHMIPwQ4UvshK+VqTYiswz8XNCMnK6lchzFqhkD4AEtZLy282vf0ABPgoNayaLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=or7ofdcw; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4852ccff333so12532725e9.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 14:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772923270; x=1773528070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7GRPrhIM/HbWD59Yul47MIZsf01ZYQyC3nXK9qbXgs=;
        b=or7ofdcwi17qkjHaB9Nw5750BROHdHokL2xHrxfJXCrZqrXels4SE3nzsNWXmLGsCI
         9PpmwLR9X9Eit+M1JqoDTSdJQoXAsLzgn7esFeYGY1RSb1OLHTxHR3MC7h8kYycI2yWJ
         jzJ6nN6f5jH/XVOsybBhH/YlMAdsV/Schnr06EXlz6aX0NsQawGxyNJ6TSz9nYaC+ijv
         W+KU8A/wUzaHj6FZObXNdJian7TGcfSsrv3nG6qzF6E9fnhxpWbnsI3IxLYRFdDWkbsD
         zv43nwKBgjrj7p9ElRAGy6dFo+Ldok9AunfyoAClDUXQ27+lSSh8kAgVNa5Y9o5bnYmy
         c98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772923270; x=1773528070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7GRPrhIM/HbWD59Yul47MIZsf01ZYQyC3nXK9qbXgs=;
        b=jb4ihxfxNeitJIrGlmKKnd1unWDeXxxoLuT+IlMZyBI13P7gQDx1bh0sAqfFVZ0MgC
         C9e3A7UqBH+BsdnIFVGEVe8wIUFAJ64MV1tG6604v9qUbZshRZThz7fQ4TuykQWwfxAV
         /6tAXbhhSvhCKeZSg2gmRSM4deVgeM8G79waQ3JIAH/V8e9AblDzUz+Np8Hr/rUb0Tbj
         q30tIQTDRQuTZKTVxno4XUuJOPrllgN+nGD/OcRiApefIhStpqZOgiKJb4odPXGTZGxF
         1geHXr+nS8xXHv3NkGM44nPayORKlpuGUTdzvZtA1NfxXrLe1mugkALeqUV2vIDeyuDQ
         PxqA==
X-Forwarded-Encrypted: i=1; AJvYcCVTAdWnJuHageKSfYO8uYUrG1hoBCBHh+kZnPp91SztkP2VYA0nmMrzUQCrZuBoFKDlb0IzU/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2T38Pc5J5bod7AcldKnremDFKenPn1itmEb5HjhwHoJEWHfJh
	wL9z4ghFq+Gsmkt1rELbBu9srnGn8gfrxg3U0wFYhcULWyo0trcZLoMsfxirkJv9M+Ig5Ym9UMM
	cF/yT9+fihWedo1clgQ==
X-Received: from wmjy4.prod.google.com ([2002:a7b:cd84:0:b0:483:27fd:cf2b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:350e:b0:480:4a90:1afe with SMTP id 5b1f17b1804b1-485269785afmr99848205e9.34.1772923270530;
 Sat, 07 Mar 2026 14:41:10 -0800 (PST)
Date: Sat, 7 Mar 2026 22:41:09 +0000
In-Reply-To: <42407d43-00e9-4938-8d6c-70d83b0f2ac9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <20260307104131.4c1d0de5@kernel.org> <aayWSuOM59uojtuG@google.com> <42407d43-00e9-4938-8d6c-70d83b0f2ac9@lunn.ch>
Message-ID: <aayphfkModIeENp3@google.com>
Subject: Re: [PATCH 0/4] Rust netlink support + use in Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 476A722DDA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265200-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 10:39:28PM +0100, Andrew Lunn wrote:
> > > Please no duplication of existing code in Rust.
> > 
> > The plan is certainly to get rid of C Binder, but it was unfortunately
> > not possible to get there without a transition period.
> 
> Dumb question....
> 
> Why?

The reasons for moving to a Rust implementation are discussed in the
cover letter [1], and in my 2023 plumbers talk [2].

[1]: https://lore.kernel.org/all/20231101-rust-binder-v1-0-08ba9197f637@google.com/
[2]: https://www.youtube.com/watch?v=Kt3hpvMZv8o

> You are just sending messages to user space. Does the rust version
> send different messages? Can user space tell the difference?

No, it sends the same messages. The intent is for Android to move to the
Rust implementation without userspace being able to tell the difference.

Alice

