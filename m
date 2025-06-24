Return-Path: <netdev+bounces-200509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4462AE5C34
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 491547AE6AB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 05:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690DC2343CF;
	Tue, 24 Jun 2025 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="dx9cfxD8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B122258C
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744639; cv=none; b=ivkrmplkB4+M7OIvs3IvsN8ZxP9LfrCB7BMEqgt6xbnyGMO8Xf72B81uhVe9urYxt32tClGWoVhOY+4UkBIMPUXrt8DSYLUOTkb39RTa5IkuU4zFq3AOqlWSbkA7I53r97369gmkjZSB1JfQ6YvQShr73rgkE8m0k2L9N2aVacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744639; c=relaxed/simple;
	bh=wQG+BVB6ZgI6Ot0dD8XPqPZiabmg0QZ1hAsjbCd20pE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n/tiwQYVS++KG7HzJbBHrs4nwwbm/srRlBZcN0sbUnpBVHlitutNEkuqHvKBw8ZM+XVO003S2vgLc6UikzG11+GuVaR79jO5niE7ZObrQU/+4900en+5ugUAVCjuRMJbqWKJfRVxl/35Ir4v5x4JwbjvQRiVhJcjOVT32cEi85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=dx9cfxD8; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1750744634; x=1751003834;
	bh=gW2CsLqCBaEtsZqEZGI916Pc8CduI5n2a6IEbCF9HDI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dx9cfxD8kWpgyi/fBenrXtrqJZPlywfYCr996a3gOuf8qowYLA7438ifDJ3sjrk+t
	 +UnP0EkLWGGWxR3RkhJkKsqBDcwC9yVphsNCWddn7qUQZZZyyRe3a+GVcLfFAJ0M4F
	 4QxbxOL7/VR5SmPhv3O2TY5SbVr3lvl25zF2Lepuysy7VW6nQ30UXcohqDyzRhfDue
	 pneinuVmAR4SQXvOY4Gufh0t811G3QacczNfC+7jigaz3/1Lfy3PNCZWukzuPVx4/z
	 Pr9kO3s1w0/CwS0jAUq7QXd4sClUjzPgmZHiVaYL6btooY8pqDyh6jkT3UT3xzaGzN
	 2zWNmDPhqdBgQ==
Date: Tue, 24 Jun 2025 05:57:07 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH net v3 1/2] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
Message-ID: <20250624055537.531731-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 2f2e302ab17dd7f229850b7ee9cc20b8a961360a
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

netem_enqueue's duplication prevention logic breaks when a netem
resides in a qdisc tree with other netems - this can lead to a
soft lockup and OOM loop in netem_dequeue as seen in [1].
Since we do not want to add bits to sk_buff for tracking
duplication metadata for this one specific case, we have to ensure
that a duplicating netem cannot exist in a tree with other netems.
Technically, this check is only required on the ancestral path,
but filters and actions can change a packet's path in the
qdisc tree and require us to apply the restriction over the tree.

[1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsE=
BNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@will=
sroot.io/

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Signed-off-by: William Liu <will@willsroot.io>
Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
---
v2 -> v3:
  - Clarify reasoning for approach in changelog
  - Removed has_duplication
v1 -> v2: https://lore.kernel.org/all/20250622190344.446090-1-will@willsroo=
t.io/
  - Renamed only_duplicating to duplicates and invert logic for clarity
---
 net/sched/sch_netem.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..eafc316ae319 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -973,6 +973,41 @@ static int parse_attr(struct nlattr *tb[], int maxtype=
, struct nlattr *nla,
 =09return 0;
 }
=20
+static const struct Qdisc_class_ops netem_class_ops;
+
+static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
+=09=09=09       struct netlink_ext_ack *extack)
+{
+=09struct Qdisc *root, *q;
+=09unsigned int i;
+
+=09root =3D qdisc_root_sleeping(sch);
+
+=09if (sch !=3D root && root->ops->cl_ops =3D=3D &netem_class_ops) {
+=09=09if (duplicates ||
+=09=09    ((struct netem_sched_data *)qdisc_priv(root))->duplicate)
+=09=09=09goto err;
+=09}
+
+=09if (!qdisc_dev(root))
+=09=09return 0;
+
+=09hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
+=09=09if (sch !=3D q && q->ops->cl_ops =3D=3D &netem_class_ops) {
+=09=09=09if (duplicates ||
+=09=09=09    ((struct netem_sched_data *)qdisc_priv(q))->duplicate)
+=09=09=09=09goto err;
+=09=09}
+=09}
+
+=09return 0;
+
+err:
+=09NL_SET_ERR_MSG(extack,
+=09=09       "netem: cannot mix duplicating netems with other netems in tr=
ee");
+=09return -EINVAL;
+}
+
 /* Parse netlink message to set options */
 static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 =09=09=09struct netlink_ext_ack *extack)
@@ -1031,6 +1066,11 @@ static int netem_change(struct Qdisc *sch, struct nl=
attr *opt,
 =09q->gap =3D qopt->gap;
 =09q->counter =3D 0;
 =09q->loss =3D qopt->loss;
+
+=09ret =3D check_netem_in_tree(sch, qopt->duplicate, extack);
+=09if (ret)
+=09=09goto unlock;
+
 =09q->duplicate =3D qopt->duplicate;
=20
 =09/* for compatibility with earlier versions.
--=20
2.43.0



