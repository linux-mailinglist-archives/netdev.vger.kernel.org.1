Return-Path: <netdev+bounces-303128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N1lWD4usQ2oxewoAu9opvQ
	(envelope-from <netdev+bounces-303128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:46:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A135E6E3C96
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:46:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DWShCo6N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303128-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303128-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75C0C3021653
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E239E401A26;
	Tue, 30 Jun 2026 11:41:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5D3F0759
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:41:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819702; cv=none; b=m734bm4jX6Q5iOT8F0VG6+mVwwuWyUisvwo4iqh1kKez0OL5H+XGn1p/6h5FkVRZ/x3ygTNubCnSi66GkN3DvZwrblw3EbdQbYMZQ68aMcs9Ngz/I34nalqwBn1hLXlWO2mUBXZ1wEgm3uOf7geF+iXDcpltKLSLc8IjEGACav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819702; c=relaxed/simple;
	bh=sctLDCraoqCWCHLB4nNb3QTSx7xmsvTDIgwcFQAmGiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEsOkGnjVTDJ48HsisZ073iBF38Q4MvRpg8Kstm9BSHr/3/6sLWOPEUq/okkBNENMQykHLdk8p9jsQuxBqH/6EzapUUT53douV0WJObLyvwgx3BBgj+qg2axMusLacwQzozvP4Kt9W3pc3IFFaLDdEZbG1l3hsohOqGXC2ijqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWShCo6N; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37e11438c66so1749675a91.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782819701; x=1783424501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TomsKHbFVKPd5mT8o3f72yj5MFefhGWYWpbgcg1BT1o=;
        b=DWShCo6N+ZlszbZuehfCMymqitVypn0SI1J8/JJji7OMkOSEXWLet+hzEWs7JGQDnL
         Bh9BnCWq/xWInmHGyZYahAuv/ygo92EK+iAMoQuS2qNqjt3nPbQIxnTjQGe+MUa49Ccr
         8RKqOYxaZwFyC2ecPvMy0qXk/9EQo2hvQTDE9PHAr0pfeyp5Gs4lSlyfgDNhEviiyNHl
         KnbRE8YOMdbWttilvtAXHMkV8u1Wzvazly2YeYY/21ItSzKAZeL2joA5xQDswuxniheN
         I8fHu8f2Ow5TOVwj/v0/5Grz/63Prv/fI9YF5zjBaZ8URsgdAwQw9kOz3bsxzNEwBlyG
         xTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782819701; x=1783424501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TomsKHbFVKPd5mT8o3f72yj5MFefhGWYWpbgcg1BT1o=;
        b=mnATJGVupC9fKIQRZ4pIAO1O3/yLTvS1c+3kyObzXSX2ZCfY6HUoJy/Wz5lsTU9jql
         XimW8XyBAMRUIq/Cr+FwKDDr8WDyjkKNwr8DZOjKMDrtIBCbWy066lxFNmfO1jTtL+zL
         D5MYcsy8qs4dS1lMU45jRCPwJEG6j1RBnY0ilQl6LB8TlIo4/Is1w4tiH0q+ZGnDYidJ
         7uzkFg4TWhkNcsjSLfvHGwr3QD8miYV2T2v6Pm/DmsBsLiAu5zz3R1B57b8NEhwVUzl5
         eRFyPfVHTv0tZTVAD7E91iW3SElRmIpbR3I7IxV4u7khexxzeT8EHDzX806ULVmLuZd9
         +CDw==
X-Gm-Message-State: AOJu0Yzlm5+AmIwS80VrTwuAdr4QxYLu1K9PSThVGhKMYnA8CXVwjdpG
	Dh1u4n6jTm2rgKFbj8l5FLp0rO3MDKP44pTeK78G6YMaqbP/oK5WMkehBmw3RJPBs/Ubfw==
X-Gm-Gg: AfdE7ckdSd4WGB+Am8/AqZQfRjz8JZBgTkQLBwweWmF2NKp9xsdx1oWtvZx+/iQWhJa
	arc7o4QkHX3jFrrbTrbkoy1g5a5I0sSHup+IdAdfWfHMZZBlZhKh7X/z1XFew3t4jY1AAN5gPil
	HlUGqu4NVuWS2ONgE112wpW2tHGpDxfiu1fYuxT1P1ZBCsNew9AfumPldtv2WaJhTV/o3XR3LRi
	DKe5I1tc3nOV8A9URIXHi02E7SXLmU3+HmOj30cHJZhN8kNwzdRVmMLjNZ50h2HX6tohGjfIRFX
	crQYnPAoevLIMYAXkQFUtKgMDJ1tZjI/RaXzFFWxwWVjcx65VcUEIIb8F1IqtfQOM/lR98k+8MD
	Obd4rFIa6RSge8t0kY838Fa/kIgkyEamKl0fZSueeSPWUKrRRNM+K30TUw0/GW+rIlDSJd9lvv9
	6bszPgcKIQTJxFeolRpBcpJAxtpvlUqIwVdKQw5SKqsN/s+NCPuKS7+joHV8DfrzPfZgD94g==
X-Received: by 2002:a17:90b:3909:b0:377:424b:59e3 with SMTP id 98e67ed59e1d1-3808c0e139dmr86914a91.24.1782819700663;
        Tue, 30 Jun 2026 04:41:40 -0700 (PDT)
Received: from yafangs-Air ([240e:46d:2200:5f15:f47c:a584:480b:2f57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380532d4563sm1578743a91.6.2026.06.30.04.41.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 04:41:39 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: stephen@networkplumber.org,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH iproute2-next] ss: stop displaying dccp sockets
Date: Tue, 30 Jun 2026 19:41:21 +0800
Message-ID: <20260630114121.26430-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303128-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[laoarshao@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:laoar.shao@gmail.com,m:laoarshao@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laoarshao@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A135E6E3C96

DCCP support was retired in kernel commit 2a63dd0edf38 ("net: Retire
DCCP socket."). However, ss still attempts to query DCCP sockets via
netlink, which triggers repeated SELinux warnings in dmesg:

  SELinux: unrecognized netlink message: protocol=4 nlmsg_type=19 \
    sclass=netlink_tcpdiag_socket pid=188945 comm=ss

Stop sending DCCPDIAG_GETSOCK netlink messages to suppress these
warnings and align ss with the kernel change.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
---
 man/man8/ss.8 |  5 +++--
 misc/ss.c     | 40 ++++++++--------------------------------
 2 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 70e0a566..37dd75a0 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -378,7 +378,8 @@ Display TCP sockets.
 Display UDP sockets.
 .TP
 .B \-d, \-\-dccp
-Display DCCP sockets.
+[Deprecated] DCCP is no longer supported since kernel 6.16.
+This option is ignored.
 .TP
 .B \-w, \-\-raw
 Display RAW sockets.
@@ -411,7 +412,7 @@ supported: unix, inet, inet6, link, netlink, vsock, tipc, xdp.
 .B \-A QUERY, \-\-query=QUERY, \-\-socket=QUERY
 List of socket tables to dump, separated by commas. The following identifiers
 are understood: all, inet, tcp, udp, raw, unix, packet, netlink, unix_dgram,
-unix_stream, unix_seqpacket, packet_raw, packet_dgram, dccp, sctp, tipc,
+unix_stream, unix_seqpacket, packet_raw, packet_dgram, sctp, tipc,
 vsock_stream, vsock_dgram, xdp, mptcp. Any item in the list may optionally be
 prefixed by an exclamation mark
 .RB ( ! )
diff --git a/misc/ss.c b/misc/ss.c
index 14e9f27a..dae5f282 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -195,7 +195,6 @@ static const char *dg_proto;
 enum {
 	TCP_DB,
 	MPTCP_DB,
-	DCCP_DB,
 	UDP_DB,
 	RAW_DB,
 	UNIX_DG_DB,
@@ -215,7 +214,7 @@ enum {
 #define PACKET_DBM ((1<<PACKET_DG_DB)|(1<<PACKET_R_DB))
 #define UNIX_DBM ((1<<UNIX_DG_DB)|(1<<UNIX_ST_DB)|(1<<UNIX_SQ_DB))
 #define ALL_DB ((1<<MAX_DB)-1)
-#define INET_L4_DBM ((1<<TCP_DB)|(1<<MPTCP_DB)|(1<<UDP_DB)|(1<<DCCP_DB)|(1<<SCTP_DB))
+#define INET_L4_DBM ((1<<TCP_DB)|(1<<MPTCP_DB)|(1<<UDP_DB)|(1<<SCTP_DB))
 #define INET_DBM (INET_L4_DBM | (1<<RAW_DB))
 #define VSOCK_DBM ((1<<VSOCK_ST_DB)|(1<<VSOCK_DG_DB))
 
@@ -274,10 +273,6 @@ static const struct filter default_dbs[MAX_DB] = {
 		.states   = SS_CONN,
 		.families = FAMILY_MASK(AF_INET) | FAMILY_MASK(AF_INET6),
 	},
-	[DCCP_DB] = {
-		.states   = SS_CONN,
-		.families = FAMILY_MASK(AF_INET) | FAMILY_MASK(AF_INET6),
-	},
 	[UDP_DB] = {
 		.states   = (1 << SS_ESTABLISHED),
 		.families = FAMILY_MASK(AF_INET) | FAMILY_MASK(AF_INET6),
@@ -388,13 +383,12 @@ static int filter_db_parse(struct filter *f, const char *s)
 		int dbs[MAX_DB + 1];
 	} db_name_tbl[] = {
 #define ENTRY(name, ...) { #name, { __VA_ARGS__, MAX_DB } }
-		ENTRY(all, UDP_DB, DCCP_DB, TCP_DB, MPTCP_DB, RAW_DB,
+		ENTRY(all, UDP_DB, TCP_DB, MPTCP_DB, RAW_DB,
 			   UNIX_ST_DB, UNIX_DG_DB, UNIX_SQ_DB,
 			   PACKET_R_DB, PACKET_DG_DB, NETLINK_DB,
 			   SCTP_DB, VSOCK_ST_DB, VSOCK_DG_DB, XDP_DB),
-		ENTRY(inet, UDP_DB, DCCP_DB, TCP_DB, MPTCP_DB, SCTP_DB, RAW_DB),
+		ENTRY(inet, UDP_DB, TCP_DB, MPTCP_DB, SCTP_DB, RAW_DB),
 		ENTRY(udp, UDP_DB),
-		ENTRY(dccp, DCCP_DB),
 		ENTRY(tcp, TCP_DB),
 		ENTRY(mptcp, MPTCP_DB),
 		ENTRY(sctp, SCTP_DB),
@@ -935,8 +929,6 @@ static const char *proto_name(int protocol)
 		return "mptcp";
 	case IPPROTO_SCTP:
 		return "sctp";
-	case IPPROTO_DCCP:
-		return "dccp";
 	case IPPROTO_ICMPV6:
 		return "icmp6";
 	}
@@ -3897,8 +3889,6 @@ static int tcpdiag_send(int fd, int protocol, struct filter *f)
 
 	if (protocol == IPPROTO_TCP)
 		req.nlh.nlmsg_type = TCPDIAG_GETSOCK;
-	else if (protocol == IPPROTO_DCCP)
-		req.nlh.nlmsg_type = DCCPDIAG_GETSOCK;
 	else
 		return -1;
 
@@ -4134,7 +4124,7 @@ static int inet_show_netlink(struct filter *f, FILE *dump_fp, int protocol)
 
 	/* Suppress netlink errors. Older kernels do not support extended
 	 * protocol requests using INET_DIAG_REQ_PROTOCOL, and some protocols
-	 * may not be available in the running kernel (e.g. SCTP, DCCP).
+	 * may not be available in the running kernel (e.g. SCTP).
 	 * In both cases the kernel returns EINVAL which would cause
 	 * rtnl_dump_error() to print a confusing "RTNETLINK answers" error.
 	 */
@@ -4309,18 +4299,6 @@ static int mptcp_show(struct filter *f)
 	return 0;
 }
 
-static int dccp_show(struct filter *f)
-{
-	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
-		return 0;
-
-	if (!getenv("PROC_NET_DCCP") && !getenv("PROC_ROOT")
-	    && inet_show_netlink(f, NULL, IPPROTO_DCCP) == 0)
-		return 0;
-
-	return 0;
-}
-
 static int sctp_show(struct filter *f)
 {
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
@@ -5779,7 +5757,7 @@ static void _usage(FILE *dest)
 "   -M, --mptcp         display only MPTCP sockets\n"
 "   -S, --sctp          display only SCTP sockets\n"
 "   -u, --udp           display only UDP sockets\n"
-"   -d, --dccp          display only DCCP sockets\n"
+"   -d, --dccp          DCCP is no longer supported, option ignored\n"
 "   -w, --raw           display only RAW sockets\n"
 "   -x, --unix          display only Unix domain sockets\n"
 "       --tipc          display only TIPC sockets\n"
@@ -5795,7 +5773,7 @@ static void _usage(FILE *dest)
 "       --inet-sockopt  show various inet socket options\n"
 "\n"
 "   -A, --query=QUERY, --socket=QUERY\n"
-"       QUERY := {all|inet|tcp|mptcp|udp|raw|unix|unix_dgram|unix_stream|unix_seqpacket|packet|packet_raw|packet_dgram|netlink|dccp|sctp|vsock_stream|vsock_dgram|tipc|xdp}[,QUERY]\n"
+"       QUERY := {all|inet|tcp|mptcp|udp|raw|unix|unix_dgram|unix_stream|unix_seqpacket|packet|packet_raw|packet_dgram|netlink|sctp|vsock_stream|vsock_dgram|tipc|xdp}[,QUERY]\n"
 "\n"
 "   -D, --diag=FILE     Dump raw information about TCP sockets to FILE\n"
 "   -F, --filter=FILE   read filter information from FILE\n"
@@ -5907,7 +5885,7 @@ static const struct option long_opts[] = {
 	{ "threads", 0, 0, 'T' },
 	{ "bpf", 0, 0, 'b' },
 	{ "events", 0, 0, 'E' },
-	{ "dccp", 0, 0, 'd' },
+	{ "dccp", 0, 0, 'd' }, /* DCCP retired, kept for compatibility */
 	{ "tcp", 0, 0, 't' },
 	{ "sctp", 0, 0, 'S' },
 	{ "udp", 0, 0, 'u' },
@@ -5997,7 +5975,7 @@ int main(int argc, char *argv[])
 			follow_events = 1;
 			break;
 		case 'd':
-			filter_db_set(&current_filter, DCCP_DB, true);
+			/* DCCP retired in kernel 6.16, kept for compatibility */
 			break;
 		case 't':
 			filter_db_set(&current_filter, TCP_DB, true);
@@ -6290,8 +6268,6 @@ int main(int argc, char *argv[])
 		udp_show(&current_filter);
 	if (current_filter.dbs & (1<<TCP_DB))
 		tcp_show(&current_filter);
-	if (current_filter.dbs & (1<<DCCP_DB))
-		dccp_show(&current_filter);
 	if (current_filter.dbs & (1<<SCTP_DB))
 		sctp_show(&current_filter);
 	if (current_filter.dbs & VSOCK_DBM)
-- 
2.50.1 (Apple Git-155)


