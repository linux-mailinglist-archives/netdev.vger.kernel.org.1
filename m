Return-Path: <netdev+bounces-86427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2B789EC4C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771AC1C20F32
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201826AD0;
	Wed, 10 Apr 2024 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O2j5w5Kb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6741C2D6
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734785; cv=fail; b=IX0tm9PEXdqlJl/dFttOIcx3bAFGVVBaMgW68KL8cOQk8g+xzXDUnLK2EmliEZsH7hPxyzhV+HGH6VcrKkR86hrplueDjokKsjCkyoEvOS1YC0A1qrSqceaJQhwxzeeNOOphYP3meQeKrP7VJGsgyaf4cS/EfGqsWGG4hl7dZO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734785; c=relaxed/simple;
	bh=/SZpXOtUoGy7g0UU51oJatcZuauHVZvbuFtInXWRkbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrmArx3nCeZURJRgdZR9Cu9L9dgwqmC1OV2zeyWf/F2bkw/D9+WUv1OmqPsObP5U8z0fSiqj4BHtWIHawdYKPTiii3Q7eS5VzT1mwiBQpkbYeOXpKTv6IO2wCLBFKQ6MSEcobmZDharc5GQpkIwN2PXr7RkCmJodrNpWLIT3j5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O2j5w5Kb; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnMaOMRb7Mp72FZzEGjeE0sqLMkFavWpiSZ6cbDYoI2mRJ1OReilmzAjHlabwSi7/LX+RvmzvmfyMjKxLDvrXdxbnDTVVRkIs2nFx4XRsvb4U//2y544+0tiftxdR5hzHPHjJ0d2eW+PeHxwAiD2S4puTA2NvorMS4eJ+sYcQvkkOZsONEgSQYXVFBShRnqy8zTvPqGVDtSQ83q0f78NQTWMmaXnRHuzumIb7QozQG0TP+rmZsufeBLC+FeOVUmbSKDoJQZeYCplcD+/MpP5/2/QElVe+h+WonhxRumV2R2TEyFbdIw2g52pfwPKWVrJ/mn0OWtXCKwMRTk4qDVEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0rZENuqGkV9NSLK1W870077bGrpGAFOruwiY9CW9Us=;
 b=hykd2YrKL50Pm4dNDvrEWTjl9QgybrMiW+Rbv5tCQM+Xs5mWal9uVNFLD6KH6BqYHBHT9pE+yRWMYTlZIKNghgoVMSeEB9/9/ZylZ1vm9MW4WtwvZ2jOAIP+nf7/i6qTQN/ysZFvAV+1LSgU+q0UXtf9R9i209eViJ5/wdUclj1BQI8fhXFJv10ciFa6g6byfIYZxVbFAfrhwgHRnNnH0op9DFQvzqTyg8A88Y8JXPfso+dpF5g3MY7L+ktUn4+3w7pPgAXAjAxbDvhzVfHo7JABZPZLMPGM0hENAJebk0URXJAgvCIctAFBuwZHdT2vKiMgB/NfObV6LBT8Pw0t2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0rZENuqGkV9NSLK1W870077bGrpGAFOruwiY9CW9Us=;
 b=O2j5w5KbYhU6j+EQftKEahC4xSLD4zxhds4WTMUjFSx7CjDzpAJmwm++dY0OmMh7Fcld7dmDal2b6bGbKLM6NTWmV2TKaloe6uR/VFoz5XdvKR2Kw5x7i1AtIFP7p9aM+/OOz7/bCbukjpBsHm7qD3DP4OwQTRAhrZ+y4MwsspCjVIcTyOeM0DwA7VD7bmgvfDlU4YOOX8ivb7PVQfkJLcwGa68OQWrn0eY5zFAAfntPqQBjRGe1AFfzi90pXU8u4152IN80vr/D/tX/QBJj2OCqvrZ9Dao4la0Pd8ftW2LidogmCt8dwVrE24VHaOEupFx6ZV6t2CpbxZO0ruToqA==
Received: from SN6PR16CA0058.namprd16.prod.outlook.com (2603:10b6:805:ca::35)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 07:39:40 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::df) by SN6PR16CA0058.outlook.office365.com
 (2603:10b6:805:ca::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.21 via Frontend
 Transport; Wed, 10 Apr 2024 07:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 07:39:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Apr
 2024 00:39:20 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 10 Apr 2024 00:39:19 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <dsahern@kernel.org>,
	<stephen@networkplumber.org>
CC: <jiri@nvidia.com>, <shayd@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH 1/2] uapi: Update devlink kernel headers
Date: Wed, 10 Apr 2024 10:39:02 +0300
Message-ID: <20240410073903.7913-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240410073903.7913-1-parav@nvidia.com>
References: <20240410073903.7913-1-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 13cdb81e-358b-4407-2314-08dc59316172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qs6XVObOaUcXBRsWebcuh1bWF3KXC4ROe24t2Kqq3TDfW4Z9zsz1Pl53Cj2zlpDUA8ip0k+OY8ArIu4IZIanUuUTrBktcpUo+5GJCMzsBrQas72zL1phge5XeZ2ze5gIEkUgOeiWicsYjRfwYtBVx6ERY2tvPc5t9j620Rm27VAj2yOlIpJPZ+xMtkDoyD42tWqWVft1EYHKQ8lPuNScsA4PFo4ogtGeGOauFuA9QDFS8+Wt7OHxbNmpJV1mGFRBMfi3zkEw7R5cs63zJ5r/pjmGfkvCqhg+DZ5yZ9+HSCIzd1SXl26gCnyNPIUh19qzR33NCPbo+5DiAdxofoL9pc11vJKVLNyBNkct0b5eR0JaOvSBWyq5uIA1qE4GKQo1uNk/hp0gn3xNxGgVn3lcmkeFF5FDof5d8qefmuunru/Omm9uXBbph1/hxB9PdD2SoY+o4LfhtT9YbYWkc4bgFP2e5I8AmAouqVhFwFBKsnLXtCoz3VieA0AhMHRVD8h+8AY1m7MfWt4V8n4FNVDhu1H0jWFVT02fA/cVdRbCxlCLZQpX58X1NrPvozj3WCAGcb5d3e1YOpqxZK0wVYnmw1OniHXGHCO3nfJEGPNlEyMo+C8uGfSkFciQBY9F0lSHVuEEezkmADa/WznLwJGCIOoJfFosBxgu8o90eKb7zL3+NpsGhpmqYqBfx78YnVDSdqDOgtNeWLf+Z7tMGaGeC9EPivfP1w3ON54wpK0wmfHFN/NUTox/MLXQzEpASepD
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 07:39:40.1188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cdb81e-358b-4407-2314-08dc59316172
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187

Update devlink kernel header to commit:
    92de776d2090 ("Merge tag 'mlx5-updates-2023-12-20' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux")

Signed-off-by:: Parav Pandit <parav@nvidia.com>
---
note:
This patch can be dropped by first syncing all the uapi files.

---
 include/uapi/linux/devlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index aaac2438..80051b8c 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -686,6 +686,7 @@ enum devlink_port_function_attr {
 	DEVLINK_PORT_FN_ATTR_OPSTATE,	/* u8 */
 	DEVLINK_PORT_FN_ATTR_CAPS,	/* bitfield32 */
 	DEVLINK_PORT_FN_ATTR_DEVLINK,	/* nested */
+	DEVLINK_PORT_FN_ATTR_MAX_IO_EQS,	/* u32 */
 
 	__DEVLINK_PORT_FUNCTION_ATTR_MAX,
 	DEVLINK_PORT_FUNCTION_ATTR_MAX = __DEVLINK_PORT_FUNCTION_ATTR_MAX - 1
-- 
2.26.2


