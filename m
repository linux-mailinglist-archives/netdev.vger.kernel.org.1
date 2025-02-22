Return-Path: <netdev+bounces-168797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54EDA40B93
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 21:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1E7175F78
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 20:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88828201100;
	Sat, 22 Feb 2025 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="fb4s+TPO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89CA18EB0
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740256923; cv=none; b=EalGlcfBTz1bDJUeqz7rINvBsbg8KVuQjkc90DskelnIaeMRs7x91Ja00HVkoDQYogEKWVjHTc9SSZ9eS3mY17xeqIP9aJ4sBxaqxUwfHpqSkYOTFahNk5H/tRDrjRh9bVk/Fe8h3qOEL4VY3l007Fxykql6VmmCs2KBlIhbiOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740256923; c=relaxed/simple;
	bh=HcDtFVJgQpA2UnENYZeVGuhKz1nAYxI68ddoWTK7fIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CD8LF5VK8FKymqsGt9nkKqqtEgdDkhGsug9U+8MoqSvuYliGAGw+FVMXXt0r61HtGlfVROyN35QwAhJ5V2eR4/t7adsRuk469fx7jj4Xz4POR5RzCuCsZa4qh+3HZ9FAe/hNyGHtR21y9nt07UnShd0GBIUjdDLwy1Aw52Y+PJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=fb4s+TPO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc0ab102e2so805054a91.1
        for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 12:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1740256921; x=1740861721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVG2dUml07zvr3PsmehDVxdiFBTPh7/snDVwG/qP/Ps=;
        b=fb4s+TPORmveJq6kHheZhr0jfVtClHUpP/h84hKttIuodV/0iSi6XN9cJkeDAjAS1L
         Js93pfCrNWGy+/3hFzYZ+zfX+1LwQ64WPdM77VKstMLEe2PSkigQ2oOhknRAEpYYurb0
         cuqQWTAyzVOtRzaASByBO33uTvA+B30DlZV8Xc2yzh5uBTUbHDjkDI12uMXs+zlAXOvX
         UezwNr7hgi7Q6V6wbdZFyFT/FAg47kY6G2C78ROqzelVCJzCkf6LcjIqYj0CKXXTZRBe
         QLgUxuwHn4ghd/a4m2LNGzczx9pmxwT/td6jUjo8DVEjr5Cu9RDMbuSAEDFrF4S8rD90
         EHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740256921; x=1740861721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVG2dUml07zvr3PsmehDVxdiFBTPh7/snDVwG/qP/Ps=;
        b=eOCcSwskrWlpOsqCfSh0ZFvAsDpTdty53MCrfNCxpEoFOun+zXpZnqqdntOEosba3g
         6cjDLKtKJMxlRqOQsWOPbufl9+FxmjiB1yMvV533Hz2zSZ1xPE/gtEXcDiq2C4m2AHyo
         1TVFv8qf1sxNHGbP3NN4+rnRbsEXpcM7VsQU66PGDOHhkroiSJdzd3MylxYhebWT6Dj4
         yCKGiLsIeNzrTP8PGLtTAEPdRY6+qkIHrGBZSYSeY3Nnyz6TquTWfOiKueHs2AhKjnHJ
         37NqD2Ln+vx6ZDseRAonft/7yNH4+TMryRw58jSH70wYRj3YE0fY3U/uI5J/pIB7CrdX
         7l7w==
X-Forwarded-Encrypted: i=1; AJvYcCUwV1kjTBMc3Rk5q153olJ5SlJ9hi4CtidxcTEiuNhiOWJ4mLbnNYJMnwPrdjIRRIsUf/G+odk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTWvQ5cw4W6AfDADBdWRSZ26b7Wzi1fJ/MGCOYWz/DFqgWmhh
	/4duZ/BcV/q1rmm77F7uy2s0ka80doxHZGFxAzXojeoPkkwLVHKZ+jIMyHpHhBY=
X-Gm-Gg: ASbGncta1w7ah5ZaN4IeNwm95ib4sCLrqaAVUROvxHwFb8Usby4umXJ5ixN4uNLqrZ9
	vLD2MfNyg+jpcKeCvJt55r6mm6JEjYp3Qn1JDKlHCHVixLCTTZ7oLwpID+gi1KmLEpMG31WA9Y4
	sTGtm1E2MI7/OhcfPdQhr11MRnkBV2JsGXrpkKkWJ3YsaRHpaXxEBsDAIc19waaHc7JRnI6UPvD
	h5+YSGQRKegcxKzZkHgNHdf2Upa5JOP72qtmSJxQAc6TJ8gi8lGZvudQfe/ODsCbZwvfJfELvAG
	Go/Oo9uBDKJ9Fxs=
X-Google-Smtp-Source: AGHT+IGizHjP0L8zYGKI6O3ckJuBetXlxLTfog3fEwrs3TA4HpLY+LjcvqXHnvb1NGy0J9YQlbdWbg==
X-Received: by 2002:a05:6a20:7f9c:b0:1ee:ced0:f0a6 with SMTP id adf61e73a8af0-1eef3dd0da4mr5167869637.8.1740256920983;
        Sat, 22 Feb 2025 12:42:00 -0800 (PST)
Received: from t14.. ([2001:5a8:4528:b100:1bae:99c1:10ba:a415])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5dee4sm16362899a12.14.2025.02.22.12.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 12:42:00 -0800 (PST)
From: Jordan Rife <jordan@jrife.io>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	stephen@networkplumber.org,
	dsahern@kernel.org
Subject: [PATCH iproute2] ip: link: netkit: Support scrub options
Date: Sat, 22 Feb 2025 12:41:50 -0800
Message-ID: <20250222204151.1145706-1-jordan@jrife.io>
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

Link: https://lore.kernel.org/netdev/20241004101335.117711-1-daniel@iogearbox.net/

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 ip/iplink_netkit.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/ip/iplink_netkit.c b/ip/iplink_netkit.c
index 49550a2e..f2c6e699 100644
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
+		"Usage: ... %s [ mode MODE ] [ POLICY ] [scrub SCRUB] [ peer [ POLICY <options> ] ]\n"
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


