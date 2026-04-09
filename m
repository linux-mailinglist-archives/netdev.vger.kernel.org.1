Return-Path: <netdev+bounces-276820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE2PHiwX12k1KwgAu9opvQ
	(envelope-from <netdev+bounces-276820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:04:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3553C5E42
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86F97307D8EF
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C27A371899;
	Thu,  9 Apr 2026 02:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDgvGSp7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F06B36CE12
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703597; cv=none; b=m3S3psQDWQ3cmnn5YV69+thgllkmu4VD7y/UkP2vdilQZ6EOZLRYV1MOl2YEdaqyE6ePUJ4lBxCiJ03sKLtuYCn5/gBW6Wgo1aOxCxOb16jZT2pSO/cSOajtMY9IBkyAj8Xd2u/+v0RWbRLrLhNJ5FIQMv9Cs3/96DoySd19T50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703597; c=relaxed/simple;
	bh=oH22fdqSNJSpaqo3JGrJKQygV29uz4pTKSxAP7bGPfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uEeeGzo7zXpA7dfEwkbZcuTePk/Z6P8NAJ2Da28JogvW/YS8fGTlmTDBYmwlhV1n2g19olHIvhkwlUP8Ob8j+Hd/sdS/ukCHaIMLJzwss/SrDbD3oTGeD4fCc6R8B18GaJSIVKyzPaa7KqHmjG2Lxx11R0N/bRLrSgxT12+kXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDgvGSp7; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so388800eec.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 19:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775703592; x=1776308392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ4xpDhza9yvGUIAi+VUP5bjGD/EsXUsUZaTLZUbPU4=;
        b=RDgvGSp7cKsV9anrWJcvEUPaKuCZHn3jR6cc1yuL2B9djarTJ1qrKQd4D+hYPPNkQc
         aILub9snFmYLFHbME7kKId1MO7bmoCgclXEYoepTYLTX2WOxFzGC7O2FOjbJJv5qULUy
         yjFGQyFcE8c0b5sS4npU5DNQTBscRkC/oHoPK4Ih2Tm8bfBYvHVmI+0nfrMk3198ltZO
         XoX0N18jRwa6Knj2/GN8zPfKzMR1gL8DVM12m3lM8SGXUwcdhh4sA06voFQpmZKujiia
         MGJJ+Fpl81ComsfQWRI9TGNkpSbbcnkM6cyz8U+o7Kv20A77sjYjIcZI0JzcZBb8VX25
         wuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775703592; x=1776308392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ4xpDhza9yvGUIAi+VUP5bjGD/EsXUsUZaTLZUbPU4=;
        b=Rn1kBA9y7ZhDNainRwrkYOsFROF/cVuxMfTFRGhGujtTLFQlZPggyQiDwL/J5OVgdp
         8p0gw1o7jk5Yr7CyZS76GKATpJSDD2PMc1hsTOVEGG5Phyq1UNg4YHBEedIw0SAnqDsQ
         TduZv9j5h+uOQzpgbbt+S5UHAvfzxufiWwlDBUeL7G3tUZWL3Epa5feH/lFpQ1fnglGZ
         Bh+tS2uZgaReQRN/y6ahx1vbcGuZlgt1kkP6B5KlTZ2hc5lxYH3nZs0kOh8s7ywg3GWs
         SvIwmUGUSJ6fpPek4erlNvMUsk3ozp13aYWpI0nXqFpIY2cPdVF6/Ts2x5XqNJuOmORF
         gmMw==
X-Gm-Message-State: AOJu0Yyv6mOKf1Oi/tW/JDtisT0vDcxeveqTs4+I+cQiIvePsyjKKqXN
	r7DvKqeZNC5DxwUWmOPiHF57EF/FIL7pq2Was1vT3QGjJNYicvahsNGpp11rdWuwRR3VVYCZRVn
	X8wvwliiliLyNs6JOcmmAig==
X-Received: from dybph21.prod.google.com ([2002:a05:7301:4195:b0:2ca:280a:302a])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:7306:b0:2cc:3684:d1 with SMTP id 5a478bee46e88-2cc368401b3mr8179456eec.28.1775703591326;
 Wed, 08 Apr 2026 19:59:51 -0700 (PDT)
Date: Thu, 09 Apr 2026 02:59:28 +0000
In-Reply-To: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775703578; l=10753;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=oH22fdqSNJSpaqo3JGrJKQygV29uz4pTKSxAP7bGPfQ=; b=QK8/R0HyI3/Uo4I+jmVmUxA0ZSrcQ1cuOvcYHArK3FYkNv5jFSW7dIU0VVnTKptfXwM0eE9Jm
 dTfZoLIdA1oBl7EnO01Q3du6a2L+cc6rVaFz1GTJNQn4VHi0VUkqFli
X-Mailer: b4 0.14.3
Message-ID: <20260409-teaming-driver-internal-v7-6-f47e7589685d@google.com>
Subject: [PATCH net-next v7 06/10] net: team: Rename enablement functions and
 struct members to tx
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
	Marc Harvey <marcharvey@google.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276820-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: EC3553C5E42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add no functional changes, but rename enablement functions, variables
etc. that are used in teaming driver transmit decisions.

Since rx and tx enablement are still coupled, some of the variables
renamed in this patch are still used for the rx path, but that will
change in a follow-up patch.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v4:
- New patch: split from the original monolithic v3 patch "net: team:
  Decouple rx and tx enablement in the team driver".
- Link to v3: https://lore.kernel.org/netdev/20260402-teaming-driver-internal-v3-6-e8cfdec3b5c2@google.com/
---
 drivers/net/team/team_core.c             | 44 +++++++++++++++---------------
 drivers/net/team/team_mode_loadbalance.c |  2 +-
 drivers/net/team/team_mode_random.c      |  4 +--
 drivers/net/team/team_mode_roundrobin.c  |  2 +-
 include/linux/if_team.h                  | 46 +++++++++++++++++---------------
 5 files changed, 51 insertions(+), 47 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 2ce31999c99f..826769473878 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -532,13 +532,13 @@ static void team_adjust_ops(struct team *team)
 	 * correct ops are always set.
 	 */
 
-	if (!team->en_port_count || !team_is_mode_set(team) ||
+	if (!team->tx_en_port_count || !team_is_mode_set(team) ||
 	    !team->mode->ops->transmit)
 		team->ops.transmit = team_dummy_transmit;
 	else
 		team->ops.transmit = team->mode->ops->transmit;
 
-	if (!team->en_port_count || !team_is_mode_set(team) ||
+	if (!team->tx_en_port_count || !team_is_mode_set(team) ||
 	    !team->mode->ops->receive)
 		team->ops.receive = team_dummy_receive;
 	else
@@ -831,7 +831,7 @@ static bool team_queue_override_port_has_gt_prio_than(struct team_port *port,
 		return true;
 	if (port->priority > cur->priority)
 		return false;
-	if (port->index < cur->index)
+	if (port->tx_index < cur->tx_index)
 		return true;
 	return false;
 }
@@ -929,7 +929,7 @@ static bool team_port_find(const struct team *team,
 
 /*
  * Enable/disable port by adding to enabled port hashlist and setting
- * port->index (Might be racy so reader could see incorrect ifindex when
+ * port->tx_index (Might be racy so reader could see incorrect ifindex when
  * processing a flying packet, but that is not a problem). Write guarded
  * by RTNL.
  */
@@ -938,10 +938,10 @@ static void team_port_enable(struct team *team,
 {
 	if (team_port_enabled(port))
 		return;
-	WRITE_ONCE(port->index, team->en_port_count);
-	WRITE_ONCE(team->en_port_count, team->en_port_count + 1);
-	hlist_add_head_rcu(&port->hlist,
-			   team_port_index_hash(team, port->index));
+	WRITE_ONCE(port->tx_index, team->tx_en_port_count);
+	WRITE_ONCE(team->tx_en_port_count, team->tx_en_port_count + 1);
+	hlist_add_head_rcu(&port->tx_hlist,
+			   team_tx_port_index_hash(team, port->tx_index));
 	team_adjust_ops(team);
 	team_queue_override_port_add(team, port);
 	team_notify_peers(team);
@@ -951,15 +951,17 @@ static void team_port_enable(struct team *team,
 
 static void __reconstruct_port_hlist(struct team *team, int rm_index)
 {
-	int i;
+	struct hlist_head *tx_port_index_hash;
 	struct team_port *port;
+	int i;
 
-	for (i = rm_index + 1; i < team->en_port_count; i++) {
-		port = team_get_port_by_index(team, i);
-		hlist_del_rcu(&port->hlist);
-		WRITE_ONCE(port->index, port->index - 1);
-		hlist_add_head_rcu(&port->hlist,
-				   team_port_index_hash(team, port->index));
+	for (i = rm_index + 1; i < team->tx_en_port_count; i++) {
+		port = team_get_port_by_tx_index(team, i);
+		hlist_del_rcu(&port->tx_hlist);
+		WRITE_ONCE(port->tx_index, port->tx_index - 1);
+		tx_port_index_hash = team_tx_port_index_hash(team,
+							     port->tx_index);
+		hlist_add_head_rcu(&port->tx_hlist, tx_port_index_hash);
 	}
 }
 
@@ -970,10 +972,10 @@ static void team_port_disable(struct team *team,
 		return;
 	if (team->ops.port_tx_disabled)
 		team->ops.port_tx_disabled(team, port);
-	hlist_del_rcu(&port->hlist);
-	__reconstruct_port_hlist(team, port->index);
-	WRITE_ONCE(port->index, -1);
-	WRITE_ONCE(team->en_port_count, team->en_port_count - 1);
+	hlist_del_rcu(&port->tx_hlist);
+	__reconstruct_port_hlist(team, port->tx_index);
+	WRITE_ONCE(port->tx_index, -1);
+	WRITE_ONCE(team->tx_en_port_count, team->tx_en_port_count - 1);
 	team_queue_override_port_del(team, port);
 	team_adjust_ops(team);
 	team_lower_state_changed(port);
@@ -1244,7 +1246,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		netif_addr_unlock_bh(dev);
 	}
 
-	WRITE_ONCE(port->index, -1);
+	WRITE_ONCE(port->tx_index, -1);
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
 	netdev_compute_master_upper_features(dev, true);
@@ -1595,7 +1597,7 @@ static int team_init(struct net_device *dev)
 		return -ENOMEM;
 
 	for (i = 0; i < TEAM_PORT_HASHENTRIES; i++)
-		INIT_HLIST_HEAD(&team->en_port_hlist[i]);
+		INIT_HLIST_HEAD(&team->tx_en_port_hlist[i]);
 	INIT_LIST_HEAD(&team->port_list);
 	err = team_queue_override_init(team);
 	if (err)
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 840f409d250b..4833fbfe241e 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -120,7 +120,7 @@ static struct team_port *lb_hash_select_tx_port(struct team *team,
 {
 	int port_index = team_num_to_port_index(team, hash);
 
-	return team_get_port_by_index_rcu(team, port_index);
+	return team_get_port_by_tx_index_rcu(team, port_index);
 }
 
 /* Hash to port mapping select tx port */
diff --git a/drivers/net/team/team_mode_random.c b/drivers/net/team/team_mode_random.c
index 169a7bc865b2..370e974f3dca 100644
--- a/drivers/net/team/team_mode_random.c
+++ b/drivers/net/team/team_mode_random.c
@@ -16,8 +16,8 @@ static bool rnd_transmit(struct team *team, struct sk_buff *skb)
 	struct team_port *port;
 	int port_index;
 
-	port_index = get_random_u32_below(READ_ONCE(team->en_port_count));
-	port = team_get_port_by_index_rcu(team, port_index);
+	port_index = get_random_u32_below(READ_ONCE(team->tx_en_port_count));
+	port = team_get_port_by_tx_index_rcu(team, port_index);
 	if (unlikely(!port))
 		goto drop;
 	port = team_get_first_port_txable_rcu(team, port);
diff --git a/drivers/net/team/team_mode_roundrobin.c b/drivers/net/team/team_mode_roundrobin.c
index dd405d82c6ac..ecbeef28c221 100644
--- a/drivers/net/team/team_mode_roundrobin.c
+++ b/drivers/net/team/team_mode_roundrobin.c
@@ -27,7 +27,7 @@ static bool rr_transmit(struct team *team, struct sk_buff *skb)
 
 	port_index = team_num_to_port_index(team,
 					    rr_priv(team)->sent_packets++);
-	port = team_get_port_by_index_rcu(team, port_index);
+	port = team_get_port_by_tx_index_rcu(team, port_index);
 	if (unlikely(!port))
 		goto drop;
 	port = team_get_first_port_txable_rcu(team, port);
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 740cb3100dfc..c777170ef552 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -27,10 +27,10 @@ struct team;
 
 struct team_port {
 	struct net_device *dev;
-	struct hlist_node hlist; /* node in enabled ports hash list */
+	struct hlist_node tx_hlist; /* node in tx-enabled ports hash list */
 	struct list_head list; /* node in ordinary list */
 	struct team *team;
-	int index; /* index of enabled port. If disabled, it's set to -1 */
+	int tx_index; /* index of tx enabled port. If disabled, -1 */
 
 	bool linkup; /* either state.linkup or user.linkup */
 
@@ -77,7 +77,7 @@ static inline struct team_port *team_port_get_rcu(const struct net_device *dev)
 
 static inline bool team_port_enabled(struct team_port *port)
 {
-	return READ_ONCE(port->index) != -1;
+	return READ_ONCE(port->tx_index) != -1;
 }
 
 static inline bool team_port_txable(struct team_port *port)
@@ -190,10 +190,10 @@ struct team {
 	const struct header_ops *header_ops_cache;
 
 	/*
-	 * List of enabled ports and their count
+	 * List of tx-enabled ports and counts of rx and tx-enabled ports.
 	 */
-	int en_port_count;
-	struct hlist_head en_port_hlist[TEAM_PORT_HASHENTRIES];
+	int tx_en_port_count;
+	struct hlist_head tx_en_port_hlist[TEAM_PORT_HASHENTRIES];
 
 	struct list_head port_list; /* list of all ports */
 
@@ -237,41 +237,43 @@ static inline int team_dev_queue_xmit(struct team *team, struct team_port *port,
 	return dev_queue_xmit(skb);
 }
 
-static inline struct hlist_head *team_port_index_hash(struct team *team,
-						      int port_index)
+static inline struct hlist_head *team_tx_port_index_hash(struct team *team,
+							 int tx_port_index)
 {
-	return &team->en_port_hlist[port_index & (TEAM_PORT_HASHENTRIES - 1)];
+	unsigned int list_entry = tx_port_index & (TEAM_PORT_HASHENTRIES - 1);
+
+	return &team->tx_en_port_hlist[list_entry];
 }
 
-static inline struct team_port *team_get_port_by_index(struct team *team,
-						       int port_index)
+static inline struct team_port *team_get_port_by_tx_index(struct team *team,
+							  int tx_port_index)
 {
+	struct hlist_head *head = team_tx_port_index_hash(team, tx_port_index);
 	struct team_port *port;
-	struct hlist_head *head = team_port_index_hash(team, port_index);
 
-	hlist_for_each_entry(port, head, hlist)
-		if (port->index == port_index)
+	hlist_for_each_entry(port, head, tx_hlist)
+		if (port->tx_index == tx_port_index)
 			return port;
 	return NULL;
 }
 
 static inline int team_num_to_port_index(struct team *team, unsigned int num)
 {
-	int en_port_count = READ_ONCE(team->en_port_count);
+	int tx_en_port_count = READ_ONCE(team->tx_en_port_count);
 
-	if (unlikely(!en_port_count))
+	if (unlikely(!tx_en_port_count))
 		return 0;
-	return num % en_port_count;
+	return num % tx_en_port_count;
 }
 
-static inline struct team_port *team_get_port_by_index_rcu(struct team *team,
-							   int port_index)
+static inline struct team_port *team_get_port_by_tx_index_rcu(struct team *team,
+							      int tx_port_index)
 {
+	struct hlist_head *head = team_tx_port_index_hash(team, tx_port_index);
 	struct team_port *port;
-	struct hlist_head *head = team_port_index_hash(team, port_index);
 
-	hlist_for_each_entry_rcu(port, head, hlist)
-		if (READ_ONCE(port->index) == port_index)
+	hlist_for_each_entry_rcu(port, head, tx_hlist)
+		if (READ_ONCE(port->tx_index) == tx_port_index)
 			return port;
 	return NULL;
 }

-- 
2.53.0.1213.gd9a14994de-goog


