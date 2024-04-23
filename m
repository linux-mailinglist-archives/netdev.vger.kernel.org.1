Return-Path: <netdev+bounces-90611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7118AF37D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 18:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDD31C236A0
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56D713CAA2;
	Tue, 23 Apr 2024 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="vQprFO8m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E5313CA85
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888425; cv=none; b=WqNtoPW4zSFfG3D7BMqKQs523ZJwNz8M5DVaxjEZjFjVjPuDoRqOwcf/y0oZKwLijcFjhrYNjD3EEPifypM+bYwhAP/WD298i6ZUmv27PMllA2Nf0uPqvdgZzOoOBFCL8OZS51CmcxzmSEbLVGdk2+bCKOrB22upY5s/X5e4w6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888425; c=relaxed/simple;
	bh=15ljKbv4cbUEjCZg64vWyrYTBVv3afRPyXXfsAG0AVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqGvqeamcWFarvLyDxjr9y7OLX9zjrtqUGUheaRGnPfgKz5bOK2sJN5711lUZERCgj7wrcbLxEDcO3lmYJ1XgjZMA/9lF6jRgJ0mB4tUzrWqqgjE9Xd4u+VZTHHUB5B8QUE1C4uh1RdU2e0w6HvU4BGHnGSG488MPhYJoF0pFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=vQprFO8m; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e3ff14f249so41933305ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713888423; x=1714493223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ccAK0tLMg2IaHIQtL66bvw8V/SrcoGcoIlZN6/xzeoI=;
        b=vQprFO8mqx6alxh9cHC+5L/c1avPwhl7Z/s6XbgOFhfo13P7o+DsWd2pcrr/3J6upY
         iuRwNgExdYdRMU+AmF1z9BFr4+jcrZGhrFaTumDNR7YVZsNx3NTp4zglJ1fBby++lzAJ
         Ns2wsB4TSXNBOQEWH2Z3J63VYSNosMMdtNRI2y4ERnxTFSb4qFgbwfTtJrKuwC1oSCuB
         QYwCWNaBzHuX68xDP95ck9Wx1ZHTBFKUMbwS4s7ii+tAlBy6p+XjiPloKvP2CGZyeqBd
         qC+9Ps0a6/OqLl+gKwABC3ziG7JatOmATMcM+oOGXKVcWXxre+fVhQ7eNmuXLJgeaJyt
         iAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713888423; x=1714493223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccAK0tLMg2IaHIQtL66bvw8V/SrcoGcoIlZN6/xzeoI=;
        b=pj77AXXnoBaHwrlXgJbugesrb0TUv1JFamRyDIZR6AaFsJLbI63ydShe0X5Ohc2+V+
         /3MZ8tzpSjMnt1GwlB2YYrONXjvhQwYWBKNGWzfB18M2t8Ao1ois2/UaxHqUefjP+U9B
         r/nDZiZ9548izvbO/uKNpSbh78Urlzv9uBmUxhUebXk0fySGZ2jAyzhmo3SaeI90XMam
         SZnQzotRH38RNjibOUt3iQbwO8SdC5uhz893o7kbK8KXCfvGjKbEpaxg9kyO6iU3iQQX
         ZDIedsVG5PoOg4OD2ah1UzNt0OwNfRXteaOxfSwyufAEcJ9hIxI5+DI6MdUZWwsoSp6E
         qrcw==
X-Gm-Message-State: AOJu0YyOKxLRxddk3B4magbJOIF8K/kx9Mb4vwEhT1VotcKdfmMM8N04
	eB3l/gToSpTmtklL/WtnT6vt5ycuf3h6ckql6Cq/szQCCHSPQLx4QO3BzSmt5PSPA84cGReo5a2
	+xrM=
X-Google-Smtp-Source: AGHT+IG6X6zcceYN5OUIENQojIwiVMue9NqejySPiPYCPwww1Z8xYboR7nw/XMUeoVErsdpVgNNG0A==
X-Received: by 2002:a17:903:2310:b0:1e2:bdef:3973 with SMTP id d16-20020a170903231000b001e2bdef3973mr3713376plh.33.1713888422655;
        Tue, 23 Apr 2024 09:07:02 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001e41e968a61sm10190379plf.223.2024.04.23.09.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 09:07:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] use missing argument helper
Date: Tue, 23 Apr 2024 09:05:43 -0700
Message-ID: <20240423160652.68304-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a helper in utilities to handle missing argument,
but it was not being used consistently.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/ip.c               | 10 +++++-----
 ip/iproute_lwtunnel.c |  7 ++-----
 ip/rtmon.c            |  4 ++--
 tc/f_u32.c            |  2 +-
 tc/m_sample.c         |  7 ++-----
 tc/tc.c               |  2 +-
 6 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/ip/ip.c b/ip/ip.c
index e51fa206..eb492139 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -203,15 +203,15 @@ int main(int argc, char **argv)
 			argc--;
 			argv++;
 			if (argc <= 1)
-				usage();
+				missarg("loop count");
 			max_flush_loops = atoi(argv[1]);
 		} else if (matches(opt, "-family") == 0) {
 			argc--;
 			argv++;
 			if (argc <= 1)
-				usage();
+				missarg("family type");
 			if (strcmp(argv[1], "help") == 0)
-				usage();
+				do_help(argc, argv);
 			else
 				preferred_family = read_family(argv[1]);
 			if (preferred_family == AF_UNSPEC)
@@ -258,7 +258,7 @@ int main(int argc, char **argv)
 			argc--;
 			argv++;
 			if (argc <= 1)
-				usage();
+				missarg("batch file");
 			batch_file = argv[1];
 		} else if (matches(opt, "-brief") == 0) {
 			++brief;
@@ -272,7 +272,7 @@ int main(int argc, char **argv)
 			argc--;
 			argv++;
 			if (argc <= 1)
-				usage();
+				missarg("rcvbuf size");
 			if (get_unsigned(&size, argv[1], 0)) {
 				fprintf(stderr, "Invalid rcvbuf size '%s'\n",
 					argv[1]);
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 94985972..b4df4348 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -2228,11 +2228,8 @@ int lwt_parse_encap(struct rtattr *rta, size_t len, int *argcp, char ***argvp,
 		invarg("\"encap type\" value is invalid\n", *argv);
 
 	NEXT_ARG();
-	if (argc <= 1) {
-		fprintf(stderr,
-			"Error: unexpected end of line after \"encap\"\n");
-		exit(-1);
-	}
+	if (argc <= 1)
+		missarg("encap type");
 
 	nest = rta_nest(rta, len, encap_attr);
 	switch (type) {
diff --git a/ip/rtmon.c b/ip/rtmon.c
index aad9968f..08105d68 100644
--- a/ip/rtmon.c
+++ b/ip/rtmon.c
@@ -82,7 +82,7 @@ main(int argc, char **argv)
 			argc--;
 			argv++;
 			if (argc <= 1)
-				usage();
+				missarg("family type");
 			if (strcmp(argv[1], "inet") == 0)
 				family = AF_INET;
 			else if (strcmp(argv[1], "inet6") == 0)
@@ -108,7 +108,7 @@ main(int argc, char **argv)
 			argc--;
 			argv++;
 			if (argc <= 1)
-				usage();
+				missarg("file");
 			file = argv[1];
 		} else if (matches(argv[1], "link") == 0) {
 			llink = 1;
diff --git a/tc/f_u32.c b/tc/f_u32.c
index a0699636..d7679e7a 100644
--- a/tc/f_u32.c
+++ b/tc/f_u32.c
@@ -663,7 +663,7 @@ static int parse_mark(int *argc_p, char ***argv_p, struct nlmsghdr *n)
 	struct tc_u32_mark mark;
 
 	if (argc <= 1)
-		return -1;
+		missarg("mark");
 
 	if (get_u32(&mark.val, *argv, 0)) {
 		fprintf(stderr, "Illegal \"mark\" value\n");
diff --git a/tc/m_sample.c b/tc/m_sample.c
index 642ec3a6..3baf1d55 100644
--- a/tc/m_sample.c
+++ b/tc/m_sample.c
@@ -45,11 +45,8 @@ static int parse_sample(const struct action_util *a, int *argc_p, char ***argv_p
 	__u32 group;
 	__u32 rate;
 
-	if (argc <= 1) {
-		fprintf(stderr, "sample bad argument count %d\n", argc);
-		usage();
-		return -1;
-	}
+	if (argc <= 1)
+		missarg("sample count");
 
 	if (matches(*argv, "sample") == 0) {
 		NEXT_ARG();
diff --git a/tc/tc.c b/tc/tc.c
index 7edff7e3..26e6f69c 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -289,7 +289,7 @@ int main(int argc, char **argv)
 		} else if (matches(argv[1], "-batch") == 0) {
 			argc--;	argv++;
 			if (argc <= 1)
-				usage();
+				missarg("batch file");
 			batch_file = argv[1];
 		} else if (matches(argv[1], "-netns") == 0) {
 			NEXT_ARG();
-- 
2.43.0


