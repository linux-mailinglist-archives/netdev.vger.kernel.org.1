Return-Path: <netdev+bounces-286204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEYLKuR8/2kU7AAAu9opvQ
	(envelope-from <netdev+bounces-286204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 20:28:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0134C500FB1
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 20:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E77C93009172
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 18:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1612DC76A;
	Sat,  9 May 2026 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnmFcrr6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2554A3E
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778350742; cv=none; b=ccyz9I0mIsr5R/FSCgDPZ9YkUTNH0Mj+mfJotdZFLmP4SBstqa7bn54vwRL3QZv+FJCbcmQmnGcRyVYEYUa3kqJ+c760nfHblJpz0HH5mPlT3+xcgRbbeRvEl8x2mS9x6keleqkXqG7yBqzivsh0PdRitoHG+K27fJFCNsJ7izQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778350742; c=relaxed/simple;
	bh=oO/gf2Fs5rNYURzdy4+Z5xpsyUBpydMy7vmp4nuPgKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OwEoa9Ij1Tx42eHGxubs+aeF0c6YHF8MT8FK744OiG5aND1b7ODXtVZw5+vdj5wZI/EBRpB2MHRpv1ZK0ju9X4JBYp9nx5CD8/mqNLentxMP2dSf+5jn0PGlmC9+ophfL44GUNdSB4sRWxysXRUZx1GBl2/ARsqnFqlpcYmgBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnmFcrr6; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so2656518eec.0
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 11:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778350740; x=1778955540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J85h/DDiS1R+yV4gY6WSw7npft67Bb4Adxg28ToTKn8=;
        b=NnmFcrr6pCJj3sK0t0eKMG/BdHJmiomjxFHX6bXOqSOgLKf3winbnNz4aTyZsHFYqW
         gk5CSFzd9NIRkvgM4f26c6FiYzM2V4MpOskLPKYqampc7Prra14jbRhhidSr6yM3lrhl
         wa1fw764WLuF7lWESrAUSGKxlVp0Tfb0HIgjCWuhpwfKAZVnxzh3/13NNinvsnlzuxmh
         vPAML9o4k+7NTyHFThWpqO4pF8HvnmmrppUO7VH+lOMJMp3+AltDcE0D01vCJY2hZ0YP
         BOG7WjH36q10Ujs3wm0+A7bt/6kn3qXxR9FzinYr8Q+zGPi4Ux8jGPPJfhPr8jJss6J7
         IFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778350740; x=1778955540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J85h/DDiS1R+yV4gY6WSw7npft67Bb4Adxg28ToTKn8=;
        b=SkAyPPctME6oDCFzu9fpP9eA5mwIzF8XdIBNKg9PUuH6I6QfW1oQx2O2YWq3YjRvNW
         AVU0R6LoWUL+B8+Ndmfk/gziIYic98mJr4AbY6d9RsyICedYGzmijqrTId+elAvVd7of
         uyr1RVJWVDXoW5QfbrFTYzJZP6kTBx7FVPLbw/wJXLbHwFOKDFQj8JeYYqZCd+mEMLP4
         gENm0E+Y3BzQyFn7ugWHiU1kkISRUd4POapTc3IvTK/Y7CGIKGSm3LTiGfqMD8gadaGk
         VSLoF3KMd+9hq4BlUyCyNqxsUTXoqdvH33cViUFbT9iJxwNiiOPha9jXeRowIKf8q5ZH
         OjPA==
X-Gm-Message-State: AOJu0YzY0TkjvM6i5VYSYuOiQaul22Ffsfw9LMf/x0UAxnYDQ/yHajxp
	GqT32CObu1JjmcryW3R7WpTy9MxXkhHB7kBqY/MlbZB1Qsx/jtnGbCcWaTLwrgjoGxM=
X-Gm-Gg: Acq92OEx/1NNdIf9KtD/qbqRYKnSBr6sKFRC/UpInChj9Pt+TZ9uwv7Uab9yImkUlyL
	1u6ds723yueKiUOdxEK0sVSE5UILG14kWLk5JEj5EomOJslNzmuIu9K8LmGRMriUPffAgct2g+N
	Om/wAh9qdUGI4cbUuibAWG5hx2wAOBiC9zhJgpolLBF1LTRca7HLX943r8gtaBgIWP5iIiZSy/H
	UENJbjwuA+joRoaunFyOmtuWD+lS2DWhIVBAKzYi5hSwtUXTsJJd6HA3Bm5QKzKPWhF9AzkKcQO
	A5fLC5A23KM28G6ER8B7DW0smH1EQIUmwcfqCibnKAbM6+QNZbet65RLmu0k6uJZaoHuntBaejm
	J3kmz2sGrk0tOIa4QByBaQefMiZHyjPTczVEt8rhEm5INr096W7xiQUtVUl4AEXz48x9l3cxFBB
	y0GehfElyAmdGFmPAQF3VV6Q8drjlu1MlQ6YDkehRBAYkMszJ3jayvH5dH5JjpQzahwsj7OMSq9
	pPkRkU/mg==
X-Received: by 2002:a05:7300:642a:b0:2e6:ff79:e356 with SMTP id 5a478bee46e88-2f54c280859mr7978521eec.11.1778350739756;
        Sat, 09 May 2026 11:18:59 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d43b4sm6864346eec.11.2026.05.09.11.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 11:18:58 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v2] net: team: fix NULL pointer dereference in team_xmit during mode change
Date: Sat,  9 May 2026 11:18:26 -0700
Message-ID: <20260509181825.1523951-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0134C500FB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286204-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,asu.edu,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_SPAM(0.00)[0.695];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: add header
X-Spam: Yes

__team_change_mode() clears team->ops with memset() before restoring
safe dummy handlers via team_adjust_ops(). A concurrent team_xmit()
running under RCU on another CPU can read team->ops.transmit during
this window and call a NULL function pointer, crashing the kernel.

The race requires CAP_NET_ADMIN (in init_user_ns) to trigger via
TEAM_CMD_OPTIONS_SET, plus AF_PACKET sendto() on a team device with
forced carrier and no ports.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 Oops: 0010 [#1] SMP KASAN NOPTI
 RIP: 0010:0x0
 Call Trace:
  team_xmit (drivers/net/team/team_core.c:1853)
  dev_hard_start_xmit (net/core/dev.c:3904)
  __dev_queue_xmit (net/core/dev.c:4871)
  packet_sendmsg (net/packet/af_packet.c:3109)
  __sys_sendto (net/socket.c:2265)

Fix this on the writer side by replacing the memset()/memcpy() with
per-field updates that keep transmit and receive always valid via
smp_store_release(), paired with smp_load_acquire() on the reader
side. A synchronize_net() before exit_op() drains in-flight readers
before tearing down mode state.

Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
 - Move fix from data path (reader-side NULL fallback) to
   configuration path (writer-side per-field updates), as suggested
   by the reviewer.
 - Use smp_store_release()/smp_load_acquire() instead of plain
   stores/loads for proper ordering on weakly-ordered architectures.
 - Add synchronize_net() before exit_op() to drain in-flight readers
   and prevent use-after-free of mode private state.

 drivers/net/team/team_core.c | 46 ++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 0c87f9972..dabee3aa7 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -534,21 +534,22 @@ static void team_adjust_ops(struct team *team)
 
 	if (!team->tx_en_port_count || !team_is_mode_set(team) ||
 	    !team->mode->ops->transmit)
-		team->ops.transmit = team_dummy_transmit;
+		smp_store_release(&team->ops.transmit, team_dummy_transmit);
 	else
-		team->ops.transmit = team->mode->ops->transmit;
+		smp_store_release(&team->ops.transmit, team->mode->ops->transmit);
 
 	if (!team->rx_en_port_count || !team_is_mode_set(team) ||
 	    !team->mode->ops->receive)
-		team->ops.receive = team_dummy_receive;
+		smp_store_release(&team->ops.receive, team_dummy_receive);
 	else
-		team->ops.receive = team->mode->ops->receive;
+		smp_store_release(&team->ops.receive, team->mode->ops->receive);
 }
 
 /*
- * We can benefit from the fact that it's ensured no port is present
- * at the time of mode change. Therefore no packets are in fly so there's no
- * need to set mode operations in any special way.
+ * team_change_mode() ensures no ports are present during mode change,
+ * but lockless readers (AF_PACKET) can still reach team_xmit(). Use
+ * smp_store_release() to publish safe dummy handlers before teardown,
+ * and synchronize_net() to drain in-flight readers.
  */
 static int __team_change_mode(struct team *team,
 			      const struct team_mode *new_mode)
@@ -557,9 +558,23 @@ static int __team_change_mode(struct team *team,
 	if (team_is_mode_set(team)) {
 		void (*exit_op)(struct team *team) = team->ops.exit;
 
-		/* Clear ops area so no callback is called any longer */
-		memset(&team->ops, 0, sizeof(struct team_mode_ops));
-		team_adjust_ops(team);
+		/* Install dummy handlers for locklessly-read hot-path ops
+		 * first, then clear cold-path ops that are only used under
+		 * RTNL.
+		 */
+		smp_store_release(&team->ops.transmit, team_dummy_transmit);
+		smp_store_release(&team->ops.receive, team_dummy_receive);
+		team->ops.init = NULL;
+		team->ops.exit = NULL;
+		team->ops.port_enter = NULL;
+		team->ops.port_leave = NULL;
+		team->ops.port_change_dev_addr = NULL;
+		team->ops.port_tx_disabled = NULL;
+
+		/* Ensure in-flight readers using old handlers have finished
+		 * before tearing down mode state they may depend on.
+		 */
+		synchronize_net();
 
 		if (exit_op)
 			exit_op(team);
@@ -582,7 +597,12 @@ static int __team_change_mode(struct team *team,
 	}
 
 	team->mode = new_mode;
-	memcpy(&team->ops, new_mode->ops, sizeof(struct team_mode_ops));
+	team->ops.init = new_mode->ops->init;
+	team->ops.exit = new_mode->ops->exit;
+	team->ops.port_enter = new_mode->ops->port_enter;
+	team->ops.port_leave = new_mode->ops->port_leave;
+	team->ops.port_change_dev_addr = new_mode->ops->port_change_dev_addr;
+	team->ops.port_tx_disabled = new_mode->ops->port_tx_disabled;
 	team_adjust_ops(team);
 
 	return 0;
@@ -743,7 +763,7 @@ static rx_handler_result_t team_handle_frame(struct sk_buff **pskb)
 		/* allow exact match delivery for disabled ports */
 		res = RX_HANDLER_EXACT;
 	} else {
-		res = team->ops.receive(team, port, skb);
+		res = smp_load_acquire(&team->ops.receive)(team, port, skb);
 	}
 	if (res == RX_HANDLER_ANOTHER) {
 		struct team_pcpu_stats *pcpu_stats;
@@ -1845,7 +1865,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	tx_success = team_queue_override_transmit(team, skb);
 	if (!tx_success)
-		tx_success = team->ops.transmit(team, skb);
+		tx_success = smp_load_acquire(&team->ops.transmit)(team, skb);
 	if (tx_success) {
 		struct team_pcpu_stats *pcpu_stats;
 
-- 
2.43.0


