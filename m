Return-Path: <netdev+bounces-200500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D998AAE5B83
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 06:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F373175A94
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 04:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8103D221FC3;
	Tue, 24 Jun 2025 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="cbKse9KR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE621B9F6
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750739318; cv=none; b=rJ79F6mQwYrMKQGWDUChZiupaPiNXXMVrA4n/5Kf0l2FwzHUbsN5BvUquzYyHBdgKrazQtjE8RsDlpKTrpUOGno+T7o01NuYw9zmh9MhfRKJKQcx1Sn7YP0NeGwShZvlsiSRkTjNufhOxUtIdxk9Xi6eIPJK7Y10l5SNuMmncx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750739318; c=relaxed/simple;
	bh=IlU99b3rfcvTnx4UQ5L5rm2BxWglSb+n/aBCphotbs8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdWRoYFJbg/FCc9eNbPKAQ4enKWZX5Q3TtlwyrSaYf5oYWeRRnsT73Z2NVAkEy6qEp8EM/lzL+JDd6jfYC7GTHI3+74HO2zt5RLu98BB3JTscnoltfRp02vipBES7+dkgepUP2vl11hC2g0wpKewnE54zV0YfYtvIjPlbFk7qoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=cbKse9KR; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1750739314; x=1750998514;
	bh=IlU99b3rfcvTnx4UQ5L5rm2BxWglSb+n/aBCphotbs8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cbKse9KRwf2vIpZcv/4NL0s6jZ8uvM6xEj6ChJdl3yylpqy0TxKbXKcSe1hOMomxe
	 7/HD5M+ALXh/hJTaA2fNpZPtSIb9ei21BxquHxOZquFOiJ0alRo5KpJtTOWbjgKbgz
	 XztbvsX73q84qgebYTfQyoI2y8GullzZjh28aBDhZbjHymMjAT7vIDvejvCLjqfgU+
	 bI9ei+kcqa8VN7CXR3LBHv8bFjVjaoMeVaVT1HejRd7iXH439Si2j4F8OrLGWOC7QE
	 8gMqyPvkiDkkuEhV2sFg45s9p19ZE7CoP5nXPljC5jZA23N7zwOoNBISKN5p/dy48t
	 0lIhcqm/+x+EA==
Date: Tue, 24 Jun 2025 04:28:31 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net 1/2] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
Message-ID: <zs0zNqlNRnnijrll33yl0m4VGbDv-dTgQecTErwr97GnuwynGtuLRmz5tG63EnH41B3tmZrYOTs7FSgVbYBusapPk7CkmHOLKoBST_ITufg=@willsroot.io>
In-Reply-To: <CAM0EoMmbcudme6=ogcUdQ1qt9MThChqy=37Ck1vhnw-4VuKmNw@mail.gmail.com>
References: <20250622190344.446090-1-will@willsroot.io> <CAM0EoMmbcudme6=ogcUdQ1qt9MThChqy=37Ck1vhnw-4VuKmNw@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 7c8f22a328166e2778d8abe527b230542de9c1c2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, June 23rd, 2025 at 2:33 PM, Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:

>=20
>=20
> BTW, you did fail to test tdc like i asked you to do. It was a trap
> question - if you did run it you would have caught the issue Jakub
> just pointed out. Maybe i shouldnt have been so coy/evil..
> Please run tdc fully..
>=20

tdc has been fully run for v2 - I was under the assumption that only the ne=
tem category mattered. Is there any reason tc-tests/qdiscs/teql.json does n=
ot run under a new namepsace?

> On Sun, Jun 22, 2025 at 3:05=E2=80=AFPM William Liu will@willsroot.io wro=
te:
>=20
> > netem_enqueue's duplication prevention logic breaks when a netem
> > resides in a qdisc tree with other netems - this can lead to a
> > soft lockup and OOM loop in netem_dequeue as seen in [1].
> > Ensure that a duplicating netem cannot exist in a tree with other
> > netems.
> >=20
> > [1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1i=
lxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@=
willsroot.io/
> >=20
> > Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> > Reported-by: William Liu will@willsroot.io
> > Reported-by: Savino Dicanosa savy@syst3mfailure.io
> > Signed-off-by: William Liu will@willsroot.io
> > Signed-off-by: Savino Dicanosa savy@syst3mfailure.io
> > ---
> > net/sched/sch_netem.c | 45 +++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 45 insertions(+)
> >=20
> > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > index fdd79d3ccd8c..308ce6629d7e 100644
> > --- a/net/sched/sch_netem.c
> > +++ b/net/sched/sch_netem.c
> > @@ -973,6 +973,46 @@ static int parse_attr(struct nlattr *tb[], int max=
type, struct nlattr *nla,
> > return 0;
> > }
> >=20
> > +static const struct Qdisc_class_ops netem_class_ops;
> > +
> > +static inline bool has_duplication(struct Qdisc *sch)
> > +{
> > + struct netem_sched_data *q =3D qdisc_priv(sch);
> > +
> > + return q->duplicate !=3D 0;
>=20
>=20
> return q->duplicate not good enough?
>=20
> > +}
> > +
> > +static int check_netem_in_tree(struct Qdisc *sch, bool only_duplicatin=
g,
> > + struct netlink_ext_ack *extack)
> > +{
> > + struct Qdisc *root, *q;
> > + unsigned int i;
> > +
>=20
>=20
> "only_duplicating" is very confusing. Why not "duplicates"?
>=20
> > + root =3D qdisc_root_sleeping(sch);
> > +
> > + if (sch !=3D root && root->ops->cl_ops =3D=3D &netem_class_ops) {
> > + if (!only_duplicating || has_duplication(root))
> > + goto err;
> > + }
> > +
> > + if (!qdisc_dev(root))
> > + return 0;
> > +
> > + hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
> > + if (sch !=3D q && q->ops->cl_ops =3D=3D &netem_class_ops) {
> > + if (!only_duplicating || has_duplication(q))
>=20
>=20
> if (duplicates || has_duplication)
>=20
> > + goto err;
> > + }
> > + }
> > +
> > + return 0;
> > +
> > +err:
> > + NL_SET_ERR_MSG(extack,
> > + "netem: cannot mix duplicating netems with other netems in tree");
> > + return -EINVAL;
> > +}
> > +
> > /* Parse netlink message to set options */
> > static int netem_change(struct Qdisc *sch, struct nlattr *opt,
> > struct netlink_ext_ack *extack)
> > @@ -1031,6 +1071,11 @@ static int netem_change(struct Qdisc *sch, struc=
t nlattr *opt,
> > q->gap =3D qopt->gap;
> > q->counter =3D 0;
> > q->loss =3D qopt->loss;
> > +
> > + ret =3D check_netem_in_tree(sch, qopt->duplicate =3D=3D 0, extack);
>=20
>=20
> check_netem_in_tree(sch, qopt->duplicate, extack) ?
>=20
>=20
>=20
> cheers,
> jamal
>=20
> > + if (ret)
> > + goto unlock;
> > +
> > q->duplicate =3D qopt->duplicate;
> >=20
> > /* for compatibility with earlier versions.
> > --
> > 2.43.0

Ok, thank you to everyone for the helpful feedback. I have addressed everyt=
hing and just posted v2.

