Return-Path: <netdev+bounces-152535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 539339F480A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E201881A75
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799A71DF257;
	Tue, 17 Dec 2024 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zuIk3yMb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835751DE3D7
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429175; cv=none; b=b8dccUwBYRdCRJrMdtq0QXs+Gx8RGQCw/qtCMaSzJTx+8hknUudTkHUQniPKhN3/VN6JdobZsaGdC+1ICamaVB7OQqA54/xEHOf6/geI0zRJbOGMmA2vQdFBp3ljJd6V1AZpfq045r8MUeI+ln0BbQDK5UmO9PMg/iyh0ni8IVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429175; c=relaxed/simple;
	bh=jjleIvhkMR54htIz6O/D3kVF6dV5H5QM/sApAYw7Hds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzksGTZMv+ihbscrfUNdeiURih8ONHmim8scCPZftRRWH3WHU0/tppFGyZniV9dIZMNkKHndM12M9urSqUXmeubKoiF3164WXP7bC9XPHC4fbzEr8ZOMyfJdRmH3Y6CbmBiW4ndDYJ8mInbS58/zPpfJO6UjynkXXBSnG73Xz7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zuIk3yMb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso35789a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 01:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734429172; x=1735033972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5W3/GdMG/Vf1TJOblxx6k/fBoUkKvjbm6NCip4Rbus=;
        b=zuIk3yMb6RRkTi8phgcYUfqQ52KzsR5vTNOQkd/qwdq3aIN13BhHnDRRkaN6YlWjRT
         gQIg5wDMRV+sEVIQ1YoQ4lFnRyYsRGF8OnmoTb12W8bf45p3ibhIdS2uIJHt4w9GxwaF
         ygZnS4B/R5ClS45oYn7Ho6hdObqKxwWvTN9foMYIivQBjiyCeCnuN804r4/Pb18s1ZlX
         3EWaGkEDY25wV8QxbGVvxBSJbYMvfNUznRYh+ERtaSE3NNyaqay3ugpkj+P8Z9sHk5iL
         Af43AzAM5Kgenai/HMZVRhOPZyZ8e0BMnAf0FQE6uLROVMlIsy+DKzO/YcL4SEtbcHAi
         OzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734429172; x=1735033972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5W3/GdMG/Vf1TJOblxx6k/fBoUkKvjbm6NCip4Rbus=;
        b=UQmteANzTjHtj7/J3UuvvI2CBCd+gSF5Hyuh9lxiEhLlt44DSTysaPrbeDPR44ez5x
         XXa/RHc0DUIFQeKK7cx/vZnbalTGjojgEeq34u2TBG/Q1EJpAoMXoV2rI/JkmqLytJMz
         z2aTfvUC1BNwVyCrtHbOdEwnfdZJTFNQrtT86EeVA0irvh1k2A41yt9wYJdUguTzAs58
         PV0olIrlMKYTHaXlLAowuo8KyGb3m0IGt6iXUKgbciOwq7HqoxwZVgoVyayu2fbqsKWW
         MExN05mBHQLd/1u7Cl/OMtvfC6+FnhbN2rUEXbuls2HL246O+zCisOPwKZ+MGqLELecN
         CfUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLcNtpAoZcGIgELCZnt2TsSujKc6I0rjrjuS6GtYfnyIxoAqH53oRqUo/tRpQSqqtzDq/9gSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUuc23JkKYUSzy79Bkl/pB/UJRHmf5EiKgUfmZJEm3RquK3jiW
	A/RiQe1Xp/WiHyQeqmYeIO06CrnVxMwyBhjJoR2bppfJt1ExrhqHSZ3MbxFhP0fgm7QQYqUCrF+
	x584IMkM9mt7LODItPftiVVW6KI7QrND6Krnd
X-Gm-Gg: ASbGncsKnXJKozSjmKbDSJr2WY5RYqvH3E1WlIk21cprtNLc7FrST56h1ocKrcpENuK
	1NOzURIu1+vmspoP9P0XSJNdODgsQUkFbn7HteaerdPZKxkp2UgB09bYdSFBPCXQV3vZeRXVa
X-Google-Smtp-Source: AGHT+IFnEhLQYJ+6iAh/kWOylryFXoNfnQTTKKAqfnhcw4w88uMRdyWKQNhppMfYveJ6fbeJrEQQD2Qlz4v/T8RKK0o=
X-Received: by 2002:a05:6402:3890:b0:5d0:cfad:f6c with SMTP id
 4fb4d7f45d1cf-5d63c3ad5c6mr12431373a12.21.1734429171592; Tue, 17 Dec 2024
 01:52:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu>
 <CANn89iK1+oLktXjHXs0U3Wo4zRZEqimoSgfPVzGGycH7R_HxnA@mail.gmail.com>
 <49a43774-bf97-4b20-8382-4fb921f34c66@csgroup.eu> <CANn89iLKPx+=gHaM_V77iwUwzqQe_zyUc0Dm1KkPo3GuE40SRw@mail.gmail.com>
 <8e3c9ebc-e047-4dfd-ad1d-6bbe918aa98b@csgroup.eu>
In-Reply-To: <8e3c9ebc-e047-4dfd-ad1d-6bbe918aa98b@csgroup.eu>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 10:52:40 +0100
Message-ID: <CANn89iLTGLe2uWz+yCu5ewnDBW2hubqGm8=aRbZVTeXN1Trdaw@mail.gmail.com>
Subject: Re: [PATCH net] net: sysfs: Fix deadlock situation in sysfs accesses
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	TRINH THAI Florent <florent.trinh-thai@cs-soprasteria.com>, 
	CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 10:41=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 17/12/2024 =C3=A0 10:20, Eric Dumazet a =C3=A9crit :
> > On Tue, Dec 17, 2024 at 9:59=E2=80=AFAM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >>
> >>
> >> Le 17/12/2024 =C3=A0 09:16, Eric Dumazet a =C3=A9crit :
> >>> On Tue, Dec 17, 2024 at 8:18=E2=80=AFAM Christophe Leroy
> >>> <christophe.leroy@csgroup.eu> wrote:
> >>>>
> >>>> The following problem is encountered on kernel built with
> >>>> CONFIG_PREEMPT. An snmp daemon running with normal priority is
> >>>> regularly calling ioctl(SIOCGMIIPHY). Another process running with
> >>>> SCHED_FIFO policy is regularly reading /sys/class/net/eth0/carrier.
> >>>>
> >>>> After some random time, the snmp daemon gets preempted while holding
> >>>> the RTNL mutex then the high priority process is busy looping into
> >>>> carrier_show which bails out early due to a non-successfull
> >>>> rtnl_trylock() which implies restart_syscall(). Because the snmp
> >>>> daemon has a lower priority, it never gets the chances to release
> >>>> the RTNL mutex and the high-priority task continues to loop forever.
> >>>>
> >>>> Replace the trylock by lock_interruptible. This will increase the
> >>>> priority of the task holding the lock so that it can release it and
> >>>> allow the reader of /sys/class/net/eth0/carrier to actually perform
> >>>> its read.
> >>>>
> >>
> >> ...
> >>
> >>>>
> >>>> Fixes: 336ca57c3b4e ("net-sysfs: Use rtnl_trylock in sysfs methods."=
)
> >>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >>>> ---
> >>>
> >>> At a first glance, this might resurface the deadlock issue Eric W. Bi=
ederman
> >>> was trying to fix in 336ca57c3b4e ("net-sysfs: Use rtnl_trylock in
> >>> sysfs methods.")
> >>
> >> Are you talking about the deadlock fixed (incompletely) by 5a5990d3090=
b
> >> ("net: Avoid race between network down and sysfs"), or the complement
> >> provided by 336ca57c3b4e ?
> >>
> >> My understanding is that mutex_lock() will return EINTR only if a sign=
al
> >> is pending so there is no need to set signal_pending like it was when
> >> using mutex_trylock() which does nothing when the mutex is already loc=
ked.
> >>
> >> And an EINTR return is expected and documented for a read() or a
> >> write(), I can't see why we want ERESTARTNOINTR instead of ERSTARTSYS.
> >> Isn't it the responsibility of the user app to call again read or writ=
e
> >> if it has decided to not install the necessary sigaction for an
> >> automatic restart ?
> >>
> >> Do you think I should instead use rtnl_lock_killable() and return
> >> ERESTARTNOINTR in case of failure ? In that case, is it still possible
> >> to interrupt a blocked 'cat /sys/class/net/eth0/carrier' which CTRL+C =
?
> >
> > Issue is when no signal is pending, we have a typical deadlock situatio=
n :
> >
> > One process A is :
> >
> > Holding sysfs lock, then attempts to grab rtnl.
> >
> > Another one (B) is :
> >
> > Holding rtnl, then attempts to grab sysfs lock.
>
> Ok, I see.
>
> But then what can be the solution to avoid busy looping with
> mutex_trylock , not giving any chance to the task holding the rtnl to
> run and unlock it ?

One idea would be to add a usleep(500, 1000) if the sysfs read/write handle=
r in
returns -ERESTARTNOINTR;

Totally untested idea :

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 8bbb1ad46335c3b8f50dd35d552f86767e62ead1..276c6d594129a18a7a4c2b1df44=
7b34993398ab4
100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -290,6 +290,8 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct
iov_iter *iter)
                m->read_pos +=3D copied;
        }
        mutex_unlock(&m->lock);
+       if (copied =3D=3D -ERESTARTNOINTR)
+               usleep_range(500, 1000);
        return copied;
 Enomem:
        err =3D -ENOMEM;

