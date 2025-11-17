Return-Path: <netdev+bounces-239124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A897BC64573
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADD914E8110
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF923328E0;
	Mon, 17 Nov 2025 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="sld5GOH1"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10FE331A7A
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763385834; cv=none; b=ICPqUsPFq0pQHPSDnoDzoQ+fCUOz/LHN9t80CP6gZ1jv7kWhBpsJxi6o7NyTWe3y1akPmAhA8TELNmLvB/ptSwdZ5h49m3Hg00K8282corVQyiB9RfIm2pIxKOaQmwamOtM00CbxPpCnp21yxBTcY5j42+wJKRD+f9eU8s/WwbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763385834; c=relaxed/simple;
	bh=xc3v1AyoRURQTanMjViwCpxZz23hwtZqB8PsZ4KUMKk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CvuRNTEsd3KO975gtyPUE72CAuSVxTh6mVmeJegFxVE5BWLUd5tdYJQ5An9l2DfmItqNbQLUBQcVsD+JNeQ8IyvrFzG0v3CYotrDVdpwd+vF/54RGUl6fbkIyDcOmiFpzyXlgpD5Y4yg0BE49sb2ltvyi5+NvXLlkGpZmqwU+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=sld5GOH1; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1763385829; bh=xc3v1AyoRURQTanMjViwCpxZz23hwtZqB8PsZ4KUMKk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sld5GOH1Br0rljc6YQGHJ9RHvVV0KTKJMmG1wuab2Py+6CvzWDEfzAvxjo3IWK6gi
	 awv7R5Y71h5c6vv+mli/owthV7cICMIaHs+hczeODvxSkKi/paeogS+fDZzx1Y0v+K
	 AjRW8c8E8YgUp0Xng2ozXLrR3kxhKC8hAutVveiuxcXIWGzz0+s9zfiMmdhbS6y0eO
	 lgKgJ+Y6VD2i3lXk/2jlWZHeUDMmJzpNqhzIwQbcxuIYYLLnjOHngreupdC6mNXbt2
	 YGpX206g1EiHojwrkRxxBxr58ZzdtMJtbRKZA2xOKlp7Ca6Ej44ABgDYHv/mdDlg3G
	 tvZ6uzlTR0SVg==
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, cake@lists.bufferbloat.net,
 bestswngs@gmail.com
Subject: Re: [PATCH net v3] net/sched: sch_cake: Fix incorrect qlen
 reduction in cake_drop
In-Reply-To: <aRhUsbR6DT1F0bqc@p1>
References: <20251113035303.51165-1-xmei5@asu.edu> <aRVZJmTAWyrnXpCJ@p1>
 <87346ijbs9.fsf@toke.dk> <aRhUsbR6DT1F0bqc@p1>
Date: Mon, 17 Nov 2025 14:23:45 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87a50kokri.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> will not run because the parent scheduler stops enqueueing after seeing
> NET_XMIT_CN. For normal packets (non-GSO), it's easy to fix: just do
> qdisc_tree_reduce_backlog(sch, 1, len). However, GSO splitting makes this
> difficult because we may have already added multiple segments into the
> flow, and we don=E2=80=99t know how many of them were dequeued.

Huh, dequeued? This is all running under the qdisc lock, nothing gets
dequeued in the meantime.

Besides, the ACK thinning is irrelevant to the drop compensation. Here's
an example:

Without ACK splitting - we enqueue 1 packet of 100 bytes, then drop 1
packet of 200 bytes, so we should end up with the same qlen, but 100
fewer bytes in the queue:

start: parent qlen =3D X, parent backlog =3D Y

len =3D 100;
cake_drop() drops 1 pkt / 200 bytes

if (same_flow) {
  qdisc_reduce_backlog(0, 100) // parent qlen =3D=3D X, parent backlog =3D=
=3D Y - 100
  return NET_XMIT_CN;
  // no change in parent, so parent qlen =3D=3D X, parent backlog =3D=3D Y =
- 100
} else {
  qdisc_reduce_backlog(1, 200); // parent qlen =3D=3D X - 1, backlog =3D=3D=
 Y - 200
  return NET_XMIT_SUCCESS;
  // parent does qlen +=3D1, backlog +=3D 100, so parent qlen =3D=3D x, par=
ent backlog =3D=3D Y - 100
}

With ACK splitting - we enqueue 10 segments totalling 110 bytes, then
drop 1 packet of 200 bytes, so we should end up with 9 packets more in
the queue, but 90 bytes less:

start: parent qlen =3D X, parent backlog =3D Y

len =3D 100;
/* split ack: slen =3D=3D 110, numsegs =3D=3D 10 */
qdisc_tree_reduce_backlog(-9, -10); // parent qlen =3D=3D X + 9, backlog =
=3D=3D Y + 10

cake_drop() drops 1 pkt / 200 bytes

if (same_flow) {
  qdisc_reduce_backlog(0, 100)   // parent qlen =3D=3D X + 9, backlog =3D=
=3D Y - 90
  return NET_XMIT_CN;
  // no change in parent, so parent qlen =3D=3D X + 9, backlog =3D=3D Y - 90

} else {
  qdisc_reduce_backlog(1, 200); // parent qlen =3D=3D X + 8, backlog =3D=3D=
 Y - 190
  return NET_XMIT_SUCCESS;
  // parent does qlen +=3D1, backlog +=3D 100, so parent qlen =3D=3D X + 9,=
 backlog =3D=3D Y - 90
}


In both cases, what happens is that we drop one or more packets, reduce
the backlog by the number of packets/bytes dropped *while compensating
for what the parent qdisc does on return*. So the adjustments made by
the segmentation makes no difference to the final outcome.

However, we do have one problem with the ACK thinning code: in the 'if
(ack)' branch, we currently adjust 'len' if we drop an ACK. Meaning that
if we use that value later to adjust for what the parent qdisc, the
value will no longer agree with what the parent does. So we'll have to
introduce a new variable for the length used in the ACK thinning
calculation.

> The number of dequeued segments can be anywhere in [0, numsegs], and the
> dequeued length in [0, slen]. We cannot know the exact number without=20
> checking the tin/flow index of each dropped packet. Therefore, we should
> check inside the loop (as v1 did):
>
> ```
> cake_drop(...)
> {
>     ...
>     if (likely(current_flow !=3D idx + (tin << 16)))
>         qdisc_tree_reduce_backlog(sch, 1, len);
>     ...
> }
> ```

No, this is not needed - the calculation involving prev_qlen and
prev_backlog will correctly give us the total number of packets/bytes
dropped.
>
> This solution also has a problem, as you mentioned:
> if the flow already contains packets, dropping those packets should
> trigger backlog reduction, but our check would incorrectly skip that. One
> possible solution is to track the number of packets/segments enqueued
> in the current cake_enqueue (numsegs or 1), and then avoid calling
> `qdisc_tree_reduce_backlog(sch, 1, len)` for the 1 or numsegs dropped
> packets. If that makes sense, I'll make the patch and test it.

It does not - see above.

> -----
>
> Besides, I have a question about the condition for returning NET_XMIT_CN.
> Do we return NET_XMIT_CN when:
>
> The incoming packet itself is dropped? (makes more sense to me)
> or
> The same flow dequeued once? (This is the current logic)

The same flow. The current logic it correct.

-Toke

