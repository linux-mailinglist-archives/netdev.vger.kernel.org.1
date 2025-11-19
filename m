Return-Path: <netdev+bounces-239902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA2C6DBFE
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45F633876E5
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE69026E703;
	Wed, 19 Nov 2025 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4hrZdawV"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368AA38DF9
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544711; cv=fail; b=Lk2A6cTqRCEnvrrYEQ9mhiTAgp47dW/OYaSP0MlH2uFCbd74AR3od4tYSknYR3XMxY2H/mwgjYk0nlMIkOQQov3MjWRmy+7Vr0wzSTERIlyYwTJUbCNlLL49mXAch+u4d9IHU2429Qi3byNxnoMNrfY6vurVMlqs0jIwrnI1RDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544711; c=relaxed/simple;
	bh=16C8/tRDFuWa+547PyY3wELJWJ+GLPk6cmg8IUs7kI0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jk5xIBNc0d6dUuWIOdQF2ri7wcpSYKKMTu7nxQa8p+Q8CBI1movCfouwHJVIgnfVt9f6aKbDhBC7bkeejk8WLAyXkGfjj89eKMP+wCmtT+v7LJGCiPaImkgCkBcllxio8Dhv/izFfKwtxO5CGazW8dYUdnDplRadk40loJ9KiF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4hrZdawV; arc=fail smtp.client-ip=40.93.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlziIx4JXKKGghSlPZb1c9IpWfo2w0MZEBgInfOZ7GM/EHTRCXVMrX4hmpNu+0kXy+Ud89GdvA5MwAvIPSqbaxiN+9hthOp8WkvKQHPnLkHHdBAlZRvI+6WUlLarrMBNki/msw+OKrVQNEN1VFrdG3Om4s1cnlpnjiBjAXO5BZhfFeERj7ObyqzSG2OlbtmwGu+AwEuUzHxKVwV3VhGPrgU6xaB6LJseGDj/9fGkzZvL5MZUqpf3eN1EEIOTWyfs8rjn1HLPAtj+7peL9d3y2YVyGjsm4c7ix+dLwcx4ow+Yz72ze3WD6orakGTYJSoSdnvvZiwJpUQ8CHIreK1QXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vkbQLp8qQ7phI5wloyjRYddARdNqgJesIxxwMWo0EM=;
 b=nr0V9PhXmCnjjyJmzvVW19OGuhWGsdR/3xOfyNL69Aue5xU3QA3RCJFIEzgpigDut3EyI8OhzbKmbFAZbJjM8FfNIsVaXtkiKM3aZMKISC3wQ1c4/ghWnzYLO03jVpwdiWhFJ5MZXZlSP0zGbUKvekxYAWj6rWsphsiBYwItd0AqS8B9Ui8hU4IwafqxWeL+zMi5bJNnZPTIlfboiy5V3my4kw3fvxZC/yn0zREjJ07afkxDI+OV+y3spvM39bx07vk2g5g2lu9QbbD2oX4IKnBRaCXd2ylAjugYbzw1pAHA1+eC0V0hFIIDdwPd8MsrXzTwPFNVnEwzUzIGO89h6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vkbQLp8qQ7phI5wloyjRYddARdNqgJesIxxwMWo0EM=;
 b=4hrZdawVOF7ubDfOHsm4cZn0jZqwUwC9O8Kujl8otp+OQCr2//VQxs7wGte0Y6xo+wZRwd5mRxVPyQqcH/oHLB3zOdIt1nNGsAYRDMX2qWuK8pmpZopxiJ68KLN33GdrviitE6zGNwmvmsOFOgXLCSH3NXhhJKsf3/m29bH9qqc=
Received: from SA0PR11CA0112.namprd11.prod.outlook.com (2603:10b6:806:d1::27)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 09:31:46 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:d1:cafe::f6) by SA0PR11CA0112.outlook.office365.com
 (2603:10b6:806:d1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 09:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 09:31:46 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 01:31:44 -0800
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next] amd-xgbe: let the MAC manage PHY PM
Date: Wed, 19 Nov 2025 15:01:24 +0530
Message-ID: <20251119093124.548566-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b06df53-51bf-49f4-8f5a-08de274e7590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6hRav21u/l6qxFwriVL3YT37pCuhUhzZnFl0/urqf0ErTLcoAq52Kt4iI8Fc?=
 =?us-ascii?Q?poa8AhRcQ5eo+EHbq3jEuIp3XHeHY1+Stq5dUacrxZ9fTRuTDna/OVMdbHy/?=
 =?us-ascii?Q?Mugp3TUKQTD7lnLgpsKmt8J/FzOtF+4U0rWTKx0OFinExS0iEDKBGXM4Fa23?=
 =?us-ascii?Q?Z34Zrt1QaF08JcLzfb9dhl9G+Gsgy8hbc5dXXcP35RAmAV17Z7iW7ZIDDznA?=
 =?us-ascii?Q?uCS1bbMk4mkSEu7+Ea3Q64RwkkRrxgVSgLHP3xbJLghPSSs2KsNir05y2LVW?=
 =?us-ascii?Q?qtdYKd7PO94jIa5p18vc0vJoAEZK7toB+nSt1LFM+KLxNe64VTmj/G8Ecy1L?=
 =?us-ascii?Q?3gT2twZf8MW2w/Z2ZC9bW1Zj1K1+bLFP5gPpRn7PtQnzu6EgW/B7nAnGg3j3?=
 =?us-ascii?Q?3H1IWqo/+xRZoMyiuTPupXxqEzRV+j50bMCCvud+kNqgo9DQQLZpBLKivJfb?=
 =?us-ascii?Q?UQM5f3D+LWc55zJKyC7dxBdZyaLsn5WiO5qNbh8Z440NHbRzI/1OAhiVtqnF?=
 =?us-ascii?Q?rA2yFSNVvxZiLaH2kLxvFY9gWyo1YkmWlDo8coQraxOrChBYVjprbkAr3k9b?=
 =?us-ascii?Q?rucy0X2bBR/bN04TkBIk3qOvLn4pXHzIMKhqppMDTfx0/6sYkVsnMUmzA8p7?=
 =?us-ascii?Q?nqU66MIszLEKBKLEstv9h7Aem6ON6kW+YVw3HfCuiHn9XCkLWkWn/Y6U4WR7?=
 =?us-ascii?Q?2NGkisYCRCeFD4S5XmuDBkM9W3Q2k5qWMLZ9E3GUJl/w3KwUD88PCG2gpV02?=
 =?us-ascii?Q?uG+aAysgMWJ0qnYkCueUEfXxwNpFfMH0ezauqLJ8kN4oJozVA2lH266rZb3X?=
 =?us-ascii?Q?9fNF+h59AAlpeU29yN2RwwQP1ZXsvre1w8HjJy8GF6v3OKhxc2yakoblBiw+?=
 =?us-ascii?Q?bkOK6UFSCg7AIsMJVDbO8SMKhCNDIXkbiI8lTQb9NHQBREH4UmT87mxwjKMT?=
 =?us-ascii?Q?fVTgSXK2KicbN4P9oi5AtfO3iv3x+EWbSPw9zPagxzzjg+a+ugm3+qFGyzL1?=
 =?us-ascii?Q?IsnZx76z2bbqiHI9vAkFYkLl9VyJTfzdD/pMej/OrQRhlNFtTjeU96sa5d87?=
 =?us-ascii?Q?eWDfe9qIRTDa0RrZvUo8fZhxISW23CL9ViUasazewT/THm9OBV7OUavhxK8r?=
 =?us-ascii?Q?2k9hWyT2f6Crl1ByIpQIJIqhEKz5uZGKOf1JIs45//0V+Z2WnbShQdQP013l?=
 =?us-ascii?Q?u8/t8KUU2/SPb9JWjp8C6vgJx5WmsLPLJickVUGmyoNOgI0kSgPzOoy4GV8l?=
 =?us-ascii?Q?g4rm31Nji6pYcXRmHZ8gawOzowlSVf8GQrOSsLlLGuCiwe3g9dW7jwWJQGWz?=
 =?us-ascii?Q?eo7s4XUdSXUS0TO7BzXfwtYouHwhdep7F2uSnQ61li70ZIYFOC5mqAA4SjiK?=
 =?us-ascii?Q?ekkvGCRq7aYwVZNKzAs12HC+sfCnmneJb/f5TV90fPVyLF05uwaFOq403gCF?=
 =?us-ascii?Q?Kyb2rNEfndxa4nCLSYLeMf+gPUA+69HhsUDAosPAb8ms3IJjkfVB4k3zY01n?=
 =?us-ascii?Q?oc445qFkQmjCjFklAE7c+t1IapnuUGyUtyJhqGqZwPfVKJa/vwlQaTunfhkw?=
 =?us-ascii?Q?fF0/Iyqjnpjvpx487wk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:31:46.6142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b06df53-51bf-49f4-8f5a-08de274e7590
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120

Use the MAC managed PM flag to indicate that MAC driver takes care of
suspending/resuming the PHY, and reset it when the device is brought up.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 3 +++
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index f3adf29b222b..1c03fb138ce6 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1266,6 +1266,9 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 
 	clear_bit(XGBE_STOPPED, &pdata->dev_state);
 
+	/* Reset the phy settings */
+	xgbe_phy_reset(pdata);
+
 	return 0;
 
 err_irqs:
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 35a381a83647..a68757e8fd22 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -989,6 +989,7 @@ static int xgbe_phy_find_phy_device(struct xgbe_prv_data *pdata)
 		return ret;
 	}
 	phy_data->phydev = phydev;
+	phy_data->phydev->mac_managed_pm = true;
 
 	xgbe_phy_external_phy_quirks(pdata);
 
-- 
2.34.1


