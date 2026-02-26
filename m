Return-Path: <netdev+bounces-261337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B/QIs9CoGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:55:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 486321A5F59
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE9FF30C1BBD
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34862DA749;
	Thu, 26 Feb 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgyXd5B8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475892D94AC
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110441; cv=none; b=Jq1k87hmPshs4iWr3wqFW/IWtEZuLHAyFApzKTKayRQjb3gYRzsXw4zkrJqNtArBVgI4MQcpJTynYDKOJFWm8GdoO+iU172rteQENuqBUb31a2h8EA/LHn/qSltFqx7o/dES+Pff0epVig2RzwyVCIPHAC76LtDxRiDuwLDiY30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110441; c=relaxed/simple;
	bh=EOlFZQfF9Me2mXWrNa0wqh7Ijd2um5Sdh6uvsfuEhsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVJu1EbVOC+f8F1NUIjLspexZhzHiF+Zlu9LA2LlmAIm9uY5DZqGuqhMHg0X+TB+guiSPKwu/kmKuT/YBgOBQBJBsJAu+PNXe73J2kiSGoxwq5q8vB6Lpr1Xxe9S0+iRhuiTZuni7Y2hXimMnmODdWU5lBR8N9sCdYWDBAydD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgyXd5B8; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso277868a12.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772110439; x=1772715239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqli0nfMs/A4Vg2iZeEDlDkF30pGRggTn9I8T0+gOmI=;
        b=NgyXd5B83JIEu9HmSVvI/DjvZ2nH5gHSTf0Y9bb1bRA6G2YuYxWi6XhcqUu343ksfB
         yfaYQvC3GjebDrsuTrrcLjYzB/HGSMeI9rhb3P+AHFY8i4YdrzQKyU/ldKiUGCU57kLa
         0qLmR2H7+aUpzxdRsPUFvZNx4NQ1g7vzFhzYOfiigyzzfAOqYpGN1escWZt49yT8eEXu
         kS6oiR79IP7Kp8f7vpbRdrdg6TZqTA+f1R/Okra/CC1W3Xuhgdc7ZBz0dzN78kuhd2/b
         qIvfF0mvuk2iNiH8cN3AJ+8y90HokEJBTh7CNeJ5yzfFrhpT5iZqnjkej9d/GEJtZfzC
         R1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110439; x=1772715239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mqli0nfMs/A4Vg2iZeEDlDkF30pGRggTn9I8T0+gOmI=;
        b=OO1DM938iJnCXi+Pr7k68fBJUs2Z46F22/sKLvJaBtnBC8rNX3AoHSZi8shySa1dQv
         9V786UxN25GOg9vodNqhzSBx9AHY7QbhpcI/CimTwnH5EP2CI6tDmF2LSk00wKu8zaTK
         XJIBcpbrQDIKu6XGYXGUrpkCNBwzgTYA+wEpU45WKomMmoIuU4BYTOkwznpmXhuZB19Q
         uUtNGNbg57Chw+eA5vGEc8HzoN1TBvYpewcHUkovQrOnkRGOPnpsjwOIF5pK8Bvapzet
         XQrGbcvwpj5SX4ntiiLKwjmeSX8WLSsmaNc7Rzp1T29Jhi2e9NTA9vW+cUvRUGyYBS6m
         dKpA==
X-Gm-Message-State: AOJu0YwWTCdg8KRlPDGiJgwQmeSDW1d7O+SEqsse4M01rDijEFzV2uQO
	/iYgMmk95+7NdPtA0Fv8xcCEnhCcIiAayN0JL4oGcV6YN2pmP1s11EgDH5TfvDo/oj4=
X-Gm-Gg: ATEYQzy1qHyvI+KCGIZj3AIQXtNXalcvP4eXXQ1aZeK54/d6Hkk0YvPJcNVihoy8Bep
	r91krOqi6iz22qJpF5o+19KjuVM4B1DngxwSMM4h9udJ1FbySZjgddCwOs5wfjCO6mPYslnAKY7
	bn9FqEOH35YEVLoO5ynvlYRFA62pAnRMw7m4S0Sm+PQp8E23c9+hWE5AkSc805e6tfkRosN5x30
	dY0wcZFBNf1Czd0SmQ1NZftd9ICZiTj0BO8qg+pwZtshsiNb5yIXpm8HhoqSw7gdmYSpEhKUrLc
	StpabBc5/AvmW5DzHQ+B8oqRPThKd40BNfL4Qx4mlh3xWn8isWCY08ytvfxl6aTQ4s+Zuh8cEMK
	NlXhqp5Wb58JPsd+c8YT8nInFTnVzhboiixkXdZI+jCot6s2WyYAn1HEl1TvFigAYYmfZGGAHra
	ARYVghA8xm/NdwZmtdMHqRWRdquDY=
X-Received: by 2002:a17:903:985:b0:2a0:823f:4da6 with SMTP id d9443c01a7336-2ad7456d474mr188212875ad.50.1772110439413;
        Thu, 26 Feb 2026 04:53:59 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb705b53sm25276715ad.92.2026.02.26.04.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:53:58 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mahesh Bandewar <maheshb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Liang Li <liali@redhat.com>
Subject: [PATCHv3 net 2/3] bonding: restructure ad_churn_machine
Date: Thu, 26 Feb 2026 12:53:29 +0000
Message-ID: <20260226125331.28147-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260226125331.28147-1-liuhangbin@gmail.com>
References: <20260226125331.28147-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-261337-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 486321A5F59
X-Rspamd-Action: no action

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
index c47f6a69fd2a..68258d61fd1c 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -44,7 +44,6 @@
 #define AD_PORT_STANDBY         0x80
 #define AD_PORT_SELECTED        0x100
 #define AD_PORT_MOVED           0x200
-#define AD_PORT_CHURNED         (AD_PORT_ACTOR_CHURN | AD_PORT_PARTNER_CHURN)
 
 /* Port Key definitions
  * key is determined according to the link speed, duplex and
@@ -1254,7 +1253,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 	/* first, check if port was reinitialized */
 	if (port->sm_vars & AD_PORT_BEGIN) {
 		port->sm_rx_state = AD_RX_INITIALIZE;
-		port->sm_vars |= AD_PORT_CHURNED;
 	/* check if port is not enabled */
 	} else if (!(port->sm_vars & AD_PORT_BEGIN) && !port->is_enabled)
 		port->sm_rx_state = AD_RX_PORT_DISABLED;
@@ -1262,8 +1260,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 	else if (lacpdu && ((port->sm_rx_state == AD_RX_EXPIRED) ||
 		 (port->sm_rx_state == AD_RX_DEFAULTED) ||
 		 (port->sm_rx_state == AD_RX_CURRENT))) {
-		if (port->sm_rx_state != AD_RX_CURRENT)
-			port->sm_vars |= AD_PORT_CHURNED;
 		port->sm_rx_timer_counter = 0;
 		port->sm_rx_state = AD_RX_CURRENT;
 	} else {
@@ -1347,7 +1343,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 			port->partner_oper.port_state |= LACP_STATE_LACP_TIMEOUT;
 			port->sm_rx_timer_counter = __ad_timer_to_ticks(AD_CURRENT_WHILE_TIMER, (u16)(AD_SHORT_TIMEOUT));
 			port->actor_oper_port_state |= LACP_STATE_EXPIRED;
-			port->sm_vars |= AD_PORT_CHURNED;
 			break;
 		case AD_RX_DEFAULTED:
 			__update_default_selected(port);
@@ -1379,11 +1374,41 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
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
@@ -1392,25 +1417,46 @@ static void ad_churn_machine(struct port *port)
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


