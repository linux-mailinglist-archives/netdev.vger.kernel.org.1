Return-Path: <netdev+bounces-63166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C982B7F5
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 00:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06BC1C24373
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 23:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67B158205;
	Thu, 11 Jan 2024 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="fgWTFVfr"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E51B5811F
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmachata.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TB10Z1092z9sk1;
	Fri, 12 Jan 2024 00:22:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1705015342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=292RVt104+OIsiME6wvx5i4mxWEfS8jlaDtxDDpNIlU=;
	b=fgWTFVfrHuFkAMHNJd6dK9XHwy+xtq8CVgXEGFP3m2T7piXrL1/8o0+27I68u9qa/vZP8q
	ncX5SQhdLhVgbajCC6MLM815Z8jagQ8rnvT8+qDH9/KIbe9q10YZEYESOwbHe7cHsRgmOZ
	qoGFnvu2TxxCi8g0bV436Yy6u8C2fP4GlXePQsXw9xj6x71M2meI0m6wTJRIDThYQeW9DS
	J6dPsUiX0vbcCWdT7P9ERE5s9pma104XKT4iEyqy7A1/Weot6YfAy16Vx5S4l7X0ntSFJA
	cbTzN84NSZxAX1R06jXGjaeS1LUSCd1Jld2gSOBaUd874rNi09aVQlViEWrVww==
References: <20240104125844.1522062-1-jiri@resnulli.us>
 <ZZ6JE0odnu1lLPtu@shredder>
 <CAM0EoM=AGxO0gdeHPi7ST0+-YVuT20ysPbrFkYVXLqGv39oR7Q@mail.gmail.com>
 <CAM0EoMkpzsEWXMw27xgsfzwA2g4CNeDYQ9niTJAkgu3=Kgp81g@mail.gmail.com>
 <878r4volo0.fsf@nvidia.com>
 <CAM0EoMkFkJBGc5wsYec+1QZ_o6tEi6vm_KjAJV8SWB4EOPcppg@mail.gmail.com>
From: Petr Machata <me@pmachata.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@idosch.org>, Jiri
 Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com,
 mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Date: Thu, 11 Jan 2024 22:44:52 +0100
In-reply-to: <CAM0EoMkFkJBGc5wsYec+1QZ_o6tEi6vm_KjAJV8SWB4EOPcppg@mail.gmail.com>
Message-ID: <87zfxbmp5i.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Jamal Hadi Salim <jhs@mojatatu.com> writes:

> On Thu, Jan 11, 2024 at 11:55=E2=80=AFAM Petr Machata <petrm@nvidia.com> =
wrote:
>>
>>
>> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>>
>> > On Thu, Jan 11, 2024 at 10:40=E2=80=AFAM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
>> >>
>> >> On Wed, Jan 10, 2024 at 7:10=E2=80=AFAM Ido Schimmel <idosch@idosch.o=
rg> wrote:
>> >> >
>> >> > On Thu, Jan 04, 2024 at 01:58:44PM +0100, Jiri Pirko wrote:
>> >> > > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>> >> > > index adf5de1ff773..253b26f2eddd 100644
>> >> > > --- a/net/sched/cls_api.c
>> >> > > +++ b/net/sched/cls_api.c
>> >> > > @@ -1428,6 +1428,7 @@ int tcf_block_get_ext(struct tcf_block **p_=
block, struct Qdisc *q,
>> >> > >                     struct tcf_block_ext_info *ei,
>> >> > >                     struct netlink_ext_ack *extack)
>> >> > >  {
>> >> > > +     struct net_device *dev =3D qdisc_dev(q);
>> >> > >       struct net *net =3D qdisc_net(q);
>> >> > >       struct tcf_block *block =3D NULL;
>> >> > >       int err;
>> >> > > @@ -1461,9 +1462,18 @@ int tcf_block_get_ext(struct tcf_block **p=
_block, struct Qdisc *q,
>> >> > >       if (err)
>> >> > >               goto err_block_offload_bind;
>> >> > >
>> >> > > +     if (tcf_block_shared(block)) {
>> >> > > +             err =3D xa_insert(&block->ports, dev->ifindex, dev,=
 GFP_KERNEL);
>> >> > > +             if (err) {
>> >> > > +                     NL_SET_ERR_MSG(extack, "block dev insert fa=
iled");
>> >> > > +                     goto err_dev_insert;
>> >> > > +             }
>> >> > > +     }
>> >> >
>> >> > While this patch fixes the original issue, it creates another one:
>> >> >
>> >> > # ip link add name swp1 type dummy
>> >> > # tc qdisc replace dev swp1 root handle 10: prio bands 8 priomap 7 =
6 5 4 3 2 1
>> >> > # tc qdisc add dev swp1 parent 10:8 handle 108: red limit 1000000 m=
in 200000 max 200001 probability 1.0 avpkt 8000 burst 38 qevent early_drop =
block 10
>> >> > RED: set bandwidth to 10Mbit
>> >> > # tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 m=
in 500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent early_drop =
block 10
>> >> > RED: set bandwidth to 10Mbit
>> >> > Error: block dev insert failed.
>> >> >
>> >>
>> >>
>> >> +cc Petr
>> >> We'll add a testcase on tdc - it doesnt seem we have any for qevents.
>> >> If you have others that are related let us know.
>> >> But how does this work? I see no mention of block on red code and i
>>
>> Look for qe_early_drop and qe_mark in sch_red.c.
>>
>
> I see it...
>
>> >> see no mention of block on the reproducer above.
>> >
>> > Context: Yes, i see it on red setup but i dont see any block being set=
up.
>>
>> qevents are binding locations for blocks, similar in principle to
>> clsact's ingress_block / egress_block. So the way to create a block is
>> the same: just mention the block number for the first time.
>>
>> What qevents there are depends on the qdisc. They are supposed to
>> reflect events that are somehow interesting, from the point of view of
>> an skb within a qdisc. Thus RED has two qevents: early_drop for packets
>> that were chosen to be, well, dropped early, and mark for packets that
>> are ECN-marked. So when a packet is, say, early-dropped, the RED qdisc
>> passes it through the TC block bound at that qevent (if any).
>>
>
> Ok, the confusing part was the missing block command. I am assuming in
> addition to Ido's example one would need to create block 10 and then
> attach a filter to it?
> Something like:
> tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 min
> 500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent
> early_drop block 10
> tc filter add block 10 ...

Yes, correct.

> So a packet tagged for early drop will end up being processed in some
> filter chain with some specified actions. So in the case of offload,
> does it mean early drops will be sent to the kernel and land at the
> specific chain? Also trying to understand (in retrospect, not armchair

For offload, the idea is that the silicon is configured to do the things
that the user configures at the qevent.

In the particular case of mlxsw, we only permit adding one chain with
one filter, which has to be a matchall, and the action has to be either
a mirred or trap, plus it needs to have hw_stats disabled. Because the
HW is limited like that, it can't do much in that context.

> lawyering): why was a block necessary? feels like the goto chain
> action could have worked, no? i.e something like: qevent early_drop
> goto chain x.. Is the block perhaps tied to something in the h/w or is
> it just some clever metainfo that is used to jump to tc block when the
> exceptions happen?

So yeah, blocks are super fancy compared to what the HW can actually do.
The initial idea was to have a single action, but then what if the HW
can do more than that? And qdiscs still exist as SW entitites obviously,
why limit ourselves to a single action in SW? OK, so maybe we can make
that one action a goto chain, where the real stuff is, but where would
it look the chain up? On ingress? Egress? So say that we know where to
look it up, but then also you'll end up with totally unhinged actions on
an ingress / egress qdisc that are there just as jump targets of some
qevent. Plus the set of actions permissible on ingress / egress can be
arbitrarily different from the set of actions permissible on a qevent,
which makes the validation in an offloading driver difficult. And chain
reuse is really not a thing in Linux TC, so keeping a chain on its own
seems wrong. Plus the goto chain is still unclear in that scenario.

Blocks have no such issues, they are self-contained. They are heavy
compared to what we need, true. But that's not really an issue -- the
driver can bounce invalid configuration just fine. And there's no risk
of making another driver or SW datapath user unhappy because their set
of constrants is something we didn't anticipate. Conceptually it's
cleaner than if we had just one action / one rule / one chain, because
you can point at e.g. ingress_block and say, this, it's the same as
this, except instead of all ingress packets, only those that are
early_dropped are passed through.

BTW, newer Spectrum chips actually allow (some?) ACL matching to run in
the qevent context, so we may end up relaxing the matchall requirement
in the future and do a more complex offload of qevents.

> Important thing is we need tests so we can catch these regressions in
> the future.  If you can, point me to some (outside of the ones Ido
> posted) and we'll put them on tdc.

We just have the followin. Pretty sure that's where Ido's come from:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/testing/selftests/drivers/net/mlxsw/sch_red_root.sh
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/testing/selftests/drivers/net/mlxsw/sch_red_ets.sh

Which is doing this (or s/early_drop/mark/ instead):

    tc qdisc add dev $swp3 parent 1: handle 108: red \
            limit 1000000 min $BACKLOG max $((BACKLOG + 1)) \
            probability 1.0 avpkt 8000 burst 38 qevent early_drop block 10

And then installing a rule like one of these:

    tc filter add block 10 pref 1234 handle 102 matchall skip_sw \
            action mirred egress mirror dev $swp2 hw_stats disabled
    tc filter add block 10 pref 1234 handle 102 matchall skip_sw \
            action trap hw_stats disabled
    tc filter add block 10 pref 1234 handle 102 matchall skip_sw \
            action trap_fwd hw_stats disabled

Then in runs traffic and checks the right amount gets mirrored or trapped.

>> > Also: Is it only Red or other qdiscs could behave this way?
>>
>> Currently only red supports any qevents at all, but in principle the
>> mechanism is reusable. With my mlxsw hat on, an obvious next candidate
>> would be tail_drop on FIFO qdisc.
>
> Sounds cool. I can see use even for s/w only dpath.

FIFO is tricky to extend BTW. I wrote some patches way back before it
got backburner'd, and the only payloads that are currently bounced are
those that are <=3D3 bytes. Everything else is interpreted to mean
something, extra garbage is ignored, etc. Fun fun.

