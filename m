Return-Path: <netdev+bounces-211668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B64B1B12A
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 11:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B31E1890462
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA9F27056F;
	Tue,  5 Aug 2025 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="dtRXBcEy"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793B026056C;
	Tue,  5 Aug 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386428; cv=fail; b=KNpddtOjfIhuKlBZYcQvZmQpQEHCVo2y22Za8qu/aemZRwQoomg78hKKk6L5hnFFku2bKBvL2UuBaz56Z+ydb1DAd3abwW+nJc6tu+o0pavD+lzE3xSzCseKz0XGJMhxs4r6GtRxyXd3Ldcj3273wr2UQUukLtjErKkhPbvzyus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386428; c=relaxed/simple;
	bh=82o+ZoQNdwcrsC+OctTplrLw7hR9x18HnCNKLxXIt9Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MWPthAdBcVI5PVnBG6PCzwrZOlSBsAhpCZDVgyDHLPzmpYWeTXeXz0xN1HAHISre2bjObnnlyKRVqePGM6fUzD278aYJCYWe8+X/Gq8Ywf2LOm5kVij3WLfxnn6vg6VAxrXWo7bjymdg1uIBqh8v7Z2lfAXBwDwbL9KQme2EFW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=dtRXBcEy; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exrkS1uo8kJxjKzzcEXXI4aTz58PdXOqRqOJUClHpd8uEN0lGXl2RaIZNRK+gh5Rem61wP8lyYdx3CJ6ATCqPdgWIfIWuOcg75xBBVI7N7zU1XWe6wj+mlwgBL3YRTB5+VOW7JH9ujNXCW2pUeV3aTgi5xsMFDYKxp7auDQx7v2DfLlV8zQwCEqbe3preLmmRrZCLeFJ3hz2zLzr7kwxRIHW5xu0QhWZqIHf+Zma+h6EMcaJeK6c1qi4uaB6v38mCulqLnFjxcagIxXxdTzcSDRYElhE5vKLgwpn3D8ZNXy0IsFCJc/tAuOFHlUSTNLOkY2zCFw/gvYieKNWKp0Rvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEqt7ye004ca8JFE52EYm2xYJZlRxgMc2jeZRB51fVA=;
 b=xpOCHz/tatEc/uN/4KXXvdFJSvaW4tuxFirZp1QHHukxsNov+1WmT08J8nqjNlwKA5q3tGySfC5INandBJ9eEVXw03be/mdVDjHwrWYt02ENoYyM6zR9l3zTlGcIixrJhKB6gI3Wghxz+4omDknI7NjADQDRaMUAFhsEbPMZ82D91Qpfq4cYS2MEJzCenXqyggCtzhmNq6wLgaQXntq1lOq/NaPQmoOMPMV68jQfJ6MAmeBwk/prLVtCX+38/KkGpuqjOUSas8ZYB8K193jBO+BK8U8Vayb8aSXSy2RXJFa4EXpcyBCx1ayDJrUnhsWrsxjUuE05RUI6S4LrKbP5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEqt7ye004ca8JFE52EYm2xYJZlRxgMc2jeZRB51fVA=;
 b=dtRXBcEyTI6vzKbDN+SwvzKSD3uJuTg9imJcXmbzipwbpaVp5PziSKXgYhU9yEZKJGflLiThSGNXld3gI75no5JuhznaHC21H57mXYiRAXQFP5Y3cVdsPWLqv9CvnOXO6gqo5heM2sRe0Umq0Dye5c6ovJMTxctfv1qzQqEOX8I=
Received: from CWLP123CA0009.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:56::21)
 by VI2PR02MB10950.eurprd02.prod.outlook.com (2603:10a6:800:27d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 5 Aug
 2025 09:33:41 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:401:56:cafe::98) by CWLP123CA0009.outlook.office365.com
 (2603:10a6:401:56::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 09:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 09:33:41 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 5 Aug
 2025 11:33:35 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <kernel@axis.com>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2] net: enetc: Remove error print for
 devm_add_action_or_reset()
User-Agent: a.out
Date: Tue, 5 Aug 2025 11:33:35 +0200
Message-ID: <pnd5xf2m7tc.a.out@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A790:EE_|VI2PR02MB10950:EE_
X-MS-Office365-Filtering-Correlation-Id: c6583413-36dd-40f3-8860-08ddd4032a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R9fF1vjXz1G7p8g8lx8nXujALXwVs5RLE+TXBMI/URDC47zt9RCCHOHvWWJg?=
 =?us-ascii?Q?TuR8J+TNBWxKHdV6eY2rgLj6MAHx12+TNcXlc3+7q4hj5J3+3ciS618g81F1?=
 =?us-ascii?Q?OZu//BoDCHn42DxtdWSmhvj4o6mLgZWOoF0X5mRuejk97p4TZmgt1c4s7ZNm?=
 =?us-ascii?Q?u1ruWmAEG1va9Jjll65KxNIyRwJYJDCEmM8AC/Fd3qe7XSrfnmd9hjnb0sJA?=
 =?us-ascii?Q?UW0aIVhXeZECBBsiYDK72PzH+/VCUsPr5p/IfYjQ2/MO89/MFGobruX+acb4?=
 =?us-ascii?Q?iZ4rRK4IKJZtz3KEYzV9M/DkdGL925nQYiKB2dmE1BxFaXdMh9zuP39oOUVe?=
 =?us-ascii?Q?MIk4qaXMTEyF13wJzyn1WHXBRUejWDX+iqYCTUtE4iQUuLEg12+uEoeWFY+p?=
 =?us-ascii?Q?D6CP40XCSo7I8thnxW/wCcJw0Iyuh5iRCbxPKtGgE5jhHYDOu8GWaeIeagtx?=
 =?us-ascii?Q?DLa2QDW70ZVZJwgxIGuxtWehtC/rREg8zQzlQVGwHurKAnqF9/kbCpUkhnjn?=
 =?us-ascii?Q?tPsny8V2tmKwCVHfDhp/oBodSgpO17LQ5WCemoMUxubNW/vHJAdyX3xHKyMy?=
 =?us-ascii?Q?/QXNfi53Lypldo7fR1Nc6NjnBZeV3C4Yp+Rq9d6IhH+5v0MxGa8lWoNO5Vyh?=
 =?us-ascii?Q?R461tzkD0hg0QqUfjYKNrPI+co2NGZlmYH0x+b5KCGd12JKij65Q2FLmR/Pw?=
 =?us-ascii?Q?JCLijjm+ZEWrMG6JgrSdqLFKHLWQ4uumDQn1r3J4cSatrGyweGbVbEEYyQTT?=
 =?us-ascii?Q?NqLYsUTiK55LsMA5m5q2N3l5mFpfdiiGQz+F1afyKK5/namll6Kh5ihvMJ9j?=
 =?us-ascii?Q?Gp8aOm+MCkGSnHvK1dPxo/oBxHqo4TCtB0r5b7DMbdYnyCiMB9Yq8YEkof8M?=
 =?us-ascii?Q?h72z4kAWpFrsISqqhE3P18IuzTQkl9mfmOpVUuMTOIekSXYIbXRoNKq5auOy?=
 =?us-ascii?Q?gqSV2gnZV67LBYuV3vRdi8fw3CUjHI3K739p04nKqWyyPk48pro8M+wcLGk+?=
 =?us-ascii?Q?oXF5fRa6wmcVRvcNRcm8J6DA8300iTU6H9hUO911VamM3fJCeLINMtK1JrB9?=
 =?us-ascii?Q?ozPinMFC1y+5eRAnXPSaaHTgDR8PMi8a/IHBaCZXuZ604QxRZ2Nczs1Cu/oS?=
 =?us-ascii?Q?FFFeve013OYDICpuCqJAxFqeIoXGEygYlenngmYqa+WZxAD/WAI6k9Bb6eJN?=
 =?us-ascii?Q?m+sv09URdSMzC4alw+g4MkLBqlFfmNjNm3/PYxX4HA0bZPTvpGfinDdybBHA?=
 =?us-ascii?Q?ASMfLGsrbMfVA6EAAx7GKJ3itxoy6zMLxla1Jhd7isBDquNkPVjKMSLLgLQe?=
 =?us-ascii?Q?a84jSg18UUgwhPyY0FmWOCX0CHsRcxvVdR7HsA4JEFDJD1aWzdqtcgdihBWT?=
 =?us-ascii?Q?bntkxtUt86G2ZPnhr9iLkxeMAD+PFm8Nq7Pbphe0S+doGZJS37rkYlG7KItk?=
 =?us-ascii?Q?16g4e1a5GNAhKSmUYvLsWBjezsdGFBuLoE5YQ0w5Z0NPJEIURopD6DVSNcyI?=
 =?us-ascii?Q?BlkJPrQjbKRfTuQoaH6uLWFwZhmEPgdLufdY?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:33:41.4585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6583413-36dd-40f3-8860-08ddd4032a3b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR02MB10950

When `devm_add_action_or_reset()` fails, it is due to a failed memory
allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
anything when error is `-ENOMEM`. Therefore, remove the useless call to
`dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
return the value instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Changes in v2:

* Split the patch to one seperate patch for each sub-system.

Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/

 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index b3dc1afeefd1..38fb81db48c2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -1016,8 +1016,7 @@ static int enetc4_pf_probe(struct pci_dev *pdev,
 
 	err = devm_add_action_or_reset(dev, enetc4_pci_remove, pdev);
 	if (err)
-		return dev_err_probe(dev, err,
-				     "Add enetc4_pci_remove() action failed\n");
+		return err;
 
 	/* si is the private data. */
 	si = pci_get_drvdata(pdev);

base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
-- 
2.39.5


