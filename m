Return-Path: <netdev+bounces-94994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2868C12FF
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B681F2105A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FD06AD7;
	Thu,  9 May 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ex2sVoji"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4EA1A2C10
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272375; cv=fail; b=MTL3nZxr2aPNxn8XoD9iGn4KsZ4Zguw35SO+VpvksqqCLw23W+ZQiBAGs3KDMVFEgChPXMy+b3xnfu4vpx2tKiR72LvyYhnXUsH3iX/h4s+6e3yuMo9uEIArdzV9762Xy8lc5L1JYl39ZkW4Ta5yz8OWHfM13Y8Maue0B9LlSFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272375; c=relaxed/simple;
	bh=8zMHu466FzpW9jiGjuRsP42hGKWXdS/6Nj6ZyrnSAUQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I+HENk850MQ3YK+AGMhJIcyyNREHm4N2SVqUENxO3b8mx6WvzZa3p59c4P7pFlBFhepGGd39DUSwnC7n5Adp1DejE2DdE9qHCJXwek1pydKBGabiXYdaZnaoWif7zywuO6OVAJJvGNRPoI1QtBYTaCPmnwCJj+gpXbjXcujhV1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ex2sVoji; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djDEKUtod1AsGS6pZOMCAOV9QR1ka3CWNw6BaLCxMY720ji2WJzqKWMlyGO6VVbJk/ZlUlDu0KOeZUQToe7f5NhAAzTkrWAFN7vQRY4EtsR5m5MkVz8E900RxatxbuPaDEcVQMU8eRGS2ABAY4m6QuqiUPj5bhE7kywsI3GVQi7LRtXGNw3efKJ9y8VCkCrMh6fURvl0dE9lDtBozFY+5FtjU981RJxGqN8vell3cWOimieTv8XSHBzhQiTKc2nAIlTuL5tyDdrCgxp7NaiwzVMVCyFwzlXot+HU+pQ956DBym5KS57KBEeLf6xxbY4KG6OtdFHeFp7l5y+eCPYBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkNnyzt/hun2EYUQ7Y+R1ZwzNDVEPoAPuLRBs9gW7B0=;
 b=KdotbrAvfUJaIVl0FvFcjkmApIT6nluArjy0vF4sXMShaN6NFb2bf3d/q2llTpvhEynhnwd77HDvxtgbx9JtgfULt7dmGr8ErJsiStM8GoBCueu0KyFq3EvbUcc+PTZ1v0TGzFSn7KU+ShwoudEzrjQQppT6vHA6WJphBkMJ2/IcBTmy3P8oRR91qOCzPHChNFYZbkdAgAYuiWxNmLT7tWknJ7RxvaSQCDLsM+fBDILJ/n5LzbiFEOB3r4ms5Lt5DLrRo0ou+v2ny3td+q9Jm/Yn0O+jbND+hEVLR9rH9XvinYCBEnHeonPYXcWpYI5h2ehxB+92CpE4ZX/RK+Pp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkNnyzt/hun2EYUQ7Y+R1ZwzNDVEPoAPuLRBs9gW7B0=;
 b=Ex2sVojiKaW8VG5KpCNhUoEOW75JauHwHs42KkT1+/A4LIL+8rWym+4GJG1qWCxVEINZAKSDRFXZFacoILlF0nnaC/mbSzv1e/EnUa/2BlqA4ZtxbhYcEM6bbxpyv5w1QoMo8d5NBmzuTHxuButz17ZiOJMipHLl5vqmbKldCzVZRX2oug3S5v7JCoieC9ipcCvuxO1/2A2eQ7YO3o3VX2dMrogMr96IqbIyoenrGZxsfpPo1WoIp1iEFT8QQ6mJzgn+UCDlxBRD8JQu8SvPGDYcPeyDjBsARSin4kymBy+9KTJcMyliwGX3oISFWNLC6ORFQMGOirxVpq19G4TnOA==
Received: from CH5P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::6)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 16:32:50 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::fc) by CH5P220CA0011.outlook.office365.com
 (2603:10b6:610:1ef::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 16:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 16:32:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 09:32:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 May 2024 09:32:29 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 9 May 2024 09:32:28 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next 0/2] Add TX stop/wake counters
Date: Thu, 9 May 2024 11:32:14 -0500
Message-ID: <20240509163216.108665-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 117ded38-3bc2-4677-c70d-08dc7045aad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YRVYIyLheQZN9fQE3Lf8l7arBfnMbJhGwGZ2NZ0fqhyHxVCNbjzYcdDbDFZB?=
 =?us-ascii?Q?EitoSD+sojblaSdtUawKl1oX0nEQT+2TvpOWwIdlXwEbf4tr4MhwjS31frqU?=
 =?us-ascii?Q?gvoZbRqtk7T5un35ja+GnNPpymt5tOXU8CASoYk7ljcvOUGYn0/3iw71JWc1?=
 =?us-ascii?Q?/hhncLu+8WxEHC+1/yzUliFVNtCb8/LjA7O/ydkjByQaew2L+5f13aZ7ANSV?=
 =?us-ascii?Q?/BE7eNivSGweIIvKcG9Rtr6yKf4DsJBBPSxcxC78cq2HddDgnORhILy5YJYq?=
 =?us-ascii?Q?DICeVhe0OYyEeYmY0TxNscEmiGxj8wnSL9FaewacBsD8OZ9dO29aPw+hjtqK?=
 =?us-ascii?Q?YknR6y1RPP0KYJSnPH6PBYkXVFfYLaahruzWv3pvmiueyqU6LNQUuT6SuWlD?=
 =?us-ascii?Q?BwB+gSdrLWpr+bukZ9R569xNII6n/Xza9dTo7JhszRNXjmTPWXtHKVqPoXvs?=
 =?us-ascii?Q?b0FT3qiFMXr9oaO1y2WMk1C9qu0R2T5KUtvpKePQqlcnqVj2rjkXFZBW+sCp?=
 =?us-ascii?Q?uO5PEQmBN4wyUBjvnalZL0VZJInJJ8f+ltr7yN9bZlmhWj5p1z9A1SdVrPst?=
 =?us-ascii?Q?bPlKlOGdeLTYynFykcTvplInc6udPbrxYwQ771IhiRcrgvS+bC0IVqzmTZqb?=
 =?us-ascii?Q?1jHubaOunLyDpjb+FlRAwr+XMQYSXzNEsBLjrzOVsO/9FAcUpaw3lRL1Wk/8?=
 =?us-ascii?Q?Ftatpdc37jhpEjTu/4xPvlS/O5YSGihFMlY0vyU+8VejvTF9M6EbaIFNsYw8?=
 =?us-ascii?Q?DtonEBS8SqhqotsCCmyNTFH4mGgapMutXd9TC/QrMU6nA8ZFbfHJwGQWAalA?=
 =?us-ascii?Q?Nl+TvLzz7NStzHk6RrKTt88VfsNisOcaV3anX0M8oKRgWn5ZIg5Z9+NSSFRE?=
 =?us-ascii?Q?ZcOVfZ0UUmx0tjCJlrRlxT3Sqiz9VTyu+cwHZ3waMfSBn1vgHHPQtvNC2r/P?=
 =?us-ascii?Q?JVSrpJWVIbl0PG+ydSVfAFVvP6oO64mhVGPcIXY+wu68/Oo/OOYBLGTw8hjq?=
 =?us-ascii?Q?iISixcfZrPlgOWZjzauMTaF5I7kiRvl8eO1BSwXChLc6cv43xBoaZhqsnh18?=
 =?us-ascii?Q?hQIEHDYYwGYR1+4TovXOAxa4EtMszYXMHnaBNoO+UOfpwAYAgvn7Wex1XkhS?=
 =?us-ascii?Q?dc6l0aggSIxsSAu4FA14inUq+UZk5gPu5uEm9PxtpbKsDk4/SgBhkXaFvHx+?=
 =?us-ascii?Q?EsvZd9kC8e4Rcfnr561QODBA1psEbsTUpwXd24zRZVL9GaWV7IN20z2m7RpJ?=
 =?us-ascii?Q?eLoSkcGhASXgVfosXRpFv/OTrLmNekC5DogNoUglo2+AlTFHGZ145hkyg8Ky?=
 =?us-ascii?Q?4B5ZRdvv+peYiiZudFdHr756WTtYqDFIIOYwH22Gue34/AKFmnf5jKw6AoI0?=
 =?us-ascii?Q?vMHNnlKUv5nGbBz6iOskxkAbKOkp?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:32:49.9527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117ded38-3bc2-4677-c70d-08dc7045aad7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929

Several drivers provide TX stop and wake counters via ethtool stats. Add
those to the netdev queue stats, and use them in virtio_net.

Daniel Jurgens (2):
  netdev: Add queue stats for TX stop and wake
  virtio_net: Add TX stopped and wake counters

 Documentation/netlink/specs/netdev.yaml | 10 +++++++++
 drivers/net/virtio_net.c                | 28 +++++++++++++++++++++++--
 include/net/netdev_queues.h             |  3 +++
 include/uapi/linux/netdev.h             |  2 ++
 net/core/netdev-genl.c                  |  4 +++-
 tools/include/uapi/linux/netdev.h       |  3 ++-
 6 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.44.0


