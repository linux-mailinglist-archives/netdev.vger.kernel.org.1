Return-Path: <netdev+bounces-204884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA2FAFC67F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297123BC8F9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884F229E11F;
	Tue,  8 Jul 2025 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="aPVFd1J0"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398BD221554;
	Tue,  8 Jul 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965322; cv=fail; b=IvP3XB5RAc7H0rfzeJFtQEuZM62d+j5X+5ydpeh1aC8ZqqAPdFrb4VuV8VpCM7thE385DXoN+nCnJ+dB2LLFsKTDGOTF6ohEI4jGwq5thIaOs2MLQwqfiByaLrC4JE269W4Gq8sicnJTQYtea110T4TCkMfUfvdw50KEyHz10lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965322; c=relaxed/simple;
	bh=y68XLclY57vukmDjI0wPswgmz56iKl3lHEmuvh4MqHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0lXqxQW+zPD/Fvm/fqDvFF2ruVzdz5dOpcqK0w0se6IsEtVXhSSccwz8IPb6yGMmNqhaSEftFH2qyYh4CiHPokcwTMQ2lJerp39aaVndkItYzQ5gx8eebVCJ+MI1BS1qgPQryfCex0IJtHD0rJd6PGJVe/SbSRlIqflguX/Szc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=aPVFd1J0; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deSIHtHvYC+sDqbkVjRDjUDargZ0bjtjGiL69Jb1PucMf10T55WttcR+IjT22wmVwjW5mdYEh/gsgGybH5W5uXKuG5xfDbT7g+iow9B7pQicjJlaF7phMVQuNERpw6p/nAdRVgCA5m3R8fg93CH9+oH4gb3UZNMS/RQbOF4BB2qeZ/td+JWpgsm53lGRjd9tDONOKsWKIbgwcC4jha5gbiNbMVit9jm7kATmLIw3A5NrCGGiH36Zx/9f2N9+/EQIl2XAKAfONl9ur3fqVYAzzzLV/acI1ISgYGEstyiFAgPpExHQiKQyrnnvDY53cZYKnShbCX5n2j31Kt2V95Of1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLTe4whWT4q7CGpR5VqFknx4DTOHOJxShD//P9jJf9s=;
 b=H493+heTa1cMpODSXPDkWOgPEXbYaNczvE1bBGNqeWEg5yAusUrAlTK4VJ2bgAgcv768YQcmTseSsjS01T0ky6RRGVW2N/XucrD4MK747S+6X49CECnGMlZonplJZEIGWTefn5xGih/jjMXc25P25E6wtuMCL+YRj4EaOhhrFTTHvBSvrNiHoEgN7MqUJgIv5ozgojwm8NcSkMXnpRs9okaRUe5Jd3e4dgeLBgxb0pGfI9BuhSMO4qtXCoS2cMZxXKBrks3VCsMeUfD03C7CeoTGXz95e4ajmbvd/ebMNr77lyjw15/+hoxI8vXebv/6GtpAaBqVzJnJKyr7OjxwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLTe4whWT4q7CGpR5VqFknx4DTOHOJxShD//P9jJf9s=;
 b=aPVFd1J0GCgXkcNPK1lUaaW1riEhwUcbHDr0CgD6r7cz90NqMX9dlH1jaWOCjHIHWFs00jrpj4chOhtYH60VBsxIr/U2sXb61J69/oRvIIKLcOXE+9V09I/oRZIlGVF+iucFsu1IRNbUXq56py8mnn55vV891bIaJoWjw3HwCl0=
Received: from DUZPR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::20) by AS2PR02MB9583.eurprd02.prod.outlook.com
 (2603:10a6:20b:598::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 09:01:57 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::14) by DUZPR01CA0045.outlook.office365.com
 (2603:10a6:10:468::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Tue,
 8 Jul 2025 09:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 09:01:57 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 8 Jul
 2025 11:01:56 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v7 2/4] dt-bindings: ethernet-phy: add MII-Lite phy interface type
Date: Tue, 8 Jul 2025 11:01:38 +0200
Message-ID: <20250708090140.61355-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708090140.61355-1-kamilh@axis.com>
References: <20250708090140.61355-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|AS2PR02MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 46313cc4-cb4d-4e71-a7a2-08ddbdfe17b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|19092799006|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REhmRUZCQ3VLYitIZDZrOWlpdVBPdHZLTWFuQVhrQW5UN0Z5S2Mza0tSQ1h5?=
 =?utf-8?B?NlhEem0yUFBMR0NsV0tkVUtNRjQ2NFFVVk5nTDVQREFCa0owR0psa25SU2Vx?=
 =?utf-8?B?aW9SK2JlYW8vZlNMS1BvREdKWlZKZzhzNUFxZlpXeVpLQTdHYmRYN3VvV2kr?=
 =?utf-8?B?cGloUXYzSjg5blM2d0xVcVVyV0NhcTJEZEVhR0FiVjM0RzBYQjBXeHcxUnNV?=
 =?utf-8?B?TVljbkdtaU9WN2g1aFNKWWswU1o0TUpjZElISWxvUFNVdTNlU2wwTGdSbHNZ?=
 =?utf-8?B?SS80a0RWYXdJWnJVcXh2L2lCMjV3SnNFYzUyZDEvT2NCbm8wNXZkdDVWUlEz?=
 =?utf-8?B?Z3JNZUpaK3pEQXdJMEs2YlN5ZGJuNGJKZC90dkdIS0kzUkgybGxvdWdJTzFS?=
 =?utf-8?B?ZFFWbHJ1bnorNDRrVU9NQUVhZjV2MDNvUExRVkpzdS9jejM2Z0FtTklIampE?=
 =?utf-8?B?T0FjeEJjOFRYNlpxc215QkxkSHRtWElNUVJTYldJSFZ5cWNHR2docEUyQUor?=
 =?utf-8?B?NWpXa3FZcTFuYlJscWlZZXk0VEtYNmJWOW9xeXV0UGdjVmRRMm1KWTM0aEZG?=
 =?utf-8?B?NlFpSlpOL1dBa3d4OUFhWk5NYlhGK2t4ME9IcXc0S0tBMHV0QjBoTWg0NWpq?=
 =?utf-8?B?MVBoT2RLNVR6L1BraloyWE9LOXFUQjlZamtCNzQyWUV5aGxtY2oyRSttS2ZQ?=
 =?utf-8?B?TFgvdGluMGttUmZRdXl2MXhRWUJLZGpWOWkxWW51dE8vakRDU3B0d3EzNVhO?=
 =?utf-8?B?bWRIY2VBZGxHYng5bUt3Y09MdmszZzFPUFgxUmdzNnA4VnMrbU5iQmY0L2Y1?=
 =?utf-8?B?ZS9KSDlZZGRDcTc1ZFRoRTMzYXV3K0hTM1Q0em1SdWRza0VqWDBwN1l5aU9I?=
 =?utf-8?B?T0QySEFKVFhUR3FkUjMvNHdkWW1yTUVGWWlLaGFEcnRrZFozMzZGMmtvcXpv?=
 =?utf-8?B?ODhtcStQYjF1dDNvcjQ4SURUT3JGcHAySTZpSngrN0wrdUxkbWFNZmdiSkhN?=
 =?utf-8?B?VXdrbTBxNUNiaDE3dlZ5YkVmejdvbFZQSlUrZWJPU3JMV0NBYS9ieXppcmJU?=
 =?utf-8?B?NDVpMWluMGxKaHE0Y2s2bzZEeVBnRzAzVFlqVG9EMVVXODRZZk9CbUlJZ2E2?=
 =?utf-8?B?VFFrYytDU0NGWGJQU0VCM054Tks4ZUpRWVRGYXVqVUgzWkRqZTVqVU8xYXdE?=
 =?utf-8?B?SlgxUHhzcWV1ZndNNXR0WUptR0ZIMk41czhXN0dYbXNiSXRwaFFOclBEYlAv?=
 =?utf-8?B?ajUzaVhndkl3NGtzMDF0T3AvRkphZGtEbUtTbXM4dXg4Tnl6MGVPb1BSNVM2?=
 =?utf-8?B?dEVXNnRlTTFuWWNCWlpuM1NwZTNhdVg2UVdEMXI1NDNYK2FYOHlUeGNNUjQ0?=
 =?utf-8?B?TDYzV1RERi8vUzJkbVVDRnZXMngxeGRXYVhiRGhwaVorODNXRkdqR2Qrczl2?=
 =?utf-8?B?d2NLak9tMU9mNGVqeER1NkI0a3M5azZYbmQ0TlhIMC80OTBwOWVQbS9VQlJu?=
 =?utf-8?B?M1dyVmUvM2FuUzZRcU5pTUNhVFNrUW1zVy9wRnNWNEZLaStJbGN5N3JqaHpN?=
 =?utf-8?B?MWRBMURuMlZDM0E1bTZENFA1QTdGSVlXSC9IRjRSMDd4RUZPSUVMV0haQW9T?=
 =?utf-8?B?YjRkV2x0WDlybFAreWMxT1pIbE91cTU1dW5EV3RmMENtNEE3b3hDYU5PZnNN?=
 =?utf-8?B?VXowRWEySGtrMzZwRWphaG9mSmRZbEU0N3JVbllhc1E1b3VIY2NJbFZkZ1NK?=
 =?utf-8?B?MUlNT1p3WjVnVXNUZUUyRDEwdHJUVm94L2MwZUlINE9lZEtXQXpqSG9neGlO?=
 =?utf-8?B?VWl0bzkxSnl4ZCt5WEUzK2N3bktTOU5DWTBEeXlHQzVnMkl4N3dLcThzNVEx?=
 =?utf-8?B?cXBjS1JiT01qWGpWejlDR2RkcVBkUjNOY3pnUXpYeDBiQW9hMnJqaW1NK3lx?=
 =?utf-8?B?VGZjUEpuU1d5YzVkOVJISHJLLzdSakpaVS9kdm4wRHRNL2hENlZnbzc5RXR0?=
 =?utf-8?B?eFBUano2eXJMR3hBbEh4SDJOWUc2L1F4N3ZzVVBFbFgrK3FnblhGWmU4Tmpn?=
 =?utf-8?B?Tkh2NFNhVHBPUjIwT2tJcmJDbGJXTHE2aWJOUT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(19092799006)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:01:57.3006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46313cc4-cb4d-4e71-a7a2-08ddbdfe17b4
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9583

Some Broadcom PHYs are capable to operate in simplified MII mode,
without TXER, RXER, CRS and COL signals as defined for the MII.
The MII-Lite mode can be used on most Ethernet controllers with full
MII interface by just leaving the input signals (RXER, CRS, COL)
inactive. The absence of COL signal makes half-duplex link modes
impossible but does not interfere with BroadR-Reach link modes on
Broadcom PHYs, because they are all full-duplex only.

Add new interface type "mii-lite" to phy-connection-type enum.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 7cbf11bbe99c..66b1cfbbfe22 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -39,6 +39,7 @@ properties:
       # MAC.
       - internal
       - mii
+      - mii-lite
       - gmii
       - sgmii
       - psgmii
-- 
2.39.5


