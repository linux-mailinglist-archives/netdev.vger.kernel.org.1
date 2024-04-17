Return-Path: <netdev+bounces-88823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ACD8A89E7
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9BB0B22116
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0E8171652;
	Wed, 17 Apr 2024 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hURiV2km"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C017109F
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373711; cv=none; b=ilTSn02NrTDUCobDlboBMe4Yk6RoI6igKa6mscwYYB88dYy/tI4NJdTLXTQqrTiqw/SU+2M4iMPc9DXFzovLQm6V7fXt8DbcQ6ITxKorQZYyFLfIOWfqLAbYgTDopTu9fp5/MirocxuBL7XsHvU5esO3j+fpoZ2OMCzaNEfH5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373711; c=relaxed/simple;
	bh=HzAAzEWoWb+b+m5xZ+ddLeMWHSU8LRBnSyg1i8kMiGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tgvr1ZCE13fFIHK2fyDaksxgcGpl12DnIWFLL2xVAbwnPOJYFCg/+FD0o3qg+iieQ27WXppbavEPL9D0Dy1RLx/3S4t5QdmVoA/rIdl1E/T1fn7XnyvWLn49Vn5lKYR6zsqxTey0YKFhS+cE7Eizn7kbbCOKSounF8e0HizjU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hURiV2km; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so647a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 10:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713373708; x=1713978508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7WqwhtDVeWKdTW4x3Cz1mpTrhXM99PxxKgm0mBnGKE=;
        b=hURiV2kmcXPiX2UUuSXFgZ7DZqWgYSsFwSRThWCE9hAebP3hzJy/zN8CCf/PWKVIgL
         uf4uK5taH9dFzKHAWEvXSR/aj4O3X+OH+fZcxygehoTOZYjXPT2Buu9UZsc72Ri7Ciw5
         9xe+vfTxFcbqC5tSf9/0VbtSW+tTWlaQqaKp0P5rv0asjFPXxrFE6bgB//iA/iv9jlCE
         36zhM2wjuC/TF6tgE0kq+IJEIB7rnYCe1p353n8gSnOPLtJGgYJNnP40QVMAxbF8zcH0
         6JqFmbGIbUZKVU4VO5mEAwGhba9Q/d6NhibmZRCFbfJxoozbXeecJ1oZX0RaPf7ySfPl
         MknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373708; x=1713978508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7WqwhtDVeWKdTW4x3Cz1mpTrhXM99PxxKgm0mBnGKE=;
        b=NK4obE8qbaWr80eC3G0nj9TcTGWxI2CIA4PZDVmrbGGBeV5hnc2mQuXhD+vP6fEiNj
         FxY716hJahqSKtzDMDgE1+5rEnFwVZTHX75AhSiHuBA55FbUaAMdlrTWOuLRM8R5uvfA
         55BRD2r458yx5knmU115GV7zwpjZRr/tdwNTASbAoMfjFy4DBmSWBy+dMjp+lct567oP
         5jzihOyPGIDTq4t9J3GX5YM0ufPhet7mmMZdyuxatSrdaZVjettYyJ7BkhWYwQ8FPRXi
         42kIO3ZTLU3jsi9ddGKNHJUmU8vqPTCRp9dQ//cM2tYvqdenkpaNWdFtqmHSqinLJs4j
         RgMA==
X-Forwarded-Encrypted: i=1; AJvYcCUUnMwfO9N7IQC9e72BVGx0R8pIHRyLvHKVRieDHkPjsc6EhcSdLHrF7tCE+IBpPmb7/03fj/BqQOlXMDC3RrZ+bUb854Zk
X-Gm-Message-State: AOJu0YzMRGnoGo2bmDNUK3YiIXojGbS0YDgv/i/uwjfBh4eqQFvuVt3j
	wsUuUQkmFczt2pXV7lNM92vQDMByJbWFHcDu37hHMQj8WPcOdeFLih2pCGK6bpkwOt51yf6Ib18
	CKUJGBnlMUJOZhiy1FlqewBkh1Zdn0yiw47c4
X-Google-Smtp-Source: AGHT+IG77eS1J0VR8eJjDeTPed0uvnz/elC6LkkcDtmUt8woSRRoODVCFr2zmhyfUw/A/i9LlCtkFcMCuTCu5+Cjn8A=
X-Received: by 2002:a05:6402:686:b0:570:2bbc:77c6 with SMTP id
 f6-20020a056402068600b005702bbc77c6mr209313edy.3.1713373708278; Wed, 17 Apr
 2024 10:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com> <20240415132054.3822230-8-edumazet@google.com>
 <20240417165425.GD2320920@kernel.org>
In-Reply-To: <20240417165425.GD2320920@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 19:08:17 +0200
Message-ID: <CANn89i+Z+Wz_V8+1vaRzVgoZCecTXd4bVhwR5Bjq9+q_3f_s4A@mail.gmail.com>
Subject: Re: [PATCH net-next 07/14] net_sched: sch_ets: implement lockless ets_dump()
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 6:54=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Apr 15, 2024 at 01:20:47PM +0000, Eric Dumazet wrote:
> > Instead of relying on RTNL, ets_dump() can use READ_ONCE()
> > annotations, paired with WRITE_ONCE() ones in ets_change().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/sched/sch_ets.c | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > index 835b4460b44854a803d3054e744702022b7551f4..f80bc05d4c5a5050226e6cf=
d30fa951c0b61029f 100644
> > --- a/net/sched/sch_ets.c
> > +++ b/net/sched/sch_ets.c
>
> ...
>
> > @@ -658,11 +658,11 @@ static int ets_qdisc_change(struct Qdisc *sch, st=
ruct nlattr *opt,
> >                       list_del(&q->classes[i].alist);
> >               qdisc_tree_flush_backlog(q->classes[i].qdisc);
> >       }
> > -     q->nstrict =3D nstrict;
> > +     WRITE_ONCE(q->nstrict, nstrict);
> >       memcpy(q->prio2band, priomap, sizeof(priomap));
>
> Hi Eric,
>
> I think that writing elements of q->prio2band needs WRITE_ONCE() treatmen=
t too.

Not really, these are bytes, a cpu will not write over bytes one bit at a t=
ime.

I could add WRITE_ONCE(), but this is overkill IMO.

>
> >       for (i =3D 0; i < q->nbands; i++)
> > -             q->classes[i].quantum =3D quanta[i];
> > +             WRITE_ONCE(q->classes[i].quantum, quanta[i]);
> >
> >       for (i =3D oldbands; i < q->nbands; i++) {
> >               q->classes[i].qdisc =3D queues[i];
>
> ...
>
> > @@ -733,6 +733,7 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct=
 sk_buff *skb)
> >       struct ets_sched *q =3D qdisc_priv(sch);
> >       struct nlattr *opts;
> >       struct nlattr *nest;
> > +     u8 nbands, nstrict;
> >       int band;
> >       int prio;
> >       int err;
>
> The next few lines of this function are:
>
>         err =3D ets_offload_dump(sch);
>         if (err)
>                 return err;
>
> Where ets_offload_dump may indirectly call ndo_setup_tc().
> And I am concerned that ndo_setup_tc() expects RTNL to be held,
> although perhaps that assumption is out of date.

Thanks, we will add rtnl locking later only in the helper,
or make sure it can run under RCU.

Note the patch series does not yet remove RTNL locking.

Clearly, masking and setting TCQ_F_OFFLOADED in sch->flags in a dump
operation is not very nice IMO.


>
> ...
>
> > @@ -771,7 +773,8 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct=
 sk_buff *skb)
> >               goto nla_err;
> >
> >       for (prio =3D 0; prio <=3D TC_PRIO_MAX; prio++) {
> > -             if (nla_put_u8(skb, TCA_ETS_PRIOMAP_BAND, q->prio2band[pr=
io]))
> > +             if (nla_put_u8(skb, TCA_ETS_PRIOMAP_BAND,
> > +                            READ_ONCE(q->prio2band[prio])))
> >                       goto nla_err;
> >       }
>
> ...

