Return-Path: <netdev+bounces-235860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD1AC36A6A
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4E7664A3F
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7A93358AA;
	Wed,  5 Nov 2025 16:09:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B5335570
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358958; cv=none; b=meXFmTU+IPLzd0wSXKI1Nxknyj3IOHdUu3PDLlgX6lHXoPBHAZuIUMjLjgNcyTSZMXbEUzM/oP3ukIsJikMQfK+/P/mAc/vRSnpK+Hs/eywXR7kCEXOo0GJ+syZx/GohJuEzkZbqJ9n8FqmmpA9O0TQ8fYZFu1ixn2WdTKnGK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358958; c=relaxed/simple;
	bh=999gxEadfInHHFzeuTbM4HIE2zWKbMryG1bMU6PnHPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kXhYq6zFY9urOkHFvyRUG+mp4Gsof2Grosonls6033SLGWLzigPelTIGWISlnOP8+Xd0RDy3lzSttkMm1cuS70D3rljpzQOWEhOYRGIMTnlNnrRvmR0e8dUcG5wnMsGgzVfHIGpUThPhoR+Tm0qvDx4wKYftuVwlTgUwZexLzvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1qyF4K7fzHnGjH
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:09:09 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 34C75140370
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:09:15 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 19:09:14 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>
Subject: [PATCH v2 iproute2-next 1/1] Support l2macnat in ip util
Date: Wed, 5 Nov 2025 19:09:07 +0300
Message-ID: <20251105160907.1728085-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
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


