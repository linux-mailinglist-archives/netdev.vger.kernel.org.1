Return-Path: <netdev+bounces-205087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFBDAFD26F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78053189A262
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5FD2E5414;
	Tue,  8 Jul 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="eI2CZS/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B0215F5C
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993018; cv=none; b=pAelePTz1cTL9XoiE7VFJPG0nZxpbFdqYZf4O3WKO3KzihKVlhZ1KryHqiBMLj+mt6MjDrk+Orfh/Kre4ollQZLCm3MyHByv2VSV2ckCAhnmgB5vC1spP+kPYgPVa+GvnaNZ4lEO52hsUZ1zpuaB7skQrtWmAPBZBIIgkMD9btg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993018; c=relaxed/simple;
	bh=n3IP9ZU9VK2W01DW+wdUCJO1NgFlXHm3ttZn3m5+r0k=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mYYUvye1bHL6+GPI96J9wq/GMYT7Ds0lNAGiclRDMlgyln6sU9D6kCDsWJZvknW60QADQXKcfGT2Mm4FQ59ZRUxZYAC7xIsZhptSW0WkQuEwe1EmnjrKhrdICifKsunSqR2FrS2y90ovu01eLnKt24nQeNeip023X1nU8NW6Ba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=eI2CZS/Y; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1751993012; x=1752252212;
	bh=3jSCw/CDwOXTmStLmsLOkLE793lTNMgwNdrFXEOOu4E=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eI2CZS/YguQPjZSI6D8ToEJfjLqnkKxJSdskjV6pwf8iJ8NwHZRZPqLr/tnzWOyQZ
	 JN7mqQKhf/B8/U0DG3JTjs6m9+ipr9pw2+TLY4ft8vJAFlpj9B1+OjfIsaKR2SuUpF
	 01eVenN0NWeYG3DrbgaspKXSzmR6Dk4D4pSkcCJtTeDOAileTLwXWayfDnluvgzDcm
	 m8LrkO4nhEUIpKlkrjpuxZZXqRtNFCKJZxgPgshCtt3OhPDZ24NbFuGNjOKmGd51ZU
	 /Lvy8upSOlQf0zOyQH1LW/VHNBwuN7VyDzIdV0CWiMs1ADd3cgcasRlDZtAlesQi+5
	 5liccNjsRXqnQ==
Date: Tue, 08 Jul 2025 16:43:26 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH net v5 1/2] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
Message-ID: <20250708164141.875402-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: acfcf2bf1e2ca0907b67a6f3e88f0346c00687e3
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
soft lockup and OOM loop in netem_dequeue, as seen in [1].
Ensure that a duplicating netem cannot exist in a tree with other
netems.

Previous approaches suggested in discussions in chronological order:

1) Track duplication status or ttl in the sk_buff struct. Considered
too specific a use case to extend such a struct, though this would
be a resilient fix and address other previous and potential future
DOS bugs like the one described in loopy fun [2].

2) Restrict netem_enqueue recursion depth like in act_mirred with a
per cpu variable. However, netem_dequeue can call enqueue on its
child, and the depth restriction could be bypassed if the child is a
netem.

3) Use the same approach as in 2, but add metadata in netem_skb_cb
to handle the netem_dequeue case and track a packet's involvement
in duplication. This is an overly complex approach, and Jamal
notes that the skb cb can be overwritten to circumvent this
safeguard.

4) Prevent the addition of a netem to a qdisc tree if its ancestral
path contains a netem. However, filters and actions can cause a
packet to change paths when re-enqueued to the root from netem
duplication, leading us to the current solution: prevent a
duplicating netem from inhabiting the same tree as other netems.

[1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsE=
BNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@will=
sroot.io/
[2] https://lwn.net/Articles/719297/

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Signed-off-by: William Liu <will@willsroot.io>
Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
---
v4 -> v5: no changes, reposting per Jakub's request
v3 -> v4:
  - Clarify changelog with chronological order of attempted solutions
v2 -> v3:
  - Clarify reasoning for approach in changelog
  - Removed has_duplication
v1 -> v2:
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



