Return-Path: <netdev+bounces-265917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOgkAbTMr2nWcAIAu9opvQ
	(envelope-from <netdev+bounces-265917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:48:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ED72469BB
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B33E93029244
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34282363089;
	Tue, 10 Mar 2026 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9qU+g0F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906283624CB
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128864; cv=none; b=ThRw7EllcaaNTbdEvmc5K0XLt4fzHG9u0uY5w5K72XJFVrZ4sDAuum9hEZisIwkL8NYWQrOA7HX5x/twd0zms0Soz+Em9gb5WjZUwDGIildKMbx4d+EgC6Sr9/SkZLz51d1V9LNz3wRPkt8lBBwL+Qza1M4u7/pK+RLXL9lV5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128864; c=relaxed/simple;
	bh=CEMltqQW9u10Dc2iBNuTXi2X2wgdQ6LtEATQpEiFmIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GosbPChvvg6LuzkC3tABALpzoaN+WcpYbxkJ8CgBCaee2r5eESrytwb3pZ0bfZLXc8L1NhjhNUPePNbdc9PvqwO+BFnu1NPwR1IytTVW9COyi0DsnZqtp2RwDhJuXQZj6PT9xeMrLYV+lHW1uP7wr5uBE0R+A3EMBf87L/p+qXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9qU+g0F; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b96d8d60303so198702366b.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773128861; x=1773733661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXA6X3KJ8wqz98mCcEpEVMkHZRCBuaUnyvX8XE1PQJs=;
        b=t9qU+g0Fg35pqzgVF0KwcUYxr5CrkQ2lw8+6R71nPpEhzSqvJLx2qzMIsHCSAP9biG
         G1swGxvwSmr1XKQ1Y9XCk3yC8w79Hdl4AF19fXQgZRbeOJNMfvoalEopeJo9Nh2GU4ZL
         OsgA94v9GY5pKXkAgjeGUp63996z8XRbxqXlLU4vqaWGwvckO+cDtkul+gBS78A/YuGj
         oOI9EJSofRvcPtxFQIpFmo7VfvEtINJDGy8Ftf3fUOGU68d/3l1DrMaGWQPTdehcWNfX
         9Vky5JNr8ybVxh7A2pFGfZ3x/pZzVDPibbZvA/dn9QqPC34Ut9rwcDT5BT4QLgb5YKVk
         pq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128861; x=1773733661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXA6X3KJ8wqz98mCcEpEVMkHZRCBuaUnyvX8XE1PQJs=;
        b=lipRufCnJRfJunsmHBWxnU1RIt4rzDLkNrSVI7IQPY98CVJwgSbigD8Qs0j8OJWxnR
         nIXVA+PMeBuWjQ2K9LmNiF6Z4/W/7np8XJU+kPg/63al992qbC3cPM0Gy/5JegyEGks8
         rDrM1PzP8P6TT4sqlWv88JCSxqMzB326Ba27t5yZ9lfyFY/7ucHsThMggh65l9ADwFdp
         q/Q+cyUeFdhpuyb8iN4FD/R3kfyg6+laUrXPsiivbGreUOsOAdgaDj2Zrh3uUrW47lAN
         Q1AKf7n3Igy4bxXypr6X7XwaZGILJiPEiF21U4k4CZRXafYQ1rkKFF+Ri0EAap9XfK6F
         +f7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEvFcO7iusan3imqK/YRSNCbBhg/OLQRNjILoV6I4WKS8VQJufR06l9sja5fyyUJlXd8MbN5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjnxEPrBuaa7k9+/d6YpEgFpKyJpyqJ7F/po9zD0REkR5FfQcQ
	+6hYX7MznB2eZ2tSsRqN1d/U5PbCKD3HzKHYkzFGhSWteo/QrLv86hE4GefYIMKshjWZXaElj09
	0S04dS69e9xyGOfQ3EA==
X-Received: from ejav26.prod.google.com ([2002:a17:906:339a:b0:b94:578:d46e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:e117:b0:b96:f7c7:6233 with SMTP id a640c23a62f3a-b96f7c76586mr210194966b.19.1773128860572;
 Tue, 10 Mar 2026 00:47:40 -0700 (PDT)
Date: Tue, 10 Mar 2026 07:47:39 +0000
In-Reply-To: <20260309142400.596f5010@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <20260307104131.4c1d0de5@kernel.org> <aayWSuOM59uojtuG@google.com>
 <20260307135941.51353a4f@kernel.org> <aayrtyPKOqVGpich@google.com> <20260309142400.596f5010@kernel.org>
Message-ID: <aa_Mm3mHmF-eFh5x@google.com>
Subject: Re: [PATCH 0/4] Rust netlink support + use in Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
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
X-Rspamd-Queue-Id: D7ED72469BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265917-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 02:24:00PM -0700, Jakub Kicinski wrote:
> On Sat, 7 Mar 2026 22:50:31 +0000 Alice Ryhl wrote:
> > > > To be honest, I'm not entirely happy with what Binder is using netlink
> > > > for either, but it is what it is.  
> > > 
> > > If we're both not happy let's take this opportunity to find a better
> > > solution?  
> > 
> > My understanding is that userspace is already using or looking into
> > using the netlink uapi that Binder exposes here. I don't know to what
> > extent; it's not used *that* much yet, but it may still be tricky to
> > change the uapi at this point.
> 
> Let's explore it? What user space components would need to be updated?
> What's a better design?

Well ... the thing I'm the most unhappy about is needing to have a
userspace daemon that is notified about all transaction failures to
begin with.

But if you must have such a daemon, I think the netlink based API is
an okay way to do it. You can easily add new fields in the future, and
it implements notifications to userspace on our behalf.

Though using raw pids in the netlink messages is pretty ugly ... pids
can change, and the pid namespace of the receiving proc ends up ignored.

Alice

