Return-Path: <netdev+bounces-157803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A173CA0BC93
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D89160FD1
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FAF1C5D7C;
	Mon, 13 Jan 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lenbrook.com header.i=@lenbrook.com header.b="FPayzdCW"
X-Original-To: netdev@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020073.outbound.protection.outlook.com [52.101.189.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56FF1C5D6F;
	Mon, 13 Jan 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783339; cv=fail; b=BVoER1UwzgNI4mCkg7qrriuA5JS4VC5hn/lhnXd/uXFDRWVJVyIxxQt2yMKmXsEkJSBFARxqPhckkFKBOyM+reMwI5SIQoG2Q0GiMA7LuGx8eq6G3/ojxhmyNd5lRFCmXonchH2kybV/dD2bwhultsEBs9bpIpinA4G8+6vUX+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783339; c=relaxed/simple;
	bh=11MaUkbWorjGTKq5EPT2u6Zt9Ji7vCgtDxcy78Xf3go=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F2Fz4Xu+a/wFqgbvZ03YKyK/6anXXduz3QNK/EL0wFxwCFJOIjqJHMLTdzkhegMEVY7pl8M6WLPRKCgYD3cYUDzPjyKwq3LLKA9ANKkvpclNFV/y+SpFSFRl+sTHu+AgQih55AK6urIegRXqFKtg3lqsq6EDQi14OJq2/tzQ+BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lenbrook.com; spf=pass smtp.mailfrom=lenbrook.com; dkim=pass (1024-bit key) header.d=lenbrook.com header.i=@lenbrook.com header.b=FPayzdCW; arc=fail smtp.client-ip=52.101.189.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lenbrook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenbrook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c599gW29Sw0d5olgCHNXmHUOW5zmtzgLmgPjAQ8OiH16Ie0hJriV7Pu3NV9AsHFICEqxmQX6xDUSxXWxOAj3z3nJH9iAPGK/18/YRRiHhBYczfQMutozgBpbs1YwOj1ofh7ZMyoKgZEs/YheKgb1RpLzPnhamsiZvrSmVZ3dNhK2WkseYQ8PkG2WqteOktxdfYcuCjXBe/TinhM37UzxGYkuPDwyqZxHwISwIe1zjxe/a7DS+9Qoaa74AUasusgXPvazGJERaTJOZB53gyVQMMA+f6K7aP3gAES84IoDBPX2FdXn7nEQJo1L2EOjkRbsGXRAHYfjKcjiGxbzOGO8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dA2vd8/rN4O45KmLUMmyAjsXsBcvGfAA1ChpJhXOPmw=;
 b=s3LJPjdJtZjMYwaOU3Lv6s9cHK8YMA3+RwIbw/x+sEgG+We92H5Y51xP0Tz7ze5hZ3L1V8TO7vXOQEaq+bTcU55R4RijtjZlH8SygTG463gXDcJvla4NUlHWjOE5YUoGpVYZHl/dK00KYzOEmurwUErpuu65MGwGJpHAFj4ikshnXGhWKioyWSu8P/pVIiKlMbCpWVrW619o0esn0KA0V7tAibGz1LcpsSeAkK5RUD7itn3rKv7EJoLVX+4IEG3fTXdcXLCqLOVIW+5P3T+YoddAwmXrKeeenv/yNFJhKwvV2jz6JtQzCVN9kJNTrJtlT01y1AwTyTgQsHGRN4LTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dA2vd8/rN4O45KmLUMmyAjsXsBcvGfAA1ChpJhXOPmw=;
 b=FPayzdCWCb9qY5zQ5LNo+k9kv1ZPtEIPXT6i6m+jylHvKHp8uJQc99fBnIAeAUu5Ft5HJu1zcL9noe6NMX/mFjd6u9kLVFk/OHmJBqBcRXbLmk+d8RTB+51IZezi+1j4pXMdDfpW43mHxsUr826HZuJ2JEZakbeK9zQ14ITnnU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:54::18)
 by YT3PR01MB10701.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:48:54 +0000
Received: from YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9def:1c97:2f04:5541]) by YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9def:1c97:2f04:5541%6]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 15:48:54 +0000
From: Kevin Groeneveld <kgroeneveld@lenbrook.com>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kevin Groeneveld <kgroeneveld@lenbrook.com>
Subject: [PATCH v2 1/1] net: fec: handle page_pool_dev_alloc_pages error
Date: Mon, 13 Jan 2025 10:48:45 -0500
Message-ID: <20250113154846.1765414-1-kgroeneveld@lenbrook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::17) To YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:54::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB5632:EE_|YT3PR01MB10701:EE_
X-MS-Office365-Filtering-Correlation-Id: 8798f192-ce25-4a36-826e-08dd33e9c895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UQmiQAASweqbFiUFK0as+ZNa6p96oiebHJPIU09wxWsHy4r7ttOX9nyCRlr0?=
 =?us-ascii?Q?6DF30WpPELiIuxazf/Z0H7RrA9mH5MkCpkwAgMTidPfH+5+Q68eZRGKLige4?=
 =?us-ascii?Q?Jf9j/OoVEj/1F3IjKc8AOud0F3jNLmyYQPjsBYSa2fd9LbddcLD1e75dXvU5?=
 =?us-ascii?Q?Z6D2oILld5wzV2RRx8Mjl4gMS2mH1xP41/eRc8d8uMqKFW/tbZJW16wIuB6m?=
 =?us-ascii?Q?joKZWFwh3146wO7DVJ7pVC2E1zA+4jxvUmkHVTrdsBcAa3R6WbJ7pINVz/e3?=
 =?us-ascii?Q?Hh0z2B0mhuL8vQrSKOwriq39c0ZjDe4PK5zZePs9KrmdEj3BpKYMtl/fTJYN?=
 =?us-ascii?Q?zCYjneaqcaGU6TEjnf0qUGJxWVzvy+A2vzR/p4qeJ/VgWvmidM93UbR18iV9?=
 =?us-ascii?Q?//tmALur4Kkx9Nu3d9IJvDjj1VWwzCDlNcuzhBOp3Z4sONF6lqCyeY+bIRYM?=
 =?us-ascii?Q?/dy2JZbFloiRPUO7OiO4FpX6hv+NEjgMHQnFM0xn7VvFXe8VBzqE9wFnPKFh?=
 =?us-ascii?Q?S9B32NA1U7pKHcf76oixcIRnP9+ZTEJKXPBlcB4jgIUuuOhum+OZ2adwA1ro?=
 =?us-ascii?Q?56qk5VDCFW7Teo1/fBZIlReXWj/Yp/3Z7M4StvrWpgiMeuxXiwpJ2iCnDW7U?=
 =?us-ascii?Q?B9p6pDiux3L+f8LcpqRDr4AbBBiuLFmbR0DiiJ7b8CAI9GZaCQqlwtXrqH9R?=
 =?us-ascii?Q?YekaabvRVdsfRF1v9ixw9cGIW9gCNuRKHl97EP6BDDD2jYM0vQkI3fgiE6ve?=
 =?us-ascii?Q?omHpvkvxYopZwPhV4feAsHoTnSRKu5BLGXS1hog24ceFBk+SMgo7JtQXwQPu?=
 =?us-ascii?Q?5haoxKfO9K89dXjYdEb5+VrLpYaLb1aArV37+nwb2vKqPU4ZGITosziLn8Gg?=
 =?us-ascii?Q?w09NGGCh3Lf+5mGQ05vEXqOW/lzFHED/1e6dNKxNKVpFaEGHaZ0j5rfytX7i?=
 =?us-ascii?Q?gO/uw09E2a61+d7UTCXjcSCtNknHku20NaZnUgDBOWN+d284tn/gK3zZN20P?=
 =?us-ascii?Q?v36znMFylV8arK5VY3m9NP2gvbbw3mDzQ9MpO83aelGQfTQmOwpfwMasCCj8?=
 =?us-ascii?Q?d7ZFpt1sUMYrzi2nbbtHRMVJOMfPKWJFX8BDB9bHe6U/TLHuxmmocTTqxbdq?=
 =?us-ascii?Q?mbnM9E7dp8AAcyk6AQqnIRU7VKw1xTswJjSMX0ylK7x0K8ohNa/ApNjZDxGv?=
 =?us-ascii?Q?mpNQB5OmG5YZt2DJCb6KaGVPDPLEv5f4fwGMmuCanaMxXQFL0K1aHr5+mmjM?=
 =?us-ascii?Q?6TArx5Sqlfc9rVFik3Ms97uaZMbBvGcF02adz2xqJ7YRWldeqAgyRgNZ564m?=
 =?us-ascii?Q?Mg2Bq46EVr9MGpoMsCKL7bKRnt322s8ljuOPpc3YHjPjsZDw9qFn4fFJ4NTS?=
 =?us-ascii?Q?SI2K0uNN4/liQ6NpYZuvtgR6hZ3DM86k/EFRPUfOwduHCtyt4McWNHMR7Uwk?=
 =?us-ascii?Q?tva6KlVLXa0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gcHdV9Bxom/iIvquuOGEyAEI78xXqv9dXH7gL/8yEKLSFwyoMxnahwLYer5p?=
 =?us-ascii?Q?EuHt3GZ7Hdnr+fxG8QxEh1FjR3l9QE265uvM/OLQ9g5VmUZxHxGJPFRennJz?=
 =?us-ascii?Q?IKS9HFyN1TGUe3YWZpgFlm7G4xW+gINImCulXbiquRTxTMf5Afz0F0m7XXGp?=
 =?us-ascii?Q?0ivUCx3Ez4GyId+ZuzCtwiZlW6lG06g1YNBDEDQ62gCh2WZGYmZMB4iQlsTO?=
 =?us-ascii?Q?5C1IChIFix6KztSOojaVu77cdbVCRVsNYnkO6yE7+9/CS0E2lolEXZ5gF9qZ?=
 =?us-ascii?Q?mFHHNLo7gggxFmgM39u7sRPV3pDyPtMTp6JUssf0WNgZkaDdIc8N6z9JW/mm?=
 =?us-ascii?Q?0sJgiMDgoW2dXeQiuho/dq2LLj6/8X3Oj0ZS2HThewPE7s497Hv3HY6Xx9Md?=
 =?us-ascii?Q?lXijTQPlWqn0Kgil0JSjPgCxbMEZnjBMOoMDsb/goyJhrX0+jjKVzPTmw0zl?=
 =?us-ascii?Q?qSAAsUXnZLr87w37aiBy3yj+Ea0ubOf4SEFAz7xVH51KrKBJV1GNgInKoT6j?=
 =?us-ascii?Q?pKPXZ0ZwWky8tHfD5rHiu/8xrJsnqStlMkIYPB3pme/k6gtBfHwPyLX/yQI8?=
 =?us-ascii?Q?Dh7GjYKSh3ffkrEwfKwn67N0qTts7+RLJ9TTPv9lZIq5OISJ/x06DB/bo8R5?=
 =?us-ascii?Q?GCdzgs0t7VKBlT/Gys9cWdd0hSoKHWrC1q2mFSwfAwrrCKiQZAzzMJAvCJao?=
 =?us-ascii?Q?Eh4cLi0MvvxwPprUIj5mkqP7vSZWGxbCpq4rsVFidwWHBAHKxWCqwFB3sSCT?=
 =?us-ascii?Q?dgvPP7QoHcz3iooMLurVtP8+SVIxnesDMcKjpjdw4MJLQoeupVqcTUTXgC7b?=
 =?us-ascii?Q?5TzUzhjbH/8augvJGUwN0vqsvYVBFiajyIoXUdVdyEVrNpZgFusgG+dT0KZS?=
 =?us-ascii?Q?pVkiWJfZcAtSz2uaMzfjoyw/q4Zk80qP5VwVVH4MV5f9+6cL6DixKwRkkv9l?=
 =?us-ascii?Q?nMaSiP7sMUWScGSYX/xu+wXu27Clpnbm5Xe0r0fmndmBXje70wRXcfOKMj0E?=
 =?us-ascii?Q?AqCWf/wa3Qyh8zMbLgDUbsC8fdfVW8NWxtEViZvuhcwBLhXWZAcskVjk3Ef5?=
 =?us-ascii?Q?OjJJaNU/WTyMyNTAXaFZJGH/grkmDyrtRNzNzMGWZmFCpSk1jh7e+V3NCYOT?=
 =?us-ascii?Q?YKp0k/i6tQaZm5bNJ5tjre6gMUbn7qDWj/Rle9X2mjX808JBSs6+qiUIQ+Kj?=
 =?us-ascii?Q?I9oIGPV7cqIdBNv0wapGCepEzsW1ZCLKjsmVHKVPDcmBJqfAIpR+cEoW0aD9?=
 =?us-ascii?Q?KMvg3fLnyqeEef/AOZHWrotc9k3L18RtAegRxgRkP+TmzXSTFp6lQ5/R4Mbd?=
 =?us-ascii?Q?PPaY0g8vPIILx7D1OS40ZHBHM7nfHY3ejYozxRPjAMjMRnlLhkabXSUrLsXO?=
 =?us-ascii?Q?22JCgJuBvvXpAQTni/NQy++Q9g5yyWx5I29PZHAwRG4BnktM1gFQQvQPxx9K?=
 =?us-ascii?Q?q98imT0OvDcdAC6/ba5nLdDMnkoCRLCZ2wzlgiRlSgbjyJYkOU+ZDXTwhZ9j?=
 =?us-ascii?Q?rvkqW+oeQBI9UGw3+eVgcyZyKrSAr+cpnqvsK/NWA2Wgl4q13eXTyvTApH7X?=
 =?us-ascii?Q?ZOEqMaYvDln4QCSWgRVKH/EBOrhnTGOYNrqhjk2sjMCBG1unTWv5qC37ZyPc?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8798f192-ce25-4a36-826e-08dd33e9c895
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:48:54.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4AOcKo9zNIozC60dOAza9gWHh762gULI10046sw6SF7p8MUeZny0NVoj8O0wMHVuARAGILMTcyz+7JoaJjRnesCLQc+5nyhpLBD2evM45Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10701

The fec_enet_update_cbd function calls page_pool_dev_alloc_pages but did
not handle the case when it returned NULL. There was a WARN_ON(!new_page)
but it would still proceed to use the NULL pointer and then crash.

This case does seem somewhat rare but when the system is under memory
pressure it can happen. One case where I can duplicate this with some
frequency is when writing over a smbd share to a SATA HDD attached to an
imx6q.

Setting /proc/sys/vm/min_free_kbytes to higher values also seems to solve
the problem for my test case. But it still seems wrong that the fec driver
ignores the memory allocation error and can crash.

This commit handles the allocation error by dropping the current packet.

Fixes: 95698ff6177b5 ("net: fec: using page pool to manage RX buffers")
Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
---
v1 -> v2:
- Simplify commit message.
- As suggested by and based on partial patch from Wei Fang, re-write to
  drop packet instead of trying to return from fec_enet_rx_napi early.

 drivers/net/ethernet/freescale/fec_main.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1b55047c0237..4566848e1d7c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1591,19 +1591,22 @@ static void fec_enet_tx(struct net_device *ndev, int budget)
 		fec_enet_tx_queue(ndev, i, budget);
 }
 
-static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
+static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 				struct bufdesc *bdp, int index)
 {
 	struct page *new_page;
 	dma_addr_t phys_addr;
 
 	new_page = page_pool_dev_alloc_pages(rxq->page_pool);
-	WARN_ON(!new_page);
-	rxq->rx_skb_info[index].page = new_page;
+	if (unlikely(!new_page))
+		return -ENOMEM;
 
+	rxq->rx_skb_info[index].page = new_page;
 	rxq->rx_skb_info[index].offset = FEC_ENET_XDP_HEADROOM;
 	phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
 	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
+
+	return 0;
 }
 
 static u32
@@ -1698,6 +1701,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 	int cpu = smp_processor_id();
 	struct xdp_buff xdp;
 	struct page *page;
+	__fec32 cbd_bufaddr;
 	u32 sub_len = 4;
 
 #if !defined(CONFIG_M5272)
@@ -1766,12 +1770,17 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_skb_info[index].page;
+		cbd_bufaddr = bdp->cbd_bufaddr;
+		if (fec_enet_update_cbd(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
 		dma_sync_single_for_cpu(&fep->pdev->dev,
-					fec32_to_cpu(bdp->cbd_bufaddr),
+					fec32_to_cpu(cbd_bufaddr),
 					pkt_len,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
-		fec_enet_update_cbd(rxq, bdp, index);
 
 		if (xdp_prog) {
 			xdp_buff_clear_frags_flag(&xdp);
-- 
2.43.0


