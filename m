Return-Path: <netdev+bounces-240799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D3EC7AABC
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0693A3643E2
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C51346E55;
	Fri, 21 Nov 2025 15:52:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666A133508F
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740351; cv=none; b=eZdKI4f/qglPC8heTek2miaYnw/SSwma/lhul1MqvJ2ocYA3UOZcJHvw9RNKtUjUY03cZXWO2qz+9/JWhA6AZu5U8KpZ4YS2doGndE65HQ2aH6Y6BeLjf8eqE21/3XGRocYKZxcs1g97BIt7f6mJQFbV3xen8Cd+dUfgIlWjt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740351; c=relaxed/simple;
	bh=aLAwUwPUB/giJndSAaNolDZ14OqkLMO0H9WFIe4u+fQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzIIRT+aiYg/YPBh+Bew3cC4GMRVR7ptWjm8sDROgRKQHWY6YehC/Gaj3hBXHURNtYlmcMxaG0hRyoEUoIBGKrBGc1cyRL33UQDbsDfDPae1ndSciBSudSUsCQ0WseOGR80ZUv0U1tMGoiervFmQO61nxg0Y7n0cpVnShmBaGmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dCfpq3Mq9zHnGk1;
	Fri, 21 Nov 2025 23:51:47 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DD301402FF;
	Fri, 21 Nov 2025 23:52:24 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 18:52:24 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>
Subject: [PATCH iproute2-next 1/3] helper funcs for ipvlan_mode <-> string conversion
Date: Fri, 21 Nov 2025 18:52:10 +0300
Message-ID: <20251121155212.4182474-2-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121155212.4182474-1-skorodumov.dmitry@huawei.com>
References: <20251121155212.4182474-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)

Introduced functions get_ipvlan_mode() and get_ipvlan_mode_name()
to convert between name <-> IPVLAN_MODE_XXX.

Next patch will add new mode and inplace code is becoming too large.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 ip/iplink_ipvlan.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/ip/iplink_ipvlan.c b/ip/iplink_ipvlan.c
index f29fa4f9..691fd6f3 100644
--- a/ip/iplink_ipvlan.c
+++ b/ip/iplink_ipvlan.c
@@ -25,6 +25,31 @@ static void print_explain(struct link_util *lu, FILE *f)
 		lu->id);
 }
 
+static int get_ipvlan_mode(const char *mode)
+{
+	if (strcmp(mode, "l2") == 0)
+		return IPVLAN_MODE_L2;
+	if (strcmp(mode, "l3") == 0)
+		return IPVLAN_MODE_L3;
+	if (strcmp(mode, "l3s") == 0)
+		return IPVLAN_MODE_L3S;
+	return -1;
+}
+
+static const char *get_ipvlan_mode_name(__u16 mode)
+{
+	switch (mode) {
+	case IPVLAN_MODE_L2:
+		return "l2";
+	case IPVLAN_MODE_L3:
+		return "l3";
+	case IPVLAN_MODE_L3S:
+		return "l3s";
+	default:
+		return "unknown";
+	}
+}
+
 static int ipvlan_parse_opt(struct link_util *lu, int argc, char **argv,
 			    struct nlmsghdr *n)
 {
@@ -33,21 +58,17 @@ static int ipvlan_parse_opt(struct link_util *lu, int argc, char **argv,
 
 	while (argc > 0) {
 		if (matches(*argv, "mode") == 0) {
-			__u16 mode = 0;
+			int mode;
 
 			NEXT_ARG();
 
-			if (strcmp(*argv, "l2") == 0)
-				mode = IPVLAN_MODE_L2;
-			else if (strcmp(*argv, "l3") == 0)
-				mode = IPVLAN_MODE_L3;
-			else if (strcmp(*argv, "l3s") == 0)
-				mode = IPVLAN_MODE_L3S;
-			else {
-				fprintf(stderr, "Error: argument of \"mode\" must be either \"l2\", \"l3\" or \"l3s\"\n");
+			mode = get_ipvlan_mode(*argv);
+			if (mode < 0) {
+				fprintf(stderr, "Error: argument of \"mode\" must be either "
+					"\"l2\", \"l3\" or \"l3s\"\n");
 				return -1;
 			}
-			addattr16(n, 1024, IFLA_IPVLAN_MODE, mode);
+			addattr16(n, 1024, IFLA_IPVLAN_MODE, (__u16)mode);
 		} else if (matches(*argv, "private") == 0 && !mflag_given) {
 			flags |= IPVLAN_F_PRIVATE;
 			mflag_given = true;
@@ -82,9 +103,7 @@ static void ipvlan_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_IPVLAN_MODE]) {
 		if (RTA_PAYLOAD(tb[IFLA_IPVLAN_MODE]) == sizeof(__u16)) {
 			__u16 mode = rta_getattr_u16(tb[IFLA_IPVLAN_MODE]);
-			const char *mode_str = mode == IPVLAN_MODE_L2 ? "l2" :
-				mode == IPVLAN_MODE_L3 ? "l3" :
-				mode == IPVLAN_MODE_L3S ? "l3s" : "unknown";
+			const char *mode_str = get_ipvlan_mode_name(mode);
 
 			print_string(PRINT_ANY, "mode", " mode %s ", mode_str);
 		}
-- 
2.25.1


