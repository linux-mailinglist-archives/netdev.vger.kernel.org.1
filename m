Return-Path: <netdev+bounces-215407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6C6B2E819
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 00:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EE27A3095
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 22:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C21627E1D0;
	Wed, 20 Aug 2025 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gl4j1Rb0"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE57155A30;
	Wed, 20 Aug 2025 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728613; cv=fail; b=bYMQINRW+ogZ2XeUpGdcWPwTIfP4JbnfASMOe1OGisVosEmpuY6SexQ5ett4rY1lkAzfDaxi6ZrBNv9Px5+0y12RSEH0a0LUtd4ZnRGxYipHA8AU/tduQoIela0HCpOILmJ/Epd9PwT+4Ed/WpVpE2hEJfoh+V5gumLRV6KTgsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728613; c=relaxed/simple;
	bh=SRmu8K+I4usAkJ1eHVrOLPoH4moYt2Ok8fUn0cu1AzM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cjCKfvttTf5CUb4CzIQDD7wyZHF0xLrIYQ0z8Bfrg9jSEXwhjgUICzxhtcV8W1F+4qREnz0Yn7BLvLIVbPfApnt0pzCJbXH01w2jCCqhI7D2bSebyOlVrF7hmkPXBmjAvElqkGQZMurQ6whqK9JJAvz2m6w3ko9oIUBZho5dlg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gl4j1Rb0; arc=fail smtp.client-ip=52.101.70.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siZLs1JK4XvzxdFF1ggnW22OCm944Rze3J1G4faYAV00K2haNuLE3rtl6i+QnCfM9xKjKWctrdnzeykh9nn0sAFbF9giiweix9Qbg+DlHtef1T2cHb971ht7cQxJsQbDfUduzqiN4UiyYnpG284G1NDr5a4c1+Fs/swFwSI/bDGCeAQWcOOzn/UBA6vI81hAB6xk6HAn49Ho6Dm4fpZn8FnihZO7kPVNfjvs6zjuzQ1RCADeuKFhaydE3LmF8QPypKNwwl6wcu9cvZtx59lrTJ0hp3/wI01c0tNtBgg7TbHOUrHJB8NsYfrim07q7Iz0hjjayfvFP/yJadMbihsu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKm5YtnCwdswT/h7C9zQl4INqv7nLJu1IxOORFmW7aE=;
 b=NC3oHJoWh9OHNxJLPQCZ6iHFeutB+Duvy7Cp6lDD98CnP9kBpOHVjxgVd2o3BqQW+VhyImWjXAleNyYa0kswT4l2swQ+HPBO/jTH8nZikZsfXLkUedvn8+PwxiOW/HEe/Kfwazg1acE5UUPZtk0vy8otlwNbDuqZV9yH+/ovnQ87L6wMPG9g9aJPTJPDaVIg7qxtTJBvBfWbh6UTlK4BCv6CxLhH0L7o60hXmUQfNTjG6hrTxvpRFHLBif/Dmmoswav/c9N2Nq2lp17WmbR+lFxdITHzrMYuouRjly8ln0EfzoSBRqEyawWP9Ev1NJkXo8TG97y5JXD6jYRPtUPaig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKm5YtnCwdswT/h7C9zQl4INqv7nLJu1IxOORFmW7aE=;
 b=Gl4j1Rb0cmE5sPXQQIQAQG1srOn7HouZjL9S2FpVC/WGv5SONkJIYL/ZEJiJSbusNuApJnUBugPZzMdfxZflXpzQmbiSHpk3/c9qSRvFeMzBoMUlPo69yxjRTNfJBNPKuXEJNJhSelc6ESPwz+nqKkCHMF0ZVFTY7hl7hOOsekVtaUtooQepxB8Qkq5zL5XLBMjxKqQSCKFfxvJ4POt/WfiTTN8Dtvjw6bb46XOY6I/AEAZEuCE0hUclkxl4X/Vr4Zg10B8ryGV3KxOl7SteSv5XlxTtbvr6sysOY/g/D9bg2xotH8NkXgYXpQbQNveESmRj4ZjZJAaztaicrX9hdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB7199.eurprd04.prod.outlook.com (2603:10a6:800:11d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 22:23:27 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9052.011; Wed, 20 Aug 2025
 22:23:27 +0000
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
Subject: [PATCH net-next] net: fec: add the Jumbo frame support
Date: Wed, 20 Aug 2025 17:23:08 -0500
Message-ID: <20250820222308.994949-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::20) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI1PR04MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d91081-5a69-4ee1-e604-08dde0382f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+LArp5XSiddgye3FqJwXBo86DOKRG5cPsX/RLIs2cy8+kILg1Fj4QC1+Qu3W?=
 =?us-ascii?Q?uaoJw/pCMb78+tTbZ4pOp6f/CYlj4vYpWudwZOVBitSRww91FsNSEyi1FEg0?=
 =?us-ascii?Q?OJqZhwue9oJjl/xnKKyJBCvFBpZnu3Z23J0xMNMn0tT79UE6PClB8Ma6NE8s?=
 =?us-ascii?Q?rp75BH3o3M5dB1NeLjGtx9dSx4axOC/XoKwvoNWkNMtaO4eQQMW4n5YN8nbH?=
 =?us-ascii?Q?SlBOJBd4oGX4O4moWhYKOhgZ8xB5WFXJ5ZDIi8B/1f+HgEiJqv4P+VbvSRzY?=
 =?us-ascii?Q?uv0ChW83+ICYd/76E1aI9CwRgE1dW9kusu3hibB9XlvDWEPqj0tArrJy8P2r?=
 =?us-ascii?Q?39cCtv3BTbpT9Y+GgNrWBhGLatRQfePOvhSzHKztgmUEQVq7t76WZ+HVBlsc?=
 =?us-ascii?Q?rlCtsXaMnjBq1laq/eE+heRWcHSHhNUICx54G4EM0E1fcPKk7gScnOuH9Qxo?=
 =?us-ascii?Q?f8DcnVkccgFJ51ZDcarDl5hS+q4TcIE3HKC+tqK2GfN1QE3ZS7K1cFYNOiBX?=
 =?us-ascii?Q?Q9oNoWzrhMAhWpiSUqmpGBB7Rfb/D0UhNBtLrFk3Rmgj+dGCkcluFs3t+/xP?=
 =?us-ascii?Q?xYYxSjulowbjk/e01i40BQ7rY54XxXyD0AghZAhsRm4DtyLstOdhe9WgnFV4?=
 =?us-ascii?Q?FE3syaaUNs0rB445bnsNAMjuzG11tdNWYTkutF8BIAIr0wqGxb9P7HnLE60A?=
 =?us-ascii?Q?P19Rlwqan0gqW9d1CpS8PmEaI4NBXXLjWhQg95ri4vHWavARGeQ5RbvsKfXA?=
 =?us-ascii?Q?rj0g9Lbtg3ya18c98kSojRcqPWe74DVcWb4FdaQtsLVthFW7+5VPPwmwL69c?=
 =?us-ascii?Q?PDnBnqkJ8a4Akq9di2g+fTsn7C4i7uT1DN9dxGsLef9DamcxUTbzplppXHH/?=
 =?us-ascii?Q?k/IxuXrwQtAzfKdZ19bGv31jqbRSOFn+LY5NUvzYS/WjnMEH/cleRcSruAbR?=
 =?us-ascii?Q?7ZjL3Ke1AFQrUaqeZekV0pdwiuf12cELR8U11zirB2VpWghVRVBPgpCIBwXx?=
 =?us-ascii?Q?HncNfPjKusjte5wd7kAjDLeq8asVxxZGc4iWAWkZFQgLqowGoSBv/C8V/stW?=
 =?us-ascii?Q?xFoP4Ib/2UeqVPBxfEO8Z0s+st4aC6aMBnuNWmoxIAqF+hOmLrRI4+xjduXS?=
 =?us-ascii?Q?Wfdl4KQ9pEGC4rRx+xsCKVf554GnMI+OwXbAoHHvwLKant4uwBuulk1pnfCD?=
 =?us-ascii?Q?TxUM8RggdRRwRBl6L20okZDisob5cUW/U94AFzxvmGvQrZMhb613/105aWUz?=
 =?us-ascii?Q?ycE2jrb7rGTYgY/fYH/cQG/xrSnq59F0S+96ppiwWfZcKC0zi/LQmzQJk8Fe?=
 =?us-ascii?Q?aIdcNcMUXG7zwVtA/MQW3eDwlpFeoEFiDoRK18iO7UsalgLtMGvRtmASF5Gn?=
 =?us-ascii?Q?AHroRQ02flTHhELHR4/ZDjSHkqcgz1QB8Bbf6auX+2qeUOxPw7KRS2w/o0cG?=
 =?us-ascii?Q?+kdutnpI9CkCrNJT26a6HrVLi0VAGJHng1edyUz5w0SSRdVOQunlVdDI/2Qq?=
 =?us-ascii?Q?y0b1/aYF9P+jWY0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wl24jRPrAlX37xLw0AnoaH7QcE73y8iVB+igrrTY9oyn6wulssaIz64Vagtj?=
 =?us-ascii?Q?GjD83MdeuEnBEegypJWRu0q1y6wEU27h89SFUqD60Vy3n38JWWBeXWHNRMLA?=
 =?us-ascii?Q?D8fals67eoHHo/8oF3Byoxrx72+5qKXKdKJFN+LY9Uli6hqGKxpvojOaWUFI?=
 =?us-ascii?Q?9VcS2lPBRqMWMM7DSCJb3jJJEPN8eAm5PvwkKdZ1ctYB30kmLuhnuRNNfOtj?=
 =?us-ascii?Q?ZZqY08MGciPfwjgufG2XVfcMu2wr1tuwEPvLgUHXovKSAKvwk7+7u/w5+kS3?=
 =?us-ascii?Q?JRlp0QwWtrQK2yLXAyuBfdQCuQtGyThl+X6s53iq/hIDIqGYz00e+AKj61pG?=
 =?us-ascii?Q?li8WTIRVb8ZuEEbNOu4OI7LE6ZHwlyAjok1vl0hXSRkjT1LWRFwITJ3JS0Qr?=
 =?us-ascii?Q?IEr8zTuBVXTXrezv4mSGCUri9+AlOVl+MoyWuOrR148SrawJIpJGqkrecE0c?=
 =?us-ascii?Q?fjzbS3t0hA/rxmZn1tGYWobV/XFla2k6qgqQT3FcPcIU489U86igNwe+DOSC?=
 =?us-ascii?Q?010AX4tq3nIw7o65JpDhmxenGugpke/023TLvMcIigqTRwGS4wnZERy+XO31?=
 =?us-ascii?Q?MHNifeNWh8xuBmnVSdLzO/kHgvC+iiGnNEYqBFdrU2NdDQ5PwgmIF7yyo3qP?=
 =?us-ascii?Q?5F6Ex3hpOFwQQOuJpWOohiKw5UmexSF1DWDit40I3PgzEZVVtIUdAC+rf+si?=
 =?us-ascii?Q?hRnzaZxcKufyxnm8FQdG+My7puzPsaAPOZzlagDetEmyrJANk8K++ycxnriW?=
 =?us-ascii?Q?r91O2g2bY1KcTVH30gUxwr9r+4OB0lt2WE0rh3AnbWa4bceI3NKKmC3roHfG?=
 =?us-ascii?Q?H/7D5lv9ZFUa7yiqN1SvfPB5w1BuM8dnFk+TfWYk+jnhs3Nz9SZfDtdYxSSh?=
 =?us-ascii?Q?K8OFj6ywQ+daO1GW0Nn1d2ijYQK6g6fnlGZcQM/eQgMqXT1gWHhnfZMhJNrg?=
 =?us-ascii?Q?Y1QT5Fa6IxoXKpKyW5xyhrWHyLB3egpdpFZq8rLGumB3Zk94VxHdBVEW6qvd?=
 =?us-ascii?Q?WAVjmIalewcnOHTP1aGoQWlvXMu2z3/JPdN80fdJaCeQt13XORb3ioXUzQ6e?=
 =?us-ascii?Q?BF7SUEHUkljZOW2/Jv158qjeyMc0l596DCaxKibHMc/jkVeHBoCb7VIqbT2n?=
 =?us-ascii?Q?WeRPdDIjHvCwgmlKe/bAbk5jUrQKx5+O7cU6Fc19b9MZCGyby8XN1kUC0rQE?=
 =?us-ascii?Q?Wva/zqztV5zqjiigZ4MvYNAE9Y+oFI3jEM77wIBwNpNUFQYBHr4oWJ82zeDn?=
 =?us-ascii?Q?UV1Ee+IPphqbZUlPecCK8TzfRAAoz6/ipJ7GHfeSRW6XPF6CKEyRbvr6JhiJ?=
 =?us-ascii?Q?rd4mifU8j4ozWvc+rZhfPeeO1ATVqU7Yfvusvk7DnNxXqXHy1ZxWEWkPrdd1?=
 =?us-ascii?Q?WlvfNpIa0d6/paBD/ESigdEsmaY+NSqaUVd5UpHnrUBPkqEEOWU3DxkAJUct?=
 =?us-ascii?Q?1otF8wyvn91vjk7Br7kGPzT9HDMFTLZ5xgwOjOqsqb+n6copPrj+pP4lLAQQ?=
 =?us-ascii?Q?hnku34BHKwONuTmmIOuPIAmmivDb/9Rv0f01mjFuyJ4V1GeeQHXjBUCIxnWl?=
 =?us-ascii?Q?1Y2Sfa3sau7hRQYge3zeQWDeS12O++A789+AJB/D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d91081-5a69-4ee1-e604-08dde0382f31
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 22:23:27.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6mqIH89jDx9nLHL/d1cR/f5IYQvAog0vQ8kb/7iQSY1Jr9oqp25VIuyMyx5+fMWubZFoeuq1kWSFVXZ4sQmpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7199

Certain i.MX SoCs, such as i.MX8QM and i.MX8QXP, feature enhanced
FEC hardware that supports Ethernet Jumbo frames with packet sizes
up to 16K bytes.

When Jumbo frames are enabled, the TX FIFO may not be large enough
to hold an entire frame. To accommodate this, the FIFO should be
configured to operate in cut-through mode, which allows transmission
to begin once the FIFO reaches a certain threshold.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  6 ++
 drivers/net/ethernet/freescale/fec_main.c | 90 ++++++++++++++++++++---
 2 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 5c8fdcef759b..6802773c5f34 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -513,6 +513,9 @@ struct bufdesc_ex {
  */
 #define FEC_QUIRK_HAS_MDIO_C45		BIT(24)
 
+/* Jumbo Frame support */
+#define FEC_QUIRK_JUMBO_FRAME		BIT(25)
+
 struct bufdesc_prop {
 	int qid;
 	/* Address of Rx and Tx buffers */
@@ -619,6 +622,9 @@ struct fec_enet_private {
 
 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
+	unsigned int max_buf_size;
+	unsigned int pagepool_order;
+	unsigned int rx_frame_size;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1383918f8a3f..6031f958973e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -167,7 +167,8 @@ static const struct fec_devinfo fec_imx8qm_info = {
 		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
 		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
 		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
-		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45,
+		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45 |
+		  FEC_QUIRK_JUMBO_FRAME,
 };
 
 static const struct fec_devinfo fec_s32v234_info = {
@@ -233,6 +234,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
  * 2048 byte skbufs are allocated. However, alignment requirements
  * varies between FEC variants. Worst case is 64, so round down by 64.
  */
+#define MAX_JUMBO_BUF_SIZE	(round_down(16384 - 64, 64))
 #define PKT_MAXBUF_SIZE		(round_down(2048 - 64, 64))
 #define PKT_MINBUF_SIZE		64
 
@@ -481,6 +483,11 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 	};
 	int err;
 
+	if (fep->pagepool_order != 0) {
+		pp_params.order = fep->pagepool_order;
+		pp_params.max_len = fep->rx_frame_size;
+	}
+
 	rxq->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(rxq->page_pool)) {
 		err = PTR_ERR(rxq->page_pool);
@@ -1083,7 +1090,7 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 	for (i = 0; i < fep->num_rx_queues; i++) {
 		rxq = fep->rx_queue[i];
 		writel(rxq->bd.dma, fep->hwp + FEC_R_DES_START(i));
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_R_BUFF_SIZE(i));
+		writel(fep->max_buf_size, fep->hwp + FEC_R_BUFF_SIZE(i));
 
 		/* enable DMA1/2 */
 		if (i)
@@ -1145,9 +1152,10 @@ static void
 fec_restart(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 rcntl = OPT_FRAME_SIZE | FEC_RCR_MII;
+	u32 rcntl = FEC_RCR_MII;
 	u32 ecntl = FEC_ECR_ETHEREN;
 
+	rcntl |= (fep->max_buf_size << 16);
 	if (fep->bufdesc_ex)
 		fec_ptp_save_state(fep);
 
@@ -1191,7 +1199,7 @@ fec_restart(struct net_device *ndev)
 		else
 			val &= ~FEC_RACC_OPTIONS;
 		writel(val, fep->hwp + FEC_RACC);
-		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
+		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
 	}
 #endif
 
@@ -1278,8 +1286,16 @@ fec_restart(struct net_device *ndev)
 	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
 		/* enable ENET endian swap */
 		ecntl |= FEC_ECR_BYTESWP;
-		/* enable ENET store and forward mode */
-		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
+
+		/* When Jumbo Frame is enabled, the FIFO may not be large enough
+		 * to hold an entire frame. In this case, configure the interface
+		 * to operate in cut-through mode, triggered by the FIFO threshold.
+		 * Otherwise, enable the ENET store-and-forward mode.
+		 */
+		if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
+			writel(0xF, fep->hwp + FEC_X_WMRK);
+		else
+			writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
 	}
 
 	if (fep->bufdesc_ex)
@@ -1780,7 +1796,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 * These get messed up if we get called due to a busy condition.
 	 */
 	bdp = rxq->bd.cur;
-	xdp_init_buff(&xdp, PAGE_SIZE, &rxq->xdp_rxq);
+	xdp_init_buff(&xdp, (PAGE_SIZE << fep->pagepool_order), &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
 
@@ -1829,6 +1845,11 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			goto rx_processing_done;
 		}
 
+		if (pkt_len > fep->rx_frame_size) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
 		dma_sync_single_for_cpu(&fep->pdev->dev,
 					fec32_to_cpu(cbd_bufaddr),
 					pkt_len,
@@ -1850,7 +1871,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		 * include that when passing upstream as it messes up
 		 * bridging applications.
 		 */
-		skb = build_skb(page_address(page), PAGE_SIZE);
+		skb = build_skb(page_address(page), (PAGE_SIZE << fep->pagepool_order));
 		if (unlikely(!skb)) {
 			page_pool_recycle_direct(rxq->page_pool, page);
 			ndev->stats.rx_dropped++;
@@ -4020,6 +4041,47 @@ static int fec_hwtstamp_set(struct net_device *ndev,
 	return fec_ptp_set(ndev, config, extack);
 }
 
+static int fec_change_mtu(struct net_device *ndev, int new_mtu)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int order, done;
+	bool running;
+
+	order = get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN);
+	if (fep->pagepool_order == order) {
+		WRITE_ONCE(ndev->mtu, new_mtu);
+		return 0;
+	}
+
+	fep->pagepool_order = order;
+	fep->rx_frame_size = (PAGE_SIZE << order) - FEC_ENET_XDP_HEADROOM
+			     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	running = netif_running(ndev);
+
+	if (running) {
+		napi_disable(&fep->napi);
+		netif_tx_disable(ndev);
+
+		read_poll_timeout(fec_enet_rx_napi, done, (done == 0),
+				  10, 1000, false, &fep->napi, 10);
+
+		fec_stop(ndev);
+		fec_enet_free_buffers(ndev);
+	}
+
+	WRITE_ONCE(ndev->mtu, new_mtu);
+
+	if (running) {
+		fec_enet_alloc_buffers(ndev);
+		fec_restart(ndev);
+		napi_enable(&fep->napi);
+		netif_tx_start_all_queues(ndev);
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops fec_netdev_ops = {
 	.ndo_open		= fec_enet_open,
 	.ndo_stop		= fec_enet_close,
@@ -4029,6 +4091,7 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
+	.ndo_change_mtu		= fec_change_mtu,
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
@@ -4559,7 +4622,16 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
-	ndev->max_mtu = PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN;
+	fep->pagepool_order = 0;
+	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
+	fep->max_buf_size = PKT_MAXBUF_SIZE;
+
+	if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
+		fep->max_buf_size = MAX_JUMBO_BUF_SIZE;
+	else
+		fep->max_buf_size = PKT_MAXBUF_SIZE;
+
+	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
 	ret = register_netdev(ndev);
 	if (ret)
-- 
2.43.0


