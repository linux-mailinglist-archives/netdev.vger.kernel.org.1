Return-Path: <netdev+bounces-276249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNdRMF7D1Wkx9gcAu9opvQ
	(envelope-from <netdev+bounces-276249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:54:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 186FD3B6563
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDCBA302B14E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3503750C8;
	Wed,  8 Apr 2026 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkVtwTey"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BBD373C19
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616763; cv=none; b=jzrbWE1N5e5aknN6r8wE6Btp5H7urKdjPTV+ioaLH6BmGJjCYRiAEmGP8BA9mOpRdxaRq62Oi9SbzDHHgJlsVmdmFMXOn1dH+JoVtOWqwdDtGBfswCRlVb5dRc6bnKDjMlWRaMnZGi5qChQnFB2hRtun4k1deu/DwfSXGlIMBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616763; c=relaxed/simple;
	bh=eMqaikrJDeYNfUMhslQU9p/PNnQcABSE67+YKPMPpAs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QtQ7B6et5z401MS1yFrkH5Mpv1PUX/Ub5Q/qU+K+qfLAu7mkCZJT3ZerGXntymiSWdP67Ah848pTLxKqQONfYJk3Lg7srNX0hWpqmI7Uib3Arm4i6K7+4F82FTmhzxtrTKxirZiVeSeOrnwNOwRayCsDyTrGcTivLjemdu12vT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkVtwTey; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12737f276a2so9058163c88.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 19:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775616760; x=1776221560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCOV5PVZ0/9+BmL80DppSiUK4xF2oayBnBsK0SdDfuw=;
        b=hkVtwTeyYVG1yX7RVL5rlhE+lOgB2OvgQljUdDm6xUuJ/dYefHp4i028gnVOroTC82
         MZo5Q/wGzLdZL2XJLH7sZ5sUWrlrS4vM7KTFyZ1t4i+j9jkH4ZR3M+P2v3cFPXRNUcCc
         edXT8MjU62gjTzSbj5GZrDx3G7HhVDSUiHSBqjqdC4RX/7cBMJOAppEPn8FfcKDwU6lJ
         mDcagpLOEMQLW6q5F2Q9svhBtmZiY+AczPelXvRkqk58w7GY8T6Kqovs58bMDwQiYLoA
         alaHhDf1JdUKc9jVwYNjJlQTuI2HV8VHr33Jng5DjO/124+leIAAOS4EIiJr5euzdl+k
         6Q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775616760; x=1776221560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCOV5PVZ0/9+BmL80DppSiUK4xF2oayBnBsK0SdDfuw=;
        b=arlYCjpPKGjVyzFZmwfxkEErv6hj+n3RzdeY+PpoFHis/Dh2W1ABCwKZi5H4NuZCfW
         RS5eM5ZBuQDVU42x+62tmu3ASg5miwGl5yhfNdD1ovaHe9K2T1ZUTFfeyfTCRdM4NVCk
         Np/0rGMFqY4bct1H8f3tQTsrBGeVwCTlQMxLwgJUFuBiIqzF7QTV8Ctq9VjL4mX1BGkZ
         0xqxFXopqLQjviYyRGE80LzJzGqndDVKrscK3+X1NXXs41fB7Wg4MrIzVhJTnfC2S7zq
         MhYIlPrlkI5kYVNMFMlPRslLaLXjRGe7B5Gfl9hV2ibKHvsbAT+Ys5P4nyVfpFTwXrXh
         R60w==
X-Gm-Message-State: AOJu0Yx4Sc+LRRlEj02HDX5jlwUGwrT+XEWZoBX5xRN3YahzWdMQAS2o
	lTU/ghzNcnD654M833OOKG4v8CLejonXTLL6Y4Ah/ReaTPCVsUPJUWVKx9eI3JdtD+3uNNojW6g
	UDJiJn/bJDS8du9MlzcMCZg==
X-Received: from dycc15.prod.google.com ([2002:a05:693c:60cf:b0:2c6:415a:9023])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:62aa:b0:12a:72af:83d2 with SMTP id a92af1059eb24-12bfb7109c0mr9410902c88.14.1775616760223;
 Tue, 07 Apr 2026 19:52:40 -0700 (PDT)
Date: Wed, 08 Apr 2026 02:52:26 +0000
In-Reply-To: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775616747; l=9038;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=eMqaikrJDeYNfUMhslQU9p/PNnQcABSE67+YKPMPpAs=; b=Dd/qWxK0iiZ4X3BIMci8eyVnoG1gW8XzIWzDZs6nKEE1TG753dhyJkkrp7f3vLzlLG6xPNi0J
 zb8u79TiACUAjLZSNqMQlH1oUxeTK6j2RvJlSsAcBi2bCGiWDCQp6iX
X-Mailer: b4 0.14.3
Message-ID: <20260408-teaming-driver-internal-v6-7-e5bcdcf72504@google.com>
Subject: [PATCH net-next v6 07/10] net: team: Track rx enablement separately
 from tx enablement
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>, 
	Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276249-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 186FD3B6563
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Separate the rx and tx enablement/disablement into different
functions so that it is easier to interact with them independently
later.

Although this patch changes receive and transmit paths, the actual
behavior of the teaming driver should remain unchanged, since there
is no option introduced yet to change rx or tx enablement
independently. Those options will be added in follow-up patches.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v5:
- Reorder function calls in team_port_enable() to make sure the call
  order stays the same as before.
- Link to v4: https://lore.kernel.org/netdev/20260403-teaming-driver-internal-v4-7-d3032f33ca25@google.com/

Changes in v4:
- New patch: split from the original monolithic v3 patch "net: team:
  Decouple rx and tx enablement in the team driver".
- Link to v3: https://lore.kernel.org/netdev/20260402-teaming-driver-internal-v3-6-e8cfdec3b5c2@google.com/
---
 drivers/net/team/team_core.c             | 104 ++++++++++++++++++++++++-------
 drivers/net/team/team_mode_loadbalance.c |   2 +-
 include/linux/if_team.h                  |  16 ++++-
 3 files changed, 95 insertions(+), 27 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 826769473878..e437099a5a17 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -87,7 +87,7 @@ static void team_lower_state_changed(struct team_port *port)
 	struct netdev_lag_lower_state_info info;
 
 	info.link_up = port->linkup;
-	info.tx_enabled = team_port_enabled(port);
+	info.tx_enabled = team_port_tx_enabled(port);
 	netdev_lower_state_changed(port->dev, &info);
 }
 
@@ -538,7 +538,7 @@ static void team_adjust_ops(struct team *team)
 	else
 		team->ops.transmit = team->mode->ops->transmit;
 
-	if (!team->tx_en_port_count || !team_is_mode_set(team) ||
+	if (!team->rx_en_port_count || !team_is_mode_set(team) ||
 	    !team->mode->ops->receive)
 		team->ops.receive = team_dummy_receive;
 	else
@@ -734,7 +734,7 @@ static rx_handler_result_t team_handle_frame(struct sk_buff **pskb)
 
 	port = team_port_get_rcu(skb->dev);
 	team = port->team;
-	if (!team_port_enabled(port)) {
+	if (!team_port_rx_enabled(port)) {
 		if (is_link_local_ether_addr(eth_hdr(skb)->h_dest))
 			/* link-local packets are mostly useful when stack receives them
 			 * with the link they arrive on.
@@ -876,7 +876,7 @@ static void __team_queue_override_enabled_check(struct team *team)
 static void team_queue_override_port_prio_changed(struct team *team,
 						  struct team_port *port)
 {
-	if (!port->queue_id || !team_port_enabled(port))
+	if (!port->queue_id || !team_port_tx_enabled(port))
 		return;
 	__team_queue_override_port_del(team, port);
 	__team_queue_override_port_add(team, port);
@@ -887,7 +887,7 @@ static void team_queue_override_port_change_queue_id(struct team *team,
 						     struct team_port *port,
 						     u16 new_queue_id)
 {
-	if (team_port_enabled(port)) {
+	if (team_port_tx_enabled(port)) {
 		__team_queue_override_port_del(team, port);
 		port->queue_id = new_queue_id;
 		__team_queue_override_port_add(team, port);
@@ -927,26 +927,33 @@ static bool team_port_find(const struct team *team,
 	return false;
 }
 
+static void __team_port_enable_rx(struct team *team,
+				  struct team_port *port)
+{
+	team->rx_en_port_count++;
+	WRITE_ONCE(port->rx_enabled, true);
+}
+
+static void __team_port_disable_rx(struct team *team,
+				   struct team_port *port)
+{
+	team->rx_en_port_count--;
+	WRITE_ONCE(port->rx_enabled, false);
+}
+
 /*
- * Enable/disable port by adding to enabled port hashlist and setting
- * port->tx_index (Might be racy so reader could see incorrect ifindex when
- * processing a flying packet, but that is not a problem). Write guarded
- * by RTNL.
+ * Enable just TX on the port by adding to tx-enabled port hashlist and
+ * setting port->tx_index (Might be racy so reader could see incorrect
+ * ifindex when processing a flying packet, but that is not a problem).
+ * Write guarded by RTNL.
  */
-static void team_port_enable(struct team *team,
-			     struct team_port *port)
+static void __team_port_enable_tx(struct team *team,
+				  struct team_port *port)
 {
-	if (team_port_enabled(port))
-		return;
 	WRITE_ONCE(port->tx_index, team->tx_en_port_count);
 	WRITE_ONCE(team->tx_en_port_count, team->tx_en_port_count + 1);
 	hlist_add_head_rcu(&port->tx_hlist,
 			   team_tx_port_index_hash(team, port->tx_index));
-	team_adjust_ops(team);
-	team_queue_override_port_add(team, port);
-	team_notify_peers(team);
-	team_mcast_rejoin(team);
-	team_lower_state_changed(port);
 }
 
 static void __reconstruct_port_hlist(struct team *team, int rm_index)
@@ -965,20 +972,69 @@ static void __reconstruct_port_hlist(struct team *team, int rm_index)
 	}
 }
 
-static void team_port_disable(struct team *team,
-			      struct team_port *port)
+static void __team_port_disable_tx(struct team *team,
+				   struct team_port *port)
 {
-	if (!team_port_enabled(port))
-		return;
 	if (team->ops.port_tx_disabled)
 		team->ops.port_tx_disabled(team, port);
+
 	hlist_del_rcu(&port->tx_hlist);
 	__reconstruct_port_hlist(team, port->tx_index);
+
 	WRITE_ONCE(port->tx_index, -1);
 	WRITE_ONCE(team->tx_en_port_count, team->tx_en_port_count - 1);
-	team_queue_override_port_del(team, port);
+}
+
+/*
+ * Enable TX AND RX on the port.
+ */
+static void team_port_enable(struct team *team,
+			     struct team_port *port)
+{
+	bool rx_was_enabled;
+	bool tx_was_enabled;
+
+	if (team_port_enabled(port))
+		return;
+
+	rx_was_enabled = team_port_rx_enabled(port);
+	tx_was_enabled = team_port_tx_enabled(port);
+
+	if (!rx_was_enabled)
+		__team_port_enable_rx(team, port);
+	if (!tx_was_enabled)
+		__team_port_enable_tx(team, port);
+
+	team_adjust_ops(team);
+	if (!tx_was_enabled)
+		team_queue_override_port_add(team, port);
+	team_notify_peers(team);
+	if (!rx_was_enabled)
+		team_mcast_rejoin(team);
+	if (!tx_was_enabled)
+		team_lower_state_changed(port);
+}
+
+static void team_port_disable(struct team *team,
+			      struct team_port *port)
+{
+	bool rx_was_enabled = team_port_rx_enabled(port);
+	bool tx_was_enabled = team_port_tx_enabled(port);
+
+	if (!tx_was_enabled && !rx_was_enabled)
+		return;
+
+	if (tx_was_enabled) {
+		__team_port_disable_tx(team, port);
+		team_queue_override_port_del(team, port);
+	}
+	if (rx_was_enabled)
+		__team_port_disable_rx(team, port);
+
 	team_adjust_ops(team);
-	team_lower_state_changed(port);
+
+	if (tx_was_enabled)
+		team_lower_state_changed(port);
 }
 
 static int team_port_enter(struct team *team, struct team_port *port)
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 4833fbfe241e..38a459649569 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -380,7 +380,7 @@ static int lb_tx_hash_to_port_mapping_set(struct team *team,
 
 	list_for_each_entry(port, &team->port_list, list) {
 		if (ctx->data.u32_val == port->dev->ifindex &&
-		    team_port_enabled(port)) {
+		    team_port_tx_enabled(port)) {
 			rcu_assign_pointer(LB_HTPM_PORT_BY_HASH(lb_priv, hash),
 					   port);
 			return 0;
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index c777170ef552..3d21e06fda67 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -31,6 +31,7 @@ struct team_port {
 	struct list_head list; /* node in ordinary list */
 	struct team *team;
 	int tx_index; /* index of tx enabled port. If disabled, -1 */
+	bool rx_enabled;
 
 	bool linkup; /* either state.linkup or user.linkup */
 
@@ -75,14 +76,24 @@ static inline struct team_port *team_port_get_rcu(const struct net_device *dev)
 	return rcu_dereference(dev->rx_handler_data);
 }
 
-static inline bool team_port_enabled(struct team_port *port)
+static inline bool team_port_rx_enabled(struct team_port *port)
+{
+	return READ_ONCE(port->rx_enabled);
+}
+
+static inline bool team_port_tx_enabled(struct team_port *port)
 {
 	return READ_ONCE(port->tx_index) != -1;
 }
 
+static inline bool team_port_enabled(struct team_port *port)
+{
+	return team_port_rx_enabled(port) && team_port_tx_enabled(port);
+}
+
 static inline bool team_port_txable(struct team_port *port)
 {
-	return port->linkup && team_port_enabled(port);
+	return port->linkup && team_port_tx_enabled(port);
 }
 
 static inline bool team_port_dev_txable(const struct net_device *port_dev)
@@ -193,6 +204,7 @@ struct team {
 	 * List of tx-enabled ports and counts of rx and tx-enabled ports.
 	 */
 	int tx_en_port_count;
+	int rx_en_port_count;
 	struct hlist_head tx_en_port_hlist[TEAM_PORT_HASHENTRIES];
 
 	struct list_head port_list; /* list of all ports */

-- 
2.53.0.1213.gd9a14994de-goog


