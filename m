Return-Path: <netdev+bounces-218991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B93B0B3F3DD
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 06:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2977A4F13
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 04:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C172676C9;
	Tue,  2 Sep 2025 04:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ish/7crU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542C1DDA0E
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 04:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756788892; cv=none; b=qNxkwyJv3xHXe/CgoDkuAyaLWy0i7Dtqbwg6Bu+vENYdM+GTim1pf2c0y1zPEcEgwKBXhVN6NhbTzWgteud7QdDSaVbMS1BDQrQQvfGaTGo3KQdzqPEx33zgXHJuQ/pEQqTzBslwdqBoeK+w1zhVKPcoeXCb6Bw0JHog27ejPbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756788892; c=relaxed/simple;
	bh=72IhmJ6RIfLV7jI/e78WP3nbD5d4w8Qq8fRB98ssrss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2eviZutL04wBStTUdENaNHjm4hefJbeUdnKivxs3iKEJknoRXI6lGd9qLOjHJwd/tiEnZd0f7eIdCIphwT2i5jA921VtqvMhJ4I4mDjq9yFoAxlmz9AoHEu5bl32L2dCh89e5KLZhHi3uwcaZpQsPf0QMna0fTo9njooZU+uJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ish/7crU; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Aj+19BNZQAJQEnx9NIIxJe/jwS+rvqdX2kPfnDEUW5Q=; t=1756788890; x=1757652890; 
	b=ish/7crU8HPNKkwGzAcnFgpgut4O+FHmFnRlIGu49KcQrPjU9a86OKb/3WFrHdEKmbDzFQMuOhA
	KuohrktyVWUElgupJ++lBLK+7H3t1R1Bqf31tDGNwPjq5+aPZHx1nzX0CcudrRztqzCHdEsPUX91D
	gsPFV2UOqeM8kjtqrpc/alDC1lkNmABRh5lld0FpDHx8ihyGuUoDEn8YsRgQR8OYAqKw8Ck08FyhE
	07IhErPY8FJA+O0rHRP/H7upiTx+ULp3EZG+NUzmnZSK7bPfbZ5jzTwu21+hu/+ULzwh06+ODCYjh
	xFCZa2aRnVW1wsADU1WbJmizprLdgIQnf3fA==;
Received: from mail-oo1-f46.google.com ([209.85.161.46]:54406)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1utJ2Y-000409-Qn
	for netdev@vger.kernel.org; Mon, 01 Sep 2025 21:54:43 -0700
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61bd4ad64c7so1500172eaf.0
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 21:54:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPuKLbqOtiF5IF27+1mWxe0YMLZUWy5hibJFnAapTnfMUpV3CzvQ8kvrZtUMSxGfh2dRPxNKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymncEP1Ek0OsatjJ3k4gh/U6HPrnTAztkc3lW21vH4E8uodI1z
	9UXGfz4M+1FWYHYa7ivpKkcvPxvtyk2bAOceJVpbFjseNfBpFEJhZbfbJex6iwkjx5hSoQ6pzaE
	CLUvIn1O1wtyBqC5Du47wHHHepKEwAVo=
X-Google-Smtp-Source: AGHT+IFvD8bgEGiZG0joeKVlTG89zGehV4u9JZkaAIruUUL9UoDL2yFgD4ufE6BSQhVAot3AhKOWYWi8nTrrMX7vpl0=
X-Received: by 2002:a05:6808:48d6:b0:437:d7b0:878d with SMTP id
 5614622812f47-437f7ddeecbmr4427628b6e.50.1756788882172; Mon, 01 Sep 2025
 21:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-15-ouster@cs.stanford.edu>
 <a2dec2d0-84be-4a4f-bfd4-b5f56219ac82@redhat.com> <CAGXJAmztO1SdjyMc6jdHf7Zz=WGnboR5w74kbmy4n-ZjJHNHQw@mail.gmail.com>
 <04716a9e-9dad-47e6-9298-5b5cf6efe7cb@lunn.ch>
In-Reply-To: <04716a9e-9dad-47e6-9298-5b5cf6efe7cb@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 1 Sep 2025 21:54:06 -0700
X-Gmail-Original-Message-ID: <CAGXJAmwwKu_yUW_vjXhT64+QPyZsHpgqLtih6coQKqgOVC+0EA@mail.gmail.com>
X-Gm-Features: Ac12FXybycDPAxQAmpiOJOBaWbc4dy5lcMS1e9zJnm0CKeT2ywxMEFPTsaB23ow
Message-ID: <CAGXJAmwwKu_yUW_vjXhT64+QPyZsHpgqLtih6coQKqgOVC+0EA@mail.gmail.com>
Subject: Re: [PATCH net-next v15 14/15] net: homa: create homa_plumbing.c
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Scan-Signature: 2d1a4fa5d0150c38835749a59b44c419

On Mon, Sep 1, 2025 at 4:03=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Sep 01, 2025 at 03:53:35PM -0700, John Ousterhout wrote:
> > On Tue, Aug 26, 2025 at 9:17=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >
> > > > +     status =3D proto_register(&homa_prot, 1);
> > > > +     if (status !=3D 0) {
> > > > +             pr_err("proto_register failed for homa_prot: %d\n", s=
tatus);
> > > > +             goto error;
> > > > +     }
> > > > +     init_proto =3D true;
> > >
> > > The standard way of handling the error paths it to avoid local flags =
and
> > > use different goto labels.
> >
> > I initially implemented this with different goto labels, but there
> > were so many different labels that the code became unmanageable (very
> > difficult to figure out what to change when adding or removing
> > initializers). The current approach is *way* cleaner and more obvious,
> > so I hope I can keep it. The label approach works best when there is
> > only one label that collects all errors.
>
> This _might_ mean you need to split it unto a number of helper
> function, with each helper using a goto, and the main function calling
> the helper also using goto when a helper returns an error code.

Unfortunately helpers don't help. There are already separate functions
for the individual initializations. The problem is with handling
errors in the parent. If a child returns an error, the parent must
reverse all of the initializations that completed before that child
was invoked, so error handling is slightly different for every child
invocation.

-John-

