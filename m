Return-Path: <netdev+bounces-200983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04304AE7A70
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D3D168536
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A6127F187;
	Wed, 25 Jun 2025 08:39:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C513270565
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840763; cv=none; b=LPcKsyyy7ZmQto2cjuHfZ1bEiL4xGJkQQV1s0QHaminJHRa8b2ZZOlFFehaXZ72n6mlOKTionFFo9yfQXCBAxtZWYbXw4KGuAJrp+6z8cN/Eaz+5p5T0vExCiA9QVs7q9wZT3uwHsMHZJtnTdORJ6ESnZm2gbLtnF5cfgBb/Ep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840763; c=relaxed/simple;
	bh=0yc8uei6GfxD9iFGqlSZm6BHT3C8+n5vPHXZSIqu4iM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qaTQ2cjrnycihiQePijoSrWFuSIaLj2f1mSp+1Wu+nZNiZ58hIK2gHHWNaQTkzan95lkYYHipC3W86Sh/8gIx0Fa5m0pjika8ws9IADFXN63mhILyFIk8jHYZ/N6yyVZyOw8og6ATQMyjYSVkdShL2+WnSsP62BI0tGiMpOYHhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULez-0006WI-Iv; Wed, 25 Jun 2025 10:39:13 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULey-005Fdm-1b;
	Wed, 25 Jun 2025 10:39:12 +0200
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULey-00FT0E-1P;
	Wed, 25 Jun 2025 10:39:12 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Date: Wed, 25 Jun 2025 10:39:13 +0200
Subject: [PATCH iproute2-next v6 1/3] bridge: move mcast querier dumping
 code into a shared function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-mcast-querier-vlan-lib-v6-1-03659be44d48@pengutronix.de>
References: <20250625-mcast-querier-vlan-lib-v6-0-03659be44d48@pengutronix.de>
In-Reply-To: <20250625-mcast-querier-vlan-lib-v6-0-03659be44d48@pengutronix.de>
To: netdev@vger.kernel.org
Cc: entwicklung@pengutronix.de, razor@blackwall.org, 
 bridge@lists.linux-foundation.org, dsahern@gmail.com, idosch@nvidia.com, 
 Fabian Pfitzner <f.pfitzner@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Put mcast querier dumping code into a shared function. This function
will be called from the bridge utility in a later patch.

Adapt the code such that the vtb parameter is used
instead of tb[IFLA_BR_MCAST_QUERIER_STATE].

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---
 include/bridge.h   |  3 +++
 ip/iplink_bridge.c | 59 +++-------------------------------------------------
 lib/bridge.c       | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 56 deletions(-)

diff --git a/include/bridge.h b/include/bridge.h
index 8bcd1e38..8b0942b5 100644
--- a/include/bridge.h
+++ b/include/bridge.h
@@ -3,9 +3,12 @@
 #define __BRIDGE_H__ 1
 
 #include <linux/if_bridge.h>
+#include <linux/rtnetlink.h>
 
 void bridge_print_vlan_flags(__u16 flags);
 void bridge_print_vlan_stats_only(const struct bridge_vlan_xstats *vstats);
 void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats);
 
+void bridge_print_mcast_querier_state(const struct rtattr *vtb);
+
 #endif /* __BRIDGE_H__ */
diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 31e7cb5e..76e69086 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -682,62 +682,9 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
 
 	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
-		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
-		SPRINT_BUF(other_time);
-
-		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
-		memset(other_time, 0, sizeof(other_time));
-
-		open_json_object("mcast_querier_state_ipv4");
-		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
-			print_string(PRINT_FP,
-				NULL,
-				"%s ",
-				"mcast_querier_ipv4_addr");
-			print_color_string(PRINT_ANY,
-				COLOR_INET,
-				"mcast_querier_ipv4_addr",
-				"%s ",
-				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
-		}
-		if (bqtb[BRIDGE_QUERIER_IP_PORT])
-			print_uint(PRINT_ANY,
-				"mcast_querier_ipv4_port",
-				"mcast_querier_ipv4_port %u ",
-				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
-		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
-			print_string(PRINT_ANY,
-				"mcast_querier_ipv4_other_timer",
-				"mcast_querier_ipv4_other_timer %s ",
-				sprint_time64(
-					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
-									other_time));
-		close_json_object();
-		open_json_object("mcast_querier_state_ipv6");
-		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
-			print_string(PRINT_FP,
-				NULL,
-				"%s ",
-				"mcast_querier_ipv6_addr");
-			print_color_string(PRINT_ANY,
-				COLOR_INET6,
-				"mcast_querier_ipv6_addr",
-				"%s ",
-				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
-		}
-		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
-			print_uint(PRINT_ANY,
-				"mcast_querier_ipv6_port",
-				"mcast_querier_ipv6_port %u ",
-				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
-		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
-			print_string(PRINT_ANY,
-				"mcast_querier_ipv6_other_timer",
-				"mcast_querier_ipv6_other_timer %s ",
-				sprint_time64(
-					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
-									other_time));
-		close_json_object();
+		struct rtattr *vtb = tb[IFLA_BR_MCAST_QUERIER_STATE];
+
+		bridge_print_mcast_querier_state(vtb);
 	}
 
 	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
diff --git a/lib/bridge.c b/lib/bridge.c
index a888a20e..480693c9 100644
--- a/lib/bridge.c
+++ b/lib/bridge.c
@@ -45,3 +45,64 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)
 
 	close_json_object();
 }
+
+void bridge_print_mcast_querier_state(const struct rtattr *vtb)
+{
+	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+
+	SPRINT_BUF(other_time);
+
+	parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb);
+	memset(other_time, 0, sizeof(other_time));
+
+	open_json_object("mcast_querier_state_ipv4");
+	if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
+		print_string(PRINT_FP,
+			NULL,
+			"%s ",
+			"mcast_querier_ipv4_addr");
+		print_color_string(PRINT_ANY,
+			COLOR_INET,
+			"mcast_querier_ipv4_addr",
+			"%s ",
+			format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
+	}
+	if (bqtb[BRIDGE_QUERIER_IP_PORT])
+		print_uint(PRINT_ANY,
+			"mcast_querier_ipv4_port",
+			"mcast_querier_ipv4_port %u ",
+			rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
+	if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
+		print_string(PRINT_ANY,
+			"mcast_querier_ipv4_other_timer",
+			"mcast_querier_ipv4_other_timer %s ",
+			sprint_time64(
+				rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
+								other_time));
+	close_json_object();
+	open_json_object("mcast_querier_state_ipv6");
+	if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
+		print_string(PRINT_FP,
+			NULL,
+			"%s ",
+			"mcast_querier_ipv6_addr");
+		print_color_string(PRINT_ANY,
+			COLOR_INET6,
+			"mcast_querier_ipv6_addr",
+			"%s ",
+			format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
+	}
+	if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
+		print_uint(PRINT_ANY,
+			"mcast_querier_ipv6_port",
+			"mcast_querier_ipv6_port %u ",
+			rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
+	if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
+		print_string(PRINT_ANY,
+			"mcast_querier_ipv6_other_timer",
+			"mcast_querier_ipv6_other_timer %s ",
+			sprint_time64(
+				rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
+								other_time));
+	close_json_object();
+}

-- 
2.39.5


