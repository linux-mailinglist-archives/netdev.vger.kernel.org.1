Return-Path: <netdev+bounces-70543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D86084F737
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E591F2233E
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1691142A8F;
	Fri,  9 Feb 2024 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b="YpOBKfGC";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="K9NXQpIh"
X-Original-To: netdev@vger.kernel.org
Received: from e234-2.smtp-out.ap-northeast-1.amazonses.com (e234-2.smtp-out.ap-northeast-1.amazonses.com [23.251.234.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1735469D08
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488574; cv=none; b=OCJ/gJl/sny5c2PMnyjAFueEO3QUoyFOdqCWmMWHWALqYV46rd3/qBZm6Ss747m/J1xZB+iX7RU9q6aFMLf+F3ASeyIlNNesANFi+WFa2PKbqiav9L6ZajvWhfuNEbKsncNKil4QvRKazbjrx2YpmHSLT/LM3ztMnVYq0+O3i8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488574; c=relaxed/simple;
	bh=ejK66TtFGmgF2Y0+avp271LM3lwShx4FWVlSBUz/+U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rolLf3DTimfp+KKf5awVdorhOR9cLNYnBKFB9vAiqHbegOAng+orwfkcJgQhzNhBXT1bsxWmKYRcg7Yfd9lJdP3Xt6zOdy92oW2+GJZKIYe5GQLO1Mqr73DQfCLlwDdbF8Za42QyetYehwpE/aZmAA3zPtXeXMQzwWW5jUYNMJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com; dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b=YpOBKfGC; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=K9NXQpIh; arc=none smtp.client-ip=23.251.234.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=otpfqkfjftndw3gmuo745xikcugpdsgy; d=hrntknr.net; t=1707488570;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
	bh=ejK66TtFGmgF2Y0+avp271LM3lwShx4FWVlSBUz/+U8=;
	b=YpOBKfGCy1nLzrhReNSWNoeqZV4jYvJqEeyLQtV6ZwRB8njiPqr1gFndqhPRxWhW
	WuRT1I+N3mAAJaelCCr/ixVZAEPXiMphLVORvf4J33N2TIpYVdD/V7Vle41V+4CTtRw
	Mm2apJlclstciNOSfeNd0msyzYNkmQi4qt8MZqbiN3B6La8tarMHvr1iXGo+e5ULcxD
	Rw08zHAoAhdsMH2HiddLBOdkZPvtxQkrHYfeHA9NkKCmeGOsNgEi/IhiHTsV2UMJ7MO
	ct1FzkESdYPRkvlm+haRl+V0UGybCeB3AGYZNOdaujBapbJo8O1o8oKX09Cm2NpbsWH
	eogqaedmhw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1707488570;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=ejK66TtFGmgF2Y0+avp271LM3lwShx4FWVlSBUz/+U8=;
	b=K9NXQpIh7Vjc5EEe5BIR/sU0YGVtw4PG64CXfg4ULPKLtdO2qhGXtfRoLmpYrbsR
	pNcDSQ7mh9L98BAXYXF+BpLOIcsL3SAR2Am2FH0G3A0O6NZxShEHiPtdCUZfqaNMd4Z
	+vT4ZJ13pJ/EGjOGGfZIilyl5DDKBM2AVT/0I47E=
From: Takanori Hirano <me@hrntknr.net>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org, Takanori Hirano <me@hrntknr.net>
Subject: [PATCH iproute2] tc: Support json option in tc-fw.
Date: Fri, 9 Feb 2024 14:22:50 +0000
Message-ID: <0106018d8e3feccb-51048e17-d81c-4a1b-97cb-bc3809ad3eca-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-northeast-1.rx1zlehJXIhTBJXf7/H1gLdwyBf0eKXp6+AKci1nnIg=:AmazonSES
X-SES-Outgoing: 2024.02.09-23.251.234.2

Fix json corruption when using the "-json" option in cases where tc-fw is set.

Signed-off-by: Takanori Hirano <me@hrntknr.net>
---
 tc/f_fw.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tc/f_fw.c b/tc/f_fw.c
index 38bec492..fe99cd42 100644
--- a/tc/f_fw.c
+++ b/tc/f_fw.c
@@ -124,18 +124,25 @@ static int fw_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u
 	if (handle || tb[TCA_FW_MASK]) {
 		__u32 mark = 0, mask = 0;
 
+		open_json_object("handle");
 		if (handle)
 			mark = handle;
 		if (tb[TCA_FW_MASK] &&
-		    (mask = rta_getattr_u32(tb[TCA_FW_MASK])) != 0xFFFFFFFF)
-			fprintf(f, "handle 0x%x/0x%x ", mark, mask);
-		else
-			fprintf(f, "handle 0x%x ", handle);
+		    (mask = rta_getattr_u32(tb[TCA_FW_MASK])) != 0xFFFFFFFF) {
+			print_hex(PRINT_ANY, "mark", "handle 0x%x", mark);
+			print_hex(PRINT_ANY, "mask", "/0x%x ", mask);
+		} else {
+			print_hex(PRINT_ANY, "mark", "handle 0x%x ", mark);
+			print_hex(PRINT_JSON, "mask", NULL, 0xFFFFFFFF);
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
-- 
2.34.1


