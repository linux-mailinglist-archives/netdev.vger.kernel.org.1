Return-Path: <netdev+bounces-273902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKjoGiO3zGnMVwYAu9opvQ
	(envelope-from <netdev+bounces-273902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:11:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1630137513E
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCE9130F3133
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 06:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA802DF3F2;
	Wed,  1 Apr 2026 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlZlwc+3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA9333727
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 06:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775023552; cv=none; b=pQnuMRFHwF18yCxeRWs+8SMs2FmyWaCEutDiLpnpcAf82xlUh3G+kbBiyziGlYRB4cl5CYE8IaVSDNktBDThtRS72IndFXfKiIPPbG1kxLN/DxNb4HX+xNln6y7U3VZfAyEpnvcw03E2NW3JSbsbQzujy5Z33y2iBmkDl09FYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775023552; c=relaxed/simple;
	bh=cz1UQUY9YQJLilTEJn4TLXI+9W35mi+oIsWZFttvuns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rHB9O/FiYW4HWaNRUCp3zpIsZPD651aYhsjGwc90NuSJyXqt3CESwJYV9Ro/ZiQ3omsmAP1qNGi5hWPKAiTyqx5qsaLsZWhZoowup1eLA3cIut9S+aiT82wFyQjUAiKlWTXAZ2unVdNC+GN4eZwsPXV+n981BHpx6aeptFQnGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jlZlwc+3; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c7f2b72c91so13238834eec.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775023550; x=1775628350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cuYgE2YbSvQcBffd2lsPUBv8j5gtRNwWojLcek0U8ig=;
        b=jlZlwc+3td/pd+Ba79/PbsRKW0KL47/JjTJEKt/AdyQ6e2/CKwbKf6ijyfkKgyQffp
         1mg+3CIqmMo0MCDV9NkIsmBRzmRO1hhS9csT0sh4mIbwW9OSd4+50LjsZIVc1DZQKpbd
         umqn7vYB3U9AHpi85hkreVrxZi/ypDBLfRsgQzok9eqLylpCavRzhUYTxYbry/83qcBf
         5robvEy9e+aKCfnWwpUmQ5Dxb8kHwNc1SFr1cINO86A0JbAYBgzO71ZRwyiBzRRmz3CQ
         zmyUWmkjy2XRBvXeWc5fPPM8m4HhnDKHowU2mZziTiYQ2SlgEbR2gwurbq180cWvUkp1
         AYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775023550; x=1775628350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuYgE2YbSvQcBffd2lsPUBv8j5gtRNwWojLcek0U8ig=;
        b=i4QeMpdAJKuwLCGoUd9+4U/lXUKa/BW4arhUEVeVEU7spKctHaCn+/t5JHDghLTAug
         sKrS1X7Gfk8hSI4YAt12HSiD79/02e28rDj7/sr3KsPLZSecaAgL1wXCQzOIPqvHlxPF
         g6Ii7UNLw2pQOSTioyng3jYoiNrbO355Txe/K6J5chI2lSOt50Lik0g8AunrIRZOWCU1
         F/GumJwcimwXHgxKHbeXHqH55FFa2VtNRnJVcOPrHdZ98yu6RXw5iaQ9hxy3ZHq19Gx8
         w1+ajYSe64ZIb4fm0vieKWELRsigpDAst8P+Q6KJ0BBpCQwFg53otY/H6dIcAbMgRTSA
         dYkw==
X-Gm-Message-State: AOJu0YwgmrzzoaUTlOTRsfy7BAiUjFY3PnvnWcfI9/3WNhNQGRCLa4nz
	/YhhlLqTVvlMKNN0I8r0/+R0wwOhoeaqMuGH3mkoIi6t+Bwknfu6rzLOzE/xZ3U4MgKwU5siFGg
	IzwBtEbaNlXhHaXXUqnyK5w==
X-Received: from dycag12.prod.google.com ([2002:a05:7300:fa0c:b0:2c8:8992:d026])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:a498:b0:2be:6f30:f2f9 with SMTP id 5a478bee46e88-2c9328ac279mr1186570eec.26.1775023549872;
 Tue, 31 Mar 2026 23:05:49 -0700 (PDT)
Date: Wed, 01 Apr 2026 06:05:30 +0000
In-Reply-To: <20260401-teaming-driver-internal-v2-0-f80c1291727b@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401-teaming-driver-internal-v2-0-f80c1291727b@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775023538; l=18316;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=cz1UQUY9YQJLilTEJn4TLXI+9W35mi+oIsWZFttvuns=; b=zqJHtFEXpRyKG9qwhNl/W0hO82YNsXrr4pMnhNd6U7ns5xKYzJY2wZfyhEfG2/eaPnDWylBfn
 l/LFN0+5ZQaApW0cY74t7yxVPepD5I0xlraiQq42oHe3ZJznmEaGWvV
X-Mailer: b4 0.14.3
Message-ID: <20260401-teaming-driver-internal-v2-6-f80c1291727b@google.com>
Subject: [PATCH net-next v2 6/7] net: team: Decouple rx and tx enablement in
 the team driver
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>
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
	TAGGED_FROM(0.00)[bounces-273902-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1630137513E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are use cases where an aggregated port should send traffic, but
not receive traffic, and vice versa. For example, in the IEEE
802.3ad-2000 specification, there is an optional "Independent Control"
version of the mux machine. Currently there is no way create
implementations like this for the team driver.

Separate the existing "enabled" per-port option into tx and rx
specific enablement options, but do so without breaking the existing
"enabled" option. The existing "enabled" option is now defined as
(rx_enabled AND tx_enabled), so if one is independently disabled, then
the old "enabled" option will also not be enabled. However, setting
the old "enabled" option affects both the rx_enabled and tx_enabled
options. This is the first case where setting an option can affect
another option.

Note that teamd and any other software that exclusively uses "coupled"
enablement will continue to work without any changes.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v2:
- None
---
 drivers/net/team/team_core.c             | 238 ++++++++++++++++++++++++++-----
 drivers/net/team/team_mode_loadbalance.c |   4 +-
 drivers/net/team/team_mode_random.c      |   4 +-
 drivers/net/team/team_mode_roundrobin.c  |   2 +-
 include/linux/if_team.h                  |  60 +++++---
 5 files changed, 245 insertions(+), 63 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 2ce31999c99f..308ff7cd4b15 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -87,7 +87,7 @@ static void team_lower_state_changed(struct team_port *port)
 	struct netdev_lag_lower_state_info info;
 
 	info.link_up = port->linkup;
-	info.tx_enabled = team_port_enabled(port);
+	info.tx_enabled = team_port_tx_enabled(port);
 	netdev_lower_state_changed(port->dev, &info);
 }
 
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
@@ -831,7 +831,7 @@ static bool team_queue_override_port_has_gt_prio_than(struct team_port *port,
 		return true;
 	if (port->priority > cur->priority)
 		return false;
-	if (port->index < cur->index)
+	if (port->tx_index < cur->tx_index)
 		return true;
 	return false;
 }
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
@@ -927,58 +927,172 @@ static bool team_port_find(const struct team *team,
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
+static void team_port_enable_rx(struct team *team,
+				struct team_port *port)
+{
+	if (team_port_rx_enabled(port))
+		return;
+
+	__team_port_enable_rx(team, port);
+
+	team_adjust_ops(team);
+
+	team_notify_peers(team);
+	team_mcast_rejoin(team);
+}
+
+static void team_port_disable_rx(struct team *team,
+				 struct team_port *port)
+{
+	if (!team_port_rx_enabled(port))
+		return;
+
+	__team_port_disable_rx(team, port);
+	team_adjust_ops(team);
+}
+
+/*
+ * Enable just TX on the port by adding to tx-enabled port hashlist and
+ * setting port->tx_index (Might be racy so reader could see incorrect
+ * ifindex when processing a flying packet, but that is not a problem).
+ * Write guarded by RTNL.
+ */
+static void __team_port_enable_tx(struct team *team,
+				  struct team_port *port)
+{
+	WRITE_ONCE(port->tx_index, team->tx_en_port_count);
+	WRITE_ONCE(team->tx_en_port_count, team->tx_en_port_count + 1);
+	hlist_add_head_rcu(&port->tx_hlist,
+			   team_tx_port_index_hash(team, port->tx_index));
+}
+
+static void team_port_enable_tx(struct team *team,
+				struct team_port *port)
+{
+	if (team_port_tx_enabled(port))
+		return;
+
+	__team_port_enable_tx(team, port);
+	team_adjust_ops(team);
+	team_queue_override_port_add(team, port);
+
+	/* Don't rejoin multicast, since this port might not be receiving. */
+	team_notify_peers(team);
+	team_lower_state_changed(port);
+}
+
 /*
- * Enable/disable port by adding to enabled port hashlist and setting
- * port->index (Might be racy so reader could see incorrect ifindex when
- * processing a flying packet, but that is not a problem). Write guarded
- * by RTNL.
+ * Enable TX AND RX on the port.
  */
 static void team_port_enable(struct team *team,
 			     struct team_port *port)
 {
+	bool rx_was_enabled;
+	bool tx_was_enabled;
+
 	if (team_port_enabled(port))
 		return;
-	WRITE_ONCE(port->index, team->en_port_count);
-	WRITE_ONCE(team->en_port_count, team->en_port_count + 1);
-	hlist_add_head_rcu(&port->hlist,
-			   team_port_index_hash(team, port->index));
+
+	rx_was_enabled = team_port_rx_enabled(port);
+	tx_was_enabled = team_port_tx_enabled(port);
+
+	if (!rx_was_enabled)
+		__team_port_enable_rx(team, port);
+	if (!tx_was_enabled) {
+		__team_port_enable_tx(team, port);
+		team_queue_override_port_add(team, port);
+	}
+
 	team_adjust_ops(team);
-	team_queue_override_port_add(team, port);
 	team_notify_peers(team);
-	team_mcast_rejoin(team);
-	team_lower_state_changed(port);
+
+	if (!rx_was_enabled)
+		team_mcast_rejoin(team);
+	if (!tx_was_enabled)
+		team_lower_state_changed(port);
 }
 
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
 
-static void team_port_disable(struct team *team,
-			      struct team_port *port)
+static void __team_port_disable_tx(struct team *team,
+				   struct team_port *port)
 {
-	if (!team_port_enabled(port))
-		return;
 	if (team->ops.port_tx_disabled)
 		team->ops.port_tx_disabled(team, port);
-	hlist_del_rcu(&port->hlist);
-	__reconstruct_port_hlist(team, port->index);
-	WRITE_ONCE(port->index, -1);
-	WRITE_ONCE(team->en_port_count, team->en_port_count - 1);
+
+	hlist_del_rcu(&port->tx_hlist);
+	__reconstruct_port_hlist(team, port->tx_index);
+
+	WRITE_ONCE(port->tx_index, -1);
+	WRITE_ONCE(team->tx_en_port_count, team->tx_en_port_count - 1);
+}
+
+static void team_port_disable_tx(struct team *team,
+				 struct team_port *port)
+{
+	if (!team_port_tx_enabled(port))
+		return;
+
+	__team_port_disable_tx(team, port);
+
 	team_queue_override_port_del(team, port);
 	team_adjust_ops(team);
 	team_lower_state_changed(port);
 }
 
+static void team_port_disable(struct team *team,
+			      struct team_port *port)
+{
+	bool rx_was_enabled;
+	bool tx_was_enabled;
+
+	if (!team_port_tx_enabled(port) && !team_port_rx_enabled(port))
+		return;
+
+	rx_was_enabled = team_port_rx_enabled(port);
+	tx_was_enabled = team_port_tx_enabled(port);
+
+	if (tx_was_enabled) {
+		__team_port_disable_tx(team, port);
+		team_queue_override_port_del(team, port);
+	}
+	if (rx_was_enabled)
+		__team_port_disable_rx(team, port);
+
+	team_adjust_ops(team);
+
+	if (tx_was_enabled)
+		team_lower_state_changed(port);
+}
+
 static int team_port_enter(struct team *team, struct team_port *port)
 {
 	int err = 0;
@@ -1244,7 +1358,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		netif_addr_unlock_bh(dev);
 	}
 
-	WRITE_ONCE(port->index, -1);
+	WRITE_ONCE(port->tx_index, -1);
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
 	netdev_compute_master_upper_features(dev, true);
@@ -1429,6 +1543,46 @@ static int team_port_en_option_set(struct team *team,
 	return 0;
 }
 
+static void team_port_tx_en_option_get(struct team *team,
+				       struct team_gsetter_ctx *ctx)
+{
+	struct team_port *port = ctx->info->port;
+
+	ctx->data.bool_val = team_port_tx_enabled(port);
+}
+
+static int team_port_tx_en_option_set(struct team *team,
+				      struct team_gsetter_ctx *ctx)
+{
+	struct team_port *port = ctx->info->port;
+
+	if (ctx->data.bool_val)
+		team_port_enable_tx(team, port);
+	else
+		team_port_disable_tx(team, port);
+	return 0;
+}
+
+static void team_port_rx_en_option_get(struct team *team,
+				       struct team_gsetter_ctx *ctx)
+{
+	struct team_port *port = ctx->info->port;
+
+	ctx->data.bool_val = team_port_rx_enabled(port);
+}
+
+static int team_port_rx_en_option_set(struct team *team,
+				      struct team_gsetter_ctx *ctx)
+{
+	struct team_port *port = ctx->info->port;
+
+	if (ctx->data.bool_val)
+		team_port_enable_rx(team, port);
+	else
+		team_port_disable_rx(team, port);
+	return 0;
+}
+
 static void team_user_linkup_option_get(struct team *team,
 					struct team_gsetter_ctx *ctx)
 {
@@ -1550,6 +1704,20 @@ static const struct team_option team_options[] = {
 		.getter = team_port_en_option_get,
 		.setter = team_port_en_option_set,
 	},
+	{
+		.name = "tx_enabled",
+		.type = TEAM_OPTION_TYPE_BOOL,
+		.per_port = true,
+		.getter = team_port_tx_en_option_get,
+		.setter = team_port_tx_en_option_set,
+	},
+	{
+		.name = "rx_enabled",
+		.type = TEAM_OPTION_TYPE_BOOL,
+		.per_port = true,
+		.getter = team_port_rx_en_option_get,
+		.setter = team_port_rx_en_option_set,
+	},
 	{
 		.name = "user_linkup",
 		.type = TEAM_OPTION_TYPE_BOOL,
@@ -1595,7 +1763,7 @@ static int team_init(struct net_device *dev)
 		return -ENOMEM;
 
 	for (i = 0; i < TEAM_PORT_HASHENTRIES; i++)
-		INIT_HLIST_HEAD(&team->en_port_hlist[i]);
+		INIT_HLIST_HEAD(&team->tx_en_port_hlist[i]);
 	INIT_LIST_HEAD(&team->port_list);
 	err = team_queue_override_init(team);
 	if (err)
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 840f409d250b..38a459649569 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -120,7 +120,7 @@ static struct team_port *lb_hash_select_tx_port(struct team *team,
 {
 	int port_index = team_num_to_port_index(team, hash);
 
-	return team_get_port_by_index_rcu(team, port_index);
+	return team_get_port_by_tx_index_rcu(team, port_index);
 }
 
 /* Hash to port mapping select tx port */
@@ -380,7 +380,7 @@ static int lb_tx_hash_to_port_mapping_set(struct team *team,
 
 	list_for_each_entry(port, &team->port_list, list) {
 		if (ctx->data.u32_val == port->dev->ifindex &&
-		    team_port_enabled(port)) {
+		    team_port_tx_enabled(port)) {
 			rcu_assign_pointer(LB_HTPM_PORT_BY_HASH(lb_priv, hash),
 					   port);
 			return 0;
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
index 740cb3100dfc..3d21e06fda67 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -27,10 +27,11 @@ struct team;
 
 struct team_port {
 	struct net_device *dev;
-	struct hlist_node hlist; /* node in enabled ports hash list */
+	struct hlist_node tx_hlist; /* node in tx-enabled ports hash list */
 	struct list_head list; /* node in ordinary list */
 	struct team *team;
-	int index; /* index of enabled port. If disabled, it's set to -1 */
+	int tx_index; /* index of tx enabled port. If disabled, -1 */
+	bool rx_enabled;
 
 	bool linkup; /* either state.linkup or user.linkup */
 
@@ -75,14 +76,24 @@ static inline struct team_port *team_port_get_rcu(const struct net_device *dev)
 	return rcu_dereference(dev->rx_handler_data);
 }
 
+static inline bool team_port_rx_enabled(struct team_port *port)
+{
+	return READ_ONCE(port->rx_enabled);
+}
+
+static inline bool team_port_tx_enabled(struct team_port *port)
+{
+	return READ_ONCE(port->tx_index) != -1;
+}
+
 static inline bool team_port_enabled(struct team_port *port)
 {
-	return READ_ONCE(port->index) != -1;
+	return team_port_rx_enabled(port) && team_port_tx_enabled(port);
 }
 
 static inline bool team_port_txable(struct team_port *port)
 {
-	return port->linkup && team_port_enabled(port);
+	return port->linkup && team_port_tx_enabled(port);
 }
 
 static inline bool team_port_dev_txable(const struct net_device *port_dev)
@@ -190,10 +201,11 @@ struct team {
 	const struct header_ops *header_ops_cache;
 
 	/*
-	 * List of enabled ports and their count
+	 * List of tx-enabled ports and counts of rx and tx-enabled ports.
 	 */
-	int en_port_count;
-	struct hlist_head en_port_hlist[TEAM_PORT_HASHENTRIES];
+	int tx_en_port_count;
+	int rx_en_port_count;
+	struct hlist_head tx_en_port_hlist[TEAM_PORT_HASHENTRIES];
 
 	struct list_head port_list; /* list of all ports */
 
@@ -237,41 +249,43 @@ static inline int team_dev_queue_xmit(struct team *team, struct team_port *port,
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
2.53.0.1118.gaef5881109-goog


