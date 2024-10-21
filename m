Return-Path: <netdev+bounces-137375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 317A79A5A3C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 08:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2B31F2174F
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 06:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCAB1946A4;
	Mon, 21 Oct 2024 06:22:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2103.outbound.protection.partner.outlook.cn [139.219.146.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E2BA27;
	Mon, 21 Oct 2024 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729491740; cv=fail; b=mvPbEbdgwWhcchYSg1z3wBUjrW1nd9g3RwWizNaqxe1uS5YE0X9VhaATwlVtcC1NqdR+HyOpGWr1g8OmTbQv0LvdWKEnz+8XOXMYmJ7GuGPf+1zA8QdBFgCKbqhiC17sN5thKKd4ShxJB4bxBFbBjsKmX6ULIdMhBzFZoH7T6Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729491740; c=relaxed/simple;
	bh=nrhVvbhQ4Cid68XoDalOXADlRjCYvC9AZABxfoQeVgU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NKwKQbeUjAh6HbOs+stpFc9vUZAAp2UuAhUe7RQe3AxbBmHvwVZSx8NbR4ENW+7zrQYPh+2dW6NmCjji6cDAQOUZhHwLy5q8yLKm2+NgjcO4AjRdW8I/S+ajyQssR28i94u/v0MoFAy00UnkCd1Y/X5v/C5Cf690sn0eWEk7LF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2Nxcd/QBKuschKDf7fUmp3agsH8y9fmhcGS8yebA9kuYzGmkyXlnrBDuTAbg+XBbEmNE0h96hF03e54gIzzIqR2J7vd+i2QagK928GJH6A8kDSzrtZ3JBIyeTxuL3qHIjdXNIGMfpkUDnFahyNx21QcHry6CXiEPvYmXO5HcbohHs1mAUy3yFUSRioX7eEogKAjwUQWJkKAQMu2kUf/Zc4Rh772v5G2HDp4wDd1DbTM/VKFgJCDiS/yZnpBMeX/sHzKdrdEp1VCfKPB+y+lbYJzJISiHTfwfZOut6+M4xNJJA+eSmQgM4a4yDmRVdV/l9KuiGpPET/fw3490V5/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAnb4E5HUG15fezuefi26RFzij2OA0OrVaxlJZDy8iw=;
 b=E/KoaWItpjG/Ke3beTQNgaDs7wEE7vVKOD0j+zJGIDIkpJxiKXxPpX2kiaMk0DTR4PVeiXhnafjgf/yphcHZJVFuipYAE/GnA+bhXjopD1pY1prrIYiuGdKguch+i0ci5ZfWZVAzhR2iLelazT9iJO0nxt7Oc3+S/idCbNbWShvrxt/W0xqfqjvinXlI9pobrLMb5AQHbVgGmCTusxGIGdhOOrYx0TcqvhqDB10M28uMZZoheyfg13RqEIfRMN5xq2tW6hz3RINct2fScj9iuHt2tPKUwa7cLn9fb54QOdRMrQFvq4jHkWu5F7i15FUP4ZUiVjHLaHScmZuZYswiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB0996.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Mon, 21 Oct
 2024 05:49:10 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8069.016; Mon, 21 Oct 2024 05:49:10 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmail.com,
	leyfoon.tan@starfivetech.com
Subject: [PATCH net-next, v1 0/3] net: stmmac: dwmac4: Fixes bugs in dwmac4
Date: Mon, 21 Oct 2024 13:48:45 +0800
Message-ID: <20241021054849.1801838-1-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0028.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::15) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB0996:EE_
X-MS-Office365-Filtering-Correlation-Id: cca46268-b624-4387-020f-08dcf19415ff
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	wW3mFeqOVrKd0waebQlb9TTUP1/4hbnUwqJ6nnzoG6OEjHTkICuWvbuGe9RBIL7QIhaqWSb4Og8CDXhE92MfyvwZkEXoYR7R7gUoQZ6fi+A2JjuE3h1SN0n8zhJInywBzKomJS/M4pPikQ4Kwb/0HZUuTW/ANCK/Fysjh7Vn42+F5vpVn+1hn1976TAl1ifahbNa/SNlzeBSTTSC2QqI37Wj5WPdE3HAp+UfaWTZLKHH9yKpfxEPnzekXP43dnhcsX0N0eFpSTZQ+Zuo5TYVh/1t8/tCTYp+n6DSFRiZssipPLk3u7w3jXiGtFOaqNmPYAmiLIqsvsEHcENdH09VPE+TbPj/MVkpZUjLQYt7KpUj94Z7pvGzzxAVZvQin4DYN5vGtoqfNwr2WHNu+mDyr2hQnGTt/MoD7sY66xPDqF3lGYfPBvS1HK1biktuwpOgNwbeMI4I0aeOm0WWZb4s7FMBrCNN0zmzHoi2Myb3U6wqyNuUcL2g9YHN8Q3BwEzB5fZ4UYMik8QR7qYwj3nalzexaGrEw9fXQGlegr/VrGk4XiYVBKqRQoBKN216CypN29xaZVf0aNJYs1HwKzbiCGNRdtGT4INQ7u4hr5XOqz9JwJ66RhOmOB+prW+Q6waJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cGgClt8UGKAfCDugPH4VPFAiXYTaAsVqyl003yUxTu74uV40h53XNOneTm6w?=
 =?us-ascii?Q?H96hggYdn4b3WztEgtJZ10DU4M5B1TLbUjQbG4cpZzIUMnkqSKs0rh8oz4o1?=
 =?us-ascii?Q?/1Ztwn7BK5Fb+BXE+hdgZadgIXNrokMXZgtFPhO7epevx1VSccz4J8KFMtQY?=
 =?us-ascii?Q?KVB17xR12RCpzNkhHvOrT9b1ARUm6io/bYfs4uXfulHQ6/9aLb3Q4lmz13vf?=
 =?us-ascii?Q?d0xatSl9V9UdVsu7FuxWaIVGsQV2ZHBnh5DqcEcW1t39X1IVaccaeQD4A8jA?=
 =?us-ascii?Q?A4619G4g+Us6592g/c+D3GCHnN0TV03LIurF2e4pz5ZDtnT6aGD9hnV/F6mK?=
 =?us-ascii?Q?FWbWxN1MCE5kLHFpIX2XM5Pn6azRZTJljQvAN1kQXkRK9IsdgX5ufKfA77Ty?=
 =?us-ascii?Q?sVtLuiWLyc1JcmhZOmlDEJvXs8bv4B+EcwkXIYan8gphRCbvqMtuQ8NVgndy?=
 =?us-ascii?Q?5bkbNX1UllITVoC9FpymCUYqw9dfz0I/gvRR5hVD6B158ZCMXX6V7ifUZ2jh?=
 =?us-ascii?Q?wWYysCU4B1y7uRzWU7G/P8hrOaeZ432jkUU5W7AaZhUBzMqRXW4ZMqa/GzgT?=
 =?us-ascii?Q?U9lv/BEbD2FQ7EQupVELLyXF+mVdddPCSbKI5fBd1S9L1wYgV0zfcXh4+1as?=
 =?us-ascii?Q?FfikR8vfq2egDvKF2bSNjkPqZ1gokaMh8q2VGlxyIl/hUgayyzC2mfzLbIJf?=
 =?us-ascii?Q?Tt+RjNd5KFAAnkCLhOoawfYUScPszwwit7n7aPidRtOFaMOUeCrDbTdnOnvv?=
 =?us-ascii?Q?Bzp+CQGaKvM7r/LUksqxznZV6CHxah/DemkhX8RL5BwA2HPfKSyYXlH1+73x?=
 =?us-ascii?Q?+4MzSPp3JCY6ah57+NyyNz0e3Ng33OnlFxg+SYdTfLoZ1XsB63sMHGJSmC87?=
 =?us-ascii?Q?RUM8gh9rkCUEbyLitcOil4tC7PTLZeWY2c9kT9dnOCPAgaBQkrvXDAlq7aXx?=
 =?us-ascii?Q?ZcZpHEMDXmgt8/KRVd2jUB40mFaC322gbVQNhFFfXpJw++iZwVirLghk1y67?=
 =?us-ascii?Q?ulR60KAwkuX0zQMy+vjuoNcYw7y7hz9lQ1nFg/DVOIFc86VOnZpsH9y9DzEv?=
 =?us-ascii?Q?48Vwf485/QkcY2U6dTAaXW+L1FmTCVdv0Z7j+cg+sx3+ZLPOkM/7RsCN7ErG?=
 =?us-ascii?Q?dGfKviXaQiAQ4eMD9gb04ns8vZRKCTZw36g+2lPri+x0FAIffQYQ0W1mbu0j?=
 =?us-ascii?Q?m6l1SX2+pF1OZW6apLqqRa/TZrvNN1pObMkmSnsH4vhnQdkih9wFQcQRNufK?=
 =?us-ascii?Q?5kuR21ucHCsg1j2fDDGuYVHlmROAsSqV7k6wagF1eWxWX/1q+xrC4s9dsOua?=
 =?us-ascii?Q?ru86GDMqBLLofTV5zlUjXu8Rp80meDYWtIXSo3oX5Tk1Pcj4AysYNtUDW6HB?=
 =?us-ascii?Q?sd56Z9QDMZBPM48HK7Ut3HiTpSJAv3Ie3f4C+27jWC/a4N/Z1mPiOBvofxok?=
 =?us-ascii?Q?nrq/a+FDx6WO5SYQAibPiGcG34fM+suUcdGX9QfP6ocZMD4ts8a1O+MyGsEd?=
 =?us-ascii?Q?hdepMBpgMH0y79haTsZXkRQsNWf0JOnLCZSZNMe5+w3H6LuJNZ9ZBc1NkHqd?=
 =?us-ascii?Q?DljagyIpuAMpkQK4xtdarPLrtKiF1HVh4jxWYw7r5RFrb82k7EhLAuJgcKEQ?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca46268-b624-4387-020f-08dcf19415ff
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 05:49:10.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKqYHPpXYDT83HkK5aNCh4H/TbofP4E/7V9yydML8ledUxUWvckpCvbY5CSH9cl+Bs9eUOLAY/DKrspMJKVFZ/ysVPJz1LioSnrMw39tDk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0996

This patch series fixes the bugs in the dwmac4 drivers.

Based on the feedback in [1], split the patch series into net and net-next,
and resubmit these three patches to net-next.

[1] https://patchwork.kernel.org/project/netdevbpf/cover/20241016031832.3701260-1-leyfoon.tan@starfivetech.com/

Ley Foon Tan (3):
  net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC mask and shift macros
  net: stmmac: dwmac4: Fix the MTL_OP_MODE_*_MASK operation
  net: stmmac: dwmac4: Receive Watchdog Timeout is not in abnormal
    interrupt summary

 drivers/net/ethernet/stmicro/stmmac/dwmac4.h     | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c | 6 ++++--
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.34.1


