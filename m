Return-Path: <netdev+bounces-104477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DE490CA7A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D6F1C21286
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C322156C6F;
	Tue, 18 Jun 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X5wlSK1Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1D15622E
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710539; cv=fail; b=WuhcMfq3i+v2RG92X1SH2YMEIPcu8hUyyiu2sUayWhd92D5ln6qBxqFBkruOVJVT/qqAost7KgEUMVQQWVp4yPmBHAxw2NqtxKJvFFMsS8W9HPiHWNhlatHaxP9fNEGpXFyJcNJj5KUOK2V4NWeLvKOO1Cb9aD+JtUHZBSogYSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710539; c=relaxed/simple;
	bh=3Wu4t7D8br/8UAyfEowqABXlC8qWd79G+eJQdr9jTIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAWdGSTVM8mh2clyxr7tnbJ+Mwm/g0QTFS3EuN3E8fmOc+Vd719YyVZzIInhcF4mqVKg+q6h7m3UPBYqSmWGnAJF+C/NOJo3COhUQgOK+Age9pUvxiTVPUFK6YJsOA+DfHhVS4ZtNQCbMH+YWvVQ8NQxKYE42fdVdBE08ON/z54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X5wlSK1Z; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6pFe8tQP/6MF0cXUFiuUxsO9dtp9IibZs9ka7beOiFLn8AmNWzqkY7GKz2n+BTbBzrY42lOPttQV/wbSOsb9L/myLuBs7i1VKLTyvClfUGreQt+v7BbRMFhRg1CIRXg0FaRhYuR5a4kJCAu70fEfnb2gSeE8VhKb15B47HaKzp10TANU93ebHaEYJWpbu6l2LMYu1T2u76R7qwwdcevvnvV09LUAr9K2MESz7M+KVEuFprbM0WIebwCgyCHs3ExWLEnry2efU7xM54KKV/gFwmp2AH8q7GNUu93/HtHZWylmdSwLHtmIbjmb/zp7Hmc+b9SEg8T8ztYra7AfrhFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2oX9DetTgp9sxH6R5daOzMQt7LVRmr2Z2GxfaTz6WE=;
 b=ThuDnEIeRj3R9UvqMaKbLIpfgbFCun+FhUERUfXXQZ0HSr1jm7V9I1i1GaUShUl6whtOk5ZlaEynegCOInCm03O/+z6RnxvMUnO6mGKY6juqKyHBD6pBG7iPzO6aeri2UN8Br9VOkFmA2KAuZExqvSkzDGmTrBAWP6hujf/NRZ0H1K00zRwi+YJE19UdJZ6+L5snrbnIuyuZJpn9gdnMGZ0FEPOWU1vbHj7pIvh9oLz3vEUcxl9Pz4RnVxvEece/WnfvC3rbTw+DfmQ7aOWldv4wfxTcdbbKOAjRyj6z982pkj7L/m1KiFnR7gMI3iMX93RSJoaShTjzbN8ZVfYHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2oX9DetTgp9sxH6R5daOzMQt7LVRmr2Z2GxfaTz6WE=;
 b=X5wlSK1ZTMg9PYQb8kYrR4LJE1RgWBqAHyhZY9VsAV3CMyF+cdEdfEBcgGxd2qUimhyBk/iG4u4LZzzMzUM9KDihaQM2QC6w0jIxDDr/DASgN4SrF0ua+2MCfWl+fgq0RRe+POG7RjUhIMuo6ZQFUU0nZiWNeu6WFiRgxgoL7Y1cIhDGPR7/141rDxSSzA6rlMfnZPNMhiF9uQPlNstsWLeSRAZf5HXQXc4vvSART2MuzfmWx4OfZ4nZV0/9+s545Kec8QtBn14YFAG69m/3HyxEKYsXGeF44L6hUMGWYS/SHUG48fzHnC2y5hrDd8Po9qxn8kTshzIbmA62ngsjHA==
Received: from BN9PR03CA0877.namprd03.prod.outlook.com (2603:10b6:408:13c::12)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 11:35:34 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::fc) by BN9PR03CA0877.outlook.office365.com
 (2603:10b6:408:13c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 11:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 11:35:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:16 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:11 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/7] mlxsw: pci: Split NAPI setup/teardown into two steps
Date: Tue, 18 Jun 2024 13:34:40 +0200
Message-ID: <8dbf37e859f07247498fca17109b8858ff2b0498.1718709196.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718709196.git.petrm@nvidia.com>
References: <cover.1718709196.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: a754d114-3361-4798-ec6e-08dc8f8ac40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NWIZ29Lt6nDMpFsgi6cK49NT8dnzK1rUmi5LU8MYI1Z5hYVdAJHKc2d9VV5a?=
 =?us-ascii?Q?L75Z1xuE7dk2WrjU+x+x/DMq28HdnbXO3Xyr84BL57u+PrF507NlbOaEk3wu?=
 =?us-ascii?Q?3EKv77JBlvq1R/bDcFSVP0AZA4QWs2h47uclU8nhjC3zjawg/M5HEcCI9gxL?=
 =?us-ascii?Q?KHfKBlJCR0nimtWt+hEqaRYB9j1EGkw4477O5axcfHZs5U1BH4iomrDcA8gb?=
 =?us-ascii?Q?nlvP84s4jjD6I7bLBBQNt31m/2I1oRVbPpy3MuATBumvIhHtMP0SAgVizu8L?=
 =?us-ascii?Q?KouKsduQQnVjNKwc9905zwwFPZEbCguDvUqWcFdiIDrEpWBtbpSMlMBYHqzg?=
 =?us-ascii?Q?ZwSrrGKsvhCoYbKB3CjvrHAugVs8TYIycQgAbKs5XeIQVfeXUo9Uon7R08IM?=
 =?us-ascii?Q?Kf5UQkmhSN9OmGYqNIH+iT3FZ+OuDIUdcrZEC3jEv1Dw1GjKK8iPneSUsffq?=
 =?us-ascii?Q?gmsgq8N+NHKoPw1uSv/zKnUgycdq/oJSSfW0YzaSVFzT43eRxuvppW5FUhBM?=
 =?us-ascii?Q?aoxXcld8e87UBB6rheCM6ZLiB3WJsBAuY+s6glm8hQjHV4/y6VO/+ayJlDKK?=
 =?us-ascii?Q?/a7oid8BVN77/4fLQzZ8DwvswUh31Brzxn5UiFRwFK0vlsdw4e93lm3UHNmz?=
 =?us-ascii?Q?j2nMV+QnPknApJPqmiOWLnGUsQMHPuM2IvPxFKsr+akz+Pe6F478w9+rHFfX?=
 =?us-ascii?Q?ldYP6/5e1AF263YfiX0oxRc9+2RV9xrYOLGywHjHfPzMcvSeY89MYMD7+TSN?=
 =?us-ascii?Q?Zjn6knXjJdeYTHMI2bwRrsd5QTsKq68DYK4ldC8kcCsDk/1NRpUEolOA9qqC?=
 =?us-ascii?Q?V/F2/UngBk6rFVBNQksySmKm9DBBBq6qwdZkRKEnbLnAHnIoRpaqvSpxVqdp?=
 =?us-ascii?Q?hvcMTtpd+sjk3y+q6u9NFnurXpkAEvvdorej1WfayWjXXfSiOD4OCy0niouD?=
 =?us-ascii?Q?lFBmv6u52WbK1dN/xcL+boh6B1euqBwUAdrHRjy2US4g5rEKx1Vq3TzH1n3O?=
 =?us-ascii?Q?2t9bUZxxK6fs8Hji4/08brOXSBBY8RARxQVTl5ByT/LaXSXrAUngUcZevl6j?=
 =?us-ascii?Q?Fb61jfyt350HZSjBrEgnaMtLwdqw/Cq7CoMUcIjqSmHJf0ONS+b178pGYGMN?=
 =?us-ascii?Q?RVua+rECkPdapghG7LTgwj75cFnR46L5sj+2nDQ6/H0BGuJJ2gA7k75r/MfX?=
 =?us-ascii?Q?a3/jm5uVMaqx17xx0Yxj1aKbcAJxyX26T0HipH969R7Ww+JFSbP2xmLqnQws?=
 =?us-ascii?Q?pEZGd13dZON5GVQZiJdtAm52RTs5EBk6nrykB/78K+iGozieoZY5pitzlqey?=
 =?us-ascii?Q?OKty10P2EUSO9TRoOOehWP/hNB14kJrqUTWfH/HttNpkhAful6fZN/mkZ+Yz?=
 =?us-ascii?Q?7LP2MnUPtw+OM8+RpTC5AFAoLEjJF4kWK/lWN2HHfOJ8Da24eA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(376011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 11:35:33.5242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a754d114-3361-4798-ec6e-08dc8f8ac40d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869

From: Amit Cohen <amcohen@nvidia.com>

mlxsw_pci_cq_napi_setup() includes both NAPI initialization and
enablement, similar to teardown function. Next patches will add support
for page pool in mlxsw driver, then we use NAPI instance for page pool.

Page pool initialization should be done before NAPI enablement, same for
page pool destruction which should be done after NAPI disablement.

As preparation, split NAPI setup/teardown into two steps, then page pool
setup will be done between the phases.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index c0ced4d315f3..3b6afe3aa2a1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -832,13 +832,10 @@ static void mlxsw_pci_cq_napi_setup(struct mlxsw_pci_queue *q,
 			       mlxsw_pci_napi_poll_cq_rx);
 		break;
 	}
-
-	napi_enable(&q->u.cq.napi);
 }
 
 static void mlxsw_pci_cq_napi_teardown(struct mlxsw_pci_queue *q)
 {
-	napi_disable(&q->u.cq.napi);
 	netif_napi_del(&q->u.cq.napi);
 }
 
@@ -875,6 +872,7 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	if (err)
 		return err;
 	mlxsw_pci_cq_napi_setup(q, mlxsw_pci_cq_type(mlxsw_pci, q));
+	napi_enable(&q->u.cq.napi);
 	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 	return 0;
@@ -883,6 +881,7 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 static void mlxsw_pci_cq_fini(struct mlxsw_pci *mlxsw_pci,
 			      struct mlxsw_pci_queue *q)
 {
+	napi_disable(&q->u.cq.napi);
 	mlxsw_pci_cq_napi_teardown(q);
 	mlxsw_cmd_hw2sw_cq(mlxsw_pci->core, q->num);
 }
-- 
2.45.0


