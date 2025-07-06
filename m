Return-Path: <netdev+bounces-204410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CD7AFA592
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 15:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCE9189C98F
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 13:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C33225390;
	Sun,  6 Jul 2025 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="qJbYveqD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch [79.135.106.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A320487E
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751809407; cv=none; b=meIcXnTJCTZSLp+ZpfjNpMoMBDohwHMeuVopwGCERfyueV415CCi9UbFrx1tkbY9qwP/V4+eFak4NoHu9HI4YBGG+ooclFU7fyiwGju7efe/w9El71cXN46Pmw+fjm9/nHsPVHB5oR1g+u2ortPAeiIND6mDVzOoLS0FfK+PsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751809407; c=relaxed/simple;
	bh=Iz05zg6KTG2h870K13pF4I99TkLs10BkZ2pBAub+Tno=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Az2UDNuYhc9Y335Jk+qjEuj73fmT+9djdITzm/Afq5WwVJ9ZFtDsxZ8B+vG88Lhoj1FQvyAbUyc34o/U9f9rYnK3pxsC+dX7lUDRvZ1KqfvtBOSkfFIq1+3HyH8810c6uVjt3OtnbEDt/+xjFo1UIdQVAy0wHZdp8mf63ZTUniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=qJbYveqD; arc=none smtp.client-ip=79.135.106.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1751809395; x=1752068595;
	bh=Iz05zg6KTG2h870K13pF4I99TkLs10BkZ2pBAub+Tno=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qJbYveqDzu66TvK0Hvufs0qUSVKKiwXWvPZXpRGRoTmaPQiG5dle/DJBiH9sJ2/LY
	 +wm8HfMOf4rLN2sjDUlw2SnxivOen/qk7rrG1yAsyjUQySHgcbK968NyeGBE6O5bja
	 b1jYIXOHERHmfSDFHAOz/6P74a11rcMPoj9vYDPaDtluN0PS0KRbIGqoa2fi7b+Czu
	 utAjoMoagnNFQe52o6Fi/8ZFP+w5uWhrsDQDmsC40YtR/IOL7l9cG/bs1iHYQtZvVk
	 HLNvKf6EbHcdTY8rCmVo3klw+diQ01sgGREcUVEGRy/znt/0+M4Nnvk7poQO/vW4ba
	 o+9rFzZ/GaLeg==
Date: Sun, 06 Jul 2025 13:43:08 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <jhs@mojatatu.com>, Savy <savy@syst3mfailure.io>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [BUG]  Inconsistency between qlen and backlog in hhf, fq, fq_codel, and fq_pie causing WARNING in qdisc_tree_reduce_backlog
Message-ID: <X6Q8WFnkbyNTRaSQ07hgoBUIihJJdm7GIDvCCY0prplSeVDZPKXquiH2as4hPXAWn1J1a2tyP5RnBm8tjKWNM881yDlMlx0pMg9vioBRY1w=@willsroot.io>
In-Reply-To: <aGh6HiQmcgsPug1u@pop-os.localdomain>
References: <2UMzQV_2SQetYadgDKNRO76CgTlKBSMAHmsHeosdnhCPcOEwBB-6mSKXghTNSLudarAX4llpw70UI7Zqg2dyE06JGSHm04ZqNDDC5PUH1uo=@willsroot.io> <aGh6HiQmcgsPug1u@pop-os.localdomain>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 101863d14e42b2a8fa434b75af334c5c54e62f6e
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, July 5th, 2025 at 1:04 AM, Cong Wang <xiyou.wangcong@gmail.com=
> wrote:

>=20
>=20
> On Wed, Jul 02, 2025 at 08:39:45PM +0000, William Liu wrote:
>=20
> > Hi,
> >=20
> > We write to report a bug in qlen and backlog consistency affecting hhf,=
 fq, fq_codel, and fq_pie when acting as a child of tbf. The cause of this =
bug was introduced by the following fix last month designed to address a nu=
ll dereference bug caused by gso segmentation and a temporary inconsistency=
 in queue state when tbf peeks at its child while running out of tokens dur=
ing tbf_dequeue [1]. We actually reported that bug but did not realize the =
subtle problem in the fix until now. We are aware of bugs with similar symp=
toms reported by Mingi [3] and Lion [4], but those are of a different root =
cause (at least what we can see of Mingi's report).
>=20
>=20
> Thanks for your report.
>=20
> > This works on the upstream kernel, and we have the following reproducer=
.
> >=20
> > ./tc qdisc del dev lo root
> > ./tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b latency 1=
ms || echo TBF
> > ./tc qdisc add dev lo handle 3: parent 1:1 hhf limit 1000 || echo HH
> > ping -I lo -f -c1 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
> > ./tc qdisc change dev lo handle 3: parent 1:1 hhf limit 0 || echo HH
> > ./tc qdisc replace dev lo handle 2: parent 1:1 sfq || echo SFQ
> >=20
> > Note that a patched version of tc that supports 0 limits must be built.=
 The symptom of the bug arises in the WARN_ON_ONCE check in qdisc_tree_redu=
ce_backlog [2], where n is 0. You can replace hhf with fq, fq_codel, and fq=
_pie to trigger warnings as well, though the success rate may vary.
> >=20
> > The root cause comes from the newly introduced function qdisc_dequeue_i=
nternal, which the change handler will trigger in the affected qdiscs [5]. =
When dequeuing from a non empty gso in this peek function, only qlen is dec=
remented, and backlog is not considered. The gso insertion is triggered by =
qdisc_peek_dequeued, which tbf calls for these qdiscs when they are its chi=
ld.
> >=20
> > When replacing the qdisc, tbf_graft triggers, and qdisc_purge_queue tri=
ggers qdisc_tree_reduce_backlog with the inconsistent values, which one can=
 observe by adding printk to the passed qlen backlog values.
>=20
>=20
> If I understand you correctly, the problem is the inconsistent behavior
> between qdisc_purge_queue() and qdisc_dequeue_internal()? And it is
> because the former does not take care of ->gso_skb?
>=20

No, there are 2 points of inconsistent behavior.=20

1. qdisc_dequeue_internal and qdisc_peek_dequeued. In qdisc_peek_dequeued, =
when a skb comes from the dequeue handler, it gets added to the gso_skb wit=
h qlen and backlog increased. In qdisc_dequeue_internal, only qlen is decre=
ased when removing from gso.

2. The dequeue limit loop in change handlers and qdisc_dequeue_internal. Ev=
ery time those loops call qdisc_dequeue_internal, the loops track their own=
 version of dropped items and total dropped packet sizes, before using thos=
e values for qdisc_tree_reduce_backlog. The hhf qdisc is an exception as it=
 just uses a before and after loop in the limit change loop. Would this not=
 lead to double counting in the gso_skb dequeue case for qdisc_dequeue_inte=
rnal?=20

Also, I took a look at some of the dequeue handlers (which qdisc_dequeue_in=
ternal call when direct is false), and fq_codel_dequeue touches the drop_co=
unt and drop_len statistics, which the limit adjustment loop also uses.=20

> > While historically triggering this warning often results in a UAF, it s=
eems safe in this case to our knowledge. This warning will only trigger in =
tbf_graft, and this corrupted class will be removed and made inaccessible r=
egardless. Lion's patch also looks like qlen_notify will always trigger, wh=
ich is good.
> >=20
> > However, the whole operation of qdisc_dequeue_internal in conjunction w=
ith its usage is strange. Posting the function here for reference:
> >=20
> > static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch,=
 bool direct)
> > {
> > struct sk_buff *skb;
> >=20
> > skb =3D __skb_dequeue(&sch->gso_skb);
> > if (skb) {
> > sch->q.qlen--;
> > return skb;
> > }
> > if (direct)
> > return __qdisc_dequeue_head(&sch->q);
> > else
> > return sch->dequeue(sch);
> > }
> >=20
> > The qdiscs pie, codel, fq, fq_pie, and fq_codel all adjust qlen and bac=
klog in the same loop where they call qdisc_dequeue_internal to bring the q=
ueue back to the newly requested limit. In the gso case, this always seems =
incorrect as the number of dropped packets would be double counted for. In =
the non gso case, this looks to be fine for when direct is true, as in the =
case of codel and pie, but can be an issue otherwise when the dequeue handl=
er adjusts the qlen and backlog values. In the hhf case, no action for qlen=
 and backlog accounting is taken at all after qdisc_dequeue_internal in the=
 loop (they just track a before and after value).
>=20
>=20
> I noticed the inconsistent definition of sch->limit too, some Qdisc's
>=20
> just shrink their backlog down to the limit (assuming it is smaller than
> the old one), some Qdisc's just flush everything.
>=20
> The reason why I didn't touch it is that it may be too late to change,
> since it is exposed to users, so maybe there are users expecting the
> existing behaviors.
>=20
> > Cong, I see you posted an RFC for cleaning up GSO segmentation. Will th=
ese address this inconsistency issue?
>=20
>=20
> No, actually the ->gso_skb has nothing to do with GSO segmentation. It
>=20
> is a terribly misleading name, it should be named as "->peeked_skb". I
>=20
> wanted to rename it but was too lazy to do so. (You are welcome to work
> on this if you have time).

Ok, I might take a look at this when free.


