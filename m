Return-Path: <netdev+bounces-86526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962D989F197
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EAB1C230A1
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFC6159909;
	Wed, 10 Apr 2024 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ax+tcJp1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D715B10D
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750383; cv=fail; b=PgRm0x8aBFKQIZjRD7XXCH2qqLi3eu3yTJjlik9jt/uZ6/WmJosclnfE7mT6pyKOivMxlkAVpfKmIdXJtd4ig+zqDut3V1YZW9SrOCOyHJc2cyDwKoyzaXkcsQu6mi03k64VCPbDM6xLoJ8UwqVOeavfrrtpCK2v7G5ToikJXnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750383; c=relaxed/simple;
	bh=vKvPhi2GBf8Lfqp8zUd3BB0ecYLrZTRMigHZETp3oUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBVqm00OJstoqLv+CHBHp9jpiU+Q3flDdK3kfUD6f8cvGRmgLk2sB4qikDMaOULk9ptkU5v3R+iARvHyJaa4gBxN/X5C6J9zkixzEvplNUD4UPzckKx+8BjzttroAvKQc/NP6D3aJUEPVeFk3yYRuU+Ue/C5fvAIgZtDkrUgfoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ax+tcJp1; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdIjb2xRnT27qwRo5Tat3vJTjGYa/wIJyw6+ZgIm4aqXhGkFCKUde+5vKNubmtloQq5Co0XjLq+ndpBS5xa445w0qSoNYeWWrZlu1PpCMSI1FVRjuZm5QbAp0vkbNdcU2+nq8fW64cKdWTbLWxDLCgexumB2/aa2QXMvJzSBx0pYRagU+4gLfRvLFuCKWfcJZl5zbzZXH86vsifjRYOimkXMeh/HMJ45Glpn/gV+NVnSFrOb4ujNLk2DCHrg680s6P+ocSeHeHXqYNkp2GcpV6jdPOB1Jvx4nv/7Xu/9TLysW3yYDMWk6yeapsoucENdFVTHPDS+Ggir49yW+sagCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxpSH3DuL/qHzrrYWOhra7G/q0jlmugPOobRZ5Y5cd8=;
 b=V0w+42m/9YXyLZqpVMhVbi4XC9BsIUzvPY2akZ2U6mvZMmMtmvWaXzvq8NADN2VwNmx9q0KjgJGhRmbk6FnnTD+ZGqsgzVa/VycomOmKwmp4et/nEiRdn9G6NfiBjWdD5vUlubddd2JW8hWuvYxIwdDRgi7e+U2C3Mbsz7XhQQTZL/NDSN70nUlzuB0fM9BWd8wZN0teULwaB2jjTTro4awbHQ3124UkC7+8hZfX9eMSmwq5vrZO3xSm3aw75+XOdiLgM51uM5gqipznAQ6ojcCNpIQ14ENPFDFuFkJ763Ef+Z+z1z72LBoRVQjmVs7z/x7f20uoohpsyW8ixjc0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxpSH3DuL/qHzrrYWOhra7G/q0jlmugPOobRZ5Y5cd8=;
 b=ax+tcJp1M4HDlste92QS8xj09MtOfvvhlWKOiSOaFFcELVYzgCpu/LNh76Bv5E/EPbVc7g22bO6K4kUh+ohFCBWR6Icxav3k+sF1hUwB1qPrRx8ODCsdSJMd62hhUJRFVQc5FViUNBX84OzppHX9RcKHr86OMzF2PpMsZm/GRp6TQ0mDTqQ5JVP9fBshnLbi5UNKZoVD58ESgiKf31jUIrHVY21k0sOLYMSPDe+SMHO01SUO06ru3qgzYtbF5hK1dNuRypuRiftlzOeiLw13EGT3urcXUl2SEp5JOizotsFIBY8t+vlLIrQt8o9jLoVPE3eZKi9EEaZTLk8It2OWWQ==
Received: from BL1PR13CA0163.namprd13.prod.outlook.com (2603:10b6:208:2bd::18)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 11:59:36 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::3d) by BL1PR13CA0163.outlook.office365.com
 (2603:10b6:208:2bd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.7 via Frontend
 Transport; Wed, 10 Apr 2024 11:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 11:59:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Apr
 2024 04:59:14 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 10 Apr 2024 04:59:13 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <dsahern@kernel.org>,
	<stephen@networkplumber.org>
CC: <jiri@nvidia.com>, <shayd@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 1/2] uapi: Update devlink kernel headers
Date: Wed, 10 Apr 2024 14:58:07 +0300
Message-ID: <20240410115808.12896-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240410115808.12896-1-parav@nvidia.com>
References: <20240410115808.12896-1-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbe0501-5d58-492d-7377-08dc5955b186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o4YVTxt17XPuFhag2878jkI2hWLY4sCCn/IWyzvBcy46gjoMqD+10nlhm5bxkH5LlsGLGhHPDZuOFjQQGWa9dPdhyNb78HpuSdZrLKuS2XTLmyaIcVLcMWTX+Il+OvTFnNoK6OOy+0MPpmw1OaEgSIVaFRthr3BMtG+PHAU8vHnRr4zEv2vREiDCkzLW5HxVrhPbsx5R8Mucwb8lb7b+AcFdJ3N7DOnW2/cwtQXs7/FLxBtlVlhd87GSR9P3sDBDzJSq7U6sZkt1gs1kGc0WF9CfHb+B2md5kurITRN0O54aS2RYdUmPhpVq5O+0SOrcd6g1kAHl0Y1D+A2QpFH5Lm5gfbmFKaAMK4lBZPUO3FDb25J1h5Z5ZH8/XDwHiLZVGGtm9a3ixYqQULdUZnRXpYnYdIKema7LcUczsYdEMZ4pMqWjuUJmAqLNkn6oBqiJmqJ7zNBsecLP4rZortNI9Wd0TOix3e1v0+ivyrhPRICbycrZ8KURYcOluQMbAjhNjuq7XESR377QQBgOi0jUwchMmIItcFMBo5qkGuK6qBIvwtAwLPUQbMH8gJ8EKrIif9DO78hcrdqhafrMSo51xDEiuQzik1oLaIzoUyoYDVQiZb+MttqFH5KOHW9Uxc12KBS8oh6u1UXola5VYNT3f6LO3i5SY3bG6LSHpKsWvKJOJMlwnkMMqkT8WVpVAv6twnXrsWr09sjxLUIjBEbDIM2f0U6MHH3jxGTiTRmmckp0Y89KHtQRzbOHFJzczirm
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:59:36.3207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbe0501-5d58-492d-7377-08dc5955b186
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765

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


