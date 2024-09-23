Return-Path: <netdev+bounces-129371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5C497F13A
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 21:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F7A1F22785
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975381A0724;
	Mon, 23 Sep 2024 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChhTxxry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A981CA84
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727120200; cv=none; b=PDMxJZ2xAB+GVdGNF2/s7ooRt/RJcZ8A1bMvsUmkF2fzkMEnfNIgCOA3FZ6+N+tVRSvSsmxxHSsn0LU/gLG7Wu9/VyRejTDsJVKSCFhycCcyuWQUZxyt+Ktb8KHxlXA8FEsYevGvUzIinpiGvaWB9VJM0davjaWPuGdM9MgFf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727120200; c=relaxed/simple;
	bh=1m4zcfvdPaz0E2o/eY0QEOXrSHe77n0OpAORGAsn5iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8in9oLxTSicmXbZapjj++d/gq6GSjJ++QX2nbTS9kwoXgH0j3AVs242Yw6dbCOf4pOWeFcyuA4Tkah1UipD3AiZp6QMffhHkeLemYnvaIVaSdzaBA07HGW717pY+zXPl8T99nw2lghzVbg6XK3HlXA3gFsmuMepOwCoChMAeWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChhTxxry; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so3227656a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727120198; x=1727724998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Qi+Kgk43OGPwI/ndQhdjfFDYl0gRjPddN/7xXFWCDA=;
        b=ChhTxxryDyjj9hbx6fCf4YpwgkL5aSn3yGBoI6dvkHFsgRtoZ4ucxQV5tnb3pW2ZAL
         UpLv7pO/EQVt9EMZa409QzC2b2hZZ5eRubJ7WnKyPb7pAUvsPC/uDsn8IhvADIs/crOm
         UTEUXxsu02LDEUB9lxAr3Kt9ae2lybPzs3vrisudCfvoxtqh+cqt1TInTOc21PajkRq9
         O/0YJADafAvmhSZ4gS78+iIkZyks0EKo46biwXz/+F6klUib/NKRGLzyHTMLpe6gj05r
         FN36Dpj5k4Ir4km4+WqsWOYsFVYhe1rgEL2e2GFAvAcNQ1mFQTcU/1gRXXeteazBme7r
         aZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727120198; x=1727724998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Qi+Kgk43OGPwI/ndQhdjfFDYl0gRjPddN/7xXFWCDA=;
        b=n7E7hOTKXbhT0ztE+uKDHra8BqaT6/9kqektMJBDlHlnnmbgOIL0+eetP/UhQPqtAi
         1XNrvqJJlRHknbb7drMWdTCKXKkwsRrhIO03b0SxalbQ1dqPEU3n73Zi5CfUyTtGQGk5
         Pm08OwjCFrEdb6RV9b0d5re7T6Lyf05RTZ+jTsqepSveHeE/wY2o7Vl4ZodPf7DahlgD
         5rntWj41m7+gxhw0DDUlieBWUqu3XzGu7OAsEJZuDA9k+baQ4QH6NHgvtIaWVa7lJAhf
         po3AGzoTZP4hEd7Gh0g6iAh+zDEHEuxy67zMhP9MfxR5Szu3PS/ro/eeFtUzS51UtGyN
         wlMA==
X-Forwarded-Encrypted: i=1; AJvYcCUMVgToEkDz8rq2CjEUu1fuCizMipYtDitAzCKCNZI9UFg0HmUKrtG0wfHRQPQcxmZKubxaQpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7mXB/q1bLdBtsEAnErH4gc8qyXiBImAFEpG6SUFgjJSn8Fqq
	uBZ6y/4ZldAp01XjhP/rCAXtSk+ttzCFSSwA6uxDFS4EFDTbfqPderUx3GbOikPc5ySFnHcKg6e
	TkHtEBHSECz7MM4suepSrz7Bo9tc=
X-Google-Smtp-Source: AGHT+IE3uYFH9c3EdxlvkUdveZWm/vhvQygMPTNk7cPy7EHpLneVGF7k9tpqSLTB0jSIB5VIa0rFLUpHa05oJy88+M8=
X-Received: by 2002:a05:6a21:3489:b0:1d2:e78d:2147 with SMTP id
 adf61e73a8af0-1d30c9d3fe8mr18445180637.6.1727120198354; Mon, 23 Sep 2024
 12:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923170322.535940-1-sahandevs@gmail.com> <CADKFtnS7JRHz1eg8M3V52MAcJUW3bVch2siaoqQSqMPW7ZrfUg@mail.gmail.com>
 <CANn89i+asgFpSSAxavvLe22TW897VaEdyYzMJ_s0JpH+2_RzUA@mail.gmail.com>
 <93d71681-1a3e-4802-a95b-4156fa3847fb@gmail.com> <CANn89i+PnFohFa3Q0DhcVS129u8NVbtnNkUvgCFRKocgP2Ekrw@mail.gmail.com>
In-Reply-To: <CANn89i+PnFohFa3Q0DhcVS129u8NVbtnNkUvgCFRKocgP2Ekrw@mail.gmail.com>
From: Sahand Evs <sahandevs@gmail.com>
Date: Mon, 23 Sep 2024 23:06:26 +0330
Message-ID: <CAEhU8Zy09JLHhiAbPw+es4Pp6Xumg5DrDaNv=jfNvGvuReOnbA@mail.gmail.com>
Subject: Re: [PATCH] net: expose __sock_sendmsg() symbol
To: Eric Dumazet <edumazet@google.com>
Cc: Jordan Rife <jrife@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 10:30=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Sep 23, 2024 at 8:45=E2=80=AFPM Sahand Akbarzadeh <sahandevs@gmai=
l.com> wrote:
> >
> > Yes, existing program still need some modification in order to work and
> > are already broken (from kernel 6.8 to master branch) for some time. Th=
e issue
> > here is there is no direct probe equivalent one could use to update tho=
se scripts.
> >
> > By adding `__sock_sendmsg`, one could attach based on kernel version or=
 do something
> > like this:
> >
> > sudo bpftrace -e 'kprobe:sock_sendmsg,kprobe:__sock_sendmsg {}'
> >
> > which only throws a warning if it can't find the `__sock_sendmsg`
> >
> > - Sahand
>
> Convention on netdev mailing list is to not top post.
>
> Removing the static is not enough, a compiler and linker can
> completely inline / delete this function.
>
> Anyway, I do not think sock_sendmsg() was part of any ABI.
>
> If it was ABI, we would have to reinstate sock_sendmsg(), not making
> __sock_sendmsg() visible.

Sorry about the top posting. I do think this patch is not necessarily a goo=
d
solution to the problem but I'm not sure what is a/the good solution for it=
.
To give more context, I was trying to figure out why this observability scr=
ipt
(written in bpftrace) doesn't work on some kernels and how to fix it.

(goal: calculating network usage per process per thread. recv part
works fine)

 kretprobe:sock_sendmsg
 {
   if (@inetsocket[tid] && retval < 0x7fffffff) {
     @send_bytes[pid, comm, tid] =3D sum(retval);
   }
   delete(@inetsocket[tid])
 }

Script Source:
https://www.gcardone.net/2020-07-31-per-process-bandwidth-monitoring-on-Lin=
ux-with-bpftrace/


> Removing the static is not enough
Should I also add a EXPORT_SYMBOL?

