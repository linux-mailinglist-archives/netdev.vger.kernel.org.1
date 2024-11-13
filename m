Return-Path: <netdev+bounces-144579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA979C7CFF
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D22832F4
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE3120899D;
	Wed, 13 Nov 2024 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pzUhwVmt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651D20651B
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530064; cv=fail; b=MXLxhHLDndIJ3HTJ2RZDsW4m3iWiBrOycVavEMsMfIDl3UTFr5H+v1w1o7zTeA9QH159bKGFzTa4oby+Z4eiEFohWm4fFEL/nyTPLE9tUOq4XK+fF+K7InoJTFxaYbhVHJcwGwwbK/tsgokJSz3c/qBf5VNRTEOKFssb9wMQAtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530064; c=relaxed/simple;
	bh=JQIMpO3MG7TIvSwENnIkWVQpA88wm5cGzNVFJDAoH04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwsADj0llNM+mUDT9R+OSAAknDfeQKWgPcLkpnG6KAVzk43WbQ0IqtPSLdvS3Xth7xvB8dwyxRXpI7tU/30AsMdu0ksHWE39bLGNpmnBsAxMSfXzYm3To3rwFjtEsriyFYz5g9ADvQGZHni+/EX9ZLh+01neJUxurqXq03twfLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pzUhwVmt; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpG02Bom9AErToRzdIX3LHyeVq+kCqf5k2b39JRpJQ0LTBWQRzHOLB5D913SNvgHwRG5BTzHpszrraYO8RjcqVrBThrwANf1mbIV7Bs8mU2IGuhga7P0Ov4ExlLGUzvUgV+aEFBLwMzocHalbW4YMx9x8aRS1jJtnJpQdask3ohmXdqIO9CnWU3gsmhmBNkSL3tokoISJNUzQAEoPaQetPcAO4Mdco3hameWlhXbLyihd5gKm5kM6IYZ3HpRiGmtqDkNcx4pYGQepml1ehiIobI5Q21MdZUkD0oJuclHvHoc3teJ2EVzij49ylKffWAiNZhZ5S6Sf4x/sjqXByz19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiYZMcqiGHfPkht4Cd15ogoh5oGL0pLLt1W8ozlCV/A=;
 b=Gb4feL3UN9WD0AB+d0/U4z0jG+UxfSLysf08UA5UOqwGA77Is1ueMoNdfq0abxWMl1KhCYH9geQsGlnEB+GnGbb9DUKceugGGQI6CC/zzS5ui3TkZMRuLEO8ToHQ4VdqMqHpLidrDAT3botZvlzaU5Ee8xn9DGauizbWf7dYqDgC3X9wax40HNSamY2aXAkXvONOokVvBJ02aV7IB9TIu8gmQzJ2aT/sHfJMywslKi0vM53C7iQB8q7d5VZ1AlrTu4a4l/EslRoiy74hrtolwO1rEkhPysMM2zHtHeIYefwN+bEQQxCZpKTRrA480bMol5sDoRodFK6GHXHPJGOOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiYZMcqiGHfPkht4Cd15ogoh5oGL0pLLt1W8ozlCV/A=;
 b=pzUhwVmtUGv7HR1TQj01UpLy95BGk2yoI5kaHWTUiRehRZL8Jqpl6ExHZ67V109j1dRo7A1F5MxeexPCGru8cebGk3e0gggicv+ivdFKWe4H8Ya8mbg9xX1OYdTF8LCDezaUPCC7jcCSUInI/WRgdTGuxAeETdUYzo+KqlKvJ7vNM9rt5/XU2bC/zItFxsIbo5wk4ACLPbSpqUt/E2t1zOuIu5heZs0gdEhIcRj+ftloITcn/jRjvqVy8K+Mh5a+7fpH5oq56BQKp6yae3nEolXjd8mX3BQpe1cUa5+IvrZ99/cnpKhg3aWwp76qH2+731/S2HZzNPOu5U3XdjXPYw==
Received: from DS7PR03CA0295.namprd03.prod.outlook.com (2603:10b6:5:3ad::30)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 20:34:19 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::59) by DS7PR03CA0295.outlook.office365.com
 (2603:10b6:5:3ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 20:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 20:34:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:34:02 -0800
Received: from nexus.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:34:00 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <tariqt@nvidia.com>, <kuba@kernel.org>,
	<saeedm@nvidia.com>, <cratiu@nvidia.com>
Subject: [PATCH 10/10] net/mlx5: qos: Init shared devlink rate domain
Date: Wed, 13 Nov 2024 22:30:47 +0200
Message-ID: <20241113203317.2507537-11-cratiu@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241113203317.2507537-1-cratiu@nvidia.com>
References: <20241113203317.2507537-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a740570-27ec-4eb3-71d5-08dd04228d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kD6NKbv/J7y0QQ3ubmhPr8dh0ZQ/gCMncMjoj0mhu/KRLbs+kEjqs3Nrp3Tl?=
 =?us-ascii?Q?ISRdIZgcPHSEall/vVytnx5J0ZkDW7bc1BPD0eWAmXfpIkvIwKU3oRXTo0KX?=
 =?us-ascii?Q?h/EGfpktNtCQwsVA2YN4yEYGgOBHo8m/dNzDxBT9x5082I+14EWu0IC9O5qX?=
 =?us-ascii?Q?KnQ2W196i386Uu9ynWbn7Wg1Tyuthxs0XnkvJQl6v61ZfqUFHGbrebzh8E52?=
 =?us-ascii?Q?pEVJD2HpRPjzHnKbK6uyAy1nCRtHNv0eVKRELvKC/IFx5J8GUfM7wCGzWJgS?=
 =?us-ascii?Q?kpwrCyZwwI33u8ckxN2i67W6q2VvZwqmRSDZ+OYZjoY0gKfV7JTcObkNBPJS?=
 =?us-ascii?Q?mHO9RpIPQb+YZ6cauP2O4P2rSDkGINrLRw9hkw+UW569GrkcbQiDJznFL9/j?=
 =?us-ascii?Q?JtVytqxp0xpLVeZxQpHEDptcAFMiH3dO8tKRTQkIpeEAo2JCEd4W3myRoFc1?=
 =?us-ascii?Q?1D+v7gZfxwRSpEBfjvsMPAZ1aYAL/InzdCPhu7+pesv0P/WY3/DQ+St6LkmZ?=
 =?us-ascii?Q?6MByIYvkJj4djizsf9MuAJEF+4WI9vsOP806hmMsHZQ9efPX5Ov95iB0a9XN?=
 =?us-ascii?Q?Dk3rkEjNIC2JnpEPoSnbB9xu7dIOGDV7HrcCLDfGLe8qSiss2PyLarq/1DJg?=
 =?us-ascii?Q?v+SqWvoXLW4Wi2Nj4B2C3AGtFCuATO2Zi9w1dawdXs2+T80mOLC8h2RMdOlr?=
 =?us-ascii?Q?iUeOoSUvZ/rVTNNRn1uUVcw5MSmq17spamw6SvWAwUMrmLFncjjI83CIMYYr?=
 =?us-ascii?Q?Y1RpLwALO5u2eAlik58RHp+hWf9/8cMSNbzKtRnSWKTq9rGsUA33dlMfj/3M?=
 =?us-ascii?Q?SI9GdHqxFFeT1D29N9dmPlN+yCT/B5QtJ0cy6z0ghIsC6bxTCRiMwxYaDPO0?=
 =?us-ascii?Q?IqkkxN3sc6ydVNKlMjunh7nFdooiQ1tl3Ga+kliEMWbpx4eZFzBZt5FVUHB+?=
 =?us-ascii?Q?qpi65tXQTJUhI4Vc92hXjitBuy3iH9dH+fBli0+F3JmDLJROcDg1hrXM89c/?=
 =?us-ascii?Q?VFdCN6k0JZaWb+QsG33lY5bYJxqeZkbzQSkClabN073tq0lJNPlgyL1gdMTW?=
 =?us-ascii?Q?/eIKvdT3id3l0tq8Hd3SYlcrqTfLrlmS5ju11CxWT4g4gViUtIVlWZ7BA3Od?=
 =?us-ascii?Q?yPmyOGs8fU4AKQ4HThuLuttfyyPxOTQb44W1bfs1KlyL+x+QFrCzsdUznB49?=
 =?us-ascii?Q?9cq+YzyYGp/u540a1erAkcqMdlQhT0lgukXGzSTsDHgD9kqlKyCJ+mCzz0AV?=
 =?us-ascii?Q?HJNxG8q4RrAHPSdIp8e1F99CVUwqbLP9QrkFz5/59S7jVGnWKCEGOTPFlIgv?=
 =?us-ascii?Q?5GrHgV1gqK8f3atH194s8koWMPIwDkisxEnQfgN9dhB5tD8+BsJ/BVisXAqV?=
 =?us-ascii?Q?qqM5g2VnPW+O3L795u6p3wWRFx06A0IoJnd6Uh+rxg4o1psBEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:34:19.6743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a740570-27ec-4eb3-71d5-08dd04228d0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423

If the device can do cross-esw scheduling, switch to using a shared rate
domain so that devlink rate nodes can have parents from other functions
of the same device.

As a fallback mechanism, if switching to a shared rate domain failed, a
warning is logged and the code proceeds with trying to use a private qos
domain since cross-esw scheduling cannot be supported.

Issue: 3645895
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Change-Id: I6ccb5e29f316f97ad8a559fcf5d59ee70f2b9315
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index b75f9939ae4b..7230637b4303 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1577,6 +1577,20 @@ int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
 	bool use_shared_domain = esw->mode == MLX5_ESWITCH_OFFLOADS &&
 		MLX5_CAP_QOS(esw->dev, esw_cross_esw_sched);
 
+	if (use_shared_domain) {
+		u64 guid = mlx5_query_nic_system_image_guid(esw->dev);
+		int err;
+
+		err = devlink_shared_rate_domain_init(priv_to_devlink(esw->dev), guid);
+		if (err) {
+			/* On failure, issue a warning and switch to using a private domain. */
+			esw_warn(esw->dev,
+				 "Shared devlink rate domain init failed (err %d), cross-esw QoS not available",
+				 err);
+			use_shared_domain = false;
+		}
+	}
+
 	if (esw->qos.domain) {
 		if (esw->qos.domain->shared == use_shared_domain)
 			return 0;  /* Nothing to change. */
-- 
2.43.2


