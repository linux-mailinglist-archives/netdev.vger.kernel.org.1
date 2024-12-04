Return-Path: <netdev+bounces-148817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE409E3346
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE5C1604C6
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2393A18D64B;
	Wed,  4 Dec 2024 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xm4co7zk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFC617DFEC;
	Wed,  4 Dec 2024 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291155; cv=fail; b=uqohHC7m0Txf0Mk8jtzfjWLbLJMi9/tmQDPg9X5dVnksbuF0XB8o2fhcDM7IEIM2bzGnB9tKmUaqUzekEwMMBRmgg9EUV97U1FBqftrIfwcaj0kJaU73v7EZ6Nzrrgv1dejAMMHKLD9oJclC19DcHr8nbpiebT5hIgXzheEi2T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291155; c=relaxed/simple;
	bh=vAM4Ne6JpteYfBEBQeDuGtVhoaGzyZxVNK3n0QYS3Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q0GFaNdoVlureA2U0DpeWQcvvI/w/3i14G/CH/wY6ntQPur0Qz0+3DFgIyBM7vDFsAzzibuH197PWJk4LhKv35WEC8PWguOC9hO9oBf+WjfFvA0h7eSgYdHVFQmR9XYPNLCOW52nPrr2xp0xKVBKdgurwdgx2IrFeWoE018HKVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xm4co7zk; arc=fail smtp.client-ip=40.107.249.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTnufbG/aZCa7OPkYWjHVJh2qDAtJ2yM83+AfaJboNNbwBaCPVAoyqbeqq1ClZMrkUt9CBiLRsFVhgez6GzAMi+OtK+MUKe5oQ/GkfRYmtk9hZXaytl3uSS17Lxp81WN+b2g7sK84Ef2PtDuhc8V0iGzIGluMNP5OIeuD6q0eCV3035tzgoFHstz+S++wPr3GGkpQiPOHk6inUNXn8k4up9SzWtMAi/x0kfqev+A40/FycRhyDxWOBFzChfWkxY3riT9vCfUx65lef3aUPaWAOgmrt5Q1uWWnG+hV0jhP//p4fnGi8JXWjt9lzrJ0oUQHLIWhhLYSMMkiZJw5vFn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljeL7HquODLPFjYuRoOdvtxer1d8IKNE8Q+i8GGZLwk=;
 b=owc9AiDj+r96VgravDhbH6RXmrKlYmDxZt+aC5/IS8GIVXCsA8NG9Z7xlkJqpBPCIkuziUGImCtkN8rt2CNE6+RlDBfJ69kvWhILtzdMMRgSOoxN24UnHOq3EEnjhDxJqerPf1SWa+qPa4fI56nmlIsaKY1zXpoFrWQqc77/DRHQcTggUOElZLVHInFpU5CI9C8Bu16kSZHM70oRY/0ME+3M5b8yxRm60VcN4+W2jzuNbzH/let6vNya2sLN74CBhXbLPWQSM+lYCT38mexwwFe1rTCMIZEbQnef49qUbbu+IrWv4/gCvWh/WLg8COcQ7PJ6ORxInSH2mCVV1dNMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljeL7HquODLPFjYuRoOdvtxer1d8IKNE8Q+i8GGZLwk=;
 b=Xm4co7zkakRq5ZOiO+MnOXMwO8QYMQ5NKVDErSQWToEUSvYiAEAPoVdNAvSTzPDWUcSJg3ARC/JnHzgLg1Crv5y2lHi6EfdpLuKHpJD++73RfiQDjDE5xwJIMXDofEj4iji0Cu7ZcXq9COYjFi7xuwOXmhHwWBEA+zEKj411XMu3QxuS6Uakwvi55by6URYBq0LBp8TyuP6OA3AAOXXF5+VZNv+EotbvZ34yAnmjapDYixqS7CumpccFiSv9AbY/Ouk+PnCypnSMb7+fkkyDQXQQEfi9GapGi8gJMsVlS4kjbXnbNKLrNyLPt7dDKcP/qoXNxlpw6EnyJCfZ9BBboA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 05:45:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 05:45:50 +0000
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
Subject: [PATCH v6 RESEND net-next 5/5] net: enetc: add UDP segmentation offload support
Date: Wed,  4 Dec 2024 13:29:32 +0800
Message-Id: <20241204052932.112446-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204052932.112446-1-wei.fang@nxp.com>
References: <20241204052932.112446-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e6b237-d6db-460e-c289-08dd1426e892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GreNqC2jdHAD7h/3gMBzle1wu59Qa8IknxFp4H0pUMcrgrSVcY6dcjW4KJeS?=
 =?us-ascii?Q?gJRRYVZBUCHjSumisG129oI3A5HsLfajZfpKsBjEjMAk2ut+zeWkqaWwdcOX?=
 =?us-ascii?Q?V6uzeP/cGcEToBSw82+cP1Gidgd/yKwzgpQKtisHBIZDLAOZO/EyJZIn1d++?=
 =?us-ascii?Q?xfFXUuoVzhwmtF5ht0B9eaSa731HQNnhJ4/dm3xLLN56t0hMvDhrSkaDS9FI?=
 =?us-ascii?Q?VPrrueMTZ6eZK7NtlpDKqYv5Ez3wRve6MnzR2DUMsT68iOzYTD1VhtVk0pUR?=
 =?us-ascii?Q?zOCXB87w2lfapwov408kNK/NZTxCWmgr8dukVrnPW8V8VCFh93hSMiGCeezm?=
 =?us-ascii?Q?6qsKeaiYi16Xkc7GV3njaRkE9DuZ7gvGxZne3iXdz+/tk8svkgbJLD0aHDCY?=
 =?us-ascii?Q?qQqS0a6rXaSFM0ovZbrkNYU4osjcrtXXtSiinKtzBpMfGa68bHELvlCNJGQ5?=
 =?us-ascii?Q?40hu/tUFxGuIV/JadOq2orFEK9HgcIrAy1eSIcKIV/cHS8nsztBwvTmGdRu3?=
 =?us-ascii?Q?rkyJodd+GZdTgetSP7fCb4zoh5/b3duMsrHJhKrJpbFidEuKhvVT7B8MF1g/?=
 =?us-ascii?Q?qHEaQjUbTNlNNeEplh0QgH2PAbFDpnEgy/PeNUzdrm6Lnq6H5HVVeQaxQenj?=
 =?us-ascii?Q?YKfIaonlHNlFtL+fppNStYaeJp87ThaF3B8DMxUYWptHA20ZexfTQpnyEWHr?=
 =?us-ascii?Q?5jV+uA26qAYsdUcdyBySseEesDqh36Psw8Mh83hN3Aa15G9m0lJt6atAXyUR?=
 =?us-ascii?Q?EIAZubuwzz/Uf1zSZO6z/IwDQwNZQt7GOV4J9rMBwSt3NB4kGbP+3bDkJX+c?=
 =?us-ascii?Q?CqIVeeFRvZouED+yDNAS8fODfEIGNXfbN6MbX1RTdmG3yspmAmE2relM8lmz?=
 =?us-ascii?Q?PKi7hiy1z/QWLW+JXcGEeTQZwENWowH1goB4p9K2Nqs2nJuYRn6fiw5sDypx?=
 =?us-ascii?Q?s5Dv/7pNx5mFujl1NsbGaXTJbewzJ0q1dAB+bvSf7OmR/26x8wLelVtq2kU4?=
 =?us-ascii?Q?8Llc+cyN0raBzEx2C6yOM0hVXQudS5D7P0Bce9fmlgzsArDsjW9FpjlLvaYV?=
 =?us-ascii?Q?SfFx584h97vZ9AUjHWp7qOz7KVWug1ZxeLiXklS/GsCzoieCdahvFSYkZuyu?=
 =?us-ascii?Q?5c6I8/O/G92UvkA0XQAtie3EJmLs5ypk7QtKVfWmnk/mwrZ1SCRu3B71wDlJ?=
 =?us-ascii?Q?KEC3/RLrvs+WlHYqIHvjSzAbBjuzmoXw2MCRiwlzNa1yfe6L0qYS9TB2EvYr?=
 =?us-ascii?Q?RGZCIki2ZIFPu2Orc+zw0+QhxU7Nv4/h7OKP9tzWWewoBn0aWDqCN8sU2Tbn?=
 =?us-ascii?Q?KeYGera3F6Hfv2kY2/vxRKGdb2BpsXEyNk8dQpMC4vwS4jRZSfKZqL12cuhF?=
 =?us-ascii?Q?Svp+yMvmwfuNiUTIkhjrx6fQ8wFcDz2mA41cWrodB4XbuUHEWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tofdLkmmUPflkBVL9HHAY5qBI4ZsAll4kGNLYE89xW6SmA7Vumng05J1Ls3d?=
 =?us-ascii?Q?+OuDcaO337/fsq2EMHrNtWrP9HhJo7VtFd79x9WYBZoSx5QH47tKvrI9MXlo?=
 =?us-ascii?Q?GVicw4rCFiTlF0PN7iaa1baZ5TxZzXgDx4fmTzyIiGVsdr/EQ4BZ5uOKAJo9?=
 =?us-ascii?Q?6bdim3RIIoXqzlMwXlwVgD5Tlt7xtkmtGxqoNsWTmY/FSQomt1VJ46y3c4+B?=
 =?us-ascii?Q?gK8/S9BWzJAkbYFvQApMWnGrJg9sEOHvpocMSE9RA+teAodXgEgYOuWD/xhg?=
 =?us-ascii?Q?KLV4iXW9d/eA+8CdUUA5AshQmA3znW/CiVPc8ea1YQeICd8CoDv0qNlroWFw?=
 =?us-ascii?Q?2hmP2IMqrtjfCbqyj6IjLhyU4QVXMzsCywnDf53W6fUvbdztpWY82uVEAwm0?=
 =?us-ascii?Q?6QXxeBxnPoCsojBZ5/2TSiMb8G4K4asoHXiroEX588aBbvSkvlckkPqqocit?=
 =?us-ascii?Q?lEnaFabbosYt0mThW3Q4R6FlUsuaSrLBLEXFwbYgfWFU2WwCazSHJ5IxPbXl?=
 =?us-ascii?Q?p1J1sjvf5HCn8ROEvpQFBtVWbmXK72lam7IfjwiTCwVX1UwoganqI2s7X6+l?=
 =?us-ascii?Q?2sDzC/uJbhvnaF8HDRndGBZPclkAR+YeVxcAvsbsQ7C77W5CknHo17MVTHa0?=
 =?us-ascii?Q?Yn/Md1kqZ4eENRqZxJyXWywejNsI2JtfDLp7j/9Nd6ts9cUxwmn6KXo9YYhD?=
 =?us-ascii?Q?Sz17u12EB/TswEkQeKP+d61AY6v5w6E/FKGyW9HNDfFgRlyA2q5cgoMcU27W?=
 =?us-ascii?Q?SqM3w66p2zHiEloWVWnktICGkPHzkpDZ2ZaljwWUqhPzTPQV0y89ZCIc7rBX?=
 =?us-ascii?Q?LJTNBAQZyK78Mg3OaBM0sISmrshSbNluo1NAgZHUeFyLAD8iBNg/+GMkAwDF?=
 =?us-ascii?Q?/rsewhWwSmLRGHCOAQHAgw40FgdS6pECqYOUPCYdXmoylqqLvy3IOqqzUU8j?=
 =?us-ascii?Q?jsKZoYrY20UpFAkNjSMlCCkGfEmO9y/JHpmsIye0Za26SLD5/Or6rV+WtX3+?=
 =?us-ascii?Q?m6wWD8cpco7JYSUwqt4bVKPT2dBCF4S7bWHm8KP/ShYGegy+175ysBwdDV9D?=
 =?us-ascii?Q?FxsQ9nl53+i7Nmz8nOQYOliCQbsVKoJtCG/2pa1XEc1/YVJ9I8NK4BNuX1y4?=
 =?us-ascii?Q?FTkLWdo6/aV/RMmhumQFOZ9cU8PY39sgJwl7ad6GwPFH8w/mlXKjreDk4MEI?=
 =?us-ascii?Q?Wzk/Oj28YASGHdTLrtpQeiUkf1C9YWVK3HSD2iT2kiANpEDEyjf0wyVuRsWq?=
 =?us-ascii?Q?KeeEYXmFfgEELprKFl3ayOR7YcAGm74W0AxrjnhSBwKu15cwt4BN1cSRNf/t?=
 =?us-ascii?Q?MA8ddBwsy5EUnrBjDB79KnujmUmSvzYyr8+XOoKk9THINh6d43FzEZbLXoAf?=
 =?us-ascii?Q?qbFcGe4DgNfbZyD3hJnar2N9hCr3NHioo6Qq7CHg58gorUgUwHVosbEs7KG2?=
 =?us-ascii?Q?Bj0pY7A2ITm/aGQtSRwNwLNsJglrAUpse29d9+7CFNBngakGQTjsB50QAPxC?=
 =?us-ascii?Q?PsZcocId1S2OAqA7GFQgct+r4O9kukojVJSN20tatB4b+orWDuRJoIHD90KG?=
 =?us-ascii?Q?zgF0mEgp2PVBAB1PL4mnue/T5PwH/1+nOJwSElEr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e6b237-d6db-460e-c289-08dd1426e892
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 05:45:50.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdmoXj69WfNKS+a00dQ+bHBMq9YVm4J+p+WspB5P/hw4r12swiwvVScHc75p3cZtvtzVubt6GFoodGXLzMxjWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

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
index 63d78b2b8670..3768752b6008 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -145,11 +145,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
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


