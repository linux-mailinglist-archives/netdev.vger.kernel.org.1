Return-Path: <netdev+bounces-195071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFF7ACDC35
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 12:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAB5E7A895E
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 10:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCD528DB55;
	Wed,  4 Jun 2025 10:57:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0D18E377
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749034621; cv=none; b=hiah+uBLz5qYMOQF7k83Xj7XYo38cxH7C7x5s6/3i2Yg/IZCyBe7Jr4OdQHtUxaXzT3px/9MyxzuInSYBH6qI2uZ0dMIHvR0OxxJTITOaiqVuVngWbUv0+n5f+ATqw+lb+BxI5XNNUs2o1ZWbDKhVE1WUWP38+Vropd4GeH/Q/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749034621; c=relaxed/simple;
	bh=Klz9txw57GzdTGx2HdVc9FFDT0xClzwEGccEBkynaMw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PbR/fH/F+cE/0DXPZIHshwkrl32fVyxNbzWrzbOkRlJODx8fGJoqQGy6+3f2JOLnpAhjsZV0uW83gORCeNbrQrkH1Wg/7AC9Gl1GYvOaONDobrlBK0+z1+Zq1VFiKnofdzeHs/tLfnVr8Cf7hdqmMPUXI9NRewrCNBy6vvWXk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uMlnk-0007LO-Vc; Wed, 04 Jun 2025 12:56:56 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uMlnk-001mP8-2J;
	Wed, 04 Jun 2025 12:56:56 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uMlnk-0052tu-1y;
	Wed, 04 Jun 2025 12:56:56 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH] bridge: dump mcast querier state per vlan
Date: Wed,  4 Jun 2025 12:53:23 +0200
Message-Id: <20250604105322.1185872-1-f.pfitzner@pengutronix.de>
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

This patch is a bit redundant compared to [1]. It makes sense to put it
into a helper function, but i am not sure where to place this function.
Maybe somewhere under /lib?

 bridge/vlan.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index ea4aff93..b928c653 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -892,6 +892,64 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
 		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
 			   rta_getattr_u8(vattr));
 	}
+	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
+		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
+		SPRINT_BUF(other_time);
+
+		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]);
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
 	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
 		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
 		print_uint(PRINT_ANY, "mcast_igmp_version",
--
2.39.5


