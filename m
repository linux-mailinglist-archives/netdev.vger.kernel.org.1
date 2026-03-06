Return-Path: <netdev+bounces-264748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MinHOO3qmkiVwEAu9opvQ
	(envelope-from <netdev+bounces-264748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:17:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6971921F8B6
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 12:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6F1A3007A4D
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 11:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0475338656B;
	Fri,  6 Mar 2026 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VTSSw+m8"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179FC35F160;
	Fri,  6 Mar 2026 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795866; cv=fail; b=T0z1TGImnvmHF0lyTBqjTbcQSudp5LkS3ei354VDBzxceHSb2yJrLMkDImm3YrVbtw9vNsztpZ4hN6DWxtazGPxgbk5sV2wOoANI0Vwmh90Ac+VcJGjwdEFpHvKi09/9IimXJ5XLQvCAe0ZR+Xpcggj4qZkyZxAD3AiNr4qx2Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795866; c=relaxed/simple;
	bh=aLj5XjPBs+M2YFY5vPvDPfMCHZ9yf40yWbs1GPczT0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zwf9X2/9p/boa0KfqBxioyTylM0/a07VN4O4GJwwoWFXbY/8lTub+J6QR4Offoetb2+oXmhnGnRs8tqYiC7MOZhGhyiACEV2ysXDqxns7PPOmuq1ZiA0upntuTEgh6AQql5hfvTpXggWdaJaTfQ5xIlvX8HgjYR7K4jRNqKD/8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VTSSw+m8; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKOFOJJmmzgH9QRSJzpE0engA35JFvgvEUmNkzC2OzaicepRtqqud1UCE4ubFlhWvaeAx07oMAMl3OwOGS8mY/mJ2U3mqSb5rebm8JLwzzKVKKoD5sShQqH/at1P6HMO1Yxr0BNEZEzAymMio+U07kAwc4L/QRcgWWUy0gGxJ/alD7wGZthc1asIuEfL1QfCau5qbVLINT8gugcdoCCwBGOqgV/BGeg9l9WALFoLL5g9a9XCA9oLSbIeUcfGCtCvzYGvUJau+KgFkltY+UfzW/Imj0nL/Eel2zG/OGcJPBoU401DDG6Nyfn9RUEBG4w5eyYlVeYO/J6X4nEqw/C6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah/O1kmksLzUBl6KX7QZqLzXCE53aatZZPBm+XslFE8=;
 b=kPg/6kuBauPR0UgGkmQ1t2IrypdG2GAGU+vD9w/2ptWgrNLdzgay+vsjU8BMUteHXD/ryqacWnVfmLUo27U9qyYyEsyqJu6KsUF6ElW7W8WH3E6+zcmMGgBKYzRIC35oOVM2CjhW18I3W6RouwoGmSGasYBhg8GxjGFmxKLO8zLvnwQcUgq4MTPAE1X8zTBhn/DQ5LJ9RhiBkNzd/xlmn5tyneSSmOOX2RtQHzcpD+c82Yqs7n4ure7EA7284j6hc9WAV3DoW0WQ9GKTgeLrO93dXj+c7m/Tt0oTOEyHBjVyLiFTIDxxIj3RUBWsFONu60uyadxG51r1S61zmCCqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah/O1kmksLzUBl6KX7QZqLzXCE53aatZZPBm+XslFE8=;
 b=VTSSw+m8/MgZ5WRfDizAVl0T6hSL0BNIw3x7uefYO8QHVx0eDppuDvsgcw0zFbdZyMVrSGGyknBoHmfKFZu1iwwP6CxYGAzweOJqnHiiz8wlW01iVE/Y91sA1AdBO6N9NciI81ulaW8TlkiZVqLdnD5rR72jlQMZVK4MGJJKD8A=
Received: from DM6PR10CA0017.namprd10.prod.outlook.com (2603:10b6:5:60::30) by
 IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 11:17:39 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::a0) by DM6PR10CA0017.outlook.office365.com
 (2603:10b6:5:60::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 11:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 11:17:39 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 05:17:36 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v3 net 1/3] amd-xgbe: fix link status handling in xgbe_rx_adaptation
Date: Fri, 6 Mar 2026 16:46:27 +0530
Message-ID: <20260306111629.1515676-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306111629.1515676-1-Raju.Rangoju@amd.com>
References: <20260306111629.1515676-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ef439b-12e9-4f2e-e745-08de7b71fa55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	jPgl+RnxE7ZtVY+1ogUjfKmQJx78WyUjQyqG55ptmESqPKcYt62Kogj0UB6Fuq3USzqfC+iNPyXqVCkt5QCdDpJ/TkBPoyDCFCgs6/bT5QwrHMKH7HFBXSjugOFbOmsVPj8rr7xlUloCJ8XwYiiaaAOJOSl51MYVCNznXgKhmA1hWyMcJRrPgLIxnZEQe+VLm2+gOWulWVvtWwolg2mUw/SHY6EtPNCSCTWQVVYAhFt37Nes8SBISu/45WZ8OPpTY2Uks2dPx2AmA6u+OKWipKnwCaFKxQOXDEc3FkpAzAm3DunjNcw5u/ntrGquRhC3L5oajGN3xTx1NWOhfcTlYlE3lys+BKFipw9lWwHnaehVaah2Ftc9ylg9I7YNExMmyNnS02W+8m6e8D0FOgkRKoHr0juGWIYBeFj373S7UbQ4RsSfeI6cC3I0E0Lz6FuC9PfpgENaL37AtMfidBTJT0dYKnPQjRCg1zMwWkig0mno8Me4+DeIGB4v0jQI2Rbmy+YXt8rV7XiiXnvuyfq0V61zk0sNSyiGXMpx6T0ecJrkbsFl8zccB+Wb/1v0JQur9r5EU8dHxkTsbxsTjRo+y6bQZa+QpRKQeTXog/S92ddMI2UPU9Hin8eQ+MyAKy3hvmN7cOXCowYHBf2FYmZEsC3q6sBLHIEoLIKajHE25MeIDCYPHP5BKLg88hgBAYuz+7y2/zXQXw/dtnyXIplebCrDdUVpLlFTGbzYwGqPLLdqny/pDjL/tNr6Tx85gY01CWTs7CfprBV6EddIe8NfTw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h2vASUHgVuO4kn2Gl+hPL4HDZGJ+ir+XA7rPUYu1zWf+kqRdLKQ72FKhWx6xME5ZN/SRx+fh0ANop9qYFfQSrQ5p4Dd2QRHcgRA9tacw0iYEmNIrt2breDZiceyZEC29YQzM2nkCGhtr98LSVdIyEYai2ytqPVcWtN5ERDrHeJUUwxAVTz3W0gG94hBltsRcZ20b4BqvX90Mb9ubek2SZQoXwWFhc8kql8J3hX9nvTGH6a67KymWZ0zflz26LeK3sdx3DbVoTJdlBRpYW2SOC1HT3+VJpqk6KHYhcveLxvGUCBx04sFtGhvx7B8tLNHi29xf2YiSAyZAVNsW4kEC2eDxa/H/f3QUqRuqaO4Y49v5DqXHoC7BM/7yrWSQvR2pXPIzSNJWadrFj36Fc74j2k04xBr4aAjA1w6ZT/FHhyjDvKby74u4QV/a+oU70plK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 11:17:39.3913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ef439b-12e9-4f2e-e745-08de7b71fa55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
X-Rspamd-Queue-Id: 6971921F8B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264748-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The link status bit is latched low to allow detection of momentary
link drops. If the status indicates that the link is already down,
read it again to obtain the current state.

Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 1dbfa9d4360d..b330e888c944 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -1942,7 +1942,7 @@ static void xgbe_set_rx_adap_mode(struct xgbe_prv_data *pdata,
 static void xgbe_rx_adaptation(struct xgbe_prv_data *pdata)
 {
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
-	unsigned int reg;
+	int reg;
 
 	/* step 2: force PCS to send RX_ADAPT Req to PHY */
 	XMDIO_WRITE_BITS(pdata, MDIO_MMD_PMAPMD, MDIO_PMA_RX_EQ_CTRL4,
@@ -1964,11 +1964,20 @@ static void xgbe_rx_adaptation(struct xgbe_prv_data *pdata)
 
 	/* Step 4: Check for Block lock */
 
-	/* Link status is latched low, so read once to clear
-	 * and then read again to get current state
-	 */
-	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
 	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
+	if (reg < 0)
+		goto set_mode;
+
+	/* Link status is latched low so that momentary link drops
+	 * can be detected. If link was already down read again
+	 * to get the latest state.
+	 */
+	if (!pdata->phy.link && !(reg & MDIO_STAT1_LSTATUS)) {
+		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
+		if (reg < 0)
+			goto set_mode;
+	}
+
 	if (reg & MDIO_STAT1_LSTATUS) {
 		/* If the block lock is found, update the helpers
 		 * and declare the link up
-- 
2.34.1


