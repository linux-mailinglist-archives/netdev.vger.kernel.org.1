Return-Path: <netdev+bounces-175710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E4BA67345
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5393B11FD
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E33120B7F9;
	Tue, 18 Mar 2025 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SSaqyyzW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA520B21F
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299067; cv=fail; b=EaNPsELOUR3fkLf9BZ2H+AQbF/Aty5D3IaECoz7P3mkum7dBMvxr1PpPWqsJ8PcEt/n/X61CZFAHWdycsfrt0xnAlmKZkuzc1io3HjiACibgIn1nhu86B2pEtJY4BybDrDX46/TRpakY/NBO7kXWuq4KnxV1Iuc0BfD5/3ogID4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299067; c=relaxed/simple;
	bh=kItts/52Rpdt04yzwYO1LP5FV1eGeHy8zAoQdtRNOZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYVuTa2kFJ+skor3s3FLyq2P2Q5+EKHfPe0Wqofblcb14NOblaxUi90DhsBfLoyfgNpWLTuFJix2I4/WlwLY1Tti1ce3MAlPg/fLjQjkMvwQK58HZYP0OUJOG88qKQnd9oWhsOkmEg6lTBH5vFqhnoHnFUHY6Y2zgOTLwo/YAYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SSaqyyzW; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZlkcw5F9OUmx3srd4XR4qxSohzo7ejVN22tL5mfMbDpqcR7MhngqRIj063MCs6uAR93VofTmg9efSHc6Bcoq4FGxPrVzqCIBgwsm/wFMR2/t28l3eevaB00bYje/hNj02EexaY2HaRa1neV3ZJJ6wERFIaek1qaD6M6Q/rpFOKkoCvtjdZ2aQ5rgbWtCgbb5ljCgC5o2Txl1hdHYRSI4uN1HLXgGRv2tsUxSzhG5bbTpHe967ngIY+6oK4VnBvCOMM6d74lQFV74G1DrxBgmoPR0QON2LTRxPyBqF73S7wFkWJDv0EhCKir7CmkVXa4SHmH084TKtsmRLR7WvArZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NG0C8UoC+j1U8zlSa5RoZdopl2PYwtKg5+ht/Y2QJrE=;
 b=XWe+OCJ3e5OUWq/Oib5n+GUcTkNT34Fqp8xhm3KBz8AuUJcL4CjWLzP36Ndi5FKuigOL7D+M1vbkylUbB2TZafnVu3dx7HwcP5A5+sZylWmFmdnAI00UT0I8D1y4y1qlVu6+1T+StwJ6rCCZGYymfubpsjZ8bHQzDwFKJ3Yk15oARHuPcL2oNcZX2ZY31cBYkdzvujGp8c2MdzKHTW7ceuYkHG7POywGXGKkfyuEiFS3WwnXCPbajSUIGI8uClzT7jyWH8jsqtg2hWxaWoOwjK5ChMWn+R3F+eDWi1oWalzAjOU+w4umZPzCaLPKyQLBXz87UkXnT8Pcb9jT0kexiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG0C8UoC+j1U8zlSa5RoZdopl2PYwtKg5+ht/Y2QJrE=;
 b=SSaqyyzWRRlK9OnbVnmEXSYpk4E2QaCEaL1vCiF9kKE5StjKhlWtj/ZkgJC1FGjd0t/wE8bqrSyC2asUq2eLC32MMFUlPDhmUbspoPZP6s+TNBa0aw5LT45qEYmmhLMQdrxbGuoC4UHAptlWgpU4HYI0Y8EF9La7x0TB9NaM3Fu43SBW4bryAGk7mg1H6R5PmQ5DeaDp8Snvo5HXPFKYw1V1k8lqgvjk7yykHYDjXbvpFNw+4Bg7dI9r+hrzelzzFO327i5skbAN3rtwUO0FeBN1ltpErFeB+LhupR2MgZoiWfK5W6DVMDfbltEVZGVVGuDPF68h9ROpRgH/oFIwnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9713.eurprd04.prod.outlook.com (2603:10a6:20b:4f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:57:29 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 11:57:29 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net 1/3] net: dsa: sja1105: fix displaced ethtool statistics counters
Date: Tue, 18 Mar 2025 13:57:14 +0200
Message-Id: <20250318115716.2124395-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318115716.2124395-1-vladimir.oltean@nxp.com>
References: <20250318115716.2124395-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0042.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed25909-1702-442d-972e-08dd66140eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/TUnEYI++Md5YzjHk0JAMfSLAGKvFCer1iGJYgFWrwac1vTaXQayWfAWCJfV?=
 =?us-ascii?Q?peYPgVmzqdYyvgzbtxClVMinaHA34UhFo83eFxG4iSSFSoxIPD7SbCRuLioP?=
 =?us-ascii?Q?yY0l6GbD7ZgVBI7yjrMHl+mM3Llra/M7oHwWcxzHJeRwhxbIvM/RFxZcFiit?=
 =?us-ascii?Q?MaIAznyHRdfGpde9UZdYpvp4c1pQO+s4E1y93b9d9JJ+zgY3S7PopDCo8dKq?=
 =?us-ascii?Q?mdyQkoJ8IA7b4lF4NyAhKDBGbXHfBdG80w0H3Q9cALQpQjMKeL1gyphlya6Y?=
 =?us-ascii?Q?bCcOvLAQWm1Tkk4nbVUbLEpUru1krjzpCW5Z1btPIsi/L0cTE9gtNxPWhCLP?=
 =?us-ascii?Q?gxTV+vAqO5rlVbeMoOAuUqFhzGF0BC1kvTfJNmsN6tKNYVcA8Qs6E7pPQMUN?=
 =?us-ascii?Q?Wgco/8eIkPTM6m/9yyeWFiDIZI2VlqwxNhmh1Hi131pwMZtHWXE9IcS+yzLz?=
 =?us-ascii?Q?Kgy2Nn+qlJf1fb7x+tr4FPXnDCZwsvRVR9Gp4ddjFuXugT6F3+VuDQKkkyLR?=
 =?us-ascii?Q?4GsawK5rb70GmThoEnnEgqXE7zGDXV5+/qe55Y4t7AtH+c38f4MoUPoASstH?=
 =?us-ascii?Q?Jw3ThnN45DHuTkqIZS2oDrxmvFbm0YEYv6PKTcVGpQviJ/KVwVN44NN1om+r?=
 =?us-ascii?Q?y2nEEzjJGnNec/XSddk+zroi5icLhqc0peMH97SYatGBJMzJ8I1kdOGC2RQQ?=
 =?us-ascii?Q?/SdxJSHlMrDWeFOG2kAKFDKqgf17xerc8KbBOz7b/qEHuYUzCBTyW+Qo6oqU?=
 =?us-ascii?Q?3dDu6dGZSw8axAmmmgR+WPePDpz9j1+R7JLTPIfAcx/Uh6BygfVcoX8PuE4e?=
 =?us-ascii?Q?SyyJkaxXFlTJVk/JzOQ2gSmlz43cI55u7rvcmncGn3zABLlBXYAKxNnuou7M?=
 =?us-ascii?Q?S1x6nfJoXfU2lKqmyOVZ0VxH+EVTnLMRiP1QaQdx0oATtWlU0smVa7zaq4Ot?=
 =?us-ascii?Q?5nuUquiwgRCdCd9mqDE8+Wb5+YafjAl653UpFRL18HLVOUe0Kc29Z6ZwE36E?=
 =?us-ascii?Q?KQnvohIKIuPPXSl2zjcGmIchGTIQSYkFrnechm4mAHR/K1nds55jw+ACU4wJ?=
 =?us-ascii?Q?Jholax6DUvvT4NwgkFjpF6Y7CYDf721cESe07zpqt3Z5EOLuWS799oiuEIs3?=
 =?us-ascii?Q?ahOzrQNrPyTR9Z7XpSoey7+Dmklhx/V4YghqeZ5N+n9yq5wq2fMG0isYot3O?=
 =?us-ascii?Q?2VrzSbJ7FhyuCifb3qVkaYJwHaRO9RguHDBXZb5JdrPoohos2LJaXOOWasfo?=
 =?us-ascii?Q?rO7bIo1B/m+uCRl+7pXw1Ru9rIahdTUCH7qhkp/TtIgmZCpYI1JPa8iHCTHf?=
 =?us-ascii?Q?UflRUJ3CuIRuHREYING6NRJPBTo0FuiKRh/T514a1FRlvsUHh4Kx0ROJjrbd?=
 =?us-ascii?Q?e8axG+D7KjoIfBx7p7+E2vKcUaAetcD6DPv77WlS6qzwzUEl/uA1fWyP1ZW0?=
 =?us-ascii?Q?5iuVmU0PMM+Mh7uzOS9Avb6QBiWhqGag?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kq5ZhjZ2hTY/nx7G68nVf6wDZJGvkUmDtWDofBgT2uon89j1gDFO9RRzneMR?=
 =?us-ascii?Q?MVPmR4Cf08ukloo61SBw20bdpAPznW6FkRpoTAn5VTVxs87ONZMoEVRmkcQo?=
 =?us-ascii?Q?/OZK1nhusrN5xmKkva88SXGd0kjO1Ih/XG6BkKucTY6UEjr1B2jgU9xv4faM?=
 =?us-ascii?Q?sxaScgeBMJHzoAglgXfHsR7TsNRANd6i8U/3FKr8RdVIi5BIFgns/pL7+M3b?=
 =?us-ascii?Q?pyeNP1lPj5JJ6HT8gUkx+XDURT/HsE+UCNq0VJmoQQAz/38iYc5fzt6XQmsX?=
 =?us-ascii?Q?vFeUX8gix5H1Dyddsrnzo9Lg+MhetK4DIYRP3Jp+GNcBEsXg+aaqAQ3lM4cl?=
 =?us-ascii?Q?PrOLnFYZq4ueSl3Y8ERtzB+5we+b1Ov2TTlsQ8BwUToekPkNEMcl4O1B0Tns?=
 =?us-ascii?Q?XUhqoyk2OoOflEjeL4I7W7o1RXJF4DH6xkiXJKcOPDLWFPkceDYuhjZwv34a?=
 =?us-ascii?Q?PfgpZPnVRi+ktctnbbklG4fi9gDwirBz/4oihfBHNaNFWl1HWM9qiJL2ronM?=
 =?us-ascii?Q?C+0YQGCMNZpBuQ8mmZd6WP1vhSW5ry9iyT7w7wWCKkCunp5c+Ge2jxylPFna?=
 =?us-ascii?Q?utu4rooh7gXrAystQ7Q/RAXvu3hLAyqnS9eTwOIxNr5WzBbpHh7n5h8BO6PX?=
 =?us-ascii?Q?1Ov+6FoTKDCQFBUXpvAwD6GFhzUSi6MrAtIyDw4Lx4bz2sgpCLf3pcxhv/BX?=
 =?us-ascii?Q?uk+31lt64pihs/RpJzyTeu+m9q2gMScdi1nfKFgPdeELfT+Foz+4iFHwb38F?=
 =?us-ascii?Q?7bPr/0PIHpCvqhkiBYlzEMSyaEErKCzzdzA8kRflR6nlvQN39bMCi4yIt10m?=
 =?us-ascii?Q?ttxZVJj0XrPDVx6m6eZRSg4/PD1Znl930GPGwfkDg5Dj462Ti8bZW8kepP/4?=
 =?us-ascii?Q?EwEyMN27XWZx2vUFFS8b0TkEPLldImvmQfnNt4GISVrxQwWk4kfR121VINb5?=
 =?us-ascii?Q?Tnsgbfa0dDIOpUwNI4Ph26T9AAwKQFye6Xg2YZEwBQEHa4fjm6yMsQLLpV+S?=
 =?us-ascii?Q?uIOMQoRgGSu9naft8M0FBqzSSK3990ePNt7G9Gvbo64RLSY9bztR55lhensG?=
 =?us-ascii?Q?Kz43Orr4nsKp9c6t6vQ5rOirQeUkFmNQ1YCoOQcwdK2svYSVxr3KQvfagnve?=
 =?us-ascii?Q?Ljfq7FAU5ekVKirjnWivGQE8/pNDEsFqM8VTL3fk9PCu2bDs3WNehb8NcERU?=
 =?us-ascii?Q?gFAvM/lBlGMTJA2ZsHvw/WRNDni6q0+GBhHqtzubZFNf7koq0loKsxIwPH0n?=
 =?us-ascii?Q?nK6RChIifRyc+q1g848CPPmP+V0vvIBVoJipnJpzCRX76yLTvjrRcduHv+Q3?=
 =?us-ascii?Q?PN5s/+uvDk8qNFDPYzOjPozpfs/eirI1uGfOjictI8iS6SCwoH+ql6yWtORY?=
 =?us-ascii?Q?yBoM7KTgDx+IYUmwHhzPFzlj7VAYlPwKobeXciLiiTaTQfBhfPvLLOKs0DQK?=
 =?us-ascii?Q?AQSzNyJrQ09FAcxwVCIWhvaLfjzaum3IlXwbLFhlp+ntwv2ZchEiAvZSEY2Y?=
 =?us-ascii?Q?GzgKgUUA+9oAXagSK/UtKHdpYqSNMTWbojtdRJnU+zJCSpE9K1WPYmjD95dm?=
 =?us-ascii?Q?1v2Ec9yVLfvEXXBPCdO7byOrsRcIxgsQzBcRrGV3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed25909-1702-442d-972e-08dd66140eff
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 11:57:29.5766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6QDccZ+HXAH+eh2hx+Vc1KbJ5fMvKr1KOD5sr6xVJ0fzgBLlR61de0zUn1lSCaKIqTOfnkIptOAKXENVp0MUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9713

Port counters with no name (aka
sja1105_port_counters[__SJA1105_COUNTER_UNUSED]) are skipped when
reporting sja1105_get_sset_count(), but are not skipped during
sja1105_get_strings() and sja1105_get_ethtool_stats().

As a consequence, the first reported counter has an empty name and a
bogus value (reads from area 0, aka MAC, from offset 0, bits start:end
0:0). Also, the last counter (N_NOT_REACH on E/T, N_RX_BCAST on P/Q/R/S)
gets pushed out of the statistics counters that get shown.

Skip __SJA1105_COUNTER_UNUSED consistently, so that the bogus counter
with an empty name disappears, and in its place appears a valid counter.

Fixes: 039b167d68a3 ("net: dsa: sja1105: don't use burst SPI reads for port statistics")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_ethtool.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_ethtool.c b/drivers/net/dsa/sja1105/sja1105_ethtool.c
index 2ea64b1d026d..84d7d3f66bd0 100644
--- a/drivers/net/dsa/sja1105/sja1105_ethtool.c
+++ b/drivers/net/dsa/sja1105/sja1105_ethtool.c
@@ -571,6 +571,9 @@ void sja1105_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data)
 		max_ctr = __MAX_SJA1105PQRS_PORT_COUNTER;
 
 	for (i = 0; i < max_ctr; i++) {
+		if (!strlen(sja1105_port_counters[i].name))
+			continue;
+
 		rc = sja1105_port_counter_read(priv, port, i, &data[k++]);
 		if (rc) {
 			dev_err(ds->dev,
@@ -596,8 +599,12 @@ void sja1105_get_strings(struct dsa_switch *ds, int port,
 	else
 		max_ctr = __MAX_SJA1105PQRS_PORT_COUNTER;
 
-	for (i = 0; i < max_ctr; i++)
+	for (i = 0; i < max_ctr; i++) {
+		if (!strlen(sja1105_port_counters[i].name))
+			continue;
+
 		ethtool_puts(&data, sja1105_port_counters[i].name);
+	}
 }
 
 int sja1105_get_sset_count(struct dsa_switch *ds, int port, int sset)
-- 
2.34.1


