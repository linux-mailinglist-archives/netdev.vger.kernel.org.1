Return-Path: <netdev+bounces-144617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F35F99C7F08
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD581F230F4
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B3C199FD0;
	Wed, 13 Nov 2024 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Vuq0sRej"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BAB193061;
	Wed, 13 Nov 2024 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542224; cv=none; b=VbB7z6KEAcDTPtDQz6IaKiqSJPRCuzD19rshMLO8Fl0DhbnuehWOsx6r59MT0YPoYMQN6WPNQLL3nwZqhYW3O25VdFFGKgaQroZ0NFYjnyKtGPR0KwGTpcldrkQa7FaWnGKKs6zpR7mUA0Q4FqmIPuCfHv5UKAbbtvbKfZePogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542224; c=relaxed/simple;
	bh=EKr4vTzAC596mh6OAe51sUzgy1wDv2Oe1xck8TnlJ0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NFnHCfHrO9fb4QIzjFPLRZ0l/4onRmis9YquO3x7P78P++/uArDmFOCRXq65C+0sK7H5NBkJEdBBdeiKtUfUb2l7uJwJor4LsdM1r940Ff1bGqlhz5Qn6C1ctcMIu8gqWin6/ZPi0+XmgEkOJonalBLaHimvg34AYkXe5560t+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Vuq0sRej; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2306; q=dns/txt; s=iport;
  t=1731542223; x=1732751823;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+a/hUgADXfQgRFbN1jhyeqhTNqk5xC9hKt4NZ9QC7+c=;
  b=Vuq0sRejbh3IqSThpxjiEBj6zsUaHAXHs6wAxaTrgpdcf39fqQUD+Zhj
   w3lJjLlIxx2W5wVVejdC/bSuglDeWhYJW1ykzBM3mXSjwNkt363y5NxBI
   yjIUaihUj/YX5qX1Vvz6HvgfeY2n/M4a+GthN1F0qsoTi4rPCoifnWg4j
   8=;
X-CSE-ConnectionGUID: Ieu90L4SSdKvJVkVYWJouw==
X-CSE-MsgGUID: v3lxAPX6R+GGkUDK/i/3aA==
X-IPAS-Result: =?us-ascii?q?A0AGAADHOzVnj5MQJK1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYQaQkiEVYgdhzCOFoxHhVyBJQNWDwEBAQ9EBAEBhQcCi?=
 =?us-ascii?q?kUCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFFAEBAQEBA?=
 =?us-ascii?q?TkFDjuGCIZbAgEDIwRSECUCJgICKxsQBgESgwGCZQIBsGZ6fzOBAYR72TiBb?=
 =?us-ascii?q?YEaLgGISwGBbINkGTuEPCcbgUlEhH2IHoJpBIQtA4MuhUODeZkpCT+BBRwDW?=
 =?us-ascii?q?SERAVUTDQoLBwVjVzwDIm9qXHorgQ6BFzpDgTuBIi8bIQtcgTeBGhQGFQSBD?=
 =?us-ascii?q?kY/gkppSzoCDQI2giQkWYJPhRqEbYRmglQvHUADCxgNSBEsNQYOGwY9AW4Hn?=
 =?us-ascii?q?mVGgzIBgQ2CQJNQg2uNPqFrhCShXDOqTS6HZJBlIqQchGaBZzqBWzMaCBsVg?=
 =?us-ascii?q?yJSGQ+OLQ0JkxYBtj9DNTsCBwsBAQMJkEkBAQ?=
IronPort-Data: A9a23:v0WPe61fzGy16YTCj/bD5UZxkn2cJEfYwER7XKvMYLTBsI5bp2FRz
 2YXUD2Bafzba2Skc91zO4y39x4FsJCGn942HFM63Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmE4E/watANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU4
 7sen+WFYAX5gmctaTpPg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGLUwrbNU8pt1MDUJQ1
 8IbFgEyTBeemLfjqF67YrEEasULJc3vOsYb/3pn1zycVK5gSpHYSKKM7thdtNsyrpkRRrCFO
 YxAN3w2MEuojx5nYj/7DLo4keqzjX71ehVTqUmeouw85G27IAlZi+izaYGKJ4fSLSlTtljDo
 nLvx1SnOFI1G9+i5RnC8zX3j8aayEsXX6pJSeXnraQ16LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JQFPc/8ymOx7DS7gLfAXILJhZCddYvnMw7Xzon0
 hmOhdyBLTVpvKeYVjGb+6uYoC2aPTUTKykJZUcsVQIP7t/iiJs+ghLGUpBoF6vdptn0Hyzgh
 jOHti4zg50NgsMRkaa251bKh3SrvJehZgg4+gnaQEq74Q5jIo2ofYql7R7c9/koEWqCZlCFu
 H5Bn42V6/oDSMjV0ieMW+4KWrqu4p5pLQEwn3ZOEoRwrxDxwEWvXp5y3jJAFXhLNdsbLGqBj
 FDohStd45paPX2PZKBxYp6sB8lC8UQGPYq5PhwzRoQTCqWdZDO6EDdSiVl8Nl0BcXTAc4lja
 f93ku71UR727JiLKhLtGY/xNpdwmkgDKZv7H8yT8vhe+eP2iISpYbkEKkCSSesy8bmJpg7Ym
 /4GaJDTlk8FDr2uP3CNmWL2EbzsBSVlbXwRg5EGHtNv3iI/SQnN9teIm+p4IN0/90irvryYp
 yrjMqOn9LYPrSaacVrRMC8LhELHVpdkpnVzJj03IVutwDAiZ43phJrzhLNpFYTLANdLlKYuJ
 9FcIp3oKq0WFlzvpW9HBbGj99MKSfherV7VV8ZTSGRkJ8Y4L+EIk/e4FjbSGN4mVXrr65Bm+
 OL/h2s2g/MrHmxfMSofU9r3p3vZgJTXsLsas5fgSjWLRHjRzQ==
IronPort-HdrOrdr: A9a23:IiC8jarGiGCMJL5ppaHcWsEaV5rmeYIsimQD101hICG9vPbo8P
 xG+8566faUslcssR4b9exoVJPsfZqYz+8R3WBzB9mftXfdyQiVxehZhOOIqQEIWReOlNK1vp
 0OT0ERMqyVMXFKyev3/wW8Fc8t252k/LDAv5an815dCSxndK1k6R50EUKgEkNwTBRbHpZRLu
 vk2iM+nUvHRZzSBf7LfEXsmIP41qb2qK4=
X-Talos-CUID: =?us-ascii?q?9a23=3ApvVfd2uKXCrFsuxDXOx9AUUz6IsEf2CMlFOMGHS?=
 =?us-ascii?q?0KnhLdr6reGCy/757xp8=3D?=
X-Talos-MUID: 9a23:O1jzGgTW5hJ8xiMXRXTy3zVyHf9YvZ7tJ28OrLkl/MjDbiVZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,152,1728950400"; 
   d="scan'208";a="386137530"
Received: from alln-l-core-10.cisco.com ([173.36.16.147])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2024 23:56:55 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-10.cisco.com (Postfix) with ESMTPS id 60DED1800026E;
	Wed, 13 Nov 2024 23:56:54 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id E59C7CC12B6; Wed, 13 Nov 2024 23:56:52 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Wed, 13 Nov 2024 23:56:39 +0000
Subject: [PATCH net-next v4 7/7] enic: Move kdump check into
 enic_adjust_resources()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-remove_vic_resource_limits-v4-7-a34cf8570c67@cisco.com>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731542212; l=2338;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=EKr4vTzAC596mh6OAe51sUzgy1wDv2Oe1xck8TnlJ0U=;
 b=CB4HU7454gJHpqTOfwkzGZOvsq5kj+WNbydAhzUAhCn3N980d7ss0O64Cd486EACE/CrYNfHt
 5uLh1IHgJOUDFHWGUv5sn2TOjveRvWdmpRfQ+a8lP2JjP6Ae+QJ8UCt
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Outbound-SMTP-Client: 171.70.41.192, neescoba-vicdev.cisco.com
X-Outbound-Node: alln-l-core-10.cisco.com

Move the kdump check into enic_adjust_resources() so that everything
that modifies resources is in the same function.

Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 84e85c9e2bf52f0089c0a8d03fb6d22ada4d086c..9913952ccb42f2017037a81a8e2c42daa7b53ec3 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2531,6 +2531,15 @@ static int enic_adjust_resources(struct enic *enic)
 		return -ENOSPC;
 	}
 
+	if (is_kdump_kernel()) {
+		dev_info(enic_get_dev(enic), "Running from within kdump kernel. Using minimal resources\n");
+		enic->rq_avail = 1;
+		enic->wq_avail = 1;
+		enic->config.rq_desc_count = ENIC_MIN_RQ_DESCS;
+		enic->config.wq_desc_count = ENIC_MIN_WQ_DESCS;
+		enic->config.mtu = min_t(u16, 1500, enic->config.mtu);
+	}
+
 	/* if RSS isn't set, then we can only use one RQ */
 	if (!ENIC_SETTING(enic, RSS))
 		enic->rq_avail = 1;
@@ -2764,18 +2773,6 @@ static void enic_dev_deinit(struct enic *enic)
 	enic_free_enic_resources(enic);
 }
 
-static void enic_kdump_kernel_config(struct enic *enic)
-{
-	if (is_kdump_kernel()) {
-		dev_info(enic_get_dev(enic), "Running from within kdump kernel. Using minimal resources\n");
-		enic->rq_avail = 1;
-		enic->wq_avail = 1;
-		enic->config.rq_desc_count = ENIC_MIN_RQ_DESCS;
-		enic->config.wq_desc_count = ENIC_MIN_WQ_DESCS;
-		enic->config.mtu = min_t(u16, 1500, enic->config.mtu);
-	}
-}
-
 static int enic_dev_init(struct enic *enic)
 {
 	struct device *dev = enic_get_dev(enic);
@@ -2811,10 +2808,6 @@ static int enic_dev_init(struct enic *enic)
 		return err;
 	}
 
-	/* modify resource count if we are in kdump_kernel
-	 */
-	enic_kdump_kernel_config(enic);
-
 	/* Set interrupt mode based on system capabilities */
 
 	err = enic_set_intr_mode(enic);

-- 
2.35.6


