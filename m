Return-Path: <netdev+bounces-199216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 334ECADF745
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34F13B5363
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E1921931B;
	Wed, 18 Jun 2025 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTIo2LKW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ADA1E0B91;
	Wed, 18 Jun 2025 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276394; cv=none; b=qElRkBWoIRCCdi7afCPv2cFzgoP7V0wszqn4dZDe5yitN/59P8gtg7RA3YLEIp7zkztjHjnnLmk6l15dO685NRyeVLtMUCau3rGuLkmiIQPml2ghV6V/IUhOcrz0om840HKUwdjR1p9wnllDubOmExc6qZLbmns9/O2HK+46d9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276394; c=relaxed/simple;
	bh=oPU7685ZJ45AjRsgwSe2lgXLJwMXeypEgdbEMPJe2vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PRbGwIcdk4YDux5UncNehNsgEmLd4xsePZdOJshp1lxMm38jbhhviiUUpdMovAk3YZ9QytvZbngrmvOfBLDZxQOzrK5yxFNadjYxhQ2L5U9zURpn0tb5BD7fSPaCgudBobT7KGC4eGDRBiorOoOfXi069X0m0McIAf0c4w9Hr5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTIo2LKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2377CC4CEE7;
	Wed, 18 Jun 2025 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750276394;
	bh=oPU7685ZJ45AjRsgwSe2lgXLJwMXeypEgdbEMPJe2vc=;
	h=From:To:Cc:Subject:Date:From;
	b=bTIo2LKWrQmMfucTfZhxO4p9e3pTYIQbc0DAJAWc5jdTuTrcpW0yHZ5gpuiAlxY0t
	 3suoh0Bol753Y6XPBjgkcENJZLY7kRF18nLC53EvBlZXOJMr4c4a13qWuuaCSXrjek
	 aAtF3fi94ztvqMr6TskS7p5sck2agv36aERLyjhBd1J3Pe1wa8c5cKXTlQ+IUQVVrX
	 A2Q8t2n2fdCDnmSInKFtKYtMNXdh/XugomTpbIivILWo1+sUbOSuhYZdS4eKOl+dhG
	 hzdZRlC/8cbLL2GoziL9BrhNDe73LFklxt6JhcdJ+vlUqkqh12gLJF+sTapKVps3YY
	 Wm41Uhd59vXWg==
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
Subject: [PATCH] bonding: Improve the accuracy of LACPDU transmissions
Date: Wed, 18 Jun 2025 14:53:09 -0500
Message-ID: <20250618195309.368645-1-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <carlos.bilbao@kernel.org>

Improve the timing accuracy of LACPDU transmissions in the bonding 802.3ad
(LACP) driver. The current approach relies on a decrementing counter to
limit the transmission rate. In our experience, this method is susceptible
to delays (such as those caused by CPU contention or soft lockups) which
can lead to accumulated drift in the LACPDU send interval. Over time, this
drift can cause synchronization issues with the top-of-rack (ToR) switch
managing the LAG, manifesting as lag map flapping. This in turn can trigger
temporary interface removal and potential packet loss.

This patch improves stability with a jiffies-based mechanism to track and
enforce the minimum transmission interval; keeping track of when the next
LACPDU should be sent.

Suggested-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
---
 drivers/net/bonding/bond_3ad.c | 18 ++++++++----------
 include/net/bond_3ad.h         |  5 +----
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c6807e473ab7..47610697e4e5 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1375,10 +1375,12 @@ static void ad_churn_machine(struct port *port)
  */
 static void ad_tx_machine(struct port *port)
 {
-	/* check if tx timer expired, to verify that we do not send more than
-	 * 3 packets per second
-	 */
-	if (port->sm_tx_timer_counter && !(--port->sm_tx_timer_counter)) {
+	unsigned long now = jiffies;
+
+	/* Check if enough time has passed since the last LACPDU sent */
+	if (time_after_eq(now, port->sm_tx_next_jiffies)) {
+		port->sm_tx_next_jiffies += ad_ticks_per_sec / AD_MAX_TX_IN_SECOND;
+
 		/* check if there is something to send */
 		if (port->ntt && (port->sm_vars & AD_PORT_LACP_ENABLED)) {
 			__update_lacpdu_from_port(port);
@@ -1395,10 +1397,6 @@ static void ad_tx_machine(struct port *port)
 				port->ntt = false;
 			}
 		}
-		/* restart tx timer(to verify that we will not exceed
-		 * AD_MAX_TX_IN_SECOND
-		 */
-		port->sm_tx_timer_counter = ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
 	}
 }
 
@@ -2199,9 +2197,9 @@ void bond_3ad_bind_slave(struct slave *slave)
 		/* actor system is the bond's system */
 		__ad_actor_update_port(port);
 		/* tx timer(to verify that no more than MAX_TX_IN_SECOND
-		 * lacpdu's are sent in one second)
+		 * lacpdu's are sent in the configured interval (1 or 30 secs))
 		 */
-		port->sm_tx_timer_counter = ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
+		port->sm_tx_next_jiffies = jiffies + ad_ticks_per_sec / AD_MAX_TX_IN_SECOND;
 
 		__disable_port(port);
 
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index 2053cd8e788a..956d4cb45db1 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -231,10 +231,7 @@ typedef struct port {
 	mux_states_t sm_mux_state;	/* state machine mux state */
 	u16 sm_mux_timer_counter;	/* state machine mux timer counter */
 	tx_states_t sm_tx_state;	/* state machine tx state */
-	u16 sm_tx_timer_counter;	/* state machine tx timer counter
-					 * (always on - enter to transmit
-					 *  state 3 time per second)
-					 */
+	unsigned long sm_tx_next_jiffies;/* expected jiffies for next LACPDU sent */
 	u16 sm_churn_actor_timer_counter;
 	u16 sm_churn_partner_timer_counter;
 	u32 churn_actor_count;
-- 
2.43.0


