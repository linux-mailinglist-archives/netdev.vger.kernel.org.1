Return-Path: <netdev+bounces-244788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7798DCBEAC3
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96F0030407B3
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B493314C1;
	Mon, 15 Dec 2025 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5r3D7kpK"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196721576E
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765811875; cv=fail; b=bcHRPq1M/fIsJldewVuuc7v6EerYToXDEA2xIGrK/yI+2YiCxWUzJMy4vPOdM5gldpufcADCkW4DtQrMl9fkNReslgZcnkLHbX5aXxHbXnCM+QWKDNuHBMsqPCpwgQ7YvkC6pk5ObVQkv8WyReBDcWRMA6LhP40I+xtvi9F8BV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765811875; c=relaxed/simple;
	bh=KU8Ss8c+kDxllm1Jhg6tsztKQ/rqekUGg0G8yXXUKr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AdchOcoyMKT8IpQugoEUgjuEmLIN/EkzNbhMb+oRZoYEcENqitX4sEUfkN+ax3p0tCGWzmQXOVyglUdFHqKDX9dPfgy5YCW/0/ANKW/+szA0B6T1lpYuY9RKuzsIJd0pYaiyRYjlO+Ag6EA3xsu4xND0dxDKB8/MnQEfJKmW6Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5r3D7kpK; arc=fail smtp.client-ip=52.101.46.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmoauciAbJcF5SM527ZmjiK0LMJWcq2SE1nqh/r0me1z3/Kle1r/AeWbTF5z/T47Bp9NpTqUTBPDEySmckgHLEi+HF2+ev4N7fv9tTpieTMh0DGFOQ1JRgBi0ibBF9SlboH1EiwgWxAGS7elQenyTb7uUMkHJ8onLg/K4cVlK+Xg7scpiaJ9/Ix/uXU5unW8aBOy6L2kPrDDUwFEuKVWc1aKaS57lxZQApmt80QtrV4Vl4oAxRD5MtxfP4ixgs6nyVFmIFylXVXFs3dfEvcRME0JFHXobxYJxbCXSnQmry7Gp4zXs5kLknpo3bLRW8OEZvK1SeZXBQOWx28TKgGlig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln8eFz0f0yCHP5XVFX7C/NjY3JtwNhkjDvDKAoBfQOU=;
 b=vEHF3BlycIol3+wLDyd0/hrn946WJqrjXKqr642L39N6AKzfO30LhTs6ewf/jHALZh5tlqNjFdWZ4pHhn+8XcImg4HBPNM8ht7fwaltDC+q3QYvm2cM9DIdgtJFNXgB4RuaRU2/SThusyxyRoeQuN+pcbOYAM3IESQDWW17Yvl1u/ooMZKndXmRfzUeGSGIIMPjHl/9kzIX5kOUnES4QR7udV7buqMycc5v+Crq+nNhjHV3RJThn9a5aAtbQR5pVSbyaVSnX7ODrw4xyyCwBQXcEEZc88fkMKN1JUt1XOO9q8bE8VtSQGwD6lB8o+8XGc3wYNdJIaJ9MbhluAahOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln8eFz0f0yCHP5XVFX7C/NjY3JtwNhkjDvDKAoBfQOU=;
 b=5r3D7kpKvwgSw3j77FQI/uhlVA7P0AEmVKyacj9OGUSiO6hEesT+HqR5bfcvvRt8Q8sJIW8sDWbxQ9049ckG81ajVB5j6IQoZqzR5jNt3Xc5r0m1dMJblw2wYzT6wkrqBwb7tmdqZPjlF2v47bIxImOE1Z840l5COwlvAiGjNdM=
Received: from BN9PR03CA0505.namprd03.prod.outlook.com (2603:10b6:408:130::30)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 15:17:49 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::dd) by BN9PR03CA0505.outlook.office365.com
 (2603:10b6:408:130::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 15:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 15:17:48 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 09:17:46 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net] amd-xgbe: reset retries and mode on RX adapt failures
Date: Mon, 15 Dec 2025 20:47:28 +0530
Message-ID: <20251215151728.311713-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 061a6a73-2549-4d49-15fb-08de3bed1b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p2S9J5FtJaGizhNVO1mlR51F0YGigaAMl2T8EaHBSsGqRAVX0cAWUB1AGEKU?=
 =?us-ascii?Q?ehnFJkIZ9KfIRlp9TnJEOH8l7QNfWY2cx1Z1FyBNdzxKrcxVVn1UUWf8Trnq?=
 =?us-ascii?Q?eV3GcXo4p1++3pJkPlIeaxcxIrkhtVhqtGLNCmpDmXLxOa+UEYB5Redcr3Mb?=
 =?us-ascii?Q?qB4fKZrg/e/DDTcu7KaDXm1DAhrwHK6jowyQWNpSrqQ2qRKSmqAObpF+0TQR?=
 =?us-ascii?Q?rDAm8V/4GBeXaUH52zAHJs9Oft2fwbeuWu3QMYOdWEW5PJ4RpOUw50tb4EH0?=
 =?us-ascii?Q?mk+lm1O48lXu8pW+AAnRTGO/QfjmzOvQjJeIJWSy6XlNw7mi2Tazkv3nUuzU?=
 =?us-ascii?Q?8X0UUo6LcihpWv3nhN7U5b4NyYe7oYr4kA9vw+O5+Xeojsfla1SSeuuNmNQ8?=
 =?us-ascii?Q?cr/wDqaCRMR8lWA7zKjUeoecoFptOKbQGRBokRorI6KPK66wFLp0DPFPbC8k?=
 =?us-ascii?Q?0eP5R6qswTxWItCTRfPsdY3H39kuScVHbTK387Ic3BfcjmSDbdlHOEJSHxk0?=
 =?us-ascii?Q?KCte/PpDlp/dySjy1pyznr98FrE8cRFnLllD1Bq2n85JnDCiMG0TlACAdCc7?=
 =?us-ascii?Q?OjxUHnH2yB+9/9Y3cYo5eRwapPoOh6+DP/5QTU/j1CZzqo69LBj/ZKldq9FV?=
 =?us-ascii?Q?qezGk23Nzp3ZDC+VGmACNZw4Ts3w+JqpyYjnOpAqkFFdSvyhxd2ZqhG9eVqU?=
 =?us-ascii?Q?f0qdM6Qa9rqTnEc0AXBZY4v4Lus1fxwQ+mEIEDtABdDrRSgfytlg5UJntEo7?=
 =?us-ascii?Q?zqA4WH8IfKxYCPYD9Y3WhVV26UuuJyW6wjxe4dbZmWKhfIa8oAPy4j+c4Wsl?=
 =?us-ascii?Q?6rlQ9UtEEYI/wiuVF8ICTar0ZwqwcU94QJ4usg8EgCnNJ/DXzwc+4Drjljik?=
 =?us-ascii?Q?Vo9raGjtpTjBK4HY529sAn+r3pcTDk58PqoXxCvXIYXCrlRtpCjj1lXVA2Cg?=
 =?us-ascii?Q?dFSSPBPz/cbfucK90ALKZIhO6kbnM/ge85xpYWSqMpFsWUG1iMt5cGfUDEG/?=
 =?us-ascii?Q?m+p0VVemXwoVsv9cXZSzSyjz7fyhzQ+IhRi5AEHXLsw4R6Ug81d63X+UrZG4?=
 =?us-ascii?Q?3CgI11H5Nq5r944eurCPW4L6Eq3futIr52PFxa/MAMCTn5w9Yru9CytkabHD?=
 =?us-ascii?Q?km61RI0U9ncSYsJYaSLDfcbIvymHpiVqmH/hg8ENzNLzKnIOKuOvquZpzhf5?=
 =?us-ascii?Q?J873II+Kt6AvHqwGlFuKNTVyjDnu31GSAiKfjqc94mv4OTh5Zx7ixZIRAchd?=
 =?us-ascii?Q?7mm20W90WXMPJtvYlogQIAQgazuem8K/6Wr0u6Bzor25gCT+CftJO6xhR5LD?=
 =?us-ascii?Q?5PvzJqSnA04WNMWqgDSb2pCW4eiH3Jq4qmb1+P2NCveMbxTs1/iuXHVMRWmP?=
 =?us-ascii?Q?rEmbbp/DZ4BNTFUaS0MHSVV4WZ422jBTpQJxiSKOQBVfMYAZa6bHEXlY1NjU?=
 =?us-ascii?Q?zkH4AV8t4Qevvp9qWqhTSt4duxvL1VOUhvxCbmOcNP3qUDOjHoOD7NCIwD77?=
 =?us-ascii?Q?eYZE0ovkisvNKxVaUR8aBdPi/H/Sr7/PDcUUHj6dnHtt4vd5Rdi1Fo0qdtUI?=
 =?us-ascii?Q?jZMbUjYG7+8ttj3GeEU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 15:17:48.7308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061a6a73-2549-4d49-15fb-08de3bed1b7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453

During the stress tests, early RX adaptation handshakes can fail, such
as missing the RX_ADAPT ACK or not receiving a coefficient update before
block lock is established. Continuing to retry RX adaptation in this
state is often ineffective if the current mode selection is not viable.

Resetting the RX adaptation retry counter when an RX_ADAPT request fails
to receive ACK or a coefficient update prior to block lock, and clearing
mode_set so the next bring-up performs a fresh mode selection rather
than looping on a likely invalid configuration.

Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index a68757e8fd22..c63ddb12237e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -1928,6 +1928,7 @@ static void xgbe_set_rx_adap_mode(struct xgbe_prv_data *pdata,
 {
 	if (pdata->rx_adapt_retries++ >= MAX_RX_ADAPT_RETRIES) {
 		pdata->rx_adapt_retries = 0;
+		pdata->mode_set = false;
 		return;
 	}
 
@@ -1974,6 +1975,7 @@ static void xgbe_rx_adaptation(struct xgbe_prv_data *pdata)
 		 */
 		netif_dbg(pdata, link, pdata->netdev, "Block_lock done");
 		pdata->rx_adapt_done = true;
+		pdata->rx_adapt_retries = 0;
 		pdata->mode_set = false;
 		return;
 	}
-- 
2.34.1


