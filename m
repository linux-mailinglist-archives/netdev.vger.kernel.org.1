Return-Path: <netdev+bounces-206492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C0FB0347C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F243B1DE4
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 02:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184767262A;
	Mon, 14 Jul 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="aQjzWHUS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4112CDBE
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460242; cv=none; b=AMuvCi/HE0HSluXaJO1WDloKg5XSPbsw7P0rOKsCS+/FRglP2SsdpfvJCEFL1jyM9jM7LgczieLBhBBBZFt2pr/b6LSRoH8XtticUGeEGaATmR3qwNC81QxUH5PVHdOAXojJ/Evdg/WRvbNYlxZIrZHQBnLRacs+UNzTVOKBtvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460242; c=relaxed/simple;
	bh=VfjU38eAwTt0XziaMSWSC3QN+c0VIgN3/uBCuntbJyI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYFxpk2txD7F2UaMBplVctbgDRQEFBx6o3SqlqmhQ4w91cno4EbQWtMHHXEcp35N6osOwYLy9i+eqieb/pIV4hK7pw3YfUen+eHDbO7ScWDACiuWjStLNG3Vp5rPR5sUDGW6PQuK7G481OS37UTk6cvSBWUuac9KEiMKpwwEWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=aQjzWHUS; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1752460230; x=1752719430;
	bh=VfjU38eAwTt0XziaMSWSC3QN+c0VIgN3/uBCuntbJyI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aQjzWHUSeAjmzp9wMqVdfW3bHmZQrNdL9Sruyvh1Ku5uQYaujutIgCnxernuCxzrF
	 P4H8cCTYpo7Y++Hta379sMgZBApySqEvtCn4iO3Wgqv+je8P48znXOyyqkuQET913I
	 GDq+te/kzUOc1ocqVRYdIeB2ihLkT9AYZ31paXOrFYHvNV/BtL7bFCEHtI2tbgYKMq
	 JQNYJFX5iV+4fql7dOUZ7g0jY9a9mCPG6nCjNkjrWxX6gulJipt9jQr1BmDkucFiA4
	 QHuTl52IY/EnZ5rMNTfQBbWoxvYMct3xBgEq1B0baIZTaa0g1PaAWo+FALT3u8jEeX
	 NEXPtt9GX0vNg==
Date: Mon, 14 Jul 2025 02:30:26 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, stephen@networkplumber.org, Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch v3 net 1/4] net_sched: Implement the right netem duplication behavior
Message-ID: <pGE9OHWRSf4oJwC4gS0oPonBy8_0WsDthxgLzBYGBtMVeT_EDc-HAz8NbhJxcWe0NEUrf_a7Fyq2op5FVFujfc2KyO-I38Yx_HlQhFwB0Cs=@willsroot.io>
In-Reply-To: <20250713214748.1377876-2-xiyou.wangcong@gmail.com>
References: <20250713214748.1377876-1-xiyou.wangcong@gmail.com> <20250713214748.1377876-2-xiyou.wangcong@gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 4179139e1b9b21fb9e105b64c863d5ab7de8b6e0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, July 13th, 2025 at 9:48 PM, Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:

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
> Users can now confidently chain multiple netem qdiscs together to achieve
> sophisticated network impairment combinations, knowing that each stage wi=
ll
> apply its effects exactly once to the packet flow, making network testing
> scenarios more reliable and results more deterministic.
>=20
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

FWIW, I suggested changing this behavior to not enqueue from the root a whi=
le ago too on the security mailing list for the HFSC rsc bug (as the re-ent=
rancy violated assumptions in other qdiscs), but was told some users might =
be expecting that behavior and we would break their setups.

If we really want to preserve the ability to have multiple duplicating nete=
ms in a tree, I think Jamal had a good suggestion here to rely on tc_skb_ex=
t extensions [1].

However, I noted that there are implementation issues that we would have to=
 deal with. Copying what I said there [2]:

"The tc_skb_ext approach has a problem... the config option that enables it=
 is NET_TC_SKB_EXT. I assumed this is a generic name for skb extensions in =
the tc subsystem, but unfortunately this is hardcoded for NET_CLS_ACT recir=
culation support.

So what this means is we have the following choices:
1. Make SCH_NETEM depend on NET_CLS_ACT and NET_TC_SKB_EXT
2. Add "|| IS_ENABLED(CONFIG_SCH_NETEM)" next to "IS_ENABLED(CONFIG_NET_TC_=
SKB_EXT)"
3. Separate NET_TC_SKB_EXT and the idea of recirculation support. But I'm n=
ot sure how people feel about renaming config options. And this would requi=
re a small change to the Mellanox driver subsystem.

None of these sound too nice to do, and I'm not sure which approach to take=
. In an ideal world, 3 would be best, but I'm not sure how others would fee=
l about all that just to account for a netem edge case."

Of course, we can add an extra extension enum for netem but that will just =
make this even messier imo.

[1] https://lore.kernel.org/netdev/CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaG=
T6p3-uOD6vg@mail.gmail.com/
[2] https://lore.kernel.org/netdev/lhR3z8brE3wSKO4PDITIAGXGGW8vnrt1zIPo7C10=
g2rH0zdQ1lA8zFOuUBklLOTAgMcw4Z6N5YnqRXRzWnkHO-unr5g62msCAUHow-NmY7k=3D@will=
sroot.io/



