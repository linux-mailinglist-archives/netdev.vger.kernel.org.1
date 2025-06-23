Return-Path: <netdev+bounces-200173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A01AE38DF
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE8A172B6F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 08:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FD922F740;
	Mon, 23 Jun 2025 08:47:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F122F152
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668459; cv=none; b=n176K4HjSpUvPa5Pldn4Uem6qYUfRvSnZvCt0UnV6KWjfUW9HUBru+veiATCNDiRctgTkWyZCIOvK0nzWLLEOlOcqpzWGXYmuGNJukfjK1s7QboIT9vj6cA8/+mPe+hG9+8xv4MrqjidQe1qrYbINmvpD9eb4D6F8djeW9sJOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668459; c=relaxed/simple;
	bh=qNc6GTlheLM80V5QuxI0fmiPiNuK2uca5oRKTRIo7hE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sIULhXjh5aX9kYhMK43gzJlABHJdB3fr6wCYCQr7Q7+ES1jYapCevudlcpLea9VFmjJHFvg6MRoFyD2XPkm6NxSRvzrEOqQs0EYJLKKbtJlXnpDKhQWYGkbLVcKkxaRvTc2mZFcOM7vnw2Tva5dS8sS+wRC2fgpzXNQygkn79DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcpz-0001u4-4f; Mon, 23 Jun 2025 10:47:35 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcpy-004ux9-2s;
	Mon, 23 Jun 2025 10:47:34 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcpy-004e0T-2h;
	Mon, 23 Jun 2025 10:47:34 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	razor@blackwall.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH iproute2-next v4 1/3] bridge: move mcast querier dumping code into a shared function
Date: Mon, 23 Jun 2025 10:45:18 +0200
Message-Id: <20250623084518.1101527-2-f.pfitzner@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623084518.1101527-1-f.pfitzner@pengutronix.de>
References: <20250623084518.1101527-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: fpf@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Put mcast querier dumping code into a shared function. This function
will be called from the bridge utility in a later patch.

Adapt the code such that the vtb parameter is used
instead of tb[IFLA_BR_MCAST_QUERIER_STATE].

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---

I decided to not only move the code into a separate function, but also
to adapt it to fit into the function. If I split it into a pure refactoring
and an adapting commit, the former will not compile preventing git bisects.

 include/bridge.h   |  3 +++
 ip/iplink_bridge.c | 58 ++------------------------------------------
 lib/bridge.c       | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 56 deletions(-)

diff --git a/include/bridge.h b/include/bridge.h
index 8bcd1e38..b2f978f4 100644
--- a/include/bridge.h
+++ b/include/bridge.h
@@ -3,9 +3,12 @@
 #define __BRIDGE_H__ 1

 #include <linux/if_bridge.h>
+#include <linux/rtnetlink.h>

 void bridge_print_vlan_flags(__u16 flags);
 void bridge_print_vlan_stats_only(const struct bridge_vlan_xstats *vstats);
 void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats);

+void bridge_print_mcast_querier_state(const struct rtattr* vtb);
+
 #endif /* __BRIDGE_H__ */
diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 31e7cb5e..4e1f5147 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -682,62 +682,8 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
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
+		bridge_print_mcast_querier_state(vtb);
 	}

 	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
diff --git a/lib/bridge.c b/lib/bridge.c
index a888a20e..35cc409a 100644
--- a/lib/bridge.c
+++ b/lib/bridge.c
@@ -45,3 +45,63 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)

 	close_json_object();
 }
+
+void bridge_print_mcast_querier_state(const struct rtattr *vtb)
+{
+	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
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


