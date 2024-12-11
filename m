Return-Path: <netdev+bounces-150999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9CB9EC50A
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88704167A34
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02711C5F07;
	Wed, 11 Dec 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IAr+pAL4"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEE1C5CC1;
	Wed, 11 Dec 2024 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733900044; cv=fail; b=jkhmBCQN5HVvg52zn8KdA38PnGP8SbfRUZaP5TSUrmPaQz9Y/KG3H9+mTDMR+E6Z3Kiu8m8uei2HZnNpvf0zLfmQxHUTFDNKAPqbRdV/P31FcR+x0qL5+SARnyuQ+gVMsFgz87s2KB7I9GnWB0jowc26XWloHhYyqmwCYgq3jRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733900044; c=relaxed/simple;
	bh=dkhfDE5iSSkIV0IA4c4iGuEcaNDr4BCT2piR3DTkCjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R6/mQdf91J8Rmu8IdFzx+FcSiCu0t8DMzW03mKhBux2TRox/2TJ3nNNPaRDpXmIPT42iVNrbyD6DImOZHHX2BaPmvSFuU7cJ2PNowG3hrqDjW55+A5z0d50vsY2mZberXMjtANMdBkqqwHHnwnt92ctd1CvM6mDQ9i6yf6vSjOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IAr+pAL4; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJVUMlrFk86KXruTjHiofaH8aFe1jXLIxrIX7BqTfLd5RuwjdzrqEfZpHYTBeSIbKlMEyDjiclEly7xz5NPAzmTNBJ1PMcJwXOCQsYOrD4ltGCd2TmhJstWZ/pg5XOtsgH+1gKQdpaD/SyMkKNeNrnQP+u6FOKQEh17wbPW2Kd1HM/XcKrwSKm1B5cAinH0sNX/IQqsFq3pFD/BiyzS6541lFmKp0d5B0KvJcnwu0b7Pr+Mn2IxQcD5X2RP91BH88TwjrifQuqyQ4P2hx+0QM07LxBYGvPuaqnImmeAaPZKz0o7bK83z6b5T86rw6oeaqlnrZrK+07VIPYu0hoQoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xCmXcKUQnvouBgl1ejloT8UEhsXfQCXxk3HZJP/LKc=;
 b=MOyMDEeMzXT4GyihMmG6MVJ7ZVn10/bFP/SP8/5qEq9nV93mJGzDbuMs9z0t3UBHNb6+EGCiaTUqa0HPEmZ25cyz+zWScEveG7/xIu8tVpedzitS1pqSX7gwWQ2aW2l9SbAWeZ2A++SuNJzZcbNmn4KT/jcNCBiRDBJSBr99RYpHdfKPRR+ZgRgRgrw8zjXn1JkCIzOYk8doluI+Q2X95RP7LXhrTYcQVUBHx6qEzACtWsTr2yJydXitPJ1uzLUAN6TiWGi8Gvbu2bRLqVt2S75RrxNyiJWVgcFZ9n0lTrBVVj1dlbH0OfSCpOHJw3okIWe2Gde3iQBVWdj1LTaWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xCmXcKUQnvouBgl1ejloT8UEhsXfQCXxk3HZJP/LKc=;
 b=IAr+pAL4U063mIKwvzhBnwaG1nTGcB/SkZHWlmzsBSIQiThaAykkFvCfGq3DlQ0JDhdtlo8YzhneeTIL2KuUcSdpES3jZ0+icH25qN6WCbzRyvnS/7TETP8nF0piDtYv8Oo06fsQvnsf6ibhaHKegxdEqtG2bF+xqHynY1YNQBmUOJScW0hyC/OJ1oPnNJxvA6QQH20j2JR5tfZQoEoSeMvnenduIALu6BGT1r+6agwLyAshC3i4/v2AcT7OqquleX87SICwh2Eq3Uln5HPWmr28LGPEpjYk5n/yZgM4XQVfchDBE1YTzrgM8WWhpw0qZCsgnIid63UMEAGHoT3BSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB11042.eurprd04.prod.outlook.com (2603:10a6:150:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 06:53:59 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 06:53:59 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com,
	horms@kernel.org,
	idosch@idosch.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 1/4] net: enetc: add Tx checksum offload for i.MX95 ENETC
Date: Wed, 11 Dec 2024 14:37:49 +0800
Message-Id: <20241211063752.744975-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211063752.744975-1-wei.fang@nxp.com>
References: <20241211063752.744975-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0237.apcprd06.prod.outlook.com
 (2603:1096:4:ac::21) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB11042:EE_
X-MS-Office365-Filtering-Correlation-Id: 896eebdf-94ff-47bc-a7bb-08dd19b096bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nT/29cJLRdvXfBeSo9oyS41998Xo34yCtpfsAA+tBTKrYEd2Lp+EJ5Vl8222?=
 =?us-ascii?Q?KLb19hRfPoSRsINLUTSpNjv2teMGIahWXjaT8HVq9kgBjrqqtetCvG9iDBVj?=
 =?us-ascii?Q?juHru5Gf8EFKSqbEYJShWzgEDUWg4YWptsIUz4ZoMFolsxFh6SIHG3dqRTJ5?=
 =?us-ascii?Q?f+GVfm6ZSiEP7Gc0Wir1WHjIpwHPtCXSH53cH/00nGDC9t52U/t2lrn6rXbQ?=
 =?us-ascii?Q?ZsutcFoJEanfYKXJLuvOZwYKuqS99XN4RQRn5PqaHQaylt48rDfHjldZhSak?=
 =?us-ascii?Q?zhCP/9nMTDaVpqYvkQyUIu5SYiy1VIkFws8VJxl4zLMjT+TxYAxax+KTWmRB?=
 =?us-ascii?Q?ixRzJE0OJPqTYs1YMGpmlUTLIhhqCWyIRc4rnErP4iZF+dUKYWM+Gks43wfX?=
 =?us-ascii?Q?DwhsGCakWjX/a773i5rCm2ZW72zeRtRXZrTg7JdaAfCz0+HJTdRDEsg70Xsx?=
 =?us-ascii?Q?+/1zWVvFU0QlPtIPpbvbkIuY8dGopijYTCSSvdCThfl6+zwwDM+YSCS0NRsg?=
 =?us-ascii?Q?If4sE9acPUabM+K3IW9n25p9x7WGrb+bq3CmTEIetbhuMSIKujg5lPZdryoK?=
 =?us-ascii?Q?M3my21U9p8rtsjFwFsC2lFuKjkdvveqpw55OlRZWLDJmpnk/V5xjOXKjx4IU?=
 =?us-ascii?Q?d34+QVyCUA6g4Wr6aIZ3XyP27aw8hA96PiX27NT8ZzXUU+2XVZC/iG2vl4Tg?=
 =?us-ascii?Q?JFLzrDt1sqtyP8OfKSy2vWP92ns3wH1QlEmrznZSAx936yHG31q7osBjThIB?=
 =?us-ascii?Q?W/3ZN/TosriOvp7M94WkMshljMvN6XdOh4k6xT4MW68tfSuaebP0ePbLXgGQ?=
 =?us-ascii?Q?7d4+R3tHhm3LPVLJoT9X8bUpdGQ3NuDs2KaYi8gb+nlTVLm/fpxOkAke1zon?=
 =?us-ascii?Q?s+n3jSlsOtPwnFDlogQKdNgPHR/nBRKnF1uSE0ePnOPLHKkJ8/SkKieM5z2b?=
 =?us-ascii?Q?57nKah2r98+bq2Q+tIk1X01ZHZoJVfgLUVEuf1DouwAtp2cBZU7ayCfJ+ds7?=
 =?us-ascii?Q?sdOxgr5C7Z4Ufh67bdyHMCBcDqEqfkKV5IiyxC71/gXpw66ZjGLrYpXYgeLa?=
 =?us-ascii?Q?O0rL50aL1fp3ukqO9cvK4WhrXf9dpkuYoZbcmeFx1/aCOlTFBlqGYQnIk7Q5?=
 =?us-ascii?Q?kPcz3XAFZGEbIrjBEj/YnZHU8NmOeVetd59GaSFD70/Rwv3mujnc7uk2l6mJ?=
 =?us-ascii?Q?NF4V3iqjVuYmb3F77ZnlK/oXTD8tRIoGame3Sf30gtESYQAIq4jMdqUWI+0H?=
 =?us-ascii?Q?8kgvvslVog25yfRzE1Emb4z2cYSDkA7uLNm50wB4oiOuhWQB/NPRcihx3viJ?=
 =?us-ascii?Q?08QD1WAFzWtrPX6+6RRIKoY17HFMPD/bGPXYVQ44y5Mu9lkQv0XjsmmQU4GB?=
 =?us-ascii?Q?qcKY7NiNn3kxPbydSaxL9O9xBgvvd9eApaJWkb2abvju9a79IxbEXuyabSP6?=
 =?us-ascii?Q?GtlQxOa8bGY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zWdBdUNXvAaP0uY18EpNPjw7D96+YYKQ8mexypPVqOhByjGta/0yb1fvN5uD?=
 =?us-ascii?Q?K5WVV+0JgZs+0ThmcSGFcQWLeYJDrmBSXJtQtt3IU3aEAA6ZvFdWGveVnhYo?=
 =?us-ascii?Q?TAt783S1TYzMDVPlsPqh5A1TxbAprgsh9B2gDew5FSwzYepie0OhPxYT6AgG?=
 =?us-ascii?Q?P1RKVwKa/r2Eoc9BZ1GKdHemG9JXzlUllBvg4ZOHqGDDCQFkNZryItJQFvPy?=
 =?us-ascii?Q?/Qoiz2WfUSk7FMzmXgv2cedHZ/tlyCe0Vor7a2sm4J7ZbQe/aJsN7dtOOeaf?=
 =?us-ascii?Q?Grekq2JpW+hnqUxAWkbk1XEntPmxkZzO08Qt+0mXGCVdyY4S84ZUG3HU4Oi9?=
 =?us-ascii?Q?HZ7gb4YX+CQGi/5F9vbwHJwp2o/iUJAdS4NdH4T7HPhNJ2V7EMom8Vy4VOJM?=
 =?us-ascii?Q?O6ob/1jO0wWx0PnwCxLQy8l+vqhfv7qklIW39uQXzyz79Oyb1mffcAqgUjX7?=
 =?us-ascii?Q?QX6Hz4raPNze018FUpRdNr5T/ZBWCyyAfE3QdgI5pIih7v8GktAGw6uPfURa?=
 =?us-ascii?Q?CpwnO3SZWIYLrcbg4iCnHRan2U4OMK+jpYQCQvrn6801zrAPlo5JS3H8+zg2?=
 =?us-ascii?Q?s3EkxXZC2oDIvayYkkeDq0Ul9Pi0mIWcT9KTpOrWjVbhFjFAbN48Jej8pKL/?=
 =?us-ascii?Q?nwgTvsdD8MpqPqR8fUIUJaTFtxoPQtlPlq23UQdGdCxgmkHFJxerCgPSu0Po?=
 =?us-ascii?Q?QL+W0DPUlG2zDC0mcchCRQNJ7cppy+AFzAPY/IGmcJAjQzk1T+HNDOLpYoHc?=
 =?us-ascii?Q?zsLMPxnJXLByedUWncwiNIg/RQfUdxeMSMa/D4QrIUa962/TyaYb1D8qwDhO?=
 =?us-ascii?Q?vBEuNkINx6yqyDb75FjgkQY0teDd7va00na7TFcvrTUhNlaA34LLMT734Ywl?=
 =?us-ascii?Q?3JupbzH1TjtYeSbFJYiePW9S2BDwJPFkPcZMo0rR1zLNCJdyeMT2OuI0ey9B?=
 =?us-ascii?Q?mM3kjzKTc0AksAVwWS5zt+NqOIarebIVJGmJBjheclHWacyWo7Ae3WP3xLg8?=
 =?us-ascii?Q?M6iWe92LQCIAir3rr4OFhZyhODhcXWo0KnIYK8Li3Tnmw6TOWvhkBOspHjum?=
 =?us-ascii?Q?aYtXCIqn62nzAd6/aEhE8zfH/AXZG3meMF7KDEntqCimRLhxl1GUFrPRt0MU?=
 =?us-ascii?Q?I93kigyUKDyNiiO3WH4CUJRZst3+RveCNCQLN2m+XH511dUmnFYbbBKfKY7s?=
 =?us-ascii?Q?d92u5jsaU1ZU7yGgGSnVO2V39z+CHayKoGaWp/17KsyYkGjfZSKxBxV+YIj2?=
 =?us-ascii?Q?VVWa50HbRS3VAd49n7Aqj2wrOzaxstzjRheVbUrRcl5/VLD80Vzx7hqTSlAP?=
 =?us-ascii?Q?auEnmD/ZSwPxhB1G6OI4WSOdw7f5MfvvqzW81H0N4EGeFiIL0d/aOnAHix8k?=
 =?us-ascii?Q?J3tt69oBmgbScgfEgdNUjZWeeMxTp4/gVgI/NRftiH1PQNwGr/klRtV6h1im?=
 =?us-ascii?Q?uj1An0fcLPgewXSnxHVJInL4H1Db4su4BEeGLsXah7pwp61fwQi8xobJBP7Q?=
 =?us-ascii?Q?gDaw7Qykso17SP389kTxC0ICUMPCTowig+ixJfKnpC1x6g5IIdsACAmOCkOV?=
 =?us-ascii?Q?9FIWsrNLg7Ui1D6D6btXN3vtrrTLjOI5TYSfM30P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896eebdf-94ff-47bc-a7bb-08dd19b096bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 06:53:59.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/cNtOvKk72Cf0dYGkPrDH+F2i95ojn8WbsRWIG2X/i8kqZOJIeoyA29PN8HvETozUOplkmZhpURPDmjFGLIWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11042

In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
Tx checksum offload. The transmit checksum offload is implemented through
the Tx BD. To support Tx checksum offload, software needs to fill some
auxiliary information in Tx BD, such as IP version, IP header offset and
size, whether L4 is UDP or TCP, etc.

Same as Rx checksum offload, Tx checksum offload capability isn't defined
in register, so tx_csum bit is added to struct enetc_drvdata to indicate
whether the device supports Tx checksum offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: refine enetc_tx_csum_offload_check().
v3:
1. refine enetc_tx_csum_offload_check() and enetc_skb_is_tcp() through
skb->csum_offset instead of touching skb->data.
2. add enetc_skb_is_ipv6() helper function
v4: no changes
v5:
1. remove 'inline' from enetc_skb_is_ipv6() and enetc_skb_is_tcp().
2. temp_bd.ipcs is no need to be set due to Linux always aclculates
the IPv4 checksum, so remove it.
3. simplify the setting of temp_bd.l3t.
4. remove the error log from the datapath
v6: no changes
v7:
1. Change the layout of enetc_tx_bd to fix the issue on big-endian
hosts.
2. Rebase the patch due to remove the Rx checksum offload patch from
v6.
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 54 ++++++++++++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 15 ++++--
 .../freescale/enetc/enetc_pf_common.c         |  3 ++
 4 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 35634c516e26..c278915cd021 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -143,6 +143,27 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
 	return 0;
 }
 
+static bool enetc_tx_csum_offload_check(struct sk_buff *skb)
+{
+	switch (skb->csum_offset) {
+	case offsetof(struct tcphdr, check):
+	case offsetof(struct udphdr, check):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool enetc_skb_is_ipv6(struct sk_buff *skb)
+{
+	return vlan_get_protocol(skb) == htons(ETH_P_IPV6);
+}
+
+static bool enetc_skb_is_tcp(struct sk_buff *skb)
+{
+	return skb->csum_offset == offsetof(struct tcphdr, check);
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
@@ -160,6 +181,30 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	dma_addr_t dma;
 	u8 flags = 0;
 
+	enetc_clear_tx_bd(&temp_bd);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		/* Can not support TSD and checksum offload at the same time */
+		if (priv->active_offloads & ENETC_F_TXCSUM &&
+		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
+			temp_bd.l3_aux0 = FIELD_PREP(ENETC_TX_BD_L3_START,
+						     skb_network_offset(skb));
+			temp_bd.l3_aux1 = FIELD_PREP(ENETC_TX_BD_L3_HDR_LEN,
+						     skb_network_header_len(skb) / 4);
+			temp_bd.l3_aux1 |= FIELD_PREP(ENETC_TX_BD_L3T,
+						      enetc_skb_is_ipv6(skb));
+			if (enetc_skb_is_tcp(skb))
+				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
+							    ENETC_TXBD_L4T_TCP);
+			else
+				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
+							    ENETC_TXBD_L4T_UDP);
+			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+		} else {
+			if (skb_checksum_help(skb))
+				return 0;
+		}
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -170,7 +215,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	temp_bd.addr = cpu_to_le64(dma);
 	temp_bd.buf_len = cpu_to_le16(len);
-	temp_bd.lstatus = 0;
 
 	tx_swbd = &tx_ring->tx_swbd[i];
 	tx_swbd->dma = dma;
@@ -591,7 +635,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
-	int count, err;
+	int count;
 
 	/* Queue one-step Sync packet if already locked */
 	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
@@ -624,11 +668,6 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 			return NETDEV_TX_BUSY;
 		}
 
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			err = skb_checksum_help(skb);
-			if (err)
-				goto drop_packet_err;
-		}
 		enetc_lock_mdio();
 		count = enetc_map_tx_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
@@ -3280,6 +3319,7 @@ static const struct enetc_drvdata enetc_pf_data = {
 
 static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
+	.tx_csum = 1,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 72fa03dbc2dd..e82eb9a9137c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -234,6 +234,7 @@ enum enetc_errata {
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
+	u8 tx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -341,6 +342,7 @@ enum enetc_active_offloads {
 	ENETC_F_QBV			= BIT(9),
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
+	ENETC_F_TXCSUM			= BIT(12),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 7c3285584f8a..09ee86d09170 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -558,7 +558,16 @@ union enetc_tx_bd {
 		__le16 frm_len;
 		union {
 			struct {
-				u8 reserved[3];
+				u8 l3_aux0;
+#define ENETC_TX_BD_L3_START	GENMASK(6, 0)
+#define ENETC_TX_BD_IPCS	BIT(7)
+				u8 l3_aux1;
+#define ENETC_TX_BD_L3_HDR_LEN	GENMASK(6, 0)
+#define ENETC_TX_BD_L3T		BIT(7)
+				u8 l4_aux;
+#define ENETC_TX_BD_L4T		GENMASK(7, 5)
+#define ENETC_TXBD_L4T_UDP	1
+#define ENETC_TXBD_L4T_TCP	2
 				u8 flags;
 			}; /* default layout */
 			__le32 txstart;
@@ -582,10 +591,10 @@ union enetc_tx_bd {
 };
 
 enum enetc_txbd_flags {
-	ENETC_TXBD_FLAGS_RES0 = BIT(0), /* reserved */
+	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
 	ENETC_TXBD_FLAGS_W = BIT(2),
-	ENETC_TXBD_FLAGS_RES3 = BIT(3), /* reserved */
+	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
 	ENETC_TXBD_FLAGS_EX = BIT(6),
 	ENETC_TXBD_FLAGS_F = BIT(7)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 0eecfc833164..09f2d7ec44eb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -119,6 +119,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	ndev->priv_flags |= IFF_UNICAST_FLT;
 
+	if (si->drvdata->tx_csum)
+		priv->active_offloads |= ENETC_F_TXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


