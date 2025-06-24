Return-Path: <netdev+bounces-200497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 349D5AE5B7B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 06:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDE917C1AF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 04:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59261DB148;
	Tue, 24 Jun 2025 04:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="MbmBdURC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE4224FD
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 04:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750739066; cv=none; b=oPlNCJN+BamN2tVdyFQRuGkd4SGn5gNeoRdVePuocwTysc8bqelgaYz6oPJm54JHVY48HDdTX4pI3IVqVjMh7RDm7hBTJlkokkE7njtkvEtU9JsTbBTPMg2z/S3jAgG0eDSs2a6g8J0Sooo9gnZErc4d7KxMEODzqKj9TgwrFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750739066; c=relaxed/simple;
	bh=52p5c8SzvZu0VY8k5YM1r9NOHkkEu8PHSspzWaYlX0w=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DORmU9MF7rTeTphJezG7VVwSWaAC+r2a61fww1IRp9m05472WoxPlhCoMLKhyjxHfGANp8ukgyAEv9KdOu3Y6Kxc/aVyjZ+/LjUbooHCdV9kvrUZy/N2+X+CfNFntM67h1mVOEpnfpO5j1igI2VAcPX+HLo4YV0zuOJiufj9J3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=MbmBdURC; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1750739060; x=1750998260;
	bh=YKgPQHqBJ+3hhak+NRtpEOe6Idgu89kBqDAhXG5laQo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MbmBdURCQ64IYr8VMaPcBUf76RTF4trtp3GgasW0pcPMuE//rbU6d4cqU5UUj+BFy
	 pVe2bukRJF5v7C7ffrFHhVN1mXylxwb4apMEOG3CllMWiq8NaIMBig7pApre0l8/09
	 YbeycIpN4kIDK+IkC9USB+J+w8QafecU9OvrAgoWF1oQlOaenyh4NkXJov54tWNQNN
	 I45xI+iHcn8pEPZO2z4AbVcKRuSFZndZ8UExXuvgJ5coB7RudJIuECRXNVK7dRCkAM
	 FaTSG9hrgfGlB6CT6H/JA/tgTb1E+MvGZQeFnrDEA1T83Q5tnYWvOO6rQMEwAhHm6S
	 7f9R30lCAmnNQ==
Date: Tue, 24 Jun 2025 04:24:14 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH net v2 1/2] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
Message-ID: <20250624042238.521211-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: d910e71601c1dffbca131668656120db0c72ba4d
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
Ensure that a duplicating netem cannot exist in a tree with other
netems.

[1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsE=
BNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@will=
sroot.io/

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Signed-off-by: William Liu <will@willsroot.io>
Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
---
 net/sched/sch_netem.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..be38458ae5bc 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -973,6 +973,46 @@ static int parse_attr(struct nlattr *tb[], int maxtype=
, struct nlattr *nla,
 =09return 0;
 }
=20
+static const struct Qdisc_class_ops netem_class_ops;
+
+static inline bool has_duplication(struct Qdisc *sch)
+{
+=09struct netem_sched_data *q =3D qdisc_priv(sch);
+
+=09return q->duplicate;
+}
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
+=09=09if (duplicates || has_duplication(root))
+=09=09=09goto err;
+=09}
+
+=09if (!qdisc_dev(root))
+=09=09return 0;
+
+=09hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
+=09=09if (sch !=3D q && q->ops->cl_ops =3D=3D &netem_class_ops) {
+=09=09=09if (duplicates || has_duplication(q))
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
@@ -1031,6 +1071,11 @@ static int netem_change(struct Qdisc *sch, struct nl=
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



