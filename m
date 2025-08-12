Return-Path: <netdev+bounces-212845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83914B22411
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD271AA56BF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1E22EB5A7;
	Tue, 12 Aug 2025 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FFlm1vf8"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0C12EAD1C;
	Tue, 12 Aug 2025 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993232; cv=fail; b=EfNqBSgTmo/LWrjaYYbUUU4j1YWW8coUUfrHs7JM4N3fxQFIltqTzSqVrq79TvgJJ75JVmhfJgap68Tii2SKSIQDu4WlWPHn/blzzYTGz2adzS8DKxDtYSxCejkOvqhPPFjP8KbT8X+1Ps1jCxHw5bw5xen9Gb9pPIv9fCMSXHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993232; c=relaxed/simple;
	bh=4n1WczJOY3/nZ3b42wabf9UWZ5PQqYh9SD6eajp0fic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I4KkGG8+rikLf6TpsJl/yZXW7smObcBmfhVj1MHTNmoxB7ZsWytooILDY8G0MGhJxmystqoQoBAW7WgiE3jqICg+rVzUh/mDMkfeQ+GIX0B00T7qRXRnmrdonJ7s6gbZzWk3tTucPdmJ3ll4fOyx5FXVBmC0ln8NaNQc1Dyenxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FFlm1vf8; arc=fail smtp.client-ip=40.107.162.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=po1qfNcHMLcfcZqKf8xF7xYFKLUcmWkfoVIH1OQUwJS3ZxdwY6pI789p5/v3J3CQIZ5gJxdFpvIHeRV1i6LnQfb0+FOL2k8ixhcQjV8cbmK0SRRWKFvtLnsjJmdkovSrMaKs+6hwDk7kHeirUguLpiuIBduHZtM0m7DysfqaWOBm9xQalGeZzVsfdznJk8+uc8lqEjr1YRf4Mq6jyb9NMsWL7noY7jx5RM7Lid0a8rOgM2F1YasppLaTVlJ6pqM88VJA7mHIz0BSn+cdvzELy4+HiAAKXo+LnThSeJTMiRuX5/ByALMHTtHJrsAWpyNe0u9F6PF08qimPsLFXqK1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbENv6kA2txGULFvp1X8XkgujQdWnuRujpa8/XN8OIs=;
 b=g9a4pRKJ2h4cW/EEw0IHtME4wnOcdtkob1cNE5h/bgaH0cxbyGLejXFPbpYIgUtmP44SqMKqHiwryWY2DnbEz7neGfWhwMsDjiZf1Mvbt38SAahAaJUzH+kaZmruB9PMtvor7D+2V3Q0Ra03+WT05DmUb3Hq3wVLQ7QteWOXSIkpGes+gTHOzf5lF7G/6rsIn9AFsWP/UKylNhD1Hfs3JjrE2Z6P/Zsqx4As/0RasYCd0MFG800lu7T9hQlw9JwuuldDWouSvS5YM0aIr4rJnKeu3C/f3hnm63CcraLvrn9loO+mJda+AG7cDRNyTEcEIVxKK6XQj3gtUwPWM/3pHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbENv6kA2txGULFvp1X8XkgujQdWnuRujpa8/XN8OIs=;
 b=FFlm1vf8/1G479whXA0Mru8a2KtoFiDyU5kE8yu11iEQPj5wchAWwz68tCYV7dpVu7TMQEdlonszvwac/jDjsxWOo5pQBIvawjjHyqg02CpZVzjoEu+jnLZ81QJqlFiXklhPwq3HI51KlXmBwpv0WeoAZ2jr+FGgiQB1vRvsrFLWH5j3O8UCbR28lFuz2p9YU8m7dwEH8RaGyR8rfN6Gf1JylImX5fnLNixwahXYAq6/XZwC6v0yKyF76SqxSX72pZ35Dc5uHGXBx/bNeJdCxGUyEXvZKv8z0nqlIHkCLPYIs4bGRGOuwoHE/5zfhiFl8X0lQJBL3rOqiTIllY8+3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:07:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:07:07 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v3 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP clock
Date: Tue, 12 Aug 2025 17:46:20 +0800
Message-Id: <20250812094634.489901-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812094634.489901-1-wei.fang@nxp.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: ae681b2f-34d7-427a-fa87-08ddd987fe8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YOeS/4OZxcpGx9eNS7mV3iYqV6r/VWLPgrgvPvXyp6gBeIufxTQF9Tqpm3H2?=
 =?us-ascii?Q?jz7THkoKVLeZp/BBkSflSnjxXhIP+5nQEwR6ZNt0d/q/Wa+K7+z573mUVXtc?=
 =?us-ascii?Q?lwi7DAsILBdaj23ySfF3BekVC/iqQNXeG4DITsLko2ftFdINVnPgQ373Rg2d?=
 =?us-ascii?Q?h5zewOdXkJHdRBqz7PmvHo7YvvZwpMyJ27UDcRAGoKfQQKQG2s5wjzRd3PZG?=
 =?us-ascii?Q?l0MK2vSkX5MtSmNaycbwimnWRbwR1gZEMQlket9KC9Aaeo1FKxCTjOSALPRX?=
 =?us-ascii?Q?y+2BkUJsEqa2if1DiwqdfSf51v8G0KvwtLXHHQd1QOcBWAsKpNQzrsuBB8oH?=
 =?us-ascii?Q?8G+CgYeL7A64bmFVtCAhAnh0orPmKRtt/I+Ii1pBXlAIPpFqH12WTGuyDTZK?=
 =?us-ascii?Q?WUiRUSR7TYmgS/b63DZX/h5fA8uLKtoqj+9Dgp9JPt1ub0D678RqDVF3ChkZ?=
 =?us-ascii?Q?tqlapVU8XCwyClZNXcsKCLHhUYG3raYGl2a3JLsg7VD5srPcSkV77wrII9hR?=
 =?us-ascii?Q?ASnPcjx7cH2Y3PJyH729rWKGB2HnP/sjuddQYMwrLvGgTUdEff1ANp7G6J62?=
 =?us-ascii?Q?BFjxc1yeb9yBMiigZW+Ia6DROf7app26Ss8x2lux0PgT05Gu2s1BV1eDuPf3?=
 =?us-ascii?Q?EL3rWym9hl8Z6SV//zZ9gS5cwWz8rNB/q/Uh+8QbvLXbfq9jObt48EJ0Ww3q?=
 =?us-ascii?Q?fuJ1V2bBHkycdcE8930DUAVkE9Zi4aGqY5L0TQYLevHDq/FtBUAIqL3c0H7M?=
 =?us-ascii?Q?CTQSKCuc6dfDxD4SHnlNhc+m9OtesCPLdspjrSiT0t7nG3BNthWY34YQjP64?=
 =?us-ascii?Q?28ytPtAFp7b22SdVAMrbf1Cn/bDrszk/7GF2UoIpi+6NeBNPBHkAKC1Zf5zB?=
 =?us-ascii?Q?p2ULtb7xVV5iX2tL53XHCVpZ1ud9gHaB3yRAkuNRfiviniVV8wmUuOVB5yFC?=
 =?us-ascii?Q?iZ/OnAg2HZ8DaXl+1dJx3D8DMoWAUdVph4uJMZ3VQ6r5z+O+/GtT0/FEtbxy?=
 =?us-ascii?Q?4h5brSTC/G4dNK0mE5qJWrZabnxCDHBOeoQiEtxnOpyU+aBKdeT9PbF2TQNT?=
 =?us-ascii?Q?AyGr/S7krNgZYo5KXO30DtXiKBrxd2OMD5/p4CxbO52BoXcwRak5l1cQyyZK?=
 =?us-ascii?Q?FzsxrM32CYY7GD2lZt9eIOEHCFL6tyieXUGHQMtNR49ZhgnKF4XdbFD7mwla?=
 =?us-ascii?Q?bdmGkQC+E1p2giKmQhnsbo/KXU3dt/3+aCHmtVJ2D07Tu1HjM86UZj8bdrxI?=
 =?us-ascii?Q?bkbskADza6dEcnKjVy+nUaqRzHY2V6tLDPjwk6Zl4jFkekpSdbHcq1fK6NKa?=
 =?us-ascii?Q?iRYHhe7k8Iz1778r20/L8D7KjcCX3bhuwIGhBJEAhhBO8RoTaqbfqv9Ti2do?=
 =?us-ascii?Q?qjIQXKydhfkhvpjsDMKmWMBE1KhTYIXs4fEIms1L/O47JHpMtwLxcqPKfhtu?=
 =?us-ascii?Q?l8M7zHSbFCblDf76dezgZNlqiFsx3f6d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N45hWR7dEcmg15h3px8lHMG22JzvwXKrl95RDkjwRI1DixlmBZxe5f1x+xkV?=
 =?us-ascii?Q?7ar3ZptS1v9xiUPGvM/4FwvhU7ecHv3XGL5kvLU+lTTVquD9TbhlliRQ3E5q?=
 =?us-ascii?Q?UBVw3N6MNBkzhGsKU3368D5P5ytNE8zLelWtOtr8FoXVZBfChcQYEYQLaxf0?=
 =?us-ascii?Q?DBenaeUL0YDkJtoiLA2nGe9j02Ag6QXQ3F9CkDp5S1uaM2f0WfyEoisIycwu?=
 =?us-ascii?Q?fsSH/oQBjC0TOHYKSJcw4rv2wtQm8YDyWXC1eEKuIxBcGffE5dr9XhhTzTBd?=
 =?us-ascii?Q?sxbmZ3nHZUV78UpbWVzMrb3DRKXwcxXdF6y6vctrI2BQ73nWA0XZ6qsflbKR?=
 =?us-ascii?Q?+uxe3gQt6njl9S4Ku5x0bHkf2JJ9m0f79KvGPOHmN4C+X2zzJA1w5qt3CClB?=
 =?us-ascii?Q?ukDyy/I9AKbzqLFyruSq13u6d0NFjo8gDaSxtCqSEQor69iVnlhAxyW93CzT?=
 =?us-ascii?Q?jWwR3ry1b1W2QKQqkhOo2zdh1KCtnG85/oR2z0qsXBwJoIT8mFLb3Wb85y0j?=
 =?us-ascii?Q?1T9Qs32277z7smDJbu8NV7O5WwI+aHGLBVxRcwd9R/fsWCHUUi6TkdJujjsN?=
 =?us-ascii?Q?17jZuCuKmNqtTm4KySPuStkuxIcn1q09JH4M57iTg3WOV2sr0lx5IetdFmB3?=
 =?us-ascii?Q?xYvzDNOddAdWM/IAWvu8JeIctSptfvVy/VH0CYUNba5ktMJl/4hX5vXxa4f6?=
 =?us-ascii?Q?cxv3SVSMHOKCdxi4l1TKDi2HUqv0l4rukrAvMfbmn9cnAe1vRIyV/5lpc5Vq?=
 =?us-ascii?Q?d/jfeBrME3e5ZYVlmoRIs9hJ+LrqNY3/DZO2zs8Fa2ELZYWG5kKXgocJuWHv?=
 =?us-ascii?Q?WOYPa/kDUv/bV2vtj7y6PQ0/vH/KmU5Lt0jzqd6m9L0BGYtyQsd73RFWKplX?=
 =?us-ascii?Q?mzCnGYu+4vt23m8NTq/7XEYT5wSvKVetX5gcwh8m+R3TjiOzjwvbLGk3MHCr?=
 =?us-ascii?Q?XrHXRrBlj0dGGRgPZ3osE+macUcZxm3pQ8Dg2D2xUyfxb6kJyPHmACEJ6KX7?=
 =?us-ascii?Q?ZZHlk4JY5t/g6untkh9vub9HSCcAEjdA7XZ5nPvQIGAHt00x6r3RiiS0DJN1?=
 =?us-ascii?Q?1Dbwfh0zeZ7l05jqG6aCbzKQBiNinUSAjo2P30HdEy9sDgLTujvB6vyiDIrP?=
 =?us-ascii?Q?S3vrvUrU9VUp10Ms2f1avzTnj+lC9L/aylZ6ccernNadIm5W9uo/j+2fwtBK?=
 =?us-ascii?Q?dco6boDosDdBExt/NTtBPq18M/QEoAvz97Cy8Y/DSGpZRZBQIGgjszQpD74+?=
 =?us-ascii?Q?PfS95hGXu4Pxhconyz0HlkEtxS9k9xzZef2OA5sM2H/iT6dnrIuT37CTrPwB?=
 =?us-ascii?Q?hwZV6750QITQgFNXUoUdERWxLv9qCDQH7/XOnvqy3iAlLIcW8f2bdVXl2Z0w?=
 =?us-ascii?Q?bOZkMR+4xZ9T5J3A/62/2ISFvea1M6mrAQMUFg4zSbU1uCfZYCndrZMZp/Yt?=
 =?us-ascii?Q?MY33BXQjmd2PmWQ/CjdYm72ictCfoiIn2RW9xbrFAkWvZAzXOGFtpuQWe4/6?=
 =?us-ascii?Q?3rNrtoRf8G9Lsd/KfHfs0p2ZxaMmHuhwzh/id8B7yeHYBMQcsqFgjk6YT/Ci?=
 =?us-ascii?Q?x5It9hSzYNEKNGrnVgmh7ulAppLu8ZfTO2470vDy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae681b2f-34d7-427a-fa87-08ddd987fe8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:07:07.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/whVKCTMhnKp9btT6jL0FAu7vOQPt5YB+pwmJRCF8uX0sOlmeiaw+QU5PUxVSsKHuNJmRxYs9z2JieNye3kug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
Integrated Endpoint (RCiEP), the Timer is one of its functions which
provides current time with nanosecond resolution, precise periodic
pulse, pulse on timeout (alarm), and time capture on external pulse
support. And also supports time synchronization as required for IEEE
1588 and IEEE 802.1AS-2020. So add device tree binding doc for the
PTP clock based on NETC Timer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Refine the subject and the commit message
2. Remove "nxp,pps-channel"
3. Add description to "clocks" and "clock-names"
v3 changes:
1. Remove the "system" clock from clock-names
---
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml

diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
new file mode 100644
index 000000000000..60fb2513fd76
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ptp/nxp,ptp-netc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP NETC V4 Timer PTP clock
+
+description:
+  NETC V4 Timer provides current time with nanosecond resolution, precise
+  periodic pulse, pulse on timeout (alarm), and time capture on external
+  pulse support. And it supports time synchronization as required for
+  IEEE 1588 and IEEE 802.1AS-2020.
+
+maintainers:
+  - Wei Fang <wei.fang@nxp.com>
+  - Clark Wang <xiaoning.wang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - pci1131,ee02
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      The reference clock of NETC Timer, if not present, indicates that
+      the system clock of NETC IP is selected as the reference clock.
+
+  clock-names:
+    description:
+      The "ccm_timer" means the reference clock comes from CCM of SoC.
+      The "ext_1588" means the reference clock comes from external IO
+      pins.
+    enum:
+      - ccm_timer
+      - ext_1588
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/pci/pci-device.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        ethernet@18,0 {
+            compatible = "pci1131,ee02";
+            reg = <0x00c000 0 0 0 0>;
+            clocks = <&scmi_clk 18>;
+            clock-names = "ccm_timer";
+        };
+    };
-- 
2.34.1


