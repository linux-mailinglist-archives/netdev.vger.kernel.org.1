Return-Path: <netdev+bounces-298975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ikCGDb14LWr9ggQAu9opvQ
	(envelope-from <netdev+bounces-298975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:35:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 804A467EF75
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:35:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=muS0iD8V;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oG0uielg;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=muS0iD8V;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oG0uielg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298975-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298975-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C068C3068463
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D5E3859CB;
	Sat, 13 Jun 2026 15:31:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E67F391E72
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 15:30:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364668; cv=none; b=lm3LWjC7AK3IaNonlDy7t1jpmXwl6IpvMZzczl3fN07/wmVopyqu6vQqOriBf/0j21dkbj4/UyZT1QZ75Z5r6RDKdogQMCZQd0GY1vc0BsYKSbLhtrLkERqzz9gFLbGFxEf7eCsmK5SPtSHx39jkfriKFM8PmNtpVpCdDqyiV4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364668; c=relaxed/simple;
	bh=0YLQ99xaL2r9BOPgopKaIIURJwRfv126lcg2myoXH8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgSc/+jeqW//tRUO7yNlraLlssWcOooAks4300Voc07sgV+iosSn7b+OesTybTkVNggkQq+JYQ1EyNxHYUVTMgHyqq4CiX0RGrcLeE2U3wPPA80dMEqDXJYbgRQ7S3Gd2DqPSm+nd+qXllSUAIjcvz5SH5zj5Jejh+ARI4Bf7jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=muS0iD8V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oG0uielg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=muS0iD8V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oG0uielg; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D9395462;
	Sat, 13 Jun 2026 06:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781333854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jrcQ7yk7DWcjjFDTbI+ib+44m0+8MefBpZExHv574M0=;
	b=muS0iD8V1A8hJYe72KCaIuPyCtgBMn6sl8RZEZ12qz0kFKhXWVhE9SaKH2/XhHoZK7XSvo
	k1pjlYhY1XkmYy8gUmTgGGAKj+mgzg+uCizjDHiax7rr82FbCJC3UMjEriDNbX/HBQ84p1
	YEkH9c9To/ZGsCS+dk2ZoTk0ynaZuhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781333854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jrcQ7yk7DWcjjFDTbI+ib+44m0+8MefBpZExHv574M0=;
	b=oG0uielgF8jSlCPtuUhvSG9sSxPBRlB85XwaOn4jXrEe3dWkqWlj2Uqy+Jk618A0EN7G3n
	zbkgUu+MzxtOZcDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781333854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jrcQ7yk7DWcjjFDTbI+ib+44m0+8MefBpZExHv574M0=;
	b=muS0iD8V1A8hJYe72KCaIuPyCtgBMn6sl8RZEZ12qz0kFKhXWVhE9SaKH2/XhHoZK7XSvo
	k1pjlYhY1XkmYy8gUmTgGGAKj+mgzg+uCizjDHiax7rr82FbCJC3UMjEriDNbX/HBQ84p1
	YEkH9c9To/ZGsCS+dk2ZoTk0ynaZuhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781333854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jrcQ7yk7DWcjjFDTbI+ib+44m0+8MefBpZExHv574M0=;
	b=oG0uielgF8jSlCPtuUhvSG9sSxPBRlB85XwaOn4jXrEe3dWkqWlj2Uqy+Jk618A0EN7G3n
	zbkgUu+MzxtOZcDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B02F2779A7;
	Sat, 13 Jun 2026 06:57:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u8f8J13/LGqXQwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 13 Jun 2026 06:57:33 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH iproute2-next v2] ipaddress: add support for showing IPv4 devconf attributes
Date: Sat, 13 Jun 2026 08:57:20 +0200
Message-ID: <20260613065720.991-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298975-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:fmancera@suse.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 804A467EF75

This patch introduces support for showing IPv4 devconf attributes on
detailed output of an interface e.g "ip -d link show dev enp1s0".

Additionally, this refactors 'print_af_spec()' to sequentially process
both AF_INET and AF_INET6 attributes rather than returning early if
AF_INET6 is missing.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: changed print_string to print_bool for boolean attributes
---
 ip/ipaddress.c | 239 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 199 insertions(+), 40 deletions(-)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 6017bc83..0dd2aa87 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -23,6 +23,7 @@
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/if_infiniband.h>
+#include <linux/ip.h>
 #include <linux/sockios.h>
 #include <linux/net_namespace.h>
 
@@ -294,53 +295,211 @@ static void print_linktype(FILE *fp, struct rtattr *tb)
 	close_json_object();
 }
 
+static void print_inet(FILE *fp, struct rtattr *inet_attr)
+{
+	struct rtattr *tb[IFLA_INET_MAX + 1];
+
+	parse_rtattr_nested(tb, IFLA_INET_MAX, inet_attr);
+
+	if (tb[IFLA_INET_CONF]) {
+		int *conf = RTA_DATA(tb[IFLA_INET_CONF]);
+		int max_elements = RTA_PAYLOAD(tb[IFLA_INET_CONF]) / sizeof(int);
+
+		if (max_elements >= IPV4_DEVCONF_FORWARDING)
+			print_bool(PRINT_ANY, "forwarding", "forwarding %s ",
+				   conf[IPV4_DEVCONF_FORWARDING - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_MC_FORWARDING)
+			print_bool(PRINT_ANY, "mc_forwarding", "mc_forwarding %s ",
+				   conf[IPV4_DEVCONF_MC_FORWARDING - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_PROXY_ARP)
+			print_bool(PRINT_ANY, "proxy_arp", "proxy_arp %s ",
+				   conf[IPV4_DEVCONF_PROXY_ARP - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_ACCEPT_REDIRECTS)
+			print_bool(PRINT_ANY, "accept_redirects",
+				   "accept_redirects %s ",
+				   conf[IPV4_DEVCONF_ACCEPT_REDIRECTS - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_SECURE_REDIRECTS)
+			print_bool(PRINT_ANY, "secure_redirects",
+				   "secure_redirects %s ",
+				   conf[IPV4_DEVCONF_SECURE_REDIRECTS - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_SEND_REDIRECTS)
+			print_bool(PRINT_ANY, "send_redirects", "send_redirects %s ",
+				   conf[IPV4_DEVCONF_SEND_REDIRECTS - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_SHARED_MEDIA)
+			print_bool(PRINT_ANY, "shared_media", "shared_media %s ",
+				   conf[IPV4_DEVCONF_SHARED_MEDIA - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_RP_FILTER)
+			print_int(PRINT_ANY, "rp_filter", "rp_filter %d ",
+				  conf[IPV4_DEVCONF_RP_FILTER - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE)
+			print_bool(PRINT_ANY, "accept_source_route",
+				   "accept_source_route %s ",
+				   conf[IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_BOOTP_RELAY)
+			print_bool(PRINT_ANY, "bootp_relay", "bootp_relay %s ",
+				   conf[IPV4_DEVCONF_BOOTP_RELAY - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_LOG_MARTIANS)
+			print_bool(PRINT_ANY, "log_martians", "log_martians %s ",
+				   conf[IPV4_DEVCONF_LOG_MARTIANS - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_TAG)
+			print_int(PRINT_ANY, "tag", "tag %d ",
+				  conf[IPV4_DEVCONF_TAG - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_ARPFILTER)
+			print_bool(PRINT_ANY, "arpfilter", "arpfilter %s ",
+				   conf[IPV4_DEVCONF_ARPFILTER - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_MEDIUM_ID)
+			print_int(PRINT_ANY, "medium_id", "medium_id %d ",
+				  conf[IPV4_DEVCONF_MEDIUM_ID - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_NOXFRM)
+			print_bool(PRINT_ANY, "noxfrm", "noxfrm %s ",
+				   conf[IPV4_DEVCONF_NOXFRM - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_NOPOLICY)
+			print_bool(PRINT_ANY, "nopolicy", "nopolicy %s ",
+				   conf[IPV4_DEVCONF_NOPOLICY - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_FORCE_IGMP_VERSION)
+			print_int(PRINT_ANY, "force_igmp_version", "force_igmp_version %d ",
+				  conf[IPV4_DEVCONF_FORCE_IGMP_VERSION - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_ARP_ANNOUNCE)
+			print_int(PRINT_ANY, "arp_announce", "arp_announce %d ",
+				  conf[IPV4_DEVCONF_ARP_ANNOUNCE - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_ARP_IGNORE)
+			print_int(PRINT_ANY, "arp_ignore", "arp_ignore %d ",
+				  conf[IPV4_DEVCONF_ARP_IGNORE - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_PROMOTE_SECONDARIES)
+			print_bool(PRINT_ANY, "promote_secondaries",
+				   "promote_secondaries %s ",
+				   conf[IPV4_DEVCONF_PROMOTE_SECONDARIES - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_ARP_ACCEPT)
+			print_int(PRINT_ANY, "arp_accept", "arp_accept %d ",
+				  conf[IPV4_DEVCONF_ARP_ACCEPT - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_ARP_NOTIFY)
+			print_bool(PRINT_ANY, "arp_notify", "arp_notify %s ",
+				   conf[IPV4_DEVCONF_ARP_NOTIFY - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_ACCEPT_LOCAL)
+			print_bool(PRINT_ANY, "accept_local", "accept_local %s ",
+				   conf[IPV4_DEVCONF_ACCEPT_LOCAL - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_SRC_VMARK)
+			print_bool(PRINT_ANY, "src_vmark", "src_vmark %s ",
+				   conf[IPV4_DEVCONF_SRC_VMARK - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_PROXY_ARP_PVLAN)
+			print_bool(PRINT_ANY, "proxy_arp_pvlan", "proxy_arp_pvlan %s ",
+				   conf[IPV4_DEVCONF_PROXY_ARP_PVLAN - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_ROUTE_LOCALNET)
+			print_bool(PRINT_ANY, "route_localnet", "route_localnet %s ",
+				   conf[IPV4_DEVCONF_ROUTE_LOCALNET - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_BC_FORWARDING)
+			print_bool(PRINT_ANY, "bc_forwarding", "bc_forwarding %s ",
+				   conf[IPV4_DEVCONF_BC_FORWARDING - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL)
+			print_int(PRINT_ANY, "igmpv2_unsolicited_report_interval",
+				  "igmpv2_unsolicited_report_interval %d ",
+				  conf[IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL)
+			print_int(PRINT_ANY, "igmpv3_unsolicited_report_interval",
+				  "igmpv3_unsolicited_report_interval %d ",
+				  conf[IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN)
+			print_bool(PRINT_ANY, "ignore_routes_with_linkdown",
+				   "ignore_routes_with_linkdown %s ",
+				   conf[IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST)
+			print_bool(PRINT_ANY, "drop_unicast_in_l2_multicast",
+				   "drop_unicast_in_l2_multicast %s ",
+				   conf[IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_DROP_GRATUITOUS_ARP)
+			print_bool(PRINT_ANY, "drop_gratuitous_arp",
+				   "drop_gratuitous_arp %s ",
+				   conf[IPV4_DEVCONF_DROP_GRATUITOUS_ARP - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_ARP_EVICT_NOCARRIER)
+			print_bool(PRINT_ANY, "arp_evict_nocarrier",
+				   "arp_evict_nocarrier %s ",
+				   conf[IPV4_DEVCONF_ARP_EVICT_NOCARRIER - 1]);
+	}
+}
+
 static void print_af_spec(FILE *fp, struct rtattr *af_spec_attr)
 {
-	struct rtattr *inet6_attr;
 	struct rtattr *tb[IFLA_INET6_MAX + 1];
+	struct rtattr *inet6_attr;
+	struct rtattr *inet_attr;
 
-	inet6_attr = parse_rtattr_one_nested(AF_INET6, af_spec_attr);
-	if (!inet6_attr)
-		return;
+	inet_attr = parse_rtattr_one_nested(AF_INET, af_spec_attr);
+	if (inet_attr)
+		print_inet(fp, inet_attr);
 
-	parse_rtattr_nested(tb, IFLA_INET6_MAX, inet6_attr);
+	inet6_attr = parse_rtattr_one_nested(AF_INET6, af_spec_attr);
+	if (inet6_attr) {
+		parse_rtattr_nested(tb, IFLA_INET6_MAX, inet6_attr);
 
-	if (tb[IFLA_INET6_ADDR_GEN_MODE]) {
-		__u8 mode = rta_getattr_u8(tb[IFLA_INET6_ADDR_GEN_MODE]);
-		SPRINT_BUF(b1);
+		if (tb[IFLA_INET6_ADDR_GEN_MODE]) {
+			__u8 mode = rta_getattr_u8(tb[IFLA_INET6_ADDR_GEN_MODE]);
 
-		switch (mode) {
-		case IN6_ADDR_GEN_MODE_EUI64:
-			print_string(PRINT_ANY,
-				     "inet6_addr_gen_mode",
-				     "addrgenmode %s ",
-				     "eui64");
-			break;
-		case IN6_ADDR_GEN_MODE_NONE:
-			print_string(PRINT_ANY,
-				     "inet6_addr_gen_mode",
-				     "addrgenmode %s ",
-				     "none");
-			break;
-		case IN6_ADDR_GEN_MODE_STABLE_PRIVACY:
-			print_string(PRINT_ANY,
-				     "inet6_addr_gen_mode",
-				     "addrgenmode %s ",
-				     "stable_secret");
-			break;
-		case IN6_ADDR_GEN_MODE_RANDOM:
-			print_string(PRINT_ANY,
-				     "inet6_addr_gen_mode",
-				     "addrgenmode %s ",
-				     "random");
-			break;
-		default:
-			snprintf(b1, sizeof(b1), "%#.2hhx", mode);
-			print_string(PRINT_ANY,
-				     "inet6_addr_gen_mode",
-				     "addrgenmode %s ",
-				     b1);
-			break;
+			SPRINT_BUF(b1);
+			switch (mode) {
+			case IN6_ADDR_GEN_MODE_EUI64:
+				print_string(PRINT_ANY,
+					     "inet6_addr_gen_mode",
+					     "addrgenmode %s ",
+					     "eui64");
+				break;
+			case IN6_ADDR_GEN_MODE_NONE:
+				print_string(PRINT_ANY,
+					     "inet6_addr_gen_mode",
+					     "addrgenmode %s ",
+					     "none");
+				break;
+			case IN6_ADDR_GEN_MODE_STABLE_PRIVACY:
+				print_string(PRINT_ANY,
+					     "inet6_addr_gen_mode",
+					     "addrgenmode %s ",
+					     "stable_secret");
+				break;
+			case IN6_ADDR_GEN_MODE_RANDOM:
+				print_string(PRINT_ANY,
+					     "inet6_addr_gen_mode",
+					     " addrgenmode %s ",
+					     "random");
+				break;
+			default:
+				snprintf(b1, sizeof(b1), "%#.2hhx", mode);
+				print_string(PRINT_ANY,
+					     "inet6_addr_gen_mode",
+					     "addrgenmode %s ",
+					     b1);
+				break;
+			}
 		}
 	}
 }
-- 
2.54.0


