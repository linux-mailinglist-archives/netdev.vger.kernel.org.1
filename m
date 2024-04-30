Return-Path: <netdev+bounces-92420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD2C8B70EC
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 12:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E00E1C2241A
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B17B12C547;
	Tue, 30 Apr 2024 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dc3/uwII"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE012C550
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474273; cv=none; b=UZLxgJNGlg9rMRDJXvA9CUBaEazpBKTShyTMQ7pPXuBuUsLkqvP5jLlM8q3o8lxlppsJKsG43sda/LgeNBtFyC8/ODs2mdMGcLxoZcLvaqf+daNILUV0LhtOoNqSygyntW/icaDyFzws6FY29THiLWgspGG4/Lzr/tL2aJdF7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474273; c=relaxed/simple;
	bh=hw91BVZ3BIU2n40tRHa+GbTxvIOGET7aKPy+lD9AJjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDzAU1OQ6j8rHuoRnoCKVNaSQOXVcYHoOpZVCAd87A8me9WUr4lDULZI9M73Cw0WczKU7qFv5my3mmjT7zfZ77nB3kubMFt6CWyXReGsZdfzbc/J6Fqe0aZpZRwItOzZjCvudz13Xzv3YCYGZO1Qk1K7j455HbaTOZgVXHGoFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dc3/uwII; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso1396a12.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 03:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714474270; x=1715079070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TbSRYgv1Lwx30m8U+AB58yuIgcKq4qcQMtSlYHMwBQ=;
        b=Dc3/uwIIgQqNR8lVapNjgkEykw8mtzRpk696AcQ9WYq/H+7/qFY9gcDoVwtOBNXAQG
         JoF9rQqrvFJL3MfjN8KSF470kpQfMhqggJy/V0PM51j5we/NLFqgysmNjw2IZH6A2pmT
         TohC+l7JXV1G06L3ksS37qv99uqdz0j9dRylGHInNUYlk7CGG7uIFmpRonPqz4z+xhCm
         EVRRGNnp5tyzOysuVG6oqcQRHanj029RN7H7NjXCik0Fo263DMgewUCe5lKIIyZshOpC
         SXVG6AU84bnfNK252Kk2UwIyeZCOuEzEOKRQ18rW1xbhfad0FTqFG9ipoRnS/296nuFq
         HwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714474270; x=1715079070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TbSRYgv1Lwx30m8U+AB58yuIgcKq4qcQMtSlYHMwBQ=;
        b=XxzkW/ae2PEupTqAlLe2pbgV8plX0XvNTAQddIlQE1QB1m4Cg7SB9mH76NkF14i6mI
         AtkmGS5T6b86LR5Grd96bOAIJ6ZhIhhl+dr0WEK40gQRzYE8NwsGnQBD7P76/rgIMKTD
         espEyhXtR0eoBEJ2p7rQip4MFbnU9Xkn+Wdd2RMB2vCy/52rMY+MVbWhnWW0QJdZ2Iiu
         dLJa1QpKaNfsulAVdLkHBKZMKkhB9+W5aCXh9k57+lHPZWyvdFWQHGRsF0idEeC6eU0A
         DrmKp+f5l6mKN7DPX/w+5LLKEHOl84BevN+NlJHdNy3Zc59kpcyjREceMEAAb6qmXkCa
         MGEA==
X-Forwarded-Encrypted: i=1; AJvYcCWNsZ+GMKt2+J8MhRU7+ARGACwjjXnv3qZrZyiRDPmbu8SL3eLmXwjJ5Xx6zuIcnAO5IAHDogm/DCmo/RTHOIMR2SdKvzv6
X-Gm-Message-State: AOJu0YzgL6IS3+Jb5FQz+t489cpi+rN9DjofewzpdbT6vaGhmjntwGt/
	2zJr2BdQzW3QBkHyQ42l7Zzjq2rOqQIHjataVpzAdGovGpssy92eAM65aMMD/ClT7X44xTzPTii
	DI6s84631L6EDt3bAeKELCPsq0OJOaUNWTBKp
X-Google-Smtp-Source: AGHT+IFpuwwu5idvQTm1ZTGpLviZvJt6m+HUqd4cA/zlgcldS2q3rjeCdw8cvj+UvD+CUQnKl7++MnivP1qcT5LD7vY=
X-Received: by 2002:aa7:d1cf:0:b0:572:336b:31b7 with SMTP id
 g15-20020aa7d1cf000000b00572336b31b7mr168167edp.2.1714474269852; Tue, 30 Apr
 2024 03:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429221706.1492418-1-naresh.kamboju@linaro.org>
 <CAKa-r6vJjeYqGZERRr=B4ykLf-efPRY3h=HU3y3QxazwZ_cMAg@mail.gmail.com> <CANn89iJ4go0oXSjRaxkdxsUFPCK8kcb8YPt+0d7isK9ZsFrpww@mail.gmail.com>
In-Reply-To: <CANn89iJ4go0oXSjRaxkdxsUFPCK8kcb8YPt+0d7isK9ZsFrpww@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 12:50:58 +0200
Message-ID: <CANn89iJ=Nom+4gUL2yROvobd0VQ=rjW5nVdDHkADxPFMjkn0OQ@mail.gmail.com>
Subject: Re: selftests: tc-testing: tdc.sh: WARNING: at kernel/locking/lockdep.c:1226
 lockdep_register_key
To: Davide Caratti <dcaratti@redhat.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, lkft-triage@lists.linaro.org, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, cpaasch@apple.com, pabeni@redhat.com, xmu@redhat.com, 
	maxim@isovalent.com, anders.roxell@linaro.org, dan.carpenter@linaro.org, 
	arnd@arndb.de, Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:30=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Apr 30, 2024 at 12:17=E2=80=AFPM Davide Caratti <dcaratti@redhat.=
com> wrote:
> >
> > hello,
> >
> > On Tue, Apr 30, 2024 at 12:17=E2=80=AFAM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > While running selftests: tc-testing: tdc.sh the following kernel warn=
ings,
> > > kernel Bug, kernel oops and kernel panic noticed with Linux next-2024=
0429
> > > tag kernel as per the available data.
> > >
> > > This build config is from kselftest merge config[1].
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > selftests: tc-testing: tdc.sh log and crash log
> >
> > the problem is created by [1]. I think that at least we need to guard
> > against failures to allocate sch->cpu_bstats and sch->cpu_qstats,
> > otherwise the dynamic key is registered but never unregistered (though
> > the key is freed  in the error path of of qdisc_alloc() ). But there
> > might be also something else; however, I can reproduce some similar
> > splat, will follow-up on the list.
> >
> > sorry for the noise,
> > --
> > davide
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git=
/commit/?id=3Daf0cb3fa3f9ed258d14abab0152e28a0f9593084
> >
>
> I just had  5 or 6 syzbot reports about this issue.
>
> I tested the following fix.
>
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 31dfd6c7405b01e22fe1b8c80944e2bed7d30ddc..d3f6006b563ccd8827b7af362=
ce9dceaa78f8841
> 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -982,6 +982,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_qu=
eue,
>
>         return sch;
>  errout1:
> +       lockdep_unregister_key(&sch->root_lock_key);
>         kfree(sch);
>  errout:
>         return ERR_PTR(err);

Davide, I will let you send a formal fix. Let me know if you want me
to release a syzbot report.

