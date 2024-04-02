Return-Path: <netdev+bounces-84058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3427A8955F0
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581E31C223C8
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9B1127B73;
	Tue,  2 Apr 2024 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qJTh3LIl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DC985278
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066288; cv=fail; b=llE99wBH4xbnlv6VHZUW2yQqSQifPMJfBUAxkhBLKeu7ATmW6ALKxqZrKjxhKpIRJw/oiUsrttycRzf2lZPAwhzuKyArHdPXu3nsNyvqp7KWMhtmW9a1lvLoIogMUG0ip0CFclm061tutfMLuTwTa9Q0tpp4bTnBm23Voz2bY6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066288; c=relaxed/simple;
	bh=CPCOZJ7Sort8nl3GajpuBEby2nUDUoDxxdJSMUR/qKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owCqocgXA10c7p9jkZEcn+ranm0ZK+t4Fng+3Ot+6suhuECvZ21UEoA4WpCHtL4uMw0dz0cKpA5bk75lAfFrzookRyMUhLZSS9wzI4lBrtsINwnfDGBJ6t0KKcJrF30AeDBAMlSyBWPp8YRyjASJdp4qlJmKpN3ACGE1P6OuiNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qJTh3LIl; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrsaiwyikcBIk9HQRlDKO174Y8T2FBrN6zUwWIbYeVdcoJmJt5tSNtsnFs68JK8CxGENsQqcvZblOa1hYnDPrV+Q9RPFZMqQmDpzh+ai0mkWedWomuMpsSQdtXE+61Usc+N0S/xylJeCPxe26UWxMwyjO+SPJjwqh0tMBVLv8igxSTRT99xz4tpaYKGzw3yFtL2aHNdtOFR9+5x2LHFqQsN55NtYBfhzA4IwOoXQD0n45SpM1b0RL7zi5NQbaNvsMfAOl7n8BYZyIKwPDjQS4AtkWOJmr5/QMIlzAe0d+/EdPJuJ5J3hUfxCN0BCpbPOAyH48I4eMp1APlQ2iJEZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDx9vH/mV9nD68/U5JL/rrEoT0WcgjpM5HpnQZImyKE=;
 b=LOI9RCva2gdf5P/ze7VDhaFQG9cn7IUccW+e1Teg8zPYgi5hOI+sDMfaYSk35qqOXYrQXWZWCtjTbjYxiL5WgODrMmLvMwM6W8nIGjkFRSAgiQIgVfDKwbsdOfeU/F+y2IdnUw6RCmyReH2DNyTjSuggzPnf3O7Y2IXO2PQ4yIHPmTvd1JHES8Mi0k/dreW14DXgZ3Wsbm98w99avWSIqVJwY/iL7laoQHN0KIv7/ZI5ddmdYJihLIyoOiibcCb7h91hY0Vdd19+1oVRccqhcQnY+6z4QjaWwKHzEO8JCM1h6I8JlLH9FgRXGcCY/laf3rITbHIRZ4RpH7ehz51nxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDx9vH/mV9nD68/U5JL/rrEoT0WcgjpM5HpnQZImyKE=;
 b=qJTh3LIlyCoKk+bIrN+UdCBUUVtb49RiYBTBaQlHRSY92jm6JJV0nrjyiKo7eCvdnaUH+1/gsbPu79fCUMWZaWmyY10+hLmxIcTphTslwNVGt9J1+RuqXznuE92BdnIXsILM+sqT01iovRjJfAHWmcXqBVl0PZe1gaNa0koe47PJsmGTyWIryQbgtEMkk6tIS6bVnF/SuDJSE3AGqd/zRyT/LmyQxVf07YvLd4KNSiOD3+4j2HVO9l0jSUI47gXCyYlXEBN8DQeJIciObvqr+GGTcVujYnCGkDenxL6Q58RmsFeyRQUv0OvgRBpNLQaKFCIc4CrodLWSAuJuqlpLew==
Received: from BYAPR21CA0008.namprd21.prod.outlook.com (2603:10b6:a03:114::18)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:58:04 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::3a) by BYAPR21CA0008.outlook.office365.com
 (2603:10b6:a03:114::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.8 via Frontend
 Transport; Tue, 2 Apr 2024 13:58:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:58:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:52 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:57:48 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 14/15] mlxsw: pci: Remove mlxsw_pci_cq_count()
Date: Tue, 2 Apr 2024 15:54:27 +0200
Message-ID: <f08ad113e8160678f3c8d401382a696c6c7f44c7.1712062203.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712062203.git.petrm@nvidia.com>
References: <cover.1712062203.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DM6PR12MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: 2726775f-97fb-4ce4-586d-08dc531cea64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iWE0gOVGh/tc0pyJw6QF3KRbncPotc9iEz6Iqk0RE1kVLv4hI01g6zX6IXHqh6h5pT1ta0xWPKXYy2VKP3SahvEhx1kvsvvYqJ3/iTT1JjrxfFnwMHu/phTVOoLvyb7kqB+Lhi55DvPiwD/ncQSaPlYTXj3L0ZykA8d7vyITXXngn7JXiqpTJ6oaEnoC0GdrHZ9t+a8XE5Xm9e4XIGyOP2ZjPMXD/52KR3LPxdkEx605x+WJcoj1z5+xMfg6ddYJsKvyfzsebHdeLwcOMfDUNJmVYyWNG/edk3YJsQZu6FC1P5YF/2nJpq+CQ/jO6m00ng1qSxX45Cw28x3BR0NEicL/WHCJwaewhlNiFZIbfpoYxP3YBfoLmEnVWIOsSudKjcs++DNItY5u8cplmGiNYX+z80vmwUZ4kvBpuETdnMKz9zlnIlZERgc/kVsGqGbGjV4CXsl5xQW1pPC+IHHioR1OH3i1nmFm2KFyog+71XrYWycIbwAxC/tQeaSk0col4hJbDVNlBr9L7l5yVgnznDVcibYqunoywd1ZEeVLWb1PoLISE6PcmOU0i/6h6U7geZlSA8WRQG9WO8E5eWL7UiWyzNVFACs4XOXiFjRT509h9Nkoryx/I1GhUAPZgFXIc7jdvnpOYgqlHz5vXnRC3vxYBvz8OT+hubIoaZ5tdU2DCBA2l+G8/roJsgjzlSbxlG7X728yx4m4KZ5cQXo0zjfH6kjt3kqbVOzjstVIdirFlBljV7rQjLW92C592kNZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:58:03.6089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2726775f-97fb-4ce4-586d-08dc531cea64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386

From: Amit Cohen <amcohen@nvidia.com>

Currently, for each interrupt we call mlxsw_pci_cq_count() to determine the
number of CQs. This call makes additional two function's calls. This can
be removed by storing this value as part of structure 'mlxsw_pci', as we
already do for number of SDQs. Remove the function and
__mlxsw_pci_queue_count() which is now not used and store the value
instead.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index a7ede97a3bcc..2148110542cb 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -123,6 +123,7 @@ struct mlxsw_pci {
 	struct mlxsw_bus_info bus_info;
 	const struct pci_device_id *id;
 	enum mlxsw_pci_cqe_v max_cqe_ver; /* Maximal supported CQE version */
+	u8 num_cqs; /* Number of CQs */
 	u8 num_sdqs; /* Number of SDQs */
 	bool skip_reset;
 };
@@ -179,20 +180,6 @@ mlxsw_pci_queue_type_group_get(struct mlxsw_pci *mlxsw_pci,
 	return &mlxsw_pci->queues[q_type];
 }
 
-static u8 __mlxsw_pci_queue_count(struct mlxsw_pci *mlxsw_pci,
-				  enum mlxsw_pci_queue_type q_type)
-{
-	struct mlxsw_pci_queue_type_group *queue_group;
-
-	queue_group = mlxsw_pci_queue_type_group_get(mlxsw_pci, q_type);
-	return queue_group->count;
-}
-
-static u8 mlxsw_pci_cq_count(struct mlxsw_pci *mlxsw_pci)
-{
-	return __mlxsw_pci_queue_count(mlxsw_pci, MLXSW_PCI_QUEUE_TYPE_CQ);
-}
-
 static struct mlxsw_pci_queue *
 __mlxsw_pci_queue_get(struct mlxsw_pci *mlxsw_pci,
 		      enum mlxsw_pci_queue_type q_type, u8 q_num)
@@ -850,7 +837,7 @@ static void mlxsw_pci_eq_tasklet(struct tasklet_struct *t)
 	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 
-	cq_count = mlxsw_pci_cq_count(mlxsw_pci);
+	cq_count = mlxsw_pci->num_cqs;
 	for_each_set_bit(cqn, active_cqns, cq_count) {
 		q = mlxsw_pci_cq_get(mlxsw_pci, cqn);
 		mlxsw_pci_queue_tasklet_schedule(q);
@@ -1107,6 +1094,7 @@ static int mlxsw_pci_aqs_init(struct mlxsw_pci *mlxsw_pci, char *mbox)
 		return -EINVAL;
 	}
 
+	mlxsw_pci->num_cqs = num_cqs;
 	mlxsw_pci->num_sdqs = num_sdqs;
 
 	err = mlxsw_pci_queue_group_init(mlxsw_pci, mbox, &mlxsw_pci_eq_ops,
-- 
2.43.0


