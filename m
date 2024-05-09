Return-Path: <netdev+bounces-94996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D9E8C1304
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98081F228B6
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837631A2C11;
	Thu,  9 May 2024 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YlkUf+2K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701963D6C
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272378; cv=fail; b=HOZO9x+xABONDC7zf4JUs/MOjOBANRIffc0rDVJaIRd+8B66ZhD6qnYcUzg3tBJ5Fl7E+Em7X/z74YqtYbrS1EDSihMXW4IKLrDOq+ChnkLEGCOwV6w2byrxtpc4dczhiUPT/fvf7aA+H1LSJXmdgCapJd+7u/RB9hPE4QoNHdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272378; c=relaxed/simple;
	bh=8dTHgmc1e4oNgvIQEsnwxh6tVV8a0Xp1AprDS9DK8vQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWzGVTHPRzpwjGcVCf4NRqRfloAfTstaA9qurH8K5Xtot++rj8yTzjSGK/T0JuOh5BL3puNBvOp5Vuv9+uOY0teAsKRcE8mWux4KpWk7H6Qwl2zP8KH3iBc+rO2FN56nWthN6rR1HQXItHZ09zxjKwsGx7pllsytwpZm6NiGT24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YlkUf+2K; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxyGKnd+aVRW1ar9SSEVurUoBkAP1vXVaoXtUOxOOn/gGlbPMNYqe05gze7onaFFi2kDKldLgUbTqHmyGp2BT8HqWhCVV2dRXe3O5BxmSWPafQ4QLZKJdoe+iIopAlVzj1jJ3aS3DdlfjwwzyrZE+We9LAFAKbvGyf/epJTURJHQ1yzaNUTLcbLl2uMTdOWXyZJQ9xZe6pY9WhhAHKcWV8G9L/0iO7gLAaz2QTjWRD/zJYAdWbHs+AtZ29XH8ld5rNAqaK5aMLuydU6sHqmNHPr4PqMbwWrgG5YzOmUBXDXNgWhTejUHDIXFIOg44ba1potSWglHUHCEdKuRGWJmcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANqksOxiSwFrdS3pflG6NvljQYnPyaP/IUGka/deAU0=;
 b=HQF0H0d3nG3hoPra18B2bD9KxNpqSe+jTeEFjEQMua44HAwL2KIYUtrVqeGZFRcfSLCd44ggxU5TY9MGqgLgbteBztabnNQ7UrV17ksYINMWRlkzqNorXJI5q9sHOBqsjhbc4qPGcKsaG+5JwVITjDDz7UstYCsYS72vCR5TWcMfTUUt6R03q1/k+Gg0KklAQux0YBtudG9lsikV87TN0ZVFm7frXzAeHhbqGQHVawIeUM397e1bmSmmui6UnrLOZ2MJWGKtikjGBMnLycEbDYsCLkPgLOJeC6FqTM6yIa5bi49ixQKwtUuHrubZ9cUPqW6L6thytseas2Ujfa5z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANqksOxiSwFrdS3pflG6NvljQYnPyaP/IUGka/deAU0=;
 b=YlkUf+2Kf8DU7B+mdNYdQNI9eswcVqgexj+rB/WJdAkHq0Ar8et52T2Mzwgsl0Y4lu7yYuwnL/PK0AWEsRgoSEDMKnLNUAOzBUHRgO9gUp5c8D4LB70fAXX1t0pWqO1mtPS7CQf5K+udZGW85dDkZfCeexc1k2qP0eUI12Mwilm8UPWghYhq19hDHQ5GQoUA0UMqAR29PjJoDTmzNYWgAObCsQiUDEpva9GRQxlHNfk37lmdsd/edBoDp4FkqXzCcjLztJnUcG54ZOh7a6GX5NkjYNcxoybv8hJQURekrVa6LPIvtJDGYViIEfeVr2Rs2BWlzLpvbXbiEiu91qe0yg==
Received: from CH5P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::13)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.38; Thu, 9 May
 2024 16:32:52 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::a3) by CH5P220CA0007.outlook.office365.com
 (2603:10b6:610:1ef::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 16:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 16:32:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 09:32:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 May 2024 09:32:30 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 9 May 2024 09:32:29 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and wake
Date: Thu, 9 May 2024 11:32:15 -0500
Message-ID: <20240509163216.108665-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509163216.108665-1-danielj@nvidia.com>
References: <20240509163216.108665-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: c4674a5c-c96e-4244-30d6-08dc7045abe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IzZ8ogeeqF4SdRpzzkKkOVY80kXJlR0bn6IOHDVt83BIFcBZvoyQlqvSO+m3?=
 =?us-ascii?Q?fFVyJl/OHF/RAkn9kaO8AzVwoO9mY5cA6Mq6/t3UfZARMEtQ+d+4dcLFK2zn?=
 =?us-ascii?Q?ajnlCtfTX3ITQE/Gq70psJdQ/jAmNJBmxkDH9dezf/Cmp1VV192B+RT74Dq2?=
 =?us-ascii?Q?eP5L9M9K9mZyZ3EIduvB954IEyX34fq5fEwaz1ATLk1IwxazCjjuEIKhZMaO?=
 =?us-ascii?Q?azDJZ7yzVNH0bo8NF6IwLs48UYtgk4e5L9CdfF/8QpttkQKPkT8OF9mtiESs?=
 =?us-ascii?Q?fR57VBdbs5YUGEaVyS2ARvFC2nDXtSmmeEre2h4ZTyhChQkugc7Bq2cT+HnP?=
 =?us-ascii?Q?0kwOf8eVWj8P5TrQsYn4oEyv8DDC5eUKyJIr25KM2YDlMugl3agwomSXOwRB?=
 =?us-ascii?Q?949aczLiIKVD7aAqEbIO8/XaWCYgdqvaK+m5yTxO0LkyHac9uK62oWxG7Dv3?=
 =?us-ascii?Q?snqHR9dj7xcoqPnbKgjFReJskpbpogJJGMOvp7yAHliJw87Giw39spN+saG+?=
 =?us-ascii?Q?831ZO7n48vENlpOym4hv4TQZfDUBCAlKlVUAUw16fHoVRJXfu/rPUE3Qblu+?=
 =?us-ascii?Q?uS1XG6E3CBLW6j0H5hSyctrVu0bTdX+4/uRRMeI28q9zhgsptjbhwp439peJ?=
 =?us-ascii?Q?ACHtNdLubQit+emM5+Ed4zMgIkn7CTGJozAyLY6Hh4q2orD8dpzPvm0rkl64?=
 =?us-ascii?Q?c/61iQqfSyjj+qL0kxVIXL4UIJYR6uV8SgXUgg/2JWlyQOzkRFgK46A90Fhc?=
 =?us-ascii?Q?w8UZNxFOxDp3sF9X8fNGLu3G22Q1KwHcog9a3+GZ7qNGLonpFIgG8phg9EOt?=
 =?us-ascii?Q?zq3/Ptgpf4GVSjQV0JecW/eqFw9fNkIclr2+0TUf5a6c+LRJwY6l4q9MO55t?=
 =?us-ascii?Q?W7EX2WWNL5olVvBtnacJa8xwHShzmtOFU1xm8R5bRW1lBJktPkuaAqx84vBy?=
 =?us-ascii?Q?t9F161ZhRLqDsJhKKxcoWfPlePZCYqx7YHsY1YkjSBBbVReEVJikNrcdjUWR?=
 =?us-ascii?Q?G1qY/gbss2Jht6GcChY8L7LI7FNfvl1007w76gScXefUXhVv+jwkfZzHzVor?=
 =?us-ascii?Q?cP3n62sl6obtsuS0v2490I2xVX5qeFwQcyUGOn+OKlJMQivIQQcJmtVlLvWn?=
 =?us-ascii?Q?aSPhA9m4AeGJmZKteLS52Sy2lgQSeaB1IaZnf1rWqIsR6uS0mUk2RsmkeSIp?=
 =?us-ascii?Q?YvdA8DLreDKqwRpE01mX1JBzWBhLTLCFNFmaANMOEkSiJV3gjqJfgwmqo99K?=
 =?us-ascii?Q?mcwuqrE5snAbMYaO883Wy3zsmpLY+jWZI+VnqEOR/f/jtgz387g3MJ/x2I62?=
 =?us-ascii?Q?przrX2FUu3rXoZVpJ+78TmLZfYGfnFQEnoMJVJuG1WHiUu8SSMzHaSQfJhVI?=
 =?us-ascii?Q?DVAr9LA0hcKvnHy+auETPd2Qp7eu?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:32:51.7340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4674a5c-c96e-4244-30d6-08dc7045abe5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284

TX queue stop and wake are counted by some drivers.
Support reporting these via netdev-genl queue stats.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/netdev.yaml | 10 ++++++++++
 include/net/netdev_queues.h             |  3 +++
 include/uapi/linux/netdev.h             |  2 ++
 net/core/netdev-genl.c                  |  4 +++-
 tools/include/uapi/linux/netdev.h       |  3 ++-
 5 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 2be4b3714d17..c8b976d03330 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -439,6 +439,16 @@ attribute-sets:
           Number of the packets dropped by the device due to the transmit
           packets bitrate exceeding the device rate limit.
         type: uint
+      -
+        name: tx-stop
+        doc: |
+          Number of times the tx queue was stopped.
+        type: uint
+      -
+        name: tx-wake
+        doc: |
+          Number of times the tx queue was restarted.
+        type: uint
 
 operations:
   list:
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index e7b84f018cee..a8a7e48dfa6c 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -41,6 +41,9 @@ struct netdev_queue_stats_tx {
 	u64 hw_gso_wire_bytes;
 
 	u64 hw_drop_ratelimits;
+
+	u64 stop;
+	u64 wake;
 };
 
 /**
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index cf24f1d9adf8..a8188202413e 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -165,6 +165,8 @@ enum {
 	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
 	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
 	NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
+	NETDEV_A_QSTATS_TX_STOP,
+	NETDEV_A_QSTATS_TX_WAKE,
 
 	__NETDEV_A_QSTATS_MAX,
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 4b5054087309..1f6ae6379e0f 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -517,7 +517,9 @@ netdev_nl_stats_write_tx(struct sk_buff *rsp, struct netdev_queue_stats_tx *tx)
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_BYTES, tx->hw_gso_bytes) ||
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS, tx->hw_gso_wire_packets) ||
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES, tx->hw_gso_wire_bytes) ||
-	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS, tx->hw_drop_ratelimits))
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS, tx->hw_drop_ratelimits) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_STOP, tx->stop) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_WAKE, tx->wake))
 		return -EMSGSIZE;
 	return 0;
 }
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index cf24f1d9adf8..ccf6976b1693 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -164,7 +164,8 @@ enum {
 	NETDEV_A_QSTATS_TX_HW_GSO_BYTES,
 	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
 	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
-	NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
+	NETDEV_A_QSTATS_TX_STOP,
+	NETDEV_A_QSTATS_TX_WAKE,
 
 	__NETDEV_A_QSTATS_MAX,
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
-- 
2.44.0


