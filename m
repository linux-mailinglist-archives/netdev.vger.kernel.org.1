Return-Path: <netdev+bounces-180706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69647A8237C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6FC178FFA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE6925D917;
	Wed,  9 Apr 2025 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N5DPg6om"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7B218AD2
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197934; cv=fail; b=qnuULR5gWqf05Zy6L6I4wHnnTwQfY2IaCczcDmbnXPnnXGo/GvXa3tir2tZ+N3qF/HMoeo0wz0Myt/2JB5JoZQP+GpCxwlVF9Eyp6EPw+y1y4YB7zG8JTsduebvj6UQdGHoDGRoJ20PyW13NWbE90bzYdcHgnQGKm+8bSfjOauM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197934; c=relaxed/simple;
	bh=y9ZGEuFBqbbi9d5wdGmt47FM2ieFrPiHAxF0teWbyJE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C6Zyfy4lJUfxV15mKap2HBxL1aTCdwjxVvTm5Cv/U4UZjUpR9X+IaVVZXaFfmeaqrncOqqPXRA524FpG6OJJI2QXWmYn7NOXJ7kU7itnYz2bnrn//35XArUMeN8dMDwoyucJv13ey67ARfwqs0st1qvE2WmFAYYlZeq3+G00wAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N5DPg6om; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gL+xKLo/GqqT4eQwjIPEep16somcKkacgsHVon43Tid8sxSms+2JjXzSCI0tvJqb0UuFJNJrP4N9703BH6R/H5ez4bUBHoXuNnCaxh7rLyGi26YuGzTy7vlyKtPPkv5UP8J9mfJxL61oTablWatb+R25oswOBSae3p86Pj0hymCOTK82Un3VyAVqWbPXsxHevk4Qj/SPRGuxKdpzJsyRRBe2zM8TQEkrCABeP6RCOMfRLC6VHKJB7M0SWlPe3URo30axEiCSG5Pd8271OHmy9Y6l+T8FCXr3poX1KFxKqKQy3TGSQahgi3vtoeYgqWM0dPKhyKPjwBca1aIrggoYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kE0qr6+s+NkU6kbX2NjzM1RAjPAbgSOUyyYyoAfQy4=;
 b=WM8wij7pE01+quk3XLTdgG88rB7FQez8i22EIOrcTLHsCkxA7AWX9hnwoqLxtB7c4nNonLNaSYqOnUUyBkaw9UY1oubXAdbXNo2wtTPxfAegYbMm6RVN0aw0B3yjiIG7nrSeJzw94Ma0qY5J64Q4ssPkQCMn3vOUJhmGCoz77IIl2Cko9Z772R6eSwEl81eOf0Bj55bKWxbC7lyzsDE32z5rQoyM+8FMFDhD7lraRvQ0Vh0iYMt7x95JhuMipNROMLOd6cQyyO3+jQ+uLfBOSYSZ09WaiQzGFcsy+yUiXlldaJpskv3TjZWMQPjSLVMTvMFhkkwcPLCFzSMxVpYuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kE0qr6+s+NkU6kbX2NjzM1RAjPAbgSOUyyYyoAfQy4=;
 b=N5DPg6omn7BUQ5jwH5lbhdaf5izEK6IX634csULLbdYpewwDiLe5qtiejrxOP+PUiQ+WXOrIXBcVwWMpWG4XMuejsR0FSDyg+b1MSl6uNnKGJpI6oK4l9f81wf69wu4JNeProW/nVObhp6l17YxSqmHx2cIBepDmvcbRHCKFYdEw64z5346/4IANL4slugiOpTReYnITPiBe2HeZSuQ07nmkyotzJ1P/ITgvIXPwNnpCIGNCfiF1fS271xzeNawVzgWQrG7vqXbmyfB9dfYUU1meGjR0QmKgorMYlHAVLyRHxVJxCrTsT3nnQPC5YSxt8TXnE4ojAVXgZFG9lteGEA==
Received: from BN9PR03CA0464.namprd03.prod.outlook.com (2603:10b6:408:139::19)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 11:25:28 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::83) by BN9PR03CA0464.outlook.office365.com
 (2603:10b6:408:139::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Wed,
 9 Apr 2025 11:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Wed, 9 Apr 2025 11:25:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Apr 2025
 04:25:14 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Apr
 2025 04:25:10 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <danieller@nvidia.com>,
	<petrm@nvidia.com>, <andrew@lunn.ch>, <damodharam.ammepalli@broadcom.com>,
	<michael.chan@broadcom.com>, <andrew.gospodarek@broadcom.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net] ethtool: cmis_cdb: Fix incorrect read / write length extension
Date: Wed, 9 Apr 2025 14:24:40 +0300
Message-ID: <20250409112440.365672-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f27e287-ee9a-40a1-8922-08dd77593a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EoJ32aX7eFDwyVs7AS+Xi3GjSZLkp26999wBV2ybzJWUw7NXXYyu+kPyYFaT?=
 =?us-ascii?Q?3NGB4taHbMmbP5cDMXN+D3+bfDgTcjauYZ9MvG80RZdc2Vz54yLAz/X2YGcm?=
 =?us-ascii?Q?UBaUh+P13mPvNIR6ArFW4NtpEII6IjM7H8XjprXWPVwAk5LdUEs7nV3vYwvp?=
 =?us-ascii?Q?s5NlJum9YI+kIoXVL7i5uq4fHmdyx7ShuDyj2zVmYM+ljonXd7jmkcLJr+nQ?=
 =?us-ascii?Q?dZs7mKWYG5TX17ZoRA4TI+auE7vx/xdz2UCV3jYJ6KCs5eaVVY64JHbehioY?=
 =?us-ascii?Q?aKSIemMO28/di3DDgUrvcXEUNrFwqDpC61nh/j1q3yfNuy1cnabz43gf1Ohx?=
 =?us-ascii?Q?BKvTZp60kzUSMOjSAQJHyM69B5mZPWJEF1oq1R1iLK2kKHiLYudJuyy6jc0Y?=
 =?us-ascii?Q?RfLTgzwL3wZjw1Z0LzTFhELUhhd/wdA+L32NlQRgYhxC6AzyaGLjZ9E2Hx29?=
 =?us-ascii?Q?nWQaEqUJ2pSq8jTWOytb+MbVbYG8Nzel506zA+SwahAaVTh6HpVipYy3nsIR?=
 =?us-ascii?Q?JmQpHozPnGIl26Zfye5TOMlrYDefo/kAu9q6K11IQfd6ZyPXKtuzTmjd38gg?=
 =?us-ascii?Q?2j9s6GqjDwg6T0APIEbiBbMZUZV1bqt/g1ETYWVFIbFhrGc6Va/YEKw5MQ7b?=
 =?us-ascii?Q?6b6Dm2vl6rFypqV5sdgPzpyVZK+J9ZroLylTVE2Bv6Xk/kcXIs3QS3u6HQim?=
 =?us-ascii?Q?S1o3PKo/uWQS/QvWbacPschzK9hwgpEiV37j2a4va7tIo1VbYIRJCCAr0Ew0?=
 =?us-ascii?Q?FNrO7yCjAYf1U2rxf4iYqkATpU8nvDr0rRhq3FDrpAyxUU/E4WsrdjBoXy+0?=
 =?us-ascii?Q?yiT81YJk+bklqSQa1O3PDmscwJNu/wymsd7vNPi+JkJDIWQddukkFNsaiXjF?=
 =?us-ascii?Q?mYMcPgmrXD8Kmto/PfJM90tv0WREfXBGqO8RTBmzrTNCGXYHIeakiqNVhtIV?=
 =?us-ascii?Q?ONxIvLRX419TzPV2YI5WIsF9B+FL0pozWb9uMkyVDFwLm+w4Or70SsvCbIpO?=
 =?us-ascii?Q?RMy3MiNduwka3KME8kPC2uNq0RuBAhBt884UZE/Vq/QNpCIIJMvoGYvnXNDQ?=
 =?us-ascii?Q?Mng9CLv98d7CXSjiNvL+585spIil3NQmi1tRlrQ8LYeBqIQ0BUimOdL1bfTs?=
 =?us-ascii?Q?8SnXPxjVgCUzu5M1fgUwW3FS1ubp98ftWfhJVUnoG/bgezPOPzxuGESalB6f?=
 =?us-ascii?Q?6IHEjV3kTKhEWH3cZm0mg6dvP6XcS5t1P53RAdn1bp2ORlLCsP1oNd6Idiq7?=
 =?us-ascii?Q?smqBu+au2hPlStTvUCTy7A/SpDNh3AiRZNxjWErq2pFutquCj6IN4YRrQ5CQ?=
 =?us-ascii?Q?BtPqlIgEzm2cre+EJ0ZhHzCYU77dd5imaG1V3eNnFWZ3H81jzjsIv4sUNTuU?=
 =?us-ascii?Q?ZkAUTChj/YmWfQeL4Pp21WYVQHb2Tv9C/WP5klu4MLj+DHiKBTExUyjQ1zHd?=
 =?us-ascii?Q?GHKRwzmKtAQLFr1lYC5knEr70xkDy5YOblsFaBCToL0NlU2qK62T7NQEB3IS?=
 =?us-ascii?Q?XI4L4eOW4aVGGZU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 11:25:27.2424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f27e287-ee9a-40a1-8922-08dd77593a88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248

The 'read_write_len_ext' field in 'struct ethtool_cmis_cdb_cmd_args'
stores the maximum number of bytes that can be read from or written to
the Local Payload (LPL) page in a single multi-byte access.

Cited commit started overwriting this field with the maximum number of
bytes that can be read from or written to the Extended Payload (LPL)
pages in a single multi-byte access. Transceiver modules that support
auto paging can advertise a number larger than 255 which is problematic
as 'read_write_len_ext' is a 'u8', resulting in the number getting
truncated and firmware flashing failing [1].

Fix by ignoring the maximum EPL access size as the kernel does not
currently support auto paging (even if the transceiver module does) and
will not try to read / write more than 128 bytes at once.

[1]
Transceiver module firmware flashing started for device enp177s0np0
Transceiver module firmware flashing in progress for device enp177s0np0
Progress: 0%
Transceiver module firmware flashing encountered an error for device enp177s0np0
Status message: Write FW block EPL command failed, LPL length is longer
	than CDB read write length extension allows.

Fixes: 9a3b0d078bd8 ("net: ethtool: Add support for writing firmware blocks using EPL payload")
Reported-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Closes: https://lore.kernel.org/netdev/20250402183123.321036-3-michael.chan@broadcom.com/
Tested-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ethtool/cmis.h     |  1 -
 net/ethtool/cmis_cdb.c | 18 +++---------------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
index 1e790413db0e..4a9a946cabf0 100644
--- a/net/ethtool/cmis.h
+++ b/net/ethtool/cmis.h
@@ -101,7 +101,6 @@ struct ethtool_cmis_cdb_rpl {
 };
 
 u32 ethtool_cmis_get_max_lpl_size(u8 num_of_byte_octs);
-u32 ethtool_cmis_get_max_epl_size(u8 num_of_byte_octs);
 
 void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *args,
 				   enum ethtool_cmis_cdb_cmd_id cmd, u8 *lpl,
diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
index d159dc121bde..0e2691ccb0df 100644
--- a/net/ethtool/cmis_cdb.c
+++ b/net/ethtool/cmis_cdb.c
@@ -16,15 +16,6 @@ u32 ethtool_cmis_get_max_lpl_size(u8 num_of_byte_octs)
 	return 8 * (1 + min_t(u8, num_of_byte_octs, 15));
 }
 
-/* For accessing the EPL field on page 9Fh, the allowable length extension is
- * min(i, 255) byte octets where i specifies the allowable additional number of
- * byte octets in a READ or a WRITE.
- */
-u32 ethtool_cmis_get_max_epl_size(u8 num_of_byte_octs)
-{
-	return 8 * (1 + min_t(u8, num_of_byte_octs, 255));
-}
-
 void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *args,
 				   enum ethtool_cmis_cdb_cmd_id cmd, u8 *lpl,
 				   u8 lpl_len, u8 *epl, u16 epl_len,
@@ -33,19 +24,16 @@ void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *args,
 {
 	args->req.id = cpu_to_be16(cmd);
 	args->req.lpl_len = lpl_len;
-	if (lpl) {
+	if (lpl)
 		memcpy(args->req.payload, lpl, args->req.lpl_len);
-		args->read_write_len_ext =
-			ethtool_cmis_get_max_lpl_size(read_write_len_ext);
-	}
 	if (epl) {
 		args->req.epl_len = cpu_to_be16(epl_len);
 		args->req.epl = epl;
-		args->read_write_len_ext =
-			ethtool_cmis_get_max_epl_size(read_write_len_ext);
 	}
 
 	args->max_duration = max_duration;
+	args->read_write_len_ext =
+		ethtool_cmis_get_max_lpl_size(read_write_len_ext);
 	args->msleep_pre_rpl = msleep_pre_rpl;
 	args->rpl_exp_len = rpl_exp_len;
 	args->flags = flags;
-- 
2.49.0


