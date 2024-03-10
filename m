Return-Path: <netdev+bounces-79027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CB0877761
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 15:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F921C2111F
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BDC33CD0;
	Sun, 10 Mar 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="myb1pFUW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB622324
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710082542; cv=fail; b=QXSc6z9ncRVD4CVJw2ht+w3tC5EyxOispQDkXVh545N80+kZyBcQYw0SOEWhr2abF+yrYQXuFL4Ih6oD6pTGkBG/3CHVQUDyKN85qohFYZkHMd64gLzYAvM1Ct9007UFeeDPDwSRtTXtSiLZNrct3iXbXr/eP0DSvzkocYAOXPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710082542; c=relaxed/simple;
	bh=hJaPtbM8dCj56VVrI9l9TaCZeuLhSSiK144l50udfh0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lkB95q3MeymRYlacX7yRaoHELKqbwhiTHbqoWTtHHF3plMG4m5ruDVP3UZ/qIet/42/DQr9h9NIhypjXTRarPi6fPN76R4It8RHR7zju81ZFv+G4r03c15LxzVa0bQQHVD9Y9xM/AzeZLU3KdY0R+5TyNJDjpfQ/EYTbhoYE1JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=myb1pFUW; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfbMJvIgN3c3mtJ6n2n8Y7VKx5b1im9fKKxh/+78WcPAWS/v+YXMQOk0/ST5HTcSsgdAop1ixnAKWm/NdKkWwbSHY2JYhQ+KCMRTRKfqOgZDZcOFQ8M+jwB+jgWB4P5cZHh92tiujlBFVxgZeygG1rdNAExUNHRqX+aBN4+6NppoFdF0gu2oFlygQiqLz+6U5J0WlCXimJ/6hbWSt/kNrUnPBBacYERC/53E9Z/hweZWnEq3iuHRbtAQswFFMjDFfm8s4XTdn21Wv0HJVWS2XIoiH26xeyE3+nR06MgnOSJosNfQTfWXVWNGDlCk8lBQlA6q2kDtyOwBUV7hSyWdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lbkl8+lpdKt0RttdGF29uyfyBykeAn/Z2TB3BGQyf4=;
 b=FVOIzr6Z3S5MOHxnOEnuAc7abzAItx7qAmjPhGRCjHe9LTeDPeBAyz8v3pAYhJJog/4SsULenRDk7KS1lV4y7TMR/mraum0BRxLGPilnnZvI4kijvhbATukreutvNyrB30C3tLAMI2x92tkKHv1CeCMNzHsEvLAnkBXIJSIZv5ep/9hvPGBpGtlRvw02qy3gfUZogqXchpITqyecK8vzm3WC9EqcRo6nwCIWxeILSRu2osvWwVeUL/6ii5oDSr9DQTMH4NwCBz8VCBTQCrgBbb6pDwg6dP92DhMPYhJrKNjzT7bn2M5sBOCW6HR08kVy2Ok8W09SeEzRzvIbl5g7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lbkl8+lpdKt0RttdGF29uyfyBykeAn/Z2TB3BGQyf4=;
 b=myb1pFUWr+Fb5LQDmN3INd9iZPrI+5o7LVQy+a6BWl3LljW9aTms2XnCpEp4MYGpvprJ45AdTk5zjWL2vlsTDYMhJOuzAyqThEOzRO2MfZNOfUUOBLYeUx0qkdMBlykfxuCh/55SiA47spzKOvA1In2ENSMQMF+A03W60MzGLCZuDy5tmderDzwYcNFm5zygW0gTa+Joo+fBw0GMdS6VwbXfjuBOzDm6aY4Vchv5xd9lxQyu2fINizhp8qUQP8F4HFSZIq7mkVc/me9aKl00E/vet2MsMm0RA5ePLC8o5jxGXbNboTy2mYmxn3h17REoWrYNpl8DEkP2Wihu1/5h/g==
Received: from BYAPR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:74::27)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sun, 10 Mar
 2024 14:55:37 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::39) by BYAPR05CA0050.outlook.office365.com
 (2603:10b6:a03:74::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16 via Frontend
 Transport; Sun, 10 Mar 2024 14:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Sun, 10 Mar 2024 14:55:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 10 Mar
 2024 07:55:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 10 Mar 2024 07:55:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Sun, 10 Mar 2024 07:55:35 -0700
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <kuba@kernel.org>,
	<witu@nvidia.com>
Subject: [PATCH v2 net-next] devlink: Add comments to use netlink gen tool
Date: Sun, 10 Mar 2024 16:55:03 +0200
Message-ID: <20240310145503.32721-1-witu@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: a30ceeb4-0bb1-4461-64d3-08dc41122589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ia8axkkBtNJIR48ULRExRZagBfA7EdCEBpf0hLh3/fw810goXKvXyt1JUVQKSwHE6RmDZvXq+av27Y7dLdJuW7xKa2VcFEFAwyHIiIZ3zvP1FZZ5ZlcLS5s/C6Pr+gsQmd9Vub5fyCOMaIBdYmYhkMCOluEHa5JtD0zdN7RLBvgrAK4YMJY2dXDpcg6OJj7JfUbU44RhLVngCvGGcY2giBHSfMJIoEAMnxT7+4qGMqb4WQkzhUAt8LORwoc7sMAzb05+E2YNOQ/c1uxIt+46HFOUfNpt02y6QGZz13KxCS+ID3SaLyBLAGSvpa5dhlWCVBQLhDOkIbABB8UQgl2wueePmZwPe9ye2uOIJYnC4NZFOtForGgDdSKPhLHBD/i/Ank9PZgLK8mOu7dBPQtH8ierk1mPRPoAhCDo8E3Rn997reFQkC0mXyElBA0Fs/vBR1IYu3hIQFE0rRo1xLa5dkGju65RkrhqvPSyF2hNkwvATF6WrXNhytcBFmnpS/utUw3BoiPGt1231McosKRRGjWVDeNs2PxNEGA7OkSphADxrtHJLpTagqnvh2ACTWkcPa30+WHYTIueQ22n8i9Ld6l120xEILVeySxGx4v82tse6ZiPNqrEnmWLb5oKUxUg3ygXthZCFsyv5w8yrfLTe2fFaGdhP1brn16gh8bK2ZaR4BQzyx5DVTjD4Sm+mHQ3YKTySBz73RpBNayqm4ydeh+2wjpvEtTjijRgGpBPZZsmOOZnwm4G42cmc1nDGDTK
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 14:55:37.4589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a30ceeb4-0bb1-4461-64d3-08dc41122589
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099

Add the comment to remind people not to manually modify
the net/devlink/netlink_gen.c, but to use tools/net/ynl/ynl-regen.sh
to generate it.

Signed-off-by: William Tu <witu@nvidia.com>
Suggested-by: Jiri Pirko <jiri@nvidia.com>
---
v2: fix checkpatch error

---
 include/uapi/linux/devlink.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 130cae0d3e20..2da0c7eb6710 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -614,7 +614,10 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
-	/* add new attributes above here, update the policy in devlink.c */
+	/* Add new attributes above here, update the spec in
+	 * Documentation/netlink/specs/devlink.yaml and re-generate
+	 * net/devlink/netlink_gen.c.
+	 */
 
 	__DEVLINK_ATTR_MAX,
 	DEVLINK_ATTR_MAX = __DEVLINK_ATTR_MAX - 1
-- 
2.38.1


