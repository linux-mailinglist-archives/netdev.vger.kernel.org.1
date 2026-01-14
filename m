Return-Path: <netdev+bounces-249725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DE4D1CB94
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 07:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC32B301FC0C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 06:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF82136E48D;
	Wed, 14 Jan 2026 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4oH3VQP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ACA36BCE4
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373406; cv=none; b=rU/5vbCQPvZnWGINXjiZs395IZ6MvwRvhzYKV0QRhpC7hiegb60Nfb9mqOge7RTPSLjrdip2rhBvmeYA+jaJZf3vmmTmM7Z0BOxg712LbGHgbTUgEaHNawg4Xuhs8dlrF2QSwKUqTigmAZ+SmwA9i5Vtd7hvFyqKJ3Std/jT+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373406; c=relaxed/simple;
	bh=0R/dBKf944EQx8pEmvyqKum4VIhIbTlogzkyEmg6Rdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQORvszKArzejMkA9rIlmzjyAnI1WK2LspPZVPnHZLVKOaxeTKoNRw64s5QKbShPy4BZ3qQILdLB1JT49bFOtPpoM8OsNR8945aE442N1GusfJOlQsk5vj1WtBodY+ebHTJSULGe0hsWksL8QS3lqmfH0K7EEy2O+6HjORdg6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4oH3VQP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0c09bb78cso4132885ad.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768373396; x=1768978196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZfDYhswA92Nlf/7cLmt9NuonT5imrnRxL/6I454NmI=;
        b=D4oH3VQPGh7HJlc0vTeNKqjpbuObSuvMD2f5kEfEr5Ksf0cgSAeGRdz8Hcj3mA/pgV
         7Eom7aT+/OI5iA0yvB9EBm3L4gRP2PkjVPQKxru9mALG+loSkdmvGVNP0O4nZX3r64++
         2gurFEfWNWmJ0lEaCJLfTViUJMI2sqwxiL/xDLkew1VbCZrhLb5rdUhdVdC8bbGqWvWv
         arEZZmrRhuNrZoV/n7o3tAqXT4Icdz+pTKHAux0Qjnot7pozd111W3vdntIQQch3izcj
         lg7C26garDxbSLtrcrsd559kmYg3/rQJUARdYIwUFA94hfZH3UOz+Ff64OlecxCuTehg
         AF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768373396; x=1768978196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UZfDYhswA92Nlf/7cLmt9NuonT5imrnRxL/6I454NmI=;
        b=XALjD6kXcH+QhY18+Bk/lPTL73tpSxzlGijdHvs+uJ1UBMjBcnJV1gjY3AbJbSVOOJ
         qtH+YPE+26GpOQVXok40lV3ZeVMSIbi6nSu+PQOO+M9OVJB0b90JX5YuTixrJkryROfP
         FMhY23mnhZZknGws3AzOM6w0A0sgPLv3LmKFAuGTQjjh3N9r4wNB6EaXL9FTGcZZmuzN
         3fE0vz5Vyx57tw0vVOcGFAtpH9JTw8FqTSUogxwIcRoB6gNU2W/7CByjF0/hpdEtsCWu
         O0kW7Csiztrtb8ygUtQf83PeNDGLK0tBj2M4uA+wE8QARqBNg4dTiOTuQ/yXtfz8W+2z
         5ATA==
X-Gm-Message-State: AOJu0YzxcoS28W0DAtcU3u49okinccvsvjxLWnv2C0AOdtiiiTKoAfSG
	cX9lRxfBqQvpke2IhXHIr+XeE60W27h24tK7f2y6CXAhHWFCn9vYW/Jn3TG0gcTT
X-Gm-Gg: AY/fxX5douKDjr3C+8t10EzkYSqfCc3rI1APdoP5bOg9oLSK3HLNt9eQxqgsLZkRaSx
	aK6VH3ZDkAeMw7QL28cyWR4atgopS6hnONMQwCglhhacIRXqI7MvAAtxwK/LnZd60/cP256ppF+
	F/Z/jIFFwG8XV5n1HeA8iL59JhKr5bwVvFQP3V9a8PJCnvA9yz3bBr2RG1EdRDe5StXBb6GxUGA
	9qn2hTSj9BlJBfUxy/bpcYkTKiSH7JofQU1TuYuKApgCoVyeDWcsaKJaA7Hw1QxpfvYM/2DmOUt
	1G7mDu1ztNDzf5Y3rJSPWtspaISwtUnPC7lslkAzspOZquDPlUgXKSM1djrWVHNDEvJQ8Bey/Kl
	3VNIlJaTvhhxqfCCV/p3OorCM09pi0hvLZ6/VadI+z7qrh9LpOwZHMvz1fZLkcUiVJHxCVYxKtg
	ThmoN0odyrXFuoE4rrVwX40DzjCA==
X-Received: by 2002:a17:903:2344:b0:2a3:ccfc:4de5 with SMTP id d9443c01a7336-2a58b49e424mr58071045ad.5.1768373395689;
        Tue, 13 Jan 2026 22:49:55 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492fsm96315525ad.98.2026.01.13.22.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 22:49:54 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Liang Li <liali@redhat.com>
Subject: [PATCHv2 net-next 2/3] bonding: restructure ad_churn_machine
Date: Wed, 14 Jan 2026 06:49:20 +0000
Message-ID: <20260114064921.57686-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114064921.57686-1-liuhangbin@gmail.com>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current ad_churn_machine implementation only transitions the
actor/partner churn state to churned or none after the churn timer expires.
However, IEEE 802.1AX-2014 specifies that a port should enter the none
state immediately once the actor’s port state enters synchronization.

Another issue is that if the churn timer expires while the churn machine is
not in the monitor state (e.g. already in churn), the state may remain
stuck indefinitely with no further transitions. This becomes visible in
multi-aggregator scenarios. For example:

Ports 1 and 2 are in aggregator 1 (active)
Ports 3 and 4 are in aggregator 2 (backup)

Ports 1 and 2 should be in none
Ports 3 and 4 should be in churned

If a failover occurs due to port 2 link down/up, aggregator 2 becomes active.
Under the current implementation, the resulting states may look like:

agg 1 (backup): port 1 -> none, port 2 -> churned
agg 2 (active): ports 3,4 keep in churned.

The root cause is that ad_churn_machine() only clears the
AD_PORT_CHURNED flag and starts a timer. When a churned port becomes active,
its RX state becomes AD_RX_CURRENT, preventing the churn flag from being set
again, leaving no way to retrigger the timer. Fixing this solely in
ad_rx_machine() is insufficient.

This patch rewrites ad_churn_machine according to IEEE 802.1AX-2014
(Figures 6-23 and 6-24), ensuring correct churn detection, state transitions,
and timer behavior. With new implementation, there is no need to set
AD_PORT_CHURNED in ad_rx_machine().

Fixes: 14c9551a32eb ("bonding: Implement port churn-machine (AD standard 43.4.17).")
Reported-by: Liang Li <liali@redhat.com>
Tested-by: Liang Li <liali@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 96 +++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 25 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index bcf9833e5436..154e06e345ad 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -44,7 +44,6 @@
 #define AD_PORT_STANDBY         0x80
 #define AD_PORT_SELECTED        0x100
 #define AD_PORT_MOVED           0x200
-#define AD_PORT_CHURNED         (AD_PORT_ACTOR_CHURN | AD_PORT_PARTNER_CHURN)
 
 /* Port Key definitions
  * key is determined according to the link speed, duplex and
@@ -1248,7 +1247,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 	/* first, check if port was reinitialized */
 	if (port->sm_vars & AD_PORT_BEGIN) {
 		port->sm_rx_state = AD_RX_INITIALIZE;
-		port->sm_vars |= AD_PORT_CHURNED;
 	/* check if port is not enabled */
 	} else if (!(port->sm_vars & AD_PORT_BEGIN) && !port->is_enabled)
 		port->sm_rx_state = AD_RX_PORT_DISABLED;
@@ -1256,8 +1254,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 	else if (lacpdu && ((port->sm_rx_state == AD_RX_EXPIRED) ||
 		 (port->sm_rx_state == AD_RX_DEFAULTED) ||
 		 (port->sm_rx_state == AD_RX_CURRENT))) {
-		if (port->sm_rx_state != AD_RX_CURRENT)
-			port->sm_vars |= AD_PORT_CHURNED;
 		port->sm_rx_timer_counter = 0;
 		port->sm_rx_state = AD_RX_CURRENT;
 	} else {
@@ -1341,7 +1337,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 			port->partner_oper.port_state |= LACP_STATE_LACP_TIMEOUT;
 			port->sm_rx_timer_counter = __ad_timer_to_ticks(AD_CURRENT_WHILE_TIMER, (u16)(AD_SHORT_TIMEOUT));
 			port->actor_oper_port_state |= LACP_STATE_EXPIRED;
-			port->sm_vars |= AD_PORT_CHURNED;
 			break;
 		case AD_RX_DEFAULTED:
 			__update_default_selected(port);
@@ -1373,11 +1368,41 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
  * ad_churn_machine - handle port churn's state machine
  * @port: the port we're looking at
  *
+ * IEEE 802.1AX-2014 Figure 6-23 - Actor Churn Detection machine state diagram
+ *
+ *                                                     BEGIN || (! port_enabled)
+ *                                                               |
+ *                                      (3)                (1)   v
+ *   +----------------------+     ActorPort.Sync     +-------------------------+
+ *   |    NO_ACTOR_CHURN    | <--------------------- |   ACTOR_CHURN_MONITOR   |
+ *   |======================|                        |=========================|
+ *   | actor_churn = FALSE; |    ! ActorPort.Sync    | actor_churn = FALSE;    |
+ *   |                      | ---------------------> | Start actor_churn_timer |
+ *   +----------------------+           (4)          +-------------------------+
+ *             ^                                                 |
+ *             |                                                 |
+ *             |                                      actor_churn_timer expired
+ *             |                                                 |
+ *       ActorPort.Sync                                          |  (2)
+ *             |              +--------------------+             |
+ *        (3)  |              |   ACTOR_CHURN      |             |
+ *             |              |====================|             |
+ *             +------------- | actor_churn = True | <-----------+
+ *                            |                    |
+ *                            +--------------------+
+ *
+ * Similar for the Figure 6-24 - Partner Churn Detection machine state diagram
+ *
+ * We don’t need to check actor_churn, because it can only be true when the
+ * state is ACTOR_CHURN.
  */
 static void ad_churn_machine(struct port *port)
 {
-	if (port->sm_vars & AD_PORT_CHURNED) {
-		port->sm_vars &= ~AD_PORT_CHURNED;
+	bool partner_synced = port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION;
+	bool actor_synced = port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION;
+
+	/* ---- 1. begin or port not enabled ---- */
+	if ((port->sm_vars & AD_PORT_BEGIN) || !port->is_enabled) {
 		port->sm_churn_actor_state = AD_CHURN_MONITOR;
 		port->sm_churn_partner_state = AD_CHURN_MONITOR;
 		port->sm_churn_actor_timer_counter =
@@ -1386,25 +1411,46 @@ static void ad_churn_machine(struct port *port)
 			 __ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
 		return;
 	}
-	if (port->sm_churn_actor_timer_counter &&
-	    !(--port->sm_churn_actor_timer_counter) &&
-	    port->sm_churn_actor_state == AD_CHURN_MONITOR) {
-		if (port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION) {
-			port->sm_churn_actor_state = AD_NO_CHURN;
-		} else {
-			port->churn_actor_count++;
-			port->sm_churn_actor_state = AD_CHURN;
-		}
+
+	if (port->sm_churn_actor_timer_counter)
+		port->sm_churn_actor_timer_counter--;
+
+	if (port->sm_churn_partner_timer_counter)
+		port->sm_churn_partner_timer_counter--;
+
+	/* ---- 2. timer expired, enter CHURN ---- */
+	if (port->sm_churn_actor_state == AD_CHURN_MONITOR &&
+	    !port->sm_churn_actor_timer_counter) {
+		port->sm_churn_actor_state = AD_CHURN;
+		port->churn_actor_count++;
 	}
-	if (port->sm_churn_partner_timer_counter &&
-	    !(--port->sm_churn_partner_timer_counter) &&
-	    port->sm_churn_partner_state == AD_CHURN_MONITOR) {
-		if (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) {
-			port->sm_churn_partner_state = AD_NO_CHURN;
-		} else {
-			port->churn_partner_count++;
-			port->sm_churn_partner_state = AD_CHURN;
-		}
+
+	if (port->sm_churn_partner_state == AD_CHURN_MONITOR &&
+	    !port->sm_churn_partner_timer_counter) {
+		port->sm_churn_partner_state = AD_CHURN;
+		port->churn_partner_count++;
+	}
+
+	/* ---- 3. CHURN_MONITOR/CHURN + sync -> NO_CHURN ---- */
+	if ((port->sm_churn_actor_state == AD_CHURN_MONITOR ||
+	     port->sm_churn_actor_state == AD_CHURN) && actor_synced)
+		port->sm_churn_actor_state = AD_NO_CHURN;
+
+	if ((port->sm_churn_partner_state == AD_CHURN_MONITOR ||
+	     port->sm_churn_partner_state == AD_CHURN) && partner_synced)
+		port->sm_churn_partner_state = AD_NO_CHURN;
+
+	/* ---- 4. NO_CHURN + !sync -> MONITOR ---- */
+	if (port->sm_churn_actor_state == AD_NO_CHURN && !actor_synced) {
+		port->sm_churn_actor_state = AD_CHURN_MONITOR;
+		port->sm_churn_actor_timer_counter =
+			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
+	}
+
+	if (port->sm_churn_partner_state == AD_NO_CHURN && !partner_synced) {
+		port->sm_churn_partner_state = AD_CHURN_MONITOR;
+		port->sm_churn_partner_timer_counter =
+			__ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
 	}
 }
 
-- 
2.50.1


