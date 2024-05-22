Return-Path: <netdev+bounces-97630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A398CC72E
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B294B212E2
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346121482EB;
	Wed, 22 May 2024 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fLODaJ6L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D5146D68
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406109; cv=fail; b=pmVXldrBgoDhV+9EZbrAhZICbMtl6HTJETP2XX93kYxDa+q7RDV8/p+B8nPNJmS34zhhVz/88/dUVm/6TVH/4RL7l9XLjQVHlik7aBD0UMQLVZWloCzAuf13fKYVFR9zR6oQFQXvYxVEtJTzzelmdwTEYjzOYEYzpqi5STmj3UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406109; c=relaxed/simple;
	bh=Z5IrxwQK9WTjgDckhvKUBsP4LwfzVtPSAaIcOAtAyZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hf0FCQGOfukBFTKBgmlAFhFvJvYr+3AA3TNMmze+an1BPMkwj65w3oZeSo7/w7Kt254E8X25dvu/HXShO4/FNRZFgDZ9LwECibjpMU7GrPVI6GCTu7OtBL5Ztz6jbjWsjJQxo0Q+8OD988+K5d7g8cgoK0Wh6xYxMEmogMi+oYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fLODaJ6L; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2oguwyQAXXFJzXXaNyANbn6gBNUS8RzVHM7LooEeMVKkDcPSVQdvvROHjKDgbE2iqSeBecFxA3814EZpZqFq+/1lcINx9kbOssVLv2u9r11LHT6RNlzFp2tujqR0I5EOY+fc1lrl1OhKuc3xkSZWQy8C36nfI/gb4x6iG+6hobEkebZBpTFb7WBzoT97Ut0hEdjPFkMeaCJ2xcLR1zX0RnkaCNh5HARlF8m5xkMvrLXt/3fU9C71wnyHSRX9XmjR67yegPAMhtpmJnQfczwXveW6Q0rQtYlWP3IKWCNbPrsxxT/ligAehI5VsgH+uyAMI/sXC1vvWy+snHuswDn3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyHB0T7xCcsnOCxWelGJRVW45IHeZKZvIDfrM6KIVcU=;
 b=EOcwZeKaOp12mlBzBEDE1b1o8tYLkLtZnHJCt76Ltt+crY1/8As2PygO//EquJ0qigZ8PspcUE2Os/QY/YKsq1oGeRhex3+VfmVxiQOPdvaLEpPdCw7UuGWmLI+yLnEyY64zJJpDLtuLCzEQ76pSV0Si4AIUcLtto5tYSmkKe/OLTGKW0rAcGc66GPxQX2vUkfgFF3yiBk2WhjzUT+z0+Uax9j0spdYOcJ3BC9ddRaL7mgLDhvAlKZU7Dz/S38jUYkcR1fKauvgx8CzoLB20ahndKk4et2ZyfUtb4y2Qm8h5xqbnDeFw+as9r5LD6t2YmcMSQ+T6cKS5uzTX5iic3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyHB0T7xCcsnOCxWelGJRVW45IHeZKZvIDfrM6KIVcU=;
 b=fLODaJ6Lg+OiMLhR54/o1XvT7gUhPCBO2HojcNMInlzz9H64eai9o3qnIp14JRtujYamfciT1YXd/Xhah70+9UJbR7ozFTB2xAVgLnhDVlnreiXasZWlmfnysaFZvfS8Qydp6i6B2BAQR0fZDDoFNbs+cfyLMmdsEg6dq7u952a9gFZ/egNT7ctS7t+oqGot47bknHnoKeyjcuZGGKpO/b6I2X9gs3Pprq8eJukpBoDQUy+77v/j3covBkesqdc2X4ZcmzEq6bDGTq9RNkdps15DmVJLgKIJAK3mXYBSrRUZPjc3+iOPbwlWrycm/IN8/DTputUXKa+E4iU8LaZaUg==
Received: from SA9PR13CA0027.namprd13.prod.outlook.com (2603:10b6:806:21::32)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 19:28:24 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::29) by SA9PR13CA0027.outlook.office365.com
 (2603:10b6:806:21::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Wed, 22 May 2024 19:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 19:28:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:28:09 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:28:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 22 May
 2024 12:28:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 6/8] net/mlx5e: Do not use ptp structure for tx ts stats when not initialized
Date: Wed, 22 May 2024 22:26:57 +0300
Message-ID: <20240522192659.840796-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240522192659.840796-1-tariqt@nvidia.com>
References: <20240522192659.840796-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac62246-bbd2-4ceb-8bd7-08dc7a95590c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7G70XtI3y/Pmo85a6Y11WMVIPHIGl1Le/NXOmt3khyilpI9sW1W1CbtJp9fz?=
 =?us-ascii?Q?fyVBrUniYdOK0JsW8GMaqbMhjG883bOBhCosPCQj7ewVxli3EXJbylRx/jMb?=
 =?us-ascii?Q?znimrbADbRXn4Ozqk/zrWtuHuu+de2k7YQ31/wRstmI/xEhdS+YzzwIwf3Do?=
 =?us-ascii?Q?UOk5SuoaQv7EhwMTiy7lsQtxVXP9dB4CRZUezZKt14AWQf1rtLE4gEFH+7ss?=
 =?us-ascii?Q?YImvvPgSrQOMBq2b9QvhciNrfIxTFsdKWeZ/HJZ7la0cge9uVfwhY5Nr6edx?=
 =?us-ascii?Q?j2ZQMgemr4liR6H5lRygl46f/PjrbyFoMt5pX7LCXlTm2MmAzWXAqCEfzcPx?=
 =?us-ascii?Q?Ru6Dpjk4tquMglqMZeXPFEkbNN3QUmw5zjqZH6TJwh0MkBoQ5jswtqwKuhHw?=
 =?us-ascii?Q?3n7LV5NkJe//kiXabuCMOjAKYrOOSuohggQ2O/Vfc+V2baerd4Pj2a12Yq1A?=
 =?us-ascii?Q?yzMgaaRmC2ieQ37bJooFmCB7yPq52iPUQSj4XpWmTFk4sWYUs6T0vJb6BgrR?=
 =?us-ascii?Q?I3AQYvbRAYf7VCGrauqZYpMqFnGXevVRxTR0nT38fNRaTXuYEH+6TP3Bb6/U?=
 =?us-ascii?Q?iEvpDsa6HRVfPXQmReRjor5phVU8rj+ETzsTdv98ClgP7GABhU7ZeSANx4CW?=
 =?us-ascii?Q?cPA1StcSm1HS9mjAKVVS2lO4lsAcH0+6aag7WWHQmW308wI4vaonaK8BK1SU?=
 =?us-ascii?Q?N1tNQVjTd2KCI0eSeCuckmcDP4VPdIt/bPbNxZIlPJfVOQiZ2MsEZ7ruBf10?=
 =?us-ascii?Q?kgtMAUSB+i/vJjPHZc39eImdPj5SP59xMd5A7eBdZk7ydG3PrvFzpBU2Mpam?=
 =?us-ascii?Q?9/dQpzeSZiupR6kw1Vko3TtV+gBNnthWCmRyuEHf9fobS7CMJKjHseCEChtw?=
 =?us-ascii?Q?0SrRcY3INBdZNkUuDdcgHxhIvTvxHg4hddH/3Hl0gJHBUQ6Qc9dzoEFd2DXK?=
 =?us-ascii?Q?UqWHcfwBbKB1Ij8BekR4Pb4CAC9VnSBmmzNOui6YhPj2idrD+UENQjbvbKSn?=
 =?us-ascii?Q?sCVj2ChzBbRGO0UtAbQTD9BQestVyNYipvX5RyITkCDtNMCA5KcwnUMk6rjf?=
 =?us-ascii?Q?qPF+I2il/mBrufPX9LerA6+UhFY18ruFRgwY+PsSO8UUg2P6StJMjLJCQTcH?=
 =?us-ascii?Q?4D1ersQyRWXL57T8TUZswm+IZtdXO67Ywh4YJMNZEF39hUQi+C8/mAF1uotN?=
 =?us-ascii?Q?SqusGWwLHNgXXbrYgxABPHTdwmYovZ4jS6qgIBuuIgLSBrdgwICwi3Kv8SPC?=
 =?us-ascii?Q?OoKqc60vK/PHRr9D09ptHimiCNPbh4Qhft7BmQSx5pTLZBX6HwHRboIpznIK?=
 =?us-ascii?Q?oYQ2yeTn7/Y60ydh1ZLPEru2TXXNyJa/RqAvS7w21PgdaKSBFSYASE2n4E7n?=
 =?us-ascii?Q?5Ck3Sdg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 19:28:24.1071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac62246-bbd2-4ceb-8bd7-08dc7a95590c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

The ptp channel instance is only initialized when ptp traffic is first
processed by the driver. This means that there is a window in between when
port timestamping is enabled and ptp traffic is sent where the ptp channel
instance is not initialized. Accessing statistics during this window will
lead to an access violation (NULL + member offset). Check the validity of
the instance before attempting to query statistics.

  BUG: unable to handle page fault for address: 0000000000003524
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 109dfc067 P4D 109dfc067 PUD 1064ef067 PMD 0
  Oops: 0000 [#1] SMP
  CPU: 0 PID: 420 Comm: ethtool Not tainted 6.9.0-rc2-rrameshbabu+ #245
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.16.3-1-1 04/01/204
  RIP: 0010:mlx5e_stats_ts_get+0x4c/0x130
  <snip>
  Call Trace:
   <TASK>
   ? show_regs+0x60/0x70
   ? __die+0x24/0x70
   ? page_fault_oops+0x15f/0x430
   ? do_user_addr_fault+0x2c9/0x5c0
   ? exc_page_fault+0x63/0x110
   ? asm_exc_page_fault+0x27/0x30
   ? mlx5e_stats_ts_get+0x4c/0x130
   ? mlx5e_stats_ts_get+0x20/0x130
   mlx5e_get_ts_stats+0x15/0x20
  <snip>

Fixes: 3579032c08c1 ("net/mlx5e: Implement ethtool hardware timestamping statistics")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index e211c41cec06..e1ed214e8651 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1186,6 +1186,9 @@ void mlx5e_stats_ts_get(struct mlx5e_priv *priv,
 		ts_stats->err = 0;
 		ts_stats->lost = 0;
 
+		if (!ptp)
+			goto out;
+
 		/* Aggregate stats across all TCs */
 		for (i = 0; i < ptp->num_tc; i++) {
 			struct mlx5e_ptp_cq_stats *stats =
@@ -1214,6 +1217,7 @@ void mlx5e_stats_ts_get(struct mlx5e_priv *priv,
 		}
 	}
 
+out:
 	mutex_unlock(&priv->state_lock);
 }
 
-- 
2.44.0


