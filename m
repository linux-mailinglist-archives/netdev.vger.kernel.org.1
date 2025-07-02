Return-Path: <netdev+bounces-203406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D52EAF5CB4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507723BD64C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7702857C5;
	Wed,  2 Jul 2025 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="svXgKaeO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F1D2F2728
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469672; cv=none; b=fruPYgVH54XW0K5iuB8Yf3CXmQ1LzD4NDMpFVyAuub9cIPz3XvUKFoEEn8h/wBiS3nG/3XYWDqnn0qZCxDh5P/S0bDHTZBO27jZm1cM2Klgp1/yjCPnF9yH1oG/n8SYaIMDud/fqayDYigEXurIubp5ir3QA3zyWXXZGLfJi+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469672; c=relaxed/simple;
	bh=2mEdTRDuApr5KvT1TxhMMLyqPVDBj8SlKj1v67WW7+I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YeTh25xkvr6vazvwgz2s5UIeIcowCy5kfz+aWVO2Fe+1ekLXM1KekR7CKQYtt5k5HDT0R2jy4pak3zZ5+yEh+QwK3+IsGNyDPBKT8JxIvIRdo2temFSikiGLik2HOBC5cEWcRzZi4hoqb62BJkUEojCHzNSF9NSU+53EHl0b1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=svXgKaeO; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1751469666; x=1751728866;
	bh=2mEdTRDuApr5KvT1TxhMMLyqPVDBj8SlKj1v67WW7+I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=svXgKaeOGcXvP2sd45hCDAfSFvjUbhbiJIPPV3xHvnDT9CxP41b9BxuZT7CqA9TYG
	 utEHbNdERYEtFY97rBzMRifWsN0k6ODWDaKnTDXtevUYvD5DlEQw/O9NJDpiUqdjDw
	 uQ92kAGBX+XeToXlkq5PVLcNrSVZ16T7r8PXgXG0HnzbHpnQTdd4ktT98rTzsCjaf2
	 7PxNwPgsqXzbv2614zzOidTO/NBOoMPwQ2FFTcCScgmjY4+g2KaK+jrhR+rlhJA3ju
	 eWMSz0pUE3Sudcc2KxIyIt6tSwOO72Ho3xyOVzfS3m1GcmZrOc8B1xEGasntZ3jMDH
	 FrFjqGhyXZHFw==
Date: Wed, 02 Jul 2025 15:20:50 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, stephen@networkplumber.org, Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch net 1/2] netem: Fix skb duplication logic to prevent infinite loops
Message-ID: <1tUrbP9EoC0snDQNBB8x_nmT2z1xjeEpsxnfS98xVcYAtGaJ6XWpUw6pHmCiC8f4c6WwcRpFMPIOivnco0aR8ZnVp2dC2lZyzgXzg7b8qDE=@willsroot.io>
In-Reply-To: <CAM0EoM=CwJczYjCOYZzNJsjxz_dwaei5mTHyREYbS4iaE3drSg@mail.gmail.com>
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com> <20250701231306.376762-2-xiyou.wangcong@gmail.com> <aGSSF7K/M81Pjbyz@pop-os.localdomain> <CAM0EoMmDj9TOafynkjVPaBw-9s7UDuS5DoQ_K3kAtioEdJa1-g@mail.gmail.com> <CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com> <CAM0EoM=CwJczYjCOYZzNJsjxz_dwaei5mTHyREYbS4iaE3drSg@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 8c021efbd0350ced884ebe9320f1503c173862eb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Wednesday, July 2nd, 2025 at 3:06 PM, Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:

>=20
>=20
> On Wed, Jul 2, 2025 at 11:04=E2=80=AFAM Jamal Hadi Salim jhs@mojatatu.com=
 wrote:
>=20
> > On Wed, Jul 2, 2025 at 10:12=E2=80=AFAM Jamal Hadi Salim jhs@mojatatu.c=
om wrote:
> >=20
> > > On Tue, Jul 1, 2025 at 9:57=E2=80=AFPM Cong Wang xiyou.wangcong@gmail=
.com wrote:
> > >=20
> > > > On Tue, Jul 01, 2025 at 04:13:05PM -0700, Cong Wang wrote:
> > > >=20
> > > > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > > > index fdd79d3ccd8c..33de9c3e4d1b 100644
> > > > > --- a/net/sched/sch_netem.c
> > > > > +++ b/net/sched/sch_netem.c
> > > > > @@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *skb,=
 struct Qdisc *sch,
> > > > > skb->prev =3D NULL;
> > > > >=20
> > > > > /* Random duplication */
> > > > > - if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, =
&q->prng))
> > > > > + if (tc_skb_cb(skb)->duplicate &&
> > > >=20
> > > > Oops, this is clearly should be !duplicate... It was lost during my
> > > > stupid copy-n-paste... Sorry for this mistake.
> > >=20
> > > I understood you earlier, Cong. My view still stands:
> > > You are adding logic to a common data structure for a use case that
> > > really makes no sense. The ROI is not good.
> > > BTW: I am almost certain you will hit other issues when this goes out
> > > or when you actually start to test and then you will have to fix more
> > > spots.
> >=20
> > Here's an example that breaks it:
> >=20
> > sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0
> > 0 0 0 0 0 0 0 0 0 0 0
> > sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
> > netem_bug_test.o sec classifier/pass classid 1:1
> > sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate =
100%
> > sudo tc qdisc add dev lo parent 10: handle 30: netem gap 1 limit 4
> > duplicate 100% delay 1us reorder 100%
> >=20
> > And the ping 127.0.0.1 -c 1
> > I had to fix your patch for correctness (attached)
> >=20
> > the ebpf prog is trivial - make it just return the classid or even zero=
.
> >=20
> > William, as a middle ground can you take a crack at using cb_ext -
> > take a look for example at struct tc_skb_ext_alloc in cls_api.c (that
> > one is safe to extend).
>=20
> Meant: struct tc_skb_ext *ex
>=20
> If you need help ping me privately - some latency will be involved..
>=20
> cheers,
> jamal

Sure, I can take a crack at it in the upcoming days.

Best,
Will

