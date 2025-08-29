Return-Path: <netdev+bounces-218108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C50AB3B269
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4610568285
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092BD221FA0;
	Fri, 29 Aug 2025 05:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BEQzcbMW"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95D321D58B;
	Fri, 29 Aug 2025 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445241; cv=fail; b=D9nSDXOuD8Vn7PZyj5Ct55wXOmCww5rLbW5jwGPBO4ZlVCaOp8VWMaIYSDLr2Lqb2AwfzxlWDh/kVPmYcmpTogj37zU91qVE17XMh4RWeb4hugOlZjFJE6yP/mOGkx/d3jCq5QvTi3Y8tmyPOTQE6iWwi910oGJU4MBRWbwnYHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445241; c=relaxed/simple;
	bh=3LpkdxC2YkXWyNCuP6wBmCyuP/AZBtz1Sin9K/TlBtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hlrb6RG71QjcTWeYKHRSmEokHlkpLtDHJsL3ODQUOJrDS6YIpOwDb688XBK1XViBVciVGE4Iv226cIJRBBtm+TtTsYYBno6BKLJ/0hX/4eXtTK/eCVamSjYaeuoSv+7hRhtBpWCJ7w5b0jdveUjqCb+taM9N/Pt7lhnRk9jDgXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BEQzcbMW; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJVnFD3MURO8vp2F2pdUlonu77jWoYQjozB2/n+5fG8O3i64yCtZQ2cSZeGdK9FgtwViY79icBgimWY4Ok8Qs+XMc5Owr8VNi5OqkWGxF2+jm1pt1+5G9y6A6QS1sJRfcp4SMm6Qn3oWeU8kbCANVTOhpbpl5TnLe2tKzwnz7+jwefXeClq2JSB2Lwo1jC4n1dyqHALgTsgH7fsZkaEx4p7t174tagwF/hpLmH+b9YSbE9maqqSnHCTBkzSmS/RTuTtpRgaTcW8snD05URx68SzEr7EnYgkZsCfLnXH+fiUJVRE4p3HUL9p0K2pGaZULH2Ho7Ue8cZOOoLOYNBvXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHwdHGquKmIjo3npTzgO6ul2zw0D3TbRJV1fqBaI0Kc=;
 b=lZ4sPTr645DNGM2CKy6yC3co121VQ25WWTDJZQQhDU6+o/UBGu1FLN0E3ulTkBPez0inOalVkftBoCcL5Jwy5GDiWFc9w7l2WH3krrgEnCUVS5sVHp0++vpMnMQPZIAZrklHiw8aGLiU/UM79GDaBweV9qC+mhyzG7vMl/c/qWJukCdHN7QLvSctjawkscKNCu3U57tcM8KaZCi9vDptRGmlbif6wfzQFJU2IGGXY6ZKL6EfiW29wbOCAAzLmxw85bAvVHWVK5K4YHa64r71QoZ32baEL6yIlTWxST+KKkyoMKkNq1QX4iYJaJFFkyVQIm7DUxGP3V0HiIJOgXwqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHwdHGquKmIjo3npTzgO6ul2zw0D3TbRJV1fqBaI0Kc=;
 b=BEQzcbMW0eLQcPclWSawFCZjMR7qSYZYKiOyuA6oTcHRl3RroNv/N/4LJ13aXP56bpf9uNLF6hPiFbPRVEAPn3ELX0CtNyotnoEReNSLCL2EfdpMBoFFJQA+HnZyd+UUo7GkOfq+qQykIXVNMP8GKiaDLEy527fMhNMwQFMp7UCMohJbvpXcn/y4nz/LojuHj8okYlYCtRnlLjLhBjhKqLj6MipBGqos+9AJK3YVZvXiEllm8gGl6vLLU/FeFesEDgw7TyVJAqbPVwU/qV2LRNICS65reWWZbLXnUB4W5t6a4z8uZypH9+4G4WdNYmhXBBhTcW6zqf/D9yNt7HJVAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:27:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:27:17 +0000
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
Subject: [PATCH v7 net-next 01/14] dt-bindings: ptp: add NETC Timer PTP clock
Date: Fri, 29 Aug 2025 13:06:02 +0800
Message-Id: <20250829050615.1247468-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829050615.1247468-1-wei.fang@nxp.com>
References: <20250829050615.1247468-1-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6623e1f7-6ad4-4df4-11ae-08dde6bcb7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gtb3ly6m3Zs56UMecqBShfqiS2ZcHBLKQNu+yR1Ap1HnEPlh5JB7dQ+meK2k?=
 =?us-ascii?Q?7WyJ8wywru5qT/MvEMNeuTg5Vft7si0bN6Niy8yTI7G5iYnx+s/TtrVKWRix?=
 =?us-ascii?Q?2Mimd8rQBfX+y4rpPfLUlCUdrsHPTRUDjCRvqF983Ir+ghaH8SSN1nFRyaW9?=
 =?us-ascii?Q?8CwckO16PlWMavbycjfhUWssQ2D/o1ihZ4npyoF5G7874d2WPdRujcswMhwy?=
 =?us-ascii?Q?9/mJnu8f8jIE9OyxkJfmrVMdC7X5gefUlLLwXxzpIwew6rLsrpXPmOgezKMn?=
 =?us-ascii?Q?iokDF2dWZQQyE4QOfsl+Qs+Av+REBHRviTj8e+WQiTCQYOc4twtTR+33KGKR?=
 =?us-ascii?Q?lTPOUKJIJrC5CFiFQ+EGvpsMOe0TMjevXHYh0SjLIv6Fa3ldhE9BY3VzhSfS?=
 =?us-ascii?Q?SmjYs4tqtyqm76birUx/tglbWIjrBjo7bAo6P28Xch+fJtY3FGzudJnj4Gob?=
 =?us-ascii?Q?EVfQ678UbfTEF4gesx3WMCa/SxL6KJdKuH5335u/3QQI1SOhpCwR25cL3d5m?=
 =?us-ascii?Q?QXZ0RC70HNvt88Ri6GizwmpS15FNuUgDP6Bk3DIe0LgckK1cdlDUs03VNkaZ?=
 =?us-ascii?Q?Zr+m97p/6n2Z9U6Z/a6zXluxO2Lo072iPpvMxhLDnhvfcKDpr6h1xUoTcnEA?=
 =?us-ascii?Q?2RCnW+m9Wkw9xYm7F4nyrStiioNw6fcdeD+lJIfULCWrHo3VlTZmrIIK9Kxz?=
 =?us-ascii?Q?09JHw9hFHpg8NC4jMt43KGpDQVLnVDJzwFp3F3gHY+SLRHtYjGnhsbro92cq?=
 =?us-ascii?Q?Aaxf0zHpoNX8CPMqZ+yVZ478fwxhW/2SlgbOW0i9J1X8hSZEPOnSsT6A1zJy?=
 =?us-ascii?Q?H9tZ+sdEnYmoM9Kkq08LGYb0Pjtqbzlil39pBWXzMjSz4aKlGwIelPg1cgxw?=
 =?us-ascii?Q?p32Vhz5/ITLKK+HWLfXf4q77gyYcKJV9g0NL9gZaGzXl5AuOpxRgDtj8tL9T?=
 =?us-ascii?Q?ynj4rGXZT0O0HwA76bchBOnQ/luyRLBSQfN4QZMt7VFizL4Esgs2y9fzSVJP?=
 =?us-ascii?Q?6hwQPdAQE+4D+4ZmpQ01kBM2hWZiy0AOd/7nMUVXIlO+DLov2TeF4Uc6V3p/?=
 =?us-ascii?Q?7q3NXzarepQHvLeVwZb3H33sNgpIZRHXHk5v4tH29VevBHU+ASU8dJd6LwfG?=
 =?us-ascii?Q?TZn2AYIXQbWO+S68ZAfBhJrdDOD+hY4uWrZDjDDDD/heFh8iMkYfAX/QLyti?=
 =?us-ascii?Q?PgxmzLBgpb/DXv7teGZ0Nk6C1iIkYuEbLYFjFLeqB8XX+8Oyc2TWHEbkq1hq?=
 =?us-ascii?Q?YFBQRxXCRP98GfDrbQ0J3B0CkwYvwidvsMZF80IN47YGc5RcuqQS1cSFhOd1?=
 =?us-ascii?Q?eT7ly0K2fLh+Rhghl/BBQAHbfzNQzQjdv4Tpy24b1YlrtaRugZLeXeYthbcx?=
 =?us-ascii?Q?bEOP/2UPuhmtSzdqaeclhfFlF4ypGAPxsVWWxwaW18UXb5OPFWZD6tVXB/qq?=
 =?us-ascii?Q?AnpYn0V/4eKeg5H4AaEcKHgMzBC+gdFH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xzeuMzJAnQvrzlls4aVInM8cDcDCn+8UlqfhYJams3uCz9Gtv4I+zLg76zSi?=
 =?us-ascii?Q?gr1ZBPS3U3nw+JjAzrOJMaQpH1aYmdzQQ2tQ0/533B11/I2G6dOroDye7MLM?=
 =?us-ascii?Q?2xG4NpQyVtgA6duPylwCpvvg8Xcp6n5O4ou9RRB5Hara7u1yzLT2aBefN1HR?=
 =?us-ascii?Q?yi60sTeiqVFYwS56xFD6eojT54YlGnObFTYWtrD4sNnacAqwTdVUMQwaFfsp?=
 =?us-ascii?Q?zzOP+5wCZcCfv4mdKPpjjb+uFf2WX2ZnViaVdH6P3HYATFzkNquk2VKU51px?=
 =?us-ascii?Q?jdMfSv7fGfGq5FCWN2/mfmVVHT8BMoDt3CbRiIUJPUWmIeWg3dTNGC0u1t1f?=
 =?us-ascii?Q?rhd7KewJo9lKAGJEFXk2SS/o1Bb07aW5ltYjAs4lpD28Kp9JXFu1+MR22NLG?=
 =?us-ascii?Q?NTrZDCwy7nT1+SX1H7Rz5SDbwHPR6h4JZCGrh4DQ7IvbAtbt/9pDoEc3WZj/?=
 =?us-ascii?Q?zT0GcRPOIwMiLYwJoFQe2nSyqw2El7+pWKEIJtp2UhrkSGfb99MnJJcKSQCl?=
 =?us-ascii?Q?qbFb7ktYWuXvg4rPBbNXTUKSew79GxUrsXdNeXMh1G6eBZz01NiON4YRo+os?=
 =?us-ascii?Q?vMOfppCC/nhWmUIU9m+gK3SuZq4GqgD0UYj1HUnGJ4BLYNmLr3Doj8wE0/cK?=
 =?us-ascii?Q?QIzi8lCY+8KedspMXx5IlIIEQAOCKQ2zGy4GDt/8VCUKkf2PbykWQuh11kEY?=
 =?us-ascii?Q?T7edfv4NKGovv4G4tRgnlIXhxuFMtulXkYqFWVbVHnP9nnddsMhC1Dl8uetm?=
 =?us-ascii?Q?GN6Lv75yV63Zalumst+EQPSuKgTrdeqmWnwesYhFNFKIEp5a87T8IptVqcGr?=
 =?us-ascii?Q?S3y4zHEhtq00dHRt6nBzoNl5noXI4LojQmhAG+79Xl9nQx3SLARPtjnr0Mdu?=
 =?us-ascii?Q?xTnZVgCpex05A4QFW5mPLkBaUfUDHX64Z3MQuRL9/2HbzxQhv8V5JaxruNfq?=
 =?us-ascii?Q?K0IPQWDhTeUs+LcgdjhkCI6tU6H+wu949W1k751UcLK2xiI+1LhxWeDhx5k0?=
 =?us-ascii?Q?guQyxbWhuIBGiQjgOtIub2v6uiyY7hbgEcd62MZ/7LLkUhRiiBl0W5M8sc6B?=
 =?us-ascii?Q?XtLKXDovsF1gOu80hkkq0f2qOwnE2dbCsdJdLdCCEHun4E+S+4JDWxFw95rA?=
 =?us-ascii?Q?RpY11xSY17n7H0OhbD8YzcvgaxExZP7HryRBlAgo6Isbtlvvt/RyiH4lCGcO?=
 =?us-ascii?Q?v2BwGvWxqOVcH0S/g0YhQWt2KmCx9B/Qi81FmSHG0pzLe1nbCf6t2n/OfKiE?=
 =?us-ascii?Q?uR/Pp0p8uIOJhwCjBKAprm0FJb0Eak/GTrtIOz8+MUETyNpMpDBDwP3fB44u?=
 =?us-ascii?Q?PkOqV6HxNBpaQwRGxMVZ+GbWwp7JjAS4nwLIWwYTbN3/VQMx3u/C57CbFUPG?=
 =?us-ascii?Q?TfmmQlW6Rt5o9ELM5U4ZZMK+6Aadr0a4QE0ZXabLc9MDxcgmEXQIfXSRwm8t?=
 =?us-ascii?Q?E37aKtolfQFoQJgETZkehCrzBs2UzVgDfHdqEhQKip+1aevBoEWHvYTarDwC?=
 =?us-ascii?Q?mH0e2RCMBT6FTFULW7NdGVDRUyEVRpz2TQdKW40wtyxtCrB4qUwJ+N68+l+f?=
 =?us-ascii?Q?Rf772MCL90+GL4ijBtoVjhxUEFSC9SxIJ9i/HCAu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6623e1f7-6ad4-4df4-11ae-08dde6bcb7c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:27:17.0800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6XZr5F15SWMvozM36Yhg4DJlFyPMRGyQhAesOk1Q477EkxA6qLtTU/IpyzJ60DPiLGBp8cGhJzu1eQRad42vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
Integrated Endpoint (RCiEP), the Timer is one of its functions which
provides current time with nanosecond resolution, precise periodic
pulse, pulse on timeout (alarm), and time capture on external pulse
support. And also supports time synchronization as required for IEEE
1588 and IEEE 802.1AS-2020. So add device tree binding doc for the PTP
clock based on NETC Timer.

NETC Timer has three reference clock sources, but the clock mux is inside
the IP. Therefore, the driver will parse the clock name to select the
desired clock source. If the clocks property is not present, NETC Timer
will use the system clock of NETC IP as its reference clock. Because the
Timer is a PCIe function of NETC IP, the system clock of NETC is always
available to the Timer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
v6 changes:
Improve the commit message slightly and collect the Reviewed-by tag
v5 changes:
Only change the clock names, "ccm_timer" -> "ccm", "ext_1588" -> "ext"
v4 changes:
1. Add the description of reference clock in the commit message
2. Improve the description of clocks property
3. Remove the description of clock-names because we have described it in
   clocks property
4. Change the node name from ethernet to ptp-timer
v3 changes:
1. Remove the "system" clock from clock-names
v2 changes:
1. Refine the subject and the commit message
2. Remove "nxp,pps-channel"
3. Add description to "clocks" and "clock-names"
---
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml

diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
new file mode 100644
index 000000000000..042de9d5a92b
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
+      The reference clock of NETC Timer, can be selected between 3 different
+      clock sources using an integrated hardware mux TMR_CTRL[CK_SEL].
+      The "ccm" means the reference clock comes from CCM of SoC.
+      The "ext" means the reference clock comes from external IO pins.
+      If not present, indicates that the system clock of NETC IP is selected
+      as the reference clock.
+
+  clock-names:
+    enum:
+      - ccm
+      - ext
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
+        ptp-timer@18,0 {
+            compatible = "pci1131,ee02";
+            reg = <0x00c000 0 0 0 0>;
+            clocks = <&scmi_clk 18>;
+            clock-names = "ccm";
+        };
+    };
-- 
2.34.1


