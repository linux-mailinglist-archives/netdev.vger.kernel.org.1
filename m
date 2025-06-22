Return-Path: <netdev+bounces-200092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47101AE319D
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 21:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED8C163C67
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69E1D8E07;
	Sun, 22 Jun 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="Mya3tHVO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CCE18B47D
	for <netdev@vger.kernel.org>; Sun, 22 Jun 2025 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750619136; cv=none; b=IW5mxFYLiwzVrBiAaVp96JK7G/chqkcylraOFa/lOlRFHuvVrawYwxVkhkuv6hGQaoixJ4X3FnlwzwBUTU7RHCJNVVsWOeFK1YAwB4STiMr7hN6BcGkB4Re3A+WEPtCeOVSk7axvUpP7PtiIO4j/jktCnuJiZPmAGHQuPTXlYlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750619136; c=relaxed/simple;
	bh=DMMwMabRLzMBbBib8nHRoBIONufYSYt2s4ex4qAZvcc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bhpSpHcXFIqUVNwQBN3Yw9gD6J9ikWvC34ZwOy66bLhPOkCi7GZyKBX1VWOoEkLiLX1mhVX6Q+PDjHWBP9YRxGibqCfDTm4EcBC/EADHMy2N0h8Ug9xELeu/Aqx3VnNNDbS4ZadMzlH/vd422ravPlgZVH+p/9lOj/0TFielwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=Mya3tHVO; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1750619125; x=1750878325;
	bh=u+Tg1vx7bmudL9Y5ayxnUsk3odCkoOZXJciIY/7Fd9w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Mya3tHVOVjdJVxfLCiPaOWcRPMyl3XxSfz6eZ1N3louRdIFu0MYoFbHFJgdsMFyzL
	 sadp8JQ4CnfFqQRb0JPVJQTRHHP03BbVYmnLPw+ykK00JNrHjvwYEbY02y2IzYYEei
	 Hlq7DDBOYRHIqq7SICbNnDCR+BxWVopn4fAiJfRV/hDxO8TcTGcd7EmjpneNg5R9Pg
	 rdlYDKtZQgIzf+C/YmRkfW63j65blM1UTARHX3kwrDZgPjwSpum83NdgmwRum7mDG4
	 7+UrjVdmGinYpgRsXjYSiCx2BZ5cc8mR4GJ5QTDdMRXQCY5KgAukY+WZnrMDg5+0W2
	 Mq7K+ZlssqvYw==
Date: Sun, 22 Jun 2025 19:05:18 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH net 1/2] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
Message-ID: <20250622190344.446090-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 75e9183a3eade8740431daec3a74a2eee3cb82ed
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
index fdd79d3ccd8c..308ce6629d7e 100644
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
+=09return q->duplicate !=3D 0;
+}
+
+static int check_netem_in_tree(struct Qdisc *sch, bool only_duplicating,
+=09=09=09       struct netlink_ext_ack *extack)
+{
+=09struct Qdisc *root, *q;
+=09unsigned int i;
+
+=09root =3D qdisc_root_sleeping(sch);
+
+=09if (sch !=3D root && root->ops->cl_ops =3D=3D &netem_class_ops) {
+=09=09if (!only_duplicating || has_duplication(root))
+=09=09=09goto err;
+=09}
+
+=09if (!qdisc_dev(root))
+=09=09return 0;
+
+=09hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
+=09=09if (sch !=3D q && q->ops->cl_ops =3D=3D &netem_class_ops) {
+=09=09=09if (!only_duplicating || has_duplication(q))
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
+=09ret =3D check_netem_in_tree(sch, qopt->duplicate =3D=3D 0, extack);
+=09if (ret)
+=09=09goto unlock;
+
 =09q->duplicate =3D qopt->duplicate;
=20
 =09/* for compatibility with earlier versions.
--=20
2.43.0



