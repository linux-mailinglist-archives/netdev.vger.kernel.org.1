Return-Path: <netdev+bounces-207269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D75B06830
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 22:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4A47B7EA9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D904E28727E;
	Tue, 15 Jul 2025 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN+IDxbe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21641DC9B8;
	Tue, 15 Jul 2025 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613060; cv=none; b=uS5ylxxyEesCsjjISY1vNgYkl0zI9dWIF/W+3JoaWs7xVpMpU43Yx/Z/fkC5KpW9Vyz58OJc6o7Kiu7aEGzF5wrwFDw9h/DLtRgO6hRsuAYdQSLhC75pZCuHMzdIucSRKq1mJxBWu253Cvm640Gs0oFt+tqYulwgNLZNHWO8hYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613060; c=relaxed/simple;
	bh=yHLetidUjsZN7RzvYQdZwkWIcftP0/dIz6TpMlYhQK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iv2f7RG/MRkoB0+eDr/wlhOc+d0b+FM0Wr/f3TaQVD8vFbc6ytQD+MCGPeid5bDNF+Hok1RfRp6tCFGltCeh13PjuTGZQMZJMvOSPszoq9K6xE/80kWaJ3poXKDtV953t3ltK8elW+62VR+1Hob7uIf7W/8t7IK745+RO7o72Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN+IDxbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C366C4CEE3;
	Tue, 15 Jul 2025 20:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752613059;
	bh=yHLetidUjsZN7RzvYQdZwkWIcftP0/dIz6TpMlYhQK0=;
	h=From:To:Cc:Subject:Date:From;
	b=RN+IDxbe4uibUHwRVILAFrBBk70Qacbt5TQoYSwdTcsWzLnV1ANSKGTNe5/TkJUl2
	 oU7ruh9CRik02gT3X9ekLiDzYhX2acEMG7yh2mWo7jjP2byELcS/vV6nU09Yp+gMRa
	 PvzNrHixDDTWRwsWR7o6+cDUgkmPnIE7YrB5UE9hs5FhF3SvW3Jc1wYqk8t/JsI8c2
	 Oeo3oNU6btqCljYKUJ/8sV8R0SXs5ipOZyOJlHjXYIWd81/nBpTiXZuahW+Hbz5Ekd
	 /1qrWIDHcM1SBSQRLAlrxF4SRVzdpu/7+QUCUISdf+3f03z56Ts2nNJths2pSwZZpY
	 mdUym407KwnUg==
From: carlos.bilbao@kernel.org
To: jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: sforshee@kernel.org,
	bilbao@vt.edu,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: [PATCH] bonding: Switch periodic LACPDU state machine from counter to jiffies
Date: Tue, 15 Jul 2025 15:57:33 -0500
Message-ID: <20250715205733.50911-1-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <carlos.bilbao@kernel.org>

Replace the bonding periodic state machine for LACPDU transmission of
function ad_periodic_machine() with a jiffies-based mechanism, which is
more accurate and can help reduce drift under contention.

Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
---
 drivers/net/bonding/bond_3ad.c | 79 +++++++++++++---------------------
 include/net/bond_3ad.h         |  2 +-
 2 files changed, 32 insertions(+), 49 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c6807e473ab7..8654a51266a3 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1421,44 +1421,24 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
 	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
 	    !bond_params->lacp_active) {
 		port->sm_periodic_state = AD_NO_PERIODIC;
-	}
-	/* check if state machine should change state */
-	else if (port->sm_periodic_timer_counter) {
-		/* check if periodic state machine expired */
-		if (!(--port->sm_periodic_timer_counter)) {
-			/* if expired then do tx */
-			port->sm_periodic_state = AD_PERIODIC_TX;
-		} else {
-			/* If not expired, check if there is some new timeout
-			 * parameter from the partner state
-			 */
-			switch (port->sm_periodic_state) {
-			case AD_FAST_PERIODIC:
-				if (!(port->partner_oper.port_state
-				      & LACP_STATE_LACP_TIMEOUT))
-					port->sm_periodic_state = AD_SLOW_PERIODIC;
-				break;
-			case AD_SLOW_PERIODIC:
-				if ((port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT)) {
-					port->sm_periodic_timer_counter = 0;
-					port->sm_periodic_state = AD_PERIODIC_TX;
-				}
-				break;
-			default:
-				break;
-			}
-		}
+	} else if (port->sm_periodic_state == AD_NO_PERIODIC)
+		port->sm_periodic_state = AD_FAST_PERIODIC;
+	/* check if periodic state machine expired */
+	else if (time_after_eq(jiffies, port->sm_periodic_next_jiffies)) {
+		/* if expired then do tx */
+		port->sm_periodic_state = AD_PERIODIC_TX;
 	} else {
+		/* If not expired, check if there is some new timeout
+		 * parameter from the partner state
+		 */
 		switch (port->sm_periodic_state) {
-		case AD_NO_PERIODIC:
-			port->sm_periodic_state = AD_FAST_PERIODIC;
-			break;
-		case AD_PERIODIC_TX:
-			if (!(port->partner_oper.port_state &
-			    LACP_STATE_LACP_TIMEOUT))
+		case AD_FAST_PERIODIC:
+			if (!(port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
 				port->sm_periodic_state = AD_SLOW_PERIODIC;
-			else
-				port->sm_periodic_state = AD_FAST_PERIODIC;
+			break;
+		case AD_SLOW_PERIODIC:
+			if ((port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
+				port->sm_periodic_state = AD_PERIODIC_TX;
 			break;
 		default:
 			break;
@@ -1471,21 +1451,24 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
 			  "Periodic Machine: Port=%d, Last State=%d, Curr State=%d\n",
 			  port->actor_port_number, last_state,
 			  port->sm_periodic_state);
+
 		switch (port->sm_periodic_state) {
-		case AD_NO_PERIODIC:
-			port->sm_periodic_timer_counter = 0;
-			break;
-		case AD_FAST_PERIODIC:
-			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
-			port->sm_periodic_timer_counter = __ad_timer_to_ticks(AD_PERIODIC_TIMER, (u16)(AD_FAST_PERIODIC_TIME))-1;
-			break;
-		case AD_SLOW_PERIODIC:
-			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
-			port->sm_periodic_timer_counter = __ad_timer_to_ticks(AD_PERIODIC_TIMER, (u16)(AD_SLOW_PERIODIC_TIME))-1;
-			break;
 		case AD_PERIODIC_TX:
 			port->ntt = true;
-			break;
+			if (!(port->partner_oper.port_state &
+						LACP_STATE_LACP_TIMEOUT))
+				port->sm_periodic_state = AD_SLOW_PERIODIC;
+			else
+				port->sm_periodic_state = AD_FAST_PERIODIC;
+		fallthrough;
+		case AD_SLOW_PERIODIC:
+		case AD_FAST_PERIODIC:
+			if (port->sm_periodic_state == AD_SLOW_PERIODIC)
+				port->sm_periodic_next_jiffies = jiffies
+					+ HZ * AD_SLOW_PERIODIC_TIME;
+			else /* AD_FAST_PERIODIC */
+				port->sm_periodic_next_jiffies = jiffies
+					+ HZ * AD_FAST_PERIODIC_TIME;
 		default:
 			break;
 		}
@@ -1987,7 +1970,7 @@ static void ad_initialize_port(struct port *port, int lacp_fast)
 		port->sm_rx_state = 0;
 		port->sm_rx_timer_counter = 0;
 		port->sm_periodic_state = 0;
-		port->sm_periodic_timer_counter = 0;
+		port->sm_periodic_next_jiffies = 0;
 		port->sm_mux_state = 0;
 		port->sm_mux_timer_counter = 0;
 		port->sm_tx_state = 0;
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index 2053cd8e788a..aabb8c97caf4 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -227,7 +227,7 @@ typedef struct port {
 	rx_states_t sm_rx_state;	/* state machine rx state */
 	u16 sm_rx_timer_counter;	/* state machine rx timer counter */
 	periodic_states_t sm_periodic_state;	/* state machine periodic state */
-	u16 sm_periodic_timer_counter;	/* state machine periodic timer counter */
+	unsigned long sm_periodic_next_jiffies;	/* state machine periodic next expected sent */
 	mux_states_t sm_mux_state;	/* state machine mux state */
 	u16 sm_mux_timer_counter;	/* state machine mux timer counter */
 	tx_states_t sm_tx_state;	/* state machine tx state */
-- 
2.43.0


