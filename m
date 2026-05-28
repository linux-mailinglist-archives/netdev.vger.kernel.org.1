Return-Path: <netdev+bounces-292566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NXcOfrfF2riTwgAu9opvQ
	(envelope-from <netdev+bounces-292566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:26:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EE65ED44C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 705923025494
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 06:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348B331A78;
	Thu, 28 May 2026 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwRmDNyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09C330B0E
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949557; cv=none; b=MSQRjbxwo76Om4iY0JXvCcEZQDasRgMVZ2+O1heGvTfoXbRG36GCxXNVWTruZoElW2slucnLfYsnrmTT3bYrVJDDCNpq6e+DULLYkN1RKxIcn0Li5Xj6wN/54/xtmrKYVeaDx+cttVQViHQKDE4o3K9ki+qaj/+Ix2PYGQ6Ipcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949557; c=relaxed/simple;
	bh=2ju0gi2msI4LA4jLVYYeoWcL+MgWV/250G5FJn9IDHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PdmB4gpgrK4uRq8VDIbKgcWO0ZrjUcWZWn7alqLciWnRiRB8wyO4pFE2uWNHtxkVt4RJ23AQdQ8kCGVC3EFPJUpUYVs5i87aHZSh6M6qaVKnf1fb5efxfiiUafcgEwmqTGifH8+R7CucKBee4EfJ/3qJ2jKkOyBk3rs0BoZ1nuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwRmDNyi; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49045243094so83513275e9.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 23:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779949549; x=1780554349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Osc2OSTyPqT4oi0FZ2bdQ3RgEJRcoTvJK8RojzOLg8E=;
        b=hwRmDNyicPEimEagV4/T1v11KjabZeojN9RkLmv6ynzkg7a7G6v95QUT0HO+iMrOlO
         pixAaOv7umIRemdjfizZrDPDnwhQyPmxeAEyHzznGxibtq1N3b/8xJ3ZlZTDss7cgHa7
         TvyrMrlQpNvt8hrMWUWln1weYj4CLBgznB1tIwpVOLlqVs5AwtKpT+iYd8SAGxCoQw4N
         BO6zbbknXgWwL+YF9oVc4PlxnszQlP/b2VLAujGGbiVFrE+OSfHRvy7oIl0NRnul3OHr
         df+1yaAwi4cW9SpdeH3M+oSxR8B//xPseDeH1G2LtDWnwJ5aG+ULeI0fgQIjzSOnaSC/
         qBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779949549; x=1780554349;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Osc2OSTyPqT4oi0FZ2bdQ3RgEJRcoTvJK8RojzOLg8E=;
        b=W3+3C0cv9+Edw/bOyysEjN9ILeSVXuP1SO7xaVVJ9uXryusfcic5hheXyz1Z0SCCjY
         4tF1jvgdThXf2MinWsP1n8iXtaILyCYRmSLmKkCJm70yMZ5V3SZ6tAoEKbQ5eVVjNLpT
         5BoDDospqT7wNAbwszDLZxuUtGOLgzamMmIqGawcJNpEc10Fi/VWdfOwERXrEPCCOFn2
         gpavWTcsar8zis44izkXsP0U+JUgCdYi+At2Z+rIIeHcQ3m61s3bVzOxYhrNEXnzOSSm
         UsfnXILMck08bVh/mFG6qlr5dkySU8ULHTm4SC2w1TN0LvKrSRymkqchPjS5uGL0wRNu
         CpmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mfG13oxVk0XymMEm9fuCulLrL5+FA5fYstO3SRqd9bflDcTftivi5pn/M8FWEmvEvdk7BjdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUjKuTHn4VBQ1n5pxYKTdjnFSuOpEI801qwWoiL2yMwSoHByb
	oi1ka7OawaGdF50k6EnDWTdjA7ord6FCnBq+ZfZ9fl/jEyUe3cBaP47h4/qewsq8wCOwyDmYGZ5
	TxFan3e2OuUaF988R1w==
X-Received: from wmsl24.prod.google.com ([2002:a05:600c:1d18:b0:487:3739:c5c4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5254:b0:490:484b:bf41 with SMTP id 5b1f17b1804b1-490484bbf7amr427484645e9.6.1779949548810;
 Wed, 27 May 2026 23:25:48 -0700 (PDT)
Date: Thu, 28 May 2026 06:25:48 +0000
In-Reply-To: <20260527192130.21dabf08@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525-binder-netlink-v5-0-a90e2923ebeb@google.com>
 <20260525-binder-netlink-v5-1-a90e2923ebeb@google.com> <CANiq72kRC_k1cnJLmG+AUSiUH6kDXVsox3nMJnV-c6HkNXOwBA@mail.gmail.com>
 <ahbAyBD584Hk9Mst@google.com> <20260527192130.21dabf08@kernel.org>
Message-ID: <ahff7OTzS46Rti5c@google.com>
Subject: Re: [PATCH v5 1/2] rust: netlink: add raw netlink abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Carlos Llamas <cmllamas@google.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292566-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F1EE65ED44C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 07:21:30PM -0700, Jakub Kicinski wrote:
> On Wed, 27 May 2026 10:00:40 +0000 Alice Ryhl wrote:
> > On Tue, May 26, 2026 at 04:29:26PM +0200, Miguel Ojeda wrote:
> > > On Mon, May 25, 2026 at 3:17=E2=80=AFPM Alice Ryhl <aliceryhl@google.=
com> wrote: =20
> > > >
> > > > This implements a safe and relatively simple API over the netlink A=
PI,
> > > > that allows you to add different attributes to a netlink message an=
d
> > > > broadcast it. As the first user of this API only makes use of broad=
cast,
> > > > only broadcast messages are supported here. =20
> > >  =20
> > > >  rust/kernel/netlink.rs          | 336 ++++++++++++++++++++++++++++=
++++++++++++ =20
> > >=20
> > > This should be added to an existing or new `MAINTAINERS` entry, i.e.
> > > as usual, either inheriting it if the maintainers want, or delegating
> > > it to a sub- or co-maintainer, etc. depending on what people want. =
=20
>=20
> Good call, missed this isn't under rust/kernel/net
>=20
> > Netdev maintainers, what do you prefer that I put for these files? I'm
> > of course happy to be on the hook for this code.
>=20
> Can we put it under rust/kernel/net and rust/helpers/net ?
> And then add those directories to networking ?
> Just so that we don't have to keep wondering with every little piece=20
> of code.

Sure, will do.

However, it doesn't look like rust/kernel/net/ is listed under any
MAINTAINERS entry either.

> > Of course, it would be useful to have others listed here, as I'm sure I
> > will have questions about how networking works if there are patches in
> > this area. Or perhaps the netdev@ list itself is enough for that to
> > reach the right people?
> >=20
> > With regards to actually merging code in this area, then I think for
> > this particular series it is simpler to let Greg take it through
> > char-misc with all the other Binder changes. But for any future changes
> > to netlink.rs, I think it makes sense for them to land through the
> > netdev tree.
>=20
> SG, once acked it can go via any tree. Greg's tree make sense.

SG, thanks!

Alice

