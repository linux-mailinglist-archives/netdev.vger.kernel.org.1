Return-Path: <netdev+bounces-290269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIVSEjzBDmrXBwYAu9opvQ
	(envelope-from <netdev+bounces-290269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:24:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ACB5A0FC0
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 245353007349
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2AF2853E0;
	Thu, 21 May 2026 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNOV+opE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABBD18DB2A
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351441; cv=none; b=di6WC4Y/AFnn6aDMupEZGA+xhOU1GpNpqJvNCGWiHZbTvxVrGjsNiEFZGcmsiNPDE5zPxGTzwfLXF1hSWNcirNkXnWolW2ZAE8NfLaBVVmdM7AGIlSyzMjCbR6dpBty9CDaasMcjQkO3lF5KFFERhxvrWezGBT2zVcoR/ykAcQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351441; c=relaxed/simple;
	bh=3DwBrFddYkucFL/KPq9Wgqr5DKEGsTVRdf9FZ9GDViU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPzX35+NuIoyIEYb8eS82KJhBgqiymOLG6cBiXbhG+D/yCf2c4SNvBl/N1ixhrCgqiVFe3FQPJCT3rDud+yrJiRQIqS0v1uwGE1xlqN7EBuFPP/aIzgMjyYkT8S/gaqWMjRiLWPYANe1G0pscg/hq918XcZqPtn+FkL5nAq6lMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNOV+opE; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f0ad52830cso7525422eec.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779351439; x=1779956239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8AlacyrIcUHVN175tHvr4VinZu4pzeRnULv4Wk7GzNs=;
        b=HNOV+opE5cpMawEp+JDC72nfFDQZ9D+4XHekssJSUjmMr9Y/ptFe2loNMsa0jJOQIl
         LAU1AHE1MST3q+DaKSgY2UNGXvbJI3j2jV10AiTzBcrv851MjQGokWbw88j5A5YCHPCC
         XND5EHv5v6P4AUGkqw1OX3dMxlAtlLleYqCCXogVjWhd5xEYfMnentdtOdOJxnGCnsBp
         2Dz0+BpclHLMuNtihyhhtyY5OeUpBJH43a9LeDMlRmDM+FvJ0oBzdMIYtNPAwi9W5Kx/
         yb4RS67LEdL90bIHJEnHMSNR/YmIaBKrmFMnK1t5ACIQE8yH25+7ixGzf/aT+q3TJ4uI
         aNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779351439; x=1779956239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AlacyrIcUHVN175tHvr4VinZu4pzeRnULv4Wk7GzNs=;
        b=OcbA6b07GUkHMs/MK2ylKQgPv5XIhNq3mBNaCudP+lJVplg/CnzE49eNx64Ezc4Www
         fufYXPzb+6Muo4RNj27f+b6EsBMYeukM/Ln/6OIa0eKLenax0KpnkIp1c5PhD8Y6isjH
         TN7+UeWxE2GIGtxqjZm6leM99kw9hxr4ice1CvpqwnsPPO2gbisAXzG9XEsJ4Iys720B
         QJYmQkd65EOnFsey5YqKCJkZtzrizWSl5mU8FaE5iUimeW9HdQcIeugEkgcJ4HwfL2BH
         kzQS827KQGkBbW9HhMesrK+FSdK3jZh018I410rKMu3wgiw5LkzYvvDfU9C1PlKLo9LQ
         uRRA==
X-Gm-Message-State: AOJu0YxbNlL98P2hy01bDQorzHFcJ8FhLdg6JnKtkXfo6y/T2p9LQCAa
	or0pI9b7pXY4RA3L+fDutUkqErIzzbuLEL/wFpo2IuHmRpmf0UM5EHEJ
X-Gm-Gg: Acq92OGhBrJE8+9WBvalZiaMB4P8Y+CVMpYE4+Bb+0GmkqS9DBgtOcb5munsrAWW9b5
	7LQWnk9EGwsYDFhUE8q5NENOWQ8CdPEhQazTH6aSI1exEsedSdjc7A2cBAezjnwKYYIlwKizbN0
	DNUX+Ml3Q83hxzp0eEmwSCWITJPYiNSeBdh7B1365JmEGESNQmK9melOaDWu6RwFT9TjjUn0al3
	Vzsy9p7Cu69PC7MYlPIFib3zj5O5EM9xKNQwKf0GL1+bWC3VYWnKdCpufJD6rY0Ps2VybY2Pn9+
	FCCIjo/LtDkeNpFu4x+Ghy1/nzys/wKyNzClZtcXdNYkO4c5v0PdTxh5Ue1RyGKiw//dEojK5fA
	iBRRRVYKuUJ8YM0zXYflEonjn5sXE3/orHzfwvJwwWuZBn1IRrxC38VMvOneqOjyX7b+MJZMwtt
	jY8uReogsUpCz0IOoVKYoB6LiN2EnAIl+mIfpQTkEMrVnzwBsrNxP1dv5jBuYh86FuvydZtmgdg
	zCQVMbgenBrMvnhna7BF+7lJb+t83M=
X-Received: by 2002:a05:693c:2c93:b0:2ed:e12:376b with SMTP id 5a478bee46e88-3042f98fa98mr1035343eec.33.1779351438673;
        Thu, 21 May 2026 01:17:18 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302977a9474sm20771163eec.25.2026.05.21.01.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:17:18 -0700 (PDT)
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
Subject: [PATCH net v4] net: team: fix NULL pointer dereference in team_xmit during mode change
Date: Thu, 21 May 2026 01:12:01 -0700
Message-ID: <20260521081159.1491563-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,asu.edu,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290269-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A1ACB5A0FC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__team_change_mode() clears team->ops with memset() before restoring
safe dummy handlers via team_adjust_ops(). A concurrent team_xmit()
running under RCU on another CPU can read team->ops.transmit during
this window and call a NULL function pointer, crashing the kernel.

The race requires a mode change (CAP_NET_ADMIN) concurrent with
transmit on the team device.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 Oops: 0010 [#1] SMP KASAN NOPTI
 RIP: 0010:0x0
 Call Trace:
  team_xmit (drivers/net/team/team_core.c:1853)
  dev_hard_start_xmit (net/core/dev.c:3904)
  __dev_queue_xmit (net/core/dev.c:4871)
  packet_sendmsg (net/packet/af_packet.c:3109)
  __sys_sendto (net/socket.c:2265)

The original code assumed that no ports means no traffic, so mode
changes could freely memset()/memcpy() the ops.  AF_PACKET with
forced carrier breaks that assumption.

Prevent the race instead of making it safe: replace memset()/memcpy()
with per-field updates that never touch transmit or receive.  Those
two handlers are managed solely by team_adjust_ops(), which already
installs dummies when tx_en_port_count == 0 (always true during mode
change since no ports are present).  WRITE_ONCE/READ_ONCE prevent
store/load tearing on the handler pointers.

synchronize_net() before exit_op() drains in-flight readers that may
still reference old mode state from before port removal switched the
handlers to dummies.

Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v4:
 - Prevent the race instead of making it safe, as suggested by
   Jakub: never touch transmit/receive during mode change, let
   team_adjust_ops() manage them based on port count.
 - Drop smp_store_release()/smp_load_acquire() in favor of
   WRITE_ONCE/READ_ONCE.

v3:
 - Clarify barrier ordering in commit message.
 - Drop AF_PACKET mention from commit message and code comment.

v2:
 - Move fix from data path (reader-side NULL fallback) to
   configuration path (writer-side per-field updates), as suggested
   by the reviewer.
 - Use smp_store_release()/smp_load_acquire() instead of plain
   stores/loads for proper ordering on weakly-ordered architectures.
 - Add synchronize_net() before exit_op() to drain in-flight readers
   and prevent use-after-free of mode private state.

 drivers/net/team/team_core.c | 45 +++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 0c87f9972457..89a3f71b7a71 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -534,21 +534,23 @@ static void team_adjust_ops(struct team *team)
 
 	if (!team->tx_en_port_count || !team_is_mode_set(team) ||
 	    !team->mode->ops->transmit)
-		team->ops.transmit = team_dummy_transmit;
+		WRITE_ONCE(team->ops.transmit, team_dummy_transmit);
 	else
-		team->ops.transmit = team->mode->ops->transmit;
+		WRITE_ONCE(team->ops.transmit, team->mode->ops->transmit);
 
 	if (!team->rx_en_port_count || !team_is_mode_set(team) ||
 	    !team->mode->ops->receive)
-		team->ops.receive = team_dummy_receive;
+		WRITE_ONCE(team->ops.receive, team_dummy_receive);
 	else
-		team->ops.receive = team->mode->ops->receive;
+		WRITE_ONCE(team->ops.receive, team->mode->ops->receive);
 }
 
 /*
- * We can benefit from the fact that it's ensured no port is present
- * at the time of mode change. Therefore no packets are in fly so there's no
- * need to set mode operations in any special way.
+ * team_change_mode() ensures no ports are present during mode change,
+ * but lockless readers can still reach team_xmit().  Avoid touching
+ * transmit/receive -- they are already set to dummies by
+ * team_adjust_ops() since no ports are enabled.  synchronize_net()
+ * drains in-flight readers before destroying old mode state.
  */
 static int __team_change_mode(struct team *team,
 			      const struct team_mode *new_mode)
@@ -557,9 +559,21 @@ static int __team_change_mode(struct team *team,
 	if (team_is_mode_set(team)) {
 		void (*exit_op)(struct team *team) = team->ops.exit;
 
-		/* Clear ops area so no callback is called any longer */
-		memset(&team->ops, 0, sizeof(struct team_mode_ops));
-		team_adjust_ops(team);
+		/* Clear cold-path ops used only under RTNL.  transmit and
+		 * receive are already dummies (no ports) so leave them
+		 * alone -- overwriting them is the source of the race.
+		 */
+		team->ops.init = NULL;
+		team->ops.exit = NULL;
+		team->ops.port_enter = NULL;
+		team->ops.port_leave = NULL;
+		team->ops.port_change_dev_addr = NULL;
+		team->ops.port_tx_disabled = NULL;
+
+		/* Wait for in-flight readers before tearing down mode
+		 * state they may reference.
+		 */
+		synchronize_net();
 
 		if (exit_op)
 			exit_op(team);
@@ -582,7 +596,12 @@ static int __team_change_mode(struct team *team,
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
@@ -743,7 +762,7 @@ static rx_handler_result_t team_handle_frame(struct sk_buff **pskb)
 		/* allow exact match delivery for disabled ports */
 		res = RX_HANDLER_EXACT;
 	} else {
-		res = team->ops.receive(team, port, skb);
+		res = READ_ONCE(team->ops.receive)(team, port, skb);
 	}
 	if (res == RX_HANDLER_ANOTHER) {
 		struct team_pcpu_stats *pcpu_stats;
@@ -1845,7 +1864,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	tx_success = team_queue_override_transmit(team, skb);
 	if (!tx_success)
-		tx_success = team->ops.transmit(team, skb);
+		tx_success = READ_ONCE(team->ops.transmit)(team, skb);
 	if (tx_success) {
 		struct team_pcpu_stats *pcpu_stats;
 
-- 
2.43.0


