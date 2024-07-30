Return-Path: <netdev+bounces-114180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D769413D8
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2DB1F24920
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441CC1A08C7;
	Tue, 30 Jul 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qplIeZwI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3B1DFE4
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348023; cv=fail; b=kNT7D8+JHQBTlPhwP5yVombzSf5vS/UiDnlN5j8X9RMj94ZOiGLafCFcSCqh2a8t1scV4zqmpulfNV1Bj24EDY3ycxGBtlI3C+uj4iCjy1lKpf9vg5tbXI5e6kijV+yF9MfNGU6lGp4z98VNx0x01KlHBM1nyST+8y2+bSHcTaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348023; c=relaxed/simple;
	bh=hK3KGEItqJq7/zS1jwOHSeVR9IWojFjjLwk8dbiiL9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+4X3mzbbRBNpo0+TUhxt8ZMI8MfvstcZ7zY8ICJmpxW25/CKpoGe9blJtTN5SsWUldPtTApc5fOHAyn/d5BrkA5cGpGizxNlP38vbJH+yBg9JMJOahXdMUTwtKkORnJ5KSjcYhtV6/TNmnDRCZdO9JcQknoE8nxZHgC7bxtkq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qplIeZwI; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIXpyIxVQZwVfjhCuvRIm8Mtzp7bUXMv4D3MaN0d4oUgePNAokvEpzB6pWzl0g+Mkowq3ZsesEbMnVPqXjPxO0Cj9KS8J3+MTcm19XdvW2f4qJAjsVEf5lt8hSuFLdGBMYZPuJPlTc3VH6t0ib2Mc0J49GIj0Z4Cb9ZBgGNMXYH1wezrogLXbO9II5AreHX5dh3aEF0d04F9OsrwIlzUCCQudLOpfbyQadUXvgN9erm89vXUjMZQRyi9ipQ3hIue82L55+kdom2D8cc6VeNlTOAV6dvP5z8qGhTXlpC+KzxAD8C3LiyJOYrdiQIS+z+OImet/PGTV9SP9WPqO2+cJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGrtKUaAkUOZrDQe0UMZUwZ7Ldul7asa0P+VoBb8Ri4=;
 b=wDYW8LpOdn6MB5bgm5s72NMd8Vahoja09uSbIOorRAhtjCeNNBwjd8EVqHDekyWkOkn/Gr6wzVzMqGhWOffXuiWpszP9uSWv4c1NGvT6T8pZQcxezuK4NxEiNAjiyr9x5nu2Vu1HasdeTMxRmaWfz48jiLInWblnTezw0yNzu8xuoJ/0YvhzP+84j7KtZiqcJ+it3jD2CQCTsRZubtjjnruWWejnbhsE3R4k/5UQT9J3GHc2PUYtlPeNICVjLZJDsrS/eBPCY95pZDWmrh8Oxqs6me2glhFQ6GS8RJRSgDW6/FBC2JkP5qnuvM0Wy14w5V8UHLesA6+TxseNIH82Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGrtKUaAkUOZrDQe0UMZUwZ7Ldul7asa0P+VoBb8Ri4=;
 b=qplIeZwIwZ/4kbLegryaI3lM7Zh1l6NgLtwkdGgXT/X2LJEUPoDfdRGNNnbDhFKv3dda/LjIl8NRs96w5d+sBTQM33pYxOzRE2wJ0hOa3x7jqZVX+a0QwAAfCww+PXx98H9zHVJrCbiXTdiMUTE4L9BMv4gtCLjVdvfWjTtFmBkDki3/XiF9EG9NTXE9jzQq7FqxFFDiBK3SsNcHjezgRYDunArbN/pHCHv7ANmLwaee/5bXMwX9NpAGDgwao0FuCAuzCJzGDy1Ch2hmDgbv9plZg06jqpfzga7S7Wtuj6Yj8daZMAV3Spgv5n5XhWkP/XEKMNBUwbcQeCUPvEeYqA==
Received: from PH7PR17CA0046.namprd17.prod.outlook.com (2603:10b6:510:323::6)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 14:00:15 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::9c) by PH7PR17CA0046.outlook.office365.com
 (2603:10b6:510:323::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 14:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 14:00:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 07:00:00 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:55 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vadim Pasternak <vadimp@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 10/10] mlxsw: core_thermal: Fix -Wformat-truncation warning
Date: Tue, 30 Jul 2024 15:58:21 +0200
Message-ID: <583a70c6dbe75e6bf0c2c58abbb3470a860d2dc3.1722345311.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722345311.git.petrm@nvidia.com>
References: <cover.1722345311.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7e5df6-a846-4757-5362-08dcb09fef97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUlWNWpZcjFuZ3RBekpKSVkvRzcxMFJ3alN1b3BnUzNrMlBwZ3pzUlBHbGIy?=
 =?utf-8?B?Z1lTc3BINXhyakEweGFZbUgzZ0Q2NzZzWDBNVnlvMDhHVmh5V2YrRm85R1J3?=
 =?utf-8?B?bE95TUpjNWpHbFg5U3VoN0dHZHBYUkJyZ2szZXdWeGhNRjR5QzUyVmFIUVpE?=
 =?utf-8?B?SktMcDVDU2QrUGhkbjZzUlBubFFDdlFTQldDR3hMb0pLZUtsVVZoS1J3L3Za?=
 =?utf-8?B?dWtXWE15dVhhb1NuWFc4TkRnMWVncWpYNmdxNGhqT0d4Lzh2ZmlIcUdvOGE4?=
 =?utf-8?B?OFVrNXIwK1R2czRtMDhRWGEvK3ZKKzc3SEZhYzFMQzN6aWNmdjY5NjJPajdj?=
 =?utf-8?B?Z1Bid2lzZFBtMUJ1c1NNcXUrVHRwZUVleVhiYkxJMXJMcVpSa0RTdEQvdTNv?=
 =?utf-8?B?ejZxRWU4Q0x1V0pHSzFOV09MMmphMXliUEZVdm1GUmpnbEg4TnpSSUpkd2RW?=
 =?utf-8?B?QUVtNFhkQy9VNU45UDYrekFpaWFUS0p5U3ZFRXRPWUovbU01S29zS2haZjBQ?=
 =?utf-8?B?OWZYdnhYVk1yTlE3aStDSEoyeFVsTkZUTXMrMjRSdm9mbmZDTFA3YlVQNE9U?=
 =?utf-8?B?R2MzZ2hrRjhMZE5pbHgvVzVFUEc1WisyQmwwZ3RwYnZZWFd3MERYZzNjNXl0?=
 =?utf-8?B?UjhNS1lBUWM1RDFMbGxkbnUrVWdibXNZWFlKaVpvNnd4ZlpjbXFIaXJ2blRq?=
 =?utf-8?B?UCtoUFgvbFZqclR2bDFqdjhKRllnT0kvUEdtUnJ2NW50MkthaEpnWEJjdXI0?=
 =?utf-8?B?MzU2TzF2M3ljSFBURkt0ZHNTZHRmQ3dJMVVsYTh2MFFzd1JxMkN5VzVyd1NB?=
 =?utf-8?B?YXp4TEVCZUZyRVVnYk9wQTR0aDJOK1VXR2Q4Yk9RSkQ1a2pOZjJjSWV2TG9B?=
 =?utf-8?B?WTJ1UlhQNGp1LzdkMURyYVBubzRJeHEyN01xRjlzT0JiM3JEdlF6SHA1SS81?=
 =?utf-8?B?MU11bUY5L1FhWjRFSy9qSGoxYjJNRUxveTM5aFUrSTd4bGs2NWdId2dGMHcr?=
 =?utf-8?B?a20xd1dLQ3pERlNVRndYWFdjaWtJak9RbEk1WlVOSlIvdU85ejA5MzV2dXpP?=
 =?utf-8?B?WnFlb1NqQjA1dWVlS21xbDVDZHhpWXBIa3VxWjBNWVZEZGIvSXkrT0dHbytE?=
 =?utf-8?B?ZzYrZkNxaFNSQncwZ2xyaDR5MW5TVThYbGl0K28vbkpzaDYxWUhhMHAzYkdh?=
 =?utf-8?B?RTY0NkRvOFIzYlNFckR0WjZVbkd6Z3hOZGJZb1dkWjBkdzNmNjJsRGJTU2Ry?=
 =?utf-8?B?TFlHVEJCS09KckdHQzMvL2kzZWhCcmJXL01ZdUgzMWcxU0hQdWNVNjByVUN2?=
 =?utf-8?B?MzFNZlMvUHd4OE4vZDBtV2pPM1F4MHBEMFR6bHd1MDJTMDZIVmE3UUtpQVZB?=
 =?utf-8?B?aVlZOWpIekhaMHNGUE1OellWTEw0ci9mMURKakRzdEZBUW40dGdyaE1reXNp?=
 =?utf-8?B?MWRxM2VhZGhBR1NjSzVCZzhwUjFINGJXOTcrK3VibnpNRXczUDduODF5ZTBJ?=
 =?utf-8?B?cHJqcGZRc0pONkY5NzM0SCtsbWE2cW15aEpYTWRsT09mODhiNk5ETng4NDkv?=
 =?utf-8?B?TnBBdUd3VDZ4eURoMnJ5bkxLYkRvMkMzbDluaGUyNWg2VExxYm9CZW1xQkRI?=
 =?utf-8?B?Tkw3aStQR1h3enFlSGVEWTNhSWhIMjBjbytnTk8vNjdreVRCcXZiQS9oSU9W?=
 =?utf-8?B?bEJBRnlYcGl2S0txbUVaWHI2QzdRVXBoZW00T2pDaDd6d3NRdU1KZk1rb0pi?=
 =?utf-8?B?QmFERU1IUGVSMERKd3hubFNoYkRLRWk2V211cDFDSlAzelVMQVY2dDB3cXVw?=
 =?utf-8?B?cDRKUCtjdHJ6OTB0Y2IreTBLc2hrR0hCTFNPK2ZSQkF3dFgwVUZmQkJvNTRO?=
 =?utf-8?B?YmlKT2lCL25oLzhqNUluREVlNXlSdittNE12eVc1WmMrTjFMdmhadU12VWkx?=
 =?utf-8?Q?PEJS8lI+0UzKVmL0feMFpE+DNNNQGZ6L?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:00:14.4478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7e5df6-a846-4757-5362-08dcb09fef97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037

From: Ido Schimmel <idosch@nvidia.com>

The name of a thermal zone device cannot be longer than 19 characters
('THERMAL_NAME_LENGTH - 1'). The format string 'mlxsw-lc%d-module%d' can
exceed this limitation if the maximum number of line cards cannot be
represented using a single digit and the maximum number of transceiver
modules cannot be represented using two digits.

This is not the case with current systems nor future ones. Therefore,
increase the size of the result buffer beyond 'THERMAL_NAME_LENGTH' and
suppress the following build warning [1].

If this limitation is ever exceeded, we will know about it since the
thermal core validates the thermal device's name during registration.

[1]
drivers/net/ethernet/mellanox/mlxsw/core_thermal.c: In function ‘mlxsw_thermal_modules_init.part.0’:
drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:418:70: error: ‘%d’ directive output may be truncated writing between 1 and 3 bytes into a region of size between 2 and 4 [-Werror=format-truncation=]
  418 |                 snprintf(tz_name, sizeof(tz_name), "mlxsw-lc%d-module%d",
      |                                                                      ^~
In function ‘mlxsw_thermal_module_tz_init’,
    inlined from ‘mlxsw_thermal_module_init’ at drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:465:9,
    inlined from ‘mlxsw_thermal_modules_init.part.0’ at drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:500:9:
drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:418:52: note: directive argument in the range [1, 256]
  418 |                 snprintf(tz_name, sizeof(tz_name), "mlxsw-lc%d-module%d",
      |                                                    ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:418:17: note: ‘snprintf’ output between 18 and 22 bytes into a destination of size 20
  418 |                 snprintf(tz_name, sizeof(tz_name), "mlxsw-lc%d-module%d",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  419 |                          module_tz->slot_index, module_tz->module + 1);
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 269c4986ea24..303d2ce4dc1e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -411,7 +411,7 @@ static const struct thermal_cooling_device_ops mlxsw_cooling_ops = {
 static int
 mlxsw_thermal_module_tz_init(struct mlxsw_thermal_module *module_tz)
 {
-	char tz_name[THERMAL_NAME_LENGTH];
+	char tz_name[40];
 	int err;
 
 	if (module_tz->slot_index)
-- 
2.45.0


