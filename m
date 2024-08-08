Return-Path: <netdev+bounces-116892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7EB94C013
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4BB1F28BAC
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EC5193085;
	Thu,  8 Aug 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cgzm2Puy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8975191F87
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128185; cv=fail; b=n1s40XNB4E4KG6wB869ehMS7/+XVDpWS0CRLC3mvB/ebCCb43wTH1XNr3tbUWOnMXD0HlcLGdYRvGtfa2Nv+K24JOURY38Es2CcT3VV6GRzECPxmcg5Vx2dWhpSgOHiDN0nl3wmphAA06jWCcShgL34hJ2lji6S0vIE8+D0NJuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128185; c=relaxed/simple;
	bh=1eC3NgN60KY2TqWhP6SfZMzfehhajhFg9F/GrZ2tP2Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=etZtsjJg+WXm6cKLm8p25z3qop+ahrcXthP1yJrz5H0tnuEVmq/QCpqlkIv+M8RvlKVOmtPlAhBoihvprzx4nthOSqgBKMkslrCemSBCbCV8smB13ft807Sb/MVzpdz2RLqVC8lA4UpwyOsv7vv1WOsE2bB8I3ITNyI0rYoR3sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cgzm2Puy; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/vZ4jI0NHk19IHTf4i+w68/1uhf7634EH7djHOH2eZY6nruNTLYDthGYFY6hBELuregUkAubDDg+zw1YpGxLB7gnPN16XhaSBsDqIi4DQ6wxrGcqQAq56ARlrGNRUtzWCc3Iq2nqT/J8uB7SBPYUXQ2dRnallarq4wqgtiRPDn8K5/OeVt04EBHfXCc7WSSXe/Pzy5QbEMGJR9OZlz6OGpW5EZtEfKOpskfm0+vR4Z9YP/tHJ+yC/jcl6exwyBzxGdIteYN4FydWC3lrJ25qRmgb5boJ+4D8WD78RmVM3BVEevmkuUicGaNxKplfXfJjmsGsUFgXrGoI8ZBMiUj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=briOvNKJF1FTVYvsfDlVud2h+xf/YSIiZwwwHLnDoTo=;
 b=H7TMvYyXiQ688oysoppCwafwhOxpizzmBLPT+Adz6L6Nuj0swXIbXj0w2mNNgwdIIygbDmL95YwjoCbXN6q38F17fghcMgxEqUdXMZa5+PiBqvDlN0ZzsxOulXaXKlytvu1TbhdgJAHRVdNItE/aatZBrjjIRro5wfYo8XLEGV4cZAVkNq8D1ivMoLJZq0YGmwfIv6PKx1e4cBWQhRKjzinF1tEZJ7Sc36vfto884/brQchvu1DvxeLPnBihhYGHYZi3wktuWjRwzuL+T3zW5jQWymBtH9aOo41/zenm1VqiMCPbXASQgreMH/fBHNazD6DPv2m89E28LZoDEFqt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=briOvNKJF1FTVYvsfDlVud2h+xf/YSIiZwwwHLnDoTo=;
 b=cgzm2PuywNBJrnXS76ZmvZexXstvhoXSpqJE+6yNRM4wAws0l2lsfspXie+vIuCp7XYjTM89Wd3xETFJytM3fSfWpSzCHqGjljKmSwj0xIdpwWgjZevjIsJcOKOUzY5J0IsJ03SpFRftTB1ZDDTgEj9tJ3/A1Licp2e1LP22oDE7ycVkUXj0YbXmLL/bWBiEkuqtN0NesjiZRkbFG2T/5AIS5v82MjtFbwOJhdA5tHbS7j4neZoZx4hiKYSpPrulM/y/gWO8MTbqu9wPonE/ktcJAM1HEbjv4VS7dXb2Ax1/k00zzrG5iB4cjuCjo75uXeCOB1GRvdu5oihSQPKA4g==
Received: from CH2PR04CA0019.namprd04.prod.outlook.com (2603:10b6:610:52::29)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 14:42:55 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::ce) by CH2PR04CA0019.outlook.office365.com
 (2603:10b6:610:52::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15 via Frontend
 Transport; Thu, 8 Aug 2024 14:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 14:42:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 Aug 2024
 07:42:39 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 Aug 2024 07:42:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 Aug 2024 07:42:36 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/5] mlx5 misc fixes 2024-08-08
Date: Thu, 8 Aug 2024 17:41:01 +0300
Message-ID: <20240808144107.2095424-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: dea45388-06e8-4d67-cf9a-08dcb7b86249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GemTu0798Rch3SvrcZM4v52QoycHUzBiIFgUitJULOHi0QC1BvzLgnS5P7ra?=
 =?us-ascii?Q?G4B7HCJZQ/rOou6jHMVoNyIU1CcbTF2sWnuiqdqMQgybFf4xMPkQLE+UTCu/?=
 =?us-ascii?Q?Er5AMZzpQ6rmt2sytFFdDT6iOpMWy7ZwEfeBoddahTcPD5MXfNye9HIU5pAI?=
 =?us-ascii?Q?R0e7OXnp0GDO5fWYcdZjIySIrGNUryD+0viOIaxAQ79i5dA777xtRuiP8zOy?=
 =?us-ascii?Q?oBbzU+ccKCplKsfHUKn1GhaBctyMT8jdU7OGNUD7TQKG18yq/ev27lkQ3XdK?=
 =?us-ascii?Q?ec5WY3GOqCIAj07G0pXRCx1AF+XgqHfgpW6scdrAJUZbk0FqawYhHg0Q9DNn?=
 =?us-ascii?Q?8ELvNlHZ6oPSuHyGNH/I4q0dD0rIrcZBfLr8Ppm23xGX/qTFQT6DI/XXs0o8?=
 =?us-ascii?Q?BWVyRgpLaEKdldpLJmwa2vL4Rpk9YhbhzxkwOvwwHAp1fDK+qrRuAfqieWIt?=
 =?us-ascii?Q?csDttUMVqQDTvxJmwqil+cZW1a0SEn3YVTFZ4k/ExmStsg2ugM1b67GPKrhM?=
 =?us-ascii?Q?HcHC+jjFLRPShE4/TkJxRgH3zVu1YegZD6JCqnlXETVn1w7Y+JpURJpWsyJy?=
 =?us-ascii?Q?hj5AM8crxg7pRCUed8ufGyux9SVFWE/9Q+/ibGGak3b6hPyVQug/pZNfur3O?=
 =?us-ascii?Q?+PaDQrzhT98+MJSzrd8u5TU4j23L4eN+DNkDxqMq0oaD+68Lp5xmxkBr+aYS?=
 =?us-ascii?Q?9NQOs0XkM1W10qRJA990nJziJRCEHbUqBkp3/JJrioqUY+ZLyXPj9S0YRqv7?=
 =?us-ascii?Q?hI6DAZ8IEXE3sVpjWfIstmdvUOg7UVg8/WodQACXke72jqw2jvfqKCqnZOfo?=
 =?us-ascii?Q?jUXCYbwX/oPge+v2H4rkoQ7s0mRG9MC2GFwBwz8jQ+BARFe5n9b08a3h/MAL?=
 =?us-ascii?Q?LFIKuaUFtGRdkqLwAf6lhrH4TydSmEyy3ko3ZQPEveUZQmMn/qi/GGvf6wSM?=
 =?us-ascii?Q?hwoWDxAbGQU5x60P8sLTvF67UZvq7CgEJ8ZGuV/xjQwJfESBNsm27DwFiFUT?=
 =?us-ascii?Q?QZIYij/ZfGoyH2nZTyvN9umgxBpVaaocRO3wTXvhv/CYnm9KhzmrQ881RfyU?=
 =?us-ascii?Q?+JWfcMjd1DHXBzRIVVUZF645Pp7VhyijcAaOqGgeEz5JCHsyVvlyk4KzjxdK?=
 =?us-ascii?Q?WEwOcBplyCcb1kfoCVyWXPwNSGkYJDwVIBTn8dRtCmQRu6VUcKGyb/QC1+nk?=
 =?us-ascii?Q?IaIn3y8lS4dFzlSMjN2/OExnmKa4KIb7rK0Mc3wTTEiISWEK+zsc0Kd9y+gC?=
 =?us-ascii?Q?LBk9VPAF4pLfuEAmH3cNL+ExV2bYl5WVUvynVtMmxP6TqDAkCdPzr0R3bV2A?=
 =?us-ascii?Q?CyZtDPhnkEMwq0OmYJU6AXmc0S1kwU586mFzrK6wHOQfoDIwoJH4yEVCqpRf?=
 =?us-ascii?Q?/qjuigRzhwHkp7QV/uSAo+vhMgU5/CMrxjI0QYD0fp6ceWJ5GQfx8wjenroa?=
 =?us-ascii?Q?MQCux5ztpj8ScHLwVh3NoWU/pY4BbHdG?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:42:52.8762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dea45388-06e8-4d67-cf9a-08dcb7b86249
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Series generated against:
commit b928e7d19dfd ("Merge tag 'for-net-2024-08-07' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth")

Thanks,
Tariq.

Cosmin Ratiu (1):
  net/mlx5e: Correctly report errors for ethtool rx flows

Dragos Tatulea (2):
  net/mlx5e: SHAMPO, Increase timeout to improve latency
  net/mlx5e: Take state lock during tx timeout reporter

Gal Pressman (1):
  net/mlx5e: Fix queue stats access to non-existing channels splat

Tariq Toukan (1):
  net/mlx5: SD, Do not query MPIR register if no sd_group

 drivers/net/ethernet/mellanox/mlx5/core/en.h   |  2 +-
 .../ethernet/mellanox/mlx5/core/en/params.c    | 16 +++++++++++++++-
 .../ethernet/mellanox/mlx5/core/en/params.h    |  1 +
 .../mellanox/mlx5/core/en/reporter_tx.c        |  2 ++
 .../mellanox/mlx5/core/en_fs_ethtool.c         |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c  | 17 ++++-------------
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c   | 18 +++++++++---------
 7 files changed, 33 insertions(+), 25 deletions(-)

-- 
2.44.0


