Return-Path: <netdev+bounces-221827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30968B5207A
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 20:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02F03AF04C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB5C2D6E4A;
	Wed, 10 Sep 2025 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rbd7LrCA"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013052.outbound.protection.outlook.com [40.107.162.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AAD2D63F9;
	Wed, 10 Sep 2025 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530371; cv=fail; b=aZzr71cJo23jZZnpKRIZFIGta4eOsGneURR0sW0YAJdr3BjvkV0lLSDKoPyCaVQVJYERFBZ105urKc+4M5sy47xyCAYRYhFCnP/yP8YfMVfKp9nAewy/YReTSe3oOgdFpvpTSF15oxF36302rXZPemzLw0GETlZqKpBUUP5AfU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530371; c=relaxed/simple;
	bh=JjaHZWsavKJ2eM8gtRuGB+BZ4zSSVlHmLsgx7qXJXOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rdk7Rn7uug7xZpHC3WvH/tWBpsZ0MuxAVmR5ECjsmbtbpXRTA3f47jcR7MGY6rSCKyVtimhYJEdPGAyLs09LguLfhJ/TnApltsJH8jZeWcsnlPVi0u8CCZbD4wfdaYKyQE5nfz2TEAwhYGONEdOYCZboZab67eiZKzqeYhfvrHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rbd7LrCA; arc=fail smtp.client-ip=40.107.162.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzReXJEUH2wBZSqpwEnDBrEQEX5JPY6BwcLv6lWXFmd6KszYR7YIv5Yar5ew9HQNDiPE4ODiBPLLKIekqRGaTrO3i0Sg1PU+gGrcpG0zApB9KOUqao6vJVTkDEZBM2FCNIzMznPz8IwvZib+7TT/H9E4fxkbbpGC5WC6vqzZr1y2AkJ8EUY2efX4y9RTv1R5N6nIdLdeJjqbnCDUorNZXQsDcH2xY8zE82GhKccTw7hQpVeDsxpFNiOzOfGepo4lhLQZvvBECDm/diMii1I/1Fl14KBocx+Ul0wb9CVJb6IU9Pm72M10dR3+pYnvsfk3JGzDQbksXNpx+AdXAk1/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdKwy/PnzClm9WQGXQCNaSLs+5Un0LLg49oR9jCYlgg=;
 b=Nin7SStN2TfN7wXHpK5xW1/8uI8CI+EhZLNn6KAcuDwdIdaTPww+36+Z8Z9ICDScrkLcA7t9fsCkU/bJ38wl0iwBWaaX4C20w/2r3aRQj88pQfRBMoOJLUYNWvDNKPS30OrO5rtO4bfmBFSHka2S2r/DqY1dtnF/AdtZ2iXAZYkm/rex/nTcdV6yjy1PKGH30799N04WYyuiXIhiIuY8ThpfaDz1qVRynicV1zTGCrWtl3Qr4P5QaFvI9F4ye/iSqH4XTSSPQoV3lbQ5pPDX6jfgnHwmCUt6CwAHZZPk2bUzCBd5rn1Fwu2tBG2UnkzZ8+jdgSLc2bVxbIcllnZ8lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdKwy/PnzClm9WQGXQCNaSLs+5Un0LLg49oR9jCYlgg=;
 b=Rbd7LrCA/b0zJb28n1sXdlD1WoXEmQ51/Jm9v1wpQcNfgT7APAjKuem7lG+yxFKOhlQrPH6Eym13CJNgQ3zE2GtqhXJ0awrb5lN0ECTAiD41L5g2o5RmPUnKUDu4GBeJqTbUslro1Hb5P9Ox143lcNEdJ++jQmaijKk9NyVS1B/7JIH0IoRKJhm28BEI5S0OK3xP2Cw+32FHYDIE5tDt7EvFXpcR1X9x9InFy2S0D+0rlsnStTEFALtPVN2tpcHK20MbMdoaEsyFO6Lse8hmxJpkx1kTkRjc2wXlVhQOzSx4/0G98zpJdypH0rXaXh8dilPGrwtiJ7M0DCr+9zOptg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DBBPR04MB7724.eurprd04.prod.outlook.com (2603:10a6:10:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Wed, 10 Sep
 2025 18:52:46 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 18:52:46 +0000
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
Subject: [PATCH v7 net-next 4/6] net: fec: add rx_frame_size to support configurable RX length
Date: Wed, 10 Sep 2025 13:52:09 -0500
Message-ID: <20250910185211.721341-5-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910185211.721341-1-shenwei.wang@nxp.com>
References: <20250910185211.721341-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0157.namprd05.prod.outlook.com
 (2603:10b6:a03:339::12) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DBBPR04MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 2296f794-7215-4866-44c3-08ddf09b3b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ibCpnU33unl1leVfSymu6OCsJeJ4igsU+Ev7MOcL3YGWqvZhbkls5Y7sQTQ7?=
 =?us-ascii?Q?W7IZIb/Q8S3gAEsCSzAqxgOX0UzN9yHBGt2cdmQ3R+sP6FlAitj6Sghm1wIt?=
 =?us-ascii?Q?XYaWyR4Wzpyrdc3GlddR7mGl0VIm8LMx83Gq+47R5VtRLfCrgBFQyXqA5jE/?=
 =?us-ascii?Q?zPbJQvaC45C6YCwFW+t4oz17Y7grNqTyQeApDxAEo1R9O+vLmvSSq63jna11?=
 =?us-ascii?Q?ApsH7ddoE9sB26lBBYJV9VdqOYveu4TOGiyBKlVKoPJf3cq495wqQyjoE44t?=
 =?us-ascii?Q?gFW0GRs0JJZIJsEZpC5ukgBt2k2uDEiw2TIHH1TupoyDRxGpRQtXS7Ts3vdG?=
 =?us-ascii?Q?YV6dpD82Ks3CMNd31mQUhVBoq7Cv+TJenxPBsB8qqtYbNDPGQyCZwSr0nVMf?=
 =?us-ascii?Q?/h5JF7JpGhrjG9H7Eid/ImBD1GunKHTi5xbAfQAR7l8++TRb3MF1Ifve3Iga?=
 =?us-ascii?Q?PMelQGp8NlWYpJGPlIzf1Ac5LW5Zdzq+6sfdVFHu1la0YfVDm/lhkeJ3Wovq?=
 =?us-ascii?Q?KnLx+4mpKvihcQOgHui0ObF0a/ICXMNE4f1HCtmKeGqILyjpOsTUtm3yF9WD?=
 =?us-ascii?Q?1qdVlQRa4H74GbHby/P2V5MYPKERb0HaoGG7qq8jqJqz3WSpUOYgmjmSRYEe?=
 =?us-ascii?Q?6cLkm1NBIXv+syk7mRcl6b+4mFg++nR3+DbDE2XIYDPr+I1nub8rE9dqOgHw?=
 =?us-ascii?Q?GjprZ3jI2oAEPukh5+vfbBDAp3cyZDPORLcZbnrjCMcDFMBUWDSw+YpTR1qG?=
 =?us-ascii?Q?mz+ZQozq1Usc3+TsgE61O/DOAPHvn1GgII6Marr0cMGgmIh4j39Zul61c+Wq?=
 =?us-ascii?Q?+OkBYXhj2Nylyf7mJgga4V5oP+1jZOcT1ZUJpDUApQMmyFNVEDU0by2Ubr1G?=
 =?us-ascii?Q?gnjVJywVoAVoo5rdZi0qc+VjTFosimQLFNWNXkJ4ZHtFgBs0+vrpmeCOHzki?=
 =?us-ascii?Q?ENF/V4GWZCQ2JjI+C9vnpxqjECv6T+Vo8vUGjkN/8//KUR7nNJWAGJeBjbS8?=
 =?us-ascii?Q?W4Ihw/bdSrxKh7nQrdRiluMYsFKu+K+0Qoy2Y/JwYGSYgMZo2PJMAh5r97H4?=
 =?us-ascii?Q?9dPbvd47wnN1A/vWcGnTSMm4X5U8VOk48TiYMte2zNAa9OOzBcNOvXmWGRS3?=
 =?us-ascii?Q?nD1jq3EIv+cCb0lUzuFatd4BnndA9KoyupmtQrCKrqnMIUIbAoAIYpH0cvOz?=
 =?us-ascii?Q?HLQnG5If5MSWypZYYo3gQKXeDZKhvTeFJ4bsbskSAs3pjQOQ4xlQSrNgme+g?=
 =?us-ascii?Q?PJsJ2ehcoYWTw3kcE9gINaEQ1ujwF0CkHUCL5TmtUFMXBI2eVYDqPU6rIMAI?=
 =?us-ascii?Q?kAm5Z7v2KL242spelj2PUMFGImsXB5rlJydyeCSXjAeaTryBhOy48so09KfE?=
 =?us-ascii?Q?bgtaq9Nen2ReUaOcbhXTpm18jpiID+XAFFTYBHUzd7qXcM8BTwF9HqvAFUU4?=
 =?us-ascii?Q?VRnIkhCv3PHZuP6PhbBBQmNTZbTDcJLOupdyIypThxOXGi8OKSgUdOBX/71d?=
 =?us-ascii?Q?Jbm7/hsmdkDQ1SU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?giQqsTQaMOGcFkhOKOYXSE0Nk515QjKMqZLNJTQsJdcnE9yKrdxFYSv6opnx?=
 =?us-ascii?Q?yoH2wINyszqAgBeW64sZRw76vZD4IrDM9SCs6PvtqhNKZlBsbeb6VUWjHuYb?=
 =?us-ascii?Q?oqM7yG/lwWJdRUP7qbtTnzz/zEUY/C5gWOMZ+1J1lAPVACa7bb4m+qnLjQlQ?=
 =?us-ascii?Q?RVY66oeIp/K/2IHLj2nMQaHnbfHxx49G2ilKMokClQyB6pfKI34VxjZSWw4n?=
 =?us-ascii?Q?yM1glBPpRYpvX4rk3ACBwBBga+lE5B1MeUUHFBZyk0OVAAqmxGpS5FlLJNCL?=
 =?us-ascii?Q?0yasHZGz5blXXMG9d8sttyka7XtI8yOEfb4S40ktK9zAItKvZIwpryII263U?=
 =?us-ascii?Q?ifGp2i1ds96i3N9dLmY61ImWM2QrCUQEPUlpDS9Wf4g+T2jOVvnZnEf8Od12?=
 =?us-ascii?Q?I//axl6a+bzkH/CdsArrMkvFfW/63hUsIWD6yhIQQJ1QRCRxn4xc/c5gC73Y?=
 =?us-ascii?Q?yZwSVJB6A0i4RBUYeCkUxkaWqDo6ppNmQejToLzSVruJKLEU4lAWTrUtSl4h?=
 =?us-ascii?Q?lKLepdTUNEneSS/e3FR3OCUutObobF7Rg+/xdCk6+QRNiD+IQL33SkwNRw7d?=
 =?us-ascii?Q?hxCxA0OmAoXI3fjlB2id42TjL64U69iFHmVgqytnUPamDridOM7zPQOw6OSc?=
 =?us-ascii?Q?6LJEhZG2xDJxW3onoS2SeeM23vyxyy+WZpq/ssB6eFtnnuElRY8yyEw8VnJB?=
 =?us-ascii?Q?jZlOjkw+SUtYDhCSgb6/sSJa8YVFZC4QiSPyXsXTSRugtEVPBq2plbk6355H?=
 =?us-ascii?Q?XnErAAINxqGD9+d7i4SZQCriB8Y2NFB+SQPvmcl88W1e7FW9rTbEzs8nwjZD?=
 =?us-ascii?Q?Gk+g360Z2VIFmnE5SUYBTA9gvkjg7p5IV/1Chhuh8m5t3gmSLlROsVUySkoZ?=
 =?us-ascii?Q?O4KRLW832266FYnmE9GO4cli0zxEj7M7yH9GN/ICEChsSYxhxMALIy1baQWX?=
 =?us-ascii?Q?lNgGq97TP7kprysr9Ep7cfBfUsBFtIhEohiFGtbGASovW4bBi1HhHIfdrQ05?=
 =?us-ascii?Q?L7xPRskU/rZasbumPsfYSiuIoqNhfQ0mu4cStlbrx/EliR9tHZt2kp3agLGM?=
 =?us-ascii?Q?8pfnRInJoQT2RN5UL9iTVeNdy0hZCCXkbYBS96cJprb76T5O4hUbp3YnwGg7?=
 =?us-ascii?Q?nlqp6VTSXoMdFHp+zW9hYt7H7t62WMvbkgx/RMWpNQiX2uDZISMKqRCq9mGW?=
 =?us-ascii?Q?Gr5h30kHBH/LxSj4rTBxZPietYxBtn6qQOZICgnMJEN0/HpPi69lNVmwWLof?=
 =?us-ascii?Q?a4MMSwWlYII8kLVXjylZyP4ffVD/Q1EFPexem1Ich3cfH0tR3eH6SBxhAceM?=
 =?us-ascii?Q?U3hDEq70KUU66w6SSgTWsIfPcAtiFcAk5bUEa2kPrDebGCYh4VlagC42iWHw?=
 =?us-ascii?Q?3xO4ndWWYR8vaZHnrLMsJ1F0lxVfIjA1KESVtDtSDPIVVnSXVULVjO6y4VA1?=
 =?us-ascii?Q?iDpUoiVrj5Sqz5kNRu7By2UhMqSpwYl0Q1rfmjfLS+QZ4EpBbIG5zKd8mJhf?=
 =?us-ascii?Q?u7iMqdDKzGfApheAImnC0h3H5ZlyH8QHIMWu7+TJryVSIkgDVGLrXR/B6BBc?=
 =?us-ascii?Q?YS0F4tGJ9XKqJ2Odx5K3c4KUOivi2rDlq48kyuJ1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2296f794-7215-4866-44c3-08ddf09b3b6c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 18:52:46.5997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /w8tZ56aVYYMHQUo533QNtLKMpy/bKhhsMW/1aa3FbMSDmR1GOPUDHw3gInAJTr079TYOfj7ZRRxMSOu4uJhXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7724

Add a new rx_frame_size member in the fec_enet_private structure to
track the RX buffer size. On the Jumbo frame enabled system, the value
will be recalculated whenever the MTU is updated, allowing the driver
to allocate RX buffer efficiently.

Configure the TRUNC_FL (Frame Truncation Length) based on the smaller
value between max_buf_size and the rx_frame_size to maintain consistent
RX error behavior, regardless of whether Jumbo frames are enabled.

Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 47317346b2f3..f1032a11aa76 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -621,6 +621,7 @@ struct fec_enet_private {
 	unsigned int total_rx_ring_size;
 	unsigned int max_buf_size;
 	unsigned int pagepool_order;
+	unsigned int rx_frame_size;

 	struct	platform_device *pdev;

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c37ac84ab956..96322187a220 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1194,7 +1194,7 @@ fec_restart(struct net_device *ndev)
 		else
 			val &= ~FEC_RACC_OPTIONS;
 		writel(val, fep->hwp + FEC_RACC);
-		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
+		writel(min(fep->rx_frame_size, fep->max_buf_size), fep->hwp + FEC_FTRL);
 	}
 #endif

@@ -4564,6 +4564,7 @@ fec_probe(struct platform_device *pdev)
 	pinctrl_pm_select_sleep_state(&pdev->dev);

 	fep->pagepool_order = 0;
+	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
 	fep->max_buf_size = PKT_MAXBUF_SIZE;
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;

--
2.43.0


