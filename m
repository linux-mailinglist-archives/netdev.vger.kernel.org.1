Return-Path: <netdev+bounces-173303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31351A58506
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F823AD193
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE821EB5CE;
	Sun,  9 Mar 2025 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g5WS/I5Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cizgkai2"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762591CAA82
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531635; cv=none; b=fHa4hHn5Vg2kSSPNFGN/1Bg7Xs7wGfHkT99meUbKOk5091T0ULxNwuZBWrD0UAdT5MEz66W9YsFBFBsoOQDNer7Pf4oFvG67wUXnVVTlUCCvCBSE3qMcweEwNYMuwZllRMvLRVHNDC0bNMRPA1s0hBoL7lAi7icHRlliO/Ik9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531635; c=relaxed/simple;
	bh=gx+3pA1xypEJIOgecxEu+S7TciZ+6AtG896/3aVu7zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fa5CQg6/LOnfFTGSE2Fkxs9VKrpQrsWJL+PlHLgrMetvrAT93Yte/CwWMZMhxufS/FBeEygTRaOJ5J/vrw6bU+6xqtuPQFZNUI8Ere6glDWAmTKw0u7E+/bapPTEBEJDwWalV1iPgjWzMMhZ/J5HpVVT+rI2O85QRs35SohjCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g5WS/I5Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cizgkai2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UyUyvZ2gbpz7ldtdWmJpnUwK+MzrqxKuihxzEiTpbTA=;
	b=g5WS/I5YoksASSyVPo2iytPMYEPRMsPaEvuQBHivYuF/A+amLHtppcRJANmNnqhUSYhVp/
	lgd+HOOkzG1OATyM9cXrXiAuap+v0iY5TA8oPXz9qnJR95gOXlu9fZw7+6bz47P6o17T5y
	6rwWbErBor6eUWlADdoEnW5Fx1uG0wDlP2nVSSsDntSkKWvehjdWfAJMG/QBgF9f2C/RDa
	OOCc9HvCDpEs8AF9VmzVEYVTzAynMlPzdVRbvyhyjchNsc1XX3gG5UF5Uh8HSQ6lIKLS2G
	zl8xM7EXiofzrmYTtwLO0oCYB9V2ADkPwzKy3HCTq0ehWu3XRH7EX4NKpEEe+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UyUyvZ2gbpz7ldtdWmJpnUwK+MzrqxKuihxzEiTpbTA=;
	b=cizgkai2B7dEE+5hLSSORCTMB9AkEoQLcsKNlPG8BRkKNaJLrhkQOPTALUote0xullz6cS
	hyw4DeLCnuVjsfDA==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Pravin B Shelar <pshelar@ovn.org>,
	dev@openvswitch.org
Subject: [PATCH net-next 10/18] openvswitch: Merge three per-CPU structures into one.
Date: Sun,  9 Mar 2025 15:46:45 +0100
Message-ID: <20250309144653.825351-11-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
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

Merge the three per-CPU variables into ovs_action, adapt callers.

Cc: Pravin B Shelar <pshelar@ovn.org>
Cc: dev@openvswitch.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/openvswitch/actions.c  | 49 +++++++++++++-------------------------
 net/openvswitch/datapath.c |  9 +------
 net/openvswitch/datapath.h |  3 ---
 3 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 704c858cf2093..322ca7b30c3bc 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -78,17 +78,22 @@ struct action_flow_keys {
 	struct sw_flow_key key[OVS_DEFERRED_ACTION_THRESHOLD];
 };
=20
-static struct action_fifo __percpu *action_fifos;
-static struct action_flow_keys __percpu *flow_keys;
-static DEFINE_PER_CPU(int, exec_actions_level);
+struct ovs_action {
+	struct action_fifo action_fifos;
+	struct action_flow_keys flow_keys;
+	int exec_level;
+};
+
+static DEFINE_PER_CPU(struct ovs_action, ovs_actions);
=20
 /* Make a clone of the 'key', using the pre-allocated percpu 'flow_keys'
  * space. Return NULL if out of key spaces.
  */
 static struct sw_flow_key *clone_key(const struct sw_flow_key *key_)
 {
-	struct action_flow_keys *keys =3D this_cpu_ptr(flow_keys);
-	int level =3D this_cpu_read(exec_actions_level);
+	struct ovs_action *ovs_act =3D this_cpu_ptr(&ovs_actions);
+	struct action_flow_keys *keys =3D &ovs_act->flow_keys;
+	int level =3D ovs_act->exec_level;
 	struct sw_flow_key *key =3D NULL;
=20
 	if (level <=3D OVS_DEFERRED_ACTION_THRESHOLD) {
@@ -132,10 +137,9 @@ static struct deferred_action *add_deferred_actions(st=
ruct sk_buff *skb,
 				    const struct nlattr *actions,
 				    const int actions_len)
 {
-	struct action_fifo *fifo;
+	struct action_fifo *fifo =3D this_cpu_ptr(&ovs_actions.action_fifos);
 	struct deferred_action *da;
=20
-	fifo =3D this_cpu_ptr(action_fifos);
 	da =3D action_fifo_put(fifo);
 	if (da) {
 		da->skb =3D skb;
@@ -1615,13 +1619,13 @@ static int clone_execute(struct datapath *dp, struc=
t sk_buff *skb,
=20
 		if (actions) { /* Sample action */
 			if (clone_flow_key)
-				__this_cpu_inc(exec_actions_level);
+				__this_cpu_inc(ovs_actions.exec_level);
=20
 			err =3D do_execute_actions(dp, skb, clone,
 						 actions, len);
=20
 			if (clone_flow_key)
-				__this_cpu_dec(exec_actions_level);
+				__this_cpu_dec(ovs_actions.exec_level);
 		} else { /* Recirc action */
 			clone->recirc_id =3D recirc_id;
 			ovs_dp_process_packet(skb, clone);
@@ -1657,7 +1661,7 @@ static int clone_execute(struct datapath *dp, struct =
sk_buff *skb,
=20
 static void process_deferred_actions(struct datapath *dp)
 {
-	struct action_fifo *fifo =3D this_cpu_ptr(action_fifos);
+	struct action_fifo *fifo =3D this_cpu_ptr(&ovs_actions.action_fifos);
=20
 	/* Do not touch the FIFO in case there is no deferred actions. */
 	if (action_fifo_is_empty(fifo))
@@ -1688,7 +1692,7 @@ int ovs_execute_actions(struct datapath *dp, struct s=
k_buff *skb,
 {
 	int err, level;
=20
-	level =3D __this_cpu_inc_return(exec_actions_level);
+	level =3D __this_cpu_inc_return(ovs_actions.exec_level);
 	if (unlikely(level > OVS_RECURSION_LIMIT)) {
 		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, proba=
ble configuration error\n",
 				     ovs_dp_name(dp));
@@ -1705,27 +1709,6 @@ int ovs_execute_actions(struct datapath *dp, struct =
sk_buff *skb,
 		process_deferred_actions(dp);
=20
 out:
-	__this_cpu_dec(exec_actions_level);
+	__this_cpu_dec(ovs_actions.exec_level);
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
index 365b9bb7f546e..1fce99992d25d 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -270,9 +270,6 @@ int ovs_execute_actions(struct datapath *dp, struct sk_=
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
2.47.2


