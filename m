Return-Path: <netdev+bounces-213122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBDCB23CD3
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0FF6E640E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 23:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F128A2E88B9;
	Tue, 12 Aug 2025 23:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="nKV4yiUu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DD92DCBFE
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043090; cv=none; b=Vk+TjFjR7S9IQft8lEe7r52qNYhO3IH41aRhU0g9Uz4f0V04KRuk2E4VAxabkVjV61dLlXkZeURrR5uTLxrQq0bcyMJNfHqTdD7ToJ9jJNWwBl5p3MV1AC8leALzLAZPKt4FMW53JFjk/G3DnGEMmDXLr1a5bfYIeg5X9ui/R1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043090; c=relaxed/simple;
	bh=lXW/AZ9G9V+GO8R1p/mE+K8kKhjpG5A21hnBxl56lv0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BSKk1nj/ALEHYUzQAh7fKUMBD6+tdgDO5bs1t3ano5lrqocEJM9XlYd2DcwuOiXRwDToR99bfF336vz60xBw/55lFs2Nn22acoMy7LKRjcsN6vM/VRejl2PHrzCto7//+cHBYg+76dtNO3E/ZhRR29k7ni9TgnM/b6M9pLlczVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=nKV4yiUu; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1755043084; x=1755302284;
	bh=zOALadcS+7an4duDsUhYvmmnEIvzq8wkviPkFFBgIF4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nKV4yiUuRQPy8yaRMOanOzJ4E6lN1LLM5A9iN6wQengSFjaCm5pi7sZqXlqYHo2fa
	 KmrCP4thRUmvn63vTTWYM0+F+OxBolFeBVB56W+2dw3SQXQo0HyECuKTazlRjq0xS9
	 P94W8u2SyWsKRH/I11OXOOZi40vqmx5BNcRMWS0ja44xX7JcUxZM+1AFp+0Q51qeMh
	 DYd3xolyYEelAbMfFFOuADEiub5lze6JXOul7zng0yRnheRzyZYcAjOM1AyJD6EEej
	 V2ElwJZJ+XqVcQVQOSvImEuLafddgeeBkiRFennOXfBZiLh+FDuU73Pv+PzVtR1ODw
	 RSnOzLlzvwfSQ==
Date: Tue, 12 Aug 2025 23:57:57 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io, victor@mojatatu.com, William Liu <will@willsroot.io>
Subject: [PATCH net v5 1/2] net/sched: Fix backlog accounting in qdisc_dequeue_internal
Message-ID: <20250812235725.45243-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 514879c64a1f94eb4732a25a21aeab8e6e204011
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This issue applies for the following qdiscs: hhf, fq, fq_codel, and
fq_pie, and occurs in their change handlers when adjusting to the new
limit. The problem is the following in the values passed to the
subsequent qdisc_tree_reduce_backlog call given a tbf parent:

   When the tbf parent runs out of tokens, skbs of these qdiscs will
   be placed in gso_skb. Their peek handlers are qdisc_peek_dequeued,
   which accounts for both qlen and backlog. However, in the case of
   qdisc_dequeue_internal, ONLY qlen is accounted for when pulling
   from gso_skb. This means that these qdiscs are missing a
   qdisc_qstats_backlog_dec when dropping packets to satisfy the
   new limit in their change handlers.

   One can observe this issue with the following (with tc patched to
   support a limit of 0):

   export TARGET=3Dfq
   tc qdisc del dev lo root
   tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b latency 1ms
   tc qdisc replace dev lo handle 3: parent 1:1 $TARGET limit 1000
   echo ''; echo 'add child'; tc -s -d qdisc show dev lo
   ping -I lo -f -c2 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
   echo ''; echo 'after ping'; tc -s -d qdisc show dev lo
   tc qdisc change dev lo handle 3: parent 1:1 $TARGET limit 0
   echo ''; echo 'after limit drop'; tc -s -d qdisc show dev lo
   tc qdisc replace dev lo handle 2: parent 1:1 sfq
   echo ''; echo 'post graft'; tc -s -d qdisc show dev lo

   The second to last show command shows 0 packets but a positive
   number (74) of backlog bytes. The problem becomes clearer in the
   last show command, where qdisc_purge_queue triggers
   qdisc_tree_reduce_backlog with the positive backlog and causes an
   underflow in the tbf parent's backlog (4096 Mb instead of 0).

To fix this issue, the codepath for all clients of qdisc_dequeue_internal
has been simplified: codel, pie, hhf, fq, fq_pie, and fq_codel.
qdisc_dequeue_internal handles the backlog adjustments for all cases that
do not directly use the dequeue handler.

The old fq_codel_change limit adjustment loop accumulated the arguments to
the subsequent qdisc_tree_reduce_backlog call through the cstats field.
However, this is confusing and error prone as fq_codel_dequeue could also
potentially mutate this field (which qdisc_dequeue_internal calls in the
non gso_skb case), so we have unified the code here with other qdiscs.

Fixes: 2d3cbfd6d54a ("net_sched: Flush gso_skb list too during ->change()")
Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
Signed-off-by: William Liu <will@willsroot.io>
Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
---
v4 -> v5:
  - address formatting nit, update commit message with additional
    clarifications, unify limit adjustment loops to suggested
    style from Jakub
v1 -> v2:
  - Fix commit formatting
  - There was a suggestion to split the patch apart into one for each
    qdisc - however, individual qdisc behavior will be further broken
    by this split due to the reliance on qdisc_dequeue_internal
---
 include/net/sch_generic.h | 11 ++++++++---
 net/sched/sch_codel.c     | 12 +++++++-----
 net/sched/sch_fq.c        | 12 +++++++-----
 net/sched/sch_fq_codel.c  | 12 +++++++-----
 net/sched/sch_fq_pie.c    | 12 +++++++-----
 net/sched/sch_hhf.c       | 12 +++++++-----
 net/sched/sch_pie.c       | 12 +++++++-----
 7 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 638948be4c50..738cd5b13c62 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1038,12 +1038,17 @@ static inline struct sk_buff *qdisc_dequeue_interna=
l(struct Qdisc *sch, bool dir
 =09skb =3D __skb_dequeue(&sch->gso_skb);
 =09if (skb) {
 =09=09sch->q.qlen--;
+=09=09qdisc_qstats_backlog_dec(sch, skb);
 =09=09return skb;
 =09}
-=09if (direct)
-=09=09return __qdisc_dequeue_head(&sch->q);
-=09else
+=09if (direct) {
+=09=09skb =3D __qdisc_dequeue_head(&sch->q);
+=09=09if (skb)
+=09=09=09qdisc_qstats_backlog_dec(sch, skb);
+=09=09return skb;
+=09} else {
 =09=09return sch->dequeue(sch);
+=09}
 }
=20
 static inline struct sk_buff *qdisc_dequeue_head(struct Qdisc *sch)
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index c93761040c6e..fa0314679e43 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -101,9 +101,9 @@ static const struct nla_policy codel_policy[TCA_CODEL_M=
AX + 1] =3D {
 static int codel_change(struct Qdisc *sch, struct nlattr *opt,
 =09=09=09struct netlink_ext_ack *extack)
 {
+=09unsigned int dropped_pkts =3D 0, dropped_bytes =3D 0;
 =09struct codel_sched_data *q =3D qdisc_priv(sch);
 =09struct nlattr *tb[TCA_CODEL_MAX + 1];
-=09unsigned int qlen, dropped =3D 0;
 =09int err;
=20
 =09err =3D nla_parse_nested_deprecated(tb, TCA_CODEL_MAX, opt,
@@ -142,15 +142,17 @@ static int codel_change(struct Qdisc *sch, struct nla=
ttr *opt,
 =09=09WRITE_ONCE(q->params.ecn,
 =09=09=09   !!nla_get_u32(tb[TCA_CODEL_ECN]));
=20
-=09qlen =3D sch->q.qlen;
 =09while (sch->q.qlen > sch->limit) {
 =09=09struct sk_buff *skb =3D qdisc_dequeue_internal(sch, true);
=20
-=09=09dropped +=3D qdisc_pkt_len(skb);
-=09=09qdisc_qstats_backlog_dec(sch, skb);
+=09=09if (!skb)
+=09=09=09break;
+
+=09=09dropped_pkts++;
+=09=09dropped_bytes +=3D qdisc_pkt_len(skb);
 =09=09rtnl_qdisc_drop(skb, sch);
 =09}
-=09qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen, dropped);
+=09qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
=20
 =09sch_tree_unlock(sch);
 =09return 0;
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 902ff5470607..fee922da2f99 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1013,11 +1013,11 @@ static int fq_load_priomap(struct fq_sched_data *q,
 static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 =09=09     struct netlink_ext_ack *extack)
 {
+=09unsigned int dropped_pkts =3D 0, dropped_bytes =3D 0;
 =09struct fq_sched_data *q =3D qdisc_priv(sch);
 =09struct nlattr *tb[TCA_FQ_MAX + 1];
-=09int err, drop_count =3D 0;
-=09unsigned drop_len =3D 0;
 =09u32 fq_log;
+=09int err;
=20
 =09err =3D nla_parse_nested_deprecated(tb, TCA_FQ_MAX, opt, fq_policy,
 =09=09=09=09=09  NULL);
@@ -1135,16 +1135,18 @@ static int fq_change(struct Qdisc *sch, struct nlat=
tr *opt,
 =09=09err =3D fq_resize(sch, fq_log);
 =09=09sch_tree_lock(sch);
 =09}
+
 =09while (sch->q.qlen > sch->limit) {
 =09=09struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
=20
 =09=09if (!skb)
 =09=09=09break;
-=09=09drop_len +=3D qdisc_pkt_len(skb);
+
+=09=09dropped_pkts++;
+=09=09dropped_bytes +=3D qdisc_pkt_len(skb);
 =09=09rtnl_kfree_skbs(skb, skb);
-=09=09drop_count++;
 =09}
-=09qdisc_tree_reduce_backlog(sch, drop_count, drop_len);
+=09qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
=20
 =09sch_tree_unlock(sch);
 =09return err;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 2a0f3a513bfa..a14142392939 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -366,6 +366,7 @@ static const struct nla_policy fq_codel_policy[TCA_FQ_C=
ODEL_MAX + 1] =3D {
 static int fq_codel_change(struct Qdisc *sch, struct nlattr *opt,
 =09=09=09   struct netlink_ext_ack *extack)
 {
+=09unsigned int dropped_pkts =3D 0, dropped_bytes =3D 0;
 =09struct fq_codel_sched_data *q =3D qdisc_priv(sch);
 =09struct nlattr *tb[TCA_FQ_CODEL_MAX + 1];
 =09u32 quantum =3D 0;
@@ -443,13 +444,14 @@ static int fq_codel_change(struct Qdisc *sch, struct =
nlattr *opt,
 =09       q->memory_usage > q->memory_limit) {
 =09=09struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
=20
-=09=09q->cstats.drop_len +=3D qdisc_pkt_len(skb);
+=09=09if (!skb)
+=09=09=09break;
+
+=09=09dropped_pkts++;
+=09=09dropped_bytes +=3D qdisc_pkt_len(skb);
 =09=09rtnl_kfree_skbs(skb, skb);
-=09=09q->cstats.drop_count++;
 =09}
-=09qdisc_tree_reduce_backlog(sch, q->cstats.drop_count, q->cstats.drop_len=
);
-=09q->cstats.drop_count =3D 0;
-=09q->cstats.drop_len =3D 0;
+=09qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
=20
 =09sch_tree_unlock(sch);
 =09return 0;
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index b0e34daf1f75..7b96bc3ff891 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -287,10 +287,9 @@ static struct sk_buff *fq_pie_qdisc_dequeue(struct Qdi=
sc *sch)
 static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 =09=09=09 struct netlink_ext_ack *extack)
 {
+=09unsigned int dropped_pkts =3D 0, dropped_bytes =3D 0;
 =09struct fq_pie_sched_data *q =3D qdisc_priv(sch);
 =09struct nlattr *tb[TCA_FQ_PIE_MAX + 1];
-=09unsigned int len_dropped =3D 0;
-=09unsigned int num_dropped =3D 0;
 =09int err;
=20
 =09err =3D nla_parse_nested(tb, TCA_FQ_PIE_MAX, opt, fq_pie_policy, extack=
);
@@ -368,11 +367,14 @@ static int fq_pie_change(struct Qdisc *sch, struct nl=
attr *opt,
 =09while (sch->q.qlen > sch->limit) {
 =09=09struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
=20
-=09=09len_dropped +=3D qdisc_pkt_len(skb);
-=09=09num_dropped +=3D 1;
+=09=09if (!skb)
+=09=09=09break;
+
+=09=09dropped_pkts++;
+=09=09dropped_bytes +=3D qdisc_pkt_len(skb);
 =09=09rtnl_kfree_skbs(skb, skb);
 =09}
-=09qdisc_tree_reduce_backlog(sch, num_dropped, len_dropped);
+=09qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
=20
 =09sch_tree_unlock(sch);
 =09return 0;
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 5aa434b46707..2d4855e28a28 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -508,9 +508,9 @@ static const struct nla_policy hhf_policy[TCA_HHF_MAX +=
 1] =3D {
 static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 =09=09      struct netlink_ext_ack *extack)
 {
+=09unsigned int dropped_pkts =3D 0, dropped_bytes =3D 0;
 =09struct hhf_sched_data *q =3D qdisc_priv(sch);
 =09struct nlattr *tb[TCA_HHF_MAX + 1];
-=09unsigned int qlen, prev_backlog;
 =09int err;
 =09u64 non_hh_quantum;
 =09u32 new_quantum =3D q->quantum;
@@ -561,15 +561,17 @@ static int hhf_change(struct Qdisc *sch, struct nlatt=
r *opt,
 =09=09=09   usecs_to_jiffies(us));
 =09}
=20
-=09qlen =3D sch->q.qlen;
-=09prev_backlog =3D sch->qstats.backlog;
 =09while (sch->q.qlen > sch->limit) {
 =09=09struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
=20
+=09=09if (!skb)
+=09=09=09break;
+
+=09=09dropped_pkts++;
+=09=09dropped_bytes +=3D qdisc_pkt_len(skb);
 =09=09rtnl_kfree_skbs(skb, skb);
 =09}
-=09qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen,
-=09=09=09=09  prev_backlog - sch->qstats.backlog);
+=09qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
=20
 =09sch_tree_unlock(sch);
 =09return 0;
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index ad46ee3ed5a9..0a377313b6a9 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -141,9 +141,9 @@ static const struct nla_policy pie_policy[TCA_PIE_MAX +=
 1] =3D {
 static int pie_change(struct Qdisc *sch, struct nlattr *opt,
 =09=09      struct netlink_ext_ack *extack)
 {
+=09unsigned int dropped_pkts =3D 0, dropped_bytes =3D 0;
 =09struct pie_sched_data *q =3D qdisc_priv(sch);
 =09struct nlattr *tb[TCA_PIE_MAX + 1];
-=09unsigned int qlen, dropped =3D 0;
 =09int err;
=20
 =09err =3D nla_parse_nested_deprecated(tb, TCA_PIE_MAX, opt, pie_policy,
@@ -193,15 +193,17 @@ static int pie_change(struct Qdisc *sch, struct nlatt=
r *opt,
 =09=09=09   nla_get_u32(tb[TCA_PIE_DQ_RATE_ESTIMATOR]));
=20
 =09/* Drop excess packets if new limit is lower */
-=09qlen =3D sch->q.qlen;
 =09while (sch->q.qlen > sch->limit) {
 =09=09struct sk_buff *skb =3D qdisc_dequeue_internal(sch, true);
=20
-=09=09dropped +=3D qdisc_pkt_len(skb);
-=09=09qdisc_qstats_backlog_dec(sch, skb);
+=09=09if (!skb)
+=09=09=09break;
+
+=09=09dropped_pkts++;
+=09=09dropped_bytes +=3D qdisc_pkt_len(skb);
 =09=09rtnl_qdisc_drop(skb, sch);
 =09}
-=09qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen, dropped);
+=09qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
=20
 =09sch_tree_unlock(sch);
 =09return 0;
--=20
2.43.0



