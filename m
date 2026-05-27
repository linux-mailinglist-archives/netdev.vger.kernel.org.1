Return-Path: <netdev+bounces-292422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WExZFm44F2os9gcAu9opvQ
	(envelope-from <netdev+bounces-292422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:31:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B245E90FA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D80431D1B0A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A2246AEE0;
	Wed, 27 May 2026 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="klD85YB6"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011062.outbound.protection.outlook.com [40.93.194.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A24611CA;
	Wed, 27 May 2026 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905969; cv=fail; b=hzz3Kx6Wv5u9n6GRAEgVD6d7d2V49ZkicKJEPVmL/Ak27AZy+gnRX1ZHeeAoXBE2VFRHrtNArRz+1HXSl1kS1cuEfenK21CGNixKsZMFtLu5Z5uCx6rxO+IUC3IPXj/pi+tPqUK0XQo29jKfza7/44LVuV9E4lE/JSRKOtsf+RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905969; c=relaxed/simple;
	bh=K3qVaUO8w6blyRz44K/ooCEbuFQmEZXKkgczDhu1zgg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HPxvaqSXaOIc1EXILMQ4Gyu3NjtYwHEq6KqW8hci0LyR3utL+vTuF5NBJudSGK5y6Wnk4egVKr0jy9LhY60/6vwwK0dIiwhxbXBOKgClgMdnWQqIrtjbZKnpB1ZH50Hh1P57klTBX11Fg5rw64gJ0Ot5dDO/3/jIUptq7Se0STE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=klD85YB6; arc=fail smtp.client-ip=40.93.194.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nj9SrRO8s7fUw0CXAP/07fi/3aLQxuCQGCDviKNjnaAOMqYV+anK6udxr69GujazxzfE0tUhlAWqd6n5uM2H1fWv4+wsWaZVj/s9fNyuG5Wc2sM9WZgi6uehPUJT90SS2tcynJHoqtiQOXq82uWnlnEUoH5pkEKI2S7o0wMQBmjPx81FMvOsD/H1GSUU4iPzwij6CUMxJVQyfEHPoxTreeQvj9PM0siAn5mv++IlExG9C1qxr1CHfBiYTBLyIFUHXQYXeeKz25eQ6GPVI37mDlY3ReyG4QxW1L4qV/61oVsPaZQNRu7c6qrEvyeM6ktsNlQloeqVTgz35f/BfOnvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m20GqNBffSOXH4n1RgpWm1i/Eu8Xg3L9Dl8j66GzUIQ=;
 b=CVMjrCgjSqfXxDq5xLaac9w8BijMOhAqUVfx5M+wWit9jZ67BuJWRcaLqfVCblNcs/oLZ5DtZsWXM6sH+jqPyuAGDQVKc+523+IrKIndnIQ9Gh1I6BD+TvGeIqh2HWy7BIxcokUxXbeaPzmigQGVVMdeABs3VId3Rt6tLpGx731JTiKRhRgBsMjIAwFiGxthRMuhL2sQnpX55sBn+Kw+w5yjKDoJ39jQ4iVKgfUiDARTlJKx95VdcJgb9jiTK2n2ahL27l01Y2hZTI10lVIhhAhuKR5RA7XU1PLtUFeZVm/2nMUNwK7iAvBeQMnolvt6maSBRJAPFUmh01JVbfq6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m20GqNBffSOXH4n1RgpWm1i/Eu8Xg3L9Dl8j66GzUIQ=;
 b=klD85YB6Xa+9ldDDWDH+YW495/fH4tKrGD71k7VVEuu9+fSRPHkN190xMSB8XsR3ybweMed5c8rIQmRItVqTKq4kPCCJXWcDcdhQmtMl+DzBrNQWZ6lXuggquRfyt6X+8UbPicmYgo5shJQOHSKkhHEmdeRorop2DRF5+j2esmn9OfX/Te2EJNh0So3aCTUBAdaQIMdQOSD7cQUDoNOtXndbde3fIiNIiQjz0zL1gQdKlNKhFKyWO/TytEmzZgjZw1f19UlkQ+RYITFii00yZBC8m5E6gQjw+aFU1wfGFNYsuAKsUyz39UBs8zr8shvPmMTcLwvkcmOENjN8Ky4+vQ==
Received: from MN2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:208:239::21)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Wed, 27 May 2026 18:19:23 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::91) by MN2PR08CA0016.outlook.office365.com
 (2603:10b6:208:239::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 18:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 18:19:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 11:19:03 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 11:19:02 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 27
 May 2026 11:19:02 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: [PATCH net-next v2 0/2] net: lan743x: cleanup netdev-based logging
Date: Wed, 27 May 2026 18:18:56 +0000
Message-ID: <cover.1779903597.git.davthompson@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bb432b-3674-4ea0-7693-08debc1c7a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	8JHTITjpWjeY8l9G1VGS7O08lpmw3vr7X+9TAQydQK69RkZ8gF4+sPsmjvKsMiQ4cx8L/YDDjLXzulI1YV7Ttnwh3GQ6PECSPW36dkZpqi4wNIV15MoLCCL/r6w9ISghGy7k3Zex/Luh2u0seWBHWp3R4TIGdKiGgblyD3Bb2W72MrXKtRDX2WnM1OmfS+NhL2pt+JdhAbyeLZAwmlgsgx/dyy3WQP3HP9lQ7PlWvvmzXDH4jvftFY0YB3/Bz13B3unoZga89p+sk1Kbz5dw8/glzObj4dcND4fHrNJumEP6EtS7gY8SMmZzxnxPsGlbUjRaGjdP3SNT3HmyhQHxRICtU70GHRrhl/FgpV5q60QZpgC8gEj9vatK/m5ca3B8QvOOU153daPzIekDfeE3myGUjZCKLXFjhIioO2lT4iD0yhlNLU/e4nvzbnjOFfrcVPAUaI4wC9LHtGxg9lla9z8wM26bl14F6ooOo4vJLiFNMC1DTedlGwbfmOjUZ6NF4uoPsMUcY7bfK3V74jULGRqoCwO5siZ88eh4FN1f+v8J34AFwS8/4C7xayOiYsy3uCUvsCe5C5JkQIfiSq6fO+UMuSnKQfyPJoL5OuidhB5lE1oI2rOnO+7gsjnCZbKTWMyZPOVCOKsPG6vG2oKFa5pvrOyV4FCT3qs2ebYcsi0UPTF5p1Z2ckvEps0DyXk/TqHnC+2GISLXRja/uJhBx8F4qAfq4g1iCRAvfMrg5hg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YhF4/JKbjyXARakOSaKJyHdKWGlqZND0tAIVMwIfe03HhFaO2Mhtt2VXhx+aFfnQypAHD3tAo+tZa8nFfuVLxwy88Zm8VHrJC90ZvtSwynMagCIXTo2LVZA/kWp9hARS4kX4W2OuZuBMwTiCPLiOWMg8VPmUk3/x8yFsHm3zm5mJSrTmGo9uMDg83ZoNO5vsAyP8bG0wupbwZK5uexhnLY4WkwS2ghsjK18PhiAtdMs5HKMl6isAAmWlsMXPRkbHmEvO2SngQBwzwtnlUz8fLrZvLPhcvVROZCwUjs6G4c7CnF5L7duVC1uHGLWguO6vdFOJfzNZeDghzh/Pb/Tz8K6p+HpRA8d4PydASRhWj0idFyBUn0K4VAiGK07O7ZLG4Yj//JxtjOevTYX+ae32QspgsD3F8IX4wrDRORcJ3oQkG0GgwQLEx3Sdatll53Lj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 18:19:23.3589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bb432b-3674-4ea0-7693-08debc1c7a9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292422-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Queue-Id: C3B245E90FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series improves netdev-based logging in the lan743x driver by
addressing the issue where several log entries at boot include the
warning "(unnamed net_device) (uninitialized)".

The first patch introduces a "message level" module parameter and uses
netif_msg_init(), allowing msg_enable to be configured at load time.

The second patch ensures that netdev-based logging is only used after
netdev registration has completed successfully.

v2:
- Added patch 1
- Changed target repo from "net" to "net-next" 

David Thompson (2):
  net: lan743x: add "message level" module parameter
  net: lan743x: avoid netdev-based logging before netdev registration

 drivers/net/ethernet/microchip/lan743x_main.c | 87 ++++++++++++-------
 1 file changed, 57 insertions(+), 30 deletions(-)

-- 
2.43.0


