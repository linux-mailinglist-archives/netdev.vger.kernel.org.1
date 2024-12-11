Return-Path: <netdev+bounces-150998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9B39EC508
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE558284857
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E906F1C4A3B;
	Wed, 11 Dec 2024 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AygINt0S"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B31C07C4;
	Wed, 11 Dec 2024 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733900039; cv=fail; b=J86f+Qp8gJUxEREip1zWRY3+XdSwGnIelDAoBaX8xtlzPAKTFGBi8dqFDTvcP902sXky1mPMPphGTAMR/288Jp3NO/XUqW/zC3J2NxiJREckuc85zeijkbaNCrAQhjWB9yLFd7Z4m2dPEYi7Xwhlz49qeJUgrlonFiXn70Cv4B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733900039; c=relaxed/simple;
	bh=ysTrrjqJ3nZX9QVfFG0XstURZ95EmhY8RLFXzYNXfjs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YjbCIee7DGi9+xh2TRNd8MGrJONAp6EQrhIxQhr+Si+jGQdkr+NVyur5BsIi0bPSgblwBd382D3CKZjrON0nadsWOsUW0N4BmdJg8BajXU9MTjusQrS+U2eSXhG4mKxhHoT7V9uk+yAzvmnxrIV/fwzTslxJSWqZ/bNRdwgVt6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AygINt0S; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrW5Izj9r//D0QEagpWJL8Y2E5urdSghdPSXdtHLF2Ars1JEs7YcmLDnMAuWRNnUadcWZenzk/fySS/4o29ssMj3+w7pgt3LRHqGuoSheUxbfEFZQCXl/yiuCi6dGRugcXH9wfzBvbWRc2r9KdR3cLqCQYMWWDejiuC5AYv4hKpuyPQ8Gt6H5IIQ7Fs/mKer90eorSBpnDwW+upX6l4VYoX93n7balLFQvZWKaqB/ni0Q8t5MBJ+Rknv0WW7YYSYuK7T+ZZaY9hD96LtsDss3ZtlX2uPJ+ZQcDWzG6rN3n9CWR3fk+KepsKRDPYLXCIYT4cUK3jUXN3EW9WglZQ9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si+rH1Yoq/1Q7MjNKh6+RxS2o+iE/LWoFD+mVs68VNo=;
 b=gQlMOAj4EwUIjezmvx6wyKiBqHVXepPk+U4LZrDGCIC5d9Ml6i0XA3gTbFbT38e2q771vCvcCoZJ10lzLkLmaf9kD5OyPqb3PPsjw7gnGAyMJXezeZfvdif3BRzpQnVItil0Tgy92zo3n4CoCyEpbzEuTWDY6CahpC/lYBFQGadD0ti/EAr9svZJCV/L0GpOlbg3ftNYtHWS8QoJVEa5qcJne1/81oFmp0VUxh5d/AXgbg3AtrdSO2nLsg66rln/+sN3qnCinCWu8YjTcL0kkruIJ9cfrXCv/saTlH8qRQ87jz5YNSTrTLThHp4mXpYu+tSULFXFNDKaqdrKZGG6LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si+rH1Yoq/1Q7MjNKh6+RxS2o+iE/LWoFD+mVs68VNo=;
 b=AygINt0STvyaF9jYBzgZ6zPGtc6pKpHMAmNfHX6JEjZwCE+kteqrZ9rPKu9JEp02rwm3mhpGGxFKFsZBBxA1rzskul7F/Qzbhg9FgQwQqLmqy9gShaWoa2eWNgZd2yFnYDuhXlb46A3yp/E7uLMmcGWd5aB/s6/uPHHKUuDDDbqCVO0P0+Etur+8NjBgd8Go2FShrkhZpvWiXcIyO6OiL5pnM15ASjQ+pQn7GeYjJDSKhtyJRcZlD8/Mi2YgCmtKrpM4Juui4k0XTlS8HKuoxp80qG25tzzxK6Cqf0oEBvXZivubEP6ZvUiiWTejX0UBkBB3L0fHOycCXIblhy0liQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB11042.eurprd04.prod.outlook.com (2603:10a6:150:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 06:53:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 06:53:54 +0000
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
Subject: [PATCH v7 net-next 0/4] Add more feautues for ENETC v4 - round 1
Date: Wed, 11 Dec 2024 14:37:48 +0800
Message-Id: <20241211063752.744975-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: c68f092a-8dbb-4cda-dd6b-08dd19b0938d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OwB9mBl58DhKDml0Fa4YFhayf4qMOXinqmpQt3JmCguPXO8B1gq24bw6wA7S?=
 =?us-ascii?Q?NyukAZJzvbt8eg9z8jJAmiTRTReQlKKTlUx1K1x1DZZ7uiixKeQsoZhjEvEG?=
 =?us-ascii?Q?k+E/li0yPyHqiwXwlR5e2wVYANqNj5kroQCaKuU2tM5tInWVUg4yFkC+5ncK?=
 =?us-ascii?Q?knmHU+Yxa/D6ns7muPtW0qzq+gIHtEbOhdygpA3PR+3FrmNJ+CHlVNon7Zo9?=
 =?us-ascii?Q?Va9qQBlsp5FHAOIiIHLQ928n9+dk8TlzvtrBRsJkBfNHLp/6hIEMvp1WUoe+?=
 =?us-ascii?Q?298kQRa4+LwBWFdYRw5qwZ0E4edESCy5JacSnqechOYqXtzxH7YnGc6FZrhn?=
 =?us-ascii?Q?szGIIuDATGf0/M2bRkemJoNilOkYqnQcuTP9rqdbjdzVUwus+tkaB4qXdLQl?=
 =?us-ascii?Q?/gQ+CCnxXUtDQTcatarDxIn8mFcrvLokBYkQaDhZven5TWxdt8bAMIdz84bK?=
 =?us-ascii?Q?P5LYEs5+C4Vn6mEQqbjJNXB/1I3RYun5X+BdGDG3MDsr43HVoOr5jmsgjV8p?=
 =?us-ascii?Q?4K5rnFC2IlW2/mogENC9CauooCgVzsj534RiO5eDcN+h1YvXp6riBajGaA52?=
 =?us-ascii?Q?GiPMenLtBPVeMMkwS9T/LsGYSEPXwTsYrimCSo5drhFOHsi5PhfBCfUSqLDr?=
 =?us-ascii?Q?/0dkRzWyvM8gm4g/yFOf2H+vD9kdM/4wAJhUBCi0DkvHRYYTVGydTLLSxSUM?=
 =?us-ascii?Q?wB4KKmz3pOxluBvDPbs4/JDwFy9tO4PsPAzJUE066mupmpyv8VttSDivd1GX?=
 =?us-ascii?Q?k1FPC0JkwtR/Zbgnj8dP0s9wQ1cSd7gAh8kMBfAxoOE/1XZfYMMFhIzKqBoU?=
 =?us-ascii?Q?Q0v3GQle2uuJkloBwVkK9aIJHbyigFpII++OEgmBUoa9HgXw/oDGz8B8ps79?=
 =?us-ascii?Q?0vRNu41+PaClb7SvGoH+k3BoFAlmki5FUG4P7nAY/LMDseIkb5mmH7o4UokO?=
 =?us-ascii?Q?4+/tjfMHQteCUkm4BWvoWXg+vBV+Ocn6bx9/LGzJIcyPv+TcJLUFLexjK9FN?=
 =?us-ascii?Q?xkV/kXysxDUAnRO2pwYCE9Nk4N5Tmy+uosX1mVs+r3zeLiDxDgzZSRLiR8nk?=
 =?us-ascii?Q?mPbXZVCPhYLBmLiLGcnycYQs1PzeiPJn7iAeukqGWLmjnkPqWYLwKCOkbXkO?=
 =?us-ascii?Q?QsQTugskqTwoEHi6ALsHFQNiPlW1zUK3gB42oTb3H9QbmfpvD4RVAzb4VCtk?=
 =?us-ascii?Q?jhG1G6Z0fCyIDu3xKVbYJWo23MqNdmiPgE7uqNPQu+Wogf9OjJkUaBf2DSf2?=
 =?us-ascii?Q?A95TnucfEnZkKqdsTaSnHO6QwhQmwdfD4/hNaj6Y6oK8rInxpLH3er53E791?=
 =?us-ascii?Q?kJpSmYaifCLzRhJ5gaLLDiY5npT2KdV0RaOQoF9B0XKgWagat2WdhRjKuwcJ?=
 =?us-ascii?Q?ez6QgGSsFt4j6KxbmbbE9PPSBfnO72kCc0WcE7tNj4fgmRQ261tqj7xBuL7U?=
 =?us-ascii?Q?rDe60jRwlEw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bR9qUMAxG0R4ZNHJ+h30LWkaBeRKzpcFr7iOLKsWSRMhfXlD/Vbw74s9FWQp?=
 =?us-ascii?Q?V4MW8q5Sg3lbCcVga0tINbJAE+XpxNhPY63LlyVBtEzaxZGtoEs9by0wgaP9?=
 =?us-ascii?Q?st5yfBVuUCtY1OWvimb3tUDj8DW9t41/Hr2PyYgJcbfyLK4PHmu+YNObbb9S?=
 =?us-ascii?Q?J3PaESng1HYS+Y7UgYIEqqA8adqJKOoiMmNq2w1/d+KQsQLwIGYIaCtbjCmd?=
 =?us-ascii?Q?73hlN3voUxtA10kL3fwOWU4Emgk/uRh5FCoavxs7pAgwGm5Cthn3sLQQeuUv?=
 =?us-ascii?Q?opyHAGt+ON0XyXHBQU3cu5ZLJUGZXlOQmtkkckuG8Rr+dgfgktfIjP2c7afk?=
 =?us-ascii?Q?yw11jkI22L0oz+OM5PjyQEWPd52zIJc/74A6jLO12GvkmcI8rzJaIUvO6xps?=
 =?us-ascii?Q?vZRWQ1UN9qNtY8Bm8o3qKEbyEvEfAwHzvm3dzfVEbSw/bfFJZXCSOBAi7z6C?=
 =?us-ascii?Q?5MPmgh8LshpkIZy8y/JrOkMB1TEDD1edKE+/yQWz59W27lGC1b/3rk5szi0L?=
 =?us-ascii?Q?FCo1BsAdWkuPvR9KGSI754XepCmPU64Sj6GHzozEM8uhjh+QGwGq+1vVqVpU?=
 =?us-ascii?Q?mzXxN1aRGgN83j9opvniUAxxPtYGfwAuBrsMh6b/190v2SRRdd+JLm3YVhCc?=
 =?us-ascii?Q?YyQYUl2x/iemOj/3wWwHUuKKfP+HJbDvS7WZeFFat+S0iIvRRtVH5mML0DCw?=
 =?us-ascii?Q?os6oMrMwiItMgab+66gBVYe6IGUn/IDEDzf2AC/fELfx44LX2Ei1fIhu2l/4?=
 =?us-ascii?Q?HccmACBpIppl4SSv65OhkzMqnhfE9l3XeGgFMgQtMVyXfic0zGH4KIpzLou8?=
 =?us-ascii?Q?+Jdd9w+6dLeZWfYHrJU60C0eo2Er/sJeO+SHXY+e9xKy5gbMjmmAgeJra5h7?=
 =?us-ascii?Q?jtoMzv08IZN+e0j1WMSSMCI0qbJmlROvmm+1pBLkjpLeRSY7qz0HM7/iBnj5?=
 =?us-ascii?Q?F49ef31iaHQmNv2i4sEcls3GkZnPbU7jjQbD0LHtFZ0+jRIMjd8qr8oySdFV?=
 =?us-ascii?Q?32UKP2m8UWP9IASUBn1Br+SljDqJpLl/AYqcLoazySSH1D4dwnYoQHvQGJrX?=
 =?us-ascii?Q?d+yblPFp3NcUdvCup0bw+Scsn8JoiyQfiTtqjZ1UeTDHFFido2o5Nat0CBTC?=
 =?us-ascii?Q?WtXMf5slUMOHNVmL57/lO7Ec7PMFN0j9Z0Zi+eHHTwXEiLIH2gPn+nAV+OQ0?=
 =?us-ascii?Q?d75plWR7cjNO2PzX2QuXEUScpWYmXijeoz2mXxRbYm+rZImtnz3/+H5JRu8D?=
 =?us-ascii?Q?n3fIkrQxwtdPLvoz/1I3d+jm6Wfb0GupRjYdnxquBGe9MmHnYraUNwQQrtFW?=
 =?us-ascii?Q?ZYOKxWox8+cdWgDCKXEX/GlYduQicMuYkql/N7Zl8lQDYlC5N4MEobxxazwF?=
 =?us-ascii?Q?BkJTi/UT2N3tHecSZwGroOmGe6dA2mbjqDJV9ZvdsOmKBflFOkYkg/gp9jnF?=
 =?us-ascii?Q?K6d30/DwqFL9JaoiwgQ1sp3FEg6alUnqYZQ9w7Fs2IFy/vrBwl2XAj3zcObS?=
 =?us-ascii?Q?sAinfF3n0vh3xfLP4vpVDUaN5D4p7RwMa2rr2/Nv6b95W0wtlj2hUXu/kjmE?=
 =?us-ascii?Q?eH/HAHW+xKUjB+DiUWYwx1nrR90dd1Ovkp+Sr39k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68f092a-8dbb-4cda-dd6b-08dd19b0938d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 06:53:53.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTDPSbrOF41azfpRAbJxK1+nxjCMgM1lIbm1oxdZBbJ4SiDMYdDcwD73g7841IVZZ+OTOGXXPMcIkU9Y1j/bsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11042

Compared to ENETC v1 (LS1028A), ENETC v4 (i.MX95) adds more features, and
some features are configured completely differently from v1. In order to
more fully support ENETC v4, these features will be added through several
rounds of patch sets. This round adds these features, such as Tx and Rx
checksum offload, increase maximum chained Tx BD number and Large send
offload (LSO).

---
v1 Link: https://lore.kernel.org/imx/20241107033817.1654163-1-wei.fang@nxp.com/
v2 Link: https://lore.kernel.org/imx/20241111015216.1804534-1-wei.fang@nxp.com/
v3 Link: https://lore.kernel.org/imx/20241112091447.1850899-1-wei.fang@nxp.com/
v4 Link: https://lore.kernel.org/imx/20241115024744.1903377-1-wei.fang@nxp.com/
v5 Link: https://lore.kernel.org/imx/20241118060630.1956134-1-wei.fang@nxp.com/
v6 Link: https://lore.kernel.org/imx/20241119082344.2022830-1-wei.fang@nxp.com/
v6 RESEND Link: https://lore.kernel.org/imx/20241204052932.112446-1-wei.fang@nxp.com/
---

Wei Fang (4):
  net: enetc: add Tx checksum offload for i.MX95 ENETC
  net: enetc: update max chained Tx BD number for i.MX95 ENETC
  net: enetc: add LSO support for i.MX95 ENETC PF
  net: enetc: add UDP segmentation offload support

 drivers/net/ethernet/freescale/enetc/enetc.c  | 324 +++++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  30 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  30 +-
 .../freescale/enetc/enetc_pf_common.c         |  13 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   7 +-
 6 files changed, 396 insertions(+), 30 deletions(-)

-- 
2.34.1


