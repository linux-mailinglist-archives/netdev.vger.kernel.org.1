Return-Path: <netdev+bounces-221825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAC6B52074
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 20:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E9A1BC5B4F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E712D3757;
	Wed, 10 Sep 2025 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CRl2m8PS"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013034.outbound.protection.outlook.com [52.101.72.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095D2D24BD;
	Wed, 10 Sep 2025 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530360; cv=fail; b=sHHLTnYmE+gtN9F0N3Nu8CffIJ+0ayig8HSaVGvghkiM2R/U72JVxvKMFXMuSJz6Ao+GjE9sGwoZkAKA2Dd+BC0dXjuzQ9nL8AKJxm40qlQsYDAxhAbNqJAfGyU79AVnb1OAiEEr2rdwcfawSvwfeaFLCjtgq5ewKcGO9DS+FI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530360; c=relaxed/simple;
	bh=168RE52lIFYcbJYVmyaoy78HYH9tzBmDG8eCTNtWYtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gKW9vsdt36VN26UTlKUiQ7DdcAmgwCdr1kKz5fR8TlReBU4aqAD1DUfxfUfbFfUwYiixnCcuyTaM+m/hbDn4YdTaZqnkZjGiA9zs+8DQeEVoDwB8TdeYRVm/KJRmjufJsNG+FA+tdvxmZtbmGkj8LBDrzUlVFEz75/h2q2D7YsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CRl2m8PS; arc=fail smtp.client-ip=52.101.72.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQsB+qhiGKCj/TVk9NRCt0s3sx6BxtrmEdgPVrqS64UHzKEF1po4o0UH/yA3T6p9GSWZqAkQf6EhY/VgcrHldw6hqTXS2du496dd9+w5gqh3XlBipvA/+xnHQ7FiAIW83SZodh0+7JUrYBg1oTmktr4BVtg6IWRXrSNiPvHuv1+3Y8k284WPgSzSDH9+RTKQBOog9BKHdMyTNJhRHlyoMWIzq/IWDxS6RtK9ZYASkDyEUEGHMeJslrJfeOPoqnUBk+78ZOkBs+bDuXcrbn5e0Ql09FahCDCiFYEnxVluLVEZGFDW4IHrjVI7uiUojYJiQyNi7Bf9RGdL8Rrc6oNCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nrrYNoywqzivGzjbUw7omwU7EPFXbvUQSwNbkvCXEs=;
 b=iUAmV4ETg2CrElgAj6UUswJ65/u2sskWRj7INP2V0A3MaBmxyzTZ0P1tjNONjIzhQ8nxM6yzQZjX+1G5+o4C2pOIG8NZjgia9Iz5DPOqjxl/7fQjCMewZJzce0s3zpezKurd8FLksCxVLpOrod8pJihN3NGBNZ7EXe02zHFolUYcs8N1/riiLsiWag/fPRujY85tzVR9Q29aX7sx9+UTgz8aVamqLPAJGraAYcfRcN8g/SsWMlZRIGR+8ppDc6pKY10SGnO77xdF5knabaRCy97oQpt/3H4CrubUZPWWlbC2JPJAfltgrvHa8qB6IRI9pRr599uJtQiAuOzE2+EWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nrrYNoywqzivGzjbUw7omwU7EPFXbvUQSwNbkvCXEs=;
 b=CRl2m8PSh2G79R6dNFbVOOP4J7iDwztj/2AMeQVqOytmPVrH1kFZWw8qkrzpZlExTD0M0bvoAMBpo8Edl9HwU0Jg7P7dbSx9gdn5tC4pfhJ3gF3jYxKmOMJso/PtV00D5XsBOPBsyynz7x2SbGBApuzzn7iuLZyh7iuariLlo21A58CG7YWYHemZFpXRGHnpTNsXf023iy9RNpkqPbyRDcWvkauAW3Mxh5JsFH8SmtX7Sw9qT2vB7OXnZ6DeGdv5mbdxs92/44vb6ouX/Dasw39sDR0JfDXvDE1rNFz0i1dKk86km6Ok3ucRkfG0B//qJykJxQiGhBlqlNE80CVXsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DBBPR04MB7724.eurprd04.prod.outlook.com (2603:10a6:10:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Wed, 10 Sep
 2025 18:52:34 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 18:52:34 +0000
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
	linux-imx@nxp.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v7 net-next 2/6] net: fec: add pagepool_order to support variable page size
Date: Wed, 10 Sep 2025 13:52:07 -0500
Message-ID: <20250910185211.721341-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910185211.721341-1-shenwei.wang@nxp.com>
References: <20250910185211.721341-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:332::10) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DBBPR04MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d272fe4-b016-4ed7-9cc2-08ddf09b344a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BveDtVCnhuBSIzgFit64AstwfgNA7KTrooXVlV9Yzj3br+fGfmFFdTfxTFoZ?=
 =?us-ascii?Q?OQFErT1h1fm36zHIpuY0nQ5xNVASiS/4FEIEreiSB5+s9Evl40XFIUr2QqlU?=
 =?us-ascii?Q?zKjY2RnsDX8sgU7Ve6NVYIgwMmg+WsFujN6rcVzZxJzj+xXX2D4OSavtnGU8?=
 =?us-ascii?Q?4ax4JcdTNbIB2xz5QcekJL37cxB0315gIfEPboFWjswOoB6zYUm3XOhW+hz0?=
 =?us-ascii?Q?u65PVFaajqJSBEVoGSO2Z3BvcWcU2fbXCvVrnntddGWkP5ncVlk+yDbiWsQN?=
 =?us-ascii?Q?DxDbHbBiQ+P7Dk47DuVe/ZGu7mikFQWxG/vWc+ySZdB3EQJCvA+x1KmLU1X7?=
 =?us-ascii?Q?dNNrN0q1HVz1w4HxSYmDHiyLGt66zKXouTxCzFLjcjwN7afXcUGR4TksXQqc?=
 =?us-ascii?Q?gpN4QirmjV0aS1wD6OSLUbpMniLl/EPMDbBgNHYwpZ+iU7Cl6TScQ4/CU3QG?=
 =?us-ascii?Q?ouaZW+v+ZBIKoUJpPYwYMQRHzKY0GJYDREIfqmSVMibsPRSzdd7RFlzJQi8A?=
 =?us-ascii?Q?4OJ2wfd/AxzuD9iYN7jQTFA+wcVwgb9fSIDMg8BeHg0AMge2d/OIw1yc0mlb?=
 =?us-ascii?Q?oofE8MuVYguw4cWJJw5bHXZvkWBRJswYlTeLywvdGGBBTBeMtY3tIP+mQzff?=
 =?us-ascii?Q?YbFo/xhOzoF7L8zcOQqICRCU0SpOFtbpj50/NXqsUk4wySSqr92UrlVCT3kp?=
 =?us-ascii?Q?P33t0NFby2qumAcHq5CYfm8yjjobSn8iX8nGyS6mhVNswC5/d/xlkLI8GflP?=
 =?us-ascii?Q?OCOzn6qQipYWge+jkDOJaXUcX6E/6z+vND1G2sPZntzbaRyLCEyhDTR/BqLo?=
 =?us-ascii?Q?dDRkW8TvuBjsL3pcDCMla2XBSfOyCQQCCyq4JQb+/uHsOdCUUGtZKSIefZpg?=
 =?us-ascii?Q?Z9k2ROAIp2pfeS3JaBywpFAqCGRe7iU5YjhXvmjUCPPtyRsq7hLMINrgot40?=
 =?us-ascii?Q?pcnNcQS1v8lcp/MCSD/VQ0gaJu82Uy9zVJSbwDa3OH0naju0VyY5mAqFQPPs?=
 =?us-ascii?Q?cLTLnIXZTTHt17hdHKW9PcAlvvi56gPDDgWv1pDJDIpxBY3QCx+xpVYRgiWK?=
 =?us-ascii?Q?Ud2r6w7hkYojhMoaAVhSFe2jDP5sUtNwnj+DmOScHARV4Va4qUMQcxpUGOO1?=
 =?us-ascii?Q?Z8W8Ix+RymDMDdwM7Fp85zQqCNKt/wnxjSJNg2C/ObruIu7oy1tTw/ChTnGf?=
 =?us-ascii?Q?hWsbUb0ZrO8VbfA83rYtvmuxonDi51ze3kE5fORLrwI1p3EgXb7Sv//IimSb?=
 =?us-ascii?Q?epDffz1ka5H88EDAbNYZX/ueEMGy0D30wXlaNnloJ+79RSR8seUyTVtskXWs?=
 =?us-ascii?Q?BV6VkLywV8Frc0KlffTtByML91PHQHzPQ0Q7kTLmSamvPp8NSGvKxNnSHsow?=
 =?us-ascii?Q?O0RuNcWBomhsfN4ZHFLgomJu7psoLtKNpZI6dwLNzsymNlWkj+w3yTA5qUsi?=
 =?us-ascii?Q?Oonei11C5pFnH3fqSI7t9wHJfqSco6R2jdM8EYeK5dN95ZlWUkk64eKkSnKj?=
 =?us-ascii?Q?5hHTBndyfsoVliE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nd12BsL4xziJrlpj3m4U4mW6xY22L6FVa7g64+hcHmW6Y1XNeGoamJMpsCSv?=
 =?us-ascii?Q?k1qMbVgQTECXKFQIkqhknBsWX8nHTUwhSNnlZmp8hu0zsWYXMY5+09EJS9W5?=
 =?us-ascii?Q?X8PBBqdkxCgnE/Ci6Ouz6Hiwq8lDVX4FxqzwEzv9cTp23NQq2vmxpxnUU6FO?=
 =?us-ascii?Q?owicvsXyVys16bcWC5NHMd4gWHa4uCOZbFCCd6kau79cUFB+x2jrQWl5qdw9?=
 =?us-ascii?Q?bGVKrGOLS4oTFNG5JaKQwGAGpQJi5IGWEh/zzNFalNQ2G7LLfxmPg+Y2AzMT?=
 =?us-ascii?Q?tBlv/qLMzntOSICvBgbgJHFwvVBw83t3M/nr1F/CqI3sA+Rs7JYVw8sIWaHT?=
 =?us-ascii?Q?yYLvMZUN8qS2cqCrJq1Jfc+cM09+HCy6Z0LmlICvcryNmwB9xKg5UsI7xvjW?=
 =?us-ascii?Q?RMKjdTjDCPSJhu5cfXV5AwLZ16xd4yR+Vo9MSjbr5vw9dWyjN2m/EAoOxv7m?=
 =?us-ascii?Q?cfbETH1d25asQ8+p/3vfARGV8LktfKDqzJG+KAPNVfhnSe2lnze4nchcWCR8?=
 =?us-ascii?Q?WrNx9W6To0F6QKgK6ohFRoGsXXum4ktpomkvcXmCrxsoNPSsg4wioKGkonGI?=
 =?us-ascii?Q?eWpoFqFSTwF+pCuLgyii23KdRIkLdu7Q7g1UMyvgYeavWK5RlBhOtBV92Y1J?=
 =?us-ascii?Q?XnKuHAqV2zqg0PwtLEIzRIIiKjpD6bhOb4vR4y6Tsne3TrUOMgS0ldeOWfD4?=
 =?us-ascii?Q?P0LDcGBSRVYmwQKOHx6KtY2WzwzyESDETy+hRbDkCMOA3vLQTzzZAiAV1SEK?=
 =?us-ascii?Q?UqChjSzHDb4mSnFkfJ/bEb+7ge4vfs6uEqhw7XRt+EL6UlL20l9ZVKI7vswg?=
 =?us-ascii?Q?dLHjdOErcPhhZJ6WX4VZCRDvSt4AngObskMwaQhfJ+062lLCZ5IWxX80INYj?=
 =?us-ascii?Q?uSd7rW4i2vbrHauZp+VEfNHJORZldptJI4Zxz4Xqt2Jas48nC2ZZXQRbJ4WC?=
 =?us-ascii?Q?yoEPbLX/MoJXUZEtX8kYUH9G94iUkp/dPgTvi4ButB+DjxY45XPY+Iq6jbDB?=
 =?us-ascii?Q?cbdeWA5kz0Mj99ic09iLkN8YJgbFWYys9pr7I3WSblLVYEmYrqQ7sQTLrmg3?=
 =?us-ascii?Q?jZlLJVVwpdAMI4cOJeCuNs+VmZMJ9M1JScHgIEb6HiABb3n+l3wj8NyvaKmT?=
 =?us-ascii?Q?uXrW9BrjKq5pzdOpZHj/YZEaN9eJhw9dQmVMkKWqXDPkFNBPo8udVXC/zu7H?=
 =?us-ascii?Q?mccNzcQNuWfrVBX5cp+SOXPTdp40XixpgwldhAGyRfBeLMOzDXa5+KsMFVjB?=
 =?us-ascii?Q?sHJzp+kJFac71WRCKX6MH8idWZluyzSiiJyg+jX3asfh+b44LV7lN7ITLWht?=
 =?us-ascii?Q?WVZl8hYFju8bm3N8O0Q/En7wDYrB/5dJkiK6xTieF9Ax7gbGU2hc/t+TAyOS?=
 =?us-ascii?Q?XRMYmO52PDp4qQDHQ0gmjytV/KoPj6ClPwi4fAsmH7WbXVKdk+H6JxyKnBGx?=
 =?us-ascii?Q?aG2vRhgf3R1JUMbYB8u5Sn9mjm6/ZaDKcTOI1NXdlAAeFjRFZMxDu0QznxZR?=
 =?us-ascii?Q?aBfzBQOJVAO3TDtHncm1J2k+gWcCb2HMfxxet5ucv5VEWgQOYpLXNL0G1wYg?=
 =?us-ascii?Q?Vb7CIQWPPXUMryrWma16gn9Ti+BineUXkaONbnei?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d272fe4-b016-4ed7-9cc2-08ddf09b344a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 18:52:34.7098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xgu2cVh0jqgN/KVI2R4/S8MGXHwOZrCb24+6BzHZuquv8F5iKYE6/+B90FHQg+cHM3I4ZqkKL7OXJS06CVtSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7724

Add a new pagepool_order member in the fec_enet_private struct
to allow dynamic configuration of page size for an instance. This
change clears the hardcoded page size assumptions.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 2969088dda09..47317346b2f3 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -620,6 +620,7 @@ struct fec_enet_private {
 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
 	unsigned int max_buf_size;
+	unsigned int pagepool_order;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 93bd8cec6719..5fb9afdafec4 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1783,7 +1783,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 * These get messed up if we get called due to a busy condition.
 	 */
 	bdp = rxq->bd.cur;
-	xdp_init_buff(&xdp, PAGE_SIZE, &rxq->xdp_rxq);
+	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
 
@@ -1853,7 +1853,8 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		 * include that when passing upstream as it messes up
 		 * bridging applications.
 		 */
-		skb = build_skb(page_address(page), PAGE_SIZE);
+		skb = build_skb(page_address(page),
+				PAGE_SIZE << fep->pagepool_order);
 		if (unlikely(!skb)) {
 			page_pool_recycle_direct(rxq->page_pool, page);
 			ndev->stats.rx_dropped++;
@@ -4562,6 +4563,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
+	fep->pagepool_order = 0;
 	fep->max_buf_size = PKT_MAXBUF_SIZE;
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
-- 
2.43.0


