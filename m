Return-Path: <netdev+bounces-140309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F99B5E37
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 09:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB44B284314
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D371E1A1C;
	Wed, 30 Oct 2024 08:48:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3415B0F7
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278102; cv=none; b=jOg8d+OinO/qUbwD5KHUcu3aix5KPWF5F27ZG1azj/xb4WYEP/4fnsPG5MKr5Nm7AWVQC3F975V+9Fwb5x7oxR1z1Wo2femnBdwaIzD3+FhCj9y9cOnDLOy1R81keHlcB7MnKjQN1R1/YDXv1K2Chu7c+T9NvgNFMo9O7ejneSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278102; c=relaxed/simple;
	bh=7X+BkPWVY3jrDds8UbTE1K7ELbI+fgW1NyOMDM+42sI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lCYbreYUCX6lgzsBosiszVPSqUHUWEaitiVTvXr3f0ktve2Kzl5NPFykF954UykCXnT06z4z9vU9IB9SqBU8bmV0RPc6Mp0WE9uDV/XxnxdpqtN9xQ+X+79vE7ZXmEPTuCrukvKa/bZVCYtU6YqWNAKnMnaBu/QOvKPG+yat3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1t64N8-0001WQ-6Z; Wed, 30 Oct 2024 09:48:10 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1t64N7-001AO7-35;
	Wed, 30 Oct 2024 09:48:09 +0100
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1t64N7-000ZWZ-2u;
	Wed, 30 Oct 2024 09:48:09 +0100
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: entwicklung@pengutronix.de,
	bridge@lists.linux-foundation.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH v2 iproute] bridge: dump mcast querier state
Date: Wed, 30 Oct 2024 09:46:23 +0100
Message-Id: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
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

v1->v2: refactor code

 ip/iplink_bridge.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index f01ffe15..f74436d3 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -661,6 +661,53 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   "mcast_querier %u ",
 			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
 
+	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
+		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+		SPRINT_BUF(other_time);
+
+		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
+		memset(other_time, 0, sizeof(other_time));
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


