Return-Path: <netdev+bounces-205129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31924AFD843
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 22:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18251C23EB7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 20:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86BC237180;
	Tue,  8 Jul 2025 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="GzsQ83iQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163A14EC73
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006102; cv=none; b=sCooLL8G/93Vrs1TIX1zUrt1F3H/Qcox/c+dckRkEFh/3v5ihSorbe5JuZ4G9egoxHw9WuM4NQD0MSfOXkkrbKWTaWQ5Hr7Nt41SCJyuXMrfcd78UBniAZSIsUpsZFl68z3+/kFjrvMA/9wHNNHCNcQ0qJs7JpqjIzK7+LR2rVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006102; c=relaxed/simple;
	bh=btdtHyx6SZ/6qn8hf3z6P8TkqiyZ0QThhraS0wLRty4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9SoDaJAsaMHAdwj4J8rhVpgPdpT5fgHMRLatnPIFHYgzFi+q1tERhXlNU0efkef9IhyI2VB/6Bnu1/id2vPh2r9nlzZ6aj5RWhG/732fsknS9aK5FAnaT+f0cCzUJcA/wV5ey/vKxqgS2otKORu82XtRigAKM2e2DxObsCnua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=GzsQ83iQ; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1752006096; x=1752265296;
	bh=btdtHyx6SZ/6qn8hf3z6P8TkqiyZ0QThhraS0wLRty4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GzsQ83iQ3MjggKCephc70Jw12Z4YCPejLK2hF7VMv7R34WkQzUm+0Vexu+eoLBw9c
	 9EbMe0+oEVhRgB/FPCOSOHQ3OU9Pcgx71iGlD9DSz9qD8mTZFDtlypzeiNx1OFTlGt
	 SrTvbxCoYW0KY0oNjFBHc9p1a0PMk+hN9c53DVOtGw6o3iaUc55uFC/9rTV9CLtMqz
	 mdOBlNP1djqeKKib6zhGhB9Rdwy1mE8u1hwZ3XDAkQ5D0bJ32NfNOyq0Da9sfF+TRV
	 OlK9iEGHaB30T1AGFgPXR/ida8YFwYWdUqyGC3ZJeuXVEWGVV9H+N2afNERB7Hpyq5
	 PslHJY5ENm0xw==
Date: Tue, 08 Jul 2025 20:21:31 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <jhs@mojatatu.com>, Savy <savy@syst3mfailure.io>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [BUG]  Inconsistency between qlen and backlog in hhf, fq, fq_codel, and fq_pie causing WARNING in qdisc_tree_reduce_backlog
Message-ID: <rt_47kiO_w5I_HyL1B4RuHKclPjWvmSJqnlZwSZB5YKxStxbDAsb7lTae0yhrRLJkh9yb7JjV-LpU_xzNCd031YI23Z4Yy83u8-DgYuPsEI=@willsroot.io>
In-Reply-To: <aGwXLe8djsE0H3Ed@pop-os.localdomain>
References: <2UMzQV_2SQetYadgDKNRO76CgTlKBSMAHmsHeosdnhCPcOEwBB-6mSKXghTNSLudarAX4llpw70UI7Zqg2dyE06JGSHm04ZqNDDC5PUH1uo=@willsroot.io> <aGh6HiQmcgsPug1u@pop-os.localdomain> <X6Q8WFnkbyNTRaSQ07hgoBUIihJJdm7GIDvCCY0prplSeVDZPKXquiH2as4hPXAWn1J1a2tyP5RnBm8tjKWNM881yDlMlx0pMg9vioBRY1w=@willsroot.io> <aGwXLe8djsE0H3Ed@pop-os.localdomain>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 49937e5e0f34e40894d9ac41ebaac54dafdf2c70
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, July 7th, 2025 at 6:51 PM, Cong Wang <xiyou.wangcong@gmail.com> =
wrote:

>=20
>=20
> On Sun, Jul 06, 2025 at 01:43:08PM +0000, William Liu wrote:
>=20
> > On Saturday, July 5th, 2025 at 1:04 AM, Cong Wang xiyou.wangcong@gmail.=
com wrote:
> >=20
> > > On Wed, Jul 02, 2025 at 08:39:45PM +0000, William Liu wrote:
> > >=20
> > > > Hi,
> > > >=20
> > > > We write to report a bug in qlen and backlog consistency affecting =
hhf, fq, fq_codel, and fq_pie when acting as a child of tbf. The cause of t=
his bug was introduced by the following fix last month designed to address =
a null dereference bug caused by gso segmentation and a temporary inconsist=
ency in queue state when tbf peeks at its child while running out of tokens=
 during tbf_dequeue [1]. We actually reported that bug but did not realize =
the subtle problem in the fix until now. We are aware of bugs with similar =
symptoms reported by Mingi [3] and Lion [4], but those are of a different r=
oot cause (at least what we can see of Mingi's report).
> > >=20
> > > Thanks for your report.
> > >=20
> > > > This works on the upstream kernel, and we have the following reprod=
ucer.
> > > >=20
> > > > ./tc qdisc del dev lo root
> > > > ./tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b laten=
cy 1ms || echo TBF
> > > > ./tc qdisc add dev lo handle 3: parent 1:1 hhf limit 1000 || echo H=
H
> > > > ping -I lo -f -c1 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
> > > > ./tc qdisc change dev lo handle 3: parent 1:1 hhf limit 0 || echo H=
H
> > > > ./tc qdisc replace dev lo handle 2: parent 1:1 sfq || echo SFQ
> > > >=20
> > > > Note that a patched version of tc that supports 0 limits must be bu=
ilt. The symptom of the bug arises in the WARN_ON_ONCE check in qdisc_tree_=
reduce_backlog [2], where n is 0. You can replace hhf with fq, fq_codel, an=
d fq_pie to trigger warnings as well, though the success rate may vary.
> > > >=20
> > > > The root cause comes from the newly introduced function qdisc_deque=
ue_internal, which the change handler will trigger in the affected qdiscs [=
5]. When dequeuing from a non empty gso in this peek function, only qlen is=
 decremented, and backlog is not considered. The gso insertion is triggered=
 by qdisc_peek_dequeued, which tbf calls for these qdiscs when they are its=
 child.
> > > >=20
> > > > When replacing the qdisc, tbf_graft triggers, and qdisc_purge_queue=
 triggers qdisc_tree_reduce_backlog with the inconsistent values, which one=
 can observe by adding printk to the passed qlen backlog values.
> > >=20
> > > If I understand you correctly, the problem is the inconsistent behavi=
or
> > > between qdisc_purge_queue() and qdisc_dequeue_internal()? And it is
> > > because the former does not take care of ->gso_skb?
> >=20
> > No, there are 2 points of inconsistent behavior.
> >=20
> > 1. qdisc_dequeue_internal and qdisc_peek_dequeued. In qdisc_peek_dequeu=
ed, when a skb comes from the dequeue handler, it gets added to the gso_skb=
 with qlen and backlog increased. In qdisc_dequeue_internal, only qlen is d=
ecreased when removing from gso.
>=20
>=20
> Yes, because qlen is handled by qdisc_dequeue_internal()'s callers to
> control their loop of sch->limit.
>=20

This makes sense. However, if backlog is not adjusted in that helper, then =
they would go out of sync. qdisc_tree_reduce_backlog only adjusts counters =
for parent/ancestral qdiscs.=20

This should help elucidate the problem:
export TARGET=3Dhhf
./tc qdisc del dev lo root
./tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b latency 1ms |=
| echo TBF
./tc qdisc replace dev lo handle 3: parent 1:1 $TARGET limit 1000 || echo H=
H
echo ''; echo 'add child'; tc -s -d qdisc show dev lo
ping -I lo -f -c1 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
echo ''; echo 'after ping'; tc -s -d qdisc show dev lo
./tc qdisc change dev lo handle 3: parent 1:1 $TARGET limit 0 || echo HH
echo ''; echo 'after limit drop'; tc -s -d qdisc show dev lo
./tc qdisc replace dev lo handle 2: parent 1:1 sfq || echo SFQ
echo ''; echo 'post graft'; tc -s -d qdisc show dev lo

Perhaps the original WARNING in qdisc_tree_reduce_backlog (which Lion's pat=
ch removed) regarding an inconsistent backlog was not a real problem then? =
But this backlog adjustment can be accounted for pretty easily I think. Let=
 me know if I can help with this.

On another note, asides from hhf (because the backlog value to qdisc_tree_r=
educe_backlog is 0 due to its different limit change loop), the other qdisc=
s cause an underflow in the backlog of tbf by the final graft.

>=20
> > 2. The dequeue limit loop in change handlers and qdisc_dequeue_internal=
. Every time those loops call qdisc_dequeue_internal, the loops track their=
 own version of dropped items and total dropped packet sizes, before using =
those values for qdisc_tree_reduce_backlog. The hhf qdisc is an exception a=
s it just uses a before and after loop in the limit change loop. Would this=
 not lead to double counting in the gso_skb dequeue case for qdisc_dequeue_=
internal?
>=20
>=20
> Right, I think hhf qdisc should align with other Qdisc's to track the
> qlen.
>=20
> Note: my patch didn't change its behavior, so this issue existed even
> before my patch.
>=20
> > Also, I took a look at some of the dequeue handlers (which qdisc_dequeu=
e_internal call when direct is false), and fq_codel_dequeue touches the dro=
p_count and drop_len statistics, which the limit adjustment loop also uses.
>=20
>=20
>=20
> Right, this is why it is hard to move the qlen tracking into
> qdisc_dequeue_internal().
>=20
> Thanks.

