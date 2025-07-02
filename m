Return-Path: <netdev+bounces-203507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46490AF6375
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB1C1C26053
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9FE2BCF51;
	Wed,  2 Jul 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="N0+M9a5K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EDA2D63E2
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488802; cv=none; b=BRqKQbGflcAKHAQEsiBzbFyiLxw/kRWXqrWZoRlLScGUHaNtiL/uKr1FLSx5C0rQlxEms0NxhvyYuVc8waOpVPLI8vaEBpmG7RgVyVp+q1MMj6UluZfSbCpyr7OYDNMGpZ6z9kqH9x4eC3ceADlU6RwkDdSepyPg9cJz7JS0O4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488802; c=relaxed/simple;
	bh=uaiHubqpFRR4F4vaOrI/6747rZfgxE1BrVEsRjq8fUs=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=XumKEdzSBa7i3nuOClLx+494qKfS3+1VVRt0JeoPWTXXXEeZOjB55YJu3LU3fD6CfrJj4h3qGntAyztBQfLa1SurkAQko+Md8QH14Sg8dRNsRnXFEyvIb3gCfTgyJHn+xnU5G6dnDuqmkaXqx3AIXQiXoO7mi/+8Edgz6qx5R3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=N0+M9a5K; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1751488790; x=1751747990;
	bh=a/hdannPY9BCy1X1wMpHfEy0TMKP+MEPbU305iK4TVU=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=N0+M9a5K/LVjZp7gcnaOi0TgkG1co6fjJEZflmTI8tBrqFwX/2hTsDEoAtU0dUKE/
	 uQyaGy55MC5o/VGCUtQazOhq+jRCfHE91h6jlens1kJ/GPFGKLDvv8ZokwzuJvQ9R2
	 pnyRR1afrqDMkNLj5pu2wtrWsI1F9ISaEaERLy8kLgwmdP0pvJh9erM6nlnqTPyP5o
	 hiVW2R2f89nTiYkcG5I1GtZzMcvHLYdzoDN4c90AchNjCPlLyo/AMUkTELt2w064aC
	 IJBQklCWA+/xZ+2LYOXpxeP8Dyw2b74rmparr9dft4mnJm0N+a7wAy7AOuZjSW8Aet
	 R6Yjx+AF6CaFg==
Date: Wed, 02 Jul 2025 20:39:45 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <jhs@mojatatu.com>, Savy <savy@syst3mfailure.io>, Paolo Abeni <pabeni@redhat.com>
From: William Liu <will@willsroot.io>
Subject: [BUG]  Inconsistency between qlen and backlog in hhf, fq, fq_codel, and fq_pie causing WARNING in qdisc_tree_reduce_backlog
Message-ID: <2UMzQV_2SQetYadgDKNRO76CgTlKBSMAHmsHeosdnhCPcOEwBB-6mSKXghTNSLudarAX4llpw70UI7Zqg2dyE06JGSHm04ZqNDDC5PUH1uo=@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 93ac2c8c761f39ddae57dbcff67cd7d6a8552fc3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

We write to report a bug in qlen and backlog consistency affecting hhf, fq,=
 fq_codel, and fq_pie when acting as a child of tbf. The cause of this bug =
was introduced by the following fix last month designed to address a null d=
ereference bug caused by gso segmentation and a temporary inconsistency in =
queue state when tbf peeks at its child while running out of tokens during =
tbf_dequeue [1]. We actually reported that bug but did not realize the subt=
le problem in the fix until now. We are aware of bugs with similar symptoms=
 reported by Mingi [3] and Lion [4], but those are of a different root caus=
e (at least what we can see of Mingi's report).

This works on the upstream kernel, and we have the following reproducer.

./tc qdisc del dev lo root
./tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b latency 1ms |=
| echo TBF
./tc qdisc add dev lo handle 3: parent 1:1 hhf limit 1000 || echo HH
ping -I lo -f -c1 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
./tc qdisc change dev lo handle 3: parent 1:1 hhf limit 0 || echo HH
./tc qdisc replace dev lo handle 2: parent 1:1 sfq || echo SFQ=20

Note that a patched version of tc that supports 0 limits must be built. The=
 symptom of the bug arises in the WARN_ON_ONCE check in qdisc_tree_reduce_b=
acklog [2], where n is 0.  You can replace hhf with fq, fq_codel, and fq_pi=
e to trigger warnings as well, though the success rate may vary.

The root cause comes from the newly introduced function qdisc_dequeue_inter=
nal, which the change handler will trigger in the affected qdiscs [5]. When=
 dequeuing from a non empty gso in this peek function, only qlen is decreme=
nted, and backlog is not considered. The gso insertion is triggered by qdis=
c_peek_dequeued, which tbf calls for these qdiscs when they are its child.

When replacing the qdisc, tbf_graft triggers, and qdisc_purge_queue trigger=
s qdisc_tree_reduce_backlog with the inconsistent values, which one can obs=
erve by adding printk to the passed qlen backlog values.

While historically triggering this warning often results in a UAF, it seems=
 safe in this case to our knowledge. This warning will only trigger in tbf_=
graft, and this corrupted class will be removed and made inaccessible regar=
dless. Lion's patch also looks like qlen_notify will always trigger, which =
is good.

However, the whole operation of qdisc_dequeue_internal in conjunction with =
its usage is strange. Posting the function here for reference:

static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch, boo=
l direct)
{
    struct sk_buff *skb;

    skb =3D __skb_dequeue(&sch->gso_skb);
    if (skb) {
        sch->q.qlen--;
        return skb;
    }
    if (direct)
        return __qdisc_dequeue_head(&sch->q);
    else
        return sch->dequeue(sch);
}

The qdiscs pie, codel, fq, fq_pie, and fq_codel all adjust qlen and backlog=
 in the same loop where they call qdisc_dequeue_internal to bring the queue=
 back to the newly requested limit. In the gso case, this always seems inco=
rrect as the number of dropped packets would be double counted for. In the =
non gso case, this looks to be fine for when direct is true, as in the case=
 of codel and pie, but can be an issue otherwise when the dequeue handler a=
djusts the qlen and backlog values. In the hhf case, no action for qlen and=
 backlog accounting is taken at all after qdisc_dequeue_internal in the loo=
p (they just track a before and after value).

Cong, I see you posted an RFC for cleaning up GSO segmentation. Will these =
address this inconsistency issue?

Best,
Will
Savy

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?id=3D2d3cbfd6d54a2c39ce3244f33f85c595844bd7b8
[2] https://elixir.bootlin.com/linux/v6.16-rc4/source/net/sched/sch_api.c#L=
809
[3] https://lore.kernel.org/netdev/CAM0EoMnv6YAUJVEFx2mGrP75G8wzRiN+Z=3DhSf=
RAz8ia0Fe4vBw@mail.gmail.com/
[4] https://lore.kernel.org/netdev/CAM0EoMngoh9hMr363XNiVxpKCu3Y+C4QkBmu0br=
Yncx3YgPF=3DQ@mail.gmail.com/
[5] https://elixir.bootlin.com/linux/v6.16-rc4/source/include/net/sch_gener=
ic.h#L1034

