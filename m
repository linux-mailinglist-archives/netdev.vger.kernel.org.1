Return-Path: <netdev+bounces-107665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC3991BDB0
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 13:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E879A284B87
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2061D156C65;
	Fri, 28 Jun 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXJC3Gdg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5FD156241
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575103; cv=none; b=soabfGtTxJy28t7V6dsOCixDohntfa9GDwLSCJYPdnwiT9qF0+KyLg1BidOlLG/3xC4JQycwEei+tzffQpWwhMn4k8uQfS2JQoxPwLfSzNc+pxzDvp4AROmXbhI6aJPNJPYGeqHGqe+Yu/49ShpERNnFlk4L1smSCsoWZ1g+x10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575103; c=relaxed/simple;
	bh=tCbwvqL2j8l+v/7DM8z0RLMLYqxbX6isQPdQ5BDuw2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFmfO5D2an6I/AvMcgFXfnoX2t9UvliUG8ElIekXf8c12bN+hhwkKFNc+yAbx+u+1qGTzqah4QqSHEQAvcEFWlmQT/vDBV1hPCu+QkWuUJUgFDG38agPjffSIh43cvK7M4Gskm6+H/sIXmSoYrxs+qD9qX84ffd/6ZI/EAUVN8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXJC3Gdg; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-48f43c388f5so132467137.3
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719575100; x=1720179900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vairtunRTij7/0Vlw0E0dL9DdjrxaP4kLZmLM1W/7Lk=;
        b=dXJC3GdgF75uSayigFQzh4HgMzWoAN6kG0o4aElv5CDot25LP4hLuE+66IitmK79uS
         eT2yjV/UY9aiJk47eG3ZILGORatEtMTN629B3EvohFW8Dw+pQzhxLrRSPcuUOJRn1Lyw
         EiucQq9cn5m1kJSE/qXTz6XBzKBKspJDT25d1wI7tD9jSmE2kZYVBw4xYDjGZ/cgXh2I
         /QPcf+5FZxI29fufLyblsraKTRTOPTWqCuVOyYQniUY7+ZPoi7pP0f83VxM2/m/qg3K/
         k8jH+4lR6LnWWtPpI2X+txZA9ww+7j6Ng/Fh8ezbzec0OB38IGbcygtwSpJav9+KjmcN
         ETaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575100; x=1720179900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vairtunRTij7/0Vlw0E0dL9DdjrxaP4kLZmLM1W/7Lk=;
        b=BqhsEyCEPpERAa6SZAQ6/spe4GaB2cmIGSKW737DOxp6jtLXlL5BjZSb17pxrxb0yY
         1o/Chs24cfAqO+bFiSeUMYxgQqH+EqNgXn6amlGgJ/4Q7nF8I3IR7VpRQhuX5yLUZSVY
         EuB4FAjzGjK3Hw28YZMVMSORtrhFn23n/yYf0Zt+eSNacxFAAxpPJ5n78AcdntpJijyt
         sZNQYrhJWisv8mIYZRlndbtyUZrwWDbEakX0XH9DSe8IFbdsgZ75Yb7PlBwBEfAQL4RH
         xlOGjDZerqj49wlu6xe22sqcXtGA+lXZf3aHVfe+Y0gghiU+2TBOwwjJiHgLfmwRQ3kX
         CBvw==
X-Gm-Message-State: AOJu0YxlSHzzv2qu/lfdT0XXIDtajEWDrC7Xsv0shx/QlfXj2nYGoG1g
	uJOYrqgkI2/aJCZ9jH3QvcIxdGk1fAL8KOmy4b5Ec7+ZUtCOaLxBoogu9ncpv+T4qxhkzxriN3o
	jLPC8RyjiGRRuKndwKExYLG4A88Q=
X-Google-Smtp-Source: AGHT+IG71eeFzXYQ5hyuYGneHARn3ep2RQKhwMBaLsk50SsnDDJ9gys3RYtZ7AJha83RK+iRatsKdx9dhcEGTJO9sf0=
X-Received: by 2002:a05:6102:6cb:b0:48d:d206:74b0 with SMTP id
 ada2fe7eead31-48f52bb3ba9mr19141109137.33.1719575100287; Fri, 28 Jun 2024
 04:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZuGQGM+mNOtD+B=GQJjH3UaoqUkZkoeiKZ+ZD+7FR5ucQ@mail.gmail.com>
 <20240628105343.GA14296@breakpoint.cc> <CAA85sZvo54saR-wrVhQ=LLz7P28tzA-sO3Bg=YuBANZTcY0PpQ@mail.gmail.com>
 <CAA85sZt8V=vL3BUJM3b9KEkK9gNaZ=dU_YZPj6m-CJD4fVQvwg@mail.gmail.com>
In-Reply-To: <CAA85sZt8V=vL3BUJM3b9KEkK9gNaZ=dU_YZPj6m-CJD4fVQvwg@mail.gmail.com>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Fri, 28 Jun 2024 13:44:49 +0200
Message-ID: <CAA85sZt1kX6RdmCsEiUabpV0-y_O3a0yku6H7QyCZCOs=7VBQg@mail.gmail.com>
Subject: Re: IP oversized ip oacket from - header size should be skipped?
To: Florian Westphal <fw@strlen.de>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 1:28=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com>=
 wrote:
> On Fri, Jun 28, 2024 at 12:55=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.c=
om> wrote:
> > On Fri, Jun 28, 2024 at 12:53=E2=80=AFPM Florian Westphal <fw@strlen.de=
> wrote:
> > > Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > > Hi,
> > > >
> > > > In net/ipv4/ip_fragment.c line 412:
> > > > static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
> > > >                          struct sk_buff *prev_tail, struct net_devi=
ce *dev)
> > > > {
> > > > ...
> > > >         len =3D ip_hdrlen(skb) + qp->q.len;
> > > >         err =3D -E2BIG;
> > > >         if (len > 65535)
> > > >                 goto out_oversize;
> > > > ....
> > > >
> > > > We can expand the expression to:
> > > > len =3D (ip_hdr(skb)->ihl * 4) + qp->q.len;
> > > >
> > > > But it's still weird since the definition of q->len is: "total leng=
th
> > > > of the original datagram"
> > >
> > > AFAICS datagram =3D=3D l4 payload, so adding ihl is correct.
> >
> > But then it should be added and multiplied by the count of fragments?
> > which doesn't make sense to me...
> >
> > I have a security scanner that generates big packets (looking for
> > overflows using nmap nasl) that causes this to happen on send....
>
> So my thinking is that the packet is 65535 or thereabouts which would
> mean 44 segments, 43 would be 1500 bytes while the last one would be
> 1035
>
> To me it seems extremely unlikely that we would hit the limit in the
> case of all packets being l4 - but I'll do some more testing

So, I realize that i'm not the best at this but I can't get this to fit.

The 65535 comes from the 16 bit ip total length field, which includes
header and data.
The minimum length is 20 which would be just the IP header.

Now, IF we are comparing to 65535 then it HAS to be the full packet (ie l3)

If we are making this comparison with l4 data, then we are not RFC
compliant IMHO

