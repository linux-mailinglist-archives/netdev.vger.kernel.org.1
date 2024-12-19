Return-Path: <netdev+bounces-153469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEC49F8297
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBB7163678
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF019DF99;
	Thu, 19 Dec 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="OIKT/ZO9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419619C546
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630691; cv=none; b=rHahcBBFEULjfhLdzTieS6ffEo2cHRmryV3wiEuaqd1WrPasUUwIS5wDpAeETA3b9vTQ1zhJ8kA7RCcciSDsuCF+pUJmHtWL9D33o7/k+omaGCGTS+k+0uGGjgFl9CzNtyn4zRUlwnuheS8146sFJQsWJmidzCKRHQ6S1b1SDFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630691; c=relaxed/simple;
	bh=RZQLqfybZLEvtZw7WvVIZkSrrzCTmbCBUDEyQknNXjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxIUsky0Kw5F3NkVUg87YpeY2MZmMS+lUBcNUzcicfPDuhmUD8iTfjDaqQ2pIqALIHV/Zz8EYnMeCenXD5EOwEfmvXbkfvy8s3ibuwej0eWV9SJg43dkvu6gqsU2zNSBJMz8On+fEevF7swPQkEGb89r9SArjjuosXlC70XycZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=OIKT/ZO9; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gsQ9q94kvtemdre0cf5SAk6N7BvpeyylRo83uYZ5drA=; t=1734630689; x=1735494689; 
	b=OIKT/ZO9J8oFpSOVU1M3HhISwDvyZlkGsVwwCDcX07BuDZ3UM58k6Iq37hHFfwnXzxoSq7rn8N6
	NbiOmN+G95s3EW2OaqJwGlrwH7q+nWQ+RM5mDJhGkL6aJLhb/kigfUqZvlVJQatL/ntayGMjw1IgP
	Qbokeh0ENIEFqkOhVH0/kFe2SRjChYTn2QfOy7POSGeLpZxhY3hLFXSeuG6jB5NchzFKaaHKT5TPI
	Q2ut+q78ThqUx4kL0ufuueiwS9636XNSxk4NtJ9h3LjIW0FNQ1hK3gdoCY75a7nPtYFjLOKCpdDdU
	w9ZvHSIjaFusNX31nU605UF0jyhOHpqH2vfA==;
Received: from mail-oa1-f53.google.com ([209.85.160.53]:50522)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tOKgD-0004Yb-8x
	for netdev@vger.kernel.org; Thu, 19 Dec 2024 09:51:21 -0800
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29e149aff1dso330505fac.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:51:21 -0800 (PST)
X-Gm-Message-State: AOJu0Yz6v/2VRGvifnKo8cqgJdVUkh1zQzUix7Klbj0a8O9zysNboamd
	BsZJWj097x3U1EXQBnvjQ8zaw+sM86pShhBRiNMJkpIsspnGgmL0LyTA++ObwjZWtL0Eqc9O2RR
	Z5OctMHpSv4YmoCcSY7cLvbN4eHc=
X-Google-Smtp-Source: AGHT+IFJY4aff3uJ0KYSNUurWpdmWluU+a72EQj+tHEL8VcfwVRjNGIn3sLnABvhdqfsvc+Nz6zDNZtmDmQR3JZT664=
X-Received: by 2002:a05:6870:fbab:b0:277:d8ee:6dda with SMTP id
 586e51a60fabf-2a7d0859654mr2531682fac.23.1734630680682; Thu, 19 Dec 2024
 09:51:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209175131.3839-1-ouster@cs.stanford.edu> <20241209175131.3839-5-ouster@cs.stanford.edu>
 <8a73091e-5d4a-4802-ffef-a382adbbe88f@gmail.com> <CAGXJAmzVYDQtBVwdhazf9R2UgMCOOwppD+EM2-NY25t+N1vJhA@mail.gmail.com>
 <e1ed4a57-f32c-3fcd-5caf-0861ef7cf0b5@gmail.com>
In-Reply-To: <e1ed4a57-f32c-3fcd-5caf-0861ef7cf0b5@gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 19 Dec 2024 09:50:45 -0800
X-Gmail-Original-Message-ID: <CAGXJAmwsxBdzgEa5hg6vvgdCU3yvCJhvG7xzAembMVTSeCXGag@mail.gmail.com>
Message-ID: <CAGXJAmwsxBdzgEa5hg6vvgdCU3yvCJhvG7xzAembMVTSeCXGag@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/12] net: homa: create shared Homa header files
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 2ecb59bd28923317bd193fe54b7794cd

On Wed, Dec 18, 2024 at 4:25=E2=80=AFAM Edward Cree <ecree.xilinx@gmail.com=
> wrote:\
>
>
> > This is a lock-free mechanism to hand off a complete message to a
> > receiver thread (which may be polling, though the polling code has
> > been removed from this stripped down patch series). I couldn't find an
> > "atomic pointer" structure, which is why the code uses atomic_long_t
> > (which I agree is a bit ugly).
>
> As far as I can tell, ready_rpc only ever transitions from NULL to
>  populated; once non-NULL, the value is never overwritten by a
>  different pointer.  Is that correct?  If so, I believe you could use
>  a (typed) nonatomic pointer and an atomic flag to indicate "there is
>  an RPC in ready_rpc".

Yep, that's much better; don't know why I didn't think of that. I've
refactored to implement this approach.

> > I'm not
> > sure I understand your comment about not manually sleeping and waking
> > threads from within Homa; is there a particular mechanism for this
> > that you have in mind?
>
> It's not in this patch but homa_rpc_handoff() does a wake_up_process()
>  and home_wait_for_message() does set_current_state(), neither of
>  which ought to be necessary.
> I think wait-queues do what you want (see `struct wait_queue_head` and
>  `wait_event_interruptible` in include/linux/wait.h =E2=80=94 it's basica=
lly a
>  condvar), or if you want to wake unconditionally then completions
>  (kernel/sched/completion.c, include/linux/completion.h).

It's been a long time since I wrote this part of Homa, but I believe
that I considered wait queues and found that they wouldn't work. The
problem is that different threads might be waiting for partially
overlapping groups of RPCs (e.g. thread A might be waiting for a
specific RPC X, while thread B might be waiting for any client
response, which happens to include X). Wait queues don't work because
they assume that everyone in the queue is waiting for the same stuff,
so any event satisfies any thread. That isn't the case with Homa RPCs.
Thus I had to introduce the homa_interest struct and handle the
wakeups with lower-level mechanisms (which, as I recall, I copied from
the wait queue implementation).
>
> >>> +     interest->request_links.next =3D LIST_POISON1;
> >>> +     interest->response_links.next =3D LIST_POISON1;
> >>
> >> Any particular reason why you're opencoding poisoning, rather than
> >>  using the list helpers (which distinguish between a list_head that
> >>  has been inited but never added, so list_empty() returns true, and
> >>  one which has been list_del()ed and thus poisoned)?
> >> It would likely be easier for others to debug any issues that arise
> >>  in Homa if when they see a list_head in an oops or crashdump they
> >>  can relate it to the standard lifecycle.
> >
> > I couldn't find any other way to do this: I want to initialize the
> > links to be the same state as if list_del had been called,
>
> If there's a reason why this is necessary, there should be a comment
>  here explaining why.  I *think*, from poking around the rest of the
>  Homa code, you're using 'next =3D=3D LIST_POISON1' to signal some kind
>  of state, but if it's just "this interest is not on a list", then
>  list_empty() after INIT_LIST_HEAD() or list_del_init() should work
>  just as well.  (Use list_del_init(), rather than plain list_del(),
>  if the interest is still reachable by some code that may need to
>  tell whether the interest is on a list; otherwise, using list_del()
>  gets the poisoning behaviour that will give a recognisable error if
>  buggy code tries to walk the list anyway.)

Oops. I had somehow overlooked list_del_init. I've switched to using
that, and now I don't need the LIST_POISON stuff (the problem was that
I needed "initialized" and "inserted then removed" states to be the
same). That's much better.

Thanks for all of your comments; they've been very helpful. I look
forward to getting more next year.

-John-

