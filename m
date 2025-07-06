Return-Path: <netdev+bounces-204424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E819FAFA605
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDE33B5F4C
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A18D25A350;
	Sun,  6 Jul 2025 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="UiXn8nG1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BE41991CA
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751813971; cv=none; b=VvhS8HMiag8Ps5JQJmC8ucR9bN4BFcXWP0162mUZdhAaWKRe9H1YAaLJdgvhh0eJN1INalVEuMNLfZsyqYU+NDPLzVeXZzVV+IDsJrtu6T/YiKMmFHvcCIvCxuBGqcjh1jygO6CPkn6ElRiZ+WQt6U0p8OUXVzLeJZNCFBOeilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751813971; c=relaxed/simple;
	bh=qBWlMlwGcPnKL73dMB0iEsZbxgD++alYPveM2iGMlzs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/mOiX5FHopHvTpogRzJYQg1YX10skI48i5R0TCPo9/oMlYCgd8Os2jWYLws6NiVeyJTUbAq7apX1g/S5IZAdAddtTTczEvNabALvOqa6dNFRm2Gh6qYcYEKv8O1qGziczcAKONTmACbzJBNQtj93L+SKN5d9VO3rSZtGpb2P+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=UiXn8nG1; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1751813958; x=1752073158;
	bh=qBWlMlwGcPnKL73dMB0iEsZbxgD++alYPveM2iGMlzs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UiXn8nG1elVLv7RkHaNqVxT61ci8TsxsBgrVDh2/oDECmS3ahXdViZwaM+rE0qnMB
	 a47as2n9AqKRTcDroGz8kgxaVSerDVtnykhon/eVkrx1KzICIu99peEUZEOfluFiAL
	 gtu79EN+L6ZjOYLVgCux0Q/l96lx7BvUr4TgWNhoxhKoJbJ4XjKeJ0IcdmVXDafXd4
	 SUlXThreZlomndrDIbVQ1HkfB/MWPdxSNO8dJgg7CWfGPM3VKUvCOb6X/hehbezKDi
	 PBQw9LXbDG/Fiz+4NgGLCqEFS2NyXLN2+FYvBk76FaWIsXdffYqvKTrLmBUTddbZSN
	 MiBpjkvlfjPDA==
Date: Sun, 06 Jul 2025 14:59:11 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, stephen@networkplumber.org, Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch net 1/2] netem: Fix skb duplication logic to prevent infinite loops
Message-ID: <lhR3z8brE3wSKO4PDITIAGXGGW8vnrt1zIPo7C10g2rH0zdQ1lA8zFOuUBklLOTAgMcw4Z6N5YnqRXRzWnkHO-unr5g62msCAUHow-NmY7k=@willsroot.io>
In-Reply-To: <CAM0EoM=99ufQSzbYZU=wz8fbYOQ2v+cMa7BX1EM6OHk+dBrE0Q@mail.gmail.com>
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com> <20250701231306.376762-2-xiyou.wangcong@gmail.com> <aGSSF7K/M81Pjbyz@pop-os.localdomain> <CAM0EoMmDj9TOafynkjVPaBw-9s7UDuS5DoQ_K3kAtioEdJa1-g@mail.gmail.com> <CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com> <aGh2TKCthenJ2xS2@pop-os.localdomain> <CAM0EoM=99ufQSzbYZU=wz8fbYOQ2v+cMa7BX1EM6OHk+dBrE0Q@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: f0c3fd5629a972eb4cc104f64b52877e2ad35cf7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, July 5th, 2025 at 1:52 PM, Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:

>=20
>=20
> On Fri, Jul 4, 2025 at 8:48=E2=80=AFPM Cong Wang xiyou.wangcong@gmail.com=
 wrote:
>=20
> > On Wed, Jul 02, 2025 at 11:04:22AM -0400, Jamal Hadi Salim wrote:
> >=20
> > > On Wed, Jul 2, 2025 at 10:12=E2=80=AFAM Jamal Hadi Salim jhs@mojatatu=
.com wrote:
> > >=20
> > > > On Tue, Jul 1, 2025 at 9:57=E2=80=AFPM Cong Wang xiyou.wangcong@gma=
il.com wrote:
> > > >=20
> > > > > On Tue, Jul 01, 2025 at 04:13:05PM -0700, Cong Wang wrote:
> > > > >=20
> > > > > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > > > > index fdd79d3ccd8c..33de9c3e4d1b 100644
> > > > > > --- a/net/sched/sch_netem.c
> > > > > > +++ b/net/sched/sch_netem.c
> > > > > > @@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *sk=
b, struct Qdisc *sch,
> > > > > > skb->prev =3D NULL;
> > > > > >=20
> > > > > > /* Random duplication */
> > > > > > - if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor=
, &q->prng))
> > > > > > + if (tc_skb_cb(skb)->duplicate &&
> > > > >=20
> > > > > Oops, this is clearly should be !duplicate... It was lost during =
my
> > > > > stupid copy-n-paste... Sorry for this mistake.
> > > >=20
> > > > I understood you earlier, Cong. My view still stands:
> > > > You are adding logic to a common data structure for a use case that
> >=20
> > You are exaggerating this. I only added 1 bit to the core data structur=
e,
> > the code logic remains in the netem, so it is contained within netem.
>=20
>=20
> Try it out ;->
>=20
> Here's an even simpler setup:
>=20
> sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0
> 0 0 0 0 0 0 0 0 0 0 0
> sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
> netem_bug_test.o sec classifier/pass classid 1:1
> sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 10=
0%
> then:
> ping -c 1 127.0.0.1
>=20
> Note: there are other issues as well but i thought citing the ebpf one
> was sufficient to get the point across.
>=20
> > > > really makes no sense. The ROI is not good.
> >=20
> > Speaking of ROI, I think you need to look at the patch stats:
> >=20
> > William/Your patch:
> > 1 file changed, 40 insertions(+)
> >=20
> > My patch:
> > 2 files changed, 4 insertions(+), 4 deletions(-)
>=20
>=20
> ROI is not just about LOC. The consequences of a patch are also part
> of that formula. And let's not forget the time spent so far debating
> instead of plugging the hole.
>=20
> > > > BTW: I am almost certain you will hit other issues when this goes o=
ut
> > > > or when you actually start to test and then you will have to fix mo=
re
> > > > spots.
> > >=20
> > > Here's an example that breaks it:
> > >=20
> > > sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 =
0
> > > 0 0 0 0 0 0 0 0 0 0 0
> > > sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
> > > netem_bug_test.o sec classifier/pass classid 1:1
> > > sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicat=
e 100%
> > > sudo tc qdisc add dev lo parent 10: handle 30: netem gap 1 limit 4
> > > duplicate 100% delay 1us reorder 100%
> > >=20
> > > And the ping 127.0.0.1 -c 1
> > > I had to fix your patch for correctness (attached)
> > >=20
> > > the ebpf prog is trivial - make it just return the classid or even ze=
ro.
> >=20
> > Interesting, are you sure this works before my patch?
> >=20
> > I don't intend to change any logic except closing the infinite loop. IO=
W,
> > if it didn't work before, I don't expect to make it work with this patc=
h,
> > this patch merely fixes the infinite loop, which is sufficient as a bug=
 fix.
> > Otherwise it would become a feature improvement. (Don't get me wrong, I
> > think this feature should be improved rather than simply forbidden, it =
just
> > belongs to a different patch.)
>=20
>=20
> A quick solution is what William had. I asked him to use ext_cb not
> because i think it is a better solution but just so we can move
> forward.
> Agree that for a longer term we need a more generic solution as discussed=
 ...
>=20
> cheers,
> jamal

The tc_skb_ext approach has a problem... the config option that enables it =
is NET_TC_SKB_EXT. I assumed this is a generic name for skb extensions in t=
he tc subsystem, but unfortunately this is hardcoded for NET_CLS_ACT recirc=
ulation support.

So what this means is we have the following choices:
1. Make SCH_NETEM depend on NET_CLS_ACT and NET_TC_SKB_EXT
2. Add "|| IS_ENABLED(CONFIG_SCH_NETEM)" next to "IS_ENABLED(CONFIG_NET_TC_=
SKB_EXT)"
3. Separate NET_TC_SKB_EXT and the idea of recirculation support. But I'm n=
ot sure how people feel about renaming config options. And this would requi=
re a small change to the Mellanox driver subsystem.

None of these sound too nice to do, and I'm not sure which approach to take=
. In an ideal world, 3 would be best, but I'm not sure how others would fee=
l about all that just to account for a netem edge case.

Best,
William

