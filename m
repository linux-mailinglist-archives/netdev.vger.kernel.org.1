Return-Path: <netdev+bounces-208624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431C0B0C64B
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06091632F9
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864072DBF48;
	Mon, 21 Jul 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GnYMTZ0r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154E2DAFCE
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108090; cv=none; b=Dc3I9GRCjsojcE2IfjYO8eELYL51jZ0HqCmBEBBhTXifJtd462vj+GT1dbHMqxw7I0NjblkCzkT4WEVlsGfq060eGV9wpKaLF7l7NVlwGrDK7yV9AsiOONnKl2/YZfTkF/huU8dhEDHFFUgk5Cvi+tc9Erryf6nwABnOuvTOqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108090; c=relaxed/simple;
	bh=CcccSm3GHzr4qIrGIOI4ZwkyR+VY2PHVFQePrQTlrmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuWHziJXl7RndJzbKrFMDmZsxhiuPy1ci49cKVIW6NZQDKqtrbpweBU47KP+gxBX8P/YHV2KAVeB0MAEsSD0iFDrUwvmGFqX9mSh0vUjlW6VeYwGaIRB3sJXYM5bhsblMqcGatZBNRp+TF/bD4piokEJ83fQkJgY/+JET9+RAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GnYMTZ0r; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-719728a1811so17076517b3.3
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1753108087; x=1753712887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhKTn69GUZnWk4nkXibJbALsxXvYMvOYTGqKmIh+//A=;
        b=GnYMTZ0rvmjELkRHryTfxjHm+J49jxn2HTN0zh1xvDBh3DDRpYVt39ZQ8pnayRWHPS
         Tf1GPVCCFybSoPKwHinKKePaIxYWf2aCqUYrRQ8iOSnq/kM66nHq36uTyilCfiu4rgzk
         8DisV0QaZRoYlUauovYX8C93yJ3WsZVpAvSTGMGKi2aGao4yoJFAJSdjA6Dv2ogBmkyk
         hxxZfSzDTZq4iMdZY6HQcrSQy4djSs1wCM1lE/vpVo85metfIMBTZ3zh3x7XJ/+oH3lC
         JBvV150gfdl556/jHfkFcpwK4vcBoMImNa473/y0dIwFvWQtJJJzSv/KkyhsuKAgIdCA
         ureg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108087; x=1753712887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhKTn69GUZnWk4nkXibJbALsxXvYMvOYTGqKmIh+//A=;
        b=klELbqRzEGtsNMix2HjHiDxafkdODTMyQFoM2kOSxqzf4DYpoi0NBahm3WHnhjc7+a
         k8W0zjOprOjNkq8gDlColCmG/jZ/aHjfsEmwpIwpT6S0gKJHGPVWIvQXd16XdRh23Lbo
         EvDXk4wDP6Fs9PDmmYzhFRvOWKZcGDfULgUr/EtUeiiuXtmbkA2c3DIUoxFuPMzkx0jc
         1CBW2/l7psDIbhkCsVdr2iysURYRkRCQ10gyslLb7P9IAoe/H5otL7hH4ffjVqyZ267O
         u+KaTMQRHePxD3Xd51xBOJpP9HyNpLjLAnxULS/oB3Z2G3KlLU36uSFdXvr4VZWm9YK5
         nrBg==
X-Gm-Message-State: AOJu0YxGXO1+0MtyyZquMHhTLhH6ox1QeMveZO+He7WSgn4T8UNkOaVb
	QPNn70qaQEdSExAiKetFpRJDzgH/KzbfxKu4k53UfmgSCRSd+tYzzppKxsOi5JOVVRMRcHjpw3L
	woVPndH2oWEWJQ9Ody8LSR6Z+YjDvQIInd7ACvwU5
X-Gm-Gg: ASbGncsc7RN6y0450aMLOGAUtgWDOPoPWaF4nnZ1mVx+S3zkkJJCijNpzLPW/QkrEvh
	e1MbYwXvM1mZ1H4IWGfkVA8XcMCmZcIDvLeTxurG5hvvcQRmR5DL/MAF65tokdEM7IwrFisgm2T
	OcdzFD3GGni0euM6Q69Ipd4cfWDLX0cwatfWEZy+lWWXfyIXPHsRqRc4BfyswjIGE1Rd/7fEui7
	qkaNXWaapwVhTI=
X-Google-Smtp-Source: AGHT+IGQFPNa10v/vN+L4iepX0YhUryKkxwCKDZKbOhQMTFk3kOevnDz1qLhW7ecXlEQ/PDhzwvrI89vDqfRrNEuIlo=
X-Received: by 2002:a05:690c:45ca:b0:70e:326:6aeb with SMTP id
 00721157ae682-718a335df8cmr207388597b3.10.1753108087102; Mon, 21 Jul 2025
 07:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719220341.1615951-1-xiyou.wangcong@gmail.com> <CAM0EoMmTZon=nFmLsDPKhDEzHruw701iV9=mq92At9oKo0LGpA@mail.gmail.com>
In-Reply-To: <CAM0EoMmTZon=nFmLsDPKhDEzHruw701iV9=mq92At9oKo0LGpA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 21 Jul 2025 10:27:53 -0400
X-Gm-Features: Ac12FXy1oF_kk-Y_ueH-7JxLovDedNZ7zbLwx9pmQ4ut46BBILQWByQ95MjyXQI
Message-ID: <CAM0EoMnexkyxN83S_cGh+da2kSCg5sB4g-kE5qqnMH6eF8m5gQ@mail.gmail.com>
Subject: Re: [Patch v4 net 0/6] netem: Fix skb duplication logic and prevent
 infinite loops
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, will@willsroot.io, stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 10:00=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Sat, Jul 19, 2025 at 6:04=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.c=
om> wrote:
> >
> > This patchset fixes the infinite loops due to duplication in netem, the
> > real root cause of this problem is enqueuing to the root qdisc, which i=
s
> > now changed to enqueuing to the same qdisc. This is more reasonable,
> > more predictable from users' perspective, less error-proone and more el=
egant.
> >
> > Please see more details in patch 1/6 which contains two pages of detail=
ed
> > explanation including why it is safe and better.
> >
> > This replaces the patches from William, with much less code and without
> > any workaround. More importantly, this does not break any use case.
> >
>
> Cong, you are changing user expected behavior.
> So instead of sending to the root qdisc, you are looping on the same
> qdisc. I dont recall what the history is for the decision to go back

Digging a bit, check the following history:
Commit ID: d5d75cd6b10d
Commit ID: 0afb51e72855

Sorry - in travel mode so cant look closely..

cheers,
jamal

> to the root qdisc - but one reason that sounds sensible is we want to
> iterate through the tree hierarchy again. Stephen may remember.
> The fact that the qfq issue is hit indicates the change has
> consequences - and given the check a few lines above, more than likely
> you are affecting the qlen by what you did.
>
> cheers,
> jamal
> > All the test cases pass with this patchset.
> >
> > ---
> > v4: Added a fix for qfq qdisc (2/6)
> >     Updated 1/6 patch description
> >     Added a patch to update the enqueue reentrant behaviour tests
> >
> > v3: Fixed the root cause of enqueuing to root
> >     Switched back to netem_skb_cb safely
> >     Added two more test cases
> >
> > v2: Fixed a typo
> >     Improved tdc selftest to check sent bytes
> >
> >
> > Cong Wang (6):
> >   net_sched: Implement the right netem duplication behavior
> >   net_sched: Check the return value of qfq_choose_next_agg()
> >   selftests/tc-testing: Add a nested netem duplicate test
> >   selftests/tc-testing: Add a test case for piro with netem duplicate
> >   selftests/tc-testing: Add a test case for mq with netem duplicate
> >   selftests/tc-testing: Update test cases with netem duplicate
> >
> >  net/sched/sch_netem.c                         |  26 ++--
> >  net/sched/sch_qfq.c                           |   2 +
> >  .../tc-testing/tc-tests/infra/qdiscs.json     | 114 +++++++++++++-----
> >  .../tc-testing/tc-tests/qdiscs/netem.json     |  25 ++++
> >  4 files changed, 127 insertions(+), 40 deletions(-)
> >
> > --
> > 2.34.1
> >

