Return-Path: <netdev+bounces-200986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C458CAE7A73
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4793B3FDD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491C928314A;
	Wed, 25 Jun 2025 08:39:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57127147A
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840764; cv=none; b=TRO+RJl1liy1+OV6/WLuCYscS88gefk6zeeoMoJsPLPHIyPj21/+AM4wK824IwllL4djq4A22HgDGJrT1dUcZeUhc0DFzm1WSNvSFd2Calb0Qb1at83QrCynT0pBIV1x8rwdDoKgIi7QzExcD1pxDtnYsQT6z/XN43tbpT5DqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840764; c=relaxed/simple;
	bh=2LwpDPhSmqsE6ynvcMtU9/l1N8p0wByRkxH7oogvnJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICYGoz0XQMoeR1zowMIHDt8LoyHScY+vHmfYABtS5zTu7KUinwylMGwcxGn3C95zEsaybyFCsHGysicUk+WydopOctqNuWv0vUm5frWDEjr/0ELshs4M/B+X6OPyzbZVXdBNdjjYxRBKuVl1KEDPbq0rz5/7cZXEciNwf++2gNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULez-0006WK-Iv; Wed, 25 Jun 2025 10:39:13 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULey-005Fdo-1g;
	Wed, 25 Jun 2025 10:39:12 +0200
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULey-00FT0E-1R;
	Wed, 25 Jun 2025 10:39:12 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Date: Wed, 25 Jun 2025 10:39:15 +0200
Subject: [PATCH iproute2-next v6 3/3] bridge: refactor bridge mcast querier
 function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-mcast-querier-vlan-lib-v6-3-03659be44d48@pengutronix.de>
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

Make code more readable and consistent with other functions.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---
 lib/bridge.c | 73 ++++++++++++++++++++++++++++--------------------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/lib/bridge.c b/lib/bridge.c
index 480693c9..5386aa01 100644
--- a/lib/bridge.c
+++ b/lib/bridge.c
@@ -49,60 +49,55 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)
 void bridge_print_mcast_querier_state(const struct rtattr *vtb)
 {
 	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
-
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


