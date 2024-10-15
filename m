Return-Path: <netdev+bounces-135519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24DD99E2E1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04761B219C2
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD3B1DF970;
	Tue, 15 Oct 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="frytr7QN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F761DF731
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984807; cv=fail; b=gptN1aF1+/oN9FPFHXb3Lz7Q5pJq5iQPfqpH+GADjpTr7qB7kH+VnkP4IsPYibrsc6vFyuoo0QFnb4Tc6oRjOFdf0NigiRL26LDzX1AnX/BOHFOopYqZ5peIIAHXRbUfBgI47unO0F+J/WwePuXfNl3Ek7yw8zW88JkuoOepsG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984807; c=relaxed/simple;
	bh=IHryUYKqh1trjxg08vqLC2waSTyOYAWvL+P1LTokP9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4V9gWKEMgqHiVEU1HY1NlwtNMUW9Ek7nNVy7FOuhleEwmOM4X1Zf5APUMMVbd+j7aPe+8EzEFfwI9lJRXHHOXXz240aXipj0wd+TX0fvM/qmwm/E96x1qiZp1NVTJxeQjSFjBGRjTvtlSGPL+K5ZNvht/Ej+95LGDPQlhKPSow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=frytr7QN; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQzcXZHiWdB4zagdf5FO29nc5ExZXckI6HtedIKXiKydtnLK5tHvuAd6ALtI0ryTbWOWwLvnRBjfjXC6odnWlCtkiVp2phvUCWxL4kD1YHWz17YghSeDoYtxPW77KMK8M4G44RgUuFIyktFQCLi9bBXhILmke2Ixxhf31cHERSgBxXD+rVsiyQiv/HePid05f+UvsSAWv+8DWCEsj+WsirV8Z+RNK8ji0Wic9xhtHpgqmCND7Lr3TFXqA1AGbtIt7saSLLRdZWbsGdDGDn8s5V1QshzvS9eyA8J1mWOZXsI0yZc5ZdUPlSLT+anpu5uC7HUmfc/ouSxQeCnZr1emGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuGlx8KXf6pz317HQ5azBOlTCo10KSWefuSbDDwo878=;
 b=PZPOa82hlS8yWbrsEvD+JJA+dtc335X4wbtIFZn5iOiUlSFw5KPyOJwHCHIrfGQirU/eJtZ4Esd4FmqxdUaP+buSjT6pKWQE/sU1McyP2L9H89wVe4EGxtAl/BPDdCP+7WgCjGmXEShX6HUdAtSZfWbWLE6aHb9E6LXUDetz3FxAEthNFuShWjum2L9KvLWgd2K/cR0SReJsH/WYnaDr5Hy/s8OsQ0jcPwbpHajE0VlNMiaxsMdG00INlnvvjWp6A0ewaZwr0C7s7OQtuhF64n0RzMsnKorXCEycwrgzTCrYPz/oZUXrJVy2HtakRGmvIR6mXwhlC68GekCdqB8vgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuGlx8KXf6pz317HQ5azBOlTCo10KSWefuSbDDwo878=;
 b=frytr7QN1y/5L8USpn+n/ZY55UTj9WYGG5QM+ve32Q4beOXU8PxkpAA5ZjaCHKf8KDv8QWa9LEzMBeR3pCv2ZvBQ3HnWoZ2M/3oXTz5MYj1Jj/yWtJX0dGZLrHWDFYRXcboYHFxPpMfeSTlv/zeXsCeG+W1m7T01yMBjyqGmvH9x/u0aOCppL8rABP48ht/oxpb9UEAfsefpVRcxqDKA9QvhhlvcKdF7C2my6cRBjTCsLNODUUDWpLUyfH1XSMcIwYoI0ZlBlnLzIHc4HQEzH+uzL3oWoTwOZF9lEYAADDiM89FHaXGRVoOgHf+PfCvHIi5m0otdopZ21eFwEZo99g==
Received: from SJ0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:a03:333::22)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 09:33:23 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::2b) by SJ0PR03CA0107.outlook.office365.com
 (2603:10b6:a03:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Tue, 15 Oct 2024 09:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 09:33:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:33:05 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:33:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 15 Oct
 2024 02:33:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Maher Sanalla
	<msanalla@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 5/8] net/mlx5: Check for invalid vector index on EQ creation
Date: Tue, 15 Oct 2024 12:32:05 +0300
Message-ID: <20241015093208.197603-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241015093208.197603-1-tariqt@nvidia.com>
References: <20241015093208.197603-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: c37d66ca-9705-47e7-eb9d-08dcecfc696f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D4bIAT+4CwlZQgVy8EQpWwC+oTabJEexdTOJ+663OI6Bp8ljdhdbz7uiug9j?=
 =?us-ascii?Q?hqSzYiZay24X01CY5rJq0keO4Vl9jN5D+0J+XrLxBS5UMUNGBP/Bqz8i53Zy?=
 =?us-ascii?Q?srSGgBuxe0vfzZAXeFiPQrxUw+gPT2A9OJvloAR+vpo268vLnpi8OfstPGVf?=
 =?us-ascii?Q?+2YkfVMfmd1Zaoj3RkbartgPUsIDYJsplFR5WUjWYyzGTo63cD92yVTkjArj?=
 =?us-ascii?Q?vZdlNwZ22MBPe5+wxxj2xIBQB6wOKWdyNXQ4ro2CpXct7t06ZQRm2R+i2WnO?=
 =?us-ascii?Q?qWilaszFViZ8PvFK8R8vXMOsYGiBsGIY0RKdp1KffpqK8jaC0txtqkhqKmRr?=
 =?us-ascii?Q?QYJ+0TolzcCwGaUvqQ9P84QSL7VI1X4c0cRhbxzrFg0VAIelnjVq3G+jRw1P?=
 =?us-ascii?Q?TxCJX7SM8NbfCyHtmS31n5QEO6reariAhb32pXvYeWunzV5mo3m3GM12xPi3?=
 =?us-ascii?Q?Zvj/WUD6KouQvy5qDIthrT7tPOK4QuuO/xNrLiQFlZ7m0UBo4RpdRqsQthGQ?=
 =?us-ascii?Q?8jRRmxRbvRExjD4iWY4DInHj0JkviZaVxa4myQGJ3IyKK0V3NiP9GhC2/Rm/?=
 =?us-ascii?Q?tGASpjacBEBzdcYk7UHEf+SWvZACLLPQxfc9c972AH7I4KSCX99s5rlUIwve?=
 =?us-ascii?Q?bd9OKb7SFzMRdDwmKNmIERyF2aJUEeGrY6xszcvDIN9Ro2AGq5I83bl7/+G0?=
 =?us-ascii?Q?rf+1SK5KqsWNTBGv/o3j4aqOQskKuNGCkGfCSSTon4JqHwiIh1bOYpDlYrr7?=
 =?us-ascii?Q?HGkTOokdwtOB3di8gR/OdIEUBQ08onbbIT/GW5iV3lkI7sA4XMcjx+NnN+CU?=
 =?us-ascii?Q?HLXIqetUZJ61bPyrs5Id4QMOsDFsOXVVy6fAb58FwN4GNNb5vg7lf/VTtR34?=
 =?us-ascii?Q?KKGbcCTzENmy8LUsZvkQrEnqU4ipV8uoRxq63KfMny0HSeuWIFFYMKHWKmLu?=
 =?us-ascii?Q?Md2msGQt8udz7+6fJjtD/L693K0m0iosjuKdT5S2F7sACZ4OT2wk4x32Bb4l?=
 =?us-ascii?Q?Ukm8T1HYh05u33qyKJUaause4HJss2Pl5MXHKCITQCP69R1LmlNvSjdruccA?=
 =?us-ascii?Q?iQPibRzvJs8xuPAmksyB2Qrt5gfWRh7ett85e0NDmYm5JcUEfgCgiNXzxm6V?=
 =?us-ascii?Q?kkLQpFeEejAMJnum8Vor9+WBO5Lu3U7y1b676b6WkUNLQSvYNmGqkO0G4PrO?=
 =?us-ascii?Q?d5pUD59RgwJ0zUU3pZlNHhCzvAw4QRMF065OcnnwQ2tEkKuh5GfzIHEm0iOT?=
 =?us-ascii?Q?CmwslbGRwdBq9mrrtyv4cl+0CMnWbbAJNVQzbliKgV1v5BQI+HDcrG7PbA45?=
 =?us-ascii?Q?9moWn/Ifsha8ytFkotd4eHslNm/DV3HoWuhB8DLZcx2dduqJu4UcSLyZwPUE?=
 =?us-ascii?Q?Gp5NlTDFA1aOJ5PnXflKrur92oCw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:33:22.3217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c37d66ca-9705-47e7-eb9d-08dcecfc696f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

From: Maher Sanalla <msanalla@nvidia.com>

Currently, mlx5 driver does not enforce vector index to be lower than
the maximum number of supported completion vectors when requesting a
new completion EQ. Thus, mlx5_comp_eqn_get() fails when trying to
acquire an IRQ with an improper vector index.

To prevent the case above, enforce that vector index value is
valid and lower than maximum in mlx5_comp_eqn_get() before handling the
request.

Fixes: f14c1a14e632 ("net/mlx5: Allocate completion EQs dynamically")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 2505f90c0b39..68cb86b37e56 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -1061,6 +1061,12 @@ int mlx5_comp_eqn_get(struct mlx5_core_dev *dev, u16 vecidx, int *eqn)
 	struct mlx5_eq_comp *eq;
 	int ret = 0;
 
+	if (vecidx >= table->max_comp_eqs) {
+		mlx5_core_dbg(dev, "Requested vector index %u should be less than %u",
+			      vecidx, table->max_comp_eqs);
+		return -EINVAL;
+	}
+
 	mutex_lock(&table->comp_lock);
 	eq = xa_load(&table->comp_eqs, vecidx);
 	if (eq) {
-- 
2.44.0


