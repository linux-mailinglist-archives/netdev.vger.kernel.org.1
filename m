Return-Path: <netdev+bounces-157793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A7AA0BC44
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92117188563F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0361C5D74;
	Mon, 13 Jan 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fcrn3Nx2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A11C5D6B
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782935; cv=fail; b=Weq1rfcmMdJ9+3YSAzBK1IeA9wRBTlY+IxhC8a6qQDfSZbzNuQ/AV8lWluIgHYdbz6EeYen5I/lycnWB30HqzccF1D+0WHAFQMsLNixbyr4dIUf/scAutKVYUbSqiJ1DxcX930PX/C1PHcMpvyYD6uZLHQwM9dkYrA9/j7RY8jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782935; c=relaxed/simple;
	bh=CeXHgYj3unOIPrLtdYLWxq6gaG6DQ4feGpilYv7hkws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jU/A7cds30IKqibf6Dmabie/LHN09Hd31BlWznLhcan9GMNIefqyt+bJKluNu3Hm29w7xKOcC+3ZonrGcAytYv4IG9q0Z97w7j7uwu7VsJH57kq3v4CKYPGAAmpV7bbrlVdJUW2WoxAsVamgxp2WvNyS2aO1dOxnao1CwmS/3Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fcrn3Nx2; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbaYUYvcL25OQGvBtDtg8ma9DZua20/D9G7D79TseewM16heBzp0dAXm4Gs7LvJKlq0QksEuwE/UJUSxDLYZBjlJ2a38N3kBkVOHZshxba9j8HxRFJto5rby75XV7v1iERSh83mHCfRN95Iy6bDOJOFAlhV+oFP/nU2+cxG9h3YjRfXiZy32NPJKyN5GeHmHRuhnA9rpm2LYTYoSzThiOAflwD3xm6gDU9v9ja1lrrzEvST4lCaiVBrTHXQ4YzzQtV6F5JyNVvN6ElpYq2sx/KXdGqMQNqRBCQvjLzcv1t3zhEyURpzURcALrpn+9X9+agPoHkUU9QLY8tWXliUw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw4B3GewTDrgtoU5MMreRaSjAd4Un5o/edkqHNsvPJA=;
 b=xrujdxtZJ2pdy9PPMWpyxloI9xfcN459OwPxPwavhowCBjtBq7SoPOd+ovWmwqYKNFDbpwYWfsluBTCt5kg0bQx1ey8zWOuUBD5zJ6WCAEZtU7FQuktWadURvsN34DEBMq+rl8lgATGkxyGh1ZKkgO+rRymFQ0+KpSaCxCCx8LGrsOK83J83vxPnoZKGtamZcWg56tgxXc6JH/GTre7t/mwaUYAc7hHtyRSGny9HTUmcpXtxXazTNZxqt9eg8XIgOWH/UJsry53xReMoJLv1ELmuXf6gAA3+4zOpM0wlcjGQs9MqWIgt7/EJfRBNUwYP4ugVYKPBjrlMuB5qr+mTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw4B3GewTDrgtoU5MMreRaSjAd4Un5o/edkqHNsvPJA=;
 b=Fcrn3Nx2Ei/3A1IcteLE8FymRvIH3FfsF3hXkBkKZIMfzusceqTyz4ygwrtl3QyoeLtP7RcCun1pwVCJIUg0BX1VOLdTcXEwLY+XeQDpFgylQbQZ+lsaoFYVYYGPzSV7dqYo43veIJoXJKn3G0yRtfiJZDt8yg4J5qxIwXSaLGue0wkPYTAheFrbHeI827zvxFtH2eUWLylYrqyGKFy2cltqYE9T8m6TeHpL+sdsLTTVskYBEoZpLQHK2AL/Wfg4TOLcdF4o6mYO/qZLf3J465RL9/Xo7A9d6sY4FkYNOK3oBqMDg+ky17qV+2MI4ND05ToIuiP03L4eg+ewg0dCVA==
Received: from BN9PR03CA0549.namprd03.prod.outlook.com (2603:10b6:408:138::14)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:42:09 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::6e) by BN9PR03CA0549.outlook.office365.com
 (2603:10b6:408:138::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 15:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 15:42:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:41:54 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:41:53 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 13 Jan
 2025 07:41:50 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Shay Drori <shayd@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 3/8] net/mlx5: SF, Fix add port error handling
Date: Mon, 13 Jan 2025 17:40:49 +0200
Message-ID: <20250113154055.1927008-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250113154055.1927008-1-tariqt@nvidia.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a8b07d-add3-4bcf-d89f-08dd33e8d70a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?erkz555mVRfuNP6iH2H0TI/mgN6skjeT6tCGyPjCjrHyTaVnXLINz9gOmwEv?=
 =?us-ascii?Q?JtO/8Wq5iHMkeeATbbDdQW3tiYqzwXsgfBsO+3TeNvA5U4JY4kpMcjSsOsoo?=
 =?us-ascii?Q?oqyrAPioQA2gP+u0EerUUPxb06xBteP3wUz4INMAgKoWhgTMwK2Jhrrl9VJJ?=
 =?us-ascii?Q?bYFWC5SuqrTbE80mPYNALTDw5ii02i3yaOiR0GUpor1/8u0MnXDmkTgjyyO+?=
 =?us-ascii?Q?gBK0rRIeIZEDL/p9NGXf8Pe/eT0Mx1cBGh9VqNX4IlMS1mt0dRQiMtkNMcFi?=
 =?us-ascii?Q?YtaeRU+lcOpONncmkwxnb2JCKJiixvdJmRIVv0iAX1tIDQtN0+D73zRbDrF0?=
 =?us-ascii?Q?eKNLqLPeU/1OXg2AsRdKXh0XpuWJDHy3jst5NKK5JITbOyeo56ShgP7fDCXz?=
 =?us-ascii?Q?3PvFGnEVlfW2HMtMLZNwVYUxnCIBin3W5oRtyhI4+COiWtcPsgB8WoW1p8Pm?=
 =?us-ascii?Q?PMg7ylqa2KVeEYaMHvRGFCZ7r/o+JiMQqin3GCfHqhFDzV+MRco1q3ojvsWV?=
 =?us-ascii?Q?zvsgvJHRTax2oCluS6HHdYbG/4G1fSuZ7ZG1L38JxdAIiWeuAsXPaGmvmcfT?=
 =?us-ascii?Q?g63Q9R6Ekvra14IU+FW9ljlgowBU8LQEp+VpzJnC9njk7Zr8OIoziyQVpsiY?=
 =?us-ascii?Q?Fl1nDgdvWGgHJS95r6FNc3DiLWCffXE3TVFZlHlej6Eemk9UogeRJMmyztWB?=
 =?us-ascii?Q?5WziRc1o0vm2lt8wcIJbEjuzGThTYDT+UX+qAMilLYS/ukdIxPy2XYmL9jkv?=
 =?us-ascii?Q?Gtjy4NnTAtpaE5/sassTWpVJCngqcP+zlWSBHWoFXJUvHPzp11umQIB2XBjI?=
 =?us-ascii?Q?vkTpI4fMc6zjAV6ooTksR4sUBtgE0r3NfuEOFPcf4uCWliMOWPEiKYtZeRox?=
 =?us-ascii?Q?3S2EcAAS1qlq5hQX+BMVOEW2S8TmIMJtQ1I/ykcI19C5V+30tfdcoA/1mPXk?=
 =?us-ascii?Q?kWRDvXhMDvj3CwG2amI0yTvjuHIzRoHAiD7EQkHXjEzHrPvugcxYDGNeOANp?=
 =?us-ascii?Q?RDXExlGHQdRNUValQeoHEHzD1kx/QE7aeRJDpMUk+Kw4ue/jaO91zeD45Jkz?=
 =?us-ascii?Q?o6AT8VNypUwCvoEbwyYN0UlAgF1OxHRmWqeN0vToO6vQBzpEAxhxgFX/TEiK?=
 =?us-ascii?Q?O0D4eVb4XWS7zWRSFpHpjMYIY8sJXBActrblzH+OmsNWRr4aI0OVNvMfB2La?=
 =?us-ascii?Q?udZFe6XXxZHTsSxHlmYefmI+xtxpOA1wwrcm2/WPbsaOu4EIXNeBgiuhK8l5?=
 =?us-ascii?Q?IrBwQLE/ED5uOgM7j3VtyxSnHMzM0I7TlrkWl8+cBo624Cqx0ywL1q5OVstD?=
 =?us-ascii?Q?lENBKGqN5qh6o0tLpD6OjY+YtiiMgptrJyG4DX9wDZ3mnaTXZs2WdhzHR73j?=
 =?us-ascii?Q?piBkvpjdH/RnnN2dnxixJaSxlOshbmlczbD1s3N8hRikVBaeLDkb6wNo64li?=
 =?us-ascii?Q?B0ZgMWBnzi81Qx6BICxJdVfSiCR6xbgGSOKXc2DoulV2yRf0Cd3wAtg6SrWR?=
 =?us-ascii?Q?4AQs/F5DBVKgdUY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:42:08.7063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a8b07d-add3-4bcf-d89f-08dd33e8d70a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015

From: Chris Mi <cmi@nvidia.com>

If failed to add SF, error handling doesn't delete the SF from the
SF table. But the hw resources are deleted. So when unload driver,
hw resources will be deleted again. Firmware will report syndrome
0x68def3 which means "SF is not allocated can not deallocate".

Fix it by delete SF from SF table if failed to add SF.

Fixes: 2597ee190b4e ("net/mlx5: Call mlx5_sf_id_erase() once in mlx5_sf_dealloc()")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index a96be98be032..b96909fbeb12 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -257,6 +257,7 @@ static int mlx5_sf_add(struct mlx5_core_dev *dev, struct mlx5_sf_table *table,
 	return 0;
 
 esw_err:
+	mlx5_sf_function_id_erase(table, sf);
 	mlx5_sf_free(table, sf);
 	return err;
 }
-- 
2.45.0


