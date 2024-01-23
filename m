Return-Path: <netdev+bounces-65151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B03598395E1
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D191C23176
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F23823B0;
	Tue, 23 Jan 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EnDcGY3G"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC029823B1
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029421; cv=fail; b=jCOXLxX1Ccv2gkZE+72uCp9oq+4k+N2QPjFpg8puMYukS8SB426nwHyDpisohoigrA/IXC3XPH8UZSxlsSbPPHI/qtcK9+eh5VZNhFn0i5Y9jf5TPXGw9fFvCSRdoE+Zbsepju8lika78RDqbJSO/HCxPWoMK5X4MZSa2LIux+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029421; c=relaxed/simple;
	bh=0NqLJjK7NI8bztgnLwuy4h3uVeErDrgRgBcOMAFq1I0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OyPNkFI8NOviMWcPcllIycMG0DZlAkCjcWpp/eHULrsnRdKflxsCg/zWYpctAM58BzDgoPBPcMK7Mq5LGha00XAE6vyfqb1KmlyfhbwpYg/E200LgBh54fuTTBJHnf8BC083YXRa9vdcKooNQ7Lc+S2XDecDxgv7xtJUEMm/Izo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EnDcGY3G; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJIKAp/zAAoUYXgYpaHCaAhvNPXQCROJF3iwCqvYhWmjSQPfAxr3zOcrn8Ir6kdQJCcBXdZyNgCentvhvzslGqFQjNdNies7izPx70BehfogOYsmwX7I9VIfhDBgoPsaatJ3Bqw8NzIQIQqnQpsU3QUoBAphLC7EFn+AZfq+XgWvSPSvXVJMUd5+b5vUZKAaL7xzBQA1WjChz54fkzdIBJ6aLaSUumU2o622NqR6cxs6lM/qtbk6jYIuLwmMVWLOOVjq8MNRW0ydzb+rZGAbSma1kgc0WY/liRT9PMxcn/IlRM/zxXH0tPxkK47ZU83VjLq6kOv9VFDD2elU76CV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eegp7hxhb8UihHpvpE75x9XUTC8pUX9E8m45aE+moVI=;
 b=GVfPTMhdu8pi165QIXq+Twh5zI9wyKEbRltg/Y9uTo+UlE2uVpYdO1ZF85odjf99TfQtap9DtzP/2oHiqbpzDC8gzQSCeD0ZIARI+sZNvWnMokO/5QAY+WQlwHSN6SSodLc1KUaqQdZ+5JiJkjA+oJv2QFH+sIkHkzwnW9xVqX6ysSwKp5AbFgrIvQkBdtqq7uc7ks/gzQSPycM4zNnmG7Tm9Ho8jFTEiZKVmXbLfC3jkUMl8/jEtz9B3vYj6nzs67nrB7OcicC0Ix0GB2m8nw4V+8TlAWxgQRaolsv5hM3NZpIio8gQEr7GPGFUYQorihUl2Lkq39g99pVpgGNb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eegp7hxhb8UihHpvpE75x9XUTC8pUX9E8m45aE+moVI=;
 b=EnDcGY3GEmf+cMNCSGUyAC3MlK/ATz2LW0o+YEyzTespC9MftqTwF7zv3wllgzMTlqQQjXfX/Q7pvQyev3sLorHY4xulCTW7ylNmYhw/JcCHxR7pu+qIrINP4h+6JX3CCZwUsyrp8d/yAzWFSWdRz7Sqjk4xNwJjRIVujJnucNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB8PR04MB7116.eurprd04.prod.outlook.com (2603:10a6:10:127::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.29; Tue, 23 Jan
 2024 17:03:36 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::bf80:653e:1f4:c58e]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::bf80:653e:1f4:c58e%5]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 17:03:36 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Fugang Duan <B38611@freescale.com>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net] net: fec: fix the unhandled context fault from smmu
Date: Tue, 23 Jan 2024 10:51:41 -0600
Message-Id: <20240123165141.2008104-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DB8PR04MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: c16439d1-5330-48ad-b685-08dc1c353d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+u0R9WHEsAOcFi7KhpfkSARsdqO+oHSVxYPH5tZA4SPbzRVmau6LtnCTb8RepJ6goEUqVdW7g4j077haHluTPXfQrYi10qw2nHO1F1MuY1nKXBquU57tGF9ZHvkcFTFljSXDQj0jFsi+Y8bOT12+jBH7+a3+wInBKv6llVQiPmYCY72KJTqID+4B/BEM0J5H44PMvXilwhhwT+zzKrQeRvzPqvzMhu7fwC90m8mXj/LLCH42GO/bFhQeKhHhzS8Tq5gYzWHlFXc5VW4XnopuVUbBgG91G8MEyumVGh0CM6pk2yjaIsPKFz31Ijeg1Zv1Qn3esmv1m4GT2ZVAKgbzdVxypr1/W34zP5BbEJ/nx4c8roBenN8v1AbSMkcC8Yh1caHHRTdOZ0nh/gazwWe9LeNNZWHDUSSq3KsqD695mDBXGg7nOtjB9d5mP5dMSzHkIxbShuiYIE0FxvL9spILEGGOKGPyMrXs/5axG1Qplqi2B9mPGGCWSvZIdlSVN6/kvHyjhhyXhVnLN0hBYyWDuiHXLlG/Njih8gDLzGg5byrBpcnVHMWZn5j1man58B1A+gImg/EYo5JClaE1btsqznYMXJOVNQQKuNPpY45zGJWOqqmY3EGglKTma2teUB5w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(6512007)(6666004)(26005)(6506007)(52116002)(5660300002)(83380400001)(44832011)(4326008)(6486002)(8936002)(66556008)(66946007)(54906003)(110136005)(66476007)(2906002)(316002)(8676002)(478600001)(41300700001)(36756003)(86362001)(38350700005)(38100700002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rKhQERmGSnUy0q8TO1HWboEjJhJntaPyQG3IHxoESzy2NciXO2ZJwhovkgTY?=
 =?us-ascii?Q?Cg7ssdk95am5dcXWd+t7QXhWRVbMABF3UgV9Mu8N55VVe8vvy2oKNESQWs0t?=
 =?us-ascii?Q?Pp9aj2rYxNZvRspO2rEFpZ3+ky/2JMDbO1RZBd7ssttJ6ORhFjXMiuoL8KtA?=
 =?us-ascii?Q?/OxvCeisa3uIMVLx79TTHJqmKN09DhIZD+yY0bUWReEmdz6cHzJR6V92ShkD?=
 =?us-ascii?Q?YfNCbX61jH3is1M3/gIXDEZXjCDWJetnFwpMU/kesSMqJSgkzJA36hlKI2bw?=
 =?us-ascii?Q?9wt1Q32O86k0FEdnH2xzFytNy5DIKKGaBGJq9f2bWebl+MLe7cw+WQdZqzRJ?=
 =?us-ascii?Q?PSUA7AKffOrD/YaltkgmT0R3cEm1elUKO9C/UOxIknOhk3C2fIO4IgbF7Doo?=
 =?us-ascii?Q?5oRsI4d04ips+VhPVzLheyVP6oIwuAwvwkRwfuo9Qz6KIe9r+aFtTtZl25oI?=
 =?us-ascii?Q?a+YeMH9z1RObxyZMBFXBmBM5zr9jhuUVwVBcUSaLvCMwQ3+JatCqHlA/AEGc?=
 =?us-ascii?Q?bfsLTt1ZF7WFeT6PBzn5HwdD0wdnkY9g2dqYzZmk8Pm5e2MFKbopVnsQt+tv?=
 =?us-ascii?Q?BxfaolrU+lZ0idagscYMLwWag3WHqTSmJVK0fU4LX2D3TzDsJtsqW6JjBs/x?=
 =?us-ascii?Q?girbV+pCQVz8ooepOLnYx47fPlw9q942Mh2x/dP2dWlfEB1sg81NuHUQcSMd?=
 =?us-ascii?Q?MkK5PcA/RoA0z/oAz0UcFozgM1WqANf12Z6/1fM7BpFFBM2GA9EvpCw5ew/f?=
 =?us-ascii?Q?Aa7qw8Mtp5RNTxFpe8V4Ym8vFTMLlhrwMj4JwXoaFx656mzrf9o0+c1ZjdnT?=
 =?us-ascii?Q?jK97gosw1vhZ6pz2tU1Oi6gFWjo7vPGj/8vrer8LjmBRaQcHnb1BNJXLUI1F?=
 =?us-ascii?Q?akjbwEhhBmnLtRssfKk1wz+UCWu05bMWjv8cYIonz+a+kYs5h0p0O72pWxVV?=
 =?us-ascii?Q?6TfohhvbCqE/hcbxm/wKp1dgHcSTlQJduPf0zzzND+iNyr26rcKslnYWd5n1?=
 =?us-ascii?Q?wYGontMBNuDqUdXONO0R5oNYbGwsgsWRPz+iJWkMepTGAIXaUNomiWnG2/9a?=
 =?us-ascii?Q?fp2da0E4RMOCHdbKq+eO+07tZtMErqgEasUFvvRLTi7Z0cMTzjkSQxfdjNNQ?=
 =?us-ascii?Q?0TQikoFE8gcd47Eh32eQzBtD6q36NPZ3NeFPn+e5wxVQLtZAlInu1Gi+0jb0?=
 =?us-ascii?Q?Xqt3kg+Pqeyp0SbKDThnkRHspQ2gJH+GhiswwR/ps/aXgFtAxC3NG+LARdDn?=
 =?us-ascii?Q?qLqfKgRzWuLXr68w3gEc3hnGQDogaNKiAO8XbG9YnFkrca1/DXwfY8KR/0rg?=
 =?us-ascii?Q?0psDDwYlwHGRiba89UUimly0E5NyWjnBB0adFRrGdH0oH5qAwDTO/8SO80H2?=
 =?us-ascii?Q?qPgfaDRiiK13RXZjiLhwNta3XZK0EkUFJewH1gqXvLKXh50yO66on8zgEfRB?=
 =?us-ascii?Q?Ej2un6XO6r1at5sg9uBIAS3lZBVggVraJqi1QOxKCaJwkSKoFpwwboMcPTK2?=
 =?us-ascii?Q?6q20oKHvet5wZX+MS5JBy9uboPtERe0hAjkvbrAkmqU0D7q5SoQAFRh9lC0V?=
 =?us-ascii?Q?y52n2Ywq/w4PVIsUG5jV2/9etLcDpI878R0YryEP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16439d1-5330-48ad-b685-08dc1c353d0b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 17:03:36.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DCeAaRv5QVi9Bl6R9NPeYtencZEPvkffyVeg020Aczus6vlsxBz2Z09udKmKZX+s/xUw7wgkt6G+TyYvRLryw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7116

When repeatedly changing the interface link speed using the command below:

ethtool -s eth0 speed 100 duplex full
ethtool -s eth0 speed 1000 duplex full

The following errors may sometimes be reported by the ARM SMMU driver:

[ 5395.035364] fec 5b040000.ethernet eth0: Link is Down
[ 5395.039255] arm-smmu 51400000.iommu: Unhandled context fault:
fsr=0x402, iova=0x00000000, fsynr=0x100001, cbfrsynra=0x852, cb=2
[ 5398.108460] fec 5b040000.ethernet eth0: Link is Up - 100Mbps/Full -
flow control off

It is identified that the FEC driver does not properly stop the TX queue
during the link speed transitions, and this results in the invalid virtual
I/O address translations from the SMMU and causes the context faults.

Fixes: dbc64a8ea231 ("net: fec: move calls to quiesce/resume packet processing out of fec_restart()")
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d42594f32275..f2bab7239776 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2036,6 +2036,7 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 
 		/* if any of the above changed restart the FEC */
 		if (status_change) {
+			netif_stop_queue(ndev);
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(ndev);
 			fec_restart(ndev);
@@ -2045,6 +2046,7 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 		}
 	} else {
 		if (fep->link) {
+			netif_stop_queue(ndev);
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(ndev);
 			fec_stop(ndev);
-- 
2.34.1


