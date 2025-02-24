Return-Path: <netdev+bounces-169084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D422BA4284D
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6A93B467A
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C978C262D0E;
	Mon, 24 Feb 2025 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="wPsbUf4C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B74A261370
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415755; cv=none; b=PB64m2qI6sMR/tsu2d33wUA+s03IMQnC1Jiy0F2oSAUl6z+vS4TcEVoGVFhpzHApLVGmbVyfq58RqRteGye429A/+lsVyl8c2ypnEp8WCHLF1ulJE6zGhj6FJfog2Y2QkPuV+/ildTaPV4BS12M/faTZRj6Vx/SuElepidtdfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415755; c=relaxed/simple;
	bh=0owWw1cuo+cX4j4Ih/WHzBKYOaqO9Rssv7adgvP7S50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f78fgKRuMWIYqchEDVp4FP/yEQxLiKgwSPzRqGkeevG78/75JJk7cMcNrBc0d8Mi1jaNsQS3mYYJuaFrWKEXEbalItgNNHJgOeiFcde6bGkb2dRcny4B77PONbf27bEGTDllmQJ1OgWhJbKKGquMpRK22FLYbHl1N1bHS0uUpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=wPsbUf4C; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220d27fcdaaso9652205ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 08:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1740415753; x=1741020553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UeyntKBy7kGuKLN3CHbZwgt0kVqLbpOMJBlnkYeB+/4=;
        b=wPsbUf4CEFx6qtIzkRrg1utqSv+bWcuu1+iyRIQxzjKtuLSt0Kin2kgA9OCs1QrE3z
         FxCsnT0HCBnJ1j/3V2zvg5lgfX0akbCluiCTCz9QE0raMkdShTBccXuiVtLQV+VN/QU5
         F5NI5FN9HktZVB+CUOAC2HtNHKEDTjVSHWnYxGfIostdUd1k/eYcVcPoRFMY6ZAPzJ3K
         4BAOumMSkpHTKQyXE35lclXZWSn3dR/iRTUceFBSKN/Dcrg/Mm0EfgLwadxUpF4fcFBy
         J34qyIvzP7AgpoImSi2sakaLeWMukrpRwxwXfZ3bfcb5xyMnHxPUXN5KVZspI2Nxkl9B
         Ucnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740415753; x=1741020553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeyntKBy7kGuKLN3CHbZwgt0kVqLbpOMJBlnkYeB+/4=;
        b=TDLLxh+Ix7tMKNuCbdRX+S+J4J6KatAyRRf+29NuC5npsbTt6TsAFAP/kvfrjoyIr7
         Tzghf1uTfi3EbFMxciW/XcHJdklHuQKGPnYWwodIdQ61FqSR/SKXQyva25bvhFs4Uqd0
         hFsshC2/JR2wP2Tm16Gvkw+U0nlFiyoIkuUhbo6UyknuMisAUI1gq6y0DfsTcqqNv+eb
         mzztbzPsxe+xFsi1Q74mfDmVlqruZL4Yi32g4YV7v94YTLNI+pUfBr9msHQlkTPGmtsc
         Dtkmm0uaSRmDxKrLQ2cQ274nrz//2alfK570f30Y0YRVY4MWAxE9k8Xrw+lBZUFpZm1c
         QjPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0JKgko1j7POF6W4mqBWp0drzuHG2D8WOtLLStFCnq0v1LHb4yrCaiPqsIbvhYJbFeaFQG6gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnkZYsZiQ3j1Q02ZDoomr+6NSaohwdR4qOShBbMDK/OHhCPn9
	rhaiaXEc9KVhX6e9sxAPQNgy5AP7FpRxSNMiuZIRVquc9io+wimLud0IX2WYinA=
X-Gm-Gg: ASbGncv3dvoV+JVekLeFNnoxND80JJh78NtXr/ij5fxouE0wXWtTq2Yr8naqgnxB1VC
	uXmnUzsGujPFACz3Xg7zT+b3aXJvjBCJXcSrD1Lh9rcgpIyI/WTJ9ZlCJVhacOQBmRxPVSrGCGW
	gwR9CW4cZnLkGEdyMgSLFCbwJeZOkrSxvYDw9TkBOJcnPAvdfEcX8LBhJPhOn8aOFaz7kv7KN9r
	lM6GXPTzb56w4STXa7Nq43gtO9cp9JQEQn1zuyOUgKiO/v1sr7YY1WInsiKRA2MeOp+RhqxEFx0
	fF9G1APCL1w9SS4=
X-Google-Smtp-Source: AGHT+IH778xCAayJCWhZcoKEZgbQQMZL7qHzpXFDag5SlCSeSKmNLD4Sz8UTadasHcx2Pict6gMw6w==
X-Received: by 2002:a05:6a00:1409:b0:730:915c:b77 with SMTP id d2e1a72fcca58-73426c7c787mr8312631b3a.1.1740415753476;
        Mon, 24 Feb 2025 08:49:13 -0800 (PST)
Received: from t14.. ([2001:5a8:4528:b100:7b8c:7570:b6d6:368f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7346d9b1af1sm1465573b3a.71.2025.02.24.08.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:49:13 -0800 (PST)
From: Jordan Rife <jordan@jrife.io>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	stephen@networkplumber.org,
	dsahern@kernel.org
Subject: [PATCH iproute2-next v2] ip: link: netkit: Support scrub options
Date: Mon, 24 Feb 2025 08:49:00 -0800
Message-ID: <20250224164903.138865-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "scrub" option to configure IFLA_NETKIT_SCRUB and
IFLA_NETKIT_PEER_SCRUB when setting up a link. Add "scrub" and
"peer scrub" to device details as well when printing.

$ sudo ./ip/ip link add jordan type netkit scrub default peer scrub none
$ ./ip/ip -details link show jordan
43: jordan@nk0: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    netkit mode l3 type primary policy forward peer policy forward scrub default peer scrub none numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 524280 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536

v1->v2: Added some spaces around "scrub SCRUB" in the help message.

Link: https://lore.kernel.org/netdev/20241004101335.117711-1-daniel@iogearbox.net/

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 ip/iplink_netkit.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/ip/iplink_netkit.c b/ip/iplink_netkit.c
index 49550a2e..818da119 100644
--- a/ip/iplink_netkit.c
+++ b/ip/iplink_netkit.c
@@ -24,13 +24,19 @@ static const char * const netkit_policy_strings[] = {
 	[NETKIT_DROP]		= "blackhole",
 };
 
+static const char * const netkit_scrub_strings[] = {
+	[NETKIT_SCRUB_NONE]	= "none",
+	[NETKIT_SCRUB_DEFAULT]	= "default",
+};
+
 static void explain(struct link_util *lu, FILE *f)
 {
 	fprintf(f,
-		"Usage: ... %s [ mode MODE ] [ POLICY ] [ peer [ POLICY <options> ] ]\n"
+		"Usage: ... %s [ mode MODE ] [ POLICY ] [ scrub SCRUB ] [ peer [ POLICY <options> ] ]\n"
 		"\n"
 		"MODE: l3 | l2\n"
 		"POLICY: forward | blackhole\n"
+		"SCRUB: default | none\n"
 		"(first values are the defaults if nothing is specified)\n"
 		"\n"
 		"To get <options> type 'ip link add help'.\n",
@@ -91,6 +97,23 @@ static int netkit_parse_opt(struct link_util *lu, int argc, char **argv,
 			if (seen_peer)
 				duparg("peer", *(argv + 1));
 			seen_peer = true;
+		} else if (strcmp(*argv, "scrub") == 0) {
+			int attr_name = seen_peer ?
+					IFLA_NETKIT_PEER_SCRUB :
+					IFLA_NETKIT_SCRUB;
+			enum netkit_scrub scrub;
+
+			NEXT_ARG();
+
+			if (strcmp(*argv, "none") == 0) {
+				scrub = NETKIT_SCRUB_NONE;
+			} else if (strcmp(*argv, "default") == 0) {
+				scrub = NETKIT_SCRUB_DEFAULT;
+			} else {
+				fprintf(stderr, "Error: scrub must be either \"none\" or \"default\"\n");
+				return -1;
+			}
+			addattr32(n, 1024, attr_name, scrub);
 		} else {
 			char *type = NULL;
 
@@ -144,6 +167,15 @@ static const char *netkit_print_mode(__u32 mode)
 	return netkit_mode_strings[mode] ? : inv;
 }
 
+static const char *netkit_print_scrub(enum netkit_scrub scrub)
+{
+	const char *inv = "UNKNOWN";
+
+	if (scrub >= ARRAY_SIZE(netkit_scrub_strings))
+		return inv;
+	return netkit_scrub_strings[scrub] ? : inv;
+}
+
 static void netkit_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 {
 	if (!tb)
@@ -172,6 +204,18 @@ static void netkit_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		print_string(PRINT_ANY, "peer_policy", "peer policy %s ",
 			     netkit_print_policy(policy));
 	}
+	if (tb[IFLA_NETKIT_SCRUB]) {
+		enum netkit_scrub scrub = rta_getattr_u32(tb[IFLA_NETKIT_SCRUB]);
+
+		print_string(PRINT_ANY, "scrub", "scrub %s ",
+			     netkit_print_scrub(scrub));
+	}
+	if (tb[IFLA_NETKIT_PEER_SCRUB]) {
+		enum netkit_scrub scrub = rta_getattr_u32(tb[IFLA_NETKIT_PEER_SCRUB]);
+
+		print_string(PRINT_ANY, "peer_scrub", "peer scrub %s ",
+			     netkit_print_scrub(scrub));
+	}
 }
 
 static void netkit_print_help(struct link_util *lu,
-- 
2.43.0


