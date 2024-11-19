Return-Path: <netdev+bounces-146240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F59D269F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92162864E0
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4931CCEC6;
	Tue, 19 Nov 2024 13:10:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D01CCECA
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021859; cv=none; b=YJM/6xAUMV4MdiRPL+PmKK0itf0FUKj35FGi7OQYOPUY/5oEgkWvL8vbWanl8exvSt1tWHred6zc2WiUPmfyVDR3u6iGpo3Zcj/wSvCC+nj80bu5Npm5pIqFaBr9VtYZmYo6i3DoSzdnhNaOSb1nXtXDic1e4tKSczogfGhUeGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021859; c=relaxed/simple;
	bh=Ph2HH2evqEmPoPkYfgGLjHRjPVWxGXpEM1gwBeJXZFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kRa+10zLP550i+Dy7qCu2K5fqsuWscNH9WFDAtEGmjBWpO0IGj6AAr5tOWQ5ct3/1iZCOhrMK94+MzRAF4T7GQyzGDTDilwC8NtHlJVXJbmncIEARlFOobq/z3S6NaqGkRFOp7/e6OQwrJda6lX/UuNRF7Ze1ID4SvkiH7Jx2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tDO0N-0000Vp-Ma; Tue, 19 Nov 2024 14:10:55 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tDO0N-001ZRj-1F;
	Tue, 19 Nov 2024 14:10:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tDO0N-00Dv1H-13;
	Tue, 19 Nov 2024 14:10:55 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	netdev@vger.kernel.org
Subject: [PATCH ethtool-next v1 1/1] ethtool: add support for ETHTOOL_A_CABLE_FAULT_LENGTH_SRC and ETHTOOL_A_CABLE_RESULT_SRC
Date: Tue, 19 Nov 2024 14:10:54 +0100
Message-Id: <20241119131054.3317432-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Extend cable test output to include source information, supporting
diagnostic technologies like TDR (Time Domain Reflectometry) and ALCD
(Active Link Cable Diagnostic). The source is displayed optionally at
the end of each result or fault length line.

TDR requires interrupting the active link to measure parameters like
fault location, while ALCD can operate on an active link to provide
details like cable length without disruption.

Example output:
Pair B code Open Circuit, source: TDR
Pair B, fault length: 8.00m, source: TDR

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 netlink/cable_test.c   | 39 +++++++++++++++++++++++++++++++++------
 netlink/desc-ethtool.c |  2 ++
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/netlink/cable_test.c b/netlink/cable_test.c
index ba21c6cd31e4..0a1c42010114 100644
--- a/netlink/cable_test.c
+++ b/netlink/cable_test.c
@@ -18,7 +18,7 @@ struct cable_test_context {
 };
 
 static int nl_get_cable_test_result(const struct nlattr *nest, uint8_t *pair,
-				    uint16_t *code)
+				    uint16_t *code, uint32_t *src)
 {
 	const struct nlattr *tb[ETHTOOL_A_CABLE_RESULT_MAX+1] = {};
 	DECLARE_ATTR_TB_INFO(tb);
@@ -32,12 +32,15 @@ static int nl_get_cable_test_result(const struct nlattr *nest, uint8_t *pair,
 
 	*pair = mnl_attr_get_u8(tb[ETHTOOL_A_CABLE_RESULT_PAIR]);
 	*code = mnl_attr_get_u8(tb[ETHTOOL_A_CABLE_RESULT_CODE]);
+	if (tb[ETHTOOL_A_CABLE_RESULT_CODE])
+		*src = mnl_attr_get_u32(tb[ETHTOOL_A_CABLE_RESULT_SRC]);
 
 	return 0;
 }
 
 static int nl_get_cable_test_fault_length(const struct nlattr *nest,
-					  uint8_t *pair, unsigned int *cm)
+					  uint8_t *pair, unsigned int *cm,
+					  uint32_t *src)
 {
 	const struct nlattr *tb[ETHTOOL_A_CABLE_FAULT_LENGTH_MAX+1] = {};
 	DECLARE_ATTR_TB_INFO(tb);
@@ -51,6 +54,8 @@ static int nl_get_cable_test_fault_length(const struct nlattr *nest,
 
 	*pair = mnl_attr_get_u8(tb[ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR]);
 	*cm = mnl_attr_get_u32(tb[ETHTOOL_A_CABLE_FAULT_LENGTH_CM]);
+	if (tb[ETHTOOL_A_CABLE_FAULT_LENGTH_CM])
+		*src = mnl_attr_get_u32(tb[ETHTOOL_A_CABLE_FAULT_LENGTH_SRC]);
 
 	return 0;
 }
@@ -88,33 +93,55 @@ static char *nl_pair2txt(uint8_t pair)
 	}
 }
 
+static char *nl_src2txt(uint32_t src)
+{
+	switch (src) {
+	case ETHTOOL_A_CABLE_INF_SRC_TDR:
+		return "TDR";
+	case ETHTOOL_A_CABLE_INF_SRC_ALCD:
+		return "ALCD";
+	default:
+		return "Unknown";
+	}
+}
+
 static int nl_cable_test_ntf_attr(struct nlattr *evattr)
 {
 	unsigned int cm;
+	uint32_t src = UINT32_MAX;
 	uint16_t code;
 	uint8_t pair;
 	int ret;
 
 	switch (mnl_attr_get_type(evattr)) {
 	case ETHTOOL_A_CABLE_NEST_RESULT:
-		ret = nl_get_cable_test_result(evattr, &pair, &code);
+		ret = nl_get_cable_test_result(evattr, &pair, &code, &src);
 		if (ret < 0)
 			return ret;
 
 		open_json_object(NULL);
 		print_string(PRINT_ANY, "pair", "%s ", nl_pair2txt(pair));
-		print_string(PRINT_ANY, "code", "code %s\n", nl_code2txt(code));
+		print_string(PRINT_ANY, "code", "code %s", nl_code2txt(code));
+		if (src != UINT32_MAX)
+			print_string(PRINT_ANY, "src", ", source: %s",
+				     nl_src2txt(src));
+		print_nl();
 		close_json_object();
 		break;
 
 	case ETHTOOL_A_CABLE_NEST_FAULT_LENGTH:
-		ret = nl_get_cable_test_fault_length(evattr, &pair, &cm);
+		ret = nl_get_cable_test_fault_length(evattr, &pair, &cm, &src);
 		if (ret < 0)
 			return ret;
 		open_json_object(NULL);
 		print_string(PRINT_ANY, "pair", "%s, ", nl_pair2txt(pair));
-		print_float(PRINT_ANY, "length", "fault length: %0.2fm\n",
+		print_float(PRINT_ANY, "length", "fault length: %0.2fm",
 			    (float)cm / 100);
+		if (src != UINT32_MAX)
+			print_string(PRINT_ANY, "src", ", source: %s",
+				     nl_src2txt(src));
+		print_nl();
+
 		close_json_object();
 		break;
 	}
diff --git a/netlink/desc-ethtool.c b/netlink/desc-ethtool.c
index 5c0e1c6f433d..97a994961c8e 100644
--- a/netlink/desc-ethtool.c
+++ b/netlink/desc-ethtool.c
@@ -252,12 +252,14 @@ static const struct pretty_nla_desc __cable_test_result_desc[] = {
 	NLATTR_DESC_INVALID(ETHTOOL_A_CABLE_RESULT_UNSPEC),
 	NLATTR_DESC_U8(ETHTOOL_A_CABLE_RESULT_PAIR),
 	NLATTR_DESC_U8(ETHTOOL_A_CABLE_RESULT_CODE),
+	NLATTR_DESC_U8(ETHTOOL_A_CABLE_RESULT_SRC),
 };
 
 static const struct pretty_nla_desc __cable_test_flength_desc[] = {
 	NLATTR_DESC_INVALID(ETHTOOL_A_CABLE_FAULT_LENGTH_UNSPEC),
 	NLATTR_DESC_U8(ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR),
 	NLATTR_DESC_U32(ETHTOOL_A_CABLE_FAULT_LENGTH_CM),
+	NLATTR_DESC_U8(ETHTOOL_A_CABLE_FAULT_LENGTH_SRC),
 };
 
 static const struct pretty_nla_desc __cable_nest_desc[] = {
-- 
2.39.5


