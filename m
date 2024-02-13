Return-Path: <netdev+bounces-71254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DBF852D63
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D44EB29DAC
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE522BB08;
	Tue, 13 Feb 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b="Fxje+HDQ";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="AwgNX+uM"
X-Original-To: netdev@vger.kernel.org
Received: from e234-4.smtp-out.ap-northeast-1.amazonses.com (e234-4.smtp-out.ap-northeast-1.amazonses.com [23.251.234.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD72BAFB
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818469; cv=none; b=kOsPdM3ayhBgSbNLNmyAbi28UkBWbOvwnQi+GoHclNM+1uKoLESmcg6GjZ553j8WuObDVBRG0bWyuKTCd0NL70pM6WiMbe5vkT/vZDdYkwvOIEySI7xop6hghwbfgIF6uVb+9CdsUgzU2vSE6OWp6LtQ5aDOc1HxIBAeNFJKvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818469; c=relaxed/simple;
	bh=6xTegrBQ0IAkippKdrJi3LHJh8yzucXUD9VBPnARGKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iefi2mvIS/cZnZpSbrOmGcl9li0qZIElN2hoMujdK8QYFOQZhwNohWXJKTt2N87eltugBo/Pmdz+uD6QvWQRAGmVxypwTaCv5MRa5Eyg9qF6mK6ZpPPE0txwXnLfdzqy8P7h2iI4Zu1Ls0K6ffKOqOwEcEdVpy6cARVmZzF5GOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com; dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b=Fxje+HDQ; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=AwgNX+uM; arc=none smtp.client-ip=23.251.234.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=otpfqkfjftndw3gmuo745xikcugpdsgy; d=hrntknr.net; t=1707818464;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6xTegrBQ0IAkippKdrJi3LHJh8yzucXUD9VBPnARGKM=;
	b=Fxje+HDQW/BTRU5sRd81o4EHowX7rPTQM00x6/sdu6eGmJR96waBMCHEFjuGTkdz
	mC8MSM4T1T+YRkE7/SaUdfueHAT08AKp42sxYDH6/J9FUHdWNIZ1YaAjx2y1Nj2yADD
	Yc+v0YKK8/NoLiNZ0UBTpt6PDZEOVuBnscFHLq8lIzVtHkfbOH2pUGT/I5bmEG9GPef
	WqHvODIXs9xvzPdCOVyyvZlaPMbA+XHrWs87KJyLkUmT606w3H/AL8STVyKysqyeoj8
	EKYumDgVrG4Awh1mtXy1y3GZoqlwdlubV9Nvw809SHfIBhScYhqpJjkLxjTaqXrWlkp
	7rJ7rIRnYA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1707818464;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=6xTegrBQ0IAkippKdrJi3LHJh8yzucXUD9VBPnARGKM=;
	b=AwgNX+uMhC6kDHsZyR0zs2O7L7zShUCdTeiZVjDB7aaJITvBXCCcdJqaTtmZwyJM
	258X6a29pXj03iBlPk9Wzp52ZeV+gLbGZAeBiM6qWL7Y65lYUgrq0JR5hKmRYmhRAfR
	CDnJaMVemkXwD+0O/exAaPLJBVrzYMaDSKXv8QV0=
From: Takanori Hirano <me@hrntknr.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Takanori Hirano <me@hrntknr.net>
Subject: [PATCH v2] tc: Support json option in tc-cgroup, tc-flow and tc-route
Date: Tue, 13 Feb 2024 10:01:04 +0000
Message-ID: <0106018da1e9b5ee-8b2403c9-8e5b-4f22-8b25-18919a57d29d-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212201609.7ac78134@hermes.local>
References: <20240212201609.7ac78134@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-northeast-1.rx1zlehJXIhTBJXf7/H1gLdwyBf0eKXp6+AKci1nnIg=:AmazonSES
X-SES-Outgoing: 2024.02.13-23.251.234.4

Fix json corruption when using the "-json" option in some cases

Signed-off-by: Takanori Hirano <me@hrntknr.net>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
Changes in v2:
 - Use print_color_string at print iface.
 - Fix json object structure in f_route (to/from).
 - Avoid line breaks.
---
 tc/f_cgroup.c |  4 ++--
 tc/f_flow.c   | 64 +++++++++++++++++++++++++++++----------------------
 tc/f_route.c  | 16 ++++++++-----
 3 files changed, 48 insertions(+), 36 deletions(-)

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
index 2445aaef..4a29af22 100644
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
@@ -272,33 +287,26 @@ static int flow_print_opt(struct filter_util *fu, FILE *f, struct rtattr *opt,
 
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
+				print_string(PRINT_ANY, NULL, "%s", flow_keys[i]);
 				sep = ",";
 			}
 		}
-		fprintf(f, " ");
+		close_json_array(PRINT_ANY, " ");
 	}
 
 	if (tb[TCA_FLOW_MASK])
@@ -311,37 +319,37 @@ static int flow_print_opt(struct filter_util *fu, FILE *f, struct rtattr *opt,
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
+			     sprint_tc_classid(rta_getattr_u32(tb[TCA_FLOW_BASECLASS]), b1));
 
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
index e92c7985..ca8a8ddd 100644
--- a/tc/f_route.c
+++ b/tc/f_route.c
@@ -146,20 +146,24 @@ static int route_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt,
 	parse_rtattr_nested(tb, TCA_ROUTE4_MAX, opt);
 
 	if (handle)
-		fprintf(f, "fh 0x%08x ", handle);
+		print_0xhex(PRINT_ANY, "fh", "fh 0x%08x ", handle);
 	if (handle&0x7F00)
-		fprintf(f, "order %d ", (handle>>8)&0x7F);
+		print_uint(PRINT_ANY, "order", "order %d ", (handle >> 8) & 0x7F);
 
 	if (tb[TCA_ROUTE4_CLASSID]) {
 		SPRINT_BUF(b1);
-		fprintf(f, "flowid %s ", sprint_tc_classid(rta_getattr_u32(tb[TCA_ROUTE4_CLASSID]), b1));
+		print_string(PRINT_ANY, "flowid", "flowid %s ",
+			     sprint_tc_classid(rta_getattr_u32(tb[TCA_ROUTE4_CLASSID]), b1));
 	}
 	if (tb[TCA_ROUTE4_TO])
-		fprintf(f, "to %s ", rtnl_rtrealm_n2a(rta_getattr_u32(tb[TCA_ROUTE4_TO]), b1, sizeof(b1)));
+		print_string(PRINT_ANY, "name", "to %s ",
+			rtnl_rtrealm_n2a(rta_getattr_u32(tb[TCA_ROUTE4_TO]), b1, sizeof(b1)));
 	if (tb[TCA_ROUTE4_FROM])
-		fprintf(f, "from %s ", rtnl_rtrealm_n2a(rta_getattr_u32(tb[TCA_ROUTE4_FROM]), b1, sizeof(b1)));
+		print_string(PRINT_ANY, "name", "from %s ",
+			rtnl_rtrealm_n2a(rta_getattr_u32(tb[TCA_ROUTE4_FROM]), b1, sizeof(b1)));
 	if (tb[TCA_ROUTE4_IIF])
-		fprintf(f, "fromif %s", ll_index_to_name(rta_getattr_u32(tb[TCA_ROUTE4_IIF])));
+		print_color_string(PRINT_ANY, COLOR_IFNAME, "fromif", "fromif %s",
+			ll_index_to_name(rta_getattr_u32(tb[TCA_ROUTE4_IIF])));
 	if (tb[TCA_ROUTE4_POLICE])
 		tc_print_police(f, tb[TCA_ROUTE4_POLICE]);
 	if (tb[TCA_ROUTE4_ACT])
-- 
2.34.1


