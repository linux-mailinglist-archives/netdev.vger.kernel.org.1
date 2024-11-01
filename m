Return-Path: <netdev+bounces-141002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AE29B90AA
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 12:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A411B1C2074D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254CA17C227;
	Fri,  1 Nov 2024 11:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875DA15820C
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462005; cv=none; b=JNZBYdJ6wstH5NJBCkUwTn66nr/u2FmRkh2IVpFPE3Yb18uYeOHhOr2G5Z+5lu3bo2xEhofuU7dyLIkk20bHXMZbPfr7WQVmAk/iuz7on6pIDfnBF6nAyUi8QcZ/s90jiRlm8hBLbSpxueY1ysP/WY6tFZG7Oybqk0Fx1dvDmFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462005; c=relaxed/simple;
	bh=5WpOuEix74X7yKM6WtxCZXsnuVlB/PdCVvCIoID6/jY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n5zPU9rRwc0HOnkSvCMVgXmSR1i+D/42PsXMzhQn+20rKzMzolIqbzz84VasEZxVCqXgEpoty6iePBhuG66Dwb0n2QOomx+DTS/raj3/JEEwAAJ5flwG9Y7E7IFoCH3ZPtuii3ilRZDxTSPkcHkR/KGyUn6hzmE3YjFDXyS/gdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1t6qDO-0006Ep-ED; Fri, 01 Nov 2024 12:53:18 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1t6qDM-001VL6-1p;
	Fri, 01 Nov 2024 12:53:16 +0100
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1t6qDM-00AveW-1e;
	Fri, 01 Nov 2024 12:53:16 +0100
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	entwicklung@pengutronix.de,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux-foundation.org,
	stephen@networkplumber.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH v3 iproute] bridge: dump mcast querier state
Date: Fri,  1 Nov 2024 12:50:40 +0100
Message-Id: <20241101115039.2604631-1-f.pfitzner@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

Kernel support for dumping the multicast querier state was added in this
commit [1]. As some people might be interested to get this information
from userspace, this commit implements the necessary changes to show it
via

ip -d link show [dev]

The querier state shows the following information for IPv4 and IPv6
respectively:

1) The ip address of the current querier in the network. This could be
   ourselves or an external querier.
2) The port on which the querier was seen
3) Querier timeout in seconds

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---

v1->v2
	- refactor code
	- link to v1: https://lore.kernel.org/netdev/20241025142836.19946-1-f.pfitzner@pengutronix.de/
v2->v3
	- use print_color_string for addresses
	- link to v2: https://lore.kernel.org/netdev/20241030222136.3395120-1-f.pfitzner@pengutronix.de/

 ip/iplink_bridge.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index f01ffe15..9c01154b 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -661,6 +661,66 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   "mcast_querier %u ",
 			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
 
+	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
+		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+
+		SPRINT_BUF(other_time);
+
+		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
+		memset(other_time, 0, sizeof(other_time));
+
+		open_json_object("mcast_querier_state_ipv4");
+		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
+			print_string(PRINT_FP,
+				NULL,
+				"%s ",
+				"mcast_querier_ipv4_addr");
+			print_color_string(PRINT_ANY,
+				COLOR_INET,
+				"mcast_querier_ipv4_addr",
+				"%s ",
+				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
+		}
+		if (bqtb[BRIDGE_QUERIER_IP_PORT])
+			print_uint(PRINT_ANY,
+				"mcast_querier_ipv4_port",
+				"mcast_querier_ipv4_port %u ",
+				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
+		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
+			print_string(PRINT_ANY,
+				"mcast_querier_ipv4_other_timer",
+				"mcast_querier_ipv4_other_timer %s ",
+				sprint_time64(
+					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
+									other_time));
+		close_json_object();
+		open_json_object("mcast_querier_state_ipv6");
+		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
+			print_string(PRINT_FP,
+				NULL,
+				"%s ",
+				"mcast_querier_ipv6_addr");
+			print_color_string(PRINT_ANY,
+				COLOR_INET6,
+				"mcast_querier_ipv6_addr",
+				"%s ",
+				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
+		}
+		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
+			print_uint(PRINT_ANY,
+				"mcast_querier_ipv6_port",
+				"mcast_querier_ipv6_port %u ",
+				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
+		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
+			print_string(PRINT_ANY,
+				"mcast_querier_ipv6_other_timer",
+				"mcast_querier_ipv6_other_timer %s ",
+				sprint_time64(
+					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
+									other_time));
+		close_json_object();
+	}
+
 	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
 		print_uint(PRINT_ANY,
 			   "mcast_hash_elasticity",
-- 
2.39.5


