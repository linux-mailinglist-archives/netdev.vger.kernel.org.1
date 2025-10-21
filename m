Return-Path: <netdev+bounces-231301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCE1BF72A9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD5B19A6131
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5F340291;
	Tue, 21 Oct 2025 14:48:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101533C505
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058080; cv=none; b=bkifnHUpr69y8CEDsAbVwEtV62DxRBWJpUXXE0fOz9f+kJ295PqI0XU0dBKgp2LHktZscQHFRcEY1FuFXPHTRutSF0nLgZFNX/GWLZZCujU9M6yL2ayV7OdUvYthp+xNGzXDj+UWm0NXEjiJQbnL14Cpaa6t1mBOSSQybZxHMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058080; c=relaxed/simple;
	bh=rSlq5XB6W32di/7nXDHsDhPtoQsU7jhv7EbRaGFRpM8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VPP+61zKxrxUImd9UbwIEkmDW3dj/R0+TZ2YbXzun1ZrdnEQx3jUI528GkYASLJbjqrLe68ZMk5SJTuMKGkIXq/RF24KVBu4hj8p2OFNPJRjq4OtKlLgxVWvSWIjk/Amnyj8+yTzBY4Q6zdYqfLLLPSQgxPm5uw83k35Ptnzieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4crZnG1vCGz6D92b
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:44:18 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id DA28914011A
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:47:56 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 17:47:56 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>
Subject: [PATCH iproute2-next 1/1] Support l2e in ip util
Date: Tue, 21 Oct 2025 17:47:46 +0300
Message-ID: <20251021144746.259257-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
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
+	IPVLAN_MODE_L2E,
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
+		"MODE: l3 | l3s | l2 | l2e\n"
 		"FLAGS: bridge | private | vepa\n"
 		"(first values are the defaults if nothing is specified).\n",
 		lu->id);
@@ -39,12 +39,15 @@ static int ipvlan_parse_opt(struct link_util *lu, int argc, char **argv,
 
 			if (strcmp(*argv, "l2") == 0)
 				mode = IPVLAN_MODE_L2;
+			else if (strcmp(*argv, "l2e") == 0)
+				mode = IPVLAN_MODE_L2E;
 			else if (strcmp(*argv, "l3") == 0)
 				mode = IPVLAN_MODE_L3;
 			else if (strcmp(*argv, "l3s") == 0)
 				mode = IPVLAN_MODE_L3S;
 			else {
-				fprintf(stderr, "Error: argument of \"mode\" must be either \"l2\", \"l3\" or \"l3s\"\n");
+				fprintf(stderr, "Error: argument of \"mode\" must be either "
+					"\"l2\", \"l2e\", \"l3\" or \"l3s\"\n");
 				return -1;
 			}
 			addattr16(n, 1024, IFLA_IPVLAN_MODE, mode);
-- 
2.25.1


