Return-Path: <netdev+bounces-209036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AC6B0E0F6
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F10567F17
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B8327A10F;
	Tue, 22 Jul 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="u+qx/+u8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5B279DC4
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199559; cv=none; b=OwjpppcZ650Ppbf8bJAbyddw37jbgkqWvBv2fhAbH3j22f7MBoH4TE6tban1c52iebDcwC9ZzZvPehBHK+XhBxH+zvo+Hj6ZxKE7BWXit2w154jFx9jZZL6LkCkC9CG5EhgAWUprH0QreTq6CxyBQCg8nK6OXmKDmM3A82t6s7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199559; c=relaxed/simple;
	bh=KncVDkm3KRa8pqTCUQScdLMC2gsvAe5RP0/Uxk7QWow=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7zbtt2PjJ/EJhtkPcXOA54dCbOUsLd7rsG+NDobWK4Tk8rrGLTt2zydDqjrDWQeH+NvJFN29lxmAaPMXF77b7z4WSSULEUssZuxw6DG+s8mCHz8uuXdP+WHRp/+9vw2KVf6YQGm0NpChUVMPXEN5Te301KxG2NCiekdWTL6mCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=u+qx/+u8; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1753199550; x=1753458750;
	bh=KncVDkm3KRa8pqTCUQScdLMC2gsvAe5RP0/Uxk7QWow=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=u+qx/+u8uv9G4SiDPOLFybLWEY0GSLuf/eVWCDPpBBSRVNgSBLjZZZG3x1eiZ3AbZ
	 WxqqOwVZFXjZUVgdAS98N10o9EZlUqTzKK+FaGk4kJJZ00J6QOLwnUwTJgRWe2ihZR
	 SBva5TcSEeE+Yvr2y3Ow/QZTY5jcU6Nh/b9/m1JzzGc1dmNL+msx+M7vyZJ51WlV4T
	 axDSk5C2p15GngAQzrWAjGIw/fSsP3az+UKgZszfckGCVSEkiyeKOu79ZnS9mz7Bhn
	 VlfownNbED/xQS6e7TFIR0hahjxGbesU790SNDjxMEHXEHOhmjlgXjttEDqjUCbyf5
	 TOhQS85RyzWOg==
Date: Tue, 22 Jul 2025 15:52:25 +0000
To: Paolo Abeni <pabeni@redhat.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io
Subject: Re: [PATCH net 1/2] net/sched: Fix backlog accounting in qdisc_dequeue_internal
Message-ID: <3VMC2BvvUHZC7kQfL_mtfX8Arwvgb3Sx8jNF-YzqiJ81f_L7nOgIYvQOxVmjeWqWJcIW5rb48oCbzp8iAzjAUPU0iKBk012t0DR7arhqtOY=@willsroot.io>
In-Reply-To: <96927022-92d9-46be-8af4-225cab01b006@redhat.com>
References: <20250719180746.189247-1-will@willsroot.io> <96927022-92d9-46be-8af4-225cab01b006@redhat.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: aaab6e35d7faeb8b4e71fb2b44f8f91a82841a5c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, July 22nd, 2025 at 1:32 PM, Paolo Abeni <pabeni@redhat.com> wro=
te:

Thank you for the review!

>=20
>=20
> On 7/19/25 8:08 PM, William Liu wrote:
>=20
> > This issue applies for the following qdiscs: hhf, fq, fq_codel, and
> > fq_pie, and occurs in their change handlers when adjusting to the new
> > limit. The problems are the following in the values passed to the
> > subsequent qdisc_tree_reduce_backlog call:
> >=20
> > 1. When the tbf parent runs out of tokens, skbs of these qdiscs will
> > be placed in gso_skb. Their peek handlers are qdisc_peek_dequeued,
> > which accounts for both qlen and backlog. However, in the case of
> > qdisc_dequeue_internal, ONLY qlen is accounted for when pulling
> > from gso_skb. This means that these qdiscs are missing a
> > qdisc_qstats_backlog_dec when dropping packets to satisfy the
> > new limit in their change handlers.
> >=20
> > One can observe this issue with the following (with tc patched to
> > support a limit of 0):
> >=20
> > export TARGET=3Dfq
> > tc qdisc del dev lo root
> > tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b latency 1ms
> > tc qdisc replace dev lo handle 3: parent 1:1 $TARGET limit 1000
> > echo ''; echo 'add child'; tc -s -d qdisc show dev lo
> > ping -I lo -f -c2 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
> > echo ''; echo 'after ping'; tc -s -d qdisc show dev lo
> > tc qdisc change dev lo handle 3: parent 1:1 $TARGET limit 0
> > echo ''; echo 'after limit drop'; tc -s -d qdisc show dev lo
> > tc qdisc replace dev lo handle 2: parent 1:1 sfq
> > echo ''; echo 'post graft'; tc -s -d qdisc show dev lo
> >=20
> > The second to last show command shows 0 packets but a positive
> > number (74) of backlog bytes. The problem becomes clearer in the
> > last show command, where qdisc_purge_queue triggers
> > qdisc_tree_reduce_backlog with the positive backlog and causes an
> > underflow in the tbf parent's backlog (4096 Mb instead of 0).
> >=20
> > 2. fq_codel_change is also wrong in the non gso_skb case. It tracks
> > the amount to drop after the limit adjustment loop through
> > cstats.drop_count and cstats.drop_len, but these are also updated
> > in fq_codel_dequeue, and reset everytime if non-zero in that
> > function after a call to qdisc_tree_reduce_backlog.
> > If the drop path ever occurs in fq_codel_dequeue and
> > qdisc_dequeue_internal takes the non gso_skb path, then we would
> > reduce the backlog by an extra packet.
> >=20
> > To fix these issues, the codepath for all clients of
> > qdisc_dequeue_internal has been simplified: codel, pie, hhf, fq,
> > fq_pie, and fq_codel. qdisc_dequeue_internal handles the backlog
> > adjustments for all cases that do not directly use the dequeue
> > handler.
> >=20
> > Special care is taken for fq_codel_dequeue to account for the
> > qdisc_tree_reduce_backlog call in its dequeue handler. The
> > cstats reset is moved from the end to the beginning of
> > fq_codel_dequeue, so the change handler can use cstats for
> > proper backlog reduction accounting purposes. The drop_len and
> > drop_count fields are not used elsewhere so this reordering in
> > fq_codel_dequeue is ok.
> >=20
> > Fixes: 2d3cbfd6d54a ("net_sched: Flush gso_skb list too during ->change=
()")
> > Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
> > Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
> >=20
> > Signed-off-by: William Liu will@willsroot.io
> > Reviewed-by: Savino Dicanosa savy@syst3mfailure.io
>=20
>=20
> Please avid black lines in the tag area, i.e. between 'Fixes' and the SoB=
.
>=20

Ok noted.

> Also I think this could/should be splitted in several patches, one for
> each affected qdisc.
>=20

I considered doing that originally, but the commit that introduced qdisc_de=
queue_internal had all the changes in one patch: https://git.kernel.org/pub=
/scm/linux/kernel/git/stable/linux.git/commit/?id=3D2d3cbfd6d54a2c39ce3244f=
33f85c595844bd7b8

Plus, splitting this change up for each affected qdisc and the change in qd=
isc_dequeue_internal would have codel and pie end up with broken backlog ac=
counting, unless I group them with the same patch for qdisc_dequeue_interna=
l. Should I still split it in this case?

> > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> > index 2a0f3a513bfa..f9e6d76a1712 100644
> > --- a/net/sched/sch_fq_codel.c
> > +++ b/net/sched/sch_fq_codel.c
> > @@ -286,6 +286,10 @@ static struct sk_buff *fq_codel_dequeue(struct Qdi=
sc *sch)
> > struct fq_codel_flow *flow;
> > struct list_head *head;
> >=20
> > + /* reset these here, as change needs them for proper accounting*/
> > + q->cstats.drop_count =3D 0;
> > + q->cstats.drop_len =3D 0;
> > +
> > begin:
> > head =3D &q->new_flows;
> > if (list_empty(head)) {
> > @@ -319,8 +323,6 @@ static struct sk_buff *fq_codel_dequeue(struct Qdis=
c *sch)
> > if (q->cstats.drop_count) {
>=20
>=20
> Why is this 'if' still needed ? Isn't drop_count always 0 here?
>=20

No, the codel_dequeue call in the middle can adjust that value.

> /P

Best,
Will

