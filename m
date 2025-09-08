Return-Path: <netdev+bounces-220872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0520AB49502
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81301203E2A
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7CB30FF02;
	Mon,  8 Sep 2025 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kkCH5iwG"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBCC30F92D;
	Mon,  8 Sep 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348328; cv=fail; b=IYmo/Lm8i1LBHGWt7bzLbSbTU+fbq+/NwJDK2UnEZJmCJRUn5rWee9OTbOPMshNevIQR8o1LBhuVJRbhApcT5tT1d5pEfo07asOHPkPzQoDoS2KvsJ5Yi/Q4HV1fmTnB7mUvADq7xyjXih6XM1fT0WwBb7kmk7tEIkuQ/PLjErA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348328; c=relaxed/simple;
	bh=XHTshbUL8P6okutR6A6q4kPoUc9exmwzE6wQISt2TyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOUVx7Uututb+4czj1AKZeWwEcGTKRhguFAm1Q3ISPEzm3aHWscAY0QO7ZDeITonEFIAYm8UoMD4Yo60/JDWNHhC9W4By8SNLnb9bO/88uUcoe9CaEeBFlEPqJNSQM+NTd5A7grvvie6Fxs10NvGnScU+P6IUbLjyKZmX88m/9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kkCH5iwG; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQLZyuGaqfTjOpPaVanlxgLMT1qt3QuRcJ3ETXbBIG6EQnTcri86rWQIaEcaqjaeVo+9UCadavauedw4H9uBgqdU0hK9xsh9zgtpvSIMwA+snK9h/NIgRNXU+fCOl8pIJzAm0K4OPsv5W/mbzvr5sSRe1hxeV0nm9LOxVBbbrPiVlnbreAY8Dr3jmDMHYHp7sdIqHBzswopgymYrkUBHkfPTwMGLTxeozgBzG6gOZ3C3U+eMMuApd4qubXTrYhIvB5Feot/Ro7+zfQ1S833T5O2nP9UIvqL7ZuYdzMJRbD+Bzy36X0eBruulWjFHzJHfcVFOX/20vLTojL4jcNtV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ5Csm61uYNa9b6HhzjUtFTpcwhDT/bSag3Hj1Bwps0=;
 b=LuW9qepqgmMlB/mVRRUv5dATGcHLv2G4Qm7lc7uJey6aHkrbhBhOSa2qxzRRHQCHDgJD5yQLgDCEv0OS5YPz8hCSKPZbZ+Xuos2yHYt+EZp9uh5T/QR07i5cdSECB8rx5i+w4TDiYWWFaOV/FHCkVwQj6vgmQus6nA3XvdiTNEwrBlhuC1He8wGtJBJblnJ09MUH2/XxMv5fyMfi8w48vp+ZYubn6bz0/Q1XsBXYY834+AU2KWzZo0Tm6ZD8LzWspkv8ruIlfw+fuv1OZ10b7frEtiYQL9e/L/mHY7uyCLW53KMs5ydiu4i4TJNUTHt20SXvoBJvIi+GCsC1BM4vyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ5Csm61uYNa9b6HhzjUtFTpcwhDT/bSag3Hj1Bwps0=;
 b=kkCH5iwGQeP4FShe2S+SvMKaVUC02Wjj380tCGiOQB9+3m+ZYygyn1+vx22/hAx88ANsHUVEwPiBPiz/MXKBbadE5v+aD6IRADgik6ZYglkUv7GNIMsLyzEzy3riP5ztrvWOnBnlCXh9bSXtdiLVsU1wL/1btrxZVzMfd7DrTUyEk8ZzhAQwNR13Pk4c9Lps2wY6T1m45UIvm+eJI+VODlefZs3/OA7YMPwmTj1quBVR80kP5nqaMnDR48OAmbHR0bagEc8vE5iQDIBNnYpHEWB+Jntdvuxl2tjwoyxqbwuN0v7Vg3BZjwU0RU3S8u06dnKAX8CsWkJdbUD0AxRqyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DU2PR04MB8501.eurprd04.prod.outlook.com (2603:10a6:10:2d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Mon, 8 Sep
 2025 16:18:43 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 16:18:43 +0000
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
Subject: [PATCH v6 net-next 2/6] net: fec: add pagepool_order to support variable page size
Date: Mon,  8 Sep 2025 11:17:51 -0500
Message-ID: <20250908161755.608704-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908161755.608704-1-shenwei.wang@nxp.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DU2PR04MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: d429929c-e104-4dce-d101-08ddeef3612a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8P6mnKL7b4L+fd0Po29leCtzR8Lq2mbf4d8rPazDocBLrUrIfowCazBY06D+?=
 =?us-ascii?Q?R6DfvqR3TnbIa7/9pYw7JpDBea/e+ZbMCwzSl/M7pe7ZVTEV7pK5IAQb/lPu?=
 =?us-ascii?Q?aCCa5kHBtzTZ0rTnvf+kwwZF8cHaoRzSdAfyyu4bIu9DJsxLu5iMmRgiAX/B?=
 =?us-ascii?Q?hdPIigEKbKhRel9QdjFKBDWXa/KXBGhRH0Nhkz2595QoyauHTpPGn4mI/wjM?=
 =?us-ascii?Q?L+cF4l7j0NCFiMTOa53RY74J4pqT1u3lzJVbxygAt/vml6WskMZCnattc1Kx?=
 =?us-ascii?Q?EsOWET0oXZp+/AJnAusFJRzB1Vf1FZw2CQaY16z7gyWW4wOgu1odoK6VXo4m?=
 =?us-ascii?Q?wckV67WR1ULsuu7qHArPprlAhB8GT/XGHv9avNy+lGKLJ20a434b6B1a5/yQ?=
 =?us-ascii?Q?cqPmtih/xh298d1FMb7wQZJxif//CfVxcTQIfN8sqSlzB7qdAXpePjAS7Ql8?=
 =?us-ascii?Q?+TP9Nbit2Ppzz9M/c3H5gWesWUQKW2iEU7qtDp48v/OAfb8eW/1kS6Fl9DpS?=
 =?us-ascii?Q?ExbFCVv7CiGKToSWJrP6ZGo/7xSo6iGlW3ANB31FxeSlL4pHmm7vYLwAs3sn?=
 =?us-ascii?Q?DdCs2yw1wqgR8ay0+NtpuAIkJQroFHhnsKdo7SzuBEfvPChmt+T5nLQZ37YW?=
 =?us-ascii?Q?c3qp4iC2BL+jepCplp69VudabyDkKNdDl4VI6n+3kqfjAioLtMnAvgYEWnoL?=
 =?us-ascii?Q?9jmhno/cajqc6G5ohrDEPyAcUtUeqBK2pg+rInItvM1f5xm5a9xTPsWYTj+8?=
 =?us-ascii?Q?8dCBK0D0iAIAP7Vsz3wePYYhB7uhNo2PRWvVB0Oicn3lzf4D5SD20Pw5t11E?=
 =?us-ascii?Q?J7iZ7UwC0Ft4pZx/PD3vXd7fotokl0+Xr2ppwPWh5bIpoM3Mnx3ObZ75sPJe?=
 =?us-ascii?Q?rf6zCDlRQ2FbZpefZgnhLUTQECdRuVwjNXxyabQsLftuHLPx3ItWvj6obfEB?=
 =?us-ascii?Q?Sk7wlMOESbFKyLUpdc2XMALAmehhknQNUbqF0tSz1O8pF8amHw8hM1+i4JI0?=
 =?us-ascii?Q?63BwvUMk2aEQmHaPxuQhct/0vK/CWyPXeC6zBvb6Hl92RrSxVvIEtc+j4K+o?=
 =?us-ascii?Q?nLOB6SS5upoclr/qb+j9ryiO1W7fZxduZcJSWim6JIjxz/45UgO5YRM29ROg?=
 =?us-ascii?Q?HSfwtAeIXzf8uE5xItBoFSg34hS5jnqGteXqfM1QRyfGLjMhHHTIojxZVqTJ?=
 =?us-ascii?Q?lvCZCnHd12gjF1ljoy/YH5wf4QWn2yhqMGVVjgFak1rKeKx3NP07JlPnQwE1?=
 =?us-ascii?Q?kiAW4yZ9dc9hbOlCxgH+7+X/EphxM6MW8Y8mOsHFS8hv3fjjHHsWRF7J87MI?=
 =?us-ascii?Q?FSGL+pmPeGXeEoCDOidtkldlqngC/WeNeRbV6CnIkgdDEy2ibz0KJ4tukdZU?=
 =?us-ascii?Q?cC1aATNhkSzHCQLEGEqMkKYzxiKVrtA944E9Oil8sUI2gqlSnNjIz7XedikR?=
 =?us-ascii?Q?MLl0SCWSL+eO3wTTIVEe4u9GUMLES950mBlfUFFJfQk2/rn5k7QD1ga6dHig?=
 =?us-ascii?Q?qmTHYwYHQtoZPbM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xJ6Ta2VDTjMkG9tZ1SU/Alnh8dc8h6KwR9cziAisrbjYHN9skSa6vkRQy79Q?=
 =?us-ascii?Q?2B5iIwTTVvwGj0amEW80Di6L7h7/KEAw2ln2bwMJGXxC9zR6RJI3TooyT8+6?=
 =?us-ascii?Q?4Q9YeF9bQ/jD0R2UFu1+0yns9Iq+kpKY9FqcQCUDQw6eWGfliqaaryQWKrjH?=
 =?us-ascii?Q?6O3f1UBTXivwdVh/DRE3l6DcQLtnuubL9tMy0Mxf1GBIZbY4R6d2eT9F0MgY?=
 =?us-ascii?Q?uoImEG7vl3X5+jSO38i5YktLdDH++oHjxGwh/BYxKq9J0P4E7HmlUkAqxm7m?=
 =?us-ascii?Q?7e53VeivBKMxz9+m260S3VxDpuvy+9TMg31/RGxA302B5hiJ8uUXRpZXZmAr?=
 =?us-ascii?Q?S6ve3PsXDycCZEoO39wagZlAkUPPB6CrzWEzKUce/LL5tFOcONb+od42RM30?=
 =?us-ascii?Q?Nj0RvrlJ9GuQ8Nf+tP8t9FdanXtJUsRXVfil1QIIl6rVLHFCDbDao6C60rZw?=
 =?us-ascii?Q?4uWK+nvuuD/nylXYrozM6i9KGQM6nfdLMA9Zbw6bkcxpyir7PKZZ5GcLvOHY?=
 =?us-ascii?Q?aBKCipgThPBSOdJxWO7FYvPyVGOOk0nDWc1LYHS8uebFJJ7PNS0EzRPmwNWL?=
 =?us-ascii?Q?xUgBCVfjO56EX2XEqL/A1BYYon1gK1Q7qh7U6B54fN9TUaMiBCeYVMgNdGYX?=
 =?us-ascii?Q?/dc4wAB2NZho476WNyAJcZdOPyNnkOIt6oibipp+vdRtq2Hi6uRr5VWUOq9E?=
 =?us-ascii?Q?LjMEkhQWq/HNa4+twKR9QSp9MLOwBnVQYKEo9ZNDhSz00RQKef5DK4agTUD2?=
 =?us-ascii?Q?iOb/e6oYHcPNWpswoJ6M+cAbXdCEF8YJj3X6WxMYI3Dvbo+KqMSdT5lp5wgy?=
 =?us-ascii?Q?RtmEQ3ISC+dxGWbmzXJulPXyGITDZwzh83xmuoYWbQUDRqDzkpuaRFkMk1wD?=
 =?us-ascii?Q?a8O9MBPAOWWnN9mW6OaaaWjjQ7mOawObhr96QNE4ixJUawhi8VKgid8JIorc?=
 =?us-ascii?Q?CVdcXOb6b45vf+Xt20+BReYb37P62DtMmJBYlA07gHvaZdegNgYhhKKYJVY0?=
 =?us-ascii?Q?ww4RfQ0uNv39xEVEfb5j7gJmQmau93JINYNKtSUMgX1Qk9I2it1G70kYMh8O?=
 =?us-ascii?Q?C5mjwSYU/H7f5ngLVr1RiTTqkbWz1m2EMCpiZW+l3Awz0570zvigWZdBVTYb?=
 =?us-ascii?Q?bAaqpqqh6GGKYqxMMlS9qjm5mttZ+IH5SwyYz3C0Ovb+ffYsOi6CUcK4k+xj?=
 =?us-ascii?Q?MKOHWb+e16E65+D3nUBQEGKCbbieollSS4oe3SuxkDjLsHbe7JQC0Dnj1qY1?=
 =?us-ascii?Q?LcfR0p+odCUp9z/Lg6k5hVf3dGrynBnp6IEkrVYMKUT8JY/q2fpVY+Wdq2rQ?=
 =?us-ascii?Q?8qALiiJDyQ1NoCmGY9suIEG4N34Mhtk7kkNabz8Bmuo8O1hgIq+NvQ/Zqq79?=
 =?us-ascii?Q?6oFa2I5HTOOANAz+uMtsk48kYBKQO4a0198OVwz3YDkU+kdDZUsdeWG86YEq?=
 =?us-ascii?Q?V0trL+rLsUgyN4KoiqBs1/UwCHSEJLk03O7QblA+pbheiopo/LU/JixFM5S4?=
 =?us-ascii?Q?ejtWjmWvn5oBSEtDV/wzZvbzivUQz/1QNs0Eip3SiA2WXn1sPeIijmnOfKF6?=
 =?us-ascii?Q?Zcb4yQX7q8qojhkexVFnVlmMbF0Eog27mbxl4AM+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d429929c-e104-4dce-d101-08ddeef3612a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:18:43.3638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlZ205LDiKFO4NJUsTBctSbpzVtElcYYyfgZkOcbyv88TnmScDrtSzpCjfeErrhr0K7QYHFU8DYwfY5lxb5z9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8501

Add a new pagepool_order member in the fec_enet_private struct
to allow dynamic configuration of page size for an instance. This
change clears the hardcoded page size assumptions.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 2969088dda09..47317346b2f3 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -620,6 +620,7 @@ struct fec_enet_private {
 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
 	unsigned int max_buf_size;
+	unsigned int pagepool_order;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9d348a8edf02..642e19187128 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1782,7 +1782,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 * These get messed up if we get called due to a busy condition.
 	 */
 	bdp = rxq->bd.cur;
-	xdp_init_buff(&xdp, PAGE_SIZE, &rxq->xdp_rxq);
+	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
 
@@ -1852,7 +1852,8 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		 * include that when passing upstream as it messes up
 		 * bridging applications.
 		 */
-		skb = build_skb(page_address(page), PAGE_SIZE);
+		skb = build_skb(page_address(page),
+				PAGE_SIZE << fep->pagepool_order);
 		if (unlikely(!skb)) {
 			page_pool_recycle_direct(rxq->page_pool, page);
 			ndev->stats.rx_dropped++;
@@ -4561,6 +4562,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
+	fep->pagepool_order = 0;
 	fep->max_buf_size = PKT_MAXBUF_SIZE;
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
-- 
2.43.0


