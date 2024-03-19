Return-Path: <netdev+bounces-80647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1A2880270
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CEE1F24C31
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69016F50D;
	Tue, 19 Mar 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C1XJC8Fy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40AAC8E1;
	Tue, 19 Mar 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866158; cv=fail; b=N2opDfQiXuGaOjl9VksNkwAhn7GMm5nHEykYE18fu+m1ruSMIhp1s+mvN7zo4d4EJaxBdFMQ6oFf0SgT9GeYrQZDAaqg68bgpwKiYJHiDAqxm6HImG7LwskVd5ZBmY+Qi3/tuXXKagJ66PMSc3QQ4gO1qqpIRntK75MYT5wqPXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866158; c=relaxed/simple;
	bh=uFbTx6ezOif8P6jX75NUPqPJO+HJ4AZaIcw87JSzhAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uor1CfkRTFS3RhF2jIYwmelYKZGA0o+HBX8emINCswRyKZmjOJA0er4ZSR6T3U5W1h1uE0/qbaUWCFnHJr+aH5g6YJJ3w7ILyTWUJ/hdQIHCg8e1lofZ1HAtTyFroZT3/FhvXC0e+NEb3ag4m8Uz7I0tTFZhGHibaf4OfW+sHPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C1XJC8Fy; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2Q8ty2IBr2+Csiuhqzft2B0E6yGFatNtERBoqrJH1R3nYNZe0RnS0grUZvwLat3NrYuZvW7+m69kjhb1xXUgeJJYVlJeTEjcydtf5bFgkFUreY8CrPNSdGlM5MDbbjyZMRJfUFb9qgJ40Zab8LIhZaUPxb8gcXHe/QC6aU0Upy8Abc8rbwdaP/KuCiWEs1h+ZSy9Ua4lS9fzyv/B6qGmBcHkjd++KOKFzmBh0aaClNl37xRM0rMadomxQKBUC12j0mNlKAfR2isHEquD67wDKCBNVo3XoWfZmcUqawEzrSPTSbq6JzTm2f10LKTHNhyUQrfiiW+r/5/q1dtjxj2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRAOURHWevyponacj5pRr1mP65mXlm/xvcb44hQBYQM=;
 b=GpN10MjEPDdWKSwm72pD2SMSJ1spFQbNtVPgmF5SwCxUtxfXdwuctkeP+qhyhg3srjHpHJoC1tPxcUpnyl6yw2zNHxJBqoc1QQKpYtJd/VNpuJSXzeePl4NsoETRRiDsePW0nowsRTHN/yyPWKCmsnZnBr/jZU467IutYbTomNp3xHc/jrzK2/X8v6sTIMNcHLTJdoGqSXFHSqqCyUah8vUnScEnEZQxjkP6q5BYjbQABsuAFiS+9aEvm99PVz+z4IlP8OLmV80h48pFZ031Rhhz/8TYJD1a83p6OItluFsMqAJIgiW+/vX67ickVHjEro41FzyQGuCGv2C3D/II/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRAOURHWevyponacj5pRr1mP65mXlm/xvcb44hQBYQM=;
 b=C1XJC8FyAHUsuscetiKcpVKixRL6XO7L5hwLCLZeVA5vBlxJB8zioWZqPQaiORhQqBRq/EA/kjc0B46dma2RWw9EHHAM+n7jMQoUTruDzN0cDFudijfTdYzgjeIpDA/7c8vra9jyNjsrzaNyT7X7RCXwSxikw8+lRNEmm9GDHVA=
Received: from BN8PR15CA0001.namprd15.prod.outlook.com (2603:10b6:408:c0::14)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 19 Mar
 2024 16:35:52 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:c0:cafe::98) by BN8PR15CA0001.outlook.office365.com
 (2603:10b6:408:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Tue, 19 Mar 2024 16:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7430.0 via Frontend Transport; Tue, 19 Mar 2024 16:35:51 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 11:35:50 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <corbet@lwn.net>
CC: <bagasdotme@gmail.com>, <linux-doc@vger.kernel.org>,
	<brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net] ionic: update documentation for XDP support
Date: Tue, 19 Mar 2024 09:35:34 -0700
Message-ID: <20240319163534.38796-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 03161231-0c10-4fe9-3321-08dc4832a419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G0n9KidNoxyxup5ELwradIl60eLXkTccJYV/+q4Jbiv+jA/ADhj/5x1URd/XRgyY+QQ4aaOvSiqIKyegNHNWm3f0M6IR/WewmtAU91w7tIRJdPhWs90pnD1wxymrYn82hsn46RlF/dRUfONSVWVaXjemsaPUWwldokFg5IhOkFjQsBofBamEL0pgD5+/iMqeEBmqX7kf9c/lH0NGF4kAIl6n06153IOR0qOE+AXNpoQxxuw6fU6rntWkyK2ccRjPJ7c+0dmpm/CDs+/yp0by+f92A5KQp1KVnJg1ZKUQP20Cv4RWi4To1xt7h3nHcIxsOmFBb6ElY+uzlQ+bEIXFdaL9IEf67fh6ipAKIC6w8SyZKrphC0a18FxmIuxJoKIht6Ll8qaV6FdgvXVsbP2f/0alEQvFm7FEq2CtnBgX3Tbtmkcr6OxKoBSetxbgffJMCO1ueJoLq9AQYOGkopJYolk7l5tcTMSGqNcVYbNlUo+URAV0zszpOVzy85focU+bxQDkOhfkipogRHJ+QPIzxG7BZITFpN3E+GufWmq0VlGf5AKFkv4CXI/yZ8N3eixqer4vYcB8KxCoQjwWsl5U9z2KrFzPAt83cnhouVjA/m/tiKEXjuUoHL/TPRnCq8B4/veuYYAgfe0277c/yl+gZhRKOk/cdbsXOm40hKfuyxKHCYuByS5N7JsANKCH/6XGIDdm1KJIl7CjUm9CQjqLPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 16:35:51.7978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03161231-0c10-4fe9-3321-08dc4832a419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809

Add information to our documentation for the XDP features
and related ethtool stats.

While we're here, we also add the missing timestamp stats.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
v2: fixed missing word "support"

v1:
https://lore.kernel.org/netdev/20240318235331.71161-1-shannon.nelson@amd.com

 .../ethernet/pensando/ionic.rst               | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/pensando/ionic.rst b/Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
index 6ec7d686efab..05fe2b11bb18 100644
--- a/Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
+++ b/Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
@@ -99,6 +99,12 @@ Minimal SR-IOV support is currently offered and can be enabled by setting
 the sysfs 'sriov_numvfs' value, if supported by your particular firmware
 configuration.
 
+XDP
+---
+
+Support for XDP includes the basics, plus Jumbo frames, Redirect and
+ndo_xmit.  There is no current support for zero-copy sockets or HW offload.
+
 Statistics
 ==========
 
@@ -138,6 +144,12 @@ Driver port specific::
      rx_csum_none: 0
      rx_csum_complete: 3
      rx_csum_error: 0
+     xdp_drop: 0
+     xdp_aborted: 0
+     xdp_pass: 0
+     xdp_tx: 0
+     xdp_redirect: 0
+     xdp_frames: 0
 
 Driver queue specific::
 
@@ -149,9 +161,12 @@ Driver queue specific::
      tx_0_frags: 0
      tx_0_tso: 0
      tx_0_tso_bytes: 0
+     tx_0_hwstamp_valid: 0
+     tx_0_hwstamp_invalid: 0
      tx_0_csum_none: 3
      tx_0_csum: 0
      tx_0_vlan_inserted: 0
+     tx_0_xdp_frames: 0
      rx_0_pkts: 2
      rx_0_bytes: 120
      rx_0_dma_map_err: 0
@@ -159,8 +174,15 @@ Driver queue specific::
      rx_0_csum_none: 0
      rx_0_csum_complete: 0
      rx_0_csum_error: 0
+     rx_0_hwstamp_valid: 0
+     rx_0_hwstamp_invalid: 0
      rx_0_dropped: 0
      rx_0_vlan_stripped: 0
+     rx_0_xdp_drop: 0
+     rx_0_xdp_aborted: 0
+     rx_0_xdp_pass: 0
+     rx_0_xdp_tx: 0
+     rx_0_xdp_redirect: 0
 
 Firmware port specific::
 
-- 
2.17.1


