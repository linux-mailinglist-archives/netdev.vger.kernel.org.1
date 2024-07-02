Return-Path: <netdev+bounces-108313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A34F91ECE4
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 04:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEE91C21415
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 02:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D2C133;
	Tue,  2 Jul 2024 02:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSH0KMR4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A437BC129;
	Tue,  2 Jul 2024 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719886137; cv=none; b=Yv7uNgUDNk3A2vCo+OMOlsGfB0j1m67st3MamVr35/LNyjmpfHI4MtdbSwPO/lu4q5VxkOo6/Ic+5XPmtiQgyArx5QplPRioBYNIZBKIly5ffkSiQn4RPt5rhegbhln9XJecMY3sY2pjMVs/fQ9XoewRntAPhZ3yMqFswf1IcNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719886137; c=relaxed/simple;
	bh=q2dQRzE+aINYiLlUDRwYF0sHgWIJl6eq3nw5CuDIAEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4m+D+6Fd36Bus9wvkm/MbMi8cytE9yI9ap5pi8IjKxbXtpPiMiQaeI5Xh+D54Tolknt+xMmkHWCABr96C6SylGEDVbjNwGXGyS8KR+Q1gwtwrjXVqoBZEvpabYsIwx3YlZKLRkLIAh7SbHxMqDw0RcPFUhpo2vzzvKUwQza7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSH0KMR4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c7bf925764so2669263a91.0;
        Mon, 01 Jul 2024 19:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719886135; x=1720490935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3iPlmzgUkKMFHH6EFR/RoC05ho1mABcPgvKqXMWiosA=;
        b=LSH0KMR4eo77d6KP9tuOR8ps7wddKaQw8GigESc0qEG5KZKLQz3vAhcrkrLD5gg8/A
         fS28tgd+D31pRDbck5XKeJ0WU80G2Mw8cf3Hy931CUclf3Dj+JUaJb8soVzVM8GdeqXU
         BZtQ40WmGRiTSvvCgYGZ/a4U0rqMCE8fYIirbT3ErHNunsELhP5fsul8/Kg3b6wwdW3P
         xopKxORDHPrmR2IfpTYf7m+hKjCuFSYZq6eEsOddQzAhDLaqozotqvNtiS6xU7lLSH9G
         8Y1KUBVFt2qNgTek2ti/NCaK2K4aEA9YQL3qJzikn1a5hk4ni+NSHMvpYluLl1IViX6h
         4o6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719886135; x=1720490935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iPlmzgUkKMFHH6EFR/RoC05ho1mABcPgvKqXMWiosA=;
        b=ZacxsGGRZ0+N6SOSVVdzDzfJ4DeWrWY/kOQIowICdRVjvQeRi0b0Pjm4Ql+xJjIADC
         XeKAXahmPNz68UKR58bhjEvpx/UyM+xZOGYOoumC+DSmZp85ewNagQY4lKw6aKAABk1t
         dxYHVRDKE9KXN3dCTQBwP6VfhNmNK/KYtrGyU6gpcY7lXO7joFJG1j8hro7WJUpCiRIY
         ZHTYlNZiUc85Az151vNkh5n/GSyhpAGJmEd7ogWusGMe4W35HLxF0+1zyt8ZpXbiz7NO
         iKuDJmIpsAZCM7B777L1bYJiJEonmMO9cns2ywAKAM867SvJ99amV41Hv4JeaH5mRqoM
         Byjw==
X-Forwarded-Encrypted: i=1; AJvYcCXjnLygUY/dBWKlZHE2qYqgNCnxmySQ51rppwKHCaumGqrLJnk19+jNQvTlh5EhhG3ma9N2b38UCz92iJH76j9MQmordJyV3yDO0GuqUZVlSI9tNlwGwEG7RrAT
X-Gm-Message-State: AOJu0YwlCxpHKd+wONLVBlgb/SSKFhKKc167s4mRO1CC2+SZO7Vs0nOY
	qCY8HqJHPQOiZbTD4Es7UoRlIk0K6C0q8UvqPK6Ozwv4PaGBxvJmvkyTIHNy4L/O5bG/65esacx
	aO2lsMiSXE90/ty5BsNiPtg0IB1I=
X-Google-Smtp-Source: AGHT+IFuHFs79uSz4c57ZsoyFVPORwa70gmeiK1+Nqnse2Zgj8pSKhvSLrGTdcae9Puv50+y6ig07dVud6Z1pPSA3xY=
X-Received: by 2002:a17:90a:6c90:b0:2c4:aa78:b48b with SMTP id
 98e67ed59e1d1-2c93d775c23mr6297581a91.38.1719886134790; Mon, 01 Jul 2024
 19:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617072451.1403e1d2@kernel.org> <CAJwJo6ZjhLLSiBUntdGT8a6-d5pjdXyVv9AAQ3Yx1W01Nq=dwg@mail.gmail.com>
 <20240618074037.66789717@kernel.org> <fae8f7191d50797a435936d41f08df9c83a9d092.camel@redhat.com>
 <ee5a9d15-deaf-40c9-a559-bbc0f11fbe76@paulmck-laptop> <20240618100210.16c028e1@kernel.org>
 <53632733-ef55-496b-8980-27213da1ac05@paulmck-laptop> <CAJwJo6bnh_2=Bg7jajQ3qJAErMegDjp0F-aQP7yCENf_zBiTaw@mail.gmail.com>
 <37d3ca22-2dac-4088-94f5-54a07403dd27@paulmck-laptop>
In-Reply-To: <37d3ca22-2dac-4088-94f5-54a07403dd27@paulmck-laptop>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 2 Jul 2024 03:08:42 +0100
Message-ID: <CAJwJo6Y0hfB5royz0D8QPkgpRMxz9G5s81ktZbtHPBdt8EYdEQ@mail.gmail.com>
Subject: Re: [TEST] TCP MD5 vs kmemleak
To: paulmck@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, rcu@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

Sorry for the delayed answer, I got a respiratory infection, so was in
bed last week,

On Thu, 20 Jun 2024 at 18:02, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Jun 19, 2024 at 01:33:36AM +0100, Dmitry Safonov wrote:
[..]
> > I'm sorry guys, that was me being inadequate.
>
> I know that feeling!

Thanks :)

[adding/quoting back the context of the thread that I cut previously]

> On Tue, Jun 18, 2024 at 10:02:10AM -0700, Jakub Kicinski wrote:
> > On Tue, 18 Jun 2024 09:42:35 -0700 Paul E. McKenney wrote:
> > > > FTR, with mptcp self-tests we hit a few kmemleak false positive on RCU
> > > > freed pointers, that where addressed by to this patch:
> > > >
> > > > commit 5f98fd034ca6fd1ab8c91a3488968a0e9caaabf6
> > > > Author: Catalin Marinas <catalin.marinas@arm.com>
> > > > Date:   Sat Sep 30 17:46:56 2023 +0000
> > > >
> > > >     rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects
> > > >
> > > > I'm wondering if this is hitting something similar? Possibly due to
> > > > lazy RCU callbacks invoked after MSECS_MIN_AGE???
> >
> > Dmitry mentioned this commit, too, but we use the same config for MPTCP
> > tests, and while we repro TCP AO failures quite frequently, mptcp
> > doesn't seem to have failed once.
> >
> > > Fun!  ;-)
> > >
> > > This commit handles memory passed to kfree_rcu() and friends, but
> > > not memory passed to call_rcu() and friends.  Of course, call_rcu()
> > > does not necessarily know the full extent of the memory passed to it,
> > > for example, if passed a linked list, call_rcu() will know only about
> > > the head of that list.
> > >
> > > There are similar challenges with synchronize_rcu() and friends.
> >
> > To be clear I think Dmitry was suspecting kfree_rcu(), he mentioned
> > call_rcu() as something he was expecting to have a similar issue but
> > it in fact appeared immune.

On Thu, 20 Jun 2024 at 18:02, Paul E. McKenney <paulmck@kernel.org> wrote:
> > That's a real issue, rather than a false-positive:
> > https://lore.kernel.org/netdev/20240619-tcp-ao-required-leak-v1-1-6408f3c94247@gmail.com/
>
> So we need call_rcu() to mark memory flowing through it?  If so, we
> need help from callers of call_rcu() in the case where more than one
> object is being freed.

Not sure, I think one way to avoid explicitly marking pointers for
call_rcu() or even avoiding the patch above would be a hackery like
this:

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index d5b6fba44fc9..7a5eb55a155c 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1587,6 +1587,7 @@ static void kmemleak_cond_resched(struct
kmemleak_object *object)
 static void kmemleak_scan(void)
 {
        struct kmemleak_object *object;
+       unsigned long gp_start_state;
        struct zone *zone;
        int __maybe_unused i;
        int new_leaks = 0;
@@ -1630,6 +1631,7 @@ static void kmemleak_scan(void)
                        kmemleak_cond_resched(object);
        }
        rcu_read_unlock();
+       gp_start_state = get_state_synchronize_rcu();

 #ifdef CONFIG_SMP
        /* per-cpu sections scanning */
@@ -1690,6 +1692,13 @@ static void kmemleak_scan(void)
         */
        scan_gray_list();

+       /*
+        * Wait for the greylist objects potentially migrating from
+        * RCU callbacks or maybe getting freed.
+        */
+       cond_synchronize_rcu(gp_start_state);
+       rcu_barrier();
+
        /*
         * Check for new or unreferenced objects modified since the previous
         * scan and color them gray until the next scan.


-->8--

Not quite sure if this makes sense, my first time at kmemleak code,
adding Catalin.
But then if I didn't mess up, it's going to work only for one RCU
period, so in case some object calls rcu/kfree_rcu() from the
callback, it's going to be yet a false-positive.

Some other options/ideas:
- more RCU-invasive option which would be adding a mapping function to
segmented lists of callbacks, which would allow kmemleak to request
from RCU if the pointer is yet referenced by RCU.
- the third option is for kmemleak to trust RCU and generalize the
commit above, adding kmemleak_object::flags of OBJECT_RCU, which will
be set by call_rcu()/kfree_rcu() and unset once the callback is
invoked for RCU_DONE_TAIL.
- add kmemleak_object::update_jiffies or just directly touch
kmemleak_object::jiffies whenever the object has been modified (see
update_checksum()), that will ignore recently changed objects. As
rcu_head should be updated, that is going to automagically ignore
those deferred to RCU objects.

Not sure if I mis-looked anything and it seems there is no hurry in
fixing anything yet, as this is a theoretical issue at this moment.

Hopefully, these ideas don't look like a nonsense,
             Dmitry

