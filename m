Return-Path: <netdev+bounces-98413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA798D1566
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35C1B21FDB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 07:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494871B3A;
	Tue, 28 May 2024 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ET6iKXZP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C752629C
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716881810; cv=none; b=gA/UspODTjkDnIbFPBSuqxIuB0Y++RCN3d284CefQsdluehQz+slIW9uL6PRbZjYMZmPEDGyEVl9NriOo7KwdvgaMHrQYgdfFjHNv2pu/Cf3rmCqIhDU+T2lda2ZvNdrxxS7z2VO1+iRGlhgM9KzZ5JAqIdRSZCCsP+BrAoVvUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716881810; c=relaxed/simple;
	bh=3lfBlfuZafDnmYBvq9YrNhPjzIfYqdJl60kuvRAWTJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKNQFhW8olW2kpDCm5X5TuFPZTxmecJPgaG65i5mCp1pVFAZr2Xwcf4Wb5r5VTpOlbckqtojpyWg9mnsdQV2Ay24cw+FjUja2wr/ZWuah8Rs/FCMU7oHiuxD5C0KyCeneYohxp25UnpquA/Rud/bDDIfuqF7jS/QT42jRW9SNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ET6iKXZP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-579ce5fbeb6so16154a12.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 00:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716881807; x=1717486607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2r/zvlfR8iRrZ4KE+uhpWyZOhPqSCMciJBHg8xUseg=;
        b=ET6iKXZPIZXsaAlEpRKZYMs4pcXh8mXQBPtQRmAD0mPip1pjazWy+O/vIIGo23WGPW
         BAfl4duLRvsFdC3bnkp4RpjA4btv5vFcWB7G/7iSrYjH9g4YdvIrpiW9/amVOSM/o0bd
         3qn1tAvKUB0UtYke5Pdp9r4YYEKDBa/d1JrLKxRg+D/uilQlkMrCYNfOrtsggtPGvx1v
         GC4JYOWJwHc1oNGp7dreW/fJ0p2flEVTxtR8ktbN6mR/hNR6T1N70EokdWAPEoaUPpeo
         J5MQslWPSnKIprcGukNvRYTCZNeyzIb1s8lU9OxE94bq6c1gMQm0tU1f2a5ujz965V46
         197w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716881807; x=1717486607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2r/zvlfR8iRrZ4KE+uhpWyZOhPqSCMciJBHg8xUseg=;
        b=FY40GoVaRzV49H6QfoK5f9w55I/YSeCnrCxY77YLt5HypP3q/1RfCgrZX2/TVxjx5q
         J6wPZdWawXUWqTKNUSG5I0PzAcwzyug03tcryWik3HEVz5ONh5kjUJszR4KAYpedcA+9
         dERi3dfefXwe5fli+VCBlvKJI0+bBY3OUNeW3th6/UwukFr2TTx8tKTIhWGfSi1JZR+c
         ae+FOfxUVzpuW3QGI8/64wnCOyRcitGDC2je9awLOFo+ec3DwuJBf8PiMLh8VD5etAbJ
         lq/kfaaErmw3bdWhmf8w5of3iqptwYYrDPsXGvPfYiqfCoALY+qtwqMWSIKh7gqWElI2
         xugA==
X-Forwarded-Encrypted: i=1; AJvYcCV3AZEEFDpN5rg/jBSssFceQG5ASyggv8E1bActoq2TvPni44tEhrLY6EoTXdlR24SgEG+fCuatQG3jJv8I8roZKKKzCBC4
X-Gm-Message-State: AOJu0YwBw0NHxgAfeLihwf4Vv44BVv6t80Nr7jBRZWTdrNnSIWCWkoe2
	M3IwcIM3APwOvfXmZeeHAa9+z+j9eoT0dietsRo4BQws+74OC+jeInJQ/E1mMjvyivtmQ9iaybL
	YZ1rI/xny5fsE/bWg0xQEyvLTFFCtbHEcFOAH
X-Google-Smtp-Source: AGHT+IGFBIRDeKoj2x3loduqOUT0eFzl8z6k5vUrS/7qJMuMl+Is6xJvMvbYs0tWL/UuPK+xr9Qce6mKFBZHj0KUXQs=
X-Received: by 2002:a05:6402:5243:b0:574:ea5c:fa24 with SMTP id
 4fb4d7f45d1cf-57869bac296mr401831a12.3.1716881806821; Tue, 28 May 2024
 00:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528021149.6186-1-kerneljasonxing@gmail.com>
 <CANn89iJQWj75y+QpLGQKZ6jBgSgpi0ZtPf4830O8S0Ld2PpqEg@mail.gmail.com> <CAL+tcoCSJrZPvNCW28UWb4HoB905EJpDzovst6oQu-f0JKdhxA@mail.gmail.com>
In-Reply-To: <CAL+tcoCSJrZPvNCW28UWb4HoB905EJpDzovst6oQu-f0JKdhxA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 May 2024 09:36:32 +0200
Message-ID: <CANn89i+zbXNOJtxJjMDVKEFt2LnjSW9xGG71bMBRc_YimuqKLA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: introduce a new MIB for CLOSE-WAIT sockets
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yongming Liu <yomiliu@tencent.com>, 
	Wangzi Yong <curuwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 8:48=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Eric,
>
> On Tue, May 28, 2024 at 1:13=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, May 28, 2024 at 4:12=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > CLOSE-WAIT is a relatively special state which "represents waiting fo=
r
> > > a connection termination request from the local user" (RFC 793). Some
> > > issues may happen because of unexpected/too many CLOSE-WAIT sockets,
> > > like user application mistakenly handling close() syscall.
> > >
> > > We want to trace this total number of CLOSE-WAIT sockets fastly and
> > > frequently instead of resorting to displaying them altogether by usin=
g:
> > >
> > >   netstat -anlp | grep CLOSE_WAIT
> >
> > This is horribly expensive.
>
> Yes.
>
> > Why asking af_unix and program names ?
> > You want to count some TCP sockets in a given state, right ?
> > iproute2 interface (inet_diag) can do the filtering in the kernel,
> > saving a lot of cycles.
> >
> > ss -t state close-wait
>
> Indeed, it is much better than netstat but not that good/fast enough
> if we've already generated a lot of sockets. This command is suitable
> for debug use, but not for frequent sampling, say, every 10 seconds.
> More than this, RFC 1213 defines CurrEstab which should also include
> close-wait sockets, but we don't have this one.

"we don't have this one."
You mean we do not have CurrEstab ?
That might be user space decision to not display it from nstat
command, in useless_number()
(Not sure why. If someone thought it was useless, then CLOSE_WAIT
count is even more useless...)

> I have no intention to
> change the CurrEstab in Linux because it has been used for a really
> long time. So I chose to introduce a new counter in linux mib
> definitions.
>
> >
> > >
> > > or something like this, which does harm to the performance especially=
 in
> > > heavy load. That's the reason why I chose to introduce this new MIB c=
ounter
> > > like CurrEstab does. It do help us diagnose/find issues in production=
.
> > >
> > > Besides, in the group of TCP_MIB_* defined by RFC 1213, TCP_MIB_CURRE=
STAB
> > > should include both ESTABLISHED and CLOSE-WAIT sockets in theory:
> > >
> > >   "tcpCurrEstab OBJECT-TYPE
> > >    ...
> > >    The number of TCP connections for which the current state
> > >    is either ESTABLISHED or CLOSE- WAIT."
> > >
> > > Apparently, at least since 2005, we don't count CLOSE-WAIT sockets. I=
 think
> > > there is a need to count it separately to avoid polluting the existin=
g
> > > TCP_MIB_CURRESTAB counter.
> > >
> > > After this patch, we can see the counter by running 'cat /proc/net/ne=
tstat'
> > > or 'nstat -s | grep CloseWait'
> >
> > I find this counter quite not interesting.
> > After a few days of uptime, let say it is 52904523
> > What can you make of this value exactly ?
> > How do you make any correlation ?
>
> There are two ways of implementing this counter:
> 1) like the counters in 'linux mib definitions', we have to 'diff' the
> counter then we can know how many close-wait sockets generated in a
> certain period.

And what do you make of this raw information ?

if it is 10000 or 20000 in a 10-second period, what conclusion do you get ?

Receiving FIN packets is a fact of life, I see no reason to worry.

> 2) like what CurrEstab does, then we have to introduce a new helper
> (for example, NET_DEC_STATS) to decrement the counter if the state of
> the close-wait socket changes in tcp_set_state().
>
> After thinking more about your question, the latter is better because
> it can easily reflect the current situation, right? What do you think?

I think you are sending not tested patches.

I suggest you use your patches first, and send tests so that we can all see
the intent, how this is supposed to work in the first place.

That would save us time.

Thank you.

