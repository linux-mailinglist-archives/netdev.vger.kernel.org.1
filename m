Return-Path: <netdev+bounces-192842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC724AC15C8
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 23:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64738503E48
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 21:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76602512CA;
	Thu, 22 May 2025 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="Xm673vHz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC81C2512C9
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747947825; cv=none; b=CSKPflsNfAciH91kvwaDdG2CagOyMexBMsPWP1llOscYzUvthpm+WiMZL/qo0Bnv2DMGXl5eRtXWdKMpqphl1/tc2aonGEWup5Q/9jJLGQJf51X/fhxIz+b6UDBYplVFBjN4ICRA9PtJjUFww1gVn6hd5JSbkINtRMnO1GgAS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747947825; c=relaxed/simple;
	bh=+szTrW6AQ1nRnSmBS2aF/7oRncDOVVzgy9d6o6tBQ8g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M31gCpPUbBhRli34ls1e9nMRIH11uEQ5FHa4bpG1pqlwgIXyvRf/oYJVkd9y3n93NAvRVi4uO9oSi8E5f4ru1z5dQOUB8YZW2OOqJtaUsf9P246RUdZEcM4mBWV+IdraRvV1tIgXMgZ9e/IhkCnv7oVwktcM6qTNMOBjB38MkH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=Xm673vHz; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1747947814; x=1748207014;
	bh=zluv7/MuVvKaYRMBYyBVEbmHmlvuov+e4DRaQhfzywE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Xm673vHz81rGkwQ/H2hoqq36RaVDKWSzUP5LphZ/XnoMK7hkPZc0rjDueE8tCG1Tc
	 /N2GIhiowjjWcBC6rYW3qRrOlHJVdY654zHeYSd2gUbBEcwqruJhBpFv0enyVRoHBe
	 OYT5oNKGV+XvdbzkvPgKMQ+flq6XW4LL8cpFAaxschLYGcG0MFy0LwHZtMBvK/WeZy
	 9UcoSye6Lk8RRwqySo9yrnWkGE9f7ShcrLjkWDwnMnT38nMTRdCpOT9oxynTE2fxj2
	 NnXXUNrE9TJp9+SNgKKsBE2zTxuDS2xYAVTb+vZDy+e4JkjgkAtg5f8j00SujfDh9l
	 d2B5eezK0LeLA==
Date: Thu, 22 May 2025 21:03:31 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <Ppi6ol0VaHrqJs9Rp0-SGp0J1Y0K8hki_jbNZ8sjNOmtEq0mD4f0IozBxxX-m4535QPJonGFYmiPmB643yd4SOpd1HDDYyMeGQuASuFHl-E=@willsroot.io>
In-Reply-To: <CAM0EoMkd87-6ZJ5PWsV8K+Pn+dVNEOP9NcfGAjXVrzAH70F4YA@mail.gmail.com>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <CAM0EoMmKL68r_b1T4zHJTmdZPdCwS69F-Hh+0_ev+-5xPGy2=w@mail.gmail.com> <DglTO9NHmtFTRrCJf07R16_tYUUqoTV7M0hID_k-ryn5mAhe4ADq1mBpAuxNK24ZTnzIPaPq4x1woAtqZGXgAQS4k64C4SGRCfupe3H3dRs=@willsroot.io> <CAM0EoMmQau9+uXVm-vpuWqYjh=51a_CCS6orS6VrK6qBdddxrQ@mail.gmail.com> <iEqzQsC-O2kAXqH1_58I59DIhBjRgebyGym2ZqyMEI3DaMtgsKSYR0KUsbxj5xqvfzf-4XzpM8dXvATHJhVVw3NedRdL3j1FJaqiXPlNWeE=@willsroot.io> <ggSxq-NP-LDpev4N-rvkgs0Rrd0qOrbwtGRjcu4j4y3SuZth9k5RxTg2tFvhriQu4w_GxRPYjnkKN6VqFP6Q6FCyqWudz7_5iuOV06IEzgY=@willsroot.io> <CAM0EoMkd87-6ZJ5PWsV8K+Pn+dVNEOP9NcfGAjXVrzAH70F4YA@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 57370092e48267225f4ce00732797d7b5a714a47
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, May 22nd, 2025 at 12:34 PM, Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:

> > If we do a per cpu global variable approach like in act_mirred.c to tra=
ck nesting, then wouldn't this break in the case of having multiple normal =
qdisc setups run in parallel across multiple interfaces?
>=20
>=20
> A single skb cannot enter netem via multiple cpus. You can have
> multiple cpus entering the netem but they would be different skbs - am
> i missing something? Note mirred uses per-cpu counter which should
> suffice for being per skb counters.
>=20

Ah right, you are correct. This approach will be fine then. We were origina=
lly concerned about another netem qdisc being interwoven during the operati=
ons, but that is not possible.

> > This brings us back to the approach where we don't allow duplication in=
 netem if a parent qdisc is a netem with duplication enabled. However, one =
issue we are worried about is in regards to qdisc_replace. This means this =
check would have to happen everytime we want to duplicate something in enqu=
eue right? That isn't ideal either, but let me know if you know of a better=
 place to add the check.
>=20
>=20
> I didnt follow - can you be more specific?
>=20

Oh, I meant that disablement of duplication due to an ancestor netem in the=
 qdisc tree isn't possible at class instantiation time because
qdiscs can be replaced. So we would have to do the check at every skb enque=
ue, which would be far from ideal. The per cpu approach is better.

Anyways, please let us know how the patch below looks - it passes all the n=
etem category test cases in tc-testing and avoids the problem for me. Thank=
 you for all the help so far!

From c96d94ab2155e18318a29510f0ee8f3983a14274 Mon Sep 17 00:00:00 2001
From: William Liu <will@willsroot.io>
Date: Thu, 22 May 2025 13:08:30 -0700
Subject: [PATCH] net/sched: Fix duplication logic in netem_enqueue

netem_enqueue's duplication prevention logic is broken when multiple
netem qdiscs with duplication enabled are stacked together as seen
in [1]. Ensure that duplication does not happen more than once in a
qdisc tree with netem qdiscs. Also move the duplication logic to
happen after the initial packet has finished the enqueue process
to preserve the accuracy of the limit check.

[1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsE=
BNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@will=
sroot.io/

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Signed-off-by: William Liu <will@willsroot.io>
Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
---
 net/sched/sch_netem.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..651fae1cd7d6 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -167,6 +167,8 @@ struct netem_skb_cb {
    u64         time_to_send;
 };
=20
+static DEFINE_PER_CPU(unsigned int, enqueue_nest_level);
+
 static inline struct netem_skb_cb *netem_skb_cb(struct sk_buff *skb)
 {
    /* we assume we can use skb next/prev/tstamp as storage for rb_node */
@@ -454,13 +456,21 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
    struct sk_buff *skb2 =3D NULL;
    struct sk_buff *segs =3D NULL;
    unsigned int prev_len =3D qdisc_pkt_len(skb);
+   int nest_level =3D __this_cpu_inc_return(enqueue_nest_level);
+   int retval;
    int count =3D 1;
=20
    /* Do not fool qdisc_drop_all() */
    skb->prev =3D NULL;
=20
-   /* Random duplication */
-   if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng=
))
+   /*
+    * Random duplication
+    * We must avoid duplicating a duplicated packet, but there is no
+    * good way to track this. The nest_level check disables duplication
+    * if a netem qdisc duplicates the skb in the call chain already
+    */
+   if (q->duplicate && nest_level < 1 &&
+       q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng))
        ++count;
=20
    /* Drop packet? */
@@ -473,7 +483,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qd=
isc *sch,
    if (count =3D=3D 0) {
        qdisc_qstats_drop(sch);
        __qdisc_drop(skb, to_free);
-       return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+       retval =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+       goto dec_nest_level;
    }
=20
    /* If a delay is expected, orphan the skb. (orphaning usually takes
@@ -528,7 +539,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qd=
isc *sch,
        qdisc_drop_all(skb, sch, to_free);
        if (skb2)
            __qdisc_drop(skb2, to_free);
-       return NET_XMIT_DROP;
+       retval =3D NET_XMIT_DROP;
+       goto dec_nest_level;
    }
=20
    /*
@@ -642,9 +654,14 @@ static int netem_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
        /* Parent qdiscs accounted for 1 skb of size @prev_len */
        qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_len));
    } else if (!skb) {
-       return NET_XMIT_DROP;
+       retval =3D NET_XMIT_DROP;
+       goto dec_nest_level;
    }
-   return NET_XMIT_SUCCESS;
+   retval =3D NET_XMIT_SUCCESS;
+
+dec_nest_level:
+   __this_cpu_dec(enqueue_nest_level);
+   return retval;
 }
=20
 /* Delay the next round with a new future slot with a
--=20
2.43.0


