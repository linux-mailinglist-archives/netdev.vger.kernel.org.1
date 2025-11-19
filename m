Return-Path: <netdev+bounces-239801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB290C6C761
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4AAD42B3D0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4730B2E8B96;
	Wed, 19 Nov 2025 02:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OI/lCJ57"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1712E8B76;
	Wed, 19 Nov 2025 02:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520686; cv=fail; b=N/ck0Uiyrq1ArrRFu9LhT5jgnoSet6xmCN2IKQQUXvJxJ9Ss18pcm1vTLX8qScMptccqjEw0zDge6X2cuSkz6STQ1TFc2c+CnZaC22ksjYi9YGgP0KX1Nj9dW/AwdNVkZ5oH/Gi4TJRO+B9BaiX01D7sFLLsJh30vV5d9Seg5Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520686; c=relaxed/simple;
	bh=qtbsfzhyaet+jrQK1QaFxqn4uexkRX/Tdb42byQ4+ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fu/2YfQ/0wdnUHdyin0cH6CGAVKVnARsGDkjqWVmiewnk8Ur5UkBXC+YzO/mhv6p0oCjlr+onlJ6XzF5/IuLYpDBUYRYPxuo+7wUnefZzOZk7J4MeDJmhXS6ctc0OfzrmMydkDosDoPSJ1jYbCf3jGLHkSy44XTuzbNl7YPnKUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OI/lCJ57; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9/WwvtB3gZd8rsUmC7E8bb6lLWlM9g/8zIe/zwiNJL50P/ZKkH8lKNqr28PSWxnKH/tKQsWvU/emJ5klyhqTVptdUsnx2/EnH/vjp1PS1b7lpuAheJZIMordmYUmx5DhapvjcSQqyQ1Jgszzs6DwZTGDKKV9bCuhRvJRK1bawJMPTMcmg/PMjhkrJ/oKAcwsLQa3w9ayQxLsaqrJbrO0HjEiTcsWJFVMGlgvROxEvoxibEk9yUP62INn09wnUtTwCyF98S6cA8TqhACSAT0kkEocfcW8apmhP1ULMpxHpxBFfhEV92yc9Ix0c1e8aoICHEdzHnq/t5Fjcir5AwyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssM5g/aQJOd4Fp8lpsveJm+LhJ2oO+GwfGci/Nz+QDE=;
 b=DtL9YSyV0URBzUM6/7fHRq6EYTv5fPI/HCHIsaWWsxIEk+TD/lpbaGnlZEYCNJSi66GU36XP3Yb8fvmSY3hZAwSgt72vNhCgwjeVOs2Y5npRabm/AHJXt+j1sfx5rep6QLi3fpgs85chM5xaK3Z7s+jGegIL1Pzgrh8uiRwW4qOnRlSpp3lvqO9ceEeR37vtc9EdGuYPrWquTnauJSOIuzT+4sg3e3BYghQljrPkTi+alJWxjIWg5N2bpp3UVmhx40scxlnZAae2s+HYKfF91Y9MsSz+a6KOMPT8XU89CNQV/Aivt6Ogpd3GzvC13DErjyPXkzQRau6O5ClvfVHq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssM5g/aQJOd4Fp8lpsveJm+LhJ2oO+GwfGci/Nz+QDE=;
 b=OI/lCJ576lHGAEw6dL+6I9DRsh3md/PSn+DzXG/8Gj7V0gm9IQtJcFOj+FIW/13dfmVhUQ4ytl48UekI49jM5ew2taShZL3OKVGBZ77vAPAe4wliGn1/5J1y/wfkxxnGH37iWfbK7LciFj95mn9g0XTZfOj6RZu/GhApAV+xsmRz0PYgDPFJylvZqxO49BTtDE/RLWhzqNAfmpw1zA0jxY1yqeqGQjoRcFlxGRyV/TJbOlTMpYd9Sr0EdpSAhSjlNO3Oy6C3zfZWUWs02Eni/wILNM2+WwsdgF1SAVUvqy6+EBxeA+Il6s98s7mV3UYZ1+omEgddl7QzeUPWV9lEpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by OSKPR04MB11439.eurprd04.prod.outlook.com (2603:10a6:e10:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 19 Nov
 2025 02:51:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 02:51:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 4/5] net: fec: remove rx_align from fec_enet_private
Date: Wed, 19 Nov 2025 10:51:47 +0800
Message-Id: <20251119025148.2817602-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119025148.2817602-1-wei.fang@nxp.com>
References: <20251119025148.2817602-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|OSKPR04MB11439:EE_
X-MS-Office365-Filtering-Correlation-Id: 623b3728-c29a-44b4-883f-08de27168557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BvH1lIYxPRWwoZDoIHuj1XttFnvjkirsO6/kh5mR/DIRWlf2GPLj2dEC+b67?=
 =?us-ascii?Q?Q4NkxX1eKcCZPUijiwEe3MT6sckY7dncJmRqRXx4fl+YhaT4Csmr8AEuRixs?=
 =?us-ascii?Q?WgbaDcqL+QoVGA0m1stgEm2eEcE2gszltzqmqGtMDxvKdb7LfstvnbXIo8ez?=
 =?us-ascii?Q?Xg1Emzev/RczxIbNm0mzsQGcTsJ1SbCgMyBTumZvsp8pmr5YhWkIiqMVqDn9?=
 =?us-ascii?Q?2T6jGjCCs0DtapXcGY9tdi1uAFbKucIJJIrvWQO/Gu3Kpw9COHbJ9qCrbc2N?=
 =?us-ascii?Q?dPWGf8JG8DJ6pha6s0q+c/qTwJK9tGunkDiD6WQDSM0UACwzzQRfZR4MZPxr?=
 =?us-ascii?Q?A/GiSxm/vgd9y4M/y92XkA00q+tM1yQdB+IlAHPpMXXK/lib0JpIRUS4Ufa1?=
 =?us-ascii?Q?5VR6MselitBcPp54pj4gJsqfUX2ugApjMc9CTiAFul98TK/Lo995L49S5CY3?=
 =?us-ascii?Q?+tQ6A1EnonOUoga/vjMGGfDOcEAXhWIwY5GK6Me+XJP9Eo3BNlMZszfp6uBs?=
 =?us-ascii?Q?rifdqPcrIe1EJ4l2vYm8+23+pYx7ntBSMPXNGwB1AO6epg1fBAHEfUlWsXa6?=
 =?us-ascii?Q?nphdVOX0bwhpWuULNxSTDzFlIGHRgB+mrQvF9XSO4cDc0Ciy1ub6p1qHNPr4?=
 =?us-ascii?Q?BOqzCzn7fmcPalgVFTSJlE8mvEgO5U2bV4+w5coKpoA1SJTFbijMYa1oxjrS?=
 =?us-ascii?Q?OqWqlvqyz5RRyzyr8Tu6d80FohJY/e9+3BVsSSf0bqBmqUtnfZDpKAG7y7ns?=
 =?us-ascii?Q?0GacLOb0Ao7avXovJDDnrLhrkvGYpYZQjLXvT5fE6Y3kVxBTdf04Y6QIfquJ?=
 =?us-ascii?Q?DWNXmJDEDOT18KFtdKIvFFypHV541WqY1NZPIbOyBT6GcLZXc0poaauCz9f4?=
 =?us-ascii?Q?im6CIyoWDzB5VAP2K1sLgGQsZmKZ2mYArHEZ/Ss/G9rWaQMQdi0TeRnUb5/6?=
 =?us-ascii?Q?ZfxfZS/1PKkXGczveuNKCB+O2JVbjMUXURssIK+xHZ8EOR+8113DUE/5N6vx?=
 =?us-ascii?Q?6xSG4BW42IOgyMyeJaIkOuuFQewPYrRuzAUxDm/2S6sSStLL1sVlUt42V3Tv?=
 =?us-ascii?Q?lbpl8d3VE41YFEY7EXTfpRLHZCuRBVAyBZLWtr0Q3uC6AqpxlywF71VSO/eu?=
 =?us-ascii?Q?UkFMWO1SmbE96of5UClTY6yu2eUoWcZw2L5KncP8ryvxtZJW63QaXgtXKn8f?=
 =?us-ascii?Q?1+eGY9Hbo+5Duk2+IWlDCoMW1MZlnBs6nKfWGw4xTO/e1fGYC3sEUrqj6KEu?=
 =?us-ascii?Q?e7cjhIC7pMvgPjpRcc9PA6kq9x/bB9IZWuc8UfzwVL5dcVey90qRgaGlosBH?=
 =?us-ascii?Q?h0qluXKfzWw8bOo8h5GW3vzSwJm5hZVI1h9efILSKq8fQ+gJ9CSep6xJ/P7v?=
 =?us-ascii?Q?k4G+Rok9zkkHiDyHZlTMKVo3PcV4KCxLbY1x4TofrIcDThfYMLUbuK88Zcbt?=
 =?us-ascii?Q?SxCtYTGqlOm1nkdWKP12kLfcKg2sEY9qnwSEbG/La2GubMgOswqfKOoLJqzy?=
 =?us-ascii?Q?R2+kbCvWsE3efSaTQUTxaC+FS4deFkrqZecC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IYYtmpa22t33+NrFwsF4AITIaAPNBsI2M25OP/8/LAgx4edb4/7Y61lqlKKR?=
 =?us-ascii?Q?l1psVnEHQIvIcEe27rUAVUFfApwcuDKwnR0RuPKp0Pr1mQKoa4poD/c12orN?=
 =?us-ascii?Q?5o/37agnVTFx2/X5vySm+Xi/S1R+k8+elywYPxW8/DeS2IZUmOay9FdECkyj?=
 =?us-ascii?Q?fTenoO2uMBqHJNMwUpCcR5uxtxs6UhlL4xkMuI/ok1W1HXptB2lUE0/57A20?=
 =?us-ascii?Q?hZVRf0ZwUq+BIhS/bTuaEmTH9csxZoRvj0+LUBd9aTTt4+ArARhDe+EVkI8d?=
 =?us-ascii?Q?OywujB9qqpCYM5qHeDeG5Dhvd4Ir9N+7jdX53O6mY8KJQJkuavCt/g7RH3zb?=
 =?us-ascii?Q?+ZvswDKl6kAXmxyh8oriDb0OU7z0FccfqxzM8E1j736WnY8K/1F3p7xWXvb9?=
 =?us-ascii?Q?ohwRSGy4FjcyRJRyG54tv3UGPefEFfO3U2QMN63S3Ipt47a179/JJPxMIE8Z?=
 =?us-ascii?Q?VNYl77u3yMLY8EBaxlyILTFgLBpmwUVWF/x8fFP4/UZvbW0vzuL87cpBQXnG?=
 =?us-ascii?Q?jJAyzMpyvVhi1Y02ILXJWP1iVo2a1aAmJOtrP3lbHH52PBBf4n/MqjGmVvrd?=
 =?us-ascii?Q?8gj5oaQ+OoNYYF2T5b5QyPNI+FmAAgqGxDAy3Jw4AL8vO1zrbhlWZq+EkZ3g?=
 =?us-ascii?Q?TN/O2OaH3KJ+S991wLuN70nk0VQjkzJKEFvrs8Qa21TpBiLv2knlmrsxw6bo?=
 =?us-ascii?Q?8LAShQIYffvia5wbPo+j+uPAIdbMEdGWQ2dMlWkIgkq64NJWs9qcGWIuvGv7?=
 =?us-ascii?Q?IksrLN5KGzL1MQqhLy4F+WJOnZuxzvyDcZ7Jolnpi6zKoYX02mXvIKsvAVfp?=
 =?us-ascii?Q?eyTIaIn4DygHTnUcosv9/M4rpkTxQ0IcHXMlz9JawsFgas8+tkGtv1vEt5FM?=
 =?us-ascii?Q?Ht7c6LtRcJaIBRVfWIBFzYy8vL3aUfqe6jo8p13ZrWownLEafwTNavyqPhGQ?=
 =?us-ascii?Q?h2H4aB6wVS1lSsyt+4oMphx2j1QkutM39nX/xrR/fsB24Ug/KCdobnNv21Jh?=
 =?us-ascii?Q?ynTLkKITmFzex8sN9EfwBc3VMDnW6+oj+vXuy8RTOUkMBsvF4/gZe04klat8?=
 =?us-ascii?Q?MLz13NKQPrVdo7OmCae5sMnQj/ounTBJDPHCrj4tyx6tLzNEdrg7CkKqHg6z?=
 =?us-ascii?Q?Bl4WWRSh7iYc26dlEA3YkKU6iGSGYC6EsXVU5zFn0xtM+V9R08yuZGKkRbuE?=
 =?us-ascii?Q?8euDhcAa3Hkw4X9iMoeyCiRBU71PIheEjOJ4UX+VExd01Yz8raxg1gIn4eA+?=
 =?us-ascii?Q?NENmG2ht47SrxWL2AdEm64WGd/ZxCW6BWEe9ZmnUNkvyahyh9SafLi/TWoul?=
 =?us-ascii?Q?7eNNLy6d06TsRNVIKTqpcCUlsXSIzfZoLuNss62YC6Lj0n3cLI01Csa5lb/Z?=
 =?us-ascii?Q?BEemN5yppn/5f3ZzPmcBSWKFeirA9NBXWsGBTH8B2QTR7s7SlbIVTrVku/Hw?=
 =?us-ascii?Q?VSuxHKVuJlklGuOgfOa2mz8fhjxLo7fOUShDq/5Zy3iGHa7IeLMBj21eCZk2?=
 =?us-ascii?Q?f3ydPovz4vGQqdMFuWD7ZyHXnLFeA5lz1XE9xv+ll8Bg+vfqxvimICrMU/cY?=
 =?us-ascii?Q?VFIgSj06Uyp+5Ul7sXDAax1uRSNS7MEVVXv4cV5x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623b3728-c29a-44b4-883f-08de27168557
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 02:51:21.5976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ejy2Tw0Wsw27aKUd9FuTOcfDoh6B9xtRAjFnSt4gTVCL5HY/Wc1exHkd7Xee3AoQ95lEyGZmAFTL41faQNXDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11439

The rx_align was introduced by the commit 41ef84ce4c72 ("net: fec: change
FEC alignment according to i.mx6 sx requirement"). Because the i.MX6 SX
requires RX buffer must be 64 bytes alignment.

Since the commit 95698ff6177b ("net: fec: using page pool to manage RX
buffers"), the address of the RX buffer is always the page address plus
FEC_ENET_XDP_HEADROOM which is 256 bytes, so the RX buffer is always
64-byte aligned. Therefore, rx_align has no effect since that commit,
and we can safely remove it.

In addition, to prevent future modifications to FEC_ENET_XDP_HEADROOM,
a BUILD_BUG_ON() test has been added to the driver, which ensures that
FEC_ENET_XDP_HEADROOM provides the required alignment.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  1 -
 drivers/net/ethernet/freescale/fec_main.c | 19 ++++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index c5bbc2c16a4f..a25dca9c7d71 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -660,7 +660,6 @@ struct fec_enet_private {
 	struct pm_qos_request pm_qos_req;
 
 	unsigned int tx_align;
-	unsigned int rx_align;
 
 	/* hw interrupt coalesce */
 	unsigned int rx_pkts_itr;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 6c19be0618ae..c82be43b19ab 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3438,6 +3438,19 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 		return err;
 	}
 
+	/* Some platforms require the RX buffer must be 64 bytes alignment.
+	 * Some platforms require 16 bytes alignment. And some platforms
+	 * require 4 bytes alignment. But since the page pool have been
+	 * introduced into the driver, the address of RX buffer is always
+	 * the page address plus FEC_ENET_XDP_HEADROOM, and
+	 * FEC_ENET_XDP_HEADROOM is 256 bytes. Therefore, this address can
+	 * satisfy all platforms. To prevent future modifications to
+	 * FEC_ENET_XDP_HEADROOM from ignoring this hardware limitation, a
+	 * BUILD_BUG_ON() test has been added, which ensures that
+	 * FEC_ENET_XDP_HEADROOM provides the required alignment.
+	 */
+	BUILD_BUG_ON(FEC_ENET_XDP_HEADROOM & 0x3f);
+
 	for (i = 0; i < rxq->bd.ring_size; i++) {
 		page = page_pool_dev_alloc_pages(rxq->page_pool);
 		if (!page)
@@ -4072,10 +4085,8 @@ static int fec_enet_init(struct net_device *ndev)
 
 	WARN_ON(dsize != (1 << dsize_log2));
 #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
-	fep->rx_align = 0xf;
 	fep->tx_align = 0xf;
 #else
-	fep->rx_align = 0x3;
 	fep->tx_align = 0x3;
 #endif
 	fep->rx_pkts_itr = FEC_ITR_ICFT_DEFAULT;
@@ -4164,10 +4175,8 @@ static int fec_enet_init(struct net_device *ndev)
 		fep->csum_flags |= FLAG_RX_CSUM_ENABLED;
 	}
 
-	if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES) {
+	if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES)
 		fep->tx_align = 0;
-		fep->rx_align = 0x3f;
-	}
 
 	ndev->hw_features = ndev->features;
 
-- 
2.34.1


