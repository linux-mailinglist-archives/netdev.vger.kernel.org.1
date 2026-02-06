Return-Path: <netdev+bounces-257408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KypL3dUhWmV/wMAu9opvQ
	(envelope-from <netdev+bounces-257408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:39:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C9FF964B
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7997A301FA42
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB6426B777;
	Fri,  6 Feb 2026 02:37:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813D026982C
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345437; cv=none; b=EyRkXDEexhOjtfsDoLOc7O9WRoAz6zno3oiv8KWl+0OH7VNLjOP4CbJnmbcmjzSSxbrBps4qasccOl5Cx9gwpvajfF5ZTkGynb2PR8CCQ38tRo8/ayAYSHmgSDdIBLJVgWlUK+fvfieTOwAEN/FFf7yqWW2AlozvAlLSHxOUV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345437; c=relaxed/simple;
	bh=tBDHiBQtKEZujxCCbJ5rfG4pWqxjOPb5wNPEsUvS/xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cx3IQ66qqovMCiJV3fcNMSwdNlGoh17sQB4N81QoqE19Pba0qOE6aHGOqaK4mbM4D4OHtgt4tZX1HDeAQdCRAcisHhmpPlpPW+G7q/R/sXiB6vxXxfwEOYN5RymoBmdx4zEDTXotCaKTe+TSL3va3A9uiASysm8TuIuJjNXgOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D53454C9F3;
	Fri,  6 Feb 2026 03:37:14 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH iproute2-next] bridge: mcast: add mcast_active_v4 / mcast_active_v6 output
Date: Fri,  6 Feb 2026 03:37:04 +0100
Message-ID: <20260206023704.4839-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[c0d3.blue];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257408-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,c0d3.blue:mid,c0d3.blue:email]
X-Rspamd-Queue-Id: 16C9FF964B
X-Rspamd-Action: no action

Add output for the mcast_active_v4 and mcast_active_v6 states. If their
output is 1 then IGMP/MLD snooping is applied to multicast payload
traffic of their according protocol family. This is the case when:

* the bridge interface is up
* multicast snooping is enabled
* an IGMP/MLD querier is present
* for own IPv6 MLD querier: an IPv6 address is configured on the bridge

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 bridge/vlan.c                  | 10 ++++++++++
 include/uapi/linux/if_bridge.h |  2 ++
 include/uapi/linux/if_link.h   |  2 ++
 ip/iplink_bridge.c             | 12 ++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 3c240207028b..d0b6afdee49d 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -920,6 +920,16 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
 		print_uint(PRINT_ANY, "msti", "msti %u ",
 			   rta_getattr_u16(vattr));
 	}
+	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4]) {
+		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4];
+		print_uint(PRINT_ANY, "mcast_active_v4", "mcast_active_v4 %u ",
+			   rta_getattr_u8(vattr));
+	}
+	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6]) {
+		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6];
+		print_uint(PRINT_ANY, "mcast_active_v6", "mcast_active_v6 %u ",
+			   rta_getattr_u8(vattr));
+	}
 	print_nl();
 	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS]) {
 		vattr = RTA_DATA(vtb[BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS]);
diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 4d7509c4b84d..be0935057c56 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -584,6 +584,8 @@ enum {
 	BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS,
 	BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE,
 	BRIDGE_VLANDB_GOPTS_MSTI,
+	BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4,
+	BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6,
 	__BRIDGE_VLANDB_GOPTS_MAX
 };
 #define BRIDGE_VLANDB_GOPTS_MAX (__BRIDGE_VLANDB_GOPTS_MAX - 1)
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index d05f5cc750ff..7d36cfd6b30c 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -794,6 +794,8 @@ enum {
 	IFLA_BR_MCAST_QUERIER_STATE,
 	IFLA_BR_FDB_N_LEARNED,
 	IFLA_BR_FDB_MAX_LEARNED,
+	IFLA_BR_MCAST_ACTIVE_V4,
+	IFLA_BR_MCAST_ACTIVE_V6,
 	__IFLA_BR_MAX,
 };
 
diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index df3264c3f45d..b3c0d6bb5310 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -784,6 +784,18 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   "mcast_mld_version %u ",
 			   rta_getattr_u8(tb[IFLA_BR_MCAST_MLD_VERSION]));
 
+	if (tb[IFLA_BR_MCAST_ACTIVE_V4])
+		print_uint(PRINT_ANY,
+			   "mcast_active_v4",
+			   "mcast_active_v4 %u ",
+			   rta_getattr_u8(tb[IFLA_BR_MCAST_ACTIVE_V4]));
+
+	if (tb[IFLA_BR_MCAST_ACTIVE_V6])
+		print_uint(PRINT_ANY,
+			   "mcast_active_v6",
+			   "mcast_active_v6 %u ",
+			   rta_getattr_u8(tb[IFLA_BR_MCAST_ACTIVE_V6]));
+
 	if (tb[IFLA_BR_NF_CALL_IPTABLES])
 		print_uint(PRINT_ANY,
 			   "nf_call_iptables",
-- 
2.51.0


