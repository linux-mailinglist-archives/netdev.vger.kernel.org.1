Return-Path: <netdev+bounces-229521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA25BDD764
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2FF3B13F3
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D0C3064AB;
	Wed, 15 Oct 2025 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lactOngR"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33B30649F
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517672; cv=none; b=t1bd5XjnSr/lCuRmViFBcxdkkedNPeZdkijSNBBPqLnw6A0Qo5zzowWuxu58Rlt3fKA/kBmZ3k08R0J55FpzP4Rq7/+M93rorBR9iiytPmDQ96TzRShi/lTPmHjj7+dvonjTo5rW4wpm812Skk/Om4gl6llWG8BRKkENUgl/QmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517672; c=relaxed/simple;
	bh=f6hvt/NkFdxn6Xx1792HgfmUP0Dn5MOAPtACW0y82Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXOQ2BeNnv8oSa3ie/inkH8zhaahD6vptcpXACYeuLYVCBiAYqirYlo8HvemlfLncNi5Txnlr/qhm0pGNIjpWtA3AWPKpRxI9LvjK/+OXYJ0OZTSuEzOmPl82Ef1PqGZ+gGfnH8Mu03MTMKOwuntqfEgvnIN4php1O0dXUbUE8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lactOngR; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760517665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VSjbHQDh1+KgRk8wHE69Ht5wW5omcZP6fXsOpT7LvU=;
	b=lactOngR0mxUFc31b0rRqonkdWF9lUr/ALYGH20EDawQY1vG2NicmD4EN1klJa/rpZHl9h
	sGEHIf29iB3GfkwFz7RyP9Jru6Lls81qN6qefJSGBzCIpHvbGsGS/YarYMzg+ylIC1qYrT
	IEvX/Pss8uE2T7X6SqgH5PjbHmI1Qvg=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
Subject:
 Re: [PATCH bpf-next 1/4] rcu: factor out migrate_enable_rcu and
 migrate_disable_rcu
Date: Wed, 15 Oct 2025 16:40:43 +0800
Message-ID: <2239372.irdbgypaU6@7950hx>
In-Reply-To:
 <CAADnVQJygR6Pb1SQq=tJUpHVx7wwnSX1A78mXGha+bQArowtHQ@mail.gmail.com>
References:
 <20251014112640.261770-1-dongml2@chinatelecom.cn>
 <20251014112640.261770-2-dongml2@chinatelecom.cn>
 <CAADnVQJygR6Pb1SQq=tJUpHVx7wwnSX1A78mXGha+bQArowtHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/14 22:59, Alexei Starovoitov wrote:
> On Tue, Oct 14, 2025 at 4:27=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Factor out migrate_enable_rcu/migrate_disable_rcu from
> > rcu_read_lock_dont_migrate/rcu_read_unlock_migrate.
> >
> > These functions will be used in the following patches.
> >
> > It's a little weird to define them in rcupdate.h. Maybe we should move
> > them to sched.h?
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  include/linux/rcupdate.h | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index c5b30054cd01..43626ccc07e2 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -988,18 +988,32 @@ static inline notrace void rcu_read_unlock_sched_=
notrace(void)
> >         preempt_enable_notrace();
> >  }
> >
> > -static __always_inline void rcu_read_lock_dont_migrate(void)
> > +/* This can only be used with rcu_read_lock held */
> > +static inline void migrate_enable_rcu(void)
> > +{
> > +       WARN_ON_ONCE(!rcu_read_lock_held());
> > +       if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> > +               migrate_enable();
> > +}
> > +
> > +/* This can only be used with rcu_read_lock held */
> > +static inline void migrate_disable_rcu(void)
> >  {
> > +       WARN_ON_ONCE(!rcu_read_lock_held());
> >         if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> >                 migrate_disable();
> > +}
> > +
> > +static __always_inline void rcu_read_lock_dont_migrate(void)
> > +{
> >         rcu_read_lock();
> > +       migrate_disable_rcu();
> >  }
> >
> >  static inline void rcu_read_unlock_migrate(void)
> >  {
> > +       migrate_enable_rcu();
> >         rcu_read_unlock();
> > -       if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> > -               migrate_enable();
> >  }
>=20
> Sorry. I don't like any of it. It obfuscates the code
> without adding any benefits.

It has a slight performance improving for some BPF type, such as
SK_SKB, SK_MSG.

Hmm, after we make migrate_disable() inline, the performance
improving here is extremely slight. And you are right, it do obfuscate
the code :/

Thanks!
Menglong Dong

>=20
> pw-bot: cr
>=20
>=20





