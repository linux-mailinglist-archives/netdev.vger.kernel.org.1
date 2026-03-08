Return-Path: <netdev+bounces-265253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GMXBXZBrWn50AEAu9opvQ
	(envelope-from <netdev+bounces-265253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 10:29:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF7A22F2F2
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 10:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFCEF3002B5E
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676035EDBD;
	Sun,  8 Mar 2026 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HW7uqfTH"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC23128DF;
	Sun,  8 Mar 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772962160; cv=fail; b=N4HAwg0o3qSRm9PjWG8prom8HcXZu7zPTI6yioJ2+4Wv0uxZ/FUW3323hYNIvi6uCe/YYVUQcwzbN9gDj8SNXpdGZImYncUcdwvPP+UHXCdWHH+E/KKGEEywfZgMBLKmhLu9soCUlrKvBp+iTrWI28Cx1VWv8u+qV/wj0S1if4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772962160; c=relaxed/simple;
	bh=YDCr8GRohFxtRcEKk/Dg0Iyo+s87I1Ux+TIAqFSgoac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JE6zm12DBiZU+qrAZC/jkWvCzl4qf3pE2LmuQd5OQZvkjQC5utXfluE+tSex0If02RsInNeFtS3NGYFu5VdPACccFEbJa3WBRxN01u2p1I1N243aw87bG69h0sRvwF2HWAWd1HL0a8mwoQjwb0lEGHaQWb1wQ+usAN7ufg5wo0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HW7uqfTH; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfGe4jT2obIEoiWKQ7BezPmLsRWXZFQJnDYG6byzMueA7+AB04mc1aYYHpShcdfGkXVZfq7JMTpkPIQLwtcQjPfHhVnRpSRzNVV7JAApSvgnkEjit9aziEp9+vD/fKUO9LyHwd0OxWbDKenzj6o2VvR7qo43OQUffMJ3DnN80tHG0ex9P65wBZ9V9yHnXbWD/V+hXEq2sP/C+62qeE/0+M9e4Pw4XokztTHdifzW+uwPbh3k2Ql5j5hPDj5+nCRGtzDasqGmtVgzCX4/nLMA0euXaSdFQufplTlRvgLxLKFhaRp8BYj3FjfuYHStrWsEWX5OzF3HWRzodQ09mesfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmUKBMyTfXPZ16cabMehxyKDDYaOWhzaM9wDEdz28ro=;
 b=ZEDdHrGfXk86ap2adrVMbNJBlrO6Qi7C4T6q2er5wgfgfxwfXrzxfJt3ZpNlifJocR3Ia7sCyVKXTo+UTPut07j7diwT1XGDBjN6d7b1mu+/izGLG8ctdP+B7bESvOkRBhVOAwlwMYzjQHYLz0pW7yiU+527VnDe3DEaOi8qqcLpTnkOaRkAGmvNRL9nQxfuQzxvOF9Nc8yhKGreIxADubTovQ197VNhpOoJdFmO/3PpjmiGbolX9mCEZXEoHx7G3eLICExNuvpqNhIV6HiyayDevrek942xtH/re+pjx9JUc4dFqqgZA0LqJyAE0ELs2JGYdO/p5b1yBac+PiWccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmUKBMyTfXPZ16cabMehxyKDDYaOWhzaM9wDEdz28ro=;
 b=HW7uqfTHgm4yJNabPwwgn5TsZgQT4o32iS09gAk3dQl+NLHFLHDIhCH0dfcwNGlDOH6quH4fkfXZUxlig/Sxa7OtQB93C4/ED8F2No+xX1j0Jlc56I0j7v9enGSMeuTZWA6w0Um9wgFNZnQBTQyzREc8uPYzgmmkicyhwcv9ShE=
Received: from BL0PR02CA0032.namprd02.prod.outlook.com (2603:10b6:207:3c::45)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 09:29:13 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::b8) by BL0PR02CA0032.outlook.office365.com
 (2603:10b6:207:3c::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Sun,
 8 Mar 2026 09:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 09:29:12 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Mar
 2026 04:29:10 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 0/2] amd-xgbe: Improve power management for S0i3
Date: Sun, 8 Mar 2026 14:58:49 +0530
Message-ID: <20260308092851.1510214-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 17184702-0841-4ff6-0900-08de7cf528e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	WO9VsIu03tYbrtLgpen6m0CLfQuk+YN/mJd4MiqOl7EBrx+CcMz36k1zFTMZx3eiwwCQQhYgYPYagsHTq2DbCILsFwc+vBollcckuE5poVfTFyoGXG2BNpL3wHgzjfTZZZs0CKOX8ZgB6O1hInKTMfBuS18WGQbg+en51RGmYEuWx72RarbKwRbuqwdQjkXZENyLQ+HSQOSqoGBQL/X2iGwTSehHjFZAauDVshV5gTgpBCk1cuMYvfDWNgF9JVRvI9Dznru49kAsdChfmtoBsBq9cUjwnCIWERUDthngqmLuy413jMPE3XmIV1Nr5t/CrkHhXeGmxcF+dscNIkSeZl2djG75hUQM89sW3xIgN+5oB1mKfEPQApZ3kMvjSg28tm23H32MVPY9mLl5/mtGY/jy6pRSBfunUgMPw9Z/i5iLtT3kvm7RqCGLh/L+ak2GB17ep+WbOfZzAiGSqfXM9ZwVkSVl67P15QcbKQJvdCNVPo/DRK3+Ij79esHfWVDhVISMU9r6Q0Vwj0pxK2BVO6V3a04qwTyVK8cNswJeJw3E4aa8g7m2Qk3WuxY+UpV96gJnkhhXzWihmZ3I0Ku/XC6vh4u0XMmTFlygxUxT8V7twiXSym1plUR3MWx1lGzrqkOdHswYddcWCG3HSBFIiGH9lXJJ0xkhsrU5zwUC8Axpg24v9w2FEkBF1LUcKRcApRDkESh4rK/CPko7ZRba0qv19+Seju/7tG361V6MI7iIKSQ7vm8lPwMg+QpkQctu4LI/xsoXiusdmF5+dDeVrA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t42QP+V7YJwH9TYmvlFi/8/oAX/aycOFjgJelHJczHgwg3v5zLgc9VFnZcHtXa3cWKezNlskqRhuyn2sMGYuVSX1IXn9FeCPuW/oWXf7ye6SWjlJJ6bjxCoGkTh6tStZoeXINCoJzKF0L9hrHpZzR4ia32wlFpjeR7grvaltV0xWLk+tlQ1VcYD0sLkzqjxe0naIITYhtLy0D06dTUBB3alobXkf9imN00J+QlnaBXhFGS4J9wJLRBUrYSrNDCpZIBOL9TcpgO2hAE6TYAlU2bDLxWJu8tIUSCuyJQFn4iF61eIk0yFTsUFataRJBrk7jjXhy8rRJ5rYAYI2zfMGPRlZzh1KhFdS0xrS+7sfGRQuAzZ7dQrKQ7J42GhMXTL66CvxmslBXsbp0qlhSW2WIDF8L24pdI/hI7vHE+nU1skx3LcKTN8rYJGFTtGoUlg0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 09:29:12.7939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17184702-0841-4ff6-0900-08de7cf528e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503
X-Rspamd-Queue-Id: 0EF7A22F2F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265253-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Improve the amd-xgbe power management handling to allow AMD platforms to
reach the deepest suspend state (S0i3) when modern standby is used.

The first patch cleans up the xgbe_powerdown() and xgbe_powerup()
helpers by removing an unused caller distinction and aligning the
ordering of operations with xgbe_stop().

The second patch adds proper PCI power management operations, following
the standard PCI PM model, so that the device can be cleanly put into
D3 and resumed back to D0. Without this, the amd_pmc driver reports:

  "Last suspend didn't reach deepest state"

when the amd-xgbe driver is enabled.

These changes have been tested on AMD platforms using S0i3 modern
standby.

---
Changes since v1:
 - Fix compiler warnings when CONFIG_PM_SLEEP is not enabled.
 - Added a new helper function xgbe_pci_synchronize_irqs() that
   synchronizes all registered IRQs to ensure that no pending IRQs are
   left when the device is suspended.

Raju Rangoju (2):
  amd-xgbe: Simplify powerdown/powerup paths
  amd-xgbe: add PCI power management for S0i3 support

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 47 +++++------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      | 83 +++++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c |  4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  8 +-
 4 files changed, 99 insertions(+), 43 deletions(-)

-- 
2.34.1


