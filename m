Return-Path: <netdev+bounces-231800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8355BFD785
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A273619A7482
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45161280309;
	Wed, 22 Oct 2025 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rpw6zai8"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33FB27442;
	Wed, 22 Oct 2025 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152925; cv=fail; b=ay8qFyTggeuJJxtuKEOmanGLdWB+ahg8Y40vCL9TssggVgIoGTglFsvL0BpMZbf0/6aCaXtfaRwgJLtAG4tsdDO9gIT8XdRgmzjEE8qdOrQZGulF9ap5KgwTpy0GBQ6WzD6J2GS+9LMN7SQOXMVNzIKTWKFnK9iP+ixnkp6l1Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152925; c=relaxed/simple;
	bh=7x2YaCupM66KGxzQrjOyDISaXaJ+xo9crG6edQnbcE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCzmHrOfvgeMZaxH9uKSRSTRM7+jyYsQnpWfULEjh8KfwRxJbaCYvrpJKwBC4th7fgdymmfhESr3hyKs6jRFPAdHJApD0JKERCkw5flek+IRg0LYufq2jrR081bil1ZNPZJNv84GDO+uhreyrWyryXyVu5zatVEMGxL+XZrU1Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rpw6zai8; arc=fail smtp.client-ip=52.101.61.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f142fg/QYMAdPSIsMad8gMRVIDSIAEcRlOoM33noDX/p+8swPlKpGtk+WAtZpjWAsL8BXNEOuvMsb8fBqMs+4CeH9CAWXCLDxmwI7EB+kk93AUGHBOosWMrlrruZkxGvdCGZzDbuuKCmQRuuDgfKuCzFdtv0HXorLB14arD6QcNmD8Yw1SPeaREcFxK4goZScb4ROUYxDxQPSmcsyi/GQTF1AEW0iJF7d1vJWiXhDBkzRSnhyAUqo1lVHnCMXuWP0rDpipzxqRFsP+JfJN2i1dZLnWPZTxPqXwIKVtXjeDVDmj7Qb4EnFCep3OYOXB8wSmfu8kQMpbUZ5tSed0i5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7x2YaCupM66KGxzQrjOyDISaXaJ+xo9crG6edQnbcE4=;
 b=UaCYsXwoLceskXkjMM3soh0ZvxDl/Qy4tEwpgpcE1CPnCq6FYwiY4QzSlO5wo2/z104mWb+UYPPLGAx98DC7871dESHY+s5x++kCahsecw6Xwmakgcm9izOm8TZtyjWtVzZ4jI2NaFa5Kbs1ZrFqOg6QE9n6bnhPR79SfhqH+1SXS6eot+Av8cUes1ydsT6ngqmOBnr4zWZsSBhkQOXwl0kliIUgosFTRXeIKPR2cYIn1HX/JPLJSpP8gHsa7oa3kbL3mCXXWNrR7x+SnRz26W4UOLcPhr2Y8WA8Y4MDrbY9cafkC7NA2SsjyAt5nFd5KNslIqflqtfZUrulf3W02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x2YaCupM66KGxzQrjOyDISaXaJ+xo9crG6edQnbcE4=;
 b=Rpw6zai8zDBc9H9cNZPXyXC4f9wlaIGuvdpyFHMldjTdmKWfeDqZTbbmWCVcsRZ3Oh34BnW2MFPBTTmpK0H0R5uKLZc5Ulm5IzSg9/HhIef9lc3tSfccDciI6pB00+pL4YRHNMgTqUVThHi2941v8F1UuilJjuvxh47mr8Mvqsn7+vjGCTKnZQ3uNphjJEHBz1YOENfh3Gn65mxp4FEMEupE+CCGmdclMdX72z0c56NAoVyNAkM/mv8iAcqR2svGNNq1hbxE6K2OCR2OP9y5Q4s3bMIBQyyEtSfGFcgVMQgZi4m05QWLHu+v09Z4FMqwg+Fk1YV8kfHXShjVNwECTg==
Received: from SJ0PR03CA0211.namprd03.prod.outlook.com (2603:10b6:a03:39f::6)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 17:08:37 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::9f) by SJ0PR03CA0211.outlook.office365.com
 (2603:10b6:a03:39f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 17:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 17:08:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 22 Oct
 2025 10:08:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 22 Oct 2025 10:08:27 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 10:08:26 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <cbabroski@nvidia.com>, <davem@davemloft.net>,
	<davthompson@nvidia.com>, <edumazet@google.com>, <hkallweit1@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] mlxbf_gige: report unknown speed and duplex when link is down
Date: Wed, 22 Oct 2025 13:08:25 -0400
Message-ID: <20251022170825.1108218-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017155402.35750413@kernel.org>
References: <20251017155402.35750413@kernel.org>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 2221166a-e368-4cfd-8230-08de118da308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0xuI4GIVW+ozjdwTu54Ngf4lDwWxg92DPyL4jFJxlKF7lLkJ3ayZESXYFacM?=
 =?us-ascii?Q?UPCnxcAsD0WwZ1AJ0jGcIlIEFCmhacDxr1PS8OT+rnY3flEYFwXI/Z62+ykH?=
 =?us-ascii?Q?r1h8E/njs2SfOh8j8/+UObCIbccWZ2CqnGBuslE44ioDBmtR6WXiErZLYtvb?=
 =?us-ascii?Q?MxmSRfnJumYvYwxTeeceGVMYeSef/Ivlj6+1a9URUR5CtH0RJGgsJL5RBTeQ?=
 =?us-ascii?Q?5rRuaDPb2iJrKKmWCSf2H/kH+/xKAwWsdIVkLrsFy3jXNejiB2eziK0Pd6LV?=
 =?us-ascii?Q?cf3LvaScwMql+Q9ANcDPH8Kk+XZpXyKb0CsYwyXMDuU5hMwKeXwNt7vvyukn?=
 =?us-ascii?Q?jeyUZKDPwLxa4625tEHa+ULGk4WsmaQxKX/KXAI9M5/7Y25u94bSyH7SP8d5?=
 =?us-ascii?Q?YkCf1ZirRnE5LV36ZBcIkXbNMED/qIKmzqmDMA2YMLIjGI+hXtIR6xL6Mi9q?=
 =?us-ascii?Q?nh+4/0D7Q5gWq+le0VWSgcxnWxZt21lQxJbHaD+AEfms0It4NYCAko/JSWZM?=
 =?us-ascii?Q?OSDHbK2kL+c9JdF22MjT7bzHPrx2wRKfYlFRTmPaxfTwVsFN4p11oLWuirHQ?=
 =?us-ascii?Q?GeMArRhn+1ncP/7B/UER3yLuzd0ktApuI5mlEsFWvbb7ObAPZmDo0SgK3K4/?=
 =?us-ascii?Q?9emgS93E4OjzLV2VNgnSJIHrZBzzD5ptij5SMTro92LD6ozRGbpz2MrH/FC6?=
 =?us-ascii?Q?qzvqOwJLe+tvPcOZb/EYjq7c6/zI3oYVsMi6V1jfkDLKlcCRX29gsgUpvwjs?=
 =?us-ascii?Q?7bamKy72hOLRIycXMlab7+LqpldeWh2HZwMm2NO0cKrQcaZpxz8hp93T5ewB?=
 =?us-ascii?Q?E0zWtyMTduoS+XrIoRcsc28zz4WmsYlSVUu5XbOyLf6uYXaLYl36m4wZ7ukl?=
 =?us-ascii?Q?d47zFn4bxs+dpXJ2Rxh/lBqaBH3ySzM16Ljg7rM+TKdwOaFE8dv4PkfS/T7P?=
 =?us-ascii?Q?r7rFW29SQcmMylssO5E2E9Hu8cJsyEWrBzWpAlr+HR/t6i+CepDbXp5zDuUQ?=
 =?us-ascii?Q?opUIeLNgUcZyzgB4HSQfJqoZoTmuqPkoA0kPfeo+HbQPmq9cvDWrEmtEmapq?=
 =?us-ascii?Q?n1JLHEx3OVhlucznyzv+6wBLAWoRIxhu+YMexQlr3VlviMiI/iKXH3RUpWZL?=
 =?us-ascii?Q?CQmoWaVEL3kJIJ4oEAKpBV3Eupn7QJiKl4odhPyURbRWQhh+PwcCRBVs65z/?=
 =?us-ascii?Q?ANv4MMuVXtxifeOUroyUhC/170hr3UeNDgJoh4dKuydaOm+Gn5QFCSK2sLoG?=
 =?us-ascii?Q?hF5M0+5GGPqLzholHnEKegrzjKINibIoq4VJTstD3/kRod63q5Z/VlXGfi+r?=
 =?us-ascii?Q?u3g6m0M6tM+/x4PPS0WHcHqdgz0LxfzNk2NjSIrXi3/QOjGR3PTigpHzZ5Oc?=
 =?us-ascii?Q?KBRgEWEGZh1zdV3SV/7gpkXfVTn/YK+IQc+/3tgqejSbs5vcbKJ7pIxcD7yL?=
 =?us-ascii?Q?8XN016xajA0eofN3eKWNGclGrhDofm+XqaONY8CovBF5eR29dkOxlXb0jLqI?=
 =?us-ascii?Q?tQyg34iz0gO/nfk3DnqKt6B53R6tBPIIzi/1BBarm7pyH3HWgcft+YOar5L4?=
 =?us-ascii?Q?IdkcEA0Rishq3Zk/MU8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 17:08:35.5940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2221166a-e368-4cfd-8230-08de118da308
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618

Hi Jakub,

Thank you for pointing 60f887b1290b out - this commit resolves
the issue and our patch is no longer needed. Please disregard.

Chris

