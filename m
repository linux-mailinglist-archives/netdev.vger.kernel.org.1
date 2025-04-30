Return-Path: <netdev+bounces-187068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EA8AA4BA7
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7E41C04163
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A625F7B1;
	Wed, 30 Apr 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RVI1Lw2o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A1BF97Mg"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB38E25D8E7
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017299; cv=none; b=kN50JV73t7PvMd8zyO8g+hk5JuQA2+dBFRdVJ+QIN6yV6k5P9r24F7syVUCftslGcq6D7kFV9uTzcZNZTzqEbxIvxk8i1NLdezcQ8gVFdxDR+c2/HuwZcajtCPT2GsgPymbE3Mh6pLptgn4aRmlOV4uFcPldTvCK4fn050zKuo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017299; c=relaxed/simple;
	bh=bEWL0pVq0EBDlXfIZ2SPz8ZWrtWM6bM2KECMeiUlMd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwiHkP6TOaD09zMrkmFNERM87Fjmrhm9rKudKXhAgrhXhJUEOYVMLbqOduQLMeB3Y4XOhvNWM1CVb4uLxz9u1JEnyRmDIOlkS35395UW3WwhTUxeFILfcwSHoktmLXNiSguTDybFGuKgnA5lABixD9c10z01tWAxVeoD8NY69Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RVI1Lw2o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A1BF97Mg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746017293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQCXC/uVgpSDNQQQhkgw6eLXiyOg5+jam5JRoJqv1Bo=;
	b=RVI1Lw2o7iwQuEmghqU8fPZ23pDwFFkYL8WT0TVfQTsLHhvkbRSjAvQeDJoyTwic3P+Qud
	O/8/OV7g94D0H6WfO4pcLGQJG+yI25OWJlppvoTcrDyYhDraLlbf4Tnw6z1DXVteL320Nv
	7prbgQcKmUGRQUSsihJ2Q94dCD5iGt4EjZbP0bFZPqPQsZnkQ92eJlGoLgGfBw7lJpbY/R
	SpGL2zGPYnPwjWkYGvKVWYIrXlwkpO3CHp1Fp7VNiJicFsXFTuZIAMw+azMag0wjWpxI8j
	ChGBPoENHw6CrSkRgokl8eO+79D/YY32E/kxZUHjyqA9y3v94OWKIbRIxETI4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746017293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQCXC/uVgpSDNQQQhkgw6eLXiyOg5+jam5JRoJqv1Bo=;
	b=A1BF97MgmX/4rCtruGSzW/dGsOq1oL+PrTljSGdvm/3H9psINnpxt3TTI36wUkKBGevT8k
	0q3AYmQr6uQmlpBQ==
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
Subject: [PATCH net-next v3 10/18] openvswitch: Merge three per-CPU structures into one
Date: Wed, 30 Apr 2025 14:47:50 +0200
Message-ID: <20250430124758.1159480-11-bigeasy@linutronix.de>
In-Reply-To: <20250430124758.1159480-1-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

exec_actions_level is a per-CPU integer allocated at compile time.
action_fifos and flow_keys are per-CPU pointer and have their data
allocated at module init time.
There is no gain in splitting it, once the module is allocated, the
structures are allocated.

Merge the three per-CPU variables into ovs_pcpu_storage, adapt callers.

Cc: Aaron Conole <aconole@redhat.com>
Cc: Eelco Chaudron <echaudro@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: dev@openvswitch.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/openvswitch/actions.c  | 49 +++++++++++++-------------------------
 net/openvswitch/datapath.c |  9 +------
 net/openvswitch/datapath.h |  3 ---
 3 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 61fea7baae5d5..bebaf16ba8af6 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -78,17 +78,22 @@ struct action_flow_keys {
 	struct sw_flow_key key[OVS_DEFERRED_ACTION_THRESHOLD];
 };
=20
-static struct action_fifo __percpu *action_fifos;
-static struct action_flow_keys __percpu *flow_keys;
-static DEFINE_PER_CPU(int, exec_actions_level);
+struct ovs_pcpu_storage {
+	struct action_fifo action_fifos;
+	struct action_flow_keys flow_keys;
+	int exec_level;
+};
+
+static DEFINE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage);
=20
 /* Make a clone of the 'key', using the pre-allocated percpu 'flow_keys'
  * space. Return NULL if out of key spaces.
  */
 static struct sw_flow_key *clone_key(const struct sw_flow_key *key_)
 {
-	struct action_flow_keys *keys =3D this_cpu_ptr(flow_keys);
-	int level =3D this_cpu_read(exec_actions_level);
+	struct ovs_pcpu_storage *ovs_pcpu =3D this_cpu_ptr(&ovs_pcpu_storage);
+	struct action_flow_keys *keys =3D &ovs_pcpu->flow_keys;
+	int level =3D ovs_pcpu->exec_level;
 	struct sw_flow_key *key =3D NULL;
=20
 	if (level <=3D OVS_DEFERRED_ACTION_THRESHOLD) {
@@ -132,10 +137,9 @@ static struct deferred_action *add_deferred_actions(st=
ruct sk_buff *skb,
 				    const struct nlattr *actions,
 				    const int actions_len)
 {
-	struct action_fifo *fifo;
+	struct action_fifo *fifo =3D this_cpu_ptr(&ovs_pcpu_storage.action_fifos);
 	struct deferred_action *da;
=20
-	fifo =3D this_cpu_ptr(action_fifos);
 	da =3D action_fifo_put(fifo);
 	if (da) {
 		da->skb =3D skb;
@@ -1609,13 +1613,13 @@ static int clone_execute(struct datapath *dp, struc=
t sk_buff *skb,
=20
 		if (actions) { /* Sample action */
 			if (clone_flow_key)
-				__this_cpu_inc(exec_actions_level);
+				__this_cpu_inc(ovs_pcpu_storage.exec_level);
=20
 			err =3D do_execute_actions(dp, skb, clone,
 						 actions, len);
=20
 			if (clone_flow_key)
-				__this_cpu_dec(exec_actions_level);
+				__this_cpu_dec(ovs_pcpu_storage.exec_level);
 		} else { /* Recirc action */
 			clone->recirc_id =3D recirc_id;
 			ovs_dp_process_packet(skb, clone);
@@ -1651,7 +1655,7 @@ static int clone_execute(struct datapath *dp, struct =
sk_buff *skb,
=20
 static void process_deferred_actions(struct datapath *dp)
 {
-	struct action_fifo *fifo =3D this_cpu_ptr(action_fifos);
+	struct action_fifo *fifo =3D this_cpu_ptr(&ovs_pcpu_storage.action_fifos);
=20
 	/* Do not touch the FIFO in case there is no deferred actions. */
 	if (action_fifo_is_empty(fifo))
@@ -1682,7 +1686,7 @@ int ovs_execute_actions(struct datapath *dp, struct s=
k_buff *skb,
 {
 	int err, level;
=20
-	level =3D __this_cpu_inc_return(exec_actions_level);
+	level =3D __this_cpu_inc_return(ovs_pcpu_storage.exec_level);
 	if (unlikely(level > OVS_RECURSION_LIMIT)) {
 		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, proba=
ble configuration error\n",
 				     ovs_dp_name(dp));
@@ -1699,27 +1703,6 @@ int ovs_execute_actions(struct datapath *dp, struct =
sk_buff *skb,
 		process_deferred_actions(dp);
=20
 out:
-	__this_cpu_dec(exec_actions_level);
+	__this_cpu_dec(ovs_pcpu_storage.exec_level);
 	return err;
 }
-
-int action_fifos_init(void)
-{
-	action_fifos =3D alloc_percpu(struct action_fifo);
-	if (!action_fifos)
-		return -ENOMEM;
-
-	flow_keys =3D alloc_percpu(struct action_flow_keys);
-	if (!flow_keys) {
-		free_percpu(action_fifos);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-void action_fifos_exit(void)
-{
-	free_percpu(action_fifos);
-	free_percpu(flow_keys);
-}
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 5d548eda742df..aaa6277bb49c2 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2729,13 +2729,9 @@ static int __init dp_init(void)
=20
 	pr_info("Open vSwitch switching datapath\n");
=20
-	err =3D action_fifos_init();
-	if (err)
-		goto error;
-
 	err =3D ovs_internal_dev_rtnl_link_register();
 	if (err)
-		goto error_action_fifos_exit;
+		goto error;
=20
 	err =3D ovs_flow_init();
 	if (err)
@@ -2778,8 +2774,6 @@ static int __init dp_init(void)
 	ovs_flow_exit();
 error_unreg_rtnl_link:
 	ovs_internal_dev_rtnl_link_unregister();
-error_action_fifos_exit:
-	action_fifos_exit();
 error:
 	return err;
 }
@@ -2795,7 +2789,6 @@ static void dp_cleanup(void)
 	ovs_vport_exit();
 	ovs_flow_exit();
 	ovs_internal_dev_rtnl_link_unregister();
-	action_fifos_exit();
 }
=20
 module_init(dp_init);
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 384ca77f4e794..a126407926058 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -281,9 +281,6 @@ int ovs_execute_actions(struct datapath *dp, struct sk_=
buff *skb,
=20
 void ovs_dp_notify_wq(struct work_struct *work);
=20
-int action_fifos_init(void);
-void action_fifos_exit(void);
-
 /* 'KEY' must not have any bits set outside of the 'MASK' */
 #define OVS_MASKED(OLD, KEY, MASK) ((KEY) | ((OLD) & ~(MASK)))
 #define OVS_SET_MASKED(OLD, KEY, MASK) ((OLD) =3D OVS_MASKED(OLD, KEY, MAS=
K))
--=20
2.49.0


