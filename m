Return-Path: <netdev+bounces-250511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE135D30689
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1114D30034BA
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A57378D66;
	Fri, 16 Jan 2026 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="GIpkxIqj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C836213D
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563073; cv=none; b=oly+tekbLV0HximQgH5l4qkekGi++QvUaNxGVIQtL/dA2htcIP9CQ3B5HQcMS8RlEciCONakc/9LCTo+tX5EtlJL4Q30mQLX7+0Q1McvTezBsNm58EF+oS3w6bN7ODFv4vBGxg+1093VsrEpH5y3ksW+DCG81PfSgv9TSeWXiYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563073; c=relaxed/simple;
	bh=hoOEp7/FyClFSn7beJBB130mX8xXI/mlyVhaMqv9VTE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CkvZ5UE37iTExlD4Q/5nksimh/QYptpOci5NO4luJi0loDweQ6LSOItVVtC+1IWOqk51rGdhzv0+GFWyjChZg4SU1UpsKCf8z4tHLM89hwts0WAINITr1zC9BrYrFutTB+0IEZyWJd5L7MLOw1nY/Idfkn0K+LSv5M3rWQpUC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=GIpkxIqj; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1768563060; x=1768822260;
	bh=C8WFaZulI+vGjy9miXXrO+/PImGZmDzNc4fGolmoMPI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GIpkxIqj6ni3xoWui5Kz3vJK2+2IPAffuVO0KFRuHnlkOHms2oM1yG4ks9MLzB2LH
	 k7nR4SvvJk5F5BluQ7/W1AbtBC2E/igQVN6uvKIqWNpvhHS3j02H/TU+kPt1ejOnVq
	 fDPtCvlCFNoKRiKfiCLHMfL4MT7VXfRQfIul+I03JnawexE1GHmUSqRtBMtfHvO1wo
	 tavUVJ8bOClEejwP+lUlywuu3yiJfLTBSufj5naZQiLWE1SVwVEGHgFCF5X7BZR5PO
	 oAXtuybAmNn6mA5zgA0JbgUK1ITJrkuigAfoqDCoy8RAxGP4glf9bx8g4ETKrOPgE6
	 zPfJU4qHM9Ddg==
Date: Fri, 16 Jan 2026 11:30:56 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Paul Moses <p@1g4.org>
Subject: [PATCH net-next v1] net/sched: act_gate: pack schedule entries into a single blob
Message-ID: <20260116113049.159824-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 9de41c861bfe9dac4acfdfa1744b5003f851c578
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Store gate schedule entries in a flexible array within tcf_gate_params to
reduce allocations and improve cache locality. Update the timer, dump,
and parsing paths to use index-based access, and reject overflowing
cycle times.

Signed-off-by: Paul Moses <p@1g4.org>
Depends-on: <20260116112522.159480-3-p@1g4.org>
---
 include/net/tc_act/tc_gate.h |  23 ++---
 net/sched/act_gate.c         | 184 +++++++++++++----------------------
 2 files changed, 73 insertions(+), 134 deletions(-)

diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.h
index 5fa6a500b9288..23510206b6c9e 100644
--- a/include/net/tc_act/tc_gate.h
+++ b/include/net/tc_act/tc_gate.h
@@ -14,13 +14,11 @@ struct action_gate_entry {
 =09s32=09=09=09maxoctets;
 };
=20
-struct tcfg_gate_entry {
-=09int=09=09=09index;
+struct gate_entry {
 =09u8=09=09=09gate_state;
 =09u32=09=09=09interval;
 =09s32=09=09=09ipv;
 =09s32=09=09=09maxoctets;
-=09struct list_head=09list;
 };
=20
 struct tcf_gate_params {
@@ -30,9 +28,9 @@ struct tcf_gate_params {
 =09u64=09=09=09tcfg_cycletime_ext;
 =09u32=09=09=09tcfg_flags;
 =09s32=09=09=09tcfg_clockid;
-=09size_t=09=09=09num_entries;
-=09struct list_head=09entries;
+=09u32=09=09=09num_entries;
 =09struct rcu_head=09=09rcu;
+=09struct gate_entry=09entries[];
 };
=20
 #define GATE_ACT_GATE_OPEN=09BIT(0)
@@ -45,7 +43,7 @@ struct tcf_gate {
 =09ktime_t=09=09=09current_close_time;
 =09u32=09=09=09current_entry_octets;
 =09s32=09=09=09current_max_octets;
-=09struct tcfg_gate_entry=09*next_entry;
+=09u32=09=09=09next_idx;
 =09struct hrtimer=09=09hitimer;
 =09enum tk_offsets=09=09tk_offset;
 };
@@ -128,7 +126,7 @@ static inline struct action_gate_entry
 =09struct action_gate_entry *oe;
 =09struct tcf_gate *gact =3D to_gate(a);
 =09struct tcf_gate_params *p;
-=09struct tcfg_gate_entry *entry;
+=09struct gate_entry *entry;
 =09u32 num_entries;
 =09int i =3D 0;
=20
@@ -137,23 +135,18 @@ static inline struct action_gate_entry
 =09=09=09=09      lockdep_rtnl_is_held());
 =09num_entries =3D p->num_entries;
=20
-=09list_for_each_entry(entry, &p->entries, list)
-=09=09i++;
-
-=09if (i !=3D num_entries)
-=09=09return NULL;
+=09i =3D num_entries;
=20
 =09oe =3D kcalloc(num_entries, sizeof(*oe), GFP_ATOMIC);
 =09if (!oe)
 =09=09return NULL;
=20
-=09i =3D 0;
-=09list_for_each_entry(entry, &p->entries, list) {
+=09for (i =3D 0; i < num_entries; i++) {
+=09=09entry =3D &p->entries[i];
 =09=09oe[i].gate_state =3D entry->gate_state;
 =09=09oe[i].interval =3D entry->interval;
 =09=09oe[i].ipv =3D entry->ipv;
 =09=09oe[i].maxoctets =3D entry->maxoctets;
-=09=09i++;
 =09}
=20
 =09return oe;
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 043ad856361d7..74394e3767387 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -72,14 +72,16 @@ static enum hrtimer_restart gate_timer_func(struct hrti=
mer *timer)
 =09struct tcf_gate *gact =3D container_of(timer, struct tcf_gate,
 =09=09=09=09=09     hitimer);
 =09struct tcf_gate_params *p;
-=09struct tcfg_gate_entry *next;
+=09struct gate_entry *next;
+=09u32 next_idx;
 =09ktime_t close_time, now;
=20
 =09spin_lock(&gact->tcf_lock);
=20
 =09p =3D rcu_dereference_protected(gact->param,
 =09=09=09=09      lockdep_is_held(&gact->tcf_lock));
-=09next =3D gact->next_entry;
+=09next_idx =3D gact->next_idx;
+=09next =3D &p->entries[next_idx];
=20
 =09/* cycle start, clear pending bit, clear total octets */
 =09gact->current_gate_status =3D next->gate_state ? GATE_ACT_GATE_OPEN : 0=
;
@@ -91,11 +93,9 @@ static enum hrtimer_restart gate_timer_func(struct hrtim=
er *timer)
=20
 =09close_time =3D gact->current_close_time;
=20
-=09if (list_is_last(&next->list, &p->entries))
-=09=09next =3D list_first_entry(&p->entries,
-=09=09=09=09=09struct tcfg_gate_entry, list);
-=09else
-=09=09next =3D list_next_entry(next, list);
+=09next_idx++;
+=09if (next_idx >=3D p->num_entries)
+=09=09next_idx =3D 0;
=20
 =09now =3D gate_get_time(gact);
=20
@@ -109,7 +109,7 @@ static enum hrtimer_restart gate_timer_func(struct hrti=
mer *timer)
 =09=09close_time =3D ktime_add_ns(base, (n + 1) * cycle);
 =09}
=20
-=09gact->next_entry =3D next;
+=09gact->next_idx =3D next_idx;
=20
 =09hrtimer_set_expires(&gact->hitimer, close_time);
=20
@@ -177,7 +177,7 @@ static const struct nla_policy gate_policy[TCA_GATE_MAX=
 + 1] =3D {
 =09[TCA_GATE_CLOCKID]=09=09=3D { .type =3D NLA_S32 },
 };
=20
-static int fill_gate_entry(struct nlattr **tb, struct tcfg_gate_entry *ent=
ry,
+static int fill_gate_entry(struct nlattr **tb, struct gate_entry *entry,
 =09=09=09   struct netlink_ext_ack *extack)
 {
 =09u32 interval =3D 0;
@@ -202,8 +202,8 @@ static int fill_gate_entry(struct nlattr **tb, struct t=
cfg_gate_entry *entry,
 =09return 0;
 }
=20
-static int parse_gate_entry(struct nlattr *n, struct  tcfg_gate_entry *ent=
ry,
-=09=09=09    int index, struct netlink_ext_ack *extack)
+static int parse_gate_entry(struct nlattr *n, struct gate_entry *entry,
+=09=09=09    struct netlink_ext_ack *extack)
 {
 =09struct nlattr *tb[TCA_GATE_ENTRY_MAX + 1] =3D { };
 =09int err;
@@ -214,34 +214,20 @@ static int parse_gate_entry(struct nlattr *n, struct =
 tcfg_gate_entry *entry,
 =09=09return -EINVAL;
 =09}
=20
-=09entry->index =3D index;
-
 =09return fill_gate_entry(tb, entry, extack);
 }
=20
-static void release_entry_list(struct list_head *entries)
-{
-=09struct tcfg_gate_entry *entry, *e;
-
-=09list_for_each_entry_safe(entry, e, entries, list) {
-=09=09list_del(&entry->list);
-=09=09kfree(entry);
-=09}
-}
-
 static void tcf_gate_params_release(struct rcu_head *rcu)
 {
 =09struct tcf_gate_params *p =3D container_of(rcu, struct tcf_gate_params,=
 rcu);
=20
-=09release_entry_list(&p->entries);
 =09kfree(p);
 }
=20
-static int parse_gate_list(struct nlattr *list_attr,
-=09=09=09   struct tcf_gate_params *sched,
-=09=09=09   struct netlink_ext_ack *extack)
+static int gate_setup_gate_list(struct nlattr *list_attr,
+=09=09=09=09struct tcf_gate_params *p,
+=09=09=09=09struct netlink_ext_ack *extack)
 {
-=09struct tcfg_gate_entry *entry;
 =09struct nlattr *n;
 =09int err, rem;
 =09int i =3D 0;
@@ -255,31 +241,13 @@ static int parse_gate_list(struct nlattr *list_attr,
 =09=09=09continue;
 =09=09}
=20
-=09=09entry =3D kzalloc(sizeof(*entry), GFP_ATOMIC);
-=09=09if (!entry) {
-=09=09=09NL_SET_ERR_MSG(extack, "Not enough memory for entry");
-=09=09=09err =3D -ENOMEM;
-=09=09=09goto release_list;
-=09=09}
-
-=09=09err =3D parse_gate_entry(n, entry, i, extack);
-=09=09if (err < 0) {
-=09=09=09kfree(entry);
-=09=09=09goto release_list;
-=09=09}
-
-=09=09list_add_tail(&entry->list, &sched->entries);
+=09=09err =3D parse_gate_entry(n, &p->entries[i], extack);
+=09=09if (err < 0)
+=09=09=09return err;
 =09=09i++;
 =09}
=20
-=09sched->num_entries =3D i;
-
-=09return i;
-
-release_list:
-=09release_entry_list(&sched->entries);
-
-=09return err;
+=09return 0;
 }
=20
 static void gate_setup_timer(struct tcf_gate *gact, u64 basetime,
@@ -304,13 +272,13 @@ static void gate_setup_timer(struct tcf_gate *gact, u=
64 basetime,
 =09hrtimer_setup(&gact->hitimer, gate_timer_func, clockid, HRTIMER_MODE_AB=
S_SOFT);
 }
=20
-static int gate_calc_cycletime(struct list_head *entries, u64 *cycletime)
+static int gate_calc_cycletime(struct tcf_gate_params *p, u64 *cycletime)
 {
-=09struct tcfg_gate_entry *entry;
 =09u64 sum =3D 0;
+=09u32 i;
=20
-=09list_for_each_entry(entry, entries, list) {
-=09=09if (check_add_overflow(sum, (u64)entry->interval, &sum))
+=09for (i =3D 0; i < p->num_entries; i++) {
+=09=09if (check_add_overflow(sum, (u64)p->entries[i].interval, &sum))
 =09=09=09return -EOVERFLOW;
 =09}
=20
@@ -332,20 +300,18 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09struct tcf_gate_params *p, *oldp;
 =09struct tcf_gate *gact;
 =09struct tc_gate *parm;
-=09struct tcf_gate_params newp =3D { };
 =09ktime_t start;
 =09u64 cycletime =3D 0, basetime =3D 0, cycletime_ext =3D 0;
 =09enum tk_offsets tk_offset =3D TK_OFFS_TAI;
 =09s32 clockid =3D CLOCK_TAI;
 =09u32 gflags =3D 0;
 =09u32 index;
+=09u32 num_entries =3D 0;
 =09s32 prio =3D -1;
 =09bool bind =3D flags & TCA_ACT_FLAGS_BIND;
 =09bool clockid_set =3D false;
 =09int ret =3D 0, err;
=20
-=09INIT_LIST_HEAD(&newp.entries);
-
 =09if (!nla)
 =09=09return -EINVAL;
=20
@@ -395,12 +361,11 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
=20
 =09=09ret =3D ACT_P_CREATED;
 =09=09gact =3D to_gate(*a);
-=09=09p =3D kzalloc(sizeof(*p), GFP_KERNEL);
+=09=09p =3D kzalloc(struct_size(p, entries, 0), GFP_KERNEL);
 =09=09if (!p) {
 =09=09=09tcf_idr_release(*a, bind);
 =09=09=09return -ENOMEM;
 =09=09}
-=09=09INIT_LIST_HEAD(&p->entries);
 =09=09rcu_assign_pointer(gact->param, p);
 =09=09gate_setup_timer(gact, basetime, tk_offset, clockid, true);
 =09} else {
@@ -469,16 +434,19 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09}
=20
 =09if (tb[TCA_GATE_ENTRY_LIST]) {
-=09=09INIT_LIST_HEAD(&newp.entries);
-=09=09err =3D parse_gate_list(tb[TCA_GATE_ENTRY_LIST], &newp, extack);
-=09=09if (err <=3D 0) {
-=09=09=09if (!err)
-=09=09=09=09NL_SET_ERR_MSG(extack,
-=09=09=09=09=09       "Missing gate schedule (entry list)");
+=09=09struct nlattr *n;
+=09=09int rem;
+
+=09=09nla_for_each_nested(n, tb[TCA_GATE_ENTRY_LIST], rem) {
+=09=09=09if (nla_type(n) !=3D TCA_GATE_ONE_ENTRY)
+=09=09=09=09continue;
+=09=09=09num_entries++;
+=09=09}
+=09=09if (!num_entries) {
+=09=09=09NL_SET_ERR_MSG(extack, "Empty schedule entry list");
 =09=09=09err =3D -EINVAL;
 =09=09=09goto put_chain;
 =09=09}
-=09=09newp.num_entries =3D err;
 =09} else if (ret =3D=3D ACT_P_CREATED) {
 =09=09NL_SET_ERR_MSG(extack, "Missing schedule entry list");
 =09=09err =3D -EINVAL;
@@ -493,39 +461,39 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09else if (ret !=3D ACT_P_CREATED)
 =09=09cycletime_ext =3D oldp->tcfg_cycletime_ext;
=20
-=09if (!cycletime) {
-=09=09struct list_head *entries;
-
-=09=09if (!list_empty(&newp.entries))
-=09=09=09entries =3D &newp.entries;
-=09=09else if (ret !=3D ACT_P_CREATED)
-=09=09=09entries =3D &oldp->entries;
-=09=09else
-=09=09=09entries =3D NULL;
+=09if (ret !=3D ACT_P_CREATED)
+=09=09hrtimer_cancel(&gact->hitimer);
=20
-=09=09if (!entries) {
-=09=09=09NL_SET_ERR_MSG(extack, "Invalid cycle time");
-=09=09=09err =3D -EINVAL;
-=09=09=09goto release_new_entries;
+=09if (num_entries) {
+=09=09p =3D kzalloc(struct_size(p, entries, num_entries), GFP_KERNEL);
+=09=09if (!p) {
+=09=09=09err =3D -ENOMEM;
+=09=09=09goto put_chain;
 =09=09}
+=09=09p->num_entries =3D num_entries;
+=09=09err =3D gate_setup_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extack);
+=09=09if (err < 0)
+=09=09=09goto free_p;
+=09} else {
+=09=09num_entries =3D oldp->num_entries;
+=09=09p =3D kzalloc(struct_size(p, entries, num_entries), GFP_KERNEL);
+=09=09if (!p) {
+=09=09=09err =3D -ENOMEM;
+=09=09=09goto put_chain;
+=09=09}
+=09=09p->num_entries =3D num_entries;
+=09=09memcpy(p->entries, oldp->entries,
+=09=09       flex_array_size(p, entries, num_entries));
+=09}
=20
-=09=09err =3D gate_calc_cycletime(entries, &cycletime);
+=09if (!cycletime) {
+=09=09err =3D gate_calc_cycletime(p, &cycletime);
 =09=09if (err < 0) {
 =09=09=09NL_SET_ERR_MSG(extack, "Invalid cycle time");
-=09=09=09goto release_new_entries;
+=09=09=09goto free_p;
 =09=09}
 =09}
=20
-=09if (ret !=3D ACT_P_CREATED)
-=09=09hrtimer_cancel(&gact->hitimer);
-
-=09p =3D kzalloc(sizeof(*p), GFP_KERNEL);
-=09if (!p) {
-=09=09err =3D -ENOMEM;
-=09=09goto release_new_entries;
-=09}
-
-=09INIT_LIST_HEAD(&p->entries);
 =09p->tcfg_priority =3D prio;
 =09p->tcfg_basetime =3D basetime;
 =09p->tcfg_cycletime =3D cycletime;
@@ -533,31 +501,12 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09p->tcfg_flags =3D gflags;
 =09p->tcfg_clockid =3D clockid;
=20
-=09if (!list_empty(&newp.entries)) {
-=09=09list_splice_init(&newp.entries, &p->entries);
-=09=09p->num_entries =3D newp.num_entries;
-=09} else if (ret !=3D ACT_P_CREATED) {
-=09=09struct tcfg_gate_entry *entry, *ne;
-
-=09=09list_for_each_entry(entry, &oldp->entries, list) {
-=09=09=09ne =3D kmemdup(entry, sizeof(*ne), GFP_KERNEL);
-=09=09=09if (!ne) {
-=09=09=09=09err =3D -ENOMEM;
-=09=09=09=09goto free_p;
-=09=09=09}
-=09=09=09INIT_LIST_HEAD(&ne->list);
-=09=09=09list_add_tail(&ne->list, &p->entries);
-=09=09}
-=09=09p->num_entries =3D oldp->num_entries;
-=09}
-
 =09spin_lock_bh(&gact->tcf_lock);
 =09gate_setup_timer(gact, basetime, tk_offset, clockid, ret =3D=3D ACT_P_C=
REATED);
=20
 =09gate_get_start_time(gact, p, &start);
 =09gact->current_close_time =3D start;
-=09gact->next_entry =3D list_first_entry(&p->entries,
-=09=09=09=09=09    struct tcfg_gate_entry, list);
+=09gact->next_idx =3D 0;
 =09gact->current_entry_octets =3D 0;
 =09gact->current_gate_status =3D GATE_ACT_PENDING;
=20
@@ -580,8 +529,6 @@ static int tcf_gate_init(struct net *net, struct nlattr=
 *nla,
=20
 free_p:
 =09kfree(p);
-release_new_entries:
-=09release_entry_list(&newp.entries);
 put_chain:
 =09if (goto_ch)
 =09=09tcf_chain_put_by_act(goto_ch);
@@ -589,7 +536,6 @@ static int tcf_gate_init(struct net *net, struct nlattr=
 *nla,
 =09if (ret =3D=3D ACT_P_CREATED) {
 =09=09p =3D rcu_dereference_protected(gact->param, 1);
 =09=09if (p) {
-=09=09=09release_entry_list(&p->entries);
 =09=09=09kfree(p);
 =09=09=09rcu_assign_pointer(gact->param, NULL);
 =09=09}
@@ -611,7 +557,7 @@ static void tcf_gate_cleanup(struct tc_action *a)
 }
=20
 static int dumping_entry(struct sk_buff *skb,
-=09=09=09 struct tcfg_gate_entry *entry)
+=09=09=09 struct gate_entry *entry, u32 index)
 {
 =09struct nlattr *item;
=20
@@ -619,7 +565,7 @@ static int dumping_entry(struct sk_buff *skb,
 =09if (!item)
 =09=09return -ENOSPC;
=20
-=09if (nla_put_u32(skb, TCA_GATE_ENTRY_INDEX, entry->index))
+=09if (nla_put_u32(skb, TCA_GATE_ENTRY_INDEX, index))
 =09=09goto nla_put_failure;
=20
 =09if (entry->gate_state && nla_put_flag(skb, TCA_GATE_ENTRY_GATE))
@@ -645,12 +591,12 @@ static int tcf_gate_dump(struct sk_buff *skb, struct =
tc_action *a,
 =09=09=09 int bind, int ref)
 {
 =09struct tcf_gate *gact =3D to_gate(a);
-=09struct tcfg_gate_entry *entry;
 =09struct tcf_gate_params *p;
 =09struct nlattr *entry_list;
 =09struct tc_gate opt =3D { };
 =09struct tcf_t t;
 =09unsigned char *b =3D skb_tail_pointer(skb);
+=09u32 i;
=20
 =09spin_lock_bh(&gact->tcf_lock);
 =09opt.index    =3D gact->tcf_index;
@@ -689,8 +635,8 @@ static int tcf_gate_dump(struct sk_buff *skb, struct tc=
_action *a,
 =09if (!entry_list)
 =09=09goto nla_put_failure;
=20
-=09list_for_each_entry(entry, &p->entries, list) {
-=09=09if (dumping_entry(skb, entry) < 0)
+=09for (i =3D 0; i < p->num_entries; i++) {
+=09=09if (dumping_entry(skb, &p->entries[i], i) < 0)
 =09=09=09goto nla_put_failure;
 =09}
=20
--=20
2.52.GIT



