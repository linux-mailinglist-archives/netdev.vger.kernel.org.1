Return-Path: <netdev+bounces-100192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1838D81A6
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652461F222A1
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E662886634;
	Mon,  3 Jun 2024 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3T5r7yk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F5486278
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415612; cv=none; b=oigimuzoGRxYk+I7I8HIoQ1AlaTGYWSOCR405HakyR3pOaZXLV44eXiN5GDGub3vBtCntjd7Tc0nOJU216p4BvtJPBfgQNA4iNaoVR5u2+xRM2LmDaolnrfQdv02hDOkSlmdhpKVzlfNvFxjAn3WUnQMzXv3JMDmpU2AqzLbt+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415612; c=relaxed/simple;
	bh=iI1xbwEGAsahYCSHGv/Nl5RH5Fyx0iyN9EQiEXNptpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiosxBZbKwFAZOfOSGNqTEpdHropgLyEES/dHm+/uNtJOpmDMI4CKUUmip5UlYAWtgnpEpneoRFTXacUkF3LnaqXZ8gxxP6lK4yP+nTnvERMkZv9PlOM1YUa1ZSBUED7DjNttiHIaa8GtSprl+VlUeU+3Vq3W095C7S4OBE8ZSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3T5r7yk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso13658a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 04:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717415609; x=1718020409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5kKrdNrL/QGV/tFJ2qzIqsuhTWt4pdsE95KGDdCviw=;
        b=m3T5r7ykLS11hrWZDWHGBShvl03fUFaqp5brgjt5xFAUT70AIi3QFf/cRIl0v46gW5
         PP/aPplzn0mC6qJ4/UlsQxMdm4mALhZdWYhV64fB2XQ8H0sKM4KGSupojneBLpvXrVab
         +aWpBICrkjqmvgN/Pi7RZMDm4lfqgLYnmgtIsZu0lBwiFc4D+01aCYPt4VRwHjJ3G+lQ
         x10nfZNQobNNtsQo/OvW/PvXalUXc76WbTWobmAHX9aTGftd5I7BzZhqGCVosTRrfzH6
         5LsVxXFZLZ2GdbVWcKdva8Y+ohBpbNbsbGOR0RlJdHmvuONxILkh/akbSh5qrC+mInWt
         WIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717415609; x=1718020409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5kKrdNrL/QGV/tFJ2qzIqsuhTWt4pdsE95KGDdCviw=;
        b=RdhSpnEF8Ivs2evypeQ1ACEzhqVLJD/WMaCaSl7kLPfkaZmEtZQVzu9AxElotncP0/
         +onK+d5+JvPGqDieN0CD5F0xu/HdezhGTt8PQEflxDPI732nOCGdYukVEVd7IT2nseDF
         lqF1AOTG4q0LusaGEhzfo6kXP7YXh3YzLrsFRmkzQxU4DLaYWgzsSQMIEV2sZydNhkcx
         WYbHD9iwCieAw6ZsTPQherxfWbr+tpdNyvqLIuJtw7WzA7uw1pdjXbln0Z/nAS+OUoSR
         Wjzm7S7kwJ205KDI0Ir5iMttxYl7A7cfnPJQy1f2uSVUtlQPonkWSKqj6mH3Ndso9nfu
         nEtw==
X-Gm-Message-State: AOJu0Yz7fyOm7g2bJyYIiAUeLgN5ShR/Z8wHoQLDOvo3bPShr8AEZzNl
	qNptROcsrml+lhrgkkHpzFS4NuYaGFb52g7GS8rAdGxdfFMIfWbdEiPjbgJ1laP+msLYJBXJCxu
	/1qu7IZkmRy3cM1RUbA9xTVkIBCi/idoHNbjc
X-Google-Smtp-Source: AGHT+IFlFo+GLxhjNhm16ajuw3nSkjt2K15wYl+OEUZugbeomhfBEzfwrFRZNXxcaO8Dc17ff+Fp9aqhdlJh4BVpDKk=
X-Received: by 2002:a05:6402:2113:b0:57a:1a30:f5da with SMTP id
 4fb4d7f45d1cf-57a46125455mr362458a12.2.1717415609137; Mon, 03 Jun 2024
 04:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603093625.4055-1-fw@strlen.de> <20240603093625.4055-2-fw@strlen.de>
 <CANn89i+Zp=_F0tHTgQKuk1+5MV8MU+N=JV35vSTwKLFmi_5dNg@mail.gmail.com> <20240603112152.GB8496@breakpoint.cc>
In-Reply-To: <20240603112152.GB8496@breakpoint.cc>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Jun 2024 13:53:16 +0200
Message-ID: <CANn89iJ=cBBJ-iHLNE1h3KZyUxfDFMw1sHnDWAGCvrXLzv+FZA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/3] net: tcp/dcpp: prepare for tw_timer un-pinning
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, mleitner@redhat.com, 
	juri.lelli@redhat.com, vschneid@redhat.com, tglozar@redhat.com, 
	dsahern@kernel.org, bigeasy@linutronix.de, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 1:21=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Eric Dumazet <edumazet@google.com> wrote:
> > On Mon, Jun 3, 2024 at 11:37=E2=80=AFAM Florian Westphal <fw@strlen.de>=
 wrote:
> > > +       spin_lock(lock);
> > > +       if (timer_shutdown(&tw->tw_timer)) {
> > > +               /* releases @lock */
> > > +               __inet_twsk_kill(tw, lock);
> > > +       } else {
> >
> > If we do not have a sync variant here, I think that inet_twsk_purge()
> > could return while ongoing timers are alive.
>
> Yes.
>
> We can't use sync variant, it would deadlock on ehash spinlock.
>
> > tcp_sk_exit_batch() would then possibly hit :
> >
> > WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcoun=
t));
> >
> > The alive timer are releasing tw->tw_dr->tw_refcount at the end of
> > inet_twsk_kill()
>
> Theoretically the tw socket can be unlinked from the tw hash already
> (inet_twsk_purge won't encounter it), but timer is still running.
>
> Only solution I see is to schedule() in tcp_sk_exit_batch() until
> tw_refcount has dropped to the expected value, i.e. something like
>
> static void tcp_wait_for_tw_timers(struct net *n)
> {
>         while (refcount_read(&n->ipv4.tcp_death_row.tw_refcount) > 1))
>                 schedule();
> }
>
> Any better idea?


Maybe usleep_range(500, 1000)

>
> I started to sketch a patch that keeps PINNED as-is but schedules almost
> all of the actual work to a work item.
>
> Idea was that it would lower RT latencies to acceptable level but it got
> so ugly that I did not follow this path.
>
> I could resurrect this if you think its worth a try.

I would rather avoid a work queue.

