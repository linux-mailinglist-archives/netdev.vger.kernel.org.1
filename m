Return-Path: <netdev+bounces-207398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 960B9B06FA6
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C911AA1735
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0268298990;
	Wed, 16 Jul 2025 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XOHBI2mt"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEFF28EA4D;
	Wed, 16 Jul 2025 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652352; cv=fail; b=O8EoanvQ97mokFTa56ItpLEFmrwvnpvchUee13tEAO+gcfyQ/jL8/NzYjoIicwTq3S2TFbPYwj+z+8dzOoZGrBQ0r5Ggh1siwV1VKUpqJwS3eZaFNthpBjqoRJZWNWgXT8aif7rpPJi4WLljHXZ4j7n7MLxvex9O8O8uMgPBpks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652352; c=relaxed/simple;
	bh=dPJcHBSqRGHa5Gwe19To0sRqqvQwzv91rbVYYuUWWRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qmurq/LwA32Z1diWTUDoSf7mjEf6IKdUbOsfSs/oiQ9YJUbcNYSlUgWi0spmrrRBNxXCHjD9uvSrqu1/sAgTAdOqrKXDN/TUprbTgNIFy/9RvclqVfSGALo9ViGbzVvA3pwOsVtpqBI0IPGNmBB2h4OMt15sUsam2LdNkazDq8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XOHBI2mt; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZUWEFhldRlFpQxPIVVkuXH7iHshl0GRRSF2gdE7f0ymMiLnIx9VCx5ohGEQ/yf91QYwoUMGpS1fIn9n2/9G2kStjwT5UiMLWMm2Pn8gbZEiXOX1FntGrAcBfp5FLeEwiHoI2gNjL3uHj6dZZDPed9RLYm9am6vUWQ9Uz8kv36Pj85HU0oLUmzuowzaLrMM/uD6xCG4iMmXoQVeqUpnlA2wUkABcItzpt5MwxU5kqyUs2cTi8aM1rHXL+JUaU2N85h1PAqnzS1HA3RD/3wOjkhrSJEeGboitOKYSGngQyqNN/ROPzLFB6eoYMAkCUBik2l35R/WGil/1YqM0ohSyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41D+a2iTH/mbybIR8zGqfLwjfhHRxLd5eMlgt0hlH3k=;
 b=o1/uXFQfomvwk797YzHAkrSSHVYwsZatyCKr9+SZAF5qcnJtWjKdmeayTf7t4JjqYVyCPsrls5DD4SQepSsrW4oYsU9B1ZO2QNRXRsjcEXRTC5AOwp/zXdsabvePQzwMI0K015Q9TJskkdYan88oMhNUmkTmy7NmCTWdirJxTdXnuEY3b1wZhrOOtjSQCFE2kqSgUwm0OGJOJ7cC/pyWoxrfswRNi0M2AUt83xU5eegTuPXq/zRuDrXigMPd1/kDrulKNpMuqmfUlNqyTwRHxJvfRvr0G//SM8yTLq/BejMNizX6XdOq8ep5kLpGRVAEIqn6XyHnCxljh+QKq/e92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41D+a2iTH/mbybIR8zGqfLwjfhHRxLd5eMlgt0hlH3k=;
 b=XOHBI2mtDQpluF4ReHnK74wxqy+IFVL29xNaJvcmiGTXaRgJv3e+NNwxL2pFe1dbVKCIrGheEl+5JzZNLBMfDRCxGC0Wa6x7XmsMTuNDwxxjSnnBza/ntFACCCEVFhioqpYkDX6ib9fHohUdyk+iWg7eBgT1IO2K4I1lwiyMGH6BMNC5la16SbFM48LcFrlKCLAEbQgnkof7+s91h3FyQ0GwRLAknZr7e3lJOF5zwp2CNPtbRJOcGLRBmkNu3PVO24EQlBqmf9myqLuJbic0Ppu68EjgeMSiV+bWaLFTMvASTPxXPB3FT7BO1yB+VJ1U3BMi8RjVp3oPuwY4gwCOeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7709.eurprd04.prod.outlook.com (2603:10a6:102:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:52:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:52:27 +0000
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
Subject: [PATCH v2 net-next 12/14] net: enetc: add PTP synchronization support for ENETC v4
Date: Wed, 16 Jul 2025 15:31:09 +0800
Message-Id: <20250716073111.367382-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073111.367382-1-wei.fang@nxp.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 3214de3c-86bf-4cca-070f-08ddc43db53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0PmDaxmQj+SMZn0K0JzeuT1/96vi0gUTJUAa1tKBwlqPCEp7sJGd9erWswhg?=
 =?us-ascii?Q?gj/8VHs9Phx873JD/tR0lHLADczeLWI64mHKfLkxhPel0Nm+hcmMVH5G2DyC?=
 =?us-ascii?Q?7djNVId0kfRLGEI3rKu+q9zeZT/1saK1E5ItFRhgNo54C+WytcSh2p9oCuxL?=
 =?us-ascii?Q?RB2XA8c4YpPhVCMcEgE2VeyEmPqrWo6qjWTOEoB6jyRo5vrkDrtik1P33ccT?=
 =?us-ascii?Q?B/9QO4PQRejmlevTeajw+1OREDW/R97OjFtwo2MDTbKHzA1RpZBfKLszhq2H?=
 =?us-ascii?Q?cukmt1vMfUGXrzQyAmXsdwseq3SV94GgGohRbjmTTGgEJeatiXRJ+lIgWbbs?=
 =?us-ascii?Q?1XPN4RIQDK2JgWRGzQIbOrXgFGKbPaR+VV1t5Y5h1wWGoIDGx+f2pM3gAB9q?=
 =?us-ascii?Q?+DN5+4ZizNZFw0S1OLzloGtG/HgI5lGK0KegSBu7tPeO+g7c9WmNwlKIj0lG?=
 =?us-ascii?Q?3p7pvXmgMffA8IDSUXTkyaGgbk2AehbqKjn/lOH10HY2uR+E65qaohTIeCjH?=
 =?us-ascii?Q?1xxVFmDt1x2IpsooE6J2u1/GUPGpmW/wa3dyPzsICpE9DLkSf0d3wLnUvGep?=
 =?us-ascii?Q?nVrXRofcPX47JlkLYLAQoQwmg2dliDhhidP8cuyCpjnQJ9ie1Ho/DlVE4hMA?=
 =?us-ascii?Q?JYuCwR/j6FjYxdc8wPfWNpNAz2KKtiHYZ9dLZom+riLy8X582poIQHLEpy37?=
 =?us-ascii?Q?O/3Og9YuW1Hg/aSnuu1NnLJIALNoKhlCp1dx42GH7cbEEQphD/G5plYSc2Pd?=
 =?us-ascii?Q?2nw2n0y9fiUIAtVft5mmXtMDAMGW0S4QFNgoHQ9f0cuUIU4EsoX6Zp6t8OOL?=
 =?us-ascii?Q?7/KlbHApqCMPTwoIu+8B9+fwlymY5WMLDLanwBE/7/RibztiOlrlzMv7FRVr?=
 =?us-ascii?Q?lKEzpsF0r3lU6t+qqKMKLn5sA9jEUZ67VV6AcBw+yyXkU6Qc2XJBvKd+t5Xf?=
 =?us-ascii?Q?DGYKzHvqiAkqksbE3VIMiG6HrNkIpTP92cXzEuZMDhDVjT49+l7SPFdk58IL?=
 =?us-ascii?Q?eiRXGusRgsBQsBvh/gHOd1K41/DSQ3qkeDfyEN9He70n+PAok9HBYdokdhLA?=
 =?us-ascii?Q?stKj/ysPtxpFQsduA95ZSKmC6oQKH7QJmAD+NtkVgOuh+0T1j3SNW12teotU?=
 =?us-ascii?Q?aqUKD/5kqU1bTJK85aiLOz06cwxKizifwcbAwc17KDf2gGRCvh7UvSf5AWNr?=
 =?us-ascii?Q?t68ez6Rz1Xi+pUB/my/NhtCjq1JMsGgrITNUy54Slf4mGrq4+e36dbtCyexm?=
 =?us-ascii?Q?CffxhFrezyqfNYRb2r3Nb0D7aITrYMJOGBzteU6MockhnjQYgV2vfhrgJW7e?=
 =?us-ascii?Q?wWv/mMUKTQlpy/UKaPvWUb6+Y1cwsY2Axct3w9lJVK/ZKStbXxATiGTDOS7R?=
 =?us-ascii?Q?Z8g9s4ohc6vJYXFcBTQE/6G9mAEHzm1Nhql1cwXBJ7y/nyjjqhgBZDtlIYMl?=
 =?us-ascii?Q?pNjaWx1slIalG+Jv5ADguj3sgvLGU3jnf298QfPJyjMU7Mpy01yJGVewOZi6?=
 =?us-ascii?Q?njmMg7U0S5PvBbA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m8fzyGHapUjbBuO69/V0tzhdJyY3s881vO4AnNDjFzdMUrPrg0oqnAjLpkcu?=
 =?us-ascii?Q?tj0hRbG57I/U+HVU1U8/iJwe4WqXRIagU6VB19DdkxZWXN50jmuYjl5ypzpz?=
 =?us-ascii?Q?buytug7KEykQXQ+XnTrU9jBYPXBNTzDx4MfBwYlTDVfpgO85j7nZly213pmz?=
 =?us-ascii?Q?DhBRGs9EKWMBJiL/9sogl2bue9xAJDyw+cDr+1VVzZEobVa1ChFZ5VvIF5V9?=
 =?us-ascii?Q?Xm8wcBVXDt4FZDlmWBOCNSaxAwfp2MgcxqttmKZctyv1TCg4Slf4C8z0SAF9?=
 =?us-ascii?Q?RfFhOIG4vT9uzcG8Toa4NFJK/rYk81afsW0unBBLobr1iCBea/zpqrjMkagn?=
 =?us-ascii?Q?B6cTm0ru4jHPeT2xKm6GVhIbL2qZgu+oeTNtP0rt6nP+tMJO6Dkle7VUoRbI?=
 =?us-ascii?Q?nnSqJWUX8iIyK5i1gawjbjP5rht3o7OrZqNy/KSr4Cecsj1vUIm9yZqu1a0m?=
 =?us-ascii?Q?XRo764MJiMGeo8q5La9losNDirIgjzT7QHfbntnxZgCXYLeXIA/8h9PekD0K?=
 =?us-ascii?Q?yOfgk0TT0lFVIXj2BZWgwGDfG0hdH7rCC3CsZIuoAsAmyBNX0DV5cE+CBNzc?=
 =?us-ascii?Q?7YaaCvwvwIUyrIxdYtu6wzH8ED61uJVOPJdf1irzZkg2r/UfPU8sGxYSbKtV?=
 =?us-ascii?Q?b6ZEcr5gfULYADRk8rQMlzBeMQDbnxuzRFSQgEAqn75FnhK8zmhbmCPZTm21?=
 =?us-ascii?Q?cKPrSg0sJuQhy7kG4N0IkK054tx2Wat15F5ZsYaTHM3DYCtLVvDBMH41DdrV?=
 =?us-ascii?Q?4j+5o/zQ+6rTYcgtGCexP+0daP3XrLmiu6HKXEvSQZ3qrpw8/4+OfZviSRp+?=
 =?us-ascii?Q?VwadTqHJmeF1h4a6ZWa8bp7XJGJ620q5HExniu8rVlI90Et1ei3UELNF8W0V?=
 =?us-ascii?Q?4XvAZKzddvCjo1ZXJhnQc/4VRdRBz1tb5qmYnBY3rjZmpSNR4j+sy25bPUqQ?=
 =?us-ascii?Q?PfednE+BJG5Gc+ji9Vw2YyNkZbvMnIcsg3LJW39pgEYZqGKrNF7CT50Vp/uA?=
 =?us-ascii?Q?To4xUrUGdG8AxRIkA41SN6df2YsNJfaVnVcGEbxaAjO/MLbc2/rDsc8JERZW?=
 =?us-ascii?Q?OaEMIvZJHOozpLB9Shnv4p4wL3t8oetR/jFjBsEN1GMvrZVIdGuQBPnNh86l?=
 =?us-ascii?Q?1jyVjmDjFX7sTUOe2dgE4cRAzxsHGoQh1/KZamyj1us+9T9rzk1oFTaBKqds?=
 =?us-ascii?Q?FPnUJjAd+bEdix/TRW499zdxr4PXbuvca31x2odDHqdGsUVKT5fDAfgx3k8C?=
 =?us-ascii?Q?vkt4l5YPdSQ//z+XF8i/Tl1bB72EB4HcvI0TETd21/AP/Y3BBz5s+UT6cJ5j?=
 =?us-ascii?Q?WbOLM5QlF6R3h3JNjxFWTHKu3YWAb7HvtYCVdz4hmwr9KbuW/69cSSjD7R3+?=
 =?us-ascii?Q?jsETYory292nPFt18H5IB7ILa3QhWvfTQ25SA8mq0h/MO0P7pLvdEs3qZ55n?=
 =?us-ascii?Q?OcgCdJvQo9V+dB93rWBlcATccmC6DhHoLZ71WOzb//w+LlCv8lLGO3ghqjMt?=
 =?us-ascii?Q?JWqWtU4UJJEcdFyE70a1/DymMsFukxxwKwHYuKcpxK0PSvBsF+3DiYNLqmTw?=
 =?us-ascii?Q?duFO2vwX4NoLt1MAX+SJR+GKxfcM3XxbVD2gkRrX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3214de3c-86bf-4cca-070f-08ddc43db53e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:52:27.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KEcyLAGzmF1ORzs2HB5q6ip+RXCj5Xe0VJHoMjuokeg3dCrjbQPVd3Oc/TeFIE1gSxn+SzJG3tpRZj8Bqd3Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7709

Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A),
mainly as follows.

1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
different from LS1028A. Therefore, enetc_get_ts_info() has been modified
appropriately to be compatible with ENETC v1 and v4.

2. The hardware of ENETC v4 does not support "dma-coherent", therefore,
to support PTP one-step, the PTP sync packets must be modified before
calling dma_map_single() to map the DMA cache of the packets. Otherwise,
the modification is invalid, the originTimestamp and correction fields
of the sent packets will still be the values before the modification.

3. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
register offset, but also some register fields. Therefore, two helper
functions are added, enetc_set_one_step_ts() for ENETC v1 and
enetc4_set_one_step_ts() for ENETC v4.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Move the definition of enetc_ptp_clock_is_enabled() to resolve build
errors.
2. Add parsing of "nxp,netc-timer" property to get PCIe device of NETC
Timer.
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 55 +++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h  |  8 ++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  6 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 92 ++++++++++++++++---
 5 files changed, 135 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 4325eb3d9481..6e04dd825a95 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = ENETC_PM0_SINGLE_STEP_EN;
+
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(offset);
+	if (udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	/* the "Correction" field of a packet is updated based on the
+	 * current time and the timestamp provided
+	 */
+	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val);
+}
+
+static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = PM_SINGLE_STEP_EN;
+
+	val |= PM_SINGLE_STEP_OFFSET_SET(offset);
+	if (udp)
+		val |= PM_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val);
+}
+
 static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 				     struct sk_buff *skb)
 {
@@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	u32 lo, hi, nsec;
 	u8 *data;
 	u64 sec;
-	u32 val;
 
 	lo = enetc_rd_hot(hw, ENETC_SICTR0);
 	hi = enetc_rd_hot(hw, ENETC_SICTR1);
@@ -279,12 +303,10 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
 	/* Configure single-step register */
-	val = ENETC_PM0_SINGLE_STEP_EN;
-	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-	if (enetc_cb->udp)
-		val |= ENETC_PM0_SINGLE_STEP_CH;
-
-	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+	if (is_enetc_rev1(si))
+		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
+	else
+		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
 
 	return lo & ENETC_TXBD_TSTAMP;
 }
@@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	unsigned int f;
 	dma_addr_t dma;
 	u8 flags = 0;
+	u32 tstamp;
 
 	enetc_clear_tx_bd(&temp_bd);
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -327,6 +350,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 	}
 
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+		do_onestep_tstamp = true;
+		tstamp = enetc_update_ptp_sync_msg(priv, skb);
+	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
+		do_twostep_tstamp = true;
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	count++;
 
 	do_vlan = skb_vlan_tag_present(skb);
-	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
-		do_onestep_tstamp = true;
-	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
-		do_twostep_tstamp = true;
-
 	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
 	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
 	tx_swbd->check_wb = tx_swbd->do_twostep_tstamp || tx_swbd->qbv_en;
@@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
-
 			/* Configure extension BD */
 			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
@@ -3314,7 +3337,7 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err, new_offloads = priv->active_offloads;
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	switch (config->tx_type) {
@@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index c65aa7b88122..6bacd851358c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct enetc_si *si, int size,
 void enetc_reset_ptcmsdur(struct enetc_hw *hw);
 void enetc_set_ptcmsdur(struct enetc_hw *hw, u32 *queue_max_sdu);
 
+static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
+
+	return IS_ENABLED(CONFIG_PTP_1588_CLOCK_NETC);
+}
+
 #ifdef CONFIG_FSL_ENETC_QOS
 int enetc_qos_query_caps(struct net_device *ndev, void *type_data);
 int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index aa25b445d301..a8113c9057eb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -171,6 +171,12 @@
 /* Port MAC 0/1 Pause Quanta Threshold Register */
 #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
 
+#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
+#define  PM_SINGLE_STEP_CH		BIT(6)
+#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
+#define   PM_SINGLE_STEP_OFFSET_SET(o)  FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
+#define  PM_SINGLE_STEP_EN		BIT(31)
+
 /* Port MAC 0 Interface Mode Control Register */
 #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index b3dc1afeefd1..107f59169e67 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_set_features	= enetc4_pf_set_features,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
+	.ndo_eth_ioctl		= enetc_ioctl,
+	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
+	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 961e76cd8489..404dcb102b47 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -2,8 +2,11 @@
 /* Copyright 2017-2019 NXP */
 
 #include <linux/ethtool_netlink.h>
+#include <linux/fsl/netc_global.h>
 #include <linux/net_tstamp.h>
 #include <linux/module.h>
+#include <linux/of.h>
+
 #include "enetc.h"
 
 static const u32 enetc_si_regs[] = {
@@ -877,23 +880,49 @@ static int enetc_set_coalesce(struct net_device *ndev,
 	return 0;
 }
 
-static int enetc_get_ts_info(struct net_device *ndev,
-			     struct kernel_ethtool_ts_info *info)
+static struct pci_dev *enetc4_get_default_timer_pdev(struct enetc_si *si)
 {
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	int *phc_idx;
-
-	phc_idx = symbol_get(enetc_phc_index);
-	if (phc_idx) {
-		info->phc_index = *phc_idx;
-		symbol_put(enetc_phc_index);
+	struct pci_bus *bus = si->pdev->bus;
+	int domain = pci_domain_nr(bus);
+	int bus_num = bus->number;
+	int devfn;
+
+	switch (si->revision) {
+	case ENETC_REV_4_1:
+		devfn = PCI_DEVFN(24, 0);
+		break;
+	default:
+		return NULL;
 	}
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
-		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
+	return pci_dev_get(pci_get_domain_bus_and_slot(domain, bus_num, devfn));
+}
 
-		return 0;
-	}
+static struct pci_dev *enetc4_get_timer_pdev(struct enetc_si *si)
+{
+	struct device_node *np = si->pdev->dev.of_node;
+	struct fwnode_handle *timer_fwnode;
+	struct device_node *timer_np;
+
+	if (!np)
+		return enetc4_get_default_timer_pdev(si);
+
+	timer_np = of_parse_phandle(np, "nxp,netc-timer", 0);
+	if (!timer_np)
+		return enetc4_get_default_timer_pdev(si);
+
+	timer_fwnode = of_fwnode_handle(timer_np);
+	of_node_put(timer_np);
+	if (!timer_fwnode)
+		return NULL;
+
+	return pci_dev_get(to_pci_dev(timer_fwnode->dev));
+}
+
+static void enetc_get_ts_generic_info(struct net_device *ndev,
+				      struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
@@ -908,6 +937,42 @@ static int enetc_get_ts_info(struct net_device *ndev,
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);
+}
+
+static int enetc_get_ts_info(struct net_device *ndev,
+			     struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
+	struct pci_dev *timer_pdev;
+	int *phc_idx;
+
+	if (!enetc_ptp_clock_is_enabled(si))
+		goto timestamp_tx_sw;
+
+	if (is_enetc_rev1(si)) {
+		phc_idx = symbol_get(enetc_phc_index);
+		if (phc_idx) {
+			info->phc_index = *phc_idx;
+			symbol_put(enetc_phc_index);
+		}
+	} else {
+		timer_pdev = enetc4_get_timer_pdev(si);
+		if (!timer_pdev)
+			goto timestamp_tx_sw;
+
+		info->phc_index = netc_timer_get_phc_index(timer_pdev);
+		pci_dev_put(timer_pdev);
+		if (info->phc_index < 0)
+			goto timestamp_tx_sw;
+	}
+
+	enetc_get_ts_generic_info(ndev, info);
+
+	return 0;
+
+timestamp_tx_sw:
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	return 0;
 }
@@ -1296,6 +1361,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
 	.get_rxfh = enetc_get_rxfh,
 	.set_rxfh = enetc_set_rxfh,
 	.get_rxfh_fields = enetc_get_rxfh_fields,
+	.get_ts_info = enetc_get_ts_info,
 };
 
 void enetc_set_ethtool_ops(struct net_device *ndev)
-- 
2.34.1


