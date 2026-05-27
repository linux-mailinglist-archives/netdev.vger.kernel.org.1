Return-Path: <netdev+bounces-292237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DRyMBTCFmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:06:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE955E25D8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27BB130DAD04
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA13EDE7F;
	Wed, 27 May 2026 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crkznwvu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABAE3ECBFD
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876048; cv=none; b=bieUqJ+U0JacjuGbWdeO3QtIL3skuW7NlcNhMLMrQkmOzm8slj0n5lYgLUpVmOvk+g3OMGn9q/z1B16rzzn8towpO9nBZ5QAKdFkBPCGnvHg2MGQLx8fEYGlnj3vO3TPaOn2pViJjldGbIfI0FGX31WgYb3PdglR1Zf0n8msx5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876048; c=relaxed/simple;
	bh=EALKIjV6741ShbozP3pzBJI6TCQdg6YABZXuAUMU20A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rzqNiiX0Jhlm8jFtcXNwwpXGKZou7V2sImasMSQmhhTTZuRwTeEh7IdV2FL9IepMEGZ4MUT5k4ifmoht+N0kvlfG6BhQPuFhOtmQSz/8oLnogBZqvWoIhgwmBPXrSuc0uVUd54SH54yk4KLo5ZcX3QFa8bdZLJ22fcWbUsgthSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=crkznwvu; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48fe24773c8so60605995e9.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 03:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779876042; x=1780480842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HybpFb6d1l31Aoue0OxjoI6wFbeps3Bhk/YBv4itmA=;
        b=crkznwvuLRvdLfdj3ryaAn+fcfcYslz2uBgFQ2B4Ytv6lCenY45doaq5QzNEgSu1jr
         NzWHFGFu2GwaMniwr9Tud4AEDh53i3Tc4M0BcEHy32cibMYvQFRfGPBz9Ud23Wc8nwIJ
         qVkiLXL6XEmpBWHZqLk2md7x1iA+5/1BVb8ClCoIUggAc3ozNoxcw+gzUTYsqp/2XkIk
         RUDuPEBf/256K8GOThOBrwRVR8qMnv1DEjprv/R60Y9P0EXFjLUEMA0bb24vlJwjkKwn
         NmmWlFf5o/aYOZnK5ynWilQU+pWHE745M3Eszn7lSGzrphRQ5jCa6XZnBkejE5dN1Gxl
         gsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779876042; x=1780480842;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/HybpFb6d1l31Aoue0OxjoI6wFbeps3Bhk/YBv4itmA=;
        b=nZPBAuqW9S7F4+N12yxhtW0HcpiJdtEBHGeWY+zuuvUn1h0QocSc3jHkG1ZnoANLOQ
         efan/7H9TzalfbwsF6YKI4/ohC11SZLLZQusacMOSk6GDeRKqItytVOXVxUaTv7ZF6w4
         Jc/0neJI6GDBELqx+yoHB3e8FTU7DQCQUBzTsYXy6MY7YPrxet67a1FjCabdsNykk8fo
         KEED770MuQpqjWC6LFS8BO9dl7CE4XPxfVotZeCe5cumef5H7bnpXH9EKGRicR8+/5WE
         cGKrW9SF9PEIBq1Nqhod9Qocbv+mZMp/cN8i45xMzFk7rv6XnGYmG+ceenzJggia+7fb
         kR+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8sP2TD9rB4X11WmaZ9iJKoiSbUgb8YXbAjX/AD5xFuA2xXfskrBs3pBYhf5pzVKvC2veCCmfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyej0Rq+wov8gtePjBfu+qjtt7dYcJdXdKKaCmHWtD+qPdnBUW
	ZD1gtP3S/wcShQHzBKy7RMXTcq+LI5eR40cz+l8b3tAttK9TSQ+wVKJBLav+oMpXJ9uYqmmoNaB
	bxnIycnBoevYUfpqliQ==
X-Received: from wmqh19.prod.google.com ([2002:a05:600c:3513:b0:485:3bc4:b1d6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a402:b0:48f:d1c0:721e with SMTP id 5b1f17b1804b1-490426b294amr256811665e9.12.1779876042131;
 Wed, 27 May 2026 03:00:42 -0700 (PDT)
Date: Wed, 27 May 2026 10:00:40 +0000
In-Reply-To: <CANiq72kRC_k1cnJLmG+AUSiUH6kDXVsox3nMJnV-c6HkNXOwBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525-binder-netlink-v5-0-a90e2923ebeb@google.com>
 <20260525-binder-netlink-v5-1-a90e2923ebeb@google.com> <CANiq72kRC_k1cnJLmG+AUSiUH6kDXVsox3nMJnV-c6HkNXOwBA@mail.gmail.com>
Message-ID: <ahbAyBD584Hk9Mst@google.com>
Subject: Re: [PATCH v5 1/2] rust: netlink: add raw netlink abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>
Cc: Carlos Llamas <cmllamas@google.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292237-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linuxfoundation.org,lunn.ch,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,redhat.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.605];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3AE955E25D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 04:29:26PM +0200, Miguel Ojeda wrote:
> On Mon, May 25, 2026 at 3:17=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > This implements a safe and relatively simple API over the netlink API,
> > that allows you to add different attributes to a netlink message and
> > broadcast it. As the first user of this API only makes use of broadcast=
,
> > only broadcast messages are supported here.
>=20
> >  rust/kernel/netlink.rs          | 336 ++++++++++++++++++++++++++++++++=
++++++++
>=20
> This should be added to an existing or new `MAINTAINERS` entry, i.e.
> as usual, either inheriting it if the maintainers want, or delegating
> it to a sub- or co-maintainer, etc. depending on what people want.

Netdev maintainers, what do you prefer that I put for these files? I'm
of course happy to be on the hook for this code.

We can either add it under an existing entry, or we could add a new one
along these lines:

NETWORKING [RUST]
M:	Alice Ryhl <aliceryhl@google.com>
L:	netdev@vger.kernel.org
L:	rust-for-linux@vger.kernel.org
S:	Supported
F:	rust/helpers/genetlink.c
F:	rust/kernel/netlink.rs

Of course, it would be useful to have others listed here, as I'm sure I
will have questions about how networking works if there are patches in
this area. Or perhaps the netdev@ list itself is enough for that to
reach the right people?

With regards to actually merging code in this area, then I think for
this particular series it is simpler to let Greg take it through
char-misc with all the other Binder changes. But for any future changes
to netlink.rs, I think it makes sense for them to land through the
netdev tree.

Thoughts?

Alice

