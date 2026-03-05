Return-Path: <netdev+bounces-264174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMmZHusGqWlW0QAAu9opvQ
	(envelope-from <netdev+bounces-264174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:30:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BFD20ACEA
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4854A303B957
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 04:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AD14204E;
	Thu,  5 Mar 2026 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ck3U6Wnu"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576A3286A4;
	Thu,  5 Mar 2026 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685030; cv=fail; b=on/w62h/npeupTTCbZrPJZTRYxT0haFbzUa3Zuu3tQnza3naSEvnhgBZJcWdVlJCSb5rqSomgGILtvAxh/Xjc4KCEocq8H24W37ee+J9TIg3yvza29SkRR6z5bWx1a97yK4s/rt3YESjrhjPftZSuw6kLqDn99TJLZSNSZh/Pa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685030; c=relaxed/simple;
	bh=lT+X3UVW2RqpTH77hECsplmkCQYa13nyTRO0QmTzKJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxeiGhzgFH6b18/RUFgIqp4D3d+rwhENeKreUELI6YSovqmqhP7wnoQoOrifnGrDEi+p/vyciS5Ei7e1wR5ZAgiZO0E1839P8uFjapjgyNlP2BebpzISUsW8rl1oHxzQ9SN8A6trhdwXL0ZDM1J0Ld3u4m0nWfqbj3lIML0GkUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ck3U6Wnu; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2DH44upLDM8Qg2aTpO7ji7PbnDa9NH5xiHuyAMDW6YaSRBHYV8cGN/f8LLP6lucNMCOaT75nzyB4c/kxOMHJe3ZfspfH5oyxsBrhz3UqY8W+4sgFlUNT0no/z8k1YsTu3OqAn8M5RNjJsFn7S5TLuGPWLO9zrotoD6uew6wdT4JQ/oyGVREMwnvB3Fz6xSV1NyROmM2ZjYH6mQalHimew5rMumpFWp3+qVhVq/7ykQeD+9Rg78yJ6sU7Pj9anKj4f4N3zxoHnXLqvbqm7dS1ZNUVJAindZ/tUFsjQCWL8J75zE/us9S9wRCVTH5KiWLbuY+/cyZJYvj0ngvVsuy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WhJ/DlysRMRlAqQ8KTfrnZOh4bC/H/L9iys24i4DgQ=;
 b=IxvAQ1BVlr9r1A/uTOiXirW7O90OqIm5vOG8wzwIDN0wREfqO+OFkECMYsHCWJRWWW0m98UzcPx45u1iXzguqSvZdIeGjUHF4KqutI/pTgNtGBVxp3GPCW3ThAhs37I4/ROn1RjYsfUzqT5w7nqgHg6oIaEFsaUyjo5kPs3wDHlTkHDscWZdjfQRqJmZoiSJ5DNg5BfdWkYem2JoF4te03LrBPzVW6vSdGWLO1qktueJAk1CWAp3XwfQvL2n0rnpL7C03g9RdjsZ2h5eQB8eTdtvx0s7K1sOFHPAtvtOn05lkA++2IRSXrlZjKjU3+IBJhI4AO7tHdUNYEUwiY6RxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WhJ/DlysRMRlAqQ8KTfrnZOh4bC/H/L9iys24i4DgQ=;
 b=Ck3U6Wnu+/Gihp6Ysyzo1uKbBJJ4uMzFkZ9wcvbFw31oIdq2HG8w+Ay0FCNrIT6qpY24jSaCqGVQhEi5LJlS2dE08K6vSNSozFYcyg0HAmUWyAnKqbo5A1CmqQDI3ttXipLPOvKYqAJCYbr1CAawBe7bNWs2SyUhY7q4g/osdSc=
Received: from MN0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::12)
 by LV5PR12MB9826.namprd12.prod.outlook.com (2603:10b6:408:2fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 04:30:26 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::a7) by MN0P220CA0022.outlook.office365.com
 (2603:10b6:208:52e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 04:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 04:30:26 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 22:30:23 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v2 net 1/3] amd-xgbe: fix link status handling in xgbe_rx_adaptation
Date: Thu, 5 Mar 2026 09:59:50 +0530
Message-ID: <20260305042952.835926-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305042952.835926-1-Raju.Rangoju@amd.com>
References: <20260305042952.835926-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|LV5PR12MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 9941626b-52e9-44b9-c4ef-08de7a6fecff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info:
	4RisALPQI+39VVro/3j2Dy07Zxd+Af5psSjAehsm5e4faS67rzeRn3Vvn6dBfp+3tR0wJuORuHsXUHcHRV+bupMK32Kf/jVt1+8Ew5wryaoRI4gFHMDb2DXqXV+hJhXEfoBaM3+7qRyE2U0OUqIWUnGnhTGGFbpCwUgGXNNcxZgc8RUvqT3b9jZ5Atm9CoTXdt4ZSgbARZeZl8hUdOeSF0pIbtZPc1aQZHhDSv4r2xWkyczMyno+oKMgqw7zi111rrcIG+3wYMRBe0zrK9NeKu7lxvu7mM1nR9AGu9AerwC/FyDI30byoFijSSG3yLhRc0RVfSN0nnga8zY1jf8pRo9f071DvYHTyZlnDC1OMIhnt8wPn8B+GnU3CzGIs/hGGMqpyVEyblpWXhkn3hPtYu9kov6KNpWov2NdVRXY8CWI7TwGkV+6xoj1aF/eDEAewWgfPQSKLBvpGWC2hG01ldGpwOATe7p+ETxRLmjVhBzoyPkPHQxFHtv2REh49eP03lkrEz3yqWgyKpORzR2P1X5islwqpilLmpmLBK3Fx4z0Ha+qgKnkk+tHCmG4XD4SGndeq3l6YcxywMmDkwK7R8Xt/inSMbE8XIkJnZvY8C2iiQrDYHtkftkmBjkA6Lisx6TFCNCHHzUl95kDurlGOAlUskrNfNJ2i+1iirmW0RRhlbKQ2gVJlq8Ay5ghKblyYn+j2Z3NjoV9wDPLhGN/B9TT/jEbFuHC1J2g0L/lG+YZcUYKgoXMK2PfBe6Tkz+7LLmnrxdYlpfE0ElzVyUQlA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	99hJ/hIxKo3QR06K4Motk19mhSQVttWV3N+cWtt3F2OAgTz1FYsCeBFn+mjiCMZ8KNiZXhm6ILHiwdMfwn2cz8oyzeTxMsmNz/Ig41blOG/DC6gKGXtMkB0oDmc3FFQblM20Kp2WP0tso18m7oDpb1oyl7Csau71QliWnCDaCHrf8zAvJ65kCYxrWGg/Jhn8CqKADJskf94IZP9imLi/nG/cW5Xbij6DQk033/bKrLU8iLqjN1o7ykWkqcG8WOlbzeqbbgGzhBNbyuIz5ipzieBDx7RTww0NXghrEoK3694+aOkPAX/qDtcL3oEGPPyg4D3CnyDg+3gKSZJ1ZPfvtoePaBvZmhBsoNqkVGEzq+Kz+LHFbR4Lwtp7d7dfts8ePvpxGyb1H6373HApDqdCjgkDiv1yK9QifoChJpjPMZX2EFZjdocese5nKdpyZ4JL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 04:30:26.8463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9941626b-52e9-44b9-c4ef-08de7a6fecff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9826
X-Rspamd-Queue-Id: F0BFD20ACEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264174-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Action: no action

The link status bit is latched low to allow detection of momentary
link drops. If the status indicates that the link is already down,
read it again to obtain the current state.

Fixes: 16ceda2ef683 ("amd-xgbe: do not double read link status")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 1dbfa9d4360d..457d6049291f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
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


