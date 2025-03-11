Return-Path: <netdev+bounces-173756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B99A5B8F1
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 07:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BDE1895F83
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 06:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E587522F155;
	Tue, 11 Mar 2025 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dkczwoca"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23380221D93;
	Tue, 11 Mar 2025 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741672630; cv=fail; b=Y+t+h7PNdfpNqnb5XrUmuT7UX5e16v1H9klLolNEOAge3yl5L9KUNrD9dyofWnXbOVXFE9o3TYiw0YmzzQMXGuDlGaon4pQ4ab11Zj5ZLGsUcGQIn5fVXsrazcIzupcojOz0/VCDwqj63Uf+eUCi5x7GLsrZRC9fE7aq0+N8NgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741672630; c=relaxed/simple;
	bh=FCIGavlohMJh9Ceuk/ftt3fUJY/22NS00scPpiuIGP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EWIVLWcfNyWIarnsofKl9JV1K4J0/YdWz6ElaLU92FJRyiQXJbEaH0EZ/hGuzCuXpvbpU2BGPy1HgSsWyxstYBD32Vt76WPk19xyulsJU3MIzG21jgNOsyhka1FJRjNodoYUQFDm0ft7ocUgDo9Rayw6R7RtarsM7Nmo+LB5DoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dkczwoca; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sX4/opGMD35u9h9TwoOVxsoiqEYGcTsmnvXCgCHhSvewlf6zqKEVzyc/hdm8eLECCmVcZQUJGW1zt3Ohm0yXGHsHXr2UI4eZ+LDO4iORc7iUGsLNb0GWgcFXlBRWXTv8VuEe9LTS1mxg1bOGf/aIMtssWobTU2UvUAUSpNeiFPNJNa5Elj8VLiGZDJdQjNGieMHvR7MHiMxjTOgfdf67WuNUrb/SHOmRC3mnW/nWOZLiW/ALRf4Q9GXkgQtFIAIeGMK7odE/6MaijA7DgxDFiqtWtQMVPDNcgK7qMtXMugdB1kCSdoNs/c+eU7KSFo0UO3uGJL1SUliImHr/aROCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVom9LDIhX23btcpGNSVRM13wz0Urd0TO/BlD5e6M1c=;
 b=SdHuje4ZT0LNfYhfYBaI9y7tjULoDytgkekxN+MegE4sJVnRSozmbjEX1yZjYqTgPuNpiiTEb/hH76q4gL+XpQOjIv43v4WrU5xkPJocoUbpCC0DK8VlOX/+ytXcnmtke9k2J/2O5+byyLPT9uyLy+MrHOkFAsnu484AmKtCFICkgcg2h7hGVlOhUIig5EBe8zajDl8tFObNsS4BCFSuj0538G3EVbOI3EOoWhsMr2rKVZPrPtC5gIkKBVD1PzRXogere01y2H9xedQV0Ne9OtIfGqYtOPAowddArVLVf15k74SXjvkBfFrg0N4xwXQ7GIHAoGS/aiXp9qQQCMNRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVom9LDIhX23btcpGNSVRM13wz0Urd0TO/BlD5e6M1c=;
 b=DkczwocaVZVy+3okRZ1L32lKqGsqYWMs66FUSTpcr3+lsuhPQvD+21F5psAWTLLzkDTlLu5H3X2FyrwViE/SaWgdJq+0WaU0G9euykDycrwszX3wjuVfi0MiEpayILkx7PQ1Ly+QBKJxJWjbUdw99Tjg+NFDiW1E+yDj3ZcJG9yXE2dr+wqG57q0i0lZ+CAzPiPakGO5JfTERuGS0pyXyAwUACPBIyd1XMYtJ10kWK7PWARv/eHwU3s0np0+GNaLmyo54dwkDCzNXLScqs+ny5R+mwsK6Pfwbw2SxTgOa5vfKw8X3ezakFZAiwMt8jLgD7tky9rk071cP/Uk39utKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10945.eurprd04.prod.outlook.com (2603:10a6:150:21e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 05:57:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 05:57:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 14/14] MAINTAINERS: add new file ntmp.h to ENETC driver
Date: Tue, 11 Mar 2025 13:38:30 +0800
Message-Id: <20250311053830.1516523-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311053830.1516523-1-wei.fang@nxp.com>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB10945:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f50082b-bd1e-4fc7-d134-08dd60618db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wIXdpyz+LM24KQGFX9kks6/0ehdpN0OJ6deDSgQZUaqnsqjVjzqf4ce/DWRF?=
 =?us-ascii?Q?/cZOfCm9k0sK8VMm9O23i0SrjQxxUN6lHXhVjxfOrEunn6FUI1nasGw/7a/8?=
 =?us-ascii?Q?wkP9n4ufyUUZUxpUwf/nyE+v7QLpMdI/GI4gVV4ZWeCBJf0GOLyqvBs3aO51?=
 =?us-ascii?Q?LXinHiFZfwj2baMAgsKopLfP7rm9gGiDkUjL54eQ6EHphyCUcGi2XPqJUWZQ?=
 =?us-ascii?Q?MvpIktTO8lK0IRQyFBXq6SpFvLYznthBK3Zh7Ghr75ra71PKivwQtUJrlR4E?=
 =?us-ascii?Q?nUzkz/DtmtZ7qAZPoviFaC8mvE3vuUhNHN3wPt5JPGyCGm7BX8pkSy5dPeay?=
 =?us-ascii?Q?6hFq+HMjDlFhx7P2Ha8SyCinyqrjNO2IZ9XN4XmlEgisjSDSQqo8Y0BCtuRk?=
 =?us-ascii?Q?8YlQFEFqbI3HbQPrCwjuZRn9BeNN+9JZSAXwYPj99jAvdgPjgoB+kH+kZBRm?=
 =?us-ascii?Q?A9ZjUHFEbnQmj0379erI+qSjSHGvFFiEAsmwoPRXAt7Wq6XBA6XUoF7JFhLJ?=
 =?us-ascii?Q?8OOkBNwbtpQPTIFElnnszTHfDBXIqImUMizcBGLFCIX15dpZWk29FVmpWe+4?=
 =?us-ascii?Q?50VMgns3JqOQywJPTYIY2NX5/oK8x3aKLMgOvbUyBih73+8cFXxfBHbGyTC9?=
 =?us-ascii?Q?ZMT0wmPuecZ70advr0n9/BkWShM4NMoy5lTxZ9cIMBy5p3s0EiLemdv1OVgq?=
 =?us-ascii?Q?OEMp1hRXcKw+lSkWr4RpuzB+8Q/wrIWkRNjUIPHZTyMqvZb6GadsUbHmEEEm?=
 =?us-ascii?Q?1SVov7VwBmti9+/DIDep2V6wuzS3THF8U6iP6Op9jD5xG6ZuVHgqI4H+eWij?=
 =?us-ascii?Q?3z2C7wfkV8/svUSI5zMmKczmPVYgsRWxMHxVao17KbOOZvB0qLzH6BU4+EcK?=
 =?us-ascii?Q?uK+CDVwKWPq23oxGcIn+gV2Eb7BRe4uPdXknUrSUNrS8yO5m7JO7Fij8YrZR?=
 =?us-ascii?Q?4MaIyHYYChIznJQYbMZ9/MxEXgF381zXiY7LUTmIdbosJNxHEt45+Fcka4Ov?=
 =?us-ascii?Q?JrS82iJVwF/tQK5ef/xhBaBUZNVpzPIqTCsF9eraGtxHAbI6B0QdntAeQ44M?=
 =?us-ascii?Q?vXDJk0mttMD0MHqPygT1lhuWJ6rYuysyGG/vF161hMzdhfaxAySkPykloIll?=
 =?us-ascii?Q?cx4KL22SxWrlsvnqMA0WkTlyx4+LccIIEJn0oNFdpDS1KIEuMYD6bY7KfBpw?=
 =?us-ascii?Q?t2beWpbgTn8+Ql0TVWfFzY3Z5oVIjGcAYfeHOtztUZ5M7G+v7Ex4hrIVnIKI?=
 =?us-ascii?Q?L60xmSXhdqd1tXYRr/5xE7LVyY/ulmOK14iNsAbhRJakCPzgzVx9dqilF91P?=
 =?us-ascii?Q?MLi1TFI0ZQw6Lgyvpp4ER7EY4dfAs3ZIvlnByiCJYgj08oFUJyx3gX1PcOPy?=
 =?us-ascii?Q?VbPYcVQARrb1Q5YWZNt+UQKgXp0kbW2kr3bqmsgj33E10T+tmD+sQ95yxPd2?=
 =?us-ascii?Q?R1cGjuvbTX3pc3lwnh/9gf5jtq6ZQET5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uVjfK9YudxEGsSw4Aw09mBU6jr+P0wEaCtNxnKU/Cqn9eFbKhuv0MJdCB6Ra?=
 =?us-ascii?Q?RpRNZPJlPAU+GsuUyR4idmmOfui1GtALJMSt48X3PCiP3B1iU3ZzwvEWlIKH?=
 =?us-ascii?Q?/NA4SuP5ytZxf4Nt8GwARKqbfmjaN9fvd8TW8M8zjiAyLy+alkpsHzv34RpQ?=
 =?us-ascii?Q?1JQ1ChpRyec+9Ae2mJCxG+Qa4HCCUU5SCc95xjlK6Z/2pZZsZ1uqKl1C1xGy?=
 =?us-ascii?Q?oFkeuzCaBoooHGVkpnve0n96+kuyuPE3A4F2MaKb2Jng61ydzCU8GOapKBqA?=
 =?us-ascii?Q?IdUwfNiFMa+OgU9N5tAaFlU8TQOwxwwCYT6ca4zBl8qewUUcMSSeQpM3r1pg?=
 =?us-ascii?Q?dnAruKJdRijAGoU46IMsyfAzH1Dv30CyOqmMGyJTpf2bIXcAyqptrmUQpUVy?=
 =?us-ascii?Q?S6g2DS8tJBfk9fKeVn+VWHYwTS5exgJCCPt/mEwEMARlrJ8agOb8Pt1IHLRj?=
 =?us-ascii?Q?cLi+EeBlTmfQL91prXwpjEQejcgG3KJmFU8fsPG6s4LQAylti5FoiD/jhppT?=
 =?us-ascii?Q?SXVPszeZBGfCs8W0F30iwN31e46ZDpbR1I92oI/594GJYeA//TRMVFIpWFWa?=
 =?us-ascii?Q?zISmRorYXTCYAPCVVNBqoq6eZvXLuNk6+ifmuhMhi/aVMV3vTEOUjVsottXx?=
 =?us-ascii?Q?7yA+aqB8HEjQZ3uu1pkDuy4/HSd99lXxCsGdq6rKe2X2CcRHa9tVPJF47UuY?=
 =?us-ascii?Q?58dgXyuWPxLgMBjXVRWDOORM3YnaKbCTOT5+zKl8Q5pl2NsKPBGFVopGckgj?=
 =?us-ascii?Q?w6gvAPkk5lFCnGvIt7uAe4FxXIIV94A2m/2vGfPi9LxIYUqNtQPnlXAwlzOQ?=
 =?us-ascii?Q?5fHjln6l1UvoZsfPYBAzK7ccWEHmv8oQ3KIG28pUjcYBzVEFNd8rU+578/zV?=
 =?us-ascii?Q?oPAYqa/ugBCYtTfzgxFM9EG83XS8Dt3lROKNayN6xVsWLD0gk9LHYOTss7lN?=
 =?us-ascii?Q?SADvpHIdHA4Oo47+MCXhFON0Yinv8h4rghEmBpDcWr0dwByljnZLWU1u5O8u?=
 =?us-ascii?Q?rLY1GNNflDoX29Xv20ZT4QlJccVtD5Om3kwlbOTD3syXVER5GdW1FI9mst3H?=
 =?us-ascii?Q?mb1G2eEb6CUOujCQbzGf3UmG40kqKhUtnhmW2BF1hU/ewJoEsdIls/vS1OD0?=
 =?us-ascii?Q?8UHz5YR2cpt+CcD8Klo2WZtpvcjzaB0TkfSfANK8mllm55GbOWR8kaJl4sa7?=
 =?us-ascii?Q?y1UqAsInip8eEaluITTL08+siOtsERwU0COooqS6gdn2FhhKqC712E7AizT3?=
 =?us-ascii?Q?TVKY3r2MyB+N6aOZFUKZCIz+4hrIHNAzU8opElS2NbSYW7cfkDOYbe+LIXmY?=
 =?us-ascii?Q?Ia3IUQ7D6TG6Mv0uahRN6Rg5A4QJk0ZY8JFu2nE04WI8nK6PRbV7e7CZXidk?=
 =?us-ascii?Q?iAUuFL+avSV9qisgFNoMtwGLBvTbiNSuRkuu2pWF2qU8Ifo4S/5yKaySkMaf?=
 =?us-ascii?Q?SQIPg0whKUKJBm1ZFMrCK0DHusy7Ay8U3CsiKtgs0RpXEkZPMvK46IkznWF7?=
 =?us-ascii?Q?MHKtXUkJSCkW8zaetKS+lEwc1zz0tQbdsuAb/eko+BI7FGDx+UBjCmTO1/79?=
 =?us-ascii?Q?k0biJNv7VIrc/9mpV8jPgwsjCXAeNRJbc2Dt+XjY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f50082b-bd1e-4fc7-d134-08dd60618db3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 05:57:06.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSXRkKmOH6F4Op8cnHyiUQoDOUGPYd1YmBFXJqDYCul7Ar5H/4+tPA6WVWKib9pYgeu38rFPkl9lApuv/Sz7Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10945

Add new file ntmp.h. to ENETC driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7078199fcebf..e259b659eadb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9174,6 +9174,7 @@ F:	Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
 F:	drivers/net/ethernet/freescale/enetc/
 F:	include/linux/fsl/enetc_mdio.h
 F:	include/linux/fsl/netc_global.h
+F:	include/linux/fsl/ntmp.h
 
 FREESCALE eTSEC ETHERNET DRIVER (GIANFAR)
 M:	Claudiu Manoil <claudiu.manoil@nxp.com>
-- 
2.34.1


