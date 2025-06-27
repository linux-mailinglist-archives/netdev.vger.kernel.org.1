Return-Path: <netdev+bounces-201765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B23AEAEEA
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A151C22400
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4354B1FFC48;
	Fri, 27 Jun 2025 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="Hkh3KnRQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1741FCD1F
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751005066; cv=none; b=nct9cL6svReaUXAhuAE1TQnq6Su5roSn6IpTvjE2z7EKt0+H33ebPF6VBpJQYZXD1ZyZgmnHkE8aLBm0ouD4uPgr8LG8JiDz/1BVI6iG3ofqXXQ1IGTqlHX/4Tubvm34yJY5l4lLB6tVt7ZYmyPU+C7ZjYf8yE4qP4yyunD1Tew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751005066; c=relaxed/simple;
	bh=2IAr9VFxEDplXPJkuL6MqwWXBLY2M/UA0OG5AAIy/TQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IQGvOxmzPxG7H0EfvJu8p5NS+YF8l5D646QRKnkgUcz9b/7i6b5oiVapJ6TnhprfcuLZFoGKtwZY+F9jqvSuZy+hA/rblcbjPhmgGeyBh7uYz8tgIGVPFOu8cGx5qoh4lmidILQ8jryyuGZ23yCKf0R0D5o/eJhIX9fgo5d6qcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=Hkh3KnRQ; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1751005055; x=1751264255;
	bh=JXVAW4r9PukxZDVZYQHceF9Zif1gpBN2BGnuxxPcWB4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Hkh3KnRQ0TwCwjUz8cAMdNwGxshQgLtHhtZcqNiFuL1e8ExLtXy+DUs0A848hdhNE
	 mTTyXZ+UKQzqQeCg5FX/T3qxuMlVoz4V3IJ3mo1yFv65UZ5WaI/fgjyhlmHrmQPb9m
	 utNvuTW5oJqYgxywbSZfBvMh6rs15cmPv+72m1uVjL3CobrQZ6dofXmHZoNVL3afbw
	 DNbrEwqkPoNDzZ5kEMiz38WcH5HlaWpOYAk7N5aaDyhDmmXCGkKScz8FHROLyDpfkB
	 5gy/W4u7QgFJGZYkGFpg8xoh2VkPBJeeduyw6ogyj+A3U70c/RZlMeDd5xxSTMTeJ+
	 xVi5eVFJZuyRQ==
Date: Fri, 27 Jun 2025 06:17:31 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH net v4 1/2] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
Message-ID: <20250627061600.56522-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: eceddb4eb6469820356c53edaab3a9ad975ac661
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



