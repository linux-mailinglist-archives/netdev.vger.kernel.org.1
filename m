Return-Path: <netdev+bounces-201256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64068AE89F7
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 601857AF89B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A66D2D663B;
	Wed, 25 Jun 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="KBwe1LEJ"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FF42D4B4F;
	Wed, 25 Jun 2025 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869318; cv=fail; b=TZJDeA68NzYOdaMkl9ENmFl4FecgmQRB43Tbnt61cSzzMJDFUntq7YE0yDwzZEEZdRYvmEZcmF9m7iwOAFIl5sSwQw4hIbZbDbjWs27hH4SoMb2X+ZBgjdecgmPRQlS3jV+VDQShF2Qt5KaJa8FQszhyo62ADHVlFlzzaT7/sCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869318; c=relaxed/simple;
	bh=AXEFTaY8Dl70QqeV37/ey1rX77oxDxnP7/fmpiBZYmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRHKcta5u+bQ7juuVFPYaAhSSi+4TmcSil/8kutwPFEuNUFj0Cq5Lm/IMJo3wmJpz/lS7jtle3Q+dvwJBT/r/ihFu6CVaM7hD8VskYRt39csUf+CQoNCb0gJk1RXWXscgrmTwafLGYcuTMtvZxOxPq7x+XUlWUtR9eM+2MRWRCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=KBwe1LEJ; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnqqJ277XFlWzwwp/NNJr1gwi1YEyuyFuDB3/qZE5jQcRcB/RSlpBaEQsvUmfvJ1lSqV+TuKAPdLDSP8dTzZ14vxrJyyV08lB/Xh43CV7fo3s0VxjWdCT53g73c9R+r53apcID+51IBdyVKT9wsx6GcTMQiWWrx/ootAmbeTFCpygs1UNxr1wNwABCfxyzizmHt3BOsmJs5mnoH9k3PNFNe8d5Fh5loEdqhVHS9FXiBwL3C600AmpN6gAu3FVxvJs2ICFYPNcXPSdP3TfHx7yVuZGMpIAQZEpvK48dLhM4HSOHc9/L1wbF6JkEThuesHBanrlOM41Zff9vCHUPdQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iuwv4TOgBBH7uC6d1M0AFq0avU66bPGfPLr6PdS9yK8=;
 b=KLP3qbYNc+cg+9sa3eMpBzJTrPz6AyipMrCoyz6Webzat3CicH//eleDPpWY665ycxii2gwvjZ7DfDP2Gr0bYjxwGFMKnJ/OItwB7vjyQnWQT4JD31SkemSbHlryro+NZtfaB6Vr2zbaQuhCwe1P39stHW4+9IDdxPNZ1gdI5yqqpENqqKhq5ymj1U0aT8mSqSRpmJwEZnljiqKCfzX1XXpZq2V1QAuYtnlRaPVbAiY2Ml2rt3pLLtYNT1qcfksNRF0OHtBHzNWZUeAJ2Y1zO4wfpJ1sMppEkyVU1Zs4azgiBgrPCvGiKbjtrGf7Rt8SJ9fQVhVD+bp/gUF11YWEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iuwv4TOgBBH7uC6d1M0AFq0avU66bPGfPLr6PdS9yK8=;
 b=KBwe1LEJE8Qiu1S4w9aPqajOJrUjxawdejVWvYMkT/PMC0CQaIQ9vRbVNRxGnaiztEoM6keojuAy5xgfDBH0xIi1eQk6n2uZJAgr1Q9+kz6lv7HMN206bHyY0xwUauakxTgLZ+SPBQQuC+zZGsfspDfhh9ZQrX8/V2vDiTqzg04=
Received: from DU2PR04CA0262.eurprd04.prod.outlook.com (2603:10a6:10:28e::27)
 by DB9PR02MB9801.eurprd02.prod.outlook.com (2603:10a6:10:452::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 16:35:12 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::b5) by DU2PR04CA0262.outlook.office365.com
 (2603:10a6:10:28e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 16:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 16:35:12 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 25 Jun
 2025 18:35:09 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>
Subject: [PATCH net-next v3 2/3] dt-bindings: ethernet-phy: add MII-Lite phy interface type
Date: Wed, 25 Jun 2025 18:34:52 +0200
Message-ID: <20250625163453.2567869-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250625163453.2567869-1-kamilh@axis.com>
References: <20250625163453.2567869-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|DB9PR02MB9801:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f9207b-050d-4a73-5054-08ddb40641b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXVrK1lZOFhPK3kvMUtqQXM5azlFZ3gvamdIdU1EaENKbDdmazNwbjBRYWpY?=
 =?utf-8?B?bGFvOGRhZmltNzIzOWVVVlNqc044NHJtUTdOZThqbkdiU0VDMDBRb0NsUmhO?=
 =?utf-8?B?UmtFSjV4eWdUY2pwNHFJcFF2Z0JLS2dkbHlUck5nUzNaWStSb2xUd3BQRk5q?=
 =?utf-8?B?V253c3UwMEVTOUdhWnJxT3pVbEJGckp0NUwyZWJmNzlRd29tVTQwVEpVZVRV?=
 =?utf-8?B?YkcvcVNUdU13YTlFTjlLL1kyeEg3bEdVOElwUm5uTXhlUVhyUDIxc3FvbXRI?=
 =?utf-8?B?VjBINWdaemFmZmZEMG9neHhMa0w5WkxzNWRoS1pWeldidU1UeGtyVmNxZDhP?=
 =?utf-8?B?NFRjY3pFVDB0ZVFDbXV5eUhvbDVjOEV0ZEE3bFZValVOL0l1SXpxZUhBWk1h?=
 =?utf-8?B?R1hISDN3RFhpTTd1Sk1sZ3IxTTBIYlFmZWgycWxpejNXMC9oSVlzWFFXMjZj?=
 =?utf-8?B?K25lTlBXYlkwcE1YK2IrWHRpbkQxeFRwM0xabjdBZUJDN0Y2cHpJYk5MTjYx?=
 =?utf-8?B?ampWdm5lQjVVUE5aSW9pUGR6L3pYS2xqMU51NFZMMktUWHV0bDlDYTM0bHlN?=
 =?utf-8?B?K3lMMGlGMjBaeXV6VUx2MFB0M3M3QWM4bWllQkVBc3JqMVNxMjhGT3VlenJw?=
 =?utf-8?B?OTFiNFJoWUxqWUkzU2ZMdE5DTGZUWEs5K2JVMXBUZjE5UEJlcU5seUdnUysx?=
 =?utf-8?B?Uy92MkMySkVVcXFGV2RQMVZjWXVrTXBLeWt3UjRrbXliYS9kTk5YeVVmaXZx?=
 =?utf-8?B?eWtycmtVamxxai9WUGdNUXZGNHNucjl2bThkRTAvb3RaS1QvQ2g3NjJKOTVt?=
 =?utf-8?B?cW0wL0VHS053SWlOOHFuOTdqelY3eCtzMkFZb3VsODRkUUZOMVUwTlZSVjlS?=
 =?utf-8?B?eExzQ1RzeURvVVAzNlFlUy9HRjVvTXNMeXgxUGEwckc1OHBPSGplYXpPVkxE?=
 =?utf-8?B?eW1SUys5cGlOZG0zdmVOQWZTZUNoSnRHWHcrQUowRXMrVk9DcmhaN0U0czMw?=
 =?utf-8?B?eVBVWFlGTGI1TGZtMDdtQU02UHJDRjFIRmVJL2lta202NWJOWXR6MEtJcC9T?=
 =?utf-8?B?SHhIQ204MFd3bzF3UUlMb29PaDBZWVBSS0JOVTVSRURlcEFUMUVPaGVFckYv?=
 =?utf-8?B?ZklzQk53SXozVk51RGZYc3V5WklnU3graGZwTFBnV1k1MzdDV3lxL1ZyMEZm?=
 =?utf-8?B?OGtRSzU2aFkzWmVtemExK1J2KzVodTQ5RjgxUTBiWTU0SmE4czYrenRzZDBF?=
 =?utf-8?B?cVdGd2lpNmxjVnlmelB3Nmx1aGxvSUhFZVd0S3ZOdkgwMS9qSThybXNibEJy?=
 =?utf-8?B?bnk2aVVXL05LMG5rbDZsNm5oQ1c4RTVmTzRISXdraTQ3eFlIZkl5ZDAwTnRH?=
 =?utf-8?B?TkNnYnBXcERGS1oyNzVxYU4vNkJGSVpZK3VjdWR6Uy84ODMwU01tSjJXUkhn?=
 =?utf-8?B?aTdtTS8yRldWRFRBZE9PaGtEOEpnNWhtYlA4NlJqc2FCcEc1LytSeklDTWRE?=
 =?utf-8?B?dUVLYTRhUjRobmZxbVpwUUNjdWdxR2FtL0oxcVRkZVNNY0k2aUlVSDJlZlB6?=
 =?utf-8?B?K0JzbDVOV1RMOExQUkxqTkRWdlFkMXdoazN6V3RiZUJJdUZLTlk4TVdGYVFq?=
 =?utf-8?B?NW1iUExDTUczWVJoVXJMRHBUYnloR0hvbGlXaVFkTXR0NkE4TEtJcHNQL0Q0?=
 =?utf-8?B?L3hPdTJCMlNZaHdEdEQxbG5nZ3IwNUNKSkJiWGNXYWRwYk1FOEowMHdFUVRD?=
 =?utf-8?B?VUF3d1QzK3BKTXVycEM4eXNhb3hrc2JlbWR1bXoxM0FSQjcyUy9TTEs5eDlu?=
 =?utf-8?B?a2NpV0EyUzY5aXJiaDh3eGVaY08vZ1RIcElDRGVScFdoTy9oWDA1a3Z4Wmd6?=
 =?utf-8?B?OHRjMEd2SmVWSVN2KzYrcUhBTFVPeWdOcks4enF2azZVQ1FyaGlPNEFHMm1Q?=
 =?utf-8?B?eDNmVWs2Rlptc2puTnJETkNReFlLb1NmcWtQY0xaOERiV2VxMDIrWU0ranBE?=
 =?utf-8?B?VTlrbE4zTElTN3R6TktGMGI5S2Jyc28ra1JGcnQvNG1ENFBlT3NMTnhLUzc4?=
 =?utf-8?B?VGVkTW5EWlprUjRmRlA1OWltT2xNV0gza0JoUT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 16:35:12.1411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f9207b-050d-4a73-5054-08ddb40641b9
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9801

From: Kamil Horák (2N) <kamilh@axis.com>

Some Broadcom PHYs are capable to operate in simplified MII mode,
without TXER, RXER, CRS and COL signals as defined for the MII.
The MII-Lite mode can be used on most Ethernet controllers with full
MII interface by just leaving the input signals (RXER, CRS, COL)
inactive. The absence of COL signal makes half-duplex link modes
impossible but does not interfere with BroadR-Reach link modes on
Broadcom PHYs, because they are all full-duplex only.

Add new interface type "mii-lite" to phy-connection-type enum.

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
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


