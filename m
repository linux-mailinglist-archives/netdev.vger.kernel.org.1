Return-Path: <netdev+bounces-113638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50E393F5C8
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4EDB22179
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4921494DB;
	Mon, 29 Jul 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QFIeFpPk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391CE148FF5
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257151; cv=fail; b=DyJVOCisxUbwgp1KeiBmZA96DR8aanUtGJSGuJqL3Xxhvh1NRnb6jUHrl2iYKyyWAPDWR+9rktFXZEWjbmkCAfWHP7oBfk3ukbtSiPx/uQYnBdbd5xjmQu9GqPwrI/+RTvhYCsnZf/SkF4yKYucv/m9cTTh+5caEQcGpTLWI2g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257151; c=relaxed/simple;
	bh=SXLQhrwB+XzuHxzvHzG751NXNDqeoh2rR9roFGA9/P0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gimBA4549nIalmk1Ak3cwBz180uL8OI1ihMX8qJ0CsB5uiNrK4fM/hvZ5GHOPi7cD7P+oO7P5yKvVlciK7I19B90G8m9UXGB+LUpLh9ALJeyJrRGSDwfJbdQlwj+s3Dxro9SONfD65W60v7HUydp/1L2fjbLcn9PkiYlVv2ImDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QFIeFpPk; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbYA3YmpQfr/1gXigW4SkQd6Oi6VZo8qFnxK5pE5mwFltaD3aTVMgyyx1e7tRsPQtQLXb+a7t2D8Zu5fotjzgwOlsJENHffVsjv/fl0+szU7pc/SrJ9Ji1lPdSrC6vo1LDQTdCU8d0j4/sn80+RakQ779/73oQEI31hsXoAn9s2pw5oNKVG97gejFrlCOGnv50zQBsjmeJTgSqf5/k5BmYdykvkuyktTM1jqEpoKRk5O8Y/PQJVjtcW8nR5eTk81Ly6H4XaQev+4w7bx6XE/EW2cRy7R7NyUYo2WYTH9LIMJ4kDEAplT7e1KCn6ugwUfAgUgNQi4qcCo8aKMJZxKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ni1FJ1GLA6nZv+3cdM9HqZxC6YISB8OOQP+2GA0uV8k=;
 b=T5kBfNo5EhMHo18TP9Nai6GWXhTmt+/bFy4U31xEPi+ir7KdYjcxXjv8k27V77lXMhhTO9p5eaOKw18+FBuH2oF6BOWSiNWRo481+nen9mtCoX+p7g2/fVLTzgCGl56S7tMjFfEBzCQz0vG46aJZisVwJ7SaAZeo4/I7ztfSRMGRxQlWc+pTHIFBtpRQwIxsYDeZ6ihhW8ZmorvOdJt7XNSlBHF5TfccWYSrlH7bG/9pypelXKbCuwi01MKEhNJ2NNwLKpWhd3dxXbrfRLIC8sxl+DVFpcvZBeDn/Kcv1eNCil4w4cpILWfHkwAcwLeamhZ04p6Ykeru/gnAaehmUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni1FJ1GLA6nZv+3cdM9HqZxC6YISB8OOQP+2GA0uV8k=;
 b=QFIeFpPkcPCBm3Noi0g/DesCiXjli4hb/aXj4KRyF4xJyVvxU1INhVxHariVYhwmO+44l5q0O2HuyzJoBA78U7ohKzZz11vn6rEmKo/D+bMfcXfQWaX8bIqagE/Omg3qhaX+ArISSPUNATrgL5HDFcDGJV+SuJ6AY4DMPJIGhARYpEzO1+ZXJElZmbOTs66zANu8/mqg9G5rXYzGQTCE4fB/JyuN+6BmE5uvD/0P09d/mc50FA96r93TgPxfy3NfXNaUp55n+qbnjoYa5ArdsG6k3Ry14/+Ffc/U2PQG6RV/QBazMOhi8+pJ143MAXdFPpZg9mqO6DU/F5zjgrUC2A==
Received: from SA9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::11)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 12:45:47 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::2b) by SA9P223CA0006.outlook.office365.com
 (2603:10b6:806:26::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Mon, 29 Jul 2024 12:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Mon, 29 Jul 2024 12:45:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 05:45:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 05:45:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 05:45:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 2/4] bonding: call xfrm state xdo_dev_state_free after deletion
Date: Mon, 29 Jul 2024 15:44:03 +0300
Message-ID: <20240729124406.1824592-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729124406.1824592-1-tariqt@nvidia.com>
References: <20240729124406.1824592-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 42db3353-b8bb-49a1-6380-08dcafcc5e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pH1TVkNn5+LfqkxIzJGr5Je/7I57T6jCFMog8qt3WmMUYuZ1qxUaKqDDYVs9?=
 =?us-ascii?Q?Os6rUNJGf7DAvyHEIcu1c0nqUESN5v/PH6Y5/QZ7U2da0NQL1VtjOU0bsWaT?=
 =?us-ascii?Q?cf0rfYQp8uSe7BULA7cCqdyUgrp6n/SUUY2ctt7IMNnx7TV/4tMgHIS5IKA5?=
 =?us-ascii?Q?olmQgZ+pyzhTUcp39fjOtx6wWfTLUAzrjAC99plGSb10+2QFatUybgNdiJBI?=
 =?us-ascii?Q?o8hfrEx5JlyDdP+f51LmjnqoP821ZxiEgT0JisCbAv0GYN34Tdgv1TcQmskA?=
 =?us-ascii?Q?2E6UU38GdJ1SA6vcDJo5xk1XSbtxz8VUcQc4F6wxK1d4h42uADbRQ7Yuhmqp?=
 =?us-ascii?Q?7FQ1b/XzuJ/mkDPXKA5JSCnxsim/dlruTe6mJcxZV550NLi8DDKifnLgUFbU?=
 =?us-ascii?Q?Hlywr6Lc5CoZ9u1vtkDEJ9aUZEMy7oEgmmUup66DR0AT/+xpn+MASc9bf4oh?=
 =?us-ascii?Q?7n7ru6orM3yPQA9lMXlGmcx7fMjgNCL5bM8U3t5Aai7/dN+iKXtovO/AK9kB?=
 =?us-ascii?Q?ZXQtiALi6LY0WXs653li2SwRHUu+ypC4DGvVgKvtgssm51a0uyEQOWkG5a+h?=
 =?us-ascii?Q?71FHUpzxob1WdzzKkiRZdLJO7kvNkO0zMMeEd6oF3quhtPCfTWRpmG+pl+2D?=
 =?us-ascii?Q?LXkI7urXcheL9WsB2bRNfBeNTdIn/MrdXG7lfAW4sZrkPaCu6TrFOQFaCYNc?=
 =?us-ascii?Q?dU8+bLut360ctSdgzqITcM+ENt4YWr9ZvO1sknTtmLNPIQ0g0rPyx4CSwayo?=
 =?us-ascii?Q?sZ0ARXdhlH80vhVWFTVGDsNk3D1tqspPAFxJyIiP5By90qLpvGVaueqSbsJc?=
 =?us-ascii?Q?HGq5AZENWEjZPuOWDwJ2fcD0/ozWkC3iy7XmeMOEN9NN3przwVt2JgskrG8A?=
 =?us-ascii?Q?brkAz8+UWHjKiSdmMM8shkG9qpOKdGo7E1jTdEiHNcrB1MmH6Mfa5a60yn0m?=
 =?us-ascii?Q?BXK+v7pZ3ut+GCsxUSRi4tdGKin7eV51aKu9vkrYCVABNhSRq6qjXMasqkY7?=
 =?us-ascii?Q?WMHK31f/6lo49etGu80YCGJSv8sSkPPZhFG7+UnAyRLvGbVz39yl19PQpzv0?=
 =?us-ascii?Q?aapFKWnK8cWhMDeoUq1ULhF83SYi0EPlIguX0izEP3Y4jqfy8lrg++vsOTbu?=
 =?us-ascii?Q?KB/+ojC0w6vjvg6cQarRkXbOQ93HV7Fi+oGJciLt0QgOgYhGFUa953lccJDk?=
 =?us-ascii?Q?HiJy7qQgM4sZsQRsEANBz1d1AaF1QWepybE8f8MNnzD7K0swYFDwqMtQ6l+D?=
 =?us-ascii?Q?iOxdmWbBY7APUDH1SGWsiDjOgUPuUBRtLj1OB89le+AwqbXpnTCPP7Hf49MD?=
 =?us-ascii?Q?3WZgBHIRFp+15s4yzt5qgvo7v8zgnVI//ZqDWfLRfsSTX4NzZUg1usbOilJ4?=
 =?us-ascii?Q?SDpb8r55MJOJzB/Mcos9pnCYVKMatqh3MFc+ZLsyK29Txc/Bz5nZ8Zplyc9p?=
 =?us-ascii?Q?ZaNFeftJE4hqe/kPHSQRafCGe7eZY5TC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 12:45:46.6190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42db3353-b8bb-49a1-6380-08dcafcc5e27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810

From: Jianbo Liu <jianbol@nvidia.com>

Need to call xdo_dev_state_free API to avoid hardware resource leakage
when deleting all SAs from old active real interface.

Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3b880ff2b82a..551cebfa3261 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -581,6 +581,8 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				   __func__);
 		} else {
 			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
+			if (slave->dev->xfrmdev_ops->xdo_dev_state_free)
+				slave->dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
 		}
 		ipsec->xs->xso.real_dev = NULL;
 	}
-- 
2.44.0


