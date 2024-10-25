Return-Path: <netdev+bounces-139139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7849B05E9
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28CD9B21332
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3CB1FB8A1;
	Fri, 25 Oct 2024 14:34:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245318E76C
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866849; cv=none; b=FgBgH5cn5SBFfPQV5PxQHKfkQebzm3cs5+U1wkkce57qw06shFc6sYhQ35rPKRh+PuHOODT4SzfK/HeZ+IJxiu8N7zDa5+3WUCQWpUd/+gLHjJct25v/edcGkmVxPrlRrrrl7pP5JAYfQb8YV0LgdkTBx/OClEZCqtwJoP7chXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866849; c=relaxed/simple;
	bh=yn9J/ld5c/NZbwlR/ZkJtxP7FfE44j4YB9QFTAgXXyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=thBSaapBUgc1lWzQSUQCz1oNK05Rqr8ju6L9uWcPmhKZNwY7cgHKwUbooFug4msEPUuI7/KYwAa+sIEN70vy2a2V3bgj/o9g6cbO5vylZxlliKENARS1CfBP4vrvUphzHyFyUB6oeO6oNxkd2sauxJukzYIoq6Fmb8qksjky43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1t4LO8-0007qY-UV; Fri, 25 Oct 2024 16:34:04 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1t4LO8-000Np2-2O;
	Fri, 25 Oct 2024 16:34:04 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1t4LO8-0017Fu-2D;
	Fri, 25 Oct 2024 16:34:04 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: entwicklung@pengutronix.de,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH iproute] bridge: dump mcast querier state
Date: Fri, 25 Oct 2024 16:28:37 +0200
Message-Id: <20241025142836.19946-1-f.pfitzner@pengutronix.de>
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
 ip/iplink_bridge.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index f01ffe15..fb92a498 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -661,6 +661,54 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   "mcast_querier %u ",
 			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
 
+	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
+		SPRINT_BUF(other_time);
+		memset(other_time, 0, sizeof(other_time));
+
+		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+
+		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
+
+		open_json_object("mcast_querier_state_ipv4");
+		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS])
+			print_string(PRINT_ANY,
+				"mcast_querier_ipv4_addr",
+				"mcast_querier_ipv4_addr %s ",
+				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
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
+		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS])
+			print_string(PRINT_ANY,
+				"mcast_querier_ipv6_addr",
+				"mcast_querier_ipv6_addr %s ",
+				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
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


