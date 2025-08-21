Return-Path: <netdev+bounces-215753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E70E9B30221
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE54B63342
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E443C3451C5;
	Thu, 21 Aug 2025 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gifV9gZ1"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E22EC55C;
	Thu, 21 Aug 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801247; cv=fail; b=Hpjkj95WTGcYWQeK4iAgg0lqNHB1Zp82nBV9bVNOfMPpDnOj7NfnDl9hhDeWXqxHhv849UopjDIzRXdT03981ny3kr7DXLr34GynRMxlTB6W9zVxd2gEcgXyDGrr8CiG8hbkCGE1MUCbFFSSP5pnsP8H8uctd42J/GR6rZFdaxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801247; c=relaxed/simple;
	bh=YEMW2SItxBq+qvqoprtjI0KFosgB6bLeuXXRYjnPMmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rPBgycACdbb1AnTuPgfVnZDyyhZC3u/f+CbDjTpgKLva45LfbtL1tBFT/nvRTLJM7gYrL/9FZ7eAziqYa93E36wXPHKjV8ivVg3N+JmItOatEO5PHv8C6LL0Vl/QQ/4JmbXa8grGwzPLelY1yz2ivpWn1AQQs0bHUj0MKVcL8Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gifV9gZ1; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ssq6f6uIQHtrLQ1wdff5QQ7XjF1WkeBU2e5AGB79/bhLO3YkFG73sDie5Xs9E2JpB6vtYGKuMqAdfGfBsouAY23+8Q+ooUidz6eL/rvxq1JHR3WiKkkbjpl9P8RWgpy4hvAtswEMbb3Pe67y8VEqnxwrJ9ydHl08OXbClpbog6Fp40HWKdzzbtt+QiggGmaEej4bSU4kaCxIlp2cvsTFPW3Ib3WVem7Lk/I0e0gVNDIMmnTJMhPRRvkt/K0sW9jWE3kGf6qvb2SilN119Qs/3OKg6AjuZYSKKlNpO8zijY45V9ATnZ07Ry9SOM9PUfST5m51t3NNAlqBtSVt3okoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO/jKpL+5zI2yJs9eUgWZQNJntlu0s76vdi9EE2lqNg=;
 b=oa45CNVi38S1BJmtJC0t2L962UYt8Rr/cdKFfv6YKs2IJSKOzeEdjtycNhvP9ebB8KYkhygSDLvxxovnQVd/uCTQdz15IDxnpzNTAZjHj8hYP5OW+IlU2D3I7F5qelK5mvbCOaYG/9VAG840zLijjsCaXwngF0fmvMavKCuLPVEIhOSam6DO7HkkQXnGUWBY3snl10cWs2Nr+PHped3hrOI9EIq27gyinsK7Qzj4WZ05XRzxhCfS0hPhDoILQe1JBCd637ICTm+NDhBvQpunv6ewjKffb7QMIyrGzkFGm6qQYWtZ6txd7XE5WL9xqCtOEP9j0N1WnzkOPyvt8W+FdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO/jKpL+5zI2yJs9eUgWZQNJntlu0s76vdi9EE2lqNg=;
 b=gifV9gZ1VZNiSdBht7XZvWF2BrRCv2kKDCL3JJjbzLSs9XgbbnW0YSKgpWpFqfNnWmnCgzFLSk2o6k5up4SUIMK5D08L2GKrACkyDxKXkXdmPsYDWMH0M+L3Mf3aKCb64FJZs6jyO9zpMb8Q9MTUWR3NMLB0DD2z6cP1QXP+NnkMGM3wWgw8pk3WdCoraOuhSPng1B88ENozUnQof3uwQGqAeVF60vggDlbEv6DDTK6GDxySA7yY8jdPBDpWC4auvdRPvN+tL8aZjDITkXV4tRggzdNf4OiO/lMkq/+jg2ogMFWXwXYkjICgPhWf6J8hxm8uQ/fhEAMTdTNbKNm4gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DUZPR04MB10037.eurprd04.prod.outlook.com (2603:10a6:10:4d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 18:34:03 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9052.011; Thu, 21 Aug 2025
 18:34:03 +0000
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
Subject: [PATCH v2 net-next 1/5] net: fec: use a member variable for maximum buffer size
Date: Thu, 21 Aug 2025 13:33:32 -0500
Message-ID: <20250821183336.1063783-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821183336.1063783-1-shenwei.wang@nxp.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::25) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DUZPR04MB10037:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b687b4f-a837-4ea5-6222-08dde0e14d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evItHWgfruFnSns78apJylp3O23csbxzDAa/yDYYpV0XYCeBqWMGhzpF6w3Y?=
 =?us-ascii?Q?vP6JjBUhBhs42Kri+VU5+LJkyo/9/5FgEmW7wpPoVEYxeNDa7askCXQ4GtQL?=
 =?us-ascii?Q?rQFqZVZrf90KyBhz+JgNj6T34sUZB9t35/V/Qza4Dx040Yh58V1y28USaA7H?=
 =?us-ascii?Q?+vwP69qvt2STixUbTxuWdeHbrN6xdOdonKYKifRZoRIbrekXl+IgnsNJxDW6?=
 =?us-ascii?Q?W+0qvPibpVMrmyZhxnyjti4xeX1mvr+8Mb0syovDwLtRquUpFbw+Yn0Te+9W?=
 =?us-ascii?Q?S9Pvx8u9nAa1rt9PFShl50M5OykgLNfWmgVZTFRPhPUd8lTSLO0COz0+wkNj?=
 =?us-ascii?Q?zuGEdkkIVNuSZxigQ7JheSIk0L27TJ3rw0oqnrk50DqsOwhjtzB3jQF3b+y9?=
 =?us-ascii?Q?aN0ulk/eMUiVT7zqlV1q4CAwyeFLX3K1OnmkKsWMsAtyCYuuJXPTSuPbDssW?=
 =?us-ascii?Q?fhqGh3lOD1ls4Mxc6GzxensfciR0KM+eRKLMtHtsl41IZzjuqoR7XEI3hA1Y?=
 =?us-ascii?Q?0vqH30JqHovuFWhDo80oawD1WspY3dxGIe79BUNwIEiC6AHK6Zrkm8BBbmis?=
 =?us-ascii?Q?0kf9XpzoOMAQFjVvkf0trTx46lPkzu9UrV1fV1eFKfuyBHklV21yJ5ZEDoSF?=
 =?us-ascii?Q?DiFcJs5wG3uI4vg9ay05EDct7hZ9zi21QWS5Njni4i2FR7jxyZ5/tTXLSaq7?=
 =?us-ascii?Q?Lg6JXGIzzmxwPgqQEhxTsm748zHEYTHgRLoiog/INSQn5GH8/6909NktpbKS?=
 =?us-ascii?Q?p+mIZ4K6HQrTXneJn3GOmTWlhPew7oNloZefveV2AJdQcIY/SbSn7aJSuN9M?=
 =?us-ascii?Q?2FsXwpuqwwqyFIRBfZqKtHKdce4qtkYWWPZX3zLBKlgYmA3a16Workv3s3FE?=
 =?us-ascii?Q?vPg3AZz8tDnbOt/lnaUdMpigLXxghb7XdhrHI9IiZv7mH8pcm5sxsHhDBT5Q?=
 =?us-ascii?Q?8RaUKaMY/aJVj7PR5UhEensYmdpcQRURk3DShcgfDBAq1Hl6er0Z/NUuj2GW?=
 =?us-ascii?Q?2NMm3g8d2FglqIq3lJFCzF/dv4+UxaP9rNqzECuAc4RaRgo+IT8n5EP6DCWr?=
 =?us-ascii?Q?o95ARiwCZbCljIX65OvgnYXAHIzyV5MN3+jX0FlimHk3RN3OFWu/AhHWJiUF?=
 =?us-ascii?Q?y86GXUU4GhxsTXDrwligr2KySoYR1F5OmfgIHY/QjOjXL+ZJUnDdFuWMsJRm?=
 =?us-ascii?Q?nDL6p9UmlViz6TvMtT1v623yjaEaQrnivaGJMYZ6wMzIVURZJ0oaPkkv6OuY?=
 =?us-ascii?Q?oouxc7jUYwrPsRTyIuhkFyTZGvqsL8uGF3+ODKN7jCGyln/YtEOOP1pDYKLD?=
 =?us-ascii?Q?5yErWDifMp20/8/bUDwEv/2djheLzJswdZUAhxUOhJ4mcaTyFmJHx4FV0HzK?=
 =?us-ascii?Q?fxk/C4op8X8TymlmZMMyvbL417Mxp5pjVHSlR2XRrzXFD6WnBUfbT6nONAMW?=
 =?us-ascii?Q?qexzHEKDSBK3rVf2g77hxo/TG7X0aD33B+wkaqNOYL0uBgPZbysA9e3piA1W?=
 =?us-ascii?Q?z1z+qdPKLF9QnY8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k85XSZbnWOYdHYlXN6Kv03fUonW/XeRYyajxDEAthi3ZtJOk47FqfIEqNbfs?=
 =?us-ascii?Q?E91GCJICobGXQhTHOoFl2/VdVlQw2SuJO08OwbTe4zEUMaG/yGIiQvi73PXD?=
 =?us-ascii?Q?yCk1imez/Jkf2AhlvwplWXD0XnuIddwWm8Iu6ONm/qEK82JtGXz2KNrOOHUJ?=
 =?us-ascii?Q?tYoUfIRQYQttWAFOA7Us+CR5orb3ZRQRy0SphJwmTndBP6Kh9ev7BtcLonq1?=
 =?us-ascii?Q?qZsNVPaDIksQSo49ai3spMgXBl694+9dJmbZaWNXZ+zGWk3FLyLw4ODKNlnU?=
 =?us-ascii?Q?k3nnD8ixzkD5XqIJjLbHRaU90JJ2k/XixX8uSTjjI/PpGEQ/LHEw8MJaTcyN?=
 =?us-ascii?Q?dmDhj+/I5w9ExCUVfaH+qa8LBuar5iSoSXc4ofPc6Xa2CTc8Dk2BRPwIsmJz?=
 =?us-ascii?Q?jra/2k0x3ad1oKV5J8eoU54XNjsyBYx8jfl4Ru1xU/HyX4LptOspfvvCzIbu?=
 =?us-ascii?Q?lqd6uVinhra81o5HZu/NtpGQNb5xasJdbAU4GT8kU2qKsq3eiSbnWolbni0P?=
 =?us-ascii?Q?RnzWVZG9nAOAg0HZxiMdugyzkG2DFvFePNzU10ee/qdeJycmMzddaZb43t9C?=
 =?us-ascii?Q?WaS9VuaKvi1QnBi/8b8MjctgAhDeLWimQAjoeX9SMec6Ux82YKtqpH5gjen8?=
 =?us-ascii?Q?SDWgvIWuGjTFlYaxFtPfsecn2kpjPyazM0Z04eTinuITThN+BXj27NWOFugi?=
 =?us-ascii?Q?LyJ6mgE6oYZrVb3C9z/HTznjyZRyVGPMqpNqcYFK9d8Fq8ikhoksROK43Y4O?=
 =?us-ascii?Q?K3cSqbe3/TI7QNKtyorPhu/WU6kjMy9PcUPEP/WZ+MWshk8MlfWj0xA2uF5d?=
 =?us-ascii?Q?fgV6gU6hTbse+5Dq1gJrXEXm5jwaVKSxZpraXyCSW6Dk0yOOI6hJN2Qpxq9Q?=
 =?us-ascii?Q?PTqwDIuCsjSXPmgEp5ehWRD569mH1Dt694u4nF3AtnY+EGkMmN1z4xLI9DzM?=
 =?us-ascii?Q?O72971utt7KyuifTcAjCuKcc2Gf785Ef3ebN14KQVGVkHsr5+k0LP/z+iRvR?=
 =?us-ascii?Q?5iDXxyOO0Gf4h6DScNe7wnuLE7YK9HSfhEm0K7A+YhC3BnTlvhTjuzyNhHdm?=
 =?us-ascii?Q?+qs893gMgo2a2ztRAcBMAHaKLpsu8FN7okjJDUzyE2HRcpOI6boQZ9VCb1mx?=
 =?us-ascii?Q?kdKCPKuRDsj7azzZxuJ3ECjZZ2kro/bmI2drSIAaltw4m3ijC4vmEpyBuGkE?=
 =?us-ascii?Q?BSN6wA39sLgdNxznrBN0N+EqjSI0+3dzQe6YBCwWxRU9B3+swPPWq5h3K4ek?=
 =?us-ascii?Q?GAMBTPh9EhG31GKAZIUYH0EqQdDE+bbhDc5JeB0fBJMdvYB70Cw/n2z/XYr3?=
 =?us-ascii?Q?8p9FQ9ZF3ItNDZfIGg+UgVro6Nf3AbTJ68ysVO6rbh5mW2yv0LyykgZBN60p?=
 =?us-ascii?Q?2oQFW1ix6MqP5J/6ZegNqqIU5tnYJVka/ngMCb2LRIiHCeRmuhnvZCr5eqoT?=
 =?us-ascii?Q?gGkSIZMypFUmXi/OC1B/sI1IpgflYatnzVxLz+3dw2v3uic8BkCRnJ7gJffa?=
 =?us-ascii?Q?lSLA7NBSIW8IEuAxM8xHRSWWnlo8jQyIJWMij4QTnEMA8D58osCDwlNS9ZRh?=
 =?us-ascii?Q?Uubf9hBz/wdnkF4uIZS5rHEXSDy/83RbVW2+/uIb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b687b4f-a837-4ea5-6222-08dde0e14d7d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 18:34:03.2018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDeFhqnEun+S2GxPsDflex40Rtqb8mO9KfI2VuO16vEDIh08eGKpvGySs8FZIDX8Z9z3k9OBSf/sGovEa1DwlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10037

Refactor code to support Jumbo frame functionality by adding a member
variable in the fec_enet_private structure to store PKT_MAXBUF_SIZE.

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 5c8fdcef759b..2969088dda09 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -619,6 +619,7 @@ struct fec_enet_private {
 
 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
+	unsigned int max_buf_size;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1383918f8a3f..24ce808b0c05 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1083,7 +1083,7 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 	for (i = 0; i < fep->num_rx_queues; i++) {
 		rxq = fep->rx_queue[i];
 		writel(rxq->bd.dma, fep->hwp + FEC_R_DES_START(i));
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_R_BUFF_SIZE(i));
+		writel(fep->max_buf_size, fep->hwp + FEC_R_BUFF_SIZE(i));
 
 		/* enable DMA1/2 */
 		if (i)
@@ -1145,9 +1145,12 @@ static void
 fec_restart(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 rcntl = OPT_FRAME_SIZE | FEC_RCR_MII;
+	u32 rcntl = FEC_RCR_MII;
 	u32 ecntl = FEC_ECR_ETHEREN;
 
+	if (fep->max_buf_size == OPT_FRAME_SIZE)
+		rcntl |= (fep->max_buf_size << 16);
+
 	if (fep->bufdesc_ex)
 		fec_ptp_save_state(fep);
 
@@ -1191,7 +1194,7 @@ fec_restart(struct net_device *ndev)
 		else
 			val &= ~FEC_RACC_OPTIONS;
 		writel(val, fep->hwp + FEC_RACC);
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
+		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
 	}
 #endif
 
@@ -4559,7 +4562,8 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
-	ndev->max_mtu = PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN;
+	fep->max_buf_size = PKT_MAXBUF_SIZE;
+	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
 	ret = register_netdev(ndev);
 	if (ret)
-- 
2.43.0


