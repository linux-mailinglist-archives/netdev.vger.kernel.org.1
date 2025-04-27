Return-Path: <netdev+bounces-186325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A5EA9E4B1
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 23:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE88C175447
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 21:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB3120299D;
	Sun, 27 Apr 2025 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="mw4ypeE1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9721FE45C
	for <netdev@vger.kernel.org>; Sun, 27 Apr 2025 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745789219; cv=none; b=Fv2aaTEyW54kJV7cjE75OoZpmdHkspZlm6PfakPpMHDtDxGma2KATpOnoHSiXJJ683ObdJ1+HBU8jsTG+zzamylNYmmoWgTov33EACOLqLzU2CXJ4CWC3Cw9G+His83dIjxKXvtq9XjCzlDC41Q0F7+Lf6zQbDsY5XP2PVGX9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745789219; c=relaxed/simple;
	bh=pg8pcED93nvKe98XShN7rUDPd2ZdNjkY3wj1yPdjNWI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bolka6yN1a2u9+AHzWml0aiwqWrFOWsR4/FD1z2leyb0uSmAX02tENCr8GjeM3htQOdpZtRdpJ1pOCGpjKA98flBymyp2XVeywJK2f/Jb8ZoskVgrClRHbDYtlsgQOKj2ExLVNF4enTLX1Brzrle8o1fuyo9lotBJhw+DWPMRa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=mw4ypeE1; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1745789207; x=1746048407;
	bh=OvtonKY0a2Vig/9gOykGYwRv/umgTSdgqEL9iz1WW6M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mw4ypeE1Nltf4hJev4G3zb6ESjQV1J7HFYP0m+wBLLxPY4kp+Oe/JE+Dyev3RSxGP
	 T6S0e7J2JlvZr8K4SWwlYtNc9Sfi28zvrxDlORazMienc/xffzN43HC4oHiwVF/e7G
	 Lwi+NdCmcjGXrqE7sJ1LEIrvcGFHkw5mVQ+T4X45j4vefLn+d5DtbZfbcNr3k2wUu9
	 QWErXvtppfJKW0KP9e1k1QeRQmsMcVJxDC3YuMBzo6pnv+kL9vO4pobmCAnHYNkqMd
	 DU42tvg+ygAlSDfM5h6IrOj2PbeeSQiH4O00+hvJmhCn2iY3DKS+HqzHrXFOg5cWqq
	 +XNjDwERrB4ug==
Date: Sun, 27 Apr 2025 21:26:43 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: Will <willsroot@protonmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, jhs@mojatatu.com, jiri@resnulli.us
Subject: Re: [BUG] net/sched: Race Condition and Null Dereference in codel_change, pie_change, fq_pie_change, fq_codel_change, hhf_change
Message-ID: <B2ZSzsBR9rUWlLkrgrMrCzqOGeSFxXIkYImvul6994v5tDSqykWo1UaWKRV-SNkNKJurgVzRcnPN07ZAVYykRaYhADyIwTxQ18OQfKDpILQ=@protonmail.com>
In-Reply-To: <aA1kmZ/Hs0a33l5j@pop-os.localdomain>
References: <UTd8zf-_MMCqMv9R15RSDZybxtCeV9czSvpeaslK7984UCPTX8pbSFVyWhzqiaA6HYFZtHIldd7guvr7_8xVfkk9xSUHnY3e8dSWi7pdVsE=@protonmail.com> <aA1kmZ/Hs0a33l5j@pop-os.localdomain>
Feedback-ID: 25491499:user:proton
X-Pm-Message-ID: 0af424dbdd78292be7cf1ccf83d9d9e378f3d692
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, April 26th, 2025 at 10:56 PM, Cong Wang <xiyou.wangcong@gmail.=
com> wrote:

>=20
>=20
> Hi Will,
>=20
> On Fri, Apr 25, 2025 at 02:14:07PM +0000, Will wrote:
>=20
> > Hi all,
> >=20
> > We've encountered and triaged the following race condition that occurs =
across 5 different qdiscs: codel, pie, fq_pie, fq_codel, and hhf. It came u=
p on a modified version of Syzkaller we're working on for a research projec=
t. It works on upstream (02ddfb981de88a2c15621115dd7be2431252c568), the 6.6=
 LTS branch, and the 6.1 LTS branch and has existed since at least 2016 (an=
d earlier too for some of the other listed qdiscs): https://github.com/torv=
alds/linux/commit/2ccccf5fb43ff62b2b9.
> >=20
> > We will take codel_change as the main example here, as the other vulner=
able qdiscs change functions follow the same pattern. When the limit change=
s, the qdisc attempts to shrink the queue size back under the limit: https:=
//elixir.bootlin.com/linux/v6.15-rc3/source/net/sched/sch_codel.c#L146. How=
ever, this is racy against a qdisc's dequeue function. This limit check cou=
ld pass and the qdisc will attempt to dequeue the head, but the actual qdis=
c's dequeue function (codel_qdisc_dequeue in this case) could run. This wou=
ld lead to the dequeued skb being null in the change function when only one=
 packet remains in the queue, so when the function calls qdisc_pkt_len(skb)=
, a null dereference exception would occur.
>=20
>=20
> Thanks for your detailed report, reproducer and patch!
>=20
> I have two questions here:
>=20
> 1. Why do you say it is racy? We have sch_tree_lock() held when flushing
> the packets in the backlog, it should be sufficient to prevent
> concurrent ->dequeue().
>=20
>=20
> 2. I don't see immediately from your report why we could get a NULL from
> __qdisc_dequeue_head(), because unless sch->q.qlen is wrong, we should
>=20
> always have packets in the queue until we reach 0 (you specifically used
> 0 as the limit here).
>=20
> The reason why I am asking is that if we had any of them wrong here, we
> would have a biger trouble than just missing a NULL check.
>=20
>=20
> Best regards,
> Cong Wang

Hi Cong,

Thank you for the reply. On further analysis, we realized that you are corr=
ect - it is not a race condition between xxx_change and xxx_dequeue. The ro=
ot cause is more complicated and actually relates to the parent tbf qdisc. =
The bug is still a race condition though.

__qdisc_dequeue_head() can still return null even if sch->q.qlen is non-zer=
o because of qdisc_peek_dequeued, which is the vulnerable qdiscs' peek hand=
ler, and tbf_dequeue calls it (https://elixir.bootlin.com/linux/v6.15-rc3/s=
ource/net/sched/sch_tbf.c#L280). There, the inner qdisc dequeues content be=
fore, adds it back to gso_skb, and increments qlen (https://elixir.bootlin.=
com/linux/v6.15-rc3/source/include/net/sch_generic.h#L1133). A queue state =
consistency issue arises when tbf does not have enough tokens (https://elix=
ir.bootlin.com/linux/v6.15-rc3/source/net/sched/sch_tbf.c#L302) for dequeui=
ng. The qlen value will be fixed when sufficient tokens exist and the watch=
dog fires again. However, there is a window for the inner qdisc to encounte=
r this inconsistency and thus hit the null dereference.

Savy made this diagram below to showcase the interactions to trigger the bu=
g.

Packet 1 is sent:

    tbf_enqueue()
        qdisc_enqueue()
            codel_qdisc_enqueue() // Codel qlen is 0
                qdisc_enqueue_tail()
                // Packet 1 is added to the queue
                // Codel qlen =3D 1

    tbf_dequeue()
        qdisc_peek_dequeued()
            skb_peek(&sch->gso_skb) // sch->gso_skb is empty
            codel_qdisc_dequeue() // Codel qlen is 1
                qdisc_dequeue_head()
                // Packet 1 is removed from the queue
                // Codel qlen =3D 0
            __skb_queue_head(&sch->gso_skb, skb); // Packet 1 is added to g=
so_skb list
            sch->q.qlen++ // Codel qlen =3D 1
        qdisc_dequeue_peeked()
            skb =3D __skb_dequeue(&sch->gso_skb) // Packet 1 is removed fro=
m the gso_skb list
            sch->q.qlen-- // Codel qlen =3D 0

Packet 2 is sent:

    tbf_enqueue()
        qdisc_enqueue()
            codel_qdisc_enqueue() // Codel qlen is 0
                qdisc_enqueue_tail()
                // Packet 2 is added to the queue
                // Codel qlen =3D 1

    tbf_dequeue()
        qdisc_peek_dequeued()
            skb_peek(&sch->gso_skb) // sch->gso_skb is empty
            codel_qdisc_dequeue() // Codel qlen is 1
                qdisc_dequeue_head()
                // Packet 2 is removed from the queue
                // Codel qlen =3D 0
            __skb_queue_head(&sch->gso_skb, skb); // Packet 2 is added to g=
so_skb list
            sch->q.qlen++ // Codel qlen =3D 1

        // TBF runs out of tokens and reschedules itself for later
        qdisc_watchdog_schedule_ns()


Notice here how codel is left in an "inconsistent" state, as sch->q.qlen > =
0, but there are no packets left in the codel queue (sch->q.head is NULL)

At this point, codel_change() can be used to update the limit to 0. However=
, even if  sch->q.qlen > 0, there are no packets in the queue, so __qdisc_d=
equeue_head() returns NULL and the null-ptr-deref occurs.

Here is an updated PoC below that triggers this with just two packets. The =
same patch with an updated commit message is below as well.=20

#!/bin/bash

# --------------------------------------------------------------------
# Authors: Will (will@willsroot.io) and Savy (savy@syst3mfailure.io)
# Description: null-ptr-deref across 4 qdiscs from xxx_change function
# --------------------------------------------------------------------

if [ $# -eq 0 ]; then
        echo "Usage: $0 <codel/pie/fq_codel/fq_pie/hhf>"
        exit 1
fi

crash() {
    local name=3D$1
    ./tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b latency 1=
s
    ./tc qdisc add dev lo parent 1: handle 2: "$name" limit 1
    ping -I lo -f -c2 -s48 -W0.001 127.0.0.1
    ./tc qdisc change dev lo parent 1: handle 2: "$name" limit 0
}

case $1 in
        codel|pie|fq_codel|fq_pie|hhf)
                echo "Triggering crash in $1..."
                crash "$1"
                ;;
        *)
                echo "Error: Invalid qdisc!"
                echo "Usage: $0 <codel/pie/fq_codel/fq_pie/hhf>"
                exit 1
                ;;
esac

Best,
Will (will@willsroot.io)
Savy (savy@syst3mfailure.io)

From 58114954b375868497ed9850db7b983e0f61589f Mon Sep 17 00:00:00 2001
From: William Liu <will@willsroot.io>
Date: Sun, 27 Apr 2025 13:59:03 -0700
Subject: [PATCH] net/sched: Exit dequeue loop if empty queue in change
 handlers for codel, pie, fq_codel, fq_pie, and hhf Qdisc_ops

When the inner qdisc of a TBF qdisc dequeue packets to reach the newly
set limit in its change handler, the qlen variable might be inconsistent
with the actual queue length due to the TBF qdisc moving elements to
gso_skb without sufficient tokens in tbf_dequeue. A TBF watchdog
addresses this inconsistency later on, but the change handler can see
this inconsistent state and result in a null dereference in codel_change,
pie_change, fq_codel_change, fq_pie_change, or a soft lockup as in
hhf_change.

Check to ensure that the skb is not null before continuing.

Signed-off-by: William Liu <will@willsroot.io>
Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
---
 net/sched/sch_codel.c    | 3 +++
 net/sched/sch_fq_codel.c | 3 +++
 net/sched/sch_fq_pie.c   | 3 +++
 net/sched/sch_hhf.c      | 3 +++
 net/sched/sch_pie.c      | 3 +++
 5 files changed, 15 insertions(+)

diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 12dd71139da3..e714f324a85b 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -146,6 +146,9 @@ static int codel_change(struct Qdisc *sch, struct nlatt=
r *opt,
    while (sch->q.qlen > sch->limit) {
        struct sk_buff *skb =3D __qdisc_dequeue_head(&sch->q);
=20
+       if (!skb)
+           break;
+
        dropped +=3D qdisc_pkt_len(skb);
        qdisc_qstats_backlog_dec(sch, skb);
        rtnl_qdisc_drop(skb, sch);
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 6c9029f71e88..85d591b430e4 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -443,6 +443,9 @@ static int fq_codel_change(struct Qdisc *sch, struct nl=
attr *opt,
           q->memory_usage > q->memory_limit) {
        struct sk_buff *skb =3D fq_codel_dequeue(sch);
=20
+       if (!skb)
+           break;
+
        q->cstats.drop_len +=3D qdisc_pkt_len(skb);
        rtnl_kfree_skbs(skb, skb);
        q->cstats.drop_count++;
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index f3b8203d3e85..f52e355698ca 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -368,6 +368,9 @@ static int fq_pie_change(struct Qdisc *sch, struct nlat=
tr *opt,
    while (sch->q.qlen > sch->limit) {
        struct sk_buff *skb =3D fq_pie_qdisc_dequeue(sch);
=20
+       if (!skb)
+           break;
+
        len_dropped +=3D qdisc_pkt_len(skb);
        num_dropped +=3D 1;
        rtnl_kfree_skbs(skb, skb);
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 44d9efe1a96a..c9da90689e0c 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -566,6 +566,9 @@ static int hhf_change(struct Qdisc *sch, struct nlattr =
*opt,
    while (sch->q.qlen > sch->limit) {
        struct sk_buff *skb =3D hhf_dequeue(sch);
=20
+       if (!skb)
+           break;
+
        rtnl_kfree_skbs(skb, skb);
    }
    qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen,
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 3771d000b30d..6810126b8368 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -197,6 +197,9 @@ static int pie_change(struct Qdisc *sch, struct nlattr =
*opt,
    while (sch->q.qlen > sch->limit) {
        struct sk_buff *skb =3D __qdisc_dequeue_head(&sch->q);
=20
+       if (!skb)
+           break;
+
        dropped +=3D qdisc_pkt_len(skb);
        qdisc_qstats_backlog_dec(sch, skb);
        rtnl_qdisc_drop(skb, sch);
--=20
2.43.0

