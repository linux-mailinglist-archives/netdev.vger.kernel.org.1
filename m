Return-Path: <netdev+bounces-132983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6CA994096
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F8A6B22900
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 08:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A6B2040B0;
	Tue,  8 Oct 2024 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ffoV7tYO"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14B2040A4;
	Tue,  8 Oct 2024 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372221; cv=fail; b=nb18eICm5QEs4EmOcqu08OfBZH7T4O4VWMjreARWCnRKr/FdmEMLQqkIrNKi+HoLcr0BUt9WeG4ZZyT8TyFTqFVxS4Qngfa2KXkvneDoNSLVo80wA3aAbLjG6o4kEJuFqiCkb/RLpt++PKNXUYEn5fD8wr7gO0ScH4U/uKo8ZA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372221; c=relaxed/simple;
	bh=3Ie6lylrWIzCpt4i4mFfMpYAwWuMCLcbo8Lm0vDGG+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fhMn1vcrccbb5Gy1b1WpQ6Oh+adUtzi7MXGt0KSiLN8krGty5+yd5v/2C8ASZ206QiyXY0kprc4wP0IpMMGtPl4ZgyqnNKs5Q1s7pZPRPmvizV7dJFnGkrzWtWDgl5NQ2G77ZKfT7wnpiDw68otjxQrVID3pPpJuurW1jdD7MAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ffoV7tYO; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReWaWpJZXwMpVHIZTsotnjy9bsXekiDIYiCNNskdnsJsGSjoF4liKAUXHKtppQLOVZaF2F445c+WzkoEZRy1VbKm4LdVlqoDIRkW4G+KKPsAg05CQTUltzXUaX/4fivXvtX3oPZ/gAzIyT/xxeR4qszGZB4L6ATi7pRT7YqPfXIIAVlCViwjAfalBoJsdEDGpJ03ynqINZTxOeK+RtuBL6BeSlIVlvQIyw7g6M1bAPqPPkuH4CoytT9mHuuo7gKwxU/6ly771APazn+JIcCGELi89h08WVbjOgjtFL1FiM+jucfWHrJ/ZDdSPvS7QM+/NFYRUQh24a+W5/lm7nV6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lzw7SdsouHuA+JImjTIUqXwltWwkmmR0EZBAL5sN8as=;
 b=dLcORJAVXenXnX3N9K2Mlho/9pAZDqKJ7cBICtfM1aJLogpklK/8BC/qTQp8EO+44wonrk31Hom4i1QObmgNTvIewmQLBnFCDf51jbY9lDhaoqZd0wXxRgCSf+VNRmq2AEF+qguHetwf3YE3jlfWXj5C3equ3iJs/T0CCHCUk3YJ2/9jagZiAupB4FpUp065nvyWpGEYTHjqad64LgHZ3fNSeqp/fTaWGB1eX5Zc8Qx+8tZFl10h/VaiHILPfB5eAZGy5hFGS6a5PA2aFhteHN5yXAZO09sXAIzNoD9URE5jF54/ic9JtK0QUQ+CubsOzvVrnrXEeuilNdRDGJFWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lzw7SdsouHuA+JImjTIUqXwltWwkmmR0EZBAL5sN8as=;
 b=ffoV7tYOzmoNLoj5UiEvyGLr8vJnLkGscOpNPBW4Zcyv8R49ngK2Wu7VQnraYecpPrpgXhfqp8EUrPwUhH46KVziNcI3za0Spdj81O0GANu6PhXl9tmdPLr8BnIiemFdq1L9ZgxHkfqwZS+QKruIsUJmnI8LspM+5CLIW4n51MtTe4mQu02361AjzhKuxYMeYtPsYrZfSGp3KWLRJIKstHao9NAIOh2YegYtmT2FsRaw+yRRMqixJWyYczI/IMozNsukNYIGNGIwocp0JlFR2wAirgC3XWdA9CQe0F1bC4AQsM8GyzkEidcKCmt4DiIxcEA62z1kKs3/NebiFCgZwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB9564.eurprd04.prod.outlook.com (2603:10a6:10:316::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 07:23:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 07:23:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	andrei.botila@oss.nxp.com,
	linux@armlinux.org.uk
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 1/2] dt-bindings: net: tja11xx: add "nxp,rmii-refclk-out" property
Date: Tue,  8 Oct 2024 15:07:07 +0800
Message-Id: <20241008070708.1985805-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008070708.1985805-1-wei.fang@nxp.com>
References: <20241008070708.1985805-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU0PR04MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2c4b79-af88-4236-2e7e-08dce76a1f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ApkEMIBueRFAmaxobHinvn8aE4HenLJdeTTnLi358gnl/ojHXs52xoqXJs/G?=
 =?us-ascii?Q?S5+Fqexvm+t4FRQeK+lmutYBFRSisSddrmqeKo2yMLE0TwRux629Hcfym1lS?=
 =?us-ascii?Q?Z3/bQPklHs1ZkLHbJ4LOywgDtJ5DZRGzfevg8N4pcTxkjFJbcJgdIQpGrYMd?=
 =?us-ascii?Q?BWkF1+roFsukM0PXobthV7J2KvW8fumgzq0zgnAQsJvSmTd4uY2aiqDKkODI?=
 =?us-ascii?Q?58kZ8lZtHY491E3xOfU6UMc93lHZyLSTV6YsfxssmZ2SQa0ZHzSMu0pEKc8V?=
 =?us-ascii?Q?6nxEu/bafbJQy4Fvl2GfIKQ04Qd+pDWmcO0nrTj/N7XgzEWI7I3vD88MMY34?=
 =?us-ascii?Q?X5K7MAVjtMA4+EqYqIX5E500Uu8/auqUR1i0LwWjgk0Z7JS46iNndA9E3gUY?=
 =?us-ascii?Q?GEdEjB+fFWI81Sr+lsbj0w3Ux+X6o3CJTTRYn6xZs/x6VkGgfHpxnnuONReM?=
 =?us-ascii?Q?8IMyrpOTpSHuioac5/TCbFMzILZ1XQA2BqnoxRIf9zw6QGgp1YeWhp3MWOlc?=
 =?us-ascii?Q?0mjeTjxDshDQYpom51/7YA0Gl/vYqCIv5wvxicc/40S0XsMSi2YLo0bTcRrG?=
 =?us-ascii?Q?c3Vd9IiN/4p0ftK4kzuOy0jRv4yzh4BxQ7MTGIP5KQ1TE9bn5hEChfhVz3Pb?=
 =?us-ascii?Q?zAh9vdUpR0h3DGEuTM5eyyFerEDTzMSL1/jSE98JE/myhQu/YCFhaAonCbI8?=
 =?us-ascii?Q?vtRfaaojNYHmaqMT9q39R53tRGwktguJy3VMArZl3fQ9V5ni9TnHWfdSwFqm?=
 =?us-ascii?Q?zTv2iYoH/nF3zTl9BOJf99At8EmgGHtqT1OMqsYIbf3C2ZV69Ry43110HgkM?=
 =?us-ascii?Q?k16l3+cTadPKfsgJMSMFNmvoU15WvEa3YoVVObTPARhcVEOU6lpYF91OILKW?=
 =?us-ascii?Q?AEcxUlIjXNTy9Frxa4+rks4ZdZqimVym0p0o4RU2g0WDAagbDhzAHLf314gn?=
 =?us-ascii?Q?TJ4ZgJTjoo5ZxUYxHclTZzTTFcGcG0GhVg2twxVpKxby7DKpPCk1CDPC223s?=
 =?us-ascii?Q?/II6TBkH7N7oLKpog5AFKSk51ZuzAg1XOfLnT65J/GFwbq8sBgFSwd5TeiTw?=
 =?us-ascii?Q?EV9rNbresqDpixS/uXAHZFh42YDsLrfblXrcrVD0LLQSd/WamPN6RAkQMtnD?=
 =?us-ascii?Q?Tv4myLAop/xiyZO3o3vjiBVpjTyuWN4bvrSTL5bV60Sdj+m8s9v41Grc3Z9q?=
 =?us-ascii?Q?cZ/tYGLcaWVl6D8yzWh+unTcaVBY0l/e+yzVL0zikI+W7Q7Lts8ZT88VipNQ?=
 =?us-ascii?Q?NMNVcDoApYAVC1csP+otBHH8uUZnWnaHXN5ZEqFon4jHwzcrC/ffBu6zve9v?=
 =?us-ascii?Q?yEYPK5zZBUTAKFFfDzolgqZlifLGFpVBNW2VJwxZqZ6yKpyrzz2/oA1FMQjT?=
 =?us-ascii?Q?J8Tk4ok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?drdAj+IXgaLbsdd1utTikBDJt0eMPKLDd3cenXs/8aceLzvl0XeTFVr3e1tV?=
 =?us-ascii?Q?1ttp0bLwSB26vpYAWh7VZ9Lnowrk6CdstjJdn7BjqLTsAiFM2cyMIJwAyne5?=
 =?us-ascii?Q?DrLKIiiL/Vycle8pMVXlEjVTfpptcviPiEOndh3hYVIlIu0FRoLNBaSFNYgR?=
 =?us-ascii?Q?GW/5KajrP+yVLFxmnoFdPn6gPKj6tjzqZU/+c5uJZu2M/Y+1CpOBQ3bccF3H?=
 =?us-ascii?Q?Xbg4oMwdCpkOe7tjRCZwngJrjwxzxQRwMdXZgq/eFyx/DrkDJ6OpWWkvVY00?=
 =?us-ascii?Q?Eql2EzY9tf1+CIL/cwL5BYaY3Y/KJ7B0aVU1h25KG6asVqIQQLtOd6Z7RpL2?=
 =?us-ascii?Q?cNZeKJ336qY9ZoIc3cXYvXGA6qB7uAhsyqW6mwYmOr7Rp+7+UaCbdxLQBWoe?=
 =?us-ascii?Q?ON6+uMi9VKlxzvxrxce0Y/eyuAky6FN+oTSvi1SqxjzC24N0u6YZIFsHF8Mh?=
 =?us-ascii?Q?12Hlva0n6xogW1nsv4e4CmyNv1HNEVCS6XwjVYNR0XsWLeTMW/BMC1k2fqaz?=
 =?us-ascii?Q?PQGlZeNiYs2WG4I158OsPF9u/TPqAg+BHMVumxqZUmImbu/osZIUQBVIfCqz?=
 =?us-ascii?Q?rYoGesOKsaYb81ogPg4RmI9gA/SNShaqoj+zbyj4cq0/TF8dudmEnB0QVxB1?=
 =?us-ascii?Q?BmK1BlsqmQ1mZxLaWkSo9w0WwNd3hAbaLqjp654kpZOEBAwe6CsRlA8nZc/s?=
 =?us-ascii?Q?G2bbMCfl5Undr/KG6CUR6xORVuaSTfinD3QxCp50qJ2ArnjFu6kxxGO4DNrT?=
 =?us-ascii?Q?LQFWkgmn5ZgAZVvYxtjH7WxUCmUmqBPBFIDR3RXU9MdY5baBhVjT+B1zZ47b?=
 =?us-ascii?Q?bHjC/tPzVtSy/psNnFcN7nzpZPUW9J9LfchHaXqjfcICyKnlmd07zqvpICpL?=
 =?us-ascii?Q?RE0ei06JESP4OFlDTOl6tCxLRO3quZM3hJQKeq8nZaKLTLFkdqBwyV83aXsE?=
 =?us-ascii?Q?dFEbIBSDHraMrRU1DhBGfevmPNd+cBbftzny3fiiatSXbV0t9i8fNgabOnyK?=
 =?us-ascii?Q?gEg7wEh/RnBp/sSXgBvV4rFWZKV12MmjGpr7jIpnARyfUB8pOyzPFJGSHD58?=
 =?us-ascii?Q?QUgs4kaKi9NvePLCiP4H7U4EDRS3C+avBBKC5kmwakJcjhiuJB6L90wtPQ9O?=
 =?us-ascii?Q?MBiAuhbyZePK3tQIcKPTEaHIgNAJmmoK951wePxdAlhRS7WVm3U7NaHdKM0/?=
 =?us-ascii?Q?lIYRXoSU2WzQNwtYnVFZX5IGjzCOYsUTYjSSW7wa3DqPilUvZsK8WZXVAnCS?=
 =?us-ascii?Q?wADJUJ+apRPsONExY0cgSYOs3BIRXZQ1TUTwuNCXJB1T5gnfsg/CNm+2j2TN?=
 =?us-ascii?Q?XelO7AZQqHSCon63LbhWSRJlEYsK+ADxlsZkjTsNlkN4K62AScPPvxg1RcYV?=
 =?us-ascii?Q?S8g21/BOQHT2LVVduyNzCiUwZov/CkuAVl1nM+IUZoAtV742V0C9y6FKuuvx?=
 =?us-ascii?Q?mRcTnw6U+xcKSap+gs2doHmCM2rSJCLkf8SEUAigByOBO4pMWZuCMauYncWX?=
 =?us-ascii?Q?nxMS8Q4eyuzodHRFZFOH6ZiM+m7NR53hKlGZltJGbZfZnL2itRvfLQp65X2Z?=
 =?us-ascii?Q?g489p0Wp4ykDeuJR1AG+KR+t+0JZvkag/Hxo/Wl2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2c4b79-af88-4236-2e7e-08dce76a1f97
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:23:36.4179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59NA5EwG4hi5PJPFBaiL2mJLtBPueB6mQrfqgaSgLZ8lelQGrxwW5bM5xOhTnGY+YR6nnnXUigTUHCLV8Z+pIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9564

Per the RMII specification, the REF_CLK is sourced from MAC to PHY
or from an external source. But for TJA11xx PHYs, they support to
output a 50MHz RMII reference clock on REF_CLK pin. Previously the
"nxp,rmii-refclk-in" was added to indicate that in RMII mode, if
this property is present, REF_CLK is input to the PHY, otherwise
it is output. This seems inappropriate now. Because according to
the RMII specification, the REF_CLK is originally input, so there
is no need to add an additional "nxp,rmii-refclk-in" property to
declare that REF_CLK is input.

Unfortunately, because the "nxp,rmii-refclk-in" property has been
added for a while, and we cannot confirm which DTS use the TJA1100
and TJA1101 PHYs, changing it to switch polarity will cause an ABI
break. But fortunately, this property is only valid for TJA1100 and
TJA1101. For TJA1103/TJA1104/TJA1120/TJA1121 PHYs, this property is
invalid because they use the nxp-c45-tja11xx driver, which is a
different driver from TJA1100/TJA1101. Therefore, for PHYs using
nxp-c45-tja11xx driver, add "nxp,rmii-refclk-out" property to
support outputting RMII reference clock on REF_CLK pin.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
1. Change the property name from "nxp,reverse-mode" to
"nxp,phy-output-refclk".
2. Simplify the description of the property.
3. Modify the subject and commit message.
V3 changes:
1. Keep the "nxp,rmii-refclk-in" property for TJA1100 and TJA1101.
2. Rephrase the commit message and subject.
V3 changes:
1. Change the property name from "nxp,phy-output-refclk" to
"nxp,rmii-refclk-out", which means the opposite of "nxp,rmii-refclk-in".
2. Refactor the patch after fixing the original issue with this YAML.
---
 .../devicetree/bindings/net/nxp,tja11xx.yaml   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
index a754a61adc2d..1e688c7a497d 100644
--- a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
@@ -62,6 +62,24 @@ allOf:
             reference clock output when RMII mode enabled.
             Only supported on TJA1100 and TJA1101.
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ethernet-phy-id001b.b010
+              - ethernet-phy-id001b.b013
+              - ethernet-phy-id001b.b030
+              - ethernet-phy-id001b.b031
+
+    then:
+      properties:
+        nxp,rmii-refclk-out:
+          type: boolean
+          description: |
+            Enable 50MHz RMII reference clock output on REF_CLK pin. This
+            property is only applicable to nxp-c45-tja11xx driver.
+
 patternProperties:
   "^ethernet-phy@[0-9a-f]+$":
     type: object
-- 
2.34.1


