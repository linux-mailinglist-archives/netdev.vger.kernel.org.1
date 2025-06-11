Return-Path: <netdev+bounces-196564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A7AD5527
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21031BC1296
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D182749E2;
	Wed, 11 Jun 2025 12:13:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A042E610F
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644003; cv=none; b=ZaMLRzsj5MHydgDH2D9PDuvN5lmCkOz7jHbgIqKzeHxj/3sBR5OPIwS4hEVzqZAOVTMd3fhNs08VbVhAl/xBK4KFdMj024V36QnXnQ9K0St2tW1S7mRQIee/tD38G2eitGavzlzJy4oMBRnuspWhzARw+NX3f+bWlFBOYsdPPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644003; c=relaxed/simple;
	bh=sPM052dHaSMGLKDwax5eRx1wwGJo4Wnmy6GY6SYUQiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pA2ctoMsoI5CmDaiYQh/enRz1CgzfdLwPlsWIexynNjjdchs31iTbXm6Wcesyv2zKYYJb0UOhIlcCD2CXLvFxlcHTMc3k5hHK9utjmvgM+e/y762w48RhxW+k56DadAtnI/HxgHStv/VVgx7q5O+C0HRfqdG2peI88JKYP+MjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uPKKU-0003bJ-9w; Wed, 11 Jun 2025 14:13:18 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uPKKU-002wUH-05;
	Wed, 11 Jun 2025 14:13:18 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uPKKT-006yvY-35;
	Wed, 11 Jun 2025 14:13:17 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	razor@blackwall.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH v2] bridge: dump mcast querier state per vlan
Date: Wed, 11 Jun 2025 14:11:52 +0200
Message-Id: <20250611121151.1660231-1-f.pfitzner@pengutronix.de>
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

Dump the multicast querier state per vlan.
This commit is almost identical to [1].

The querier state can be seen with:

bridge -d vlan global

The options for vlan filtering and vlan mcast snooping have to be enabled
in order to see the output:

ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1

The querier state shows the following information for IPv4 and IPv6
respectively:

1) The ip address of the current querier in the network. This could be
   ourselves or an external querier.
2) The port on which the querier was seen
3) Querier timeout in seconds

[1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---

v1->v2
	- refactor code
	- link to v1: https://lore.kernel.org/netdev/20250604105322.1185872-1-f.pfitzner@pengutronix.de/

 bridge/vlan.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index ea4aff93..2afdc7c7 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -892,6 +892,61 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
 		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
 			   rta_getattr_u8(vattr));
 	}
+	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
+		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+		const char *querier_ip;
+		SPRINT_BUF(other_time);
+		__u64 tval;
+
+		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX,
+				    vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);
+		memset(other_time, 0, sizeof(other_time));
+
+		open_json_object("mcast_querier_state_ipv4");
+		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
+			querier_ip = format_host_rta(AF_INET,
+						     bqtb[BRIDGE_QUERIER_IP_ADDRESS]);
+			print_string(PRINT_FP, NULL, "%s ",
+				     "mcast_querier_ipv4_addr");
+			print_color_string(PRINT_ANY, COLOR_INET,
+					   "mcast_querier_ipv4_addr", "%s ",
+					   querier_ip);
+		}
+		if (bqtb[BRIDGE_QUERIER_IP_PORT])
+			print_uint(PRINT_ANY, "mcast_querier_ipv4_port",
+				   "mcast_querier_ipv4_port %u ",
+				   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
+		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]) {
+			tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]);
+			print_string(PRINT_ANY,
+				     "mcast_querier_ipv4_other_timer",
+				     "mcast_querier_ipv4_other_timer %s ",
+				     sprint_time64(tval, other_time));
+		}
+		close_json_object();
+		open_json_object("mcast_querier_state_ipv6");
+		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
+			querier_ip = format_host_rta(AF_INET6,
+						     bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]);
+			print_string(PRINT_FP, NULL, "%s ",
+				     "mcast_querier_ipv6_addr");
+			print_color_string(PRINT_ANY, COLOR_INET6,
+					   "mcast_querier_ipv6_addr", "%s ",
+					   querier_ip);
+		}
+		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
+			print_uint(PRINT_ANY, "mcast_querier_ipv6_port",
+				   "mcast_querier_ipv6_port %u ",
+				   rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
+		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]) {
+			tval = rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]);
+			print_string(PRINT_ANY,
+				     "mcast_querier_ipv6_other_timer",
+				     "mcast_querier_ipv6_other_timer %s ",
+				     sprint_time64(tval, other_time));
+		}
+		close_json_object();
+	}
 	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
 		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
 		print_uint(PRINT_ANY, "mcast_igmp_version",
--
2.39.5


