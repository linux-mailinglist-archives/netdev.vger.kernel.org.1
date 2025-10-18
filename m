Return-Path: <netdev+bounces-230677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8036ABED1FA
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 17:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BC35E3EE0
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 15:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEA71A9FBF;
	Sat, 18 Oct 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6ME7jkG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6027462
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799967; cv=none; b=kR7cOs+V/efJkyRFms9E6l1UJROQPLEJGy8s7MrflEGIewh7Nk2G9PoAr6KcLs6eXbTxqtzdndTWukcpMrcaz7Ahsqsf4cMIXI0tStVLYJjQDhxXTnYwrlJHxiHOzllc1UC5VFQD3QZeMZkAxtu/SfiTYE2n0Fw8whqqsaSbKC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799967; c=relaxed/simple;
	bh=ZyvjCPO/DXVQM8YwuZEJD0JqI8HSEb46tVTufAtomWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fy83+0itLubxdQrl3V7YB0J7d0TVV6VNdHrJtBBceNrsq6JV37pCQiBQA9asGc8rclE6beeZCxI7fcOWd6npNb0rOmvnkyfWbqnuwz7Mvo5y9kvc8aQiCCcYERKAnfFDsrWL0zvQvogjmgdjeX6e6uRB9SZFtbd3GDqAQDUZ5mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6ME7jkG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57d97bac755so3839e87.0
        for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760799964; x=1761404764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSPOiZ7jNcagXuc9lWkglLdnTNQHlNGICFG0e3VfcRw=;
        b=Q6ME7jkGsm6mkgeROvptigGebUJofPQIBPkJZyGsxHgnTqfPuzCWoGOkOLpVWyhk+s
         qDpRrX0CsfdOznkp45d5JQBBBbeelXxm76/ZjBYTQ2kdiDFmRApJ9eOtYkYaBzfVJnwT
         qd2aoLatCZkf+GQO6/a5NZbTkXzgbZHE0pmWCGYoSABnl798V+xDMhLgxU8PnJFecFLj
         q2XCuq9TmANzKzwo+daHXKsxpZXZaHrlcxGLTDUt20szV53Yy7UqSWJ6BbjzQ5Fe7l7J
         fh4B2V8LA7EtMQ5g5L85MCzKmO9gruOZFa383QsMXfrwaAFgd42yAHhz51ue+LqbhvY9
         nyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760799964; x=1761404764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSPOiZ7jNcagXuc9lWkglLdnTNQHlNGICFG0e3VfcRw=;
        b=fYZYjMIk2ielLPnKB+lUffCdHgjsz2VYbj7ML9/4bR0u+aXKjB8wFPpsKG4xiZZzRk
         RKfizA6ZoOqhU2c1wIyPemhOv2CoQ3SO3SAOOe47gg0+n6q1/yXKudObTZSjPyLXXZMq
         kP9yvr5FpPh8omeqlmddxH4bY0QC6CXhLa0MhW3H6LY0z/ECJWcdp3i0TwL0rb+i45X0
         VAqAJcIEZoWsSVPjD51ZDKxNLmmuTzrIqE6fa7iqA+0u15eNW55ZxP4DQeXpuuLBHFJu
         FunHyFIUba6Q3pfe6Q3UgSWKY1CcZalz+ncu9+VABc3mokBPldyVXBg1Rr+C+pGCvEVZ
         KpDw==
X-Forwarded-Encrypted: i=1; AJvYcCUZLkeYAwJbcSolNARYVaVoiA7UUd9FTJkpjV0SU8mH34mNqcNhCifZjwk/ZQMAF2HXHnQ1804=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0T66HE9jlyVgn1quZxNk9T2e3/eztY7PgS/JG95fQUbDLL7dg
	S+GXENARwtuPreUQnA66ksjygKefrR/cQ/4WuQnze9qgYdi/Er7XuoZh/4EJSWuY3UW36tbe7/g
	BlmSR9N9+S/gvwVAVaSnHim02uUH5lq1fS72CdZIL
X-Gm-Gg: ASbGnctaiQU3zKdym0ySmUcIwAfzrvYDGS8bPP3m7LYYz6r+X+NZnGsAQwDbg4ie7pA
	JYL/nd2+W3BydP2j3Q4WsujGZL11m6I7Wn1OY/ydJxRoCkqGmuqSXAMAhQdqR5i9WyxmjTWuJDo
	URjXUF92mJlIJOdZLJ8XPawmIdiNbuP9c990E2qFzwcV/rn5LGNS4vA+9BXiQd0kmNRFGMUVJ9z
	MzfY5TZfTyxxMxJuu5rBTu5y9+JB0IPU/VJdSMT7NaKFUKBoDYE28j2D5qpNw==
X-Google-Smtp-Source: AGHT+IFcaG2diqMxOqusH9IIiQ6tzpbrJgmvAJveAGN983bDcWLIVWyiyO0L7LLJDKrl11UqMQ6S9cxZtA1TVs4J73o=
X-Received: by 2002:a05:6512:38ab:b0:591:d413:57fd with SMTP id
 2adb3069b0e04-591d4135be6mr718612e87.4.1760799963225; Sat, 18 Oct 2025
 08:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016063657.81064-1-byungchul@sk.com> <20251016072132.GA19434@system.software.com>
 <8d833a3f-ae18-4ea6-9092-ddaa48290a63@gmail.com> <CAHS8izMdwiijk_15NgecSOi_VD3M7cx5M0XLAWxQqWnZgJksjg@mail.gmail.com>
 <20251018044653.GA66683@system.software.com>
In-Reply-To: <20251018044653.GA66683@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 18 Oct 2025 10:05:51 -0500
X-Gm-Features: AS18NWCdRnTpaOE-ua3r-9Us5t5kUAoflf6Cc1Wzwirr87rmZDAh12Y2B710qzk
Message-ID: <CAHS8izPeFvTNPTAqmfkAxR9aKd00HW-G45r77Ex16QQSjfQibg@mail.gmail.com>
Subject: Re: [PATCH net-next] page_pool: check if nmdesc->pp is !NULL to
 confirm its usage as pp for net_iov
To: Byungchul Park <byungchul@sk.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, axboe@kernel.dk, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, sdf@fomichev.me, dw@davidwei.uk, 
	ap420073@gmail.com, dtatulea@nvidia.com, toke@redhat.com, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kernel_team@skhynix.com, max.byungchul.park@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 11:47=E2=80=AFPM Byungchul Park <byungchul@sk.com> =
wrote:
>
> On Fri, Oct 17, 2025 at 08:13:14AM -0700, Mina Almasry wrote:
> > On Fri, Oct 17, 2025 at 5:32=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> > >
> > > On 10/16/25 08:21, Byungchul Park wrote:
> > > > On Thu, Oct 16, 2025 at 03:36:57PM +0900, Byungchul Park wrote:
> > > >> ->pp_magic field in struct page is current used to identify if a p=
age
> > > >> belongs to a page pool.  However, ->pp_magic will be removed and p=
age
> > > >> type bit in struct page e.g. PGTY_netpp should be used for that pu=
rpose.
> > > >>
> > > >> As a preparation, the check for net_iov, that is not page-backed, =
should
> > > >> avoid using ->pp_magic since net_iov doens't have to do with page =
type.
> > > >> Instead, nmdesc->pp can be used if a net_iov or its nmdesc belongs=
 to a
> > > >> page pool, by making sure nmdesc->pp is NULL otherwise.
> > > >>
> > > >> For page-backed netmem, just leave unchanged as is, while for net_=
iov,
> > > >> make sure nmdesc->pp is initialized to NULL and use nmdesc->pp for=
 the
> > > >> check.
> > > >
> > > > IIRC,
> > > >
> > > > Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> > >
> > > Pointing out a problem in a patch with a fix doesn't qualify to
> > > me as "suggested-by", you don't need to worry about that.
> > >
> > > Did you get the PGTY bits merged? There is some uneasiness about
> > > this patch as it does nothing good by itself, it'd be much better
> > > to have it in a series finalising the page_pool conversion. And
> > > I don't think it simplify merging anyhow, hmm?
> > >
> >
> > +1 honestly.
> >
> > If you want to 'extract the networking bits' into its own patch,  let
> > it be a patch series where this is a patch doing pre-work, and the
> > next patches in the series are adding the page_flag.
>
> Okay.  Then is it possible that one for mm tree and the other for
> net-next in the same patch series?  I've never tried patches that way.
>
> > I don't want added netmem_is_net_iov checks unnecessarily tbh. These
> > checks are bad and only used when absolutely necessary, so let the
> > patch series that adds them also do something useful (i.e. add the
> > page flag), if possible. But I honestly think this patch was almost
> > good as-is:
>
> Hm.. but the following patch includes both networking changes and mm
> changes.  Jakub thinks it should go to mm and I don't know how Andrew
> thinks it should be.  It's not clear even to me.
>
> That's why I splitted it into two, and this is the networking part, and
> I will post the mm part to mm folks later.  Any suggestions?
>

I think 1 series with all the mm and networking changes targeting mm
and Cc: netdev@ would work (and lets see if Andrew prefers something
different). The networking changes are very small.

--=20
Thanks,
Mina

