Return-Path: <netdev+bounces-212387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D109B1FC1B
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 23:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E866E3AD907
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E8F1F237A;
	Sun, 10 Aug 2025 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="bIikNoKh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89501A76BC
	for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860034; cv=none; b=WzOcMDug0sf8r6Fp+eNLHZooVWy7VvAy4JUxk+cNT3VHWJ2gqi0gIpI0+vYKasM9nT7jG7437pXrOSHmpVroxh5YRXSb+FKX58HQZ3td58q5lDgjIQMr1gEgLJsbdKJXKK5A8F3hEFIEsilDom68O90AFIakKZKlQfolUW9bPfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860034; c=relaxed/simple;
	bh=hS+oeFgCOm6BBlq3GaBir9qH3vCdjhIaHvfbIhnfbzk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+GHF/9bTxBKAku620bzyEyhORsx6ohFmWefnWytxxFCmWCSjJG0NKC75nsXraC2FalCtVPrfYoeplLdw8o3J2AM59y4kgGzyfekw7u4Am4aD72rTWMLrqMTMuSum+p9OGJ8qEs9IPVyl4O/n6VcVo7JOyqWTHoio7E4fDkThWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=bIikNoKh; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1754860021; x=1755119221;
	bh=hS+oeFgCOm6BBlq3GaBir9qH3vCdjhIaHvfbIhnfbzk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bIikNoKh2qSLRFLRd7LrrBjrJlqsUxUh1QrEf5NGXmnyVNjOec9kBxkVPySFysrhf
	 hYsLeHolV4gsrjwzOX5zvw2ERj8abRisUMuFBTidYd88silIiuM1soRaarh83o/9hE
	 SrtiKrrkX/QV7uWJt0YbcrYLkIQ/vjkHK8wGi7EeUQgR1tAnudNMD45bICAIAOwqTb
	 9sD+rN4gk5xU98a4Ddiib2DbLYQrxXE0AA4SjNtCLqGPirrMWKNDmyucvk0j7Pzgku
	 OOXLQccIwyMyU/Wo2RAAjUVGO51bZpxCMUUSz3ukfRzMtP8G5q7FcmJm0ytChukMA2
	 s1Cit5FPOaePg==
Date: Sun, 10 Aug 2025 21:06:57 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io, victor@mojatatu.com
Subject: Re: [PATCH net v4 1/2] net/sched: Fix backlog accounting in qdisc_dequeue_internal
Message-ID: <n-GjVW0_1R1-ujkLgZIEgnaQKSsNtQ9-7UZiTmDCJsy1EutoUtiGOSahNSxpz2yANsp5olbxItT2X9apTC9btIRepMGAZZVBqWx6ueYE5O4=@willsroot.io>
In-Reply-To: <20250808142746.6b76eae1@kernel.org>
References: <20250727235602.216450-1-will@willsroot.io> <20250808142746.6b76eae1@kernel.org>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 2b88b8cfb5058f78acf9ad978513c55da13ba5fe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, August 8th, 2025 at 9:27 PM, Jakub Kicinski <kuba@kernel.org> wr=
ote:

>=20
>=20
> On Sun, 27 Jul 2025 23:56:32 +0000 William Liu wrote:
>=20
> > Special care is taken for fq_codel_dequeue to account for the
> > qdisc_tree_reduce_backlog call in its dequeue handler. The
> > cstats reset is moved from the end to the beginning of
> > fq_codel_dequeue, so the change handler can use cstats for
> > proper backlog reduction accounting purposes. The drop_len and
> > drop_count fields are not used elsewhere so this reordering in
> > fq_codel_dequeue is ok.
>=20
>=20
> Using local variables like we do in other qdiscs will not work?
> I think your change will break drop accounting during normal dequeue?

Can you elaborate on this?=20

I just moved the reset of two cstats fields from the dequeue handler epilog=
ue to the prologue. Those specific cstats fields are not used elsewhere so =
they should be fine, but we need to accumulate their values during limit ad=
justment. Otherwise the limit adjustment loop could perform erroneous accou=
nting in the final qdisc_tree_reduce_backlog because the dequeue path could=
 have already triggered qdisc_tree_reduce_backlog calls.

>=20
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index 638948be4c50..a24094a638dc 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -1038,10 +1038,15 @@ static inline struct sk_buff *qdisc_dequeue_int=
ernal(struct Qdisc *sch, bool dir
> > skb =3D __skb_dequeue(&sch->gso_skb);
> > if (skb) {
> > sch->q.qlen--;
> > + qdisc_qstats_backlog_dec(sch, skb);
> > + return skb;
> > + }
> > + if (direct) {
> > + skb =3D __qdisc_dequeue_head(&sch->q);
> > + if (skb)
> > + qdisc_qstats_backlog_dec(sch, skb);
> > return skb;
> > }
> > - if (direct)
> > - return __qdisc_dequeue_head(&sch->q);
> > else
>=20
>=20
> sorry for a late nit, it wasn't very clear from the diff but
> we end up with
>=20
> if (direct) {
> ...
> }
> else
> return ..;
>=20
> Please reformat:
>=20
> if (direct) {
> ...
> } else {
> ...
> }
>=20

Ok noted.

> > return sch->dequeue(sch);
> > }
>=20
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 902ff5470607..986e71e3362c 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -1014,10 +1014,10 @@ static int fq_change(struct Qdisc *sch, struct =
nlattr *opt,
> > struct netlink_ext_ack *extack)
> > {
> > struct fq_sched_data *q =3D qdisc_priv(sch);
> > + unsigned int prev_qlen, prev_backlog;
> > struct nlattr *tb[TCA_FQ_MAX + 1];
> > - int err, drop_count =3D 0;
> > - unsigned drop_len =3D 0;
> > u32 fq_log;
> > + int err;
> >=20
> > err =3D nla_parse_nested_deprecated(tb, TCA_FQ_MAX, opt, fq_policy,
> > NULL);
> > @@ -1135,16 +1135,16 @@ static int fq_change(struct Qdisc *sch, struct =
nlattr *opt,
> > err =3D fq_resize(sch, fq_log);
> > sch_tree_lock(sch);
> > }
> > +
> > + prev_qlen =3D sch->q.qlen;
> > + prev_backlog =3D sch->qstats.backlog;
> > while (sch->q.qlen > sch->limit) {
> > struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
> >=20
> > - if (!skb)
> > - break;
>=20
>=20
> The break conditions is removed to align the code across the qdiscs?

That break is no longer needed because qdisc_internal_dequeue handles all t=
he length and backlog size adjustments. The check existed there because of =
the qdisc_pkt_len call.

>=20
> > - drop_len +=3D qdisc_pkt_len(skb);
> > rtnl_kfree_skbs(skb, skb);
> > - drop_count++;
> > }
> > - qdisc_tree_reduce_backlog(sch, drop_count, drop_len);
> > + qdisc_tree_reduce_backlog(sch, prev_qlen - sch->q.qlen,
> > + prev_backlog - sch->qstats.backlog);
>=20
>=20
> There is no real change in the math here, right?
> Again, you're just changing this to align across the qdiscs?

Yep, asides from using a properly updated qlen and backlog from the revampe=
d qdisc_dequeue_internal.

> --
> pw-bot: cr

