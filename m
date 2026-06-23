Return-Path: <netdev+bounces-301229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z/eBCcHfOWrhyQcAu9opvQ
	(envelope-from <netdev+bounces-301229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:22:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 469916B326C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:22:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PZXU5EDJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301229-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301229-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34821302BE2F
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 01:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A309235A39F;
	Tue, 23 Jun 2026 01:17:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439030D3E9
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:17:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177461; cv=none; b=Bt7pkXPrO3nJz4bqFIKIqtO+UsWIKHOiUx5eXs6WuLi0xcwddpvZD+NO4ynxeAd4ACbLutAGgZXUn1EtShshvWJM0lgcs8dYFHEy4nD1lNJ7MsDEMVQq2k4LwODecKlbm5DFLo2eV9mDXMoapst1ZI8agtsDRxC+Yr83yOm5Lhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177461; c=relaxed/simple;
	bh=xuSoA3uyIHWVRnzGEcsy7fgNan/gYmTM8LsJNEylCik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPqeV34VZP1waVOxh5m/YTtrqyldfhBIMPmTmTX8GyQyh7PXHNt5ri9fGgCRJ2DpoMYjY76ANl5wqEzeJLhKknao9r9B0A8dsTl2fnpYYXR829itFUVXCFxUH95ONgdI1f4twSi9V0jnZX5Kvdr5wglsSBqZNuhq+KkXaPzh35M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZXU5EDJ; arc=none smtp.client-ip=209.85.210.50
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e718d46a6aso2912842a34.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 18:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782177457; x=1782782257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKObHQPf57jQKV6VIAwyVqWiQEYrV9A99Y1M0rd+eWc=;
        b=PZXU5EDJsHTlRg33ov+ew8wXl78C9wpkCG6gynniwrYeMOnXpx39vica8mXldcrlyP
         3Xhfq6zt7SYKS89CpQeVpzCFMh4VEcPKoB4181/Zqde57tfMIe4v5XoMgzEPXTqnPxhK
         ZhytLknr3RFo9hkmnI6lO6TrLZn9vZbHKN/SDZgr3F9G9fl4QkkkHBMHwa0PJVy0cCMK
         vttUFhKqaca1pFIBppQyjI0T4ND/5Q5jA4YHARVBsQXzDpypcU5b4ytHmbkVMGTINKps
         HIkaQJe8cTk//nGsSPgGKDi90N5x25yY4yFO6z9iFZ7siysxB2FWKytYR5lt/I04hOj5
         yvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782177457; x=1782782257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xKObHQPf57jQKV6VIAwyVqWiQEYrV9A99Y1M0rd+eWc=;
        b=QFILn9UCoOHQVLzTZ8GgIMltAFQVnhw5Zl7yfhubuhb1u8Ocsg80xuheOrTbkzGQ5b
         jFUY28IcjTJ/ejiqcTe5lB7rkpjE4MPyiO6YsMvp0pf74p6D/Q/JjeeEBzd+LS/FulAl
         0BqQJw9gmudT1wZwnwnaH1C+1gDoZygC7s3+gs4Pe3Tqe72qfSTd2qS01nCFAi0yuWxP
         ZV90XiafS7O6rcMBC/OzRG/TZdm/QUznww5thAUpjxYzLek9IA6tkpxei0vsq9UhEwGu
         iLeGm+tBU1o9j3nAQiPxk/al1OaWWo2MfoVOKusu2g9F6Yq1QDK8ynetMOga33ZJtS3N
         +dwQ==
X-Gm-Message-State: AOJu0Yyqsx7MmzC1NP4pUG8CTFeOF3/LsCQdYP08t14h5uWWsrCVyMg1
	897Gs4iCNQV9rzs5RsDBBw026eBzAU0HsGz1w+UyTKsYmVm1BsVlNAFJ
X-Gm-Gg: AfdE7cnxwJBR1Y+EfJlunOQkdBV1TRI2ZTthgd++JekANqPVVlKoPe33ROmdLXlXe42
	xbK0P+5jSvfuUzRvKiH3BtMFoMbv0oQmm1p+dJ6rNDHZbfSwc03KeYIF4fHjTjgjx0JKYbXL587
	RrgAXQFWBUAv0LID8cbOlRPvNNd9Qp8X9p1zRMFIS9L9p2LF9t382A23uuKeTfq1pVulMaRKQxX
	fL4/cVkj6qHe92Xtubi2dk9uo1zbMvLBMp3/hjHYUw5d0LJAdQWBSREPZeKxflGZgQfeH2gvh+V
	OTXd2aE9Pe0atTuJPnkRUwCtJHscaVwY4weauTstuMkt6Nu8bfjoGIngiO3lmVTAZ5uz428knF9
	OYxn5IWLde6OvYXflPGK4ahf9OlxA0LVU9Gf+tKrwWg1p2DPYEI6SXX6f5ryQjLlbZzDD4rHJQ+
	aLHAcPxf7sefjvf37KGG47L5p9NfqrvPpt0Bbw
X-Received: by 2002:a05:6808:c1f7:b0:489:443d:a8ed with SMTP id 5614622812f47-4896ac4a91amr14992923b6e.32.1782177456394;
        Mon, 22 Jun 2026 18:17:36 -0700 (PDT)
Received: from 94d39335bfd1 ([147.126.81.13])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0dcd69sm6287439b6e.5.2026.06.22.18.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 18:17:35 -0700 (PDT)
From: Rose Wright <rosesophiewright@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	Rose Wright <rosesophiewright@gmail.com>
Subject: [PATCH v2] iproute2: return correct status from help commands across all utilities
Date: Tue, 23 Jun 2026 01:14:54 +0000
Message-ID: <20260623011454.214244-1-rosesophiewright@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622081637.172a6bb8@phoenix.local>
References: <20260622081637.172a6bb8@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-301229-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosesophiewright@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:netdev@vger.kernel.org,m:rosesophiewright@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosesophiewright@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 469916B326C

Currently, help commands ("help", "-h", "-help") in utilities
always return error codes.

This is a bug which breaks piping, grep operations, and scripts
that rely on standard exit codes. The fix parameterizes the usage/help
functions in these utilities to dynamically write to stdout when help
is explicitly requested.

This patch standardizes the behavior of help commands and usage errors
across all utilities: ip, bridge, tc, devlink, dcb, rdma, vdpa, dpll,
genl, tipc, and netshaper.

Netlink socket initialization is bypassed when a help command is used to prevent commands from failing in isolated
test/container environments.

Test added to confirm these changes: testsuite/tests/ip/help.t

Signed-off-by: Rose Wright <rosesophiewright@gmail.com>
---
 bridge/bridge.c           |  22 +++---
 dcb/dcb.c                 |  38 +++++++---
 devlink/devlink.c         |  42 ++++++++---
 dpll/dpll.c               |  31 +++++---
 genl/genl.c               |  14 ++--
 netshaper/netshaper.c     |  52 ++++++++++---
 rdma/rdma.c               |  39 +++++++---
 tc/tc.c                   |  14 ++--
 testsuite/tests/ip/help.t | 151 ++++++++++++++++++++++++++++++++++++++
 tipc/bearer.c             | 142 +++++++++++++++++++----------------
 tipc/bearer.h             |   8 +-
 tipc/cmdl.c               |   9 ++-
 tipc/cmdl.h               |   6 +-
 tipc/link.c               | 108 ++++++++++++++-------------
 tipc/link.h               |   4 +-
 tipc/media.c              |  24 +++---
 tipc/media.h              |   4 +-
 tipc/nametable.c          |   8 +-
 tipc/nametable.h          |   4 +-
 tipc/node.c               |  54 ++++++++------
 tipc/node.h               |   4 +-
 tipc/peer.c               |  26 +++----
 tipc/peer.h               |   4 +-
 tipc/socket.c             |   8 +-
 tipc/socket.h             |   4 +-
 tipc/tipc.c               |  26 ++++---
 vdpa/vdpa.c               |  40 +++++++---
 27 files changed, 598 insertions(+), 288 deletions(-)
 create mode 100755 testsuite/tests/ip/help.t

diff --git a/bridge/bridge.c b/bridge/bridge.c
index d993ba19..7bc08b82 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -29,23 +29,25 @@ int timestamp;
 static const char *batch_file;
 int force;
 
-static void usage(void) __attribute__((noreturn));
+static void usage(int status) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(int status)
 {
-	fprintf(stderr,
+	FILE *out = status == 0 ? stdout : stderr;
+
+	fprintf(out,
 "Usage: bridge [ OPTIONS ] OBJECT { COMMAND | help }\n"
 "       bridge [ -force ] -batch filename\n"
 "where  OBJECT := { link | fdb | mdb | mst | vlan | vni | monitor }\n"
 "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
 "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
 "                    -com[pressvlans] -c[olor] -p[retty] -j[son] }\n");
-	exit(-1);
+	exit(status);
 }
 
 static int do_help(int argc, char **argv)
 {
-	usage();
+	usage(0);
 }
 
 
@@ -118,7 +120,7 @@ main(int argc, char **argv)
 			opt++;
 
 		if (matches(opt, "-help") == 0) {
-			usage();
+			usage(0);
 		} else if (matches(opt, "-Version") == 0) {
 			printf("bridge utility, %s\n", version);
 			exit(0);
@@ -135,13 +137,13 @@ main(int argc, char **argv)
 			argc--;
 			argv++;
 			if (argc <= 1)
-				usage();
+				usage(-1);
 			if (strcmp(argv[1], "inet") == 0)
 				preferred_family = AF_INET;
 			else if (strcmp(argv[1], "inet6") == 0)
 				preferred_family = AF_INET6;
 			else if (strcmp(argv[1], "help") == 0)
-				usage();
+				usage(0);
 			else
 				invarg("invalid protocol family", argv[1]);
 		} else if (strcmp(opt, "-4") == 0) {
@@ -165,7 +167,7 @@ main(int argc, char **argv)
 			argc--;
 			argv++;
 			if (argc <= 1)
-				usage();
+				usage(-1);
 			batch_file = argv[1];
 		} else {
 			fprintf(stderr,
@@ -192,5 +194,5 @@ main(int argc, char **argv)
 		return do_cmd(argv[1], argc-1, argv+1);
 
 	rtnl_close(&rth);
-	usage();
+	usage(-1);
 }
diff --git a/dcb/dcb.c b/dcb/dcb.c
index fe0a0f04..131005fe 100644
--- a/dcb/dcb.c
+++ b/dcb/dcb.c
@@ -465,9 +465,9 @@ int dcb_cmd_parse_dev(struct dcb *dcb, int argc, char **argv,
 	}
 }
 
-static void dcb_help(void)
+static void dcb_help(FILE *out)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: dcb [ OPTIONS ] OBJECT { COMMAND | help }\n"
 		"       dcb [ -f | --force ] { -b | --batch } filename [ -n | --netns ] netnsname\n"
 		"where  OBJECT := { app | apptrust | buffer | dcbx | ets | maxrate | pfc | rewr }\n"
@@ -478,8 +478,11 @@ static void dcb_help(void)
 
 static int dcb_cmd(struct dcb *dcb, int argc, char **argv)
 {
-	if (!argc || matches(*argv, "help") == 0) {
-		dcb_help();
+	if (!argc) {
+		dcb_help(stderr);
+		return -EINVAL;
+	} else if (matches(*argv, "help") == 0) {
+		dcb_help(stdout);
 		return 0;
 	} else if (matches(*argv, "app") == 0) {
 		return dcb_cmd_app(dcb, argc - 1, argv + 1);
@@ -533,6 +536,7 @@ int main(int argc, char **argv)
 	const char *batch_file = NULL;
 	bool force = false;
 	struct dcb *dcb;
+	bool need_nl = true;
 	int opt;
 	int err;
 	int ret;
@@ -579,12 +583,12 @@ int main(int argc, char **argv)
 			dcb->use_iec = true;
 			break;
 		case 'h':
-			dcb_help();
+			dcb_help(stdout);
 			ret = EXIT_SUCCESS;
 			goto dcb_free;
 		default:
 			fprintf(stderr, "Unknown option.\n");
-			dcb_help();
+			dcb_help(stderr);
 			ret = EXIT_FAILURE;
 			goto dcb_free;
 		}
@@ -593,10 +597,21 @@ int main(int argc, char **argv)
 	argc -= optind;
 	argv += optind;
 
-	err = dcb_init(dcb);
-	if (err) {
-		ret = EXIT_FAILURE;
-		goto dcb_free;
+	if (argc > 0 && (strcmp(argv[0], "help") == 0 ||
+			 strcmp(argv[0], "-h") == 0 ||
+			 strcmp(argv[0], "--help") == 0))
+		need_nl = false;
+	if (argc > 1 && (strcmp(argv[1], "help") == 0 ||
+			 strcmp(argv[1], "-h") == 0 ||
+			 strcmp(argv[1], "--help") == 0))
+		need_nl = false;
+
+	if (need_nl) {
+		err = dcb_init(dcb);
+		if (err) {
+			ret = EXIT_FAILURE;
+			goto dcb_free;
+		}
 	}
 
 	if (batch_file)
@@ -612,7 +627,8 @@ int main(int argc, char **argv)
 	ret = EXIT_SUCCESS;
 
 dcb_fini:
-	dcb_fini(dcb);
+	if (need_nl)
+		dcb_fini(dcb);
 dcb_free:
 	dcb_free(dcb);
 
diff --git a/devlink/devlink.c b/devlink/devlink.c
index b4deba30..ad64ba1e 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -10332,9 +10332,9 @@ static int cmd_trap(struct dl *dl)
 	return -ENOENT;
 }
 
-static void help(void)
+static void help(FILE *out)
 {
-	pr_err("Usage: devlink [ OPTIONS ] OBJECT { COMMAND | help }\n"
+	fprintf(out, "Usage: devlink [ OPTIONS ] OBJECT { COMMAND | help }\n"
 	       "       devlink [ -f[orce] ] -b[atch] filename -N[etns] netnsname\n"
 	       "where  OBJECT := { dev | port | lc | sb | monitor | dpipe | resource | region | health | trap }\n"
 	       "       OPTIONS := { -V[ersion] | -n[o-nice-names] | -j[son] | -p[retty] | -v[erbose] -s[tatistics] -[he]x }\n");
@@ -10345,9 +10345,12 @@ static int dl_cmd(struct dl *dl, int argc, char **argv)
 	dl->argc = argc;
 	dl->argv = argv;
 
-	if (dl_argv_match(dl, "help") || dl_no_arg(dl)) {
-		help();
+	if (dl_argv_match(dl, "help")) {
+		help(stdout);
 		return 0;
+	} else if (dl_no_arg(dl)) {
+		help(stderr);
+		return -EINVAL;
 	} else if (dl_argv_match(dl, "dev")) {
 		dl_arg_inc(dl);
 		return cmd_dev(dl);
@@ -10454,6 +10457,7 @@ int main(int argc, char **argv)
 	const char *batch_file = NULL;
 	bool force = false;
 	struct dl *dl;
+	bool need_nl = true;
 	int opt;
 	int err;
 	int ret;
@@ -10464,7 +10468,7 @@ int main(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	while ((opt = getopt_long(argc, argv, "Vfb:njpvsN:ix",
+	while ((opt = getopt_long(argc, argv, "Vfb:njpvsN:ixh",
 				  long_options, NULL)) >= 0) {
 
 		switch (opt) {
@@ -10505,9 +10509,13 @@ int main(int argc, char **argv)
 		case 'x':
 			dl->hex = true;
 			break;
+		case 'h':
+			help(stdout);
+			ret = EXIT_SUCCESS;
+			goto dl_free;
 		default:
 			pr_err("Unknown option.\n");
-			help();
+			help(stderr);
 			ret = EXIT_FAILURE;
 			goto dl_free;
 		}
@@ -10516,10 +10524,21 @@ int main(int argc, char **argv)
 	argc -= optind;
 	argv += optind;
 
-	err = dl_init(dl);
-	if (err) {
-		ret = EXIT_FAILURE;
-		goto dl_free;
+	if (argc > 0 && (strcmp(argv[0], "help") == 0 ||
+			 strcmp(argv[0], "-h") == 0 ||
+			 strcmp(argv[0], "--help") == 0))
+		need_nl = false;
+	if (argc > 1 && (strcmp(argv[1], "help") == 0 ||
+			 strcmp(argv[1], "-h") == 0 ||
+			 strcmp(argv[1], "--help") == 0))
+		need_nl = false;
+
+	if (need_nl) {
+		err = dl_init(dl);
+		if (err) {
+			ret = EXIT_FAILURE;
+			goto dl_free;
+		}
 	}
 
 	if (batch_file)
@@ -10535,7 +10554,8 @@ int main(int argc, char **argv)
 	ret = EXIT_SUCCESS;
 
 dl_fini:
-	dl_fini(dl);
+	if (need_nl)
+		dl_fini(dl);
 dl_free:
 	dl_free(dl);
 
diff --git a/dpll/dpll.c b/dpll/dpll.c
index 60404e13..e0afb4fe 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -575,9 +575,9 @@ static void dpll_pr_freq_range(__u64 freq_min, __u64 freq_max)
 	close_json_object();
 }
 
-static void help(void)
+static void help(FILE *out)
 {
-	pr_err("Usage: dpll [ OPTIONS ] OBJECT { COMMAND | help }\n"
+	fprintf(out, "Usage: dpll [ OPTIONS ] OBJECT { COMMAND | help }\n"
 	       "where  OBJECT := { device | pin | monitor }\n"
 	       "       OPTIONS := { -V | --Version | -j | --json | -p | --pretty |\n"
 	       "                    -t | --timestamp | --tshort }\n");
@@ -592,9 +592,12 @@ static int dpll_cmd(struct dpll *dpll, int argc, char **argv)
 	dpll->argc = argc;
 	dpll->argv = argv;
 
-	if (dpll_argv_match(dpll, "help") || dpll_no_arg(dpll)) {
-		help();
+	if (dpll_argv_match(dpll, "help")) {
+		help(stdout);
 		return 0;
+	} else if (dpll_no_arg(dpll)) {
+		help(stderr);
+		return -EINVAL;
 	} else if (dpll_argv_match_inc(dpll, "device")) {
 		return cmd_device(dpll);
 	} else if (dpll_argv_match_inc(dpll, "pin")) {
@@ -646,10 +649,12 @@ int main(int argc, char **argv)
 		{ "pretty", no_argument, NULL, 'p' },
 		{ "timestamp", no_argument, NULL, 't' },
 		{ "tshort", no_argument, NULL, OPT_TSHORT },
+		{ "help", no_argument, NULL, 'h' },
 		{ NULL, 0, NULL, 0 }
 	};
-	const char *opt_short = "Vjpt";
+	const char *opt_short = "Vjpth";
 	struct dpll *dpll;
+	bool need_nl = true;
 	int err, opt, ret;
 
 	dpll = dpll_alloc();
@@ -678,9 +683,13 @@ int main(int argc, char **argv)
 			timestamp = 1;
 			timestamp_short = 1;
 			break;
+		case 'h':
+			help(stdout);
+			ret = EXIT_SUCCESS;
+			goto dpll_free;
 		default:
 			pr_err("Unknown option.\n");
-			help();
+			help(stderr);
 			ret = EXIT_FAILURE;
 			goto dpll_free;
 		}
@@ -700,11 +709,13 @@ int main(int argc, char **argv)
 	}
 
 	/* Skip netlink init for help commands */
-	bool need_nl = true;
-
-	if (argc > 0 && strcmp(argv[0], "help") == 0)
+	if (argc > 0 && (strcmp(argv[0], "help") == 0 ||
+			 strcmp(argv[0], "-h") == 0 ||
+			 strcmp(argv[0], "--help") == 0))
 		need_nl = false;
-	if (argc > 1 && strcmp(argv[1], "help") == 0)
+	if (argc > 1 && (strcmp(argv[1], "help") == 0 ||
+			 strcmp(argv[1], "-h") == 0 ||
+			 strcmp(argv[1], "--help") == 0))
 		need_nl = false;
 
 	if (need_nl) {
diff --git a/genl/genl.c b/genl/genl.c
index b497a3ad..2c304a57 100644
--- a/genl/genl.c
+++ b/genl/genl.c
@@ -90,16 +90,18 @@ noexist:
 	return f;
 }
 
-static void usage(void) __attribute__((noreturn));
+static void usage(int status) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(int status)
 {
-	fprintf(stderr,
+	FILE *out = status == 0 ? stdout : stderr;
+
+	fprintf(out,
 		"Usage: genl [ OPTIONS ] OBJECT [help] }\n"
 		"where  OBJECT := { ctrl etc }\n"
 		"       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] | -r[aw] |\n"
 		"                    -j[son] | -p[retty] }\n");
-	exit(-1);
+	exit(status);
 }
 
 int main(int argc, char **argv)
@@ -122,7 +124,7 @@ int main(int argc, char **argv)
 		} else if (matches(argv[1], "-pretty") == 0) {
 			++pretty;
 		} else if (matches(argv[1], "-help") == 0) {
-			usage();
+			usage(0);
 		} else {
 			fprintf(stderr,
 				"Option \"%s\" is unknown, try \"genl -help\".\n",
@@ -146,5 +148,5 @@ int main(int argc, char **argv)
 		return ret;
 	}
 
-	usage();
+	usage(-1);
 }
diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 3b47d43d..f9aeac9b 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -26,9 +26,11 @@
 static struct rtnl_handle gen_rth = { .fd = -1 };
 static int genl_family = -1;
 
-static void usage(void)
+static void usage(int status)
 {
-	fprintf(stderr,
+	FILE *out = status == 0 ? stdout : stderr;
+
+	fprintf(out,
 		"Usage: netshaper [ OPTIONS ] { COMMAND | help }\n"
 		"OPTIONS := { -V[ersion] | -c[olor] | -help }\n"
 		"COMMAND := { set | get | delete | group } dev DEVNAME\n"
@@ -216,6 +218,13 @@ static void print_netshaper_attrs(struct nlmsghdr *answer)
 
 static int do_cmd(int argc, char **argv, int cmd)
 {
+	if (argc > 0 && (strcmp(*argv, "help") == 0 ||
+			 strcmp(*argv, "-h") == 0 ||
+			 strcmp(*argv, "--help") == 0)) {
+		usage(0);
+		exit(0);
+	}
+
 	GENL_REQUEST(req, 1024, genl_family, 0, NET_SHAPER_FAMILY_VERSION, cmd,
 		     NLM_F_REQUEST | NLM_F_ACK);
 
@@ -243,7 +252,7 @@ static int do_cmd(int argc, char **argv, int cmd)
 
 			if (strcmp(*argv, "scope") != 0) {
 				fprintf(stderr, "What is \"%s\"\n", *argv);
-				usage();
+				usage(-1);
 				return -1;
 			}
 			NEXT_ARG();
@@ -270,7 +279,7 @@ static int do_cmd(int argc, char **argv, int cmd)
 				NEXT_ARG();
 				if (strcmp(*argv, "id") != 0) {
 					fprintf(stderr, "What is \"%s\"\n", *argv);
-					usage();
+					usage(-1);
 					return -1;
 				}
 				NEXT_ARG();
@@ -282,7 +291,7 @@ static int do_cmd(int argc, char **argv, int cmd)
 			}
 		} else {
 			fprintf(stderr, "What is \"%s\"\n", *argv);
-			usage();
+			usage(-1);
 			return -1;
 		}
 		argc--;
@@ -363,7 +372,7 @@ static int parse_scope_id(const char *what, int *argcp, char ***argvp, int *scop
 		NEXT_ARG();
 		if (strcmp(*argv, "id") != 0) {
 			fprintf(stderr, "What is \"%s\"\n", *argv);
-			usage();
+			usage(-1);
 			return -1;
 		}
 		NEXT_ARG();
@@ -476,6 +485,13 @@ static int parse_leaves(int *argcp, char ***argvp,
 
 static int do_group(int argc, char **argv)
 {
+	if (argc > 0 && (strcmp(*argv, "help") == 0 ||
+			 strcmp(*argv, "-h") == 0 ||
+			 strcmp(*argv, "--help") == 0)) {
+		usage(0);
+		exit(0);
+	}
+
 	GENL_REQUEST(req, 4096, genl_family, 0, NET_SHAPER_FAMILY_VERSION,
 		     NET_SHAPER_CMD_GROUP, NLM_F_REQUEST | NLM_F_ACK);
 
@@ -517,7 +533,7 @@ static int do_group(int argc, char **argv)
 			continue;
 		} else {
 			fprintf(stderr, "What is \"%s\"\n", *argv);
-			usage();
+			usage(-1);
 			goto free_leaves;
 		}
 		argc--;
@@ -599,6 +615,7 @@ free_leaves:
 int main(int argc, char **argv)
 {
 	int color = default_color_opt();
+	bool need_nl = true;
 
 	while (argc > 1) {
 		const char *opt = argv[1];
@@ -609,7 +626,7 @@ int main(int argc, char **argv)
 			opt++;
 
 		if (strcmp(opt, "-help") == 0) {
-			usage();
+			usage(0);
 			exit(0);
 		} else if (strcmp(opt, "-Version") == 0 ||
 			   strcmp(opt, "-V") == 0) {
@@ -627,8 +644,19 @@ int main(int argc, char **argv)
 
 	check_enable_color(color, 0);
 
-	if (genl_init_handle(&gen_rth, NET_SHAPER_FAMILY_NAME, &genl_family))
-		exit(1);
+	if (argc > 1 && (strcmp(argv[1], "help") == 0 ||
+			 strcmp(argv[1], "-h") == 0 ||
+			 strcmp(argv[1], "--help") == 0))
+		need_nl = false;
+	if (argc > 2 && (strcmp(argv[2], "help") == 0 ||
+			 strcmp(argv[2], "-h") == 0 ||
+			 strcmp(argv[2], "--help") == 0))
+		need_nl = false;
+
+	if (need_nl) {
+		if (genl_init_handle(&gen_rth, NET_SHAPER_FAMILY_NAME, &genl_family))
+			exit(1);
+	}
 
 	if (argc > 1) {
 		argc--;
@@ -643,7 +671,7 @@ int main(int argc, char **argv)
 		if (strcmp(*argv, "group") == 0)
 			return do_group(argc - 1, argv + 1);
 		if (strcmp(*argv, "help") == 0) {
-			usage();
+			usage(0);
 			return 0;
 		}
 		fprintf(stderr,
@@ -651,6 +679,6 @@ int main(int argc, char **argv)
 			*argv);
 		exit(-1);
 	}
-	usage();
+	usage(-1);
 	exit(-1);
 }
diff --git a/rdma/rdma.c b/rdma/rdma.c
index 253ac58b..3bdb76f0 100644
--- a/rdma/rdma.c
+++ b/rdma/rdma.c
@@ -11,9 +11,9 @@
 /* Global utils flags */
 int json;
 
-static void help(char *name)
+static void help(FILE *out, char *name)
 {
-	pr_out("Usage: %s [ OPTIONS ] OBJECT { COMMAND | help }\n"
+	fprintf(out, "Usage: %s [ OPTIONS ] OBJECT { COMMAND | help }\n"
 	       "       %s [ -f[orce] ] -b[atch] filename\n"
 	       "where  OBJECT := { dev | link | resource | monitor | system | statistic | help }\n"
 	       "       OPTIONS := { -V[ersion] | -d[etails] | -j[son] | -p[retty] | -r[aw]}\n", name, name);
@@ -21,14 +21,20 @@ static void help(char *name)
 
 static int cmd_help(struct rd *rd)
 {
-	help(rd->filename);
+	help(stdout, rd->filename);
 	return 0;
 }
 
+static int cmd_no_arg(struct rd *rd)
+{
+	help(stderr, rd->filename);
+	return -EINVAL;
+}
+
 static int rd_cmd(struct rd *rd, int argc, char **argv)
 {
 	const struct rd_cmd cmds[] = {
-		{ NULL,		cmd_help },
+		{ NULL,		cmd_no_arg },
 		{ "help",	cmd_help },
 		{ "dev",	cmd_dev },
 		{ "link",	cmd_link },
@@ -104,6 +110,7 @@ int main(int argc, char **argv)
 	bool show_raw = false;
 	bool force = false;
 	bool oneline = false;
+	bool need_nl = true;
 	struct rd rd = {};
 	char *filename;
 	int opt;
@@ -142,14 +149,14 @@ int main(int argc, char **argv)
 			batch_file = optarg;
 			break;
 		case 'h':
-			help(filename);
+			help(stdout, filename);
 			return EXIT_SUCCESS;
 		case ':':
 			pr_err("-%c option requires an argument\n", optopt);
 			return EXIT_FAILURE;
 		default:
 			pr_err("Unknown option.\n");
-			help(filename);
+			help(stderr, filename);
 			return EXIT_FAILURE;
 		}
 	}
@@ -163,9 +170,20 @@ int main(int argc, char **argv)
 	rd.show_driver_details = show_driver_details;
 	rd.show_raw = show_raw;
 
-	err = rd_init(&rd, filename);
-	if (err)
-		goto out;
+	if (argc > 0 && (strcmp(argv[0], "help") == 0 ||
+			 strcmp(argv[0], "-h") == 0 ||
+			 strcmp(argv[0], "--help") == 0))
+		need_nl = false;
+	if (argc > 1 && (strcmp(argv[1], "help") == 0 ||
+			 strcmp(argv[1], "-h") == 0 ||
+			 strcmp(argv[1], "--help") == 0))
+		need_nl = false;
+
+	if (need_nl) {
+		err = rd_init(&rd, filename);
+		if (err)
+			goto out;
+	}
 
 	if (batch_file)
 		err = rd_batch(&rd, batch_file, force);
@@ -173,6 +191,7 @@ int main(int argc, char **argv)
 		err = rd_cmd(&rd, argc, argv);
 out:
 	/* Always cleanup */
-	rd_cleanup(&rd);
+	if (need_nl)
+		rd_cleanup(&rd);
 	return err ? EXIT_FAILURE : EXIT_SUCCESS;
 }
diff --git a/tc/tc.c b/tc/tc.c
index 7d69e4d5..057541d2 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -186,9 +186,11 @@ noexist:
 	return q;
 }
 
-static void usage(void)
+static void usage(int status)
 {
-	fprintf(stderr,
+	FILE *out = status == 0 ? stdout : stderr;
+	
+	fprintf(out,
 		"Usage:	tc [ OPTIONS ] OBJECT { COMMAND | help }\n"
 		"	tc [-force] -batch filename\n"
 		"where  OBJECT := { qdisc | class | filter | chain |\n"
@@ -217,7 +219,7 @@ static int do_cmd(int argc, char **argv)
 	if (matches(*argv, "exec") == 0)
 		return do_exec(argc-1, argv+1);
 	if (matches(*argv, "help") == 0) {
-		usage();
+		usage(0);
 		return 0;
 	}
 
@@ -282,7 +284,7 @@ int main(int argc, char **argv)
 		} else if (matches(argv[1], "-iec") == 0) {
 			++use_iec;
 		} else if (matches(argv[1], "-help") == 0) {
-			usage();
+			usage(0);
 			return 0;
 		} else if (matches(argv[1], "-force") == 0) {
 			++force;
@@ -335,8 +337,8 @@ int main(int argc, char **argv)
 		return batch(batch_file);
 
 	if (argc <= 1) {
-		usage();
-		return 0;
+		usage(-1);
+		return -1;
 	}
 
 	tc_core_init();
diff --git a/testsuite/tests/ip/help.t b/testsuite/tests/ip/help.t
new file mode 100755
index 00000000..141abdd6
--- /dev/null
+++ b/testsuite/tests/ip/help.t
@@ -0,0 +1,151 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+. lib/generic.sh
+
+ts_log "[Testing help exit codes and output streams]"
+
+if [ -z "$SNAME" ]; then
+	SNAME="iproute2/iproute2-this"
+fi
+
+# Define binary paths using env vars if available, else fallback to SNAME subpaths
+IP="${IP:-$SNAME/ip/ip}"
+BRIDGE="${BRIDGE:-$SNAME/bridge/bridge}"
+TC="${TC:-$SNAME/tc/tc}"
+DEVLINK="${DEVLINK:-$SNAME/devlink/devlink}"
+DCB="${DCB:-$SNAME/dcb/dcb}"
+RDMA="${RDMA:-$SNAME/rdma/rdma}"
+VDPA="${VDPA:-$SNAME/vdpa/vdpa}"
+DPLL="${DPLL:-$SNAME/dpll/dpll}"
+GENL="${GENL:-$SNAME/genl/genl}"
+TIPC="${TIPC:-$SNAME/tipc/tipc}"
+NETSHAPER="${NETSHAPER:-$SNAME/netshaper/netshaper}"
+
+test_help_cmd() {
+	binary_path="$1"
+	arg="$2"
+	desc="$3"
+
+	$binary_path $arg >$STD_OUT 2>$STD_ERR
+	status=$?
+
+	if [ $status -ne 0 ]; then
+		ts_err "$0: $desc exited with $status (expected 0)"
+		return 1
+	fi
+
+	if [ -s $STD_ERR ]; then
+		ts_err "$0: $desc wrote to stderr (expected stdout only)"
+		ts_err "$0: stderr content:"
+		ts_err_cat $STD_ERR
+		return 1
+	fi
+
+	if [ ! -s $STD_OUT ]; then
+		ts_err "$0: $desc stdout was empty"
+		return 1
+	fi
+
+	echo "$0: $desc passed"
+	return 0
+}
+
+test_usage_error() {
+	binary_path="$1"
+	desc="$2"
+
+	$binary_path >$STD_OUT 2>$STD_ERR
+	status=$?
+
+	if [ $status -eq 0 ]; then
+		ts_err "$0: $desc (no args) exited with 0 (expected non-zero)"
+		return 1
+	fi
+
+	if [ ! -s $STD_ERR ]; then
+		ts_err "$0: $desc (no args) stderr was empty (expected usage info)"
+		return 1
+	fi
+
+	echo "$0: $desc (no args) failed as expected"
+	return 0
+}
+
+test_help_netlink_bypass() {
+	binary_path="$1"
+	arg="$2"
+	desc="$3"
+
+	$binary_path $arg >$STD_OUT 2>$STD_ERR
+	status=$?
+
+	if [ $status -ne 0 ]; then
+		ts_err "$0: $desc exited with $status (expected 0)"
+		return 1
+	fi
+
+	echo "$0: $desc passed"
+	return 0
+}
+
+# Run tests for each utility
+# ip
+test_help_cmd "$IP" "help" "ip help"
+test_help_cmd "$IP" "-help" "ip -help"
+test_usage_error "$IP" "ip"
+
+# bridge
+test_help_cmd "$BRIDGE" "help" "bridge help"
+test_help_cmd "$BRIDGE" "-h" "bridge -h"
+test_usage_error "$BRIDGE" "bridge"
+
+# tc
+test_help_cmd "$TC" "help" "tc help"
+test_help_cmd "$TC" "-h" "tc -h"
+test_usage_error "$TC" "tc"
+
+# devlink
+test_help_cmd "$DEVLINK" "help" "devlink help"
+test_help_cmd "$DEVLINK" "-h" "devlink -h"
+test_help_netlink_bypass "$DEVLINK" "dev help" "devlink dev help"
+test_usage_error "$DEVLINK" "devlink"
+
+# dcb
+test_help_cmd "$DCB" "help" "dcb help"
+test_help_cmd "$DCB" "-h" "dcb -h"
+test_help_netlink_bypass "$DCB" "app help" "dcb app help"
+test_usage_error "$DCB" "dcb"
+
+# rdma
+test_help_cmd "$RDMA" "help" "rdma help"
+test_help_cmd "$RDMA" "-h" "rdma -h"
+test_help_netlink_bypass "$RDMA" "dev help" "rdma dev help"
+test_usage_error "$RDMA" "rdma"
+
+# vdpa
+test_help_cmd "$VDPA" "help" "vdpa help"
+test_help_cmd "$VDPA" "-h" "vdpa -h"
+test_help_netlink_bypass "$VDPA" "dev help" "vdpa dev help"
+test_usage_error "$VDPA" "vdpa"
+
+# dpll
+test_help_cmd "$DPLL" "help" "dpll help"
+test_help_cmd "$DPLL" "-h" "dpll -h"
+test_help_netlink_bypass "$DPLL" "device help" "dpll device help"
+test_usage_error "$DPLL" "dpll"
+
+# genl
+test_help_cmd "$GENL" "-help" "genl -help"
+test_usage_error "$GENL" "genl"
+
+# tipc
+test_help_cmd "$TIPC" "-h" "tipc -h"
+test_help_cmd "$TIPC" "--help" "tipc --help"
+test_usage_error "$TIPC" "tipc"
+
+# netshaper
+test_help_cmd "$NETSHAPER" "help" "netshaper help"
+test_help_cmd "$NETSHAPER" "-help" "netshaper -help"
+test_help_netlink_bypass "$NETSHAPER" "group help" "netshaper group help"
+test_usage_error "$NETSHAPER" "netshaper"
diff --git a/tipc/bearer.c b/tipc/bearer.c
index bb434f5f..2804631b 100644
--- a/tipc/bearer.c
+++ b/tipc/bearer.c
@@ -33,9 +33,9 @@ struct cb_data {
 	struct nlmsghdr *nlh;
 };
 
-static void _print_bearer_opts(void)
+static void _print_bearer_opts(FILE *out)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"OPTIONS\n"
 		" priority		- Bearer link priority\n"
 		" tolerance		- Bearer link tolerance\n"
@@ -43,18 +43,18 @@ static void _print_bearer_opts(void)
 		" mtu			- Bearer link mtu\n");
 }
 
-void print_bearer_media(void)
+void print_bearer_media(FILE *out)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"\nMEDIA\n"
 		" udp			- User Datagram Protocol\n"
 		" ib			- Infiniband\n"
 		" eth			- Ethernet\n");
 }
 
-static void cmd_bearer_enable_l2_help(struct cmdl *cmdl, char *media)
+static void cmd_bearer_enable_l2_help(FILE *out, struct cmdl *cmdl, char *media)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s bearer enable media %s device DEVICE [OPTIONS]\n"
 		"\nOPTIONS\n"
 		" domain DOMAIN		- Discovery domain\n"
@@ -62,9 +62,9 @@ static void cmd_bearer_enable_l2_help(struct cmdl *cmdl, char *media)
 		cmdl->argv[0], media);
 }
 
-static void cmd_bearer_enable_udp_help(struct cmdl *cmdl, char *media)
+static void cmd_bearer_enable_udp_help(FILE *out, struct cmdl *cmdl, char *media)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s bearer enable [OPTIONS] media %s name NAME [localip IP|device DEVICE] [UDP OPTIONS]\n\n"
 		"OPTIONS\n"
 		" domain DOMAIN		- Discovery domain\n"
@@ -230,7 +230,7 @@ static int nl_add_udp_enable_opts(struct nlmsghdr *nlh, struct opt *opts,
 		opt = get_opt(opts, "localip");
 		if (!opt) {
 			fprintf(stderr, "error, udp bearer localip/device missing\n");
-			cmd_bearer_enable_udp_help(cmdl, "udp");
+			cmd_bearer_enable_udp_help(help_flag ? stdout : stderr, cmdl, "udp");
 			return -EINVAL;
 		}
 		locip = opt->val;
@@ -292,7 +292,7 @@ static char *cmd_get_media_type(const struct cmd *cmd, struct cmdl *cmdl,
 
 	if (!opt) {
 		if (help_flag)
-			(cmd->help)(cmdl);
+			(cmd->help)(help_flag ? stdout : stderr, cmdl);
 		else
 			fprintf(stderr, "error, missing bearer media\n");
 		return NULL;
@@ -307,14 +307,14 @@ static int nl_add_bearer_name(struct nlmsghdr *nlh, const struct cmd *cmd,
 	char bname[TIPC_MAX_BEARER_NAME];
 	int err;
 
-	if ((err = cmd_get_unique_bearer_name(cmd, cmdl, opts, bname, sup_media)))
+	if ((err = cmd_get_unique_bearer_name(help_flag ? stdout : stderr, cmd, cmdl, opts, bname, sup_media)))
 		return err;
 
 	mnl_attr_put_strz(nlh, TIPC_NLA_BEARER_NAME, bname);
 	return 0;
 }
 
-int cmd_get_unique_bearer_name(const struct cmd *cmd, struct cmdl *cmdl,
+int cmd_get_unique_bearer_name(FILE *out, const struct cmd *cmd, struct cmdl *cmdl,
 			       struct opt *opts, char *bname,
 			       const struct tipc_sup_media *sup_media)
 {
@@ -332,7 +332,7 @@ int cmd_get_unique_bearer_name(const struct cmd *cmd, struct cmdl *cmdl,
 
 		if (!(opt = get_opt(opts, entry->identifier))) {
 			if (help_flag)
-				(entry->help)(cmdl, media);
+				(entry->help)(out, cmdl, media);
 			else
 				fprintf(stderr, "error, missing bearer %s\n",
 					entry->identifier);
@@ -350,15 +350,15 @@ int cmd_get_unique_bearer_name(const struct cmd *cmd, struct cmdl *cmdl,
 	return -EINVAL;
 }
 
-static void cmd_bearer_add_udp_help(struct cmdl *cmdl, char *media)
+static void cmd_bearer_add_udp_help(FILE *out, struct cmdl *cmdl, char *media)
 {
-	fprintf(stderr, "Usage: %s bearer add media %s name NAME remoteip REMOTEIP\n\n",
+	fprintf(out, "Usage: %s bearer add media %s name NAME remoteip REMOTEIP\n\n",
 		cmdl->argv[0], media);
 }
 
-static void cmd_bearer_add_help(struct cmdl *cmdl)
+static void cmd_bearer_add_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s bearer add media udp name NAME remoteip REMOTEIP\n",
+	fprintf(out, "Usage: %s bearer add media udp name NAME remoteip REMOTEIP\n",
 		cmdl->argv[0]);
 }
 
@@ -421,6 +421,11 @@ static int cmd_bearer_add_media(struct nlmsghdr *nlh, const struct cmd *cmd,
 		{ NULL, },
 	};
 
+	if (help_flag) {
+		(cmd->help)(stdout, cmdl);
+		return 0;
+	}
+
 	/* Rewind optind to include media in the option list */
 	cmdl->optind--;
 	if (parse_opts(opts, cmdl) < 0)
@@ -473,15 +478,15 @@ static int cmd_bearer_add(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return run_cmd(nlh, cmd, cmds, cmdl, NULL);
 }
 
-static void cmd_bearer_enable_help(struct cmdl *cmdl)
+static void cmd_bearer_enable_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s bearer enable [OPTIONS] media MEDIA ARGS...\n\n"
 		"OPTIONS\n"
 		" domain DOMAIN         - Discovery domain\n"
 		" priority PRIORITY     - Bearer priority\n",
 		cmdl->argv[0]);
-	print_bearer_media();
+	print_bearer_media(out);
 }
 
 static int cmd_bearer_enable(struct nlmsghdr *nlh, const struct cmd *cmd,
@@ -509,12 +514,14 @@ static int cmd_bearer_enable(struct nlmsghdr *nlh, const struct cmd *cmd,
 		{ NULL, },
 	};
 
-	if (parse_opts(opts, cmdl) < 0) {
-		if (help_flag)
-			(cmd->help)(cmdl);
-		return -EINVAL;
+	if (help_flag) {
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
+	if (parse_opts(opts, cmdl) < 0)
+		return -EINVAL;
+
 	nlh = msg_init(TIPC_NL_BEARER_ENABLE);
 	if (!nlh) {
 		fprintf(stderr, "error: message initialisation failed\n");
@@ -548,23 +555,23 @@ static int cmd_bearer_enable(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return msg_doit(nlh, NULL, NULL);
 }
 
-static void cmd_bearer_disable_l2_help(struct cmdl *cmdl, char *media)
+static void cmd_bearer_disable_l2_help(FILE *out, struct cmdl *cmdl, char *media)
 {
-	fprintf(stderr, "Usage: %s bearer disable media %s device DEVICE\n",
+	fprintf(out, "Usage: %s bearer disable media %s device DEVICE\n",
 		cmdl->argv[0], media);
 }
 
-static void cmd_bearer_disable_udp_help(struct cmdl *cmdl, char *media)
+static void cmd_bearer_disable_udp_help(FILE *out, struct cmdl *cmdl, char *media)
 {
-	fprintf(stderr, "Usage: %s bearer disable media %s name NAME\n",
+	fprintf(out, "Usage: %s bearer disable media %s name NAME\n",
 		cmdl->argv[0], media);
 }
 
-static void cmd_bearer_disable_help(struct cmdl *cmdl)
+static void cmd_bearer_disable_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s bearer disable media MEDIA ARGS...\n",
+	fprintf(out, "Usage: %s bearer disable media MEDIA ARGS...\n",
 		cmdl->argv[0]);
-	print_bearer_media();
+	print_bearer_media(out);
 }
 
 static int cmd_bearer_disable(struct nlmsghdr *nlh, const struct cmd *cmd,
@@ -585,12 +592,14 @@ static int cmd_bearer_disable(struct nlmsghdr *nlh, const struct cmd *cmd,
 		{ NULL, },
 	};
 
-	if (parse_opts(opts, cmdl) < 0) {
-		if (help_flag)
-			(cmd->help)(cmdl);
-		return -EINVAL;
+	if (help_flag) {
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
+	if (parse_opts(opts, cmdl) < 0)
+		return -EINVAL;
+
 	nlh = msg_init(TIPC_NL_BEARER_DISABLE);
 	if (!nlh) {
 		fprintf(stderr, "error, message initialisation failed\n");
@@ -607,27 +616,27 @@ static int cmd_bearer_disable(struct nlmsghdr *nlh, const struct cmd *cmd,
 
 }
 
-static void cmd_bearer_set_help(struct cmdl *cmdl)
+static void cmd_bearer_set_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s bearer set OPTION media MEDIA ARGS...\n",
+	fprintf(out, "Usage: %s bearer set OPTION media MEDIA ARGS...\n",
 		cmdl->argv[0]);
-	_print_bearer_opts();
-	print_bearer_media();
+	_print_bearer_opts(out);
+	print_bearer_media(out);
 }
 
-static void cmd_bearer_set_udp_help(struct cmdl *cmdl, char *media)
+static void cmd_bearer_set_udp_help(FILE *out, struct cmdl *cmdl, char *media)
 {
-	fprintf(stderr, "Usage: %s bearer set OPTION media %s name NAME\n\n",
+	fprintf(out, "Usage: %s bearer set OPTION media %s name NAME\n\n",
 		cmdl->argv[0], media);
-	_print_bearer_opts();
+	_print_bearer_opts(out);
 }
 
-static void cmd_bearer_set_l2_help(struct cmdl *cmdl, char *media)
+static void cmd_bearer_set_l2_help(FILE *out, struct cmdl *cmdl, char *media)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s bearer set [OPTION]... media %s device DEVICE\n",
 		cmdl->argv[0], media);
-	_print_bearer_opts();
+	_print_bearer_opts(out);
 }
 
 static int cmd_bearer_set_prop(struct nlmsghdr *nlh, const struct cmd *cmd,
@@ -662,6 +671,11 @@ static int cmd_bearer_set_prop(struct nlmsghdr *nlh, const struct cmd *cmd,
 	else
 		return -EINVAL;
 
+	if (help_flag) {
+		(cmd->help)(stdout, cmdl);
+		return 0;
+	}
+
 	if (cmdl->optind >= cmdl->argc) {
 		fprintf(stderr, "error, missing value\n");
 		return -EINVAL;
@@ -716,33 +730,33 @@ static int cmd_bearer_set(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return run_cmd(nlh, cmd, cmds, cmdl, NULL);
 }
 
-static void cmd_bearer_get_help(struct cmdl *cmdl)
+static void cmd_bearer_get_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s bearer get [OPTION] media MEDIA ARGS...\n",
+	fprintf(out, "Usage: %s bearer get [OPTION] media MEDIA ARGS...\n",
 		cmdl->argv[0]);
-	_print_bearer_opts();
-	print_bearer_media();
+	_print_bearer_opts(out);
+	print_bearer_media(out);
 }
 
-static void cmd_bearer_get_udp_help(struct cmdl *cmdl, char *media)
+static void cmd_bearer_get_udp_help(FILE *out, struct cmdl *cmdl, char *media)
 {
-	fprintf(stderr, "Usage: %s bearer get [OPTION] media %s name NAME [UDP OPTIONS]\n\n",
+	fprintf(out, "Usage: %s bearer get [OPTION] media %s name NAME [UDP OPTIONS]\n\n",
 		cmdl->argv[0], media);
-	fprintf(stderr,
+	fprintf(out,
 		"UDP OPTIONS\n"
 		" remoteip              - Remote ip address\n"
 		" remoteport            - Remote port\n"
 		" localip               - Local ip address\n"
 		" localport             - Local port\n\n");
-	_print_bearer_opts();
+	_print_bearer_opts(out);
 }
 
-static void cmd_bearer_get_l2_help(struct cmdl *cmdl, char *media)
+static void cmd_bearer_get_l2_help(FILE *out, struct cmdl *cmdl, char *media)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s bearer get OPTION media %s device DEVICE\n",
 		cmdl->argv[0], media);
-	_print_bearer_opts();
+	_print_bearer_opts(out);
 }
 
 
@@ -938,8 +952,8 @@ static int cmd_bearer_get_media(struct nlmsghdr *nlh, const struct cmd *cmd,
 	media = opt->val;
 
 	if (help_flag) {
-		cmd_bearer_get_udp_help(cmdl, media);
-		return -EINVAL;
+		cmd_bearer_get_udp_help(stdout, cmdl, media);
+		return 0;
 	}
 	if (strcmp(media, "udp") != 0) {
 		fprintf(stderr, "error, no \"%s\" media specific options\n", media);
@@ -1004,8 +1018,8 @@ static int cmd_bearer_get_prop(struct nlmsghdr *nlh, const struct cmd *cmd,
 	};
 
 	if (help_flag) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
 	if (strcmp(cmd->cmd, "priority") == 0)
@@ -1090,8 +1104,8 @@ static int cmd_bearer_list(struct nlmsghdr *nlh, const struct cmd *cmd,
 			   struct cmdl *cmdl, void *data)
 {
 	if (help_flag) {
-		fprintf(stderr, "Usage: %s bearer list\n", cmdl->argv[0]);
-		return -EINVAL;
+		fprintf(stdout, "Usage: %s bearer list\n", cmdl->argv[0]);
+		return 0;
 	}
 
 	nlh = msg_init(TIPC_NL_BEARER_GET);
@@ -1103,9 +1117,9 @@ static int cmd_bearer_list(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return msg_dumpit(nlh, bearer_list_cb, NULL);
 }
 
-void cmd_bearer_help(struct cmdl *cmdl)
+void cmd_bearer_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s bearer COMMAND [ARGS] ...\n"
 		"\n"
 		"COMMANDS\n"
diff --git a/tipc/bearer.h b/tipc/bearer.h
index a9344659..2389f811 100644
--- a/tipc/bearer.h
+++ b/tipc/bearer.h
@@ -12,11 +12,13 @@
 
 extern int help_flag;
 
+#include <stdio.h>
+
 int cmd_bearer(struct nlmsghdr *nlh, const struct cmd *cmd, struct cmdl *cmdl, void *data);
-void cmd_bearer_help(struct cmdl *cmdl);
+void cmd_bearer_help(FILE *out, struct cmdl *cmdl);
 
-void print_bearer_media(void);
-int cmd_get_unique_bearer_name(const struct cmd *cmd, struct cmdl *cmdl,
+void print_bearer_media(FILE *out);
+int cmd_get_unique_bearer_name(FILE *out, const struct cmd *cmd, struct cmdl *cmdl,
 			       struct opt *opts, char *bname,
 			       const struct tipc_sup_media *sup_media);
 #endif
diff --git a/tipc/cmdl.c b/tipc/cmdl.c
index 152ddb51..ee9e822c 100644
--- a/tipc/cmdl.c
+++ b/tipc/cmdl.c
@@ -108,7 +108,7 @@ int run_cmd(struct nlmsghdr *nlh, const struct cmd *caller,
 
 	if ((cmdl->optind) >= cmdl->argc) {
 		if (caller->help)
-			(caller->help)(cmdl);
+			(caller->help)(help_flag ? stdout : stderr, cmdl);
 		return -EINVAL;
 	}
 	name = cmdl->argv[cmdl->optind];
@@ -118,7 +118,7 @@ int run_cmd(struct nlmsghdr *nlh, const struct cmd *caller,
 	if (!cmd) {
 		/* Show help about last command if we don't find this one */
 		if (help_flag && caller->help) {
-			(caller->help)(cmdl);
+			(caller->help)(stdout, cmdl);
 		} else {
 			fprintf(stderr, "error, invalid command \"%s\"\n", name);
 			fprintf(stderr, "use --help for command help\n");
@@ -126,5 +126,10 @@ int run_cmd(struct nlmsghdr *nlh, const struct cmd *caller,
 		return -EINVAL;
 	}
 
+	if (help_flag && cmdl->optind >= cmdl->argc && cmd->help) {
+		(cmd->help)(stdout, cmdl);
+		return 0;
+	}
+
 	return (cmd->func)(nlh, cmd, cmdl, data);
 }
diff --git a/tipc/cmdl.h b/tipc/cmdl.h
index 18fe51bf..fd8f02d1 100644
--- a/tipc/cmdl.h
+++ b/tipc/cmdl.h
@@ -12,6 +12,8 @@
 
 extern int help_flag;
 
+#include <stdio.h>
+
 enum {
 	OPT_KEY			= (1 << 0),
 	OPT_KEYVAL		= (1 << 1),
@@ -26,14 +28,14 @@ struct cmdl {
 struct tipc_sup_media {
 	char *media;
 	char *identifier;
-	void (*help)(struct cmdl *cmdl, char *media);
+	void (*help)(FILE *out, struct cmdl *cmdl, char *media);
 };
 
 struct cmd {
 	const char *cmd;
 	int (*func)(struct nlmsghdr *nlh, const struct cmd *cmd,
 		    struct cmdl *cmdl, void *data);
-	void (*help)(struct cmdl *cmdl);
+	void (*help)(FILE *out, struct cmdl *cmdl);
 };
 
 struct opt {
diff --git a/tipc/link.c b/tipc/link.c
index f91c3000..48b759d3 100644
--- a/tipc/link.c
+++ b/tipc/link.c
@@ -139,8 +139,8 @@ static int cmd_link_get_prop(struct nlmsghdr *nlh, const struct cmd *cmd,
 		return -EINVAL;
 
 	if (help_flag) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
 	if (parse_opts(opts, cmdl) < 0)
@@ -164,9 +164,9 @@ static int cmd_link_get_prop(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return msg_doit(nlh, link_get_cb, &prop);
 }
 
-static void cmd_link_get_help(struct cmdl *cmdl)
+static void cmd_link_get_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s link get PPROPERTY link LINK\n\n"
+	fprintf(out, "Usage: %s link get PPROPERTY link LINK\n\n"
 		"PROPERTIES\n"
 		" tolerance             - Get link tolerance\n"
 		" priority              - Get link priority\n"
@@ -224,9 +224,9 @@ static int cmd_link_get_bcast_cb(const struct nlmsghdr *nlh, void *data)
 	return MNL_CB_OK;
 }
 
-static void cmd_link_get_bcast_help(struct cmdl *cmdl)
+static void cmd_link_get_bcast_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s link get PPROPERTY\n\n"
+	fprintf(out, "Usage: %s link get PPROPERTY\n\n"
 		"PROPERTIES\n"
 		" broadcast             - Get link broadcast\n",
 		cmdl->argv[0]);
@@ -239,8 +239,8 @@ static int cmd_link_get_bcast(struct nlmsghdr *nlh, const struct cmd *cmd,
 	struct nlattr *attrs;
 
 	if (help_flag) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
 	nlh = msg_init(TIPC_NL_LINK_GET);
@@ -269,9 +269,9 @@ static int cmd_link_get(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return run_cmd(nlh, cmd, cmds, cmdl, NULL);
 }
 
-static void cmd_link_stat_reset_help(struct cmdl *cmdl)
+static void cmd_link_stat_reset_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s link stat reset link LINK\n\n", cmdl->argv[0]);
+	fprintf(out, "Usage: %s link stat reset link LINK\n\n", cmdl->argv[0]);
 }
 
 static int cmd_link_stat_reset(struct nlmsghdr *nlh, const struct cmd *cmd,
@@ -286,12 +286,12 @@ static int cmd_link_stat_reset(struct nlmsghdr *nlh, const struct cmd *cmd,
 	};
 
 	if (help_flag) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
 	if (parse_opts(opts, cmdl) != 1) {
-		(cmd->help)(cmdl);
+		(cmd->help)(stdout, cmdl);
 		return -EINVAL;
 	}
 
@@ -533,9 +533,9 @@ static int link_stat_show_cb(const struct nlmsghdr *nlh, void *data)
 	return _show_link_stat(name, attrs, prop, stats);
 }
 
-static void cmd_link_stat_show_help(struct cmdl *cmdl)
+static void cmd_link_stat_show_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s link stat show [ link { LINK | SUBSTRING | all } ]\n",
+	fprintf(out, "Usage: %s link stat show [ link { LINK | SUBSTRING | all } ]\n",
 		cmdl->argv[0]);
 }
 
@@ -552,8 +552,8 @@ static int cmd_link_stat_show(struct nlmsghdr *nlh, const struct cmd *cmd,
 	int err = 0;
 
 	if (help_flag) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
 	nlh = msg_init(TIPC_NL_LINK_GET);
@@ -581,9 +581,9 @@ static int cmd_link_stat_show(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return err;
 }
 
-static void cmd_link_stat_help(struct cmdl *cmdl)
+static void cmd_link_stat_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s link stat COMMAND [ARGS]\n\n"
+	fprintf(out, "Usage: %s link stat COMMAND [ARGS]\n\n"
 		"COMMANDS:\n"
 		" reset                 - Reset link statistics for link\n"
 		" show                  - Get link priority\n",
@@ -602,9 +602,9 @@ static int cmd_link_stat(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return run_cmd(nlh, cmd, cmds, cmdl, NULL);
 }
 
-static void cmd_link_set_help(struct cmdl *cmdl)
+static void cmd_link_set_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s link set PPROPERTY link LINK\n\n"
+	fprintf(out, "Usage: %s link set PROPERTY link LINK\n\n"
 		"PROPERTIES\n"
 		" tolerance TOLERANCE   - Set link tolerance\n"
 		" priority PRIORITY     - Set link priority\n"
@@ -636,8 +636,8 @@ static int cmd_link_set_prop(struct nlmsghdr *nlh, const struct cmd *cmd,
 		return -EINVAL;
 
 	if (help_flag) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
 	if (cmdl->optind >= cmdl->argc) {
@@ -672,9 +672,9 @@ static int cmd_link_set_prop(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return msg_doit(nlh, link_get_cb, &prop);
 }
 
-static void cmd_link_set_bcast_help(struct cmdl *cmdl)
+static void cmd_link_set_bcast_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s link set broadcast PROPERTY\n\n"
+	fprintf(out, "Usage: %s link set broadcast PROPERTY\n\n"
 		"PROPERTIES\n"
 		" BROADCAST         - Forces all multicast traffic to be\n"
 		"                     transmitted via broadcast only,\n"
@@ -708,8 +708,8 @@ static int cmd_link_set_bcast(struct nlmsghdr *nlh, const struct cmd *cmd,
 	int method = 0;
 
 	if (help_flag) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
 	if (parse_opts(opts, cmdl) < 0)
@@ -720,7 +720,7 @@ static int cmd_link_set_bcast(struct nlmsghdr *nlh, const struct cmd *cmd,
 			break;
 
 	if (!opt || !opt->key) {
-		(cmd->help)(cmdl);
+		(cmd->help)(stdout, cmdl);
 		return -EINVAL;
 	}
 
@@ -744,7 +744,7 @@ static int cmd_link_set_bcast(struct nlmsghdr *nlh, const struct cmd *cmd,
 
 	opt = get_opt(opts, "ratio");
 	if (!method && !opt) {
-		(cmd->help)(cmdl);
+		(cmd->help)(stdout, cmdl);
 		return -EINVAL;
 	}
 
@@ -833,8 +833,8 @@ static int cmd_link_mon_summary(struct nlmsghdr *nlh, const struct cmd *cmd,
 	int err = 0;
 
 	if (help_flag) {
-		fprintf(stderr,	"Usage: %s monitor summary\n", cmdl->argv[0]);
-		return -EINVAL;
+		fprintf(stdout,	"Usage: %s monitor summary\n", cmdl->argv[0]);
+		return 0;
 	}
 
 	nlh = msg_init(TIPC_NL_MON_GET);
@@ -1052,23 +1052,23 @@ static int link_mon_list_cb(const struct nlmsghdr *nlh, void *data)
 	return MNL_CB_OK;
 }
 
-static void cmd_link_mon_list_help(struct cmdl *cmdl)
+static void cmd_link_mon_list_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s monitor list [ media MEDIA ARGS...]\n\n",
+	fprintf(out, "Usage: %s monitor list [ media MEDIA ARGS...]\n\n",
 		cmdl->argv[0]);
-	print_bearer_media();
+	print_bearer_media(out);
 }
 
-static void cmd_link_mon_list_l2_help(struct cmdl *cmdl, char *media)
+static void cmd_link_mon_list_l2_help(FILE *out, struct cmdl *cmdl, char *media)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s monitor list media %s device DEVICE [OPTIONS]\n",
 		cmdl->argv[0], media);
 }
 
-static void cmd_link_mon_list_udp_help(struct cmdl *cmdl, char *media)
+static void cmd_link_mon_list_udp_help(FILE *out, struct cmdl *cmdl, char *media)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s monitor list media udp name NAME\n\n",
 		cmdl->argv[0]);
 }
@@ -1096,15 +1096,15 @@ static int cmd_link_mon_list(struct nlmsghdr *nlh, const struct cmd *cmd,
 		return -EINVAL;
 
 	if (get_opt(opts, "media")) {
-		err = cmd_get_unique_bearer_name(cmd, cmdl, opts, bname,
+		err = cmd_get_unique_bearer_name(help_flag ? stdout : stderr, cmd, cmdl, opts, bname,
 						 sup_media);
 		if (err)
 			return err;
 	}
 
 	if (help_flag) {
-		cmd->help(cmdl);
-		return -EINVAL;
+		cmd->help(stdout, cmdl);
+		return 0;
 	}
 
 	nlh = msg_init(TIPC_NL_MON_GET);
@@ -1119,9 +1119,9 @@ static int cmd_link_mon_list(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return err;
 }
 
-static void cmd_link_mon_set_help(struct cmdl *cmdl)
+static void cmd_link_mon_set_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s monitor set PPROPERTY\n\n"
+	fprintf(out, "Usage: %s monitor set PROPERTY\n\n"
 		"PROPERTIES\n"
 		" threshold SIZE	- Set monitor activation threshold\n",
 		cmdl->argv[0]);
@@ -1131,16 +1131,16 @@ static int cmd_link_mon_set(struct nlmsghdr *nlh, const struct cmd *cmd,
 			    struct cmdl *cmdl, void *data)
 {
 	const struct cmd cmds[] = {
-		{ "threshold",	cmd_link_mon_set_prop,	NULL },
+		{ "threshold",	cmd_link_mon_set_prop,	cmd_link_mon_set_help },
 		{ NULL }
 	};
 
 	return run_cmd(nlh, cmd, cmds, cmdl, NULL);
 }
 
-static void cmd_link_mon_get_help(struct cmdl *cmdl)
+static void cmd_link_mon_get_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s monitor get PPROPERTY\n\n"
+	fprintf(out, "Usage: %s monitor get PROPERTY\n\n"
 		"PROPERTIES\n"
 		" threshold	- Get monitor activation threshold\n",
 		cmdl->argv[0]);
@@ -1171,6 +1171,10 @@ static int link_mon_get_cb(const struct nlmsghdr *nlh, void *data)
 static int cmd_link_mon_get_prop(struct nlmsghdr *nlh, const struct cmd *cmd,
 				 struct cmdl *cmdl, void *data)
 {
+	if (help_flag) {
+		(cmd->help)(stdout, cmdl);
+		return 0;
+	}
 
 	nlh = msg_init(TIPC_NL_MON_GET);
 	if (!nlh) {
@@ -1185,17 +1189,17 @@ static int cmd_link_mon_get(struct nlmsghdr *nlh, const struct cmd *cmd,
 			    struct cmdl *cmdl, void *data)
 {
 	const struct cmd cmds[] = {
-		{ "threshold",	cmd_link_mon_get_prop,	NULL},
+		{ "threshold",	cmd_link_mon_get_prop,	cmd_link_mon_get_help},
 		{ NULL }
 	};
 
 	return run_cmd(nlh, cmd, cmds, cmdl, NULL);
 }
 
-static void cmd_link_mon_help(struct cmdl *cmdl)
+static void cmd_link_mon_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
-		"Usage: %s montior COMMAND [ARGS] ...\n\n"
+	fprintf(out,
+		"Usage: %s monitor COMMAND [ARGS] ...\n\n"
 		"COMMANDS\n"
 		" set			- Set monitor properties\n"
 		" get			- Get monitor properties\n"
@@ -1218,9 +1222,9 @@ static int cmd_link_mon(struct nlmsghdr *nlh, const struct cmd *cmd, struct cmdl
 	return run_cmd(nlh, cmd, cmds, cmdl, NULL);
 }
 
-void cmd_link_help(struct cmdl *cmdl)
+void cmd_link_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s link COMMAND [ARGS] ...\n"
 		"\n"
 		"COMMANDS\n"
diff --git a/tipc/link.h b/tipc/link.h
index a0d46035..09e47b89 100644
--- a/tipc/link.h
+++ b/tipc/link.h
@@ -8,10 +8,10 @@
 #ifndef _TIPC_LINK_H
 #define _TIPC_LINK_H
 
-extern int help_flag;
+#include <stdio.h>
 
 int cmd_link(struct nlmsghdr *nlh, const struct cmd *cmd, struct cmdl *cmdl,
 	     void *data);
-void cmd_link_help(struct cmdl *cmdl);
+void cmd_link_help(FILE *out, struct cmdl *cmdl);
 
 #endif
diff --git a/tipc/media.c b/tipc/media.c
index 5ff0c8c4..82ce5145 100644
--- a/tipc/media.c
+++ b/tipc/media.c
@@ -40,8 +40,8 @@ static int cmd_media_list(struct nlmsghdr *nlh, const struct cmd *cmd,
 			 struct cmdl *cmdl, void *data)
 {
 	if (help_flag) {
-		fprintf(stderr, "Usage: %s media list\n", cmdl->argv[0]);
-		return -EINVAL;
+		fprintf(stdout, "Usage: %s media list\n", cmdl->argv[0]);
+		return 0;
 	}
 
 	nlh = msg_init(TIPC_NL_MEDIA_GET);
@@ -101,8 +101,8 @@ static int cmd_media_get_prop(struct nlmsghdr *nlh, const struct cmd *cmd,
 		return -EINVAL;
 
 	if (help_flag) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
 	if (parse_opts(opts, cmdl) < 0)
@@ -131,9 +131,9 @@ static int cmd_media_get_prop(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return msg_doit(nlh, media_get_cb, &prop);
 }
 
-static void cmd_media_get_help(struct cmdl *cmdl)
+static void cmd_media_get_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s media get PPROPERTY media MEDIA\n\n"
+	fprintf(out, "Usage: %s media get PPROPERTY media MEDIA\n\n"
 		"PROPERTIES\n"
 		" tolerance             - Get media tolerance\n"
 		" priority              - Get media priority\n"
@@ -156,9 +156,9 @@ static int cmd_media_get(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return run_cmd(nlh, cmd, cmds, cmdl, NULL);
 }
 
-static void cmd_media_set_help(struct cmdl *cmdl)
+static void cmd_media_set_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s media set PPROPERTY media MEDIA\n\n"
+	fprintf(out, "Usage: %s media set PPROPERTY media MEDIA\n\n"
 		"PROPERTIES\n"
 		" tolerance TOLERANCE   - Set media tolerance\n"
 		" priority PRIORITY     - Set media priority\n"
@@ -192,8 +192,8 @@ static int cmd_media_set_prop(struct nlmsghdr *nlh, const struct cmd *cmd,
 		return -EINVAL;
 
 	if (help_flag) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
 	if (cmdl->optind >= cmdl->argc) {
@@ -247,9 +247,9 @@ static int cmd_media_set(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return run_cmd(nlh, cmd, cmds, cmdl, NULL);
 }
 
-void cmd_media_help(struct cmdl *cmdl)
+void cmd_media_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s media COMMAND [ARGS] ...\n"
 		"\n"
 		"Commands:\n"
diff --git a/tipc/media.h b/tipc/media.h
index f1b4b540..eb4374dd 100644
--- a/tipc/media.h
+++ b/tipc/media.h
@@ -8,10 +8,10 @@
 #ifndef _TIPC_MEDIA_H
 #define _TIPC_MEDIA_H
 
-extern int help_flag;
+#include <stdio.h>
 
 int cmd_media(struct nlmsghdr *nlh, const struct cmd *cmd, struct cmdl *cmdl,
 	     void *data);
-void cmd_media_help(struct cmdl *cmdl);
+void cmd_media_help(FILE *out, struct cmdl *cmdl);
 
 #endif
diff --git a/tipc/nametable.c b/tipc/nametable.c
index 5162f7fc..1ede1024 100644
--- a/tipc/nametable.c
+++ b/tipc/nametable.c
@@ -80,8 +80,8 @@ static int cmd_nametable_show(struct nlmsghdr *nlh, const struct cmd *cmd,
 	int rc = 0;
 
 	if (help_flag) {
-		fprintf(stderr, "Usage: %s nametable show\n", cmdl->argv[0]);
-		return -EINVAL;
+		fprintf(stdout, "Usage: %s nametable show\n", cmdl->argv[0]);
+		return 0;
 	}
 
 	nlh = msg_init(TIPC_NL_NAME_TABLE_GET);
@@ -97,9 +97,9 @@ static int cmd_nametable_show(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return rc;
 }
 
-void cmd_nametable_help(struct cmdl *cmdl)
+void cmd_nametable_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s nametable COMMAND\n\n"
 		"COMMANDS\n"
 		" show                  - Show nametable\n",
diff --git a/tipc/nametable.h b/tipc/nametable.h
index c4df8d9d..e84227ed 100644
--- a/tipc/nametable.h
+++ b/tipc/nametable.h
@@ -8,9 +8,9 @@
 #ifndef _TIPC_NAMETABLE_H
 #define _TIPC_NAMETABLE_H
 
-extern int help_flag;
+#include <stdio.h>
 
-void cmd_nametable_help(struct cmdl *cmdl);
+void cmd_nametable_help(FILE *out, struct cmdl *cmdl);
 int cmd_nametable(struct nlmsghdr *nlh, const struct cmd *cmd, struct cmdl *cmdl,
 		  void *data);
 
diff --git a/tipc/node.c b/tipc/node.c
index b84a3fa1..77abc185 100644
--- a/tipc/node.c
+++ b/tipc/node.c
@@ -48,8 +48,8 @@ static int cmd_node_list(struct nlmsghdr *nlh, const struct cmd *cmd,
 			 struct cmdl *cmdl, void *data)
 {
 	if (help_flag) {
-		fprintf(stderr, "Usage: %s node list\n", cmdl->argv[0]);
-		return -EINVAL;
+		fprintf(stdout, "Usage: %s node list\n", cmdl->argv[0]);
+		return 0;
 	}
 
 	nlh = msg_init(TIPC_NL_NODE_GET);
@@ -68,6 +68,11 @@ static int cmd_node_set_addr(struct nlmsghdr *nlh, const struct cmd *cmd,
 	uint32_t addr;
 	struct nlattr *nest;
 
+	if (help_flag) {
+		fprintf(stdout, "Usage: %s node set address ADDRESS\n", cmdl->argv[0]);
+		return 0;
+	}
+
 	if (cmdl->argc != cmdl->optind + 1) {
 		fprintf(stderr, "Usage: %s node set address ADDRESS\n",
 			cmdl->argv[0]);
@@ -126,6 +131,11 @@ static int cmd_node_set_nodeid(struct nlmsghdr *nlh, const struct cmd *cmd,
 	struct nlattr *nest;
 	char *str;
 
+	if (help_flag) {
+		fprintf(stdout, "Usage: %s node set nodeid NODE_ID\n", cmdl->argv[0]);
+		return 0;
+	}
+
 	if (cmdl->argc != cmdl->optind + 1) {
 		fprintf(stderr, "Usage: %s node set nodeid NODE_ID\n",
 			cmdl->argv[0]);
@@ -150,9 +160,9 @@ static int cmd_node_set_nodeid(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return msg_doit(nlh, NULL, NULL);
 }
 
-static void cmd_node_set_key_help(struct cmdl *cmdl)
+static void cmd_node_set_key_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s node set key KEY [algname ALGNAME] [PROPERTIES]\n"
 		"       %s node set key rekeying REKEYING\n\n"
 		"KEY\n"
@@ -201,8 +211,8 @@ static int cmd_node_set_key(struct nlmsghdr *nlh, const struct cmd *cmd,
 	char *str;
 
 	if (help_flag || cmdl->optind >= cmdl->argc) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(help_flag ? stdout : stderr, cmdl);
+		return help_flag ? 0 : -EINVAL;
 	}
 
 	/* Check if command starts with opts i.e. "rekeying" opt without key */
@@ -285,8 +295,8 @@ static int cmd_node_flush_key(struct nlmsghdr *nlh, const struct cmd *cmd,
 			      struct cmdl *cmdl, void *data)
 {
 	if (help_flag) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
 	/* Init & do the command */
@@ -328,8 +338,8 @@ static int cmd_node_get_nodeid(struct nlmsghdr *nlh, const struct cmd *cmd,
 			       struct cmdl *cmdl, void *data)
 {
 	if (help_flag) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
 	nlh = msg_init(TIPC_NL_NET_GET);
@@ -364,8 +374,8 @@ static int cmd_node_get_netid(struct nlmsghdr *nlh, const struct cmd *cmd,
 			      struct cmdl *cmdl, void *data)
 {
 	if (help_flag) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
 	nlh = msg_init(TIPC_NL_NET_GET);
@@ -384,8 +394,8 @@ static int cmd_node_set_netid(struct nlmsghdr *nlh, const struct cmd *cmd,
 	struct nlattr *nest;
 
 	if (help_flag) {
-		(cmd->help)(cmdl);
-		return -EINVAL;
+		(cmd->help)(stdout, cmdl);
+		return 0;
 	}
 
 	nlh = msg_init(TIPC_NL_NET_SET);
@@ -408,9 +418,9 @@ static int cmd_node_set_netid(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return msg_doit(nlh, NULL, NULL);
 }
 
-static void cmd_node_flush_help(struct cmdl *cmdl)
+static void cmd_node_flush_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s node flush PROPERTY\n\n"
 		"PROPERTIES\n"
 		" key                   - Flush all symmetric-keys\n",
@@ -428,9 +438,9 @@ static int cmd_node_flush(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return run_cmd(nlh, cmd, cmds, cmdl, NULL);
 }
 
-static void cmd_node_set_help(struct cmdl *cmdl)
+static void cmd_node_set_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s node set PROPERTY\n\n"
 		"PROPERTIES\n"
 		" identity NODEID       - Set node identity\n"
@@ -454,9 +464,9 @@ static int cmd_node_set(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return run_cmd(nlh, cmd, cmds, cmdl, NULL);
 }
 
-static void cmd_node_get_help(struct cmdl *cmdl)
+static void cmd_node_get_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s node get PROPERTY\n\n"
 		"PROPERTIES\n"
 		" identity              - Get node identity\n"
@@ -478,9 +488,9 @@ static int cmd_node_get(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return run_cmd(nlh, cmd, cmds, cmdl, NULL);
 }
 
-void cmd_node_help(struct cmdl *cmdl)
+void cmd_node_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s node COMMAND [ARGS] ...\n\n"
 		"COMMANDS\n"
 		" list                  - List remote nodes\n"
diff --git a/tipc/node.h b/tipc/node.h
index 4a986d07..7d310897 100644
--- a/tipc/node.h
+++ b/tipc/node.h
@@ -8,10 +8,10 @@
 #ifndef _TIPC_NODE_H
 #define _TIPC_NODE_H
 
-extern int help_flag;
+#include <stdio.h>
 
 int cmd_node(struct nlmsghdr *nlh, const struct cmd *cmd, struct cmdl *cmdl,
 	     void *data);
-void cmd_node_help(struct cmdl *cmdl);
+void cmd_node_help(FILE *out, struct cmdl *cmdl);
 
 #endif
diff --git a/tipc/peer.c b/tipc/peer.c
index 5a583fb9..6d12fb19 100644
--- a/tipc/peer.c
+++ b/tipc/peer.c
@@ -27,9 +27,9 @@ static int cmd_peer_rm_addr(struct nlmsghdr *nlh, const struct cmd *cmd,
 	struct nlattr *nest;
 
 	if ((cmdl->argc != cmdl->optind + 1) || help_flag) {
-		fprintf(stderr, "Usage: %s peer remove address ADDRESS\n",
+		fprintf(help_flag ? stdout : stderr, "Usage: %s peer remove address ADDRESS\n",
 			cmdl->argv[0]);
-		return -EINVAL;
+		return help_flag ? 0 : -EINVAL;
 	}
 
 	str = shift_cmdl(cmdl);
@@ -63,10 +63,10 @@ static int cmd_peer_rm_nodeid(struct nlmsghdr *nlh, const struct cmd *cmd,
 	struct nlattr *nest;
 	char *str;
 
-	if (cmdl->argc != cmdl->optind + 1) {
-		fprintf(stderr, "Usage: %s peer remove identity NODEID\n",
+	if ((cmdl->argc != cmdl->optind + 1) || help_flag) {
+		fprintf(help_flag ? stdout : stderr, "Usage: %s peer remove identity NODEID\n",
 			cmdl->argv[0]);
-		return -EINVAL;
+		return help_flag ? 0 : -EINVAL;
 	}
 
 	str = shift_cmdl(cmdl);
@@ -89,23 +89,23 @@ static int cmd_peer_rm_nodeid(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return msg_doit(nlh, NULL, NULL);
 }
 
-static void cmd_peer_rm_help(struct cmdl *cmdl)
+static void cmd_peer_rm_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s peer remove PROPERTY\n\n"
+	fprintf(out, "Usage: %s peer remove PROPERTY\n\n"
 		"PROPERTIES\n"
 		" identity NODEID         - Remove peer node identity\n",
 		cmdl->argv[0]);
 }
 
-static void cmd_peer_rm_addr_help(struct cmdl *cmdl)
+static void cmd_peer_rm_addr_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s peer remove address ADDRESS\n",
+	fprintf(out, "Usage: %s peer remove address ADDRESS\n",
 		cmdl->argv[0]);
 }
 
-static void cmd_peer_rm_nodeid_help(struct cmdl *cmdl)
+static void cmd_peer_rm_nodeid_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr, "Usage: %s peer remove identity NODEID\n",
+	fprintf(out, "Usage: %s peer remove identity NODEID\n",
 		cmdl->argv[0]);
 }
 
@@ -121,9 +121,9 @@ static int cmd_peer_rm(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return run_cmd(nlh, cmd, cmds, cmdl, NULL);
 }
 
-void cmd_peer_help(struct cmdl *cmdl)
+void cmd_peer_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s peer COMMAND [ARGS] ...\n\n"
 		"COMMANDS\n"
 		" remove                - Remove an offline peer node\n",
diff --git a/tipc/peer.h b/tipc/peer.h
index 2bd0a2a3..8a2374cf 100644
--- a/tipc/peer.h
+++ b/tipc/peer.h
@@ -8,10 +8,10 @@
 #ifndef _TIPC_PEER_H
 #define _TIPC_PEER_H
 
-extern int help_flag;
+#include <stdio.h>
 
 int cmd_peer(struct nlmsghdr *nlh, const struct cmd *cmd, struct cmdl *cmdl,
 	     void *data);
-void cmd_peer_help(struct cmdl *cmdl);
+void cmd_peer_help(FILE *out, struct cmdl *cmdl);
 
 #endif
diff --git a/tipc/socket.c b/tipc/socket.c
index 4d376e07..bf2147cb 100644
--- a/tipc/socket.c
+++ b/tipc/socket.c
@@ -112,8 +112,8 @@ static int cmd_socket_list(struct nlmsghdr *nlh, const struct cmd *cmd,
 			   struct cmdl *cmdl, void *data)
 {
 	if (help_flag) {
-		fprintf(stderr, "Usage: %s socket list\n", cmdl->argv[0]);
-		return -EINVAL;
+		fprintf(stdout, "Usage: %s socket list\n", cmdl->argv[0]);
+		return 0;
 	}
 
 	nlh = msg_init(TIPC_NL_SOCK_GET);
@@ -125,9 +125,9 @@ static int cmd_socket_list(struct nlmsghdr *nlh, const struct cmd *cmd,
 	return msg_dumpit(nlh, sock_list_cb, NULL);
 }
 
-void cmd_socket_help(struct cmdl *cmdl)
+void cmd_socket_help(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: %s socket COMMAND\n\n"
 		"Commands:\n"
 		" list                  - List sockets (ports)\n",
diff --git a/tipc/socket.h b/tipc/socket.h
index c4341bb2..207b8666 100644
--- a/tipc/socket.h
+++ b/tipc/socket.h
@@ -8,9 +8,9 @@
 #ifndef _TIPC_SOCKET_H
 #define _TIPC_SOCKET_H
 
-extern int help_flag;
+#include <stdio.h>
 
-void cmd_socket_help(struct cmdl *cmdl);
+void cmd_socket_help(FILE *out, struct cmdl *cmdl);
 int cmd_socket(struct nlmsghdr *nlh, const struct cmd *cmd, struct cmdl *cmdl,
 		  void *data);
 
diff --git a/tipc/tipc.c b/tipc/tipc.c
index 56af052c..733acb50 100644
--- a/tipc/tipc.c
+++ b/tipc/tipc.c
@@ -28,9 +28,9 @@ int help_flag;
 int json;
 struct mnlu_gen_socket tipc_nlg;
 
-static void about(struct cmdl *cmdl)
+static void about(FILE *out, struct cmdl *cmdl)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Transparent Inter-Process Communication Protocol\n"
 		"Usage: %s [OPTIONS] COMMAND [ARGS] ...\n"
 		"\n"
@@ -111,20 +111,24 @@ int main(int argc, char *argv[])
 	cmdl.argc = argc;
 	cmdl.argv = argv;
 
-	res = mnlu_gen_socket_open(&tipc_nlg, TIPC_GENL_V2_NAME,
-				   TIPC_GENL_V2_VERSION);
-	if (res) {
-		fprintf(stderr,
-			"Unable to get TIPC nl family id (module loaded?)\n");
-		return -1;
+	if (!help_flag) {
+		res = mnlu_gen_socket_open(&tipc_nlg, TIPC_GENL_V2_NAME,
+					   TIPC_GENL_V2_VERSION);
+		if (res) {
+			fprintf(stderr,
+				"Unable to get TIPC nl family id (module loaded?)\n");
+			return -1;
+		}
 	}
 
 	res = run_cmd(NULL, &cmd, cmds, &cmdl, &tipc_nlg);
 	if (res != 0) {
-		mnlu_gen_socket_close(&tipc_nlg);
-		return -1;
+		if (!help_flag)
+			mnlu_gen_socket_close(&tipc_nlg);
+		return help_flag ? 0 : -1;
 	}
 
-	mnlu_gen_socket_close(&tipc_nlg);
+	if (!help_flag)
+		mnlu_gen_socket_close(&tipc_nlg);
 	return 0;
 }
diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
index e2b0a5b1..550443e6 100644
--- a/vdpa/vdpa.c
+++ b/vdpa/vdpa.c
@@ -1051,9 +1051,9 @@ static int cmd_dev(struct vdpa *vdpa, int argc, char **argv)
 	return -ENOENT;
 }
 
-static void help(void)
+static void help(FILE *out)
 {
-	fprintf(stderr,
+	fprintf(out,
 		"Usage: vdpa [ OPTIONS ] OBJECT { COMMAND | help }\n"
 		"where  OBJECT := { mgmtdev | dev }\n"
 		"       OPTIONS := { -V[ersion] | -n[o-nice-names] | -j[son] | -p[retty] }\n");
@@ -1061,8 +1061,11 @@ static void help(void)
 
 static int vdpa_cmd(struct vdpa *vdpa, int argc, char **argv)
 {
-	if (!argc || matches(*argv, "help") == 0) {
-		help();
+	if (!argc) {
+		help(stderr);
+		return -EINVAL;
+	} else if (matches(*argv, "help") == 0) {
+		help(stdout);
 		return 0;
 	} else if (matches(*argv, "mgmtdev") == 0) {
 		return cmd_mgmtdev(vdpa, argc - 1, argv + 1);
@@ -1127,6 +1130,7 @@ int main(int argc, char **argv)
 		{ NULL, 0, NULL, 0 }
 	};
 	struct vdpa *vdpa;
+	bool need_nl = true;
 	int opt;
 	int err;
 	int ret;
@@ -1150,12 +1154,12 @@ int main(int argc, char **argv)
 			pretty = true;
 			break;
 		case 'h':
-			help();
+			help(stdout);
 			ret = EXIT_SUCCESS;
 			goto vdpa_free;
 		default:
 			fprintf(stderr, "Unknown option.\n");
-			help();
+			help(stderr);
 			ret = EXIT_FAILURE;
 			goto vdpa_free;
 		}
@@ -1164,10 +1168,23 @@ int main(int argc, char **argv)
 	argc -= optind;
 	argv += optind;
 
-	err = vdpa_init(vdpa);
-	if (err) {
-		ret = EXIT_FAILURE;
-		goto vdpa_free;
+	if (argc > 0 && (strcmp(argv[0], "help") == 0 ||
+			 strcmp(argv[0], "-h") == 0 ||
+			 strcmp(argv[0], "--help") == 0))
+		need_nl = false;
+	
+	if (argc > 1 && (strcmp(argv[1], "help") == 0 ||
+			 strcmp(argv[1], "-h") == 0 ||
+			 strcmp(argv[1], "--help") == 0))
+		need_nl = false;
+
+
+	if (need_nl) {
+		err = vdpa_init(vdpa);
+		if (err) {
+			ret = EXIT_FAILURE;
+			goto vdpa_free;
+		}
 	}
 
 	err = vdpa_cmd(vdpa, argc, argv);
@@ -1179,7 +1196,8 @@ int main(int argc, char **argv)
 	ret = EXIT_SUCCESS;
 
 vdpa_fini:
-	vdpa_fini(vdpa);
+	if (need_nl)
+		vdpa_fini(vdpa);
 vdpa_free:
 	vdpa_free(vdpa);
 	return ret;
-- 
2.54.0


