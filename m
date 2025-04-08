Return-Path: <netdev+bounces-180435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A47A8151A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A9A3A57FF
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C020623C8DE;
	Tue,  8 Apr 2025 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="AjwEAiqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0D22FF4C
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138307; cv=none; b=IxxEW+7DZoTXN5e6TANDayRR7/ZTVI7AwjqH3Pmp5FBo9JqWkMK8bGin6KXgbC7SiDJ47Ye4rY+5H8B+QgySKpNJxnSMMM2QGkNb6lHBXJ4z5FROE4FwFOuNT8k8h306/VEf8itJJuLANj2IbhjTAswnQWaewUEb1wK3KLe77QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138307; c=relaxed/simple;
	bh=XE9u4A1UKpq8ZTX1VAetgkFU3oiDloC8Kgw8TUuGwVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbNm/0l9vUllqioaePqAuPK5skYJtrNJMWrFERj30teu7Q0SumF7kDs2tmtzdbqtZDN1PUwa0rg5e3F8diZnb2pHyD4aeDhYzUfy/21xy5AG0CZ3iVBpL/pQ7sYpAXFHmZc6R7J1zyaRHh9Zlum1o6Z8AU8QJl3C1iS9hez4ftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=AjwEAiqO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-301a4d5156aso5640212a91.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744138304; x=1744743104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cHOuu1m0+bzhvsMsXG/X9J/rQ3WbLdqxf597p0b60Rg=;
        b=AjwEAiqOAdqQV0pIq98l0dInPbAFtJZPiPgKJEuCG84k+LWrJoEDiu2aRAhQ8OIeeR
         qETXb426b32eBb/XbL8dIMlSa60A/SWiisfRwO1T8OLhLY/LumLrYRy373r8pW7iWq4j
         Pk/zSix+3NIbRRcfNILyUGRahmz39y/7yX96OK4fME2l+24WCW27sq2rqeHfl6iFT11t
         YEIWhPfXJ2PccTRkkBM61WiftthYhDKpae/Z3KnUHBlGHs9pWtpqSEwYEhTQPBmdZz8I
         T1vHG/dcLUerM8JrrZFd2g1CqdXsf4UBGjoLAqyM/N+0HZsi7jAmh4AAgQleHBNHivzm
         zqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744138304; x=1744743104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHOuu1m0+bzhvsMsXG/X9J/rQ3WbLdqxf597p0b60Rg=;
        b=EsRnEQe1xCJofXK6qVf35X3oqvzKVMsXLFQfZGbxxb4jK/PZPyujMptBNW9G4Jo50B
         +3zz/2A+ObUMSSyqa0v7nc7xZ68IKl1Uh/DKuv+tYCsMi3ZHZMPq2VZbT8umu7S8vuUC
         T48gL2Pd7DBMK0yaoMXM/wrcomPXvLjvCQPZbjvUAFZJ5H+YSTy4vBno3F/NP0zZTMnp
         XMTaj15hlacoCt/v22WYV8KFGcyx4nKkByqiEgsgKLa7fdTOzXBKSYWt1eX54A3wSIeY
         ZjWbsd1jUCOUSeLsRJeUHAm3rmP2SKrmcV4Cl7X3ICqUfW8XVxnKWj6O0PnYNzE4EU0O
         cORg==
X-Gm-Message-State: AOJu0YwLWC44zgVvcFWPllsDRKM31fdmkeMYLPgpB0QQFZ/B0SSYw4FJ
	yKWNImXAkITg6BGTj20Z5wQBaM9ufjFW/JBqdE3J/dOcBHwmRYdVl12SAs2spbKPL7kbDClfMZ0
	p
X-Gm-Gg: ASbGncsuokV/HB0EvWGJZUYbOckDXqAO/On17G+bFK4x4a7JF6tNMnA6OHE+qqVWC49
	7QiotTaHHcZK6NtY1scFDhUqeucYyjnFDY7sh2CBKsVu/6Cj+RIDZb+OedBKnfntd0q43Y6t7Ot
	+tJT0pWwWY6899OjEuqG4tqcueUMoZ7ktU6o45opNrtjG+Y4EO0ynY7Du4fhjiwBn3uQnJCPB8h
	3K+wqZ1OTNZ3DTfWrMODOWeCVP4WnUXSY2FqA8K/fx9MZ9Ih6OCyYqclhjncSes9GbvCgSBKG7K
	BBdtuxg5mDHzLbOuuzyfdv07pBdIerwHIVYmTg7F4WFp1Wz0d6ZUKdRhnEY4E1iJmr+ShDybSiX
	2DSbH3Rx6yDXCjtB/xNTK
X-Google-Smtp-Source: AGHT+IF2XzbDJIMWgpi8NuYu2HPLVFqysLW9QRfk+Pfb4kZZ6KwcHa/I/nPdiMcPwhcpKRJmOzCLew==
X-Received: by 2002:a17:90b:4ecb:b0:305:5f33:980f with SMTP id 98e67ed59e1d1-306dbc2bf2dmr372838a91.27.1744138304440;
        Tue, 08 Apr 2025 11:51:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305983b9cfbsm11370643a91.31.2025.04.08.11.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:51:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next] ss: remove support for DCCP
Date: Tue,  8 Apr 2025 11:51:26 -0700
Message-ID: <20250408185134.92749-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since DCCP is going away in future kernel, remove the decode
logic in ss command. Keep the display of protocol number.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/ss.8 |  5 +----
 misc/ss.c     | 35 ++++-------------------------------
 2 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index e23af826..7ff1001b 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -377,9 +377,6 @@ Display TCP sockets.
 .B \-u, \-\-udp
 Display UDP sockets.
 .TP
-.B \-d, \-\-dccp
-Display DCCP sockets.
-.TP
 .B \-w, \-\-raw
 Display RAW sockets.
 .TP
@@ -412,7 +409,7 @@ supported: unix, inet, inet6, link, netlink, vsock, tipc, xdp.
 .B \-A QUERY, \-\-query=QUERY, \-\-socket=QUERY
 List of socket tables to dump, separated by commas. The following identifiers
 are understood: all, inet, tcp, udp, raw, unix, packet, netlink, unix_dgram,
-unix_stream, unix_seqpacket, packet_raw, packet_dgram, dccp, sctp, tipc,
+unix_stream, unix_seqpacket, packet_raw, packet_dgram, sctp, tipc,
 vsock_stream, vsock_dgram, xdp, mptcp. Any item in the list may optionally be
 prefixed by an exclamation mark
 .RB ( ! )
diff --git a/misc/ss.c b/misc/ss.c
index 6d597650..e3dbafc9 100644
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
@@ -3883,8 +3877,6 @@ static int tcpdiag_send(int fd, int protocol, struct filter *f)
 
 	if (protocol == IPPROTO_TCP)
 		req.nlh.nlmsg_type = TCPDIAG_GETSOCK;
-	else if (protocol == IPPROTO_DCCP)
-		req.nlh.nlmsg_type = DCCPDIAG_GETSOCK;
 	else
 		return -1;
 
@@ -4295,18 +4287,6 @@ static int mptcp_show(struct filter *f)
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
@@ -5764,7 +5744,6 @@ static void _usage(FILE *dest)
 "   -M, --mptcp         display only MPTCP sockets\n"
 "   -S, --sctp          display only SCTP sockets\n"
 "   -u, --udp           display only UDP sockets\n"
-"   -d, --dccp          display only DCCP sockets\n"
 "   -w, --raw           display only RAW sockets\n"
 "   -x, --unix          display only Unix domain sockets\n"
 "       --tipc          display only TIPC sockets\n"
@@ -5780,7 +5759,7 @@ static void _usage(FILE *dest)
 "       --inet-sockopt  show various inet socket options\n"
 "\n"
 "   -A, --query=QUERY, --socket=QUERY\n"
-"       QUERY := {all|inet|tcp|mptcp|udp|raw|unix|unix_dgram|unix_stream|unix_seqpacket|packet|packet_raw|packet_dgram|netlink|dccp|sctp|vsock_stream|vsock_dgram|tipc|xdp}[,QUERY]\n"
+"       QUERY := {all|inet|tcp|mptcp|udp|raw|unix|unix_dgram|unix_stream|unix_seqpacket|packet|packet_raw|packet_dgram|netlink|sctp|vsock_stream|vsock_dgram|tipc|xdp}[,QUERY]\n"
 "\n"
 "   -D, --diag=FILE     Dump raw information about TCP sockets to FILE\n"
 "   -F, --filter=FILE   read filter information from FILE\n"
@@ -5892,7 +5871,6 @@ static const struct option long_opts[] = {
 	{ "threads", 0, 0, 'T' },
 	{ "bpf", 0, 0, 'b' },
 	{ "events", 0, 0, 'E' },
-	{ "dccp", 0, 0, 'd' },
 	{ "tcp", 0, 0, 't' },
 	{ "sctp", 0, 0, 'S' },
 	{ "udp", 0, 0, 'u' },
@@ -5981,9 +5959,6 @@ int main(int argc, char *argv[])
 		case 'E':
 			follow_events = 1;
 			break;
-		case 'd':
-			filter_db_set(&current_filter, DCCP_DB, true);
-			break;
 		case 't':
 			filter_db_set(&current_filter, TCP_DB, true);
 			break;
@@ -6275,8 +6250,6 @@ int main(int argc, char *argv[])
 		udp_show(&current_filter);
 	if (current_filter.dbs & (1<<TCP_DB))
 		tcp_show(&current_filter);
-	if (current_filter.dbs & (1<<DCCP_DB))
-		dccp_show(&current_filter);
 	if (current_filter.dbs & (1<<SCTP_DB))
 		sctp_show(&current_filter);
 	if (current_filter.dbs & VSOCK_DBM)
-- 
2.47.2


