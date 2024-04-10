Return-Path: <netdev+bounces-86527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3072E89F198
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C741C22395
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 12:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B9A15B13D;
	Wed, 10 Apr 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KUlnSqxA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1015ADBE
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750384; cv=fail; b=cv2DWZWojhD5ZgvuvZHGthTTSWdLl15IxGjO/+hv7Pp4JVTF6fTigkeKsCatpnhYa5Dep2R8E2tmrpukQpJBz6zMaH/9tbMx/6Iy+6BgzcP2leZTahcXYT1RBACCs+9YAbzG3AofSM16xKfpyxB6f4cNXwbDZc7HXFy8umMhV8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750384; c=relaxed/simple;
	bh=dKClswy+m9s1AJ2KKRdXllTjkHhFcWqK8U2KZmjXR8A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=njc8LL56u+M7QgQqmaHRqBO/aoedmSKKaMiLh4mr8UHwHGny3jKB2sOlt5hSFxTDMtteSPzalNOwWOd9oPwPHGqXoSMCaqSeJkUMCy4bRjuvRna/CsDs0VwuTOzaL1LDU0dCLm8IYHolUEtFbhubAwnU5felLC3wkf2HqCMh1q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KUlnSqxA; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKgGY287YhxX45NBwS8b+DWZGh9X/KrhPkwgzNqOliPupi0mos52ibJsRFJYbxUDi+4NQSgFtjKeT+dhneFO79bX1Vtr+s3FriuiweaFsNZqep8urTqtsuNNyJP9bXQFEHG45Vhl8ETqG61MDFhcfA/Jw0JyXJ0MEy+UBMle8LHjt+DOa7uy4A8FOPgBYPsNwle94WLt6RvtqpqJkliVPRWuGCQesBz/heyVDmHQD6XszprDDG+QLhDKClmy7AFi5zcXwWmeKuIoFU1U9UTdPETHFiNT1ulUXQ/O+OcDsuw7EoF4K/4ctIqSuJr6llYb8qHumjVFSJMLemWqW5Cz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoXMuH66MlExn7X81NlRR46EW31+S29HgiYOe/H2ULY=;
 b=R9jTxzibKixlmm7nmVgCZYcUKe0v0qn3RmLBHrrgOZFfFU59efaz/Na7L47YEbSUTWIHTFDq4K0WgCPIQ/bKjxFQcYlciV+0RbcIjSmNMyK4yfrouan1gUxDghzhT4qODddw8U9/l0/lxzQajTW+Vn/xoWdeqzqIQybGY/Pxemb7Igb0H7IAdUqF5bqGT21f1OK1VkdXx0ta9qq+bobAFcj+zTbbMkQ1Iu2JV4d9hJ/LmvQ6RpYp1n/aalRnIglq+fClskscEjx9sSxTBIIwn3/Z63SibAPEE5KtQ6I7qyvsXQUcGheIQPvydPmoS95UP+067mTAJ/xiddaOWzlVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoXMuH66MlExn7X81NlRR46EW31+S29HgiYOe/H2ULY=;
 b=KUlnSqxAT5j1a/x0gidm4tC2Iv3ED1Yt6+QcaeskRcsX3amhPmH928NTJ2vRN1anGXY+kbtzoycF/G5djYuAdcWKjQX96eqZ5WDAiWJZvcVp5+5jw+Dem5tJlyFV//wOVTnwxBO5rUJlovzSXqRilbMzWcdgdT9PWShPSys73IzLeH/4V+UDrxBBc19b2/jF0U78kuzXGtYuVcrAjs9CivNqUDPTn6rowEz0wA3NbtE8paYoK1gKJVP70EXvkCgMVGPEc2/aWDK5MSUejqfEo7JkSg/XSipUBbBLomZDcMt/2jF4NYdlSpQoJiDqZTNaPhZJBrnT18yxoxeIR1uEzw==
Received: from BL1PR13CA0157.namprd13.prod.outlook.com (2603:10b6:208:2bd::12)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 11:59:34 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::a1) by BL1PR13CA0157.outlook.office365.com
 (2603:10b6:208:2bd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.7 via Frontend
 Transport; Wed, 10 Apr 2024 11:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 11:59:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Apr
 2024 04:59:13 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 10 Apr 2024 04:59:13 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <dsahern@kernel.org>,
	<stephen@networkplumber.org>
CC: <jiri@nvidia.com>, <shayd@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 0/2] devlink: Support setting max_io_eqs
Date: Wed, 10 Apr 2024 14:58:06 +0300
Message-ID: <20240410115808.12896-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6e78ad-f251-47a3-df8c-08dc5955b090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l+HkLv8PGkTkjU+rAxsbX2z98UKNNYS/SLIo9MtLKbr2dg6fnw4WibIhs6GwFRC9HQ7PHSLus3+qSld6juVs7zT0ZUMTC3k9Yq8o9PobR5dnWKTp7MDRZ2ThR61kgVLt4mVPImDDEgzGmRrZhMBCQXv6Y1nzdYY61gMp+76zLjU+msjUW1DByBn9l+c8dWWoU2ihGzbGAz/5Hd3IfQk7uhM1lMqrRWVteq4WF1vTZikYZFzjhy82zNmCD8GUSGYlgN2KrvAf3U8/G8dpOBmd+U+93/yNNWwFRlca+DFsvdAGBip5vtT5ensfqY98JO3A8efkW0H3k8naGOguPjYjtOL2UkWBfCdPiVtL5rAuBSSvKyBgakI9fKXjo2FGG6J+4qL7FRtsxnm92MPqX7kADpMmYehviEJryNlf6fNhaL9ikjCOJrWGXvYwjvjvl3FZRgenIkSzaOwswLkyba8iHUlazwtVMEXTqUoXmOBaDb8T9SAEpY5Bqk11Qy+IjsKz02TEYaIKOZY+5N9aSPQ2Zplwwkvg3MNu16xK/UTdmr9ZqY1XG/hOyZ+P1+uzPxCgamEEuvGFe88Oz5MfpIqqnL7FenhBS//z0hzx2E/nOQzIrtR8cToSVUJA3KE6ACRAT/L0fDyZRpm8E0ep0aZlJ5JXvwpLP8soTQbNByRf26/GK68UnWgJGZ6luZuUF2xyDlu+ysT8IqFY6Zw4GLPkl02ya3XHku2LZIweM3n2Q/Znt3RFT6QeqMlndLEKLLZ1
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:59:34.6956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6e78ad-f251-47a3-df8c-08dc5955b090
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643

Devices send event notifications for the IO queues,
such as tx and rx queues, through event queues.

Enable a privileged owner, such as a hypervisor PF, to set the number
of IO event queues for the VF and SF during the provisioning stage.

example:
Get maximum IO event queues of the VF device::

  $ devlink port show pci/0000:06:00.0/2
  pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
      function:
          hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 10

Set maximum IO event queues of the VF device::

  $ devlink port function set pci/0000:06:00.0/2 max_io_eqs 32

  $ devlink port show pci/0000:06:00.0/2
  pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
      function:
          hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 32

patch summary:
patch-1 updates devlink uapi
patch-2 adds print, get and set routines for max_io_eqs field

changelog:
v1->v2:
- addressed comments from Jiri
- updated man page for the new parameter
- corrected print to not have EQs value as optional
- replaced 'value' with 'EQs'

Parav Pandit (2):
  uapi: Update devlink kernel headers
  devlink: Support setting max_io_eqs

 devlink/devlink.c            | 29 ++++++++++++++++++++++++++++-
 include/uapi/linux/devlink.h |  1 +
 man/man8/devlink-port.8      | 12 ++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.26.2


