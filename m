Return-Path: <netdev+bounces-217172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50684B37AE5
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECA63BD5EB
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A64E31354C;
	Wed, 27 Aug 2025 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MbKvtu4C"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8526313544;
	Wed, 27 Aug 2025 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277698; cv=fail; b=hUBlhWOs0C/J2oj7eClFAH3ULMXmHGv81IwhLb+ELEp7CoWAnC8DNm00gtbX1VognxOQiOzk/mlTLVIUE3m+/bVe1qs2y44iLt28gPgm2lVC1vpBnJ302AOtCpVfvAheR23gGryvI3JoOeEsy6uCG/ES1Hr/AKKHz3JDuwlcBo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277698; c=relaxed/simple;
	bh=byAcckbhewxW43rKxIXB24zY8xoBLEioN/Tp6NTgX7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=psZrAmMFXpgpZ9iC/HfW5J3JPdZg8w8zwdsKWYQJuYET2XScE829YBx456WlrdM+SsYcWKSPtZ8tfh8sRwdbCzFRD+IZZB2ITrteT7R59elm1cFjqaVbkeMr/Jf5eOyj0gqfc92j+qHtgFTkkweFhHnqGbxmxrPRPJt9qDUlvdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MbKvtu4C; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUg1utBZCU/1l1k+p0hM+8hEsowMjGzU242O6QKn5H5gPgDR/zhnwGGpSNIoQjAvpszBgSt2TShXcW4wp8YQM4m3nh5q1iAgToG50BVLl141Meyj+dFTbVpaEmRT5yF+9uBH2M34u8DUkhRpL7ZxP+ITM0Z1LdGfyN+9R8sJQPp2RtXKpLCQN13+ORAcOluYgXoV59iYX3yGLN45Dkt0xt/AmM6sNUhRMuywTmFldom4Zm1gcGWUMBarGLFMF38NLK9Hrw4SXDo5oMi84BYLxzP0vVtOKvRWMGR1Exf817XTs8cxsjliqylX0LxPx/jK6DOI7vKY4YGnsMNzkw8QRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nzzu6CRK1RxCRWKP6nOwDaApIKtp4FreJgb64d0fAao=;
 b=BpI2U4WlLRFlMOI93xUDrbii6KqbWI/DCfM88HCmgD0LZmL5ch264l0mLZO2sxnkiTM714UqhqcgW8LLtMEkp9rEing2BPJ7hN3FozOvFeY4GgIu0QM2jr5s+iLXW/yDGMRxCdj2oToUqf3frN/3Nwub98RKFsMlJCNq7yfUHV/VUSWCMdLjF3D2WdXVsrxsoRdfI/3/uvzTRmGkSFlEji6XAbfge8ZGxmtup8m1Cm1Hx5bUN+YAFABJSzhDEMLHl+CfC5WNkMS9dYwCxIxnZ/nKipX06vOH2vUFpXCZxaliq5ZNuJ+jXfS3zW7axg/CbR2LvL3n4rMWaHwbzNLQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nzzu6CRK1RxCRWKP6nOwDaApIKtp4FreJgb64d0fAao=;
 b=MbKvtu4CnGV5qSnFsUCovSvqieRjJZpEINrBuzSsUec0ASQpEm3piJutiHfftfZHiSocYRLmvElSYcNVBZ+XvARu6v7v+/auExn/BjJMwujb4yIJbiSnNL2+aCl+73Tbm5mFRt2kOVq0AG1oM/sU3SlGuBxQQMfPZJ1Y+Ttf3U2UHmPZ+xW8X6x+KZj5t+aPlCcRQaNi1jo7HTbyuO9312Q/BtsDl/MrEP1w7EY0RqFbYsqcx9IDwzkSs4CHGfxD2ZxPcF6FKgcGW8oRPD5ZLGPTk1n0nTe/jwx5Cvd5a76+bZXZXoqOQn21s5IdwNqUMmBwt0G/OD0WnZcPyLp7lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 06:54:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:54:51 +0000
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
Subject: [PATCH v6 net-next 00/17] Add NETC Timer PTP driver and add PTP support for i.MX95
Date: Wed, 27 Aug 2025 14:33:15 +0800
Message-Id: <20250827063332.1217664-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1454c9-e6a6-4a62-c986-08dde5369ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hlAQGkmeC0FOCikHEUV5zlUTNkxif7h5Q9++uzbVLpLkI4G3NM9iASCJ6fLM?=
 =?us-ascii?Q?H9n24LimX4EosjJYmExrD1SX4bdevUW5XqyvdCSmSyvOaw/G4KxrwNZvyRcl?=
 =?us-ascii?Q?1d2geMwSt1bWcU5VGEiPnX5mLcBtjQVh38RBGyniR0w8Go+X2ZdixpxxXk9g?=
 =?us-ascii?Q?14xS0Hf3vys3HuI69IsT5Lc9nf1/8Jul+Xa1ACKfPb4HQuis/PGMsznKh8Kn?=
 =?us-ascii?Q?UVaQVuJMEkWI6wBUicBeEK3e7UmZb7DaDHwLUEhk7OiZeDbutCPVKhAYTWaC?=
 =?us-ascii?Q?VMBB09icDnXX3osrS0bzT5KDGKHr0YAJXMsXIfatxUZKjEX0XJ4vR49WtxJo?=
 =?us-ascii?Q?BR3ssF6rIqdvp/VAq825EzFwvhgq0HS/Rh2f9cQAsPF54fz5KiYvE2GHwpH2?=
 =?us-ascii?Q?Z6kbz3p3vfbp3/8qtiPoKU5x9T0sAbXXb4TuJtd0XF5EfYnQcJI/YlesEZCY?=
 =?us-ascii?Q?6OvUDnb/tV4WkyqiOY41yUGom1BaV3Mj3kxzUrOEgA0rZSMpprwTvsDAabms?=
 =?us-ascii?Q?M2XCBsIMiJ5taB6PVBRg/MTLJJ66tN7WLHPPxkX7dUYTIcHT3ppRjzyQU/tw?=
 =?us-ascii?Q?vBQHE0TpZjVyyl2TiPfLyg1ZFwcL3zxBBXu1//Wwj2Ie7LKmkkcmoLA68okb?=
 =?us-ascii?Q?dKZUzQmXvk8uNVFGu42qyJF2p4CqswqfebbxAhgGAYcctgl8oHJ9SLweDn0w?=
 =?us-ascii?Q?2x4aUu1Ei85M1tpbCr4elrI5v13rNTXNaUq2o78TL8et7N6jbCrYzB0EJROJ?=
 =?us-ascii?Q?n+3KkZTj4nb81OFAedb5hswvdqh2syzxL/2bW83UsauB2Pj2wFiox5CYVhVG?=
 =?us-ascii?Q?PXhnf2Torl90p9HxhfWnTux959vrLxRAjSiq50lPFeV5U/94tMre7dmOWRRK?=
 =?us-ascii?Q?jO47vu70KTVgw+42uzY7vFe21tD8of+vVxH6DdEF1TrYdjEiNHjf3jUO0yFB?=
 =?us-ascii?Q?Unt2Fg7kIe37PLQHbqkxi9nS2r8MvniO5llOl0znLMjGT6M49Iersdz9rtg2?=
 =?us-ascii?Q?nBq1uccJIBjZa0vbr37sYMhHfhzuEWzuQqs+7mhXULqOJcD6/4RulMZ1rdEj?=
 =?us-ascii?Q?26atchhRk+w+1YEjaTMpKi/thcF4LI8K7MHM0hq8qwBtVSBMVxcIq6f6Kif0?=
 =?us-ascii?Q?JBdYgpv5STKo/f8fNyyir01zf8NJVBHzY02fJnXc1guHy9QUrrCBF9foHE6N?=
 =?us-ascii?Q?2g3o7kNTCXz6u49VDnQUEjj6KDYiHkRQo84KJHrvP7AHtroc5sb3cjUuI0w+?=
 =?us-ascii?Q?bEjdG70SQ9t5Quw59QFOei9WzjyqaxrCnesdowIeJk3lTSPyOyO8Mop/zXjK?=
 =?us-ascii?Q?O8GMgUYAs4c/I5veumhbIJy7DtFPYtvWQO+kR1d5uyX+LlSrPtY0th+qzJcd?=
 =?us-ascii?Q?dicPl73MyDNmRyf7gz/OKeSK3HTuytlSl5AXLrKrKQmS+OccW8qMzrcc9/bt?=
 =?us-ascii?Q?GIQ44kBca9V/HRiF7Yk/l3Byy6jGcmnMRCiKUtnCLHG+2yHEgXtOmjJYEPes?=
 =?us-ascii?Q?ml4Vod419YKVPJZOHUALhTj0x5mMj+qKsOcm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AZevyD56V7Q2JORW+RNTz4eUovwY8bCfwUEkcOLhtwg6ERn7osTxw9Ttun1d?=
 =?us-ascii?Q?E3ZWcRaWpd1FdK1PKCETkMNXbMbhfmCC3h1ik3gF6tt721NbAnEcawBH6PAZ?=
 =?us-ascii?Q?TBNf448b8dNDyc4yc7dGqYuh8eJ3Di0WbbRCNCcLO2j0Ou/EdIOUEoJSxp7V?=
 =?us-ascii?Q?2FsbyMW8D3kgavpFYj3Rnt4edMyTLftikugDj7wsUlskaoPzanJUbvr0bpx0?=
 =?us-ascii?Q?c08cVzgPr2y83AN08fN03yxp+7vJbJiiy9z4bqKUAIR0KSWK4ZNvg2JFZyvs?=
 =?us-ascii?Q?bpTqhuZamUcfKCM2wLhUUJhK0gvQYUBKjntrf0jKfiVYc5vBmbwU5rx//lBf?=
 =?us-ascii?Q?Fuyj2k6lO9MfvAnYSRqxdZX8IfU3R6/7XYK0ss0fyNPR1p230N/ia6auUKbu?=
 =?us-ascii?Q?Is3/hLtVy/AowwjDRJFEPWG3Ypby/f9VZp8I3etY5rgcmIlkLzuL12uGIkLz?=
 =?us-ascii?Q?WWIyABK0E0uccMTEsunQ9qTT2j3akZQSIr/mWh8PmUs5KZME7/ooEZ3EnL1h?=
 =?us-ascii?Q?cxQbVD4aH9a8DuBCxy4nsfrlp8QHZQKaHEEell2uK2aEI1YmLTxEz2/UlWUZ?=
 =?us-ascii?Q?q4TvJ5dfLaYTynxQK78tFTb6s8hSKzvwZA+rMDgvCMvkoKaQNir3gLow8ITd?=
 =?us-ascii?Q?U+1aj24y0CEPPsHELEIr3qfRnozYpqFpsTQVpjM08NDs0I5djUvfMIjIt3/e?=
 =?us-ascii?Q?7bcTZ0+1VJu+rL9Q6vLTBVCi08aNy1un5TZGD6yFeV0dDbGRo6pPqIC74SIl?=
 =?us-ascii?Q?KgIPgov0T1MWbMKQmNy8gVg9yXVCltFIwbj/hd0lLnwopgGjIqjXrUxW276v?=
 =?us-ascii?Q?PTstjrNWnen/caIfc/TKZoXvuH8hKgOYmlwqGHQG4G6rEQnDOgR9IAcTQ+QB?=
 =?us-ascii?Q?RgGbZOGIBQ+Iu0nmQ1cZC3pwLell8LSHir4CNNgo38RknzQmqMSXp/4joY2y?=
 =?us-ascii?Q?CzL7WPgGzNNe4y4EeXghW/lPOvnr1j+NzApN6A8zj/lKaGzQkz3iS5NgtA1p?=
 =?us-ascii?Q?/rOUSASwkRRU5YiFkTkw/bPGy3OXoD7LeH/RfyBWNQJz8uA8opGTvDyyJQn7?=
 =?us-ascii?Q?Zwj7KKp6axtqoVFPtCdUv5pS+QjamHHRc+jys2e2SBk7NmoY14K0YYMYrxpJ?=
 =?us-ascii?Q?Y7QVwl9YXZmGnV1lxHn7PmvIuAUSwUXE6N0wDzCUDoIVA3kjH6GozVtiGMEn?=
 =?us-ascii?Q?0sGMhZrvzI0aWV6+jvbounUtM898sFn6zJY2ZbDnuU9Mi7WhJifHJZJ9X5GH?=
 =?us-ascii?Q?r+wnZ66pfbmjw8T9CqaCyd3AERGln5lUvyUacRpJsVabuiSI5c0EKWgBGSZ6?=
 =?us-ascii?Q?vg5jCHHCCFfRtSc1SWD3CF3E4K7pCkMiocWNEtlsXoj8Rg/Go27gJ6pzh8Mu?=
 =?us-ascii?Q?2H0stuWlhMTXGaowxoXqihZIgJiEVKtRer3LmtRNpkjwDKhP1KBxAhTbn5Nc?=
 =?us-ascii?Q?SVll5dg+fUOgrX/Hg4+t7C8WfxN8GhzozVNcNWXvIH9q1W61qSeF6tjc3jL9?=
 =?us-ascii?Q?6j7fs3GMPMgJKZw189MvZXt3uOwYYNH+6Xjb1eBNDk2dcTM7ROlhhbrxMGkP?=
 =?us-ascii?Q?KUgSjMhkV5zgQIxP5hNbgIwkV8QDqHnTKzKX9AW/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1454c9-e6a6-4a62-c986-08dde5369ea0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:54:51.1346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SGhx/K6URbbPm05CwYUc6LADSmd0i1XgY3qiF4q6J321x+kiYtIFK3Sgi1Lz/R+MKANU0YXWqbPbwykSJ0juQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

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
---

F.S. Peng (1):
  ptp: netc: add external trigger stamp support

Wei Fang (16):
  dt-bindings: ptp: add NETC Timer PTP clock
  dt-bindings: net: move ptp-timer property to ethernet-controller.yaml
  ptp: add helpers to get the phc_index by of_node or dev
  ptp: add debugfs interfaces to loop back the periodic output signal
  ptp: netc: add NETC V4 Timer PTP driver support
  ptp: netc: add PTP_CLK_REQ_PPS support
  ptp: netc: add periodic pulse output support
  ptp: netc: add the periodic output signal loopback support
  MAINTAINERS: add NETC Timer PTP clock driver section
  net: enetc: save the parsed information of PTP packet to skb->cb
  net: enetc: extract enetc_update_ptp_sync_msg() to handle PTP Sync
    packets
  net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
  net: enetc: move sync packet modification before dma_map_single()
  net: enetc: add PTP synchronization support for ENETC v4
  net: enetc: don't update sync packet checksum if checksum offload is
    used
  arm64: dts: imx95: add standard PCI device compatible string to NETC
    Timer

 .../bindings/net/ethernet-controller.yaml     |    5 +
 .../bindings/net/fsl,fman-dtsec.yaml          |    4 -
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml |   63 +
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/freescale/imx95.dtsi      |    1 +
 drivers/net/ethernet/freescale/enetc/Kconfig  |    3 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  209 ++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |   21 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |    6 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |    3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   91 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |    1 +
 drivers/ptp/Kconfig                           |   11 +
 drivers/ptp/Makefile                          |    1 +
 drivers/ptp/ptp_clock.c                       |  119 ++
 drivers/ptp/ptp_netc.c                        | 1042 +++++++++++++++++
 include/linux/ptp_clock_kernel.h              |   32 +
 17 files changed, 1516 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
 create mode 100644 drivers/ptp/ptp_netc.c

-- 
2.34.1


