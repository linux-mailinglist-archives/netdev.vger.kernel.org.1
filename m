Return-Path: <netdev+bounces-239515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8652CC690D7
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8BCD92AEA4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC79D34FF5B;
	Tue, 18 Nov 2025 11:24:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81C1EB9FA
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465058; cv=none; b=l7JWVUcBDNoVy7D2oX67g24cvm03rrUM5DfakVMg25p5/t8HzOyvwYX87wU86Ciev4ecoSMmVevgs7/C5nCukdOQfpl5chxRkYfHsHJcda0ZnwA6FBxBdq7td/e4tkO6u0X/GOuXmxOpxRYkq09SpKbsaNvf+jNltmFMEGGqOPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465058; c=relaxed/simple;
	bh=999gxEadfInHHFzeuTbM4HIE2zWKbMryG1bMU6PnHPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RfI+hfE+rotLnOmYCuvWEODAz+4R7Wkna1+27cur2m/EjaCmQpY172Sg3y9MH3+viRyloTi65sGT+jcuiHRK+r3svsxuAYUg8kVHJSVFcJ7aJ4NHDT/w5qU/cZxW6pp31wjz2ln3AR+H2JI1O+jAweLUj7AOcEYQmsgN9KQU49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d9j0X6PDgzJ46mw
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 19:23:24 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F3DA1402F3
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 19:24:07 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 14:24:06 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, <edumazet@google.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>
Subject: [PATCH v2 iproute2-next 1/1] Support l2macnat in ip util
Date: Tue, 18 Nov 2025 14:23:47 +0300
Message-ID: <20251118112347.2967577-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 include/uapi/linux/if_link.h | 1 +
 ip/iplink_ipvlan.c           | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index d05f5cc7..ec79f246 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1267,6 +1267,7 @@ enum ipvlan_mode {
 	IPVLAN_MODE_L2 = 0,
 	IPVLAN_MODE_L3,
 	IPVLAN_MODE_L3S,
+	IPVLAN_MODE_L2_MACNAT,
 	IPVLAN_MODE_MAX
 };
 
diff --git a/ip/iplink_ipvlan.c b/ip/iplink_ipvlan.c
index f29fa4f9..df2c1aa4 100644
--- a/ip/iplink_ipvlan.c
+++ b/ip/iplink_ipvlan.c
@@ -19,7 +19,7 @@ static void print_explain(struct link_util *lu, FILE *f)
 	fprintf(f,
 		"Usage: ... %s [ mode MODE ] [ FLAGS ]\n"
 		"\n"
-		"MODE: l3 | l3s | l2\n"
+		"MODE: l3 | l3s | l2 | l2macnat\n"
 		"FLAGS: bridge | private | vepa\n"
 		"(first values are the defaults if nothing is specified).\n",
 		lu->id);
@@ -39,12 +39,15 @@ static int ipvlan_parse_opt(struct link_util *lu, int argc, char **argv,
 
 			if (strcmp(*argv, "l2") == 0)
 				mode = IPVLAN_MODE_L2;
+			else if (strcmp(*argv, "l2macnat") == 0)
+				mode = IPVLAN_MODE_L2_MACNAT;
 			else if (strcmp(*argv, "l3") == 0)
 				mode = IPVLAN_MODE_L3;
 			else if (strcmp(*argv, "l3s") == 0)
 				mode = IPVLAN_MODE_L3S;
 			else {
-				fprintf(stderr, "Error: argument of \"mode\" must be either \"l2\", \"l3\" or \"l3s\"\n");
+				fprintf(stderr, "Error: argument of \"mode\" must be either "
+					"\"l2\", \"l2macnat\", \"l3\" or \"l3s\"\n");
 				return -1;
 			}
 			addattr16(n, 1024, IFLA_IPVLAN_MODE, mode);
-- 
2.25.1


