Return-Path: <netdev+bounces-53619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1572803F08
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50591C20A3A
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0B133CD2;
	Mon,  4 Dec 2023 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="F3zT99W2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA929111
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:10:30 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-db549f869a3so3313358276.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 12:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701720630; x=1702325430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB5VPXjZuljF/dhY1MaEeO2qe30CYfMZI8kCG+x5SJY=;
        b=F3zT99W2x9Fbw/0raHFeQsAfUigPMUBEmnBPPJClzo25tW6YZ+6JrpiQRYUeMla8ib
         6alsVavXe1eILTYfxnk1MZgBeIE7lFXqkwz1puvABNN0yx7+loGojbwiHX1CiQVB+JqM
         +hgx4qigYQnVJbYXxKiRq6APipSRWrWVq2JBpwr5e8TMi/FpQy3bFSkvyM9wpuFPevaa
         ZWMzVqPARWhr3n6wWwbaVfyzHEQt8euEAFVwSwBiAsN6jqQzgOIo6pM9W+ffo/SPd5j8
         Xz1MnKKluEdHUHfqGR9jHf/iNnszl6OxiHhoepJQXWRcihwNhvBoYLkDQwEtZ9tA7i5L
         u+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720630; x=1702325430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jB5VPXjZuljF/dhY1MaEeO2qe30CYfMZI8kCG+x5SJY=;
        b=nSXk5LuUcRqqM2ei7QPRyWDMB6D5jz8/U4f7/PFzR2Xkz6KC4+MpAm2hkU6KPjPFQ+
         BIPW2QLDC2EjxVxW8ZoqGWbacVaarvFomDjL/Nma2SUOKScm5MEZoSRiV2uRJh1dEitC
         P9C2VrqCsQoljPMNAEQM76Jc85FdUNhc6mxMclXy0GQa9R0I2FBMhhbq04j+T3ljbJay
         6oAZDaOignh5lvfEDJGsf3wLQ++2E95scT+VV1cMIZgjZSNLaqwnMfQVPIqZSfY9d7h7
         e1zuEpRbzMs6u/RNISyc/xQhhLaG5WtwpMvwzicxuKGc1pE1T+tJxcAKG8zWzN/e4nK9
         gTVQ==
X-Gm-Message-State: AOJu0Yzg+eQFCXcDXeVCLhTqVBr9DQdMdyv05HEBtqNctjHls6u86qKi
	9DRuvrDGjAhsPA3u3Ieb4z1GGkbR3I7aYgQ5z3ajeg==
X-Google-Smtp-Source: AGHT+IHaHIv+NAzd7EoQU5/bnwQV4DBspUlntpixs/r7HK07s28Vnx8cLw5kQU495rhlyZrVO+cZ//V2P37ruEch78s=
X-Received: by 2002:a81:af26:0:b0:5d7:1941:aa7 with SMTP id
 n38-20020a81af26000000b005d719410aa7mr3531036ywh.66.1701720629927; Mon, 04
 Dec 2023 12:10:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZV8SnZPBV4if5umR@nanopsycho> <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
 <ZV9b0HrM5WespGMW@nanopsycho> <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>
 <ZV9tCT9d7dm7dOeA@nanopsycho> <CAAFAkD-awfzQTO6yRYeooXwW+7zEub0BiGkbke=o=fTKpzN__g@mail.gmail.com>
 <ZV+DPmXrANEh6gF8@nanopsycho> <CAM0EoMkQaEAaKc7D6kVe+p6f=-Ddd7enoKgRdeWBnqbN2zPhfA@mail.gmail.com>
 <CALnP8ZbaT+jdBvaggAPW=yiW61fip6cjnZcU48tb2-5orqdeMg@mail.gmail.com>
 <CAM0EoMmso7Y0g9jQ=FfJLuV9JTDct5Qqb5-W4+nd0Xb9DBkGkA@mail.gmail.com> <ZW2gwaj/LBNL8J3P@nanopsycho>
In-Reply-To: <ZW2gwaj/LBNL8J3P@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 4 Dec 2023 15:10:18 -0500
Message-ID: <CAM0EoMmvkT5JEm7tUNa-zGD1g80usR=KUAF0zO5uDV70Z-5hmA@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Jiri Pirko <jiri@resnulli.us>
Cc: Marcelo Ricardo Leitner <mleitner@redhat.com>, Jamal Hadi Salim <hadi@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	vladbu@nvidia.com, paulb@nvidia.com, pctammela@mojatatu.com, 
	netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 4:49=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Fri, Dec 01, 2023 at 07:45:47PM CET, jhs@mojatatu.com wrote:
> >On Mon, Nov 27, 2023 at 1:52=E2=80=AFPM Marcelo Ricardo Leitner
> ><mleitner@redhat.com> wrote:
> >>
> >> On Mon, Nov 27, 2023 at 10:50:48AM -0500, Jamal Hadi Salim wrote:
> >> > On Thu, Nov 23, 2023 at 11:52=E2=80=AFAM Jiri Pirko <jiri@resnulli.u=
s> wrote:
> >> > >
> >> > > Thu, Nov 23, 2023 at 05:21:51PM CET, hadi@mojatatu.com wrote:
> >> > > >On Thu, Nov 23, 2023 at 10:17=E2=80=AFAM Jiri Pirko <jiri@resnull=
i.us> wrote:
> >> > > >>
> >> > > >> Thu, Nov 23, 2023 at 03:38:35PM CET, jhs@mojatatu.com wrote:
> >> > > >> >On Thu, Nov 23, 2023 at 9:04=E2=80=AFAM Jiri Pirko <jiri@resnu=
lli.us> wrote:
> >> > > >> >>
> >> > > >> >> Thu, Nov 23, 2023 at 02:37:13PM CET, jhs@mojatatu.com wrote:
> >> > > >> >> >On Thu, Nov 23, 2023 at 3:51=E2=80=AFAM Jiri Pirko <jiri@re=
snulli.us> wrote:
> >> > > >> >> >>
> >> > > >> >> >> Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com =
wrote:
> >> > > >> >> >> >This action takes advantage of the presence of tc block =
ports set in the
> >> > > >> >> >> >datapath and multicasts a packet to ports on a block. By=
 default, it will
> >> > > >> >> >> >broadcast the packet to a block, that is send to all mem=
bers of the block except
> >> > > >> >> >> >the port in which the packet arrived on. However, the us=
er may specify
> >> > > >> >> >> >the option "tx_type all", which will send the packet to =
all members of the
> >> > > >> >> >> >block indiscriminately.
> >> > > >> >> >> >
> >> > > >> >> >> >Example usage:
> >> > > >> >> >> >    $ tc qdisc add dev ens7 ingress_block 22
> >> > > >> >> >> >    $ tc qdisc add dev ens8 ingress_block 22
> >> > > >> >> >> >
> >> > > >> >> >> >Now we can add a filter to broadcast packets to ports on=
 ingress block id 22:
> >> > > >> >> >> >$ tc filter add block 22 protocol ip pref 25 \
> >> > > >> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid =
22
> >> > > >> >> >>
> >> > > >> >> >> Name the arg "block" so it is consistent with "filter add=
 block". Make
> >> > > >> >> >> sure this is aligned netlink-wise as well.
> >> > > >> >> >>
> >> > > >> >> >>
> >> > > >> >> >> >
> >> > > >> >> >> >Or if we wish to send to all ports in the block:
> >> > > >> >> >> >$ tc filter add block 22 protocol ip pref 25 \
> >> > > >> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid =
22 tx_type all
> >> > > >> >> >>
> >> > > >> >> >> I read the discussion the the previous version again. I s=
uggested this
> >> > > >> >> >> to be part of mirred. Why exactly that was not addressed?
> >> > > >> >> >>
> >> > > >> >> >
> >> > > >> >> >I am the one who pushed back (in that discussion). Actions =
should be
> >> > > >> >> >small and specific. Like i had said in that earlier discuss=
ion it was
> >> > > >> >> >a mistake to make mirred do both mirror and redirect - they=
 should
> >> > > >> >>
> >> > > >> >> For mirror and redirect, I agree. For redirect and redirect,=
 does not
> >> > > >> >> make much sense. It's just confusing for the user.
> >> > > >> >>
> >> > > >> >
> >> > > >> >Blockcast only emulates the mirror part. I agree redirect does=
nt make
> >> > > >> >any sense because once you redirect the packet is gone.
> >> > > >>
> >> > > >> How is it mirror? It is redirect to multiple, isn't it?
> >> > > >>
> >> > > >>
> >> > > >> >
> >> > > >> >> >have been two actions. So i feel like adding a block to mir=
red is
> >> > > >> >> >adding more knobs. We are also going to add dev->group as a=
 way to
> >> > > >> >> >select what devices to mirror to. Should that be in mirred =
as well?
> >> > > >> >>
> >> > > >> >> I need more details.
> >> > > >> >>
> >> > > >> >
> >> > > >> >You set any port you want to be mirrored to using ip link, exa=
mple:
> >> > > >> >ip link set dev $DEV1 group 2
> >> > > >> >ip link set dev $DEV2 group 2
> >> > > >>
> >> > > >> That does not looks correct at all. Do tc stuff in tc, no?
> >> > > >>
> >> > > >>
> >> > > >> >...
> >> > > >> >
> >> > > >> >Then you can blockcast:
> >> > > >> >tc filter add devx protocol ip pref 25 \
> >> > > >> >  flower dst_ip 192.168.0.0/16 action blockcast group 2
> >> > > >>
> >> > > >> "blockcasting" to something that is not a block anymore. Not ni=
ce.
> >>
> >> +1
> >>
> >> > > >>
> >> > > >
> >> > > >Sorry, missed this one. Yes blockcasting is no longer appropriate=
  -
> >> > > >perhaps a different action altogether.
> >> > >
> >> > > mirret redirect? :)
> >> > >
> >> > > With target of:
> >> > > 1) dev (the current one)
> >> > > 2) block
> >> > > 3) group
> >> > > ?
> >> >
> >> > tbh, I dont like it - but we need to make progress. I will defer to =
Marcelo.
> >>
> >> With the addition of a new output type that I didn't foresee, that
> >> AFAICS will use the same parameters as the block output, creating a
> >> new action for it is a lot of boilerplate for just having a different
> >> name. If these new two actions can share parsing code and everything,
> >> then it's not too far for mirred also use. And if we stick to the
> >> concept of one single action for outputting to multiple interfaces,
> >> even just deciding on the new name became quite challenging now.
> >> "groupcast" is misleading. "multicast" no good, "multimirred" not
> >> intuitive, "supermirred" what? and so on..
> >>
> >> I still think that it will become a very complex action, but well,
> >> hopefully the man page can be updated in a way to minimize the
> >> confusion.
> >
> >Ok, so we are moving forward with mirred "mirror" option only for this t=
hen...
>
> Could you remind me why mirror and not redirect? Does the packet
> continue through the stack?

For mirror it is _a copy_ of the packet so it continues up the stack
and you can have other actions follow it (including multiple mirrors
after the first mirror). For redirect the packet is TC_ACT_CONSUMED -
so removed from the stack processing (and cant be sent to more ports).
That is how mirred has always worked and i believe thats how most
hardware works as well.
So sending to multiple ports has to be mirroring semantics (most
hardware assumes the same semantics).

cheers,
jamal

>
> >
> >cheers,
> >jamal
> >
> >> Cheers,
> >> Marcelo
> >>
> >> >
> >> > cheers,
> >> > jamal
> >> >
> >> > >
> >> > > >
> >> > > >cheers,
> >> > > >jamal
> >> > > >> >
> >> > > >> >cheers,
> >> > > >> >jamal
> >> > > >> >
> >> > > >> >>
> >> > > >> >> >
> >> > > >> >> >cheers,
> >> > > >> >> >jamal
> >> > > >> >> >
> >> > > >> >> >> Instead of:
> >> > > >> >> >> $ tc filter add block 22 protocol ip pref 25 \
> >> > > >> >> >>   flower dst_ip 192.168.0.0/16 action blockcast blockid 2=
2
> >> > > >> >> >> You'd have:
> >> > > >> >> >> $ tc filter add block 22 protocol ip pref 25 \
> >> > > >> >> >>   flower dst_ip 192.168.0.0/16 action mirred egress redir=
ect block 22
> >> > > >> >> >>
> >> > > >> >> >> I don't see why we need special action for this.
> >> > > >> >> >>
> >> > > >> >> >> Regarding "tx_type all":
> >> > > >> >> >> Do you expect to have another "tx_type"? Seems to me a bi=
t odd. Why not
> >> > > >> >> >> to have this as "no_src_skip" or some other similar arg, =
without value
> >> > > >> >> >> acting as a bool (flag) on netlink level.
> >> > > >> >> >>
> >> > > >> >> >>
> >> >
> >>

