Return-Path: <netdev+bounces-70750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E918503CB
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 11:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564EAB22FEC
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F40136102;
	Sat, 10 Feb 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b="rFHSD/HV";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="o4HBeNZC"
X-Original-To: netdev@vger.kernel.org
Received: from e234-5.smtp-out.ap-northeast-1.amazonses.com (e234-5.smtp-out.ap-northeast-1.amazonses.com [23.251.234.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1FE36AE0
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707559687; cv=none; b=kmA1ztp5VKWHGYTEYmxUeSRiNa/T0pDqjb4A4jwECCoEFp50BQbbCHAlzXs13v8UP5V+Lvl5FFZianmvWaAnZJuqPTzbXk6z7qsQCtcXJWYeEFxF+v7vbo7NZQzJquZGWYWZEVN9oq+0r/+sFpwaIOZiYeC0JSv4xIAVTTkeF8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707559687; c=relaxed/simple;
	bh=/uYN3GyZy8gTWAYlxGA6RCTkOWu+2l0PSJMHg9X5I/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BC8C8QvWcHvecbDpLr5AwZpHu5vZEhvHVPz8EXlqG3KXcQdGu/pUYNIvE7545Isk4IxBF6IJ85b3RhKM36D8pdWzNxkUQdZ4QFu92OkiYmwmo8a5xJWVKUkiovrDhFP0pKE/K8jRF8eRfTWC0QF+A420d7qRGvEjUHBvm/eyGOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com; dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b=rFHSD/HV; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=o4HBeNZC; arc=none smtp.client-ip=23.251.234.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=otpfqkfjftndw3gmuo745xikcugpdsgy; d=hrntknr.net; t=1707559683;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/uYN3GyZy8gTWAYlxGA6RCTkOWu+2l0PSJMHg9X5I/0=;
	b=rFHSD/HVIts3YCPH5oZr8xxvm/PpWbGDjqKaOggfZJsNzjAa02qogzsm2qSJ+VkV
	EC9jZdoAFFaOsWc4NPSlFFycler2hZRV0TusQi5RvpaZjGXWt4QAIiHMdZ8Zh2BBZ/P
	gnDX0oUnEAT3qx/fAXuU+UuGLuRYOPCZqWGP6tmxm+3Eg2if8t4DQRpwy9C+U5HcDIR
	nLvEskna8x4XTPNThKOnS7jbL7+jQynqjJ8UepQFpvVWXR3pH9pwzq1ISwz1hXif295
	Zj45NeMAGejr5mv75bVEXLgm0O6xvlX4IeAk+Fu4kFgR43bn57ae6YFwSMH4VHvrMWU
	hG4R/TmgHw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1707559683;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=/uYN3GyZy8gTWAYlxGA6RCTkOWu+2l0PSJMHg9X5I/0=;
	b=o4HBeNZCQc6SqKuvVU9ZSdgOzti+cE9aYmkLQlyOZc4PV9VvHtPMeAxr/oLzLqTC
	7yvXdST7GTgz4SDgqE3ffjucCmhk/GKDIVVrZ8uMTvo+9Ozhw8/w1UxjaBqi5mIsZki
	SsZzLX66yOshq/AkdhKC/HsZgSl0wTRO92wCZp08=
From: Takanori Hirano <me@hrntknr.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Takanori Hirano <me@hrntknr.net>
Subject: [PATCH iproute2 v2] tc: Add support json option in filter.
Date: Sat, 10 Feb 2024 10:08:03 +0000
Message-ID: <0106018d927d04ff-efbd5d4b-b32f-4b39-a184-a28939608096-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209083743.2bd1a90d@hermes.local>
References: <20240209083743.2bd1a90d@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-northeast-1.rx1zlehJXIhTBJXf7/H1gLdwyBf0eKXp6+AKci1nnIg=:AmazonSES
X-SES-Outgoing: 2024.02.10-23.251.234.5

Add support for "-json" output in tc-fw, tc-cgroup, tc-flow, and tc-route.

Signed-off-by: Takanori Hirano <me@hrntknr.net>
---
Changes in v2:
- Fix terminology, in f_fw, handle -> fw
- Add json option support for tc-cgroup, tc-flow, and tc-route
---
 tc/f_cgroup.c |  4 ++--
 tc/f_flow.c   | 51 ++++++++++++++++++++++++++++++---------------------
 tc/f_fw.c     | 22 +++++++++++++++-------
 tc/f_route.c  | 38 ++++++++++++++++++++++++++++++--------
 4 files changed, 77 insertions(+), 38 deletions(-)

diff --git a/tc/f_cgroup.c b/tc/f_cgroup.c
index a4fc03d1..0b69db6d 100644
--- a/tc/f_cgroup.c
+++ b/tc/f_cgroup.c
@@ -86,13 +86,13 @@ static int cgroup_print_opt(struct filter_util *qu, FILE *f,
 	parse_rtattr_nested(tb, TCA_CGROUP_MAX, opt);
 
 	if (handle)
-		fprintf(f, "handle 0x%x ", handle);
+		print_0xhex(PRINT_ANY, "handle", "handle %#llx ", handle);
 
 	if (tb[TCA_CGROUP_EMATCHES])
 		print_ematch(f, tb[TCA_CGROUP_EMATCHES]);
 
 	if (tb[TCA_CGROUP_POLICE]) {
-		fprintf(f, "\n");
+		print_string(PRINT_FP, NULL, "\n", NULL);
 		tc_print_police(f, tb[TCA_CGROUP_POLICE]);
 	}
 
diff --git a/tc/f_flow.c b/tc/f_flow.c
index 2445aaef..1c9a636d 100644
--- a/tc/f_flow.c
+++ b/tc/f_flow.c
@@ -272,33 +272,37 @@ static int flow_print_opt(struct filter_util *fu, FILE *f, struct rtattr *opt,
 
 	parse_rtattr_nested(tb, TCA_FLOW_MAX, opt);
 
-	fprintf(f, "handle 0x%x ", handle);
+	print_0xhex(PRINT_ANY, "handle", "handle %#llx ", handle);
 
 	if (tb[TCA_FLOW_MODE]) {
 		__u32 mode = rta_getattr_u32(tb[TCA_FLOW_MODE]);
 
 		switch (mode) {
 		case FLOW_MODE_MAP:
-			fprintf(f, "map ");
+			open_json_object("map");
+			print_string(PRINT_FP, NULL, "map ", NULL);
 			break;
 		case FLOW_MODE_HASH:
-			fprintf(f, "hash ");
+			open_json_object("hash");
+			print_string(PRINT_FP, NULL, "hash ", NULL);
 			break;
 		}
 	}
 
 	if (tb[TCA_FLOW_KEYS]) {
 		__u32 keymask = rta_getattr_u32(tb[TCA_FLOW_KEYS]);
-		char *sep = "";
+		char *sep = " ";
 
-		fprintf(f, "keys ");
+		open_json_array(PRINT_ANY, "keys");
 		for (i = 0; i <= FLOW_KEY_MAX; i++) {
 			if (keymask & (1 << i)) {
-				fprintf(f, "%s%s", sep, flow_keys[i]);
+				print_string(PRINT_FP, NULL, "%s", sep);
+				print_string(PRINT_ANY, NULL, "%s",
+					     flow_keys[i]);
 				sep = ",";
 			}
 		}
-		fprintf(f, " ");
+		close_json_array(PRINT_ANY, " ");
 	}
 
 	if (tb[TCA_FLOW_MASK])
@@ -311,39 +315,44 @@ static int flow_print_opt(struct filter_util *fu, FILE *f, struct rtattr *opt,
 		__u32 xor = mask & val;
 
 		if (mask != ~0)
-			fprintf(f, "and 0x%.8x ", mask);
+			print_0xhex(PRINT_ANY, "and", "and 0x%.8x ", mask);
 		if (xor != 0)
-			fprintf(f, "xor 0x%.8x ", xor);
+			print_0xhex(PRINT_ANY, "xor", "xor 0x%.8x ", xor);
 		if (or != 0)
-			fprintf(f, "or 0x%.8x ", or);
+			print_0xhex(PRINT_ANY, "or", "or 0x%.8x ", or);
 	}
 
 	if (tb[TCA_FLOW_RSHIFT])
-		fprintf(f, "rshift %u ",
-			rta_getattr_u32(tb[TCA_FLOW_RSHIFT]));
+		print_uint(PRINT_ANY, "rshift", "rshift %u ",
+			   rta_getattr_u32(tb[TCA_FLOW_RSHIFT]));
 	if (tb[TCA_FLOW_ADDEND])
-		fprintf(f, "addend 0x%x ",
-			rta_getattr_u32(tb[TCA_FLOW_ADDEND]));
+		print_0xhex(PRINT_ANY, "addend", "addend 0x%x ",
+			    rta_getattr_u32(tb[TCA_FLOW_ADDEND]));
 
 	if (tb[TCA_FLOW_DIVISOR])
-		fprintf(f, "divisor %u ",
-			rta_getattr_u32(tb[TCA_FLOW_DIVISOR]));
+		print_uint(PRINT_ANY, "divisor", "divisor %u ",
+			   rta_getattr_u32(tb[TCA_FLOW_DIVISOR]));
 	if (tb[TCA_FLOW_BASECLASS])
-		fprintf(f, "baseclass %s ",
-			sprint_tc_classid(rta_getattr_u32(tb[TCA_FLOW_BASECLASS]), b1));
+		print_string(PRINT_ANY, "baseclass", "baseclass %s ",
+			     sprint_tc_classid(
+				     rta_getattr_u32(tb[TCA_FLOW_BASECLASS]),
+				     b1));
 
 	if (tb[TCA_FLOW_PERTURB])
-		fprintf(f, "perturb %usec ",
-			rta_getattr_u32(tb[TCA_FLOW_PERTURB]));
+		print_uint(PRINT_ANY, "perturb", "perturb %usec ",
+			   rta_getattr_u32(tb[TCA_FLOW_PERTURB]));
 
 	if (tb[TCA_FLOW_EMATCHES])
 		print_ematch(f, tb[TCA_FLOW_EMATCHES]);
 	if (tb[TCA_FLOW_POLICE])
 		tc_print_police(f, tb[TCA_FLOW_POLICE]);
 	if (tb[TCA_FLOW_ACT]) {
-		fprintf(f, "\n");
+		print_string(PRINT_FP, NULL, "\n", NULL);
 		tc_print_action(f, tb[TCA_FLOW_ACT], 0);
 	}
+	if (tb[TCA_FLOW_MODE]) {
+		close_json_object();
+	}
 	return 0;
 }
 
diff --git a/tc/f_fw.c b/tc/f_fw.c
index 38bec492..1af6b6a7 100644
--- a/tc/f_fw.c
+++ b/tc/f_fw.c
@@ -124,18 +124,25 @@ static int fw_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u
 	if (handle || tb[TCA_FW_MASK]) {
 		__u32 mark = 0, mask = 0;
 
+		open_json_object("fw");
 		if (handle)
 			mark = handle;
 		if (tb[TCA_FW_MASK] &&
-		    (mask = rta_getattr_u32(tb[TCA_FW_MASK])) != 0xFFFFFFFF)
-			fprintf(f, "handle 0x%x/0x%x ", mark, mask);
-		else
-			fprintf(f, "handle 0x%x ", handle);
+		    (mask = rta_getattr_u32(tb[TCA_FW_MASK])) != 0xFFFFFFFF) {
+			print_0xhex(PRINT_ANY, "mark", "handle 0x%x", mark);
+			print_0xhex(PRINT_ANY, "mask", "/0x%x ", mask);
+		} else {
+			print_0xhex(PRINT_ANY, "mark", "handle 0x%x ", mark);
+			print_0xhex(PRINT_JSON, "mask", NULL, 0xFFFFFFFF);
+		}
+		close_json_object();
 	}
 
 	if (tb[TCA_FW_CLASSID]) {
 		SPRINT_BUF(b1);
-		fprintf(f, "classid %s ", sprint_tc_classid(rta_getattr_u32(tb[TCA_FW_CLASSID]), b1));
+		print_string(PRINT_ANY, "classid", "classid %s ",
+			     sprint_tc_classid(
+				     rta_getattr_u32(tb[TCA_FW_CLASSID]), b1));
 	}
 
 	if (tb[TCA_FW_POLICE])
@@ -143,11 +150,12 @@ static int fw_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u
 	if (tb[TCA_FW_INDEV]) {
 		struct rtattr *idev = tb[TCA_FW_INDEV];
 
-		fprintf(f, "input dev %s ", rta_getattr_str(idev));
+		print_string(PRINT_ANY, "indev", "input dev %s ",
+			     rta_getattr_str(idev));
 	}
 
 	if (tb[TCA_FW_ACT]) {
-		fprintf(f, "\n");
+		print_string(PRINT_FP, NULL, "\n", "");
 		tc_print_action(f, tb[TCA_FW_ACT], 0);
 	}
 	return 0;
diff --git a/tc/f_route.c b/tc/f_route.c
index e92c7985..21ca7f75 100644
--- a/tc/f_route.c
+++ b/tc/f_route.c
@@ -146,20 +146,42 @@ static int route_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt,
 	parse_rtattr_nested(tb, TCA_ROUTE4_MAX, opt);
 
 	if (handle)
-		fprintf(f, "fh 0x%08x ", handle);
+		print_0xhex(PRINT_ANY, "fh", "fh 0x%08x ", handle);
 	if (handle&0x7F00)
-		fprintf(f, "order %d ", (handle>>8)&0x7F);
+		print_uint(PRINT_ANY, "order", "order %d ",
+			   (handle >> 8) & 0x7F);
 
 	if (tb[TCA_ROUTE4_CLASSID]) {
 		SPRINT_BUF(b1);
-		fprintf(f, "flowid %s ", sprint_tc_classid(rta_getattr_u32(tb[TCA_ROUTE4_CLASSID]), b1));
+		print_string(PRINT_ANY, "flowid", "flowid %s ",
+			     sprint_tc_classid(
+				     rta_getattr_u32(tb[TCA_ROUTE4_CLASSID]),
+				     b1));
+	}
+	if (tb[TCA_ROUTE4_TO]) {
+		open_json_object("to");
+		print_string(
+			PRINT_ANY, "name", "to %s ",
+			rtnl_rtrealm_n2a(rta_getattr_u32(tb[TCA_ROUTE4_TO]), b1,
+					 sizeof(b1)));
+		print_uint(PRINT_JSON, "id", NULL,
+			   rta_getattr_u32(tb[TCA_ROUTE4_TO]));
+		close_json_object();
+	}
+	if (tb[TCA_ROUTE4_FROM]) {
+		open_json_object("from");
+		print_string(
+			PRINT_ANY, "name", "from %s ",
+			rtnl_rtrealm_n2a(rta_getattr_u32(tb[TCA_ROUTE4_FROM]),
+					 b1, sizeof(b1)));
+		print_uint(PRINT_JSON, "id", NULL,
+			   rta_getattr_u32(tb[TCA_ROUTE4_FROM]));
+		close_json_object();
 	}
-	if (tb[TCA_ROUTE4_TO])
-		fprintf(f, "to %s ", rtnl_rtrealm_n2a(rta_getattr_u32(tb[TCA_ROUTE4_TO]), b1, sizeof(b1)));
-	if (tb[TCA_ROUTE4_FROM])
-		fprintf(f, "from %s ", rtnl_rtrealm_n2a(rta_getattr_u32(tb[TCA_ROUTE4_FROM]), b1, sizeof(b1)));
 	if (tb[TCA_ROUTE4_IIF])
-		fprintf(f, "fromif %s", ll_index_to_name(rta_getattr_u32(tb[TCA_ROUTE4_IIF])));
+		print_string(
+			PRINT_ANY, "fromif", "fromif %s",
+			ll_index_to_name(rta_getattr_u32(tb[TCA_ROUTE4_IIF])));
 	if (tb[TCA_ROUTE4_POLICE])
 		tc_print_police(f, tb[TCA_ROUTE4_POLICE]);
 	if (tb[TCA_ROUTE4_ACT])
-- 
2.34.1


