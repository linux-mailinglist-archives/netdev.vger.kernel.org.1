Return-Path: <netdev+bounces-218107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD09B3B265
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02A8688A11
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904972153D8;
	Fri, 29 Aug 2025 05:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H3CT6Emk"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CAA1F55FA;
	Fri, 29 Aug 2025 05:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445237; cv=fail; b=sfLBzW97bGLFHEoj9/Gm2UyetYMojtfYypQTh8qy09Eg/TCmOQcJmKdf0YsZbHJD6i2Ujtmy8/Suf4rICOiaFtDqP0mfXK2n1wXWEgtrCK6RuP1u17BSmo8bjcQsycPjvpbgS1chKzq5aa9l8Szl5Mw0VKWGRVr6+X8v80hnajw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445237; c=relaxed/simple;
	bh=ySIijxO/WHAujUaBQqP6eKaMjYvwbkCU6Y3Ur6cxtoA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hhlUVAFvGv61OiMvaZ0Mz4QZ4lQbk3+BSv7kAXpS4NxQmdG/vceHz6lVyHCWjBx12wiMBeb8pPX+HRrYI19sj5brAYa4dgvJXF/VXRMiicw1lPUBvUsgu5wszifWN1QfbHnjpzoERpp9oF7FmZtJ/pMxH0jE/cqPmdhrFRCGERI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H3CT6Emk; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8N/HAEwbfiHXYC1vvrog0bHvagJJmAsweHoeLoL30eWWsHurBD37YO0XKnXnfnQEFOQ0nhpnbYr1naoNfyqaiAYxmcNn2xIEDZ8T52jxeEDjlB/yoe49kPrtOux78g+fg/a4Q3dOLZHvkZhvtYtEJF4jDBFuezROhOMxvUyQPEkduMJCHcQSOSx+CW1V5qazjf8WF/6ddKgUtQ586vlWvWXo70ztQNI/JlYy7Q45BX0akdjEkVnge/lhfjPTTmLluJ6ZpzH+XnGsh55c4T+B/CyGnPUno/LKniRtxdip9oCmezNFpMMz2hwfxtfavt8/kLaEL5h6RL6iEk4v+h1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIsq2uZrgoAQaFWpUgIOCT1br5QZ1cO+pwSkv9urkfc=;
 b=pJIiYvnsGv/Qqp8/cVgfxNM08QTqo2T27DTxETRH/c0jc15Lunny1pmz+5PnHRytrvmVj0u5EPYyzPGXLdKl0pfEiS5/+/t8Ve9Hzq1MHe9TxjEKDKp+HXtGN+4Bt2qv+J+3Se9tWLuWMAvvUlXuK/W+UE2aCiy4JARFe82KZRXpnN0Rhi4IZmRkoa58dd/DYR5JtdxLemPNAg2Dqsnk619ktbzynoR8B6FQp5UStiYpm6t8Y7jJ+7jBmb4x4J7r81/G4EIqC65AgswzOCaRUhuqMLjNrCXU6etanYOh9/Yg9+H6uxSgOV2ue7S8KV2gOyN4tUg6XeX6xrxPkK9flQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIsq2uZrgoAQaFWpUgIOCT1br5QZ1cO+pwSkv9urkfc=;
 b=H3CT6Emk67HI04yJoH8AP/8RZ5ABsbZDlO7sk45gPdJnUTYt5rgRE8cNBeKhxsSaT4BzcuXRV6rtayQ8kmA0BlpfMTkKpsCwM8g1ShQfL5zI1QDp4iUcn/qoZDaV9wm2Qu82PAvIW1VgQr/RzYS0JFZXU8s93dyLzrrIgpJxS/go8FBMLgyiRe7Wd09MtUNd0GpzD5Sj3orOGmrnMz2aGLUA94nagXXEfSYyzo8iGaXH1GRqikZX4HJ0ukzIOci9Q9WEKr/quZVTdEaB27xDiV3EXjedYqzqDn8mCevURlJmWrfYbVkSRWkSwxa6Suwj9QSMOWk7YyjqeG9DpLcC4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:27:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:27:11 +0000
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
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 00/14] Add NETC Timer PTP driver and add PTP support for i.MX95
Date: Fri, 29 Aug 2025 13:06:01 +0800
Message-Id: <20250829050615.1247468-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: bf500ac6-8b38-48a5-65c4-08dde6bcb45f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+i9umBJjZ3Mhkrh3Rp5zudDGgxBOITvJr6xfZdSdDkP2iY7IEbAUe0mP6Qcm?=
 =?us-ascii?Q?EL3gl7LYr6e8AqjqJ/zt57sps9ItC4c26ueSNBl1aaWbzn5rRDqroAEQB2mL?=
 =?us-ascii?Q?X2a51hqssOSF3GURkv8DriZqjgGQCZYF4Uh7O4hdRFiP7wnCyPECBY6hie9H?=
 =?us-ascii?Q?3I6y9ce/kBQliyVKR8jXQEux37+mcHpWBdGqe+LcofKIpJyOZkLiwszJZR4z?=
 =?us-ascii?Q?ZzyxW/ACIL43fAhmuBZaF8/c0U7umqGCIe3RJgJk8spSEQF5aXWYv/e8J/7g?=
 =?us-ascii?Q?2GqmADJVjLGXOrJhcsnxPEn4mZRSMTVL9eVDpiIaCQrIpoxu/AXEHx46V3Pf?=
 =?us-ascii?Q?2/BA/C6iKQqQIxyVKirfX7E4QsBNVn/BQe/F0OmPxjHKCvd5ZMXjNsNdJncE?=
 =?us-ascii?Q?PomsLVufJF2yxX5v8Tj4lVJ599322C6f4L1xtUo16RDMr30sP8MX2ZDNqqL/?=
 =?us-ascii?Q?A+ab+9mydtUvJihJkKK2JtLXe3i9ugUYBUMfQzn9nvg6wVWSNrk3HnzkIabV?=
 =?us-ascii?Q?2jWxSYvu2SNuUWDQfVKTUriMfnEOl+Z3VeJdDoCq2VaGdXqjcIE/vEa+8MTO?=
 =?us-ascii?Q?2ZNao9uxuWurq/bv7w20XVOPns6R0VoKjRkCYGaXe4KJlIl8Xhba89d/IIKa?=
 =?us-ascii?Q?ChIDPOEDQ9LoNdhKLrXoxfCdr7Zq47VUDMbYlElN69R+umYxape0VY2iYcYQ?=
 =?us-ascii?Q?FC8gEGLs3/EL3BXlkKuz42Rxjd1DKbhO1rxzG9EdxG0NHG9aDV5HpTAqYIqO?=
 =?us-ascii?Q?/3nuMfRQTLScSYvxN7wQF40wdurzQb418Tpgs/HDmPmxlMUnZ0T+NuU+PdyL?=
 =?us-ascii?Q?2FgSiS9PWYozIkELNc9T3m7oDnVHv9IsShNKEMOvpw1KS2aIIcGf/e7lBj5Q?=
 =?us-ascii?Q?n6vCfC0TIuj7wKRTggwxl0z9U7l88F/fnUGdvgFF3D9+dL+18Cp+OiQj4VY/?=
 =?us-ascii?Q?pg+EWAMrhz9m5l/PS6MjJrrIZ9VOVgimpcwrUFzEw2mxwCBKdb4FNm/j0ICo?=
 =?us-ascii?Q?tDwZJemHsi6qB+8b5vVOO8Z6CB0KeRJTqc0lBstofGyhWODsEM9kG2ATiZC7?=
 =?us-ascii?Q?sT/TK4jCNlGXzSvgoF/kXgaBx/Ike1WHpEgqVq10u4048TWlxrBw2JvTCZj5?=
 =?us-ascii?Q?FV06tcmRoXeNj8Ww3RCcQ51z2tGIFm6L4X9y6W4Hs783pTRglwyvjzWwGh7o?=
 =?us-ascii?Q?PtfFHipfSoxa6tYioKRZy6jkzFvx/7mT/+5GcqSkCfdDnrDXfj+hR9zSrCh8?=
 =?us-ascii?Q?nzaKvs5omY5rntZ9HS2q8cPbQcD9NZ+JNxbY3Xtji8ADTCzSo2OKKQq3buzs?=
 =?us-ascii?Q?dW1oiYcVo87g54FkzbePRj3XWRnyuTJvkuQQ0/MOEeotXhM1DGjjaL2qITab?=
 =?us-ascii?Q?D/qfori/aTGbbRogeQygIPe5zDIyAVoL1QwXiKeWtQK2QeQlWLymzlTk4JL2?=
 =?us-ascii?Q?KqsKAzlRejBYRNJZOAAAPVP/Omc/UcvzNGnAOYGsyyOEyl61QmFMk+XMDFY/?=
 =?us-ascii?Q?xFz9950tvhV8JdhC6NO7NMPP0DB2//poxN2m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cIcX2jmdmL4EwPScJrCsm16j6RaBzO5C9p9eioPKAL45dWV5hnNHnUOH/sRB?=
 =?us-ascii?Q?Ic9WYyoiARku9+OQp/j0g191aeGr3uyvfjWV0dGDlMY+u2tfqmyGuJGXiM30?=
 =?us-ascii?Q?Rz/KELe7qYgCh+azUs2Hy5Wb5E2ZylqdySQeK4MEX3Np5/X2TwJnANOmyi4j?=
 =?us-ascii?Q?Mmf56KWLghnlyU9rBCiiN/3KqU1tsIddParyi0ZZMYEx0W0AjXgigZSlklEN?=
 =?us-ascii?Q?M93Ve0tBfizkG31owkRFHIbeBkJgptVCPAS/hh2SfzPxsUeluf9V94Eh4dw5?=
 =?us-ascii?Q?tsyZcbUdMWTb3LMf67aqsgNGMjcQZQNVCpf0h4fMsrZTI6Um3ujInKGK/HP9?=
 =?us-ascii?Q?18GVCH1A3+8AoWiOCTrrwvl3pbkD8SH9FaKi9IKvLaYIFJVBXE+uSL/B+uSk?=
 =?us-ascii?Q?qsv+8PGiXnemn5WaBs1j7ZT6kH7oY/Vgm5XQUeANb9Suie0mFXZOgBgS5Wa3?=
 =?us-ascii?Q?DgLP2G5UwEIKAzPLE1Mbuve2KB77BlxgP3HVWAUxhuD1LlXrr8klcn7I/Aeo?=
 =?us-ascii?Q?eU7vhsrxU0M5Q59g6OnuN/a8ldTDB1u2Hu5mbfavbQPFBsFjViXpsTs0bf3C?=
 =?us-ascii?Q?TukwPM1UkM1L48wc9QiGufPnAuCBGuVxQqLiCue7thkiVYIYF6cv/Fj3thQM?=
 =?us-ascii?Q?e+Y3N/rxzY9NcGHivGSvKagwrEF2d9wJwaj4eGR27yWKPBLMa0diebwbctsX?=
 =?us-ascii?Q?AR8C+8XzITepgcRWyHlfVDxVfP+18nEA2mqBcyNatHmYN+Sycmt4hm4sG1bW?=
 =?us-ascii?Q?wZo85grAbSaMNPlUV2meXz2LcyZqye4hnqupYWJrGUezLspuhPXswtOVY9jR?=
 =?us-ascii?Q?G8Zi+T+98g0Ebq5HOBxZhnD0H33wVORIdbeEjLdT4j0YdyCVJQ1aoeDb0YQd?=
 =?us-ascii?Q?wWDmOMjyp1FBt0Oxd5+LgimEUu5u6Z61gG/43Icr1TTUEdMZst+ompWELe86?=
 =?us-ascii?Q?CS0uQL57PHV2Okfa3N6KXyEv0JeyxAVBWDo1xUaY8YolUB0mIUvfns6tjfx7?=
 =?us-ascii?Q?Y7Mx2MsfDagFMSB6qOT+oPuHepS5v7Op3rbBKwEAcbdnNtFe0vM+qrZTcVjK?=
 =?us-ascii?Q?aan3gk/Nfod0YAMEnS480cD51movgz/qSFR6krHzPZU7KPXb57pJGZuTLLz5?=
 =?us-ascii?Q?Sl+Ad/NEL3hf91sMSqV+panC4VuOl7MW95x05diOMZlz76OP8mJdfaFhRwP8?=
 =?us-ascii?Q?J2yueEGZ6uYjSNAl/HhY4GQYlPRJGEl4oSqITIyoY6w3xle4DEQHS9eRvVd5?=
 =?us-ascii?Q?yDlokFf+mQpRYlujSwtr7ub0pQXR2puCyLkaHrsBShUydEm5qMbvclIdTnCG?=
 =?us-ascii?Q?rPwM1uymUsKqEPxm0qiWyqGzOcZ2x4dEcHbhN6M/GBAjNaJv9Pd6rmiD30ff?=
 =?us-ascii?Q?HaRgNIC2ohcEd5mZq6YkvmI+tixmSKZXZv92K2QBqHfsvB7GvOqqSG8OdhWm?=
 =?us-ascii?Q?jSNBm3Hn4I3I9VYK/9jl79C7SmhDcxmgJ17TyICOtVGPjVNxmLn/X+YTWFJT?=
 =?us-ascii?Q?D4Xka2gEWff4utQG8o2Q6xS2SflTDLUQsdviKxI/NUemdpAAEmQWzaCtr3Jb?=
 =?us-ascii?Q?O9X0hsdgt8e+BST8a5oVT0FphfkMi/4z2+ytF5ca?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf500ac6-8b38-48a5-65c4-08dde6bcb45f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:27:11.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTfaka2tkx/i9fhdcNZpVGjCtq8aYgerKADbmR5YXGwBRzOz1VM/BLQBsX6XnQkkz3ZeT4OLsOaqkQo1IKOxHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

This series adds NETC Timer PTP clock driver, which supports precise
periodic pulse, time capture on external pulse and PTP synchronization.
It also adds PTP support to the enetc v4 driver for i.MX95 and optimizes
the PTP-related code in the enetc driver.

---
v1 link: https://lore.kernel.org/imx/20250711065748.250159-1-wei.fang@nxp.com/
v2 link: https://lore.kernel.org/imx/20250716073111.367382-1-wei.fang@nxp.com/
v3 link: https://lore.kernel.org/imx/20250812094634.489901-1-wei.fang@nxp.com/
v4 link: https://lore.kernel.org/imx/20250819123620.916637-1-wei.fang@nxp.com/
v5 link: https://lore.kernel.org/imx/20250825041532.1067315-1-wei.fang@nxp.com/
v6 link: https://lore.kernel.org/imx/20250827063332.1217664-1-wei.fang@nxp.com/
---

F.S. Peng (1):
  ptp: netc: add external trigger stamp support

Wei Fang (13):
  dt-bindings: ptp: add NETC Timer PTP clock
  dt-bindings: net: move ptp-timer property to ethernet-controller.yaml
  ptp: add helpers to get the phc_index by of_node or dev
  ptp: netc: add NETC V4 Timer PTP driver support
  ptp: netc: add PTP_CLK_REQ_PPS support
  ptp: netc: add periodic pulse output support
  MAINTAINERS: add NETC Timer PTP clock driver section
  net: enetc: save the parsed information of PTP packet to skb->cb
  net: enetc: extract enetc_update_ptp_sync_msg() to handle PTP Sync
    packets
  net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
  net: enetc: move sync packet modification before dma_map_single()
  net: enetc: add PTP synchronization support for ENETC v4
  net: enetc: don't update sync packet checksum if checksum offload is
    used

 .../bindings/net/ethernet-controller.yaml     |    5 +
 .../bindings/net/fsl,fman-dtsec.yaml          |    4 -
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml |   63 +
 MAINTAINERS                                   |    9 +
 drivers/net/ethernet/freescale/enetc/Kconfig  |    3 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  209 ++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |   21 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |    6 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |    3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   91 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |    1 +
 drivers/ptp/Kconfig                           |   11 +
 drivers/ptp/Makefile                          |    1 +
 drivers/ptp/ptp_clock.c                       |   53 +
 drivers/ptp/ptp_netc.c                        | 1017 +++++++++++++++++
 include/linux/ptp_clock_kernel.h              |   22 +
 16 files changed, 1414 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
 create mode 100644 drivers/ptp/ptp_netc.c

-- 
2.34.1


