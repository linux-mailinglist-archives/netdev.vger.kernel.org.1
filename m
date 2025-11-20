Return-Path: <netdev+bounces-240575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B5DC76609
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 22:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6A0AF2AE85
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0CE2EC0AC;
	Thu, 20 Nov 2025 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5LaptT0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD2D30BBBA
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674038; cv=none; b=Lg59DRRiRf6rRkLz62SG88NiTn3t6Al313GJLBEmwdiM5r9sZWe2AYVePte2JbGr2VYyNDCtn4By/U+3obIi4j/DHukBdKAxbcDWXQVaafkyRDTM8ErhOwCH8AAOhQMDf3waY6K5dPG9yr1+Kcqwkvo9ARwQmK8rBlCPdUpRoV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674038; c=relaxed/simple;
	bh=tK/h47AtclL63MsiZIw5DLkxiAtWxUM5WBuqmUYCwpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNeUHP8uds8J3ieZ1TJzpteQSKBwCuGysLhueQD4oZRlO00gEouMi2yT2Oin5tbGId0btmZx/tGh63AlyRSa2WdCjabq8/LLd2mv9WDFvBGQ2ctdegWBsV3HisJuQ8BaR2Bh3sYAaXlEhvFjbPPcbf14O3g3Z9YnxdcGNz9VTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5LaptT0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47755de027eso7932685e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763674035; x=1764278835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa7KQe8aI04mw6svA4KQsLLzNLWFcPgdOgxNPPV4Iks=;
        b=c5LaptT0eaa9zxmP8xtUATMo/MZgv27A4XQmGpCIuvJqzxESAPOBkhZ29IZe40f0IO
         y/P95uGCsa1rm0kdQ9MukucZ/M/q49F8ovXkfOWs33yx+G3hNrCVPlN7Fsza/DUEdRU1
         LflsA4NloCoECLcQy81Ot8hallv035W0YuMAZs/PA6MMXIa301DQWrbp/zo/1nAPMxGS
         I8MKksFBlTSvyk7MlEnGMhLp0+AcoSl7orOMux/9iXubawJNy0RpxEE5vYj9vhcOw7uf
         7koyf+bOvueadVtJszlVx3ZTxXf1nhr+g1SyhMGbQmgKWmCNcoOC9pT8PUlID9gaZIwy
         Ozng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763674035; x=1764278835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xa7KQe8aI04mw6svA4KQsLLzNLWFcPgdOgxNPPV4Iks=;
        b=q97jIWFStHNghVhn/vrpt5gpwjL6poRJEILbdbN+x9C7bkasd6PZu4BnhgWLUZ0gok
         Sd2opxbDK7Thv9rhA9yFpfMYjqBUnbjvRJB6HZ7V2wqiPpGcLt3ucnES1DfcsJU4DpxS
         ofkYzFzOFZeFC0fisaPAzkFk/MLE2MaNIssutSy1De1MTHAgmoFyLxvCH/uQU9m6QtZY
         RU6BHcnK+KSe+AMbAw1iZGWQjsDXC2MeJPHb97ULr25eeK3GfLeEZAwhiRaYGnyxB23L
         Gg3d7eU/5qJdOqmBdpfkRi+AZHqvUJdPOH9B3IZYHI7UWPjkRwOhGmGWI6kTkPjoSYQp
         7Sng==
X-Forwarded-Encrypted: i=1; AJvYcCVKlepcUeeO0+9cbu3TKGvcdC6O2NWKgXohNQpu9uxroGIFJIq4M0pidaPf87qzYPtOYe3tRow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyics0c52cN7Shecw7dkNorPPbNbsktIx4gpE9FOLhRtIU7il+7
	C57jDE2AqR0Hij7s4NM2u0q8Kq5iGBWenl2spR1TOkcdoY8LK3tZTdm+
X-Gm-Gg: ASbGncsBPAdyNa7qg3dvJBx/Ppuml40fONFMgcCTHnO/q5f+Dhy0vvZQQg3jBaQis1n
	uStUYyLPQWXRpf+Ic7DRHW8xw6j4txBgbW/Vx0Omtg6o4OmeBFWURweeiukhyyK1nqKEhdObpZc
	gADX5eNGTASER/uv3BNTfQ0QDp9VEx30tEJKxMtQVBzMgZ6pMtKOVH5KvdkkSSi/nSL8pTqlL1V
	RsdoPiEM32M9BHvnmWzuy95YDXyTO/z0csPA94i3vRW0FYwYWnTj4Sp5hB2R0ylSViH3O5qhbD5
	Uguy6Qqxyo7XKdK03zTlVzRhIpnEAzD5b1jRdeB/jkWVZfNc3b9f9Rbv/Mwh1lLje4/Eb1OVVQt
	Y8y12UGyXWJGSPongNqwsbk4FWPKXk4lsdjMFlcat8gx4a988rMhGxI+DRoIfqTDjSA70VxUn9C
	1KWB3ipPnJ1SugbB+26xM1tDLNBq3Pq/RAoXOAFWyAFvZNGCPjUVnh
X-Google-Smtp-Source: AGHT+IF/A6M/582nmisb9bdwvtoe3obapWUpVz79PqZr6Va3/ErJUSniRW0f/KHs/h0vZr1g/U6e/g==
X-Received: by 2002:a05:600c:1d01:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-477c016bbe2mr1282195e9.6.1763674035188;
        Thu, 20 Nov 2025 13:27:15 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cbd764dbesm4251621f8f.27.2025.11.20.13.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:27:14 -0800 (PST)
Date: Thu, 20 Nov 2025 21:27:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring
 functions with __must_check
Message-ID: <20251120212713.240fa185@pumpkin>
In-Reply-To: <CAMB2axPqr6bw-MgH-QqSRz+1LOuByytOwHj8KWQc-4cG8ykz7g@mail.gmail.com>
References: <20251117191515.2934026-1-ameryhung@gmail.com>
	<CAP01T74CcZqt9W8Y5T3NYheU8HyGataKXFw99cnLC46ZV9oFPQ@mail.gmail.com>
	<20251118104247.0bf0b17d@pumpkin>
	<CAMB2axPqr6bw-MgH-QqSRz+1LOuByytOwHj8KWQc-4cG8ykz7g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Nov 2025 12:12:12 -0800
Amery Hung <ameryhung@gmail.com> wrote:

> On Tue, Nov 18, 2025 at 2:42=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 18 Nov 2025 05:16:50 -0500
> > Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > =20
> > > On Mon, 17 Nov 2025 at 14:15, Amery Hung <ameryhung@gmail.com> wrote:=
 =20
> > > >
> > > > Locking a resilient queued spinlock can fail when deadlock or timeo=
ut
> > > > happen. Mark the lock acquring functions with __must_check to make =
sure
> > > > callers always handle the returned error.
> > > >
> > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > --- =20
> > >
> > > Looks like it's working :)
> > > I would just explicitly ignore with (void) cast the locktorture case.=
 =20
> >
> > I'm not sure that works - I usually have to try a lot harder to ignore
> > a '__must_check' result. =20
>=20
> Thanks for the heads up.
>=20
> Indeed, gcc still complains about it even casting the return to (void)
> while clang does not.
>=20
> I have to silence the warning by:
>=20
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Wunused-result"
>        raw_res_spin_lock(&rqspinlock);
> #pragma GCC diagnostic pop

I think the simpler:
	if (raw_res_spin_lock(&rqspinlock)) {};
also works.
But I'm sure I've resorted to crap like:
	x +=3D foo() ? 0 : 0;
and/or:
	x +=3D foo() =3D=3D IMPOSSIBLE_VALUE;
and/or wrapping the call in a static inline function.

It is all a right PITA when you are doing read/write on a pipe
that is being used for events.

At least no one has put a 'must_check' on fprintf() (yet).
Code that looks at the return value is usually broken!
(hint: you need to call fflush() and then check ferror().)

	David

>=20
> Thanks!
> Amery
>=20
> >
> >         David =20


