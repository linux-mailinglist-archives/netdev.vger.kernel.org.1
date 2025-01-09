Return-Path: <netdev+bounces-156751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B2A07C5B
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA54188C443
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546A21A42C;
	Thu,  9 Jan 2025 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK/zhna/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9A14D6F9
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437664; cv=none; b=lwuIEQ0seRF1aCjXSinTeOq30zS3RqTvIxdZr2n6tHXpAduhApNbYxN1r2c/eKD850APM7C1kLtcO7ehSjRLEyMVMwoVBpUa4hywvFKVP9rpQXbXVXGsJbB+Q8Cl3wgSWzWkElx5XuKMJjlChTgsjv/SYqsJ/5HEbXwC3lzBEcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437664; c=relaxed/simple;
	bh=FwRc5w/Cbfd/75LqiaadKhUorUVR0aomnvAmVFsBBPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnQE+VsuuaZ0zjFxnKrcu/Wqu0z63b6PTeGtchV/qwsrcMF9tgJdjTJU7FnOFBz+YSKfSF7Ldv9vpvs7xEwO7iFJPkviE8A7CNZLqs6jro8e9bViDyzzYjBe4YnP6xX3aMKfW7/CmyMpgSfuGdljU0fBRLhx/jRLLSI7rXHeCLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK/zhna/; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a9cb8460f7so6454145ab.2
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 07:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736437661; x=1737042461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pb6kNDYGesGw4YsIQlr8SphyjqZTdljtimufmTEUnk=;
        b=RK/zhna/BI4XypIy2nH0KtF0z0qk9Oa774GMKeQdv8110qrMHf8eCCbhwoycpfsV49
         5NnvjoK3wm0fhoNFFlUJpo97AhcW3acTfVqT8EsFXC9HJggZ7+1eyjFJyjuDWeXsgiLr
         IiR6eG8ELUXM+hbBhZ/3wlHggjSN/e3mJIOZbFKInVw6DT05T0JEYu7v0orJ1YvXj6q8
         EWf6pzpYm15efTl4qHxz9LOJFonjYsdOvGXDQ1Ekz+BGyn9p+PZP5s6e3ZW2h+4Er5si
         jaYxj/z04zlqNvqGUMN8rRmA18r29TVef4qRAJfnPBuGOm821wiB/bLFXBcGboB2N7W4
         xGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736437661; x=1737042461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pb6kNDYGesGw4YsIQlr8SphyjqZTdljtimufmTEUnk=;
        b=EXfUNRJNOLn5e6dqdj6W3KDsYiyix3BxYM9FMzQn/pAdUJm/6bcu0HjKTLxmJ5u+X8
         CZ0WeoBaCtaQq24DRD+Xka5XpgH9+nPqgCq/nvBmdaxWARS9Dc6/WFmjXYMsibTy3d71
         mJjhKXP8B5mgQQylKKcgefmWDnqjQPddW9j6yIJ96eZU4d4TnepbMOaoIhWZLOOo7Fxl
         nwjBVI0bTupGCb/VPjIcL0TRV5W/4rmr0bphLO8ni/0nSEOu7YJ6CaQeKCI0gAzzXYG0
         VPb6SbrHwz1Jd4p0DfV9Uk9J3E3cyajN/TRoPSkETeEE6+jYamn6Q5jzNYUrP358WTCm
         Xt7Q==
X-Gm-Message-State: AOJu0YxSWZ2ItwGmDb4TB6HY4rOhGnWB1ytOp2tmz24kTSFw8E1t4kyu
	/+G3fzQa2cX2izuh8pDfgc86e9X888fRnvD99Udejpc9RzS7ocMHEYbgH0hnSf/IIXG6koNIuaA
	wsOyvt7I6RjbnaNcsy++kDJHbqx50aeGl
X-Gm-Gg: ASbGncvQd6BI5dhTC5BscsJXTFmRwt9nlN6kcTPvD0dkc0nYM0cMf7YP0Y6WdUEsVhd
	2KW1DgI+vTMfltdgy4PhgZzFt/PSCDutHcADsLlQ=
X-Google-Smtp-Source: AGHT+IFXrSk3x4wtuxxcb64E2dP4TYuEYMZYlSalNhpNhk9wGi/f6Bn7cmqx65SenkChVe4dFOn0nKql7mGP8uDQRU4=
X-Received: by 2002:a05:6e02:1607:b0:3a7:66e0:a98a with SMTP id
 e9e14a558f8ab-3ce3a877f10mr48737525ab.9.1736437661403; Thu, 09 Jan 2025
 07:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b9e81aa97ab8ca62e979b7d55c2ee398790b935b.1736176112.git.lucien.xin@gmail.com>
 <e20ce5c1-9cd4-4719-9c3b-93ca8a947298@redhat.com>
In-Reply-To: <e20ce5c1-9cd4-4719-9c3b-93ca8a947298@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 9 Jan 2025 10:47:30 -0500
X-Gm-Features: AbW1kvaB_zrsSYjuIcoVpImfVdrB6OdPufBTzqL8veqGkU-CGSyL24gYE34h_pQ
Message-ID: <CADvbK_chW7898xRLXeJkis3dLnDjP72MZQ__5GB57R1OHW6Z3w@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: refine software bypass handling in tc_run
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, davem@davemloft.net, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, ast@fiberby.net, Shuang Li <shuali@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 5:46=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 1/6/25 4:08 PM, Xin Long wrote:
> > This patch addresses issues with filter counting in block (tcf_block),
> > particularly for software bypass scenarios, by introducing a more
> > accurate mechanism using useswcnt.
> >
> > Previously, filtercnt and skipswcnt were introduced by:
> >
> >   Commit 2081fd3445fe ("net: sched: cls_api: add filter counter") and
> >   Commit f631ef39d819 ("net: sched: cls_api: add skip_sw counter")
> >
> >   filtercnt tracked all tp (tcf_proto) objects added to a block, and
> >   skipswcnt counted tp objects with the skipsw attribute set.
> >
> > The problem is: a single tp can contain multiple filters, some with ski=
psw
> > and others without. The current implementation fails in the case:
> >
> >   When the first filter in a tp has skipsw, both skipswcnt and filtercn=
t
> >   are incremented, then adding a second filter without skipsw to the sa=
me
> >   tp does not modify these counters because tp->counted is already set.
> >
> >   This results in bypass software behavior based solely on skipswcnt
> >   equaling filtercnt, even when the block includes filters without
> >   skipsw. Consequently, filters without skipsw are inadvertently bypass=
ed.
> >
> > To address this, the patch introduces useswcnt in block to explicitly c=
ount
> > tp objects containing at least one filter without skipsw. Key changes
> > include:
> >
> >   Whenever a filter without skipsw is added, its tp is marked with uses=
w
> >   and counted in useswcnt. tc_run() now uses useswcnt to determine soft=
ware
> >   bypass, eliminating reliance on filtercnt and skipswcnt.
> >
> >   This refined approach prevents software bypass for blocks containing
> >   mixed filters, ensuring correct behavior in tc_run().
> >
> > Additionally, as atomic operations on useswcnt ensure thread safety and
> > tp->lock guards access to tp->usesw and tp->counted, the broader lock
> > down_write(&block->cb_lock) is no longer required in tc_new_tfilter(),
> > and this resolves a performance regression caused by the filter countin=
g
> > mechanism during parallel filter insertions.
> >
> >   The improvement can be demonstrated using the following script:
> >
> >   # cat insert_tc_rules.sh
> >
> >     tc qdisc add dev ens1f0np0 ingress
> >     for i in $(seq 16); do
> >         taskset -c $i tc -b rules_$i.txt &
> >     done
> >     wait
> >
> >   Each of rules_$i.txt files above includes 100000 tc filter rules to a
> >   mlx5 driver NIC ens1f0np0.
> >
> >   Without this patch:
> >
> >   # time sh insert_tc_rules.sh
> >
> >     real    0m50.780s
> >     user    0m23.556s
> >     sys           4m13.032s
> >
> >   With this patch:
> >
> >   # time sh insert_tc_rules.sh
> >
> >     real    0m17.718s
> >     user    0m7.807s
> >     sys     3m45.050s
> >
> > Fixes: 047f340b36fc ("net: sched: make skip_sw actually skip software")
> > Reported-by: Shuang Li <shuali@redhat.com>
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>
> Given the quite large scope of this change and the functional and
> performance implications, I think it's more suited for net-next.
>
Sounds fine to me.

> > ---
> >  include/net/pkt_cls.h     | 18 +++++++-------
> >  include/net/sch_generic.h |  5 ++--
> >  net/core/dev.c            | 11 ++-------
> >  net/sched/cls_api.c       | 52 +++++++++------------------------------
> >  net/sched/cls_bpf.c       |  2 ++
> >  net/sched/cls_flower.c    |  2 ++
> >  net/sched/cls_matchall.c  |  2 ++
> >  net/sched/cls_u32.c       |  2 ++
> >  8 files changed, 32 insertions(+), 62 deletions(-)
> >
> > diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> > index cf199af85c52..d66cb315a6b5 100644
> > --- a/include/net/pkt_cls.h
> > +++ b/include/net/pkt_cls.h
> > @@ -74,15 +74,6 @@ static inline bool tcf_block_non_null_shared(struct =
tcf_block *block)
> >       return block && block->index;
> >  }
> >
> > -#ifdef CONFIG_NET_CLS_ACT
> > -DECLARE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
>
> I think it would be better, if possible, to preserve this static key;
> will reduce the delta and avoid additional tests in fast-path for S/W
> only setup.
That's difficult. This static key will in/decrement according to
block->useswcnt, and we have to hold down_write(&block->cb_lock)
for its update when adding a filter, and the performance issue
will come back again.

>
> > -
> > -static inline bool tcf_block_bypass_sw(struct tcf_block *block)
> > -{
> > -     return block && block->bypass_wanted;
> > -}
> > -#endif
> > -
> >  static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
> >  {
> >       WARN_ON(tcf_block_shared(block));
> > @@ -760,6 +751,15 @@ tc_cls_common_offload_init(struct flow_cls_common_=
offload *cls_common,
> >               cls_common->extack =3D extack;
> >  }
> >
> > +static inline void tcf_proto_update_usesw(struct tcf_proto *tp, u32 fl=
ags)
> > +{
> > +     if (tp->usesw)
> > +             return;
> > +     if (tc_skip_sw(flags) && tc_in_hw(flags))
> > +             return;
> > +     tp->usesw =3D true;
> > +}
>
> It looks like 'usesw' is never cleared. Can't user-space change the
> skipsw flag for an existing tp?
skipsw flag belongs to a tc rule/filter, and a tp may include multiple
rules/filters, and a tp doesn't have flags for skipsw directly.

Now we are adding a tp->usesw to reflect if any rule without skipsw flag
is ever added in this tp. And yes, this tp->usesw will NOT be cleared
even if this rule without the skipsw flag is deleted. I guess that's
all we can do now.

If we want to use a tp->skipswcnt to dynamically track the skipsw flag
for a tp, some common code/functions for rule adding and deleting will
be needed. However,there's no such code in tc for a rule deleting, so
it's not doable unless we touch all cls_*.c files.

>
> [...]
> > diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> > index d3a03c57545b..5e8f191fd820 100644
> > --- a/net/sched/cls_u32.c
> > +++ b/net/sched/cls_u32.c
> > @@ -1164,6 +1164,8 @@ static int u32_change(struct net *net, struct sk_=
buff *in_skb,
> >               if (!tc_in_hw(n->flags))
> >                       n->flags |=3D TCA_CLS_FLAGS_NOT_IN_HW;
> >
> > +             tcf_proto_update_usesw(tp, n->flags);
>
> Why don't you need to hook also in the 'key existing' branch on line 909?
>
Good catch, didn't notice that cls_u32 calls to replace hw filter in
two places.

Thanks.

