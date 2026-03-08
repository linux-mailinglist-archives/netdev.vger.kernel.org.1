Return-Path: <netdev+bounces-265311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCu8Cg2RrWkQ4gEAu9opvQ
	(envelope-from <netdev+bounces-265311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 16:09:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B5D230D78
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 16:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A063B300D90D
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 15:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6BF283FC8;
	Sun,  8 Mar 2026 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mAAAj3Gw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD527B33B
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772982535; cv=none; b=ptRd1QSTar/dwn6/YojAH1aPvqu7QoUXIIUwGmbMUdWyJkqPQgSI2/r8IAdvJAEyAXAkDy0zRefUtCHpURHhImau8FQv0MYiD6oKZbecNH73syzo/gLo7R15SPojzXkE/smJr8wUAJAyVOb0Mvf2TWp4M2vkeGH6Y4k+GuB7f0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772982535; c=relaxed/simple;
	bh=mFK99LHKdUsRe+T0sCQq/VZyh7HJ7+oeMkEN2v6F0Ko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oFYBkIrb8PX5VspOdpckhPxhmy1TuSwX80xVNx4J9ZvW16CaXkwfKGxz/Az4spaVU+p/UFtnRotZnNpUKN6SsPHTNYvVxMn1gEn+3qbCQWyp9+HShbWXd2Wruyyzi0KwuHlkEvXtf3djLtyf7TsothJIfBfS5XhNfCJiVqk/lhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mAAAj3Gw; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b95c0d77b42so79121166b.1
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772982532; x=1773587332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkMvYk7sOOVr/eHkJO3RqJKUvxETsQyLKsECTZgBTXM=;
        b=mAAAj3GwaoiN/+DzaHWynfZuZJnYGpPOTBo3A6ehJjk6lGhjmEFag55d5LB/JR0PKT
         CUoUOe7/8n8oHZD5fjvPk/pXYjgWujNJlWPJds8sGUAZIA88HDHwPjv0mIQBDBVIMIYj
         KJEnSsKR2tTdbhbGI3drZY0KLS1FzpDASxA/aki3f6I2YiGQyJtQsJmGJGC8XOMvi45+
         TA7K4P/4e8DAoivaWM92LHF51vCGeYbXP7yPUyAi3uz+U8VIXL5JXkDGMxmDWpoz5wmq
         ObsL78gM8dKQOkzU3k2LMCUAp8IeOrxoSgBbVu/eCaPQ1UJZAnCbfsjmj8+dwEHKDSQ5
         anyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772982532; x=1773587332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkMvYk7sOOVr/eHkJO3RqJKUvxETsQyLKsECTZgBTXM=;
        b=oNb+ZNHhLC2ZqZo5sduVu1ANEYv48A2koNpStRNidRrc7iN2JCAceO3oUW1RBog0BN
         5cOIj2/71QQON9i+4t8DCBZN5iHMCNXX3RvFlzHFXSYbvGmTs/YCJntDX6V3Z+63GgmD
         lv5rBMoVccsnCtLa0I2SoAN7Zhae/p9UErLYUlGdFKVsfRNQxu2E4fdvBw5OjiA29atj
         jpnM3VfvDfUM0Fr/8UGsS/7E23wUfifiLRpAV1/CQcj59/DZljkyPmNPSzaVwOLim4u8
         1W0lI7/WxQCmmFsresf01BN78LLwvO2bffLT9kaNzfIFmgcZzog/9g4V6h9GYs8XiwE9
         b9mA==
X-Forwarded-Encrypted: i=1; AJvYcCXcjV5vic32dR2TbRmGu5QzTYsEso/YkCKx5gMJGmW6ySYu9MoKXNIVSPBXqASC7MGYso6jN4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnvw7/wrtkFUfddxfZ5uV5calCe9nyz0LnP3BRraQ9gSvodAA4
	rLLt3epzc1MuXz1Zn7N2RjR0+wlqO7TMudi89CWHbnwVAc8uBGSwvU4HAhQStJq45b3kdy7U4pe
	ULZTIXYCTqRiMFtg0Ow==
X-Received: from edon12.prod.google.com ([2002:aa7:d04c:0:b0:660:dc70:2f35])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:f816:b0:b83:b7c5:de2c with SMTP id a640c23a62f3a-b942dbcd35dmr433671666b.10.1772982532042;
 Sun, 08 Mar 2026 08:08:52 -0700 (PDT)
Date: Sun, 8 Mar 2026 15:08:50 +0000
In-Reply-To: <88bd0bd2-74bd-4795-be3d-c303c75eee7e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <20260307104131.4c1d0de5@kernel.org> <aayWSuOM59uojtuG@google.com>
 <42407d43-00e9-4938-8d6c-70d83b0f2ac9@lunn.ch> <aayphfkModIeENp3@google.com> <88bd0bd2-74bd-4795-be3d-c303c75eee7e@lunn.ch>
Message-ID: <aa2RAlWEKh-YUoqI@google.com>
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
X-Rspamd-Queue-Id: 99B5D230D78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265311-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 03:12:55PM +0100, Andrew Lunn wrote:
> On Sat, Mar 07, 2026 at 10:41:09PM +0000, Alice Ryhl wrote:
> > On Sat, Mar 07, 2026 at 10:39:28PM +0100, Andrew Lunn wrote:
> > > > > Please no duplication of existing code in Rust.
> > > > 
> > > > The plan is certainly to get rid of C Binder, but it was unfortunately
> > > > not possible to get there without a transition period.
> > > 
> > > Dumb question....
> > > 
> > > Why?
> > 
> > The reasons for moving to a Rust implementation are discussed in the
> > cover letter [1], and in my 2023 plumbers talk [2].
> 
> Ah, so you meant binder itself has be dual implementation for a while.

Yes, that's right.

> > No, it sends the same messages. The intent is for Android to move to the
> > Rust implementation without userspace being able to tell the difference.
> 
> Any reason you cannot use this Rust netlink code with the C binder?
> You can then throw away the C netlink code, no code duplication.

I think the benefit from that would be quite little. It would probably
not have helped avoid commit 5e8a3d015442 ("binder: fix UAF in
binder_netlink_report()") because that was a bug in the caller of
binder_netlink_report(), rather than a bug in the function itself.

And as for the benefit from avoiding duplication on its own, Binder's
netlink logic is very small to begin with, so I do not think that's
worth it either. It'll go away eventually when the entire C driver is
deleted.

Alice

