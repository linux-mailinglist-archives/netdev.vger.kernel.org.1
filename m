Return-Path: <netdev+bounces-96852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816498C80AB
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 07:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B111F21220
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 05:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F160B10A31;
	Fri, 17 May 2024 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3Xc8Qg1T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170FB2F5A;
	Fri, 17 May 2024 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715924876; cv=fail; b=cqcFviZ8RHvzdF7UMmGRCgZVAXPmFpV1bTNhMitJ6+GDnEsslAp//22PxpNip7dYif3LV2HqUKmyiCfzoKFRQLIwZF+yLLnqCNC9B3KTHcUJoPBiCdCh4N016d9CACLPhGQCSKjmGOA9DxA6edtMRRHQc9IiiGxIm5Vk5ojewh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715924876; c=relaxed/simple;
	bh=/noEDlr6o9O+GKq50jtVceyYhGOMMzCtRES+PW5DOfM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C48zyATxLFSFGu8++DLl+HNERZ01SZxP04DZ92n1XgDRJ70/xcMR5P7DIRb7StucSAyCxwTJJ9ju37ljodQpz9jlFH4z2or9rmEGKeMQJfFby0ce2YFebJs3czE/RikG4eHnkDl2KZjtx/NwGOAOmTD88Y/7sf4wIFdJZEefZ+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3Xc8Qg1T; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P24zIec3zjvfKQa1CBMWMfIMDrGw7e9oB5d18EdB51vZa/URe+mQeFwsO9WflpbYEKaQiAox8CELnL4WMnzhBZaSRP6i2pl9uAf2JA7RqI7Wm3hwavzEjOzIPQdd+9mUTXrT1OvEC7mXeHYKFu7j2ccRhu9Xkd0bnvVizopxbGNMiMbvZBWWHKwteyS2YA+qOsroeJvJdyL/98X/16UKcb+RNamTFBkW5HMAq7EMeY5TM6P6e50zg3lDa3OERNM2JBVxkcTTUmHMfN/skqnNdCN4xzrJrM37sHa9lG2zeaGcfPRvjGl9zgJfZGwOh3w40sp6vAjQuJjfVNFF5u86hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3U3qPyWXLtv9Sxw48JKZ8Mw8eyN6UWCl8RBj2r7fxU=;
 b=RD741PI2wDwVXL/9GOlYqkW4lM9oqJZjTqI4EQoYu8K5XfqHvt6qCT6CE4zetIRobhph0dT/apg/ylmd/Ec/fkUt8eTGAlgGd4hfcXggJPZUpHiU+k2BYXkZYvbTJz1ecvzjDIDFOWbNR+sd+bs4KNuWOEt64ZhRUBbwAHJw4P4nXlQ5lHWS2GN8cDrm34rAF9K0nMp4iaMNU+WI5PP4kUkFihQd0BxedMM9rb/rjz1XbjAX1r2qXNEODhbR36TgbCwJbpo0hAkGmovLeAAER45ZL+WW/2rKRqPOg1A+U/Wr2Ba43YxCrQZ6A04KcSkWmKzIt3KhClyBU5hSHntT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3U3qPyWXLtv9Sxw48JKZ8Mw8eyN6UWCl8RBj2r7fxU=;
 b=3Xc8Qg1Te53w7JL24R33JbZgOU5JLk2g04Adsh3Ni4ri9vWqhi0EbeDEMQrDd+3rHXei9enq9vMOAr3pEfEJ1dsekCj7yjTgKF/zGSEfyEgCC7gRK1PDzaRKGo5PK1oGvOKKw+A0JRStuT8lN/jbZhfsbW3BfnjKFCmYUOXTkPY=
Received: from PH7P220CA0042.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::25)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29; Fri, 17 May
 2024 05:47:52 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::b6) by PH7P220CA0042.outlook.office365.com
 (2603:10b6:510:32b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29 via Frontend
 Transport; Fri, 17 May 2024 05:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 05:47:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 17 May
 2024 00:47:50 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 17 May 2024 00:47:45 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <harini.katakam@amd.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<michal.simek@amd.com>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v2 0/2] net: xilinx_gmii2rgmii: Add clock support 
Date: Fri, 17 May 2024 11:17:43 +0530
Message-ID: <20240517054745.4111922-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: edd9d81d-2f8e-4324-bcf8-08dc7634e3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|7416005|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?siaOET9ITlpq0tmhKchpnCv14mIuMzN/eI4CqQJDm1kjDegXhadbhOoOa5Pe?=
 =?us-ascii?Q?us1fmNUlrMWxToK+MEPiyssrrLaylb+bCrftRewwsWrYnx1XYpLqeDii1ZKa?=
 =?us-ascii?Q?Z0+HFp6v61Soh2TByfV7BxwGHCZG9lB8d8Qv4w2lhJAUWh0etpwmuNt76XVS?=
 =?us-ascii?Q?gsUb6051ngQIkiHPSPMXlcZIMOTStYafb+UUHUbamnf5TkH0v1xMzo/yF4BN?=
 =?us-ascii?Q?f+sBDNXUya6Z/gx9xHoH0AqOhm2lStl9ZpfY/cnlhPN0Q+17J29Uk10IJx6t?=
 =?us-ascii?Q?rSyIbBcAqbvPapeSwCn9GwxdsA0MaDJOpjd+sQHNpQezlpLcmpvEtkBbbtCc?=
 =?us-ascii?Q?amCbe1L4lj26xx2D2XB0EP80cGHWQt/rs4slzadTv1lHqAHUUxVsxdOxJSEU?=
 =?us-ascii?Q?d9SKtRlPluBKDYV3D5FYbtvOjYow9ey6uX2aN9Xai8s7SqKHNxQPGMxe66re?=
 =?us-ascii?Q?+lOMs2BHaspbKREWUuMGkIE4ZOCZ0BXEoqVbN+4uxxOk3YztxtiNIBcbZA93?=
 =?us-ascii?Q?Z0SwLqTE2UW0KkPSWFXtQfKyySkbgWxgpm1NtoSMc/tJCEc2+LQB0JuD7+NG?=
 =?us-ascii?Q?azNN1Dsnef50U3b29t9Ldhyf4GXjkWg6L9BWJ4/7yxWzw6Ial4eDhe5qa6Nt?=
 =?us-ascii?Q?AV3G9d5sS/IbMFECiyMD0H/9/j6HYw0viYniKUR3uCUQ6hqsETffoDNCE62F?=
 =?us-ascii?Q?ekQ31HHBrPGM7HJCm9Ebtce1T2YOKHbnWf9cBSINn0aKtp+x2C2rEFwrWRvp?=
 =?us-ascii?Q?APR32pEsm02JOkpR33Y9fnw8cuQekQwdmZQIPKZLb4e32rhfFsd35XsjQDlF?=
 =?us-ascii?Q?Q6VcVMlO4/9eZywcb3KfNe+01K/Oun3WyWzNykV1b2P7C/HnJeOJhjjWsHgp?=
 =?us-ascii?Q?93Jf5ogKIbMWwLk0N9xJWukPqaKLfwU9S1AhnxTAwsmYO5tn5SmsqTiwg+p/?=
 =?us-ascii?Q?xMOgu0RjEZFLEdmqzNSdydokqh1CZ3J1obNEFG88qUIsZyU91oxmsxVSIGG8?=
 =?us-ascii?Q?jAlIw10urpPAdtyhvb5zlUdnf4ztAmjLYrRFUE9iZPc7fjtTMoayayw278Qe?=
 =?us-ascii?Q?4uHgPZdLduKDWBIWwYASXVFC8IkB3pbx/g5NsfSzppmgHI2+fVN0LOOhe2cZ?=
 =?us-ascii?Q?fXLs7iE3M0+0KPO0UjIsJgM/xQGYPEVOsnQ4w9bVSV18B2hdE7vle5af/8e9?=
 =?us-ascii?Q?SYjU/5MjeNQKYnmo7Kd0dlW5BpbQ7tgDNIrPEsR7YejKkxHI2plDvHgI+s8L?=
 =?us-ascii?Q?pUqWO1tnAyfdRm0P83SweQcwQT5ppX1TvNFKKk+KDrZIv7vk+hJn17pplXiM?=
 =?us-ascii?Q?zWwRhxAjV+/mzEB8hYBwZPviiRdXFpT5rXrGOYRDSC7MOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(7416005)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 05:47:51.2585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd9d81d-2f8e-4324-bcf8-08dc7634e3e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422

Add input clock support to gmii_to_rgmii IP.
Add "clocks" bindings for the input clock.

Changes in v2:
- remove "clkin" clock name property.

v1 link : https://lore.kernel.org/netdev/20240515094645.3691877-1-vineeth.karumanchi@amd.com/ 

Vineeth Karumanchi (2):
  dt-bindings: net: xilinx_gmii2rgmii: Add clock support
  net: phy: xilinx-gmii2rgmii: Adopt clock support

 .../devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml        | 4 ++++
 drivers/net/phy/xilinx_gmii2rgmii.c                        | 7 +++++++
 2 files changed, 11 insertions(+)

-- 
2.34.1


