Return-Path: <netdev+bounces-146148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12879D21BE
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8076F284AC1
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ADD1C1F0E;
	Tue, 19 Nov 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ETwhfEtp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38FD19C558;
	Tue, 19 Nov 2024 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005604; cv=fail; b=exM5dLl1xJOT9ONGaGTQUZQbJtFpAWj1CRg9SWVaYYXf5Cqhsasp2U53A+ham+K/VvK1zFU/sI9dwsiJkOzwKxaUkMrwFZrbxzhyb/xW5JBzb2TEYm06h10XvLPlIbnUevNW9MN+9Wa8Xmk/hTtspYT1NHzOrDJ8gn+Ru5ZfFCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005604; c=relaxed/simple;
	bh=Kve0H5+o37kDdj12/XZbbiAVDS9NZyL01nZ2uyO52Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dkiUGXkSpQcGA8+I49yRAARUwpQRYh6o1ioUSnRxOR9fAgUwNJ1Pgv4SohWyXlMJGkceAWWJ3COMHpnbBapRBb3K00QZJYnQxfbiDH99awnEqSUBTAR8YEtnQyRuUf3BRIKvlMkTWHFaUskS3aSda1/KkRQePM5dOIo4aDStVOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ETwhfEtp; arc=fail smtp.client-ip=40.107.105.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWC7WeXmswOUe6AVklTjcsN9J6UbCyzTZlTxzO6Fy4Xk3E1j0axeRowTZQWWTBwvrxJ3rE5y2k7l9BQAimcCeZ3lqXwzn5mmCwi3AHOpq1lnU1vqjBXKnM/8rj0X/iYpxGxC54Vnd2NaqcxN9zdY1lMLffQvl1oCcqMQYs8Aaf9RFmwuCGylgK3+YOsIEdQ0d7rpye14PO2WZLu6nN2joWGn1iuG5vfsGdmr7eiYXJkyYRIB+JsvYLzyYMaghJ9590p7plJ3gcbRQh5ILwth/ZZ+GQKQsv0tifpPQVwoTkw2COzEqPq/wJbQcjwfbX3mZ4EiIl+wO/L1BM2dL1hIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWi/3hfJJLhdUExR37GH35NJkVcvWklV8n+CoIbZYbE=;
 b=QPUjZjX8Mw4KTSvn1jtw6uFuV4EFHJuDnKnBfR8Naf2IjQ0rSh2WxAaT5RHS5XDFVeATWPtqWtYpTApBfHU/ZdOblcncoZ/hNRYRbD+JutkiqILR6XoCasgaBnN6fpFQoaxsvDJ2SZeAGBjPS9+rxVvqV4yaTD/pYrMS3ozTcZzCzDLqbjlE9n5N2h0XkbfDxvhZiSPmKjBUl7ZZtTvryu1DeHadgOTfSRqtkfFSRRPVF94dRAwsNBCPiOeFfwufSxeZSAWxO+ClAFxh4ckpufg711fqYFeyKPbYGp6/PrmfBvhQLsL46PhzOSgqDzFMS5sZDJqqnKwM4zhBlzEYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWi/3hfJJLhdUExR37GH35NJkVcvWklV8n+CoIbZYbE=;
 b=ETwhfEtp7o4GaARz8ur+o4maT2jTGkuZ754nzphPdTe+/ZYuNb7J5aoOa71VemrIr9K/140/yShVY0teM8lYRcKY3ci17H0zcuLSLgOmrMFUIRxN5dwdGxjff5k/cW77psAQbI8r7Q+d6d0pa9CASPOidOEEKjXwuaJHSmctT3jPuIb5Az2Uv7Ffa43DQDbaNrbu10/v92CVxY/ABpcRCt9WHyqJkf1KZh6D7dZxEWAGGINwer3O5And7unPQaE33nfdyFDbBQr87kCD73PI34To+5UH00AcNUmsxLwgvoKWd4Sw6chXn7HEKV5xmSYyLZljNy8VcZCyp6+teOn89g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10266.eurprd04.prod.outlook.com (2603:10a6:800:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:39:59 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:39:58 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 5/5] net: enetc: add UDP segmentation offload support
Date: Tue, 19 Nov 2024 16:23:44 +0800
Message-Id: <20241119082344.2022830-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119082344.2022830-1-wei.fang@nxp.com>
References: <20241119082344.2022830-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: 6539f024-7d6e-4dbd-cbd6-08dd0875c054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ndT0OOpIa9fYBnGjwqQd1eFvYYaVHCDhgxpopQrM3gw70ZH1BRBjniF8MpG?=
 =?us-ascii?Q?urzLb8+BSwB5psVltNChDew+0nmQjmDdURFwLH74QLQaKOIdpK3yaIuk09o5?=
 =?us-ascii?Q?PuD9J31RuDQUIWoNmvHvp6CN8zg+k4lhAEpekk/sFZdwwoVnIwnSk8G2Inuu?=
 =?us-ascii?Q?8upkymqF9vKSYqtpJaP0KctC5RIPVLSubjNnMhVIpdmNxeV3sS37+f/RfK4H?=
 =?us-ascii?Q?nqsH9zdsUoOCtA64fmsn9TofQWFzhr9/vpur7qRz3HMa5lZ2ll5+EzJFoRrl?=
 =?us-ascii?Q?ZTvv8v80p87Ht2Y3qfhsOPPoFWKhOcogWmVcKEoAk7+ImRUbaRYe+DzHyFSL?=
 =?us-ascii?Q?9S614Eoc7hpKKGOVOgrb0sueWNv6cLhvUyKuG9V7qnSBKQfPMQS3oSqJW500?=
 =?us-ascii?Q?aeMzZogtAmzK543TIcRTxIzzojBeWhAmEmgWRgpXXtcHtHSdxmvEnRwHYNVs?=
 =?us-ascii?Q?DMWLSrwGCEojCdK4px24sIMFn+N08nn3oJv9xkKQyP2q969jPm+RY7Mm3och?=
 =?us-ascii?Q?CMrGWgK+pj99m/WsXLewCuBptnoKXrdZgXjipiMjN8LmqUyoLLuTsseA6kK2?=
 =?us-ascii?Q?lboQMFpa4khJVL9W+5brItQXgLIH1Z7EF2AN3FvX8diJNGrxPjygkqO+fSxs?=
 =?us-ascii?Q?S9ElR0qZenwXu1aUmoVgovn2smryS1zozeqlgSfVtLI4fxPJiiyMezbL588b?=
 =?us-ascii?Q?rSw1vxwq+99enC4Qg1ryoCvq0ZtDbd+b/Ho7X9urfyB6jSeRfCHibnwG/jIv?=
 =?us-ascii?Q?feMDL4pVx/BUyStOfzhrcIGoRU/mMW39PtyK0MXTC0jnIdbXlmDNgmbUKJ/F?=
 =?us-ascii?Q?fuCkeoL5RC/AK3AbnUK45Hz/ElcmUKurmhW7RjrpQ9ZdS1rcnKr1APLcKaKI?=
 =?us-ascii?Q?5HylLoUy4Uby5U8XNOhKvTmTh7Ru13+ujkcWQGikmRvGdYfWgyJXOValL4A9?=
 =?us-ascii?Q?31Aw2Vt0BEzc8S2moGN6Tsc7p+m7XCVr7enZ/8S1qr2CC4JwOPMpB9kOr3pX?=
 =?us-ascii?Q?S3IGKRQZAXCrJsEp/q3r7RZ2gdcueC8T87hkF1BcMEnZYlH9Rkndi2AZdoJs?=
 =?us-ascii?Q?4mTqWbuz4O3OthE4KCTRw1t+vofL5tW0GDNBNvB7eg3VPlwXxundIAJcKyac?=
 =?us-ascii?Q?X5/oaq+M2oZJL4r6UEY4GA15uLKyh3g3Tmq7pKp0fizzLbGp/kAm+mrQfFgq?=
 =?us-ascii?Q?zAnZHHjohcGJcVGad3kOFWybhil0maGKlKta8gsLcoRJ5dMCHhfIjFich/kv?=
 =?us-ascii?Q?uE3tOcr4o9svmN0t1Yh8taHzcweoPQjZwdZxhYw8P8itvtebNx7B8ead8nRP?=
 =?us-ascii?Q?GFPb/reAhLmuI1sphSFVAma0QVggJiTzWpfiD3rlqClzDXtEwyPO1ML7W5G7?=
 =?us-ascii?Q?pxx4dyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?twsroAGYTMD85alJzc7pxILrmAq4XMdKFlS5dYlMrjTLnoQ+xoT+1rqsz9bK?=
 =?us-ascii?Q?0u7ikgjeuIwjrcif5m+CQjA1LGcJIlIjPlu5hnIcUQnd2W8Y+QjQHJ/6WVMm?=
 =?us-ascii?Q?FyFyjyVrFS4sInbLjcPl6nhdYL2JQdm5hwylgF99qLCK6wJRjlmG/6sciVUN?=
 =?us-ascii?Q?CQjPW8/EpE1YAs6i0zFQduVrpZjouDweY9s5k3sd3eoWT3uxd4H4jNqBbuMU?=
 =?us-ascii?Q?JcbP+RRH4aNBorTm1Xfqd3nBS3LtarB91r1hRT1VXXe1uhv5WAcRLYDcOb0j?=
 =?us-ascii?Q?rn7kTkP4oPJ5DrRt2cBVmdUT54scENHYT3OOFJiSwYPdHJfH9sbChh2gKlkS?=
 =?us-ascii?Q?bNQZDl4ISFXLiBAx8U6N46k3BMvVunSF+XBxrtGjih5y8a8ppi6hmY6gnW7R?=
 =?us-ascii?Q?Go4EWXLD4AXAiPKS8+Q4FimeXbfkkV4/FpVgYHMkrud5c53ckIFZ3yt7BKUS?=
 =?us-ascii?Q?3wFdpG8Fup8L16daG2+Ho7tIOSQYOoEHcswxM8gy5tQiruJNKNwY96ooKgXW?=
 =?us-ascii?Q?qbjx8xh+ubYvoJ6PBNbkrFz2SabWVOoP5/vi0PscOY7pgxgEDwYwSqp/BSvR?=
 =?us-ascii?Q?nBusn3qpq+cg2VB27W9WDJHY+wD7igJXatMr6Qs4PLbtqqriJTwBf1EMmRnm?=
 =?us-ascii?Q?7Jjy39/PnDHlqsGPTH5rBnu58V1z2wANw7YJYejFf7L89r4WZudHnlts4Ivr?=
 =?us-ascii?Q?NORqXTAUlRPJekcBvTOGrVgwjmfJQDW6nxPTwC0nna/eDqkF1Wi4brW8c9KW?=
 =?us-ascii?Q?V7vlMqe5WRg6pqvtScWvhOUWZSOwCSDylwjlknb2rtvoQnnLncpSk+Jx5ls/?=
 =?us-ascii?Q?N7RuLnliOYLzSEUpAazROVjWreja9DDX4/7bw4750zLzEy4PAYRlMtaiE/u+?=
 =?us-ascii?Q?8M0eexS08MDaVTQRbM+4nX3gRzfYQ1vG9Gz0FGdpe5D8ajvlAAbNnxxe7K8G?=
 =?us-ascii?Q?23MYWLFVR9ki+vsLJhPhNJZeZ/rnmOy5vr12hjCnxgrG7kxUxC8FjHLOizTB?=
 =?us-ascii?Q?p741fw2KCWppqQR8F+ESqTxRnXGKDwFTS0526R8URLY7wHCHBUh9ERumVXzS?=
 =?us-ascii?Q?gRMyLAhl7NtLhWVcmy7uFug8SSxlTJMrDi41A8acecb6A4/ZW4j/T59//KbO?=
 =?us-ascii?Q?8y/CShSbpwM/a2alnasfElxGHGjsNnGXG+9yB0QHUb9blOitT3kn4vuBJqU1?=
 =?us-ascii?Q?2ZMBwPASJepKUG3+vKPxsp/yr9CTyZwjsjZyFXj+anvcW1FJY9TbF5vnyVn2?=
 =?us-ascii?Q?gSDSxHMlf81UlfKftd2ZJqgy+2cpz2TS751FfU7v9WgzcihX9qYI2jbBl0AQ?=
 =?us-ascii?Q?H8xUXVhF4vbJMPN7PnNOK0nax8QdzzUqCLrtO8G+INsmxqECtvNiwLtM0sMH?=
 =?us-ascii?Q?yBFDiYWsZHt6wHNO4fxpS86xRU2wteP2nz4Sy5tsQi16e70tQWbXzEhZh4GI?=
 =?us-ascii?Q?j6qYLRFUu3+T0tSbAznxOxmg/wKZkyuPOomka4wUIMTJ+jp1SgCVSPCq1fvO?=
 =?us-ascii?Q?r+bzI+MhwP1ydZrIbQkfgSHMG0YblixcxUtSWWO7UP7IYi0LF8AQPOJhWwy5?=
 =?us-ascii?Q?8odcITPSzgzAyB4YQ9C/IfsPuTpuUa3pAdHqIzvf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6539f024-7d6e-4dbd-cbd6-08dd0875c054
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:39:58.9282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHL8V2r+qf8z3g0eoZ87+Ji9hoh/h4pMkNlPT7iytW4YW5kCMDtgDF/to2eUR3jR6oJE/mDdUoWRw5P+RwYxSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10266

Set NETIF_F_GSO_UDP_L4 bit of hw_features and features because i.MX95
enetc and LS1028A driver implements UDP segmentation.

- i.MX95 ENETC supports UDP segmentation via LSO.
- LS1028A ENETC supports UDP segmentation since the commit 3d5b459ba0e3
("net: tso: add UDP segmentation support").

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2: rephrase the commit message
v3: no changes
v4: fix typo in commit message
v5: no changes
v6: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++--
 drivers/net/ethernet/freescale/enetc/enetc_vf.c        | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 82a67356abe4..76fc3c6fdec1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -110,11 +110,13 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 052833acd220..ba71c04994c4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -138,11 +138,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX |
 			    NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
-- 
2.34.1


