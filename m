Return-Path: <netdev+bounces-215177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5DDB2D765
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049995A82CF
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D927C2DAFAE;
	Wed, 20 Aug 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LHjnjGCG"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013058.outbound.protection.outlook.com [40.107.44.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317AC2DA763;
	Wed, 20 Aug 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680287; cv=fail; b=HLUhTJaf8FuZkWbcEsXDaJlmMArciNIp1OnkAEYNfzc8UuUwA7TBetHMVsX/vF/cFcw1PCcDf3nTC0UgiXudd6q8eE5ViUcolSLJWAiCcSS/kdyy3L5R8ztdKLg/Rusvw0xkXITsRVgiyWElWelxaD4HIMkKdZHrZFGxpsE1p9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680287; c=relaxed/simple;
	bh=vk47+6AeCzAnbCFIwIR5x57adFgWZBp3tFMULItqwbo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Xe9gKaR/UjJvubKgIdlZZAfjXNcP5CkGdMsExlng3ijiLiyiW9Ifpicfz/ej6yjWPTqCLV0vujsldv9fE3Zd6IJquk3JNh5WITNd5Vfklk14yu9uS8Ybe2qz9Eca7qDswO6XAOyI9WDxLaJzzWiRVGwZgZYZtQNYW/bnuOTYMYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LHjnjGCG; arc=fail smtp.client-ip=40.107.44.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gix/Oh12bi6ydI1UzDZ4P5Xd9ctYbbBPWsAslme/Vs9HlylEOWXNG2XfELrFf2LfAiYOTgBnjnV0M3wA4kNsC2agzXcJBdBo85qiSoRVLCfVoascHXALQVbfjz30SN/c1uLAAiM668jxMIbiFkQ1uD4qvF0fylhrq5t5aPtFjZP7qzvEtYMSG3470TEuuCips9eifbAL49RVFmDj23wzWkM5YH6HJaPUi+0Ieq049l3kdQfrHH1mniVN4Qzdw+D1UXBBJtjSzd6IajUrT7FLIECjWmRSaEEjAH2+JJOquGtIYETBy5djtsM+HwSqwjt0/H/0S+A+s3RWUr/1/+nwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fvcqz/6cekr+4la+aNx1eUdD33jWFBzDHumCibfoPQ=;
 b=sMhQGv4HAS+sv//3EFX7ZldE30uaWZgL7X6BDKLzVXe2OETxO4eR1ybo2F2MrQDILpCrFoYomgIbMb3bEo8FTexDtqzC5b5KZTmBfNIFOzoZmN3vXoiPnjt/iLmRSluoMIR0pSCmcWBMe6vWgmx0vaLWuAY+3hO3yaW2S+6jd0cMZaM2I+SMIKuVhQHXemgm1WJyFs1namFFMFl6pgZG0jPeGWtt0SFstUFPyS5T/qcOGOMY8uw45vE03gSuvBtJKcTFFjyhLWroOCre7DnwjvgncD6Cg3Uv+/AyLEmxOuUXtbruVl66nQvNdCfYOx9OqXFCyD+UzwERYAtPl4ud6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fvcqz/6cekr+4la+aNx1eUdD33jWFBzDHumCibfoPQ=;
 b=LHjnjGCGXTXOsuiHDZTnS55I5GtNfe8+1Of1B0dl5qfs7blQ1ueJdQp3lXczv7tzDARhvsJuqr4LegEM6FOEvI/qX2Fu3mRokKCMRS2KdnOrK7i7M3aEVPipzEziJK9+QkieWki3e3WqP0DNogZDFsjtVR4NiPdLXrtNxpy1wxcFYni8+rIoMWzPWo1PiP8UjgABWSHBLYMRZVQdNqlXnE8+U0CYDKWM2ouIu5I4QsDDc75SMEeGt+WxTF7VWpAHbl7sKgfDvOFX0XIL8xNyyPD+G0qIUtejHU2kxXMEiuajZ9N1UT/zWHsaXFcoldN8psNjGkTPJLGjyIevssRAaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB5664.apcprd06.prod.outlook.com (2603:1096:400:284::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:58:00 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 08:58:00 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	netdev@vger.kernel.org (open list:LANTIQ / INTEL Ethernet drivers),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 0/2] net: Remove the use of dev_err_probe()
Date: Wed, 20 Aug 2025 16:57:47 +0800
Message-Id: <20250820085749.397586-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: d204b55c-0a84-4a7f-88a5-08dddfc7a9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1px/QZQCd0ttdQkGBlFOu1yBI45lMCQksQ75uc3T7rHXw3FqKp7ZdXa/5fij?=
 =?us-ascii?Q?hc2A3x4wpHLt3TItI4LkYGdEUFwkTjc1UxL37+Lwnc/tR6ZazvvrqQ24zPRf?=
 =?us-ascii?Q?soAaSgZ5IOGAmMRlctfVQ8Iv4Z1Mpl9uPigE7vz6Ea56Ufu8RyK5Rsed0ikm?=
 =?us-ascii?Q?C9fso1L0XQqdM0zUw9Zml7INVZVgUYgJC55YuYiFxAe7+zA1UMzK4Ktra3AN?=
 =?us-ascii?Q?kMYPMpQWeux8d102mT8b8nAEHbqMV/QCSc/K09AQ4313wxrdpjaV5RlzwRFx?=
 =?us-ascii?Q?uIydY7m3F84MXy5sm3ck6mAPoJYRxLhreFhurpAMLa7kZL0S/Oo6DwBDPPTG?=
 =?us-ascii?Q?ajxG2KPodOw3FGD8x3weWBzb+LNwgt1JG29uyEEXQOrVZD5B1PWQkgAdw7Hz?=
 =?us-ascii?Q?QHn1xm8zMFoi4wXVYRlj1dMIS+HYYQ6yu1BNNlx6ik+q2QbnZ0UEy69f9yB3?=
 =?us-ascii?Q?gmWTvvNKNNe53bH6BmQMLq/txcmkJlyuJLoZQlI9qZglypzdvpoe2SZk/M8A?=
 =?us-ascii?Q?aCbsRpA+XP96egIaUV9OM6t2QAGQ+zDbubJ9eJXqM7wYMN+Q/dkORoVnEhLQ?=
 =?us-ascii?Q?czG7+Emi+eio9vLsqeL4+DopoHQ7VfMwtVikRpdgzAgYUhaham/auONjxtz0?=
 =?us-ascii?Q?EE0DrBAMw7Z2lCPi+G8NQZqJuh8OMuyXlUEvbWzkOPL1y4TcOOGCDwIJ9kK9?=
 =?us-ascii?Q?CbvgF5FpBtXxHK8Q2oco+ZKGFJUEB8AXx0aXp+7Pgmn5C4h3K7Uq2QdSNS2W?=
 =?us-ascii?Q?u4afBc6kXITNV5bMW3anMYPsMTkDDVDm6WKmuWJrUsnnCfPfz4cMWLcoDL6z?=
 =?us-ascii?Q?ln59n7m4QSCnjsmVVcBrsZZqlvPPMFvKDhTzMeJHC7B7snp0KySV0CGg6Ea+?=
 =?us-ascii?Q?XPMbTaVTHdb97peEvcEFUS6poZ/2oxAUwAfFVfDYXdrUGx8FgKR4g2rSfpKK?=
 =?us-ascii?Q?GnhjJ0532nYmLM0q3pPhN6XncLltyKhbN+Az5kENmCHW+RpZUd4xMuHKV3ZC?=
 =?us-ascii?Q?SHnLrCZeg1d4AcsqO+BuLCKUNV75ZSkobeI5ujzJqtjtST+lLolxafEkRSfk?=
 =?us-ascii?Q?LSuoNnAc9IaaYBpelbls47uCAsk7uh7XOmHvNjS0G3dlMJ0b1JrXs/oJ8B7u?=
 =?us-ascii?Q?3K1psOq62wP7vvml14VPd+6f4BUW5UdsCdy/JWsiXWFp+C/0smI4t/uoae91?=
 =?us-ascii?Q?bmBNOUbLRDeyeAKfcZ4f3XiQrgdomOjMFU6tllfMGAgui7bu6SleHoaVvJUK?=
 =?us-ascii?Q?aJFOqgvX0Gl2B/m8U1lg+dmc9jzy5eTmyDNnA6QZAbIe2Y6ajr4Rl0CQxdNt?=
 =?us-ascii?Q?I4P3uOnJu9wXqIFcu/uQUspqgRAUPEp1nwb6MACBR14r4rpF8Sl289R6bSP6?=
 =?us-ascii?Q?VGU08ZSLcUps6MNUlqiUUSEMR2rFjXN88ZJrbecr9fpiizDWQRVjyeaA04NP?=
 =?us-ascii?Q?FMDCgR+f2eN7L18ENGk3um2j/6//Y9G0TUTPdiaBaScUn1U5CFYQ+bseqQ+p?=
 =?us-ascii?Q?nLRAADiBPdMcHj0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DGwPKB6ClY/mF4baO/6bEiBaKgibvXwup8K0AxcigaBFjABG3Stt1qLt/M+l?=
 =?us-ascii?Q?2qVUmRmSVu54SW+aINosFZAJtx1xC7urdaAahkNfG3VUFZ2zlX+O4A9tLhwL?=
 =?us-ascii?Q?0CP1TagNohl8dJuSBGon5QUWLWD0l/OoQpdy5MUO3Dk6GnD7c1DYlhfmHHg+?=
 =?us-ascii?Q?eEm6gcvrBKREB/6nJxVEfNfsNtD5N+jK++i+6h50NXLbgaRIwOi4HkAdXoJM?=
 =?us-ascii?Q?3NhTpMv+twNKjAFVBd6nbDf/Nj9BEQGnHl2aTX8w+ugfiK/IcFSEvjjLNb9b?=
 =?us-ascii?Q?Jl3HmzIvp0Ec45UMW/zd5vVxmmKa57+ft7dpSzX94zdNDaUSEGClAcVryMQg?=
 =?us-ascii?Q?rT/Meffu3KoyWnaC1HS24esWrCt4/U7Z1y+VfqCZU33eaTViml0D0ngOCWhg?=
 =?us-ascii?Q?vuP7PZ7VK0tOq9a+8aMVGOzzS1gXH7q38hbTqcGrJog5lmV0IIR65O+KGiSw?=
 =?us-ascii?Q?5+WuCUfwt7sBvvfoRqab80sAz29zZE0NolzjvPoKUpjRwtOrBFbaub4IXv1a?=
 =?us-ascii?Q?Ve8jS7QBzcp7bOxFUQ/q4G9UjVumLbVvQP/Mmqao7bh/T3c1Yvkf3OW71XOm?=
 =?us-ascii?Q?Bcdx1C6qy72X8WYw7QwCm4pHBgQZpX/RHLMfp/aWAR71H0/FyehcGivPNwiQ?=
 =?us-ascii?Q?jCdO3f3/EghuhA0rWX1McJbEHbdM+Q1fUVkFVysLTWpXmHUd5nIDdEui/kGP?=
 =?us-ascii?Q?waSDxlcTXUEXiM1nxnPR2ObmiUxVn/J2hCc8BQo8415giXGBmuNkhRO7+1Xt?=
 =?us-ascii?Q?ISOHj6RfAUh26WN4lWlsYgZprMLcHqUu4EaCEG1EEzXxEJ2zRQgn/Tb1ZQzc?=
 =?us-ascii?Q?vnwm+iHRQlaob9E+0y4yeTNXvZVQwq7YMD+ckxaxXqZlXLLQBK+sWbPo9Yej?=
 =?us-ascii?Q?XEW3Biq33rOgGPUHqwmjBJN1XiiWxbKJgbyA0IPItIwYu0In9NkUTKqQpDRK?=
 =?us-ascii?Q?9Db11VTWVqzTzIhI9GS1uxf3j4vAz3wugiKhir4z066RrbbW7OTtWRPSDPlq?=
 =?us-ascii?Q?Qiuqhhq63tOiH9hrP6ZscCaEanaDUK4F3oM+rY/npWiNWPOQwTipNm+l8XE2?=
 =?us-ascii?Q?ZAkjcom8c+W2pt+AAY54sSMnsFs+QTdw/9IGwJTRZGSj6zY1mBnbsGSNUQQ8?=
 =?us-ascii?Q?yZuE/1jHl8EeEe77BdjK+7i3Wpd1+6JpTIs0luSuJvc29tdLPexxfAGELCDv?=
 =?us-ascii?Q?crfHcIvjgjSNeTHMg626nY6ueQuEQHag66f3eNINXCE0KWGMdxPb7M8gwJUg?=
 =?us-ascii?Q?8iRZCPd0OE0XUeaN8v9QpLd4idhRjC3XaitC5mBkQIN11hK6RoHlowB4wNVo?=
 =?us-ascii?Q?kFseCFyyX3XFCZY4kPM2pE3eCW1tTRg+cjf8FPXHI2Uem2cMlSr3bffMs2N4?=
 =?us-ascii?Q?ZX2HTKGf/baK5EjmVyBAiZyZiB4CA7D0tV04YBNHnZOav2dpOT+XZI4lZOLo?=
 =?us-ascii?Q?vgL4J2RRoxymboiBt+TmShudM2UxkSyrGDnJ0TLf+vgN4/bVJn3U/3wfNjeo?=
 =?us-ascii?Q?w9pathTPT5JZ83k2l+sUiq9U5+fllkcCj+z7dwYve+GyJlWnvZPpwAuPgx1F?=
 =?us-ascii?Q?F9MStMN6Liag42RXxXZUfZyz4df50GvYXHg25pQD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d204b55c-0a84-4a7f-88a5-08dddfc7a9df
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:58:00.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 456lE0GUcE0RNKhmrXAFb1TSYkcTzjAwfT4tDyG7XAQJjzYmrQFnD/Sw8e4nowFD2peENcVnwk+whmmvemKNhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5664

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Xichao Zhao (2):
  net: hibmcge: Remove the use of dev_err_probe()
  net: dsa: Remove the use of dev_err_probe()

 drivers/net/dsa/lantiq_gswip.c                    | 3 +--
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 2 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.34.1


