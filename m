Return-Path: <netdev+bounces-35349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325CC7A8FA7
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 00:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC13FB20B48
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 22:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FE43F4AE;
	Wed, 20 Sep 2023 22:56:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB323CF
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 22:56:21 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54393AB
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 15:56:20 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59be6605e1dso4346877b3.3
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 15:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1695250579; x=1695855379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Bn+tvIAXzlnRy2VQVd0Aiy+bk60EOrJb3dFp0Y2GvY=;
        b=tkhqWzX4w9oErKwCyoSwvxQNUzNvuVNMfVON7/WnStvvvLNDbPL6MaHR7vltK5fJE5
         gjB50aDZV42G2LrmtSr8pmxR8Yf/HBxcPUAryWvGz7pmzRsw9OT8jiAhelLXbY2tsNNV
         /S0f+Dv0g3wSSNML8H+NsMTT/B0Zy1xkCxqPJyyGTXrSskrYon7+XEmq9eEtwP+gWjv2
         WRybiurYb7GZEEnxA73fNQ+IH2UpdWyrphYuiyVPymWhN/wL5TDuGVQqdVO+Nvfqa26V
         qC1JXx8rugfitl9PVnOqJgHC8jf6nKV7N4b2uhHcQNxVccw4DzrSkblSqmwOEqObYWRo
         a00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695250579; x=1695855379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Bn+tvIAXzlnRy2VQVd0Aiy+bk60EOrJb3dFp0Y2GvY=;
        b=pBEK2SrSzMyqdFl8uRNaMPH+1a957pKVmGxiIubGSJ6nhRW42KEV77BA4k3w9x/olC
         5S7NbFwdq7bnrVlFHciFZpcesYsLPT/+DXTubQNU3JeolhMjRJGBQTjPHgJYu1qJQVfP
         cxsRsQjIoJN8thV4yHRMpBhyQDS1yHtcrhBmQfTEn9lfqePu+ADYWWr3cGu4ZtGlnbM0
         uHk9YSuok9Qt6r85bvRBvUfT23wvxUJAfuzxZPrD15FUdl9t3BHHgnifx5Px0qi5rNVL
         BFPvSlsaJ2nh1/oW2/trIr1zzNJF0tqQbrlOqbHjA9WYmo8a+FVO5SK0ryZCBwNVXO0E
         9tBw==
X-Gm-Message-State: AOJu0YzkRXr/l8jC3qAaK9Uz52pQZhCx/dIkNVaERJ+yicihMBWbc3g9
	elNqiWz64/eAuOp0aJZfTgaECwNOtA8GGT7g4ifJ3g==
X-Google-Smtp-Source: AGHT+IEubbKcXs8fi8+7qh4oIyK780UJK4ghTyrQi93AbrDMv2goRx98d3Lg0taEhs3VCIYea/IxMdy2rKs5EbrqGFE=
X-Received: by 2002:a81:a111:0:b0:59b:49a0:eec0 with SMTP id
 y17-20020a81a111000000b0059b49a0eec0mr4026245ywg.12.1695250579564; Wed, 20
 Sep 2023 15:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920201715.418491-1-edumazet@google.com> <20230920201715.418491-2-edumazet@google.com>
 <CAM0EoMmKrUwMBqKeBSDCe-pa=7ouMYhCtpv7tRR6uzxkn_hGfA@mail.gmail.com> <CANn89iJNbZq+HWGnWrKBc8ULE=HVK04VUs2TrvWYu5Ef1vy+yQ@mail.gmail.com>
In-Reply-To: <CANn89iJNbZq+HWGnWrKBc8ULE=HVK04VUs2TrvWYu5Ef1vy+yQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 20 Sep 2023 18:56:08 -0400
Message-ID: <CAM0EoMn1U+1WpfaVPkN+WfEd6RP2sb-cwMU_J7aPa88bwf4LaQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/5] net_sched: constify qdisc_priv()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 5:32=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Sep 20, 2023 at 10:45=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Wed, Sep 20, 2023 at 4:17=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > In order to propagate const qualifiers, we change qdisc_priv()
> > > to accept a possibly const argument.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  include/net/pkt_sched.h | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> > > index 15960564e0c364ef430f1e3fcdd0e835c2f94a77..9fa1d0794dfa5241705f9=
a39c896ed44519a9f13 100644
> > > --- a/include/net/pkt_sched.h
> > > +++ b/include/net/pkt_sched.h
> > > @@ -20,10 +20,10 @@ struct qdisc_walker {
> > >         int     (*fn)(struct Qdisc *, unsigned long cl, struct qdisc_=
walker *);
> > >  };
> > >
> > > -static inline void *qdisc_priv(struct Qdisc *q)
> > > -{
> > > -       return &q->privdata;
> > > -}
> > > +#define qdisc_priv(q)                                               =
   \
> > > +       _Generic(q,                                                  =
   \
> > > +                const struct Qdisc * : (const void *)&q->privdata,  =
   \
> > > +                struct Qdisc * : (void *)&q->privdata)
> >
> > Didnt know you could do this - C11? Would old compilers work here or
> > do we have some standardization version around compiler versions?
>
> We already use this in the tree, I would not worry for more instances
> of _Generic()
>

Cool ;->

cheers,
jamal

