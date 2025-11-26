Return-Path: <netdev+bounces-242052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9F5C8BDCB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 049E9353CC6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD162877DE;
	Wed, 26 Nov 2025 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="C60H1sP3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D63232395
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764189039; cv=none; b=O4fEEQQsN6e71ZbML2NGYj/EsdPfQW33bYrVRydKT2E/X2vsyE7xNHd/Zzp5N3OmxmH90nhQCbEs8yTCH3B9Sn4bmA/vOmkNQDlwmUMx/GQLSccrv/w/W5/I8n1T9b9ZqCPy06HLC8pgH/el6hdWrP3nZqBAvEfSkDAmeMWx5mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764189039; c=relaxed/simple;
	bh=cj5PD0QudNa0FxLEg6wnNESLZYHPfNo5Vu0nU3cqjN0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlIu1inYuMoqrrywDMYb/XEXLJrUCIYg825KfBTCC9D19HSOsmsre+4iHtvwetaZa4xYtnMTgR5Tcvzc7kJlTl5nyD51HFHagwOj/0wsRbqlZXMwH2novxeq08XjLEzbbkyXL7wdn8HvtxErnQmHjI0dvdF2TPTEX9qdT1cTOEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=C60H1sP3; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1764189025; x=1764448225;
	bh=cj5PD0QudNa0FxLEg6wnNESLZYHPfNo5Vu0nU3cqjN0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=C60H1sP3DMU17MHV5lOHv9Bh01uiFjsmm9XMxvFuaXF26c9syBYS0FL5MJtkAO3hS
	 u4yFSZ2BEBq/mIypFKqnTEGo59dPXj1xa56uvrXX7WjHwgK18hgHEI5UoJsNat6N5e
	 sY9MGvDmQCekHLG67tNABhg3w1SNe3u0B8+KnOKdZ6kOXA4LpjIN5EBuJBuZGL0AsC
	 FiyiNIaLhnHE8H3cRPKn9nOc9CPrMEdcHJ1c8xucFQgVuJh5O7abNfPgQF2GdynRsG
	 ofUSvY0zC0RJroW6/mz9J4o1m9VHOh000ISOvog3ZmOFC11gwc6fK+hK0rQ3cUoPCj
	 ZWNxHc9mjah/w==
Date: Wed, 26 Nov 2025 20:30:21 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, kuba@kernel.org, Savino Dicanosa <savy@syst3mfailure.io>, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [Patch net v5 3/9] net_sched: Implement the right netem duplication behavior
Message-ID: <dEmtK-Tj-bnNJVo0mNwP1vJ1cj9g0hqnoi-0HJdZeTittbRmmzE4wBRIjapBAFQNZDWgE4hcR27UrTSuiGj_-yRFntfX4Tuv4QP6asVecZQ=@willsroot.io>
In-Reply-To: <20251126195244.88124-4-xiyou.wangcong@gmail.com>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com> <20251126195244.88124-4-xiyou.wangcong@gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: e345e8d3e95853ec67dd85530019882c86f1c273
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal should be added to this - he was the one brainstorming fixes for this=
 bug from the very beginning for a whole month [1].

On Wednesday, November 26th, 2025 at 7:53 PM, Cong Wang <xiyou.wangcong@gma=
il.com> wrote:

>=20
>=20
> In the old behavior, duplicated packets were sent back to the root qdisc,
> which could create dangerous infinite loops in hierarchical setups -
> imagine a scenario where each level of a multi-stage netem hierarchy kept
> feeding duplicates back to the top, potentially causing system instabilit=
y
> or resource exhaustion.
>=20
> The new behavior elegantly solves this by enqueueing duplicates to the sa=
me
> qdisc that created them, ensuring that packet duplication occurs exactly
> once per netem stage in a controlled, predictable manner. This change
> enables users to safely construct complex network emulation scenarios usi=
ng
> netem hierarchies (like the 4x multiplication demonstrated in testing)
> without worrying about runaway packet generation, while still preserving
> the intended duplication effects.
>=20
> Another advantage of this approach is that it eliminates the enqueue reen=
trant
> behaviour which triggered many vulnerabilities. See the last patch in thi=
s
> patchset which updates the test cases for such vulnerabilities.
>=20
> Now users can confidently chain multiple netem qdiscs together to achieve
> sophisticated network impairment combinations, knowing that each stage wi=
ll
> apply its effects exactly once to the packet flow, making network testing
> scenarios more reliable and results more deterministic.
>=20

Cong, this approach has an issue we previously raised - please refer to [2]=
. I re-posted the summary of the issues with the various other approaches i=
n [3] just 2 days ago in a thread with you on it. As both Jamal and Stephen=
 have pointed out, this breaks expected user behavior as well, and the enqu=
euing at root was done for the sake of proper accounting and rate limit sem=
antics. You pointed out that this doesn't violate manpage semantics, but th=
is is still changing long-term user behavior. It doesn't make sense imo to =
change one longtime user behavior for another.

Jamal suggested a really reasonable fix with tc_skb_ext - can we please tak=
e a look at its soundness and attempt that approach? No user behavior would=
 be affected in that case.

> I tested netem packet duplication in two configurations:
> 1. Nest netem-to-netem hierarchy using parent/child attachment
> 2. Single netem using prio qdisc with netem leaf
>=20
> Setup commands and results:
>=20
> Single netem hierarchy (prio + netem):
> tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0
> tc filter add dev lo parent 1:0 protocol ip matchall classid 1:1
> tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%
>=20
> Result: 2x packet multiplication (1=E2=86=922 packets)
> 2 echo requests + 4 echo replies =3D 6 total packets
>=20
> Expected behavior: Only one netem stage exists in this hierarchy, so
> 1 ping becomes 2 packets (100% duplication). The 2 echo requests generate
> 2 echo replies, which also get duplicated to 4 replies, yielding the
> predictable total of 6 packets (2 requests + 4 replies).
>=20
> Nest netem hierarchy (netem + netem):
> tc qdisc add dev lo root handle 1: netem limit 1000 duplicate 100%
> tc qdisc add dev lo parent 1: handle 2: netem limit 1000 duplicate 100%
>=20
> Result: 4x packet multiplication (1=E2=86=922=E2=86=924 packets)
> 4 echo requests + 16 echo replies =3D 20 total packets
>=20
> Expected behavior: Root netem duplicates 1 ping to 2 packets, child netem
> receives 2 packets and duplicates each to create 4 total packets. Since
> ping operates bidirectionally, 4 echo requests generate 4 echo replies,
> which also get duplicated through the same hierarchy (4=E2=86=928=
=E2=86=9216), resulting
> in the predictable total of 20 packets (4 requests + 16 replies).
>=20
> The new netem duplication behavior does not break the documented
> semantics of "creates a copy of the packet before queuing." The man page
> description remains true since duplication occurs before the queuing
> process, creating both original and duplicate packets that are then
> enqueued. The documentation does not specify which qdisc should receive
> the duplicates, only that copying happens before queuing. The implementat=
ion
> choice to enqueue duplicates to the same qdisc (rather than root) is an
> internal detail that maintains the documented behavior while preventing
> infinite loops in hierarchical configurations.
>=20
> Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> Reported-by: William Liu will@willsroot.io
>=20
> Reported-by: Savino Dicanosa savy@syst3mfailure.io
>=20
> Signed-off-by: Cong Wang xiyou.wangcong@gmail.com
>=20
> ---
> net/sched/sch_netem.c | 26 +++++++++++++++-----------
> 1 file changed, 15 insertions(+), 11 deletions(-)
>=20
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..191f64bd68ff 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -165,6 +165,7 @@ struct netem_sched_data {
> */
> struct netem_skb_cb {
> u64 time_to_send;
> + u8 duplicate : 1;
> };
>=20
> static inline struct netem_skb_cb *netem_skb_cb(struct sk_buff *skb)
> @@ -460,8 +461,16 @@ static int netem_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
> skb->prev =3D NULL;
>=20
>=20
> /* Random duplication */
> - if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng=
))
>=20
> - ++count;
> + if (q->duplicate) {
>=20
> + bool dup =3D true;
> +
> + if (netem_skb_cb(skb)->duplicate) {
>=20
> + netem_skb_cb(skb)->duplicate =3D 0;
>=20
> + dup =3D false;
> + }
> + if (dup && q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng))
>=20
> + ++count;
> + }
>=20
> /* Drop packet? */
> if (loss_event(q)) {
> @@ -532,17 +541,12 @@ static int netem_enqueue(struct sk_buff *skb, struc=
t Qdisc sch,
> }
>=20
> /
> - * If doing duplication then re-insert at top of the
> - * qdisc tree, since parent queuer expects that only one
> - * skb will be queued.
> + * If doing duplication then re-insert at the same qdisc,
> + * as going back to the root would induce loops.
> */
> if (skb2) {
> - struct Qdisc rootq =3D qdisc_root_bh(sch);
> - u32 dupsave =3D q->duplicate; / prevent duplicating a dup... */
>=20
> -
> - q->duplicate =3D 0;
>=20
> - rootq->enqueue(skb2, rootq, to_free);
>=20
> - q->duplicate =3D dupsave;
>=20
> + netem_skb_cb(skb2)->duplicate =3D 1;
>=20
> + qdisc_enqueue(skb2, sch, to_free);
> skb2 =3D NULL;
> }
>=20
> --
> 2.34.1

[1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsE=
BNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@will=
sroot.io/T/#u
[2] https://lore.kernel.org/netdev/CAM0EoMmTZon=3DnFmLsDPKhDEzHruw701iV9=3D=
mq92At9oKo0LGpA@mail.gmail.com/T/#u
[3] https://lore.kernel.org/netdev/PKMd5btHYmJcKSiIJdtxQvZBEfuS4RQkBnE4M-TZ=
kjUq_Rdj6Wgm8wDmX-p6rIkSRGDJN8ufn0HcDI6-r2lgibdSk7cn1mHIdbZEohJFKMg=3D@will=
sroot.io/

