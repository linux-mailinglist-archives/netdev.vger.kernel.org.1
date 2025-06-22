Return-Path: <netdev+bounces-200093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4C2AE319E
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 21:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F41188EF5E
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 19:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2E31E521F;
	Sun, 22 Jun 2025 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="vET48C4+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97318B47D
	for <netdev@vger.kernel.org>; Sun, 22 Jun 2025 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750619237; cv=none; b=Tgxt3j9TMREEMFsnLs0wldinY/DIBnxs6/dA1bu5EuszGQmqcHTAXt9p1LY57SjrpMYu1YfKLCLuwiU5QlcC+OsX0avYheB03jrrHfBFm8a6MvQeEFgX0Yl+j6gmD03rX8IjngalfNieyKBhMAR470KuWcntQE2DB3y9JbHNzEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750619237; c=relaxed/simple;
	bh=KxYY9S49JU/7W7z4KNAm1Enkbceslw1n0P1TnAfA6Gk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCwdeKaPR8D+gwNacisHroeD8fuI2yO+GI0q2V+2QLqYTxzicsh/ug54R9SX0SEJYFlJG8X8ITErsXjOyBCyXVacUjsg036dP7AmASGpgVIZSGQjbYz+tT9nnPCrR5lm2ziBiIHgkJ1sflekBjSZCnDA8hbBkUjvFbJw08Vp3uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=vET48C4+; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1750619233; x=1750878433;
	bh=KxYY9S49JU/7W7z4KNAm1Enkbceslw1n0P1TnAfA6Gk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vET48C4+CeDntBYmgkEViS8wOGQxEXgak1ASV4XJ1PKEQqP31PEMCvEklJO6s9sLN
	 9tk5b2svDSMJRyOvRn6hO7oshlLWtjjDi0E11ZKN8WTcBY/Lu4lKChU9XgLaimbw1t
	 3NT9GwuxfjNFLLJpMZzL4ZSzLI41IftlczxAbXUmJiYpvU4CZGxqMlE2WCTr6pBKmL
	 TiEFQpFgS242r22heZvU2HOV5ZnvpaXpa9BYvL8t/AOrymKNk1PzPAI66wwnA6Ee7n
	 9kYLpndwj3yPtYqAUhLlTrUpTmsMf2Fbq5+/0Fgr1cP34TtaX0AUAjktpZhsU4Yem3
	 itqSgyyS9ShHQ==
Date: Sun, 22 Jun 2025 19:07:08 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: Savy <savy@syst3mfailure.io>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <rhMSKBdXYU8v_FEGP-8wFe389u5UAvzg6jXom3wt65CKCFfmH-uxzxo68cdcTojE1xMnp0jJ-6erf9Ge9nCkfh1eo7hqcHQOFdGoTQfZ9KA=@willsroot.io>
In-Reply-To: <CAM0EoMmC9nuzEB0ydb5VZh8NRZQcfZ=TmFxQ82CLg1S2Ew8ZWw@mail.gmail.com>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <A2nutOWbLBIdLRrnsUdavOagBEebp4YBFx0DdL23njEFVAySZul2pDRK1xf76_g6dLb82YXCRb1Ry9btDkZqeY9Btib0KgViSIIfsi4BDfU=@willsroot.io> <CAM0EoMmhP_9UsF18M=6B6AbY_am8cEnaqggpnVb9fkmBB4vjtA@mail.gmail.com> <dF67hR5ZcMlQZMtkrUEol_zkunpoJipfdVXveT5z-3_g57e5T6TQZRYlluKWzRoNiW4dCl603wlnnYR8eE-alv6UwTf-F8o5GzHWuDsypj0=@willsroot.io> <CAM0EoMnd0nZxJW3zpEuBGWTwB3AnJSnj242f9hMpcLdBWdcbfQ@mail.gmail.com> <yA-qROHJ2pCMLiRG8Au4YMe_V2R27OhaXkkjkImGzbhdlyHUs5nCkbbJYGkNLM4Rt5812LGXHathpDmqSYTGv1D4YF-zeJdWbCnNIAezEdg=@willsroot.io> <CAM0EoM=QxAJS4ZK68mup55O7wQFqkQds-p2Us3R0U-W6FK6krw@mail.gmail.com> <KqiixybBnBLRGzU7hRxP5bpji1w9tvkkNJVawNPK04HV4Sq66HwoXkfvY-zUb-igUkh0WT0BdfbBmjpkA0H-tES79qTMRM9OuFH5HUsYwJs=@willsroot.io> <CAM0EoMmC9nuzEB0ydb5VZh8NRZQcfZ=TmFxQ82CLg1S2Ew8ZWw@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: f479f40d3e127c6e7b40e0beb6b48995b49f50e6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, June 18th, 2025 at 8:10 PM, Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:

>=20
>=20
> On Mon, Jun 16, 2025 at 5:13=E2=80=AFPM William Liu will@willsroot.io wro=
te:
>=20
> > On Monday, June 16th, 2025 at 8:41 PM, Jamal Hadi Salim jhs@mojatatu.co=
m wrote:
> >=20
> > > On Thu, Jun 12, 2025 at 11:34=E2=80=AFPM William Liu will@willsroot.i=
o wrote:
> > >=20
> > > > On Thursday, June 12th, 2025 at 10:08 PM, Jamal Hadi Salim jhs@moja=
tatu.com wrote:
> > > >=20
> > > > > Hi William,
> > > > > Apologies again for the latency.
> > > > >=20
> > > > > On Mon, Jun 9, 2025 at 11:31=E2=80=AFAM William Liu will@willsroo=
t.io wrote:
> > > > >=20
> > > > > > On Monday, June 9th, 2025 at 12:27 PM, Jamal Hadi Salim jhs@moj=
atatu.com wrote:
> > > > >=20
> > > > > > > I didnt finish my thought on that: I meant just dont allow a =
second
> > > > > > > netem to be added to a specific tree if one already exists. D=
ont
> > > > > > > bother checking for duplication.
> > > > > > >=20
> > > > > > > cheers,
> > > > > > > jamal
> > > > > > >=20
> > > > > > > > > [1] see "loopy fun" in https://lwn.net/Articles/719297/
> > > > > >=20
> > > > > > Hi Jamal,
> > > > > >=20
> > > > > > I came up with the following fix last night to disallow adding =
a netem qdisc if one of its ancestral qdiscs is a netem. It's just a draft =
-I will clean it up, move qdisc_match_from_root to sch_generic, add test ca=
ses, and submit a formal patchset for review if it looks good to you. Pleas=
e let us know if you catch any edge cases or correctness issues we might be=
 missing.
> > > > >=20
> > > > > It is a reasonable approach for fixing the obvious case you are
> > > > > facing. But I am still concerned.
> > > > > Potentially if you had another netem on a different branch of the=
 tree
> > > > > it may still be problematic.
> > > > > Consider a prio qdisc with 3 bands each with a netem child with d=
uplication on.
> > > > > Your solution will solve it for each branch if one tries to add a
> > > > > netem child to any of these netems.
> > > > >=20
> > > > > But consider you have a filter on the root qdisc or some intermed=
iate
> > > > > qdisc and an associated action that changes skb->prio; when it hi=
ts
> > > > >=20
> > > > > netem and gets duplicated then when it goes back to the root it m=
ay be
> > > > > classified by prio to a different netem which will duplicate and =
on
> > > > > and on..
> > > > > BTW: I gave the example of skb->prio but this could be skb->mark.
> > > >=20
> > > > Ah, good catch. I attached the modified patch below then.
> > > >=20
> > > > > Perhaps we should only allow one netem per tree or allow more but
> > > > > check for duplication and only allow one per tree...
> > > >=20
> > > > I believe we have to keep it at one netem per tree. The OOM loop ca=
n still trigger if a netem without duplication has a netem child with dupli=
cation. Consider the following setup:
> > > >=20
> > > > tc qdisc add dev lo root handle 1: netem limit 1
> > > > tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplica=
te 100% delay 1us reorder 100%
> > >=20
> > > I didnt explain it clearly - I meant if you have a netem that has
> > > duplication then dont allow another netem within the tree. Your patch
> > > is in the right direction but does not check for duplication.
> > >=20
> > > > The first netem will store everything in the tfifo queue on netem_e=
nqueue. Since netem_dequeue calls enqueue on the child, and the child will =
duplicate every packet back to the root, the first netem's netem_dequeue wi=
ll never exit the tfifo_loop.
> > > >=20
> > > > Best,
> > > > William
> > > >=20
> > > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > > index fdd79d3ccd8c..4db5df202403 100644
> > > > --- a/net/sched/sch_netem.c
> > > > +++ b/net/sched/sch_netem.c
> > > > @@ -1085,6 +1085,36 @@ static int netem_change(struct Qdisc *sch, s=
truct nlattr *opt,
> > > > return ret;
> > > > }
> > > >=20
> > > > +static const struct Qdisc_class_ops netem_class_ops;
> > > > +
> > > > +static bool has_netem_in_tree(struct Qdisc *sch) {
> > > > + struct Qdisc *root, *q;
> > > > + unsigned int i;
> > > > + bool ret =3D false;
> > > > +
> > > > + sch_tree_lock(sch);
> > > > + root =3D qdisc_root_sleeping(sch);
> > >=20
> > > Hrm. starting with qdisc_root_sleeping() seems quarky. Take a look at
> > > dump() - and dig into something (off top of my head) like
> > > hash_for_each(qdisc_dev(root)->qdisc_hash, b, q, hash)
> >=20
> > What is the issue here? My understanding is that the hashmap does not h=
old the root - sch_api.c shows edge cases for the root node when adding and=
 deleting from the hashmap).
>=20
>=20
> True. Ok, so no objection to using qdisc_root_sleeping() - I was
> initially comparing it to what you would need to do in dump().
> So more below in that relation (take a look at dump):
>=20
> +static const struct Qdisc_class_ops netem_class_ops;
> +
> +static bool has_netem_in_tree(struct Qdisc *sch) {
> + struct Qdisc *root, *q;
> + unsigned int i;
> + bool ret =3D false;
> +
> + sch_tree_lock(sch);
>=20
> You are already have rtnl being held by this point. No need to hold this =
lock.
>=20
> + root =3D qdisc_root_sleeping(sch);
> +
> + if (root->ops->cl_ops =3D=3D &netem_class_ops) {
>=20
> + ret =3D true;
> + goto unlock;
> + }
> +
>=20
>=20
> You dont need rcu here - again look at dump() hash_for_each() is the
> correct thing to do.
>=20
> + hash_for_each_rcu(qdisc_dev(root)->qdisc_hash, i, q, hash) {
>=20
> + if (q->ops->cl_ops =3D=3D &netem_class_ops) {
>=20
> + ret =3D true;
> + goto unlock;
> + }
> + }
> +
>=20
> And therefore unlock etc becomes unnecessary.
>=20
> cheers,
> jamal
>=20
> +unlock:
> + if (ret)
> + pr_warn("Cannot have multiple netems in tree\n");
> +
> + sch_tree_unlock(sch);
> + return ret;
> +}
>=20
> > > > +
> > > > + if (root->ops->cl_ops =3D=3D &netem_class_ops) {
> > > > + ret =3D true;
> > > > + goto unlock;
> > > > + }
> > > > +
> > > > + hash_for_each_rcu(qdisc_dev(root)->qdisc_hash, i, q, hash) {
> > > > + if (q->ops->cl_ops =3D=3D &netem_class_ops) {
> > > > + ret =3D true;
> > > > + goto unlock;
> > > > + }
> > > > + }
> > > > +
> > > > +unlock:
> > > > + if (ret)
> > > > + pr_warn("Cannot have multiple netems in tree\n");
> > >=20
> > > No point to the pr_warn()
> > >=20
> > > > +
> > > > + sch_tree_unlock(sch);
> > > > + return ret;
> > > > +}
> > > > +
> > > > static int netem_init(struct Qdisc *sch, struct nlattr *opt,
> > > > struct netlink_ext_ack *extack)
> > > > {
> > > > @@ -1093,6 +1123,9 @@ static int netem_init(struct Qdisc *sch, stru=
ct nlattr *opt,
> > > >=20
> > > > qdisc_watchdog_init(&q->watchdog, sch);
> > > >=20
> > > > + if (has_netem_in_tree(sch))
> > > > + return -EINVAL;
> > >=20
> > > set ext_ack to contain the string you had earlier ("Cannot have
> > > multiple netems in tree") and user space will be able to see it.
> > >=20
> > > It will be easy to check the existing qdisc for netem_sched_data->dup=
licate
> > >=20
> > > Also, please dont forget to run tdc tests and contribute one or more
> > > testcase that captures the essence of what you are pushing here.

Ok, I addressed those issues and just submitted a formal patchset. Thank yo=
u for all the help so far!

Best,
William

