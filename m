Return-Path: <netdev+bounces-200175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA14AE38E7
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6EF163259
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 08:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E562121B8F6;
	Mon, 23 Jun 2025 08:48:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38174226CF0
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668505; cv=none; b=hAog9j0nFnS+pHPtK2nYY88wOdt+/WrPkNmMsujTZ6q8DpkSeFHFl84i50yHABTdEt7lOQK5mnoHfGUq7df/OIVtHkj9//ztXqSJ8/go8lTVnCivDmW+btG5ILerXTSao2FS26CT8BqvVhkFluveJlGvE2pvt84JzQo/P27W4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668505; c=relaxed/simple;
	bh=aYdJuyCU85OcDHYQ2lRXBVfTia6qUszL+TKkbQTh9ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRjMyASKlRqLOgH4DzeaMJLjAICYOj09YJEsKQjkOVmIEt+7+3dHTfrS6M7M4S5CzSBwcDOLyRpMJ6zGVRvuK3+mnAC6vNuq1xriKAIcPVxtRdPKWUIBx0SayXhbYOikxEYf9PBa0JI7Ncr/jP6Kls/rcgGR39impLIGwUTEa1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcqk-0002sc-BQ; Mon, 23 Jun 2025 10:48:22 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcqk-004uxi-0H;
	Mon, 23 Jun 2025 10:48:22 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcqk-004eHH-06;
	Mon, 23 Jun 2025 10:48:22 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	razor@blackwall.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH iproute2-next v4 3/3] bridge: refactor bridge mcast querier function
Date: Mon, 23 Jun 2025 10:45:22 +0200
Message-Id: <20250623084518.1101527-4-f.pfitzner@pengutronix.de>
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

Make code more readable and consistent with other functions.

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---
 lib/bridge.c | 72 +++++++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/lib/bridge.c b/lib/bridge.c
index 35cc409a..5386aa01 100644
--- a/lib/bridge.c
+++ b/lib/bridge.c
@@ -49,59 +49,55 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)
 void bridge_print_mcast_querier_state(const struct rtattr *vtb)
 {
 	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+	const char *querier_ip;
 	SPRINT_BUF(other_time);
+	__u64 tval;

 	parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb);
 	memset(other_time, 0, sizeof(other_time));

 	open_json_object("mcast_querier_state_ipv4");
 	if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
-		print_string(PRINT_FP,
-			NULL,
-			"%s ",
-			"mcast_querier_ipv4_addr");
-		print_color_string(PRINT_ANY,
-			COLOR_INET,
-			"mcast_querier_ipv4_addr",
-			"%s ",
-			format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
+		querier_ip = format_host_rta(AF_INET,
+					     bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
+		print_string(PRINT_FP, NULL, "%s ",
+			     "mcast_querier_ipv4_addr");
+		print_color_string(PRINT_ANY, COLOR_INET,
+				   "mcast_querier_ipv4_addr", "%s ",
+				   querier_ip);
 	}
 	if (bqtb[BRIDGE_QUERIER_IP_PORT])
-		print_uint(PRINT_ANY,
-			"mcast_querier_ipv4_port",
-			"mcast_querier_ipv4_port %u ",
-			rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
-	if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
+		print_uint(PRINT_ANY, "mcast_querier_ipv4_port",
+			   "mcast_querier_ipv4_port %u ",
+			   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
+	if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]) {
+		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]);
 		print_string(PRINT_ANY,
-			"mcast_querier_ipv4_other_timer",
-			"mcast_querier_ipv4_other_timer %s ",
-			sprint_time64(
-				rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
-								other_time));
+			     "mcast_querier_ipv4_other_timer",
+			     "mcast_querier_ipv4_other_timer %s ",
+			     sprint_time64(tval, other_time));
+	}
 	close_json_object();
 	open_json_object("mcast_querier_state_ipv6");
 	if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
-		print_string(PRINT_FP,
-			NULL,
-			"%s ",
-			"mcast_querier_ipv6_addr");
-		print_color_string(PRINT_ANY,
-			COLOR_INET6,
-			"mcast_querier_ipv6_addr",
-			"%s ",
-			format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
+		querier_ip = format_host_rta(AF_INET6,
+					     bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]);
+		print_string(PRINT_FP, NULL, "%s ",
+			     "mcast_querier_ipv6_addr");
+		print_color_string(PRINT_ANY, COLOR_INET6,
+				   "mcast_querier_ipv6_addr", "%s ",
+				   querier_ip);
 	}
 	if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
-		print_uint(PRINT_ANY,
-			"mcast_querier_ipv6_port",
-			"mcast_querier_ipv6_port %u ",
-			rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
-	if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
+		print_uint(PRINT_ANY, "mcast_querier_ipv6_port",
+			   "mcast_querier_ipv6_port %u ",
+			   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
+	if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]) {
+		tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]);
 		print_string(PRINT_ANY,
-			"mcast_querier_ipv6_other_timer",
-			"mcast_querier_ipv6_other_timer %s ",
-			sprint_time64(
-				rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
-								other_time));
+			     "mcast_querier_ipv6_other_timer",
+			     "mcast_querier_ipv6_other_timer %s ",
+			     sprint_time64(tval, other_time));
+	}
 	close_json_object();
 }
--
2.39.5


