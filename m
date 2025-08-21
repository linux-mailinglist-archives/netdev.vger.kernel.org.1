Return-Path: <netdev+bounces-215752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA601B3021E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B07747A79F4
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840232E54A7;
	Thu, 21 Aug 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R1DzJLBZ"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C423C509;
	Thu, 21 Aug 2025 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801244; cv=fail; b=dUn3qrxIm57njY9dT89W0haHdF5eJZlyrHnTyr0OlsEs447/DFGUyAX9b4IxX9RIMKXcxqHz36S4ztS1goH85m5u1x7sKVMCVTbQmn4pBSsOquuOc5Iy/MFpg9bLzP7EYnnHX7ZGza9uAYzcrTwaYHFK4dpx8pcJbw2cwhWuDqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801244; c=relaxed/simple;
	bh=XLToEcAUDBqo/4zc6HWb9i35Hg0pG3FERxqsor+2KXA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=quII12wVc1YHyPyYyUkuuBwo4rSQMf8nLqaF6jhX5I6We9ZUZT7XIXRq/6SYbEtMdO4ItqKhp1UiA9YR0RQZyC0ZWaKcjdhjVPM4aI6vf4sx4VefT7VjBvk94FoNO7hhtYCN2ooP8hfaqMpOUUB3cVBhNJHEeSwJWfsvTt4f6qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R1DzJLBZ; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IB2dKyuv1nqzIdyGmAp0qCxVz064fx5POYe0g0UjmTcgZOa6QoI0NcRO+CX43IR2u4q/O/h6BxOnaKKgrneoA/xAH644O/cP8Zbg0jHRRYz/LZcXc/CC0Bu6JA/nDw4Kz/pdjGJfoyiOdWAjj2U3kkY/64fJJtJP4H6hFYsIF0tGmt5BWopIPDMXSo+W3mjIQqd79rclfNmoYVrsHzTPngZDEYSd2XG3DLANPFugdi7aIMiqlrbdqTModhAvhFffUDsFdpMZMkLMQS9UfxUgTVVB8FcY/mkTIGUwI66+4Nm9HMN9ggE9hR9uqsCX17gakwS5f8gPt/wa2PUEDgPb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jsv2q0vagXugvOzUu6/e8omtWQ75Y9/Pvnlo60At1c=;
 b=L+4Im65G/HfTeqQmd8gAP9GIHmKtrJoI6R23+37+JuxAQ8kRviyqWmRQicA3izV+l39Um36asCdTXaZ4omvycug2H/LBCDJYATbYFGpYP80gR63hyjcAEGTZ+A9pksSSZsoXSI5psiwCN8qs+kGO10deKN2ukj5e8YyWAtal3xWDWxk4HnsNzJb/hAPKa9KdcqpduwmqKey8E2EgLi0dgJcdHKrQqz93F0uZUyq7Moan4N81W8N/ymu5lBVXn80e3h73YHnBiDfgK+k6143gKgoi2MRnPAugIDSa+mpCyYu5Bx7vGj8jIaYhvI4mfMrSwOcSXlL+kz1k5YgYqn9nkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jsv2q0vagXugvOzUu6/e8omtWQ75Y9/Pvnlo60At1c=;
 b=R1DzJLBZ1IZcs/fLZ3iUWlfooBxP7JCSuIcJ4nqi9wOJQKoyhEwAIvAbwCSHue4eFKeyGN9ALH/A7+eD2wpPSynvJXpk11IkjAMpIKHUL3q7WmriQ0jjwCyTEM6V72XN34JW/nmi2W/LtE0HscE0y61q0thdCVa6Mhx8afcl/ypaPgq6LfOubs6mG98L4WXC8CBQxmWBdE6rM660P1QMUswez+POcQ3i2sitntzSCDPjuPa1N+gsGdgByFro4gcaVFhYGCIkuv3FDY3jLOZU58Arqlm2oRG5KQjZpi0NOieyZNHqWxrx3+1yZYT7x8xqUVZO74d8d3zmyfGxstuFrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DUZPR04MB10037.eurprd04.prod.outlook.com (2603:10a6:10:4d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 18:33:58 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9052.011; Thu, 21 Aug 2025
 18:33:58 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v2 net-next 0/5] net: fec: add the Jumbo frame support
Date: Thu, 21 Aug 2025 13:33:31 -0500
Message-ID: <20250821183336.1063783-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::20) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DUZPR04MB10037:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6cc192-5402-4fe1-d716-08dde0e14a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Vlk/w89+rYnp0Ixy1u+y8oBgi2NDBj0P5eQVRd4BdJ9DniCgf6sS3lPCRrL?=
 =?us-ascii?Q?jkZmLmcaasYuE1YHJp+2tz1d2dxJ4EW58kWWAF3Ft1NEU1Xdi3P7VUufpPgD?=
 =?us-ascii?Q?kWhKgMkUE9uI9dauVk6Kn+psjv+OEvdXZwld308oldAPLnxO1m+St7NR6TtR?=
 =?us-ascii?Q?wd3ho9BFSUCaAs3IBmqAmmyGJYSt8UIxSd9dZxmVVslMTEefvCTtZF61NoK8?=
 =?us-ascii?Q?mJ0sW7b+A/CqspiyjdDSMTUW1k3FbrsyvGcfHrYTwwloezr7WuQnpsmgUQJb?=
 =?us-ascii?Q?fvx3BAU7chVjVCDYBOG268DdfezoqgmXL+n25ygXHnl9r76dRIVNzKWjTX8X?=
 =?us-ascii?Q?ifDuvPFwqZG6jd5frX7Q0hf7rsnYnkxYYK2/TfJvEyBJd7L7DBz02zlhXaUN?=
 =?us-ascii?Q?CfKs2UKcvi+50Sj3k0R2+QhUyUVrcOavUNIEVkrisUx6TMa63CGG/Kb/VrIY?=
 =?us-ascii?Q?YZ4CuQvXzsUSIniPUGtLxdQCYOmo3oyocTdrrRPXMDtTDWYEuhR/6oTF9ccg?=
 =?us-ascii?Q?IhFcz5Bu5qEU3rs/tSDvSbuLGoFgm9rIdiNO+jAiZrCi2D+PSZnQXpwqubrP?=
 =?us-ascii?Q?3bCOGUfjzwzwwtFTxKuIAUT/ngWT/67XVddTXZ5jsW4cgiMWnakdJXc6vikq?=
 =?us-ascii?Q?9kBg8+2yNcjIwPQUtDe8p+Hed/6IyqrB42NCrt5ICY0w3FU4qzu5UOEvT+dS?=
 =?us-ascii?Q?vopkppAJ4VJcPEKwK+SU9IuFyZ2Ar+wfGuubvq+wYQ1QPsgVSNEA77D3alpk?=
 =?us-ascii?Q?ywskf2fk83b9Af8Ac66yI4684j/s1ZxAosEQ95mRlRp922GMLg6Nz3QFJSZQ?=
 =?us-ascii?Q?BWnsI58Tws16UM+6d3dNAohwwJlxwXmgdJ7J/ETl6Uaq586qwLoIaMVgELn+?=
 =?us-ascii?Q?FnQQbiWnxvBhuafrfTHuclN8EoFVfpW3LhgXFRy+JrkC6HTEcBiQFZ3cLl9A?=
 =?us-ascii?Q?j3+RfZdKxx+gvm9S69VGB60k2xA1czz/sY2d4eeL++xSK4ml+KbZa1+MSMqQ?=
 =?us-ascii?Q?/u5deieehRkPD1WdA7ts8+4d6lv4rsyNXEZzIoSDnmCqSurw8jypn28BcGDC?=
 =?us-ascii?Q?q6UZ7EfoUAl17+C+aEh8MvEl0uLxpHkIOYlbhuD09bB4EObh7h84AKRBqzp8?=
 =?us-ascii?Q?wqxWgyDDKhIiZjhiPaOBzINXW9AwYwIoCUx1LNZiWfEX5b5wgXV9//dnuw5B?=
 =?us-ascii?Q?corBybc9jqzMNdqGIK31SXpNMHynEAv6T9B2Kw4q2JGmsZBUL+6atzb9vocM?=
 =?us-ascii?Q?idCRA8pYymQVvdX8egBENo4zu0uIiew3HdcHlQw+Qh+UYtSRnNG0yjj4RZGC?=
 =?us-ascii?Q?t2ew43NvSpk27T7omd9Rt21vCJ0+aU+/yGbvPXGjmzt4bUkDfIQRZ2jnP/Xy?=
 =?us-ascii?Q?a5MYQhB0N9l3rAbtc5xB3Z1bZJrk7UijVku/rTHu038H0NSntUTz9KTXaQ2t?=
 =?us-ascii?Q?tUyIGiGU4J0iv4ONePjNTJ5b/62BxVDID16lutW7cuadEIMIw5ZaFB7dvXTF?=
 =?us-ascii?Q?aFToSHFIi0zE/cc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?znLlExTx09W/u8zDy9U6UCJOtXdBfk7SflyJ+e2zXcbPcMJAN64pSZP2BNLl?=
 =?us-ascii?Q?XYa1pV7KPAABb50eguyCNOPDIxZ9AW/bZvMCJAC5hM9d6S6viogmeN8kXOVc?=
 =?us-ascii?Q?vxX+V7OhD+fEIXyq6/cp6BMFTi0iXEZYNb4bUphCukD157LY/rF4PrQdVYjI?=
 =?us-ascii?Q?bPCqs9Xtujp3oxom6QnjTCokR8qfeT7W4FMU5NJqgKQbmsn4WAeBn86a9g5k?=
 =?us-ascii?Q?I0D0ikdThPQKVr4oOQb91UG4+JeOYqdNU/rcJhJtb4q8IcaNCI1Jke315ljB?=
 =?us-ascii?Q?EJXUgV8M6uabMNHwntp2NsL0nJgEnjsKT+yYYLwUjS7YONJVvpCWqYnGUMtB?=
 =?us-ascii?Q?RC4P9g9NuS15ACVZvqEBePTYFW6yW3FaIBhR3UVfVLUhxwrhSo6xyElVOXzN?=
 =?us-ascii?Q?CbLQYRK6HzzJUI3SPRFZYSyAATYwoo9TWYLJZPb6C2buHWJifQ4BY2jGyjV2?=
 =?us-ascii?Q?qQHrayC9y1hR3XcaEfMZGtVJErtK0r4PlsoP3Lcfz+CoRy/YvYjmdw5iqtTG?=
 =?us-ascii?Q?D/uGMb6qCyDNYfqsgLSQPKS3wYHO3+Mr3jokCRmIhwnWudB6WUfJBWlC6yS7?=
 =?us-ascii?Q?GlxucHcGPN7qgf6+7Ar5wJF2/W+Tz4MdZ9Mnjkp648YPEo/zgfq1MEd2ODxO?=
 =?us-ascii?Q?X6FD540uklnTWVShyynKM0+KKVcnvEb9JkAQSaQLfcr1kVzLkNeTpiC/VgfA?=
 =?us-ascii?Q?fZLLefPP3PkXmtUGsDldVevT5L/4FpoURAud6Swpzqr6yWs+wEe1isz8a3cj?=
 =?us-ascii?Q?9Dml9g37csksodfex8IT4CQVrMB0iR9jQwozs1yc4j7XlJ8LWW78qgCgdjA1?=
 =?us-ascii?Q?TTVi//XmKrk9YrgPOkr/fflpNsJtzN8e3LgXyDBVR+ZfqhudmhKxpQ6yW30D?=
 =?us-ascii?Q?SQSblW5FCQMU4OaNGpJ4j+CqPnQoa99gC400bDtsWBEttaAEHQDjFmIckiL8?=
 =?us-ascii?Q?R1VPFeYjtQrT1Sb/fQ7R4EHD0jOlRUlyoVve9+EeHyydRHxrSP5Eu/ZDlYBR?=
 =?us-ascii?Q?3wzbqDiywt/NYJIZ+Qdp1KuBuPsXtDSuYk51oPfh9pKWlSxlCe/mwlhytewI?=
 =?us-ascii?Q?ahv6RaPit/NCml3tYVn5Gif6mxNT3yw5qaUfKsX6MUEouubIbXbVKdKYmttE?=
 =?us-ascii?Q?M7oSPgz0UaW8HvcY8g5CNddEEALUgS/69Pn74qpdo8XnvLiPHafkmTTuxkz1?=
 =?us-ascii?Q?l3CKVzrGmZCBJnwC9UmsbOzd26lXOxG+xwxg6mXq9lVpQhOyhsMsDn15F/M7?=
 =?us-ascii?Q?avgTdZvZsfS65DACfX+RysPK2s4Gt9sKkEeg2A65XSxXLYywojPV1qF0dnJA?=
 =?us-ascii?Q?hhSdnKr7R6vYd2rqKi/o197aR0EPQ1S20q8ic+KDF5WUatB8AyYIUMVr5UG1?=
 =?us-ascii?Q?Ab7kj7RAs7M1tv4qkfHWR3RC+FAQzl72LZaZIYOAfjnBUWv5Nv4IQvbvXBXr?=
 =?us-ascii?Q?exsSsZqlDyBvuPd+rCeivP2Fm6fODKsgYLJQSvMNs+pVN048ZT0kgU5mBjyv?=
 =?us-ascii?Q?vlslxai7WFusobBENP+yF3mXX2h7Vmq0gRM7VSPaIygyLBrmjL5a8Wsd1O25?=
 =?us-ascii?Q?DXHLG7NTWAzaT3jg2iBwqOHvPhtNgBIbGM23lXiG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6cc192-5402-4fe1-d716-08dde0e14a69
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 18:33:58.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbmPIIxFNBhem6fTDnBMhlzxlmEZP1qOTm5M0Y/qgxrLD4pQ3LGe8W6Fd7BZPC2LKFoAeMFVvmjZUgXjcv+dJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10037

Changes in v2:
 - split the v1 patch per Andrew's feedback.

Shenwei Wang (5):
  net: fec: use a member variable for maximum buffer size
  net: fec: add pagepool_order to support variable page size
  et: fec: add rx_frame_size to support configurable RX length
  net: fec: add change_mtu to support dynamic buffer allocation
  net: fec: enable the Jumbo frame support for i.MX8QM

 drivers/net/ethernet/freescale/fec.h      |  6 ++
 drivers/net/ethernet/freescale/fec_main.c | 88 ++++++++++++++++++++---
 2 files changed, 85 insertions(+), 9 deletions(-)

--
2.43.0


