Return-Path: <netdev+bounces-212542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C211AB21297
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9E642395D
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3098829BDBE;
	Mon, 11 Aug 2025 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="WRceLz0X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D029BD9C
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931184; cv=none; b=jkxoZAx0XVHNGzLBFCLtzgJ4bB8VKk5AAFC5MkHxNQgKWQXQVmxyn2QA0oe0XrGf52hTRFbPb3DXRTgryZ8JkSmTRaSjfqzPB6WvObQk6i8lsFFMcBLO0nrTfkDeeoQlXipy7DUAv6VvWJH+L70d9KlVTPkybgmk9tfPy/DffXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931184; c=relaxed/simple;
	bh=5QndF160GCFjm7dIrzvsXDNlVlzG62tPwVmfhncnrN4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqC5AihyWxPhtBFq79yRondaw/nCp1FNCoQbM0yTnSSNe7doRkoaBQoV8X6UGGtI0F5Q9DIjIanHJ97LYfl2IsaFoe+lufVMEfMC22g/JcBH1V5kDwkGB8/mClkbQtVm2zw1uFG/D5rdRlXYZbYE+7NxQIAaSXft18p3n5RWJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=WRceLz0X; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1754931178; x=1755190378;
	bh=5QndF160GCFjm7dIrzvsXDNlVlzG62tPwVmfhncnrN4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WRceLz0X+V799SzM24EsebUM2VTRK3emDCD8LtIjWRzGW/0cQD2Xq3vIzQ1bP4mPJ
	 X/xuKviWmd27AMX5mFxEStisyqBjRRd0qwyH6SfADnDIB6lKRjLuQXWrGa3fc8WQi9
	 0ex7Ufl3CYO+WLC/FPZ6dYt7p3tifCPIg1543Ot5/AjxKguFMxs5TQX9Ksh4VM5ed5
	 w6/t1x8p8azKWFan0nJbWZ6qY4yb3Y7r78kl4hwWTBQAlwXaLJHYM1LHzcWTWoBhBY
	 RX/G/pOm/dA8cxSQ44okjBrZNHDWgZVWdP9TzmuT7S0kEwSe9QDJfv2lyNJaoBv2F0
	 aSlHBCJG1zsrg==
Date: Mon, 11 Aug 2025 16:52:51 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io, victor@mojatatu.com
Subject: Re: [PATCH net v4 1/2] net/sched: Fix backlog accounting in qdisc_dequeue_internal
Message-ID: <-8f3jdd-5pxHr0GW-uu8VtTzqDKDOyJohJ-soIwzRyqJUub186VYIxqNoGOTh8Oxtu1U0CEDl5h3N1c1D1jbn7nIlXUrNo55CHK5KcT23c4=@willsroot.io>
In-Reply-To: <20250811082958.489df3fa@kernel.org>
References: <20250727235602.216450-1-will@willsroot.io> <20250808142746.6b76eae1@kernel.org> <n-GjVW0_1R1-ujkLgZIEgnaQKSsNtQ9-7UZiTmDCJsy1EutoUtiGOSahNSxpz2yANsp5olbxItT2X9apTC9btIRepMGAZZVBqWx6ueYE5O4=@willsroot.io> <20250811082958.489df3fa@kernel.org>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 3facedebffe56d11f53a89d3a8cf097286c279f2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, August 11th, 2025 at 3:30 PM, Jakub Kicinski <kuba@kernel.org> w=
rote:

>=20
>=20
> On Sun, 10 Aug 2025 21:06:57 +0000 William Liu wrote:
>=20
> > > On Sun, 27 Jul 2025 23:56:32 +0000 William Liu wrote:
> > >=20
> > > > Special care is taken for fq_codel_dequeue to account for the
> > > > qdisc_tree_reduce_backlog call in its dequeue handler. The
> > > > cstats reset is moved from the end to the beginning of
> > > > fq_codel_dequeue, so the change handler can use cstats for
> > > > proper backlog reduction accounting purposes. The drop_len and
> > > > drop_count fields are not used elsewhere so this reordering in
> > > > fq_codel_dequeue is ok.
> > >=20
> > > Using local variables like we do in other qdiscs will not work?
> > > I think your change will break drop accounting during normal dequeue?
> >=20
> > Can you elaborate on this?
> >=20
> > I just moved the reset of two cstats fields from the dequeue handler
> > epilogue to the prologue. Those specific cstats fields are not used
> > elsewhere so they should be fine,
>=20
>=20
> That's the disconnect. AFAICT they are passed to codel_dequeue(),
> and will be used during normal dequeue, as part of normal active
> queue management under traffic..
>=20

Yes, that is the only place those values are used. From my understanding, c=
odel_dequeue is only called in fq_codel_dequeue. So moving the reset from t=
he dequeue epilogue to the dequeue prologue should be fine as the same beha=
vior is kept - the same values should always be used by codel_dequeue.

Is there a case I am not seeing? If so, I can just add additional fields to=
 the fq_codel_sched_data, but wanted to avoid doing that for this one edge =
case.

> > but we need to accumulate their
> > values during limit adjustment. Otherwise the limit adjustment loop
> > could perform erroneous accounting in the final
> > qdisc_tree_reduce_backlog because the dequeue path could have already
> > triggered qdisc_tree_reduce_backlog calls.
> >=20
> > > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > > index 902ff5470607..986e71e3362c 100644
> > > > --- a/net/sched/sch_fq.c
> > > > +++ b/net/sched/sch_fq.c
> > > > @@ -1014,10 +1014,10 @@ static int fq_change(struct Qdisc *sch, str=
uct nlattr *opt,
> > > > struct netlink_ext_ack *extack)
> > > > {
> > > > struct fq_sched_data *q =3D qdisc_priv(sch);
> > > > + unsigned int prev_qlen, prev_backlog;
> > > > struct nlattr *tb[TCA_FQ_MAX + 1];
> > > > - int err, drop_count =3D 0;
> > > > - unsigned drop_len =3D 0;
> > > > u32 fq_log;
> > > > + int err;
> > > >=20
> > > > err =3D nla_parse_nested_deprecated(tb, TCA_FQ_MAX, opt, fq_policy,
> > > > NULL);
> > > > @@ -1135,16 +1135,16 @@ static int fq_change(struct Qdisc *sch, str=
uct nlattr *opt,
> > > > err =3D fq_resize(sch, fq_log);
> > > > sch_tree_lock(sch);
> > > > }
> > > > +
> > > > + prev_qlen =3D sch->q.qlen;
> > > > + prev_backlog =3D sch->qstats.backlog;
> > > > while (sch->q.qlen > sch->limit) {
> > > > struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
> > > >=20
> > > > - if (!skb)
> > > > - break;
> > >=20
> > > The break conditions is removed to align the code across the qdiscs?
> >=20
> > That break is no longer needed because qdisc_internal_dequeue handles
> > all the length and backlog size adjustments. The check existed there
> > because of the qdisc_pkt_len call.
>=20
>=20
> Ack, tho, theoretically the break also prevents an infinite loop.
> Change is fine, but worth calling this out in the commit message,
> I reckon.
>=20
> > > > - drop_len +=3D qdisc_pkt_len(skb);
> > > > rtnl_kfree_skbs(skb, skb);
> > > > - drop_count++;
> > > > }
> > > > - qdisc_tree_reduce_backlog(sch, drop_count, drop_len);
> > > > + qdisc_tree_reduce_backlog(sch, prev_qlen - sch->q.qlen,
> > > > + prev_backlog - sch->qstats.backlog);
> > >=20
> > > There is no real change in the math here, right?
> > > Again, you're just changing this to align across the qdiscs?
> >=20
> > Yep, asides from using a properly updated qlen and backlog from the
> > revamped qdisc_dequeue_internal.
>=20
>=20
> Personal preference, but my choice would be to follow the FQ code,
> and count the skbs as they are freed. But up to you, since we hold
> the lock supposedly the changes to backlog can only be due to our
> purging.

