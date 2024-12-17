Return-Path: <netdev+bounces-152577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A399F4A97
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A5F161AA6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450801F2C3B;
	Tue, 17 Dec 2024 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJfgQ1ze"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAAB1F131C
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437058; cv=none; b=S2+8IlIuOus8f+930Qw1STLgBEy7B5N99keY37iaAeZbf+alQhwESHLxnmbfJrLmgFc4OI1rB6nakqmdeMbY8ZGuUgj7QTjsD4otA2/0kJ61G+aMxBiRmcQHou5Bo/V6NqBtcxCxKr8lwzYgyhFNb4m5y1Eugbl2DFj4eR0zipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437058; c=relaxed/simple;
	bh=jid2e4YmMaFzHs+grDlyZFItzWXJGa2FaJHW2QFcSfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRz8mXGcakhk/kAcl2bNQmBUce5k+SnYwqTeQBFWB6/a7+BnWSJiJ4izKVCNPmcoqxwong19w6ICsnWp9e6Lrc/jTGpzzDIqqoz0HZGvowcFmuKlAeK8DzP6DMmyiiTOQr6wAR4paJnO+OVvT2RkhjxvZFlNjMsONWbawfLWdyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJfgQ1ze; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so7410557a12.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 04:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734437053; x=1735041853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TYo1PX1btnj1ji1OnQmEZ7gYkMFV+lnpTQs66ixtVM=;
        b=bJfgQ1zeUqrVICy48d64YbIYig2l22VakWt45sZWKv4u/lJjf4ncQEepV6tArx77SF
         uI0+N5MZtFoh9LA7RoGdS/C5PlqoszkEbsde9ygq8xsfZNSKC8fVjGh6wjhgpcXq+XGC
         N5lx6jwvDp9TNEPmVY3NsbrEP6a79FV6sO9BiLHUaw0wzxdFJ5lGFVJMbfyMiErf/yE/
         juCpM/uWWduMmBEVzIQU/UwJ95Q51s3vchQyqRbQQRozt0IdG8QM5HWZx7yN3nLB2fAd
         fZWYCwtwcqWlOIBxtqadJz8NQDw9IzBBWkKV9NsW9WqcfS9Gnly1RDGVSFj2I6zfKz0f
         wGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734437053; x=1735041853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TYo1PX1btnj1ji1OnQmEZ7gYkMFV+lnpTQs66ixtVM=;
        b=TOo/XxBH09iyVP9EzA5+tsr4hAD9PmeGAFCzFWS2za4BIGL/vd/I0nFMKpXZA/GIHA
         t/+b0HHHTSe0WwRRo32OsEAtX9znmpDw49WaRMbkHghvVlef71QAxAlWQ0aByga39Gd2
         /T3MztD74myDoOBx22tpx/bkUS+9mM6Pyq9EbYPbWmxOrq/lDMZPAronsMKfeqBuz+y4
         f9wHIAK8/0B3Y2rTOhkSKkJYIUccRavUiydamydXKSm9rxjHtlEDyys86ly0RuuvEbHD
         OeKlDk7H5e0UW4PluOsuzac5CHrxa8ocTeOUsrEDegKsu9OoBIVMpR4sGFweMw9dB4cG
         8Ltw==
X-Forwarded-Encrypted: i=1; AJvYcCUe1+D2O3rsXARx0N7R+15DwXQPq3YXpWBxuODSFqx8sBxZ4ptMWbVda8gwNL1ehp+BQ0xGr3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwAukCQsHgXqrcTTLPAZ8TSpYALg5kyVHGW8AMk1REWPYwqy6
	2UyPLGqMJ3Aup8uK0q9DBMSUJ9HuqyQwstPRLf1qms9L1jpruvFvmAbrP9hxw1YD83UfPMjgBX8
	P1d5PeAEYTvl/Sdprl3wpvisWQMdS6IMjVALb
X-Gm-Gg: ASbGncvoidLJ1XIJW/ezxIXz1lQuAQf6UO5ujifgZ8N/pPqd5hwxFxhaFJF+sNLAeYE
	s17lwKJHLSZEUnQVKnnU/pM8Y15o2+fBr5t0eJb1Se5hCetM6dxZpgw+TnPuJQ8Bguu+60Tc2
X-Google-Smtp-Source: AGHT+IFF4svj3Uh3ESqZWoBR+uJQcQQFjsw2mf1H9d0JNIXlhoZbfP8H/stBFIU2BQsjfFgtDSM3eTvQCCn5BILfxno=
X-Received: by 2002:a05:6402:528f:b0:5d2:7456:9812 with SMTP id
 4fb4d7f45d1cf-5d63c39fba0mr14010471a12.22.1734437053063; Tue, 17 Dec 2024
 04:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu>
 <CANn89iK1+oLktXjHXs0U3Wo4zRZEqimoSgfPVzGGycH7R_HxnA@mail.gmail.com>
 <49a43774-bf97-4b20-8382-4fb921f34c66@csgroup.eu> <CANn89iLKPx+=gHaM_V77iwUwzqQe_zyUc0Dm1KkPo3GuE40SRw@mail.gmail.com>
 <8e3c9ebc-e047-4dfd-ad1d-6bbe918aa98b@csgroup.eu> <CANn89iLTGLe2uWz+yCu5ewnDBW2hubqGm8=aRbZVTeXN1Trdaw@mail.gmail.com>
 <49844fde-9424-4c81-85a0-c5c26a77321d@csgroup.eu>
In-Reply-To: <49844fde-9424-4c81-85a0-c5c26a77321d@csgroup.eu>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 13:04:02 +0100
Message-ID: <CANn89i+m5fBZZYRYXHZswpZNt8J-VCmGFOeSH1hiK965p9R1yQ@mail.gmail.com>
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

On Tue, Dec 17, 2024 at 12:56=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 17/12/2024 =C3=A0 10:52, Eric Dumazet a =C3=A9crit :
> > On Tue, Dec 17, 2024 at 10:41=E2=80=AFAM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >>
> >>
> >> Le 17/12/2024 =C3=A0 10:20, Eric Dumazet a =C3=A9crit :
> >>> On Tue, Dec 17, 2024 at 9:59=E2=80=AFAM Christophe Leroy
> >>> <christophe.leroy@csgroup.eu> wrote:
> >>>>
> >>>>
> >>>>
> >>>> Le 17/12/2024 =C3=A0 09:16, Eric Dumazet a =C3=A9crit :
> >>>>> On Tue, Dec 17, 2024 at 8:18=E2=80=AFAM Christophe Leroy
> >>>>> <christophe.leroy@csgroup.eu> wrote:
> >>>>>>
> >>>>>> The following problem is encountered on kernel built with
> >>>>>> CONFIG_PREEMPT. An snmp daemon running with normal priority is
> >>>>>> regularly calling ioctl(SIOCGMIIPHY). Another process running with
> >>>>>> SCHED_FIFO policy is regularly reading /sys/class/net/eth0/carrier=
.
> >>>>>>
> >>>>>> After some random time, the snmp daemon gets preempted while holdi=
ng
> >>>>>> the RTNL mutex then the high priority process is busy looping into
> >>>>>> carrier_show which bails out early due to a non-successfull
> >>>>>> rtnl_trylock() which implies restart_syscall(). Because the snmp
> >>>>>> daemon has a lower priority, it never gets the chances to release
> >>>>>> the RTNL mutex and the high-priority task continues to loop foreve=
r.
> >>>>>>
> >>>>>> Replace the trylock by lock_interruptible. This will increase the
> >>>>>> priority of the task holding the lock so that it can release it an=
d
> >>>>>> allow the reader of /sys/class/net/eth0/carrier to actually perfor=
m
> >>>>>> its read.
> >>>>>>
> >>>>
> >>>> ...
> >>>>
> >>>>>>
> >>>>>> Fixes: 336ca57c3b4e ("net-sysfs: Use rtnl_trylock in sysfs methods=
.")
> >>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >>>>>> ---
> >>>>>
> >>>>> At a first glance, this might resurface the deadlock issue Eric W. =
Biederman
> >>>>> was trying to fix in 336ca57c3b4e ("net-sysfs: Use rtnl_trylock in
> >>>>> sysfs methods.")
> >>>>
> >>>> Are you talking about the deadlock fixed (incompletely) by 5a5990d30=
90b
> >>>> ("net: Avoid race between network down and sysfs"), or the complemen=
t
> >>>> provided by 336ca57c3b4e ?
> >>>>
> >>>> My understanding is that mutex_lock() will return EINTR only if a si=
gnal
> >>>> is pending so there is no need to set signal_pending like it was whe=
n
> >>>> using mutex_trylock() which does nothing when the mutex is already l=
ocked.
> >>>>
> >>>> And an EINTR return is expected and documented for a read() or a
> >>>> write(), I can't see why we want ERESTARTNOINTR instead of ERSTARTSY=
S.
> >>>> Isn't it the responsibility of the user app to call again read or wr=
ite
> >>>> if it has decided to not install the necessary sigaction for an
> >>>> automatic restart ?
> >>>>
> >>>> Do you think I should instead use rtnl_lock_killable() and return
> >>>> ERESTARTNOINTR in case of failure ? In that case, is it still possib=
le
> >>>> to interrupt a blocked 'cat /sys/class/net/eth0/carrier' which CTRL+=
C ?
> >>>
> >>> Issue is when no signal is pending, we have a typical deadlock situat=
ion :
> >>>
> >>> One process A is :
> >>>
> >>> Holding sysfs lock, then attempts to grab rtnl.
> >>>
> >>> Another one (B) is :
> >>>
> >>> Holding rtnl, then attempts to grab sysfs lock.
> >>
> >> Ok, I see.
> >>
> >> But then what can be the solution to avoid busy looping with
> >> mutex_trylock , not giving any chance to the task holding the rtnl to
> >> run and unlock it ?
> >
> > One idea would be to add a usleep(500, 1000) if the sysfs read/write ha=
ndler in
> > returns -ERESTARTNOINTR;
> >
> > Totally untested idea :
> >
> > diff --git a/fs/seq_file.c b/fs/seq_file.c
> > index 8bbb1ad46335c3b8f50dd35d552f86767e62ead1..276c6d594129a18a7a4c2b1=
df447b34993398ab4
> > 100644
> > --- a/fs/seq_file.c
> > +++ b/fs/seq_file.c
> > @@ -290,6 +290,8 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct
> > iov_iter *iter)
> >                  m->read_pos +=3D copied;
> >          }
> >          mutex_unlock(&m->lock);
> > +       if (copied =3D=3D -ERESTARTNOINTR)
> > +               usleep_range(500, 1000);
> >          return copied;
> >   Enomem:
> >          err =3D -ENOMEM;
>
> Ok, that may solve the issue, but it looks more like a hack than a real
> solution, doesn't it ?
> It doesn't guarantee that the task holding the RTNL lock will be given
> the floor to run and free the lock.

I am sure all for a real solution, what do you suggest ?

>
> The real issue is the nest between sysfs lock and RTNL lock. Can't we
> ensure that they are always held in the same order ?

Problem : adding/removing netdevices may add/remove sysfs files.

Adding/removing netdevices is done under rtnl.

