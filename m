Return-Path: <netdev+bounces-104911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3429790F19B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE2D282EC9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2037711E;
	Wed, 19 Jun 2024 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="pu2X/f3/"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2069.outbound.protection.outlook.com [40.107.247.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A378A2E832;
	Wed, 19 Jun 2024 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809472; cv=fail; b=fI220NwD7vUxic+lC88qskB2qd5q1nkJZo/7+8FjBeGBawDRfPmWvoO0SLjmup9QxhG54nTM1rjI5B0+v9+9wnuYzK3El2KD3sNVuALQCzftuVLbbMO+Mv3YTTPj2v5W2+V7hrdhL9kdaQfPWSKtpPdgriNf3IUqcecxKmC/Z0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809472; c=relaxed/simple;
	bh=cwMzZ2m1dn0C9rY/2h0EsG+79CnYazYIlygrMQT/FSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urJQqft5hZhXtqkLDSQAS3cwBm7YcxZjlA9RrOE74DXodSjJ24tolGdzUBsu9SCcYRSkBYLCRYR4elPo7xxZ6R7kVC4IzENX2XKJxEg6/1801Ip9m+XACueMG34KDNNFTWrmelLmE+T8YVTx0c4rPBpasZ73r3HdQ4bNoSW4bX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=pu2X/f3/; arc=fail smtp.client-ip=40.107.247.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO+74UnhS39wdC+RPaplgrmwL7zQkByYzNCUcds2+0AFAX3AtbhyRx2WLAT7zIrwVhwXessg70ipYAgLG8gqSH72r6bpexcjx4rjxgpSSpBCXkeN44C3fzcH9iWpO3wr1sRciT4rcVtDokzBQbr8OYmnqsMzXQWH8IhAiyQT83hyIjzvIwzQ2SbAKBD1NOpEJngbj7juV71v8RdEQ2GhZp8LQ/3wVK1yr1OdFcDfls58cfU2C2j3p8u2aYWsJbFldz2GtU76uDSJGlp1U3Big15H6Q3YTD/aa8vP1otFD4EX2LXq7LEAXoviB82O1XJmpLxmlK42NqlTrNp+BAOh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN2dOLLQhedQOncCwIWhdfCtJiOCA4UAEPCcB7/T4m4=;
 b=b/vQT8hlHUbD1vTkP6rSZ77W4yhZ9VHjGus8S6RGBPbm9tHBQvUtQOYV5yA2dVmeb3S8CeRoKt/yYsfbclfqcffHUIlOXze8BuiN/XTeScpodv8OTjWbFoudXcZCr5R9/cT1EYDX80dJywaDJy8ywwe4dYBRHsqc+Q9HFscOFLan78+mg9wlbc7dL1ymy4dB3xteoKbJncE6zM041AzjFApPNk3X+wq/TDeRaUc9ompL9UBxnGU9mnfW42n91T0znE7UJZUaID9ASyBVuoOTomJR8KjbNESyaTuk5tpa9NAIMOatwyqpoeUOzaPCE3+CPqgBcsBRPq5SwiryRYZV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN2dOLLQhedQOncCwIWhdfCtJiOCA4UAEPCcB7/T4m4=;
 b=pu2X/f3/1yyI1Kks1trZBxOa+4ms6vZYxOmwQ0soYWqflOHL0jWwT8Bh705IesHaxHFT65oW+ym2I89b8jI4soP34WAls7ba//JhSJbWxhTkv940iaGlfHkh/7+nKxbgL1hb3DNbJi8qB/yyV/804B87npQGlNAHmSqusJcFGck=
Received: from AM0PR02CA0201.eurprd02.prod.outlook.com (2603:10a6:20b:28f::8)
 by AS8PR02MB6775.eurprd02.prod.outlook.com (2603:10a6:20b:23b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:04:26 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:28f:cafe::38) by AM0PR02CA0201.outlook.office365.com
 (2603:10a6:20b:28f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 15:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:04:26 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 17:04:24 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 3/4] dt-bindings: ethernet-phy: add optional brr-mode flag
Date: Wed, 19 Jun 2024 17:03:58 +0200
Message-ID: <20240619150359.311459-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240619150359.311459-1-kamilh@axis.com>
References: <20240619150359.311459-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|AS8PR02MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 762aa0ae-42ab-44f6-a603-08dc90711cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|82310400023|1800799021|36860700010|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlBEMWl3dzAvZEtScEhkdTVvR3FJOXlFaGl3em55eHR6eERUeWFXUmtqUkRs?=
 =?utf-8?B?VS9YLzczUDVsR3NtamdUdmVLc1hQTXU0SEVGOHRwSnloOFpHdGpGaE5LaFJ3?=
 =?utf-8?B?ZkVNekJoeC9nUlVnanBuSWFoK2JQakxDNStrdERrd2Vpa2NTV1VqenJCZzdY?=
 =?utf-8?B?VWtSa2tyc0tIUW5hekJqQWQrRXNIUlRNbFBNWWNBSVdoWXRpZUJiblJYV3U0?=
 =?utf-8?B?elB3MW9RZE5tK0JSNFdtR0d6TzJwMTZ5UDJiMUpMNDMxRFpjV083Ry9nUi9Q?=
 =?utf-8?B?Q1h6cTlCeVdMdk8rYXV6MXZzYm9iRUxXL3VwakRGOTlIMjZlUEkvY0txd2Fv?=
 =?utf-8?B?dU1XZmxqb1B5anNnRmJ4OUZKYzdJclQrZ0p1emNadWRFOUJjUmtEUkowYWU3?=
 =?utf-8?B?M1FqL2hrb0pmbHkwLzdmeUF0aUhnUWpRMVJlanBDV3Q1MnpyUHFFaUthc2to?=
 =?utf-8?B?VzJLTDh5TW0xcnRscUJ0SXdMcG5aeWtsdm1YOGE0ZUE0U1hhOFFBMlQ2L1FP?=
 =?utf-8?B?VnpidjhIcCtGSy9EWTBSc1F5ellFaVpmOWhtbUpzc0R1LzVLSXNaWFBRRG5o?=
 =?utf-8?B?SFhBbERHb2llOW84VlVBbC9aNzdzYm9PZFM0MWIwVDRINDVTT3NFNlJ5ZzhB?=
 =?utf-8?B?dFFKZEREWUludUpzbGNBTmtJOElLTnMxL28rS2hNWEp3dldmVDBMU0NoWmVi?=
 =?utf-8?B?bGx0QVVmVnhJc0FtbjFEVEh0T282TTFiSE43STVEVXE4WXVDdStLcjZOa0tr?=
 =?utf-8?B?Vm9yQjNCRWZpdnh1WnluY3ZnSTZCVUVVVkNjQURQSUNRZytESmxOR1psRWhO?=
 =?utf-8?B?VHpMdUphcmwyb1dwemZRVC9hR045b2psRTNTempidmJlYnFYODBDM2FRQktV?=
 =?utf-8?B?d3lWSEY1SzlhRFBncjNrazZDQTRGSlEwMDlSWExXVXlSa0VnNGhFNVUxTTNV?=
 =?utf-8?B?d25lR2psZlEzc0tKTmg3cURKZTRvUmVGY2lkTFV6WHVoMzJWQWVIUmd3L2lD?=
 =?utf-8?B?cUVnUjFWMnBIbWpUSEtWZS9PMVFhVnVJRlNIY0JsSWpxMmhZcStLNTJjOUta?=
 =?utf-8?B?SEZGOHdVTFdicHltbmFmQXc1WDlGeFZJRjY5YXRjcnBJRkhnejdpSmNlYVVZ?=
 =?utf-8?B?ZXNrUVVYZng4R3pRZURJT2NkeWcrZDRZcHpoMGJnZWhjb2RPWnJ4NFAzK3VB?=
 =?utf-8?B?c1FpNk5aTUFaMWp1ODcvZHY0U3dDNVRaNVhGMlBMZ0dsZmJ0cHoyQkgreW9G?=
 =?utf-8?B?dmV4TkJ4Rk51c2c1YW5hS1RyWThaOVh3YVFiUjBOWlA4WW1JZnFHakUwWjJl?=
 =?utf-8?B?V29HYWtQWXdtNlRueCtSMGRNaXdpRWZCNm1qQ3BEZmY5Z0xJNHhrUjRmNE02?=
 =?utf-8?B?NmVyd1E1bkV0VUxGZVZtM3lQajcvVzFvT2grWUNzOUxNZHpYV0N5M28wSU9V?=
 =?utf-8?B?eEpZSkk5b1hKMHBUVGZ6RzNoSkRQVnNyRFEvNmQ0UGJOSUc5cFhlVUZ2Y0o1?=
 =?utf-8?B?eC9DWktnRWZSYjNOMHRERUNFdjQ1UDY0THBPZGFHK3laQzBDdk9qejRPa0wr?=
 =?utf-8?B?V2svbzh1bURxV1pCU0ZtL1FDeVk0b0NVeTBEL3RHRzh4SFNYaTJDUDVjVFNB?=
 =?utf-8?B?MWdQL3paN3d5RzZSYzBGVHBGOHdmdHZ5aVU5Ni9DbjE1OEpmRW1qL05WU1FM?=
 =?utf-8?B?eWJyZWJsWW9weXR5bnZMUDcvQjlnbE1sY3BzOHJseVcwZnFra2tmRi9NSE84?=
 =?utf-8?B?SnRiYkk1S21wVWcrTW5oTy84UThXWTFjaHlRNVRGckx2OWRFY2U0UnlDMDNt?=
 =?utf-8?B?OUpRcnp3eDNyeE5jZUk5WlJUL1hYakZZdzcwQ1ZjMHltZDUyY0l1cVAwZWdM?=
 =?utf-8?B?b3RuWVNsSmhSY3BZcnFCMC8zUWtYeHpwbzJZaWdwQlJZOEhuc1NvTXQvRVRK?=
 =?utf-8?Q?FGqetR/B5gU=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(7416011)(82310400023)(1800799021)(36860700010)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:04:26.7940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 762aa0ae-42ab-44f6-a603-08dc90711cc6
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6775

There is a group of PHY chips supporting BroadR-Reach link modes in
a manner allowing for more or less identical register usage as standard
Clause 22 PHY.
These chips support standard Ethernet link modes as well, however, the
circuitry is mutually exclusive and cannot be auto-detected.
The link modes in question are 100Base-T1 as defined in IEEE802.3bw,
based on Broadcom's 1BR-100 link mode, and newly defined 10Base-T1BRR
(1BR-10 in Broadcom documents).

Add optional brr-mode flag to switch the PHY to BroadR-Reach mode.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 8fb2a6ee7e5b..0353ef98f2e1 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -93,6 +93,13 @@ properties:
       the turn around line low at end of the control phase of the
       MDIO transaction.
 
+  brr-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Request the PHY to operate in BroadR-Reach mode. This means the
+      PHY will use the BroadR-Reach protocol to communicate with the other
+      end of the link, including LDS auto-negotiation if applicable.
+
   clocks:
     maxItems: 1
     description:
-- 
2.39.2


