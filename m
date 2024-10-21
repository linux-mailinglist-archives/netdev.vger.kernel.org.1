Return-Path: <netdev+bounces-137453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499DB9A67C9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C607C1F2271C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626D61F470C;
	Mon, 21 Oct 2024 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="WqxcV6Ly"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021074.outbound.protection.outlook.com [52.101.129.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8131F470E;
	Mon, 21 Oct 2024 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513029; cv=fail; b=mCFj/FMQKVZ6sz7S3ETfzwUCWc9mFOZBESIpT5MzOQzUdFBs7WKd4Mgpeyb/epyNPLD1cBLRtpUSJdPnGDSj7JzAx5GcyyaQWYTYzlAjOWWlRrGHvEYo49Fsj8COlfVxSLqQU71M2xsJi1lCQqX4uF4F3K4iEOiWEn87+IH/xFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513029; c=relaxed/simple;
	bh=zcdVxIt41F3+w91XSdSp1Gl7i+Fe85WDDMkL94g8Eyk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GwTgvM+hBuZKeiP7eUrmkXOdNfKyjoZbEa+yNbBdyphQy4lOkBLKMLxF5BYGgtCx3uZryEgU4klFXylqcRuoNiNKPvt5Q0783pTKV2BVCKE0IC0ICkO2IuxLAH0RQhvS//SwrBP7gcOlx0FLXwGm3aall+EtcGFZUh3LAuL+BY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=WqxcV6Ly; arc=fail smtp.client-ip=52.101.129.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6XlhWkN1G41vlyr7OZOJjxRTffrZruOeGvqDbMsiQuyngZoBSnidtbUA5knv1r+OqMjJucYTImsTtRVNdvEEMY9fEen6VvuXi5L1G+HrOlNJMo15yxNGsktRV0Y+u1YAHbEzUQbZxjgjI+Ni74RyfJ5/72YNqXynWTFrMMofUK17vaFCo0dNC6Ae0BbyZytMldBgiXHXMyTZ3q1uwt44Tuu1IGzQs8X6wTt2U3TZYGGVu/tghdDwC5Rfy0tS63KvqohAm/v/mMwQWTqeR/vb0zgM4AAluq9BgrBtu/V9JhCkM5b41BQULntZsARaKh82RshL23DAfEtCeDESqAAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oINRKQZNvFOYIJMSMWUZEIDIzq9b6A6ifP/Z4dH2tLY=;
 b=HLkulrF+WfNgSNdsVZ70IIOZ5JjUCp/6SO2VwaGUY97z3lo4pw1zE0nKU/VPq8W+azTfS4syvQkZwAc9rhFzyEZz1E6uvzD0ix2b1w23oXPo6/JDn3NCw286YGDLNmygR2pGzuhT+xTtCgTReXfr5jGyGNwqhRN0q3gRT2l1adA5BuKxTh/vD5HtESYgGPNa0myqEcVZJ6ArlJ7MBog3XeZuHSTNP195dauZqO1Q10qh+9FCcVQNUxH1ZDcOJ38/Gmp3bRZw+Ei3dvqB7GZlVI3+EntIM9ztxje1aLNV5DTPzjFQUNasW17PHr3aBxvKvA+qkQnTr9UgdkaMLYOLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oINRKQZNvFOYIJMSMWUZEIDIzq9b6A6ifP/Z4dH2tLY=;
 b=WqxcV6Ly5OkH+arEDYddBkVIbZ7Coy1ucrJpc7Nd1hO7uThmjYuheJpwrm76SqJVBRYQRHKzinfvnblgNL0E/BTbyl1kxVoOnbEXyWJmf2yMbxnM9+elADUMyRnfDBXrGiIF5rTa++FNWD47JEl1xJ4R/THRBkiPZsiJD99qTMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SG2PR02MB5604.apcprd02.prod.outlook.com (2603:1096:4:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Mon, 21 Oct
 2024 12:16:58 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 12:16:58 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	matthias.bgg@gmail.com,
	corbet@lwn.net,
	linux-mediatek@lists.infradead.org,
	helgaas@kernel.org,
	danielwinkler@google.com,
	korneld@google.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v1] net: wwan: t7xx: reset device if suspend fails
Date: Mon, 21 Oct 2024 20:16:34 +0800
Message-Id: <20241021121634.16278-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SG2PR02MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 850c40de-1cc0-4d9c-449e-08dcf1ca4237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QhAeaMMMd/U2mkvJce/7RrvXLDlgEZt1vzttoxKGaaf07lnPHeA+FWaoLHvZ?=
 =?us-ascii?Q?tNlfgzh1BUSc2Ox/vUrilJ+/NrfMW9jNVwdGR/1HDRTSvHUz10Wja7tPd3kc?=
 =?us-ascii?Q?6H4kfcdeZ/Yx4ZPhgqgw4Km+rWO/L8oyucY7d3AU6v6XDJZ8CO+dBaIvptpi?=
 =?us-ascii?Q?HGXmer6cYx934FFEPUPbfGrJphFYgFJCi856uYqoLb9Bl79oQY7dcTUjcVQb?=
 =?us-ascii?Q?jS8fp9EcJHOdguvbbmXv3YAk9v5O9IIW2/u3mFP9KHB6oWGeo3Al+AeOqtmr?=
 =?us-ascii?Q?anSAvTYbxSmE+gKJnMm+H129GJrNst4UXhUCTWnIrGSqox7qTIRS8iSLEKZA?=
 =?us-ascii?Q?GCywr6uR07KldAEMpL+koU6lefacVo/O+NjaYWLXVIpmw5dz6I++yGGpl/EG?=
 =?us-ascii?Q?yTosj5mt4KaDK0F2Odlp6GfIBHUELCwYM9DCzIzUBBLtja3uZPnTcvnPsF3c?=
 =?us-ascii?Q?MgtWJdjGtSlkQcUqEsRTXY/UIA1xgsGVIQB/lmjovbGiHcuMw8RTmdLWCdda?=
 =?us-ascii?Q?60p2Re7OXP0pU8Q+gzS/NuolAYZpqEIVGE9C/2tBz2xi01P3Z5lBmIyEFm3Z?=
 =?us-ascii?Q?OJQa9v+nh/qFIi/xM4icIOazjBV13jkgSxeUydtHvA3tBZZzxaf8EqhCPzcF?=
 =?us-ascii?Q?OgcK88rnHAMVEdwJmp7BgX24y80UtrjIVWScpc0yQnPp/52T/u0YPOROIS6e?=
 =?us-ascii?Q?Uic7mBRNOvktAGPSJmSHC9P7O+Yo+EjMYrAz15e+nHKPT6Fw01LtYlEbEKth?=
 =?us-ascii?Q?OJGg3kLKpVCqnDWnTVniiWrOlDO6xOQhQpglb2T5l8tTK0sSvjN13qR6GzoQ?=
 =?us-ascii?Q?znzTWM+Cy2+1CAcq9PO9W56xwNul2KZYYGV/XQnSGGenRJlUHrtpHm5//jZ8?=
 =?us-ascii?Q?dlYwSlrGni2ZV4UOVPh3bIvyYcu4ffaosLKgKxJhd6yWbnXiw9PcQFAGcYjk?=
 =?us-ascii?Q?sQK0H64sgK2AGICYIn2gmeZPCAaEQkfGrEsctYc3JvjB8f/kevbjBvZRQoKt?=
 =?us-ascii?Q?v19BpiVMlw34Jzif6SZ37QXOEe8IMki+TiH95naxaK1sgF0bbKURsAzGLebz?=
 =?us-ascii?Q?hW9zK8cZNZYcEx/55GQtBhq5weFtr5jCaGlxj1q3duqZMVZWhtdgR96JedMQ?=
 =?us-ascii?Q?VDg5zxvQTuibAqejVPuTLi5iT0vUHga5EeVeM3GQllc5IALqbpqXH+9ze+Jg?=
 =?us-ascii?Q?kX6eas2zoLGt0e/tl1fkEEUKyoFzRU76lBcpHGdhsdN4T1K1f1IIJToiXEys?=
 =?us-ascii?Q?tlKFJK24pdQ0ZIsZtHI7UU0BmLj6JHPM7wLXDGBmUOScJW/6PhplxCaG8eUD?=
 =?us-ascii?Q?D2vu+byWR/8Zvo0AAIyROh1hlyVIOisHwdL2J+eyLkQLml5JxFQIDtDrmSoe?=
 =?us-ascii?Q?rWHvqBLcuYedbD8MF5Ic8N95YAvZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mJbSNJpciQrVN/J8mMoe0C9IUhBYAWLlhQ7Azqa/TVkFkMQuJ2pF3I+5YANE?=
 =?us-ascii?Q?JNqIvCCfXsSPTmdrtzdslyGg0xdeZnmS5bNUzy0GC445tWiwhSEGsw80XXkg?=
 =?us-ascii?Q?Dhif31rD2gx9Rrz+jY02/UHmGRVd1bEiEVwSQoUH9Hm+WpqUIO3tqUDWyA09?=
 =?us-ascii?Q?sm1l434sRbpDCV8qLTuJ+35r2u+/zNgVnxpaHlvWN9PAORBG6yuuyoUmQBrN?=
 =?us-ascii?Q?MoQQ9V/m5A4FuAfawO31ix7MRGgSoXZd9dZCDbB4FO+gGsHC/JXDD9pEal18?=
 =?us-ascii?Q?t9v3Y6LoIvLZDOXlcod5YeYmMPqi3a0xSkBvZpDg9o61vhiP+1Y02Ob9LljD?=
 =?us-ascii?Q?GwTDY2gclTGfSZBfLQYaWTwY/DnPAEKc4MKoQ5fLnDYpw3zN+lnLFbO5YdUh?=
 =?us-ascii?Q?txzRkyeT06FSrk7ID+F7OsKzTa9c9ob1r98uheOl4kwqb7eqeve5w6SdTgT6?=
 =?us-ascii?Q?FrCMBYnXBDoodyOzI2qGSvOKwYhDWROA4UjWCKYOdqWwPzUVrPJ4UDzu986s?=
 =?us-ascii?Q?3Ch4F0FF2zBeuVsaxXuCvK03HPL2vIHoja/El09AYsu6Ppd28g3gpEEl4CYc?=
 =?us-ascii?Q?vUBfAuz30pWNsw4PUH7D2qN6zrUDmU/5kp+tGx7rXmrP7tiYr9zfW08zlmN0?=
 =?us-ascii?Q?KUUbEzhnLZkigte5kKDRC06/JZoVPxaJ1nQHn29Xzjez+z+LRU2N6Ja/KbqH?=
 =?us-ascii?Q?wfqzzuddsgmp8HGdYoM/PyvXzwnRxWD0kpNi8b5z1UHWjdlce4LUdkrvAAy4?=
 =?us-ascii?Q?MnthbicfIDweomASV0aflIZnPylr/V0YNEJJLNqwlBzutyosA6M/FMbEqbYj?=
 =?us-ascii?Q?XNnh/uiexhw4/eKJZWGq1fE7EjC8E/v4tzPh0Vp5J5ONqrwRFP8gVrZcrgm/?=
 =?us-ascii?Q?qTKPriE986xmBeTbjEG4D5zbuwz5ImdKlMZiSxyZtApNyn1dmxqZcWEUw6DC?=
 =?us-ascii?Q?zad1qA5ya2KjrklF0awdxjuwUpZYxHee5q98BDety6CGFzKb9F0HnbJd7lcU?=
 =?us-ascii?Q?8b7tfwNymzSEQDFwPqIvmdbF0iASxv2vLn8NDAzdo3qda4j2SmeHpRUaKthY?=
 =?us-ascii?Q?foNq3lnvEYF3hCJMq7RGQ7+2mfaZNL+H0vys3z5K0ltYeL1oHw5lrZn2bwQR?=
 =?us-ascii?Q?U//qDbdm/iywUW8APk90God2Et6+WlA3a4qxzUh2smDjPAt56atido4sX4SJ?=
 =?us-ascii?Q?D5woj9TudsW75HUND9HHBO15SOXoYWibuZZ9hC3wBeugwimTN3cbYlEed8Ae?=
 =?us-ascii?Q?De4vA5fvRHo/v9bC+nX6Q7AB3Be16LbgUbEQBgTO9FEyskpsr67AknmH1Cti?=
 =?us-ascii?Q?uF3c6DvgXS5lEbjj0ID/Ftsqopny7pK/8t+BxDUsud1y5aJyZ4D6fMOJO8Ji?=
 =?us-ascii?Q?XXvuDtVuEk2bmy8jIzkN5C6ZjhmmlOYaC+YEiUMOxsKaOJOFIIDnA0xm+QE3?=
 =?us-ascii?Q?C98dFRLv1q1SzG1bKTFA0Ssfy3ZnOeoMaknriUIXSHMc14htniKIoz2+4H9c?=
 =?us-ascii?Q?o71wKhechs66GGKjGEpDcZeouV2DB/cXpE+G7W+jZcYZ0xCRUcaa73veia+W?=
 =?us-ascii?Q?9KwoR5VBVAXipqE35JC9q52/FQBaYPINzfDbGMiKDa9LYDveLAawCaiEfY5B?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850c40de-1cc0-4d9c-449e-08dcf1ca4237
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 12:16:58.1194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U87Y1GRSOsJ+7MWekGlfR4C6GHUnf/NDSecp9MHrg4Y8/77vgMDOoU4FSxPRTuqQDifYxB+rOCt+z2HOY8/yVm/+eqOYwlnXvb7PjXUtPXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB5604

If driver fails to set the device to suspend, it means that the
device is abnormal. In this case, reset the device to recover.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e556e5bd49ab..625f5679c3b0 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -427,6 +427,7 @@ static int __t7xx_pci_pm_suspend(struct pci_dev *pdev)
 	iowrite32(T7XX_L1_BIT(0), IREG_BASE(t7xx_dev) + ENABLE_ASPM_LOWPWR);
 	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_RESUMED);
 	t7xx_pcie_mac_set_int(t7xx_dev, SAP_RGU_INT);
+	t7xx_reset_device(t7xx_dev, PLDR);
 	return ret;
 }
 
-- 
2.34.1


