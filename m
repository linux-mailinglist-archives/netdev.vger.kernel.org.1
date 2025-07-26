Return-Path: <netdev+bounces-210345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E5AB12D1D
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 01:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4FA4E245A
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 23:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B639E21421E;
	Sat, 26 Jul 2025 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="siQEQ6G5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch [79.135.106.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62852AD16
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 23:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753573787; cv=none; b=BfezZWO1I/XOly5dCPvLRtwiYKrCDYl4/u+6kocki1DYw3C5Hy72t98m7Et4i6+gWCVxnEhk1QdazERA5MOhg+26bPn+OfPcWiJcgIXYWWbmRN+ipOyjxipIsogltr4aXR5MjMjgXTsniCi+HiMLrmlv6PBSI8QMgupDG3DOBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753573787; c=relaxed/simple;
	bh=+m7UH6pWZigDq7cVjpK5D7RI099enb9KVrUyCMpbTR4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pKEhetiBCgNQK7nhk8MFezbfwFV7aLzvwMRJYINvw2p/nkbZix1IardYBv9hNG3LnrKVYiyQ4TZDlhQsPgu/5Q2kkgrGoKh40nUwZTIa7lCrqUeCYxhek4mofrhM68tHqJ5onxDYz60fSZZ8LifY6yF2JO/X+JYnSpNrFeQF4JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=siQEQ6G5; arc=none smtp.client-ip=79.135.106.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1753573775; x=1753832975;
	bh=3c0yuvOHlGv/Vmeom/5IVzYs6YVT6VThawwKTJ1T4Vg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=siQEQ6G5qVKnQfKWUtBscLUEZcjizGLylkPiDlsO42WOvkJcMqIIBOUyW7gRfcfwC
	 j1kuRWR6/d8V38NriEZDSql6ijzwyzHOh4E0aPxbeMWbw60OdGr8Xe4/v253az/eoq
	 HF3LOnFVz6UEnb8s52Ow7IWgSJvRQaC3zwG6/TLfKpOH8fbAHLPdCdSYPwLpksgiaH
	 12XxZBcjNZrR+PNVyRw6X11+WZodX3ybr/+ds2eZ7Hi69xjgQ993Zr7pFs9J0kU+yr
	 IniJZ88dn+kX1fFilaFDhGRdqJvWwLxUqFn9+rK58dAF8jK132vQ09lBc2doZXZpKC
	 9IjWDMso0NBTA==
Date: Sat, 26 Jul 2025 23:49:30 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io, William Liu <will@willsroot.io>
Subject: [PATCH net v3 1/2] net/sched: Fix backlog accounting in qdisc_dequeue_internal
Message-ID: <20250726234901.106808-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 1d87fd3da2d2d83a42081820319f62f66a3a506e
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
limit. The problems are the following in the values passed to the
subsequent qdisc_tree_reduce_backlog call given a tbf parent:

1. When the tbf parent runs out of tokens, skbs of these qdiscs will
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

2. fq_codel_change is also wrong in the non gso_skb case. It tracks
   the amount to drop after the limit adjustment loop through
   cstats.drop_count and cstats.drop_len, but these are also updated
   in fq_codel_dequeue, and reset everytime if non-zero in that
   function after a call to qdisc_tree_reduce_backlog.
   If the drop path ever occurs in fq_codel_dequeue and
   qdisc_dequeue_internal takes the non gso_skb path, then we would
   reduce the backlog by an extra packet.

To fix these issues, the codepath for all clients of
qdisc_dequeue_internal has been simplified: codel, pie, hhf, fq,
fq_pie, and fq_codel. qdisc_dequeue_internal handles the backlog
adjustments for all cases that do not directly use the dequeue
handler.

Special care is taken for fq_codel_dequeue to account for the
qdisc_tree_reduce_backlog call in its dequeue handler. The
cstats reset is moved from the end to the beginning of
fq_codel_dequeue, so the change handler can use cstats for
proper backlog reduction accounting purposes. The drop_len and
drop_count fields are not used elsewhere so this reordering in
fq_codel_dequeue is ok.

Fixes: 2d3cbfd6d54a ("net_sched: Flush gso_skb list too during ->change()")
Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
Signed-off-by: William Liu <will@willsroot.io>
Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
---
v1 -> v2:
  - Fix commit formatting
  - There was a suggestion to split the patch apart into one for each
    qdisc - however, individual qdisc behavior will be further broken
    by this split due to the reliance on qdisc_dequeue_internal
---
 include/net/sch_generic.h |  9 +++++++--
 net/sched/sch_codel.c     | 10 +++++-----
 net/sched/sch_fq.c        | 14 +++++++-------
 net/sched/sch_fq_codel.c  | 22 +++++++++++++++-------
 net/sched/sch_fq_pie.c    | 10 +++++-----
 net/sched/sch_hhf.c       |  6 +++---
 net/sched/sch_pie.c       | 10 +++++-----
 7 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 638948be4c50..a24094a638dc 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1038,10 +1038,15 @@ static inline struct sk_buff *qdisc_dequeue_interna=
l(struct Qdisc *sch, bool dir
 =09skb =3D __skb_dequeue(&sch->gso_skb);
 =09if (skb) {
 =09=09sch->q.qlen--;
+=09=09qdisc_qstats_backlog_dec(sch, skb);
+=09=09return skb;
+=09}
+=09if (direct) {
+=09=09skb =3D __qdisc_dequeue_head(&sch->q);
+=09=09if (skb)
+=09=09=09qdisc_qstats_backlog_dec(sch, skb);
 =09=09return skb;
 =09}
-=09if (direct)
-=09=09return __qdisc_dequeue_head(&sch->q);
 =09else
 =09=09return sch->dequeue(sch);
 }
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index c93761040c6e..8dc467f665bb 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -103,7 +103,7 @@ static int codel_change(struct Qdisc *sch, struct nlatt=
r *opt,
 {
 =09struct codel_sched_data *q =3D qdisc_priv(sch);
 =09struct nlattr *tb[TCA_CODEL_MAX + 1];
-=09unsigned int qlen, dropped =3D 0;
+=09unsigned int prev_qlen, prev_backlog;
 =09int err;
=20
 =09err =3D nla_parse_nested_deprecated(tb, TCA_CODEL_MAX, opt,
@@ -142,15 +142,15 @@ static int codel_change(struct Qdisc *sch, struct nla=
ttr *opt,
 =09=09WRITE_ONCE(q->params.ecn,
 =09=09=09   !!nla_get_u32(tb[TCA_CODEL_ECN]));
=20
-=09qlen =3D sch->q.qlen;
+=09prev_qlen =3D sch->q.qlen;
+=09prev_backlog =3D sch->qstats.backlog;
 =09while (sch->q.qlen > sch->limit) {
 =09=09struct sk_buff *skb =3D qdisc_dequeue_internal(sch, true);
=20
-=09=09dropped +=3D qdisc_pkt_len(skb);
-=09=09qdisc_qstats_backlog_dec(sch, skb);
 =09=09rtnl_qdisc_drop(skb, sch);
 =09}
-=09qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen, dropped);
+=09qdisc_tree_reduce_backlog(sch, prev_qlen - sch->q.qlen,
+=09=09=09=09  prev_backlog - sch->qstats.backlog);
=20
 =09sch_tree_unlock(sch);
 =09return 0;
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 902ff5470607..986e71e3362c 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1014,10 +1014,10 @@ static int fq_change(struct Qdisc *sch, struct nlat=
tr *opt,
 =09=09     struct netlink_ext_ack *extack)
 {
 =09struct fq_sched_data *q =3D qdisc_priv(sch);
+=09unsigned int prev_qlen, prev_backlog;
 =09struct nlattr *tb[TCA_FQ_MAX + 1];
-=09int err, drop_count =3D 0;
-=09unsigned drop_len =3D 0;
 =09u32 fq_log;
+=09int err;
=20
 =09err =3D nla_parse_nested_deprecated(tb, TCA_FQ_MAX, opt, fq_policy,
 =09=09=09=09=09  NULL);
@@ -1135,16 +1135,16 @@ static int fq_change(struct Qdisc *sch, struct nlat=
tr *opt,
 =09=09err =3D fq_resize(sch, fq_log);
 =09=09sch_tree_lock(sch);
 =09}
+
+=09prev_qlen =3D sch->q.qlen;
+=09prev_backlog =3D sch->qstats.backlog;
 =09while (sch->q.qlen > sch->limit) {
 =09=09struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
=20
-=09=09if (!skb)
-=09=09=09break;
-=09=09drop_len +=3D qdisc_pkt_len(skb);
 =09=09rtnl_kfree_skbs(skb, skb);
-=09=09drop_count++;
 =09}
-=09qdisc_tree_reduce_backlog(sch, drop_count, drop_len);
+=09qdisc_tree_reduce_backlog(sch, prev_qlen - sch->q.qlen,
+=09=09=09=09  prev_backlog - sch->qstats.backlog);
=20
 =09sch_tree_unlock(sch);
 =09return err;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 2a0f3a513bfa..f9e6d76a1712 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -286,6 +286,10 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *=
sch)
 =09struct fq_codel_flow *flow;
 =09struct list_head *head;
=20
+=09/* reset these here, as change needs them for proper accounting*/
+=09q->cstats.drop_count =3D 0;
+=09q->cstats.drop_len =3D 0;
+
 begin:
 =09head =3D &q->new_flows;
 =09if (list_empty(head)) {
@@ -319,8 +323,6 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *s=
ch)
 =09if (q->cstats.drop_count) {
 =09=09qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
 =09=09=09=09=09  q->cstats.drop_len);
-=09=09q->cstats.drop_count =3D 0;
-=09=09q->cstats.drop_len =3D 0;
 =09}
 =09return skb;
 }
@@ -366,8 +368,10 @@ static const struct nla_policy fq_codel_policy[TCA_FQ_=
CODEL_MAX + 1] =3D {
 static int fq_codel_change(struct Qdisc *sch, struct nlattr *opt,
 =09=09=09   struct netlink_ext_ack *extack)
 {
+=09unsigned int dropped_qlen =3D 0, dropped_backlog =3D 0;
 =09struct fq_codel_sched_data *q =3D qdisc_priv(sch);
 =09struct nlattr *tb[TCA_FQ_CODEL_MAX + 1];
+=09unsigned int prev_qlen, prev_backlog;
 =09u32 quantum =3D 0;
 =09int err;
=20
@@ -439,17 +443,21 @@ static int fq_codel_change(struct Qdisc *sch, struct =
nlattr *opt,
 =09=09WRITE_ONCE(q->memory_limit,
 =09=09=09   min(1U << 31, nla_get_u32(tb[TCA_FQ_CODEL_MEMORY_LIMIT])));
=20
+=09prev_qlen =3D sch->q.qlen;
+=09prev_backlog =3D sch->qstats.backlog;
 =09while (sch->q.qlen > sch->limit ||
 =09       q->memory_usage > q->memory_limit) {
 =09=09struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
=20
-=09=09q->cstats.drop_len +=3D qdisc_pkt_len(skb);
+=09=09if (q->cstats.drop_count) {
+=09=09=09dropped_qlen +=3D q->cstats.drop_count;
+=09=09=09dropped_backlog +=3D q->cstats.drop_len;
+=09=09}
+
 =09=09rtnl_kfree_skbs(skb, skb);
-=09=09q->cstats.drop_count++;
 =09}
-=09qdisc_tree_reduce_backlog(sch, q->cstats.drop_count, q->cstats.drop_len=
);
-=09q->cstats.drop_count =3D 0;
-=09q->cstats.drop_len =3D 0;
+=09qdisc_tree_reduce_backlog(sch, prev_qlen - dropped_qlen - sch->q.qlen,
+=09=09=09=09  prev_backlog - dropped_backlog - sch->qstats.backlog);
=20
 =09sch_tree_unlock(sch);
 =09return 0;
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index b0e34daf1f75..8f49e9ff4f4c 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -289,8 +289,7 @@ static int fq_pie_change(struct Qdisc *sch, struct nlat=
tr *opt,
 {
 =09struct fq_pie_sched_data *q =3D qdisc_priv(sch);
 =09struct nlattr *tb[TCA_FQ_PIE_MAX + 1];
-=09unsigned int len_dropped =3D 0;
-=09unsigned int num_dropped =3D 0;
+=09unsigned int prev_qlen, prev_backlog;
 =09int err;
=20
 =09err =3D nla_parse_nested(tb, TCA_FQ_PIE_MAX, opt, fq_pie_policy, extack=
);
@@ -365,14 +364,15 @@ static int fq_pie_change(struct Qdisc *sch, struct nl=
attr *opt,
 =09=09=09   nla_get_u32(tb[TCA_FQ_PIE_DQ_RATE_ESTIMATOR]));
=20
 =09/* Drop excess packets if new limit is lower */
+=09prev_qlen =3D sch->q.qlen;
+=09prev_backlog =3D sch->qstats.backlog;
 =09while (sch->q.qlen > sch->limit) {
 =09=09struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
=20
-=09=09len_dropped +=3D qdisc_pkt_len(skb);
-=09=09num_dropped +=3D 1;
 =09=09rtnl_kfree_skbs(skb, skb);
 =09}
-=09qdisc_tree_reduce_backlog(sch, num_dropped, len_dropped);
+=09qdisc_tree_reduce_backlog(sch, prev_qlen - sch->q.qlen,
+=09=09=09=09  prev_backlog - sch->qstats.backlog);
=20
 =09sch_tree_unlock(sch);
 =09return 0;
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 5aa434b46707..011d1330aea5 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -509,8 +509,8 @@ static int hhf_change(struct Qdisc *sch, struct nlattr =
*opt,
 =09=09      struct netlink_ext_ack *extack)
 {
 =09struct hhf_sched_data *q =3D qdisc_priv(sch);
+=09unsigned int prev_qlen, prev_backlog;
 =09struct nlattr *tb[TCA_HHF_MAX + 1];
-=09unsigned int qlen, prev_backlog;
 =09int err;
 =09u64 non_hh_quantum;
 =09u32 new_quantum =3D q->quantum;
@@ -561,14 +561,14 @@ static int hhf_change(struct Qdisc *sch, struct nlatt=
r *opt,
 =09=09=09   usecs_to_jiffies(us));
 =09}
=20
-=09qlen =3D sch->q.qlen;
+=09prev_qlen =3D sch->q.qlen;
 =09prev_backlog =3D sch->qstats.backlog;
 =09while (sch->q.qlen > sch->limit) {
 =09=09struct sk_buff *skb =3D qdisc_dequeue_internal(sch, false);
=20
 =09=09rtnl_kfree_skbs(skb, skb);
 =09}
-=09qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen,
+=09qdisc_tree_reduce_backlog(sch, prev_qlen - sch->q.qlen,
 =09=09=09=09  prev_backlog - sch->qstats.backlog);
=20
 =09sch_tree_unlock(sch);
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index ad46ee3ed5a9..af2646545a8a 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -142,8 +142,8 @@ static int pie_change(struct Qdisc *sch, struct nlattr =
*opt,
 =09=09      struct netlink_ext_ack *extack)
 {
 =09struct pie_sched_data *q =3D qdisc_priv(sch);
+=09unsigned int prev_qlen, prev_backlog;
 =09struct nlattr *tb[TCA_PIE_MAX + 1];
-=09unsigned int qlen, dropped =3D 0;
 =09int err;
=20
 =09err =3D nla_parse_nested_deprecated(tb, TCA_PIE_MAX, opt, pie_policy,
@@ -193,15 +193,15 @@ static int pie_change(struct Qdisc *sch, struct nlatt=
r *opt,
 =09=09=09   nla_get_u32(tb[TCA_PIE_DQ_RATE_ESTIMATOR]));
=20
 =09/* Drop excess packets if new limit is lower */
-=09qlen =3D sch->q.qlen;
+=09prev_qlen =3D sch->q.qlen;
+=09prev_backlog =3D sch->qstats.backlog;
 =09while (sch->q.qlen > sch->limit) {
 =09=09struct sk_buff *skb =3D qdisc_dequeue_internal(sch, true);
=20
-=09=09dropped +=3D qdisc_pkt_len(skb);
-=09=09qdisc_qstats_backlog_dec(sch, skb);
 =09=09rtnl_qdisc_drop(skb, sch);
 =09}
-=09qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen, dropped);
+=09qdisc_tree_reduce_backlog(sch, prev_qlen - sch->q.qlen,
+=09=09=09=09  prev_backlog - sch->qstats.backlog);
=20
 =09sch_tree_unlock(sch);
 =09return 0;
--=20
2.43.0



