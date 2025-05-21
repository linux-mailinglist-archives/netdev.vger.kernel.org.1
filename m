Return-Path: <netdev+bounces-192468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A90AC000D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 00:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FCC1BC520B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 22:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E04D239581;
	Wed, 21 May 2025 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y47WezQ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34F21E0A2
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867834; cv=none; b=irR613MMlmVvXvdF/TPH/1LBZ8qejxABVRlK1BSMnxlZOawMxg+jPo7tDD3ALHYPX86x3VsYCZnFh29JAZVBZcix0NWO5jAzbwAES5um7jSHJSU3Vf28P8066Y6eSQGsZR461nTMh8BPkeQPnfboSTJQp6DXAsoRHNYvWWDdBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867834; c=relaxed/simple;
	bh=KLAWLdHnq7oJKwYZhLUj6ITQOjc+rCwTp33UNKldAR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5srf8DfvDYl+f9DDyDCYhjcgLHl3GH/qThdXRxHH0XqJkNWXVQgVEizmZLpgpHMT35EzXNyMdiJRwV1fRUSrNAV+fNkGPGfWZYusL3AYNb/TWJgMDKuowMIHBotMMyQWfSzEK6MRHzJ3nV0fSrnXUGyNA2GfJmjElt8XG/uL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y47WezQ7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-231f61dc510so1168075ad.0
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 15:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747867832; x=1748472632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc09VhZZyd7VUUkPxHgkcAHf7bii5eXovz7FVbqJkl8=;
        b=Y47WezQ7WqZkhmJwmchbxGHzo43aUoxvdXVG8ap3CDKSAK2m/uuD/3CmmfoP0ltLEL
         gV2mWFgDyiiv9b+mvnWqerJYtkukmDGKbEi5Z/17rFtim2MzLPH+QRC4uDvBC+UKGZK9
         g2P+KtxPWw/Bxx++LKLRT39a97C0Yie2pyJ29BtRhPTKsY2g92fjeImvqbpsPqnyDC7M
         jgIkNS+5yX9hkJ1FYKL5Og120c0sy8XNbaEXRdzrxsXa0o8AmeZ3TxBRToCu2CbvXVpd
         JNCk1JvuH6cHn9xSIXcB1fsGt6D3HOShlrRi+B3jlZYsa46MreIpk/wH/EVtHiyepurb
         PS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747867832; x=1748472632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc09VhZZyd7VUUkPxHgkcAHf7bii5eXovz7FVbqJkl8=;
        b=o+jp3Er053AkIReQBmX+5HOZTx1phO5tD3bwExX1lOwQ1n3joI746yEzFT7b73ucb1
         KjLvTeUf5Sma4y7d5ChoDXInBpFxun5wG7RP5F2ouVhp6zMUWWVBQ2YLnGboZ8QQHw7C
         NtZnIbtfHHKs1z1FEEqVuCCdytw1tH7xHqIsSIcWHt3Ok7uYB8iO34PY6EwkBv8Q1CYN
         UmxjviD0gfwBFq3wiv39+hSKFJWFoSQzmHaoWLdlyyt8Ec/dPnpI+qQ7eWlXjIhqX6Bc
         PAVN9SaZMXpaSxkdRPY9GdTVLa7qu2VUPQkxl+suVQ/hLFbRfug8EMldQ6buytKbQEb2
         L3DA==
X-Forwarded-Encrypted: i=1; AJvYcCUW0TOL0N5uL9Vf3mfIE97g///oIA7rWTmcr/5mXZ07U+pn9MWNjxvYeS7XiB04iM5C9LGHoqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNvROKVOuWx2HHaCbGQLFrPyAGSlLmYZN1oCb9aXczp1SDDTrY
	GKxfqSnNpXyLSgp9CaYpdHnX6Pv0EeEx5/UOxWK6lNPeJ+1tiE5/uj9A7yfJxVCHwfcvmRzmvB8
	Qy6o/JC74UEOme8Bq/rz+n0dB0WiQXXmZxxGh3YKR
X-Gm-Gg: ASbGncu6aIiU9mJvKIVje36Rh4lAPIWxUE6FGo9sJgw/EruoTn0Xcn1afallYuR4Y6l
	bd86cwNFKuC3izXl92dMlAMlfVgvgRkIpeYH87AbX2/guuUew4l2RCg1flM1rKeSTOkl7aRpZMN
	h1WuLz0DoVWC5JTPYaeTRNl6L6W8C6L3PGqyTzX+MZiJeTgHztqFrPXgPnAXd0H/b6ZAXxOlV6q
	w==
X-Google-Smtp-Source: AGHT+IF7rU3oLvFQOQ5bp2VC/09Uxdnd/tPiVaTcrgEfxg64zlkM5A2IpOD4CKYOvzbbdSiA1eLp9EqbG3NjK0jVMDQ=
X-Received: by 2002:a17:903:1b4b:b0:231:fb83:9c3d with SMTP id
 d9443c01a7336-233d6e3ac59mr531255ad.20.1747867831675; Wed, 21 May 2025
 15:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519224325.3117279-1-skhawaja@google.com> <20250520190941.56523ded@kernel.org>
 <CAEA6p_BxSA16cMXr5NaJCLZ+KWD2YVVwEdvVX_QG=_gyvNCP=w@mail.gmail.com>
 <CAAywjhR4znr9fsAdBKmYAwcyP8JgoesLkuS8p9D0goJBFFePWg@mail.gmail.com>
 <CAAywjhTjdgjz=oD0NUtp-k7Lccek-4e9wCJfMG-p0AGpDHwJiQ@mail.gmail.com> <20250521152147.077f1cb0@kernel.org>
In-Reply-To: <20250521152147.077f1cb0@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 21 May 2025 15:50:19 -0700
X-Gm-Features: AX0GCFujjDE9kUl5JjHCzVc36Yncy9SJurb-ojVBd7cVPJJ5PPKOmANz0e4IF4Y
Message-ID: <CAAywjhScfevLxYho-wxU6WNF+0VpwngW8MzZjpx1HQ83NTXUDw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: stop napi kthreads when THREADED napi is disabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wei Wang <weiwan@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 3:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 21 May 2025 12:51:33 -0700 Samiullah Khawaja wrote:
> > > This might suffer from the problem you highlighted earlier,
> > > CPU 0 (IRQ)             CPU 1 (NAPI thr)          CPU 2 (config)
> > >
> > >   ____napi_schedule()
> > >     if (test_bit(NAPI_STATE_THREADED))
> > >     if (thread) {
> > >
> > >  kthread_stop()
> > >                               if (state & SCHED_THREADED || !(state &=
 SCHED)) {
> > >                                    state &=3D ~THREADED;
> > >                               if (try_cmp_xchg())
> > >                                    break
> > >
> > >        set_bit(NAPI_STATE_SCHED_THREADED)
> > >        wake_up_process(thread);
>
> This got a bit line wrapped for me so can't judge :(
Yep, sorry about that. But I think we are on the same page.
>
> > > This would happen without the try_cmp_xchg logic that I added in my
> > > patch in the __napi_schedule (in the fast path). __napi_schedule woul=
d
> > > have to make sure that the kthread is not stopping while it is trying
> > > to do SCHED. This is similar to the logic we have in
> > > napi_schedule_prep that handles the STATE_DISABLE, STATE_SCHED and
> > > STATE_MISSED scenarios. Also if it falls back to normal softirq, it
> > > needs to make sure that the kthread is not polling at the same time.
> > Discard this as the SCHED would be set in napi_schedule_prepare before
> > __napi_schedule is called in IRQ, so try_cmp_xchg would return false.
> > I think if the thread stops if the napi is idle(SCHED is not) set then
> > it should do. This should make sure any pending SCHED_THREADED are
> > also done. The existing logic in napi_schedulle_prep should handle all
> > the cases.
>
> I think we're on the same page. We're clearing the THREADED bit
> (not SCHED_THREADED). Only napi_schedule() path looks at that bit,
> after setting SCHED. So if we cmpxchg on a state where SCHED was
> clear - we can't race with anything that cares about THREADED bit.
+1

Yes, the logic in napi_sched_prep should provide enough mutual
exclusion. The only problem is that we have to do a poll if
SCHED_THREADED is set. But if we unset THREADED (using the cmpxchg
logic) then do a poll, the final poll should unset SCHED_THREADED also
and would be safe to stop. I am going to move this loop to the
napi_thread_poll function so it is a little bit clean.
>
> Just to be clear - the stopping of the thread has to be after the
> proposed loop, so kthread_should_stop() does not come into play.
Wait, the thread will unset STATE_THREADED if kthread_should_stop is
true. right? Otherwise how would thread know that it has to unset the
bit and stop?

As I understand, we should be doing something like following:

while (true) {
   state =3D READ_ONCE()
   can_stop =3D false;

   if (kthread_should_stop) {
       if (SCHED_THREADED || !SCHED) {
           state &=3D !THREADED
       } else {
           msleep(1);
           continue;
       }

        if (try_cmpxchg) {
            can_stop =3D true;
            if (!SCHED_THREADED)
                break;
        }
   }

   if (SCHED_THREADED)
       poll()

   if (can_stop))
       break;
}

dev_set_threaded() {
    ...
   if (!threaded)
      kthread_stop(thread)
}

>
> And FWIW my understanding is that we don't need any barriers on the
> fast path (SCHED vs checking THREADED) because memory ordering is
> a thing which exists only between distinct memory words.

