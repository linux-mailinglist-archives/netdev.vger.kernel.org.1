Return-Path: <netdev+bounces-299263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MSqpMiDyLmqI6QQAu9opvQ
	(envelope-from <netdev+bounces-299263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 20:25:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3E6681E0B
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 20:25:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KCbXvMNH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BXDHUV8M;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KCbXvMNH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BXDHUV8M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299263-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299263-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E76C53007ADC
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 18:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941A33195F0;
	Sun, 14 Jun 2026 18:25:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5EE3043C8
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 18:25:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781461534; cv=none; b=QD6aKPNwhZKqA5OYQlMCrsUipSB2Zhm+mnkBC/F6VTE73GPp1MlXn7LPLorn3zvh1GA2AH1jk6C8zBsTGzHULbSlHqPwOO4k6HTPOGJT9g0s5DfQvuvfl3OCaKMRCjPVnvEJw9vEe30BqSXd8nZGiMB/pytPAyurknHpamJS/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781461534; c=relaxed/simple;
	bh=I/1pjbfZasMySHuLVDj5mtIcxAwr20ILi7hQnQXMWlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNZfxL1dprC6To+HyMOpfJZ7mEOyWR3v5tGF5BZ1q9CmBn062aN3lrEKhltwwNT7h63pb3BzoVqETLpOtW/hinTcGqhKHAGwenMrKut1/OfoGL0m/AtxZjFKUMZyKI75/A3nUMMNsUwSuS8f24M1lSKgN6ZcIT+LPMkQ3slIHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KCbXvMNH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BXDHUV8M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KCbXvMNH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BXDHUV8M; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C44B6B85C;
	Sun, 14 Jun 2026 18:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781461530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JyHao6lgu0v1lA/0GMJvbDJGYJSmaAR0oG0xjb5JZ2I=;
	b=KCbXvMNHAV+EBhf25lq3n2rIJUpAwwiaTe/BJmAJlrPHQpTWrbqv74J0/zd3oNMuvxDM1x
	CBPTnWarSopfCkWag5HBUsYMWhSDMz3TpwidIqttWdubvuaIof51p/8So049N2afnJ2PxY
	j6s7UAJ3PxrivSqVDO3lY16HF4/Zzck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781461530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JyHao6lgu0v1lA/0GMJvbDJGYJSmaAR0oG0xjb5JZ2I=;
	b=BXDHUV8MKaDJKwtWQyXGNopBplqAeuyqHC6AAy2lXGkD6IE/zrNqBMmw14O1kbPZ5rc8Is
	xxEkqjebg8xnMfBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781461530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JyHao6lgu0v1lA/0GMJvbDJGYJSmaAR0oG0xjb5JZ2I=;
	b=KCbXvMNHAV+EBhf25lq3n2rIJUpAwwiaTe/BJmAJlrPHQpTWrbqv74J0/zd3oNMuvxDM1x
	CBPTnWarSopfCkWag5HBUsYMWhSDMz3TpwidIqttWdubvuaIof51p/8So049N2afnJ2PxY
	j6s7UAJ3PxrivSqVDO3lY16HF4/Zzck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781461530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JyHao6lgu0v1lA/0GMJvbDJGYJSmaAR0oG0xjb5JZ2I=;
	b=BXDHUV8MKaDJKwtWQyXGNopBplqAeuyqHC6AAy2lXGkD6IE/zrNqBMmw14O1kbPZ5rc8Is
	xxEkqjebg8xnMfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D631A779A7;
	Sun, 14 Jun 2026 18:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lPSrMBnyLmoObQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 14 Jun 2026 18:25:29 +0000
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
Subject: [PATCH iproute-next v3] ipaddress: add support for showing IPv4 devconf attributes
Date: Sun, 14 Jun 2026 20:25:15 +0200
Message-ID: <20260614182515.8765-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299263-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A3E6681E0B

This patch introduces support for showing IPv4 devconf attributes on
detailed output of an interface e.g "ip -d link show dev enp1s0".

Additionally, this refactors 'print_af_spec()' to sequentially process
both AF_INET and AF_INET6 attributes rather than returning early if
AF_INET6 is missing.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: changed print_string to print_bool for boolean attributes
v3: use print_bool for JSON output only
---
 ip/ipaddress.c | 313 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 273 insertions(+), 40 deletions(-)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 6017bc83..1530b836 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -23,6 +23,7 @@
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/if_infiniband.h>
+#include <linux/ip.h>
 #include <linux/sockios.h>
 #include <linux/net_namespace.h>
 
@@ -294,53 +295,285 @@ static void print_linktype(FILE *fp, struct rtattr *tb)
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
+		if (max_elements >= IPV4_DEVCONF_FORWARDING) {
+			print_bool(PRINT_JSON, "forwarding", NULL,
+				   conf[IPV4_DEVCONF_FORWARDING - 1]);
+			print_string(PRINT_FP, "forwarding", "forwarding %s ",
+				     conf[IPV4_DEVCONF_FORWARDING - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_MC_FORWARDING) {
+			print_bool(PRINT_JSON, "mc_forwarding", NULL,
+				   conf[IPV4_DEVCONF_MC_FORWARDING - 1]);
+			print_string(PRINT_FP, "mc_forwarding", "mc_forwarding %s ",
+				     conf[IPV4_DEVCONF_MC_FORWARDING - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_PROXY_ARP) {
+			print_bool(PRINT_JSON, "proxy_arp", NULL,
+				   conf[IPV4_DEVCONF_PROXY_ARP - 1]);
+			print_string(PRINT_FP, "proxy_arp", "proxy_arp %s ",
+				     conf[IPV4_DEVCONF_PROXY_ARP - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_ACCEPT_REDIRECTS) {
+			print_bool(PRINT_JSON, "accept_redirects", NULL,
+				   conf[IPV4_DEVCONF_ACCEPT_REDIRECTS - 1]);
+			print_string(PRINT_FP, "accept_redirects",
+				     "accept_redirects %s ",
+				     conf[IPV4_DEVCONF_ACCEPT_REDIRECTS - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_SECURE_REDIRECTS) {
+			print_bool(PRINT_JSON, "secure_redirects", NULL,
+				   conf[IPV4_DEVCONF_SECURE_REDIRECTS - 1]);
+			print_string(PRINT_FP, "secure_redirects",
+				     "secure_redirects %s ",
+				     conf[IPV4_DEVCONF_SECURE_REDIRECTS - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_SEND_REDIRECTS) {
+			print_bool(PRINT_JSON, "send_redirects", NULL,
+				   conf[IPV4_DEVCONF_SEND_REDIRECTS - 1]);
+			print_string(PRINT_FP, "send_redirects", "send_redirects %s ",
+				     conf[IPV4_DEVCONF_SEND_REDIRECTS - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_SHARED_MEDIA) {
+			print_bool(PRINT_JSON, "shared_media", NULL,
+				   conf[IPV4_DEVCONF_SHARED_MEDIA - 1]);
+			print_string(PRINT_FP, "shared_media", "shared_media %s ",
+				     conf[IPV4_DEVCONF_SHARED_MEDIA - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_RP_FILTER)
+			print_int(PRINT_ANY, "rp_filter", "rp_filter %d ",
+				  conf[IPV4_DEVCONF_RP_FILTER - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE) {
+			print_bool(PRINT_JSON, "accept_source_route", NULL,
+				   conf[IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE - 1]);
+			print_string(PRINT_FP, "accept_source_route",
+				     "accept_source_route %s ",
+				     conf[IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_BOOTP_RELAY) {
+			print_bool(PRINT_JSON, "bootp_relay", NULL,
+				   conf[IPV4_DEVCONF_BOOTP_RELAY - 1]);
+			print_string(PRINT_FP, "bootp_relay", "bootp_relay %s ",
+				     conf[IPV4_DEVCONF_BOOTP_RELAY - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_LOG_MARTIANS) {
+			print_bool(PRINT_JSON, "log_martians", NULL,
+				   conf[IPV4_DEVCONF_LOG_MARTIANS - 1]);
+			print_string(PRINT_FP, "log_martians", "log_martians %s ",
+				     conf[IPV4_DEVCONF_LOG_MARTIANS - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_TAG)
+			print_int(PRINT_ANY, "tag", "tag %d ",
+				  conf[IPV4_DEVCONF_TAG - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_ARPFILTER) {
+			print_bool(PRINT_JSON, "arpfilter", NULL,
+				   conf[IPV4_DEVCONF_ARPFILTER - 1]);
+			print_string(PRINT_FP, "arpfilter", "arpfilter %s ",
+				     conf[IPV4_DEVCONF_ARPFILTER - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_MEDIUM_ID)
+			print_int(PRINT_ANY, "medium_id", "medium_id %d ",
+				  conf[IPV4_DEVCONF_MEDIUM_ID - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_NOXFRM) {
+			print_bool(PRINT_JSON, "noxfrm", NULL,
+				   conf[IPV4_DEVCONF_NOXFRM - 1]);
+			print_string(PRINT_FP, "noxfrm", "noxfrm %s ",
+				     conf[IPV4_DEVCONF_NOXFRM - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_NOPOLICY) {
+			print_bool(PRINT_JSON, "nopolicy", NULL,
+				   conf[IPV4_DEVCONF_NOPOLICY - 1]);
+			print_string(PRINT_FP, "nopolicy", "nopolicy %s ",
+				     conf[IPV4_DEVCONF_NOPOLICY - 1] ? "on" : "off");
+		}
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
+		if (max_elements >= IPV4_DEVCONF_PROMOTE_SECONDARIES) {
+			print_bool(PRINT_JSON, "promote_secondaries", NULL,
+				   conf[IPV4_DEVCONF_PROMOTE_SECONDARIES - 1]);
+			print_string(PRINT_FP, "promote_secondaries",
+				     "promote_secondaries %s ",
+				     conf[IPV4_DEVCONF_PROMOTE_SECONDARIES - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_ARP_ACCEPT)
+			print_int(PRINT_ANY, "arp_accept", "arp_accept %d ",
+				  conf[IPV4_DEVCONF_ARP_ACCEPT - 1]);
+
+		if (max_elements >= IPV4_DEVCONF_ARP_NOTIFY) {
+			print_bool(PRINT_JSON, "arp_notify", NULL,
+				   conf[IPV4_DEVCONF_ARP_NOTIFY - 1]);
+			print_string(PRINT_FP, "arp_notify", "arp_notify %s ",
+				     conf[IPV4_DEVCONF_ARP_NOTIFY - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_ACCEPT_LOCAL) {
+			print_bool(PRINT_JSON, "accept_local", NULL,
+				   conf[IPV4_DEVCONF_ACCEPT_LOCAL - 1]);
+			print_string(PRINT_FP, "accept_local", "accept_local %s ",
+				     conf[IPV4_DEVCONF_ACCEPT_LOCAL - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_SRC_VMARK) {
+			print_bool(PRINT_JSON, "src_vmark", NULL,
+				   conf[IPV4_DEVCONF_SRC_VMARK - 1]);
+			print_string(PRINT_FP, "src_vmark", "src_vmark %s ",
+				     conf[IPV4_DEVCONF_SRC_VMARK - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_PROXY_ARP_PVLAN) {
+			print_bool(PRINT_JSON, "proxy_arp_pvlan", NULL,
+				   conf[IPV4_DEVCONF_PROXY_ARP_PVLAN - 1]);
+			print_string(PRINT_FP, "proxy_arp_pvlan", "proxy_arp_pvlan %s ",
+				     conf[IPV4_DEVCONF_PROXY_ARP_PVLAN - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_ROUTE_LOCALNET) {
+			print_bool(PRINT_JSON, "route_localnet", NULL,
+				   conf[IPV4_DEVCONF_ROUTE_LOCALNET - 1]);
+			print_string(PRINT_FP, "route_localnet", "route_localnet %s ",
+				     conf[IPV4_DEVCONF_ROUTE_LOCALNET - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_BC_FORWARDING) {
+			print_bool(PRINT_JSON, "bc_forwarding", NULL,
+				   conf[IPV4_DEVCONF_BC_FORWARDING - 1]);
+			print_string(PRINT_FP, "bc_forwarding", "bc_forwarding %s ",
+				     conf[IPV4_DEVCONF_BC_FORWARDING - 1] ? "on" : "off");
+		}
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
+		if (max_elements >= IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN) {
+			print_bool(PRINT_JSON, "ignore_routes_with_linkdown", NULL,
+				   conf[IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN - 1]);
+			print_string(PRINT_FP, "ignore_routes_with_linkdown",
+				     "ignore_routes_with_linkdown %s ",
+				     conf[IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN - 1] ?
+				     "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST) {
+			print_bool(PRINT_JSON, "drop_unicast_in_l2_multicast", NULL,
+				   conf[IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST - 1]);
+			print_string(PRINT_FP, "drop_unicast_in_l2_multicast",
+				     "drop_unicast_in_l2_multicast %s ",
+				     conf[IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST - 1] ?
+				     "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_DROP_GRATUITOUS_ARP) {
+			print_bool(PRINT_JSON, "drop_gratuitous_arp", NULL,
+				   conf[IPV4_DEVCONF_DROP_GRATUITOUS_ARP - 1]);
+			print_string(PRINT_FP, "drop_gratuitous_arp",
+				     "drop_gratuitous_arp %s ",
+				     conf[IPV4_DEVCONF_DROP_GRATUITOUS_ARP - 1] ? "on" : "off");
+		}
+
+		if (max_elements >= IPV4_DEVCONF_ARP_EVICT_NOCARRIER) {
+			print_bool(PRINT_JSON, "arp_evict_nocarrier", NULL,
+				   conf[IPV4_DEVCONF_ARP_EVICT_NOCARRIER - 1]);
+			print_string(PRINT_FP, "arp_evict_nocarrier",
+				     "arp_evict_nocarrier %s ",
+				     conf[IPV4_DEVCONF_ARP_EVICT_NOCARRIER - 1] ? "on" : "off");
+		}
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


