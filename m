Return-Path: <netdev+bounces-243278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9856AC9C71B
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8032D4E05D3
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFB92C1788;
	Tue,  2 Dec 2025 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="idOj9BvB"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2201929AAE3
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697498; cv=fail; b=n/C2H8wttGPPK6SO0CA374n/AWDS95SHyUViJfEMo/qv079pR8akFZcSNYs+JjzYzmF8S6s5ZsGQPM4e+ejqlOXwZ3ZiqNf4JrAtLr3CbXmGX8aq3r2sAtCZ4GkZvohRgThgnEZJoOVJX8Egk7ZCBkrCjx6SlUohiVKzsIZdMMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697498; c=relaxed/simple;
	bh=3Y2pKSn9NvHMHo3pZFF/k2JZlS8pYZL9cHMxGbrc4GE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tBiHzludtRA53MYUVvy7K/Pxk0SFnoL6UjZ5HUNi5NTQZOEv5GASavuV/V6PRj3a5nmuYZmC2g9oHqOzkYPnqsOKcyV/zabOgghr4tv1mq3gK60qJUNI7KBPB6UXoTwPIT36xYbS1MQQ6uHBJRLJA9FmQGbSw6abjLR5W4GPn4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=idOj9BvB; arc=fail smtp.client-ip=40.93.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCqh0P5Pghm16rYVy33/Pe8kvmgjHY3Js2mQrVRJhlaiwdVxhHHoWWdVmpNK+eylBFUpd8ys+fuzD5eo1tyObmNHlYE/ht/ciNCLdbeBZyosGi0X5TYwCRTM1S6+xUvOwY5W7g9o4HPiz50kQZWWwpVJuSBwQ1IVCUJhVTEZpwGb9hHWhWq7wid/kQRqWAhG1mZJZtGzjxmkIfdHyrmCE0ZZmpQ/6o08YDa/LspRKCeB7DEawfyeAj4guhmwikQ4ceAE9taXW9GlbJhKhlqE6gW2uzVmGG2zaSGslN780AbUbNXq4DEJZFLerlntacSL4mTvPJooQHSMStexELX3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjzF6yHH9K1rvGff9/1ZU56aKgCUtXmkvWjBo07k84U=;
 b=iADwBmX9nXekijfyglz0bRmw4B5kutK/OWh8BMgT6AB7dkXoridxm8yfCUDSQSo0KPJWcWaBK8JIHr/EbwywX6lmobJhVIK2SVwNrT1vV7eB68fRcDoN8IAFp/shEnXctIbzq6NwPZ4maNOjbGfBInzS82rRs3GisydcRMjNLTnsk946V9dEb/LFKS7JrTR5Xk5twPAipG6rLfHblvQKzm4qq5yH5S0Up02fJL4YT6C0+Hwmj2oz5RE7+WnBfkwFXJaTrcrqRFf3XWjgvlOcPHXGI1i0LZUFRn2XOBjt0oJHovuC2+wF7Au/hTACooHNNJoba6vFClypunUloEK48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjzF6yHH9K1rvGff9/1ZU56aKgCUtXmkvWjBo07k84U=;
 b=idOj9BvByYVuUtv+yV80JAMRv14aFchydpS75e0+ea5i/4uKlbRngzsj0t3bHHTMQ/t79VTgfa2McFLHRwunDuqsUjbO1moMajFww/3UQ4pqxF/J+SLsDRMRjTqVKe7KoZKMx4C5ykdRWzjrK3Vv6ICBfTbHR4nJFO3fxapFEXh31BdHzCbqNwX/MUMs4EpwwSGn1fsWxeS1swNqeXJD7Q7jo8B6/bTYqv25SJ8ZeDuw1NCE03BFnqikd3ekGdk6qcjkfl2lYxYtN/gnYwO4QGsb46VJIZIZYU4ZgprFs4KLdjWB0sEVxjK+hWgIKb2k0xst1MPfu7Gl6sHZxyBvQw==
Received: from BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 17:44:54 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::a6) by BY3PR03CA0025.outlook.office365.com
 (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 17:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 17:44:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 09:44:33 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 09:44:29 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 0/3] mlxsw: Three (m)router fixes
Date: Tue, 2 Dec 2025 18:44:10 +0100
Message-ID: <cover.1764695650.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0312fc-c6d8-4ccc-0daa-08de31ca8047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p95CSvUk6XwIyD3CFJpGOgdtblFXFFyxs/CKsHRSTueUcxPGK9dO1FhxRopL?=
 =?us-ascii?Q?iMQUdIZxWcKQX2MEeyscHMvGBT1VK4mrVgG6Skh73qQWvpwDOoT6tCD1krg7?=
 =?us-ascii?Q?3FJHtiOG29VUGPpwKQaEgIX4weFcOOZ1YZQp8IBNuWM11+ATgIgCb7pMqr6c?=
 =?us-ascii?Q?ZlpKgHlHZRLfdjAygZ21n/WuIRbHiKQMIeGCVY5ouh8MIF2EIodHm05rZQpA?=
 =?us-ascii?Q?gFkmncqhUF7zVYe7py8k6rYa4fBC87GIJjorjiDIYU2HHDmL4vcBAd9Y/EMv?=
 =?us-ascii?Q?ePVIFCQjL3B9IEYDpBwNvkFSX3GXokPhmr/sS+yXmw+EILb8puUvbGbsfGm8?=
 =?us-ascii?Q?Uc8yjVrmGiU69juvWv701dOk+J8VN8sbdMvZAW3RLFLtntmgVuzjEDrrIVfo?=
 =?us-ascii?Q?mJ7AnDy+34K0pjpDR70zDxtO6HLilpFplVmiO4unaKCPHSwLEWaxKgE8/CbM?=
 =?us-ascii?Q?+vJD1qi63aKWEZ7Up4RbkUhzLlRDw6ThqNlvKusvjzJJ7rOtAT3/JDUTtFgN?=
 =?us-ascii?Q?XbtGrV8Q4b+0l+oEGb/u4ePdow8Dx6F1sllBFpa8pEkrXXdLRnRVXINxmyY0?=
 =?us-ascii?Q?MxqW+lGq1wQAO9X2bEcpkZ7KDxblLwuapDBJsHptnjrjZYZ60cSahLATtMUc?=
 =?us-ascii?Q?yTUglPu/VXfxNo0LqbZdtJ3BLwfwH6DTWqFotRnJ4PqqN5z3bBMbsZZh2BEA?=
 =?us-ascii?Q?k+QG6KJVSBHDYcN1sRc0/bbTFSezNQKMpx3idLnVtnGirU1VZzY9dA5Qnkn8?=
 =?us-ascii?Q?StqcJwPgy7OVdlR57KZOces/JeUjGlje5AhUXXmkax3BojGDRpR06MuN2R95?=
 =?us-ascii?Q?KYSpl/QIMPpTzLF6iqbog/Mnxc98t9KDlh78Ij8JPNZ1aTCMTYV8N2UoP5Rx?=
 =?us-ascii?Q?jsejcZypmeVynbvBMKUsk7IFQ7X0pN8u9p7ry62PZaLdL1bKGQDKgu7u0ECh?=
 =?us-ascii?Q?hdBYskuLyhLUs1fp3UnjSTSefb61E1Vbq0nsbwjDvubylZbjyMextivS5Is5?=
 =?us-ascii?Q?SKFT66LhRfFVIiFu0DMmV+EZuNoq+vEuRwfHp0qCs1rdEq3rrXKpv4wiLKYC?=
 =?us-ascii?Q?rS4uoNV3laN1pszO5P0TcSwyH3bSKTqG4+465AiR/NlUjnLCmS8V/JVZOpav?=
 =?us-ascii?Q?2T57YZ03Xewq6GjTmgorcfw60jEmdfl7rVbxe5NzmZcw/e/cyNNYOyGY8k9g?=
 =?us-ascii?Q?EU273Nz5UMuvlBLNPzvop7E+cFbbMzmro1AnEqL7m0xIGysosLASiWv3PwUU?=
 =?us-ascii?Q?riv3Pxgq9OpwZ53SPEqt2qQfmEZFie2yaTN+nrqpdFLTnnOqfYVuw8greqOM?=
 =?us-ascii?Q?1DyHIkPFnvjaGgqciCIcf9dep6V3J9huGxnd+m7BaoqYxVEMGq1C9PfMWTU8?=
 =?us-ascii?Q?zqFG7fbghSwYzf7fRGemIGaAsAB7LTDZkfy7DNqqYfl5dMwtYlaq2ZjN1a8h?=
 =?us-ascii?Q?45iVXgfGE8HZhRgfjuRpKgg9fUHnMdBq+LIFyRb6kjSvx35y6HkCuw3i4RCg?=
 =?us-ascii?Q?cPmsivJt7WxGyBWPPvepBlaHsGkKUCn+OqbfTh2ogmBm/aTOv/vqaTaGS1ub?=
 =?us-ascii?Q?Kxk0h3SYBJUKOOe2BTA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 17:44:53.8048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0312fc-c6d8-4ccc-0daa-08de31ca8047
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511

This patchset contains two fixes in mlxsw Spectrum router code, and one for
the Spectrum multicast router code. Please see the individual patches for
more details.

Ido Schimmel (3):
  mlxsw: spectrum_router: Fix possible neighbour reference count leak
  mlxsw: spectrum_router: Fix neighbour use-after-free
  mlxsw: spectrum_mr: Fix use-after-free when updating multicast route
    stats

 .../net/ethernet/mellanox/mlxsw/spectrum_mr.c |  2 ++
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 27 ++++++++++---------
 2 files changed, 16 insertions(+), 13 deletions(-)

-- 
2.51.1


