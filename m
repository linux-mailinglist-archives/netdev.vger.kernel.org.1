Return-Path: <netdev+bounces-104182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FED90B727
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467C9281E0C
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4334516631E;
	Mon, 17 Jun 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CgqPw4U7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B26166317
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643428; cv=fail; b=dssRZJbKXkmvqRfbbRzvo6J7rj82vVG5d3Kij/CqNUBWOupN3ITsYiShJFebLVrj6Vs7aDJpF5V1ZrGrc4feDYxU16pqzjRLbxs91+1Ii+jdjU9t3kJDSdJT1sakOFnCqwiSml59ETdNrubGg6KeZM6zXgYxGiVQj2vxi+NKIEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643428; c=relaxed/simple;
	bh=KE2uzoEXHNSOvwsI/71hk1GIC4UvhSUBEKV+olAriq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObJOYvy0MkWDuCCku69j9uA4TwwYJZYsFtzziU8EalmWV0Vjm5z41pliHPWnsEyehTkmDCxpYB7WBRX7+UnpsxC9puBh6RCmkQx0uMkk0EHcICVgzV8HSyINcw+wSiczaPt9q5fgY6nbJUnVoaI3oYVUlgS/FWhl3MMq4wnXvF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CgqPw4U7; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLpeh/2N32ERAKb4lUZV1pvFBkA7vWfnZEVyB2QyucMarmQDA2qFIWfZsWTudXczrMsXn7wUL3FhbV1bE72QDMukkV3qyJXKpZeZn6RqNd46+XuRkJOSH13Q2dgS+Fh2+FlFadsNBk72Ud84XCv5QT4l5E73z0ZJL5scFoYs83PxyeWdBrSmBz6WjVMdQ3L/hOc8gNqKhhk6l/i0AhCIxGC6eg12zVG3X1Nj0aoZUXs1oxCgn68XLXCiq/rSN5+dLujqCJlGOnYrpcd3bX9dVYfO89UuQsPJRY8RTprWT9BXJPBKutnA91HUAMB60QFJjnNMBx2SCUwbvwhULR2f/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IQmdjyyEz+O+y9khsISw09DC1ZRHIO5lc37l+N9xh4=;
 b=AWk51uBi4yk591XZO4fAfbwS4oZcS4mABURHY8TAJBZ5DKEMQ2xtqcw3Sblu8DDYCf/7ryRmZBPntrQpz5NRDW4HURJqoJ6UrfwpMAGF2qrSA/gmOeXAPoyl+x8OoL55JSqH9pRGjLUHV7iDMWIs1QNWyHZbTd5hYtIbuExVAsltkUTIF3Mt94E6VkYP/StJu7GmpOFCuhRICOdKQLdR5tJV/L5jeZ4hi6J0eNoTRIjFf4cnrgK6dOjbE0P8UuEl8Y83b7wIPpf9e/Hisi2S4UosSrCn3hNiSorz8CAPaDBTWcqWz2/8RXqB5J+FscXVPhNSKm0J20N9niTKyiUuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IQmdjyyEz+O+y9khsISw09DC1ZRHIO5lc37l+N9xh4=;
 b=CgqPw4U7f31KBZY3V5+PLpsmoS+MAobXOaOeAK2yjrM/LmtNNfb8ytV38JPKxcRCpDU9nNWFk0E+FYFpiR4Wt2/6d9gvxQgGIRPUPKjf8+QzYexq7vgNQX78762XaLqyjrliQ5fxK2bBLJJ4l7NPctXdUtaoOsWADz9EH4hIE6JTNr/DLIZFX/Xk6WWU8tMlvPqS8d87VwEulgvY04WAJRU8vcD+whMlCvcdXBpFWQ2qz78Hpto/tcCfvuSeWOeiUj7vLTQxYKjWLObf890LOFCp1ROzCG9bTKw4oPSZIzKJUjKqazBR9LFdaEdmnxK4Gr7yHEdOaE/ifTzh9zzy9w==
Received: from SJ0PR03CA0076.namprd03.prod.outlook.com (2603:10b6:a03:331::21)
 by SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 17 Jun
 2024 16:57:02 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::4) by SJ0PR03CA0076.outlook.office365.com
 (2603:10b6:a03:331::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 16:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 16:57:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 09:56:48 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 09:56:43 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Lukasz
 Luba" <lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Vadim Pasternak" <vadimp@nvidia.com>
Subject: [PATCH net 2/3] mlxsw: core_thermal: Fix driver initialization failure
Date: Mon, 17 Jun 2024 18:56:01 +0200
Message-ID: <daab03a50e29278ae1e19a00a23b4f73a9124883.1718641468.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718641468.git.petrm@nvidia.com>
References: <cover.1718641468.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 1892c522-275d-4022-fe61-08dc8eee82b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iFJUCiL5Ak163/plwHVWC4KVuFDkuCewqHQYLpkEvbX0DDpXaMnxdHd+y6ap?=
 =?us-ascii?Q?6OkxFlCtcd/8NpZxgaABfXKrhxWY7cF+WISdQANd0pISL8vSA436cBqWpRA5?=
 =?us-ascii?Q?54V4OTipXR081KWrurm3O1I/OHw2JrMv1+W2TsErOwAuLhG39OcOUptObvlp?=
 =?us-ascii?Q?mnSeLnvPF247oG6uLOVjNn/ozaH5K42mmNB4gwbSDSrP7x4uWvLMiiUzXFQ0?=
 =?us-ascii?Q?wGHYZ5f2KAYnBmIURjcltatYCcQePNRQGFKpoy1PJpy7gmq3gvJhPvPnZ5IW?=
 =?us-ascii?Q?59iUU7fmI+wNskb+wqxHP9TgXgwGi1AVmGLoLwBh2fRQWed82qKSEzdmCQCc?=
 =?us-ascii?Q?J2MHZNVrxYWWMQxUA4njV3iYJeqMfvBgHQXaYI2rWtVavLeNMr+kbQot62Tl?=
 =?us-ascii?Q?VKGbV2kOtTxYI1BA6dxEsP//hYuPM1nDmEZYzhxzGfGMAYW6Uy8kcp9lA2kK?=
 =?us-ascii?Q?/Bpp1y6zgRwKqeIik1yQDzkhTjj2CLJn7ig1o5Z8D8qpcHEmo+rHRncFTj6q?=
 =?us-ascii?Q?UI8wNmGtKnTrlKJfC+u0YzeSSVJmx/ryUKyOcEOcFjeXgZgmnvAEeyQBN46B?=
 =?us-ascii?Q?e3734rj17fwAiINCdrvlewC2h6VeOxPufJ83YT1spCvwwDJWe/kf35gh6CBJ?=
 =?us-ascii?Q?Fp5Pq2BARvdTMA+3NT3absuwlcis5sPNlh1MCzr43yGynED0TE2AXU5qQj+f?=
 =?us-ascii?Q?ciiEZPXB9QNW+/jn67oQgTK8I79dpfdl6PXY4iiVQnG2ITYPxCMUodePB7fW?=
 =?us-ascii?Q?J//vmIINAY/ohKG/VJG4Y4FcU3pASUJjAS2K0srzmSn8NibYeJiZ9w3PR6Tr?=
 =?us-ascii?Q?2Ix/QgQ1iROagbS0fJ6tSiCjT1ghbYt0kCNSb4FyxZugruvPl+5I/He5w+2X?=
 =?us-ascii?Q?9bsDnk0tk8zI88fJw8JSbwoaamMYpI3oMcwsEJJTY9LoWYST7vhusHSrx8BG?=
 =?us-ascii?Q?OcqjCuWMP3OjGhL6q2APOk9fIsjlwxvff+K0uWke8AEmBIYuQyQwFnMFNq4o?=
 =?us-ascii?Q?aVbJqjMTMJAM1cq/39CkfEw9SjNfFO5VNB/tFqb/aKmrcUoZkUV63HQq7iGv?=
 =?us-ascii?Q?Lh+OZnZvI/dhYbootA4MlB9J2/NgqEYdOajmQue7Hfvp33RhCZjMrc02TO2d?=
 =?us-ascii?Q?4M+tZ+kBy5/jcA0pxqqjrz0iNAg9Hlqe4it0RH3Av4O0TwcXZBdzXiB2NCmo?=
 =?us-ascii?Q?9EaXm6RQMwC/oeOCz92gBxcZRBtvZQeOJ+IWZKNTGunUyC4jWbhG4ml5AoYu?=
 =?us-ascii?Q?IFKAXlSCdO6bUJeqPihbt+QFEs+EN6qWlGUzdbe20cnE8F+vN4ivSNgYo1Bi?=
 =?us-ascii?Q?7vUVtAbNdk0A0UmbE0VyyOYnCiFWd+WvDq42YYUdrD/l8v+IJT12l4pb4/CS?=
 =?us-ascii?Q?wbtQqLZP5dGVBfW2WAO7gNMOOT0VsP2tetMZotVQWdZQdj502Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 16:57:02.6002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1892c522-275d-4022-fe61-08dc8eee82b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105

From: Ido Schimmel <idosch@nvidia.com>

Commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to
thermal_debug_cdev_add()") changed the thermal core to read the current
state of the cooling device as part of the cooling device's
registration. This is incompatible with the current implementation of
the cooling device operations in mlxsw, leading to initialization
failure with errors such as:

mlxsw_spectrum 0000:01:00.0: Failed to register cooling device
mlxsw_spectrum 0000:01:00.0: cannot register bus device

The reason for the failure is that when the get current state operation
is invoked the driver tries to derive the index of the cooling device by
walking a per thermal zone array and looking for the matching cooling
device pointer. However, the pointer is returned from the registration
function and therefore only set in the array after the registration.

Fix by passing to the registration function a per cooling device private
data that already has the cooling device index populated.

Decided to fix the issue in the driver since as far as I can tell other
drivers do not suffer from this problem.

Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()")
Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/core_thermal.c    | 50 ++++++++++---------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 5c511e1a8efa..eee3e37983ca 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -100,6 +100,12 @@ static const struct mlxsw_cooling_states default_cooling_states[] = {
 
 struct mlxsw_thermal;
 
+struct mlxsw_thermal_cooling_device {
+	struct mlxsw_thermal *thermal;
+	struct thermal_cooling_device *cdev;
+	unsigned int idx;
+};
+
 struct mlxsw_thermal_module {
 	struct mlxsw_thermal *parent;
 	struct thermal_zone_device *tzdev;
@@ -123,7 +129,7 @@ struct mlxsw_thermal {
 	const struct mlxsw_bus_info *bus_info;
 	struct thermal_zone_device *tzdev;
 	int polling_delay;
-	struct thermal_cooling_device *cdevs[MLXSW_MFCR_PWMS_MAX];
+	struct mlxsw_thermal_cooling_device cdevs[MLXSW_MFCR_PWMS_MAX];
 	struct thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
 	struct mlxsw_cooling_states cooling_states[MLXSW_THERMAL_NUM_TRIPS];
 	struct mlxsw_thermal_area line_cards[];
@@ -147,7 +153,7 @@ static int mlxsw_get_cooling_device_idx(struct mlxsw_thermal *thermal,
 	int i;
 
 	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++)
-		if (thermal->cdevs[i] == cdev)
+		if (thermal->cdevs[i].cdev == cdev)
 			return i;
 
 	/* Allow mlxsw thermal zone binding to an external cooling device */
@@ -352,17 +358,14 @@ static int mlxsw_thermal_get_cur_state(struct thermal_cooling_device *cdev,
 				       unsigned long *p_state)
 
 {
-	struct mlxsw_thermal *thermal = cdev->devdata;
+	struct mlxsw_thermal_cooling_device *mlxsw_cdev = cdev->devdata;
+	struct mlxsw_thermal *thermal = mlxsw_cdev->thermal;
 	struct device *dev = thermal->bus_info->dev;
 	char mfsc_pl[MLXSW_REG_MFSC_LEN];
-	int err, idx;
 	u8 duty;
+	int err;
 
-	idx = mlxsw_get_cooling_device_idx(thermal, cdev);
-	if (idx < 0)
-		return idx;
-
-	mlxsw_reg_mfsc_pack(mfsc_pl, idx, 0);
+	mlxsw_reg_mfsc_pack(mfsc_pl, mlxsw_cdev->idx, 0);
 	err = mlxsw_reg_query(thermal->core, MLXSW_REG(mfsc), mfsc_pl);
 	if (err) {
 		dev_err(dev, "Failed to query PWM duty\n");
@@ -378,22 +381,19 @@ static int mlxsw_thermal_set_cur_state(struct thermal_cooling_device *cdev,
 				       unsigned long state)
 
 {
-	struct mlxsw_thermal *thermal = cdev->devdata;
+	struct mlxsw_thermal_cooling_device *mlxsw_cdev = cdev->devdata;
+	struct mlxsw_thermal *thermal = mlxsw_cdev->thermal;
 	struct device *dev = thermal->bus_info->dev;
 	char mfsc_pl[MLXSW_REG_MFSC_LEN];
-	int idx;
 	int err;
 
 	if (state > MLXSW_THERMAL_MAX_STATE)
 		return -EINVAL;
 
-	idx = mlxsw_get_cooling_device_idx(thermal, cdev);
-	if (idx < 0)
-		return idx;
-
 	/* Normalize the state to the valid speed range. */
 	state = max_t(unsigned long, MLXSW_THERMAL_MIN_STATE, state);
-	mlxsw_reg_mfsc_pack(mfsc_pl, idx, mlxsw_state_to_duty(state));
+	mlxsw_reg_mfsc_pack(mfsc_pl, mlxsw_cdev->idx,
+			    mlxsw_state_to_duty(state));
 	err = mlxsw_reg_write(thermal->core, MLXSW_REG(mfsc), mfsc_pl);
 	if (err) {
 		dev_err(dev, "Failed to write PWM duty\n");
@@ -753,17 +753,21 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 	}
 	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++) {
 		if (pwm_active & BIT(i)) {
+			struct mlxsw_thermal_cooling_device *mlxsw_cdev;
 			struct thermal_cooling_device *cdev;
 
+			mlxsw_cdev = &thermal->cdevs[i];
+			mlxsw_cdev->thermal = thermal;
+			mlxsw_cdev->idx = i;
 			cdev = thermal_cooling_device_register("mlxsw_fan",
-							       thermal,
+							       mlxsw_cdev,
 							       &mlxsw_cooling_ops);
 			if (IS_ERR(cdev)) {
 				err = PTR_ERR(cdev);
 				dev_err(dev, "Failed to register cooling device\n");
 				goto err_thermal_cooling_device_register;
 			}
-			thermal->cdevs[i] = cdev;
+			mlxsw_cdev->cdev = cdev;
 		}
 	}
 
@@ -824,8 +828,8 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 err_thermal_zone_device_register:
 err_thermal_cooling_device_register:
 	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++)
-		if (thermal->cdevs[i])
-			thermal_cooling_device_unregister(thermal->cdevs[i]);
+		if (thermal->cdevs[i].cdev)
+			thermal_cooling_device_unregister(thermal->cdevs[i].cdev);
 err_reg_write:
 err_reg_query:
 	kfree(thermal);
@@ -848,10 +852,8 @@ void mlxsw_thermal_fini(struct mlxsw_thermal *thermal)
 	}
 
 	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++) {
-		if (thermal->cdevs[i]) {
-			thermal_cooling_device_unregister(thermal->cdevs[i]);
-			thermal->cdevs[i] = NULL;
-		}
+		if (thermal->cdevs[i].cdev)
+			thermal_cooling_device_unregister(thermal->cdevs[i].cdev);
 	}
 
 	kfree(thermal);
-- 
2.45.0


