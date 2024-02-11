Return-Path: <netdev+bounces-70796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F9685078A
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 01:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984A61C21958
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 00:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0082E367;
	Sun, 11 Feb 2024 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b="pd7I6jEi";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="D8nDWF8f"
X-Original-To: netdev@vger.kernel.org
Received: from e234-6.smtp-out.ap-northeast-1.amazonses.com (e234-6.smtp-out.ap-northeast-1.amazonses.com [23.251.234.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8B15C4
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707613185; cv=none; b=fnqh4zFOzkxnomJ0hW0+yXppJkXTzr0qj/yFnfNncDCTsd4nvCFjj4WPcf1NaQWkd8eAFuSeHPxjQ2ZwNlBVj3qQrR9D+JMa5HaWkZyOX9IXX5bijqlGr228yLJ6oSWDN30K1FjPO7Mgjg/fPBmJozprC7ATBaFsBRCS0Jv7Kgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707613185; c=relaxed/simple;
	bh=FczTX707Oo5fkMsVXDOlaEnC8kqtC190HlVe4eFhBqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=br++21N1fO5GOlvjSshld2Vh3SOUcEOWbNbCvibFXFv3gHx4R6TSqngViWycoTRgzijFPm7ZD0sBzRQhi5vVpA2o3EQ+Vo8Bsm9nIgZ6TNFEyK47hOcvx2OTdR6g7ujdKosaF5mRJWo5QjRvB9fZk8opDbqS+AsSsMEMPZpnAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com; dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b=pd7I6jEi; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=D8nDWF8f; arc=none smtp.client-ip=23.251.234.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=otpfqkfjftndw3gmuo745xikcugpdsgy; d=hrntknr.net; t=1707613181;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FczTX707Oo5fkMsVXDOlaEnC8kqtC190HlVe4eFhBqQ=;
	b=pd7I6jEiDNFVwQ22dL3KiP4D9RcV13b+LgLpqRbv3TB4FcQwYT8DzJRFtmx4cud0
	82YrGGdtgH/kVnkps914p52jWXcrym6RbAY/qCOMNq1LAUWC1uxwqSrEfB9XIf7LhZo
	BN0456fwqduDmRkc8evOCWJEsawgFL/FyyQ9t46Mimglkj3oyNVpB2L+QiJEfPxUhfw
	CEzvY7AfZZC8DMld6BOX1+nuDcxRTm/nKCpeBjV+QMLbhR3QQhfPh357cUW7hBfFaT3
	EAlpjJbMU1PPINQI+7eitoaGcExTzxT+3et3hJ9yZ3uSCiNamS/VjfQMG70edk9mf1X
	t51NhkOr7w==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1707613181;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=FczTX707Oo5fkMsVXDOlaEnC8kqtC190HlVe4eFhBqQ=;
	b=D8nDWF8fT65JycV+Omp85hm0y2ZL4aILM+9hKMX6nKryUNokAJEimiGjjqCFzh2p
	iKjib1rEpIpsiOwPnhaiRBie9/mkzOoXF7MyrD87dJs2jK4w+UcpVou3feEpMRCtSj8
	xUAmyQnaKpqIeONKSYNaAIpQCXfBeQEmSAODJA2o=
From: Takanori Hirano <me@hrntknr.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Takanori Hirano <me@hrntknr.net>
Subject: [PATCH] tc: Support json option in tc-cgroup, tc-flow and tc-route
Date: Sun, 11 Feb 2024 00:59:41 +0000
Message-ID: <0106018d95ad56f9-e076853c-3bd4-485e-b2ab-ae85e1f0d65e-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240210092107.53598a13@hermes.local>
References: <20240210092107.53598a13@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-northeast-1.rx1zlehJXIhTBJXf7/H1gLdwyBf0eKXp6+AKci1nnIg=:AmazonSES
X-SES-Outgoing: 2024.02.11-23.251.234.6

Fix json corruption when using the "-json" option in some cases

Signed-off-by: Takanori Hirano <me@hrntknr.net>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/f_cgroup.c |  4 +--
 tc/f_flow.c   | 67 ++++++++++++++++++++++++++++++---------------------
 tc/f_route.c  | 38 +++++++++++++++++++++++------
 3 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/tc/f_cgroup.c b/tc/f_cgroup.c
index a4fc03d1..291d6e7e 100644
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
+		print_nl();
 		tc_print_police(f, tb[TCA_CGROUP_POLICE]);
 	}
 
diff --git a/tc/f_flow.c b/tc/f_flow.c
index 2445aaef..f37e360c 100644
--- a/tc/f_flow.c
+++ b/tc/f_flow.c
@@ -258,6 +258,21 @@ static int flow_parse_opt(struct filter_util *fu, char *handle,
 	return 0;
 }
 
+static const char *flow_mode2str(__u32 mode)
+{
+	static char buf[128];
+
+	switch (mode) {
+	case FLOW_MODE_MAP:
+		return "map";
+	case FLOW_MODE_HASH:
+		return "hash";
+	default:
+		snprintf(buf, sizeof(buf), "%#x", mode);
+		return buf;
+	}
+}
+
 static int flow_print_opt(struct filter_util *fu, FILE *f, struct rtattr *opt,
 			  __u32 handle)
 {
@@ -272,33 +287,27 @@ static int flow_print_opt(struct filter_util *fu, FILE *f, struct rtattr *opt,
 
 	parse_rtattr_nested(tb, TCA_FLOW_MAX, opt);
 
-	fprintf(f, "handle 0x%x ", handle);
+	print_0xhex(PRINT_ANY, "handle", "handle %#llx ", handle);
 
 	if (tb[TCA_FLOW_MODE]) {
 		__u32 mode = rta_getattr_u32(tb[TCA_FLOW_MODE]);
-
-		switch (mode) {
-		case FLOW_MODE_MAP:
-			fprintf(f, "map ");
-			break;
-		case FLOW_MODE_HASH:
-			fprintf(f, "hash ");
-			break;
-		}
+		print_string(PRINT_ANY, "mode", "%s ", flow_mode2str(mode));
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
@@ -311,37 +320,39 @@ static int flow_print_opt(struct filter_util *fu, FILE *f, struct rtattr *opt,
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
+		print_nl();
 		tc_print_action(f, tb[TCA_FLOW_ACT], 0);
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


