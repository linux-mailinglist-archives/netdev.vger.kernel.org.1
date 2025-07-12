Return-Path: <netdev+bounces-206293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D126FB02830
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 02:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA081BC1126
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 00:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C9A81E;
	Sat, 12 Jul 2025 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="F9vwXXLT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15D7E1
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278925; cv=none; b=fzOAOLwzfjh+Wm029UP6ypvX0XXe18fzfvoIh3QW8tp1aboTR66mNbj+OFC2lLIjm6Vacsqf31GaWtHm+nsg02maSnV0/19yhDAb183nP2an6MTwVygK42dy3jaTFdo6ugBWProidLM2Pyo9ZsHmMtjh7bTmSXgUcoJQhwPphbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278925; c=relaxed/simple;
	bh=EG+ZK4YhcA0Vtq2sL91cOe0JEoADKhJ/YQ2CZ38jIx4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQS5j9imWsQzALHrVH9aSKTZlS5uvAtEl8McdP0zruKNrvjUc3UKMxIuLY8XeGS0Hpe0dlDnFSNyKY8kz4eQ+jhjqWXlqUpAR2JWaaBUR/b7gElPiVljGsyMhM/ui3mgXdWUuA7i3/cYBJ1lla+wbQ7h7od1lnr0T6lb1MGxb2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=F9vwXXLT; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1752278917; x=1752538117;
	bh=EG+ZK4YhcA0Vtq2sL91cOe0JEoADKhJ/YQ2CZ38jIx4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=F9vwXXLTxNemAsL/8uXGZ1kbVXA6eDiFvfJ9OL2VF+4GF6sj2QlcQ0fO4s/ZPJv/A
	 dq0zrb1nYv3gUhzUxFYVlkx95Bc08Ps4pC6tsJMqDDTaDC4k1C1NDMpwlSE4t3N1A2
	 gfzbwBKm4ZVXR4LOIUyjhWD1MyFTsCcahh8OZYA/VOyhpvokcN84MAiqzhOvq9JpTI
	 yIPLqbDCXQllBeS2eKAmgKQthWBGvx+EQynEzGxwKpdSWEqskxFuX/UWyVB55Sar8m
	 kVaadE05eNR/kStrjLVZUueKcFzUHGx7oK5uDg/XriqcVxWOP5K2bwl5QwKu1ZV8tS
	 7GP/lEVZiahFg==
Date: Sat, 12 Jul 2025 00:08:32 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <jhs@mojatatu.com>, Savy <savy@syst3mfailure.io>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [BUG]  Inconsistency between qlen and backlog in hhf, fq, fq_codel, and fq_pie causing WARNING in qdisc_tree_reduce_backlog
Message-ID: <n7wl3mZsMuu8WFLvQKWdaXXRLgQDedzbO2rGqlTQgmXtY_fWGX6G_H_R9O6-T8bN7viUWnk0GL-vyDryy_hbEcIoenjw56YNQ5uypXvIgNU=@willsroot.io>
In-Reply-To: <aHBBaXPPQvBCejoM@pop-os.localdomain>
References: <2UMzQV_2SQetYadgDKNRO76CgTlKBSMAHmsHeosdnhCPcOEwBB-6mSKXghTNSLudarAX4llpw70UI7Zqg2dyE06JGSHm04ZqNDDC5PUH1uo=@willsroot.io> <aGh6HiQmcgsPug1u@pop-os.localdomain> <X6Q8WFnkbyNTRaSQ07hgoBUIihJJdm7GIDvCCY0prplSeVDZPKXquiH2as4hPXAWn1J1a2tyP5RnBm8tjKWNM881yDlMlx0pMg9vioBRY1w=@willsroot.io> <aGwXLe8djsE0H3Ed@pop-os.localdomain> <rt_47kiO_w5I_HyL1B4RuHKclPjWvmSJqnlZwSZB5YKxStxbDAsb7lTae0yhrRLJkh9yb7JjV-LpU_xzNCd031YI23Z4Yy83u8-DgYuPsEI=@willsroot.io> <aHBBaXPPQvBCejoM@pop-os.localdomain>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 1b2883435d696402a1ed81053b1f262aa2fba844
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, July 10th, 2025 at 10:40 PM, Cong Wang <xiyou.wangcong@gmail.c=
om> wrote:

>=20
>=20
> On Tue, Jul 08, 2025 at 08:21:31PM +0000, William Liu wrote:
>=20
> > On Monday, July 7th, 2025 at 6:51 PM, Cong Wang xiyou.wangcong@gmail.co=
m wrote:
> >=20
> > > On Sun, Jul 06, 2025 at 01:43:08PM +0000, William Liu wrote:
> > >=20
> > > > On Saturday, July 5th, 2025 at 1:04 AM, Cong Wang xiyou.wangcong@gm=
ail.com wrote:
> > > >=20
> > > > > On Wed, Jul 02, 2025 at 08:39:45PM +0000, William Liu wrote:
> > > > >=20
> > > > > > Hi,
> > > > > >=20
> > > > > > We write to report a bug in qlen and backlog consistency affect=
ing hhf, fq, fq_codel, and fq_pie when acting as a child of tbf. The cause =
of this bug was introduced by the following fix last month designed to addr=
ess a null dereference bug caused by gso segmentation and a temporary incon=
sistency in queue state when tbf peeks at its child while running out of to=
kens during tbf_dequeue [1]. We actually reported that bug but did not real=
ize the subtle problem in the fix until now. We are aware of bugs with simi=
lar symptoms reported by Mingi [3] and Lion [4], but those are of a differe=
nt root cause (at least what we can see of Mingi's report).
> > > > >=20
> > > > > Thanks for your report.
> > > > >=20
> > > > > > This works on the upstream kernel, and we have the following re=
producer.
> > > > > >=20
> > > > > > ./tc qdisc del dev lo root
> > > > > > ./tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b l=
atency 1ms || echo TBF
> > > > > > ./tc qdisc add dev lo handle 3: parent 1:1 hhf limit 1000 || ec=
ho HH
> > > > > > ping -I lo -f -c1 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
> > > > > > ./tc qdisc change dev lo handle 3: parent 1:1 hhf limit 0 || ec=
ho HH
> > > > > > ./tc qdisc replace dev lo handle 2: parent 1:1 sfq || echo SFQ
> > > > > >=20
> > > > > > Note that a patched version of tc that supports 0 limits must b=
e built. The symptom of the bug arises in the WARN_ON_ONCE check in qdisc_t=
ree_reduce_backlog [2], where n is 0. You can replace hhf with fq, fq_codel=
, and fq_pie to trigger warnings as well, though the success rate may vary.
> > > > > >=20
> > > > > > The root cause comes from the newly introduced function qdisc_d=
equeue_internal, which the change handler will trigger in the affected qdis=
cs [5]. When dequeuing from a non empty gso in this peek function, only qle=
n is decremented, and backlog is not considered. The gso insertion is trigg=
ered by qdisc_peek_dequeued, which tbf calls for these qdiscs when they are=
 its child.
> > > > > >=20
> > > > > > When replacing the qdisc, tbf_graft triggers, and qdisc_purge_q=
ueue triggers qdisc_tree_reduce_backlog with the inconsistent values, which=
 one can observe by adding printk to the passed qlen backlog values.
> > > > >=20
> > > > > If I understand you correctly, the problem is the inconsistent be=
havior
> > > > > between qdisc_purge_queue() and qdisc_dequeue_internal()? And it =
is
> > > > > because the former does not take care of ->gso_skb?
> > > >=20
> > > > No, there are 2 points of inconsistent behavior.
> > > >=20
> > > > 1. qdisc_dequeue_internal and qdisc_peek_dequeued. In qdisc_peek_de=
queued, when a skb comes from the dequeue handler, it gets added to the gso=
_skb with qlen and backlog increased. In qdisc_dequeue_internal, only qlen =
is decreased when removing from gso.
> > >=20
> > > Yes, because qlen is handled by qdisc_dequeue_internal()'s callers to
> > > control their loop of sch->limit.
> >=20
> > This makes sense. However, if backlog is not adjusted in that helper, t=
hen they would go out of sync. qdisc_tree_reduce_backlog only adjusts count=
ers for parent/ancestral qdiscs.
>=20
>=20
> Oh, you mean some callers miss qdisc_qstats_backlog_dec()? If you can
> confirm this is an issue and adding it could solve it, please go ahead
> to send out a patch. It makes sense to me so far, at least for aligning
> with other callers.

Ok sounds good, I will take a stab at it then.

>=20
> > This should help elucidate the problem:
> > export TARGET=3Dhhf
> > ./tc qdisc del dev lo root
> > ./tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b latency 1=
ms || echo TBF
> > ./tc qdisc replace dev lo handle 3: parent 1:1 $TARGET limit 1000 || ec=
ho HH
> > echo ''; echo 'add child'; tc -s -d qdisc show dev lo
> > ping -I lo -f -c1 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
> > echo ''; echo 'after ping'; tc -s -d qdisc show dev lo
> > ./tc qdisc change dev lo handle 3: parent 1:1 $TARGET limit 0 || echo H=
H
> > echo ''; echo 'after limit drop'; tc -s -d qdisc show dev lo
> > ./tc qdisc replace dev lo handle 2: parent 1:1 sfq || echo SFQ
> > echo ''; echo 'post graft'; tc -s -d qdisc show dev lo
> >=20
> > Perhaps the original WARNING in qdisc_tree_reduce_backlog (which Lion's=
 patch removed) regarding an inconsistent backlog was not a real problem th=
en? But this backlog adjustment can be accounted for pretty easily I think.=
 Let me know if I can help with this.
>=20
>=20
> I think Lion's patch fixes a completely different issue? At least I
> don't immediately connect it with this sch->limit issue.

Lion's patch removed the WARN_ONCE that would show this issue occurring.

> > On another note, asides from hhf (because the backlog value to qdisc_tr=
ee_reduce_backlog is 0 due to its different limit change loop), the other q=
discs cause an underflow in the backlog of tbf by the final graft.
>=20
>=20
> Does adding qdisc_qstats_backlog_dec() solve this too?
>=20
> Thanks.

I think it should. Will test sometime soon.

Best,
Will

