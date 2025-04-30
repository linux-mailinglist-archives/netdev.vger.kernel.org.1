Return-Path: <netdev+bounces-187064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8864CAA4BA9
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564A34E44F2
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E231725EF94;
	Wed, 30 Apr 2025 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vRfnItSH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qBcVd9y2"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166AA25D8EC
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017298; cv=none; b=KZCM7eKndwkSSCHN5f+KEbYevfoxR/eT5SzyEdIjyUiyUOsD4k7CX8rz2AvLPi/WBkpkckP4s51MI6mj0u3DWimViPZyCrCCpwitUCXHB2zCa0WH/0SRclWZfSBmkjcbPzWxY7ivkgDDH/6NC9786py6SMvf/tdEfDfYFQodNhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017298; c=relaxed/simple;
	bh=XoUkxMlTRHC7S5YkyAYYLLJO+f90WFFyfs2F0MKsQcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9SpaeElqAkh5U1tgfhhXmHNKi3Ie6FriylwlSrDLSXeqYvvSA/yNY8AwPH12iCoxZsssuvRfitKiMRd/gzfxouei3oma+pZTBYi8ByLAbsGMbwWspUleadCD4nETF94rO+fu6/A7KS7KcorunCMwPvDTyNJez/2hcleHLaphUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vRfnItSH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qBcVd9y2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746017294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWftsgc2E4reij74Jhx+0RuY5VC0kbtQaCTA4HRLCcg=;
	b=vRfnItSHgVs0o/db4G0iLua2DYh8ZQ/K0lyKMxmSq+TVJ3//N8MzY+fDULPMbmn+vJRjUO
	RhE9EZo+Zyto9KGGzB5JMhuAdauAzRbtqK6O7yRfLfHHDir9vtlliZXcHpI1FFC82/Khv2
	4wVkGZH7Dmj5tr+tQ3Uyy+TL7Hz+zOwKhLwzmbS1cezDTq9dLMIgsaenTeCB8REtzPFyWl
	cmAoqxLamCuRf+lqyyAEMvHl+a74SOtuyNFIuDDb8W1wGxboFomd3lZzN3L1nVRIwz3aOu
	eaI+b+RoUKcOUxT49Zx6OyTu2C9SnHcRi3kQKSPUEKPgp779nmRPyj1AxaT1Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746017294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWftsgc2E4reij74Jhx+0RuY5VC0kbtQaCTA4HRLCcg=;
	b=qBcVd9y2HapcNvmbS9t6q1VHcNrF1gGKr1feI2NYf3Z6y4DTlYH2Zf4tvweFIKiwOryVG9
	5fGMWY2C1v3/ZMAA==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org
Subject: [PATCH net-next v3 11/18] openvswitch: Use nested-BH locking for ovs_pcpu_storage
Date: Wed, 30 Apr 2025 14:47:51 +0200
Message-ID: <20250430124758.1159480-12-bigeasy@linutronix.de>
In-Reply-To: <20250430124758.1159480-1-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ovs_pcpu_storage is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.
The data structure can be referenced recursive and there is a recursion
counter to avoid too many recursions.

Add a local_lock_t to the data structure and use
local_lock_nested_bh() for locking. Add an owner of the struct which is
the current task and acquire the lock only if the structure is not owned
by the current task.

Cc: Aaron Conole <aconole@redhat.com>
Cc: Eelco Chaudron <echaudro@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: dev@openvswitch.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/openvswitch/actions.c  | 31 ++-----------------------------
 net/openvswitch/datapath.c | 24 ++++++++++++++++++++++++
 net/openvswitch/datapath.h | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index bebaf16ba8af6..f4996c11aefac 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -39,15 +39,6 @@
 #include "flow_netlink.h"
 #include "openvswitch_trace.h"
=20
-struct deferred_action {
-	struct sk_buff *skb;
-	const struct nlattr *actions;
-	int actions_len;
-
-	/* Store pkt_key clone when creating deferred action. */
-	struct sw_flow_key pkt_key;
-};
-
 #define MAX_L2_LEN	(VLAN_ETH_HLEN + 3 * MPLS_HLEN)
 struct ovs_frag_data {
 	unsigned long dst;
@@ -64,28 +55,10 @@ struct ovs_frag_data {
=20
 static DEFINE_PER_CPU(struct ovs_frag_data, ovs_frag_data_storage);
=20
-#define DEFERRED_ACTION_FIFO_SIZE 10
-#define OVS_RECURSION_LIMIT 5
-#define OVS_DEFERRED_ACTION_THRESHOLD (OVS_RECURSION_LIMIT - 2)
-struct action_fifo {
-	int head;
-	int tail;
-	/* Deferred action fifo queue storage. */
-	struct deferred_action fifo[DEFERRED_ACTION_FIFO_SIZE];
+DEFINE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
 };
=20
-struct action_flow_keys {
-	struct sw_flow_key key[OVS_DEFERRED_ACTION_THRESHOLD];
-};
-
-struct ovs_pcpu_storage {
-	struct action_fifo action_fifos;
-	struct action_flow_keys flow_keys;
-	int exec_level;
-};
-
-static DEFINE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage);
-
 /* Make a clone of the 'key', using the pre-allocated percpu 'flow_keys'
  * space. Return NULL if out of key spaces.
  */
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index aaa6277bb49c2..b8f766978466d 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -244,11 +244,13 @@ void ovs_dp_detach_port(struct vport *p)
 /* Must be called with rcu_read_lock. */
 void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 {
+	struct ovs_pcpu_storage *ovs_pcpu =3D this_cpu_ptr(&ovs_pcpu_storage);
 	const struct vport *p =3D OVS_CB(skb)->input_vport;
 	struct datapath *dp =3D p->dp;
 	struct sw_flow *flow;
 	struct sw_flow_actions *sf_acts;
 	struct dp_stats_percpu *stats;
+	bool ovs_pcpu_locked =3D false;
 	u64 *stats_counter;
 	u32 n_mask_hit;
 	u32 n_cache_hit;
@@ -290,10 +292,26 @@ void ovs_dp_process_packet(struct sk_buff *skb, struc=
t sw_flow_key *key)
=20
 	ovs_flow_stats_update(flow, key->tp.flags, skb);
 	sf_acts =3D rcu_dereference(flow->sf_acts);
+	/* This path can be invoked recursively: Use the current task to
+	 * identify recursive invocation - the lock must be acquired only once.
+	 * Even with disabled bottom halves this can be preempted on PREEMPT_RT.
+	 * Limit the provecc to RT to avoid assigning `owner' if it can be
+	 * avoided.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && ovs_pcpu->owner !=3D current) {
+		local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
+		ovs_pcpu->owner =3D current;
+		ovs_pcpu_locked =3D true;
+	}
+
 	error =3D ovs_execute_actions(dp, skb, sf_acts, key);
 	if (unlikely(error))
 		net_dbg_ratelimited("ovs: action execution error on datapath %s: %d\n",
 				    ovs_dp_name(dp), error);
+	if (ovs_pcpu_locked) {
+		ovs_pcpu->owner =3D NULL;
+		local_unlock_nested_bh(&ovs_pcpu_storage.bh_lock);
+	}
=20
 	stats_counter =3D &stats->n_hit;
=20
@@ -671,7 +689,13 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb,=
 struct genl_info *info)
 	sf_acts =3D rcu_dereference(flow->sf_acts);
=20
 	local_bh_disable();
+	local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		this_cpu_write(ovs_pcpu_storage.owner, current);
 	err =3D ovs_execute_actions(dp, packet, sf_acts, &flow->key);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		this_cpu_write(ovs_pcpu_storage.owner, NULL);
+	local_unlock_nested_bh(&ovs_pcpu_storage.bh_lock);
 	local_bh_enable();
 	rcu_read_unlock();
=20
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index a126407926058..4a665c3cfa906 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -173,6 +173,39 @@ struct ovs_net {
 	bool xt_label;
 };
=20
+struct deferred_action {
+	struct sk_buff *skb;
+	const struct nlattr *actions;
+	int actions_len;
+
+	/* Store pkt_key clone when creating deferred action. */
+	struct sw_flow_key pkt_key;
+};
+
+#define DEFERRED_ACTION_FIFO_SIZE 10
+#define OVS_RECURSION_LIMIT 5
+#define OVS_DEFERRED_ACTION_THRESHOLD (OVS_RECURSION_LIMIT - 2)
+
+struct action_fifo {
+	int head;
+	int tail;
+	/* Deferred action fifo queue storage. */
+	struct deferred_action fifo[DEFERRED_ACTION_FIFO_SIZE];
+};
+
+struct action_flow_keys {
+	struct sw_flow_key key[OVS_DEFERRED_ACTION_THRESHOLD];
+};
+
+struct ovs_pcpu_storage {
+	struct action_fifo action_fifos;
+	struct action_flow_keys flow_keys;
+	int exec_level;
+	struct task_struct *owner;
+	local_lock_t bh_lock;
+};
+DECLARE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage);
+
 /**
  * enum ovs_pkt_hash_types - hash info to include with a packet
  * to send to userspace.
--=20
2.49.0


