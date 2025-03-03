Return-Path: <netdev+bounces-171218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44A2A4C01C
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C7B3A1EEB
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7FE20F077;
	Mon,  3 Mar 2025 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PtKJ48p7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA7A20F082
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004408; cv=fail; b=gnJ9OsyRHPRavkLgX+5B6un2wdM1aqKvEQwGkLqu9rtcspQ1TmKq5c+XbvoTF0jduWU4Hvy7maZwQs6L8ZjErgDfBIGBOU2Pz3FpTRXFnVJQqJe7mUs+pNR3w/qZtfpY6XDVJ2Y8iFCjjodlOgzwbWqY6qt09PRnkpUHPeggjr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004408; c=relaxed/simple;
	bh=Lj+LBJNdBI0K7GTONRGzjPK1Cack2/aAUsVK1eTWQmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0cKiy9jLIxqqLLa8m/Q32bSUnpjbHQJ+tdzkXL7AovODIFTxrkHSRn8f/M1qnh8K9Ae+sCITgea6CCnwgEbyvvx2wLzoJH+Aav22T2AEtM7DUK9EDqva+LhBTwwAYjiJx9xN/IC3fMq5T4PVyANQZcx9NAtW3nLZKBYvzNoqDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PtKJ48p7; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NY86ZELtToj0UJdcrEdbVwLT6ev7bMoIeAKDMIwDRf/MCPhiq7PDvrHrr+s0nLzhM/Xm7JKAhl0rC6LDxv+Kh09eGwz/kmw5JL7K6f33bAz7dnhABxrf+Omh3nUBHK9ZuX5AdR3a68T1Hneadq3rs8gTaZLiCpvYAd7no1ogSzlLYXB+f0fFZ7b415EMuoqMrUh2aNpQDgYuTQe8GdgQeoCQy1ABOEggW2F0dW8R4OryZ1VcJkGczsqenf8D4IpWfY6OwA2n9voNB2QW1VqwSnHeJLpmmfTFmiqGn5NChWCPetHYBWZxnn3kcDfBofr0kJuFK16qRUrYpcTEHpfUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lxhj44zQ8etqoEyUXg3bzp+mu0OyZgd7N+dVeAHAkZU=;
 b=YEVMsC9v9OY/GQZ/l7BRo92JbVzTVDanEQqUJpKq4Hext0kLC62SrcqrUQ87TIov5yxOaFvsQFfiW07+3xqZ+F7pht3vf/DOPuvJlb/Mru6jN9VefFXqg2P1frmevCVN3MihxC+k3THVv+u4b1PfMcHAPhcKqtMdOvU3utbYxYYb8rTpzk6q34SY5WgiHEGgbDzcNsjj75I+W7C1xVHJ1vG6iMTqiEwYC6zFai5i+gd6a5EcUboa3YoGj8r+ffru6YohFX51IAd+6+iiFEABd6oJsyRwNXi6GuI7D1FEjiOqiAhdqgvOgBN3lc7O08SnyTC9epiTxALecgz0zsFwhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lxhj44zQ8etqoEyUXg3bzp+mu0OyZgd7N+dVeAHAkZU=;
 b=PtKJ48p7lSvMkdy3W26zsD8IIaB+vrM0uGUH9Nogbcrr9VMecJuJiEmr8BgH3z9S/ujSLd6yHeGQs8eC4eoc2KusrFAjlN3HchZ+mhqebxYSaR5oBVX7+77KGpAG5oHHNFDJHZVxX+4aPGJOpXfTN1ZXsJpeNv+BdP/O+T/iut1SnCr9ccOXpPoMpnFOjloaN0SjtJrzB2D1O38VK1ZdERvjVLjk6eXyIcZwEn6CQtZh4uS+VoW7srIRPG8eIcpvPanuvYm10Pky7w19zUPgLBPzIzz7dW6iRBnnZiSSq6Ztq7ALlyLHUnpefyIJlXJUm3W53zrH2SU7UyM3z8CF/g==
Received: from SN6PR05CA0023.namprd05.prod.outlook.com (2603:10b6:805:de::36)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 12:20:02 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::4a) by SN6PR05CA0023.outlook.office365.com
 (2603:10b6:805:de::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.13 via Frontend Transport; Mon,
 3 Mar 2025 12:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 12:20:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 04:19:50 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 04:19:49 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Mar
 2025 04:19:48 -0800
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH ethtool-next 3/6] Use RXH_XFRM_NO_CHANGE instead of hard-coded value
Date: Mon, 3 Mar 2025 14:19:38 +0200
Message-ID: <20250303121941.105747-4-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250303121941.105747-1-gal@nvidia.com>
References: <20250303121941.105747-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e0bb78-2f9b-4671-de31-08dd5a4db916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1sq1y9mIYMGqaLE/pYnmU9bmKfjiJewLD5xG2MT4e457IZoXSKLhLDcSMJDb?=
 =?us-ascii?Q?OWavXhguBU6H6XbxWXKkbA54cXnqO36sbq8ZB8+2+Xz3T+o9qyd2czjc4bb+?=
 =?us-ascii?Q?+Zk7qc3SWpSl83L4k0jYBcqu+jt8RHEpwc/bTrAASPUMO+tkUY0uJ4zXWCT2?=
 =?us-ascii?Q?1EYax0oQUKRjqXxm6qfRMjel18vTyWrE/Bej8Hd08CAdriE2jmfKDSghh+aC?=
 =?us-ascii?Q?c75Nh8WBa872M613AYj83kwooiyJl62wDpNZZuTPJSuLSPQ8WNXqvtRabmhl?=
 =?us-ascii?Q?9ifD7voyNqV+yB2a3xZjPNDlq7IADheL0fMt3MUP8lRug2bL/ammTCT4vPB+?=
 =?us-ascii?Q?p69Jwr1j3m9Eo5wamOpQ9X5aXqNErI/giFEX3/Cf6vvnJYFAJlnfw2ObzdYb?=
 =?us-ascii?Q?Y9lZIbuRNeuRNqQi0NPwjy7VZwI2/bH+OOotDZD0WJOPceZRd5Hy15x5bRJ4?=
 =?us-ascii?Q?14yybUA6kOmhYjQLDua+OOt5f430jGDv/4UB5Ja+siBqRFuc73bgo33hflAM?=
 =?us-ascii?Q?9S7E0qSqQFMrfMtq5MmTK0ZvLyD+DLGnTk+hXxrsKsVSfJWzLOj8MGbpmPYU?=
 =?us-ascii?Q?Pq3yI7agWOxhKDzqzK2fQ4A7vwopPaX8l797RZDzE+xAkwkjnufb2Tsxr8nX?=
 =?us-ascii?Q?UEM4bQbKFo0+DkXxcOrzkT4aefyWnLNim6RmptW0dMLT+mS5nozfE/TEWOIF?=
 =?us-ascii?Q?i2w0X+T8YHlYOPX+T8KRk3tPTnsYvhERlKAqBrxx6Sb/IaBeoW2peNuYfRRA?=
 =?us-ascii?Q?7B/2J00tJJ9k1Zi8VMaV+ryzBrSCc35fBECpoc0ilwQaA7/s4gwOsJvoQvek?=
 =?us-ascii?Q?uWWlS8GHBvMLUVblQ00coQExZMiwPG12XP3yHf0spw+aq/YUNJfFucXG1Fxg?=
 =?us-ascii?Q?Ek3aLUW5MSzA6YZ/CcRPGHfYh0AZiLhUxlKF4SZuNw694fkvhPQEqQXEclCD?=
 =?us-ascii?Q?+kVcl9vy4GGXVukoEE130hUQA6Yhbbb7CTAe8kVDGnENeJoI2MzKRE4AKSC/?=
 =?us-ascii?Q?3nP1QJDu2EnfrXFJpSzyZyGON87NRe4Lt2WHfEt9hW7e64oeZRmKUaSVR3FC?=
 =?us-ascii?Q?YA38Tw5xMCSHS40vlzxXb/uAPlxebMDEv14TzoSo4lwTBtLQfnXrR5e9RL2r?=
 =?us-ascii?Q?2ps1qE862uCkFKhPwL23MwVgl6Bu6mh2vSSCQVvkpvvY8GB1qTplLi9rj5lm?=
 =?us-ascii?Q?J9jrfonHlUVxbGEYmZV+E33ZWMLEyee0uaNxdDrda4OhjXvKgEHjPfyFqI6o?=
 =?us-ascii?Q?xvBRkKmA7QcI/RJttGLosd4W52/xuDhhh7eKUTKBdtBeMGNwMN69+hQnfqAH?=
 =?us-ascii?Q?4hHoxgUtMvcC8yaWjK6Dq8bdLMrbW2IJSScFNDyo3ZcHa9IxB0xTE6W+pgW5?=
 =?us-ascii?Q?Dcm8MlrAFGoqBdkl2qceaslcnVhHcAHo6ACKZbif9e2szD6TvJ0cXMUOMq0D?=
 =?us-ascii?Q?R+svrTZHcjiVrGP9nZjcWHy8IfZ7NhVyRtTzFKpY817bYmYLPSVwIMLzjjoz?=
 =?us-ascii?Q?+w6vmcTIhFJ4I94=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 12:20:01.9181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e0bb78-2f9b-4671-de31-08dd5a4db916
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685

The default value for 'req_input_xfrm' should not assume that NO_CHANGE
is 0xff, use the macro instead.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index 712e5b4fbceb..1c58dbf1c379 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4236,7 +4236,7 @@ static int do_srxfh(struct cmd_context *ctx)
 	u32 arg_num = 0, indir_bytes = 0;
 	u32 req_hfunc = 0;
 	u32 entry_size = sizeof(rss_head.rss_config[0]);
-	u32 req_input_xfrm = 0xff;
+	u32 req_input_xfrm = RXH_XFRM_NO_CHANGE;
 	u32 num_weights = 0;
 	u32 rss_context = 0;
 	int delete = 0;
-- 
2.40.1


